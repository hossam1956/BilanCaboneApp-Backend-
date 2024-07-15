package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.service.FacteurService;
import com.example.BilanCarbone.service.TypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/facteur")
@RequiredArgsConstructor
public class FacteurController{
    private final FacteurService facteurService;
    @GetMapping()
    public ResponseEntity<PageResponse<FacteurResponse>> list_all(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "")String search
    ) {
        return ResponseEntity.ok(facteurService.getAllFacteurs(page,size,search));
    }
    @GetMapping("/{id}")
    public ResponseEntity<FacteurResponse> get_item(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.getFacteurById(id));
    }
}

