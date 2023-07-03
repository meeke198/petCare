package com.petCare.dto.packageDto.response;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageDtoResponse {
    private Long id;
    private String name;
    private Boolean isActive;
}
