package com.petCare.service;

import com.petCare.payload.request.LoginRequest;
import com.petCare.payload.response.LoginResponse;

public interface AuthService {
    LoginResponse login (LoginRequest loginRequest);
    Boolean isExistAccount (String account);
}