package com.petCare.service;

import com.petCare.dto.cartDto.request.CartDetailDtoRequest;
import com.petCare.dto.cartDto.response.CartDetailDtoResponse;

import java.util.List;

public interface CartService {
    List<CartDetailDtoResponse> getCartByEmail(String email);
    void addToCart( CartDetailDtoRequest cartDetailDtoRequest);
    void removeToCart (CartDetailDtoRequest cartDetailDtoRequest);
    void deleteAllItemsInCart(List<Long> cartDetailIds);
}
