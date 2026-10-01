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

import com.cl.entity.TushuxujieEntity;
import com.cl.entity.view.TushuxujieView;

import com.cl.service.TushuxujieService;
import com.cl.service.TokenService;

/**
 * 图书续借
 * 后端接口
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@RestController
@RequestMapping("/tushuxujie")
public class TushuxujieController {
    @Autowired
    private TushuxujieService tushuxujieService;











    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,TushuxujieEntity tushuxujie,
                                                                                                                                                                                                                                    HttpServletRequest request){
            String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                            if(tableName.equals("yonghu")) {
            tushuxujie.setYonghuming((String)request.getSession().getAttribute("username"));
                    }
                                                                                                        EntityWrapper<TushuxujieEntity> ew = new EntityWrapper<TushuxujieEntity>();
                                                                                                                                                                                                                            
    
    
        PageUtils page = tushuxujieService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, tushuxujie), params), params));
        Map<String, String> deSens = new HashMap<>();
                                                                                                                                                                                                                                                                                    DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,TushuxujieEntity tushuxujie, 
		HttpServletRequest request){
        EntityWrapper<TushuxujieEntity> ew = new EntityWrapper<TushuxujieEntity>();

		PageUtils page = tushuxujieService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, tushuxujie), params), params));
        Map<String, String> deSens = new HashMap<>();
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( TushuxujieEntity tushuxujie){
       	EntityWrapper<TushuxujieEntity> ew = new EntityWrapper<TushuxujieEntity>();
      	ew.allEq(MPUtil.allEQMapPre( tushuxujie, MPUtil.camelToSnake("tushuxujie")));
        return R.ok().put("data", tushuxujieService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(TushuxujieEntity tushuxujie){
        EntityWrapper< TushuxujieEntity> ew = new EntityWrapper< TushuxujieEntity>();
 		ew.allEq(MPUtil.allEQMapPre( tushuxujie, MPUtil.camelToSnake("tushuxujie")));
		TushuxujieView tushuxujieView =  tushuxujieService.selectView(ew);
		return R.ok("查询图书续借成功").put("data", tushuxujieView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        TushuxujieEntity tushuxujie = tushuxujieService.selectById(id);
		tushuxujie = tushuxujieService.selectView(new EntityWrapper<TushuxujieEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(tushuxujie,deSens);
        return R.ok().put("data", tushuxujie);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        TushuxujieEntity tushuxujie = tushuxujieService.selectById(id);
		tushuxujie = tushuxujieService.selectView(new EntityWrapper<TushuxujieEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(tushuxujie,deSens);
        return R.ok().put("data", tushuxujie);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增图书续借")
    public R save(@RequestBody TushuxujieEntity tushuxujie, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(tushuxujie);

        tushuxujieService.insert(tushuxujie);
        return R.ok().put("data",tushuxujie.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增图书续借")
    @RequestMapping("/add")
    public R add(@RequestBody TushuxujieEntity tushuxujie, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(tushuxujie);

        tushuxujieService.insert(tushuxujie);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改图书续借")
    public R update(@RequestBody TushuxujieEntity tushuxujie, HttpServletRequest request){
        //ValidatorUtils.validateEntity(tushuxujie);
        tushuxujieService.updateById(tushuxujie);//全部更新
        return R.ok();
    }

    /**  
     * 审核 
     */   
    @RequestMapping("/shBatch")
    @Transactional
    @SysLog("审核图书续借")
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<TushuxujieEntity> list = new ArrayList<TushuxujieEntity>();
        for(Long id : ids) {
            TushuxujieEntity tushuxujie = tushuxujieService.selectById(id);
            tushuxujie.setSfsh(sfsh);
            tushuxujie.setShhf(shhf);
            list.add(tushuxujie);
        }    
        tushuxujieService.updateBatchById(list);
        return R.ok();
    }    
    
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除图书续借")
    public R delete(@RequestBody Long[] ids){
        tushuxujieService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	








}
