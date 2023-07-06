package com.petCare.service;

import com.petCare.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petCare.dto.favoriteProductDto.response.FavoriteProductDtoResponse;

import java.util.List;
import java.util.Optional;

public interface FavoriteProductService {
    FavoriteProductDtoResponse add(FavoriteProductDtoRequest favoriteProductDtoRequest);

    void delete(Long id);

    List<FavoriteProductDtoResponse> findAll();

    Optional<FavoriteProductDtoResponse> getById(Long id);

    void deleteByUserIdAndProductId(Long userId, Long productId);
}
