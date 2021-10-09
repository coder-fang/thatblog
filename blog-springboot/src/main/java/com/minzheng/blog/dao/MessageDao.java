package com.minzheng.blog.dao;

import com.minzheng.blog.entity.Message;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author xiaojie
 * @since 2020-05-18
 */
@Repository
public interface MessageDao extends BaseMapper<Message> {

}
