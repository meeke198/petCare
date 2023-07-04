package com.petCare.service.impl;

import com.petCare.converter.PackageDetailConverter;
import com.petCare.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petCare.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petCare.entity.Package;
import com.petCare.entity.PackageDetail;
import com.petCare.repository.PackageDetailRepository;
import com.petCare.repository.PackageRepository;
import com.petCare.service.PackageDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PackageDetailServiceImpl implements PackageDetailService {
    private final PackageDetailRepository packageDetailRepository;
    private final PackageDetailConverter packageDetailConverter;
    private final PackageRepository packageRepository;
    @Override
    public PackageDetailDtoResponse savePackageDetail(PackageDetailDtoRequest packageDetailDtoRequest) {
        PackageDetail packageDetail = packageDetailConverter.dtoToEntity(packageDetailDtoRequest);


        Optional<Package> servicePackage = packageRepository.findPackageByName(packageDetailDtoRequest.getName());
        if (servicePackage.isEmpty()){
            Package newPackage = new Package();
            newPackage.setName(packageDetailDtoRequest.getName());
            packageRepository.save(newPackage);
            packageDetail.setServicePackage(newPackage);
        }
        packageDetail.setServicePackage(servicePackage.get());
        packageDetailRepository.save(packageDetail);
        packageDetail.setIsActive(true);
        return packageDetailConverter.entityToDto(packageDetail);
    }

    @Override
    public Optional<PackageDetailDtoResponse> getPackageDetail(Long id) {
        PackageDetailDtoResponse packageDetailDtoResponse = packageDetailConverter.
                entityToDto(packageDetailRepository.getById(id));
        return Optional.ofNullable(packageDetailDtoResponse);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageDetailRepository.deleteByIdPackageDetail(id);
    }

    @Override
    public List<PackageDetailDtoResponse> findByUserEmail(String userEmail) {
        List<PackageDetail> packageDetails =packageDetailRepository.getPackageDetailsByCenterUserEmail(userEmail);
        return packageDetails.stream().map(packageDetailConverter::entityToDto).collect(Collectors.toList());
    }

    @Override
    public Page<PackageDetailDtoResponse> findAll(Pageable pageable) {
        Page<PackageDetail> packageDetails = packageDetailRepository.findAll(pageable);
       return packageDetails.map(packageDetailConverter::entityToDto);
    }

    @Override
    public Page<PackageDetailDtoResponse> findPackageDetailByPackageName(String name,Pageable pageable) {
        Page<PackageDetail> packageDetails = packageDetailRepository.findPackageDetailsByServicePackageName(name,pageable);
        return packageDetails.map(packageDetailConverter::entityToDto);
    }
}
