package com.minzheng.blog.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 聊天类型枚举
 *
 * @author: yezhiqiu
 * @date: 2021-02-21
 **/
@Getter
@AllArgsConstructor
public enum ChatTypeEnum {
    /**
     * 在线人数
     */
    ONLINE_COUNT(1, "在线人数"),
    /**
     * 历史记录
     */
    HISTORY_RECORD(2, "历史记录"),
    /**
     * 发送消息
     */
    SEND_MESSAGE(3, "发送消息"),
    /**
     * 撤回消息
     */
    RECALL_MESSAGE(4, "撤回消息"),
    /**
     * 语音消息
     */
    VOICE_MESSAGE(5,"语音消息"),
    /**
     * 心跳消息
     */
    HEART_BEAT(6,"心跳消息");

    /**
     * 类型
     */
    private final Integer type;

    /**
     * 描述
     */
    private final String desc;

    /**
     * 根据类型获取枚举
     * @param type 类型
     * @return 枚举
     */
    public static ChatTypeEnum getChatType(Integer type) {
        for (ChatTypeEnum chatType : ChatTypeEnum.values()) {
            if (chatType.getType().equals(type)) {
                return chatType;
            }
        }
        return null;
    }

}
