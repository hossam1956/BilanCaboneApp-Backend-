package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.mappeer.FacteurMapper;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort;

import java.util.List;

/**
 * @author Oussama
 **/
@Service
@RequiredArgsConstructor
public class FacteurServiceimplement implements FacteurService{

    private final FacteurRepository facteurRepository;
    private final FacteurMapper facteurMapper;
    @Override
    public PageResponse<FacteurResponse> getAllFacteurs(int ge,int size,String search,String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(ge, size,sort);
        Page<Facteur> page=null;
        if(!search.isEmpty()) {
            page=facteurRepository.findAllByNomContainingIgnoreCase(search.toLowerCase().trim(),pe);
        }else {
            page=facteurRepository.findAll(pe);
        }
        List<FacteurResponse> res=page.stream().map(facteurMapper::toFacteurResponse).toList();
        return PageResponse.<FacteurResponse>builder()
                .content(res)
                .number(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .build();
    }

    @Override
    public FacteurResponse getFacteurById(Long id) {
        return facteurMapper.toFacteurResponse(facteurRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Facteur not found with id: " + id)
        ));
    }

}
