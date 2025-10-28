package com.miniprogram.uniappwx.entity;


import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

// ============ User实体 ============
@Data
@TableName("tbl_user")
public class User {
	@TableId(type = IdType.AUTO)
	private Long id;

	private String openid;

	private String unionid;

	private String phone;

	private String nickname;

	private String avatar;

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime createTime;

	@TableField(fill = FieldFill.INSERT_UPDATE)
	private LocalDateTime updateTime;
}