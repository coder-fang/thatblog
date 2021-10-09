package com.minzheng.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.minzheng.blog.entity.Menu;
import com.minzheng.blog.entity.OperationLog;
import org.springframework.stereotype.Repository;

/**
 * @author: yezhiqiu
 * @date: 2021-01-31
 **/
@Repository
public interface OperationLogDao extends BaseMapper<OperationLog> {
}
