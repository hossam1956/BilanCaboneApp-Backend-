package com.example.BilanCarbone.service;

import com.example.BilanCarbone.dto.DataInfoRequest;
import com.example.BilanCarbone.entity.DataInfo;
import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Utilisateur;
import com.example.BilanCarbone.jpa.DataInfoRepository;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Service pour la gestion des objets DataInfo.
 * Ce service contient des méthodes pour insérer, mettre à jour, récupérer et supprimer des DataInfo.
 *
 * @author CHALABI Hossam
 */
@Service
public class DataInfoService {

    @Autowired
    private FacteurRepository facteurRepository;
    @Autowired
    private UtilisateurRepository utilisateurRepository;
    @Autowired
    private DataInfoRepository dataInfoRepository;

    /**
     * Insère un nouvel objet DataInfo dans la base de données.
     * Si un DataInfo avec les mêmes facteur, utilisateur, et date existe déjà, il est supprimé avant l'insertion.
     *
     * @param dataInfoRequest Les informations de la demande pour créer un DataInfo.
     * @return Le DataInfo nouvellement créé et sauvegardé.
     * @throws RuntimeException si le facteur, l'utilisateur, ou la date n'est pas valide.
     */
    public DataInfo insertDataInfo(DataInfoRequest dataInfoRequest) {
        Optional<DataInfo> existingDataInfo = dataInfoRepository.findByIdFacteurAndIdUtilisateurAndDate(
                dataInfoRequest.idFacteur(),
                dataInfoRequest.idUtilisateur(),
                LocalDate.parse(dataInfoRequest.date())
        );
        existingDataInfo.ifPresent(dataInfo -> dataInfoRepository.delete(dataInfo));

        Facteur facteur = facteurRepository.findById(dataInfoRequest.idFacteur())
                .orElseThrow(() -> new RuntimeException("Facteur avec l'ID " + dataInfoRequest.idFacteur() + " introuvable."));
        Utilisateur utilisateur = utilisateurRepository.findById(dataInfoRequest.idUtilisateur())
                .orElseThrow(() -> new RuntimeException("Utilisateur avec l'ID " + dataInfoRequest.idUtilisateur() + " introuvable."));
        Entreprise entrepriseOfUtilisateur = utilisateur.getEntreprise();

        boolean dateVerification = LocalDate.parse(dataInfoRequest.date()).isAfter(LocalDate.now());
        if (!dateVerification) {
            try {
                Double emission = dataInfoRequest.quantity() * facteur.getEmissionFactor().doubleValue();
                DataInfo dataInfo = DataInfo.builder()
                        .idUtilisateur(dataInfoRequest.idUtilisateur())
                        .idFacteur(dataInfoRequest.idFacteur())
                        .entreprise(entrepriseOfUtilisateur)
                        .date(LocalDate.parse(dataInfoRequest.date()))
                        .quantity(dataInfoRequest.quantity())
                        .emission(emission)
                        .build();

                return dataInfoRepository.save(dataInfo);
            } catch (RuntimeException e) {
                throw new RuntimeException("L'insertion de DataInfo a échoué : " + e);
            }
        } else {
            throw new RuntimeException("La date n'est pas valide.");
        }
    }

    /**
     * Met à jour la quantité et l'émission d'un DataInfo existant.
     *
     * @param dataInfoId L'ID du DataInfo à mettre à jour.
     * @param quantity La nouvelle quantité à définir.
     * @return Le DataInfo mis à jour.
     * @throws RuntimeException si le DataInfo ou le Facteur associé est introuvable.
     */
    public DataInfo updateDataInfo(Long dataInfoId, Double quantity) {
        DataInfo existingDataInfo = dataInfoRepository.findById(dataInfoId)
                .orElseThrow(() -> new RuntimeException("DataInfo avec l'ID " + dataInfoId + " introuvable."));

        Facteur facteur = facteurRepository.findById(existingDataInfo.getIdFacteur())
                .orElseThrow(() -> new RuntimeException("Facteur avec l'ID " + existingDataInfo.getIdFacteur() + " introuvable."));

        Double emission = quantity * facteur.getEmissionFactor().doubleValue();

        existingDataInfo.setQuantity(quantity);
        existingDataInfo.setEmission(emission);

        return dataInfoRepository.save(existingDataInfo);
    }

    /**
     * Récupère tous les DataInfo associés à une entreprise, basée sur l'ID d'un utilisateur.
     *
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @return La liste de tous les DataInfo de l'entreprise de l'utilisateur.
     * @throws RuntimeException si l'utilisateur est introuvable.
     */
    public List<DataInfo> getAllDataInfoByEntreprise(String IdUtilisateur) {
        Utilisateur utilisateur = utilisateurRepository.findById(IdUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur avec l'ID " + IdUtilisateur + " introuvable."));
        Entreprise entrepriseOfUtilisateur = utilisateur.getEntreprise();
        return dataInfoRepository.findAllByEntreprise(entrepriseOfUtilisateur);
    }

    /**
     * Récupère tous les DataInfo associés à un utilisateur spécifique.
     *
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @return La liste de tous les DataInfo associés à cet utilisateur.
     */
    public List<DataInfo> getDataInfoByIdUtilisateur(String IdUtilisateur) {
        return dataInfoRepository.findAllByIdUtilisateur(IdUtilisateur);
    }

    /**
     * Supprime un DataInfo spécifique basé sur l'ID du Facteur, l'ID de l'utilisateur, et la date.
     *
     * @param IdFacteur L'ID du Facteur.
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @param date La date associée au DataInfo.
     * @throws RuntimeException si le DataInfo correspondant n'est pas trouvé.
     */
    public void uncheckFacteur(Long IdFacteur, String IdUtilisateur, LocalDate date) {
        List<DataInfo> dataInfoByFacteurs = dataInfoRepository.findAllByIdFacteur(IdFacteur);
        DataInfo dataInfo = dataInfoByFacteurs.stream()
                .filter(dataInfoByFacteur -> dataInfoByFacteur.getIdUtilisateur().equals(IdUtilisateur) &&
                        dataInfoByFacteur.getDate().equals(date))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("DataInfo avec le Facteur ID " + IdFacteur + ", Utilisateur ID " + IdUtilisateur + " et la date " + date + " introuvable."));
        dataInfoRepository.delete(dataInfo);
    }

    /**
     * Supprime un DataInfo spécifique basé sur l'ID du Facteur.
     *
     * @param IdFacteur L'ID du Facteur.
     * @throws RuntimeException si le DataInfo correspondant n'est pas trouvé.
     */
    public void deleteDataByIdFateur(Long IdFacteur) {
        List<DataInfo> dataInfoByFacteurs = dataInfoRepository.findAllByIdFacteur(IdFacteur);
        try{
            for(DataInfo dataInfoByFacteur:dataInfoByFacteurs){
                dataInfoRepository.delete(dataInfoByFacteur);
            }
        }
        catch (RuntimeException e){
            throw new RuntimeException("Delete dataInfo by idFacteur Failed :  "+e);
        }


    }

    /**
     * Récupère la quantité d'un Facteur spécifique associée à un utilisateur à une date donnée.
     *
     * @param IdFacteur L'ID du Facteur.
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @param date La date associée au DataInfo.
     * @return La quantité associée, ou null si aucun DataInfo correspondant n'est trouvé.
     */
    public Double quantityOfFacteurByUtilisateurByDate(Long IdFacteur, String IdUtilisateur, LocalDate date) {
        List<DataInfo> dataInfoByFacteurs = dataInfoRepository.findAllByIdFacteur(IdFacteur);
        Optional<DataInfo> dataInfo = dataInfoByFacteurs.stream()
                .filter(dataInfoByFacteur -> dataInfoByFacteur.getIdUtilisateur().equals(IdUtilisateur) &&
                        dataInfoByFacteur.getDate().equals(date))
                .findFirst();
        return dataInfo.map(DataInfo::getQuantity).orElse(null);
    }
}
