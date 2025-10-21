package com.miniprogram.uniappwx.service;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.*;
import com.miniprogram.uniappwx.mapper.*;
import com.miniprogram.uniappwx.utils.JwtUtil;
import com.miniprogram.uniappwx.utils.WxUtil;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;

@Slf4j
@Service
public class AuthService {

	@Resource
	private WxUtil wxUtil;

	@Resource
	private JwtUtil jwtUtil;

	@Resource
	private UserMapper userMapper;

	@Resource
	private CompanyBasicMapper companyBasicMapper;

	/**
	 * 微信登录
	 */
	@Transactional(rollbackFor = Exception.class)
	public LoginVO wxLogin(WxLoginDTO dto) {
		// 1. 调用微信接口获取openid
		JSONObject sessionData = wxUtil.code2Session(dto.getCode());
		if (sessionData == null || !sessionData.containsKey("openid")) {
			throw new RuntimeException("微信登录失败");
		}

		String openid = sessionData.getStr("openid");
		String unionid = sessionData.getStr("unionid");

		// 2. 查询或创建用户
		User user = userMapper.selectOne(
				new LambdaQueryWrapper<User>()
						.eq(User::getOpenid, openid)
		);

		if (user == null) {
			user = new User();
			user.setOpenid(openid);
			user.setUnionid(unionid);
			userMapper.insert(user);
		}

		// 3. 检查是否有企业信息
		CompanyBasic company = companyBasicMapper.selectOne(
				new LambdaQueryWrapper<CompanyBasic>()
						.eq(CompanyBasic::getUserId, user.getId())
		);

		// 4. 生成Token
		String token = jwtUtil.generateToken(user.getId());

		// 5. 构造返回数据
		LoginVO vo = new LoginVO();
		vo.setToken(token);
		vo.setHasCompany(company != null);

		UserInfoVO userInfo = new UserInfoVO();
		userInfo.setId(user.getId());
		userInfo.setPhone(user.getPhone());
		userInfo.setNickname(user.getNickname());
		userInfo.setAvatar(user.getAvatar());
		vo.setUserInfo(userInfo);

		return vo;
	}

	/**
	 * 获取用户信息
	 */
	public UserInfoVO getUserInfo(Long userId) {
		User user = userMapper.selectById(userId);
		if (user == null) {
			throw new RuntimeException("用户不存在");
		}

		UserInfoVO vo = new UserInfoVO();
		BeanUtils.copyProperties(user, vo);
		return vo;
	}

	/**
	 * 【新增】通过手机号授权的 Code 进行登录/绑定
	 */
	@Transactional(rollbackFor = Exception.class)
	public LoginVO wxPhoneLogin(PhoneLoginDTO dto) {
		// 【新增步骤 1】先用 code 换取 openid 和 session_key
		JSONObject sessionJson = wxUtil.code2Session(dto.getLoginCode());

		if (sessionJson == null) {
			throw new RuntimeException("微信登录凭证 code 无效或已过期");
		}

		// 【新增】获取 openid 和 session_key
		String openId = sessionJson.getStr("openid");
		String sessionKey = sessionJson.getStr("session_key");
		String unionIdFromSession = sessionJson.getStr("unionid"); // 可能会有 unionid

		// 1. 调用微信接口获取 AccessToken (获取手机号需要 AccessToken)
		String accessToken = wxUtil.getAccessToken();
		if (accessToken == null) {
			log.error("获取 AccessToken 失败");
			throw new RuntimeException("服务暂时不可用，请稍后再试");
		}
		// 2. 调用微信接口获取手机号信息
		JSONObject phoneResponse = wxUtil.getPhoneNumber(accessToken, dto.getPhoneCode()); // <--- 使用 phoneCode

		if (phoneResponse == null || phoneResponse.getInt("errcode", -1) != 0) {
			String errmsg = phoneResponse != null ? phoneResponse.getStr("errmsg") : "未知错误";
			log.error("微信获取手机号失败: {}", errmsg);
			throw new RuntimeException("获取手机号授权失败：" + errmsg);
		}


		// 3. 解析手机号数据
		JSONObject phoneInfo = phoneResponse.getJSONObject("phone_info");
		String phoneNumber = phoneInfo.getStr("phoneNumber");
		String unionId = phoneInfo.getStr("unionId"); // 手机号接口也可能返回 unionId

		// 4. 通过手机号查询用户 (如果用户已注册，且手机号已绑定)
		User user = userMapper.selectOne(
				new LambdaQueryWrapper<User>()
						.eq(User::getPhone, phoneNumber)
		);

		if (user == null) {
			// 创建新用户
			user = new User();
			user.setPhone(phoneNumber);
			// 【关键】将通过 loginCode 获取到的 openid 和 unionid 存入新用户
			if (openId != null) {
				user.setOpenid(openId);
			}
			if (unionIdFromSession != null) {
				user.setUnionid(unionIdFromSession);
			}
			userMapper.insert(user);
		} else {
			// 如果用户已存在，更新其 unionid (如果需要) 或其他信息
			if (unionId != null && user.getUnionid() == null) {
				user.setUnionid(unionId);
				userMapper.updateById(user);
			}
			// 确保手机号已绑定
			if (user.getPhone() == null) {
				user.setPhone(phoneNumber);
				userMapper.updateById(user);
			}
		}

		// 5. 生成Token
		String token = jwtUtil.generateToken(user.getId());

		// 6. 构造返回数据
		LoginVO vo = new LoginVO();
		vo.setToken(token);

		// ... (省略查询公司信息的部分，保持与 wxLogin 一致)
		CompanyBasic company = companyBasicMapper.selectOne(
				new LambdaQueryWrapper<CompanyBasic>()
						.eq(CompanyBasic::getUserId, user.getId())
		);
		vo.setHasCompany(company != null);

		UserInfoVO userInfo = new UserInfoVO();
		userInfo.setId(user.getId());
		userInfo.setPhone(user.getPhone());
		// ... 拷贝其他属性 ...
		vo.setUserInfo(userInfo);

		return vo;
	}

}

