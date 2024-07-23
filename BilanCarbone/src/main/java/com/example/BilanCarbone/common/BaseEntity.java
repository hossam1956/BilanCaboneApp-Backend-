package com.example.BilanCarbone.common;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;


/**
 * Classe de base pour toutes les entités du modèle de données.
 * <p>
 * La classe {@code BaseEntity} fournit des champs communs à toutes les entités, incluant un identifiant unique,
 * des informations de création et de modification, ainsi qu'un champ pour gérer les suppressions logiques.
 * Elle est annotée avec {@code @MappedSuperclass} pour être héritée par d'autres entités sans être elle-même une entité persistante.
 * </p>
 *
 * @author Oussama
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity {

    /**
     * Identifiant unique de l'entité, généré automatiquement.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Date et heure de création de l'entité, définie automatiquement lors de la persistance.
     */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdDate;

    /**
     * Date et heure de la dernière modification de l'entité, mise à jour automatiquement lors des modifications.
     */
    @UpdateTimestamp
    @Column(insertable = false)
    private LocalDateTime lastModifiedDate;

    /**
     * Date et heure de suppression logique de l'entité. Si ce champ est non nul, l'entité est considérée comme supprimée.
     * La valeur par défaut est {@code null}.
     */
    @Column(columnDefinition = "timestamp default null")
    private LocalDateTime isDeleted;
}
