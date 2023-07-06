package com.petCare.dto.imageDetailDto.response;

import com.petworld.entity.Product;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ImageDetailsDto {
    private Long id;
    private String url;
}
