package com.cl.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import com.hankcs.hanlp.HanLP;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cl.annotation.IgnoreAuth;
import com.baidu.aip.face.AipFace;
import com.baidu.aip.face.MatchRequest;
import com.baidu.aip.util.Base64Util;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cl.entity.ConfigEntity;
import com.cl.service.CommonService;
import com.cl.service.ConfigService;
import com.cl.utils.BaiduUtil;
import com.cl.utils.FileUtil;
import com.cl.utils.R;
import com.cl.utils.CommonUtil;
import com.cl.utils.MPUtil;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import org.apache.commons.io.IOUtils;
/**
 * 通用接口
 */
@RestController
public class CommonController{
	@Autowired
	private CommonService commonService;

    private static AipFace client = null;
    
    @Autowired
    private ConfigService configService;

    
	/**
	 * 获取table表中的column列表(联动接口)
	 * @param table
	 * @param column
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/option/{tableName}/{columnName}")
	public R getOption(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName,@RequestParam(required = false) String conditionColumn,@RequestParam(required = false) String conditionValue,String level,String parent, HttpServletRequest request) throws IOException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("column", MPUtil.camelToSnake(columnName));
		if(StringUtils.isNotBlank(level)) {
			params.put("level", level);
		}
		if(StringUtils.isNotBlank(parent)) {
			params.put("parent", parent);
		}
        if(StringUtils.isNotBlank(conditionColumn)) {
            params.put("conditionColumn", MPUtil.camelToSnake(conditionColumn));
        }
        if(StringUtils.isNotBlank(conditionValue)) {
            params.put("conditionValue", conditionValue);
        }
		params.putAll(CommonUtil.parseRequest(request));
		if(params.containsKey("refConditionColumn"))
		{
			params.put("refConditionColumn", MPUtil.camelToSnake(params.get("refConditionColumn").toString()));
		}
		List<String> data = commonService.getOption(params);
		return R.ok().put("data", data);
	}
	
	/**
	 * 根据table中的column获取单条记录
	 * @param table
	 * @param column
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/follow/{tableName}/{columnName}")
	public R getFollowByOption(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, @RequestParam String columnValue) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("column", MPUtil.camelToSnake(columnName));
		params.put("columnValue", columnValue);
		Map<String, Object> result = commonService.getFollowByOption(params);
		return R.ok().put("data", MPUtil.snakeMapToCamel(result));
	}
	
	/**
	 * 修改table表的sfsh状态
	 * @param table
	 * @param map
	 * @return
	 */
	@RequestMapping("/sh/{tableName}")
	public R sh(@PathVariable("tableName") String tableName, @RequestBody Map<String, Object> map) {
		map.put("table", MPUtil.camelToSnake(tableName));
		commonService.sh(map);
		return R.ok();
	}
	
	/**
	 * 获取需要提醒的记录数
	 * @param tableName
	 * @param columnName
	 * @param type 1:数字 2:日期
	 * @param map
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/remind/{tableName}/{columnName}/{type}")
	public R remindCount(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("table", MPUtil.camelToSnake(tableName));
		map.put("column", MPUtil.camelToSnake(columnName));
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		int count = commonService.remindCount(map);
		return R.ok().put("count", count);
	}
	
	/**
	 * 单列求和
	 */
	@IgnoreAuth
	@RequestMapping("/cal/{tableName}/{columnName}")
	public R cal(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("column", MPUtil.camelToSnake(columnName));
		Map<String, Object> result = commonService.selectCal(params);
		return R.ok().put("data", result);
	}
	
	/**
	 * 分组统计
	 */
	@IgnoreAuth
	@RequestMapping("/group/{tableName}/{columnName}")
	public R group(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("column", MPUtil.camelToSnake(columnName));
		List<Map<String, Object>> result = commonService.selectGroup(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}

	/**
	 * 词云数据
	 * @param tableName
	 * @param columnName
	 */
	@IgnoreAuth
	@RequestMapping("/wordCloud/{tableName}/{columnName}")
	public R wordCloud(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		if (tableName == null || tableName.isEmpty() || columnName == null || columnName.isEmpty()) {
			return R.error("Table name and column name cannot be empty");
		}

		Map<String, Object> params = new HashMap<>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("column", MPUtil.camelToSnake(columnName));
		List<Map<String, Object>> result = new ArrayList<>();
		List<String> listText = commonService.selectGroup(params).stream().map(m -> m.get(MPUtil.camelToSnake(columnName)).toString()).collect(Collectors.toList());

		Map<String, Integer> keywordCounts = new HashMap<>();
		for (String text : listText) {
			List<String> phrases = HanLP.extractPhrase(text, 3);
			List<String> keywords = HanLP.extractKeyword(text, 3);

			// 合并两种结果
			Set<String> uniqueTerms = new HashSet<>();
			uniqueTerms.addAll(phrases);
			uniqueTerms.addAll(keywords);

			for (String term : uniqueTerms) {
				if (term.length() > 1) {
					keywordCounts.put(term, keywordCounts.getOrDefault(term, 0) + 1);
				}
			}
		}

		keywordCounts.forEach((key, value) -> {
			Map<String, Object> item = new HashMap<>();
			item.put(columnName, key);
			item.put("total", value);
			result.add(item);
		});

		return R.ok().put("data", result);
	}

	/**
	 * 更新列数据
	 *
	 * @param tableName 表名
	 * @param type      1 字符串，直接替换。 2 数字运算，+ - * /。
	 */
	@RequestMapping("/updateColumn/{tableName}/{type}")
	public R updateColumn(@PathVariable("tableName") String tableName, @PathVariable("type") int type, HttpServletRequest request) throws IOException {
		Map<String, Object> params = new HashMap<>();
		params.put("tableName", MPUtil.camelToSnake(tableName));
		params.put("type", type);
		params.putAll(CommonUtil.parseRequest(request));
		if (type == 1) {
			Map<String, Object> params1 = new HashMap<>();
			params1.put("table", MPUtil.camelToSnake(tableName));
			params1.put("column", MPUtil.camelToSnake(params.get("csuConditionColumn")+""));
			params1.put("columnValue", params.get("csuConditionColumnValue"));
			Map<String, Object> res = commonService.getFollowByOption(params1);
			if (res != null && res.get(params.get("csuUpdateColumn").toString()).equals(params.get("csuUpdateColumnValue").toString())) {
				return R.error("更新失败");
			}
		}
		if (commonService.updateColumn(params)) {
			return R.ok("更新成功");
		}
		return R.error("库存不足");
	}

	/**
     * 删除列数据
     *
     * @param tableName 表名
     */
	@RequestMapping("/deleteColumn/{tableName}")
	public R deleteColumn(@PathVariable("tableName") String tableName, HttpServletRequest request) throws IOException {
		Map<String, Object> params = new HashMap<>();
		params.put("tableName", MPUtil.camelToSnake(tableName));
		params.putAll(CommonUtil.parseRequest(request));
		if (commonService.deleteColumn(params)) {
			return R.ok("删除成功");
		}
		return R.error("删除失败");
	}

	/**
	 * （按值统计）
	 */
	@IgnoreAuth
	@RequestMapping("/value/{tableName}/{xColumnName}/{yColumnName}")
	public R value(@PathVariable("tableName") String tableName, @PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("xColumn", MPUtil.camelToSnake(xColumnName));
		params.put("yColumn", yColumnName);
		List<Map<String, Object>> result = commonService.selectValue(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}

	/**
 	 * （按值统计）时间统计类型
 	 */
	@IgnoreAuth
	@RequestMapping("/value/{tableName}/{xColumnName}/{yColumnName}/{timeStatType}")
	public R valueDay(@PathVariable("tableName") String tableName, @PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", MPUtil.camelToSnake(tableName));
		params.put("xColumn", MPUtil.camelToSnake(xColumnName));
		params.put("yColumn", yColumnName);
		params.put("timeStatType", timeStatType);
		List<Map<String, Object>> result = commonService.selectTimeStatValue(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}



    /**
    * MySQL数据库导出
    */
    @RequestMapping("/mysqldump")
    public void exportDatabaseTool(HttpServletResponse response)throws InterruptedException {
        String fileName = "mysql.dmp";
        try {
            Runtime runtime = Runtime.getRuntime();
            String path = "/usr/bin/";
            String cmd = "mysqldump -h127.0.0.1 -uroot -P3306 -p123456 cl806133279";
            cmd = path +"/" + cmd;
            Process process = runtime.exec(cmd);
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024*4];
            int n = 0;
            while (-1 != (n = process.getInputStream().read(buffer))) {
                output.write(buffer, 0, n);
            }
            response.reset();
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName+"\"");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Access-Control-Allow-Credentials", "true");
            response.setContentType("application/octet-stream; charset=UTF-8");
            IOUtils.write(output.toByteArray(), response.getOutputStream());
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

	/*
	 * 百度千帆
	 */
	@RequestMapping("/baidu/askai")
	@IgnoreAuth
	public R baiduAskai(String ask) {
		return R.ok().put("data", BaiduUtil.qfChat(ask+"。要求：回答不能出现emoji图标。"));
	}
}
