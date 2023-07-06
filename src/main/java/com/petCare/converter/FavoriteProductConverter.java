package com.petCare.converter;

import com.petCare.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petCare.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petCare.entity.Favorite;
import com.petCare.entity.FavoriteProduct;
import com.petCare.entity.Product;
import com.petCare.repository.FavoriteRepository;
import com.petCare.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
@RequiredArgsConstructor
public class FavoriteProductConverter {
    private final ProductRepository productRepository;
    private final FavoriteRepository favoriteRepository;
    private final ProductConverter productConverter;

    public FavoriteProductDtoResponse entityToDto(FavoriteProduct favoriteProduct){
        FavoriteProductDtoResponse favoriteProductDtoResponse = new FavoriteProductDtoResponse();
        BeanUtils.copyProperties(favoriteProduct,favoriteProductDtoResponse);
        favoriteProductDtoResponse.setProductDtoResponse(productConverter.entityToDto(favoriteProduct.getProduct()));
        return favoriteProductDtoResponse;
    }

    public FavoriteProduct dtoToEntity(FavoriteProductDtoRequest favoriteProductDtoRequest) {
        FavoriteProduct favoriteProduct = new FavoriteProduct();
        Optional<Product> product = productRepository.findById(favoriteProductDtoRequest.getProductId());
        favoriteProduct.setProduct(product.get());
        Optional<Favorite> favorite = favoriteRepository.findFavoriteByUserId(favoriteProductDtoRequest.getUserId());
        favoriteProduct.setFavorite(favorite.get());
        return favoriteProduct;
    }
}
