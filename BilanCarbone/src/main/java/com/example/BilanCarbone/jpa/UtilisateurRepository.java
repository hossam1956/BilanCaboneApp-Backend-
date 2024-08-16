package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author CHALABI Hossam
 **/
public interface UtilisateurRepository extends JpaRepository<Utilisateur,String> {
    List<Utilisateur> findByEntreprise(Entreprise entreprise);

}
