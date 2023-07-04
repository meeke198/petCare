package com.petCare.service;

import com.petCare.dto.CategoryDtoResponse;
import com.petCare.dto.cartDto.request.CartDetailDtoRequest;
import com.petCare.dto.cartDto.response.CartDetailDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface CartService {
    List<CartDetailDtoResponse> getCartByEmail(String email);
    void addToCart( CartDetailDtoRequest cartDetailDtoRequest);
    void removeToCart (CartDetailDtoRequest cartDetailDtoRequest);
    void deleteAllItemsInCart(List<Long> cartDetailIds);
}
