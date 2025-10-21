package com.miniprogram.uniappwx.controller;
import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.dto.CompanyBasicDTO;
import com.miniprogram.uniappwx.dto.CompanyDetailDTO;
import com.miniprogram.uniappwx.service.CompanyService;
import com.miniprogram.uniappwx.vo.CompanyBasicVO;
import com.miniprogram.uniappwx.vo.CompanyDetailVO;
import com.miniprogram.uniappwx.vo.CompanyInfoVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * 企业信息控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/company")
public class CompanyController {

	@Resource
	private CompanyService companyService;

	/**
	 * 保存企业基本信息（Step1）
	 */
	@PostMapping("/basic")
	public Result<CompanyBasicVO> saveBasic(
			@RequestAttribute("userId") Long userId,
			@Validated @RequestBody CompanyBasicDTO dto) {
		try {
			CompanyBasicVO vo = companyService.saveBasicInfo(userId, dto);
			return Result.success("保存成功", vo);
		} catch (Exception e) {
			log.error("保存企业基本信息失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 保存企业详细信息（Step2）
	 */
	@PostMapping("/detail")
	public Result<String> saveDetail(@Validated @RequestBody CompanyDetailDTO dto) {
		try {
			companyService.saveDetailInfo(dto);
			return Result.success("保存成功");
		} catch (Exception e) {
			log.error("保存企业详细信息失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 获取当前用户的企业信息
	 */
	@GetMapping("/my-info")
	public Result<CompanyInfoVO> getMyCompanyInfo(@RequestAttribute("userId") Long userId) {
		try {
			CompanyInfoVO vo = companyService.getMyCompanyInfo(userId);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("获取企业信息失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 获取当前用户的企业详细信息
	 */
	@GetMapping("/my-detail")
	public Result<CompanyDetailVO> getMyCompanyDetail(@RequestAttribute("userId") Long userId) {
		try {
			CompanyDetailVO vo = companyService.getMyCompanyDetail(userId);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("获取企业详细信息失败", e);
			return Result.error(e.getMessage());
		}
	}
}
