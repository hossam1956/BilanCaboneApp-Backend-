package com.example.BilanCarbone.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

/**
 * Classe Facteur représentant un facteur utilisé dans les calculs de l'empreinte carbone. 
 */

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor


public class Facteur {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	/**
     * Nom du facteur. C'est un nom descriptif utilisé pour identifier le facteur.
     */
	@Column
	private String name;
	
	/**
     * Unité de mesure du facteur.
     */
	@Column
	private String unit;
	
	/**
     * Valeur du facteur d'émission.
     * Cela représente la quantité d'émissions par unité d'activité (par exemple, kg de CO2 par litre).
     */
	@Column
	private Double emissiomFactor;
	
	/**
     * Horodatage indiquant quand ce facteur a été créé.
     * Cela est utile pour le suivi et l'audit.
     */
	@Column
	private LocalDateTime createAt;
}
