package com.petCare.service;

import com.petCare.dto.serviceDto.request.ServiceDtoRequest;
import com.petCare.dto.serviceDto.response.ServiceDtoResponse;
import com.petCare.entity.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface ServiceService {
    Service saveService(ServiceDtoRequest serviceDtoRequest);

    Optional<ServiceDtoResponse> getService(Long id);

    void deleteByIdByStatus(Long id);

    Page<ServiceDtoResponse> findAll(Pageable pageable);

    void addImageToService(Long id,String urlImage);
    Optional<Page<ServiceDtoResponse>> findByPackageId(Long packageDetailId,Pageable pageable);
}
