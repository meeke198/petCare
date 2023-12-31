package com.petCare.dto.PackageDetailDto.response;

import com.petCare.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petCare.dto.serviceDto.response.ServiceDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Page;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PackageDetailDtoResponse {
    private Long id;
    private String description;
    private Double price;
    private String image;
    private Boolean isActive;
    private String status;
    private String packageName;
    private String centerName;
    private Page<ServiceDtoResponse> serviceDtoResponses;
    private Page<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponses;
}
