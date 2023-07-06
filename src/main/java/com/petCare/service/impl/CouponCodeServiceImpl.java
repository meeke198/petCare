package com.petCare.service.impl;

import com.petCare.converter.CouponCodeConverter;
import com.petCare.entity.CouponCode;
import com.petCare.dto.couponCodeDto.response.CouponCodeDtoResponse;
import com.petCare.repository.CouponCodeRepository;
import com.petCare.service.CouponCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponCodeServiceImpl implements CouponCodeService {
    private final CouponCodeRepository couponCodeRepository;
    private final CouponCodeConverter couponCodeConverter;
    @Override
    public List<CouponCodeDtoResponse> getCouponCode(Date date, Double cartTotals) {
        if(date != null && cartTotals != null) {
            List<CouponCode> couponCodes = couponCodeRepository.availableCouponCode(date,cartTotals);
            if (!couponCodes.isEmpty()) {
                List<CouponCodeDtoResponse> couponCodeDtoResponses = couponCodeConverter.entitiesToResponseDtos(couponCodes);
                return couponCodeDtoResponses;
            }
        }
        return null;
    }
}
