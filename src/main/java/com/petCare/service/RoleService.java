package com.petCare.service;


import com.petCare.dto.roleDto.response.RoleDtoResponse;

import java.util.List;

public interface RoleService {
    List<RoleDtoResponse> getAllRole ();
}