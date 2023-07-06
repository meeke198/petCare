package com.petCare.dto.favoriteDto.response;

import com.petCare.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteDtoResponse {
    private Long id;

    private Set<FavoriteProductDtoResponse> favoriteProductDtoResponses;
}
