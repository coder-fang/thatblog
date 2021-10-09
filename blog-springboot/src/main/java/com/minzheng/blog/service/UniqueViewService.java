package com.minzheng.blog.service;

import com.minzheng.blog.dto.UniqueViewDTO;
import com.minzheng.blog.entity.UniqueView;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author xiaojie
 * @since 2020-05-18
 */
public interface UniqueViewService extends IService<UniqueView> {

    /**
     * 统计每日用户量
     */
    void saveUniqueView();

    /**
     * 获取7天用户量统计
     * @return 用户量
     */
    List<UniqueViewDTO> listUniqueViews();

}
