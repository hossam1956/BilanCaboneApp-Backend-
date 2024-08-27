package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EntrepriseRepository extends JpaRepository<Entreprise, Long> {

    // Rechercher les entreprises non supprimées
    List<Entreprise> findByIsDeletedIsNull();

    // Rechercher les entreprises supprimées
    List<Entreprise> findByIsDeletedIsNotNull();

    // Rechercher une entreprise non supprimée par ID
    Optional<Entreprise> findByIdAndIsDeletedIsNull(Long id);

boolean existsByNomAndIdNot(String nom, Long id);
    boolean existsByNom(String nom);
}
