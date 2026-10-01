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
 * 客服聊天
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2026-04-08 16:29:08
 */
@TableName("chat")
public class ChatEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public ChatEntity() {
		
	}
	
	public ChatEntity(T t) {
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
	 * 管理员id
	 */
					
	private Long adminid;
	
	/**
	 * 提问内容
	 */
					
	private String ask;
	
	/**
	 * 回复内容
	 */
					
	private String reply;
	
	/**
	 * 是否回复
	 */
					
	private Integer isreply;
	
	/**
	 * 管理表
	 */
					
	private String adminTableName;
	
	/**
	 * 用户表
	 */
					
	private String userTableName;
	
	/**
	 * 已读1/未读0
	 */
					
	private Integer isRead;
	
	/**
	 * 用户名
	 */
					
	private String userName;
	
	/**
	 * 用户头像
	 */
					
	private String userImage;
	
	/**
	 * 内容(1:文本,2:图片,3:视频,4:文件,5:表情)
	 */
					
	private Integer type;
	
	/**
	 * 用户id
	 */
					
	private Long userid;
	
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
	 * 设置：管理员id
	 */
	public void setAdminid(Long adminid) {
		this.adminid = adminid;
	}
	/**
	 * 获取：管理员id
	 */
	public Long getAdminid() {
		return adminid;
	}
	/**
	 * 设置：提问内容
	 */
	public void setAsk(String ask) {
		this.ask = ask;
	}
	/**
	 * 获取：提问内容
	 */
	public String getAsk() {
		return ask;
	}
	/**
	 * 设置：回复内容
	 */
	public void setReply(String reply) {
		this.reply = reply;
	}
	/**
	 * 获取：回复内容
	 */
	public String getReply() {
		return reply;
	}
	/**
	 * 设置：是否回复
	 */
	public void setIsreply(Integer isreply) {
		this.isreply = isreply;
	}
	/**
	 * 获取：是否回复
	 */
	public Integer getIsreply() {
		return isreply;
	}
	/**
	 * 设置：管理表
	 */
	public void setAdminTableName(String adminTableName) {
		this.adminTableName = adminTableName;
	}
	/**
	 * 获取：管理表
	 */
	public String getAdminTableName() {
		return adminTableName;
	}
	/**
	 * 设置：用户表
	 */
	public void setUserTableName(String userTableName) {
		this.userTableName = userTableName;
	}
	/**
	 * 获取：用户表
	 */
	public String getUserTableName() {
		return userTableName;
	}
	/**
	 * 设置：已读1/未读0
	 */
	public void setIsRead(Integer isRead) {
		this.isRead = isRead;
	}
	/**
	 * 获取：已读1/未读0
	 */
	public Integer getIsRead() {
		return isRead;
	}
	/**
	 * 设置：用户名
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * 获取：用户名
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * 设置：用户头像
	 */
	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}
	/**
	 * 获取：用户头像
	 */
	public String getUserImage() {
		return userImage;
	}
	/**
	 * 设置：内容(1:文本,2:图片,3:视频,4:文件,5:表情)
	 */
	public void setType(Integer type) {
		this.type = type;
	}
	/**
	 * 获取：内容(1:文本,2:图片,3:视频,4:文件,5:表情)
	 */
	public Integer getType() {
		return type;
	}
	/**
	 * 设置：用户id
	 */
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	/**
	 * 获取：用户id
	 */
	public Long getUserid() {
		return userid;
	}

}
