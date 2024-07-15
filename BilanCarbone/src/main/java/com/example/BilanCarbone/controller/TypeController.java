package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.service.TypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
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
    @GetMapping("/parent")
    public ResponseEntity<PageResponse<TypeResponse>> list_parent(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "")String search
    ) {
        return ResponseEntity.ok(typeService.list_parent(page, size, search));
    }
    @GetMapping()
    public ResponseEntity<PageResponse<TypeResponse>> list_all(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "")String search
    ) {
        return ResponseEntity.ok(typeService.list_all(page, size, search));
    }
    @GetMapping("/{id}")
    public ResponseEntity<TypeResponse> get_item(@PathVariable Long id ,   @RequestParam(defaultValue = "false") Boolean detail ) {
        TypeResponse res =null;
        if(detail){
            res=typeService.get_type_detail(id);
        }else{
            res=typeService.get_type(id);
        }
        return ResponseEntity.ok(res);
    }
}
