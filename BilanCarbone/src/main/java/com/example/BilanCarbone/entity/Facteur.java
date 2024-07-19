package com.example.BilanCarbone.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


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
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
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
}