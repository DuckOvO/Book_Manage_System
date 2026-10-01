package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.YuqifakuanDao;
import com.cl.entity.YuqifakuanEntity;
import com.cl.service.YuqifakuanService;
import com.cl.entity.view.YuqifakuanView;

@Service("yuqifakuanService")
public class YuqifakuanServiceImpl extends ServiceImpl<YuqifakuanDao, YuqifakuanEntity> implements YuqifakuanService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<YuqifakuanEntity> page = this.selectPage(
                new Query<YuqifakuanEntity>(params).getPage(),
                new EntityWrapper<YuqifakuanEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<YuqifakuanEntity> wrapper) {
		  Page<YuqifakuanView> page =new Query<YuqifakuanView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<YuqifakuanView> selectListView(Wrapper<YuqifakuanEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public YuqifakuanView selectView(Wrapper<YuqifakuanEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
