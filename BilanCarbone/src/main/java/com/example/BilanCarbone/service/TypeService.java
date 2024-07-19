package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeRequest;
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
    TypeResponse activate_type(Long id);
    TypeResponse toggle_type_detail(Long id, boolean active);
    TypeResponse add_type_detail(TypeRequest request);
    List<TypeResponse> list_type();
    TypeResponse update_type_detail(Long id,TypeRequest request);
    TypeResponse delete_type_detail(Long id);
    TypeResponse force_delete_type(Long id);
    TypeResponse recovery_delete_all(Long id);
    PageResponse<TypeResponse> list_all_detail_trash(int page , int size , String search,String... order);

}
