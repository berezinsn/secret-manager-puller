package com.oae.secmanager.controller;

import com.oae.secmanager.properties.SecretProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class SecretsController {

    private final SecretProperties secretProperties;

    @GetMapping("/")
    public String getSecrets() {
        return String.format("Username: %s, Password: %s", secretProperties.getTestUser(), secretProperties.getTestPassword());
    }
}
