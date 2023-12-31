package com.petCare.repository;

import com.petCare.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Role getRoleById(Long id);
    List<Role> findAll();
}
