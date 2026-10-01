package com.cl.dao;

import com.cl.entity.TushuxujieEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.TushuxujieView;


/**
 * 图书续借
 * 
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface TushuxujieDao extends BaseMapper<TushuxujieEntity> {
	
	List<TushuxujieView> selectListView(@Param("ew") Wrapper<TushuxujieEntity> wrapper);

	List<TushuxujieView> selectListView(Pagination page,@Param("ew") Wrapper<TushuxujieEntity> wrapper);
	
	TushuxujieView selectView(@Param("ew") Wrapper<TushuxujieEntity> wrapper);



}
