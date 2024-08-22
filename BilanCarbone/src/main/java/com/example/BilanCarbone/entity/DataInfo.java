package com.example.BilanCarbone.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

/**
 * Représente une entité DataInfo qui est liée à la table "data_info" dans la base de données.
 * Cette classe contient des informations relatives aux données d'un utilisateur pour une entreprise spécifique
 * à une date donnée, ainsi que les quantités et émissions associées.
 *
 * <p>
 * Les contraintes d'unicité sont appliquées sur les colonnes "date", "idUtilisateur" et "idFacteur".
 * </p>
 *
 * @author CHALABI Hossam
 */
@Entity
@Table(name = "data_info", uniqueConstraints = @UniqueConstraint(columnNames = {"date", "idUtilisateur", "idFacteur"}))
public class DataInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String idUtilisateur;

    private Long idFacteur;

    @ManyToOne
    @JoinColumn(name = "entreprise_id", nullable = false)
    private Entreprise entreprise;

    @Column(name = "date")
    private LocalDate date;

    private Double quantity;

    private Double emission;

    /**
     * Constructeur de la classe DataInfo avec tous les paramètres.
     *
     * @param id L'identifiant unique de l'objet.
     * @param idUtilisateur L'identifiant de l'utilisateur.
     * @param idFacteur L'identifiant du facteur.
     * @param entreprise L'entreprise associée.
     * @param date La date des données.
     * @param quantity La quantité associée au facteur.
     * @param emission L'émission calculée.
     */
    public DataInfo(Long id, String idUtilisateur, Long idFacteur, Entreprise entreprise, LocalDate date, Double quantity, Double emission) {
        this.id = id;
        this.idUtilisateur = idUtilisateur;
        this.idFacteur = idFacteur;
        this.entreprise = entreprise;
        this.date = date;
        this.quantity = quantity;
        this.emission = emission;
    }

    /**
     * Constructeur sans argument.
     */
    public DataInfo() {
    }

    /**
     * Retourne une nouvelle instance de DataInfoBuilder pour construire un objet DataInfo.
     *
     * @return Une instance de DataInfoBuilder.
     */
    public static DataInfoBuilder builder() {
        return new DataInfoBuilder();
    }

    // Getters et Setters

    public Long getId() {
        return this.id;
    }

    public String getIdUtilisateur() {
        return this.idUtilisateur;
    }

    public Long getIdFacteur() {
        return this.idFacteur;
    }

    public Entreprise getEntreprise() {
        return this.entreprise;
    }

    public LocalDate getDate() {
        return this.date;
    }

    public Double getQuantity() {
        return this.quantity;
    }

    public Double getEmission() {
        return this.emission;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public void setIdFacteur(Long idFacteur) {
        this.idFacteur = idFacteur;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public void setEmission(Double emission) {
        this.emission = emission;
    }

    /**
     * Classe interne pour faciliter la construction de l'objet DataInfo.
     */
    public static class DataInfoBuilder {
        private Long id;
        private String idUtilisateur;
        private Long idFacteur;
        private Entreprise entreprise;
        private LocalDate date;
        private Double quantity;
        private Double emission;

        DataInfoBuilder() {
        }

        public DataInfoBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public DataInfoBuilder idUtilisateur(String idUtilisateur) {
            this.idUtilisateur = idUtilisateur;
            return this;
        }

        public DataInfoBuilder idFacteur(Long idFacteur) {
            this.idFacteur = idFacteur;
            return this;
        }

        public DataInfoBuilder entreprise(Entreprise entreprise) {
            this.entreprise = entreprise;
            return this;
        }

        public DataInfoBuilder date(LocalDate date) {
            this.date = date;
            return this;
        }

        public DataInfoBuilder quantity(Double quantity) {
            this.quantity = quantity;
            return this;
        }

        public DataInfoBuilder emission(Double emission) {
            this.emission = emission;
            return this;
        }

        /**
         * Construit et retourne une instance de DataInfo avec les paramètres spécifiés.
         *
         * @return Un objet DataInfo.
         */
        public DataInfo build() {
            return new DataInfo(this.id, this.idUtilisateur, this.idFacteur, this.entreprise, this.date, this.quantity, this.emission);
        }

        @Override
        public String toString() {
            return "DataInfo.DataInfoBuilder(id=" + this.id + ", idUtilisateur=" + this.idUtilisateur + ", idFacteur=" + this.idFacteur + ", entreprise=" + this.entreprise + ", date=" + this.date + ", quantity=" + this.quantity + ", emission=" + this.emission + ")";
        }
    }
}
