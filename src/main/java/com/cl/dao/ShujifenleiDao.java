package com.cl.dao;

import com.cl.entity.ShujifenleiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ShujifenleiView;


/**
 * 书籍分类
 * 
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface ShujifenleiDao extends BaseMapper<ShujifenleiEntity> {
	
	List<ShujifenleiView> selectListView(@Param("ew") Wrapper<ShujifenleiEntity> wrapper);

	List<ShujifenleiView> selectListView(Pagination page,@Param("ew") Wrapper<ShujifenleiEntity> wrapper);
	
	ShujifenleiView selectView(@Param("ew") Wrapper<ShujifenleiEntity> wrapper);



}
