package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.service.TypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
/**
 * @author Oussama
 **/
@RestController
@RequestMapping("/api/type")
@RequiredArgsConstructor
public class TypeController {
    private final TypeService typeService;
    @GetMapping()
    public ResponseEntity<PageResponse<TypeResponse>> list_all(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "")String search,
            @RequestParam(defaultValue = "createdDate") String[] sortBy,
            @RequestParam(defaultValue = "false") Boolean parent,
            @RequestParam(defaultValue = "false") Boolean detail

            ) {
        if (parent){
            return ResponseEntity.ok(typeService.list_parent(page, size, search,sortBy));
        }else if(detail){
            return ResponseEntity.ok(typeService.list_all_detail(page, size, search,sortBy));
        }
        return ResponseEntity.ok(typeService.list_all(page, size, search,sortBy));

    }
    @GetMapping("/{id}")
    public ResponseEntity<TypeResponse> get_item(
            @PathVariable Long id ,
            @RequestParam(defaultValue = "false") Boolean detail,
            @RequestParam(defaultValue = "false") Boolean all

            ) {
        TypeResponse res =null;
        if(detail){
            res=typeService.get_type_detail(id);
        } else if (all) {
            res = typeService.get_type_all(id);
        }
        else{
            res=typeService.get_type(id);
        }
        return ResponseEntity.ok(res);
    }
}
