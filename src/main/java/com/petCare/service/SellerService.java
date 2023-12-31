package com.petCare.service;

import com.petCare.dto.sellerDto.request.SellerDtoRequest;
import com.petCare.dto.sellerDto.response.SellerDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface SellerService {
    Optional<SellerDtoResponse> getById(Long id);
    Optional<Page<SellerDtoResponse>> findAll(Pageable pageable);

    Optional<SellerDtoResponse> deleteByIdByStatus (Long id);

    Optional<SellerDtoResponse> save(SellerDtoRequest sellerDtoRequest);

    List<SellerDtoResponse> findSellersByCenterUserEmail(String email);
}
