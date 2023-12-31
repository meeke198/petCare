package com.petCare.repository;

import com.petCare.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petCare.entity.PackageDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Repository
@Transactional

public interface PackageDetailRepository  extends JpaRepository <PackageDetail,Long> {
    @Modifying
    @Query("UPDATE PackageDetail pd SET pd.isActive = false WHERE pd.id = :id")
    void deleteByIdPackageDetail(@Param("id") Long id);

    List<PackageDetail> getPackageDetailsByCenterUserEmail(String userEmail);
    Page<PackageDetail> findAll(Pageable pageable);

    Page<PackageDetail> findPackageDetailsByServicePackageId(Long packageId,Pageable pageable);
}
