package com.example.BilanCarbone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.math.BigDecimal;

/**
 * @author Oussama
 **/
public class FacteurResponse {
    private Long id;
    private String nom_facteur;
    private String unit;
    private BigDecimal emissionFactor;
    private Boolean active;
    private Long type;
    private String creat_at;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String update_at;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String deleted;


    public FacteurResponse(Long id, String nom_facteur, String unit, BigDecimal emissionFactor, Boolean active, Long type, String creat_at, String update_at, String deleted) {
        this.id = id;
        this.nom_facteur = nom_facteur;
        this.unit = unit;
        this.emissionFactor = emissionFactor;
        this.active = active;
        this.type = type;
        this.creat_at = creat_at;
        this.update_at = update_at;
        this.deleted = deleted;
    }

    public FacteurResponse() {
    }

    public static FacteurResponseBuilder builder() {
        return new FacteurResponseBuilder();
    }

    public Long getId() {
        return this.id;
    }

    public String getNom_facteur() {
        return this.nom_facteur;
    }

    public String getUnit() {
        return this.unit;
    }

    public BigDecimal getEmissionFactor() {
        return this.emissionFactor;
    }

    public Boolean getActive() {
        return this.active;
    }

    public Long getType() {
        return this.type;
    }

    public String getCreat_at() {
        return this.creat_at;
    }

    public String getUpdate_at() {
        return this.update_at;
    }

    public String getDeleted() {
        return this.deleted;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setNom_facteur(String nom_facteur) {
        this.nom_facteur = nom_facteur;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public void setEmissionFactor(BigDecimal emissionFactor) {
        this.emissionFactor = emissionFactor;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public void setCreat_at(String creat_at) {
        this.creat_at = creat_at;
    }

    public void setUpdate_at(String update_at) {
        this.update_at = update_at;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof FacteurResponse)) return false;
        final FacteurResponse other = (FacteurResponse) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$id = this.getId();
        final Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final Object this$nom_facteur = this.getNom_facteur();
        final Object other$nom_facteur = other.getNom_facteur();
        if (this$nom_facteur == null ? other$nom_facteur != null : !this$nom_facteur.equals(other$nom_facteur))
            return false;
        final Object this$unit = this.getUnit();
        final Object other$unit = other.getUnit();
        if (this$unit == null ? other$unit != null : !this$unit.equals(other$unit)) return false;
        final Object this$emissionFactor = this.getEmissionFactor();
        final Object other$emissionFactor = other.getEmissionFactor();
        if (this$emissionFactor == null ? other$emissionFactor != null : !this$emissionFactor.equals(other$emissionFactor))
            return false;
        final Object this$active = this.getActive();
        final Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final Object this$type = this.getType();
        final Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final Object this$creat_at = this.getCreat_at();
        final Object other$creat_at = other.getCreat_at();
        if (this$creat_at == null ? other$creat_at != null : !this$creat_at.equals(other$creat_at)) return false;
        final Object this$update_at = this.getUpdate_at();
        final Object other$update_at = other.getUpdate_at();
        if (this$update_at == null ? other$update_at != null : !this$update_at.equals(other$update_at)) return false;
        final Object this$deleted = this.getDeleted();
        final Object other$deleted = other.getDeleted();
        if (this$deleted == null ? other$deleted != null : !this$deleted.equals(other$deleted)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof FacteurResponse;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final Object $nom_facteur = this.getNom_facteur();
        result = result * PRIME + ($nom_facteur == null ? 43 : $nom_facteur.hashCode());
        final Object $unit = this.getUnit();
        result = result * PRIME + ($unit == null ? 43 : $unit.hashCode());
        final Object $emissionFactor = this.getEmissionFactor();
        result = result * PRIME + ($emissionFactor == null ? 43 : $emissionFactor.hashCode());
        final Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final Object $creat_at = this.getCreat_at();
        result = result * PRIME + ($creat_at == null ? 43 : $creat_at.hashCode());
        final Object $update_at = this.getUpdate_at();
        result = result * PRIME + ($update_at == null ? 43 : $update_at.hashCode());
        final Object $deleted = this.getDeleted();
        result = result * PRIME + ($deleted == null ? 43 : $deleted.hashCode());
        return result;
    }

    public String toString() {
        return "FacteurResponse(id=" + this.getId() + ", nom_facteur=" + this.getNom_facteur() + ", unit=" + this.getUnit() + ", emissionFactor=" + this.getEmissionFactor() + ", active=" + this.getActive() + ", type=" + this.getType() + ", creat_at=" + this.getCreat_at() + ", update_at=" + this.getUpdate_at() + ", deleted=" + this.getDeleted() + ")";
    }

    public static class FacteurResponseBuilder {
        private Long id;
        private String nom_facteur;
        private String unit;
        private BigDecimal emissionFactor;
        private Boolean active;
        private Long type;
        private String creat_at;
        private String update_at;
        private String deleted;

        FacteurResponseBuilder() {
        }

        public FacteurResponseBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public FacteurResponseBuilder nom_facteur(String nom_facteur) {
            this.nom_facteur = nom_facteur;
            return this;
        }

        public FacteurResponseBuilder unit(String unit) {
            this.unit = unit;
            return this;
        }

        public FacteurResponseBuilder emissionFactor(BigDecimal emissionFactor) {
            this.emissionFactor = emissionFactor;
            return this;
        }

        public FacteurResponseBuilder active(Boolean active) {
            this.active = active;
            return this;
        }

        public FacteurResponseBuilder type(Long type) {
            this.type = type;
            return this;
        }

        public FacteurResponseBuilder creat_at(String creat_at) {
            this.creat_at = creat_at;
            return this;
        }

        public FacteurResponseBuilder update_at(String update_at) {
            this.update_at = update_at;
            return this;
        }

        public FacteurResponseBuilder deleted(String deleted) {
            this.deleted = deleted;
            return this;
        }

        public FacteurResponse build() {
            return new FacteurResponse(this.id, this.nom_facteur, this.unit, this.emissionFactor, this.active, this.type, this.creat_at, this.update_at, this.deleted);
        }

        public String toString() {
            return "FacteurResponse.FacteurResponseBuilder(id=" + this.id + ", nom_facteur=" + this.nom_facteur + ", unit=" + this.unit + ", emissionFactor=" + this.emissionFactor + ", active=" + this.active + ", type=" + this.type + ", creat_at=" + this.creat_at + ", update_at=" + this.update_at + ", deleted=" + this.deleted + ")";
        }
    }
}
