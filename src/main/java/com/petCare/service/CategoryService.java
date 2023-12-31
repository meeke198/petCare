package com.petCare.service;

import com.petCare.dto.categoryDto.response.CategoryDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface CategoryService {
    Page<CategoryDtoResponse> getAllCategory(Pageable pageable);

    Optional<CategoryDtoResponse> getById(Long id);


}
