package com.example.BilanCarbone.dto;

import com.example.BilanCarbone.entity.DemandeUtilisateur;

import java.time.LocalDateTime;

/**
 * Data Transfer Object (DTO) pour la classe DemandeUtilisateur.
 * <p>
 * Cette classe est utilisée pour transférer les données d'une demande utilisateur.
 *
 * @author @CHALABI Hossam
 */
public class DemandeUtilisateurDTO {

    private Long id;

    private String nomUtilisateur;

    private String email;

    private String prenom;

    private String nom;

    private LocalDateTime sendDate;

    private String role;

    private Long entreprise_id;

    private String password;

    public DemandeUtilisateurDTO(Long id, String nomUtilisateur, String email, String prenom, String nom, LocalDateTime sendDate, String role, Long entreprise_id, String password) {
        this.id = id;
        this.nomUtilisateur = nomUtilisateur;
        this.email = email;
        this.prenom = prenom;
        this.nom = nom;
        this.sendDate = sendDate;
        this.role = role;
        this.entreprise_id = entreprise_id;
        this.password = password;
    }

    public DemandeUtilisateurDTO() {
    }

    /**
     * Convertit une instance de DemandeUtilisateur en DemandeUtilisateurDTO.
     *
     * @param demandeUtilisateur l'objet DemandeUtilisateur à convertir
     * @return une instance de DemandeUtilisateurDTO contenant les mêmes données que l'objet DemandeUtilisateur
     */
    public static DemandeUtilisateurDTO toDTO(DemandeUtilisateur demandeUtilisateur) {
        return DemandeUtilisateurDTO.builder()
                .id(demandeUtilisateur.getId())
                .nomUtilisateur(demandeUtilisateur.getNomUtilisateur())
                .email(demandeUtilisateur.getEmail())
                .prenom(demandeUtilisateur.getPrenom())
                .nom(demandeUtilisateur.getNom())
                .sendDate(demandeUtilisateur.getSendDate())
                .role(demandeUtilisateur.getRole())
                .password(demandeUtilisateur.getPassword())
                .entreprise_id(demandeUtilisateur.getEntreprise() != null ? demandeUtilisateur.getEntreprise().getId() : null)
                .build();
    }

    public static DemandeUtilisateurDTOBuilder builder() {
        return new DemandeUtilisateurDTOBuilder();
    }

    public Long getId() {
        return this.id;
    }

    public String getNomUtilisateur() {
        return this.nomUtilisateur;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPrenom() {
        return this.prenom;
    }

    public String getNom() {
        return this.nom;
    }

    public LocalDateTime getSendDate() {
        return this.sendDate;
    }

    public String getRole() {
        return this.role;
    }

    public Long getEntreprise_id() {
        return this.entreprise_id;
    }

    public String getPassword() {
        return this.password;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setNomUtilisateur(String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setSendDate(LocalDateTime sendDate) {
        this.sendDate = sendDate;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setEntreprise_id(Long entreprise_id) {
        this.entreprise_id = entreprise_id;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public static class DemandeUtilisateurDTOBuilder {
        private Long id;
        private String nomUtilisateur;
        private String email;
        private String prenom;
        private String nom;
        private LocalDateTime sendDate;
        private String role;
        private Long entreprise_id;
        private String password;

        DemandeUtilisateurDTOBuilder() {
        }

        public DemandeUtilisateurDTOBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public DemandeUtilisateurDTOBuilder nomUtilisateur(String nomUtilisateur) {
            this.nomUtilisateur = nomUtilisateur;
            return this;
        }

        public DemandeUtilisateurDTOBuilder email(String email) {
            this.email = email;
            return this;
        }

        public DemandeUtilisateurDTOBuilder prenom(String prenom) {
            this.prenom = prenom;
            return this;
        }

        public DemandeUtilisateurDTOBuilder nom(String nom) {
            this.nom = nom;
            return this;
        }

        public DemandeUtilisateurDTOBuilder sendDate(LocalDateTime sendDate) {
            this.sendDate = sendDate;
            return this;
        }

        public DemandeUtilisateurDTOBuilder role(String role) {
            this.role = role;
            return this;
        }

        public DemandeUtilisateurDTOBuilder entreprise_id(Long entreprise_id) {
            this.entreprise_id = entreprise_id;
            return this;
        }

        public DemandeUtilisateurDTOBuilder password(String password) {
            this.password = password;
            return this;
        }

        public DemandeUtilisateurDTO build() {
            return new DemandeUtilisateurDTO(this.id, this.nomUtilisateur, this.email, this.prenom, this.nom, this.sendDate, this.role, this.entreprise_id, this.password);
        }

        public String toString() {
            return "DemandeUtilisateurDTO.DemandeUtilisateurDTOBuilder(id=" + this.id + ", nomUtilisateur=" + this.nomUtilisateur + ", email=" + this.email + ", prenom=" + this.prenom + ", nom=" + this.nom + ", sendDate=" + this.sendDate + ", role=" + this.role + ", entreprise_id=" + this.entreprise_id + ", password=" + this.password + ")";
        }
    }
}
