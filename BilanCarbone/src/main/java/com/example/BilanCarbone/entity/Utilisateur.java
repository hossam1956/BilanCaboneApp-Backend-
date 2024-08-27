package com.example.BilanCarbone.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

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
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdDate;

    /**
     * Date et heure de la dernière modification de l'entité, mise à jour automatiquement lors des modifications.
     */
    @UpdateTimestamp
    @Column(insertable = false)
    private LocalDateTime UpdateDate;

    /**
     * Date et heure de suppression logique de l'entité. Si ce champ est non nul, l'entité est considérée comme supprimée.
     * La valeur par défaut est {@code null}.
     */
    @Column(columnDefinition = "timestamp default null")
    private LocalDateTime isDeleted;

    public Utilisateur(String id, Entreprise entreprise, LocalDateTime createdDate, LocalDateTime UpdateDate, LocalDateTime isDeleted) {
        this.id = id;
        this.entreprise = entreprise;
        this.createdDate = createdDate;
        this.UpdateDate = UpdateDate;
        this.isDeleted = isDeleted;
    }

    public Utilisateur() {
    }

    public static UtilisateurBuilder builder() {
        return new UtilisateurBuilder();
    }

    public String getId() {
        return this.id;
    }

    public Entreprise getEntreprise() {
        return this.entreprise;
    }

    public LocalDateTime getCreatedDate() {
        return this.createdDate;
    }

    public LocalDateTime getUpdateDate() {
        return this.UpdateDate;
    }

    public LocalDateTime getIsDeleted() {
        return this.isDeleted;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public void setUpdateDate(LocalDateTime UpdateDate) {
        this.UpdateDate = UpdateDate;
    }

    public void setIsDeleted(LocalDateTime isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof Utilisateur)) return false;
        final Utilisateur other = (Utilisateur) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$id = this.getId();
        final Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final Object this$entreprise = this.getEntreprise();
        final Object other$entreprise = other.getEntreprise();
        if (this$entreprise == null ? other$entreprise != null : !this$entreprise.equals(other$entreprise))
            return false;
        final Object this$createdDate = this.getCreatedDate();
        final Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate))
            return false;
        final Object this$UpdateDate = this.getUpdateDate();
        final Object other$UpdateDate = other.getUpdateDate();
        if (this$UpdateDate == null ? other$UpdateDate != null : !this$UpdateDate.equals(other$UpdateDate))
            return false;
        final Object this$isDeleted = this.getIsDeleted();
        final Object other$isDeleted = other.getIsDeleted();
        if (this$isDeleted == null ? other$isDeleted != null : !this$isDeleted.equals(other$isDeleted)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof Utilisateur;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final Object $entreprise = this.getEntreprise();
        result = result * PRIME + ($entreprise == null ? 43 : $entreprise.hashCode());
        final Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final Object $UpdateDate = this.getUpdateDate();
        result = result * PRIME + ($UpdateDate == null ? 43 : $UpdateDate.hashCode());
        final Object $isDeleted = this.getIsDeleted();
        result = result * PRIME + ($isDeleted == null ? 43 : $isDeleted.hashCode());
        return result;
    }

    public String toString() {
        return "Utilisateur(id=" + this.getId() + ", entreprise=" + this.getEntreprise() + ", createdDate=" + this.getCreatedDate() + ", UpdateDate=" + this.getUpdateDate() + ", isDeleted=" + this.getIsDeleted() + ")";
    }

    public static class UtilisateurBuilder {
        private String id;
        private Entreprise entreprise;
        private LocalDateTime createdDate;
        private LocalDateTime UpdateDate;
        private LocalDateTime isDeleted;

        UtilisateurBuilder() {
        }

        public UtilisateurBuilder id(String id) {
            this.id = id;
            return this;
        }

        public UtilisateurBuilder entreprise(Entreprise entreprise) {
            this.entreprise = entreprise;
            return this;
        }

        public UtilisateurBuilder createdDate(LocalDateTime createdDate) {
            this.createdDate = createdDate;
            return this;
        }

        public UtilisateurBuilder UpdateDate(LocalDateTime UpdateDate) {
            this.UpdateDate = UpdateDate;
            return this;
        }

        public UtilisateurBuilder isDeleted(LocalDateTime isDeleted) {
            this.isDeleted = isDeleted;
            return this;
        }

        public Utilisateur build() {
            return new Utilisateur(this.id, this.entreprise, this.createdDate, this.UpdateDate, this.isDeleted);
        }

        public String toString() {
            return "Utilisateur.UtilisateurBuilder(id=" + this.id + ", entreprise=" + this.entreprise + ", createdDate=" + this.createdDate + ", UpdateDate=" + this.UpdateDate + ", isDeleted=" + this.isDeleted + ")";
        }
    }
}
