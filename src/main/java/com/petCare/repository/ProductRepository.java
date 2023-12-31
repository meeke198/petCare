package com.petCare.repository;


import com.petCare.dto.productDto.response.ProductDtoResponse;
import com.petCare.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query( value = "select p from Product p where p.status = true ")
    Page<Product> getAllProducts(List<Long> categoryIds, Pageable pageable);

    @Query("select p from Product p where p.category.id in (:id) and p.status = true")
    Page<Product> findByCategoryIds(@Param("id") List<Long> categoryIds, Pageable pageable);

    @Transactional
    @Modifying
    @Query("UPDATE Product p SET p.status = false WHERE p.id = :id")
    void deleteProductById(@Param("id") Long id);

    @Query( value = "select p from Product p ")
    Page<Product> getAllProductBo(Pageable pageable);

    @Query( value = "select p from Product p where p.name Like %:name%")
    List<Product> findProductByName(String name);
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :query, '%'))")
    Page<Product> searchAllProductsByNameAndDescription(@Param("query") String query, Pageable pageable);
}
