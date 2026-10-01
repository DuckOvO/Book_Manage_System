package com.cl.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 逾期罚款
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@TableName("yuqifakuan")
public class YuqifakuanEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public YuqifakuanEntity() {
		
	}
	
	public YuqifakuanEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Long id;
	/**
	 * 逾期编号
	 */
					
	private String yuqibianhao;
	
	/**
	 * 租借编号
	 */
					
	private String zujiebianhao;
	
	/**
	 * 书籍名称
	 */
					
	private String shujimingcheng;
	
	/**
	 * 封面
	 */
					
	private String fengmian;
	
	/**
	 * 书籍分类
	 */
					
	private String shujifenlei;
	
	/**
	 * ISBN
	 */
					
	private String bianma;
	
	/**
	 * 归还数量
	 */
					
	private Integer jieyueshuliang;
	
	/**
	 * 用户名
	 */
					
	private String yonghuming;
	
	/**
	 * 姓名
	 */
					
	private String xingming;
	
	/**
	 * 归还时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat 		
	private Date guihaishijian;
	
	/**
	 * 罚款金额
	 */
					
	private Double fakuanjine;
	
	/**
	 * 是否支付
	 */
					
	private String ispay;
	
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：逾期编号
	 */
	public void setYuqibianhao(String yuqibianhao) {
		this.yuqibianhao = yuqibianhao;
	}
	/**
	 * 获取：逾期编号
	 */
	public String getYuqibianhao() {
		return yuqibianhao;
	}
	/**
	 * 设置：租借编号
	 */
	public void setZujiebianhao(String zujiebianhao) {
		this.zujiebianhao = zujiebianhao;
	}
	/**
	 * 获取：租借编号
	 */
	public String getZujiebianhao() {
		return zujiebianhao;
	}
	/**
	 * 设置：书籍名称
	 */
	public void setShujimingcheng(String shujimingcheng) {
		this.shujimingcheng = shujimingcheng;
	}
	/**
	 * 获取：书籍名称
	 */
	public String getShujimingcheng() {
		return shujimingcheng;
	}
	/**
	 * 设置：封面
	 */
	public void setFengmian(String fengmian) {
		this.fengmian = fengmian;
	}
	/**
	 * 获取：封面
	 */
	public String getFengmian() {
		return fengmian;
	}
	/**
	 * 设置：书籍分类
	 */
	public void setShujifenlei(String shujifenlei) {
		this.shujifenlei = shujifenlei;
	}
	/**
	 * 获取：书籍分类
	 */
	public String getShujifenlei() {
		return shujifenlei;
	}
	/**
	 * 设置：ISBN
	 */
	public void setBianma(String bianma) {
		this.bianma = bianma;
	}
	/**
	 * 获取：ISBN
	 */
	public String getBianma() {
		return bianma;
	}
	/**
	 * 设置：归还数量
	 */
	public void setJieyueshuliang(Integer jieyueshuliang) {
		this.jieyueshuliang = jieyueshuliang;
	}
	/**
	 * 获取：归还数量
	 */
	public Integer getJieyueshuliang() {
		return jieyueshuliang;
	}
	/**
	 * 设置：用户名
	 */
	public void setYonghuming(String yonghuming) {
		this.yonghuming = yonghuming;
	}
	/**
	 * 获取：用户名
	 */
	public String getYonghuming() {
		return yonghuming;
	}
	/**
	 * 设置：姓名
	 */
	public void setXingming(String xingming) {
		this.xingming = xingming;
	}
	/**
	 * 获取：姓名
	 */
	public String getXingming() {
		return xingming;
	}
	/**
	 * 设置：归还时间
	 */
	public void setGuihaishijian(Date guihaishijian) {
		this.guihaishijian = guihaishijian;
	}
	/**
	 * 获取：归还时间
	 */
	public Date getGuihaishijian() {
		return guihaishijian;
	}
	/**
	 * 设置：罚款金额
	 */
	public void setFakuanjine(Double fakuanjine) {
		this.fakuanjine = fakuanjine;
	}
	/**
	 * 获取：罚款金额
	 */
	public Double getFakuanjine() {
		return fakuanjine;
	}
	/**
	 * 设置：是否支付
	 */
	public void setIspay(String ispay) {
		this.ispay = ispay;
	}
	/**
	 * 获取：是否支付
	 */
	public String getIspay() {
		return ispay;
	}

}
