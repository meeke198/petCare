package com.petCare.service;

import com.petCare.dto.userDto.request.UserDtoCreateRequest;
import com.petCare.dto.userDto.request.UserDtoPassword;
import com.petCare.dto.userDto.request.UserDtoUpdate;
import com.petCare.dto.userDto.response.UserDtoResponse;
import com.petCare.dto.userDto.response.UserDtoResponseDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


import java.util.List;
import java.util.Optional;

public interface UserService {
    List<UserDtoResponse> findAll();
    List<UserDtoResponse> getUsersByFullName(String fullName);
    //    User isExitUserName(String userName);
//    User findUserByEmail(String email);
    UserDtoResponseDetail getUserById(Long customerId);
    Page<UserDtoResponse> getUsers(Pageable pageable);
    Optional<UserDtoResponse> findById(Long id);
    checkEmailPassword save(UserDtoCreateRequest userDtoCreateRequest);
    Boolean remove(Long id);
    Boolean updateSimple(UserDtoUpdate userDtoUpdate);
    Boolean updatePassword (UserDtoPassword userDtoPassword);
    Boolean active(Long id);
    UserDtoResponse getUserByEmail(String email);
    Boolean updateRole(Long id, List<Long> roles);
    Boolean updateImage(Long id, String avatarUrl);
}