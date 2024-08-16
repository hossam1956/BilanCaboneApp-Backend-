package com.example.BilanCarbone.security;

import org.jasypt.util.text.BasicTextEncryptor;
import org.springframework.stereotype.Component;

/**
 * Classe responsable de l'encryption et de la décryption des mots de passe.
 * Cette classe utilise Jasypt pour sécuriser les mots de passe en les cryptant avant de les stocker
 * et en les décryptant lorsque c'est nécessaire.
 *
 * <p>Le mot de passe de cryptage est défini lors de l'initialisation de cette classe,
 * garantissant ainsi que toutes les opérations d'encryption et de décryption
 * utilisent la même clé de sécurité.</p>
 *
 * <p><strong>Attention:</strong> Le mot de passe de cryptage utilisé dans cette classe
 * doit être stocké en toute sécurité et ne doit pas être exposé publiquement
 * afin de garantir la sécurité des données cryptées.</p>
 *
 * @author CHALABI Hossam
 */
@Component
public class PasswordEncryptionService {

    private BasicTextEncryptor textEncryptor;

    /**
     * Constructeur qui initialise l'objet BasicTextEncryptor avec une clé de cryptage.
     */
    public PasswordEncryptionService() {
        textEncryptor = new BasicTextEncryptor();
        textEncryptor.setPasswordCharArray("uTSqb9grs1+vUv3iN8lItC0kl65lMG+8".toCharArray());
    }

    /**
     * Crypte le mot de passe fourni en utilisant la clé de cryptage configurée.
     *
     * @param password le mot de passe en texte clair à crypter
     * @return le mot de passe crypté
     */
    public String encryptPassword(String password) {
        return textEncryptor.encrypt(password);
    }

    /**
     * Décrypte le mot de passe crypté fourni en utilisant la clé de cryptage configurée.
     *
     * @param encryptedPassword le mot de passe crypté à décrypter
     * @return le mot de passe en texte clair
     */
    public String decryptPassword(String encryptedPassword) {
        return textEncryptor.decrypt(encryptedPassword);
    }
}
