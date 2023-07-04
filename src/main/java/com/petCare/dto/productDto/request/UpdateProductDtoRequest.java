package com.petCare.dto.productDto.request;

import com.petCare.dto.markDto.request.MarkDtoRequest;
import com.petCare.entity.ImageDetail;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateProductDtoRequest {
    private Long id;
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
    private Boolean status;
    private Integer sale;
    private MarkDtoRequest mark;
    private List<ImageDetail> imageDetailList;

}
