package com.petCare.service;


import com.petCare.dto.packageDto.request.PackageDtoRequest;
import com.petCare.dto.packageDto.response.PackageDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface PackageService {
    PackageDtoResponse savePackage(PackageDtoRequest packageDtoRequest);

    void deleteByIdByStatus(Long id);
    Optional<PackageDtoResponse> findPackageById(Long id);

    Page<PackageDtoResponse> findAll(Pageable pageable);
}