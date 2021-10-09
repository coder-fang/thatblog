package com.minzheng.blog.service;

import com.minzheng.blog.dto.*;
import com.minzheng.blog.entity.Article;
import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.vo.ArticleVO;
import com.minzheng.blog.vo.ConditionVO;
import com.minzheng.blog.vo.DeleteVO;

import java.util.List;

/**
 * @author xiaojie
 * @since 2020-05-18
 */
public interface ArticleService extends IService<Article> {

    /**
     * 查询文章归档
     *
     * @param current 当前页码
     * @return 文章
     */
    PageDTO<ArchiveDTO> listArchives(Long current);

    /**
     * 查询后台文章
     *
     * @param condition 条件
     * @return 文章列表
     */
    PageDTO<ArticleBackDTO> listArticleBackDTO(ConditionVO condition);

    /**
     * 查询首页文章
     *
     * @param current 当前页码
     * @return 文章
     */
    List<ArticleHomeDTO> listArticles(Long current);

    /**
     * 根据条件查询文章列表
     *
     * @param condition 条件
     * @return 文章
     */
    ArticlePreviewListDTO listArticlesByCondition(ConditionVO condition);

    /**
     * 搜索文章
     *
     * @param condition 条件
     * @return 文章
     */
    List<ArticleSearchDTO> listArticlesBySearch(ConditionVO condition);

    /**
     * 根据id查看后台文章
     *
     * @param articleId 文章id
     * @return 文章
     */
    ArticleVO getArticleBackById(Integer articleId);

    /**
     * 根据id查看文章
     *
     * @param articleId 文章id
     * @return 文章
     */
    ArticleDTO getArticleById(Integer articleId);

    /**
     * 查看最新文章
     * @return 最新文章
     */
    List<ArticleRecommendDTO> listNewestArticles();

    /**
     * 查看文章分类标签选项
     *
     * @return 文章分类标签选项
     */
    ArticleOptionDTO listArticleOptionDTO();

    /**
     * 点赞文章
     *
     * @param articleId 文章id
     */
    void saveArticleLike(Integer articleId);

    /**
     * 添加或修改文章
     *
     * @param articleVO 文章对象
     */
    void saveOrUpdateArticle(ArticleVO articleVO);

    /**
     * 修改文章置顶
     *
     * @param isTop     置顶状态值
     * @param articleId 文章id
     */
    void updateArticleTop(Integer articleId, Integer isTop);

    /**
     * 删除或恢复文章
     *
     * @param deleteVO 逻辑删除对象
     */
    void updateArticleDelete(DeleteVO deleteVO);

    /**
     * 物理删除文章
     * @param articleIdList 文章id集合
     */
    void deleteArticles(List<Integer> articleIdList);

}
