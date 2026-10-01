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
 * 书籍信息
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@TableName("shujixinxi")
public class ShujixinxiEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public ShujixinxiEntity() {
		
	}
	
	public ShujixinxiEntity(T t) {
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
	 * 可借数量
	 */
					
	private Integer kejieshuliang;
	
	/**
	 * 出版年份
	 */
					
	private String chubannianfen;
	
	/**
	 * 作者
	 */
					
	private String zuozhe;
	
	/**
	 * 页数
	 */
					
	private String yeshu;
	
	/**
	 * 出版社
	 */
					
	private String chubanshe;
	
	/**
	 * 简介
	 */
					
	private String jianjie;
	
	/**
	 * 包装
	 */
					
	private String baozhuang;
	
	/**
	 * 收藏数
	 */
					
	private Integer storeupNumber;
	
	/**
	 * 最近点击时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date clicktime;
	
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
	 * 设置：可借数量
	 */
	public void setKejieshuliang(Integer kejieshuliang) {
		this.kejieshuliang = kejieshuliang;
	}
	/**
	 * 获取：可借数量
	 */
	public Integer getKejieshuliang() {
		return kejieshuliang;
	}
	/**
	 * 设置：出版年份
	 */
	public void setChubannianfen(String chubannianfen) {
		this.chubannianfen = chubannianfen;
	}
	/**
	 * 获取：出版年份
	 */
	public String getChubannianfen() {
		return chubannianfen;
	}
	/**
	 * 设置：作者
	 */
	public void setZuozhe(String zuozhe) {
		this.zuozhe = zuozhe;
	}
	/**
	 * 获取：作者
	 */
	public String getZuozhe() {
		return zuozhe;
	}
	/**
	 * 设置：页数
	 */
	public void setYeshu(String yeshu) {
		this.yeshu = yeshu;
	}
	/**
	 * 获取：页数
	 */
	public String getYeshu() {
		return yeshu;
	}
	/**
	 * 设置：出版社
	 */
	public void setChubanshe(String chubanshe) {
		this.chubanshe = chubanshe;
	}
	/**
	 * 获取：出版社
	 */
	public String getChubanshe() {
		return chubanshe;
	}
	/**
	 * 设置：简介
	 */
	public void setJianjie(String jianjie) {
		this.jianjie = jianjie;
	}
	/**
	 * 获取：简介
	 */
	public String getJianjie() {
		return jianjie;
	}
	/**
	 * 设置：包装
	 */
	public void setBaozhuang(String baozhuang) {
		this.baozhuang = baozhuang;
	}
	/**
	 * 获取：包装
	 */
	public String getBaozhuang() {
		return baozhuang;
	}
	/**
	 * 设置：收藏数
	 */
	public void setStoreupNumber(Integer storeupNumber) {
		this.storeupNumber = storeupNumber;
	}
	/**
	 * 获取：收藏数
	 */
	public Integer getStoreupNumber() {
		return storeupNumber;
	}
	/**
	 * 设置：最近点击时间
	 */
	public void setClicktime(Date clicktime) {
		this.clicktime = clicktime;
	}
	/**
	 * 获取：最近点击时间
	 */
	public Date getClicktime() {
		return clicktime;
	}

}
