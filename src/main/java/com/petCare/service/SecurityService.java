package com.petCare.service;

public interface SecurityService {
    boolean isAuthenticated();
    boolean isValidToken(String token);
}