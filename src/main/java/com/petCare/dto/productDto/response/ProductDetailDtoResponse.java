package com.petCare.dto.productDto.response;

import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.dto.imagedetailDto.response.ImageDetailsDto;
import com.petworld.entity.Mark;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ProductDetailDtoResponse {
    private Long id ;
    private String name;
    private String description;
    private String image;
    private Double price;
    private String productCode;
    private String protein;
    private String fats;
    private String carbohydrates;
    private String minerals;
    private String vitamins;
    private String animal;
    private Integer sale;
    private Mark mark;
    private Boolean status;
    private CategoryDtoResponse categoryDtoResponse;
    private List<ImageDetailsDto> imageDetailList;
}
