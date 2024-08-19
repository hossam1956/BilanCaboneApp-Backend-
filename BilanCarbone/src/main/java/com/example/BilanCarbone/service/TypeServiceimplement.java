package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.config.Userget;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.TypeRequest;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.*;
import com.example.BilanCarbone.exception.OperationNotPermittedException;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import com.example.BilanCarbone.mapper.TypeMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;


/**
 * Implémentation des services liés aux entités Type.
 *
 * @author Oussama
 */
@Service
@RequiredArgsConstructor
public class TypeServiceimplement implements TypeService {
    private final TypeRepository typeRepository;
    private final TypeMapper typeMapper;
    private final FacteurRepository facteurRepository;
    private final FacteurService facteurService;
    private final Userget userclaim;
    private final UtilisateurRepository userRepository;

    @Override
    public PageResponse<TypeResponse> list_parent(int page, int size,boolean my, String search, String... order) {
        Page<Type> respage = pagesorted(page, size, my, search, order);
        return getTypeResponsePageResponse(respage);
    }


    @Override
    public PageResponse<TypeResponse> list_all(int page, int size, boolean my, String search, String... order) {
        List<Sort.Order> orders = this.buildSortOrders(order);
        Pageable pageable = PageRequest.of(page, size, Sort.by(orders));
        Page<Type> respage = null;
        Entreprise entreprise = my ? check_user_permission_and_get_entreprise(false) : null;
        boolean isSearchEmpty = search.isEmpty();
        String trimmedSearch = search.toLowerCase().trim();


        if(entreprise!=null){
            respage = (!isSearchEmpty)
                    ? typeRepository.findAllByNameContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(trimmedSearch,entreprise,pageable)
                    : typeRepository.findAllByEntrepriseAndIsDeletedIsNull(entreprise,pageable);
        }else {
            respage = (!isSearchEmpty)
                    ? typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(trimmedSearch,pageable)
                    : typeRepository.findAllByIsDeletedIsNullAndEntrepriseIsNull(pageable);
        }
        return getTypeResponsePageResponse(respage);
    }

    @Override
    public PageResponse<TypeResponse> list_all_detail(int page, int size, boolean my, String search, String... order) {
        Page<Type> respage = pagesorted(page, size,my, search, order);
        List<Type> child = typeRepository.findAllByParentIsNotNullAndIsDeletedIsNull();
        List<TypeResponse> list = typeMapper.hierarchiqueResponse(respage.stream().toList(), child,false);
        return PageResponse.<TypeResponse>builder()
                .content(list)
                .number(respage.getNumber())
                .size(respage.getSize())
                .totalElements(respage.getTotalElements())
                .totalPages(respage.getTotalPages())
                .first(respage.isFirst())
                .last(respage.isLast())
                .build();    }

    @Override
    public TypeResponse get_type(Long id) {
        return typeMapper.typeParentResponse_with_date_and_parent(findbyid(id,false));
    }

    @Override
    public TypeResponse get_type_detail(Long id) {
        Type res = findbyid(id,false);
        List<Type> list = typeRepository.findAllByParentAndIsDeletedIsNull(res);
        for (Type t : list) {
            List<Facteur> facteurs=facteurRepository.findAllByTypeAndIsDeletedIsNull(t);
            t.setFacteurs(facteurs);
        }
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list,true);
        }
        List<Facteur> facteurs=facteurRepository.findAllByTypeAndIsDeletedIsNull(res);
        res.setFacteurs(facteurs);
        return typeMapper.typeParentResponse_with_facteur(res);
    }

    @Override
    public TypeResponse get_type_all(Long id) {
        Type res = findbyid(id,false);
        Entreprise entreprise=check_user_permission_and_get_entreprise(false);
        if (res.getParent() != null) {
            res = res.getParent();
        }
        List<Type> list = typeRepository.findAllByParentAndIsDeletedIsNull(res);
        for (Type t : list) {
            t.setFacteurs(t.getFacteurs().stream()
                    .filter(f -> f.getIsDeleted() == null)
                    .collect(Collectors.toList()));
        }
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list,true);
        }
        res.setFacteurs(res.getFacteurs().stream()
                .filter(f -> f.getIsDeleted() == null)
                .collect(Collectors.toList()));
        return typeMapper.typeParentResponse_with_facteur(res);
    }
    @Override
    public List<TypeResponse> list_type() {
        Entreprise entreprise = this.check_user_permission_and_get_entreprise(false);
        List<Type> list = typeRepository.findAllByActiveIsTrueAndIsDeletedIsNullAndEntrepriseOrEntrepriseIsNull(entreprise);

        List<Type> child = typeRepository.findAllByParentIsNotNullAndIsDeletedIsNullAndEntrepriseOrEntrepriseIsNull(entreprise);
        return typeMapper.hierarchiqueResponse(list, child,true);
    }

    public Boolean search_type(String search, int id) {
        Entreprise entreprise = check_owner_entreprise();
        Type type = typeRepository.findByIdAndIsDeletedIsNull((long) id);

        if (type != null && !Objects.equals(type.getEntreprise().getId(), entreprise.getId())) {
            throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
        }
        if (type == null) {
            return typeRepository.existsByNameIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(search) ||
                    typeRepository.existsByNameIgnoreCaseAndIsDeletedIsNullAndEntreprise(search, entreprise);
        }

        return typeRepository.existsByNameIgnoreCaseAndIdNotAndIsDeletedIsNullAndEntreprise(search, (long) id, entreprise) ||
                typeRepository.existsByNameIgnoreCaseAndIdNotAndIsDeletedIsNullAndEntrepriseIsNull(search, (long) id);
    }

    @Override
    public PageResponse<TypeResponse> list_all_detail_trash(int page, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pageable = PageRequest.of(page, size, sort);
        Entreprise entreprise=this.check_owner_entreprise();
        boolean isSearchEmpty = search.isEmpty();
        String trimmedSearch = search.toLowerCase().trim();
        Page<Type> respage = null;
        if (entreprise != null) {
            respage= isSearchEmpty ?
                    typeRepository.findAllByIsDeletedNotNullAndEntreprise( pageable,entreprise) :
                    typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNullAndEntreprise(trimmedSearch, pageable,entreprise);
        } else {
            respage= isSearchEmpty ?
                    typeRepository.findAllByIsDeletedNotNullAndEntrepriseIsNull(pageable) :
                    typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNullAndEntrepriseIsNull(trimmedSearch, pageable);
        }
        return getTypeResponsePageResponse(respage);
    }

    @Override
    public TypeResponse activate_type(Long id) {
        Type type = findbyid(id,true);
        if (type.getActive()) {
            throw new OperationNotPermittedException("Le type " + id + " a déjà été activé");
        }

        type.setActive(true);
        return typeMapper.typeParentResponse_with_date_and_parent(typeRepository.save(type));
    }

    @Override
    public TypeResponse toggle_type_detail(Long id, boolean active) {
        Type type = findbyid(id,true);
        Type re = toggleTypeAndChildren(type, active);
        return this.get_type_all(re.getId());
    }

    @Override
    @Transactional
    public TypeResponse add_type_detail(TypeRequest request) {
        Entreprise entreprise = this.check_owner_entreprise();
        Type type = add_type(request, null, entreprise);
        return this.get_type_detail(type.getId());
    }


    @Override
    @Transactional

    public TypeResponse update_type_detail(Long id, TypeRequest request) {
        Type type = updateType(id, request, null);
        return this.get_type_detail(type.getId());
    }

    @Override
    @Transactional
    public TypeResponse delete_type_detail(Long id) {
        Type type = toggle_delete(id, true);

        return this.get_type_detail_deleted(type.getId());
    }

    @Override
    @Transactional
    public TypeResponse force_delete_type(Long id) {
        Type type = find_deleted_byid(id);
        TypeResponse resp = this.get_type_detail_deleted(type.getId());
        deleteTypeAndChildren(type);
        return resp;
    }

    @Override
    @Transactional
    public TypeResponse recovery_delete_all(Long id) {
        Type type = toggle_delete(id, false);
        return this.get_type_detail(type.getId());
    }





    private void deleteTypeAndChildren(Type type) {
        if (type.getFacteurs() != null) {
            // Collect factors to remove
            List<Facteur> facteursToRemove = new ArrayList<>(type.getFacteurs());
            for (Facteur facteur : facteursToRemove) {
                facteurService.delete_force_facteur(facteur.getId());
            }
            // Clear the original list after removal
            type.getFacteurs().clear();
        }

        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedNotNull(type);
        if (childTypes != null) {
            for (Type childType : childTypes) {
                deleteTypeAndChildren(childType);
            }
        }
        typeRepository.deleteById(type.getId());
    }






    private Type updateType(Long typeId, TypeRequest request, Type parent) {
        Type type = findbyid(typeId,true);
        if (request.nom_type() != null && !request.nom_type().equals(type.getName())) {
            type.setName(request.nom_type());
        }
        if (request.active() != null && !request.active().equals(type.getActive())) {
            type.setActive(request.active());
        }
        if (parent != null) {
            int depth = getDepth(parent);
            if (depth > 1) {
                throw new OperationNotPermittedException("La profondeur du type ne peut pas dépasser deux niveaux.");
            }
            type.setParent(parent);
        }
        type = typeRepository.save(type);
        if (request.facteurs() != null) {
            List<Long> newFacteurIds = request.facteurs().stream()
                    .map(FacteurRequest::id)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
            List<Facteur> oldFacteurs = newFacteurIds.isEmpty()
                    ? facteurRepository.findAllByTypeAndIsDeletedIsNull(type)
                    : facteurRepository.findAllByTypeAndIdNotInAndIsDeletedNull(type, newFacteurIds);
            for (Facteur facteur : oldFacteurs) {
                facteurService.delete_facteur(facteur.getId());
            }
            for (FacteurRequest i : request.facteurs()) {
                if (i.id() != null) {
                    facteurService.update(i.id(), i,type,true);
                } else {
                    facteurService.addFacteur(i, type);
                }
            }
        } else {
            List<Facteur> oldFacteurs = facteurRepository.findAllByTypeAndIsDeletedIsNull(type);
            for (Facteur facteur : oldFacteurs) {
                facteurService.delete_facteur(facteur.getId());
            }
        }
        if (request.types() != null) {
            List<Long> newTypeIds = request.types().stream()
                    .map(TypeRequest::id)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            List<Type> oldTypes = typeRepository.findAllByParentAndIdNotIn(type, newTypeIds);
            for (Type oldType : oldTypes) {
                this.delete_type_detail(oldType.getId());
            }

            for (TypeRequest childRequest : request.types()) {
                if (childRequest.id() != null) {
                    updateType(childRequest.id(), childRequest, type);
                } else {
                    add_type(childRequest, type,null);
                }
            }
        }
        boolean shouldDeactivate = request.active() != null && !request.active();
        if (shouldDeactivate) {
            deactivateChildrenAndFacteurs(type);
        }

        return type;
    }
    private void deactivateChildrenAndFacteurs(Type type) {
        if (type.getFacteurs() != null) {
            for (Facteur facteur : type.getFacteurs()) {
                if (facteur.getActive()) {
                    facteur.setActive(false);
                    facteurRepository.save(facteur);
                }
            }
        }
        List<Type> childTypes = typeRepository.findAllByParent(type);
        if (childTypes != null) {
            for (Type childType : childTypes) {
                if (childType.getActive()) {
                    childType.setActive(false);
                    deactivateChildrenAndFacteurs(childType);
                    typeRepository.save(childType);
                }
            }
        }
    }

    private Type toggleTypeAndChildren(Type type, boolean activate) {
        if (type.getActive() != activate) {
            type.setActive(activate);
            typeRepository.save(type);
        }

        if (type.getFacteurs() != null && !type.getFacteurs().isEmpty()) {
            // Using a copy of the list to avoid ConcurrentModificationException
            List<Facteur> facteurs = new ArrayList<>(type.getFacteurs());
            for (Facteur i : facteurs) {
                if (i.getActive() != activate) {
                    i.setActive(activate);
                    facteurRepository.save(i);
                }
            }
        }

        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedIsNull(type);
        if (childTypes != null && !childTypes.isEmpty()) {
            // Collecting child types to toggle in a separate list
            List<Type> childTypesToToggle = new ArrayList<>();
            for (Type childType : childTypes) {
                if (childType.getActive() != activate) {
                    childTypesToToggle.add(childType);
                }
            }
            for (Type childType : childTypesToToggle) {
                toggleTypeAndChildren(childType, activate);
            }
        }

        return type;
    }

    private TypeResponse get_type_detail_deleted(Long id) {
        Type res = find_deleted_byid(id);
        List<Type> list = typeRepository.findAllByParentAndIsDeletedNotNull(res);
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list,true);
        }
        return typeMapper.typeParentResponse(res);
    }

    private Type toggle_delete(Long id, Boolean deleted) {
        Type type;
        if (deleted) {
            type = findbyid(id,true);
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
            List<Facteur> facteursToModify = new ArrayList<>(type.getFacteurs());
            for (Facteur facteur : facteursToModify) {
                if (facteur.getIsDeleted() == null && deleted) {
                    facteurService.delete_facteur(facteur.getId());
                } else if (facteur.getIsDeleted() != null && !deleted) {
                    facteurService.recovery_facteur(facteur.getId());
                }
            }
        }

        List<Type> childTypes = typeRepository.findAllByParent(type);
        if (!childTypes.isEmpty()) {
            List<Type> childTypesToModify = new ArrayList<>(childTypes);
            for (Type childType : childTypesToModify) {
                toggle_delete(childType.getId(), deleted);
            }
        }

        return type;
    }

    private int getDepth(Type type) {
        int depth = 0;
        while (type != null) {
            type = type.getParent();
            depth++;
        }
        return depth;
    }

    private Type add_type(TypeRequest request, Type parent,Entreprise entreprise) {
        Type type = typeRepository.findByNameAndIsDeletedIsNull(request.nom_type());
        if (type != null) {
            throw new OperationNotPermittedException("type avec nom " + type.getName() + " deja exists.");
        }
        int depth = getDepth(parent);
        if (depth > 1) {
            throw new OperationNotPermittedException("La profondeur du type ne peut pas dépasser deux niveaux.");
        }
        type = Type.builder()
                .name(request.nom_type())
                .parent(parent)
                .entreprise(entreprise)
                .active(true)
                .build();
        type = typeRepository.save(type);

        if (request.facteurs() != null && !request.facteurs().isEmpty()) {
            for (FacteurRequest i : request.facteurs()) {
                Facteur facteur = Facteur.builder()
                        .nom(i.nom_facteur())
                        .unit(Unite.fromString(i.unit()))
                        .emissionFactor(i.emissionFactor())
                        .entreprise(entreprise)
                        .type(type)
                        .active((i.active() != null) ? i.active() : true)
                        .build();
                facteurRepository.save(facteur);
            }
        }
        if (request.types() != null && !request.types().isEmpty()) {
            for (TypeRequest childRequest : request.types()) {
                add_type(childRequest, type,entreprise);
            }
        }
        return type;
    }

    private PageResponse<TypeResponse> getTypeResponsePageResponse(Page<Type> respage) {
        List<TypeResponse> res = respage.stream().map(typeMapper::typeParentResponse_with_date_and_parent).toList();
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
    private List<Sort.Order> buildSortOrders(String... sortBy) {
        List<Sort.Order> orders = new ArrayList<>();
        for (int i = 0; i < sortBy.length; i++) {
            if (sortBy[i].equals("asc") || sortBy[i].equals("desc")) {
                continue;
            } else {
                Sort.Direction direction = (i + 1 < sortBy.length && sortBy[i + 1].equals("desc")) ? Sort.Direction.DESC : Sort.Direction.ASC;
                orders.add(new Sort.Order(direction, sortBy[i]));
            }
        }
        orders.add(new Sort.Order(Sort.Direction.ASC, "id"));
        return orders;
    }
    private Page<Type> pagesorted(int page, int size,boolean my, String search, String[] sortBy) {
        List<Sort.Order> orders = this.buildSortOrders(sortBy);
        Pageable pageable = PageRequest.of(page, size, Sort.by(orders));
        Page<Type> respage = null;
        Entreprise entreprise = my ? check_user_permission_and_get_entreprise(false) : null;
        boolean isSearchEmpty = search.isEmpty();
        String trimmedSearch = search.toLowerCase().trim();
        if(entreprise!=null){
            respage = (!isSearchEmpty)
                    ? typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNullAndEntrepriseAndIsDeletedIsNull(trimmedSearch,entreprise,pageable)
                    : typeRepository.findAllByParentIsNullAndEntrepriseAndIsDeletedIsNull(entreprise,pageable);
        }else {
            respage = (!isSearchEmpty)
                    ? typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNullAndIsDeletedIsNullAndEntrepriseIsNull(trimmedSearch, pageable)
                    : typeRepository.findAllByParentIsNullAndIsDeletedIsNullAndEntrepriseIsNull(pageable);
        }
        return respage;
    }
    private Type findbyid(Long id,boolean permision) {
        return this.find_type_byid(id,false,permision);
    }
    private Type find_deleted_byid(Long id) {
        return this.find_type_byid(id,true,true);
    }
    private Type find_type_byid(Long id,boolean is_deleted,boolean permision) {
        Type t;
        if (is_deleted) {
            t = typeRepository.findByIdAndIsDeletedIsNotNull(id);
        }else{
            t = typeRepository.findByIdAndIsDeletedIsNull(id);
        }
        if (t == null) {
            throw new EntityNotFoundException("type not found with id: " + id);
        }
        boolean check = check_owner(t, permision);
        if (!check) {
            throw new AccessDeniedException("Vous n'êtes pas autorisé à accéder à cette ressource.");
        }
        return t;

    }
    private boolean check_owner(Type res, boolean permission) {
        Entreprise entreprise = check_user_permission_and_get_entreprise(permission);
        if (entreprise != null && res.getEntreprise() != null) {
            return Objects.equals(res.getEntreprise().getId(), entreprise.getId());
        }
        return true;
    }

    private Entreprise check_owner_entreprise() {
        return check_user_permission_and_get_entreprise(true);
    }

    private Entreprise check_user_permission_and_get_entreprise(boolean permission) {
        Map<String, Object> table = userclaim.getUserInfo();
        if (table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");

            if (permission) {
                boolean hasPermission = roles.stream()
                        .anyMatch(role -> role.getAuthority().equals("ADMIN")
                                || role.getAuthority().equals("MANAGER")
                                || role.getAuthority().equals("RESPONSABLE"));
                if (!hasPermission) {
                    throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
                }
            }

            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                Entreprise entreprise = utilisateur.getEntreprise();
                if (entreprise == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
                return entreprise;
            }
        }
        return null; // Return null if the user is an admin or the role check passes
    }
}