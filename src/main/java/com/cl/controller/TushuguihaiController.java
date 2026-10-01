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

import com.cl.entity.TushuguihaiEntity;
import com.cl.entity.view.TushuguihaiView;

import com.cl.service.TushuguihaiService;
import com.cl.service.TokenService;

/**
 * 图书归还
 * 后端接口
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@RestController
@RequestMapping("/tushuguihai")
public class TushuguihaiController {
    @Autowired
    private TushuguihaiService tushuguihaiService;











    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,TushuguihaiEntity tushuguihai,
                                                                                                                                                                                                                        HttpServletRequest request){
            String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                            if(tableName.equals("yonghu")) {
            tushuguihai.setYonghuming((String)request.getSession().getAttribute("username"));
                    }
                                                                                            EntityWrapper<TushuguihaiEntity> ew = new EntityWrapper<TushuguihaiEntity>();
                                                                                                                                                                                                                
    
    
        PageUtils page = tushuguihaiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, tushuguihai), params), params));
        Map<String, String> deSens = new HashMap<>();
                                                                                                                                                                                                                                                                DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,TushuguihaiEntity tushuguihai, 
		HttpServletRequest request){
        EntityWrapper<TushuguihaiEntity> ew = new EntityWrapper<TushuguihaiEntity>();

		PageUtils page = tushuguihaiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, tushuguihai), params), params));
        Map<String, String> deSens = new HashMap<>();
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( TushuguihaiEntity tushuguihai){
       	EntityWrapper<TushuguihaiEntity> ew = new EntityWrapper<TushuguihaiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( tushuguihai, MPUtil.camelToSnake("tushuguihai")));
        return R.ok().put("data", tushuguihaiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(TushuguihaiEntity tushuguihai){
        EntityWrapper< TushuguihaiEntity> ew = new EntityWrapper< TushuguihaiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( tushuguihai, MPUtil.camelToSnake("tushuguihai")));
		TushuguihaiView tushuguihaiView =  tushuguihaiService.selectView(ew);
		return R.ok("查询图书归还成功").put("data", tushuguihaiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        TushuguihaiEntity tushuguihai = tushuguihaiService.selectById(id);
		tushuguihai = tushuguihaiService.selectView(new EntityWrapper<TushuguihaiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(tushuguihai,deSens);
        return R.ok().put("data", tushuguihai);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        TushuguihaiEntity tushuguihai = tushuguihaiService.selectById(id);
		tushuguihai = tushuguihaiService.selectView(new EntityWrapper<TushuguihaiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(tushuguihai,deSens);
        return R.ok().put("data", tushuguihai);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增图书归还")
    public R save(@RequestBody TushuguihaiEntity tushuguihai, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(tushuguihai);

        tushuguihaiService.insert(tushuguihai);
        return R.ok().put("data",tushuguihai.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增图书归还")
    @RequestMapping("/add")
    public R add(@RequestBody TushuguihaiEntity tushuguihai, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(tushuguihai);

        tushuguihaiService.insert(tushuguihai);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改图书归还")
    public R update(@RequestBody TushuguihaiEntity tushuguihai, HttpServletRequest request){
        //ValidatorUtils.validateEntity(tushuguihai);
        tushuguihaiService.updateById(tushuguihai);//全部更新
        return R.ok();
    }

    
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除图书归还")
    public R delete(@RequestBody Long[] ids){
        tushuguihaiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	








}
