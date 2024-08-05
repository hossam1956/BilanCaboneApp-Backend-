package com.example.BilanCarbone.dto;

import com.example.BilanCarbone.entity.DemandeUtilisateur;
import com.example.BilanCarbone.entity.Entreprise;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Data Transfer Object (DTO) pour la classe DemandeUtilisateur.
 *
 * Cette classe est utilisée pour transférer les données d'une demande utilisateur.
 *
 * @author @CHALABI Hossam
 */
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class DemandeUtilisateurDTO {

    private Long id;

    private String nomUtilisateur;

    private String email;

    private String prenom;

    private String nom;

    private LocalDateTime sendDate;

    private String role;

    private Long entreprise_id;

    private String password;

    /**
     * Convertit une instance de DemandeUtilisateur en DemandeUtilisateurDTO.
     *
     * @param demandeUtilisateur l'objet DemandeUtilisateur à convertir
     * @return une instance de DemandeUtilisateurDTO contenant les mêmes données que l'objet DemandeUtilisateur
     */
    public static DemandeUtilisateurDTO toDTO(DemandeUtilisateur demandeUtilisateur) {
        return DemandeUtilisateurDTO.builder()
                .id(demandeUtilisateur.getId())
                .nomUtilisateur(demandeUtilisateur.getNomUtilisateur())
                .email(demandeUtilisateur.getEmail())
                .prenom(demandeUtilisateur.getPrenom())
                .nom(demandeUtilisateur.getNom())
                .sendDate(demandeUtilisateur.getSendDate())
                .role(demandeUtilisateur.getRole())
                .password(demandeUtilisateur.getPassword())
                .entreprise_id(demandeUtilisateur.getEntreprise() != null ? demandeUtilisateur.getEntreprise().getId() : null)
                .build();
    }
}
