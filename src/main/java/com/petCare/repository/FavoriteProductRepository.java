package com.petCare.repository;

import com.petCare.entity.FavoriteProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FavoriteProductRepository extends JpaRepository<FavoriteProduct,Long> {
    void deleteFavoriteProductByFavoriteUserIdAndProductId(Long UserId,Long productId);
    Optional<FavoriteProduct> findFavoriteProductByFavoriteUserIdAndProductId(Long userId, Long productId);
}
