package com.example.BilanCarbone.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

/**
 * Entité représentant une demande utilisateur.
 *
 * @Author CHALABI Hossam
 */
@Entity
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

    /**
     * Le mot de passe de l'utilisateur.
     * Ce champ est requis.
     */
    @Column(nullable = false)
    @NotEmpty(message = "Password doit être spécifier")
    private String password;

    /**
     * Constructeur avec tous les champs.
     *
     * @param id l'identifiant unique
     * @param nomUtilisateur le nom d'utilisateur
     * @param email l'email
     * @param prenom le prénom
     * @param nom le nom de famille
     * @param sendDate la date d'envoi
     * @param role le rôle
     * @param password le mot de passe
     */
    public DemandeUtilisateur(Long id, @NotEmpty(message = "Nom Utilisateur doit être spécifier") String nomUtilisateur, @NotEmpty(message = "Email doit être spécifier") String email, @NotEmpty(message = "Prenom doit être spécifier") String prenom, @NotEmpty(message = "Nom doit être spécifier") String nom, LocalDateTime sendDate, @NotEmpty String role, @NotEmpty(message = "Password doit être spécifier") String password) {
        this.id = id;
        this.nomUtilisateur = nomUtilisateur;
        this.email = email;
        this.prenom = prenom;
        this.nom = nom;
        this.sendDate = sendDate;
        this.role = role;
        this.password = password;
    }

    /**
     * Constructeur par défaut.
     */
    public DemandeUtilisateur() {
    }

    // Getters et Setters

    public Long getId() {
        return this.id;
    }

    public @NotEmpty(message = "Nom Utilisateur doit être spécifier") String getNomUtilisateur() {
        return this.nomUtilisateur;
    }

    public @NotEmpty(message = "Email doit être spécifier") String getEmail() {
        return this.email;
    }

    public @NotEmpty(message = "Prenom doit être spécifier") String getPrenom() {
        return this.prenom;
    }

    public @NotEmpty(message = "Nom doit être spécifier") String getNom() {
        return this.nom;
    }

    public LocalDateTime getSendDate() {
        return this.sendDate;
    }

    public @NotEmpty String getRole() {
        return this.role;
    }

    public @NotEmpty(message = "Password doit être spécifier") String getPassword() {
        return this.password;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setNomUtilisateur(@NotEmpty(message = "Nom Utilisateur doit être spécifier") String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }

    public void setEmail(@NotEmpty(message = "Email doit être spécifier") String email) {
        this.email = email;
    }

    public void setPrenom(@NotEmpty(message = "Prenom doit être spécifier") String prenom) {
        this.prenom = prenom;
    }

    public void setNom(@NotEmpty(message = "Nom doit être spécifier") String nom) {
        this.nom = nom;
    }

    public void setSendDate(LocalDateTime sendDate) {
        this.sendDate = sendDate;
    }

    public void setRole(@NotEmpty String role) {
        this.role = role;
    }

    public void setPassword(@NotEmpty(message = "Password doit être spécifier") String password) {
        this.password = password;
    }
}
