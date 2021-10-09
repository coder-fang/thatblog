package com.minzheng.blog.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 角色选项DTO
 *
 * @author: yezhiqiu
 * @date: 2021-01-24
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class labelOptionDTO {

    /**
     * 选项id
     */
    private Integer id;

    /**
     * 选项名
     */
    private String label;

    /**
     * 子选项
     */
    private List<labelOptionDTO> children;

}
