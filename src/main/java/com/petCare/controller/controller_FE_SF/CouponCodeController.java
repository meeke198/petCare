package com.petCare.controller.controller_FE_SF;

import com.petCare.dto.couponCodeDto.response.CouponCodeDtoResponse;
import com.petCare.service.CouponCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/couponcode")
@RequiredArgsConstructor
public class CouponCodeController {
    private final CouponCodeService couponCodeService;
    @GetMapping("/search")
    public ResponseEntity<?> searchCouponCode(@RequestParam("currentDate") Date date,
                                              @RequestParam("cartTotals") Double cartTotals) {
        List<CouponCodeDtoResponse> couponCodeDtoResponses = couponCodeService.getCouponCode(date, cartTotals);
        return new ResponseEntity<>(couponCodeDtoResponses, HttpStatus.OK);
    }
}
