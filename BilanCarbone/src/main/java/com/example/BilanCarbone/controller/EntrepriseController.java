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

    // Ajouter une entreprise
    @PostMapping
    public ResponseEntity<?> addEntreprise(@RequestBody @Valid Entreprise entreprise) {
        // Vérifier si une entreprise avec le même nom existe déjà
        if (entrepriseService.existsByNom(entreprise.getNom())) {
            return ResponseEntity.badRequest().body("Le nom de l'entreprise existe déjà.");
        }

        // Sauvegarder la nouvelle entreprise
        Entreprise savedEntreprise = entrepriseService.save(entreprise);

        // Retourner la réponse avec les détails de l'entreprise sauvegardée
        return ResponseEntity.ok(savedEntreprise);
    }

    // Récupérer toutes les entreprises
    @GetMapping
    public List<Entreprise> getAllEntreprises() {
        return entrepriseService.findAll();
    }

    // Récupérer une entreprise par son ID
    @GetMapping("/{id}")
    public ResponseEntity<Entreprise> getEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.findById(id);
        if (entreprise == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(entreprise);
    }

    // Bloquer une entreprise
    @PutMapping("/{id}/bloquer")
    public ResponseEntity<Entreprise> bloquerEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.updateStatus(id, true);
        return ResponseEntity.ok(entreprise);
    }

    // Débloquer une entreprise
    @PutMapping("/{id}/debloquer")
    public ResponseEntity<Entreprise> debloquerEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.updateStatus(id, false);
        return ResponseEntity.ok(entreprise);
    }

    // Mettre à jour une entreprise
    @PutMapping("/{id}")
    public ResponseEntity<?> updateEntreprise(@PathVariable Long id, @RequestBody @Valid Entreprise entrepriseDetails) {
        // Vérifier si le nom existe déjà pour une autre entreprise
        if (entrepriseService.existsByNomAndDifferentId(entrepriseDetails.getNom(), id)) {
            return ResponseEntity.badRequest().body("Le nom de l'entreprise existe déjà.");
        }

        // Vérifier si l'entreprise existe
        Entreprise entreprise = entrepriseService.findById(id);
        if (entreprise == null) {
            return ResponseEntity.notFound().build();
        }

        // Mettre à jour les détails de l'entreprise
        entreprise.setNom(entrepriseDetails.getNom());
        entreprise.setAdresse(entrepriseDetails.getAdresse());
        entreprise.setType(entrepriseDetails.getType());
        entreprise.setBloque(entrepriseDetails.isBloque());

        // Enregistrer l'entreprise mise à jour
        Entreprise updatedEntreprise = entrepriseService.save(entreprise);

        // Retourner l'entreprise mise à jour dans la réponse
        return ResponseEntity.ok(updatedEntreprise);
    }

    // Supprimer une entreprise
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEntreprise(@PathVariable Long id) {
        Entreprise entreprise = entrepriseService.findById(id);
        if (entreprise == null) {
            return ResponseEntity.notFound().build();
        }

        entrepriseService.deleteById(id);
        return ResponseEntity.ok().body("L'entreprise a été supprimée avec succès.");
    }

    // Gestion des exceptions de validation
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
}
