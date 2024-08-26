package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

/**
 * Représente un utilisateur dans le système.
 *
 * @author @CHALABI Hossam
 */
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Utilisateur {

    @Id
    private String id;

    @ManyToOne
    @JoinColumn(name = "entreprise_id", nullable = false)
    private Entreprise entreprise;
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdDate;

    /**
     * Date et heure de la dernière modification de l'entité, mise à jour automatiquement lors des modifications.
     */
    @UpdateTimestamp
    @Column(insertable = false)
    private LocalDateTime UpdateDate;

    /**
     * Date et heure de suppression logique de l'entité. Si ce champ est non nul, l'entité est considérée comme supprimée.
     * La valeur par défaut est {@code null}.
     */
    @Column(columnDefinition = "timestamp default null")
    private LocalDateTime isDeleted;
}
