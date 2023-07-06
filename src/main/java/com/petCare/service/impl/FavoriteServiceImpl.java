package com.petCare.service.impl;

import com.petCare.converter.FavoriteConverter;
import com.petCare.dto.favoriteDto.response.FavoriteDtoResponse;
import com.petCare.entity.Favorite;
import com.petCare.repository.FavoriteRepository;
import com.petCare.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class FavoriteServiceImpl implements FavoriteService {
    private final FavoriteRepository favoriteRepository;
    private final FavoriteConverter favoriteConverter;
    @Override
    public Page<FavoriteDtoResponse> getAll(Pageable pageable) {
        Page<Favorite> favorites = favoriteRepository.findAll(pageable);

        return favorites.map(favoriteConverter::entityToDto);
    }

    @Override
    public Optional<FavoriteDtoResponse> getById(Long id) {
        return Optional.ofNullable(favoriteConverter.
                entityToDto(favoriteRepository.getById(id)));
    }

    @Override
    public Optional<FavoriteDtoResponse> getByUserId(Long id) {
        return Optional.ofNullable(favoriteConverter.
                entityToDto(favoriteRepository.findFavoriteByUserId(id).get()));
    }
}
