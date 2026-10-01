package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.YuqifakuanEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.YuqifakuanView;


/**
 * 逾期罚款
 *
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
public interface YuqifakuanService extends IService<YuqifakuanEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<YuqifakuanView> selectListView(Wrapper<YuqifakuanEntity> wrapper);
   	
   	YuqifakuanView selectView(@Param("ew") Wrapper<YuqifakuanEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<YuqifakuanEntity> wrapper);



}

