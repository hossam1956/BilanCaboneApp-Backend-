package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurResponse;
import org.springframework.data.domain.Pageable;


public interface FacteurService {
    PageResponse<FacteurResponse> getAllFacteurs(int page, int size,String search);
    FacteurResponse getFacteurById(Long id);
}
