package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotBlank;

@Entity
public class Entreprise extends BaseEntity {

    @NotBlank(message = "Le nom de l'entreprise est obligatoire")
    private String nom;

    @NotBlank(message = "L'adresse de l'entreprise est obligatoire")
    private String adresse;

    private boolean bloque;

    @Enumerated(EnumType.STRING)
    private EntrepriseType type;

    public Entreprise(@NotBlank(message = "Le nom de l'entreprise est obligatoire") String nom, @NotBlank(message = "L'adresse de l'entreprise est obligatoire") String adresse, boolean bloque, EntrepriseType type) {
        this.nom = nom;
        this.adresse = adresse;
        this.bloque = bloque;
        this.type = type;
    }

    public Entreprise() {
    }

    protected Entreprise(EntrepriseBuilder<?, ?> b) {
        super(b);
        this.nom = b.nom;
        this.adresse = b.adresse;
        this.bloque = b.bloque;
        this.type = b.type;
    }

    public static EntrepriseBuilder<?, ?> builder() {
        return new EntrepriseBuilderImpl();
    }
    // Getters et setters

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public EntrepriseType getType() {
        return type;
    }

    public void setType(EntrepriseType type) {
        this.type = type;
    }

    public boolean isBloque() {
        return bloque;
    }

    public void setBloque(boolean bloque) {
        this.bloque = bloque;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof Entreprise)) return false;
        final Entreprise other = (Entreprise) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$nom = this.getNom();
        final Object other$nom = other.getNom();
        if (this$nom == null ? other$nom != null : !this$nom.equals(other$nom)) return false;
        final Object this$adresse = this.getAdresse();
        final Object other$adresse = other.getAdresse();
        if (this$adresse == null ? other$adresse != null : !this$adresse.equals(other$adresse)) return false;
        if (this.isBloque() != other.isBloque()) return false;
        final Object this$type = this.getType();
        final Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof Entreprise;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $nom = this.getNom();
        result = result * PRIME + ($nom == null ? 43 : $nom.hashCode());
        final Object $adresse = this.getAdresse();
        result = result * PRIME + ($adresse == null ? 43 : $adresse.hashCode());
        result = result * PRIME + (this.isBloque() ? 79 : 97);
        final Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        return result;
    }

    public String toString() {
        return "Entreprise(nom=" + this.getNom() + ", adresse=" + this.getAdresse() + ", bloque=" + this.isBloque() + ", type=" + this.getType() + ")";
    }

    public static abstract class EntrepriseBuilder<C extends Entreprise, B extends EntrepriseBuilder<C, B>> extends BaseEntityBuilder<C, B> {
        private @NotBlank(message = "Le nom de l'entreprise est obligatoire") String nom;
        private @NotBlank(message = "L'adresse de l'entreprise est obligatoire") String adresse;
        private boolean bloque;
        private EntrepriseType type;

        public B nom(@NotBlank(message = "Le nom de l'entreprise est obligatoire") String nom) {
            this.nom = nom;
            return self();
        }

        public B adresse(@NotBlank(message = "L'adresse de l'entreprise est obligatoire") String adresse) {
            this.adresse = adresse;
            return self();
        }

        public B bloque(boolean bloque) {
            this.bloque = bloque;
            return self();
        }

        public B type(EntrepriseType type) {
            this.type = type;
            return self();
        }

        protected abstract B self();

        public abstract C build();

        public String toString() {
            return "Entreprise.EntrepriseBuilder(super=" + super.toString() + ", nom=" + this.nom + ", adresse=" + this.adresse + ", bloque=" + this.bloque + ", type=" + this.type + ")";
        }
    }

    private static final class EntrepriseBuilderImpl extends EntrepriseBuilder<Entreprise, EntrepriseBuilderImpl> {
        private EntrepriseBuilderImpl() {
        }

        protected EntrepriseBuilderImpl self() {
            return this;
        }

        public Entreprise build() {
            return new Entreprise(this);
        }
    }
}