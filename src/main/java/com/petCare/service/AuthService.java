package com.petCare.service;
public interface AuthService {
    LoginResponse login (LoginRequest loginRequest);
    Boolean isExistAccount (String account);
}