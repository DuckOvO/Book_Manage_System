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


import com.cl.dao.ChathelperDao;
import com.cl.entity.ChathelperEntity;
import com.cl.service.ChathelperService;
import com.cl.entity.view.ChathelperView;

@Service("chathelperService")
public class ChathelperServiceImpl extends ServiceImpl<ChathelperDao, ChathelperEntity> implements ChathelperService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ChathelperEntity> page = this.selectPage(
                new Query<ChathelperEntity>(params).getPage(),
                new EntityWrapper<ChathelperEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ChathelperEntity> wrapper) {
		  Page<ChathelperView> page =new Query<ChathelperView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ChathelperView> selectListView(Wrapper<ChathelperEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ChathelperView selectView(Wrapper<ChathelperEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
