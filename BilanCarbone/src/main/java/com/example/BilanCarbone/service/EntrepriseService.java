package com.example.BilanCarbone.service;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.jpa.EntrepriseRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class EntrepriseService {

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    // Méthode pour récupérer toutes les entreprises non supprimées
    public List<Entreprise> findAll() {
        return entrepriseRepository.findByIsDeletedIsNull();
    }

    // Méthode pour récupérer toutes les entreprises supprimées
    public List<Entreprise> findAllDeleted() {
        return entrepriseRepository.findByIsDeletedIsNotNull();
    }

    // Méthode pour récupérer une entreprise non supprimée par ID
    public Entreprise findById(Long id) {
        return entrepriseRepository.findByIdAndIsDeletedIsNull(id)
                .orElseThrow(() -> new EntityNotFoundException("Entreprise not found with id: " + id));
    }

    // Méthode pour sauvegarder une nouvelle entreprise
    public Entreprise save(Entreprise entreprise) {
        if (existsByNom(entreprise.getNom())) {
            throw new RuntimeException("Le nom de l'entreprise existe déjà.");
        }
        entreprise.setIsDeleted(null); // Assurez-vous que l'entreprise n'est pas marquée comme supprimée
        return entrepriseRepository.save(entreprise);
    }

    // Méthode pour marquer une entreprise comme supprimée (soft delete)
    public void deleteById(Long id) {
        Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Entreprise not found"));
        entreprise.setIsDeleted(LocalDateTime.now());
        entrepriseRepository.save(entreprise);
    }

    // Méthode pour restaurer une entreprise supprimée
    public void restoreById(Long id) {
        Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Entreprise not found"));
        entreprise.setIsDeleted(null);  // Remettre à null pour restaurer l'entreprise
        entrepriseRepository.save(entreprise);
    }

    // Méthode pour mettre à jour le statut (bloqué ou débloqué) d'une entreprise
    public Entreprise updateStatus(Long id, boolean bloque) {
        Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Entreprise not found with id " + id));

        entreprise.setBloque(bloque);
        return entrepriseRepository.save(entreprise);
    }

    // Méthode pour vérifier l'existence par nom et un ID différent
    public boolean existsByNomAndDifferentId(String nom, Long id) {
        return entrepriseRepository.existsByNomAndIdNot(nom, id);
    }

    // Méthode pour vérifier l'existence par nom
    public boolean existsByNom(String nom) {
        return entrepriseRepository.existsByNom(nom);
    }
}
