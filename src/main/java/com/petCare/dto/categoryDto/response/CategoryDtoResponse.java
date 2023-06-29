package com.petCare.dto.categoryDto.response;

import com.petCare.dto.productDto.response.ProductDtoResponse;
import com.petCare.dto.productDto.response.ProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDtoResponse {
    private Long id;
    private String name;
    List<ProductDtoResponse> productDtoResponses;
}
