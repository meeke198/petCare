package com.petCare.service;

import com.petCare.dto.productDto.request.ProductDtoRequest;
import com.petCare.dto.productDto.request.UpdateProductDtoRequest;
import com.petCare.dto.productDto.response.ProductDetailDtoResponse;
import com.petCare.dto.productDto.response.ProductDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductService {

//    Page<ProductDtoResponse> getAllProducts(Pageable pageable);
//    Page<Product> getAllProducts(Pageable pageable)
    Page<ProductDtoResponse> getAllProducts(List<Long> categoryIds, Pageable pageable);
//    Page<ProductDtoResponse> getAllProducts(Pageable pageable);

    Page<ProductDtoResponse> searchAllProductsByNameAndDescription(String query, Pageable pageable);

    ProductDetailDtoResponse findById(Long id);
    void addProduct(ProductDtoRequest productDtoRequest);
    void deleteProductById(Long id);
    ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest);

    Page<ProductDtoResponse> getAllProductBo(Pageable pageable);

    List<ProductDtoResponse> findProductByName(String name);

}
