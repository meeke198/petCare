package com.petCare.converter;

import com.petCare.entity.Mark;
import com.petCare.dto.markDto.request.MarkDtoRequest;
import com.petCare.dto.markDto.response.MarkDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class MarkConverter {
    public MarkDtoResponse entityToDto(Mark mark){
        MarkDtoResponse markDtoResponse = new MarkDtoResponse();
        BeanUtils.copyProperties(mark, markDtoResponse);
        return markDtoResponse;
    }
    public Mark dtoToEntity(MarkDtoRequest markDtoRequest){
        Mark mark= new Mark();
        BeanUtils.copyProperties(markDtoRequest, mark);
        return mark;
    }
}
