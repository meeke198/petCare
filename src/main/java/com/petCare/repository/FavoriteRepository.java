package com.petCare.repository;

import com.petCare.entity.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FavoriteRepository extends JpaRepository <Favorite,Long> {
    Optional<Favorite> findFavoriteByUserId(Long id);
}
