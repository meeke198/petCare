package com.petCare.controller.controller_FE_SF;

import com.petCare.dto.categoryDto.response.CategoryDtoResponse;
import com.petCare.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/categories")
@CrossOrigin("*")
public class CategoryController {
    private final CategoryService categoryService;

    @GetMapping("")
    public ResponseEntity<?> getAllCategory(Pageable pageable) {
        Page<CategoryDtoResponse> categories = categoryService.getAllCategory(pageable);
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCategoryById(@PathVariable Long id){
        Optional<CategoryDtoResponse> categoryDtoResponse = categoryService.getById(id);
        if(categoryDtoResponse.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(categoryDtoResponse);
    }
}
