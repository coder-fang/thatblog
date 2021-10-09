package com.minzheng.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.minzheng.blog.dao.ChatRecordDao;
import com.minzheng.blog.entity.ChatRecord;
import com.minzheng.blog.service.ChatRecordService;
import com.minzheng.blog.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author: yezhiqiu
 * @date: 2021-02-19
 **/
@Service
public class ChatRecordServiceImpl extends ServiceImpl<ChatRecordDao, ChatRecord> implements ChatRecordService {
    @Autowired
    private ChatRecordDao chatRecordDao;

    @Override
    public void deleteChartRecord() {
        String time = DateUtil.getMinTime(DateUtil.getSomeDay(new Date(), -7));
        chatRecordDao.delete(new LambdaQueryWrapper<ChatRecord>()
                .le(ChatRecord::getCreateTime,time));
    }

}
