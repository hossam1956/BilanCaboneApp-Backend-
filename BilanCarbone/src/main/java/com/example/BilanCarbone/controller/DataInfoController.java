package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.dto.DataInfoRequest;
import com.example.BilanCarbone.entity.DataInfo;
import com.example.BilanCarbone.jpa.DataInfoRepository;
import com.example.BilanCarbone.service.DataInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * Contrôleur REST pour gérer les opérations liées aux objets DataInfo.
 * Ce contrôleur fournit des endpoints pour insérer, mettre à jour, récupérer et supprimer des DataInfo.
 *
 * @author CHALABI Hossam
 */
@RestController
@RequestMapping("api/data")
public class DataInfoController {

    @Autowired
    private DataInfoService dataInfoService;
    @Autowired
    private DataInfoRepository dataInfoRepository;

    /**
     * Endpoint pour insérer un nouvel objet DataInfo.
     *
     * @param dataInfoRequest Les informations de la requête pour créer un DataInfo.
     * @return Le DataInfo nouvellement créé.
     */
    @PostMapping
    public DataInfo insertDataInfo(@RequestBody DataInfoRequest dataInfoRequest) {
        return dataInfoService.insertDataInfo(dataInfoRequest);
    }

    /**
     * Endpoint pour mettre à jour un objet DataInfo existant.
     *
     * @param dataInfoId L'ID du DataInfo à mettre à jour.
     * @param quantity La nouvelle quantité à définir.
     * @return Le DataInfo mis à jour.
     */
    @PutMapping
    public DataInfo updateDataInfo(@RequestParam Long dataInfoId, @RequestBody Double quantity) {
        return dataInfoService.updateDataInfo(dataInfoId, quantity);
    }

    /**
     * Endpoint pour récupérer tous les DataInfo associés à une entreprise spécifique,
     * basée sur l'ID d'un utilisateur.
     *
     * @param idUtilisateur L'ID de l'utilisateur.
     * @return La liste de tous les DataInfo de l'entreprise de l'utilisateur.
     */
    @GetMapping
    public List<DataInfo> getAllDataInfo(@RequestParam String idUtilisateur) {
        return dataInfoService.getAllDataInfoByEntreprise(idUtilisateur);
    }

    /**
     * Endpoint pour récupérer la quantité d'un Facteur spécifique associée à un utilisateur à une date donnée.
     *
     * @param IdFacteur L'ID du Facteur.
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @param date La date associée au DataInfo.
     * @return La quantité associée, ou null si aucun DataInfo correspondant n'est trouvé.
     */
    @GetMapping("/value")
    public Double getValueOfFacteurByUtilisateurByDate(@RequestParam Long IdFacteur,
                                                       @RequestParam String IdUtilisateur,
                                                       @RequestParam LocalDate date) {
        return dataInfoService.quantityOfFacteurByUtilisateurByDate(IdFacteur, IdUtilisateur, date);
    }

    /**
     * Endpoint pour récupérer tous les DataInfo associés à un utilisateur spécifique.
     *
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @return La liste de tous les DataInfo associés à cet utilisateur.
     */
    @GetMapping("/{IdUtilisateur}")
    public List<DataInfo> getIdUtilisateur(@PathVariable String IdUtilisateur) {
        return dataInfoService.getDataInfoByIdUtilisateur(IdUtilisateur);
    }

    @DeleteMapping("all")
    public void viderDataInfoController(){
        dataInfoRepository.deleteAll();
    }
    /**
     * Endpoint pour supprimer tous les DataInfo associés à un facteur spécifique.
     *
     * @param IdFacteur L'ID du facteur.
     */
    @DeleteMapping("facteur")
    public void deleteDataByIdFateur(@RequestParam Long IdFacteur){
        dataInfoService.deleteDataByIdFateur(IdFacteur);
    }

    /**
     * Endpoint pour supprimer un DataInfo spécifique basé sur l'ID du Facteur, l'ID de l'utilisateur, et la date.
     *
     * @param IdFacteur L'ID du Facteur.
     * @param IdUtilisateur L'ID de l'utilisateur.
     * @param date La date associée au DataInfo.
     */
    @DeleteMapping
    public void deleteDataInfoOfUnchecked(@RequestParam Long IdFacteur,
                                          @RequestParam String IdUtilisateur,
                                          @RequestParam LocalDate date) {
        dataInfoService.uncheckFacteur(IdFacteur, IdUtilisateur, date);
    }

    /**
     * Récupère les dates distinctes pour un utilisateur donné.
     *
     * @param IdUtilisateur L'identifiant de l'utilisateur pour lequel récupérer les dates.
     * @return Une liste de dates distinctes.
     */
    @GetMapping("dates")
    public List<LocalDate> getExistantDates(@RequestParam String IdUtilisateur){
        return dataInfoRepository.findDistinctDatesByIdUtilisateur(IdUtilisateur);
    }

    /**
     * Récupère les données des 7 derniers jours pour une entreprise donnée.
     *
     * @param idEntreprise L'identifiant de l'entreprise pour laquelle récupérer les données.
     * @return Une map contenant les dates et les valeurs d'émission pour les 7 derniers jours.
     */
    @GetMapping("DataOfLast7Days")
    public Map<LocalDate,Double> getDataInfoOfLast7DaysOfEntreprise(@RequestParam Long idEntreprise){
        return dataInfoService.getDataInfoOfLast7DaysOfEntreprise(idEntreprise);
    }
    /**
     * Récupère les données des 3 derniers mois pour une entreprise donnée.
     *
     * @param idEntreprise L'identifiant de l'entreprise pour laquelle récupérer les données.
     * @return Une liste des sommes mensuelles d'émission pour les 3 derniers mois.
     */
    @GetMapping("DataOfLast3Month")
    public List<Double> getDataInfoOfLast3monthOfEntreprise(@RequestParam Long idEntreprise){
        return dataInfoService.getDataInfoOfLast3monthOfEntreprise(idEntreprise);
    }
    /**
     * Récupère les données de la dernière année pour une entreprise donnée.
     *
     * @param idEntreprise L'identifiant de l'entreprise pour laquelle récupérer les données.
     * @return Une liste des sommes mensuelles d'émission pour les 12 derniers mois.
     */
    @GetMapping("DataOfLastYear")
    public List<Double> getDataInfoOfLastYearfEntreprise(@RequestParam Long idEntreprise){
        return dataInfoService.getDataInfoOfLastYearfEntreprise(idEntreprise);
    }
}
