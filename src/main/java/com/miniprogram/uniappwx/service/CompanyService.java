package com.miniprogram.uniappwx.service;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.*;
import com.miniprogram.uniappwx.mapper.*;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;

@Slf4j
@Service
public class CompanyService {

	@Resource
	private CompanyBasicMapper companyBasicMapper;

	@Resource
	private CompanyDetailMapper companyDetailMapper;

	@Resource
	private UserMapper userMapper;

	/**
	 * 保存企业基本信息（Step1）
	 */
	@Transactional(rollbackFor = Exception.class)
	public CompanyBasicVO saveBasicInfo(Long userId, CompanyBasicDTO dto) {
		// 更新用户手机号
		User user = userMapper.selectById(userId);
		if (user != null && StrUtil.isBlank(user.getPhone())) {
			user.setPhone(dto.getPrimaryPhone());
			userMapper.updateById(user);
		}

		// 查询是否已有企业信息
		CompanyBasic existing = companyBasicMapper.selectOne(
				new LambdaQueryWrapper<CompanyBasic>()
						.eq(CompanyBasic::getUserId, userId)
		);

		CompanyBasic company;
		if (existing != null) {
			// 更新
			company = existing;
			company.setCompanyName(dto.getCompanyName());
			company.setPrimaryPhone(dto.getPrimaryPhone());
			company.setPrimaryName(dto.getPrimaryName());
			company.setBackupPhone(dto.getBackupPhone());
			company.setBackupName(dto.getBackupName());
			companyBasicMapper.updateById(company);
		} else {
			// 新增
			company = new CompanyBasic();
			company.setUserId(userId);
			company.setCompanyName(dto.getCompanyName());
			company.setPrimaryPhone(dto.getPrimaryPhone());
			company.setBackupPhone(dto.getBackupPhone());
			company.setPrimaryName(dto.getPrimaryName());
			company.setBackupName(dto.getBackupName());
			companyBasicMapper.insert(company);
		}

		CompanyBasicVO vo = new CompanyBasicVO();
		vo.setCompanyId(company.getId());
		vo.setCompanyName(company.getCompanyName());
		vo.setPrimaryName(company.getPrimaryName());
		vo.setPrimaryPhone(company.getPrimaryPhone());
		vo.setBackupName(company.getBackupName());
		vo.setBackupPhone(company.getBackupPhone());

		return vo;
	}

	/**
	 * 保存企业详细信息（Step2）
	 */
	@Transactional(rollbackFor = Exception.class)
	public void saveDetailInfo(CompanyDetailDTO dto) {
		// 验证企业是否存在
		CompanyBasic basic = companyBasicMapper.selectById(dto.getCompanyId());
		if (basic == null) {
			throw new RuntimeException("企业信息不存在");
		}

		// 查询是否已有详细信息
		CompanyDetail existing = companyDetailMapper.selectOne(
				new LambdaQueryWrapper<CompanyDetail>()
						.eq(CompanyDetail::getCompanyId, dto.getCompanyId())
		);

		CompanyDetail detail;
		if (existing != null) {
			detail = existing;
		} else {
			detail = new CompanyDetail();
			detail.setCompanyId(dto.getCompanyId());
		}

		// 设置详细信息
		detail.setIndustry(dto.getIndustry());
		detail.setMainAssets(listToString(dto.getMainAssets()));
		detail.setEstablishedYears(dto.getEstablishedYears());
		detail.setEmployeeCount(dto.getEmployeeCount());
		detail.setAnnualRevenue(dto.getAnnualRevenue());
		detail.setRegisteredCapital(dto.getRegisteredCapital());
		detail.setSpecialEquipment(listToString(dto.getSpecialEquipment()));
		detail.setHasImportExport(dto.getHasImportExport());
		detail.setPurchasedInsurance(listToString(dto.getPurchasedInsurance()));
		detail.setRiskCoverage(listToString(dto.getRiskCoverage()));
		detail.setPotentialRisk(listToString(dto.getPotentialRisk()));
		detail.setRiskTransfer(listToString(dto.getRiskTransfer()));
		detail.setAnnualBudget(dto.getAnnualBudget());

		if (existing != null) {
			companyDetailMapper.updateById(detail);
		} else {
			companyDetailMapper.insert(detail);
		}
	}

	/**
	 * List转逗号分隔字符串
	 */
	private String listToString(List<String> list) {
		if (CollUtil.isEmpty(list)) {
			return "";
		}
		return String.join(",", list);
	}

	/**
	 * 获取当前用户的企业信息
	 */
	public CompanyInfoVO getMyCompanyInfo(Long userId) {
		CompanyBasic basic = companyBasicMapper.selectOne(
				new LambdaQueryWrapper<CompanyBasic>()
						.eq(CompanyBasic::getUserId, userId)
		);

		if (basic == null) {
			return null;
		}

		CompanyDetail detail = companyDetailMapper.selectOne(
				new LambdaQueryWrapper<CompanyDetail>()
						.eq(CompanyDetail::getCompanyId, basic.getId())
		);

		CompanyInfoVO vo = new CompanyInfoVO();
		vo.setCompanyId(basic.getId());
		vo.setCompanyName(basic.getCompanyName());
		vo.setPrimaryPhone(basic.getPrimaryPhone());
		vo.setPrimaryName(basic.getPrimaryName());
		if(basic.getBackupPhone() != null) {
			vo.setBackupPhone(basic.getBackupPhone());
		}
		if (basic.getBackupName() != null) {
			vo.setBackupName(basic.getBackupName());
		}


		if (detail != null) {
			vo.setIndustry(detail.getIndustry());
			vo.setEmployeeCount(detail.getEmployeeCount());
		}

		return vo;
	}

	/**
	 * 获取当前用户的企业详细信息
	 */
	public CompanyDetailVO getMyCompanyDetail(Long userId) {
		CompanyBasic basic = companyBasicMapper.selectOne(
				new LambdaQueryWrapper<CompanyBasic>()
						.eq(CompanyBasic::getUserId, userId)
		);

		if (basic == null) {
			throw new RuntimeException("企业信息不存在");
		}

		CompanyDetail detail = companyDetailMapper.selectOne(
				new LambdaQueryWrapper<CompanyDetail>()
						.eq(CompanyDetail::getCompanyId, basic.getId())
		);

		if (detail == null) {
			throw new RuntimeException("企业详细信息不存在");
		}

		CompanyDetailVO vo = new CompanyDetailVO();
		BeanUtils.copyProperties(detail, vo);
		vo.setCompanyId(basic.getId());

		return vo;
	}
}