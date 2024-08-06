package com.example.BilanCarbone.config;

import com.example.BilanCarbone.entity.Entreprise;
import org.keycloak.representations.idm.UserRepresentation;

/**
 * Classe représentant un utilisateur avec des informations supplémentaires sur l'entreprise.
 * Cette classe combine les informations d'un utilisateur Keycloak avec des détails sur l'entreprise associée.
 *
 * @author CHALABI Hossam
 */
public class CustomUserRepresentation {
    private UserRepresentation userRepresentation;
    private Entreprise entreprise;

    /**
     * Constructeur pour créer une instance de CustomUserRepresentation.
     *
     * @param userRepresentation l'utilisateur Keycloak
     * @param entreprise l'entreprise associée à l'utilisateur
     */
    public CustomUserRepresentation(UserRepresentation userRepresentation, Entreprise entreprise) {
        this.userRepresentation = userRepresentation;
        this.entreprise = entreprise;
    }

    /**
     * Retourne un constructeur de CustomUserRepresentation.
     *
     * @return une nouvelle instance de CustomUserRepresentationBuilder
     */
    public static CustomUserRepresentationBuilder builder() {
        return new CustomUserRepresentationBuilder();
    }

    // Getters et setters

    /**
     * Obtient l'utilisateur Keycloak.
     *
     * @return l'utilisateur Keycloak
     */
    public UserRepresentation getUserRepresentation() {
        return userRepresentation;
    }

    /**
     * Définit l'utilisateur Keycloak.
     *
     * @param userRepresentation l'utilisateur Keycloak
     */
    public void setUserRepresentation(UserRepresentation userRepresentation) {
        this.userRepresentation = userRepresentation;
    }

    /**
     * Obtient l'entreprise associée à l'utilisateur.
     *
     * @return l'entreprise associée
     */
    public Entreprise getEntreprise() {
        return entreprise;
    }

    /**
     * Définit l'entreprise associée à l'utilisateur.
     *
     * @param entreprise l'entreprise associée
     */
    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    /**
     * Classe Builder pour construire des instances de CustomUserRepresentation.
     */
    public static class CustomUserRepresentationBuilder {
        private UserRepresentation userRepresentation;
        private Entreprise entreprise;

        CustomUserRepresentationBuilder() {
        }

        /**
         * Définit l'utilisateur Keycloak pour le constructeur.
         *
         * @param userRepresentation l'utilisateur Keycloak
         * @return l'instance du constructeur
         */
        public CustomUserRepresentationBuilder userRepresentation(UserRepresentation userRepresentation) {
            this.userRepresentation = userRepresentation;
            return this;
        }

        /**
         * Définit l'entreprise associée pour le constructeur.
         *
         * @param entreprise l'entreprise associée
         * @return l'instance du constructeur
         */
        public CustomUserRepresentationBuilder entreprise(Entreprise entreprise) {
            this.entreprise = entreprise;
            return this;
        }

        /**
         * Construit une instance de CustomUserRepresentation.
         *
         * @return une nouvelle instance de CustomUserRepresentation
         */
        public CustomUserRepresentation build() {
            return new CustomUserRepresentation(this.userRepresentation, this.entreprise);
        }

        @Override
        public String toString() {
            return "CustomUserRepresentation.CustomUserRepresentationBuilder(userRepresentation=" + this.userRepresentation + ", entreprise=" + this.entreprise + ")";
        }
    }
}
