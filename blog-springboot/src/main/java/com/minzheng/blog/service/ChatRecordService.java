package com.minzheng.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.entity.ChatRecord;

/**
 * @author: yezhiqiu
 * @date: 2021-02-19
 **/
public interface ChatRecordService extends IService<ChatRecord> {

    /**
     * 删除7天前的聊天记录
     */
    void deleteChartRecord();

}
