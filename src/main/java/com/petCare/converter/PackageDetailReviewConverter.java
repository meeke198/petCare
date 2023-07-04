package com.petCare.converter;

import com.petCare.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petCare.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petCare.dto.userDto.response.UserDtoResponse;
import com.petCare.entity.PackageDetailReview;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class PackageDetailReviewConverter {
    private final UserConverter userConverter;

    public PackageDetailReviewDtoResponse entityToDto(PackageDetailReview packageDetailReview){
        PackageDetailReviewDtoResponse packageDetailReviewDtoResponse = new PackageDetailReviewDtoResponse();
        BeanUtils.copyProperties(packageDetailReview, packageDetailReviewDtoResponse);
        UserDtoResponse userDtoResponse = userConverter.entityToDto(packageDetailReview.getUser());
        packageDetailReviewDtoResponse.setUserDtoResponse(userDtoResponse);
        return packageDetailReviewDtoResponse;
    }
    public PackageDetailReview dtoToEntity(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest){
        PackageDetailReview packageDetailReview = new PackageDetailReview();
        BeanUtils.copyProperties(packageDetailReviewDtoRequest, packageDetailReview);
        return packageDetailReview;
    }
}
