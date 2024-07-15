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
    public PageResponse<TypeResponse> list_parent(int page , int size , String search) {
        Pageable pe = PageRequest.of(page, size);
        Page<Type> respage=null;
        if(!search.isEmpty()) {
            respage=typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNull(search,pe);
        }else {
            respage=typeRepository.findAllByParentIsNull(pe);
        }
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
    @Override
    public PageResponse<TypeResponse> list_all(int page , int size , String search){
        //return typeMapper.hierarchiqueResponse(typeRepository.findAll());
   return null;
    }

    @Override
    public TypeResponse get_type(Long id) {
        Type res=typeRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Type not found with id: " + id)
        );
        return typeMapper.typeParentResponse(res);
    }

    @Override
    public TypeResponse get_type_detail(Long id) {
        Type res=typeRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Type not found with id: " + id)
        );
        if(res.getParent()!=null)
        {
            res=res.getParent();
        }
        List<Type> list =typeRepository.findAllByParent(res);
        if(!list.isEmpty()){
            return typeMapper.typeParentResponse(res,list);
        }
        return typeMapper.typeParentResponse(res);
    }
}
