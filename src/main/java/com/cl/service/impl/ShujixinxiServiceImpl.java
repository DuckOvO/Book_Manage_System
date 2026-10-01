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


import com.cl.dao.ShujixinxiDao;
import com.cl.entity.ShujixinxiEntity;
import com.cl.service.ShujixinxiService;
import com.cl.entity.view.ShujixinxiView;

@Service("shujixinxiService")
public class ShujixinxiServiceImpl extends ServiceImpl<ShujixinxiDao, ShujixinxiEntity> implements ShujixinxiService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ShujixinxiEntity> page = this.selectPage(
                new Query<ShujixinxiEntity>(params).getPage(),
                new EntityWrapper<ShujixinxiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ShujixinxiEntity> wrapper) {
		  Page<ShujixinxiView> page =new Query<ShujixinxiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ShujixinxiView> selectListView(Wrapper<ShujixinxiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ShujixinxiView selectView(Wrapper<ShujixinxiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, Wrapper<ShujixinxiEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, Wrapper<ShujixinxiEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, Wrapper<ShujixinxiEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }



}
