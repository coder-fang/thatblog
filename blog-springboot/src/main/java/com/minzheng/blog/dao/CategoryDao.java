package com.minzheng.blog.dao;

import com.minzheng.blog.dto.CategoryDTO;
import com.minzheng.blog.entity.Category;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *
 * @author xiaojie
 * @since 2020-05-18
 */
@Repository
public interface CategoryDao extends BaseMapper<Category> {

    /**
     * 查询分类和对应文章数量
     * @return 分类集合
     */
    List<CategoryDTO> listCategoryDTO();

}
