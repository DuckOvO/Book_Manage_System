package com.cl.dao;

import com.cl.entity.YuqifakuanEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.YuqifakuanView;


/**
 * 逾期罚款
 * 
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface YuqifakuanDao extends BaseMapper<YuqifakuanEntity> {
	
	List<YuqifakuanView> selectListView(@Param("ew") Wrapper<YuqifakuanEntity> wrapper);

	List<YuqifakuanView> selectListView(Pagination page,@Param("ew") Wrapper<YuqifakuanEntity> wrapper);
	
	YuqifakuanView selectView(@Param("ew") Wrapper<YuqifakuanEntity> wrapper);



}
