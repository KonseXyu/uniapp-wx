package com.miniprogram.uniappwx.utils;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class WxUtil {

	// 【新增】注入 Redis 模板
	@Resource
	private StringRedisTemplate stringRedisTemplate;

	// 【新增】Redis Key 常量
	private static final String WX_ACCESS_TOKEN_KEY = "wx:miniapp:access_token";
	// AccessToken 有效期为 7200 秒，我们设置一个安全阈值，例如 7000 秒
	private static final long EXPIRE_SECONDS = 7000;

	@Value("${wechat.appid}")
	private String appid;

	@Value("${wechat.secret}")
	private String secret;

	private static final String CODE2SESSION_URL =
			"https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code";

	/**
	 * 通过code获取openid和session_key
	 */
	public JSONObject code2Session(String code) {
		String url = String.format(CODE2SESSION_URL, appid, secret, code);

		try {
			String result = HttpUtil.get(url);
			log.info("微信登录响应: {}", result);

			JSONObject json = JSONUtil.parseObj(result);

			if (json.containsKey("errcode") && json.getInt("errcode") != 0) {
				log.error("微信登录失败: {}", json.getStr("errmsg"));
				return null;
			}

			return json;
		} catch (Exception e) {
			log.error("调用微信接口异常", e);
			return null;
		}
	}

	/**
	 * 解密手机号（如果需要）
	 */
	public String decryptPhone(String encryptedData, String iv, String sessionKey) {
		// 这里需要实现AES解密逻辑
		// 具体实现可以参考微信官方文档
		// 暂时返回null，实际项目中需要完善
		return null;
	}


	/**
	 * 获取微信 AccessToken，使用 Redis 缓存机制 【修改点】
	 */
	public String getAccessToken() {
		// 1. 检查 Redis 缓存
		String cachedToken = stringRedisTemplate.opsForValue().get(WX_ACCESS_TOKEN_KEY);
		if (cachedToken != null) {
			log.info("从 Redis 缓存获取 AccessToken");
			return cachedToken;
		}

		// 2. 缓存不存在或已过期，请求微信接口
		String url = String.format("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",
				appid, secret);

		try {
			String result = HttpUtil.get(url);
			JSONObject json = JSONUtil.parseObj(result);

			if (json.containsKey("access_token")) {
				String accessToken = json.getStr("access_token");

				// 3. 将新的 AccessToken 存入 Redis 并设置过期时间
				stringRedisTemplate.opsForValue().set(WX_ACCESS_TOKEN_KEY, accessToken, EXPIRE_SECONDS, TimeUnit.SECONDS);
				log.info("从微信获取并缓存新的 AccessToken");
				return accessToken;
			} else {
				log.error("获取AccessToken失败: {}", json);
				return null;
			}
		} catch (Exception e) {
			log.error("请求微信AccessToken接口异常", e);
			return null;
		}
	}

	/**
	 * 调用微信接口获取用户手机号 (新版 API)
	 * @param accessToken
	 * @param code 前端 getPhoneNumber 事件返回的 code
	 * @return 包含 phone_info 的 JSONObject
	 */
	public JSONObject getPhoneNumber(String accessToken, String code) {
		String url = String.format("https://api.weixin.qq.com/wxa/business/getuserphonenumber?access_token=%s", accessToken);
		String jsonBody = String.format("{\"code\":\"%s\"}", code);

		try {
			// 使用 Hutool 的 HTTP 工具或您自己的工具发送 POST 请求
			String result = HttpRequest.post(url)
					.body(jsonBody)
					.execute()
					.body();

			JSONObject response = JSONUtil.parseObj(result);
			return response;

		} catch (Exception e) {
			log.error("请求微信获取手机号接口异常", e);
			return null;
		}
	}
}