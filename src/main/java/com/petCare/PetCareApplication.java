package com.petCare;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.Collections;

@SpringBootApplication
public class PetCareApplication {

	public static void main(String[] args) {

		SpringApplication.run(PetCareApplication.class, args);
		String port = System.getenv("PORT");
		if (port == null) {
			// Default to port 8080 if PORT environment variable is not set
			port = "8080";
		}
		SpringApplication app = new SpringApplication(PetCareApplication.class);
		app.setDefaultProperties(Collections.singletonMap("server.port", port));
		app.run(args);
	}

}
