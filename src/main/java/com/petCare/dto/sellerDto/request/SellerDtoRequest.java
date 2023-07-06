package com.petCare.dto.sellerDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SellerDtoRequest {
    private Long id;
    private String userEmail;
    private String name;
    private String phone;
    private String email;
    private String address;
    private Boolean isActive;
}
