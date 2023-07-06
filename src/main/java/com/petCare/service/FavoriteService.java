package com.petCare.service;

import com.petCare.dto.favoriteDto.response.FavoriteDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface FavoriteService {
    Page<FavoriteDtoResponse> getAll(Pageable pageable);

    Optional<FavoriteDtoResponse> getById(Long id);

    Optional<FavoriteDtoResponse> getByUserId(Long id);
}
