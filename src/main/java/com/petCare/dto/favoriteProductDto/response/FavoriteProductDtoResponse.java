package com.petCare.dto.favoriteProductDto.response;

import com.petCare.dto.productDto.response.ProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteProductDtoResponse {
    private Long id;
    private ProductDtoResponse productDtoResponse;
}
