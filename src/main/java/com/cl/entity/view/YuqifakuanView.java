package com.cl.entity.view;

import com.cl.entity.YuqifakuanEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 逾期罚款
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@TableName("yuqifakuan")
public class YuqifakuanView  extends YuqifakuanEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public YuqifakuanView(){
	}
 
 	public YuqifakuanView(YuqifakuanEntity yuqifakuanEntity){
 	try {
			BeanUtils.copyProperties(this, yuqifakuanEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
