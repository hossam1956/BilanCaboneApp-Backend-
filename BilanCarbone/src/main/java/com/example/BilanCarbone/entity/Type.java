package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;

import java.util.List;


/**
 * Représente un type dans le système.
 * <p>
 * La classe {@code Type} est une entité JPA qui représente un type avec une relation hiérarchique (un type peut avoir un type parent),
 * un état actif ou inactif, et une liste de facteurs associés.
 * </p>
 *
 * @author Oussama
 */
@Entity
public class Type extends BaseEntity {

    /**
     * Le nom du type.
     */
    private String name;

    /**
     * Le type parent de ce type, s'il existe.
     * <p>
     * Cette relation est définie avec une clé étrangère nommée {@code parent_id}.
     * </p>
     */
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Type parent;

    /**
     * Indique si le type est actif ou non.
     */
    private Boolean active;

    /**
     * La liste des facteurs associés à ce type.
     * <p>
     * Les facteurs sont liés à ce type et sont automatiquement supprimés si ce type est supprimé (cascade de suppression).
     * </p>
     */
    @OneToMany(mappedBy = "type", cascade = CascadeType.ALL)
    private List<Facteur> facteurs;

    public Type(String name, Type parent, Boolean active, List<Facteur> facteurs) {
        this.name = name;
        this.parent = parent;
        this.active = active;
        this.facteurs = facteurs;
    }

    public Type() {
    }

    protected Type(TypeBuilder<?, ?> b) {
        super(b);
        this.name = b.name;
        this.parent = b.parent;
        this.active = b.active;
        this.facteurs = b.facteurs;
    }

    public static TypeBuilder<?, ?> builder() {
        return new TypeBuilderImpl();
    }

    public String getName() {
        return this.name;
    }

    public Type getParent() {
        return this.parent;
    }

    public Boolean getActive() {
        return this.active;
    }

    public List<Facteur> getFacteurs() {
        return this.facteurs;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setParent(Type parent) {
        this.parent = parent;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public void setFacteurs(List<Facteur> facteurs) {
        this.facteurs = facteurs;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof Type)) return false;
        final Type other = (Type) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$name = this.getName();
        final Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final Object this$parent = this.getParent();
        final Object other$parent = other.getParent();
        if (this$parent == null ? other$parent != null : !this$parent.equals(other$parent)) return false;
        final Object this$active = this.getActive();
        final Object other$active = other.getActive();
        if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
        final Object this$facteurs = this.getFacteurs();
        final Object other$facteurs = other.getFacteurs();
        if (this$facteurs == null ? other$facteurs != null : !this$facteurs.equals(other$facteurs)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof Type;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final Object $parent = this.getParent();
        result = result * PRIME + ($parent == null ? 43 : $parent.hashCode());
        final Object $active = this.getActive();
        result = result * PRIME + ($active == null ? 43 : $active.hashCode());
        final Object $facteurs = this.getFacteurs();
        result = result * PRIME + ($facteurs == null ? 43 : $facteurs.hashCode());
        return result;
    }

    public String toString() {
        return "Type(name=" + this.getName() + ", parent=" + this.getParent() + ", active=" + this.getActive() + ", facteurs=" + this.getFacteurs() + ")";
    }

    public static abstract class TypeBuilder<C extends Type, B extends TypeBuilder<C, B>> extends BaseEntityBuilder<C, B> {
        private String name;
        private Type parent;
        private Boolean active;
        private List<Facteur> facteurs;

        public B name(String name) {
            this.name = name;
            return self();
        }

        public B parent(Type parent) {
            this.parent = parent;
            return self();
        }

        public B active(Boolean active) {
            this.active = active;
            return self();
        }

        public B facteurs(List<Facteur> facteurs) {
            this.facteurs = facteurs;
            return self();
        }

        protected abstract B self();

        public abstract C build();

        public String toString() {
            return "Type.TypeBuilder(super=" + super.toString() + ", name=" + this.name + ", parent=" + this.parent + ", active=" + this.active + ", facteurs=" + this.facteurs + ")";
        }
    }

    private static final class TypeBuilderImpl extends TypeBuilder<Type, TypeBuilderImpl> {
        private TypeBuilderImpl() {
        }

        protected TypeBuilderImpl self() {
            return this;
        }

        public Type build() {
            return new Type(this);
        }
    }
}