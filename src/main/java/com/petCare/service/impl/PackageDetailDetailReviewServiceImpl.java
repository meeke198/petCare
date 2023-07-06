package com.petCare.service.impl;

import com.petCare.converter.PackageDetailReviewConverter;
import com.petCare.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petCare.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petCare.entity.PackageDetail;
import com.petCare.entity.PackageDetailReview;
import com.petCare.entity.User;
import com.petCare.repository.PackageDetailRepository;
import com.petCare.repository.PackageDetailReviewRepository;
import com.petCare.repository.PackageRepository;
import com.petCare.repository.UserRepository;
import com.petCare.service.PackageDetailReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class PackageDetailDetailReviewServiceImpl implements PackageDetailReviewService {
    private final PackageDetailReviewRepository packageDetailReviewRepository;
    private final PackageDetailReviewConverter packageDetailReviewConverter;
    private final UserRepository userRepository;
    private final PackageDetailRepository packageDetailRepository;
    private final PackageRepository packageRepository;

    @Override
    public Page<PackageDetailReviewDtoResponse> findAll(Pageable pageable) {
        Page<PackageDetailReview> packageReviews = packageDetailReviewRepository.findAll(pageable);
        return packageReviews.map(packageDetailReviewConverter::entityToDto);
    }

    @Override
    public PackageDetailReview savePackageDetailReview(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest) {
        PackageDetailReview packageDetailReview = packageDetailReviewConverter.dtoToEntity(packageDetailReviewDtoRequest);
        User user = userRepository.findUserByEmail(packageDetailReviewDtoRequest.getUserEmail());
        PackageDetail packageDetail = packageDetailRepository.findById(packageDetailReviewDtoRequest.getPackageDetailId()).get();
        packageDetailReview.setUser(user);
        packageDetailReview.setPackageDetail(packageDetail);
        return packageDetailReviewRepository.save(packageDetailReview);
    }

    @Override
    public Optional<PackageDetailReviewDtoResponse> getPackDetailReviewById(Long id) {
        PackageDetailReview packageDetailReview = packageDetailReviewRepository.getById(id);
        PackageDetailReviewDtoResponse packageDetailReviewDtoResponse = packageDetailReviewConverter.entityToDto(packageDetailReview);
        return Optional.of(packageDetailReviewDtoResponse);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageDetailReviewRepository.deleteByIdPackageReview(id);
    }

    @Override
    public Page<PackageDetailReviewDtoResponse> findPackageDetailReviewsByPackageDetail(Long id, Pageable pageable) {
        Page<PackageDetailReview> packageReviews = packageDetailReviewRepository.findPackageDetailReviewsByPackageDetailId(id, pageable);
        List<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponseArrayList = new ArrayList<>();
        packageReviews.forEach(packageReview -> {
            packageDetailReviewDtoResponseArrayList.add(packageDetailReviewConverter.entityToDto(packageReview));
        });
        Page<PackageDetailReviewDtoResponse> productDtoResponses = new PageImpl<>(packageDetailReviewDtoResponseArrayList);
        return productDtoResponses;
    }
}
