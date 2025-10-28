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
            vo.setIsFavorited(false);
            return vo;
        }).collect(Collectors.toList());
    }

    /**
     * 根据筛选条件匹配保险（不保存记录）
     */
    public List<InsuranceMatchVO> matchInsuranceByFilter(CompanyDetail filter) {
        List<InsuranceProduct> allProducts = insuranceProductMapper.selectList(null);
        List<InsuranceMatchVO> matchList = new ArrayList<>();

        for (InsuranceProduct product : allProducts) {
            MatchResult matchResult = calculateMatchScore(filter, product);
            if (matchResult.isMultiFieldMismatch()) {
                continue;
            }

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

        matchList.sort((a, b) -> Double.compare(b.getMatchScore(), a.getMatchScore()));
        return matchList;
    }

    /**
     * 匹配保险产品（核心方法）
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

        // 提取单选匹配字段
        String insuranceType = detail.getInsuranceType();
        String employeeCount = detail.getEmployeeCount();
        String industry = detail.getIndustry();
        String establishedYears = detail.getEstablishedYears();
        String annualRevenue = detail.getAnnualRevenue();
        String registeredCapital = detail.getRegisteredCapital();

        // 2. 获取所有保险产品
        List<InsuranceProduct> allProducts = insuranceProductMapper.selectList(null);

        // 3. 计算匹配度
        List<InsuranceMatchVO> matchList = new ArrayList<>();
        for (InsuranceProduct product : allProducts) {
            // 单选字段严格匹配
            boolean isSingleMatch = insuranceType.equals(product.getInsuranceType())
                    && employeeCount.equals(product.getTargetEmployees())
                    && industry.equals(product.getTargetIndustry())
                    && registeredCapital.equals(product.getTargetCapital())
                    && establishedYears.equals(product.getTargetYears())
                    && annualRevenue.equals(product.getTargetRevenue());

            if (!isSingleMatch) {
                continue;
            }

            // 多选字段校验
            MatchResult matchResult = calculateMatchScore(detail, product);
            if (matchResult.isMultiFieldMismatch()) {
                continue;
            }

            // 封装结果
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

        // 排序并返回
        matchList.sort((a, b) -> Double.compare(b.getMatchScore(), a.getMatchScore()));
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
     * 核心匹配算法
     */
    private MatchResult calculateMatchScore(CompanyDetail company, InsuranceProduct product) {
        double totalScore = 0;
        List<String> reasons = new ArrayList<>();
        boolean isMultiFieldMismatch = false;

        // 1. 已购保险与产品类型匹配（15%）
        double purchasedInsuranceScore = matchField(
                company.getPurchasedInsurance(),
                product.getInsuranceType(),
                "已购保险匹配"
        );
        if (purchasedInsuranceScore > 0) {
            totalScore += purchasedInsuranceScore * 0.15;
            reasons.add("已购保险与产品类型匹配");
        }

        // 2. 行业匹配（10%）
        double industryScore = matchField(company.getIndustry(), product.getTargetIndustry(), "行业匹配");
        if (industryScore > 0) {
            totalScore += industryScore * 0.1;
            reasons.add("行业匹配");
        }

        // 3. 成立年限匹配（5%）
        double yearsScore = matchField(company.getEstablishedYears(), product.getTargetYears(), "成立年限匹配");
        if (yearsScore > 0) {
            totalScore += yearsScore * 0.05;
            reasons.add("成立年限符合");
        }

        // 4. 员工规模匹配（10%）
        double employeeScore = matchField(company.getEmployeeCount(), product.getTargetEmployees(), "员工规模匹配");
        if (employeeScore > 0) {
            totalScore += employeeScore * 0.1;
            reasons.add("员工规模符合");
        }

        // 5. 营业额匹配（15%）
        double revenueScore = matchField(company.getAnnualRevenue(), product.getTargetRevenue(), "营业额匹配");
        if (revenueScore > 0) {
            totalScore += revenueScore * 0.15;
            reasons.add("营业额范围适合");
        }

        // 6. 注册资本匹配（5%）
        double capitalScore = matchField(company.getRegisteredCapital(), product.getTargetCapital(), "注册资本匹配");
        if (capitalScore > 0) {
            totalScore += capitalScore * 0.05;
        }

        // 7. 主要资产匹配（10%）
        double assetScore = matchMultiField(company.getMainAssets(), product.getTargetAssets());
        if (assetScore > 0) {
            totalScore += assetScore * 0.1;
            reasons.add("资产类型匹配");
        } else if (assetScore == -1) {
            isMultiFieldMismatch = true;
        }

        // 8. 特殊设备匹配（5%）
        double equipmentScore = matchMultiField(company.getSpecialEquipment(), product.getTargetEquipment());
        if (equipmentScore > 0) {
            totalScore += equipmentScore * 0.05;
        } else if (equipmentScore == -1) {
            isMultiFieldMismatch = true;
        }

        // 9. 进出口贸易匹配（5%）
        if (StrUtil.isNotBlank(product.getTargetImportExport()) &&
                product.getTargetImportExport().equals(company.getHasImportExport())) {
            if ("不限进出口贸易".equals(company.getHasImportExport())) {
                totalScore += 0.01;
            } else if ("是".equals(company.getHasImportExport())) {
                totalScore += 0.05;
                reasons.add("支持进出口贸易");
            } else {
                totalScore += 0.05;
                reasons.add("不支持进出口贸易");
            }
        }

        // 10. 风险覆盖匹配（10%）
        double riskScore = matchMultiField(company.getRiskCoverage(), product.getCoveredRisks());
        if (riskScore > 0) {
            totalScore += riskScore * 0.1;
            reasons.add("风险覆盖全面");
        } else if (riskScore == -1) {
            isMultiFieldMismatch = true;
        }

        // 11. 潜在风险匹配（5%）
        double potentialRiskScore = matchMultiField(company.getPotentialRisk(), product.getCoveredPotentialRisks());
        if (potentialRiskScore > 0) {
            totalScore += potentialRiskScore * 0.05;
        } else if (potentialRiskScore == -1) {
            isMultiFieldMismatch = true;
        }

        // 12. 已购保险与覆盖类型匹配（5%）
        double coveredInsuranceScore = matchMultiField(company.getPurchasedInsurance(), product.getCoveredInsuranceTypes());
        if (coveredInsuranceScore > 0) {
            totalScore += coveredInsuranceScore * 0.05;
            reasons.add("已购保险与覆盖类型匹配");
        } else if (coveredInsuranceScore == -1) {
            isMultiFieldMismatch = true;
        }

        // 结果处理
        double finalScore = Math.min(totalScore * 100, 100);
        String reasonText = reasons.isEmpty() ? "基本符合需求" : String.join("；", reasons);
        return new MatchResult(finalScore, reasonText, isMultiFieldMismatch);
    }

    /**
     * 单字段匹配（单选逻辑）
     */
    private double matchField(String companyValue, String productTargets, String fieldName) {
        if (StrUtil.isBlank(companyValue) || StrUtil.isBlank(productTargets)) {
            return 0;
        }

        List<String> targets = Arrays.asList(productTargets.split(","));
        // 处理"不限"特殊值
        if ("不限年限".equals(companyValue.trim())
                || "不限人数".equals(companyValue.trim())
                || "不限金额".equals(companyValue.trim())
                || "不限行业".equals(companyValue.trim())) {
            return targets.size();
        }

        return targets.contains(companyValue.trim()) ? 1.0 : 0.0;
    }

    /**
     * 多字段匹配（多选逻辑）
     */
    private double matchMultiField(String companyValues, String productTargets) {
        if (StrUtil.isBlank(companyValues) || StrUtil.isBlank(productTargets)) {
            return 0;
        }

        Set<String> companySet = Arrays.stream(companyValues.split(","))
                .map(String::trim)
                .collect(Collectors.toSet());
        Set<String> productSet = Arrays.stream(productTargets.split(","))
                .map(String::trim)
                .collect(Collectors.toSet());

        for (String companyValue : companySet) {
            // 处理"不限"特殊值
            if ("不限资产".equals(companyValue)
                    || "不限场景".equals(companyValue)
                    || "不限此项".equals(companyValue.trim())) {
                return productSet.size();
            }

            // 存在不匹配项返回-1
            if (!productSet.contains(companyValue)) {
                return -1.0;
            }
        }

        return companySet.size();
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
        private final boolean isMultiFieldMismatch;

        public MatchResult(Double score, String reason, boolean isMultiFieldMismatch) {
            this.score = score;
            this.reason = reason;
            this.isMultiFieldMismatch = isMultiFieldMismatch;
        }

        public Double getScore() {
            return score;
        }

        public String getReason() {
            return reason;
        }

        public boolean isMultiFieldMismatch() {
            return isMultiFieldMismatch;
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
        return StrUtil.isBlank(str) ? new ArrayList<>() : Arrays.asList(str.split(","));
    }

    /**
     * 添加收藏
     */
    @Transactional(rollbackFor = Exception.class)
    public void addFavorite(Long userId, Long insuranceId) {
        Long count = favoriteMapper.selectCount(
                new LambdaQueryWrapper<InsuranceFavorite>()
                        .eq(InsuranceFavorite::getUserId, userId)
                        .eq(InsuranceFavorite::getInsuranceId, insuranceId)
        );

        if (count > 0) {
            throw new RuntimeException("已收藏该保险产品");
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
