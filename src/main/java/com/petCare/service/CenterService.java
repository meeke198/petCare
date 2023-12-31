package com.petCare.service;

import com.petCare.dto.centerDto.request.CenterDtoRequest;
import com.petCare.dto.centerDto.response.CenterDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface CenterService {
    Optional<CenterDtoResponse> getById(Long id);
    Optional<Page<CenterDtoResponse>> findAllByStatus(Pageable pageable);
    void deleteByIdByStatus (Long id);
    Optional<Page<CenterDtoResponse>> findAll(Pageable pageable);
    Optional<CenterDtoResponse> save(CenterDtoRequest centerDtoRequest);
    Optional<CenterDtoResponse> findCenterByUserId(Long id);
}
