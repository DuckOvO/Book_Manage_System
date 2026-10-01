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


import com.cl.dao.TushuxujieDao;
import com.cl.entity.TushuxujieEntity;
import com.cl.service.TushuxujieService;
import com.cl.entity.view.TushuxujieView;

@Service("tushuxujieService")
public class TushuxujieServiceImpl extends ServiceImpl<TushuxujieDao, TushuxujieEntity> implements TushuxujieService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<TushuxujieEntity> page = this.selectPage(
                new Query<TushuxujieEntity>(params).getPage(),
                new EntityWrapper<TushuxujieEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<TushuxujieEntity> wrapper) {
		  Page<TushuxujieView> page =new Query<TushuxujieView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<TushuxujieView> selectListView(Wrapper<TushuxujieEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public TushuxujieView selectView(Wrapper<TushuxujieEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
