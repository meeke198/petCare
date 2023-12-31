package com.petCare.service;

import com.petCare.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petCare.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface PackageDetailService {
    PackageDetailDtoResponse savePackageDetail(PackageDetailDtoRequest packageDetailDtoRequest);

    Optional<PackageDetailDtoResponse> getPackageDetail(Long id);
    void deleteByIdByStatus(Long id);

    List<PackageDetailDtoResponse> findByUserEmail(String userEmail);

    Page<PackageDetailDtoResponse> findAll(Pageable pageable);

    Page<PackageDetailDtoResponse> findPackageDetailByPackageId(Long packageId,Pageable pageable);
}
