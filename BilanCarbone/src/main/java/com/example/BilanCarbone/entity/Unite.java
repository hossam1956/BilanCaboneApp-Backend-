package com.example.BilanCarbone.entity;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Oussama
 **/
@Getter
public enum Unite {
    KG("kilogramme"),
    LITRE("litre"),
    M3("Mètre cube"),
    kWh("kilowattheure"),
    WH("wattheure"),
    kM("Kilomètre"),
    TO("tonne"),
    PKM("passager-kilomètre"),
    HA("hectare"),
    M2("Mètre carré"),
    AN("anne"),
    UNKNOWN("UNKNOWN"),
    HR("Heure");
    private  String unit;
    Unite(String unit) {
        this.unit = unit;
    }

    public static Unite fromString(String unit) {
        for (Unite co2Unit : Unite.values()) {
            if (co2Unit.getUnit().equalsIgnoreCase(unit)) {
                return co2Unit;
            }
        }
        return UNKNOWN;
    }
    public static List<String> getAllUnits() {
        List<String> units = new ArrayList<>();
        for (Unite i : Unite.values()) {
            if(i.getUnit().equalsIgnoreCase("UNKNOWN")) {
                continue;
            }
            units.add(i.getUnit());
        }
        return units;
    }
    }
