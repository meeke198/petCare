package com.petCare.service;

import com.petCare.dto.imageDetailDto.request.UpdateImageDetailDto;
import com.petCare.dto.imageDetailDto.response.ImageDetailsDto;

import java.util.List;

public interface ImageDetailService {
    List<ImageDetailsDto> findImageDetailById(Long id);
    Boolean updateImageDetail(Long id, List<UpdateImageDetailDto> updateImageDetailDtos);
}
