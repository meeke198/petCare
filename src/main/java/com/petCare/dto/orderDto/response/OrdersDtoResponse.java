package com.petCare.dto.orderDto.response;

import com.petCare.dto.orderDto.response.OrderDetailDtoResponse;
import com.petCare.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdersDtoResponse {
    private Long id;
    private String phoneNumber;
    private Double total;

    private String note;
    private Date date;
    private String address;
    private String status;
    private UserDtoResponse userDtoResponse;
    private List<OrderDetailDtoResponse> orderDetailDtoResponses = new ArrayList<>();
}
