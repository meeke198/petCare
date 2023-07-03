package com.petCare.converter;
import com.petCare.entity.Package;
import com.petCare.dto.packageDto.request.PackageDtoRequest;
import com.petCare.dto.packageDto.response.PackageDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class PackageConverter {
    private final ServiceConverter serviceConverter;
    public PackageDtoResponse entityToDto(Package servicePackage){
        PackageDtoResponse packageDtoResponse = new PackageDtoResponse();
        BeanUtils.copyProperties(servicePackage, packageDtoResponse);
        return packageDtoResponse;
    }
    public Package dtoToEntity(PackageDtoRequest packageDtoRequest){
        Package aPackage = new Package();
        BeanUtils.copyProperties(packageDtoRequest, aPackage);
        return aPackage;
    }
}
