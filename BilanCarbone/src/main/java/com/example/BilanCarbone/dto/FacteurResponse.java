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
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Boolean active;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long type;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String parent_type;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String creat_at;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String update_at;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String deleted;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long entreprise;

    public FacteurResponse(Long id, String nom_facteur, String unit, BigDecimal emissionFactor, Boolean active, Long type, String parent_type, String creat_at, String update_at, String deleted, Long entreprise) {
        this.id = id;
        this.nom_facteur = nom_facteur;
        this.unit = unit;
        this.emissionFactor = emissionFactor;
        this.active = active;
        this.type = type;
        this.parent_type = parent_type;
        this.creat_at = creat_at;
        this.update_at = update_at;
        this.deleted = deleted;
        this.entreprise = entreprise;
    }

    public FacteurResponse() {
    }

    protected FacteurResponse(FacteurResponseBuilder<?, ?> b) {
        this.id = b.id;
        this.nom_facteur = b.nom_facteur;
        this.unit = b.unit;
        this.emissionFactor = b.emissionFactor;
        this.active = b.active;
        this.type = b.type;
        this.parent_type = b.parent_type;
        this.creat_at = b.creat_at;
        this.update_at = b.update_at;
        this.deleted = b.deleted;
        this.entreprise = b.entreprise;
    }

    public static FacteurResponseBuilder<?, ?> builder() {
        return new FacteurResponseBuilderImpl();
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

    public String getParent_type() {
        return this.parent_type;
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

    public Long getEntreprise() {
        return this.entreprise;
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

    public void setParent_type(String parent_type) {
        this.parent_type = parent_type;
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

    public void setEntreprise(Long entreprise) {
        this.entreprise = entreprise;
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
        final Object this$parent_type = this.getParent_type();
        final Object other$parent_type = other.getParent_type();
        if (this$parent_type == null ? other$parent_type != null : !this$parent_type.equals(other$parent_type))
            return false;
        final Object this$creat_at = this.getCreat_at();
        final Object other$creat_at = other.getCreat_at();
        if (this$creat_at == null ? other$creat_at != null : !this$creat_at.equals(other$creat_at)) return false;
        final Object this$update_at = this.getUpdate_at();
        final Object other$update_at = other.getUpdate_at();
        if (this$update_at == null ? other$update_at != null : !this$update_at.equals(other$update_at)) return false;
        final Object this$deleted = this.getDeleted();
        final Object other$deleted = other.getDeleted();
        if (this$deleted == null ? other$deleted != null : !this$deleted.equals(other$deleted)) return false;
        final Object this$entreprise = this.getEntreprise();
        final Object other$entreprise = other.getEntreprise();
        if (this$entreprise == null ? other$entreprise != null : !this$entreprise.equals(other$entreprise))
            return false;
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
        final Object $parent_type = this.getParent_type();
        result = result * PRIME + ($parent_type == null ? 43 : $parent_type.hashCode());
        final Object $creat_at = this.getCreat_at();
        result = result * PRIME + ($creat_at == null ? 43 : $creat_at.hashCode());
        final Object $update_at = this.getUpdate_at();
        result = result * PRIME + ($update_at == null ? 43 : $update_at.hashCode());
        final Object $deleted = this.getDeleted();
        result = result * PRIME + ($deleted == null ? 43 : $deleted.hashCode());
        final Object $entreprise = this.getEntreprise();
        result = result * PRIME + ($entreprise == null ? 43 : $entreprise.hashCode());
        return result;
    }

    public String toString() {
        return "FacteurResponse(id=" + this.getId() + ", nom_facteur=" + this.getNom_facteur() + ", unit=" + this.getUnit() + ", emissionFactor=" + this.getEmissionFactor() + ", active=" + this.getActive() + ", type=" + this.getType() + ", parent_type=" + this.getParent_type() + ", creat_at=" + this.getCreat_at() + ", update_at=" + this.getUpdate_at() + ", deleted=" + this.getDeleted() + ", entreprise=" + this.getEntreprise() + ")";
    }

    public static abstract class FacteurResponseBuilder<C extends FacteurResponse, B extends FacteurResponseBuilder<C, B>> {
        private Long id;
        private String nom_facteur;
        private String unit;
        private BigDecimal emissionFactor;
        private Boolean active;
        private Long type;
        private String parent_type;
        private String creat_at;
        private String update_at;
        private String deleted;
        private Long entreprise;

        public B id(Long id) {
            this.id = id;
            return self();
        }

        public B nom_facteur(String nom_facteur) {
            this.nom_facteur = nom_facteur;
            return self();
        }

        public B unit(String unit) {
            this.unit = unit;
            return self();
        }

        public B emissionFactor(BigDecimal emissionFactor) {
            this.emissionFactor = emissionFactor;
            return self();
        }

        public B active(Boolean active) {
            this.active = active;
            return self();
        }

        public B type(Long type) {
            this.type = type;
            return self();
        }

        public B parent_type(String parent_type) {
            this.parent_type = parent_type;
            return self();
        }

        public B creat_at(String creat_at) {
            this.creat_at = creat_at;
            return self();
        }

        public B update_at(String update_at) {
            this.update_at = update_at;
            return self();
        }

        public B deleted(String deleted) {
            this.deleted = deleted;
            return self();
        }

        public B entreprise(Long entreprise) {
            this.entreprise = entreprise;
            return self();
        }

        protected abstract B self();

        public abstract C build();

        public String toString() {
            return "FacteurResponse.FacteurResponseBuilder(id=" + this.id + ", nom_facteur=" + this.nom_facteur + ", unit=" + this.unit + ", emissionFactor=" + this.emissionFactor + ", active=" + this.active + ", type=" + this.type + ", parent_type=" + this.parent_type + ", creat_at=" + this.creat_at + ", update_at=" + this.update_at + ", deleted=" + this.deleted + ", entreprise=" + this.entreprise + ")";
        }
    }

    private static final class FacteurResponseBuilderImpl extends FacteurResponseBuilder<FacteurResponse, FacteurResponseBuilderImpl> {
        private FacteurResponseBuilderImpl() {
        }

        protected FacteurResponseBuilderImpl self() {
            return this;
        }

        public FacteurResponse build() {
            return new FacteurResponse(this);
        }
    }
}