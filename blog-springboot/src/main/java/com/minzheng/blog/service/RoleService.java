package com.minzheng.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.minzheng.blog.dto.PageDTO;
import com.minzheng.blog.dto.RoleDTO;
import com.minzheng.blog.dto.UserRoleDTO;
import com.minzheng.blog.entity.Role;
import com.minzheng.blog.vo.ConditionVO;
import com.minzheng.blog.vo.RoleVO;

import java.util.List;

/**
 * @author: yezhiqiu
 * @date: 2020-12-27
 **/
public interface RoleService extends IService<Role> {

    /**
     * 获取用户角色选项
     *
     * @return 角色
     */
    List<UserRoleDTO> listUserRoles();

    /**
     * 查询角色列表
     *
     * @param conditionVO 条件
     * @return 角色列表
     */
    PageDTO<RoleDTO> listRoles(ConditionVO conditionVO);

    /**
     * 保存或更新角色
     *
     * @param roleVO 角色
     */
    void saveOrUpdateRole(RoleVO roleVO);

    /**
     * 删除角色
     * @param roleIdList 角色id列表
     */
    void deleteRoles(List<Integer> roleIdList);

}
