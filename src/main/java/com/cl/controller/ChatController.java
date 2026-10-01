package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.lang.*;
import java.math.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import com.cl.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cl.annotation.IgnoreAuth;
import com.cl.annotation.SysLog;

import com.cl.entity.ChatEntity;
import com.cl.entity.view.ChatView;

import com.cl.service.ChatService;
import com.cl.service.TokenService;

/**
 * 客服聊天
 * 后端接口
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@RestController
@RequestMapping("/chat")
public class ChatController {
    @Autowired
    private ChatService chatService;











    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ChatEntity chat,
                                                                                                                                                HttpServletRequest request){
                    EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
                                                                                                                                        
    
            if (null != params.get("userid")) {
            ChatEntity new_chat = new ChatEntity<>();
            new_chat.setIsRead(1);
            chatService.update(new_chat, new EntityWrapper<ChatEntity>().eq("userid" , params.get("userid")).eq("is_read","0").isNotNull("ask").ne("ask", ""));
        }
    
        PageUtils page = chatService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chat), params), params));
        Map<String, String> deSens = new HashMap<>();
                                                                                                                                                                                                                                            DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ChatEntity chat, 
		HttpServletRequest request){
    	if(!request.getSession().getAttribute("role").toString().equals("管理员")) {
    		chat.setUserid((Long)request.getSession().getAttribute("userId"));
    	}

        EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();

        if(params.get("isRead")==null && null != params.get("userid")){   //未指定isRead时，将所有相关记录设为已读
            ChatEntity new_chat = new ChatEntity<>();
            new_chat.setIsRead(1);
            chatService.update(new_chat, new EntityWrapper<ChatEntity>().eq("userid", params.get("userid")).eq("is_read", "0")
                    .isNotNull("reply").ne("reply", ""));
        }
		PageUtils page = chatService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chat), params), params));
        Map<String, String> deSens = new HashMap<>();
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ChatEntity chat){
       	EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
      	ew.allEq(MPUtil.allEQMapPre( chat, MPUtil.camelToSnake("chat")));
        return R.ok().put("data", chatService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ChatEntity chat){
        EntityWrapper< ChatEntity> ew = new EntityWrapper< ChatEntity>();
 		ew.allEq(MPUtil.allEQMapPre( chat, MPUtil.camelToSnake("chat")));
		ChatView chatView =  chatService.selectView(ew);
		return R.ok("查询客服聊天成功").put("data", chatView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ChatEntity chat = chatService.selectById(id);
		chat = chatService.selectView(new EntityWrapper<ChatEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(chat,deSens);
        return R.ok().put("data", chat);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ChatEntity chat = chatService.selectById(id);
		chat = chatService.selectView(new EntityWrapper<ChatEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(chat,deSens);
        return R.ok().put("data", chat);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增客服聊天")
    public R save(@RequestBody ChatEntity chat, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(chat);
    	if(StringUtils.isNotBlank(chat.getAsk())) {
			chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", request.getSession().getAttribute("userId")));
    		chat.setUserid((Long)request.getSession().getAttribute("userId"));
    		chat.setIsreply(1);
    	}
    	if(StringUtils.isNotBlank(chat.getReply())) {
    		chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", chat.getUserid()));
    		chat.setAdminid((Long)request.getSession().getAttribute("userId"));
    	}

        chatService.insert(chat);
        return R.ok().put("data",chat.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增客服聊天")
    @RequestMapping("/add")
    public R add(@RequestBody ChatEntity chat, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(chat);
        if(null == chat.getUserid()){
            chat.setUserid((Long)request.getSession().getAttribute("userId"));
        }
    	if(StringUtils.isNotBlank(chat.getAsk())) {
			chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", request.getSession().getAttribute("userId")));
    		chat.setUserid((Long)request.getSession().getAttribute("userId"));
    		chat.setIsreply(1);
    	}
    	if(StringUtils.isNotBlank(chat.getReply())) {
    		chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", chat.getUserid()));
    		chat.setAdminid((Long)request.getSession().getAttribute("userId"));
    	}

        chatService.insert(chat);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改客服聊天")
    public R update(@RequestBody ChatEntity chat, HttpServletRequest request){
        //ValidatorUtils.validateEntity(chat);
        chatService.updateById(chat);//全部更新
        return R.ok();
    }

    
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除客服聊天")
    public R delete(@RequestBody Long[] ids){
        chatService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	








}
