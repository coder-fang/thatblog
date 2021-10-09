package com.minzheng.blog.service;

import com.minzheng.blog.dto.MessageBackDTO;
import com.minzheng.blog.dto.PageDTO;
import com.minzheng.blog.vo.ConditionVO;
import com.minzheng.blog.vo.MessageVO;
import com.minzheng.blog.dto.MessageDTO;
import com.minzheng.blog.entity.Message;
import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.vo.DeleteVO;

import java.util.List;

/**
 * @author xiaojie
 * @since 2020-05-18
 */
public interface MessageService extends IService<Message> {

    /**
     * 添加留言弹幕
     *
     * @param messageVO 留言对象
     */
    void saveMessage(MessageVO messageVO);

    /**
     * 查看留言弹幕
     *
     * @return 留言列表
     */
    List<MessageDTO> listMessages();

    /**
     * 查看后台留言
     *
     * @param condition 条件
     * @return 留言列表
     */
    PageDTO<MessageBackDTO> listMessageBackDTO(ConditionVO condition);

}
