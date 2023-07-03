package com.petCare.service.impl;

import com.petCare.converter.OrderConverter;
import com.petCare.converter.OrderDetailConverter;
import com.petCare.dto.orderDto.request.OrderDetailDtoRequest;
import com.petCare.dto.orderDto.request.OrdersDtoRequest;
import com.petCare.dto.orderDto.response.OrdersDtoResponse;
import com.petCare.entity.OrderDetail;
import com.petCare.entity.Orders;
import com.petCare.repository.OrderRepository;
import com.petCare.service.OrderDetailService;
import com.petCare.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;
    private final OrderConverter orderConverter;
    private final OrderDetailService orderDetailService;
    private final OrderDetailConverter orderDetailConverter;


    @Override
    public List<OrdersDtoResponse> findOrderByEmail(String email) {
        List<Orders> orders = orderRepository.findOrdersByUserEmailOrderByDateDesc(email);
        List<OrdersDtoResponse> ordersDtoResponses = new ArrayList<>();
        orders.forEach(element -> ordersDtoResponses.add(orderConverter.entityToDto(element)));
        return ordersDtoResponses;
    }

    @Override
    public OrdersDtoResponse saveOrder(OrdersDtoRequest ordersDtoRequest) {
        Orders orders = orderConverter.dtoToEntity(ordersDtoRequest);
        Orders savedOrders = orderRepository.save(orders);
        List<OrderDetailDtoRequest> orderDetailDtoRequests = ordersDtoRequest.getOrderDetailDtoRequests();
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetailDtoRequests.forEach(element -> {
//            OrderDetail orderDetail = orderDetailConverter.dtoToEntity(element);
//            orderDetail.setOrders(savedOrders);
//            orderDetailService.saveOrderDetail(orderDetail);
//            orderDetails.add(orderDetail);
        });
        savedOrders.setOrderDetails(orderDetails);
        return orderConverter.entityToDto(savedOrders);
    }

    @Override
    public void updateOrder(Long id, String status) {
        Optional<Orders> orders = orderRepository.findById(id);
        if(orders.isPresent()){
            orders.get().setStatus(status);
            orderRepository.save(orders.get());
        }
    }
}
