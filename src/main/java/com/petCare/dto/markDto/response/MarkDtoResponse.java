package com.petCare.dto.markDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarkDtoResponse {
    private String tag;
    @Column(name = "tag_badge")
    private String tagBadge;
}
