package com.petCare.service;

import com.petCare.dto.orderDto.request.OrdersDtoRequest;
import com.petCare.dto.orderDto.response.OrdersDtoResponse;

import java.util.List;

public interface OrderService {
    List<OrdersDtoResponse> findOrderByEmail(String email);

    OrdersDtoResponse saveOrder(OrdersDtoRequest ordersDtoRequest);
    void updateOrder(Long id, String status);
}
