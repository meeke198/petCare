package com.petCare.service.impl;

import com.petCare.converter.OrderDetailConverter;
import com.petCare.entity.OrderDetail;
import com.petCare.repository.OrderDetailRepository;
import com.petCare.service.OrderDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderDetailServiceImpl implements OrderDetailService{
    private final OrderDetailRepository orderDetailRepository;
    private final OrderDetailConverter orderDetailConverter;


    @Override
    public OrderDetail saveOrderDetail(OrderDetail orderDetail) {
       return orderDetailRepository.save(orderDetail);
    }
}
