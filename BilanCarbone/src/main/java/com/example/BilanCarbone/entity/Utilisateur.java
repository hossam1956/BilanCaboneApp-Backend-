package com.example.BilanCarbone.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

/**
 * Représente un utilisateur dans le système.
 *
 * @author @CHALABI Hossam
 */
@Entity
public class Utilisateur {

    @Id
    private String id;

    @ManyToOne
    @JoinColumn(name = "entreprise_id", nullable = false)
    private Entreprise entreprise;

    /**
     * Constructeur avec paramètres pour la classe Utilisateur.
     *
     * @param id l'identifiant de l'utilisateur
     * @param entreprise l'entreprise associée à l'utilisateur
     */
    public Utilisateur(String id, Entreprise entreprise) {
        this.id = id;
        this.entreprise = entreprise;
    }

    /**
     * Constructeur par défaut pour la classe Utilisateur.
     */
    public Utilisateur() {
    }

    /**
     * Crée un nouveau constructeur pour Utilisateur.
     *
     * @return un constructeur de Utilisateur
     */
    public static UtilisateurBuilder builder() {
        return new UtilisateurBuilder();
    }

    /**
     * Obtient l'identifiant de l'utilisateur.
     *
     * @return l'identifiant de l'utilisateur
     */
    public String getId() {
        return this.id;
    }

    /**
     * Obtient l'entreprise associée à l'utilisateur.
     *
     * @return l'entreprise associée à l'utilisateur
     */
    public Entreprise getEntreprise() {
        return this.entreprise;
    }

    /**
     * Définit l'identifiant de l'utilisateur.
     *
     * @param id l'identifiant de l'utilisateur à définir
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * Définit l'entreprise associée à l'utilisateur.
     *
     * @param entreprise l'entreprise à associer à l'utilisateur
     */
    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    /**
     * Classe interne pour construire des instances de Utilisateur.
     */
    public static class UtilisateurBuilder {
        private String id;
        private Entreprise entreprise;

        UtilisateurBuilder() {
        }

        /**
         * Définit l'identifiant de l'utilisateur pour le constructeur.
         *
         * @param id l'identifiant de l'utilisateur
         * @return le constructeur d'utilisateur
         */
        public UtilisateurBuilder id(String id) {
            this.id = id;
            return this;
        }

        /**
         * Définit l'entreprise associée à l'utilisateur pour le constructeur.
         *
         * @param entreprise l'entreprise à associer à l'utilisateur
         * @return le constructeur d'utilisateur
         */
        public UtilisateurBuilder entreprise(Entreprise entreprise) {
            this.entreprise = entreprise;
            return this;
        }

        /**
         * Crée une nouvelle instance de Utilisateur.
         *
         * @return une nouvelle instance de Utilisateur
         */
        public Utilisateur build() {
            return new Utilisateur(this.id, this.entreprise);
        }

        @Override
        public String toString() {
            return "Utilisateur.UtilisateurBuilder(id=" + this.id + ", entreprise=" + this.entreprise + ")";
        }
    }
}
