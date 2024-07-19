package com.example.BilanCarbone.service;
import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.*;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.entity.Unite;
import com.example.BilanCarbone.exception.OperationNotPermittedException;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.mappeer.TypeMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Oussama
 **/
@Service
@RequiredArgsConstructor
public class TypeServiceimplement implements TypeService{
    private final TypeRepository typeRepository;
    private final TypeMapper typeMapper;
    private final FacteurRepository facteurRepository;
    private final FacteurService facteurService;
    @Override
    public PageResponse<TypeResponse> list_parent(int page , int size , String search,String... order) {
        Page<Type> respage=pagesorted(page, size, search, order);
        return getTypeResponsePageResponse(respage);
    }
    @Override
    public PageResponse<TypeResponse> list_all(int page, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size,sort);
        Page<Type> respage=null;
        if(search != null && !search.isEmpty()) {
            respage=typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNull(search,pe);
        }else{
            respage=typeRepository.findAllByIsDeletedIsNull(pe);
        }
        return getTypeResponsePageResponse(respage);
    }
    @Override
    public PageResponse<TypeResponse> list_all_detail(int page , int size , String search,String... order){
        Page<Type> respage=pagesorted(page, size, search, order);
        List<Type> child=typeRepository.findAllByParentIsNotNullAndIsDeletedIsNull();
        List<TypeResponse> list=typeMapper.hierarchiqueResponse(respage.stream().toList(),child);
        return PageResponse.<TypeResponse>builder()
           .content(list)
           .number(respage.getNumber())
           .size(respage.getSize())
           .totalElements(respage.getTotalElements())
           .totalPages(respage.getTotalPages())
           .first(respage.isFirst())
           .last(respage.isLast())
           .build();
    }

    @Override
    public TypeResponse get_type(Long id) {
        Type res=findbyid(id);
        return typeMapper.typeParentResponse2(res);
    }
    @Override
    public TypeResponse get_type_detail(Long id) {
        Type res=findbyid(id);
        List<Type> list =typeRepository.findAllByParentAndIsDeletedIsNull(res);
        if(!list.isEmpty()){
            return typeMapper.typeParentResponse(res,list);
        }
        return typeMapper.typeParentResponse(res);
    }
    @Override
    public TypeResponse get_type_all(Long id) {
        Type res=findbyid(id);
        if(res.getParent()!=null){
            res= res.getParent();
        }
        List<Type> list =typeRepository.findAllByParentAndIsDeletedIsNull(res);
        if(!list.isEmpty()){
            return typeMapper.typeParentResponse(res,list);
        }
        return typeMapper.typeParentResponse(res);
    }
    @Override
    public TypeResponse activate_type(Long id) {
        Type type=findbyid(id);
        if(type.getActive()) {
            throw new OperationNotPermittedException("Le type "+id+" a déjà été désactivé");
        }

        type.setActive(true);
        return typeMapper.typeParentResponse2(typeRepository.save(type));
    }
    @Override
    public TypeResponse toggle_type_detail(Long id, boolean activate) {
        Type type =findbyid(id);
        return typeMapper.typeParentResponse(toggleTypeAndChildren(type,activate));
    }
    @Override
    @Transactional
    public TypeResponse add_type_detail(TypeRequest request) {
        Long id=add_type(request,null).getId();
        return get_type_detail(id);
    }

    @Override
    public List<TypeResponse> list_type() {
        List<Type> list=typeRepository.findAllByActiveIsTrueAndIsDeletedIsNull();
        List<Type> child=typeRepository.findAllByParentIsNotNullAndIsDeletedIsNull();
        return typeMapper.hierarchiqueResponse(list.stream().toList(),child);
    }

    @Override
    @Transactional
    public TypeResponse update_type_detail(Long id, TypeRequest request) {
        Type type =updateType(id,request,null);
        return typeMapper.typeParentResponse(findbyid(type.getId()));
    }

    @Override
    @Transactional
    public TypeResponse delete_type_detail(Long id) {
        Type type=toggle_delete(id,true);
        return typeMapper.typeParentResponse(findbyid(type.getId()));
    }
    @Override
    public TypeResponse force_delete_type(Long id) {
        Type type = find_deleted_byid(id);  // Assuming findbyid is a method to retrieve the Type by its ID
         deleteTypeAndChildren(type);
        return typeMapper.typeParentResponse(type);
    }
    @Override
    @Transactional
    public TypeResponse recovery_delete_all(Long id) {
        Type type=toggle_delete(id,false);
        return typeMapper.typeParentResponse(findbyid(type.getId()));
    }
    @Override
    public PageResponse<TypeResponse> list_all_detail_trash(int page, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size,sort);
        Page<Type> respage=null;
        if(search!=null && !search.isEmpty()){
            respage=typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNull(search,pe);
        }else {
            respage=typeRepository.findAllByIsDeletedNotNull(pe);
        }
        return getTypeResponsePageResponse(respage);
    }
    private Type toggle_delete(Long id, Boolean deleted) {
        Type type = null;
        if (deleted) {
            type = findbyid(id);
            if (type.getIsDeleted() != null) {
                throw new OperationNotPermittedException("Le type " + type.getId() + " est supprimé");
            }
            type.setIsDeleted(LocalDateTime.now());
        } else {
            type = find_deleted_byid(id);
            if (type.getIsDeleted() == null) {
                throw new OperationNotPermittedException("Le type " + type.getId() + " n'est pas supprimé");
            }
            if (type.getParent() != null && type.getParent().getIsDeleted() != null) {
                throw new OperationNotPermittedException("Vous devez d'abord récupérer le type parent: " +
                        type.getParent().getName() + ", id: " + type.getParent().getId());
            }
            type.setIsDeleted(null);
        }
        typeRepository.save(type);
        if (type.getFacteurs() != null && !type.getFacteurs().isEmpty()) {
            for (Facteur facteur : type.getFacteurs()) {
                if (facteur.getIsDeleted() == null && deleted) {
                    facteurService.delete_facteur(facteur.getId());
                } else if (facteur.getIsDeleted() != null && !deleted) {
                    facteurService.recovery_facteur(facteur.getId());
                }
            }
        }
        List<Type> childTypes = typeRepository.findAllByParent(type);
        if (!childTypes.isEmpty()) {
            for (Type childType : childTypes) {
                toggle_delete(childType.getId(), deleted);
            }
        }

        return type;
    }
    private Type add_type(TypeRequest request,Type parent){
        Type type=typeRepository.findByNameAndIsDeletedIsNull(request.nom_type());
        if (type !=null) {
            throw new IllegalArgumentException("type avec nom " + type.getName() + " deja exists.");
        }
        int depth = getDepth(parent);
        if (depth > 1) {
            throw new IllegalArgumentException("La profondeur du type ne peut pas dépasser deux niveaux.");
        }
        type = Type.builder()
                .name(request.nom_type())
                .parent(parent)
                .active(true)
                .build();
        type = typeRepository.save(type);

        if(request.facteurs()!=null && !request.facteurs().isEmpty()){
            for(FacteurRequest i : request.facteurs()){
                Facteur facteur = Facteur.builder()
                        .nom(i.nom_facteur())
                        .unit(Unite.fromString(i.unit()))
                        .emissionFactor(i.emissionFactor())
                        .type(type)
                        .active((i.active()!=null)?i.active():true)
                        .build();
                facteurRepository.save(facteur);
            }
        }
        if (request.types() != null && !request.types().isEmpty()) {
            for (TypeRequest childRequest : request.types()) {
                add_type(childRequest, type);
            }
        }
        return type;
    }
    private Type toggleTypeAndChildren(Type type, boolean activate) {
        if(type.getActive()!=activate){
            type.setActive(activate);
            typeRepository.save(type);
        }
        if(type.getFacteurs()!=null&&!type.getFacteurs().isEmpty()){
            for (Facteur i : type.getFacteurs()) {
                if(i.getActive()!=activate){
                    i.setActive(activate);
                    facteurRepository.save(i);
                }
            }
        }
        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedIsNull(type);
        if (childTypes != null&& !childTypes.isEmpty()) {
            for (Type childType : childTypes) {
                if (childType.getActive() != activate) {
                    toggleTypeAndChildren(childType, activate);
                }
            }
        }
        return type;
    }
    private Page<Type> pagesorted(int page, int size, String search, String[] order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size,sort);
        if(!search.isEmpty()) {
            return typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNullAndIsDeletedIsNull(search,pe);
        }
        return typeRepository.findAllByParentIsNullAndIsDeletedIsNull(pe);
    }
    private PageResponse<TypeResponse> getTypeResponsePageResponse(Page<Type> respage) {
        List<TypeResponse> res=respage.stream().map(typeMapper::typeParentResponse2).toList();
        return PageResponse.<TypeResponse>builder()
                .content(res)
                .number(respage.getNumber())
                .size(respage.getSize())
                .totalElements(respage.getTotalElements())
                .totalPages(respage.getTotalPages())
                .first(respage.isFirst())
                .last(respage.isLast())
                .build();
    }
    private Type findbyid(Long id) {
        Type t= typeRepository.findByIdAndIsDeletedIsNull(id);
        if (t==null){
            throw new  EntityNotFoundException("Type not found with id: " + id);
        }
        return t;
    }
    private Type find_deleted_byid(Long id) {
        Type t= typeRepository.findByIdAndIsDeletedIsNotNull(id);
        if (t==null){
            throw new  EntityNotFoundException("Type not found with id: " + id);
        }
        return t;
    }
    private int getDepth(Type type) {
        int depth = 0;
        while (type != null) {
            type = type.getParent();
            depth++;
        }
        return depth;
    }
    private Type updateType(Long typeId, TypeRequest request, Type parent) {
        Type type = typeRepository.findByIdAndIsDeletedIsNull(typeId);
        if (type == null) {
            throw new EntityNotFoundException("Type not found with id: " + typeId);
        }
        if (request.nom_type() != null && !request.nom_type().equals(type.getName())) {
            type.setName(request.nom_type());
        }
        if (request.active() != null && !request.active().equals(type.getActive())) {
            type.setActive(request.active());
        }
        if (parent != null) {
            int depth = getDepth(parent);
            if (depth > 1) {
                throw new IllegalArgumentException("La profondeur du type ne peut pas dépasser deux niveaux.");
            }
            type.setParent(parent);
        }
        type = typeRepository.save(type);
        if (request.facteurs() != null) {
            List<Long> newFacteurIds = request.facteurs().stream()
                    .map(FacteurRequest::id)
                    .toList();
            List<Facteur> oldFacteurs = facteurRepository.findByTypeAndIdNotIn(type, newFacteurIds);
            for (Facteur facteur : oldFacteurs) {
                facteur.setIsDeleted(LocalDateTime.now());
                facteurRepository.save(facteur);
            }
            for (FacteurRequest i : request.facteurs()) {
                if (i.id() != null) {
                    facteurService.update(i.id(), i);
                } else {
                    facteurService.addFacteur(i, type);
                }
            }
        }
        if (request.types() != null) {
            List<Long> newTypeIds = request.types().stream()
                    .map(TypeRequest::id)
                    .collect(Collectors.toList());
            List<Type> oldTypes = typeRepository.findByParentAndIdNotIn(type, newTypeIds);
            for(Type oldType : oldTypes){
                typeRepository.delete(oldType);
            }
            for (TypeRequest childRequest : request.types()) {
                if (childRequest.id() != null) {
                    updateType(childRequest.id(), childRequest, type);
                } else {
                    add_type(childRequest, type);
                }
            }
        }
        return type;
    }
    private void deleteTypeAndChildren(Type type) {
        if (type.getFacteurs() != null) {
            for (Facteur facteur : type.getFacteurs()) {
                facteurService.delete_force_facteur(facteur.getId());
            }
        }
        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedNotNull(type);
        if (childTypes != null) {
            for (Type childType : childTypes) {
                deleteTypeAndChildren(childType);
            }
        }
        typeRepository.delete(type);
    }
}