package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;

import java.math.BigDecimal;


/**
 * Représente un facteur dans le système.
 * <p>
 * La classe {@code Facteur} est une entité JPA qui représente un facteur avec un nom, une unité, un facteur d'émission,
 * et une relation avec un type. Un facteur peut également être actif ou inactif.
 * </p>
 *
 * @author Oussama
 */
@Entity
public class Facteur extends BaseEntity {

	/**
	 * Le nom du facteur.
	 */
	private String nom;

	/**
	 * L'unité de mesure du facteur.
	 * <p>
	 * Les unités sont définies par l'énumération {@code Unite}.
	 * </p>
	 */
	@Enumerated(EnumType.STRING)
	private Unite unit;

	/**
	 * Le facteur d'émission associé.
	 * <p>
	 * Ce champ est de type {@code BigDecimal} pour permettre une précision élevée dans les valeurs numériques.
	 * </p>
	 */
	private BigDecimal emissionFactor;

	/**
	 * Le type auquel ce facteur est associé.
	 * <p>
	 * La relation est définie avec une clé étrangère nommée {@code type_id}.
	 * </p>
	 */
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "type_id")
	private Type type;

	/**
	 * Indique si le facteur est actif ou non.
	 */
	private Boolean active;

	public Facteur(String nom, Unite unit, BigDecimal emissionFactor, Type type, Boolean active) {
		this.nom = nom;
		this.unit = unit;
		this.emissionFactor = emissionFactor;
		this.type = type;
		this.active = active;
	}

	public Facteur() {
	}

	protected Facteur(FacteurBuilder<?, ?> b) {
		super(b);
		this.nom = b.nom;
		this.unit = b.unit;
		this.emissionFactor = b.emissionFactor;
		this.type = b.type;
		this.active = b.active;
	}

	public static FacteurBuilder<?, ?> builder() {
		return new FacteurBuilderImpl();
	}

	public String getNom() {
		return this.nom;
	}

	public Unite getUnit() {
		return this.unit;
	}

	public BigDecimal getEmissionFactor() {
		return this.emissionFactor;
	}

	public Type getType() {
		return this.type;
	}

	public Boolean getActive() {
		return this.active;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public void setUnit(Unite unit) {
		this.unit = unit;
	}

	public void setEmissionFactor(BigDecimal emissionFactor) {
		this.emissionFactor = emissionFactor;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public boolean equals(final Object o) {
		if (o == this) return true;
		if (!(o instanceof Facteur)) return false;
		final Facteur other = (Facteur) o;
		if (!other.canEqual((Object) this)) return false;
		final Object this$nom = this.getNom();
		final Object other$nom = other.getNom();
		if (this$nom == null ? other$nom != null : !this$nom.equals(other$nom)) return false;
		final Object this$unit = this.getUnit();
		final Object other$unit = other.getUnit();
		if (this$unit == null ? other$unit != null : !this$unit.equals(other$unit)) return false;
		final Object this$emissionFactor = this.getEmissionFactor();
		final Object other$emissionFactor = other.getEmissionFactor();
		if (this$emissionFactor == null ? other$emissionFactor != null : !this$emissionFactor.equals(other$emissionFactor))
			return false;
		final Object this$type = this.getType();
		final Object other$type = other.getType();
		if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
		final Object this$active = this.getActive();
		final Object other$active = other.getActive();
		if (this$active == null ? other$active != null : !this$active.equals(other$active)) return false;
		return true;
	}

	protected boolean canEqual(final Object other) {
		return other instanceof Facteur;
	}

	public int hashCode() {
		final int PRIME = 59;
		int result = 1;
		final Object $nom = this.getNom();
		result = result * PRIME + ($nom == null ? 43 : $nom.hashCode());
		final Object $unit = this.getUnit();
		result = result * PRIME + ($unit == null ? 43 : $unit.hashCode());
		final Object $emissionFactor = this.getEmissionFactor();
		result = result * PRIME + ($emissionFactor == null ? 43 : $emissionFactor.hashCode());
		final Object $type = this.getType();
		result = result * PRIME + ($type == null ? 43 : $type.hashCode());
		final Object $active = this.getActive();
		result = result * PRIME + ($active == null ? 43 : $active.hashCode());
		return result;
	}

	public String toString() {
		return "Facteur(nom=" + this.getNom() + ", unit=" + this.getUnit() + ", emissionFactor=" + this.getEmissionFactor() + ", type=" + this.getType() + ", active=" + this.getActive() + ")";
	}

	public static abstract class FacteurBuilder<C extends Facteur, B extends FacteurBuilder<C, B>> extends BaseEntityBuilder<C, B> {
		private String nom;
		private Unite unit;
		private BigDecimal emissionFactor;
		private Type type;
		private Boolean active;

		public B nom(String nom) {
			this.nom = nom;
			return self();
		}

		public B unit(Unite unit) {
			this.unit = unit;
			return self();
		}

		public B emissionFactor(BigDecimal emissionFactor) {
			this.emissionFactor = emissionFactor;
			return self();
		}

		public B type(Type type) {
			this.type = type;
			return self();
		}

		public B active(Boolean active) {
			this.active = active;
			return self();
		}

		protected abstract B self();

		public abstract C build();

		public String toString() {
			return "Facteur.FacteurBuilder(super=" + super.toString() + ", nom=" + this.nom + ", unit=" + this.unit + ", emissionFactor=" + this.emissionFactor + ", type=" + this.type + ", active=" + this.active + ")";
		}
	}

	private static final class FacteurBuilderImpl extends FacteurBuilder<Facteur, FacteurBuilderImpl> {
		private FacteurBuilderImpl() {
		}

		protected FacteurBuilderImpl self() {
			return this;
		}

		public Facteur build() {
			return new Facteur(this);
		}
	}
}