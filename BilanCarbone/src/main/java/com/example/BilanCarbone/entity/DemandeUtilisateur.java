package com.example.BilanCarbone.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

/**
 * Entité représentant une demande utilisateur.
 *
 * @Author CHALABI Hossam
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
public class DemandeUtilisateur {

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
    private String nomUtilisateur;

    /**
     * L'email de la personne faisant la demande.
     * Ce champ est requis et doit être unique.
     */
    @Column(nullable = false, unique = true)
    @NotEmpty(message = "Email doit être spécifier")
    private String email;

    /**
     * Le prénom de la personne faisant la demande.
     * Ce champ est requis.
     */
    @Column(nullable = false)
    @NotEmpty(message = "Prenom doit être spécifier")
    private String prenom;

    /**
     * Le nom de famille de la personne faisant la demande.
     * Ce champ est requis.
     */
    @Column(nullable = false)
    @NotEmpty(message = "Nom doit être spécifier")
    private String nom;

    /**
     * La date et l'heure d'envoi de la demande.
     * Ce champ est défini automatiquement lors de la persistance.
     */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime sendDate;

    /**
     * Le rôle demandé par l'utilisateur.
     * Ce champ est requis.
     */
    @Column(nullable = false)
    @NotEmpty
    private String role;

   @ManyToOne
   @JoinColumn(name="entreprise_id", nullable=false)
    private Entreprise entreprise;
    /**
     * Le mot de passe de l'utilisateur.
     * Ce champ est requis.
     */
    @Column(nullable = false)
    @NotEmpty(message = "Password doit être spécifier")
    private String password;



}