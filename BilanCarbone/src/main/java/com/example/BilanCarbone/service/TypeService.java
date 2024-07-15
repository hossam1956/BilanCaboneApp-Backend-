package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeResponse;

import java.util.List;

/**
 * @author Oussama
 **/
public interface TypeService {
    PageResponse<TypeResponse> list_parent(int page , int size , String search);
    PageResponse<TypeResponse> list_all(int page , int size , String search);
    TypeResponse get_type(Long id);
    TypeResponse get_type_detail(Long id);

}
