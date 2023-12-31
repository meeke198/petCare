package com.petCare.controller.controller_FE_SF;

import com.petCare.dto.categoryDto.response.CategoryDtoResponse;
import com.petCare.dto.productDto.request.ProductDtoRequest;
import com.petCare.dto.productDto.request.UpdateProductDtoRequest;
import com.petCare.dto.productDto.response.ProductDetailDtoResponse;
import com.petCare.dto.productDto.response.ProductDtoResponse;
import com.petCare.service.ProductService;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    @GetMapping("")
    public ResponseEntity<?> getAllProducts(@PageableDefault(size = 9) Pageable pageable,
                                            @RequestParam(required = false) List<Long> categoryIds) {
        System.out.println(categoryIds);
        Page<ProductDtoResponse> productDtoResponses = productService.getAllProducts(categoryIds, pageable);
        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
    }
//    @GetMapping("/categories")
//    public ResponseEntity<?> getAllProductsByCategories(@PageableDefault(size = 9) Pageable pageable,
//                                            @RequestParam(required = false) List<Long> categoryIds) {
//        System.out.println(categoryIds);
//        Page<ProductDtoResponse> productDtoResponses = productService.getAllProducts(categoryIds, pageable);
//        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
//    }

    @GetMapping("/all")
    public ResponseEntity<?> getAllProductBo(Pageable pageable) {
        Page<ProductDtoResponse> productDtoResponses = productService.getAllProductBo(pageable);
        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
    }



    @GetMapping("/{id}")
    public ResponseEntity<?> findProductById(@PathVariable("id") Long id){
        ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<?> addProduct(@RequestBody ProductDtoRequest productDtoRequest){
            productService.addProduct(productDtoRequest);
            return new ResponseEntity<>(HttpStatus.OK);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProductById(@PathVariable("id") Long id) {
        ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
        productService.deleteProductById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }



    @PutMapping("/{id}")
    public ResponseEntity<?> updateProductById(@PathVariable("id") Long id,
                                               @RequestBody UpdateProductDtoRequest updateProductDtoRequest) {
        ProductDetailDtoResponse productDetailDtoResponse = productService.updateProductById(id, updateProductDtoRequest);
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }


    @GetMapping("/search")
    public ResponseEntity<?> searchAllProducts(Pageable pageable,
                                            @RequestParam String query) {
        System.out.println(query);
        Page<ProductDtoResponse> productDtoResponses;
        if(query.isEmpty()){
           productDtoResponses = productService.getAllProductBo(pageable);
        } else {
            productDtoResponses = productService.searchAllProductsByNameAndDescription(query, pageable);
        }
        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
    }
}
