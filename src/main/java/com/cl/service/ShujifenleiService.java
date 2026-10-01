package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ShujifenleiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ShujifenleiView;


/**
 * 书籍分类
 *
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface ShujifenleiService extends IService<ShujifenleiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ShujifenleiView> selectListView(Wrapper<ShujifenleiEntity> wrapper);
   	
   	ShujifenleiView selectView(@Param("ew") Wrapper<ShujifenleiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ShujifenleiEntity> wrapper);



}

