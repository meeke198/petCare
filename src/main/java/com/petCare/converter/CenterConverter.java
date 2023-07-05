package com.petCare.converter;

import com.petCare.dto.centerDto.request.CenterDtoRequest;
import com.petCare.dto.centerDto.response.CenterDtoResponse;
import com.petCare.entity.Center;
import com.petCare.entity.User;
import com.petCare.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CenterConverter {
    private final UserRepository userRepository;
    public CenterDtoResponse entityToDto(Center center){
        CenterDtoResponse centerDtoResponse = new CenterDtoResponse();
        BeanUtils.copyProperties(center,centerDtoResponse);
        return centerDtoResponse;
    }

    public Center dtoToEntity(CenterDtoRequest centerDtoRequest){
        Center center = new Center();
        User user = userRepository.findUserByEmail(centerDtoRequest.getUserEmail());
        BeanUtils.copyProperties(centerDtoRequest, center);
        center.setUser(user);
        return center;
    }
}
