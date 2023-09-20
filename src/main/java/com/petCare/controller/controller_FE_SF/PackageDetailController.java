package com.petCare.controller.controller_FE_SF;


import com.petCare.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petCare.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petCare.repository.PackageDetailRepository;
import com.petCare.service.PackageDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/package-details" )
@RequiredArgsConstructor
public class PackageDetailController {
    private final PackageDetailRepository packageDetailRepository;
    private final PackageDetailService packageDetailService;

    @GetMapping("")
    public ResponseEntity<?> getAllPackageDetails(@PageableDefault(size = 9) Pageable pageable) {
        Page<PackageDetailDtoResponse> packageDetailDtoResponses = packageDetailService.findAll(pageable);
        if (packageDetailDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDetailDtoResponses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPackageDetail(@PathVariable("id") Long id){
        Optional<PackageDetailDtoResponse> packageDetail = packageDetailService.getPackageDetail(id);
        if(packageDetail.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDetail);
    }

    @GetMapping("/center/{userEmail}")
    public ResponseEntity<?> getPackageDetailsByCenter (@PathVariable("userEmail") String userEmail){
        List<PackageDetailDtoResponse> packageDetailDtoResponses = packageDetailService.findByUserEmail(userEmail);
        if (packageDetailDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDetailDtoResponses);
    }

    @PostMapping("")
    public ResponseEntity<PackageDetailDtoResponse> savePackages(@RequestBody PackageDetailDtoRequest packageDetailDtoRequest){
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("api/packages").toUriString());
        return ResponseEntity.created(uri).body(packageDetailService.savePackageDetail(packageDetailDtoRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Optional<PackageDetailDtoResponse>> removePackage(@PathVariable("id") Long id){
        Optional<PackageDetailDtoResponse> packageDetailDtoResponse = packageDetailService.getPackageDetail(id);
        if(packageDetailDtoResponse.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            packageDetailService.deleteByIdByStatus(id);
            return ResponseEntity.ok().body(packageDetailService.getPackageDetail(id));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePackage(@RequestBody PackageDetailDtoRequest packageDetailDtoRequest){
        Optional<PackageDetailDtoResponse> editedPackage = packageDetailService.getPackageDetail(packageDetailDtoRequest.getId());
        if(editedPackage.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok().body(packageDetailService.savePackageDetail(packageDetailDtoRequest));
        }
    }

    @GetMapping("/search/{packageId}")
    public ResponseEntity<?> getAllPackageDetailByPackageName(@PathVariable("packageId") Long packageId,Pageable pageable){
        Page<PackageDetailDtoResponse> packageDetailDtoResponses = packageDetailService.findPackageDetailByPackageId(packageId,pageable);
        if (packageDetailDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(packageDetailDtoResponses);
    }
}
