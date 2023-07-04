package com.petCare.converter;

import com.petCare.dto.orderDto.response.OrderDetailDtoResponse;
import com.petCare.dto.orderDto.request.OrdersDtoRequest;
import com.petCare.dto.orderDto.response.OrdersDtoResponse;
//import com.petCare.dto.userDto.response.UserDtoResponse;
import com.petCare.entity.Orders;
import com.petCare.entity.User;
import com.petCare.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class OrderConverter {
//    private final UserConverter userConverter;
    private final UserRepository userRepository;


    public OrdersDtoResponse entityToDto(Orders order){
        OrdersDtoResponse ordersDtoResponse = new OrdersDtoResponse();
        BeanUtils.copyProperties(order, ordersDtoResponse);
//        UserDtoResponse userDtoResponse = userConverter.entityToDto(order.getUser());
        List< OrderDetailDtoResponse> orderDetailDtoResponses = new ArrayList<>();
        order.getOrderDetails().forEach(element -> {
            OrderDetailDtoResponse orderDetailDtoResponse = new OrderDetailDtoResponse();
            BeanUtils.copyProperties(element, orderDetailDtoResponse);
            orderDetailDtoResponses.add(orderDetailDtoResponse);
        });
        ordersDtoResponse.setOrderDetailDtoResponses(orderDetailDtoResponses);
//        ordersDtoResponse.setUserDtoResponse(userDtoResponse);
        return ordersDtoResponse;
    };

    public Orders dtoToEntity(OrdersDtoRequest ordersDtoRequest){
        Orders orders = new Orders();
        BeanUtils.copyProperties(ordersDtoRequest, orders);
        User user = userRepository.findUserByEmail(ordersDtoRequest.getUserEmail());
        orders.setUser(user);
        return orders;
    }

}
