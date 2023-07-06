package com.petCare.repository;

import com.petCare.entity.ServiceImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceImageRepository extends JpaRepository<ServiceImage,Long> {

}
