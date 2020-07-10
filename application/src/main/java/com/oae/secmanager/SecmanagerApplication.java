package com.oae.secmanager;

import com.oae.secmanager.properties.SecretProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(SecretProperties.class)
public class SecmanagerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SecmanagerApplication.class, args);
    }

}
