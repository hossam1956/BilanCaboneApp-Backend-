package com.example.BilanCarbone.service;
import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.mappeer.TypeMapper;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Oussama
 **/
@Service
@RequiredArgsConstructor
public class TypeServiceimplement implements TypeService{
    private final TypeRepository typeRepository;
    private final TypeMapper typeMapper;
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
            respage=typeRepository.findAllByNameContainingIgnoreCase(search,pe);
        }else{
            respage=typeRepository.findAll(pe);
        }
        return getTypeResponsePageResponse(respage);
    }



    @Override
    public PageResponse<TypeResponse> list_all_detail(int page , int size , String search,String... order){
        Page<Type> respage=pagesorted(page, size, search, order);
        List<Type> child=typeRepository.findAllByParentIsNotNull();
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
        Type res=typeRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Type not found with id: " + id)
        );
        return typeMapper.typeParentResponse2(res);
    }

    @Override
    public TypeResponse get_type_detail(Long id) {
        Type res=typeRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Type not found with id: " + id)
        );
        List<Type> list =typeRepository.findAllByParent(res);
        if(!list.isEmpty()){
            return typeMapper.typeParentResponse(res,list);
        }
        return typeMapper.typeParentResponse(res);
    }

    @Override
    public TypeResponse get_type_all(Long id) {
        Type res=typeRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Type not found with id: " + id)
        );
        if(res.getParent()!=null){
            res= res.getParent();
        }
        List<Type> list =typeRepository.findAllByParent(res);
        if(!list.isEmpty()){
            return typeMapper.typeParentResponse(res,list);
        }
        return typeMapper.typeParentResponse(res);
    }



    private Page<Type> pagesorted(int page, int size, String search, String[] order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size,sort);
        if(!search.isEmpty()) {
            return typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNull(search,pe);
        }
            return typeRepository.findAllByParentIsNull(pe);

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
}
