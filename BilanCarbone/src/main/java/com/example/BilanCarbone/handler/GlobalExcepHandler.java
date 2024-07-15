package com.example.BilanCarbone.handler;

import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
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
 * @author Oussama
 **/
@RestControllerAdvice
public class GlobalExcepHandler {
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ExceptionResponse> handleMethodArgumentNotValidException(MethodArgumentNotValidException exp) {
        Map<String,String> errors = new HashMap();
        exp.getBindingResult().getAllErrors()
                .forEach(error -> {
                    var fieldName = ((FieldError) error).getField();
                    var errorMessage = error.getDefaultMessage();
                    errors.put(fieldName,errorMessage);
                });

        return ResponseEntity
                .status(BAD_REQUEST)
                .body(
                        ExceptionResponse.builder()
                                .erros(errors)
                                .details("Some data is invalid")
                                .code(BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<ExceptionResponse> handleNoHandlerFoundException(NoHandlerFoundException exp) {
        return ResponseEntity
                .status(NOT_FOUND)
                .body(
                        ExceptionResponse.builder()
                                .details("The requested path does not exist")
                                .message(exp.getMessage())
                                .code(NOT_FOUND.value())
                                .date(LocalDateTime.now())
                                .path(exp.getRequestURL()) // Include the path
                                .build()
                );
    }
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ExceptionResponse> handleNoHandlerFoundException(HttpMessageNotReadableException exp) {
        return ResponseEntity
                .status(BAD_REQUEST)
                .body(
                        ExceptionResponse.builder()
                                .message("Data is not sent")
                                .code(BAD_REQUEST.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }
   @ExceptionHandler(Exception.class)
    public ResponseEntity<ExceptionResponse> handleException(Exception exp) {
        exp.printStackTrace();
        return ResponseEntity
                .status(INTERNAL_SERVER_ERROR)
                .body(
                        ExceptionResponse.builder()
                                .details("Internal error, please contact the admin")
                                .message(exp.getMessage())
                                .code(INTERNAL_SERVER_ERROR.value())
                                .date(LocalDateTime.now())
                                .build()
                );
    }
}
