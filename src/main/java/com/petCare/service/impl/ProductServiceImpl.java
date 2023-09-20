package com.petCare.service.impl;

import com.petCare.converter.CategoryConverter;
//import com.petCare.converter.ImageDetailsConverter;
import com.petCare.converter.ProductConverter;
import com.petCare.dto.categoryDto.response.CategoryDtoResponse;
import com.petCare.dto.productDto.request.ProductDtoRequest;
import com.petCare.dto.productDto.request.UpdateProductDtoRequest;
import com.petCare.dto.productDto.response.ProductDetailDtoResponse;
import com.petCare.dto.productDto.response.ProductDtoResponse;
import com.petCare.entity.Product;
import com.petCare.repository.CategoryRepository;
import com.petCare.repository.ImageDetailRepository;
import com.petCare.repository.MarkRepository;
import com.petCare.repository.ProductRepository;
import com.petCare.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;
    private final ProductConverter productConverter;
//    private final CategoryRepository categoryRepository;
//    private final ImageDetailRepository imageDetailRepository;
    private final CategoryConverter categoryConverter;
//    private final MarkRepository markRepository;
//    private final ImageDetailsConverter imageDetailsConverter;

    @Override
    public Page<ProductDtoResponse> getAllProducts(List<Long> categoryIds, Pageable pageable) {
        Page<Product> products;
        if (categoryIds == null) {
            products = productRepository.getAllProductBo(pageable);
        } else {
            products = productRepository.findByCategoryIds(categoryIds, pageable);
        }
//        if (!products.isEmpty()) {
            Page<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
            return productDtoResponses;
//        }
//        return null;
    }

    @Override
    public ProductDetailDtoResponse findById(Long id) {
        Product product = productRepository.findById(id).get();
        if (product != null) {
            ProductDetailDtoResponse productDetailDtoResponse = productConverter.entityToProductDetailDto(product);
            CategoryDtoResponse categoryDtoResponse = categoryConverter.entityToDto(product.getCategory());

            productDetailDtoResponse.setCategoryDtoResponse(categoryDtoResponse);
            return productDetailDtoResponse;
        }
        return null;
    }

    @Override
    public void addProduct(ProductDtoRequest productDtoRequest) {
        if (productDtoRequest != null) {
            Product product = productConverter.dtoToEntity(productDtoRequest);
            product.setStatus(true);
//            product.setCategory(categoryRepository.findById(productDtoRequest.getCategoryId()).get());
            productRepository.save(product);
            productDtoRequest.getImageDetail().forEach(element -> {
                element.setProduct(product);
//                imageDetailRepository.save(element);
            });

        } else {
            System.out.println("Don't save database");
        }
    }

    @Override
    public void deleteProductById(Long id) {
        productRepository.deleteProductById(id);
    }

    @Override
    public ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest) {
        Product product = productRepository.findById(id).orElse(null);
        product = productConverter.dtoToEntity(updateProductDtoRequest, product);
        product.setImageDetails(updateProductDtoRequest.getImageDetailList());
        Product finalProduct = product;
        updateProductDtoRequest.getImageDetailList().forEach(imageDetail -> {
            imageDetail.setProduct(finalProduct);
//            imageDetailRepository.save(imageDetail);
        });
        productRepository.save(product);
        ProductDetailDtoResponse productDetailDtoResponse = findById(id);
        return productDetailDtoResponse;
    }


    @Override
    public Page<ProductDtoResponse> getAllProductBo(Pageable pageable) {

        Page<Product> products = productRepository.getAllProductBo(pageable);
        if (!products.isEmpty()) {
            Page<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
            return productDtoResponses;
        }
        return null;
    }

    @Override
    public List<ProductDtoResponse> findProductByName(String name) {
        List<Product> products = productRepository.findProductByName(name);
        List<ProductDtoResponse> productDtoResponses = new ArrayList<>();
        for (Product product : products) {
            ProductDtoResponse productDtoResponse = productConverter.entityToDto(product);
            productDtoResponses.add(productDtoResponse);
        }
        return productDtoResponses;
    }

    @Override
    public Page<ProductDtoResponse> searchAllProductsByNameAndDescription(String query, Pageable pageable) {
//        Page<Product> products;
//        Page<ProductDtoResponse> productsResponseDtos = null;
//        if (query.isEmpty()) {
//            products = productRepository.getAllProductBo(pageable);
//            if(!products.isEmpty()){
//                productsResponseDtos = productConverter.entitiesToDtos(products);
//            }
//        } else {
//            productsResponseDtos = productRepository.searchAllProductsByNameAndDescription(query, pageable);
//        }
//        return productsResponseDtos;
        Page<Product> products;
        if (query.isEmpty()) {

            products = productRepository.getAllProductBo(pageable);
        } else {
            products = productRepository.searchAllProductsByNameAndDescription(query, pageable);
        }
        if (!products.isEmpty()) {
            Page<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
            return productDtoResponses;
        }
        return null;
    }
}
