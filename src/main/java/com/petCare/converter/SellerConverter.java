package com.petCare.converter;

import com.petCare.dto.sellerDto.request.SellerDtoRequest;
import com.petCare.dto.sellerDto.response.SellerDtoResponse;
import com.petCare.entity.Seller;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class SellerConverter {
    public SellerDtoResponse entityToDto(Seller seller){
        SellerDtoResponse sellerDtoResponse = new SellerDtoResponse();
        BeanUtils.copyProperties(seller,sellerDtoResponse);
        return sellerDtoResponse;
    }
    public Seller dtoToEntity(SellerDtoRequest sellerDtoRequest){
        Seller seller = new Seller();
        BeanUtils.copyProperties(sellerDtoRequest, seller);
        return seller;
    }
}
