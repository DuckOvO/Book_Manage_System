package com.cl.dao;

import com.cl.entity.ShujixinxiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ShujixinxiView;


/**
 * 书籍信息
 * 
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface ShujixinxiDao extends BaseMapper<ShujixinxiEntity> {
	
	List<ShujixinxiView> selectListView(@Param("ew") Wrapper<ShujixinxiEntity> wrapper);

	List<ShujixinxiView> selectListView(Pagination page,@Param("ew") Wrapper<ShujixinxiEntity> wrapper);
	
	ShujixinxiView selectView(@Param("ew") Wrapper<ShujixinxiEntity> wrapper);



    List<Map<String, Object>> selectValue(@Param("params")Map<String, Object> params,@Param("ew") Wrapper<ShujixinxiEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShujixinxiEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShujixinxiEntity> wrapper);



}
