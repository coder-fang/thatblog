/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 14/05/2021 16:33:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '作者',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '文章分类',
  `article_cover` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `article_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `article_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '发表时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_top` tinyint(1) NULL DEFAULT NULL COMMENT '是否置顶 0否 1是',
  `is_draft` tinyint(1) NULL DEFAULT 0 COMMENT '是否为草稿 0否 1是',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_article
-- ----------------------------
INSERT INTO `tb_article` VALUES (31, 1, 12, 'https://www.static.talkxj.com/articles/1616249391415.jpg', '测试文章', '## 测试目录\n这是你的第一篇文章', '2021-03-20 22:09:58', '2021-03-20 23:39:20', 0, 0, 0);

-- ----------------------------
-- Table structure for tb_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_article_tag`;
CREATE TABLE `tb_article_tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `tag_id` int(11) NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_tag_1`(`article_id`) USING BTREE,
  INDEX `fk_article_tag_2`(`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 272 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_article_tag
-- ----------------------------
INSERT INTO `tb_article_tag` VALUES (272, 31, 18);

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES (12, '测试分类', '2021-03-20 22:02:43');

-- ----------------------------
-- Table structure for tb_chat_record
-- ----------------------------
DROP TABLE IF EXISTS `tb_chat_record`;
CREATE TABLE `tb_chat_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `content` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '聊天内容',
  `ip_addr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1201 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '评论用户Id',
  `article_id` int(11) NULL DEFAULT NULL COMMENT '评论文章id',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `create_time` datetime(0) NOT NULL COMMENT '评论时间',
  `reply_id` int(11) NULL DEFAULT NULL COMMENT '回复用户id',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父评论id',
  `is_delete` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id`) USING BTREE,
  INDEX `fk_comment_article`(`article_id`) USING BTREE,
  INDEX `fk_comment_parent`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 264 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES (264, 1, 31, '测试评论<img src= \'https://www.static.talkxj.com/emoji/goutou.jpg\' width=\'22\'height=\'20\' style=\'padding: 0 1px\'/>', '2021-03-20 23:41:53', NULL, NULL, 0);

-- ----------------------------
-- Table structure for tb_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `tb_friend_link`;
CREATE TABLE `tb_friend_link`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接名',
  `link_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接头像',
  `link_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接地址',
  `link_intro` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接介绍',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_friend_link_user`(`link_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_friend_link
-- ----------------------------
INSERT INTO `tb_friend_link` VALUES (12, '风丶宇的个人博客', 'https://www.static.talkxj.com/avatar/blogger.jpg', 'https://www.talkxj.com/', '成事在人 谋事在天', '2021-03-20 23:40:33');

-- ----------------------------
-- Table structure for tb_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_menu`;
CREATE TABLE `tb_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单名',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单路径',
  `component` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单icon',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `order_num` tinyint(4) NULL DEFAULT NULL COMMENT '排序',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
  `is_disable` tinyint(1) NULL DEFAULT NULL COMMENT '是否禁用 0否1是',
  `is_hidden` tinyint(1) NULL DEFAULT NULL COMMENT '是否隐藏  0否1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_menu
-- ----------------------------
INSERT INTO `tb_menu` VALUES (1, '首页', '/', '/home/Home.vue', 'el-icon-myshouye', '2021-01-26 17:06:51', '2021-01-26 17:06:53', 1, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (2, '文章管理', '/article-submenu', 'Layout', 'el-icon-mywenzhang-copy', '2021-01-25 20:43:07', '2021-01-25 20:43:09', 2, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (3, '消息管理', '/message-submenu', 'Layout', 'el-icon-myxiaoxi', '2021-01-25 20:44:17', '2021-01-25 20:44:20', 3, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (4, '系统管理', '/system-submenu', 'Layout', 'el-icon-myshezhi', '2021-01-25 20:45:57', '2021-01-25 20:45:59', 5, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (5, '个人中心', '/setting', '/setting/Setting.vue', 'el-icon-myuser', '2021-01-26 17:22:38', '2021-01-26 17:22:41', 7, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (6, '添加文章', '/articles', '/article/Article.vue', 'el-icon-myfabiaowenzhang', '2021-01-26 14:30:48', '2021-01-26 14:30:51', 1, 2, 0, 0);
INSERT INTO `tb_menu` VALUES (7, '修改文章', '/articles/*', '/article/Article.vue', 'el-icon-myfabiaowenzhang', '2021-01-26 14:31:32', '2021-01-26 14:31:34', 2, 2, 0, 1);
INSERT INTO `tb_menu` VALUES (8, '文章列表', '/article-list', '/article/ArticleList.vue', 'el-icon-mywenzhangliebiao', '2021-01-26 14:32:13', '2021-01-26 14:32:16', 3, 2, 0, 0);
INSERT INTO `tb_menu` VALUES (9, '分类管理', '/categories', '/category/Category.vue', 'el-icon-myfenlei', '2021-01-26 14:33:42', '2021-01-26 14:33:43', 4, 2, 0, 0);
INSERT INTO `tb_menu` VALUES (10, '标签管理', '/tags', '/tag/Tag.vue', 'el-icon-myicontag', '2021-01-26 14:34:33', '2021-01-26 14:34:36', 5, 2, 0, 0);
INSERT INTO `tb_menu` VALUES (11, '评论管理', '/comments', '/comment/Comment.vue', 'el-icon-mypinglunzu', '2021-01-26 14:35:31', '2021-01-26 14:35:34', 1, 3, 0, 0);
INSERT INTO `tb_menu` VALUES (12, '留言管理', '/messages', '/message/Message.vue', 'el-icon-myliuyan', '2021-01-26 14:36:09', '2021-01-26 14:36:13', 2, 3, 0, 0);
INSERT INTO `tb_menu` VALUES (13, '用户列表', '/users', '/user/User.vue', 'el-icon-myyonghuliebiao', '2021-01-26 14:38:09', '2021-01-26 14:38:12', 1, 202, 0, 0);
INSERT INTO `tb_menu` VALUES (14, '角色管理', '/roles', '/role/Role.vue', 'el-icon-myjiaoseliebiao', '2021-01-26 14:39:01', '2021-01-26 14:39:03', 2, 202, 0, 0);
INSERT INTO `tb_menu` VALUES (15, '资源管理', '/resources', '/resource/Resource.vue', 'el-icon-myxitong', '2021-01-26 14:40:14', '2021-01-26 14:40:16', 2, 4, 0, 0);
INSERT INTO `tb_menu` VALUES (16, '菜单管理', '/menus', '/menu/Menu.vue', 'el-icon-mycaidan', '2021-01-26 14:40:54', '2021-01-26 14:40:56', 1, 4, 0, 0);
INSERT INTO `tb_menu` VALUES (17, '友链管理', '/links', '/friendLink/FriendLink.vue', 'el-icon-mydashujukeshihuaico-', '2021-01-26 14:41:35', '2021-01-26 14:41:37', 3, 4, 0, 0);
INSERT INTO `tb_menu` VALUES (18, '关于我', '/about', '/about/About.vue', 'el-icon-myguanyuwo', '2021-01-26 14:42:05', '2021-01-26 14:42:10', 4, 4, 0, 0);
INSERT INTO `tb_menu` VALUES (19, '日志管理', '/log-submenu', 'Layout', 'el-icon-myguanyuwo', '2021-01-31 21:33:56', '2021-01-31 21:33:59', 6, NULL, 0, 0);
INSERT INTO `tb_menu` VALUES (20, '操作日志', '/operation/log', '/log/Operation.vue', 'el-icon-myguanyuwo', '2021-01-31 15:53:21', '2021-01-31 15:53:25', 1, 19, 0, 0);
INSERT INTO `tb_menu` VALUES (201, '在线用户', '/online/users', '/user/Online.vue', 'el-icon-myyonghuliebiao', '2021-02-05 14:59:51', '2021-02-05 14:59:53', 7, 202, 0, 0);
INSERT INTO `tb_menu` VALUES (202, '用户管理', '/users-submenu', 'Layout', 'el-icon-myyonghuliebiao', '2021-02-06 23:44:59', '2021-02-06 23:45:03', 4, NULL, 0, 0);

-- ----------------------------
-- Table structure for tb_message
-- ----------------------------
DROP TABLE IF EXISTS `tb_message`;
CREATE TABLE `tb_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户地址',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '头像',
  `message_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '留言内容',
  `time` tinyint(1) NULL DEFAULT NULL COMMENT '弹幕速度',
  `create_time` datetime(0) NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3432 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_message
-- ----------------------------
INSERT INTO `tb_message` VALUES (3432, '127.0.0.1', '', '游客', 'https://gravatar.loli.net/avatar/d41d8cd98f00b204e9800998ecf8427e?d=mp&v=1.4.14', '测试留言', 8, '2021-03-20 23:40:48');

-- ----------------------------
-- Table structure for tb_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_operation_log`;
CREATE TABLE `tb_operation_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `opt_module` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作模块',
  `opt_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作类型',
  `opt_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作url',
  `opt_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作方法',
  `opt_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作描述',
  `request_param` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数',
  `request_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方式',
  `response_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '返回数据',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `ip_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_resource`;
CREATE TABLE `tb_resource`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `resource_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源名',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限路径',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方式',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父权限id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `is_disable` tinyint(1) NULL DEFAULT NULL COMMENT '是否禁用 0否 1是',
  `is_anonymous` tinyint(4) NULL DEFAULT NULL COMMENT '是否匿名访问 0否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 249 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_resource
-- ----------------------------
INSERT INTO `tb_resource` VALUES (165, '分类模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (166, '博客信息模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (167, '友链模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (168, '文章模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (169, '日志模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (170, '标签模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (171, '用户信息模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (172, '用户账号模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (173, '留言模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (174, '菜单模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (175, '角色模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (176, '评论模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (177, '资源模块', NULL, NULL, NULL, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (178, '查看博客信息', '/', 'GET', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (179, '查看关于我信息', '/about', 'GET', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (180, '查看后台信息', '/admin', 'GET', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (181, '修改关于我信息', '/admin/about', 'PUT', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (182, '查看后台文章', '/admin/articles', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (183, '添加或修改文章', '/admin/articles', 'POST', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (184, '恢复或删除文章', '/admin/articles', 'PUT', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (185, '物理删除文章', '/admin/articles', 'DELETE', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (186, '上传文章图片', '/admin/articles/images', 'POST', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (187, '查看文章选项', '/admin/articles/options', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (188, '修改文章置顶', '/admin/articles/top/*', 'PUT', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (189, '根据id查看后台文章', '/admin/articles/*', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (190, '查看后台分类列表', '/admin/categories', 'GET', 165, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (191, '添加或修改分类', '/admin/categories', 'POST', 165, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (192, '删除分类', '/admin/categories', 'DELETE', 165, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (193, '查询后台评论', '/admin/comments', 'GET', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (194, '删除或恢复评论', '/admin/comments', 'PUT', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (195, '物理删除评论', '/admin/comments', 'DELETE', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (196, '查看后台友链列表', '/admin/links', 'GET', 167, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (197, '保存或修改友链', '/admin/links', 'POST', 167, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (198, '删除友链', '/admin/links', 'DELETE', 167, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (199, '查看菜单列表', '/admin/menus', 'GET', 174, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (200, '查看后台留言列表', '/admin/messages', 'GET', 173, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (201, '删除留言', '/admin/messages', 'DELETE', 173, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (202, '查看公告', '/admin/notice', 'GET', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (203, '修改公告', '/admin/notice', 'PUT', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (204, '查看操作日志', '/admin/operation/logs', 'GET', 169, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (205, '删除操作日志', '/admin/operation/logs', 'DELETE', 169, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (206, '查看资源列表', '/admin/resources', 'GET', 177, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (207, '新增或修改资源', '/admin/resources', 'POST', 177, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (208, '删除资源', '/admin/resources', 'DELETE', 177, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (209, '导入swagger接口', '/admin/resources/import/swagger', 'GET', 177, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (210, '保存或更新角色', '/admin/role', 'POST', 175, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (211, '查看角色菜单选项', '/admin/role/menus', 'GET', 174, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (212, '查看角色资源选项', '/admin/role/resources', 'GET', 177, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (213, '查询角色列表', '/admin/roles', 'GET', 175, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (214, '查看后台标签列表', '/admin/tags', 'GET', 170, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (215, '添加或修改标签', '/admin/tags', 'POST', 170, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (216, '删除标签', '/admin/tags', 'DELETE', 170, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (217, '查看用户菜单', '/admin/user/menus', 'GET', 174, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (218, '查看后台用户列表', '/admin/users', 'GET', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (219, '修改用户禁用状态', '/admin/users/disable/*', 'PUT', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (220, '查看在线用户', '/admin/users/online', 'GET', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (221, '下线用户', '/admin/users/online/*', 'DELETE', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (222, '修改管理员密码', '/admin/users/password', 'PUT', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (223, '查询用户角色选项', '/admin/users/role', 'GET', 175, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (224, '修改用户角色', '/admin/users/role', 'PUT', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 0);
INSERT INTO `tb_resource` VALUES (225, '查看首页文章', '/articles', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (226, '查看文章归档', '/articles/archives', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (227, '点赞文章', '/articles/like', 'POST', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (228, '查看最新文章', '/articles/newest', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (229, '搜索文章', '/articles/search', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (230, '根据id查看文章', '/articles/*', 'GET', 168, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (231, '查看分类列表', '/categories', 'GET', 165, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (232, '查看分类下对应的文章', '/categories/*', 'GET', 165, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (233, '查询评论', '/comments', 'GET', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (234, '添加评论或回复', '/comments', 'POST', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (235, '评论点赞', '/comments/like', 'POST', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (236, '查询评论下的回复', '/comments/replies/*', 'GET', 176, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (237, '查看友链列表', '/links', 'GET', 167, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (238, '查看留言列表', '/messages', 'GET', 173, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (239, '添加留言', '/messages', 'POST', 173, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (240, '查看标签列表', '/tags', 'GET', 170, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (241, '查看分类下对应的文章', '/tags/*', 'GET', 170, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (242, '用户注册', '/users', 'POST', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (243, '修改用户头像', '/users/avatar', 'POST', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (244, '发送邮箱验证码', '/users/code', 'GET', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (245, '修改用户资料', '/users/info', 'PUT', 171, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (246, 'qq登录', '/users/oauth/qq', 'POST', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (247, '微博登录', '/users/oauth/weibo', 'POST', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (248, '修改密码', '/users/password', 'PUT', 172, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);
INSERT INTO `tb_resource` VALUES (249, '上传语音', '/voice', 'POST', 166, '2021-03-20 22:56:20', '2021-03-20 22:56:20', 0, 1);

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_disable` tinyint(1) NULL DEFAULT NULL COMMENT '是否禁用  0否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES (1, '管理员', 'admin', '2021-01-11 17:21:57', '2021-03-20 23:27:55', 0);
INSERT INTO `tb_role` VALUES (2, '用户', 'user', '2021-01-11 20:17:05', '2021-03-16 23:20:20', 0);
INSERT INTO `tb_role` VALUES (3, '测试', 'test', '2021-01-11 20:17:23', '2021-03-16 23:41:59', 0);

-- ----------------------------
-- Table structure for tb_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_menu`;
CREATE TABLE `tb_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1264 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role_menu
-- ----------------------------
INSERT INTO `tb_role_menu` VALUES (1181, 3, 1);
INSERT INTO `tb_role_menu` VALUES (1182, 3, 202);
INSERT INTO `tb_role_menu` VALUES (1183, 3, 13);
INSERT INTO `tb_role_menu` VALUES (1184, 3, 14);
INSERT INTO `tb_role_menu` VALUES (1185, 3, 201);
INSERT INTO `tb_role_menu` VALUES (1243, 1, 1);
INSERT INTO `tb_role_menu` VALUES (1244, 1, 2);
INSERT INTO `tb_role_menu` VALUES (1245, 1, 6);
INSERT INTO `tb_role_menu` VALUES (1246, 1, 7);
INSERT INTO `tb_role_menu` VALUES (1247, 1, 8);
INSERT INTO `tb_role_menu` VALUES (1248, 1, 9);
INSERT INTO `tb_role_menu` VALUES (1249, 1, 10);
INSERT INTO `tb_role_menu` VALUES (1250, 1, 3);
INSERT INTO `tb_role_menu` VALUES (1251, 1, 11);
INSERT INTO `tb_role_menu` VALUES (1252, 1, 12);
INSERT INTO `tb_role_menu` VALUES (1253, 1, 202);
INSERT INTO `tb_role_menu` VALUES (1254, 1, 13);
INSERT INTO `tb_role_menu` VALUES (1255, 1, 14);
INSERT INTO `tb_role_menu` VALUES (1256, 1, 201);
INSERT INTO `tb_role_menu` VALUES (1257, 1, 4);
INSERT INTO `tb_role_menu` VALUES (1258, 1, 16);
INSERT INTO `tb_role_menu` VALUES (1259, 1, 15);
INSERT INTO `tb_role_menu` VALUES (1260, 1, 17);
INSERT INTO `tb_role_menu` VALUES (1261, 1, 18);
INSERT INTO `tb_role_menu` VALUES (1262, 1, 19);
INSERT INTO `tb_role_menu` VALUES (1263, 1, 20);
INSERT INTO `tb_role_menu` VALUES (1264, 1, 5);

-- ----------------------------
-- Table structure for tb_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_resource`;
CREATE TABLE `tb_role_resource`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `resource_id` int(11) NULL DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role_resource
-- ----------------------------
INSERT INTO `tb_role_resource` VALUES (4092, 1, 165);
INSERT INTO `tb_role_resource` VALUES (4093, 1, 190);
INSERT INTO `tb_role_resource` VALUES (4094, 1, 191);
INSERT INTO `tb_role_resource` VALUES (4095, 1, 192);
INSERT INTO `tb_role_resource` VALUES (4096, 1, 231);
INSERT INTO `tb_role_resource` VALUES (4097, 1, 232);
INSERT INTO `tb_role_resource` VALUES (4098, 1, 166);
INSERT INTO `tb_role_resource` VALUES (4099, 1, 178);
INSERT INTO `tb_role_resource` VALUES (4100, 1, 179);
INSERT INTO `tb_role_resource` VALUES (4101, 1, 180);
INSERT INTO `tb_role_resource` VALUES (4102, 1, 181);
INSERT INTO `tb_role_resource` VALUES (4103, 1, 202);
INSERT INTO `tb_role_resource` VALUES (4104, 1, 203);
INSERT INTO `tb_role_resource` VALUES (4105, 1, 249);
INSERT INTO `tb_role_resource` VALUES (4106, 1, 167);
INSERT INTO `tb_role_resource` VALUES (4107, 1, 196);
INSERT INTO `tb_role_resource` VALUES (4108, 1, 197);
INSERT INTO `tb_role_resource` VALUES (4109, 1, 198);
INSERT INTO `tb_role_resource` VALUES (4110, 1, 237);
INSERT INTO `tb_role_resource` VALUES (4111, 1, 168);
INSERT INTO `tb_role_resource` VALUES (4112, 1, 182);
INSERT INTO `tb_role_resource` VALUES (4113, 1, 183);
INSERT INTO `tb_role_resource` VALUES (4114, 1, 184);
INSERT INTO `tb_role_resource` VALUES (4115, 1, 185);
INSERT INTO `tb_role_resource` VALUES (4116, 1, 186);
INSERT INTO `tb_role_resource` VALUES (4117, 1, 187);
INSERT INTO `tb_role_resource` VALUES (4118, 1, 188);
INSERT INTO `tb_role_resource` VALUES (4119, 1, 189);
INSERT INTO `tb_role_resource` VALUES (4120, 1, 225);
INSERT INTO `tb_role_resource` VALUES (4121, 1, 226);
INSERT INTO `tb_role_resource` VALUES (4122, 1, 227);
INSERT INTO `tb_role_resource` VALUES (4123, 1, 228);
INSERT INTO `tb_role_resource` VALUES (4124, 1, 229);
INSERT INTO `tb_role_resource` VALUES (4125, 1, 230);
INSERT INTO `tb_role_resource` VALUES (4126, 1, 169);
INSERT INTO `tb_role_resource` VALUES (4127, 1, 204);
INSERT INTO `tb_role_resource` VALUES (4128, 1, 205);
INSERT INTO `tb_role_resource` VALUES (4129, 1, 170);
INSERT INTO `tb_role_resource` VALUES (4130, 1, 214);
INSERT INTO `tb_role_resource` VALUES (4131, 1, 215);
INSERT INTO `tb_role_resource` VALUES (4132, 1, 216);
INSERT INTO `tb_role_resource` VALUES (4133, 1, 240);
INSERT INTO `tb_role_resource` VALUES (4134, 1, 241);
INSERT INTO `tb_role_resource` VALUES (4135, 1, 171);
INSERT INTO `tb_role_resource` VALUES (4136, 1, 219);
INSERT INTO `tb_role_resource` VALUES (4137, 1, 220);
INSERT INTO `tb_role_resource` VALUES (4138, 1, 221);
INSERT INTO `tb_role_resource` VALUES (4139, 1, 224);
INSERT INTO `tb_role_resource` VALUES (4140, 1, 243);
INSERT INTO `tb_role_resource` VALUES (4141, 1, 245);
INSERT INTO `tb_role_resource` VALUES (4142, 1, 172);
INSERT INTO `tb_role_resource` VALUES (4143, 1, 218);
INSERT INTO `tb_role_resource` VALUES (4144, 1, 222);
INSERT INTO `tb_role_resource` VALUES (4145, 1, 242);
INSERT INTO `tb_role_resource` VALUES (4146, 1, 244);
INSERT INTO `tb_role_resource` VALUES (4147, 1, 246);
INSERT INTO `tb_role_resource` VALUES (4148, 1, 247);
INSERT INTO `tb_role_resource` VALUES (4149, 1, 248);
INSERT INTO `tb_role_resource` VALUES (4150, 1, 173);
INSERT INTO `tb_role_resource` VALUES (4151, 1, 200);
INSERT INTO `tb_role_resource` VALUES (4152, 1, 201);
INSERT INTO `tb_role_resource` VALUES (4153, 1, 238);
INSERT INTO `tb_role_resource` VALUES (4154, 1, 239);
INSERT INTO `tb_role_resource` VALUES (4155, 1, 174);
INSERT INTO `tb_role_resource` VALUES (4156, 1, 199);
INSERT INTO `tb_role_resource` VALUES (4157, 1, 211);
INSERT INTO `tb_role_resource` VALUES (4158, 1, 217);
INSERT INTO `tb_role_resource` VALUES (4159, 1, 175);
INSERT INTO `tb_role_resource` VALUES (4160, 1, 210);
INSERT INTO `tb_role_resource` VALUES (4161, 1, 213);
INSERT INTO `tb_role_resource` VALUES (4162, 1, 223);
INSERT INTO `tb_role_resource` VALUES (4163, 1, 176);
INSERT INTO `tb_role_resource` VALUES (4164, 1, 193);
INSERT INTO `tb_role_resource` VALUES (4165, 1, 194);
INSERT INTO `tb_role_resource` VALUES (4166, 1, 195);
INSERT INTO `tb_role_resource` VALUES (4167, 1, 233);
INSERT INTO `tb_role_resource` VALUES (4168, 1, 234);
INSERT INTO `tb_role_resource` VALUES (4169, 1, 235);
INSERT INTO `tb_role_resource` VALUES (4170, 1, 236);
INSERT INTO `tb_role_resource` VALUES (4171, 1, 177);
INSERT INTO `tb_role_resource` VALUES (4172, 1, 206);
INSERT INTO `tb_role_resource` VALUES (4173, 1, 207);
INSERT INTO `tb_role_resource` VALUES (4174, 1, 208);
INSERT INTO `tb_role_resource` VALUES (4175, 1, 209);
INSERT INTO `tb_role_resource` VALUES (4176, 1, 212);

-- ----------------------------
-- Table structure for tb_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_tag`;
CREATE TABLE `tb_tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_tag
-- ----------------------------
INSERT INTO `tb_tag` VALUES (18, '测试标签', '2021-03-20 22:02:51');

-- ----------------------------
-- Table structure for tb_unique_view
-- ----------------------------
DROP TABLE IF EXISTS `tb_unique_view`;
CREATE TABLE `tb_unique_view`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NOT NULL COMMENT '时间',
  `views_count` int(11) NOT NULL COMMENT '访问量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 223 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_auth`;
CREATE TABLE `tb_user_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_info_id` int(11) NOT NULL COMMENT '用户信息id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `login_type` tinyint(1) NOT NULL COMMENT '登录类型',
  `ip_addr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户登录ip',
  `ip_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_auth
-- ----------------------------
INSERT INTO `tb_user_auth` VALUES (1, 1, 'admin@qq.com', '$2a$10$H/5k4KtIwCuKEqHOlhKAyuMxrGxvk2t6tuWCxU.ScI7VpWdhjQ6Xq', 0, '127.0.0.1', '', '2020-06-29 10:48:18', '2021-03-20 23:41:41');

-- ----------------------------
-- Table structure for tb_user_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_info`;
CREATE TABLE `tb_user_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱号',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户简介',
  `web_site` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人网站',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_disable` tinyint(1) NULL DEFAULT 0 COMMENT '是否禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_info
-- ----------------------------
INSERT INTO `tb_user_info` VALUES (1, NULL, '管理员', 'https://www.static.talkxj.com/avatar/user.png', '发表你的第一篇博客吧', 'https://www.talkxj.com', '2020-06-29 10:48:18', '2021-03-20 22:10:33', 0);

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 218 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES (2, 23, 3);
INSERT INTO `tb_user_role` VALUES (4, 2, 2);
INSERT INTO `tb_user_role` VALUES (5, 3, 2);
INSERT INTO `tb_user_role` VALUES (6, 4, 2);
INSERT INTO `tb_user_role` VALUES (7, 5, 2);
INSERT INTO `tb_user_role` VALUES (8, 7, 2);
INSERT INTO `tb_user_role` VALUES (9, 8, 2);
INSERT INTO `tb_user_role` VALUES (10, 9, 2);
INSERT INTO `tb_user_role` VALUES (11, 10, 2);
INSERT INTO `tb_user_role` VALUES (12, 11, 2);
INSERT INTO `tb_user_role` VALUES (13, 15, 2);
INSERT INTO `tb_user_role` VALUES (14, 16, 2);
INSERT INTO `tb_user_role` VALUES (15, 18, 2);
INSERT INTO `tb_user_role` VALUES (16, 19, 2);
INSERT INTO `tb_user_role` VALUES (17, 21, 2);
INSERT INTO `tb_user_role` VALUES (18, 22, 2);
INSERT INTO `tb_user_role` VALUES (19, 23, 2);
INSERT INTO `tb_user_role` VALUES (20, 24, 2);
INSERT INTO `tb_user_role` VALUES (21, 25, 2);
INSERT INTO `tb_user_role` VALUES (22, 26, 2);
INSERT INTO `tb_user_role` VALUES (23, 27, 2);
INSERT INTO `tb_user_role` VALUES (24, 28, 2);
INSERT INTO `tb_user_role` VALUES (25, 29, 2);
INSERT INTO `tb_user_role` VALUES (26, 30, 2);
INSERT INTO `tb_user_role` VALUES (27, 31, 2);
INSERT INTO `tb_user_role` VALUES (28, 33, 2);
INSERT INTO `tb_user_role` VALUES (29, 35, 2);
INSERT INTO `tb_user_role` VALUES (30, 36, 2);
INSERT INTO `tb_user_role` VALUES (31, 37, 2);
INSERT INTO `tb_user_role` VALUES (32, 38, 2);
INSERT INTO `tb_user_role` VALUES (33, 39, 2);
INSERT INTO `tb_user_role` VALUES (34, 40, 2);
INSERT INTO `tb_user_role` VALUES (35, 41, 2);
INSERT INTO `tb_user_role` VALUES (36, 42, 2);
INSERT INTO `tb_user_role` VALUES (37, 44, 2);
INSERT INTO `tb_user_role` VALUES (38, 45, 2);
INSERT INTO `tb_user_role` VALUES (39, 46, 2);
INSERT INTO `tb_user_role` VALUES (40, 47, 2);
INSERT INTO `tb_user_role` VALUES (41, 48, 2);
INSERT INTO `tb_user_role` VALUES (42, 49, 2);
INSERT INTO `tb_user_role` VALUES (43, 52, 2);
INSERT INTO `tb_user_role` VALUES (44, 54, 2);
INSERT INTO `tb_user_role` VALUES (45, 55, 2);
INSERT INTO `tb_user_role` VALUES (46, 56, 2);
INSERT INTO `tb_user_role` VALUES (47, 57, 2);
INSERT INTO `tb_user_role` VALUES (48, 58, 2);
INSERT INTO `tb_user_role` VALUES (49, 59, 2);
INSERT INTO `tb_user_role` VALUES (50, 60, 2);
INSERT INTO `tb_user_role` VALUES (51, 61, 2);
INSERT INTO `tb_user_role` VALUES (52, 62, 2);
INSERT INTO `tb_user_role` VALUES (53, 63, 2);
INSERT INTO `tb_user_role` VALUES (54, 64, 2);
INSERT INTO `tb_user_role` VALUES (55, 65, 2);
INSERT INTO `tb_user_role` VALUES (56, 67, 2);
INSERT INTO `tb_user_role` VALUES (57, 68, 2);
INSERT INTO `tb_user_role` VALUES (58, 69, 2);
INSERT INTO `tb_user_role` VALUES (59, 70, 2);
INSERT INTO `tb_user_role` VALUES (60, 71, 2);
INSERT INTO `tb_user_role` VALUES (61, 72, 2);
INSERT INTO `tb_user_role` VALUES (62, 73, 2);
INSERT INTO `tb_user_role` VALUES (63, 74, 2);
INSERT INTO `tb_user_role` VALUES (64, 75, 2);
INSERT INTO `tb_user_role` VALUES (65, 76, 2);
INSERT INTO `tb_user_role` VALUES (66, 77, 2);
INSERT INTO `tb_user_role` VALUES (67, 78, 2);
INSERT INTO `tb_user_role` VALUES (68, 79, 2);
INSERT INTO `tb_user_role` VALUES (69, 80, 2);
INSERT INTO `tb_user_role` VALUES (70, 81, 2);
INSERT INTO `tb_user_role` VALUES (71, 82, 2);
INSERT INTO `tb_user_role` VALUES (72, 83, 2);
INSERT INTO `tb_user_role` VALUES (73, 84, 2);
INSERT INTO `tb_user_role` VALUES (74, 85, 2);
INSERT INTO `tb_user_role` VALUES (75, 86, 2);
INSERT INTO `tb_user_role` VALUES (76, 87, 2);
INSERT INTO `tb_user_role` VALUES (77, 88, 2);
INSERT INTO `tb_user_role` VALUES (78, 89, 2);
INSERT INTO `tb_user_role` VALUES (79, 90, 2);
INSERT INTO `tb_user_role` VALUES (80, 91, 2);
INSERT INTO `tb_user_role` VALUES (81, 92, 2);
INSERT INTO `tb_user_role` VALUES (100, 105, 2);
INSERT INTO `tb_user_role` VALUES (133, 138, 2);
INSERT INTO `tb_user_role` VALUES (134, 139, 2);
INSERT INTO `tb_user_role` VALUES (135, 140, 2);
INSERT INTO `tb_user_role` VALUES (136, 141, 2);
INSERT INTO `tb_user_role` VALUES (137, 142, 2);
INSERT INTO `tb_user_role` VALUES (138, 143, 2);
INSERT INTO `tb_user_role` VALUES (139, 144, 2);
INSERT INTO `tb_user_role` VALUES (140, 145, 2);
INSERT INTO `tb_user_role` VALUES (141, 146, 2);
INSERT INTO `tb_user_role` VALUES (142, 147, 2);
INSERT INTO `tb_user_role` VALUES (143, 148, 2);
INSERT INTO `tb_user_role` VALUES (144, 149, 2);
INSERT INTO `tb_user_role` VALUES (145, 150, 2);
INSERT INTO `tb_user_role` VALUES (146, 151, 2);
INSERT INTO `tb_user_role` VALUES (147, 152, 2);
INSERT INTO `tb_user_role` VALUES (148, 153, 2);
INSERT INTO `tb_user_role` VALUES (149, 154, 2);
INSERT INTO `tb_user_role` VALUES (150, 155, 2);
INSERT INTO `tb_user_role` VALUES (151, 156, 2);
INSERT INTO `tb_user_role` VALUES (152, 157, 2);
INSERT INTO `tb_user_role` VALUES (153, 158, 2);
INSERT INTO `tb_user_role` VALUES (154, 159, 2);
INSERT INTO `tb_user_role` VALUES (155, 160, 2);
INSERT INTO `tb_user_role` VALUES (156, 161, 2);
INSERT INTO `tb_user_role` VALUES (157, 162, 2);
INSERT INTO `tb_user_role` VALUES (158, 163, 2);
INSERT INTO `tb_user_role` VALUES (159, 164, 2);
INSERT INTO `tb_user_role` VALUES (160, 165, 2);
INSERT INTO `tb_user_role` VALUES (161, 167, 2);
INSERT INTO `tb_user_role` VALUES (162, 166, 2);
INSERT INTO `tb_user_role` VALUES (163, 168, 2);
INSERT INTO `tb_user_role` VALUES (164, 169, 2);
INSERT INTO `tb_user_role` VALUES (165, 170, 2);
INSERT INTO `tb_user_role` VALUES (166, 171, 2);
INSERT INTO `tb_user_role` VALUES (167, 172, 2);
INSERT INTO `tb_user_role` VALUES (168, 173, 2);
INSERT INTO `tb_user_role` VALUES (169, 174, 2);
INSERT INTO `tb_user_role` VALUES (170, 175, 2);
INSERT INTO `tb_user_role` VALUES (171, 176, 2);
INSERT INTO `tb_user_role` VALUES (172, 177, 2);
INSERT INTO `tb_user_role` VALUES (173, 178, 2);
INSERT INTO `tb_user_role` VALUES (174, 179, 2);
INSERT INTO `tb_user_role` VALUES (175, 180, 2);
INSERT INTO `tb_user_role` VALUES (176, 181, 2);
INSERT INTO `tb_user_role` VALUES (177, 182, 2);
INSERT INTO `tb_user_role` VALUES (178, 183, 2);
INSERT INTO `tb_user_role` VALUES (179, 184, 2);
INSERT INTO `tb_user_role` VALUES (180, 185, 2);
INSERT INTO `tb_user_role` VALUES (181, 186, 2);
INSERT INTO `tb_user_role` VALUES (182, 187, 2);
INSERT INTO `tb_user_role` VALUES (183, 188, 2);
INSERT INTO `tb_user_role` VALUES (184, 189, 2);
INSERT INTO `tb_user_role` VALUES (185, 190, 2);
INSERT INTO `tb_user_role` VALUES (186, 191, 2);
INSERT INTO `tb_user_role` VALUES (187, 192, 2);
INSERT INTO `tb_user_role` VALUES (188, 193, 2);
INSERT INTO `tb_user_role` VALUES (189, 194, 2);
INSERT INTO `tb_user_role` VALUES (191, 196, 2);
INSERT INTO `tb_user_role` VALUES (192, 195, 2);
INSERT INTO `tb_user_role` VALUES (193, 198, 2);
INSERT INTO `tb_user_role` VALUES (194, 197, 2);
INSERT INTO `tb_user_role` VALUES (195, 199, 2);
INSERT INTO `tb_user_role` VALUES (196, 200, 2);
INSERT INTO `tb_user_role` VALUES (197, 201, 2);
INSERT INTO `tb_user_role` VALUES (198, 202, 2);
INSERT INTO `tb_user_role` VALUES (199, 203, 2);
INSERT INTO `tb_user_role` VALUES (200, 204, 2);
INSERT INTO `tb_user_role` VALUES (201, 205, 2);
INSERT INTO `tb_user_role` VALUES (202, 206, 2);
INSERT INTO `tb_user_role` VALUES (203, 207, 2);
INSERT INTO `tb_user_role` VALUES (204, 208, 2);
INSERT INTO `tb_user_role` VALUES (205, 209, 2);
INSERT INTO `tb_user_role` VALUES (206, 210, 2);
INSERT INTO `tb_user_role` VALUES (217, 1, 1);
INSERT INTO `tb_user_role` VALUES (218, 1, 2);

SET FOREIGN_KEY_CHECKS = 1;
