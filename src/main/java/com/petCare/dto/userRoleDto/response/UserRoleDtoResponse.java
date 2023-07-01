package com.petCare.dto.userRoleDto.response;

import com.petCare.dto.roleDto.response.RoleDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserRoleDtoResponse {
    private RoleDtoResponse roleDtoResponse;
}