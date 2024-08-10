package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.DemandeUtilisateur;

import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author CHALABI Hossam
 **/

public interface DemandeUtilisateurRepository extends JpaRepository<DemandeUtilisateur,Long> {

    Page<DemandeUtilisateur> findAllByNomContainingIgnoreCase(String name, Pageable page);
    Page<DemandeUtilisateur> findAllByEntreprise(Entreprise entreprise,Pageable page);
}
