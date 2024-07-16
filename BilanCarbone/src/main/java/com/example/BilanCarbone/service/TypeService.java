package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeResponse;

import java.util.List;

/**
 * @author Oussama
 **/
public interface TypeService {
    PageResponse<TypeResponse> list_parent(int page , int size , String search,String... order);
    PageResponse<TypeResponse> list_all(int page , int size , String search,String... order);
    PageResponse<TypeResponse> list_all_detail(int page , int size , String search,String... order);

    TypeResponse get_type(Long id);
    TypeResponse get_type_detail(Long id);

    TypeResponse get_type_all(Long id);

}
