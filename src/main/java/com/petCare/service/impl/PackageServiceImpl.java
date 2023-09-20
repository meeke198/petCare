package com.petCare.service.impl;

import com.petCare.converter.PackageConverter;
import com.petCare.entity.Package;
import com.petCare.dto.packageDto.request.PackageDtoRequest;
import com.petCare.dto.packageDto.response.PackageDtoResponse;
import com.petCare.repository.PackageRepository;
import com.petCare.service.PackageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class PackageServiceImpl implements PackageService {
    private final PackageRepository packageRepository;
    private final PackageConverter packageConverter;
    @Override
    public PackageDtoResponse savePackage(PackageDtoRequest packageDtoRequest) {
        log.info("Saving new service package to database {}", packageDtoRequest.getName());
        Package aPackage =  packageConverter.dtoToEntity(packageDtoRequest);
        Package savedPackage =  packageRepository.save(aPackage);
        savedPackage.setIsActive(true);
        return packageConverter.entityToDto(savedPackage);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageRepository.deleteByIdPackage(id);
    }

    @Override
    public Optional<PackageDtoResponse> findPackageById(Long id) {
        log.info("Getting service package by id from database");
        Optional<Package> servicePackage = packageRepository.findPackageById(id);
        if(servicePackage.isPresent()){
            PackageDtoResponse packageDtoResponse = packageConverter.entityToDto(servicePackage.get());
            return Optional.of(packageDtoResponse);
        } else {
            return Optional.empty();
        }
    }
    @Override
    public Page<PackageDtoResponse> findAll(Pageable pageable) {
        Page<Package> servicePackages = packageRepository.findAll(pageable);
        return servicePackages.map(packageConverter::entityToDto);
    }
}
