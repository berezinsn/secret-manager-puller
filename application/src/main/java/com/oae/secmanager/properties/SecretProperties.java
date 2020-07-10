package com.oae.secmanager.properties;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;

@Getter
@ConfigurationProperties("app.secrets")
@RequiredArgsConstructor(onConstructor = @__(@ConstructorBinding))
public class SecretProperties {

    private final String testUser;

    private final String testPassword;
}
