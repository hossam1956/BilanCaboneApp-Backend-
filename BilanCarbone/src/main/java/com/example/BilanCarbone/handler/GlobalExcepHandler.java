package com.example.BilanCarbone.handler;

import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import static org.springframework.http.HttpStatus.*;
/**
 * Gère les exceptions globales pour l'application.
 * <p>
 * Cette classe est annotée avec {@code @RestControllerAdvice} et fournit des méthodes pour gérer
 * les exceptions spécifiques qui peuvent survenir dans les contrôleurs de l'application. Les méthodes
 * annotées avec {@code @ExceptionHandler} capturent les exceptions et renvoient une réponse appropriée
 * avec des détails sur l'erreur.
 * </p>
 *
 * @author Oussama
 */
@RestControllerAdvice
public class GlobalExcepHandler {

    /**
     * Gère les exceptions d'accès refusé.
     * <p>
     * Cette méthode est appelée lorsque l'utilisateur tente d'accéder à une ressource sans avoir les autorisations nécessaires.
     * Elle renvoie une réponse HTTP avec le statut 403 Forbidden.
     * </p>
     *
     * @param exp l'exception d'accès refusé
     * @return une réponse HTTP avec les détails de l'erreur de permission
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ExceptionResponse> handleAccessDeniedException(AccessDeniedException exp) {
        return ResponseEntity
                .status(FORBIDDEN)
                .body(
                        ExceptionResponse.builder()
                                .details("Accès refusé: vous n'avez pas les permissions nécessaires pour accéder à cette ressource.")
                                .message(exp.getMessage())
                                .code(FORBIDDEN.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }
    /**
     * Gère les exceptions de validation des arguments de méthode.
     * <p>
     * Cette méthode est appelée lorsque la validation des arguments d'une méthode échoue.
     * Elle crée une réponse contenant les erreurs de validation sous forme de carte, où les clés sont
     * les noms des champs et les valeurs sont les messages d'erreur.
     * </p>
     *
     * @param exp l'exception de validation des arguments de méthode
     * @return une réponse HTTP avec les détails des erreurs de validation
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ExceptionResponse> handleMethodArgumentNotValidException(MethodArgumentNotValidException exp) {
        Map<String, String> errors = new HashMap<>();
        exp.getBindingResult().getAllErrors()
                .forEach(error -> {
                    var fieldName = ((FieldError) error).getField();
                    var errorMessage = error.getDefaultMessage();
                    errors.put(fieldName, errorMessage);
                });

        return ResponseEntity
                .status(BAD_REQUEST)
                .body(
                        ExceptionResponse.builder()
                                .erros(errors)
                                .details("Certaines données sont invalides")
                                .code(BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }

    /**
     * Gère les exceptions lorsque le chemin demandé n'est pas trouvé.
     * <p>
     * Cette méthode est appelée lorsqu'une requête est effectuée pour un chemin qui n'existe pas.
     * Elle renvoie une réponse avec le message de l'exception et le chemin demandé.
     * </p>
     *
     * @param exp l'exception indiquant que le gestionnaire de requête n'a pas été trouvé
     * @return une réponse HTTP avec les détails sur le chemin demandé
     */
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<ExceptionResponse> handleNoHandlerFoundException(NoHandlerFoundException exp) {
        return ResponseEntity
                .status(NOT_FOUND)
                .body(
                        ExceptionResponse.builder()
                                .details("Le chemin demandé n'existe pas")
                                .message(exp.getMessage())
                                .code(NOT_FOUND.value())
                                .date(LocalDateTime.now())
                                .path(exp.getRequestURL()) // Inclure le chemin
                                .build()
                );
    }

    /**
     * Gère les exceptions lorsque les données envoyées ne sont pas lisibles.
     * <p>
     * Cette méthode est appelée lorsque les données envoyées dans la requête ne peuvent pas être lues ou sont invalides.
     * Elle renvoie une réponse indiquant que les données n'ont pas été envoyées correctement.
     * </p>
     *
     * @param exp l'exception indiquant que le message HTTP n'est pas lisible
     * @return une réponse HTTP avec les détails sur l'erreur de lecture des données
     */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ExceptionResponse> handleHttpMessageNotReadableException(HttpMessageNotReadableException exp) {
        return ResponseEntity
                .status(BAD_REQUEST)
                .body(
                        ExceptionResponse.builder()
                                .message("Les données ne sont pas envoyées correctement")
                                .code(BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }

    /**
     * Gère les exceptions générales non capturées par d'autres gestionnaires.
     * <p>
     * Cette méthode est appelée pour toutes les autres exceptions non spécifiquement traitées.
     * Elle enregistre la pile d'exécution et renvoie une réponse indiquant une erreur interne du serveur.
     * </p>
     *
     * @param exp l'exception générale
     * @return une réponse HTTP avec des détails sur l'erreur interne
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ExceptionResponse> handleException(Exception exp) {
        exp.printStackTrace();
        return ResponseEntity
                .status(INTERNAL_SERVER_ERROR)
                .body(
                        ExceptionResponse.builder()
                                .details("Erreur interne, veuillez contacter l'administrateur")
                                .message(exp.getMessage())
                                .code(INTERNAL_SERVER_ERROR.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }
}