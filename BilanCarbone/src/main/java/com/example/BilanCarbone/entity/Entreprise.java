package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Entity
@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Entreprise extends BaseEntity {

    @NotBlank(message = "Le nom de l'entreprise est obligatoire")
    private String nom;

    @NotBlank(message = "L'adresse de l'entreprise est obligatoire")
    private String adresse;

    private boolean bloque;

    @Enumerated(EnumType.STRING)
    private EntrepriseType type;
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
}