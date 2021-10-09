package com.minzheng.blog.handler;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.minzheng.blog.constant.CommonConst;
import com.minzheng.blog.dao.ElasticsearchDao;
import com.minzheng.blog.dto.ArticleSearchDTO;
import com.minzheng.blog.entity.Article;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

import static com.minzheng.blog.constant.MQPrefixConst.MAXWELL_EXCHANGE;
import static com.minzheng.blog.constant.MQPrefixConst.MAXWELL_QUEUE;

/**
 * 同步es数据
 *
 * @author 11921
 */
@Component
@RabbitListener(queues = MAXWELL_QUEUE)
public class MaxWellReceiver {
    @Autowired
    private ElasticsearchDao elasticsearchDao;

    @RabbitHandler
    public void process(byte[] data) {
        //获取更改信息
        Map<String, Object> map = JSON.parseObject(new String(data), Map.class);
        //获取文章数据
        Article article = JSONObject.toJavaObject((JSONObject) map.get("data"), Article.class);
        //判断操作类型
        String type = map.get("type").toString();
        switch (type) {
            case "insert":
            case "update":
                // 发布文章后更新es文章
                if (article.getIsDraft().equals(CommonConst.FALSE)) {
                    elasticsearchDao.save(convertArticleSearchDTO(article));
                }
                break;
            case "delete":
                // 物理删除文章
                if (article.getIsDraft().equals(CommonConst.FALSE)) {
                    elasticsearchDao.deleteById(article.getId());
                }
            default:
                break;
        }
    }


    /**
     * 转换文章搜索DTO
     *
     * @param article 文章
     * @return 文章搜索DTO
     */
    private ArticleSearchDTO convertArticleSearchDTO(Article article) {
        return ArticleSearchDTO.builder()
                .id(article.getId())
                .articleTitle(article.getArticleTitle())
                .articleContent(article.getArticleContent())
                .isDelete(article.getIsDelete())
                .build();
    }

}