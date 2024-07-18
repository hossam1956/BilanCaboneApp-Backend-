package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.service.FacteurService;
import com.example.BilanCarbone.service.TypeService;
import com.example.BilanCarbone.validation.OnCreate;
import com.example.BilanCarbone.validation.OnUpdate;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
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
            @RequestParam(defaultValue = "")String search,
            @RequestParam(defaultValue = "createdDate") String[] sortBy    ) {
        return ResponseEntity.ok(facteurService.getAllFacteurs(page,size,search,sortBy));
    }
    @GetMapping("/{id}")
    public ResponseEntity<FacteurResponse> get_item(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.getFacteurById(id));
    }
    @PutMapping("/{id}/activate")
    public ResponseEntity<FacteurResponse> activate_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.tooglefactecurtoggleActivation(id,true));
    }
    @PutMapping("/{id}/desactivate")

    public ResponseEntity<FacteurResponse> desactivate_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.tooglefactecurtoggleActivation(id,false));
    }
    @PutMapping("/{id}")
    public ResponseEntity<FacteurResponse> update_facteur(@PathVariable Long id, @Validated(OnUpdate.class) @RequestBody FacteurRequest facteurRequest) {
        return ResponseEntity.ok(facteurService.update(id,facteurRequest));
    }
    @GetMapping("/type")
    public ResponseEntity<List<String>> get_facteurs_unite() {
        return ResponseEntity.ok(facteurService.getType());
    }
    @PostMapping()
    public ResponseEntity<FacteurResponse> Add_facteur(@Validated(OnCreate.class)@RequestBody FacteurRequest facteurRequest) {
        return ResponseEntity.ok(facteurService.addFacteur(facteurRequest,null));
    }
    @GetMapping("/all")
    public ResponseEntity<List<FacteurResponse>> list_all_facteur(
            @RequestParam(defaultValue = "-1") Long parent
            ) {
        return ResponseEntity.ok(facteurService.list_facteur(parent));
    }
}

