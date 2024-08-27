package com.example.BilanCarbone.service;

import com.example.BilanCarbone.dto.DataInfoRequest;
import com.example.BilanCarbone.entity.DataInfo;
import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Utilisateur;
import com.example.BilanCarbone.jpa.DataInfoRepository;
import com.example.BilanCarbone.jpa.EntrepriseRepository;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

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
    @Autowired
    private EntrepriseRepository entrepriseRepository;
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

    /**
     * Récupère les informations d'émission pour une entreprise donnée entre deux dates spécifiées.
     * La fonction filtre les données en fonction de l'entreprise, de la date de début et de la date de fin.
     * Si la date de fin est après la date d'aujourd'hui, elle est ajustée à aujourd'hui.
     * Les émissions sont regroupées par date et la somme des émissions est calculée pour chaque date.
     * Le résultat est ensuite trié par date et renvoyé sous forme de Map avec les dates comme clés et les sommes des émissions comme valeurs.
     *
     * @param idEntreprise L'identifiant de l'entreprise pour laquelle les données doivent être récupérées.
     * @param firstDate La date de début de la période pour laquelle les données doivent être récupérées.
     * @param lastDate La date de fin de la période pour laquelle les données doivent être récupérées. Si cette date est après la date d'aujourd'hui, elle est ajustée à aujourd'hui.
     * @return Une Map contenant les dates comme clés et la somme des émissions pour chaque date comme valeurs, triées par date.
     * @throws RuntimeException Si l'entreprise avec l'ID spécifié n'est pas trouvée.
     */
    public Map<LocalDate,Double> getDataInfoOfEntreprise(Long idEntreprise,LocalDate firstDate,LocalDate lastDate){
        Optional<Entreprise> entreprise=entrepriseRepository.findById(idEntreprise);
        if (entreprise.isPresent()) {
            List<DataInfo> dataInfos = dataInfoRepository.findAllByEntreprise(entreprise.get());

            LocalDate today = LocalDate.now();
            if (lastDate.isAfter(today)) {
                lastDate = today;
            }
            LocalDate finalLastDate = lastDate;
            Map<LocalDate, Double> emissionSum = dataInfos.stream()
                    .filter(dataInfo -> !dataInfo.getDate().isBefore(firstDate) && !dataInfo.getDate().isAfter(finalLastDate))
                    .collect(Collectors.groupingBy(
                            DataInfo::getDate,
                            Collectors.summingDouble(DataInfo::getEmission)
                    ));

            return emissionSum.entrySet().stream()
                    .sorted(Map.Entry.comparingByKey())
                    .collect(Collectors.toMap(
                            Map.Entry::getKey,
                            Map.Entry::getValue,
                            (e1, e2) -> e1,
                            LinkedHashMap::new
                    ));
        } else {
            throw new RuntimeException("Entreprise not found with ID: " + idEntreprise);
        }

    }
}
