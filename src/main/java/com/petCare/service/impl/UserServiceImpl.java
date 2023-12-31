package com.petCare.service.impl;

import com.petCare.converter.UserConverter;
import com.petCare.dto.userDto.request.UserDtoCreateRequest;
import com.petCare.dto.userDto.request.UserDtoPassword;
import com.petCare.dto.userDto.request.UserDtoUpdate;
import com.petCare.dto.userDto.response.UserDtoResponse;
import com.petCare.dto.userDto.response.UserDtoResponseDetail;
import com.petCare.entity.*;
import com.petCare.entity.Role;
import com.petCare.entity.User;
import com.petCare.entity.UserRole;
import com.petCare.payload.response.checkEmailPassword;
import com.petCare.repository.*;
import com.petCare.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserRoleRepository userRoleRepository;
    private final RoleRepository roleRepository;

    private final CartRepository cartRepository;
    private final FavoriteRepository favoriteRepository;
    private final UserConverter userConverter;


    public UserServiceImpl(UserRepository userRepository, UserRoleRepository userRoleRepository, CartRepository cartRepository,
                           FavoriteRepository favoriteRepository, RoleRepository roleRepository, UserConverter userConverter ) {
        this.userRepository = userRepository;
        this.userConverter = userConverter;
        this.userRoleRepository = userRoleRepository;
        this.cartRepository = cartRepository;
        this.favoriteRepository = favoriteRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public Page<UserDtoResponse> getUsers(Pageable pageable) {
        Page<User> users = userRepository.findAll(pageable);
        return users.map(userConverter::entityToDto);
    }

    @Override
    public Optional<UserDtoResponse> findById(Long id) {
        Optional<User> customer = userRepository.findById(id);
        return Optional.ofNullable(userConverter.entityToDtoOptional(customer).get());
    }


    @Override
    public checkEmailPassword save(UserDtoCreateRequest userDtoCreateRequest) {
        User email = userRepository.findUserByEmail(userDtoCreateRequest.getEmail());
        User userName = userRepository.findUserByUserName(userDtoCreateRequest.getUserName());
        checkEmailPassword checkEmailPassword = new checkEmailPassword();
        if (email != null && userName != null) {
            checkEmailPassword.setUserName("userName already exists");
            checkEmailPassword.setEmail("email already exists");
            return checkEmailPassword;
        } else if (email == null && userName != null) {
            checkEmailPassword.setUserName("userName already exists");
            return checkEmailPassword;
        } else if (email != null && userName == null) {
            checkEmailPassword.setEmail("email already exists");
            return checkEmailPassword;
        } else {
            User newUser = userConverter.dtoToEntity(userDtoCreateRequest);
            String hashedPassword = BCrypt.hashpw(userDtoCreateRequest.getPassword(), BCrypt.gensalt(10));
            newUser.setPassword(hashedPassword);
            userRepository.save(newUser);
            userDtoCreateRequest.getRoles().forEach(role -> {
                UserRole userRole = new UserRole(newUser, role);
                userRoleRepository.save(userRole);
            });
            Cart cart = new Cart();
            cart.setUser(newUser);
            cartRepository.save(cart);
            Favorite favorite = new Favorite();
            favorite.setUser(newUser);
            favoriteRepository.save(favorite);
            return null;
        }
    }

    @Override
    public Boolean remove(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.deleteByIdUser(id);
            return true;
        }
        return false;
    }

    @Override
    public Boolean active(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.activeByIdUser(id);
            return true;
        }
        return false;
    }

    @Override
    public List<UserDtoResponse> findAll() {
        List<User> users = userRepository.findAll();
        List<UserDtoResponse> userDtoResponses = new ArrayList<>();
        users.forEach(element -> {
            userDtoResponses.add(userConverter.entityToDto(element));
        });
        return userDtoResponses;
    }

    @Override
    public List<UserDtoResponse> getUsersByFullName(String fullName) {
        String likeFullName = "%" + fullName + "%";
        List<User> userByFullNames = userRepository.searchByFullName(likeFullName);
        List<UserDtoResponse> userDtoResponseFullNames = new ArrayList<>();
        userByFullNames.forEach(element -> {
            userDtoResponseFullNames.add(userConverter.entityToDto(element));
        });
        return userDtoResponseFullNames;
    }

    @Override
    public UserDtoResponse getUserByEmail(String email) {
        UserDtoResponse userDtoResponse = userConverter.entityToDto(userRepository.findUserByEmail(email));
        return userDtoResponse;
    }

    @Override
    public UserDtoResponseDetail getUserById(Long customerId) {
        User user = userRepository.findById(customerId).orElse(null);
        return userConverter.entityToUserDtoResponseDetail(user);
    }

    @Override
    public Boolean updateSimple(UserDtoUpdate userDtoUpdate) {
        User user = userRepository.findUserByEmail(userDtoUpdate.getEmail());
        if (user != null) {
            user.setAddress(userDtoUpdate.getAddress());
            user.setFullName(userDtoUpdate.getFullName());
            user.setAvatar(userDtoUpdate.getAvatar());
            user.setPhone(userDtoUpdate.getPhone());
            user.setDescript(userDtoUpdate.getDescript());
            user.setDob(userDtoUpdate.getDob());
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Override
    public Boolean updatePassword(UserDtoPassword userDtoPassword) {
        User user = userRepository.findUserByEmail(userDtoPassword.getEmail());
        if (BCrypt.checkpw(userDtoPassword.getOldPassword(), user.getPassword())) {
            String hashedPassword = BCrypt.hashpw(userDtoPassword.getNewPassword(), BCrypt.gensalt(10));
            user.setPassword(hashedPassword);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Override
    public Boolean updateRole(Long id, List<Long> roles) {
        User user = userRepository.getUserById(id);
        List<Long> roleResponse = new ArrayList<>();
        if(user!= null){
            user.getUserRoles().forEach(role -> {
                roleResponse.add(role.getRole().getId());
            });
            roleResponse.forEach(idRole ->{
                Role role = roleRepository.getRoleById(idRole);
                UserRole userRole = userRoleRepository.getUserRoleByUserId(user, role);
                if (userRole != null) {
                    userRoleRepository.removeUserRoleById(userRole.getId());
                }
            });
            roles.forEach(idNewRole ->{
                Role role = roleRepository.getRoleById(idNewRole);
                UserRole newUserRole = new UserRole(user,role);
                userRoleRepository.save(newUserRole);
            });
            return true;
        }
        return false;
    }
    @Override
    public Boolean updateImage(Long id, String avatarUrl) {
        User user = userRepository.getUserById(id);
        if(user != null){
            user.setAvatar(avatarUrl);
            return true;
        }
        return false;
    }
}
