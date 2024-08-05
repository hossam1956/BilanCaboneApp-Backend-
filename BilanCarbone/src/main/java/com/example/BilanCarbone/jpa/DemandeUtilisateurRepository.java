package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.DemandeUtilisateur;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author CHALABI Hossam
 **/

public interface DemandeUtilisateurRepository extends JpaRepository<DemandeUtilisateur,Long> {

    Page<DemandeUtilisateur> findAllByNomContainingIgnoreCase(String name, Pageable page);
}
