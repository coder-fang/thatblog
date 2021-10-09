package com.minzheng.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.dto.OperationLogDTO;
import com.minzheng.blog.dto.PageDTO;
import com.minzheng.blog.entity.OperationLog;
import com.minzheng.blog.vo.ConditionVO;

/**
 * @author: yezhiqiu
 * @date: 2021-01-31
 **/
public interface OperationLogService extends IService<OperationLog> {

    /**
     * 查询日志列表
     *
     * @param conditionVO 条件
     * @return 日志列表
     */
    PageDTO<OperationLogDTO> listOperationLogs(ConditionVO conditionVO);

}
