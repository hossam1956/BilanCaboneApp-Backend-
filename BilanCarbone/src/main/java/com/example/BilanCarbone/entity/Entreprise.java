package com.example.BilanCarbone.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
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

}
