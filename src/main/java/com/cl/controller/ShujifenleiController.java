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

import com.cl.entity.ShujifenleiEntity;
import com.cl.entity.view.ShujifenleiView;

import com.cl.service.ShujifenleiService;
import com.cl.service.TokenService;

/**
 * 书籍分类
 * 后端接口
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@RestController
@RequestMapping("/shujifenlei")
public class ShujifenleiController {
    @Autowired
    private ShujifenleiService shujifenleiService;











    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ShujifenleiEntity shujifenlei,
                                            HttpServletRequest request){
                    EntityWrapper<ShujifenleiEntity> ew = new EntityWrapper<ShujifenleiEntity>();
                                    
    
    
        PageUtils page = shujifenleiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shujifenlei), params), params));
        Map<String, String> deSens = new HashMap<>();
                                    DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ShujifenleiEntity shujifenlei, 
		HttpServletRequest request){
        EntityWrapper<ShujifenleiEntity> ew = new EntityWrapper<ShujifenleiEntity>();

		PageUtils page = shujifenleiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shujifenlei), params), params));
        Map<String, String> deSens = new HashMap<>();
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ShujifenleiEntity shujifenlei){
       	EntityWrapper<ShujifenleiEntity> ew = new EntityWrapper<ShujifenleiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( shujifenlei, MPUtil.camelToSnake("shujifenlei")));
        return R.ok().put("data", shujifenleiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ShujifenleiEntity shujifenlei){
        EntityWrapper< ShujifenleiEntity> ew = new EntityWrapper< ShujifenleiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( shujifenlei, MPUtil.camelToSnake("shujifenlei")));
		ShujifenleiView shujifenleiView =  shujifenleiService.selectView(ew);
		return R.ok("查询书籍分类成功").put("data", shujifenleiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ShujifenleiEntity shujifenlei = shujifenleiService.selectById(id);
		shujifenlei = shujifenleiService.selectView(new EntityWrapper<ShujifenleiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shujifenlei,deSens);
        return R.ok().put("data", shujifenlei);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ShujifenleiEntity shujifenlei = shujifenleiService.selectById(id);
		shujifenlei = shujifenleiService.selectView(new EntityWrapper<ShujifenleiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shujifenlei,deSens);
        return R.ok().put("data", shujifenlei);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增书籍分类")
    public R save(@RequestBody ShujifenleiEntity shujifenlei, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(shujifenlei);

        shujifenleiService.insert(shujifenlei);
        return R.ok().put("data",shujifenlei.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增书籍分类")
    @RequestMapping("/add")
    public R add(@RequestBody ShujifenleiEntity shujifenlei, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(shujifenlei);

        shujifenleiService.insert(shujifenlei);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改书籍分类")
    public R update(@RequestBody ShujifenleiEntity shujifenlei, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shujifenlei);
        shujifenleiService.updateById(shujifenlei);//全部更新
        return R.ok();
    }

    
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除书籍分类")
    public R delete(@RequestBody Long[] ids){
        shujifenleiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	








}
