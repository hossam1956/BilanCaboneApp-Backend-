package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.DataInfo;
import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * @author CHALABI Hossam
 **/
@Repository
public interface DataInfoRepository extends JpaRepository<DataInfo,Long> {
    Optional<DataInfo> findByIdFacteurAndIdUtilisateurAndDate(Long idFacteur, String idUtilisateur, LocalDate date);
    List<DataInfo> findAllByIdUtilisateur(String idUtilisateur);
    List<DataInfo> findAllByEntreprise(Entreprise entreprise);
    List<DataInfo> findAllByIdFacteur(Long idFacteur);

}
