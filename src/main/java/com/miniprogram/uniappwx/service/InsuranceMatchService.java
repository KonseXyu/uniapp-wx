package com.miniprogram.uniappwx.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.*;
import com.miniprogram.uniappwx.mapper.*;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class InsuranceMatchService {

	@Resource
	private CompanyBasicMapper companyBasicMapper;

	@Resource
	private CompanyDetailMapper companyDetailMapper;

	@Resource
	private InsuranceProductMapper insuranceProductMapper;

	@Resource
	private MatchRecordMapper matchRecordMapper;

	/**
	 * 匹配保险产品
	 */
	public MatchResultVO matchInsurance(Long companyId) {
		// 1. 获取企业信息
		CompanyBasic basic = companyBasicMapper.selectById(companyId);
		if (basic == null) {
			throw new RuntimeException("企业信息不存在");
		}

		CompanyDetail detail = companyDetailMapper.selectOne(
				new LambdaQueryWrapper<CompanyDetail>()
						.eq(CompanyDetail::getCompanyId, companyId)
		);
		if (detail == null) {
			throw new RuntimeException("企业详细信息不存在");
		}

		// 2. 获取所有保险产品
		List<InsuranceProduct> allProducts = insuranceProductMapper.selectList(null);

		// 3. 计算每个产品的匹配度
		List<InsuranceMatchVO> matchList = new ArrayList<>();
		for (InsuranceProduct product : allProducts) {
			MatchResult matchResult = calculateMatchScore(detail, product);

			InsuranceMatchVO vo = new InsuranceMatchVO();
			vo.setId(product.getId());
			vo.setInsuranceName(product.getInsuranceName());
			vo.setCompanyName(product.getCompanyName());
			vo.setInsuranceType(product.getInsuranceType());
			vo.setAnnualFee(product.getAnnualFee());
			vo.setContactName(product.getInsuranceContactName());
			vo.setContactPhone(product.getInsuranceContactPhone());
			vo.setMatchScore(matchResult.getScore());
			vo.setMatchReason(matchResult.getReason());

			matchList.add(vo);

			// 保存匹配记录
			saveMatchRecord(companyId, product.getId(), matchResult);
		}

		// 4. 按匹配度排序
		matchList.sort((a, b) -> Double.compare(b.getMatchScore(), a.getMatchScore()));

		// 5. 构造返回结果
		MatchResultVO result = new MatchResultVO();

		CompanyInfoVO companyInfo = new CompanyInfoVO();
		companyInfo.setCompanyName(basic.getCompanyName());
		companyInfo.setIndustry(detail.getIndustry());
		companyInfo.setEmployeeCount(detail.getEmployeeCount());
		result.setCompanyInfo(companyInfo);

		result.setMatchResults(matchList);

		return result;
	}

	/**
	 * 核心匹配算法：计算匹配分数
	 */
	private MatchResult calculateMatchScore(CompanyDetail company, InsuranceProduct product) {
		double totalScore = 0;
		List<String> reasons = new ArrayList<>();

		// 1. 行业匹配 (权重20%)
		double industryScore = matchField(
				company.getIndustry(),
				product.getTargetIndustry(),
				"行业匹配"
		);
		if (industryScore > 0) {
			totalScore += industryScore * 0.2;
			reasons.add("行业高度匹配");
		}

		// 2. 成立年限匹配 (权重10%)
		double yearsScore = matchField(
				company.getEstablishedYears(),
				product.getTargetYears(),
				"成立年限匹配"
		);
		if (yearsScore > 0) {
			totalScore += yearsScore * 0.1;
			reasons.add("成立年限符合要求");
		}

		// 3. 员工规模匹配 (权重10%)
		double employeeScore = matchField(
				company.getEmployeeCount(),
				product.getTargetEmployees(),
				"员工规模匹配"
		);
		if (employeeScore > 0) {
			totalScore += employeeScore * 0.1;
			reasons.add("员工规模符合");
		}

		// 4. 营业额匹配 (权重15%)
		double revenueScore = matchField(
				company.getAnnualRevenue(),
				product.getTargetRevenue(),
				"营业额匹配"
		);
		if (revenueScore > 0) {
			totalScore += revenueScore * 0.15;
			reasons.add("营业额范围适合");
		}

		// 5. 注册资本匹配 (权重10%)
		double capitalScore = matchField(
				company.getRegisteredCapital(),
				product.getTargetCapital(),
				"注册资本匹配"
		);
		if (capitalScore > 0) {
			totalScore += capitalScore * 0.1;
		}

		// 6. 主要资产匹配 (权重10%)
		double assetScore = matchMultiField(
				company.getMainAssets(),
				product.getTargetAssets()
		);
		if (assetScore > 0) {
			totalScore += assetScore * 0.1;
			reasons.add("资产类型匹配");
		}

		// 7. 特殊设备匹配 (权重5%)
		double equipmentScore = matchMultiField(
				company.getSpecialEquipment(),
				product.getTargetEquipment()
		);
		if (equipmentScore > 0) {
			totalScore += equipmentScore * 0.05;
		}

		// 8. 进出口贸易匹配 (权重5%)
		if (StrUtil.isNotBlank(product.getTargetImportExport()) &&
				product.getTargetImportExport().equals(company.getHasImportExport())) {
			totalScore += 0.05;
			if ("是".equals(company.getHasImportExport())) {
				reasons.add("支持进出口贸易企业");
			}
		}

		// 9. 风险覆盖匹配 (权重10%)
		double riskScore = matchMultiField(
				company.getRiskCoverage(),
				product.getCoveredRisks()
		);
		if (riskScore > 0) {
			totalScore += riskScore * 0.1;
			reasons.add("风险覆盖全面");
		}

		// 10. 潜在风险匹配 (权重5%)
		double potentialRiskScore = matchMultiField(
				company.getPotentialRisk(),
				product.getCoveredPotentialRisks()
		);
		if (potentialRiskScore > 0) {
			totalScore += potentialRiskScore * 0.05;
		}

		// 转换为百分制
		double finalScore = Math.min(totalScore * 100, 100);

		String reasonText = reasons.isEmpty() ?
				"基本符合企业保险需求" :
				String.join("；", reasons);

		return new MatchResult(finalScore, reasonText);
	}

	/**
	 * 单字段匹配
	 */
	private double matchField(String companyValue, String productTargets, String fieldName) {
		if (StrUtil.isBlank(companyValue) || StrUtil.isBlank(productTargets)) {
			return 0;
		}

		// 将产品目标拆分为列表
		List<String> targets = Arrays.asList(productTargets.split(","));

		// 检查企业值是否在目标列表中
		return targets.contains(companyValue.trim()) ? 1.0 : 0;
	}

	/**
	 * 多选字段匹配（计算交集占比）
	 */
	private double matchMultiField(String companyValues, String productTargets) {
		if (StrUtil.isBlank(companyValues) || StrUtil.isBlank(productTargets)) {
			return 0;
		}

		Set<String> companySet = new HashSet<>(Arrays.asList(companyValues.split(",")));
		Set<String> productSet = new HashSet<>(Arrays.asList(productTargets.split(",")));

		// 清理空格
		companySet = companySet.stream().map(String::trim).collect(Collectors.toSet());
		productSet = productSet.stream().map(String::trim).collect(Collectors.toSet());

		// 计算交集
		Set<String> intersection = new HashSet<>(companySet);
		intersection.retainAll(productSet);

		// 返回交集占企业需求的比例
		if (companySet.isEmpty()) {
			return 0;
		}

		return (double) intersection.size() / companySet.size();
	}

	/**
	 * 保存匹配记录
	 */
	private void saveMatchRecord(Long companyId, Long insuranceId, MatchResult result) {
		MatchRecord record = new MatchRecord();
		record.setCompanyId(companyId);
		record.setInsuranceId(insuranceId);
		record.setMatchScore(result.getScore());
		record.setMatchReason(result.getReason());
		matchRecordMapper.insert(record);
	}

	/**
	 * 匹配结果内部类
	 */
	private static class MatchResult {
		private final Double score;
		private final String reason;

		public MatchResult(Double score, String reason) {
			this.score = score;
			this.reason = reason;
		}

		public Double getScore() {
			return score;
		}

		public String getReason() {
			return reason;
		}
	}

	/**
	 * 获取保险产品详情
	 */
	public InsuranceDetailVO getInsuranceDetail(Long insuranceId) {
		InsuranceProduct product = insuranceProductMapper.selectById(insuranceId);
		if (product == null) {
			throw new RuntimeException("保险产品不存在");
		}

		InsuranceDetailVO vo = new InsuranceDetailVO();
		vo.setId(product.getId());
		vo.setInsuranceName(product.getInsuranceName());
		vo.setCompanyName(product.getCompanyName());
		vo.setInsuranceType(product.getInsuranceType());
		vo.setAnnualFee(product.getAnnualFee());
		vo.setInsuranceContactName(product.getInsuranceContactName());
		vo.setInsuranceContactPhone(product.getInsuranceContactPhone());
		vo.setCompanyContactName(product.getCompanyContactName());
		vo.setCompanyContactPhone(product.getCompanyContactPhone());
		vo.setCompanyAddress(product.getCompanyAddress());
		vo.setOtherNotes(product.getOtherNotes());

		// 转换多选字段为列表
		vo.setTargetIndustryList(stringToList(product.getTargetIndustry()));
		vo.setTargetYearsList(stringToList(product.getTargetYears()));
		vo.setTargetEmployeesList(stringToList(product.getTargetEmployees()));
		vo.setCoveredRisksList(stringToList(product.getCoveredRisks()));
		vo.setCoveredPotentialRisksList(stringToList(product.getCoveredPotentialRisks()));
		vo.setRiskTransferTypesList(stringToList(product.getRiskTransferTypes()));

		return vo;
	}

	/**
	 * 字符串转列表
	 */
	private List<String> stringToList(String str) {
		if (StrUtil.isBlank(str)) {
			return new ArrayList<>();
		}
		return Arrays.asList(str.split(","));
	}
}
