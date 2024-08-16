package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.DemandeUtilisateur;

import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author CHALABI Hossam
 **/

public interface DemandeUtilisateurRepository extends JpaRepository<DemandeUtilisateur,Long> {

    Page<DemandeUtilisateur> findAllByNomContainingIgnoreCase(String name, Pageable page);
    Page<DemandeUtilisateur> findAllByEntreprise(Entreprise entreprise,Pageable page);
    default Page<DemandeUtilisateur> findAllByNomContainingIgnoreCaseFilterByEntreprise(String name,Entreprise entreprise, Pageable page){
        Page<DemandeUtilisateur> userBySearch=findAllByNomContainingIgnoreCase(name,page);
        List<DemandeUtilisateur> users=userBySearch.stream()
                .filter(user->user.getEntreprise()==entreprise)
                .collect(Collectors.toList());
        return  new PageImpl<>(users,page,users.size());

    }
}
