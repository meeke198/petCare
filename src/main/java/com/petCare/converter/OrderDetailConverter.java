package com.petCare.converter;

import com.petCare.dto.orderDto.request.OrderDetailDtoRequest;
import com.petCare.dto.orderDto.response.OrderDetailDtoResponse;
import com.petCare.dto.orderDto.response.OrdersDtoResponse;
import com.petCare.entity.OrderDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OrderDetailConverter {
    private final OrderConverter orderConverter;

    public OrderDetailDtoResponse entityToDto(OrderDetail orderDetail){
        OrderDetailDtoResponse orderDetailDtoResponse = new OrderDetailDtoResponse();
        BeanUtils.copyProperties(orderDetail, orderDetailDtoResponse);
        OrdersDtoResponse ordersDtoResponse = orderConverter.entityToDto(orderDetail.getOrders());
        orderDetailDtoResponse.setOrders(ordersDtoResponse);
        return orderDetailDtoResponse;
    };

    public OrderDetail dtoToEntity(OrderDetailDtoRequest orderDetailDtoRequest){
        OrderDetail orderDetail = new OrderDetail();
        BeanUtils.copyProperties(orderDetailDtoRequest, orderDetail);
        return orderDetail;
    }
}
