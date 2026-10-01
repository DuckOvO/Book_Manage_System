package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.TushuxujieEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.TushuxujieView;


/**
 * 图书续借
 *
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface TushuxujieService extends IService<TushuxujieEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<TushuxujieView> selectListView(Wrapper<TushuxujieEntity> wrapper);
   	
   	TushuxujieView selectView(@Param("ew") Wrapper<TushuxujieEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<TushuxujieEntity> wrapper);



}

