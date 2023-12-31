package com.petCare.dto.userDto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoUpdate {
    private String fullName;
    private String address;
    private String phone;
    private String avatar;
    private String descript;
    private Date dob;
    private String email;}