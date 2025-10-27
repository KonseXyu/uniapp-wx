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
import org.springframework.transaction.annotation.Transactional;


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

	@Resource
	private InsuranceFavoriteMapper favoriteMapper;
	/**
	 * 浏览所有保险产品
	 */
	public List<InsuranceListVO> listAllInsurance() {
		List<InsuranceProduct> products = insuranceProductMapper.selectList(null);

		return products.stream().map(product -> {
			InsuranceListVO vo = new InsuranceListVO();
			vo.setId(product.getId());
			vo.setInsuranceName(product.getInsuranceName());
			vo.setCompanyName(product.getCompanyName());
			vo.setInsuranceType(product.getInsuranceType());
			vo.setAnnualFee(product.getAnnualFee());
			vo.setContactName(product.getInsuranceContactName());
			vo.setContactPhone(product.getInsuranceContactPhone());
			vo.setIsFavorited(false); // 默认未收藏，前端可单独查询
			return vo;
		}).collect(Collectors.toList());
	}

	/**
	 * 根据筛选条件匹配保险（不保存记录）
	 */
	public List<InsuranceMatchVO> matchInsuranceByFilter(CompanyDetail filter) {
		// 获取所有保险产品
		List<InsuranceProduct> allProducts = insuranceProductMapper.selectList(null);

		// 计算每个产品的匹配度
		List<InsuranceMatchVO> matchList = new ArrayList<>();
		for (InsuranceProduct product : allProducts) {
			MatchResult matchResult = calculateMatchScore(filter, product);

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
		}

		// 按匹配度排序
		matchList.sort((a, b) -> Double.compare(b.getMatchScore(), a.getMatchScore()));

		return matchList;
	}

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
        String InsuranceType=detail.getInsuranceType();//保险类型
        String EmployeeCount=detail.getEmployeeCount();//员工规模
        String Industry=detail.getIndustry();//所属行业
        String EstablishedYears=detail.getEstablishedYears();//成立年限
        String AnnualRevenue=detail.getAnnualRevenue();//营业额
        String RegisteredCapital=detail.getRegisteredCapital();//注册资本
		// 2. 获取所有保险产品
		List<InsuranceProduct> allProducts = insuranceProductMapper.selectList(null);


		// 3. 计算每个产品的匹配度
		List<InsuranceMatchVO> matchList = new ArrayList<>();
		for (InsuranceProduct product : allProducts) {
            if (InsuranceType.equals(product.getInsuranceType())){
                if (EmployeeCount.equals(product.getTargetEmployees())){
                    if (Industry.equals(product.getTargetIndustry())){
                        if (RegisteredCapital.equals(product.getTargetCapital())){
                            if (EstablishedYears.equals(product.getTargetYears())){
                                if (AnnualRevenue.equals(product.getTargetRevenue())){
                                    MatchResult matchResult = calculateMatchScore(detail, product);
                                    System.out.println(matchResult.getScore());
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
                            }
                        }
                    }
                }
            }

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
        //保险类别匹配(权重15%)
        double insuranceType=matchField(company.getPurchasedInsurance(),product.getInsuranceType(),"保险匹配");
        if (insuranceType > 0) {
            totalScore += insuranceType * 0.15;
            reasons.add("保险高度匹配");
        }
		// 1. 行业匹配 (权重10%)
		double industryScore = matchField(
				company.getIndustry(),
				product.getTargetIndustry(),
				"行业匹配"
		);
		if (industryScore > 0) {
			totalScore += industryScore * 0.1;
			reasons.add("行业高度匹配");
		}

		// 2. 成立年限匹配 (权重5%)
		double yearsScore = matchField(
				company.getEstablishedYears(),
				product.getTargetYears(),
				"成立年限匹配"
		);
		if (yearsScore > 0) {
			totalScore += yearsScore * 0.05;
			reasons.add("成立年限符合要求");
		}

		// 3. 员工规模匹配 (权重10%)
		double employeeScore = matchField(
				company.getEmployeeCount(),
				product.getTargetEmployees(),
				"员工规模匹配"
		);
		if (employeeScore > 0) {
			totalScore += employeeScore * 0.10;
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

		// 5. 注册资本匹配 (权重5%)
		double capitalScore = matchField(
				company.getRegisteredCapital(),
				product.getTargetCapital(),
				"注册资本匹配"
		);
		if (capitalScore > 0) {
			totalScore += capitalScore * 0.05;
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
            if("不限进出口贸易".equals(company.getHasImportExport())){
                totalScore += 0.01;
            } else if ("是".equals(company.getHasImportExport())) {
                totalScore += 0.05;
				reasons.add("支持进出口贸易企业");
			} else{
                totalScore += 0.05;
                reasons.add("不支持进出口贸易企业");
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
        //目标购买过的保险匹配(权重5%)
        double purchaseInsurance=matchMultiField(
                company.getPurchasedInsurance(),
                product.getCoveredInsuranceTypes()
        );
        if (purchaseInsurance > 0) {
            totalScore += purchaseInsurance * 0.05;
            reasons.add("保险高度匹配");
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
        if ("不限年限".equals(companyValue.trim())){
            return  (double)targets.size();
        }
        if ("不限人数".equals(companyValue.trim())){
            return  (double)targets.size();
        }

        if ("不限金额".equals(companyValue.trim())){
            return  (double)targets.size();
        }
        if ("不限行业".equals(companyValue.trim())){
            return  (double) targets.size();
        }

        if (targets.contains(companyValue.trim())){
            return 1.0;
        }
        return 0.0;
    }

	/**
	 * 多选字段匹配（计算交集占比）
	 */
	private double matchMultiField(String companyValues, String productTargets) {
		if (StrUtil.isBlank(companyValues) || StrUtil.isBlank(productTargets)) {
			return 0;
		}
        double score = 0.0;
		Set<String> companySet = new HashSet<>(Arrays.asList(companyValues.split(",")));
		Set<String> productSet = new HashSet<>(Arrays.asList(productTargets.split(",")));

		// 清理空格
		companySet = companySet.stream().map(String::trim).collect(Collectors.toSet());
		productSet = productSet.stream().map(String::trim).collect(Collectors.toSet());


        for (String companyValue : companySet) {
            if ("不限资产".equals(companyValue)) {
                score=0.0;
                score=productSet.size();
                break;
            }
            if ("不限场景".equals(companyValue)) {
                score=0.0;
                score=productSet.size();
                break;
            }
            if ("不限此项".equals(companyValue.trim())){
               score=0.0;
               score=productSet.size();
               break;
            }


            if(productSet.contains(companyValue)){
                score+=1;
            }

        }

		return (double) score;
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

	/**
	 * 添加收藏
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addFavorite(Long userId, Long insuranceId) {
		// 检查是否已收藏
		Long count = favoriteMapper.selectCount(
				new LambdaQueryWrapper<InsuranceFavorite>()
						.eq(InsuranceFavorite::getUserId, userId)
						.eq(InsuranceFavorite::getInsuranceId, insuranceId)
		);

		if (count > 0) {
			throw new RuntimeException("已经收藏过该保险产品");
		}

		InsuranceFavorite favorite = new InsuranceFavorite();
		favorite.setUserId(userId);
		favorite.setInsuranceId(insuranceId);
		favoriteMapper.insert(favorite);
	}

	/**
	 * 取消收藏
	 */
	@Transactional(rollbackFor = Exception.class)
	public void removeFavorite(Long userId, Long insuranceId) {
		favoriteMapper.delete(
				new LambdaQueryWrapper<InsuranceFavorite>()
						.eq(InsuranceFavorite::getUserId, userId)
						.eq(InsuranceFavorite::getInsuranceId, insuranceId)
		);
	}

	/**
	 * 获取我的收藏列表
	 */
	public List<InsuranceListVO> getMyFavorites(Long userId) {
		// 查询收藏的保险ID列表
		List<InsuranceFavorite> favorites = favoriteMapper.selectList(
				new LambdaQueryWrapper<InsuranceFavorite>()
						.eq(InsuranceFavorite::getUserId, userId)
						.orderByDesc(InsuranceFavorite::getCreateTime)
		);

		if (favorites.isEmpty()) {
			return new ArrayList<>();
		}

		List<Long> insuranceIds = favorites.stream()
				.map(InsuranceFavorite::getInsuranceId)
				.collect(Collectors.toList());

		// 查询保险产品信息
		List<InsuranceProduct> products = insuranceProductMapper.selectBatchIds(insuranceIds);

		return products.stream().map(product -> {
			InsuranceListVO vo = new InsuranceListVO();
			vo.setId(product.getId());
			vo.setInsuranceName(product.getInsuranceName());
			vo.setCompanyName(product.getCompanyName());
			vo.setInsuranceType(product.getInsuranceType());
			vo.setAnnualFee(product.getAnnualFee());
			vo.setContactName(product.getInsuranceContactName());
			vo.setContactPhone(product.getInsuranceContactPhone());
			vo.setIsFavorited(true);
			return vo;
		}).collect(Collectors.toList());
	}

	/**
	 * 检查是否已收藏
	 */
	public boolean checkFavorite(Long userId, Long insuranceId) {
		Long count = favoriteMapper.selectCount(
				new LambdaQueryWrapper<InsuranceFavorite>()
						.eq(InsuranceFavorite::getUserId, userId)
						.eq(InsuranceFavorite::getInsuranceId, insuranceId)
		);
		return count > 0;
	}
}
