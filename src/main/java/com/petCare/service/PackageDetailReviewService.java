package com.petCare.service;

import com.petCare.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petCare.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petCare.entity.PackageDetailReview;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface PackageDetailReviewService {
    Page<PackageDetailReviewDtoResponse> findAll(Pageable pageable);

    PackageDetailReview savePackageDetailReview(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest);

    Optional<PackageDetailReviewDtoResponse> getPackDetailReviewById(Long id);

    void deleteByIdByStatus(Long id);

    Page<PackageDetailReviewDtoResponse> findPackageDetailReviewsByPackageDetail(Long id, Pageable pageable);
}
