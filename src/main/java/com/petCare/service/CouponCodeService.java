package com.petCare.service;

import com.petCare.dto.couponCodeDto.response.CouponCodeDtoResponse;

import java.sql.Date;
import java.util.List;

public interface CouponCodeService {
    List<CouponCodeDtoResponse> getCouponCode(Date date, Double cartTotals);
}
