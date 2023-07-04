package com.petCare.controller;

import com.petCare.security.JwtAuthFilter;
import com.petCare.security.JwtTokenProvider;
import com.petCare.service.RoleService;
import com.petCare.service.SecurityService;
import com.petCare.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/role")
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @PutMapping("/{id}")
    public ResponseEntity<?> updateRole (@PathVariable("id") Long id, @RequestParam List<Long> roles,
                                         @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        Boolean updateRole = userService.updateRole(id,roles);
        if(updateRole) return new ResponseEntity<String>("Update role successful", HttpStatus.OK);
        return new ResponseEntity<String>("update role failed", HttpStatus.BAD_REQUEST);
    }
}
