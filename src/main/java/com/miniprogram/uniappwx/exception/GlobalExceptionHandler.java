package com.miniprogram.uniappwx.exception;


import com.miniprogram.uniappwx.common.Result;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Set;
import java.util.stream.Collectors;

/**
 * 全局异常处理器
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

	/**
	 * 处理运行时异常
	 */
	@ExceptionHandler(RuntimeException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public Result<Void> handleRuntimeException(RuntimeException e) {
		log.error("运行时异常: ", e);
		return Result.error(e.getMessage());
	}

	/**
	 * 处理约束违反异常
	 */
	@ExceptionHandler(ConstraintViolationException.class)
	public Result<?> handleConstraintViolationException(ConstraintViolationException e) {
		Set<ConstraintViolation<?>> violations = e.getConstraintViolations();
		String message = violations.isEmpty() ? "参数校验失败" :
				violations.iterator().next().getMessage();
		log.error("约束违反异常: {}", message);
		return Result.error(400, message);
	}

	/**
	 * 处理业务异常
	 */
	@ExceptionHandler(BusinessException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result<Void> handleBusinessException(BusinessException e) {
		log.error("业务异常: {}", e.getMessage());
		return Result.error(e.getCode(), e.getMessage());
	}

	/**
	 * 处理参数校验异常
	 */
	@ExceptionHandler(MethodArgumentNotValidException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result<Void> handleValidationException(MethodArgumentNotValidException e) {
		String message = e.getBindingResult().getFieldErrors()
				.stream()
				.map(FieldError::getDefaultMessage)
				.collect(Collectors.joining(", "));
		log.error("参数校验异常: {}", message);
		return Result.error(400, message);
	}

	/**
	 * 处理绑定异常
	 */
	@ExceptionHandler(BindException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Result<Void> handleBindException(BindException e) {
		String message = e.getBindingResult().getFieldErrors()
				.stream()
				.map(FieldError::getDefaultMessage)
				.collect(Collectors.joining(", "));
		log.error("绑定异常: {}", message);
		return Result.error(400, message);
	}

	/**
	 * 处理用户不存在异常
	 */
	@ExceptionHandler(UsernameNotFoundException.class)
	@ResponseStatus(HttpStatus.UNAUTHORIZED)
	public Result<Void> handleUsernameNotFoundException(UsernameNotFoundException e) {
		log.error("用户不存在: {}", e.getMessage());
		return Result.error(401, "用户名或密码错误");
	}

	/**
	 * 处理认证失败异常
	 */
	@ExceptionHandler(BadCredentialsException.class)
	@ResponseStatus(HttpStatus.UNAUTHORIZED)
	public Result<Void> handleBadCredentialsException(BadCredentialsException e) {
		log.error("认证失败: {}", e.getMessage());
		return Result.error(401, "用户名或密码错误");
	}

	/**
	 * 处理权限不足异常
	 */
	@ExceptionHandler(AccessDeniedException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	public Result<Void> handleAccessDeniedException(AccessDeniedException e) {
		log.error("权限不足: {}", e.getMessage());
		return Result.error(403, "权限不足");
	}

	/**
	 * 处理所有未捕获的异常
	 */
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public Result<Void> handleException(Exception e) {
		log.error("系统异常: ", e);
		return Result.error("系统异常，请联系管理员");
	}
}