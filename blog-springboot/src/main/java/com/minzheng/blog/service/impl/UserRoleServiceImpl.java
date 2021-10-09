package com.minzheng.blog.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.minzheng.blog.dao.UserInfoDao;
import com.minzheng.blog.dao.UserRoleDao;
import com.minzheng.blog.entity.UserRole;
import com.minzheng.blog.enums.RoleEnum;
import com.minzheng.blog.service.UserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author: yezhiqiu
 * @date: 2020-12-27
 **/
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleDao, UserRole> implements UserRoleService {


}
