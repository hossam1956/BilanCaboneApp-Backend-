package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

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
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
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

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "entreprise_id")
    private Entreprise entreprise;

}