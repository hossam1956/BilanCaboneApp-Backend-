package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Type;

import java.util.List;


public interface FacteurService {
    PageResponse<FacteurResponse> getAllFacteurs(int page,boolean my, int size,String search,String... order);
    FacteurResponse getFacteurById(Long id);
    FacteurResponse tooglefactecurtoggleActivation(Long id,boolean activate);
    FacteurResponse update(Long id, FacteurRequest request,Type type,boolean all);
    FacteurResponse addFacteur(FacteurRequest request, Type type);
    List<String> getType();
    List<FacteurResponse> list_facteur(Long facteurId,boolean all);
    FacteurResponse delete_facteur(Long facteurId);
    FacteurResponse delete_force_facteur(Long facteurId);
    FacteurResponse recovery_facteur(Long facteurId);
    Boolean search_facteur(String search , int id);
    PageResponse<FacteurResponse> get_All_deleted_Facteurs(int page, int size,String search,String... order);



}
