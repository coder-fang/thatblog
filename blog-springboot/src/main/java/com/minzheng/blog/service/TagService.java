package com.minzheng.blog.service;

import com.minzheng.blog.dto.PageDTO;
import com.minzheng.blog.dto.TagDTO;
import com.minzheng.blog.entity.Tag;
import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.vo.ConditionVO;
import com.minzheng.blog.vo.TagVO;

import java.util.List;

/**
 *
 * @author xiaojie
 * @since 2020-05-18
 */
public interface TagService extends IService<Tag> {

    /**
     * 查询标签列表
     *
     * @return 标签列表
     */
    PageDTO<TagDTO> listTags();

    /**
     * 查询后台标签
     *
     * @param condition 条件
     * @return 标签列表
     */
    PageDTO<Tag> listTagBackDTO(ConditionVO condition);

    /**
     * 删除标签
     *
     * @param tagIdList 标签id集合
     */
    void deleteTag(List<Integer> tagIdList);

    /**
     * 保存或更新标签
     * @param tagVO 标签
     */
    void saveOrUpdateTag(TagVO tagVO);

}
