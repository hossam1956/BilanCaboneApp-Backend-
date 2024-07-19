package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.dto.TypeRequest;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.service.TypeService;
import com.example.BilanCarbone.validation.OnCreate;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
        if(all){
            res=typeService.get_type_detail(id);
        } else if (detail) {
            res = typeService.get_type_all(id);
        }
        else{
            res=typeService.get_type(id);
        }
        return ResponseEntity.ok(res);
    }
    @PutMapping("/{id}/activate")
    public ResponseEntity<TypeResponse> activate_facteur(@PathVariable Long id, @RequestParam(defaultValue = "false") Boolean all) {
        if(!all){
            return ResponseEntity.ok(typeService.activate_type(id));
        }
        return ResponseEntity.ok(typeService.toggle_type_detail(id,true));
    }
    @PutMapping("/{id}/desactivate")
    public ResponseEntity<TypeResponse> desactivate_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.toggle_type_detail(id,false));
    }
    @PostMapping()
    public ResponseEntity<TypeResponse> add_facteur(@Validated(OnCreate.class)@RequestBody TypeRequest typeRequest) {
        return ResponseEntity.ok(typeService.add_type_detail(typeRequest));
    }
    @GetMapping("/all")
    public ResponseEntity<List<TypeResponse>> list_type(
    ) {
        return ResponseEntity.ok(typeService.list_type());
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<TypeResponse> delete_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.delete_type_detail(id));
    }
    @DeleteMapping("/trash/{id}")
    public ResponseEntity<TypeResponse> delete_force_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.force_delete_type(id));
    }
    @PostMapping("/trash/{id}")
    public ResponseEntity<TypeResponse> recovery_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.recovery_delete_all(id));
    }
    @GetMapping("/trash")
    public ResponseEntity<PageResponse<TypeResponse>> list_all_type_trash(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "")String search,
            @RequestParam(defaultValue = "createdDate") String[] sortBy
    ) {
        return ResponseEntity.ok(typeService.list_all_detail_trash(page,size,search,sortBy));
    }
    @PutMapping("/{id}")
    public ResponseEntity<TypeResponse> update_type(@PathVariable Long id, @RequestBody TypeRequest typeRequest) {
        return ResponseEntity.ok(typeService.update_type_detail(id,typeRequest));
    }
}
