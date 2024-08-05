package com.example.BilanCarbone.entity;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

/**
 * Enumération représentant les unités de mesure utilisées pour les facteurs d'émission.
 * <p>
 * L'énumération {@code Unite} fournit une liste de différentes unités de mesure telles que kilogrammes, litres, mètres cubes, etc.
 * Elle permet de convertir des chaînes de caractères en unités et de récupérer la liste des unités disponibles.
 * </p>
 *
 * @author Oussama
 */
@Getter
public enum Unite {
    /**
     * Unité : kilogramme.
     */
    KG("kilogramme"),

    /**
     * Unité : litre.
     */
    LITRE("litre"),

    /**
     * Unité : mètre cube.
     */
    M3("Mètre cube"),

    /**
     * Unité : kilowattheure.
     */
    kWh("kilowattheure"),

    /**
     * Unité : wattheure.
     */
    WH("wattheure"),

    /**
     * Unité : kilomètre.
     */
    kM("Kilomètre"),

    /**
     * Unité : tonne.
     */
    TO("tonne"),

    /**
     * Unité : passager-kilomètre.
     */
    PKM("passager-kilomètre"),

    /**
     * Unité : hectare.
     */
    HA("hectare"),

    /**
     * Unité : mètre carré.
     */
    M2("Mètre carré"),

    /**
     * Unité : année.
     */
    AN("anne"),

    /**
     * Unité inconnue.
     */
    UNKNOWN("UNKNOWN"),

    /**
     * Unité : heure.
     */
    HR("Heure");

    /**
     * Représentation de l'unité en chaîne de caractères.
     */
    private final String unit;

    /**
     * Constructeur pour initialiser l'unité avec une chaîne de caractères.
     *
     * @param unit Représentation de l'unité.
     */
    Unite(String unit) {
        this.unit = unit;
    }

    /**
     * Convertit une chaîne de caractères en une unité {@code Unite}.
     * <p>
     * Si la chaîne de caractères ne correspond à aucune unité connue, l'unité {@code UNKNOWN} est retournée.
     * </p>
     *
     * @param unit La chaîne de caractères représentant l'unité.
     * @return L'unité correspondant à la chaîne de caractères ou {@code UNKNOWN} si aucune correspondance n'est trouvée.
     */
    public static Unite fromString(String unit) {
        for (Unite co2Unit : Unite.values()) {
            if (co2Unit.getUnit().equalsIgnoreCase(unit)) {
                return co2Unit;
            }
        }
        return UNKNOWN;
    }

    /**
     * Récupère la liste des unités disponibles, à l'exclusion de {@code UNKNOWN}.
     *
     * @return Liste des unités disponibles sous forme de chaînes de caractères.
     */
    public static List<String> getAllUnits() {
        List<String> units = new ArrayList<>();
        for (Unite i : Unite.values()) {
            if (i.getUnit().equalsIgnoreCase("UNKNOWN")) {
                continue;
            }
            units.add(i.getUnit());
        }
        return units;
    }

    public String getUnit() {
        return this.unit;
    }
}