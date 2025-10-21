package com.miniprogram.uniappwx.utils;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JwtUtil {

	@Value("${jwt.secret}")
	private String secret;

	@Value("${jwt.expiration}")
	private Long expiration;

	private SecretKey getSecretKey() {
		return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
	}

	/**
	 * 生成JWT Token
	 */
	public String generateToken(Long userId) {
		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + expiration * 1000);

		return Jwts.builder()
				.setSubject(String.valueOf(userId))
				.setIssuedAt(now)
				.setExpiration(expiryDate)
				.signWith(getSecretKey(), SignatureAlgorithm.HS256)
				.compact();
	}

	/**
	 * 从Token中获取用户ID
	 */
	public Long getUserIdFromToken(String token) {
		Claims claims = Jwts.parser()
				.setSigningKey(getSecretKey())
				.build()
				.parseClaimsJws(token)
				.getBody();

		return Long.parseLong(claims.getSubject());
	}

	/**
	 * 验证Token是否有效
	 */
	public boolean validateToken(String token) {
		try {
			Jwts.parser()
					.setSigningKey(getSecretKey())
					.build()
					.parseClaimsJws(token);
			return true;
		} catch (JwtException | IllegalArgumentException e) {
			return false;
		}
	}
}
