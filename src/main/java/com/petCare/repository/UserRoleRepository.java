package com.petCare.repository;

import com.petCare.entity.Role;
import com.petCare.entity.User;
import com.petCare.entity.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRole,Long> {
    void removeUserRoleById(long id);
    @Query(value = "select  ur from UserRole ur where ur.user = :user and ur.role = :role")
    UserRole getUserRoleByUserId (User user, Role role);

}