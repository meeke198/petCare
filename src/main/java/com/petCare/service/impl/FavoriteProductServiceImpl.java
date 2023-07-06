package com.petCare.service.impl;

import com.petCare.converter.FavoriteProductConverter;
import com.petCare.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petCare.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petCare.entity.FavoriteProduct;
import com.petCare.repository.FavoriteProductRepository;
import com.petCare.service.FavoriteProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class FavoriteProductServiceImpl implements FavoriteProductService {
    private final FavoriteProductRepository favoriteProductRepository;
    private final FavoriteProductConverter favoriteProductConverter;
    @Override
    public FavoriteProductDtoResponse add(FavoriteProductDtoRequest favoriteProductDtoRequest) {
        FavoriteProduct favoriteProduct = favoriteProductConverter.dtoToEntity(favoriteProductDtoRequest);
        Optional<FavoriteProduct> currentFavoriteProduct = favoriteProductRepository
                .findFavoriteProductByFavoriteUserIdAndProductId(favoriteProductDtoRequest.getUserId()
                        , favoriteProductDtoRequest.getProductId());
        if(currentFavoriteProduct.isPresent()){
            return null;
        }
        favoriteProductRepository.save(favoriteProduct);
        return favoriteProductConverter.entityToDto(favoriteProduct);
    }

    @Override
    public void delete(Long id) {
        Optional<FavoriteProduct> favoriteProduct = Optional.ofNullable(favoriteProductRepository.getById(id));
        favoriteProductRepository.deleteById(id);
    }

    @Override
    public List<FavoriteProductDtoResponse> findAll() {
        List<FavoriteProduct> favoriteProducts = favoriteProductRepository.findAll();
        List<FavoriteProductDtoResponse> favoriteProductDtoResponses = new ArrayList<>();
        favoriteProductDtoResponses.addAll(favoriteProducts.stream().map(favoriteProductConverter::entityToDto).collect(Collectors.toList()));
        return favoriteProductDtoResponses;
    }

    @Override
    public Optional<FavoriteProductDtoResponse> getById(Long id) {
        Optional<FavoriteProduct> favoriteProduct = Optional.ofNullable(favoriteProductRepository.getById(id));
        return Optional.ofNullable(favoriteProductConverter.entityToDto(favoriteProduct.get()));
    }

    @Override
    public void deleteByUserIdAndProductId(Long userId, Long productId) {
        favoriteProductRepository.deleteFavoriteProductByFavoriteUserIdAndProductId(userId,productId);
    }
}
