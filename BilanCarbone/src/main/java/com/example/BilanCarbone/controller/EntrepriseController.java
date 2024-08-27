package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.entity.Entreprise;

import com.example.BilanCarbone.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/entreprises")
public class EntrepriseController {

    @Autowired
    private EntrepriseService entrepriseService;

    // Méthode pour récupérer toutes les entreprises non supprimées
    @GetMapping
    public List<Entreprise> getAllEntreprises() {
        return entrepriseService.findAll();
    }

    // Méthode pour récupérer une entreprise par ID
    @GetMapping("/{id}")
    public ResponseEntity<Entreprise> getEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.findById(id);
        return ResponseEntity.ok(entreprise);
    }

    // Méthode pour ajouter une entreprise
    @PostMapping
    public ResponseEntity<?> addEntreprise(@RequestBody Entreprise entreprise) {
        if (entrepriseService.existsByNomAndDifferentId(entreprise.getNom(), null)) {
            return ResponseEntity.badRequest().body("Le nom de l'entreprise existe déjà.");
        }
        Entreprise savedEntreprise = entrepriseService.save(entreprise);
        return ResponseEntity.ok(savedEntreprise);
    }

    // Méthode pour bloquer une entreprise
    @PutMapping("/{id}/bloquer")
    public ResponseEntity<Entreprise> bloquerEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.updateStatus(id, true);
        return ResponseEntity.ok(entreprise);
    }

    // Méthode pour débloquer une entreprise
    @PutMapping("/{id}/debloquer")
    public ResponseEntity<Entreprise> debloquerEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.updateStatus(id, false);
        return ResponseEntity.ok(entreprise);
    }

    // Méthode pour mettre à jour une entreprise
    @PutMapping("/{id}")
    public ResponseEntity<?> updateEntreprise(@PathVariable Long id, @RequestBody Entreprise entrepriseDetails) {
        if (entrepriseService.existsByNomAndDifferentId(entrepriseDetails.getNom(), id)) {
            return ResponseEntity.badRequest().body("Le nom de l'entreprise existe déjà.");
        }
        Entreprise entreprise = entrepriseService.findById(id);
        if (entreprise == null) {
            return ResponseEntity.notFound().build();
        }
        entreprise.setNom(entrepriseDetails.getNom());
        entreprise.setAdresse(entrepriseDetails.getAdresse());
        entreprise.setType(entrepriseDetails.getType());
        entreprise.setBloque(entrepriseDetails.isBloque());
        Entreprise updatedEntreprise = entrepriseService.save(entreprise);
        return ResponseEntity.ok(updatedEntreprise);
    }

    // Méthode pour gérer les erreurs de validation
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return ResponseEntity.badRequest().body(errors);

    }

    // Méthode pour supprimer (soft delete) une entreprise
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEntreprise(@PathVariable Long id) {
        entrepriseService.deleteById(id);
        return ResponseEntity.ok().body("L'entreprise a été supprimée avec succès.");
    }

    // Méthode pour récupérer les entreprises supprimées
    @GetMapping("/deleted")
    public List<Entreprise> getDeletedEntreprises() {
        return entrepriseService.findAllDeleted();
    }

    // Méthode pour restaurer une entreprise supprimée
    @PutMapping("/{id}/restore")
    public ResponseEntity<?> restoreEntreprise(@PathVariable Long id) {
        entrepriseService.restoreById(id);
        return ResponseEntity.ok().body("L'entreprise a été restaurée avec succès.");
    }
}
