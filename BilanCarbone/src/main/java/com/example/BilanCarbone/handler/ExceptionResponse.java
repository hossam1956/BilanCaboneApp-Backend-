package com.example.BilanCarbone.handler;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Set;

/**
 * Représente une structure de réponse pour la gestion des exceptions.
 * <p>
 * Cette classe est utilisée pour encapsuler les détails des exceptions, y compris les codes d'erreur,
 * les messages et les informations supplémentaires qui peuvent être utiles pour le débogage et le reporting des erreurs.
 * </p>
 *
 * @author Oussama
 */
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class ExceptionResponse {

    /**
     * Code d'erreur représentant le type d'exception.
     */
    private Integer code;

    /**
     * Message descriptif concernant l'exception.
     */
    private String message;

    /**
     * Détails supplémentaires concernant l'exception.
     */
    private String details;

    /**
     * Ensemble des messages d'erreur de validation.
     * <p>
     * Ce champ est utilisé pour capturer plusieurs erreurs de validation qui peuvent se produire lors du traitement de la requête.
     * </p>
     */
    private Set<String> validationError;

    /**
     * Carte des noms de champs aux messages d'erreur.
     * <p>
     * Ce champ est utilisé pour fournir des informations détaillées sur les erreurs spécifiques aux champs rencontrées lors de la validation.
     * </p>
     */
    private Map<String, String> erros;

    /**
     * Horodatage indiquant le moment où l'exception est survenue.
     */
    private LocalDateTime date;

    /**
     * Chemin de la requête qui a causé l'exception.
     */
    private String path;

    public ExceptionResponse(Integer code, String message, String details, Set<String> validationError, Map<String, String> erros, LocalDateTime date, String path) {
        this.code = code;
        this.message = message;
        this.details = details;
        this.validationError = validationError;
        this.erros = erros;
        this.date = date;
        this.path = path;
    }

    public ExceptionResponse() {
    }

    public static ExceptionResponseBuilder builder() {
        return new ExceptionResponseBuilder();
    }

    public Integer getCode() {
        return this.code;
    }

    public String getMessage() {
        return this.message;
    }

    public String getDetails() {
        return this.details;
    }

    public Set<String> getValidationError() {
        return this.validationError;
    }

    public Map<String, String> getErros() {
        return this.erros;
    }

    public LocalDateTime getDate() {
        return this.date;
    }

    public String getPath() {
        return this.path;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public void setValidationError(Set<String> validationError) {
        this.validationError = validationError;
    }

    public void setErros(Map<String, String> erros) {
        this.erros = erros;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof ExceptionResponse)) return false;
        final ExceptionResponse other = (ExceptionResponse) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$code = this.getCode();
        final Object other$code = other.getCode();
        if (this$code == null ? other$code != null : !this$code.equals(other$code)) return false;
        final Object this$message = this.getMessage();
        final Object other$message = other.getMessage();
        if (this$message == null ? other$message != null : !this$message.equals(other$message)) return false;
        final Object this$details = this.getDetails();
        final Object other$details = other.getDetails();
        if (this$details == null ? other$details != null : !this$details.equals(other$details)) return false;
        final Object this$validationError = this.getValidationError();
        final Object other$validationError = other.getValidationError();
        if (this$validationError == null ? other$validationError != null : !this$validationError.equals(other$validationError))
            return false;
        final Object this$erros = this.getErros();
        final Object other$erros = other.getErros();
        if (this$erros == null ? other$erros != null : !this$erros.equals(other$erros)) return false;
        final Object this$date = this.getDate();
        final Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final Object this$path = this.getPath();
        final Object other$path = other.getPath();
        if (this$path == null ? other$path != null : !this$path.equals(other$path)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof ExceptionResponse;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $code = this.getCode();
        result = result * PRIME + ($code == null ? 43 : $code.hashCode());
        final Object $message = this.getMessage();
        result = result * PRIME + ($message == null ? 43 : $message.hashCode());
        final Object $details = this.getDetails();
        result = result * PRIME + ($details == null ? 43 : $details.hashCode());
        final Object $validationError = this.getValidationError();
        result = result * PRIME + ($validationError == null ? 43 : $validationError.hashCode());
        final Object $erros = this.getErros();
        result = result * PRIME + ($erros == null ? 43 : $erros.hashCode());
        final Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final Object $path = this.getPath();
        result = result * PRIME + ($path == null ? 43 : $path.hashCode());
        return result;
    }

    public String toString() {
        return "ExceptionResponse(code=" + this.getCode() + ", message=" + this.getMessage() + ", details=" + this.getDetails() + ", validationError=" + this.getValidationError() + ", erros=" + this.getErros() + ", date=" + this.getDate() + ", path=" + this.getPath() + ")";
    }

    public static class ExceptionResponseBuilder {
        private Integer code;
        private String message;
        private String details;
        private Set<String> validationError;
        private Map<String, String> erros;
        private LocalDateTime date;
        private String path;

        ExceptionResponseBuilder() {
        }

        public ExceptionResponseBuilder code(Integer code) {
            this.code = code;
            return this;
        }

        public ExceptionResponseBuilder message(String message) {
            this.message = message;
            return this;
        }

        public ExceptionResponseBuilder details(String details) {
            this.details = details;
            return this;
        }

        public ExceptionResponseBuilder validationError(Set<String> validationError) {
            this.validationError = validationError;
            return this;
        }

        public ExceptionResponseBuilder erros(Map<String, String> erros) {
            this.erros = erros;
            return this;
        }

        public ExceptionResponseBuilder date(LocalDateTime date) {
            this.date = date;
            return this;
        }

        public ExceptionResponseBuilder path(String path) {
            this.path = path;
            return this;
        }

        public ExceptionResponse build() {
            return new ExceptionResponse(this.code, this.message, this.details, this.validationError, this.erros, this.date, this.path);
        }

        public String toString() {
            return "ExceptionResponse.ExceptionResponseBuilder(code=" + this.code + ", message=" + this.message + ", details=" + this.details + ", validationError=" + this.validationError + ", erros=" + this.erros + ", date=" + this.date + ", path=" + this.path + ")";
        }
    }
}