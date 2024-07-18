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
 * Classe Facteur représentant un facteur utilisé dans les calculs de l'empreinte carbone. 
 */

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Facteur extends BaseEntity {
	/**
     * Nom du facteur. C'est un nom descriptif utilisé pour identifier le facteur.
     */
	private String nom;
	
	/**
     * Unité de mesure du facteur.
     */
	@Enumerated(EnumType.STRING)
	private Unite unit;
	
	/**
     * Valeur du facteur d'émission.
     * Cela représente la quantité d'émissions par unité d'activité (par exemple, kg de CO2 par litre).
     */
	private BigDecimal emissionFactor;
	
	/**
     * Horodatage indiquant quand ce facteur a été créé.
     * Cela est utile pour le suivi et l'audit.
     */
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "type_id")
	private Type type;

	private Boolean active ;
}