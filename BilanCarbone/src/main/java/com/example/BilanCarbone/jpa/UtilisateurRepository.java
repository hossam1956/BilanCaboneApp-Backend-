package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author CHALABI Hossam
 **/
public interface UtilisateurRepository extends JpaRepository<Utilisateur,String> {
}
