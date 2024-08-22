package com.example.BilanCarbone.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;

@Entity
public class Entreprise {
    /**
     * Identifiant unique pour la demande utilisateur.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Le nom d'utilisateur de la personne faisant la demande.
     * Ce champ est requis et doit être unique.
     */
    @Column(nullable = false, unique = true)
    @NotEmpty(message = "Nom Utilisateur doit être spécifier")
    private String nomEntreprise;

    public Entreprise(Long id, @NotEmpty(message = "Nom Utilisateur doit être spécifier") String nomEntreprise) {
        this.id = id;
        this.nomEntreprise = nomEntreprise;
    }

    public Entreprise() {
    }

    public Long getId() {
        return this.id;
    }

    public @NotEmpty(message = "Nom Utilisateur doit être spécifier") String getNomEntreprise() {
        return this.nomEntreprise;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setNomEntreprise(@NotEmpty(message = "Nom Utilisateur doit être spécifier") String nomEntreprise) {
        this.nomEntreprise = nomEntreprise;
    }
}
