package com.petCare.controller;

import com.petCare.dto.userDto.request.UserDtoCreateRequest;
import com.petCare.payload.request.LoginRequest;
import com.petCare.payload.response.LoginResponse;
import com.petCare.payload.response.checkEmailPassword;
import com.petCare.service.AuthService;
import com.petCare.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            LoginResponse loginResponse = authService.login(loginRequest);
            return new ResponseEntity<>(loginResponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("this Account is not valid", HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping
    public ResponseEntity<?> create(@Validated @RequestBody UserDtoCreateRequest userDtoCreateRequest) {
        checkEmailPassword checkEmailPassword = userService.save(userDtoCreateRequest);
        if (checkEmailPassword == null) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        } else return new ResponseEntity<>(checkEmailPassword, HttpStatus.BAD_REQUEST);
    }

    @GetMapping
    public ResponseEntity<?> findUserByAccount(@Valid @RequestParam String account) {
        try {
            Boolean isExist = authService.isExistAccount(account);
            return new ResponseEntity<>(isExist, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }
}
