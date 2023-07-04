package com.petCare.converter;


import com.petCare.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petCare.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petCare.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petCare.dto.serviceDto.response.ServiceDtoResponse;
import com.petCare.entity.Center;
import com.petCare.entity.PackageDetail;
import com.petCare.entity.PackageDetailReview;
import com.petCare.entity.Service;
import com.petCare.repository.CenterRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@AllArgsConstructor
public class PackageDetailConverter {
    private CenterRepository centerRepository;
    private ServiceConverter serviceConverter;
    private PackageDetailReviewConverter packageDetailReviewConverter;
    public PackageDetailDtoResponse entityToDto(PackageDetail packageDetail){
        PackageDetailDtoResponse packageDetailDtoResponse = new PackageDetailDtoResponse();
        BeanUtils.copyProperties(packageDetail,packageDetailDtoResponse);
        List<Service> services = packageDetail.getServices();
        if(!services.isEmpty()) {
            List<ServiceDtoResponse> serviceDtoResponses = services.stream().
                    map(serviceConverter::entityToDto).collect(Collectors.toList());
            Page<ServiceDtoResponse> servicesDto = new PageImpl<ServiceDtoResponse>(serviceDtoResponses);
            packageDetailDtoResponse.setServiceDtoResponses(servicesDto);
        }
        List<PackageDetailReview> packageDetailReviews = packageDetail.getPackageDetailReviews();
        if(!packageDetailReviews.isEmpty()) {
            List<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponses = packageDetailReviews.
                    stream().map(packageDetailReviewConverter::entityToDto).collect(Collectors.toList());
            Page<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponsePage = new PageImpl<PackageDetailReviewDtoResponse>(packageDetailReviewDtoResponses);
            packageDetailDtoResponse.setPackageDetailReviewDtoResponses(packageDetailReviewDtoResponsePage);
        }
        packageDetailDtoResponse.setPackageName(packageDetail.getServicePackage().getName());
        packageDetailDtoResponse.setCenterName(packageDetail.getCenter().getName());
        return packageDetailDtoResponse;
    }

    public PackageDetail dtoToEntity(PackageDetailDtoRequest packageDetailDtoRequest){
        PackageDetail packageDetail = new PackageDetail();
        BeanUtils.copyProperties(packageDetailDtoRequest,packageDetail);
        Center center = centerRepository.findCenterByUserEmail(packageDetailDtoRequest.getUserEmail());
        packageDetail.setCenter(center);
        return packageDetail;
    }
}
