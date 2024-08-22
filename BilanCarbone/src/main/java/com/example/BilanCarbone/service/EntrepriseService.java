package com.example.BilanCarbone.service;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.repositories.EntrepriseRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EntrepriseService {

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    // Méthode pour mettre à jour une entreprise
    public Entreprise updateEntreprise(Long id, Entreprise entrepriseDetails) {
        Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Entreprise not found"));

        // Vérifier les doublons avant de mettre à jour
        if (existsByNomAndDifferentId(entrepriseDetails.getNom(), id)) {
            throw new RuntimeException("Le nom de l'entreprise existe déjà.");
        }

        entreprise.setNom(entrepriseDetails.getNom());
        entreprise.setAdresse(entrepriseDetails.getAdresse());
        entreprise.setType(entrepriseDetails.getType());
        entreprise.setBloque(entrepriseDetails.isBloque());

        return entrepriseRepository.save(entreprise);
    }

    // Méthode pour récupérer toutes les entreprises
    public List<Entreprise> findAll() {
        return entrepriseRepository.findAll();
    }

    // Méthode pour récupérer une entreprise par son ID
    public Entreprise findById(Long id) {
        return entrepriseRepository.findById(id).orElseThrow(() -> {
            throw new EntityNotFoundException("entreprise not found with id: " + id);
        });
    }

    // Méthode pour sauvegarder une nouvelle entreprise
    public Entreprise save(Entreprise entreprise) {
        // Vérifier les doublons avant de sauvegarder
        if (existsByNom(entreprise.getNom())) {
            throw new RuntimeException("Le nom de l'entreprise existe déjà.");
        }

        return entrepriseRepository.save(entreprise);
    }

    // Méthode pour supprimer une entreprise par son ID
    public void deleteById(Long id) {
        entrepriseRepository.deleteById(id);
    }

    // Méthode pour mettre à jour le statut (bloqué ou débloqué) d'une entreprise
    public Entreprise updateStatus(Long id, boolean bloque) {
        Entreprise entreprise = entrepriseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Entreprise not found with id " + id));

        entreprise.setBloque(bloque);
        return entrepriseRepository.save(entreprise);
    }

    // Vérifie si une entreprise avec le même nom et un ID différent existe déjà
    public boolean existsByNomAndDifferentId(String nom, Long id) {
        return entrepriseRepository.existsByNomAndIdNot(nom, id);
    }

    // Vérifie si une entreprise avec le même nom existe déjà
    public boolean existsByNom(String nom) {
        return entrepriseRepository.existsByNom(nom);
    }
}
