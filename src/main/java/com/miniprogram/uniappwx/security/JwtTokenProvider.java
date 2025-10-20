package com.miniprogram.uniappwx.security;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.stream.Collectors;

@Component
public class JwtTokenProvider {

	@Value("${jwt.secret}")
	private String jwtSecret;

	@Value("${jwt.expiration}")
	private long jwtExpiration;

	/**
	 * 生成JWT Token
	 */
	public String generateToken(Authentication authentication) {
		CustomUserDetails userPrincipal = (CustomUserDetails) authentication.getPrincipal();

		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + jwtExpiration);

		SecretKey key = Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));

		return Jwts.builder()
				.subject(userPrincipal.getUsername())
				.claim("userId", userPrincipal.getId())
				.claim("role", userPrincipal.getAuthorities().stream()
						.map(GrantedAuthority::getAuthority)
						.collect(Collectors.toList()))
				.issuedAt(now)
				.expiration(expiryDate)
				.signWith(key)
				.compact();
	}

	/**
	 * 从Token中获取用户名
	 */
	public String getUsernameFromToken(String token) {
		SecretKey key = Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));

		Claims claims = Jwts.parser()
				.verifyWith(key)
				.build()
				.parseSignedClaims(token)
				.getPayload();

		return claims.getSubject();
	}

	/**
	 * 验证Token
	 */
	public boolean validateToken(String authToken) {
		try {
			SecretKey key = Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));
			Jwts.parser()
					.verifyWith(key)
					.build()
					.parseSignedClaims(authToken);
			return true;
		} catch (Exception ex) {
			// Token验证失败
			return false;
		}
	}
}
