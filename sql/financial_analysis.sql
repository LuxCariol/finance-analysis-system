/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.23 : Database - financial_analysis
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`financial_analysis` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `financial_analysis`;

/*Table structure for table `t_age_analysis` */

DROP TABLE IF EXISTS `t_age_analysis`;

CREATE TABLE `t_age_analysis` (
  `Id` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `project_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '核算项目代码（物料长代码）',
  `project_name` varchar(366) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '核算项目名称（1级物料类别）',
  `balance` decimal(16,2) DEFAULT '0.00' COMMENT '余额（金额）',
  `credit_period` decimal(16,2) DEFAULT '0.00' COMMENT '信用期限',
  `credit_line` decimal(16,2) DEFAULT '0.00' COMMENT '信用额度',
  `not_due1_to30_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期1至30天（未到期1至90天）',
  `not_due31_to90_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期31至90天（未到期91至180天）',
  `not_due91_to180_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期91至180天（未到期181至360天）',
  `not_due181_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期181天以上（未到期361至720天）',
  `due1_to30_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期1至30天（0-90天）',
  `due31_to90_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期31至90天',
  `due91_to180_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期91至180天（90-180天）',
  `due181_to360_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期181至360天（180-360天）',
  `due361_to720_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期361至720天（360-720天）',
  `due721_to1080_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期721至1080天（720-1080天）',
  `due1081_to1440_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期1081至1440天（1080天以上）',
  `due1441_days` decimal(16,2) DEFAULT '0.00' COMMENT '到期1441天以上',
  `due_today` decimal(16,2) DEFAULT '0.00' COMMENT '当日到期',
  `type` int DEFAULT '1' COMMENT '账龄分析类型 1:应付 2:应收,3.其他应付账龄分析，4.其他应收账龄分析，5应付账款账龄分析，6.应收账款账龄分析，7预付账款账龄分析，8预收账款账龄分析，9：产成品账龄分析，10：原材料账龄分析',
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `KJYEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJMOTH` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR_MOTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_port_type` bigint DEFAULT NULL,
  `FORMAT_FLAG` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'N',
  `IMP_USER` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `kcsljb` decimal(16,2) DEFAULT '0.00' COMMENT '库存数量(基本)',
  `kcslcy` decimal(16,2) DEFAULT '0.00' COMMENT '库存数量(常用)',
  `djjb` decimal(16,2) DEFAULT '0.00' COMMENT '单价(基本)',
  `djcy` decimal(16,2) DEFAULT '0.00' COMMENT '单价(常用)',
  `due0_to90_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '0天至90天数量(基本)',
  `due0_to90_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '0天至90天数量(常用)',
  `due91_to180_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '91天至180天数量(基本)',
  `due91_to180_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '91天至180天数量(常用)',
  `due181_to360_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '181天至360天数量(基本)',
  `due181_to360_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '181天至360天数量(常用)',
  `due361_to720_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '361天至720天数量(基本)',
  `due361_to720_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '361天至720天数量(常用)',
  `due721_to1080_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '721天至1080天数量(基本)',
  `due721_to1080_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '721天至1080天数量(常用)',
  `due1081_days_nm_jb` decimal(16,2) DEFAULT '0.00' COMMENT '1081天以上数量(基本)',
  `due1081_days_nm_cy` decimal(16,2) DEFAULT '0.00' COMMENT '1081天以上数量(常用)',
  `not_due721_to1080_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期721至1080天',
  `not_due1081_days` decimal(16,2) DEFAULT '0.00' COMMENT '未到期1081天以上',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='账龄分析';

/*Data for the table `t_age_analysis` */

/*Table structure for table `t_basi_assets_and_liabilities` */

DROP TABLE IF EXISTS `t_basi_assets_and_liabilities`;

CREATE TABLE `t_basi_assets_and_liabilities` (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `IS_SURE` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IMP_USER` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `BATCH_ID` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJMOTH` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR_MOTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `JEDW` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `NC_LDZC_HBZJ` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_DQTC` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YSPJ` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YSFL` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YSLX` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YSGL` decimal(16,2) DEFAULT '0.00' COMMENT '应收股利',
  `NC_LDZC_YSZK` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_QTYSK` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YFZK` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YSBTK` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_CH` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_DTFY` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_YNNDQCQZQTZ` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_QTLDZC` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_HJ` decimal(16,2) DEFAULT '0.00',
  `NC_CQTC_CQGQTZ` decimal(16,2) DEFAULT '0.00',
  `NC_CQTC_CQZQTC` decimal(16,2) DEFAULT '0.00',
  `NC_CQTZ_HJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_YJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_LJZJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_JZ` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_JZZB` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_JE` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_GCWZ` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_ZJGC` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_QL` decimal(16,2) DEFAULT '0.00',
  `NC_GDZC_HJ` decimal(16,2) DEFAULT '0.00',
  `NC_WXZC_JE` decimal(16,2) DEFAULT '0.00',
  `NC_WXZC_CQDTFY` decimal(16,2) DEFAULT '0.00',
  `NC_WXZC_QTCQZC` decimal(16,2) DEFAULT '0.00',
  `NC_WXZC_HJ` decimal(16,2) DEFAULT '0.00',
  `NC_DYSX_DYCKJX` decimal(16,2) DEFAULT '0.00',
  `NC_DYSX_ZCZJ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_DQJK` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YFPJ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YFZK` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YSZK` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YFGZ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YFFLF` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YFGL` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YJSJ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_QTYFK` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YTFY` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YJFZ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_YNNDQCQFZ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_QTLDFZ` decimal(16,2) DEFAULT '0.00',
  `NC_LDFZ_LDFZHJ` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_CQJK` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_YFZQ` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_CQYFK` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_ZXYFK` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_QTCQFZ` decimal(16,2) DEFAULT '0.00',
  `NC_FLDFZ_CQFZHJ` decimal(16,2) DEFAULT '0.00',
  `NC_DYSX_DYSKHX` decimal(16,2) DEFAULT '0.00',
  `NC_DYSX_FZHJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_SSZB` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_YGHTZ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_SSZBJE` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_ZBGJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_YYGJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_FDGYJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_WFPLR` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_SYZQYHJ` decimal(16,2) DEFAULT '0.00',
  `NC_GDQY_FZHSYZQY` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_HBZJ` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_DQTC` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YSPJ` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YSFL` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YSLX` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YSGL` decimal(16,2) DEFAULT '0.00' COMMENT '应收股利',
  `QM_LDZC_YSZK` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_QTYSK` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YFZK` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YSBTK` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_CH` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_DTFY` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_YNNDQCQZQTZ` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_QTLDZC` decimal(16,2) DEFAULT '0.00',
  `QM_LDZC_HJ` decimal(16,2) DEFAULT '0.00',
  `QM_CQTC_CQGQTZ` decimal(16,2) DEFAULT '0.00',
  `QM_CQTC_CQZQTC` decimal(16,2) DEFAULT '0.00',
  `QM_CQTZ_HJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_YJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_LJZJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_JZ` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_JZZB` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_JE` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_GCWZ` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_ZJGC` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_QL` decimal(16,2) DEFAULT '0.00',
  `QM_GDZC_HJ` decimal(16,2) DEFAULT '0.00',
  `QM_WXZC_JE` decimal(16,2) DEFAULT '0.00',
  `QM_WXZC_CQDTFY` decimal(16,2) DEFAULT '0.00',
  `QM_WXZC_QTCQZC` decimal(16,2) DEFAULT '0.00',
  `QM_WXZC_HJ` decimal(16,2) DEFAULT '0.00',
  `QM_DYSX_DYCKJX` decimal(16,2) DEFAULT '0.00',
  `QM_DYSX_ZCZJ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_DQJK` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YFPJ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YFZK` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YSZK` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YFGZ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YFFLF` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YFGL` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YJSJ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_QTYFK` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YTFY` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YJFZ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_YNNDQCQFZ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_QTLDFZ` decimal(16,2) DEFAULT '0.00',
  `QM_LDFZ_LDFZHJ` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_CQJK` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_YFZQ` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_CQYFK` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_ZXYFK` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_QTCQFZ` decimal(16,2) DEFAULT '0.00',
  `QM_FLDFZ_CQFZHJ` decimal(16,2) DEFAULT '0.00',
  `QM_DYSX_DYSKHX` decimal(16,2) DEFAULT '0.00',
  `QM_DYSX_FZHJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_SSZB` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_YGHTZ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_SSZBJE` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_ZBGJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_YYGJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_FDGYJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_WFPLR` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_SYZQYHJ` decimal(16,2) DEFAULT '0.00',
  `QM_GDQY_FZHSYZQY` decimal(16,2) DEFAULT '0.00',
  `NC_LDZC_JYXJRZC` decimal(16,2) DEFAULT '0.00' COMMENT '交易性金融资产',
  `QM_LDZC_JYXJRZC` decimal(16,2) DEFAULT '0.00' COMMENT '交易性金融资产',
  `NC_FLDZC_KGCSJRZC` decimal(16,2) DEFAULT '0.00' COMMENT '可供出售金融资产',
  `QM_FLDZC_KGCSJRZC` decimal(16,2) DEFAULT '0.00' COMMENT '可供出售金融资产',
  `NC_FLDZC_CYZDQTZ` decimal(16,2) DEFAULT '0.00' COMMENT '持有至到期投资',
  `QM_FLDZC_CYZDQTZ` decimal(16,2) DEFAULT '0.00' COMMENT '持有至到期投资',
  `NC_FLDZC_CQYSK` decimal(16,2) DEFAULT '0.00' COMMENT '长期应收款',
  `QM_FLDZC_CQYSK` decimal(16,2) DEFAULT '0.00' COMMENT '长期应收款',
  `NC_FLDZC_CQGQTZ` decimal(16,2) DEFAULT '0.00' COMMENT '长期股权投资',
  `QM_FLDZC_CQGQTZ` decimal(16,2) DEFAULT '0.00' COMMENT '长期股权投资',
  `QM_FLDZC_TZXFDC` decimal(16,2) DEFAULT '0.00' COMMENT '投资性房地产',
  `NC_FLDZC_TZXFDC` decimal(16,2) DEFAULT '0.00' COMMENT '投资性房地产',
  `NC_FLDZC_GDZC` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产',
  `QM_FLDZC_GDZC` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产',
  `NC_FLDZC_ZJGC` decimal(16,2) DEFAULT '0.00' COMMENT '在建工程',
  `QM_FLDZC_ZJGC` decimal(16,2) DEFAULT '0.00' COMMENT '在建工程',
  `NC_FLDZC_GCWZ` decimal(16,2) DEFAULT '0.00' COMMENT '工程物资',
  `QM_FLDZC_GCWZ` decimal(16,2) DEFAULT '0.00' COMMENT '工程物资',
  `NC_FLDZC_GDZCQL` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产清理',
  `QM_FLDZC_GDZCQL` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产清理',
  `NC_FLDZC_SCXSWZC` decimal(16,2) DEFAULT '0.00' COMMENT '生产性生物资产',
  `QM_FLDZC_SCXSWZC` decimal(16,2) DEFAULT '0.00' COMMENT '生产性生物资产',
  `NC_FLDZC_YQZC` decimal(16,2) DEFAULT '0.00' COMMENT '油气资产',
  `QM_FLDZC_YQZC` decimal(16,2) DEFAULT '0.00' COMMENT '油气资产',
  `NC_FLDZC_WXZC` decimal(16,2) DEFAULT '0.00' COMMENT '无形资产',
  `QM_FLDZC_WXZC` decimal(16,2) DEFAULT '0.00' COMMENT '无形资产',
  `NC_FLDZC_KFZC` decimal(16,2) DEFAULT '0.00' COMMENT '开发支出',
  `QM_FLDZC_KFZC` decimal(16,2) DEFAULT '0.00' COMMENT '开发支出',
  `NC_FLDZC_SY` decimal(16,2) DEFAULT '0.00' COMMENT '商誉',
  `QM_FLDZC_SY` decimal(16,2) DEFAULT '0.00' COMMENT '商誉',
  `NC_FLDZC_CQDTFY` decimal(16,2) DEFAULT '0.00' COMMENT '长期待摊费用',
  `QM_FLDZC_CQDTFY` decimal(16,2) DEFAULT '0.00' COMMENT '长期待摊费用',
  `NC_FLDZC_DYSDSZC` decimal(16,2) DEFAULT '0.00' COMMENT '递延所得税资产',
  `QM_FLDZC_DYSDSZC` decimal(16,2) DEFAULT '0.00' COMMENT '递延所得税资产',
  `NC_FLDZC_QTFLDZC` decimal(16,2) DEFAULT '0.00' COMMENT '其他非流动资产',
  `QM_FLDZC_QTFLDZC` decimal(16,2) DEFAULT '0.00' COMMENT '其他非流动资产',
  `NC_FLDZC_FLDZCHJ` decimal(16,2) unsigned DEFAULT '0.00' COMMENT '非流动资产合计',
  `QM_FLDZC_FLDZCHJ` decimal(16,2) unsigned DEFAULT '0.00' COMMENT '非流动资产合计',
  `NC_ZCZJ` decimal(16,2) unsigned DEFAULT '0.00' COMMENT '资产合计',
  `QM_ZCZJ` decimal(16,2) unsigned DEFAULT '0.00' COMMENT '资产合计',
  `NC_LDFZ_JYXJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '交易性金融负债',
  `QM_LDFZ_JYXJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '交易性金融负债',
  `NC_LDFZ_YFLX` decimal(16,2) DEFAULT '0.00' COMMENT '应付利息',
  `QM_LDFZ_YFLX` decimal(16,2) DEFAULT '0.00' COMMENT '应付利息',
  `NC_FLDFZ_YJFZ` decimal(16,2) DEFAULT '0.00' COMMENT '预计负债',
  `QM_FLDFZ_YJFZ` decimal(16,2) DEFAULT '0.00' COMMENT '预计负债',
  `NC_GDQY_KCG` decimal(16,2) DEFAULT '0.00' COMMENT '库存股',
  `QM_GDQY_KCG` decimal(16,2) DEFAULT '0.00' COMMENT '库存股',
  `account_port_type` bigint DEFAULT '0',
  `FORMAT_FLAG` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'N' COMMENT '转换标识（N/Y）',
  `QM_YBFXZB` decimal(16,2) DEFAULT '0.00' COMMENT '一般风险准备',
  `NC_YBFXZB` decimal(16,2) DEFAULT '0.00' COMMENT '一般风险准备',
  `QM_GSYMGSQYHJ` decimal(16,2) DEFAULT '0.00' COMMENT '归属于母公司所有者权益合计',
  `NC_GSYMGSQYHJ` decimal(16,2) DEFAULT '0.00' COMMENT '归属于母公司所有者权益合计',
  `QM_SSGDQY` decimal(16,2) DEFAULT '0.00' COMMENT '少数股东权益',
  `NC_SSGDQY` decimal(16,2) DEFAULT '0.00' COMMENT '少数股东权益',
  `QM_YSJRZC` decimal(15,2) DEFAULT '0.00' COMMENT '衍生金融资产',
  `QM_HFWZYDSZC` decimal(15,2) DEFAULT '0.00' COMMENT '持有待售的资产',
  `QM_YXG` decimal(16,2) DEFAULT '0.00' COMMENT '其中：优先股(流动)',
  `QM_CYDSFZ` decimal(16,2) DEFAULT '0.00' COMMENT '持有待售的负债',
  `QM_YXZ` decimal(16,2) DEFAULT '0.00' COMMENT '      永续债(流动)',
  `QM_DYSY` decimal(16,2) DEFAULT '0.00' COMMENT '递延收益',
  `QM_QTQYGJ` decimal(16,2) DEFAULT '0.00' COMMENT '其他权益工具',
  `QM_QZYXG` decimal(16,2) DEFAULT '0.00' COMMENT '其中：优先股(非）',
  `QM_ZCYXZ` decimal(16,2) DEFAULT '0.00' COMMENT '永续债（非)',
  `QM_ZBGJ` decimal(16,2) DEFAULT '0.00' COMMENT '减：库存股',
  `QM_QTZHSY` decimal(16,2) DEFAULT '0.00' COMMENT '其他综合收益',
  `QM_JYXJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '交易性金融负债',
  `QM_YSJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '衍生金融负债',
  `NC_YGYJZJLQQBD` decimal(16,2) DEFAULT '0.00' COMMENT '以公允价值计量且其变动计入当期损益的金融资产',
  `QM_YGYJZJLQQBD` decimal(16,2) DEFAULT '0.00' COMMENT '以公允价值计量且其变动计入当期损益的金融资产',
  `NC_YSJRZC` decimal(16,2) DEFAULT '0.00' COMMENT '衍生金融资产',
  `NC_CYDSDZC` decimal(16,2) DEFAULT '0.00' COMMENT '持有待售的资产',
  `QM_CYDSDZC` decimal(16,2) DEFAULT '0.00' COMMENT '持有待售的资产',
  `NC_YGYJZJLJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '以公允价值计量且其变动计入当期损益的金融负债',
  `QM_YGYJZJLJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '以公允价值计量且其变动计入当期损益的金融负债',
  `NC_YSJRFZ` decimal(16,2) DEFAULT '0.00' COMMENT '衍生金融负债',
  `NC_CYDSDFZ` decimal(16,2) DEFAULT '0.00' COMMENT '持有待售的负债',
  `QM_CYDSDFZ` decimal(16,2) DEFAULT '0.00' COMMENT '持有待售的负债',
  `NC_QZYXG` decimal(16,2) DEFAULT '0.00' COMMENT '其中：优先股',
  `NC_YXZ` decimal(16,2) DEFAULT '0.00' COMMENT '永续债',
  `NC_QTQYGJ` decimal(16,2) DEFAULT '0.00' COMMENT '其他权益工具',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_basi_assets_and_liabilities` */

/*Table structure for table `t_basi_cash_flow` */

DROP TABLE IF EXISTS `t_basi_cash_flow`;

CREATE TABLE `t_basi_cash_flow` (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IMP_USER` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `BATCH_ID` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJMOTH` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR_MOTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `JEDW` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `JYHD_SDDXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_SDDSFFH` decimal(16,2) DEFAULT '0.00',
  `JYHD_SDDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_GJZFDXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_ZFGZGDXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_ZFDGXSF` decimal(16,2) DEFAULT '0.00',
  `JYHD_ZFDQTDXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `JYHD_JYHDCSDJE` decimal(16,2) DEFAULT '0.00',
  `TZHD_SHTZSSDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_QDSYSSDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_SSHDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_SDDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_SZFDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_TZSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_ZFQTDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_TZHDSCSDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `CZHD_XSTZSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_JKSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_SDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_CHZWSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_FPGLSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_ZFQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_ZCHDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `CZHD_HLBDXJDYX` decimal(16,2) DEFAULT '0.00',
  `CZHD_XJJXJDWJJZE` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_JLR` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_JTZCJZZB` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_GDZCZJ` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_WXZCTX` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_CQDTFYTX` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_DTFYJS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_YTFYZJ` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_CQZCDSS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_GDZCBFSS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_CWFY` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_TZSS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_DYSDX` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_CHDJS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_JYXYSXMJS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_JYXYFXMZJ` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_OHTERS` decimal(16,2) DEFAULT '0.00',
  `JLRJYHD_JYHDCSXJLLJE` decimal(16,2) DEFAULT '0.00',
  `BSJXJ_ZWZWZB` decimal(16,2) DEFAULT '0.00',
  `BSJXJ_YNNDQZQ` decimal(16,2) DEFAULT '0.00',
  `BSJXJ_RZZRGDZC` decimal(16,2) DEFAULT '0.00',
  `XJJZJE_XJQMYE` decimal(16,2) DEFAULT '0.00',
  `XJJZJE_XJDQCYE` decimal(16,2) DEFAULT '0.00',
  `XJJZJE_XJDJWDQMYE` decimal(16,2) DEFAULT '0.00',
  `XJJZJE_XJDJWDQCYE` decimal(16,2) DEFAULT '0.00',
  `XJJZJE_XJDJWJZJE` decimal(16,2) DEFAULT '0.00',
  `account_port_type` bigint DEFAULT '0',
  `FORMAT_FLAG` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'N' COMMENT '数据转换标识（N/Y）',
  `BQ_JYHD_SDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_SDDSFFH` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_SDDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_GJZFDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_ZFGZGDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_ZFDGXSF` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_ZFDQTDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_JYHDCSDJE` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_SHTZSSDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_QDSYSSDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_SSHDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_SDDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_SZFDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_TZSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_ZFQTDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_TZHDSCSDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_XSTZSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_JKSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_SDQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_XJLRXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_CHZWSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_FPGLSZFDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_ZFQTYGDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_XJLCXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_ZCHDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_HLBDXJDYX` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_XJJXJDWJJZE` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_JLR` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_JTZCJZZB` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_GDZCZJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_WXZCTX` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_CQDTFYTX` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_DTFYJS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_YTFYZJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_CQZCDSS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_GDZCBFSS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_CWFY` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_TZSS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_DYSDX` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_CHDJS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_JYXYSXMJS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_JYXYFXMZJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_OHTERS` decimal(16,2) DEFAULT '0.00',
  `BQ_JLRJYHD_JYHDCSXJLLJE` decimal(16,2) DEFAULT '0.00',
  `BQ_BSJXJ_ZWZWZB` decimal(16,2) DEFAULT '0.00',
  `BQ_BSJXJ_YNNDQZQ` decimal(16,2) DEFAULT '0.00',
  `BQ_BSJXJ_RZZRGDZC` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJZJE_XJQMYE` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJZJE_XJDQCYE` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJZJE_XJDJWDQMYE` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJZJE_XJDJWDQCYE` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJZJE_XJDJWJZJE` decimal(16,2) DEFAULT '0.00',
  `JYHD_XSSPTGLWSDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_JYHD_XSSPTGLWSDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_CZWXHQTSHDXJJE` decimal(16,2) DEFAULT '0.00',
  `TZHD_CZWXHQTSHDXJJE` decimal(16,2) DEFAULT '0.00',
  `TZHD_CZZGSJQTZFDXJJE` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_CZZGSJQTZFDXJJE` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_GJGDWXHQTZFDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_GJGDWXHQTZFDXJ` decimal(16,2) DEFAULT '0.00',
  `TZHD_QDZGSJQTZFDXJJE` decimal(16,2) DEFAULT '0.00',
  `BQ_TZHD_QDZGSJQTZFDXJJE` decimal(16,2) DEFAULT '0.00',
  `CZHD_ZGSZFGLLR` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_ZGSZFGLLR` decimal(16,2) DEFAULT '0.00',
  `CZHD_CZHDCSDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_CZHDCSDXJLLJE` decimal(16,2) DEFAULT '0.00',
  `XJJXJDJWJZJE` decimal(16,2) DEFAULT '0.00',
  `BQ_XJJXJDJWJZJE` decimal(16,2) DEFAULT '0.00',
  `QCXJJXJDJWYE` decimal(16,2) DEFAULT '0.00',
  `BQ_QCXJJXJDJWYE` decimal(16,2) DEFAULT '0.00',
  `BQ_QMXJJXJDJWYE` decimal(16,2) DEFAULT '0.00',
  `QMXJJXJDJWYE` decimal(16,2) DEFAULT '0.00',
  `BQ_CZHD_ZGSXSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `CZHD_ZGSXSSDDXJ` decimal(16,2) DEFAULT '0.00',
  `BQ_ZGSXJJE` decimal(16,2) DEFAULT '0.00' COMMENT '处置子公司及其他营业单位收到的现金净额',
  `BQ_QDZGSXJJE` decimal(16,2) DEFAULT '0.00' COMMENT '取得子公司及其他营业单位支付的现金净额',
  `BQ_JLR` decimal(16,2) DEFAULT '0.00' COMMENT '净利润',
  `BQ_JTDZCJZ` decimal(16,2) DEFAULT '0.00' COMMENT '加：计提的资产减值准备',
  `BQ_GDZCZJ` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产折旧',
  `BQ_WXZCTX` decimal(16,2) DEFAULT '0.00' COMMENT '无形资产摊销',
  `BQ_CQDTFYTX` decimal(16,2) DEFAULT '0.00' COMMENT '长期待摊费用摊销',
  `BQ_DTFYJS` decimal(16,2) DEFAULT '0.00' COMMENT '待摊费用减少（减：增加）',
  `BQ_YTFYZJ` decimal(16,2) DEFAULT '0.00' COMMENT '预提费用增加（减：减少）',
  `BQ_CZGDZCWXZC` decimal(16,2) DEFAULT '0.00' COMMENT '处置固定资产、无形资产和其他长期资产的损失（减：收益）',
  `BQ_GDZCBFSS` decimal(16,2) DEFAULT '0.00' COMMENT '固定资产报废损失',
  `BQ_CWFY` decimal(16,2) DEFAULT '0.00' COMMENT '财务费用',
  `BQ_TZSS` decimal(16,2) DEFAULT '0.00' COMMENT '投资损失（减：收益）',
  `BQ_DYSKDX` decimal(16,2) DEFAULT '0.00' COMMENT '递延税款贷项（减：借项）',
  `BQ_CHDJS` decimal(16,2) DEFAULT '0.00' COMMENT '存货的减少（减：增加）',
  `BQ_JYXYSXMDJS` decimal(16,2) DEFAULT '0.00' COMMENT '经营性应收项目的减少（减：增加）',
  `BQ_JYXYFXMDZJ` decimal(16,2) DEFAULT '0.00' COMMENT '经营性应付项目的增加（减：减少）',
  `BQ_QT` decimal(16,2) DEFAULT '0.00' COMMENT '其他',
  `BQ_JYHDCSDXJLLJE` decimal(16,2) DEFAULT '0.00' COMMENT '经营活动产生的现金流量净额',
  `BQ_BSJXJSZ` decimal(16,2) DEFAULT '0.00' COMMENT '2、不涉及现金收支的投资和筹资活动：',
  `BQ_ZWZWZB` decimal(16,2) DEFAULT '0.00' COMMENT '债务转为资本',
  `BQ_YNNDQDKZHGSZJ` decimal(16,2) DEFAULT '0.00' COMMENT '一年内到期的可转换公司债券',
  `BQ_RZZRGDZC` decimal(16,2) DEFAULT '0.00' COMMENT '融资租入固定资产',
  `BQ_XJJXJDJWJZJQK` decimal(16,2) DEFAULT '0.00' COMMENT '3、现金及现金等价物净增加情况',
  `BQ_XJDQMYE` decimal(16,2) DEFAULT '0.00' COMMENT '现金的期末余额',
  `BQ_JXJDQCYE` decimal(16,2) DEFAULT '0.00' COMMENT '减：现金的期初余额',
  `BQ_JXJDJWDQMYE` decimal(16,2) DEFAULT '0.00' COMMENT '加：现金等价物的期末余额',
  `BQ_JXJDJWDQCYE` decimal(16,2) DEFAULT '0.00' COMMENT '减：现金等价物的期初余额',
  `BQ_XJJXJDJWJZJE2` decimal(16,2) DEFAULT '0.00' COMMENT '现金及现金等价物净增加额(第二个)',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_basi_cash_flow` */

/*Table structure for table `t_basi_profit` */

DROP TABLE IF EXISTS `t_basi_profit`;

CREATE TABLE `t_basi_profit` (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IMP_USER` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `BATCH_ID` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJMOTH` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR_MOTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `JEDW` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `BY_ZYYWSR` decimal(16,2) DEFAULT '0.00',
  `BY_ZYYWCB` decimal(16,2) DEFAULT '0.00',
  `BY_ZYYWSJJFJ` decimal(16,2) DEFAULT '0.00',
  `BY_ZYYWLR` decimal(16,2) DEFAULT '0.00',
  `BY_QTYWLR` decimal(16,2) DEFAULT '0.00',
  `BY_YYFY` decimal(16,2) DEFAULT '0.00',
  `BY_GLFY` decimal(16,2) DEFAULT '0.00',
  `BY_CWFY` decimal(16,2) DEFAULT '0.00',
  `BY_YYLR` decimal(16,2) DEFAULT '0.00',
  `BY_TZSY` decimal(16,2) DEFAULT '0.00',
  `BY_BTSR` decimal(16,2) DEFAULT '0.00',
  `BY_YYWSR` decimal(16,2) DEFAULT '0.00',
  `BY_YYWZC` decimal(16,2) DEFAULT '0.00',
  `BY_LRZE` decimal(16,2) DEFAULT '0.00',
  `BY_SDS` decimal(16,2) DEFAULT '0.00',
  `BY_JLR` decimal(16,2) DEFAULT '0.00',
  `BY_CSCLBM` decimal(16,2) DEFAULT '0.00',
  `BY_ZRZHFSDSS` decimal(16,2) DEFAULT '0.00',
  `BY_KJZCBGZJ` decimal(16,2) DEFAULT '0.00',
  `BY_KJGJBGZJ` decimal(16,2) DEFAULT '0.00',
  `BY_ZWCZSS` decimal(16,2) DEFAULT '0.00' COMMENT '5.债务重组损失',
  `BY_OTHERS` decimal(16,2) DEFAULT '0.00',
  `BN_ZYYWSR` decimal(16,2) DEFAULT '0.00',
  `BN_ZYYWCB` decimal(16,2) DEFAULT '0.00',
  `BN_ZYYWSJJFJ` decimal(16,2) DEFAULT '0.00',
  `BN_ZYYWLR` decimal(16,2) DEFAULT '0.00',
  `BN_QTYWLR` decimal(16,2) DEFAULT '0.00',
  `BN_YYFY` decimal(16,2) DEFAULT '0.00',
  `BN_GLFY` decimal(16,2) DEFAULT '0.00',
  `BN_CWFY` decimal(16,2) DEFAULT '0.00',
  `BN_YYLR` decimal(16,2) DEFAULT '0.00',
  `BN_TZSY` decimal(16,2) DEFAULT '0.00',
  `BN_BTSR` decimal(16,2) DEFAULT '0.00',
  `BN_YYWSR` decimal(16,2) DEFAULT '0.00',
  `BN_YYWZC` decimal(16,2) DEFAULT '0.00',
  `BN_LRZE` decimal(16,2) DEFAULT '0.00',
  `BN_SDS` decimal(16,2) DEFAULT '0.00',
  `BN_JLR` decimal(16,2) DEFAULT '0.00',
  `BN_CSCLBM` decimal(16,2) DEFAULT '0.00',
  `BN_ZRZHFSDSS` decimal(16,2) DEFAULT '0.00',
  `BN_KJZCBGZJ` decimal(16,2) DEFAULT '0.00',
  `BN_KJGJBGZJ` decimal(16,2) DEFAULT '0.00',
  `BN_ZWCZSS` decimal(16,2) DEFAULT '0.00' COMMENT '5.债务重组损失',
  `BN_OTHERS` decimal(16,2) DEFAULT '0.00',
  `BY_XSFY` decimal(16,2) DEFAULT '0.00' COMMENT '销售费用',
  `BN_XSFY` decimal(16,2) DEFAULT '0.00' COMMENT '销售费用',
  `BY_ZCJZSS` decimal(16,2) DEFAULT '0.00' COMMENT '资产减值损失',
  `BN_ZCJZSS` decimal(16,2) DEFAULT '0.00',
  `BY_GYJZBDSY` decimal(16,2) DEFAULT '0.00' COMMENT '公允价值变动收益',
  `BN_GYJZBDSY` decimal(16,2) DEFAULT '0.00',
  `BY_DLYQYHHYQYDTZSY` decimal(16,2) DEFAULT '0.00' COMMENT '对联营企业和合营企业的投资收益',
  `BN_DLYQYHHYQYDTZSY` decimal(16,2) DEFAULT '0.00',
  `BY_FLDZCCZSS` decimal(16,2) DEFAULT '0.00' COMMENT '非流动资产处置损失',
  `BN_FLDZCCZSS` decimal(16,2) DEFAULT '0.00',
  `BY_MGSY` decimal(16,2) DEFAULT '0.00' COMMENT '每股收益',
  `BN_MGSY` decimal(16,2) DEFAULT '0.00',
  `BY_JBMGSY` decimal(16,2) DEFAULT '0.00' COMMENT '基本每股收益',
  `BN_JBMGSY` decimal(16,2) DEFAULT '0.00',
  `BY_XSMGSY` decimal(16,2) DEFAULT '0.00' COMMENT '稀释每股收益',
  `BN_XSMGSY` decimal(16,2) DEFAULT '0.00',
  `account_port_type` bigint DEFAULT '0',
  `FORMAT_FLAG` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'N' COMMENT '数据转换标识(N/Y)',
  `BY_YYZCB` decimal(16,2) DEFAULT '0.00' COMMENT '营业总成本',
  `BN_YYZCB` decimal(16,2) DEFAULT '0.00' COMMENT '营业总成本',
  `BY_GSYMGSJLR` decimal(16,2) DEFAULT '0.00' COMMENT '归属于母公司所有者的净利润',
  `BN_GSYMGSJLR` decimal(16,2) DEFAULT '0.00' COMMENT '归属于母公司所有者的净利润',
  `BY_SSGDSY` decimal(16,2) DEFAULT '0.00' COMMENT '少数股东损益',
  `BN_SSGDSY` decimal(16,2) DEFAULT '0.00' COMMENT '少数股东损益',
  `BY_YYSR` decimal(16,2) DEFAULT '0.00' COMMENT '一、营业收入',
  `BY_JZCJZSS` decimal(16,2) DEFAULT '0.00' COMMENT '资产减值损失',
  `BY_LYQYTZ` decimal(16,2) DEFAULT '0.00' COMMENT '其中：对联营企业和合营企业的投资收益',
  `BY_HYSY` decimal(16,2) DEFAULT '0.00' COMMENT '汇兑收益（损失以“-”号填列）',
  `BY_LQTSY` decimal(16,2) DEFAULT '0.00' COMMENT '其他收益',
  `BY_ZCCZSY` decimal(16,2) DEFAULT '0.00' COMMENT '资产处置收益（损失以“-”号填列）',
  `BN_ZCCZSY` decimal(16,2) DEFAULT '0.00' COMMENT '资产处置收益（损失以“-”号填列）',
  `BY_QTSY` decimal(16,2) DEFAULT '0.00' COMMENT '其他收益',
  `BN_QTSY` decimal(16,2) DEFAULT '0.00' COMMENT '其他收益',
  `BY_BHBFJLRBD` decimal(16,2) DEFAULT '0.00' COMMENT '被合并方在合并前实现的净利润变动',
  `BN_BHBFJLRBD` decimal(16,2) DEFAULT '0.00' COMMENT '被合并方在合并前实现的净利润变动',
  `BY_CSCLBMSY` decimal(16,2) DEFAULT '0.00' COMMENT '1.出售、处理部门或被投资单位所得收益',
  `BN_CSCLBMSY` decimal(16,2) DEFAULT '0.00' COMMENT '1.出售、处理部门或被投资单位所得收益',
  `BY_ZRZHFSSS` decimal(16,2) DEFAULT '0.00' COMMENT '2.自然灾害发生的损失',
  `BN_ZRZHFSSS` decimal(16,2) DEFAULT '0.00' COMMENT '2.自然灾害发生的损失',
  `BY_KJZCBGZJJLR` decimal(16,2) DEFAULT '0.00' COMMENT '3.会计政策变更增加（或减少）净利润',
  `BN_KJZCBGZJJLR` decimal(16,2) DEFAULT '0.00' COMMENT '3.会计政策变更增加（或减少）净利润',
  `BY_KJGJBGZJJLR` decimal(16,2) DEFAULT '0.00' COMMENT '4.会计估计变更增加（或减少）净利润',
  `BN_KJGJBGZJJLR` decimal(16,2) DEFAULT '0.00' COMMENT '4.会计估计变更增加（或减少）净利润',
  `BY_QT` decimal(16,2) DEFAULT '0.00' COMMENT '6.其他',
  `BN_QT` decimal(16,2) DEFAULT '0.00' COMMENT '6.其他',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_basi_profit` */

/*Table structure for table `t_code_libr` */

DROP TABLE IF EXISTS `t_code_libr`;

CREATE TABLE `t_code_libr` (
  `ID` int NOT NULL,
  `CODE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_NO` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `REPORT_TYPE` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_area` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT '来源表code( 1:资产负债表 2:利润表 3:现金流量表 4:科目余额表)',
  `use_area_remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '来源表名称',
  `data_type` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_type_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_current` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '资产(0流动资产，1非流动资产,3营业成本，4营业收入，5营业利润，6利润总额，7净利润)',
  `is_details` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '是否有详情(0,没有，1有)',
  `survey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '概况',
  `warn` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '预警',
  `parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '上级ID',
  `clzz` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '0无，1应付，2应收，',
  `BASI_FIELD` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `km1` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `km2` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `km3` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_code_libr` */

insert  into `t_code_libr`(`ID`,`CODE_NAME`,`CODE_NO`,`REPORT_TYPE`,`use_area`,`use_area_remark`,`data_type`,`data_type_desc`,`is_current`,`is_details`,`survey`,`warn`,`parent_id`,`clzz`,`BASI_FIELD`,`km1`,`km2`,`km3`,`remark`) values 
(10001,'货币资金','ZCFZ-A','1','1001','资产负债表','0','','0','1','G1065','10001',NULL,'km07-银行存款变动（单位：万元）_x;km07-前五大银行存款占比（单位：万元）_b@5',NULL,'1002;1002%1','','','2'),
(10002,'结算备付金','ZCFZ-B','1','1002','资产负债表','1','','0','1','199999','',NULL,'',NULL,NULL,'',NULL,NULL),
(10003,'拆出资金','ZCFZ-C','1','1003','资产负债表','1',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10004,'以公允价值计量且其变动计入当期损益的金融资产','ZCFZ-D','1','1004','资产负债表','0','','0','1','G1011','10003',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10005,'衍生金融资产','ZCFZ-E','1','1005','资产负债表','0','','0','1','G1067','50001',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10006,'应收票据','ZCFZ-F','1','1006','资产负债表','0','','0','1','G1012','10022',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10007,'应收账款','ZCFZ-G','1','1007','资产负债表','0','','0','1','G1005','11002',NULL,'km07-前五大应收客户占比（单位：万元）_b@5;km01-客户应收账款账龄分析（单位：万元）_hs@5;km01-各区间账龄占比（单位：万元）_bb;km07-前五大应收客户对比_s@5',NULL,'1122%1;6;6;1122%1','','','2'),
(10008,'预付款项','ZCFZ-H','1','1008','资产负债表','0','','0','1','G1006','11003',NULL,'km07-前五大预付供应商占比（单位：万元）_b@5;km01-供应商预付账款账龄分析（单位：万元）_hs@5;km01-各区间账龄占比（单位：万元）_bb;km07-前五大预付供应商对比_s@5',NULL,'1123%1;7;7;1123%1','','','2'),
(10009,'应收保费','ZCFZ-I','1','1009','资产负债表','1',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10010,'应收分保账款','ZCFZ-J','1','1010','资产负债表','1',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10011,'应收分保合同准备金','ZCFZ-K','1','1011','资产负债表','1',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10012,'应收利息','ZCFZ-L','1','1012','资产负债表','0','','0','1','G1013','10001',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10013,'应收股利','ZCFZ-M','1','1013','资产负债表','0','','0','1','G1014','10002',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10014,'其他应收款','ZCFZ-N','1','1014','资产负债表','0','','0','1','G1007','11004',NULL,'km07-前五大其他应收款占比（单位：万元）_b@5;km01-其他应收款账龄分析（单位：万元）_hs@5;km01-各区间账龄占比（单位：万元）_bb',NULL,'1221%1;4;4','','','2'),
(10015,'买入返售金融资产','ZCFZ-O','1','1015','资产负债表','1',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10016,'存货','ZCFZ-P','1','1016','资产负债表','0','','0','1','G1008','11005',NULL,'km07-存货构成(单位：万元)_b@100;km31-原材料各月入库单价_x;km01-产成品各月入库和销售单价变动（单位：元）_xxs;km01-前五大原材料库龄（单位：万元）_hs2;km01-前五大产成品库龄(单位：万元)_hs2;km01-原材料库龄分布(单位：万元)_bb2;km01-产成品库龄分布（单位：万元）_bb2',NULL,'14%1;2RM;km31%1@入库单价,km32%1@销售单价TS;10@5;9@10;10;9','','','2'),
(10017,'持有待售的资产','ZCFZ-Q','1','1017','资产负债表','0','','0','1','G1009','10006',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10018,'一年内到期的非流动资产','ZCFZ-R','1','1018','资产负债表','0','','0','1','G1015','10004',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10019,'其他流动资产','ZCFZ-S','1','1019','资产负债表','0','','0','1','G1016','10005',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10020,'流动资产合计','ZCFZ-T','1','10','资产负债表','0',NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10021,'发放贷款及垫款','ZCFZ-U','1','1101','资产负债表','1',NULL,'1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10022,'可供出售金融资产','ZCFZ-V','1','1102','资产负债表','0','','1','1','G1017','10007',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10023,'持有至到期投资','ZCFZ-W','1','1103','资产负债表','0','','1','1','G1018','10008',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10024,'长期应收款','ZCFZ-X','1','1104','资产负债表','0','','1','1','G1019','10011',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10025,'长期股权投资','ZCFZ-Y','1','1105','资产负债表','0','','1','1','G1020','10012',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10026,'投资性房地产','ZCFZ-Z','1','1106','资产负债表','0','','1','1','G1021','10013',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10027,'固定资产','ZCFZ-AA','1','1107','资产负债表','0','','1','1','G1002','10009',NULL,'km07-固定资产构成（单位：万元）_b',NULL,'1601%1','','','2'),
(10028,'在建工程','ZCFZ-AB','1','1108','资产负债表','0','','1','1','G1022','10010',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10029,'工程物资','ZCFZ-AC','1','1109','资产负债表','0','','1','1','G1023','10014',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10030,'固定资产清理','ZCFZ-AD','1','1110','资产负债表','0','','1','1','G1024','10015',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10031,'生产性生物资产','ZCFZ-AE','1','1111','资产负债表','0','','1','1','G1025','50002',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10032,'油气资产','ZCFZ-AF','1','1112','资产负债表','0','','1','1','G1026','50003',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10033,'无形资产','ZCFZ-AG','1','1113','资产负债表','0','','1','1','G1027','10016',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10034,'开发支出','ZCFZ-AH','1','1114','资产负债表','0','','1','1','G1028','10017',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10035,'商誉','ZCFZ-AI','1','1115','资产负债表','0','','1','1','G1029','10018',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10036,'长期待摊费用','ZCFZ-AJ','1','1116','资产负债表','0','','1','1','G1030','10019',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10037,'递延所得税资产','ZCFZ-AK','1','1117','资产负债表','0','','1','1','G1031','10020',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10038,'其他非流动资产','ZCFZ-AL','1','1118','资产负债表','0','','1','1','G1032','10021',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10039,'非流动资产合计','ZCFZ-AM','1','11','资产负债表','0',NULL,'1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10040,'资产总计','ZCFZ-AN','1','01','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10041,'短期借款','ZCFZ-AO','1','1201','资产负债表','0','','','1','G1033','10023',NULL,'km08-短期借款构成（单位：万元）_b@5',NULL,'2001%1','','','2'),
(10042,'向中央银行借款','ZCFZ-AP','1','1202','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10043,'吸收存款及同业存放','ZCFZ-AQ','1','1203','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10044,'拆入资金','ZCFZ-AR','1','1204','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10045,'以公允价值计量且其变动计入当期损益的金融负债','ZCFZ-AS','1','1205','资产负债表','0','','','1','G1034','50004',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10046,'衍生金融负债','ZCFZ-AT','1','1206','资产负债表','0','','','1','G1035','50005',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10047,'应付票据','ZCFZ-AU','1','1207','资产负债表','0','','','1','G1036','10024',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10048,'应付账款','ZCFZ-AV','1','1208','资产负债表','0','','','1','G1037','11006',NULL,'km08-前五大供应商应付账款（单位：万元）_b@5;km01-应付账款账龄分析（单位：万元）_hs@5;km01-应付账款账龄占比（单位：万元）_bb;km08-前五大应付供应商对比_s',NULL,'2202%1;5;5;2202%1','','','2'),
(10049,'预收款项','ZCFZ-AW','1','1209','资产负债表','0','','','1','G1038','11007',NULL,'km08-前五大预收客户占比（单位：万元）_b@5;km01-客户预收账款账龄分析（单位：万元）_hs@5;km01-预收账款账龄占比（单位：万元）_bb;km08-前五大预收客户对比_s@5',NULL,'2203%1;8;8;2203%1','','','2'),
(10050,'卖出回购金融资产款','ZCFZ-AX','1','1210','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10051,'应付手续费及佣金','ZCFZ-AY','1','1211','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10052,'应付职工薪酬','ZCFZ-AZ','1','1212','资产负债表','0','','','1','G1039','10026',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10053,'应交税费','ZCFZ-BA','1','1213','资产负债表','0','','','1','G1040','10027',NULL,'km08-前五大应收税费构成（单位：万元）_b@5',NULL,'2221%1','','','2'),
(10054,'应付利息','ZCFZ-BB','1','1214','资产负债表','0','','','1','G1041','10028',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10055,'应付股利','ZCFZ-BC','1','1215','资产负债表','0','','','1','G1042','10029',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10056,'其他应付款','ZCFZ-BD','1','1216','资产负债表','0','','','1','G1043','11008',NULL,'km08-前五大其他应付款占比（单位：万元）_b@5;km01-其他应付款账龄分析（单位：万元）_hs@5;km01-其他应付款账龄占比（单位：万元）_bb',NULL,'2241%1;3;3','','','2'),
(10057,'应付分保账款','ZCFZ-BE','1','1217','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10058,'保险合同准备金','ZCFZ-BF','1','1218','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10059,'代理买卖证券款','ZCFZ-BG','1','1219','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10060,'代理承销证券款','ZCFZ-BH','1','1220','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10061,'持有待售的负债','ZCFZ-BI','1','1221','资产负债表','0','','','1','G1044','50011',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10062,'一年内到期的非流动负债','ZCFZ-BJ','1','1222','资产负债表','0','','','1','G1045','10025',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10063,'其他流动负债','ZCFZ-BK','1','1223','资产负债表','0','','','1','G1046','10030',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10064,'流动负债合计','ZCFZ-BL','1','12','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10065,'长期借款','ZCFZ-BM','1','1301','资产负债表','0','','','1','G1047','10031',NULL,'km08-前五大长期借款构成（单位：万元）_b@5',NULL,'2501%1','','','2'),
(10066,'应付债券','ZCFZ-BN','1','1302','资产负债表','0','','','1','G1048','10032',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10067,'其中：优先股','ZCFZ-BO','1','1303','资产负债表','1','','','0','G1049','',NULL,'',NULL,'','','',''),
(10068,'永续债','ZCFZ-BP','1','1304','资产负债表','1','','','1','G1050','',NULL,'',NULL,'','','',''),
(10069,'长期应付款','ZCFZ-BQ','1','1305','资产负债表','0','','','1','G1051','10033',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10070,'长期应付职工薪酬','ZCFZ-BR','1','1306','资产负债表','1',NULL,NULL,'1',NULL,'10039',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10071,'专项应付款','ZCFZ-BS','1','1307','资产负债表','0','','','1','G1052','10034',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10072,'预计负债','ZCFZ-BT','1','1308','资产负债表','0','','','1','G1053','50006',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10073,'递延收益','ZCFZ-BU','1','1309','资产负债表','0','','','1','G1054','10038',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10074,'递延所得税负债','ZCFZ-BV','1','1310','资产负债表','0','','','1','G1055','10036',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10075,'其他非流动负债','ZCFZ-BW','1','1311','资产负债表','0','','','1','G1056','10037',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10076,'非流动负债合计','ZCFZ-BX','1','13','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10077,'负债合计','ZCFZ-BY','1','02','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10078,'实收资本（或股本）','ZCFZ-BZ','1','1401','资产负债表','0','','','1','G1057','10040',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10079,'其他权益工具','ZCFZ-CA','1','1402','资产负债表','0','','','1','G1058','50013',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10080,'其中：优先股','ZCFZ-CB','1','1403','资产负债表','1','','','1','G1059','',NULL,'',NULL,'','','',''),
(10081,'永续债','ZCFZ-CC','1','1404','资产负债表','1','','','1','G1060','',NULL,'',NULL,'','','',''),
(10082,'资本公积','ZCFZ-CD','1','1405','资产负债表','0','','','1','G1061','10041',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10083,'减：库存股','ZCFZ-CE','1','1406','资产负债表','0','','','1','G1062','',NULL,'',NULL,'','','',''),
(10084,'其他综合收益','ZCFZ-CF','1','1407','资产负债表','0','','','1','G1063','50012',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10085,'专项储备','ZCFZ-CG','1','1408','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10086,'盈余公积','ZCFZ-CH','1','1409','资产负债表','0','','','1','G1069','10042',NULL,'',NULL,'','','',''),
(10087,'一般风险准备','ZCFZ-CI','1','1410','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10088,'未分配利润','ZCFZ-CJ','1','1411','资产负债表','0','','','1','G1064','10043',NULL,'',NULL,NULL,NULL,NULL,NULL),
(10089,'归属于母公司所有者权益合计','ZCFZ-CK','1','1412','资产负债表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10090,'少数股东权益','ZCFZ-CL','1','1413','资产负债表','1','','','1','','',NULL,'',NULL,'','','',''),
(10091,'所有者权益合计','ZCFZ-CM','1','14','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10092,'负债和所有者权益总计','ZCFZ-CN','1','03','资产负债表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20001,'营业收入','LR-A','2','21','利润表','0','','4','1','G2021','20001',NULL,'km23-各月销售数量变动_x;km07-各月应收收入比较（单位：万元）_xxb;km04-前五大销售客户（单位：万元）_b@5;km04-前五大客户收入同期对比_s@5;km04-前五大产品收入构成（单位：万元）_b@5;km04-前五大产品收入同期对比_s@5;km01-营业收入与营业成本_ss',NULL,'1RM;1007@应收款项,21@营业收入;6001%1;2.0;1.0;1.0;21,2105','','','2'),
(20003,'利息收入','LR-C','2','2102','利润表','1',NULL,'4','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20004,'已赚保费','LR-D','2','2103','利润表','1',NULL,'4','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20005,'手续费及佣金收入','LR-E','2','2104','利润表','1',NULL,'4','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),
(20006,'营业成本','LR-F','2','2105','利润表','0','','3','1','G2015','20002',NULL,'km03-各月应付成本比较（单位：万元）_xxb;km03-前五大生产成本构成（单位：万元）_b@5;km03-生成成本中的人工费用_x;km03-前五大制造费用构成（单位：万元）_b@5;km03-制造费用中的人工费用变动_x;km01-营业收入与营业成本_ss',NULL,'1208@应付账款,2105@营业成本;5001%1;500102;5101%1;510102;21,2105','','','2'),
(20008,'利息支出','LR-H','2','2106','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2202'),
(20009,'手续费及佣金支出','LR-I','2','2107','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2203'),
(20010,'退保金','LR-J','2','2108','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2204'),
(20011,'赔付支出净额','LR-K','2','2109','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2205'),
(20012,'提取保险合同准备金净额','LR-L','2','2110','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2206'),
(20013,'保单红利支出','LR-M','2','2111','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2207'),
(20014,'分保费用','LR-N','2','2112','利润表','1',NULL,'3','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2208'),
(20015,'税金及附加','LR-O','2','2113','利润表','0','','3','1','G2002','20014',NULL,'',NULL,NULL,NULL,NULL,'2209'),
(20016,'销售费用','LR-P','2','2114','利润表','0','','3','1','G2003','G20004',NULL,'km03-前五大销售费用构成（单位：万元）_b@5;km03-销售费用与营业收入的趋势比较（单位：万元）_xxb',NULL,'6601%1;2114@销售费用,21@收入','','','2'),
(20017,'管理费用','LR-Q','2','2115','利润表','0','','3','1','G2004','G20007',NULL,'km03-前五大管理费用构成（单位：万元）_b@5',NULL,'6602%1','','','2'),
(20018,'财务费用','LR-R','2','2116','利润表','0','','3','1','G2005','20010',NULL,'km03-前五大财务费用构成（单位：万元）_b@5',NULL,'6603%1','','','2'),
(20019,'资产减值损失','LR-S','2','2117','利润表','0',NULL,'3','1','G2006','20015',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20020,'公允价值变动收益','LR-T','2','2118','利润表','0','','3','1','G2007','20016',NULL,'',NULL,NULL,NULL,NULL,NULL),
(20021,'投资收益','LR-U','2','2119','利润表','0','','3','1','G2008','20011',NULL,'',NULL,NULL,NULL,NULL,NULL),
(20022,'对联营企业和合营企业的投资收益','LR-V','2','2120','利润表','1','','3','0','G2009','',NULL,'',NULL,'','','',''),
(20023,'资产处置收益','LR-W','2','2121','利润表','0','','3','1','G2020','7005',NULL,'',NULL,'','','',''),
(20024,'其他收益','LR-X','2','2122','利润表','0','','3','1','G2011','50010',NULL,'','','','','',''),
(20025,'营业利润','LR-Y','2','23','利润表','0','','5','1','G2016','20018',NULL,'',NULL,'','','',''),
(20026,'营业外收入','LR-Z','2','2301','利润表','0','','5','1','G2012','20012',NULL,'km03-营业外收入与支出对比（单位：万元）_s',NULL,'6301,6711','','','2'),
(20027,'其中：非流动资产处置利得','LR-AA','2','2302','利润表','1',NULL,'5','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL),
(20028,'营业外支出','LR-AB','2','2303','利润表','0','','5','1','G2013','20013',NULL,'km03-营业外收入与支出同期对比（单位：万元）_s',NULL,'6301,6711','','','2'),
(20029,'其中：非流动资产处置损失','LR-AC','2','2304','利润表','1',NULL,'5','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20030,'利润总额','LR-AD','2','24','利润表','0','','6','1','G2017','20019',NULL,'',NULL,'','','',''),
(20031,'所得税费用','LR-AE','2','2401','利润表','0','','6','1','G2014','20017',NULL,'',NULL,'','','',''),
(20032,'净利润','LR-AF','2','25','利润表','0','','7','1','G2018','20020',NULL,'',NULL,'','','',''),
(20033,'其中：被合并方在合并前实现的净利润','LR-AG','2','2502','利润表','1','','7','0','','',NULL,'',NULL,'','','',''),
(20034,'归属于母公司所有者的净利润','LR-AH','2','2503','利润表','1','','7','0','','',NULL,'',NULL,'','','',''),
(20035,'少数股东损益','LR-AI','2','2504','利润表','1','','7','0','','',NULL,'',NULL,'','','',''),
(20055,'汇兑收益','LR-CC','2','2123','利润表','0',NULL,NULL,'0',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL),
(30001,'销售商品、提供劳务收到的现金','XJLL-A','3','3101','现金流量表','0','','','1','G3004','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30002,'客户存款和同业存放款项净增加额','XJLL-B','3','3102','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30003,'向中央银行借款净增加额','XJLL-C','3','3103','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30004,'向其他金融机构拆入资金净增加额','XJLL-D','3','3104','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30005,'收到原保险合同保费取得的现金','XJLL-E','3','3105','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30006,'收到再保险业务现金净额','XJLL-F','3','3106','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30007,'保户储金及投资款净增加额','XJLL-G','3','3107','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30008,'处置以公允价值计量且其变动计入当期损益的金融资产净增加额','XJLL-H','3','3108','现金流量表','1','','','1','','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30009,'收取利息、手续费及佣金的现金','XJLL-I','3','3109','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30010,'拆入资金净增加额','XJLL-G','3','3110','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30011,'回购业务资金净增加额','XJLL-K','3','3111','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30012,'收到的税费返还','XJLL-L','3','3112','现金流量表','0','','','1','G3005','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30013,'收到其他与经营活动有关的现金','XJLL-M','3','3113','现金流量表','0','','','1','G3006','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30014,'经营活动现金流入小计','XJLL-N','3','31','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30015,'购买商品、接受劳务支付的现金','XJLL-O','3','3201','现金流量表','0','','','1','G3007','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30016,'客户贷款及垫款净增加额','XJLL-P','3','3202','现金流量表','1','','','1','','',NULL,'',NULL,'','','',''),
(30017,'存放中央银行和同业款项净增加额','XJLL-Q','3','3203','现金流量表','1','','','1','','',NULL,'',NULL,'','','',''),
(30018,'支付原保险合同赔付款项的现金','XJLL-R','3','3204','现金流量表','1','','','1','','',NULL,'',NULL,'','','',''),
(30019,'支付利息、手续费及佣金的现金','XJLL-S','3','3205','现金流量表','1','','','1','','',NULL,'',NULL,'','','',''),
(30020,'支付保单红利的现金','XJLL-T','3','3206','现金流量表','1','','','1','','',NULL,'',NULL,'','','',''),
(30021,'支付给职工以及为职工支付的现金','XJLL-U','3','3207','现金流量表','0','','','1','G3008','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30022,'支付的各项税费','XJLL-V','3','3208','现金流量表','0','','','1','G3009','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30023,'支付其他与经营活动有关的现金','XJLL-W','3','3209','现金流量表','0','','','1','G3010','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30024,'经营活动现金流出小计','XJLL-X','3','32','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30025,'经营活动产生的现金流量净额','XJLL-Y','3','42','现金流量表','0','','','1','7001','',NULL,'',NULL,'','','',''),
(30026,'收回投资收到的现金','XJLL-AA','3','3301','现金流量表','0','','','1','G3011','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30027,'取得投资收益收到的现金','XJLL-AB','3','3302','现金流量表','0','','','1','G3012','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30028,'处置固定资产、无形资产和其他长期资产收回的现金净额','XJLL-AC','3','3303','现金流量表','0','','','1','G3013','',NULL,'',NULL,'','','',''),
(30029,'处置子公司及其他经营单位收到的现金净额','XJLL-AD','3','3304','现金流量表','0','','','1','G3014','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30030,'收到其他与投资活动有关的现金','XJLL-AE','3','3305','现金流量表','0','','','1','G3015','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30031,'投资活动现金流入小计','XJLL-AF','3','33','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30032,'购建固定资产、无形资产和其他长期资产支付的现金','XJLL-AG','3','3401','现金流量表','0','','','1','G3016','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30033,'投资支付的现金','XJLL-AH','3','3402','现金流量表','0','','','1','G3017','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30034,'质押贷款净增加额','XJLL-AI','3','3403','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30035,'取得子公司及其他经营单位支付的现金净额','XJLL-AJ','3','3404','现金流量表','0','','','1','G3018','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30036,'支付其他与投资活动有关的现金','XJLL-AK','3','3405','现金流量表','0','','','1','G3019','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30037,'投资活动现金流出小计','XJLL-AL','3','34','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30038,'投资活动产生的现金流量净额','XJLL-AM','3','43','现金流量表','0','','','1','7002','',NULL,'',NULL,'','','',''),
(30039,'吸收投资收到的现金','XJLL-AO','3','3501','现金流量表','0','','','1','G3020','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30040,'其中：子公司吸收少数股东投资收到的现金','XJLL-AP','3','3502','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30041,'取得借款收到的现金','XJLL-AQ','3','3503','现金流量表','0','','','1','G3021','',NULL,'',NULL,'','','',''),
(30042,'发行债券收到的现金','XJLL-AR','3','3504','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30043,'收到其他与筹资活动有关的现金','XJLL-AS','3','3506','现金流量表','0','','','1','G3022','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30044,'筹资活动现金流入小计','XJLL-AT','3','35','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30045,'偿还债务支付的现金','XJLL-AU','3','3601','现金流量表','0','','','1','G3023','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30046,'分配股利、利润或偿付利息支付的现金','XJLL-AV','3','3602','现金流量表','0','','','1','G3024','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30047,'其中：子公司支付给少数股东的股利、利润','XJLL-AW','3','3603','现金流量表','1',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30048,'支付其他与筹资活动有关的现金','XJLL-AX','3','3604','现金流量表','0','','','1','G3025','',NULL,'',NULL,NULL,NULL,NULL,NULL),
(30049,'筹资活动现金流出小计','XJLL-AY','3','36','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30050,'筹资活动产生的现金流量净额','XJLL-AZ','3','37','现金流量表','0','','','1','7003','',NULL,'',NULL,'','','',''),
(30051,'四、汇率变动对现金及现金等价物的影响','XJLL-BA','3','38','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30052,'五、现金及现金等价物净增加额','XJLL-BB','3','39','现金流量表','0','','','1','7004','',NULL,'',NULL,'','','',''),
(30053,'加：期初现金及现金等价物余额','XJLL-BC','3','40','现金流量表','0',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30054,'六、期末现金及现金等价物余额','XJLL-BD','3','41','现金流量表','0','','','1','7006','',NULL,'',NULL,'','','',''),
(40001,'营运资本','YBLFX-A','5','bl5001','比率分析','0','','','1','GBL8001','',NULL,'0',NULL,'','','',''),
(40002,'流动比率','YBLFX-B','5','bl5002','比率分析','0','','','1','GBL8002','',NULL,'0',NULL,'','','',''),
(40003,'速动比率','YBLFX-C','5','bl5003','比率分析','0','','','1','GBL8003','',NULL,'0',NULL,'','','',''),
(40004,'现金比率','YBLFX-D','5','bl5004','比率分析','0','','','1','GBL8004','',NULL,'0',NULL,'','','',''),
(40005,'现金流量比率','YBLFX-E','5','bl5005','比率分析','0','','','1','GBL8005','',NULL,'0',NULL,'','','',''),
(40006,'资产负债率','YBLFX-F','5','bl5101','比率分析','0','','','1','GBL8006','',NULL,'0',NULL,'','','',''),
(40007,'产权比率','YBLFX-G','5','bl5102','比率分析','0','','','1','GBL8007','',NULL,'0',NULL,'','','',''),
(40008,'权益乘数','YBLFX-H','5','bl5103','比率分析','0','','','1','GBL8008','',NULL,'0',NULL,'','','',''),
(40009,'长期资本负债率','YBLFX-I','5','bl5104','比率分析','0','','','1','GBL8009','',NULL,'0',NULL,'','','',''),
(40010,'利息保障倍数','YBLFX-J','5','bl5105','比率分析','0',NULL,NULL,'1',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL),
(40011,'现金流量信息保障倍数','YBLFX-K','5','bl5106','比率分析','0',NULL,NULL,'1',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL),
(40012,'现金流量债务比','YBLFX-M','5','bl5107','比率分析','0','','','1','GBL8010','',NULL,'0',NULL,'','','',''),
(40013,'应收账款周转天数','YBLFX-L','5','bl5201','比率分析','0','','','1','GBL8011','',NULL,'0',NULL,'','','',''),
(40014,'存货周转天数','YBLFX-N','5','bl5202','比率分析','0','','','1','GBL8012','',NULL,'0',NULL,'','','',''),
(40015,'应付账款周转天数','YBLFX-O','5','bl5203','比率分析','0','','','1','GBL8013','',NULL,'0',NULL,'','','',''),
(40016,'流动资产周转天数','YBLFX-P','5','bl5204','比率分析','0','','','1','GBL8014','',NULL,'0',NULL,'','','',''),
(40017,'营运资本周转天数','YBLFX-Q','5','bl5205','比率分析','0','','','1','GBL8015','',NULL,'0',NULL,'','','',''),
(40018,'非流动资产周转天数','YBLFX-R','5','bl5206','比率分析','0','','','1','GBL8016','',NULL,'0',NULL,'','','',''),
(40019,'总资产周转天数','YBLFX-S','5','bl5207','比率分析','0','','','1','GBL8017','',NULL,'0',NULL,'','','',''),
(40020,'销售净利润率','YBLFX-T','5','bl5301','比率分析','0','','','1','GBL8018','',NULL,'0',NULL,'','','',''),
(40021,'总资产净利润率','YBLFX-W','5','bl5302','比率分析','0','','','1','GBL8019','',NULL,'0',NULL,'','','',''),
(40022,'权益净利润率','YBLFX-Y','5','bl5303','比率分析','0','','','1','GBL8020','',NULL,'0',NULL,'','','','');

/*Table structure for table `t_code_mapper` */

DROP TABLE IF EXISTS `t_code_mapper`;

CREATE TABLE `t_code_mapper` (
  `BASI_FIELD` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_NO` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `FBACK` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_code_mapper` */

insert  into `t_code_mapper`(`BASI_FIELD`,`CODE_NO`,`FBACK`) values 
('QM_LDZC_HBZJ','ZCFZ-A',NULL),
('QM_LDZC_JYXJRZC','ZCFZ-D',NULL),
('QM_LDZC_YSPJ','ZCFZ-F',NULL),
('QM_LDZC_YSZK','ZCFZ-G',NULL),
('QM_LDZC_YFZK','ZCFZ-H',NULL),
('QM_LDZC_YSLX','ZCFZ-L',NULL),
('QM_LDZC_YSGL','ZCFZ-M',NULL),
('QM_LDZC_QTYSK','ZCFZ-N',NULL),
('QM_LDZC_CH','ZCFZ-P',NULL),
('QM_HFWZYDSZC','ZCFZ-Q',NULL),
('QM_LDZC_YNNDQCQZQTZ','ZCFZ-R',''),
('QM_LDZC_QTLDZC','ZCFZ-S',NULL),
('QM_LDZC_HJ','ZCFZ-T',NULL),
('QM_FLDZC_KGCSJRZC','ZCFZ-V',NULL),
('QM_FLDZC_CYZDQTZ','ZCFZ-W',NULL),
('QM_FLDZC_CQYSK','ZCFZ-X',NULL),
('QM_FLDZC_CQGQTZ','ZCFZ-Y',NULL),
('QM_FLDZC_TZXFDC','ZCFZ-Z',NULL),
('QM_FLDZC_GDZC','ZCFZ-AA',NULL),
('QM_FLDZC_ZJGC','ZCFZ-AB',NULL),
('QM_FLDZC_GCWZ','ZCFZ-AC',NULL),
('QM_FLDZC_GDZCQL','ZCFZ-AD',NULL),
('QM_FLDZC_SCXSWZC','ZCFZ-AE',NULL),
('QM_FLDZC_YQZC','ZCFZ-AF',NULL),
('QM_FLDZC_WXZC','ZCFZ-AG',NULL),
('QM_FLDZC_KFZC','ZCFZ-AH',NULL),
('QM_FLDZC_SY','ZCFZ-AI',NULL),
('QM_FLDZC_CQDTFY','ZCFZ-AJ',NULL),
('QM_FLDZC_DYSDSZC','ZCFZ-AK',NULL),
('QM_FLDZC_QTFLDZC','ZCFZ-AL',NULL),
('QM_FLDZC_FLDZCHJ','ZCFZ-AM',NULL),
('QM_ZCZJ','ZCFZ-AN',NULL),
('QM_LDFZ_DQJK','ZCFZ-AO',NULL),
('QM_JYXJRFZ','ZCFZ-AS',NULL),
('QM_YSJRFZ','ZCFZ-AT',NULL),
('QM_LDFZ_YFPJ','ZCFZ-AU',NULL),
('QM_LDFZ_YFZK','ZCFZ-AV',NULL),
('QM_LDFZ_YSZK','ZCFZ-AW',NULL),
('QM_LDFZ_YFGZ','ZCFZ-AZ',NULL),
('QM_LDFZ_YJSJ','ZCFZ-BA',NULL),
('QM_LDFZ_YFLX','ZCFZ-BB',NULL),
('QM_LDFZ_YFGL','ZCFZ-BC',NULL),
('QM_LDFZ_QTYFK','ZCFZ-BD',NULL),
('QM_CYDSFZ','ZCFZ-BI',NULL),
('QM_LDFZ_YNNDQCQFZ','ZCFZ-BJ',NULL),
('QM_LDFZ_QTLDFZ','ZCFZ-BK',NULL),
('QM_LDFZ_LDFZHJ','ZCFZ-BL',NULL),
('QM_FLDFZ_CQJK','ZCFZ-BM',NULL),
('QM_FLDFZ_YFZQ','ZCFZ-BN',NULL),
('QM_YXG','ZCFZ-BO',NULL),
('QM_YXZ','ZCFZ-BP',NULL),
('QM_FLDFZ_CQYFK','ZCFZ-BQ',NULL),
('QM_FLDFZ_ZXYFK','ZCFZ-BS',NULL),
('QM_FLDFZ_YJFZ','ZCFZ-BT','QM_LDFZ_YJFZ'),
('QM_DYSY','ZCFZ-BU',NULL),
('QM_DYSX_DYSKHX','ZCFZ-BV',NULL),
('QM_FLDFZ_QTCQFZ','ZCFZ-BW',NULL),
('QM_FLDFZ_CQFZHJ','ZCFZ-BX',NULL),
('QM_DYSX_FZHJ','ZCFZ-BY',NULL),
('QM_GDQY_SSZB','ZCFZ-BZ',NULL),
('QM_QTQYGJ','ZCFZ-CA',NULL),
('QM_QZYXG','ZCFZ-CB',NULL),
('QM_ZCYXZ','ZCFZ-CC',NULL),
('QM_GDQY_ZBGJ','ZCFZ-CD',NULL),
('QM_GDQY_KCG','ZCFZ-CE','QM_ZBGJ'),
('QM_FLDZC_KFZC','ZCFZ-CF',NULL),
('QM_GDQY_YYGJ','ZCFZ-CH',NULL),
('QM_GDQY_WFPLR','ZCFZ-CJ',NULL),
('QM_GDQY_SYZQYHJ','ZCFZ-CM',NULL),
('QM_GDQY_FZHSYZQY','ZCFZ-CN',NULL),
('BY_YYSR','LR-B',NULL),
('BY_YYCB','LR-G',NULL),
('BY_ZYYWSJJFJ','LR-O',NULL),
('BY_XSFY','LR-P',NULL),
('BY_GLFY','LR-Q',NULL),
('BY_CWFY','LR-R',NULL),
('BY_ZCJZSS','LR-S',NULL),
('BY_GYJZBDSY','LR-T',NULL),
('BY_TZSY','LR-U',NULL),
('BY_DLYQYHHYQYDTZSY','LR-V',NULL),
('BN_ZCCZSY','LR-W',NULL),
('BN_QTSY','LR-X',NULL),
('BY_YYLR','LR-Y',NULL),
('BY_YYWSR','LR-Z',NULL),
('BY_YYWZC','LR-AB',NULL),
('BY_LRZE','LR-AD',NULL),
('BY_SDS','LR-AE',NULL),
('BY_JLR','LR-AF',NULL),
('BQ_JYHD_XSSPTGLWSDDXJ','XJLL-A',NULL),
('BQ_JYHD_SDDSFFH','XJLL-L',NULL),
('BQ_JYHD_SDDQTYGDXJ','XJLL-M',NULL),
('BQ_JYHD_XJLRXJ','XJLL-N',NULL),
('BQ_JYHD_GJZFDXJ','XJLL-O',NULL),
('BQ_JYHD_ZFGZGDXJ','XJLL-U',NULL),
('BQ_JYHD_ZFDGXSF','XJLL-V',NULL),
('BQ_JYHD_ZFDQTDXJ','XJLL-W',NULL),
('BQ_JYHD_XJLCXJ','XJLL-X',NULL),
('BQ_JYHD_JYHDCSDJE','XJLL-Y',NULL),
('BQ_TZHD_SHTZSSDXJ','XJLL-AA',NULL),
('BQ_TZHD_QDSYSSDXJ','XJLL-AB',NULL),
('BQ_TZHD_CZWXHQTSHDXJJE','XJLL-AC',NULL),
('BQ_TZHD_CZZGSJQTZFDXJJE','XJLL-AD',NULL),
('BQ_TZHD_SDDQTYGDXJ','XJLL-AE',NULL),
('BQ_TZHD_XJLRXJ','XJLL-AF',NULL),
('BQ_TZHD_GJGDWXHQTZFDXJ','XJLL-AG',NULL),
('BQ_TZHD_TZSZFDXJ','XJLL-AH',NULL),
('BQ_TZHD_QDZGSJQTZFDXJJE','XJLL-AJ',NULL),
('BQ_TZHD_ZFQTDXJ','XJLL-AK',NULL),
('BQ_TZHD_XJLCXJ','XJLL-AL',NULL),
('BQ_TZHD_TZHDSCSDXJLLJE','XJLL-AM',NULL),
('BQ_CZHD_XSTZSSDDXJ','XJLL-AO',NULL),
('BQ_CZHD_JKSSDDXJ','XJLL-AQ',NULL),
('BQ_CZHD_SDQTYGDXJ','XJLL-AS',NULL),
('BQ_CZHD_XJLRXJ','XJLL-AT',NULL),
('BQ_CZHD_CHZWSZFDXJ','XJLL-AU',NULL),
('BQ_CZHD_FPGLSZFDXJ','XJLL-AV',NULL),
('BQ_CZHD_ZFQTYGDXJ','XJLL-AX',NULL),
('BQ_CZHD_XJLCXJ','XJLL-AY',NULL),
('BQ_CZHD_CZHDCSDXJLLJE','XJLL-AZ',NULL),
('BQ_CZHD_HLBDXJDYX','XJLL-BA',NULL),
('BQ_XJJXJDJWJZJE','XJLL-BB',NULL),
('BQ_QCXJJXJDJWYE','XJLL-BC',NULL),
('BQ_QMXJJXJDJWYE','XJLL-BD',NULL),
('BY_ZYYWSR','LR-A',NULL),
('BY_YYZCB','LR-F',NULL),
('QM_YSJRZC','ZCFZ-E',NULL);

/*Table structure for table `t_kmye` */

DROP TABLE IF EXISTS `t_kmye`;

CREATE TABLE `t_kmye` (
  `ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IMP_USER` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `BATCH_ID` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJMOTH` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `KJYEAR_MOTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `SUBJECT_CODE` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `SUBJECT_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `HBZL` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `QCJFYE` decimal(16,2) DEFAULT '0.00',
  `QCDFYE` decimal(16,2) DEFAULT '0.00',
  `BQJFFSE` decimal(16,2) DEFAULT '0.00',
  `BQDFFSE` decimal(16,2) DEFAULT '0.00',
  `BNJFLJ` decimal(16,2) DEFAULT '0.00',
  `BNDFLJ` decimal(16,2) DEFAULT '0.00',
  `QMJFYE` decimal(16,2) DEFAULT '0.00',
  `QMDFYE` decimal(16,2) DEFAULT '0.00',
  `ZTZB` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '',
  `FX` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_port_type` bigint DEFAULT NULL,
  `bj` bigint DEFAULT '0',
  `FORMAT_FLAG` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_kmye` */

/*Table structure for table `t_message_info` */

DROP TABLE IF EXISTS `t_message_info`;

CREATE TABLE `t_message_info` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `ARRY_QUE` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `TITLE` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONTENT` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `VIEW_NUM` decimal(10,0) DEFAULT NULL,
  `AUTHOR` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `UP_DATE` date DEFAULT NULL,
  `UP_PERSON` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `UP_PERSON_TEL` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CREATE_USER` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATE_USER` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CLZZ` int DEFAULT '0' COMMENT '类型0每日资讯，1定制资讯',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_message_info` */

/*Table structure for table `t_mode` */

DROP TABLE IF EXISTS `t_mode`;

CREATE TABLE `t_mode` (
  `ID` bigint NOT NULL AUTO_INCREMENT COMMENT '住建自动增长',
  `REPORT_TYPE` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `REPORT_CONTEN` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '类型说明',
  `MODE_CONDITION` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `MODE_CONTENT` varchar(6000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `MODE_VALUES` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注说明',
  `REMARK` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `MODE_AREA` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONDITION_VALUES` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `PX` int DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3824 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_mode` */

insert  into `t_mode`(`ID`,`REPORT_TYPE`,`REPORT_CONTEN`,`MODE_CONDITION`,`MODE_CONTENT`,`MODE_VALUES`,`REMARK`,`MODE_AREA`,`CONDITION_VALUES`,`PX`) values 
(4,'2','利润表-xx模块-xx功能','LR_Q >= 500000','模板测试，利润表管理费用：{LR_Q}，管理费用+财务费用：{LR_Q+LR_R}','{LR_Q},{LR_Q+LR_R}','2代表报表类型中的利润表，这个应该是可以选择的，\r\n还有一个MODE_AREA字段未维护，该字段用来表示该模板放置的位置','1','该字段可以不用',4),
(12,'1','应收利息增加','ZCFZ_L-ZCFZ_L1>0','由于应收利息为购买债券的到期应收未收利息，因此，针对应收利息的增加，建议管理层需结合货币资金中的资金预警考虑，是否存在过度投资，导致现金不足的情况。建议针对债券进行专人专管，检查是否按要求设立备查薄，方便管理。同时，建议管理层使用本系统的在线咨询模块中的顾问咨询，由专业顾问提供针对性分析及建议。','','','10001','',12),
(13,'1','应收利息减少','ZCFZ_L - ZCFZ_L1 < 0','应收利息的减少，建议管理层结合债券的购买及到期情况做判断，如减少由债券购买的减少导致，或者因债券到期所导致，均属于正常情况，如出现相反趋势，建议管理层对其进行查询。建议针对债券进行专人专管，检查是否按要求设立备查薄，方便管理。可使用本系统在线咨询模块中的专项咨询服务，为企业设立完善的管理控制流程，提高管理效率。','','','10001','',13),
(15,'1','应收股利增加','ZCFZ_M-ZCFZ_M1>0','应收股利增加，建议结合长期股权投资、可供出售金融资产等科目情况，关注是否与股权投资收益情况相符，同时需关注后期股利资金发放。','','','10002','',15),
(16,'1','应收股利减少','ZCFZ_M - ZCFZ_M1< 0','应收股利减少，建议结合长期股权投资、可供出售金融资产等科目情况，关注是否与股权投资收益情况或处置股权资产相符。若因资产处置，则需重点关注处置原因、必要性及结果，以防不利于企业利益的情形出现。','','','10002','',16),
(17,'1','以公允价值计量且其变动计入当期损益的金融资产在期末增加','ZCFZ_D-ZCFZ_D1>0','由于以公允价值计量且其变动计入当期损益的金融资产核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的增加提请管理层关注进行该资产交易的原因以及其增减值情况，注重风险控制。','','','10003','',17),
(18,'1','以公允价值计量且其变动计入当期损益的金融资产在期末减少','ZCFZ_D - ZCFZ_D1< 0','由于以公允价值计量且其变动计入当期损益的金融资产核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的减少提请管理层考虑是有因减值还是资产处置导致期末值减少。若为减值造成，则需重点注意该资产的价值变动，注意风险控制。若为资产处置造成，则提醒管理层关注处置的原因、必要性及结果，以防做出不利于企业利益的行为。','','','10003','',18),
(19,'1','一年内到期的非流动资产在期末增加','ZCFZ_R - ZCFZ_R1 > 0','一年内到期的非流动资产增加，仍需持续关注该资产的回收可能性。此外，管理层需结合资金情况及资金预警，做好未来的资金投资规划，避免资金闲置或紧张情况的出现。','','','10004','',19),
(21,'1','其他流动资产较上期浮动>=20%','ZCFZ_S==0&&ZCFZ_S1!=0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10005','',21),
(22,'1','其他流动资产较上期浮动<20%','-0.2 < (ZCFZ_S-ZCFZ_S1)/ZCFZ_S1 && (ZCFZ_S-ZCFZ_S1)/ZCFZ_S1 < 0.2','无预警。','','','10005','',22),
(23,'1','持有待售的资产增加','ZCFZ_Q1!=0 && ZCFZ_Q - ZCFZ_Q1 > 0','由于该科目核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的增加提请管理层关注进行该资产交易的原因以及其增减值情况，注重风险控制。','','','10006','',23),
(24,'1','持有待售的资产减少','ZCFZ_Q1!=0 && ZCFZ_Q - ZCFZ_Q1 < 0','由于该科目核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的减少提请管理层考虑是有因减值还是资产处置导致期末值减少。若为减值造成，则需重点注意该资产的价值变动，注意风险控制。若为资产处置造成，则提醒管理层关注处置的原因、必要性及结果，以防做出不利于企业利益的行为。','','','10006','',24),
(25,'1','可供出售金融资产增加','ZCFZ_V > ZCFZ_V1','由于可供出售金融资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上期有所增加，需查找原因并关注已实现的增值额，同时需注意核算时点、计量金额是否会计准则要求。且需警惕因期末可供出售金融资产市场价值变动产生的增值，存在变现的不确定性。','','','10007','',25),
(26,'1','可供出售金融资产减少','ZCFZ_V < ZCFZ_V1','由于可供出售金融资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末改科目余额比上期有所减少，需查找原因并关注已实现的减值额，且需警惕可供出售金融资产市场价值变动产生的损失，存在不确定性。同时，若存在处置该资产的情形，则需注意处置的原因、必要性及结果，以防不利于企业利益的行为发生。','','','10007','',26),
(27,'1','持有至到期投资增加','ZCFZ_W > ZCFZ_W1','建议管理层了解该科目的资产类别，如为理财类投资支出的增加引起，需考虑闲置资金较多，建议合理规划资金使用及流转速度，避免资金闲置引起的浪费。同时需注意核算时点、计量金额是否符合会计准则要求。','','','10008','',27),
(28,'1','持有至到期投资减少','ZCFZ_W < ZCFZ_W1','建议管理层了解该科目的资产类别，关注其减少的原因。同时，需考虑是否存在运营资金不充足而出售长期股权投资的情形，建议管理层合理规划资金使用及流转速度，避免资金不足影响生产经营。同时需注意核算时点、计量金额是否会计准则要求。','','','10008','',28),
(29,'1','固定资产增加','ZCFZ_AA- ZCFZ_AA1>0','固定资产有所增加，管理层应注意关注固定资产的转固时间及条件是否符合会计准则的要求，是否需要进行账务调整。另外，本期投入大量固定资产，建议管理层结合相关资产的付款期限考虑后期付款资金的充足性。','','','10009','',29),
(30,'1','固定资产减少','ZCFZ_AA-ZCFZ_AA1>0','固定资产有所减少，管理层需注意区分是因资产处置还是折旧年限已到期。若为资产处置，需关注处置的原因、必要性及所得情况；若为资产折旧年限已到期，则需注意是否有重要设备折旧年限已到期，需提前准备新设备的采购或对旧设备进一步维护维修，确保生产正产运作。','','','10009','',30),
(31,'1','在建工程增加','ZCFZ_AB > ZCFZ_AB1','在建工程的增加，需考虑在未来几年对工程需投入的资金，考虑未来期间对现金流可能产生的压力。',NULL,NULL,'10010',NULL,31),
(32,'1','在建工程减少','ZCFZ_AB < ZCFZ_AB1','在建工程的减少，需注意区分是转入固定资产还是资产处置原因。若为转入固定资产，则需关注转入的时点、条件以及计量金额是否符合会计准则的要求，确保账务核算准确；若为资产处置原因，则需关注处置的原因、必要性以及所得情况。','','','10010','',32),
(33,'1','长期应收款增加','ZCFZ_X-ZCFZ_X1>0','本期长期应收款较上期末有所增加，考虑是否存在期末大量发生融资租赁的情况而导致长期应收款的增加。由于融资租赁的特殊性，建议管理层对该部分资产进行专人管理，设立专门的登记薄记录相关情况，同时，考虑融资租赁业务对整个企业业务及收益的影响。','','','10011','',33),
(34,'1','长期应收款减少','ZCFZ_X-ZCFZ_X1<0','长期应收款在期末有所减少，考虑是因为资金回笼亦或是公司融资租赁业务的缩减。若因业务缩减引起长期应收款的期末减少，建议管理层联合市场部等相关部门，评判融资租赁业务对企业总体收益的影响，从而对融资租赁业务的发展做出合理规划。','','','10011','',34),
(35,'1','长期股权投资增加','ZCFZ_Y-ZCFZ_Y1>0','由于长期股权投资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上期有所增加，需查找原因，同时需注意核算时点、计量金额是否会计准则要求。注意按收益法核算的长期股权投资在期末根据被投资企业的经营结果调整长期股权投资的账面价值。同时，需关注按成本法核算的长期股权投资是否存在减值情况。此外，如果长期股权投资金额的增加是因为债务重组或非货币性资产交换获得，建议考虑评估该部分资产未来可能产生的收益，以及对企业利润的影响。','','','10012','',35),
(36,'1','长期股权投资减少','ZCFZ_Y-ZCFZ_Y1<0','由于长期股权投资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上期有所减少，需查找原因并关注已实现的减值额，同时需注意核算时点、计量金额等是否会计准则要求。注意按收益法核算的长期股权投资在期末根据被投资企业的经营结果调整长期股权投资的账面价值。同时，需关注按成本法核算的长期股权投资是否存在减值情况以及是否存在大量处置该资产情况，若存在处置资产情况，则需关注处置的原因、必要性及结果，以防不利于企业利益的情况发生。','','','10012','',36),
(37,'1','投资性房地产增加','ZCFZ_Z-ZCFZ_Z1>0','由于投资性房地产核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上期有所增加，需查找原因并关注已实现的增值额，同时需注意核算时点、计量金额是否会计准则要求。且需警惕因期末投资性房地产市场价值变动产生的增值，存在变现的不确定性。另外，建议管理层考虑目前房地产产业发展的减缓趋势，结合国家对房地产业的宏观政策，评判投资性房地产在企业利润中所占的份额，考虑是否需要调整对投资性房地产的投入。','','','10013','',37),
(38,'1','投资性房地产减少','ZCFZ_Z-ZCFZ_Z1<0','由于投资性房地产核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上期有所减少，需查找原因并关注已实现的减值额，同时需注意核算时点、计量金额是否会计准则要求。同时，需关注是否存在大量处置该资产情况，若存在处置资产情况，则需关注处置的原因、必要性及结果，以防不利于企业利益的情况发生。','','','10013','',38),
(39,'1','工程物资增加','ZCFZ_AC-ZCFZ_AC1>0','期末该科目余额比上期有所增加，需查找原因，关注与在建工程的关联关系。此外，管理层需考虑工程进度对工程物资的采购的影响，合理规划，避免工程物资的囤积，同时对采购工程物资需投入的资金进行合理规划，避免出现资金紧张的情况。','','','10014','',39),
(40,'1','工程物资减少','ZCFZ_AC-ZCFZ_AC1<0','期末该科目余额比上期有所减少，需查找原因，关注与在建工程的关联关系。同时，由于工程物资的特殊性，建议管理层关注。','','','10014','',40),
(41,'1','固定资产清理增加','ZCFZ_AD > ZCFZ_AD1','固定资产清理有所增加，需关注清理固定资产的原因及必要性，并预估清理所得及对企业造成的损失。同时，管理层需考虑是否需要投入资金重置相关固定资产以对清理资产进行置换，如需，则建议结合货币资金中的资金预测，分析对未来现金流的影响程度，合理规划资金使用及购置计划，避免资金紧张的情况出现。','','','10015','',41),
(42,'1','固定资产清理减少','ZCFZ_AD < ZCFZ_AD1','固定资产清理有所减少，建议管理层评估已清理的固定资产的所得。此外，鉴于固定资产清理科目的性质，建议管理层评估该科目波动的合理性。','','','10015','',42),
(43,'1','无形资产增加','ZCFZ_AG-ZCFZ_AG1>0','无形资产有所增加，应考虑是属于自主开发亦或购买形成，若为自主开发，应注意关注无形资产的确认时间及条件是否符合会计准则的要求，是否需要进行账务调整。同时，需持续关注无形资产对生产运营所带来的效益情况，注意重要技术的排他性和保密性。','','','10016','',43),
(44,'1','无形资产减少','ZCFZ_AG-ZCFZ_AG1<0','无形资产有所减少，需考虑是由于摊销导致的正常减少，亦或因为处置或减值造成。若因处置导致，需关注处置的原因、必要性和所得；若因减值导致，建议管理层评估因技术落后可能给企业未来运营及发展带来的风险，考虑是否需要重新投入研发，如需投入研发新技术，则需考虑研发支出对未来现金流的需求以及影响，合理规划。','','','10016','',44),
(45,'1','开发支出增加','ZCFZ_AH-ZCFZ_AH1>0','开发支出有所增加，应注意关注开发支出的确认时间及条件是否符合会计准则的要求，并相应进行账务调整。建议管理层就开发支出是否可以资本化的问题使用在线顾问模块中的企业顾问功能，咨询专业顾问具体支出的性质，达到企业利益最大化。','','','10017','',45),
(46,'1','开发支出减少','ZCFZ_AH-ZCFZ_AH1<0','开发支出有所减少，需考虑是由于转入无形资产、处置还是减值造成。若为处置情况，需关注处置的原因、必要性和所得；若为减值情况，建议管理层需重视企业的技术创新，评估技术风险。','','','10017','',46),
(47,'1','商誉增加','ZCFZ_AI-ZCFZ_AI1>0','商誉的增加，往往出现在资产并购情况中，需重点关注事项发生的全过程，注意商誉变动的原因，并合理判断商誉计量金额的准确性。','','','10018','',47),
(48,'1','商誉减少','ZCFZ_AI-ZCFZ_AI1<0','商誉的减少，需考虑是由于资产处置还是资产减值造成，若为资产处置，需关注处置事项的原因及、必要性及所得；若为资产减值，则需查明减值原因，并防范该减值所带来的不利影响。','','','10018','',48),
(49,'1','长期待摊费用增加','ZCFZ_AJ - ZCFZ_AJ1 > 0','长期待摊费用有所增加，需查明原因，并注意区分待摊费用和直接费用化情形，确保核算符合会计准则。','','','10019','',49),
(50,'1','长期待摊费用减少','ZCFZ_AJ-ZCFZ_AJ1<0','长期待摊费用有所减少，需查明原因，考虑是否因正常摊销引起，若非，则需关注减少原因。','','','10019','',50),
(51,'1','递延所得税资产增加','ZCFZ_AK-ZCFZ_AK1>0','递延所得税资产的产生，是因为资产的账面价值大于计税基础，或负债的账面价值小于计税基础，导致会计确认的所得税小于税法确认的所得税，从而产生递延所得税资产。递延所得税资产增加，需关注其确认条件、计量金额是否符合会计准则。建议管理层使用在线顾问模块中的专项顾问功能，为企业进行整体税收筹划，进行合理避税，减少企业利润不必要的损耗。同时，建议管理层检查是否已按要求设立备查薄。','','','10020','',51),
(52,'1','递延所得税资产减少','ZCFZ_AK-ZCFZ_AK1<0','递延所得税资产的产生，是因为资产的账面价值大于计税基础，或负债的账面价值小于计税基础，导致会计确认的所得税小于税法确认的所得税，从而产生递延所得税资产。递延所得税资产减少，需关注其确认条件、计量金额是否符合会计准则。建议管理层使用在线顾问模块中的专项顾问功能，为企业进行整体税收筹划，进行合理避税，减少企业利润不必要的损耗。同时，建议管理层检查是否已按要求设立备查薄。','','','10020','',52),
(53,'1','其他非流动资产余额较上期浮动>=20%','ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1-0.2>0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10021','',53),
(54,'1','应收票据变动','ZCFZ_F != ZCFZ_F1','企业应根据汇票的种类及规定及时行使提示承兑、提示付款等权利。否则，汇票未按照规定期限提示承兑的，持票人丧失对其前手的追索权；持票人超过提示付款期限提示付款的，持票人开户银行不予受理，此时企业需通过其他方式或途径追偿其应收款项。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10022','',54),
(55,'1','短期借款增加','ZCFZ_AO-ZCFZ_AO1>0','短期借款的增加，说明企业现金流较为紧张，需要通过银行贷款缓解资金压力，建议合理规划资金使用情况，同时，查看应收账款的情况，对应收账款进行催收，亦可与供应商进行谈判，延长付款期，缓解资金压力。','','','10023','',55),
(56,'1','短期借款减少','ZCFZ_AO-ZCFZ_AO1<0','短期借款有所减少，考虑该借款是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，合理规划资金安排，控制资金压力。','','','10023','',56),
(57,'1','应付票据变动','ZCFZ_AU-ZCFZ_AU1>0','由于银行承兑汇票的付款期限最长为6个月，因此，使用票据实际上对企业来说可实现短期融资的目的，在短期现金流较为紧张的情况下，可考虑采取使用开具应付票据的方式减轻企业现金负担。然而，需注意以下可能产生的问题及风险：应付商业票据是购买企业在正常商业活动中向供应商承诺在将来特定时日、支付一笔固定货款的票据。与应付账款相比，应付商业票据由于提出了付款的书面承诺，因而更具有法律上的约束力。此外，企业应于汇票到期前将票款足额交存其开户银行，以免银行对企业进行计收利息及引起相关法律诉讼纠纷。同时建议管理层检查是否按要求设立备查薄，方便管理。','','','10024','',57),
(58,'1','一年内到期的非流动负债增加','ZCFZ_BJ-ZCFZ_BJ1>0','由于一年内到期的非流动负债主要为从长期借款转入的负债，长期借款即将到期，需考虑是否需要对长期借款进行续借或新借。建议分析未来5年资金需求，合理规划贷款金额。同时，如需新增长期借款，需考虑企业固定资产等是否有足够的抵押物进行抵押借款，或是否有足够的资信可进行其他类型的贷款。','','','10025','',58),
(59,'1','一年内到期的非流动负债减少','ZCFZ_BJ-ZCFZ_BJ1<0','由于一年内到期的非流动负债主要为一年内到期的长期借款等，对于企业来说，由于之前的资金需求产生的贷款在近期内需进行偿还，因此需分析资金状况在未来一年内是否可以满足其偿还需求。若资金紧张，则需考虑通过借款、延长支付期限等方式缓解资金压力。','','','10025','',59),
(60,'1','应付职工薪酬增加','ZCFZ_AZ- ZCFZ_AZ1>0','应付职工薪酬增加，考虑是否因正常人员增加所引起的。若员工大量增加，需关注企业的人工成本、人工效率。同时，若计划进行资本运作，则还需关注员工五险一金的缴纳是否按照相关规定执行，否则可能面临被主管单位要求补缴和处罚的情形。','','','10026','',60),
(61,'1','应付职工薪酬减少','ZCFZ_AZ-ZCFZ_AZ1<0','应付职工薪酬减少，考虑是否因正常人员减少引起的。若员工大量减少，需关注核心技术人员是否离职，人员减少后是否会对企业运营产生影响，需注意企业生产运营的稳定性。同时，若计划进行资本运作，则还需关注员工五险一金的缴纳是否按照相关规定执行，可能面临被主管单位要求补缴和处罚的情形。','','','10026','',61),
(62,'1','应交税费增加','ZCFZ_BA>ZCFZ_BA1','应交税费的有所增加，主要考虑是否因业务的增长造成。若与业务不匹配，则考虑是否存在税收政策变化等特殊情况。建议使用本系统顾问咨询中的专项咨询，由专业顾问为企业进行税收筹划，达到合理避税，利润最大化的目的。','','','10027','',62),
(63,'1','应交税费减少','ZCFZ_BA<ZCFZ_BA1','应交税费的有所减少，主要考虑是否因业务的减少造成。若与业务不匹配，则考虑是否存在税收政策变化等特殊情况。建议使用本系统顾问咨询中的专项咨询，由专业顾问为企业进行税收筹划，达到合理避税，利润最大化的目的。','','','10027','',63),
(64,'1','应付利息变动','ZCFZ_BB != ZCFZ_BB1','针对应付利息，提请管理层关注以下方面的问题：1、需查看借款合同，核查应付利息的确认时间和计量金额是否符合会计准则；2、关注付款期限及已支付金额，考虑自身资金压力；3、关注逾期未支付的违约责任及违约时间点。',NULL,NULL,'10028',NULL,64),
(65,'1','应付股利变动','ZCFZ_BC-ZCFZ_BC1>0','关注该科目的变动是否与企业宣告派发的股利相符合，同时需考虑支付能力，结合企业未来的生产经营计划关注资金压力问题。','','','10029','',65),
(66,'1','其他流动负债浮动超过20%','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1-0.2>0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10030','',66),
(67,'1','长期借款增加','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1>0','长期借款的增加，需关注未来还本付息对现金流的影响，除此之外，建议管理层整理贷款明细表对贷款情况进行归纳统计，关注合同中对贷款使用的限定，并安排专人负责对资金使用情况等进行追踪，规避因违规使用资金可能产生的风险。','','','10031','',67),
(68,'1','长期借款减少','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1<0','长期借款的减少，考虑该借款是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','','','10031','',68),
(69,'1','应付债券增加','ZCFZ_BN-ZCFZ_BN1>0','应付债券的增加，需关注未来还本付息对现金流的影响以及如未能按期支付利息或本金可能产生的法律风险。除此之外，提请管理层关注债券的募集说明书中赋予投资者的权利，避免因投资者根据募集说明书行使权利时双方可能产生的分歧。另外，建议管理层对债券设专人管理及专门的登记本，记录债券相关情况。','','','10032','',69),
(70,'1','应付债券减少','ZCFZ_BN-ZCFZ_BN1<0','应付债券的减少，考虑该债券是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','','','10032','',70),
(71,'1','长期应付款变动','ZCFZ_BQ1!=0&&ZCFZ_BQ-ZCFZ_BQ1>0','由于一般性经营较少使用此科目，建议管理层查看此科目核算的内容，关注发生的原因及合理性，看是否存在因记账错误导致的余额变动。如非上述原因，则需根据科目核算的性质，考虑未来分期付款或融资租赁时支付款项对现金流的影响。','','','10033','',71),
(73,'1','递延所得税负债增加','ZCFZ_BV-ZCFZ_BV1>0','递延所得税负债的产生，是因为资产的账面价值小于计税基础，或负债的账面价值大于计税基础而，导致会计确认的所得税大于税法确认的所得税，从而产生递延所得税负债。递延所得税负债有所增加，需关注其确认条件、计量金额是否符合会计准则。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10036','',73),
(74,'1','递延所得税负债减少','ZCFZ_BV < ZCFZ_BV1','递延所得税负债的产生，是因为资产的账面价值小于计税基础，或负债的账面价值大于计税基础而，导致会计确认的所得税大于税法确认的所得税，从而产生递延所得税负债。递延所得税负债有所减少，需关注其确认条件、计量金额是否符合会计准则。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10036','',74),
(75,'1','其他非流动负债浮动超过20%','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1-0.2>0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。','','','10037','',75),
(76,'1','递延收益增加','ZCFZ_BU-ZCFZ_BU1>0','递延收益的增加，需关注增加的原因及递延收益确认的条件是否合规。若为政府补贴产生的递延收益，则建议管理层重点关注补贴收入实现的相关条件，确保项目的开展符合政府相关规定。','','','10038','',76),
(77,'1','递延收益减少','ZCFZ_BU-ZCFZ_BU1<0','递延收益的减少，需关注减少的原因及转入收益的条件是否合规。特别是政府补贴产生的递延收益，管理层需重点关注补贴收入实现的相关条件，确保项目的开展符合政府相关规定。','','','10038','',77),
(78,'1','长期应付职工薪酬增加','ZCFZ_BR > ZCFZ_BR1','长期应付职工薪酬大幅度增加，管理层应关注其增长的原因。若是因现金流不足而长时间无法支付职工工资薪酬，则企业需努力扩大生产、节约成本及多渠道融资，开源节流渡过难关。若是因劳务纠纷而存在长期应付款增长，则建议管理层关注劳务纠纷的原因及法律后果。',NULL,NULL,'10039',NULL,78),
(79,'1','长期应付职工薪酬减少','ZCFZ_BR < ZCFZ_BR1','长期应付职工薪酬大幅度减少，若是因企业支付员工薪酬所导致，则需关注企业目前的资金流状况，以防出现资金流不足的情况。若是因劳务纠纷已解决，则需关注纠纷解决的过程及带来的法律后果。',NULL,NULL,'10039',NULL,79),
(80,'1','实收资本增加','ZCFZ_BZ-ZCFZ_BZ1>0','实收资本增加，需核查新增股东的股权比例、新增资金到位以及工商变更情况。若为资本公积转增实收资本，则需同税局确认是否需缴纳所得税，规避税务风险。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10040','',80),
(81,'1','实收资本减少','ZCFZ_BZ-ZCFZ_BZ1<0','实收资本减少，需注意是否已经全体债权人同意，确保减资程序合规。同时，关注实收资本的减少是否导致现金流的支出，注意企业的资金情况。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10040','',81),
(82,'1','资本公积增加','ZCFZ_CD-ZCFZ_CD1>0','资本公积增加，需核查新增股东的股权比例、新增资金到位以及工商变更情况。若为盈余公积转增实收资本，则需同税局确认是否需缴纳所得税，规避税务风险。','','','10041','',82),
(83,'1','资本公积减少','ZCFZ_CD-ZCFZ_CD1<0','资本公积减少，需考虑是否存在资本公积转入实收资本或进行股份制改革的情况，并同税局确认是否资本公积转实收资本或进行股改时股东是否需缴纳所得税，从而规避漏税风险。','','','10041','',83),
(84,'1','盈余公积增加','ZCFZ_CH > ZCFZ_CH1','盈余公积增加，需注意是否同净利润增加相符。',NULL,NULL,'10042',NULL,84),
(85,'1','盈余公积减少','ZCFZ_CH < ZCFZ_CH1','盈余公积减少，需考虑是否存在盈余公积转入实收资本或资本公积或进行股份制改革的情况，并同税局确认盈余公积转资本公积或实收资本或进行股改时股东是否需缴纳所得税，从而规避漏税风险',NULL,NULL,'10042',NULL,85),
(86,'1','未分配利润增加','ZCFZ_CJ-ZCFZ_CJ1>0','未分配利润增加，需注意是否同本期净利润相符。','','','10043','',86),
(87,'1','未分配利润减少','ZCFZ_CJ-ZCFZ_CJ1<0','未分配利润减少，需注意是否同本期净利润变动相符以及是否宣告分派了利润。同时，需考虑是否存在将未分配利润转入实收资本或资本公积或进行股份制改革的情况，需同税局确认未分配利润转实收资本或资本公积或进行股份制改革时股东是否需缴纳所得税，从而规避漏税风险。','','','10043','',87),
(91,'3','现金流量预警2.2','XJLL_Y > 0 && XJLL_AM>0 && XJLL_AZ < 0 && XJLL_BB > 0 &&XJLL_Y- XJLL_AM>0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',91),
(93,'3','现金流量预警模板4','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ < 0 && XJLL_BB > 0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',93),
(94,'3','现金流量预警3.1','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB > 0 && XJLL_Y-XJLL_AZ<0','尽管本期经营活动产生的现金流量净额为正数，但其金额小于筹资活动产生的现金流量净额，说明企业本期现金流主要由筹资活动支撑，建议管理层考虑后续还本付息对现金流的影响。除此以外，建议管理层改善经营活动现金流，考虑以下措施：1)对库存商品进行促销，增加收入，改善现金流入；2)加快应收款的催收，加速现金回笼；3)对成本及费用进行严格控制，减少不必要开支，从而做到开源节流。另外，投资活动产生的现金流量净额为负数，证明企业本期有大量的购置固定资产或投资性资金流出，建议管理层做投资回报的测算，查看是否达到预期，同时，如筹资活动的资金借入主要为支撑投资活动的支出而发生，建议评估两者的流入流出，考虑是否不必要的投资活动需要进行缩减。','','','300001','',94),
(95,'3','现金流量预警3.2','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB > 0 && XJLL_Y - XJLL_AZ>0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',95),
(96,'3','现金流量预警5','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ > 0 && XJLL_BB > 0','由于经营活动产生的现金流量净额为负数，但最终的现金及现金等价物净增加额为正数，说明企业的现金流实际上是依靠投资及筹资活动产生，并非健康的现金流状况。建议管理层做好现金流管理，查看经营活动现金流为负数的主要原因。','','','300001','',96),
(97,'3','现金流量预警6','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB > 0','由于经营活动和筹资活动产生的现金流量净额为负数，但最终的现金及现金等价物净增加额为正数，说明企业的现金流实际上是依靠投资活动产生，并非健康的现金流状况。建议管理层做好现金流管理，查看经营活动现金流为负数的主要原因。','','','300001','',97),
(98,'3','现金流量预警7','XJLL_Y < 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB > 0','由于经营活动及投资活动产生的现金流量净额均为负数，而最终的现金及现金等价物净增加额为正数，因此，企业本期的现金流由筹资活动支撑。建议管理层评估后续还本付息对现金流产生的压力，同时，需考虑如何改善现金流状况。如：加强市场开拓获取经营现金流入、加快销售款的回收并延长采购款的支付期限、延长借款期限缓解前期还本付息压力或引入新投资款用以偿还有息借款。','','','300001','',98),
(99,'3','现金流量预警8','XJLL_Y > 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB < 0','本期企业大量归还筹资活动借入的款项，导致总体现金及现金等价物净增加额为负数，建议管理层查看未来是否仍存在大量的归还筹资活动款项的支出，考虑对现金流的影响，避免资金链出现问题。','','','300001','',99),
(100,'3','现金流量预警9','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB < 0','本期现金及现金等价物净增加额为负数，主要是由于投资活动的大量现金流出引起。建议管理层查看投资活动的必需性，削减不必要的投资，同时，考虑投资回报率，进行投资测算，对投资款项的支出进行严格监控。对于使用贷款进行的投资活动，需考虑贷款合同对贷款用途的限定，查看是否存在违规使用贷款的情况。','','','300001','',100),
(101,'3','现金流量预警10','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ < 0 && XJLL_BB < 0','最终现金及现金等价物净增加额为负数说明经营活动产生的现金流不足以支撑投资及筹资活动所需要资金。建议管理层查看投资活动的必需性，削减不必要的投资，同时，考虑投资回报率，进行投资测算，对投资款项的支出进行严格监控。而且争取延长借款期限，缓解前期还本付息压力，或查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',101),
(102,'3','现金流量预警11','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ > 0 && XJLL_BB < 0','本期现金及现金等价物净增加额为负数，管理层需高度警惕，预防现金流不足对未来经营肯可能产生的影响。经营活动产生的现金流量净额为负数，反映企业经营不善，对未来进行贷款及信用评级等均有可能受到影响。','','','300001','',102),
(103,'3','现金流量预警12','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB < 0','经营活动和筹资活动产生的现金流出大于投资活动产生的现金流入，且投资活动的现金流入不具有可持续性，因此，建议管理层做好现金流管理，考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）延长还款期限或进行贷款置换，缓解前期还本付息压力。','','','300001','',103),
(104,'3','现金流量预警13','XJLL_Y < 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB < 0','现金及现金等价物净增加额为负数，主要是由于经营活动和投资活动现金流量净额为负数造成，企业现金流状况较差，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力。','','','300001','',104),
(105,'3','现金流量预警14','XJLL_Y < 0 && XJLL_AM < 0 && XJLL_AZ < 0 && XJLL_BB < 0','由于经营活动、投资活动及筹资活动产生的现金流量净额均为负数，企业现金流状况十分差，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',105),
(106,'3','现金流量预警15','XJLL_Y > 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB == 0','即使经营活动现金流量净额为正且投资回收，但因大量归还筹资活动借入的款项，导致总体现金及现金等价物净增加额为0，建议管理层查看未来是否仍存在大量的归还筹资活动款项的支出，考虑对现金流的影响，避免资金链出现问题。','','','300001','',106),
(107,'3','现金流量预警16','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB == 0','即使经营活动现金流量净额为正且通过筹资获取资金，但本期现金及现金等价物净增加额仍不增不减，主要是由于投资活动的大量现金流出引起。建议管理层查看投资活动的必需性，削减不必要的投资，同时，考虑投资回报率，进行投资测算，对投资款项的支出进行严格监控。对于使用贷款进行的投资活动，需考虑贷款合同对贷款用途的限定，查看是否存在违规使用贷款的情况。','','','300001','',107),
(108,'3','现金流量预警17','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ < 0 && XJLL_BB == 0','最终现金及现金等价物净增加额为0说明经营活动产生的现金流刚好支撑投资及筹资活动所需要资金。建议管理层查看投资活动的必需性，削减不必要的投资，同时，考虑投资回报率，进行投资测算，对投资款项的支出进行严格监控。而且争取延长借款期限，缓解前期还本付息压力，或查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',108),
(109,'3','现金流量预警18','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ > 0 && XJLL_BB == 0','即使投资活动与融资活动产生了正现金流，但本期现金及现金等价物净增加额仍为0，因此管理层需高度警惕，预防现金流不足对未来经营肯可能产生的影响。经营活动产生的现金流量净额为负数，反映企业经营不善，对未来进行贷款及信用评级等均有可能受到影响。','','','300001','',109),
(110,'3','现金流量预警19','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB == 0','经营活动和筹资活动产生的现金流出刚好等于投资活动产生的现金流入，且投资活动的现金流入不具有可持续性，因此，建议管理层做好现金流管理，考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）延长还款期限或进行贷款置换，缓解前期还本付息压力。','','','300001','',110),
(113,'3','现金流量预警20','XJLL_Y < 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB == 0','虽然融资额为正数，但现金及现金等价物净增加额不增不减，主要是由于经营活动和投资活动现金流量净额为负数造成，企业现金流状况较差，建议管理层考虑以下措施对现金流进行改善：1)对库存商品进行促销，增加收入，改善现金流入；2)加快应收款的催收，加速现金回笼；3)对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4)股东考虑进行增资缓解企业资金压力。','','','300001','',113),
(136,'2','财务费用预警','LR_R1!=0&&LR_R>LR_R1','财务费用本期比上年同期增长 {(LR_R-LR_R1)/LR_R1 *100}%。财务费用的增加，主要是因为本期贷款金额的增加。建议管理层结合资金情况，贷款情况，做好资金用途的管理，同时评估未来还款付息对资金流产生的压力，评估资金状况是否足以承受未来的还本付息所需的现金流。','{(LR_R-LR_R1)/LR_R1 *100}','','20010','',136),
(137,'2','财务费用预警','LR_R1!=0&&LR_R-LR_R1<0','财务费用本期比上年同期减少{(LR_R1-LR_R)/LR_R1 *100}%，本期财务费用的减少，主要是因为利息支出的减少。建议管理层结合贷款及现金流情况，考虑是否需要更新融资计划或进行增资，如需进行股权或债权融资，需考虑未来还本付息等对现金流的压力。','{(LR_R1-LR_R)/LR_R1 *100}','','20010','',137),
(138,'2','投资收益预警','LR_U1!=0&&LR_U-LR_U1>0','投资收益本期比上年同期增长 {(LR_U-LR_U1)/Math.abs(LR_U1) *100}%，本期投资收益有所增加。由于投资收益为非经常性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，具体分析其增加原因，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_U-LR_U1)/Math.abs(LR_U1) *100}','','20011','',138),
(139,'2','投资收益预警','LR_U1!=0&&LR_U-LR_U1<0','投资收益本期比上年同期减少 {(LR_U1-LR_U)/Math.abs(LR_U1) *100}%，本期投资收益大幅度下降，管理层需关注投资收益下降原因，审慎评估投资风险。由于投资收益为非经营性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_U1-LR_U)/Math.abs(LR_U1) *100}','','20011','',139),
(140,'2','营业外收入预警','LR_Z1!=0&&LR_Z-LR_Z1>0','营业外收入本期比上年同期增长{(LR_Z-LR_Z1)/LR_Z1 *100}%，由于营业外收入为非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，并剔除历史数据中营业外收入对净利润的影响后，再分析净利润的变动原因。','{(LR_Z-LR_Z1)/LR_Z1 *100}','','20012','',140),
(141,'2','营业外收入预警','LR_Z-LR_Z1<0','营业外收入本期比上年同期减少{(LR_Z1-LR_Z)/LR_Z1 *100}%，营业外收入的减少，管理层需警惕。由于营业外收入非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，考虑主营业务的发展是否足以支撑企业未来的需求。','{(LR_Z1-LR_Z)/LR_Z1 *100}','','20012','',141),
(142,'2','营业外支出预警','LR_AB1!=0&&LR_AB-LR_AB1>0','营业外支出本期比上年同期增长{(LR_AB-LR_AB1)/LR_AB1 *100}%，营业外支出有所增加，建议管理层关注是否发生了大额的资产处置损失，资产处置是否履行了审批制度并关注大额资产处置的原因。另外，营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','{(LR_AB-LR_AB1)/LR_AB1 *100}','','20013','',142),
(143,'2','营业外支出预警','LR_AB-LR_AB1<0','营业外支出本期比上年同期减少{(LR_AB1-LR_AB)/LR_AB1 *100}%,由于营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','{(LR_AB1-LR_AB)/LR_AB1 *100}','','20013','',143),
(144,'2','税金及附加预警','LR_O1!=0&&LR_O-LR_O1>0','税金及附加本期比上年同期增长{(LR_O-LR_O1)/LR_O1 *100}%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收政策变化、进一步核查本期可抵扣税额，查看是否存在税率调增、不再享有免税政策以及大量发票不可抵扣的情况，从而规范发票管理及排查税务风险。','(LR_O-LR_O1)/LR_O1 *100}','','20014','',144),
(145,'2','税金及附加预警','LR_O-LR_O1<0','税金及附加本期比上年同期减少{(LR_O1-LR_O)/LR_O1 *100}%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收是否存在税率调减、享有免税政策的情况，确保税负降低的合理性。','{(LR_O1-LR_O)/LR_O1 *100}','','20014','',145),
(146,'2','资产减值损失预警','LR_S1!=0&&LR_S-LR_S1>0','资产减值损失本期比上年同期增长{(LR_S-LR_S1)/LR_S1 *100}%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施减少损失，同时，特别警惕因技术变革、行业创新导致公司资产大幅度减值的情况。','{(LR_S-LR_S1)/LR_S1 *100}','','20015','',146),
(147,'2','资产减值损失预警','LR_S-LR_S1<0','资产减值损失本期比上年同期减少{(LR_S1-LR_S)/LR_S1 *100}%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施进一步降低损失，提升利润空间，同时，需防范因技术变革、行业创新初步导致公司资产减值的情形。','{(LR_S1-LR_S)/LR_S1 *100}','','20015','',147),
(148,'2','公允价值变动收益预警','LR_T1!=0&&LR_T-LR_T1>0','公允价值变动本期比上年同期增长{(LR_T-LR_T1)/Math.abs(LR_T1) *100}%，由于公允价值变动为非经常性收益，剔除后，营业利润将下降。建议管理层考虑公允价值变动的性质，具体分析其增加原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_T-LR_T1)/Math.abs(LR_T1) *100}','','20016','',148),
(149,'2','公允价值变动收益预警','LR_T1!=0&&LR_T-LR_T1<0','公允价值变动本期比上年同期减少{(LR_T1-LR_T)/Math.abs(LR_T1) *100}%，本期公允价值变动大幅度下降，管理层需关注变动原因，评估现有投资风险。由于公允价值变动为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑公允价值变动的性质及原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_T1-LR_T)/Math.abs(LR_T1) *100}','','20016','',149),
(150,'2','所得税费用预警','LR_AE1!=0&&LR_AE>LR_AE1','所得税费用本期比上年同期增长{(LR_AE-LR_AE1)/LR_AE1 *100}%，建议管理层关注所得税申报中不得抵扣项的原因及金额，考虑是否需要聘请专业团队为企业进行税收筹划，达到合理避税，增加净利润的目的。','{(LR_AE-LR_AE1)/LR_AE1 *100}','','20017','',150),
(151,'2','所得税费用预警','LR_AE<LR_AE1','所得税费用本期比上年同期减少{(LR_AE1-LR_AE)/LR_AE1 *100}%，所得税费用的大幅度降低属于非经常性情况，建议管理层关注减少的原因，是否有享受优惠政策，注意优惠政策的可持续性。','{(LR_AE1-LR_AE)/LR_AE1 *100}','','20017','',151),
(166,'3','现金流量表概述','XJLL_BB > 0','本期现金及现金等价物净增加额为正数，企业现金流处于正常水平，其中经营活动产生的现金流量净额占{XJLL_Y/XJLL_BB*100}%，投资活动产生的现金流量净额占{XJLL_AM/XJLL_BB*100}%，筹资活动产生的现金流量净额占{XJLL_AZ/XJLL_BB*100}%，汇率变动对现金及现金等价物的影响占{XJLL_BA/XJLL_BB*100}%。','{XJLL_Y/XJLL_BB*100},{XJLL_AM/XJLL_BB*100},{XJLL_AZ/XJLL_BB*100},{XJLL_BA/XJLL_BB*100}','','G30001','',166),
(167,'3','现金流量表概述','XJLL_BB==0','本期现金及现金等价物净增加额为0，企业现金收支平衡，其中经营活动产生的现金流量净额为Rmb{XJLL_Y/10000}万元，投资活动产生的现金流量净额为Rmb{XJLL_AM/10000}万元，筹资活动产生的现金流量净额为Rmb{XJLL_AZ/10000}万元，汇率变动对现金及现金等价物的影响为Rmb{XJLL_BA/10000}万元。','{XJLL_Y/10000},{XJLL_AM/10000},{XJLL_AZ/10000},{XJLL_BA/10000}','','G30001','',167),
(168,'3','现金流量表概述','XJLL_BB < 0','本期现金及现金等价物净增加额为负数，企业现金流收不抵支，其中经营活动产生的现金流量净额占{XJLL_Y/XJLL_BB*100}%，投资活动产生的现金流量净额占{XJLL_AM/XJLL_BB*100}%，筹资活动产生的现金流量净额占{XJLL_AZ/XJLL_BB*100}%，汇率变动对现金及现金等价物的影响占{XJLL_BA/XJLL_BB*100}%。','{XJLL_Y/XJLL_BB*100},{XJLL_AM/XJLL_BB*100},{XJLL_AZ/XJLL_BB*100},{XJLL_BA/XJLL_BB*100}','','G30001','',168),
(169,'1','固定资产概述','ZCFZ_AA1!=0&&ZCFZ_AA - ZCFZ_AA1 >0','固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元增至本期的Rmb{ZCFZ_AA/10000}万元，增长率达{(ZCFZ_AA-ZCFZ_AA1)/ZCFZ_AA1*100}%。','{ZCFZ_AA1/10000},{ZCFZ_AA}/10000,{(ZCFZ_AA-ZCFZ_AA1)/ZCFZ_AA1*100}','','G1002','',169),
(170,'1','固定资产概述','ZCFZ_AA1!=0&&ZCFZ_AA - ZCFZ_AA1 < 0','固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元减少至本期的Rmb{ZCFZ_AA/10000}万元，下降率达{(ZCFZ_AA1-ZCFZ_AA)/ZCFZ_AA1*100}%。','{ZCFZ_AA1/10000},{ZCFZ_AA/10000}，{(ZCFZ_AA1-ZCFZ_AA)/ZCFZ_AA1*100}','','G1002','',170),
(175,'1','应收账款概述','ZCFZ_G1!=0&&ZCFZ_G-ZCFZ_G1>0','应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元增加至本期的Rmb{ZCFZ_G/10000}万元，增长率为{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100}%。','{ZCFZ_G1/10000},{ZCFZ_G/10000},{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100}','','G1005','',175),
(176,'1','应收账款概述','ZCFZ_G1!=0&&ZCFZ_G-ZCFZ_G1<0','应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元降至本期的Rmb{ZCFZ_G/10000}万元，下降率达{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100}%。','{ZCFZ_G1/10000},{ZCFZ_G/10000},{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100}','','G1005','',176),
(177,'1','预付款项概述','ZCFZ_H1!=0&&ZCFZ_H - ZCFZ_H1>0','预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元增加至本期的Rmb{ZCFZ_H/10000}万元，增长率达{(ZCFZ_H-ZCFZ_H1)/ZCFZ_H1*100}%。','{ZCFZ_H1/10000},{ZCFZ_H/10000},{(ZCFZ_H-ZCFZ_H1)/ZCFZ_H1*100}','','G1006','',177),
(178,'1','预付款项概述','ZCFZ_H1!=0&&ZCFZ_H - ZCFZ_H1<0','预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元降低至本期的Rmb{ZCFZ_H/10000}万元，下降率达{(ZCFZ_H1-ZCFZ_H)/ZCFZ_H1*100}%。','{ZCFZ_H1/10000},{ZCFZ_H/10000},{(ZCFZ_H1-ZCFZ_H)/ZCFZ_H1*100}','','G1006','',178),
(179,'1','其他应收款概述','ZCFZ_N1!=0&&ZCFZ_N-ZCFZ_N1>0','其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元增加至本期的Rmb{ZCFZ_N/10000}万元，增长率达{(ZCFZ_N-ZCFZ_N1)*100/ZCFZ_N1}%。','{(ZCFZ_N-ZCFZ_N1)*100/ZCFZ_N1},{ZCFZ_N/10000},{ZCFZ_N1/10000}','','G1007','',179),
(180,'1','其他应收款概述','ZCFZ_N1!=0&&ZCFZ_N- ZCFZ_N1<0','其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元降低至本期的Rmb{ZCFZ_N/10000}万元，下降率达{(ZCFZ_N1- ZCFZ_N)*100/ZCFZ_N1}%','{ZCFZ_N1/10000},{ZCFZ_N/10000},{(ZCFZ_N1- ZCFZ_N)*100/ZCFZ_N1}','','G1007','',180),
(181,'1','存货概述','ZCFZ_P1!=0&&ZCFZ_P-ZCFZ_P1>0','存货从上期的Rmb{ZCFZ_P1/10000}万元增加至本期的Rmb{ZCFZ_P/10000}万元，增长率达{(ZCFZ_P-ZCFZ_P1)*100/ZCFZ_P1}%。','{ZCFZ_P1/10000},{ZCFZ_P/10000},{(ZCFZ_P-ZCFZ_P1)*100/ZCFZ_P1}','','G1008','',181),
(182,'1','存货概述','ZCFZ_P1!=0&&ZCFZ_P-ZCFZ_P1<0','存货从上期的Rmb{ZCFZ_P1/10000}万元降低至本期的Rmb{ZCFZ_P/10000}万元，降低率达{(ZCFZ_P1-ZCFZ_P)*100/ZCFZ_P1}%。','{ZCFZ_P1/10000},{ZCFZ_P/10000},{(ZCFZ_P1-ZCFZ_P)*100/ZCFZ_P1}','','G1008','',182),
(183,'1','持有待售的资产概述','ZCFZ_Q1!=0&&ZCFZ_Q - ZCFZ_Q1>0','持有待售的资产从上年同期的Rmb{ZCFZ_Q1/10000}万元增加至本期的Rmb{ZCFZ_Q/10000}万元，增长率达{(ZCFZ_Q-ZCFZ_Q1)/ZCFZ_Q1*100}%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000},{(ZCFZ_Q-ZCFZ_Q1)/ZCFZ_Q1*100}','','G1009','',183),
(184,'1','持有待售的资产概述','ZCFZ_Q1!=0&&ZCFZ_Q - ZCFZ_Q1<0','划分为持有待售的资产从上年同期的Rmb{ZCFZ_Q1/10000}万元降低至本期的Rmb{ZCFZ_Q/10000}万元，下降率达{(ZCFZ_Q1-ZCFZ_Q)/ZCFZ_Q1*100}%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000},{(ZCFZ_Q1-ZCFZ_Q)/ZCFZ_Q1*100}','','G1009','',184),
(187,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1!=0&&ZCFZ_D-ZCFZ_D1<0','以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元减少至本期的Rmb{ZCFZ_D/10000}万元','{ZCFZ_D1/10000},{ZCFZ_D/10000}','','G1011','',187),
(188,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1!=0&&ZCFZ_D-ZCFZ_D1>0','以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元增加至本期的Rmb{ZCFZ_D/10000}万元','{ZCFZ_D/10000},{ZCFZ_D1/10000}','','G1011','',188),
(189,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1!=0&&ZCFZ_D-ZCFZ_D1<0','，下降率达{(ZCFZ_D1-ZCFZ_D)*100/ZCFZ_D1}%。','{(ZCFZ_D1-ZCFZ_D)*100/ZCFZ_D1}','','G1011','',189),
(190,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1!=0&&ZCFZ_D-ZCFZ_D1>0','，增长率达{(ZCFZ_D-ZCFZ_D1)*100/ZCFZ_D1}%。','{(ZCFZ_D-ZCFZ_D1)*100/ZCFZ_D1}','','G1011','',190),
(191,'1','应收票据概述','ZCFZ_F1!=0&&ZCFZ_F-ZCFZ_F1>0','应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元增加至本期的Rmb{ZCFZ_F/10000}万元','{ZCFZ_F1/10000},{ZCFZ_F/10000}','','G1012','',191),
(192,'1','应收票据概述','ZCFZ_F1!=0&&ZCFZ_F-ZCFZ_F1>0','，增长率达{(ZCFZ_F- ZCFZ_F1)*100/ZCFZ_F1}%。','{(ZCFZ_F- ZCFZ_F1)*100/ZCFZ_F1}','','G1012','',192),
(193,'1','应收票据概述','ZCFZ_F1!=0&&ZCFZ_F1-ZCFZ_F>0','应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元降低至本期的Rmb{ZCFZ_F/10000}万元','{ZCFZ_F1/10000},{ZCFZ_F/10000}','','G1012','',193),
(194,'1','应收票据概述','ZCFZ_F1!=0&&ZCFZ_F1-ZCFZ_F>0','，下降率达{(ZCFZ_F1- ZCFZ_F)*100/ZCFZ_F1}%。','{(ZCFZ_F1- ZCFZ_F)*100/ZCFZ_F1}','','G1012','',194),
(199,'1','应收利息概述','ZCFZ_L1!=0 && ZCFZ_L - ZCFZ_L1 > 0','应收利息从上年同期的Rmb{ZCFZ_L1/10000}万元增加至本期的Rmb{ZCFZ_L/10000}万元，增加率达{( ZCFZ_L-ZCFZ_L1)*100/ZCFZ_L1}%','{ZCFZ_L1/10000},{ZCFZ_L/10000},{( ZCFZ_L-ZCFZ_L1)*100/ZCFZ_L1}','','G1013','',199),
(201,'1','应收利息概述','ZCFZ_L1!=0 && ZCFZ_L1 -  ZCFZ_L > 0','应收利息从上期的Rmb{ZCFZ_L1/10000}万元降低至本期的Rmb{ZCFZ_L/10000}万元，降低率达{( ZCFZ_L1-ZCFZ_L)*100/ZCFZ_L1}%','{ZCFZ_L1/10000},{ZCFZ_L/10000},{( ZCFZ_L1-ZCFZ_L)*100/ZCFZ_L1}','','G1013','',201),
(203,'1','应收股利概述','ZCFZ_M1!=0 && ZCFZ_M - ZCFZ_M1 > 0','应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元增加至本期的Rmb{ZCFZ_M/10000}万元','{ZCFZ_M1/10000},{ZCFZ_M/10000}','','G1014','',203),
(204,'1','应收股利概述','ZCFZ_M1!=0 &&ZCFZ_M - ZCFZ_M1 > 0','，增加率达{(ZCFZ_M- ZCFZ_M1)*100/ZCFZ_M1}%','{(ZCFZ_M- ZCFZ_M1)*100/ZCFZ_M1}','','G1014','',204),
(205,'1','应收股利概述','ZCFZ_M1!=0 &&ZCFZ_M1 - ZCFZ_M > 0','应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元降低至本期的Rmb{ZCFZ_M/10000}万元','{ZCFZ_M1/10000},{ZCFZ_M/10000}','','G1014','',205),
(206,'1','应收股利概述','ZCFZ_M1!=0 &&ZCFZ_M1 - ZCFZ_M > 0','，降低率达{(ZCFZ_M1- ZCFZ_M)*100/ZCFZ_M1}%','{(ZCFZ_M1- ZCFZ_M)*100/ZCFZ_M1}','','G1014','',206),
(209,'1','一年内到期的非流动资产概述','ZCFZ_R1!=0&&ZCFZ_R-ZCFZ_R1>0','一年内到期的非流动资产从上年同期的Rmb{ZCFZ_R1/10000}万元增加至本期的Rmb{ZCFZ_R/10000}万元','{ZCFZ_R1/10000},{ZCFZ_R/10000}','','G1015','',209),
(210,'1','一年内到期的非流动资产概述','ZCFZ_R1!=0&&ZCFZ_R-ZCFZ_R1>0','，增加率达{(ZCFZ_R- ZCFZ_R1)*100/ZCFZ_R1}%','{(ZCFZ_R- ZCFZ_R1)*100/ZCFZ_R1}','','G1015','',210),
(211,'1','一年内到期的非流动资产概述','ZCFZ_R1!=0&&ZCFZ_R1-ZCFZ_R>0','一年内到期的非流动资产从上期的Rmb{ZCFZ_R1/10000}万元降低至本期的Rmb{ZCFZ_R/10000}万元','{ZCFZ_R1/10000},{ZCFZ_R/10000}','','G1015','',211),
(212,'1','一年内到期的非流动资产概述','ZCFZ_R1!=0&&ZCFZ_R1-ZCFZ_R>0','，降低率达{(ZCFZ_R1- ZCFZ_R)*100/ZCFZ_R1}%。','{(ZCFZ_R1- ZCFZ_R)*100/ZCFZ_R1}','','G1015','',212),
(213,'1','其他流动资产概述','ZCFZ_S1!=0&&ZCFZ_S-ZCFZ_S1>0','其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元增加至本期的Rmb{ZCFZ_S/10000}万元','{ZCFZ_S1/10000},{ZCFZ_S/10000}','','G1016','',213),
(214,'1','其他流动资产概述','ZCFZ_S1!=0&&ZCFZ_S-ZCFZ_S1>0','，增加率达{(ZCFZ_S- ZCFZ_S1)*100/ZCFZ_S1}%。','{(ZCFZ_S- ZCFZ_S1)*100/ZCFZ_S1}','','G1016','',214),
(215,'1','其他流动资产概述','ZCFZ_S1!=0&&ZCFZ_S1-ZCFZ_S>0','其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元降低至本期的Rmb{ZCFZ_S/10000}万元','{ZCFZ_S1/10000},{ZCFZ_S/10000}','','G1016','',215),
(216,'1','其他流动资产概述','ZCFZ_S1!=0&&ZCFZ_S1-ZCFZ_S>0','，降低率达{(ZCFZ_S1- ZCFZ_S)*100/ZCFZ_S1}%。','{(ZCFZ_S1- ZCFZ_S)*100/ZCFZ_S1}','','G1016','',216),
(217,'1','可供出售金融资产概述','ZCFZ_V1!=0 && ZCFZ_V - ZCFZ_V1 > 0','可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元增加至本期的Rmb{ZCFZ_V/10000}万元','{ZCFZ_V1/10000},{ZCFZ_V/10000}','','G1017','',217),
(218,'1','可供出售金融资产概述','ZCFZ_V1!=0&&ZCFZ_V-ZCFZ_V1>0','，增加率达{(ZCFZ_V- ZCFZ_V1)*100/ZCFZ_V1}%。','{(ZCFZ_V- ZCFZ_V1)*100/ZCFZ_V1}','','G1017','',218),
(219,'1','可供出售金融资产概述','ZCFZ_V1!=0&&ZCFZ_V1-ZCFZ_V>0','可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元降低至本期的Rmb{ZCFZ_V/10000}万元','{ZCFZ_V1/10000},{ZCFZ_V/10000}','','G1017','',219),
(220,'1','可供出售金融资产概述','ZCFZ_V1!=0&&ZCFZ_V1-ZCFZ_V>0','，降低率达{(ZCFZ_V1- ZCFZ_V)*100/ZCFZ_V1}%。','{(ZCFZ_V1- ZCFZ_V)*100/ZCFZ_V1}','','G1017','',220),
(221,'1','持有至到期投资概述','ZCFZ_W1!=0&&ZCFZ_W-ZCFZ_W1>0','持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元增加至本期的Rmb{ZCFZ_W/10000}万元','{ZCFZ_W1/10000},{ZCFZ_W/10000}','','G1018','',221),
(222,'1','持有至到期投资概述','ZCFZ_W1!=0&&ZCFZ_W-ZCFZ_W1>0','增加率达{(ZCFZ_W- ZCFZ_W1)*100/ZCFZ_W1}%。','{(ZCFZ_W- ZCFZ_W1)*100/ZCFZ_W1}','','G1018','',222),
(223,'1','持有至到期投资概述','ZCFZ_W1!=0&&ZCFZ_W1-ZCFZ_W>0','持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元降低至本期的Rmb{ZCFZ_W/10000}万元','{ZCFZ_W1/10000},{ZCFZ_W/10000}','','G1018','',223),
(224,'1','持有至到期投资概述','ZCFZ_W1!=0&&ZCFZ_W1-ZCFZ_W>0','，降低率达{(ZCFZ_W1- ZCFZ_W)*100/ZCFZ_W1}%。','{(ZCFZ_W1- ZCFZ_W)*100/ZCFZ_W1}','','G1018','',224),
(225,'1','长期应收款概述','ZCFZ_X1!=0&&ZCFZ_X-ZCFZ_X1>0','长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元增加至本期的Rmb{ZCFZ_X /10000}万元','{ZCFZ_X1/10000},{ZCFZ_X /10000}','','G1019','',225),
(226,'1','长期应收款概述','ZCFZ_X1!=0&&ZCFZ_X-ZCFZ_X1>0','，增加率达{(ZCFZ_X- ZCFZ_X1)*100/ZCFZ_X1}%','{(ZCFZ_X- ZCFZ_X1)*100/ZCFZ_X1}','','G1019','',226),
(227,'1','长期应收款概述','ZCFZ_X1!=0&&ZCFZ_X1-ZCFZ_X>0','长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元降低至本期的Rmb{ZCFZ_X/10000 }万元','{ZCFZ_X1/10000},{ZCFZ_X/10000 }','','G1019','',227),
(228,'1','长期应收款概述','ZCFZ_X1!=0&&ZCFZ_X1-ZCFZ_X>0','，降低率达{(ZCFZ_X1- ZCFZ_X)*100/ZCFZ_X1}%。','{(ZCFZ_X1- ZCFZ_X)*100/ZCFZ_X1}','','G1019','',228),
(229,'1','长期股权投资概述','ZCFZ_Y1!=0&&ZCFZ_Y-ZCFZ_Y1>0','长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元增加至本期的Rmb{ZCFZ_Y/10000}万元','{ZCFZ_Y1/10000},{ZCFZ_Y/10000}','','G1020','',229),
(230,'1','长期股权投资概述','ZCFZ_Y1!=0&&ZCFZ_Y-ZCFZ_Y1>0','，增加率达{(ZCFZ_Y- ZCFZ_Y1)*100/ZCFZ_Y1}%。','{(ZCFZ_Y- ZCFZ_Y1)*100/ZCFZ_Y1}','','G1020','',230),
(231,'1','长期股权投资概述','ZCFZ_Y1!=0&&ZCFZ_Y1-ZCFZ_Y>0','长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元降低至本期的Rmb{ZCFZ_Y/10000}万元','{ZCFZ_Y1/10000},{ZCFZ_Y/10000}','','G1020','',231),
(232,'1','长期股权投资概述','ZCFZ_Y1!=0&&ZCFZ_Y1-ZCFZ_Y>0','，降低率达{(ZCFZ_Y1- ZCFZ_Y)*100/ZCFZ_Y1}%。','{(ZCFZ_Y1- ZCFZ_Y)*100/ZCFZ_Y1}','','G1020','',232),
(233,'1','投资性房地产概述','ZCFZ_Z1!=0&&ZCFZ_Z > ZCFZ_Z1','投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元增加至本期的Rmb{ZCFZ_Z/10000}万元','{ZCFZ_Z1/10000},{ZCFZ_Z/10000}','','G1021','',233),
(234,'1','投资性房地产概述','ZCFZ_Z1!=0&&ZCFZ_Z > ZCFZ_Z1','，增加率达{(ZCFZ_Z- ZCFZ_Z1)*100/ZCFZ_Z1}%。','{(ZCFZ_Z- ZCFZ_Z1)*100/ZCFZ_Z1}','','G1021','',234),
(235,'1','投资性房地产概述','ZCFZ_Z1!=0&&ZCFZ_Z1 > ZCFZ_Z','投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元降低至本期的Rmb{ZCFZ_Z/10000}万元','{ZCFZ_Z1/10000},{ZCFZ_Z/10000}','','G1021','',235),
(236,'1','投资性房地产概述','ZCFZ_Z1!=0&&ZCFZ_Z1 > ZCFZ_Z','，降低率达{(ZCFZ_Z1- ZCFZ_Z)*100/ZCFZ_Z1}%。','{(ZCFZ_Z1- ZCFZ_Z)*100/ZCFZ_Z1}','','G1021','',236),
(239,'1','在建工程概述','ZCFZ_AB1!=0&&ZCFZ_AB-ZCFZ_AB1>0','在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元增加至本期的Rmb{ZCFZ_AB/10000}万元','{ZCFZ_AB1/10000},{ZCFZ_AB/10000}','','G1022','',239),
(240,'1','在建工程概述','ZCFZ_AB1!=0&&ZCFZ_AB-ZCFZ_AB1>0','，增加率达{(ZCFZ_AB- ZCFZ_AB1)*100/ZCFZ_AB1}%。','{(ZCFZ_AB- ZCFZ_AB1)*100/ZCFZ_AB1}','','G1022','',240),
(241,'1','在建工程概述','ZCFZ_AB1!=0&&ZCFZ_AB1-ZCFZ_AB>0','在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元降低至本期的Rmb{ZCFZ_AB/10000}万元','{ZCFZ_AB1/10000},{ZCFZ_AB/10000}','','G1022','',241),
(242,'1','在建工程概述','ZCFZ_AB1!=0&&ZCFZ_AB1-ZCFZ_AB>0','，降低率达{(ZCFZ_AB1- ZCFZ_AB)*100/ZCFZ_AB1}%。','{(ZCFZ_AB1- ZCFZ_AB)*100/ZCFZ_AB1}','','G1022','',242),
(243,'1','工程物资概述','ZCFZ_AC1!=0&&ZCFZ_AC-ZCFZ_AC1>0','工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元增加至本期的Rmb{ZCFZ_AC/10000}万元','{ZCFZ_AC1/10000},{ZCFZ_AC/10000}','','G1023','',243),
(244,'1','工程物资概述','ZCFZ_AC1!=0&&ZCFZ_AC-ZCFZ_AC1>0','，增加率达{(ZCFZ_AC- ZCFZ_AC1)*100/ZCFZ_AC1}%。','{(ZCFZ_AC- ZCFZ_AC1)*100/ZCFZ_AC1}','','G1023','',244),
(245,'1','工程物资概述','ZCFZ_AC1!=0&&ZCFZ_AC1-ZCFZ_AC>0','工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元降低至本期的Rmb{ZCFZ_AC/10000}万元','{ZCFZ_AC1/10000},{ZCFZ_AC/10000}','','G1023','',245),
(246,'1','工程物资概述','ZCFZ_AC1!=0&&ZCFZ_AC1-ZCFZ_AC>0','，降低率达{(ZCFZ_AC1- ZCFZ_AC)*100/ZCFZ_AC1}%。','{(ZCFZ_AC1- ZCFZ_AC)*100/ZCFZ_AC1}','','G1023','',246),
(247,'1','固定资产清理概述','ZCFZ_AD1!=0&&ZCFZ_AD-ZCFZ_AD1>0','固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元增加至本期的Rmb{ZCFZ_AD/10000}万元','{ZCFZ_AD1/10000},{ZCFZ_AD/10000}','','G1024','',247),
(248,'1','固定资产清理概述','ZCFZ_AD1!=0&&ZCFZ_AD-ZCFZ_AD1>0','，增加率达{(ZCFZ_AD- ZCFZ_AD1)*100/ZCFZ_AD1}%。','{(ZCFZ_AD- ZCFZ_AD1)*100/ZCFZ_AD1}','','G1024','',248),
(249,'1','固定资产清理概述','ZCFZ_AD1!=0&&ZCFZ_AD1-ZCFZ_AD>0','固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元降低至本期的Rmb{ZCFZ_AD/10000}万元','{ZCFZ_AD1/10000},{ZCFZ_AD/10000}','','G1024','',249),
(250,'1','固定资产清理概述','ZCFZ_AD1!=0&&ZCFZ_AD1-ZCFZ_AD>0','，降低率达{(ZCFZ_AD1- ZCFZ_AD)*100/ZCFZ_AD1}%。','{(ZCFZ_AD1- ZCFZ_AD)*100/ZCFZ_AD1}','','G1024','',250),
(251,'1','生产性生物资产概述','ZCFZ_AE1!=0&&ZCFZ_AE-ZCFZ_AE1>0','生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元增加至本期的Rmb{ZCFZ_AE/10000}万元','{ZCFZ_AE1/10000},{ZCFZ_AE/10000}','','G1025','',251),
(252,'1','生产性生物资产概述','ZCFZ_AE1!=0&&ZCFZ_AE-ZCFZ_AE1>0','，增加率达{(ZCFZ_AE- ZCFZ_AE1)*100/ZCFZ_AE1}%。','{(ZCFZ_AE- ZCFZ_AE1)*100/ZCFZ_AE1}%','','G1025','',252),
(253,'1','生产性生物资产概述','ZCFZ_AE1!=0&&ZCFZ_AE1-ZCFZ_AE>0','生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元降低至本期的Rmb{ZCFZ_AE/10000}万元','{ZCFZ_AE1/10000},{ZCFZ_AE/10000}','','G1025','',253),
(254,'1','生产性生物资产概述','ZCFZ_AE1!=0&&ZCFZ_AE1-ZCFZ_AE>0','，降低率达{(ZCFZ_AE1- ZCFZ_AE)*100/ZCFZ_AE1}%。','{(ZCFZ_AE1- ZCFZ_AE)*100/ZCFZ_AE1}','','G1025','',254),
(255,'1','油气资产概述','ZCFZ_AF1!=0&&ZCFZ_AF-ZCFZ_AF1>0','油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元增加至本期的Rmb{ZCFZ_AF/10000}万元','{ZCFZ_AF1/10000},{ZCFZ_AF/10000}','','G1026','',255),
(256,'1','油气资产概述','ZCFZ_AF1!=0&&ZCFZ_AF-ZCFZ_AF1>0','，增加率达{(ZCFZ_AF-ZCFZ_AF1)*100/ZCFZ_AF1}%。','{(ZCFZ_AF-ZCFZ_AF1)*100/ZCFZ_AF1}','','G1026','',256),
(257,'1','油气资产概述','ZCFZ_AF1!=0&&ZCFZ_AF1-ZCFZ_AF>0','油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元降低至本期的Rmb{ZCFZ_AF/10000}万元','{ZCFZ_AF1/10000},{ZCFZ_AF/10000}','','G1026','',257),
(258,'1','油气资产概述','ZCFZ_AF1!=0&&ZCFZ_AF1-ZCFZ_AF>0','，降低率达{(ZCFZ_AF1- ZCFZ_AF)*100/ZCFZ_AF1}%。','{(ZCFZ_AF1- ZCFZ_AF)*100/ZCFZ_AF1}%','','G1026','',258),
(259,'1','无形资产概述','ZCFZ_AG1!=0&&ZCFZ_AG-ZCFZ_AG1>0','无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元增加至本期的Rmb{ZCFZ_AG/10000}万元','{ZCFZ_AG1/10000},{ZCFZ_AG/10000}','','G1027','',259),
(260,'1','无形资产概述','ZCFZ_AG1!=0&&ZCFZ_AG-ZCFZ_AG1>0','，增加率达{(ZCFZ_AG- ZCFZ_AG1)*100/ZCFZ_AG1}%。','{(ZCFZ_AG- ZCFZ_AG1)*100/ZCFZ_AG1}','','G1027','',260),
(261,'1','无形资产概述','ZCFZ_AG1!=0&&ZCFZ_AG1-ZCFZ_AG>0','无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元降低至本期的Rmb{ZCFZ_AG/10000}万元','{ZCFZ_AG1/10000},{ZCFZ_AG/10000}','','G1027','',261),
(262,'1','无形资产概述','ZCFZ_AG1!=0&&ZCFZ_AG1-ZCFZ_AG>0','，降低率达{(ZCFZ_AG1- ZCFZ_AG)*100/ZCFZ_AG1}%。','{(ZCFZ_AG1- ZCFZ_AG)*100/ZCFZ_AG1}','','G1027','',262),
(263,'1','开发支出概述','ZCFZ_AH1!=0&&ZCFZ_AH-ZCFZ_AH1>0','开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元增加至本期的Rmb{ZCFZ_AH/10000}万元','{ZCFZ_AH1/10000},{ZCFZ_AH/10000}','','G1028','',263),
(264,'1','开发支出概述','ZCFZ_AH1!=0&&ZCFZ_AH-ZCFZ_AH1>0','，增加率达{(ZCFZ_AH- ZCFZ_AH1)*100/ZCFZ_AH1}%。','{(ZCFZ_AH- ZCFZ_AH1)*100/ZCFZ_AH1}','','G1028','',264),
(265,'1','开发支出概述','ZCFZ_AH1!=0&&ZCFZ_AH1-ZCFZ_AH>0','开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元降低至本期的Rmb{ZCFZ_AH/10000}万元','{ZCFZ_AH1/10000},{ZCFZ_AH/10000}','','G1028','',265),
(266,'1','开发支出概述','ZCFZ_AH1!=0&&ZCFZ_AH1-ZCFZ_AH>0','，降低率达{(ZCFZ_AH1- ZCFZ_AH)*100/ZCFZ_AH1}%。','{(ZCFZ_AH1- ZCFZ_AH)*100/ZCFZ_AH1}','','G1028','',266),
(267,'1','商誉概述','ZCFZ_AI1!=0&&ZCFZ_AI-ZCFZ_AI1>0','商誉从上年同期的Rmb{ZCFZ_AI1/10000}万元增加至本期的Rmb{ZCFZ_AI/10000}万元','{ZCFZ_AI1/10000},{ZCFZ_AI/10000}','','G1029','',267),
(268,'1','商誉概述','ZCFZ_AI1!=0&&ZCFZ_AI-ZCFZ_AI1>0','，增加率达{(ZCFZ_AI- ZCFZ_AI1)*100/ZCFZ_AI1}%。','{(ZCFZ_AI- ZCFZ_AI1)*100/ZCFZ_AI1}','','G1029','',268),
(269,'1','商誉概述','ZCFZ_AI1!=0&&ZCFZ_AI1-ZCFZ_AI>0','商誉从上年同期的Rmb{ZCFZ_AI1/10000}降低至本期的Rmb{ZCFZ_AI/10000}','{ZCFZ_AI1/10000},{ZCFZ_AI/10000}','','G1029','',269),
(270,'1','商誉概述','ZCFZ_AI1!=0&&ZCFZ_AI1-ZCFZ_AI>0','，降低率达{(ZCFZ_AI1- ZCFZ_AI)*100/ZCFZ_AI1}%。','{(ZCFZ_AI1- ZCFZ_AI)*100/ZCFZ_AI1}','','G1029','',270),
(271,'1','长期待摊费用概述','ZCFZ_AJ1!=0&&ZCFZ_AJ-ZCFZ_AJ1>0','长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元增加至本期的Rmb{ZCFZ_AJ/10000}万元','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000}','','G1030','',271),
(272,'1','长期待摊费用概述','ZCFZ_AJ1!=0&&ZCFZ_AJ-ZCFZ_AJ1>0','，增加率达{(ZCFZ_AJ- ZCFZ_AJ1)*100/ZCFZ_AJ1}%。','{(ZCFZ_AJ- ZCFZ_AJ1)*100/ZCFZ_AJ1}','','G1030','',272),
(273,'1','长期待摊费用概述','ZCFZ_AJ1!=0&&ZCFZ_AJ1-ZCFZ_AJ>0','长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元降低至本期的Rmb{ZCFZ_AJ/10000}万元','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000}','','G1030','',273),
(274,'1','长期待摊费用概述','ZCFZ_AJ1!=0&&ZCFZ_AJ1-ZCFZ_AJ>0','，降低率达{(ZCFZ_AJ1- ZCFZ_AJ)*100/ZCFZ_AJ1}%。','{(ZCFZ_AJ1- ZCFZ_AJ)*100/ZCFZ_AJ1}','','G1030','',274),
(275,'1','递延所得税资产概述','ZCFZ_AK1!=0&&ZCFZ_AK-ZCFZ_AK1>0','递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元增加至本期的Rmb{ZCFZ_AK/10000}万元','{ZCFZ_AK1/10000},{ZCFZ_AK/10000}','','G1031','',275),
(276,'1','递延所得税资产概述','ZCFZ_AK1!=0&&ZCFZ_AK-ZCFZ_AK1>0','，增加率达{(ZCFZ_AK- ZCFZ_AK1)*100/ZCFZ_AK1}%。','{(ZCFZ_AK- ZCFZ_AK1)*100/ZCFZ_AK1}','','G1031','',276),
(277,'1','递延所得税资产概述','ZCFZ_AK1!=0&&ZCFZ_AK1-ZCFZ_AK>0','递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元降低至本期的Rmb{ZCFZ_AK/10000}万元','{ZCFZ_AK1/10000},{ZCFZ_AK/10000}','','G1031','',277),
(278,'1','递延所得税资产概述','ZCFZ_AK1!=0&&ZCFZ_AK1-ZCFZ_AK>0','，降低率达{(ZCFZ_AK1- ZCFZ_AK)*100/ZCFZ_AK1}%。','{(ZCFZ_AK1- ZCFZ_AK)*100/ZCFZ_AK1}','','G1031','',278),
(279,'1','其他非流动资产概述','ZCFZ_AL1!=0&&ZCFZ_AL>ZCFZ_AL1','其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元增加至本期的Rmb{ZCFZ_AL/10000}万元','{ZCFZ_AL1/10000},{ZCFZ_AL/10000}','','G1032','',279),
(280,'1','其他非流动资产概述','ZCFZ_AL1!=0&&ZCFZ_AL>ZCFZ_AL1','，增加率达{(ZCFZ_AL- ZCFZ_AL1)*100/ZCFZ_AL1}%。','{(ZCFZ_AL- ZCFZ_AL1)*100/ZCFZ_AL1}','','G1032','',280),
(281,'1','其他非流动资产概述','ZCFZ_AL1!=0&&ZCFZ_AL1>ZCFZ_AL','其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元降低至本期的Rmb{ZCFZ_AL/10000}万元','{ZCFZ_AL1/10000},{ZCFZ_AL/10000}','','G1032','',281),
(282,'1','其他非流动资产概述','ZCFZ_AL1!=0&&ZCFZ_AL1>ZCFZ_AL','，降低率达{(ZCFZ_AL1- ZCFZ_AL)*100/ZCFZ_AL1}%。','{(ZCFZ_AL1- ZCFZ_AL)*100/ZCFZ_AL1}','','G1032','',282),
(283,'1','短期借款概述','ZCFZ_AO1!=0&&ZCFZ_AO-ZCFZ_AO1>0','短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元增加至本期的Rmb{ZCFZ_AO/10000}万元','{ZCFZ_AO1/10000},{ZCFZ_AO/10000}','','G1033','',283),
(284,'1','短期借款概述','ZCFZ_AO1!=0&&ZCFZ_AO-ZCFZ_AO1>0','，增加率达{(ZCFZ_AO- ZCFZ_AO1)*100/ZCFZ_AO1}%。','{(ZCFZ_AO- ZCFZ_AO1)*100/ZCFZ_AO1}','','G1033','',284),
(285,'1','短期借款概述','ZCFZ_AO1!=0&&ZCFZ_AO1-ZCFZ_AO>0','短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元降低至本期的Rmb{ZCFZ_AO/10000}万元','{ZCFZ_AO1/10000},{ZCFZ_AO/10000}','','G1033','',285),
(286,'1','短期借款概述','ZCFZ_AO1!=0&&ZCFZ_AO1-ZCFZ_AO>0','，降低率达{(ZCFZ_AO1- ZCFZ_AO)*100/ZCFZ_AO1}%。','{(ZCFZ_AO1- ZCFZ_AO)*100/ZCFZ_AO1}','','G1033','',286),
(287,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1!=0&&ZCFZ_AS-ZCFZ_AS1>0','以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元增加至本期的Rmb{ZCFZ_AS/10000}万元','{ZCFZ_AS1/10000},{ZCFZ_AS/10000}','','G1034','',287),
(288,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1!=0&&ZCFZ_AS-ZCFZ_AS1>0','，增加率达{(ZCFZ_AS- ZCFZ_AS1)*100/ZCFZ_AS1}%。','{(ZCFZ_AS- ZCFZ_AS1)*100/ZCFZ_AS1}','','G1034','',288),
(289,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1!=0&&ZCFZ_AS1-ZCFZ_AS>0','以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元降低至本期的Rmb{ZCFZ_AS/10000}万元','{ZCFZ_AS1/10000},{ZCFZ_AS/10000}','','G1034','',289),
(290,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1!=0&&ZCFZ_AS1-ZCFZ_AS>0','，降低率达{(ZCFZ_AS1- ZCFZ_AS)*100/ZCFZ_AS1}%。','{(ZCFZ_AS1- ZCFZ_AS)*100/ZCFZ_AS1}','','G1034','',290),
(291,'1','衍生金融负债概述','ZCFZ_AT1!=0&&ZCFZ_AT-ZCFZ_AT1>0','衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元增加至本期的Rmb{ZCFZ_AT/10000}万元','{ZCFZ_AT1/10000},{ZCFZ_AT/10000}','','G1035','',291),
(292,'1','衍生金融负债概述','ZCFZ_AT1!=0&&ZCFZ_AT-ZCFZ_AT1>0','，增加率达{(ZCFZ_AT- ZCFZ_AT1)*100/ZCFZ_AT1}%。','{(ZCFZ_AT- ZCFZ_AT1)*100/ZCFZ_AT1}','','G1035','',292),
(293,'1','衍生金融负债概述','ZCFZ_AT1!=0&&ZCFZ_AT1-ZCFZ_AT>0','衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元降低至本期的Rmb{ZCFZ_AT/10000}万元','{ZCFZ_AT1/10000},{ZCFZ_AT/10000}','','G1035','',293),
(294,'1','衍生金融负债概述','ZCFZ_AT1!=0&&ZCFZ_AT1-ZCFZ_AT>0','，降低率达{(ZCFZ_AT1- ZCFZ_AT)*100/ZCFZ_AT1}%。','{(ZCFZ_AT1- ZCFZ_AT)*100/ZCFZ_AT1}','','G1035','',294),
(295,'1','应付票据概述','ZCFZ_AU1!=0&&ZCFZ_AU-ZCFZ_AU1>0','应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元增加至本期的Rmb{ZCFZ_AU/10000}万元','{ZCFZ_AU1/10000},{ZCFZ_AU/10000}','','G1036','',295),
(296,'1','应付票据概述','ZCFZ_AU1!=0&&ZCFZ_AU-ZCFZ_AU1>0','，增加率达{(ZCFZ_AU- ZCFZ_AU1)*100/ZCFZ_AU1}%。','{(ZCFZ_AU- ZCFZ_AU1)*100/ZCFZ_AU1}','','G1036','',296),
(297,'1','应付票据概述','ZCFZ_AU1!=0&&ZCFZ_AU1-ZCFZ_AU>0','应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元降低至本期的Rmb{ZCFZ_AU/10000}万元','{ZCFZ_AU1/10000},{ZCFZ_AU/10000}','','G1036','',297),
(298,'1','应付票据概述','ZCFZ_AU1!=0&&ZCFZ_AU1-ZCFZ_AU>0','，降低率达{(ZCFZ_AU1- ZCFZ_AU)*100/ZCFZ_AU1}%。','{(ZCFZ_AU1- ZCFZ_AU)*100/ZCFZ_AU1}','','G1036','',298),
(299,'1','应付账款概述','ZCFZ_AV1!=0&&ZCFZ_AV-ZCFZ_AV1>0','应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元增加至本期的Rmb{ZCFZ_AV/10000}万元','{ZCFZ_AV1/10000},{ZCFZ_AV/10000}','','G1037','',299),
(300,'1','应付账款概述','ZCFZ_AV1!=0&&ZCFZ_AV-ZCFZ_AV1>0','，增加率达{(ZCFZ_AV- ZCFZ_AV1)*100/ZCFZ_AV1}%。','{(ZCFZ_AV- ZCFZ_AV1)*100/ZCFZ_AV1}','','G1037','',300),
(301,'1','应付账款概述','ZCFZ_AV1!=0&&ZCFZ_AV1-ZCFZ_AV>0','应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元降低至本期的Rmb{ZCFZ_AV/10000}万元','{ZCFZ_AV1/10000},{ZCFZ_AV/10000}','','G1037','',301),
(302,'1','应付账款概述','ZCFZ_AV1!=0&&ZCFZ_AV1-ZCFZ_AV>0','，降低率达{(ZCFZ_AV1- ZCFZ_AV)*100/ZCFZ_AV1}%。','{(ZCFZ_AV1- ZCFZ_AV)*100/ZCFZ_AV1}','','G1037','',302),
(303,'2','税金及附加概述','LR_O1!=0&&LR_O-LR_O1>0','税金及附加从上年同期的Rmb{LR_O1/10000}万元增加至本期的Rmb{LR_O/10000}万元','{LR_O1/10000},{LR_O/10000}','','G2002','',303),
(304,'2','税金及附加概述','LR_O1!=0&&LR_O-LR_O1>0','，增加率达{(LR_O- LR_O1)*100/LR_O1}%。','{(LR_O- LR_O1)*100/LR_O1}','','G2002','',304),
(305,'2','税金及附加概述','LR_O1!=0&&LR_O1-LR_O>0','税金及附加从上年同期的Rmb{LR_O1/10000}万元降低至本期的Rmb{LR_O/10000}万元','{LR_O1/10000},{LR_O/10000}','','G2002','',305),
(306,'2','税金及附加概述','LR_O1!=0&&LR_O1-LR_O>0','，降低率达{(LR_O1- LR_O)*100/LR_O1}%。','{(LR_O1- LR_O)*100/LR_O1}','','G2002','',306),
(307,'2','销售费用概述','LR_P1!=0 && LR_P-LR_P1>0','销售费用从上年同期的Rmb{LR_P1/10000}万元增加至本期的Rmb{LR_P/10000}万元','{LR_P1/10000},{LR_P/10000}','','G2003','',307),
(308,'2','销售费用概述','LR_P1!=0 && LR_P-LR_P1>0','，增加率达{(LR_P- LR_P1)*100/LR_P1}%。','{(LR_P- LR_P1)*100/LR_P1}','','G2003','',308),
(309,'2','销售费用概述','LR_P1!=0 && LR_P1-LR_P>0','销售费用从上年同期的Rmb{LR_P1/10000}万元降低至本期的Rmb{LR_P/10000}万元','{LR_P1/10000},{LR_P/10000}','','G2003','',309),
(310,'2','销售费用概述','LR_P1!=0 && LR_P1-LR_P>0','，降低率达{(LR_P1- LR_P)*100/LR_P1}%。','{(LR_P1- LR_P)*100/LR_P1}','','G2003','',310),
(311,'2','管理费用概述','LR_Q1!=0 && LR_Q-LR_Q1>0','管理费用从上年同期的Rmb{LR_Q1/10000}万元增加至本期的Rmb{LR_Q/10000}万元','{LR_Q1/10000},{LR_Q/10000}','','G2004','',311),
(312,'2','管理费用概述','LR_Q1!=0 && LR_Q-LR_Q1>0','，增加率达{(LR_Q- LR_Q1)*100/LR_Q1}%。','{(LR_Q- LR_Q1)*100/LR_Q1}','','G2004','',312),
(313,'2','管理费用概述','LR_Q1!=0 && LR_Q1-LR_Q>0','本期管理费用为Rmb{LR_Q/10000}万元，上年同期为Rmb{LR_Q1/10000}万元','{LR_Q1/10000},{LR_Q/10000}','','G2004','',313),
(314,'2','管理费用概述','LR_Q1!=0 && LR_Q1-LR_Q>0','，减少了{(LR_Q1- LR_Q)*100/LR_Q1}%。','{(LR_Q1- LR_Q)*100/LR_Q1}','','G2004','',314),
(315,'2','财务费用概述','LR_R1!=0 && LR_R>LR_R1','本期财务费用为Rmb{LR_R/10000}万元，上年同期为Rmb{LR_R1/10000}万元','{LR_R1/10000},{LR_R/10000}','','G2005','',315),
(316,'2','财务费用概述','LR_R1!=0 && LR_R>LR_R1','，增加了{(LR_R- LR_R1)*100/LR_R1}%。','{(LR_R- LR_R1)*100/LR_R1}','','G2005','',316),
(317,'2','财务费用概述','LR_R1!=0 && LR_R1>LR_R','本期财务费用为Rmb{LR_R/10000}万元，上年同期为Rmb{LR_R1/10000}万元','{LR_R1/10000},{LR_R/10000}','','G2005','',317),
(318,'2','财务费用概述','LR_R1!=0 && LR_R1>LR_R','，减少了{(LR_R1- LR_R)*100/LR_R1}%。','{(LR_R1- LR_R)*100/LR_R1}','','G2005','',318),
(319,'2','资产减值损失概述','LR_S1!=0 && LR_S-LR_S1>0','本期资产减值损失为Rmb{LR_S/10000}万元，上年同期为Rmb{LR_S1/10000}万元','{LR_S1/10000},{LR_S/10000}','','G2006','',319),
(320,'2','资产减值损失概述','LR_S1!=0 && LR_S-LR_S1>0','，增加了{(LR_S- LR_S1)*100/LR_S1}%。','{(LR_S- LR_S1)*100/LR_S1}','','G2006','',320),
(321,'2','资产减值损失概述','LR_S1!=0 && LR_S1-LR_S>0','本期资产减值损失为Rmb{LR_S/10000}万元，上年同期为Rmb{LR_S1/10000}万元','{LR_S1/10000},{LR_S/10000}','','G2006','',321),
(322,'2','资产减值损失概述','LR_S1!=0 && LR_S1-LR_S>0','，减少了{(LR_S1- LR_S)*100/LR_S1}%。','{(LR_S1- LR_S)*100/LR_S1}','','G2006','',322),
(323,'2','公允价值变动收益概述','LR_T1!=0 && LR_T-LR_T1>0','本期公允价值变动收益为Rmb{LR_T/10000}万元，上年同期为Rmb{LR_T1/10000}万元','{LR_T1/10000},{LR_T/10000}','','G2007','',323),
(324,'2','公允价值变动收益概述','LR_T1!=0 && LR_T-LR_T1>0','，增加了{(LR_T- LR_T1)*100/Math.abs(LR_T1)}%','{(LR_T- LR_T1)*100/Math.abs(LR_T1)}','','G2007','',324),
(325,'2','公允价值变动收益概述','LR_T1!=0 && LR_T1-LR_T>0','本期公允价值变动收益为Rmb{LR_T/10000}万元，上年同期为Rmb{LR_T1/10000}万元','{LR_T1/10000},{LR_T/10000}','','G2007','',325),
(326,'2','公允价值变动收益概述','LR_T1!=0 && LR_T1-LR_T>0','，减少了{(LR_T1- LR_T)*100/Math.abs(LR_T1)}%','{(LR_T1- LR_T)*100/Math.abs(LR_T1)}','','G2007','',326),
(327,'2','投资收益概述','LR_U1!=0 && LR_U-LR_U1>0','本期投资收益为Rmb{LR_U/10000}万元，上年同期为Rmb{LR_U1/10000}万元','{LR_U1/10000},{LR_U/10000}','','G2008','',327),
(328,'2','投资收益概述','LR_U1!=0 && LR_U-LR_U1>0','，增加了{(LR_U- LR_U1)*100/Math.abs(LR_U1)}%。','{(LR_U- LR_U1)*100/Math.abs(LR_U1)}','','G2008','',328),
(329,'2','投资收益概述','LR_U1!=0 && LR_U1-LR_U>0','本期投资收益为Rmb{LR_U/10000}万元，上年同期为Rmb{LR_U1/10000}万元','{LR_U1/10000},{LR_U/10000}','','G2008','',329),
(330,'2','投资收益概述','LR_U1!=0 && LR_U1-LR_U>0','，减少了{(LR_U1- LR_U)*100/Math.abs(LR_U1)}%。','{(LR_U1- LR_U)*100/Math.abs(LR_U1)}','','G2008','',330),
(331,'2','对联营企业和合营企业的投资收益概述','LR_V1!=0 && LR_V>LR_V1','本期对联营企业和合营企业的投资收益为Rmb{LR_V/10000}万元，上年同期为Rmb{LR_V1/10000}万元','{LR_V1/10000},{LR_V/10000}','','G2009','',331),
(332,'2','对联营企业和合营企业的投资收益概述','LR_V1!=0 && LR_V>LR_V1','，增加了{(LR_V- LR_V1)*100/LR_V1}%','{(LR_V- LR_V1)*100/LR_V1}','','G2009','',332),
(333,'2','对联营企业和合营企业的投资收益概述','LR_V1!=0 && LR_V1>LR_V','本期对联营企业和合营企业的投资收益为Rmb{LR_V/10000}万元，上年同期为Rmb{LR_V1/10000}万元','{LR_V1/10000},{LR_V/10000}','','G2009','',333),
(334,'2','对联营企业和合营企业的投资收益概述','LR_V1!=0 && LR_V1>LR_V','，减少了{(LR_V1- LR_V)*100/LR_V1}%','{(LR_V1- LR_V)*100/LR_V1}','','G2009','',334),
(335,'2','汇兑收益概述','LR_W1!=0 && LR_W-LR_W1>0','本期汇兑收益为Rmb{LR_W/10000}万元，上年同期为Rmb{LR_W1/10000}万元','{LR_W1/10000},{LR_W/10000}','','G2010','',335),
(336,'2','汇兑收益概述','LR_W1!=0 && LR_W-LR_W1>0','，增加了{(LR_W- LR_W1)*100/Math.abs(LR_W1)}%','{(LR_W- LR_W1)*100/Math.abs(LR_W1)}','','G2010','',336),
(337,'2','汇兑收益概述','LR_W1!=0 && LR_W1-LR_W<0','本期资产处置收益为Rmb{LR_W/10000}万元，上年同期为Rmb{LR_W1/10000}万元','{LR_W1/10000},{LR_W/10000}','','G2010','',337),
(338,'1','预收款项概述','ZCFZ_AW1!=0&&ZCFZ_AW>ZCFZ_AW1','预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元增加至本期的Rmb{ZCFZ_AW/10000}万元','{ZCFZ_AW1/10000},{ZCFZ_AW/10000}','','G1038','',338),
(339,'2','汇兑收益概述','LR_W1!=0 && LR_W1-LR_W<0','，减少了{(LR_W1- LR_W)*100/Math.abs(LR_W1)}%','{(LR_W1- LR_W)*100/LR_W1}','','G2010','',339),
(340,'1','预收款项概述','ZCFZ_AW1!=0&&ZCFZ_AW>ZCFZ_AW1','，增幅为{(ZCFZ_AW- ZCFZ_AW1)*100/ZCFZ_AW1}%','{(ZCFZ_AW- ZCFZ_AW1)*100/ZCFZ_AW1}','','G1038','',340),
(341,'1','预收款项概述','ZCFZ_AW1!=0&&ZCFZ_AW1>ZCFZ_AW','预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元减少至本期的Rmb{ZCFZ_AW/10000}万元','{ZCFZ_AW1/10000},{ZCFZ_AW/10000}','','G1038','',341),
(342,'2','其他收益概述','LR_X1!=0 && LR_X-LR_X1>0','本期其他收益为Rmb{LR_X/10000}万元，上年同期为Rmb{LR_X1/10000}万元','{LR_X1/10000},{LR_X/10000}','','G2011','',342),
(343,'2','其他收益概述','LR_X1!=0 && LR_X-LR_X1>0','，增加了{(LR_X- LR_X1)*100/Math.abs(LR_X1)}%','{(LR_X- LR_X1)*100/Math.abs(LR_X1)}','','G2011','',343),
(344,'1','预收款项概述','ZCFZ_AW1!=0&&ZCFZ_AW1>ZCFZ_AW','，降幅为{(ZCFZ_AW1- ZCFZ_AW)*100/ZCFZ_AW1}%','{(ZCFZ_AW1- ZCFZ_AW)*100/ZCFZ_AW1}','','G1038','',344),
(345,'2','其他收益概述','LR_X1!=0 && LR_X1-LR_X>0','本期其他收益为Rmb{LR_X/10000}万元，上年同期为Rmb{LR_X1/10000}万元','{LR_X1/10000},{LR_X/10000}','','G2011','',345),
(346,'1','应付职工薪酬概述','ZCFZ_AZ1!=0&&ZCFZ_AZ-ZCFZ_AZ1>0','应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元增加至本期的Rmb{ZCFZ_AZ/10000}万元','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000}','','G1039','',346),
(347,'2','其他收益概述','LR_X1!=0 && LR_X1-LR_X>0','，减少了{(LR_X1- LR_X)*100/Math.abs(LR_X1)}%','{(LR_X1- LR_X)*100/Math.abs(LR_X1)}','','G2011','',347),
(348,'2','营业外收入概述','LR_Z1!=0 && LR_Z-LR_Z1>0','本期营业外收入为Rmb{LR_Z/10000}万元，上年同期为Rmb{LR_Z1/10000}万元','{LR_Z1/10000},{LR_Z/10000}','','G2012','',348),
(349,'1','应付职工薪酬概述','ZCFZ_AZ1!=0&&ZCFZ_AZ-ZCFZ_AZ1>0','，增幅为{(ZCFZ_AZ- ZCFZ_AZ1)*100/ZCFZ_AZ1}%','{(ZCFZ_AZ- ZCFZ_AZ1)*100/ZCFZ_AZ1}','','G1039','',349),
(350,'1','应付职工薪酬概述','ZCFZ_AZ1!=0&&ZCFZ_AZ1-ZCFZ_AZ>0','应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元降低至本期的Rmb{ZCFZ_AZ/10000}万元','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000}','','G1039','',350),
(351,'2','营业外收入概述','LR_Z1!=0 && LR_Z-LR_Z1>0','，增加了{(LR_Z- LR_Z1)*100/LR_Z1}%。','{(LR_Z- LR_Z1)*100/LR_Z1}','','G2012','',351),
(352,'1','应付职工薪酬概述','ZCFZ_AZ1!=0&&ZCFZ_AZ1-ZCFZ_AZ>0','，降幅为{(ZCFZ_AZ1- ZCFZ_AZ)*100/ZCFZ_AZ1}%','{(ZCFZ_AZ1- ZCFZ_AZ)*100/ZCFZ_AZ1}','','G1039','',352),
(353,'2','营业外收入概述','LR_Z1!=0 && LR_Z1-LR_Z>0','本期营业外收入为Rmb{LR_Z/10000}万元，上年同期为Rmb{LR_Z1/10000}万元','{LR_Z1/10000},{LR_Z/10000}','','G2012','',353),
(354,'2','营业外收入概述','LR_Z1!=0 && LR_Z1-LR_Z>0','，减少了{(LR_Z1- LR_Z)*100/LR_Z1}%。','{(LR_Z1- LR_Z)*100/LR_Z1}','','G2012','',354),
(355,'1','应交税费概述','ZCFZ_BA1!=0&&ZCFZ_BA>ZCFZ_BA1','应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元增加至本期的Rmb{ZCFZ_BA/10000}万元','{ZCFZ_BA1/10000},{ZCFZ_BA/10000}','','G1040','',355),
(356,'1','应交税费概述','ZCFZ_BA1!=0&&ZCFZ_BA>ZCFZ_BA1','，增幅为{(ZCFZ_BA- ZCFZ_BA1)*100/ZCFZ_BA1}%','{(ZCFZ_BA- ZCFZ_BA1)*100/ZCFZ_BA1}','','G1040','',356),
(357,'1','应交税费概述','ZCFZ_BA1!=0&&ZCFZ_BA1>ZCFZ_BA','应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元降低至本期的Rmb{ZCFZ_BA/10000}万元','{ZCFZ_BA1/10000},{ZCFZ_BA/10000}','','G1040','',357),
(358,'2','营业外支出概述','LR_AB1!=0 && LR_AB-LR_AB1>0','本期营业外支出为Rmb{LR_AB/10000}万元，上年同期为Rmb{LR_AB1/10000}万元','{LR_AB1/10000},{LR_AB/10000}','','G2013','',358),
(359,'1','应交税费概述','ZCFZ_BA1!=0&&ZCFZ_BA1>ZCFZ_BA','，降幅为{(ZCFZ_BA1- ZCFZ_BA)*100/ZCFZ_BA1}%','{(ZCFZ_BA1- ZCFZ_BA)*100/ZCFZ_BA1}','','G1040','',359),
(360,'2','营业外支出概述','LR_AB1!=0 && LR_AB-LR_AB1>0','，增加了{(LR_AB- LR_AB1)*100/LR_AB1}%','{(LR_AB- LR_AB1)*100/LR_AB1}','','G2013','',360),
(361,'2','营业外支出概述','LR_AB1!=0 && LR_AB1-LR_AB>0','本期营业外支出为Rmb{LR_AB/10000}万元，上年同期为Rmb{LR_AB1/10000}万元','{LR_AB1/10000},{LR_AB/10000}','','G2013','',361),
(362,'2','营业外支出概述','LR_AB1!=0 && LR_AB1-LR_AB>0','，减少了{(LR_AB1- LR_AB)*100/LR_AB1}%','{(LR_AB1- LR_AB)*100/LR_AB1}','','G2013','',362),
(363,'2','所得税费用概述','LR_AE1!=0 && LR_AE>LR_AE1','本期所得税费用为Rmb{LR_AE/10000}万元，上年同期为Rmb{LR_AE1/10000}万元','{LR_AE1/10000},{LR_AE/10000}','','G2014','',363),
(364,'2','所得税费用概述','LR_AE1!=0 && LR_AE>LR_AE1','，增加了{(LR_AE- LR_AE1)*100/LR_AE1}%','{(LR_AE- LR_AE1)*100/LR_AE1}','','G2014','',364),
(365,'2','所得税费用概述','LR_AE1!=0 && LR_AE1>LR_AE','本期所得税费用为Rmb{LR_AE/10000}万元，上年同期为Rmb{LR_AE1/10000}万元','{LR_AE1/10000},{LR_AE/10000}','','G2014','',365),
(366,'2','所得税费用概述','LR_AE1!=0 && LR_AE1>LR_AE','，减少了{(LR_AE1- LR_AE)*100/LR_AE1}%','{(LR_AE1- LR_AE)*100/LR_AE1}','','G2014','',366),
(367,'1','应付利息概述','ZCFZ_BB1!=0&&ZCFZ_BB>ZCFZ_BB1','应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元增加至本期的Rmb{ZCFZ_BB/10000}万元','{ZCFZ_BB1/10000},{ZCFZ_BB/10000}','','G1041','',367),
(368,'1','应付利息概述','ZCFZ_BB1!=0&&ZCFZ_BB>ZCFZ_BB1','，增幅为{(ZCFZ_BB- ZCFZ_BB1)*100/ZCFZ_BB1}%','{(ZCFZ_BB- ZCFZ_BB1)*100/ZCFZ_BB1}','','G1041','',368),
(369,'1','应付利息概述','ZCFZ_BB1!=0&&ZCFZ_BB1>ZCFZ_BB','应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元降低至本期的Rmb{ZCFZ_BB/10000}万元','{ZCFZ_BB1/10000},{ZCFZ_BB/10000}','','G1041','',369),
(370,'1','应付利息概述','ZCFZ_BB1!=0&&ZCFZ_BB1>ZCFZ_BB','，降幅为{(ZCFZ_BB1- ZCFZ_BB)*100/ZCFZ_BB1}%','{(ZCFZ_BB1- ZCFZ_BB)*100/ZCFZ_BB1}','','G1041','',370),
(371,'1','应付股利概述','ZCFZ_BC1!=0&&ZCFZ_BC-ZCFZ_BC1>0','应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元增加至本期的Rmb{ZCFZ_BC/10000}万元','{ZCFZ_BC1/10000},{ZCFZ_BC/10000}','','G1042','',371),
(372,'1','应付股利概述','ZCFZ_BC1!=0&&ZCFZ_BC>ZCFZ_BC1','，增幅为{(ZCFZ_BC- ZCFZ_BC1)*100/ZCFZ_BC1}%','{(ZCFZ_BC- ZCFZ_BC1)*100/ZCFZ_BC1}','','G1042','',372),
(373,'1','应付股利概述','ZCFZ_BC1!=0&&ZCFZ_BC1-ZCFZ_BC>0','应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元降低至本期的Rmb{ZCFZ_BC/10000}万元','{ZCFZ_BC1/10000},{ZCFZ_BC/10000}','','G1042','',373),
(374,'1','应付股利概述','ZCFZ_BC1!=0&&ZCFZ_BC1-ZCFZ_BC>0','，降幅为{(ZCFZ_BC1- ZCFZ_BC)*100/ZCFZ_BC1}%','{(ZCFZ_BC1- ZCFZ_BC)*100/ZCFZ_BC1}','','G1042','',374),
(375,'1','其他应付款概述','ZCFZ_BD1!=0&&ZCFZ_BD>ZCFZ_BD1','其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元增加至本期的Rmb{ZCFZ_BD/10000}万元','{ZCFZ_BD1/10000},{ZCFZ_BD/10000}','','G1043','',375),
(376,'1','其他应付款概述','ZCFZ_BD1!=0&&ZCFZ_BD>ZCFZ_BD1','，增幅为{(ZCFZ_BD- ZCFZ_BD1)*100/ZCFZ_BD1}%','{(ZCFZ_BD- ZCFZ_BD1)*100/ZCFZ_BD1}','','G1043','',376),
(377,'1','其他应付款概述','ZCFZ_BD1!=0&&ZCFZ_BD1>ZCFZ_BD','其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元降低至本期的Rmb{ZCFZ_BD/10000}万元','{ZCFZ_BD1/10000},{ZCFZ_BD/10000}','','G1043','',377),
(378,'1','其他应付款概述','ZCFZ_BD1!=0&&ZCFZ_BD1>ZCFZ_BD','，降幅为{(ZCFZ_BD1- ZCFZ_BD)*100/ZCFZ_BD1}%','{(ZCFZ_BD1- ZCFZ_BD)*100/ZCFZ_BD1}','','G1043','',378),
(379,'1','持有待售的负债概述','ZCFZ_BI1!=0&&ZCFZ_BI-ZCFZ_BI1>0','持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元增加至本期的Rmb{ZCFZ_BI/10000}万元','{ZCFZ_BI1/10000},{ZCFZ_BI/10000}','','G1044','',379),
(380,'1','持有待售的负债概述','ZCFZ_BI1!=0&&ZCFZ_BI-ZCFZ_BI1>0','，增幅为{(ZCFZ_BI- ZCFZ_BI1)*100/ZCFZ_BI1}%','{(ZCFZ_BI- ZCFZ_BI1)*100/ZCFZ_BI1}','','G1044','',380),
(381,'1','持有待售的负债概述','ZCFZ_BI1!=0&&ZCFZ_BI1-ZCFZ_BI>0','持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元降低至本期的Rmb{ZCFZ_BI/10000}万元','{ZCFZ_BI1/10000},{ZCFZ_BI/10000}','','G1044','',381),
(382,'1','持有待售的负债概述','ZCFZ_BI1!=0&&ZCFZ_BI1-ZCFZ_BI>0','，降幅为{(ZCFZ_BI1- ZCFZ_BI)*100/ZCFZ_BI1}%','{(ZCFZ_BI1- ZCFZ_BI)*100/ZCFZ_BI1}','','G1044','',382),
(383,'1','一年内到期的非流动负债概述','ZCFZ_BJ1!=0&&ZCFZ_BJ-ZCFZ_BJ1>0','一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元增加至本期的Rmb{ZCFZ_BJ/10000}万元','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000}','','G1045','',383),
(384,'1','一年内到期的非流动负债概述','ZCFZ_BJ1!=0&&ZCFZ_BJ-ZCFZ_BJ1>0','，增幅为{(ZCFZ_BJ- ZCFZ_BJ1)*100/ZCFZ_BJ1}%','{(ZCFZ_BJ- ZCFZ_BJ1)*100/ZCFZ_BJ1}','','G1045','',384),
(385,'1','一年内到期的非流动负债概述','ZCFZ_BJ1!=0&&ZCFZ_BJ1-ZCFZ_BJ>0','一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元降低至本期的Rmb{ZCFZ_BJ/10000}万元','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000}','','G1045','',385),
(386,'1','一年内到期的非流动负债概述','ZCFZ_BJ1!=0&&ZCFZ_BJ1-ZCFZ_BJ>0','，降幅为{(ZCFZ_BJ1- ZCFZ_BJ)*100/ZCFZ_BJ1}%','{(ZCFZ_BJ1- ZCFZ_BJ)*100/ZCFZ_BJ1}','','G1045','',386),
(387,'1','其他流动负债概述','ZCFZ_BK1!=0&&ZCFZ_BK-ZCFZ_BK1>0','其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元增加至本期的Rmb{ZCFZ_BK/10000}万元','{ZCFZ_BK1/10000},{ZCFZ_BK/10000}','','G1046','',387),
(388,'1','其他流动负债概述','ZCFZ_BK1!=0&&ZCFZ_BK-ZCFZ_BK1>0','，增幅为{(ZCFZ_BK- ZCFZ_BK1)*100/ZCFZ_BK1}%','{(ZCFZ_BK- ZCFZ_BK1)*100/ZCFZ_BK1}','','G1046','',388),
(389,'1','其他流动负债概述','ZCFZ_BK1!=0&&ZCFZ_BK1-ZCFZ_BK>0','其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元降低至本期的Rmb{ZCFZ_BK/10000}万元','{ZCFZ_BK1/10000},{ZCFZ_BK/10000}','','G1046','',389),
(390,'1','其他流动负债概述','ZCFZ_BK1!=0&&ZCFZ_BK1-ZCFZ_BK>0','，降幅为{(ZCFZ_BK1- ZCFZ_BK)*100/ZCFZ_BK1}%','{(ZCFZ_BK1- ZCFZ_BK)*100/ZCFZ_BK1}','','G1046','',390),
(391,'1','长期借款概述','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1>0','长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元增加至本期的Rmb{ZCFZ_BM/10000}万元','{ZCFZ_BM1/10000},{ZCFZ_BM/10000}','','G1047','',391),
(392,'1','长期借款概述','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1>0','，增幅为{(ZCFZ_BM- ZCFZ_BM1)*100/ZCFZ_BM1}%','{(ZCFZ_BM- ZCFZ_BM1)*100/ZCFZ_BM1}','','G1047','',392),
(393,'1','长期借款概述','ZCFZ_BM1!=0&&ZCFZ_BM1-ZCFZ_BM>0','长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元降低至本期的Rmb{ZCFZ_BM/10000}万元','{ZCFZ_BM1/10000},{ZCFZ_BM/10000}','','G1047','',393),
(394,'1','长期借款概述','ZCFZ_BM1!=0&&ZCFZ_BM1-ZCFZ_BM>0','，降幅为{(ZCFZ_BM1- ZCFZ_BM)*100/ZCFZ_BM1}%','{(ZCFZ_BM1- ZCFZ_BM)*100/ZCFZ_BM1}','','G1047','',394),
(395,'1','应付债券概述','ZCFZ_BN1!=0&&ZCFZ_BN-ZCFZ_BN1>0','应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元增加至本期的Rmb{ZCFZ_BN/10000}万元','{ZCFZ_BN1/10000},{ZCFZ_BN/10000}','','G1048','',395),
(396,'1','应付债券概述','ZCFZ_BN1!=0&&ZCFZ_BN-ZCFZ_BN1>0','，增幅为{(ZCFZ_BN- ZCFZ_BN1)*100/ZCFZ_BN1}%','{(ZCFZ_BN- ZCFZ_BN1)*100/ZCFZ_BN1}','','G1048','',396),
(397,'1','应付债券概述','ZCFZ_BN1!=0&&ZCFZ_BN1-ZCFZ_BN>0','应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元降低至本期的Rmb{ZCFZ_BN/10000}万元','{ZCFZ_BN1/10000},{ZCFZ_BN/10000}','','G1048','',397),
(398,'1','应付债券概述','ZCFZ_BN1!=0&&ZCFZ_BN1-ZCFZ_BN>0','，降幅为{(ZCFZ_BN1- ZCFZ_BN)*100/ZCFZ_BN1}%','{(ZCFZ_BN1- ZCFZ_BN)*100/ZCFZ_BN1}','','G1048','',398),
(399,'1','优先股概述','ZCFZ_BO>ZCFZ_BO1','优先股从上年同期的Rmb{ZCFZ_BO1/10000}万元增加至本期的Rmb{ZCFZ_BO/10000}万元','{ZCFZ_BO1/10000},{ZCFZ_BO/10000}','','G1049','',399),
(400,'1','优先股概述','ZCFZ_BO>ZCFZ_BO1','，增幅为{(ZCFZ_BO- ZCFZ_BO1)*100/ZCFZ_BO1}%','{(ZCFZ_BO- ZCFZ_BO1)*100/ZCFZ_BO1}','','G1049','',400),
(401,'1','优先股概述','ZCFZ_BO1>ZCFZ_BO','优先股从上年同期的Rmb{ZCFZ_BO1/10000}万元降低至本期的Rmb{ZCFZ_BO/10000}万元','{ZCFZ_BO1/10000},{ZCFZ_BO/10000}','','G1049','',401),
(402,'1','优先股概述','ZCFZ_BO1>ZCFZ_BO','，降幅为{(ZCFZ_BO1- ZCFZ_BO)*100/ZCFZ_BO1}%','{(ZCFZ_BO1- ZCFZ_BO)*100/ZCFZ_BO1}','','G1049','',402),
(403,'1','永续债概述','ZCFZ_BP>ZCFZ_BP1','永续债从上年同期的Rmb{ZCFZ_BP1/10000}万元增加至本期的Rmb{ZCFZ_BP/10000}万元','{ZCFZ_BP1/10000},{ZCFZ_BP/10000}','','G1050','',403),
(404,'1','永续债概述','ZCFZ_BP>ZCFZ_BP1','，增幅为{(ZCFZ_BP- ZCFZ_BP1)*100/ZCFZ_BP1}%','{(ZCFZ_BP- ZCFZ_BP1)*100/ZCFZ_BP1}','','G1050','',404),
(405,'1','永续债概述','ZCFZ_BP1>ZCFZ_BP','永续债从上年同期的Rmb{ZCFZ_BP1/10000}万元降低至本期的Rmb{ZCFZ_BP/10000}万元','{ZCFZ_BP1/10000},{ZCFZ_BP/10000}','','G1050','',405),
(406,'1','永续债概述','ZCFZ_BP1>ZCFZ_BP','，降幅为{(ZCFZ_BP1- ZCFZ_BP)*100/ZCFZ_BP1}%','{(ZCFZ_BP1- ZCFZ_BP)*100/ZCFZ_BP1}','','G1050','',406),
(407,'1','长期应付款概述','ZCFZ_BQ1!=0&&ZCFZ_BQ>ZCFZ_BQ1','长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元增加至本期的Rmb{ZCFZ_BQ/10000}万元','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000}','','G1051','',407),
(408,'1','长期应付款概述','ZCFZ_BQ1!=0&&ZCFZ_BQ>ZCFZ_BQ1','，增幅为{(ZCFZ_BQ- ZCFZ_BQ1)*100/ZCFZ_BQ1}%','{(ZCFZ_BQ- ZCFZ_BQ1)*100/ZCFZ_BQ1}','','G1051','',408),
(409,'1','长期应付款概述','ZCFZ_BQ1!=0&&ZCFZ_BQ1>ZCFZ_BQ','长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元降低至本期的Rmb{ZCFZ_BQ/10000}万元','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000}','','G1051','',409),
(410,'1','长期应付款概述','ZCFZ_BQ1!=0&&ZCFZ_BQ1>ZCFZ_BQ','，降幅为{(ZCFZ_BQ1- ZCFZ_BQ)*100/ZCFZ_BQ1}%','{(ZCFZ_BQ1- ZCFZ_BQ)*100/ZCFZ_BQ1}','','G1051','',410),
(411,'1','专项应付款概述','ZCFZ_BS1!=0&&ZCFZ_BS-ZCFZ_BS1>0','专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元增加至本期的Rmb{ZCFZ_BS/10000}万元','{ZCFZ_BS1/10000},{ZCFZ_BS/10000}','','G1052','',411),
(412,'1','专项应付款概述','ZCFZ_BS1!=0&&ZCFZ_BS-ZCFZ_BS1>0','，增幅为{(ZCFZ_BS- ZCFZ_BS1)*100/ZCFZ_BS1}%','{(ZCFZ_BS- ZCFZ_BS1)*100/ZCFZ_BS1}','','G1052','',412),
(413,'1','专项应付款概述','ZCFZ_BS1!=0&&ZCFZ_BS1-ZCFZ_BS>0','专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元降低至本期的Rmb{ZCFZ_BS/10000}万元','{ZCFZ_BS1/10000},{ZCFZ_BS/10000}','','G1052','',413),
(414,'1','专项应付款概述','ZCFZ_BS1!=0&&ZCFZ_BS1-ZCFZ_BS>0','，降幅为{(ZCFZ_BS1- ZCFZ_BS)*100/ZCFZ_BS1}%','{(ZCFZ_BS1- ZCFZ_BS)*100/ZCFZ_BS1}','','G1052','',414),
(415,'1','预计负债概述','ZCFZ_BT1!=0&&ZCFZ_BT-ZCFZ_BT1>0','预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元增加至本期的Rmb{ZCFZ_BT/10000}万元','{ZCFZ_BT1/10000},{ZCFZ_BT/10000}','','G1053','',415),
(416,'1','预计负债概述','ZCFZ_BT1!=0&&ZCFZ_BT-ZCFZ_BT1>0','，增幅为{(ZCFZ_BT- ZCFZ_BT1)*100/ZCFZ_BT1}%','{(ZCFZ_BT- ZCFZ_BT1)*100/ZCFZ_BT1}','','G1053','',416),
(417,'1','预计负债概述','ZCFZ_BT1!=0&&ZCFZ_BT1-ZCFZ_BT>0','预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元降低至本期的Rmb{ZCFZ_BT/10000}万元','{ZCFZ_BT1/10000},{ZCFZ_BT/10000}','','G1053','',417),
(418,'1','预计负债概述','ZCFZ_BT1!=0&&ZCFZ_BT1-ZCFZ_BT>0','，降幅为{(ZCFZ_BT1- ZCFZ_BT)*100/ZCFZ_BT1}%','{(ZCFZ_BT1- ZCFZ_BT)*100/ZCFZ_BT1}','','G1053','',418),
(419,'1','递延收益概述','ZCFZ_BU1!=0&&ZCFZ_BU-ZCFZ_BU1>0','递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元增加至本期的Rmb{ZCFZ_BU/10000}万元','{ZCFZ_BU1/10000},{ZCFZ_BU/10000}','','G1054','',419),
(420,'1','递延收益概述','ZCFZ_BU1!=0&&ZCFZ_BU-ZCFZ_BU1>0','，增幅为{(ZCFZ_BU- ZCFZ_BU1)*100/ZCFZ_BU1}%','{(ZCFZ_BU- ZCFZ_BU1)*100/ZCFZ_BU1}','','G1054','',420),
(421,'1','递延收益概述','ZCFZ_BU1!=0&&ZCFZ_BU1-ZCFZ_BU>0','递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元降低至本期的Rmb{ZCFZ_BU/10000}万元','{ZCFZ_BU1/10000},{ZCFZ_BU/10000}','','G1054','',421),
(422,'1','递延收益概述','ZCFZ_BU1!=0&&ZCFZ_BU1-ZCFZ_BU>0','，降幅为{(ZCFZ_BU1- ZCFZ_BU)*100/ZCFZ_BU1}%','{(ZCFZ_BU1- ZCFZ_BU)*100/ZCFZ_BU1}','','G1054','',422),
(423,'1','递延所得税负债概述','ZCFZ_BV1!=0&&ZCFZ_BV-ZCFZ_BV1>0','递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元增加至本期的Rmb{ZCFZ_BV/10000}万元','{ZCFZ_BV1/10000},{ZCFZ_BV/10000}','','G1055','',423),
(424,'1','递延所得税负债概述','ZCFZ_BV1!=0&&ZCFZ_BV-ZCFZ_BV1>0','，增幅为{(ZCFZ_BV- ZCFZ_BV1)*100/ZCFZ_BV1}%','{(ZCFZ_BV- ZCFZ_BV1)*100/ZCFZ_BV1}','','G1055','',424),
(425,'1','递延所得税负债概述','ZCFZ_BV1!=0&&ZCFZ_BV1-ZCFZ_BV>0','递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元降低至本期的Rmb{ZCFZ_BV/10000}万元','{ZCFZ_BV1/10000},{ZCFZ_BV/10000}','','G1055','',425),
(426,'1','递延所得税负债概述','ZCFZ_BV1!=0&&ZCFZ_BV1-ZCFZ_BV>0','，降幅为{(ZCFZ_BV1- ZCFZ_BV)*100/ZCFZ_BV1}%','{(ZCFZ_BV1- ZCFZ_BV)*100/ZCFZ_BV1}','','G1055','',426),
(427,'1','其他非流动负债概述','ZCFZ_BW1!=0&&ZCFZ_BW-ZCFZ_BW1>0','其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元增加至本期的Rmb{ZCFZ_BW/10000}万元','{ZCFZ_BW1/10000},{ZCFZ_BW/10000}','','G1056','',427),
(428,'1','其他非流动负债概述','ZCFZ_BW1!=0&&ZCFZ_BW-ZCFZ_BW1>0','，增幅为{(ZCFZ_BW- ZCFZ_BW1)*100/ZCFZ_BW1}%','{(ZCFZ_BW- ZCFZ_BW1)*100/ZCFZ_BW1}','','G1056','',428),
(429,'1','其他非流动负债概述','ZCFZ_BW1!=0&&ZCFZ_BW1-ZCFZ_BW>0','其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元降低至本期的Rmb{ZCFZ_BW/10000}万元','{ZCFZ_BW1/10000},{ZCFZ_BW/10000}','','G1056','',429),
(430,'1','其他非流动负债概述','ZCFZ_BW1!=0&&ZCFZ_BW1-ZCFZ_BW>0','，降幅为{(ZCFZ_BW1- ZCFZ_BW)*100/ZCFZ_BW1}%','{(ZCFZ_BW1- ZCFZ_BW)*100/ZCFZ_BW1}','','G1056','',430),
(431,'1','实收资本（股本）概述','ZCFZ_BZ1!=0&&ZCFZ_BZ-ZCFZ_BZ1>0','实收资本（股本）从上年同期的Rmb{ZCFZ_BZ1/10000}万元增加至本期的Rmb{ZCFZ_BZ/10000}万元','{ZCFZ_BZ1/10000},{ZCFZ_BZ/10000}','','G1057','',431),
(432,'1','实收资本（股本）概述','ZCFZ_BZ1!=0&&ZCFZ_BZ-ZCFZ_BZ1>0','，增幅为{(ZCFZ_BZ- ZCFZ_BZ1)*100/ZCFZ_BZ1}%','{(ZCFZ_BZ- ZCFZ_BZ1)*100/ZCFZ_BZ1}','','G1057','',432),
(433,'1','实收资本（股本）概述','ZCFZ_BZ1!=0&&ZCFZ_BZ1-ZCFZ_BZ>0','实收资本（股本）从上年同期的Rmb{ZCFZ_BZ1/10000}万元降低至本期的Rmb{ZCFZ_BZ/10000}万元','{ZCFZ_BZ1/10000},{ZCFZ_BZ/10000}','','G1057','',433),
(434,'1','实收资本（股本）概述','ZCFZ_BZ1!=0&&ZCFZ_BZ1-ZCFZ_BZ>0','，降幅为{(ZCFZ_BZ1- ZCFZ_BZ)*100/ZCFZ_BZ1}%','{(ZCFZ_BZ1- ZCFZ_BZ)*100/ZCFZ_BZ1}','','G1057','',434),
(435,'1','其他权益工具概述','ZCFZ_CA1!=0&&ZCFZ_CA-ZCFZ_CA1>0','其他权益工具从上年同期的Rmb{ZCFZ_CA1/10000}万元增加至本期的Rmb{ZCFZ_CA/10000}万元','{ZCFZ_CA1/10000},{ZCFZ_CA/10000}','','G1058','',435),
(436,'1','其他权益工具概述','ZCFZ_CA1!=0&&ZCFZ_CA-ZCFZ_CA1>0','，增幅为{(ZCFZ_CA- ZCFZ_CA1)*100/ZCFZ_CA1}%','{(ZCFZ_CA- ZCFZ_CA1)*100/ZCFZ_CA1}','','G1058','',436),
(437,'1','其他权益工具概述','ZCFZ_CA1!=0&&ZCFZ_CA1-ZCFZ_CA>0','其他权益工具从上年同期的Rmb{ZCFZ_CA1/10000}万元降低至本期的Rmb{ZCFZ_CA/10000}万元','{ZCFZ_CA1/10000},{ZCFZ_CA/10000}','','G1058','',437),
(438,'1','其他权益工具概述','ZCFZ_CA1!=0&&ZCFZ_CA1-ZCFZ_CA>0','，降幅为{(ZCFZ_CA1- ZCFZ_CA)*100/ZCFZ_CA1}%','{(ZCFZ_CA1- ZCFZ_CA)*100/ZCFZ_CA1}','','G1058','',438),
(439,'1','优先股概述','ZCFZ_CB>ZCFZ_CB1','优先股从上年同期的Rmb{ZCFZ_CB1/10000}万元增加至本期的Rmb{ZCFZ_CB/10000}万元','{ZCFZ_CB1/10000},{ZCFZ_CB/10000}','','G1059','',439),
(440,'1','优先股概述','ZCFZ_CB>ZCFZ_CB1','，增幅为{(ZCFZ_CB- ZCFZ_CB1)*100/ZCFZ_CB1}%','{(ZCFZ_CB- ZCFZ_CB1)*100/ZCFZ_CB1}','','G1059','',440),
(441,'1','优先股概述','ZCFZ_CB1>ZCFZ_CB','优先股从上年同期的Rmb{ZCFZ_CB1/10000}万元降低至本期的Rmb{ZCFZ_CB/10000}万元','{ZCFZ_CB1/10000},{ZCFZ_CB/10000}','','G1059','',441),
(442,'1','优先股概述','ZCFZ_CB1>ZCFZ_CB','，降幅为{(ZCFZ_CB1- ZCFZ_CB)*100/ZCFZ_CB1}%','{(ZCFZ_CB1- ZCFZ_CB)*100/ZCFZ_CB1}','','G1059','',442),
(443,'1','永续债概述','ZCFZ_CC>ZCFZ_CC1','永续债从上年同期的Rmb{ZCFZ_CC1/10000}万元增加至本期的Rmb{ZCFZ_CC/10000}万元','{ZCFZ_CC1/10000},{ZCFZ_CC/10000}','','G1060','',443),
(444,'1','永续债概述','ZCFZ_CC>ZCFZ_CC1','，增幅为{(ZCFZ_CC- ZCFZ_CC1)*100/ZCFZ_CC1}%','{(ZCFZ_CC- ZCFZ_CC1)*100/ZCFZ_CC1}','','G1060','',444),
(445,'1','永续债概述','ZCFZ_CC1>ZCFZ_CC','永续债从上年同期的Rmb{ZCFZ_CC1/10000}万元降低至本期的Rmb{ZCFZ_CC/10000}万元','{ZCFZ_CC1/10000},{ZCFZ_CC/10000}','','G1060','',445),
(446,'1','永续债概述','ZCFZ_CC1>ZCFZ_CC','，降幅为{(ZCFZ_CC1- ZCFZ_CC)*100/ZCFZ_CC1}%','{(ZCFZ_CC1- ZCFZ_CC)*100/ZCFZ_CC1}','','G1060','',446),
(447,'1','资本公积概述','ZCFZ_CD1!=0&&ZCFZ_CD-ZCFZ_CD1>0','资本公积从上年同期的Rmb{ZCFZ_CD1/10000}万元增加至本期的Rmb{ZCFZ_CD/10000}万元','{ZCFZ_CD1/10000},{ZCFZ_CD/10000}','','G1061','',447),
(448,'1','资本公积概述','ZCFZ_CD1!=0&&ZCFZ_CD-ZCFZ_CD1>0','，增幅为{(ZCFZ_CD- ZCFZ_CD1)*100/ZCFZ_CD1}%','{(ZCFZ_CD- ZCFZ_CD1)*100/ZCFZ_CD1}','','G1061','',448),
(449,'1','资本公积概述','ZCFZ_CD1!=0&&ZCFZ_CD1-ZCFZ_CD>0','资本公积从上年同期的Rmb{ZCFZ_CD1/10000}万元降低至本期的Rmb{ZCFZ_CD/10000}万元','{ZCFZ_CD1/10000},{ZCFZ_CD/10000}','','G1061','',449),
(450,'1','资本公积概述','ZCFZ_CD1!=0&&ZCFZ_CD1-ZCFZ_CD>0','，降幅为{(ZCFZ_CD1- ZCFZ_CD)*100/ZCFZ_CD1}%','{(ZCFZ_CD1- ZCFZ_CD)*100/ZCFZ_CD1}','','G1061','',450),
(451,'1','库存股概述','ZCFZ_CE1!=0&&ZCFZ_CE>ZCFZ_CE1','库存股从上年同期的Rmb{ZCFZ_CE1/10000}万元增加至本期的Rmb{ZCFZ_CE/10000}万元','{ZCFZ_CE1/10000},{ZCFZ_CE/10000}','','G1062','',451),
(452,'1','库存股概述','ZCFZ_CE1!=0&&ZCFZ_CE>ZCFZ_CE1','，增幅为{(ZCFZ_CE- ZCFZ_CE1)*100/ZCFZ_CE1}%','{(ZCFZ_CE- ZCFZ_CE1)*100/ZCFZ_CE1}','','G1062','',452),
(453,'1','库存股概述','ZCFZ_CE1!=0&&ZCFZ_CE1>ZCFZ_CE','库存股从上年同期的Rmb{ZCFZ_CE1/10000}万元降低至本期的Rmb{ZCFZ_CE/10000}万元','{ZCFZ_CE1/10000},{ZCFZ_CE/10000}','','G1062','',453),
(454,'1','库存股概述','ZCFZ_CE1!=0&&ZCFZ_CE1>ZCFZ_CE','，降幅为{(ZCFZ_CE1- ZCFZ_CE)*100/ZCFZ_CE1}%','{(ZCFZ_CE1- ZCFZ_CE)*100/ZCFZ_CE1}','','G1062','',454),
(455,'1','其他综合收益概述','ZCFZ_CF1!=0&&ZCFZ_CF-ZCFZ_CF1>0','其他综合收益从上年同期的Rmb{ZCFZ_CF1/10000}万元增加至本期的Rmb{ZCFZ_CF/10000}万元','{ZCFZ_CF1/10000},{ZCFZ_CF/10000}','','G1063','',455),
(456,'1','其他综合收益概述','ZCFZ_CF1!=0&&ZCFZ_CF-ZCFZ_CF1>0','，增幅为{(ZCFZ_CF- ZCFZ_CF1)*100/ZCFZ_CF1}%','{(ZCFZ_CF- ZCFZ_CF1)*100/ZCFZ_CF1}','','G1063','',456),
(457,'1','其他综合收益概述','ZCFZ_CF1!=0&&ZCFZ_CF1-ZCFZ_CF>0','其他综合收益从上年同期的Rmb{ZCFZ_CF1/10000}万元降低至本期的Rmb{ZCFZ_CF/10000}万元','{ZCFZ_CF1/10000},{ZCFZ_CF/10000}','','G1063','',457),
(458,'1','其他综合收益概述','ZCFZ_CF1!=0&&ZCFZ_CF1-ZCFZ_CF>0','，降幅为{(ZCFZ_CF1- ZCFZ_CF)*100/ZCFZ_CF1}%','{(ZCFZ_CF1- ZCFZ_CF)*100/ZCFZ_CF1}','','G1063','',458),
(459,'1','未分配利润概述','ZCFZ_CJ1!=0&&ZCFZ_CJ-ZCFZ_CJ1>0','未分配利润从上年同期的Rmb{ZCFZ_CJ1/10000}万元增加至本期的Rmb{ZCFZ_CJ/10000}万元','{ZCFZ_CJ1/10000},{ZCFZ_CJ/10000}','','G1064','',459),
(460,'1','未分配利润概述','ZCFZ_CJ1!=0&&ZCFZ_CJ-ZCFZ_CJ1>0','，增幅为{(ZCFZ_CJ-ZCFZ_CJ1)*100/Math.abs(ZCFZ_CJ1)}%','{(ZCFZ_CJ-ZCFZ_CJ1)*100/Math.abs(ZCFZ_CJ1)}','','G1064','',460),
(461,'1','未分配利润概述','ZCFZ_CJ1!=0&&ZCFZ_CJ1-ZCFZ_CJ>0','未分配利润从上年同期的Rmb{ZCFZ_CJ1/10000}万元降低至本期的Rmb{ZCFZ_CJ/10000}万元','{ZCFZ_CJ1/10000},{ZCFZ_CJ/10000}','','G1064','',461),
(462,'1','未分配利润概述','ZCFZ_CJ1!=0&&ZCFZ_CJ1-ZCFZ_CJ>0','，降幅为{(ZCFZ_CJ1- ZCFZ_CJ)*100/Math.abs(ZCFZ_CJ1)}%','{(ZCFZ_CJ1- ZCFZ_CJ)*100/Math.abs(ZCFZ_CJ1)}','','G1064','',462),
(463,'1','货币资金概述','ZCFZ_A1!=0&&ZCFZ_A-ZCFZ_A1>0','货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元增加至本期的Rmb{ZCFZ_A/10000}万元','{ZCFZ_A1/10000},{ZCFZ_A/10000}','','G1065','',463),
(464,'1','货币资金概述','ZCFZ_A1!=0&&ZCFZ_A-ZCFZ_A1>0','，增幅为{(ZCFZ_A- ZCFZ_A1)*100/ZCFZ_A1}%','{(ZCFZ_A- ZCFZ_A1)*100/ZCFZ_A1}','','G1065','',464),
(465,'1','货币资金概述','ZCFZ_A1!=0&&ZCFZ_A1-ZCFZ_A>0','货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元降低至本期的Rmb{ZCFZ_A/10000}万元','{ZCFZ_A1/10000},{ZCFZ_A/10000}','','G1065','',465),
(466,'1','货币资金概述','ZCFZ_A1!=0&&ZCFZ_A1-ZCFZ_A>0','，降幅为{(ZCFZ_A1- ZCFZ_A)*100/ZCFZ_A1}%','{(ZCFZ_A1- ZCFZ_A)*100/ZCFZ_A1}','','G1065','',466),
(467,'3','销售商品、提供劳务收到的现金概述','XJLL_A1!=0&&XJLL_A-XJLL_A1>0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，较上年同期增加了Rmb{(XJLL_A-XJLL_A1)/10000}万元','{XJLL_A/10000},{(XJLL_A-XJLL_A1)/10000}','','G3004','',467),
(468,'3','销售商品、提供劳务收到的现金概述','XJLL_A1!=0&&XJLL_A-XJLL_A1>0','，增幅为{(XJLL_A- XJLL_A1)*100/Math.abs(XJLL_A1)}%。','{(XJLL_A- XJLL_A1)*100/Math.abs(XJLL_A1)}','','G3004','',468),
(469,'3','销售商品、提供劳务收到的现金概述','XJLL_A1!=0&&XJLL_A1-XJLL_A>0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，较上年同期减少了Rmb{(XJLL_A1-XJLL_A)/10000}万元','{XJLL_A/10000},{(XJLL_A1-XJLL_A)/10000}','','G3004','',469),
(470,'3','销售商品、提供劳务收到的现金概述','XJLL_A1!=0&&XJLL_A1-XJLL_A>0','，降幅为{(XJLL_A1- XJLL_A)*100/Math.abs(XJLL_A1)}%。','{(XJLL_A1- XJLL_A)*100/Math.abs(XJLL_A1)}','','G3004','',470),
(471,'3','收到的税费返还概述','XJLL_L1!=0&&XJLL_L-XJLL_L1>0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，较上年同期增加了Rmb{(XJLL_L-XJLL_L1)/10000}万元','{XJLL_L/10000},{(XJLL_L-XJLL_L1)/10000}','','G3005','',471),
(472,'3','收到的税费返还概述','XJLL_L1!=0&&XJLL_L-XJLL_L1>0','，增幅为{(XJLL_L- XJLL_L1)*100/Math.abs(XJLL_L1)}%。','{(XJLL_L- XJLL_L1)*100/Math.abs(XJLL_L1)}','','G3005','',472),
(473,'3','收到的税费返还概述','XJLL_L1!=0&&XJLL_L1-XJLL_L>0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，较上年同期减少了Rmb{(XJLL_L1-XJLL_L)/10000}万元','{XJLL_L/10000},{(XJLL_L1-XJLL_L)/10000}','','G3005','',473),
(474,'3','收到的税费返还概述','XJLL_L1!=0&&XJLL_L1-XJLL_L>0','，降幅为{(XJLL_L1- XJLL_L)*100/Math.abs(XJLL_L1)}%。','{(XJLL_L1- XJLL_L)*100/Math.abs(XJLL_L1)}','','G3005','',474),
(475,'3','收到其他与经营活动有关的现金概述','XJLL_M1!=0&&XJLL_M-XJLL_M1>0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，较上年同期增加了Rmb{(XJLL_M-XJLL_M1)/10000}万元','{XJLL_M/10000},{(XJLL_M-XJLL_M1)/10000}','','G3006','',475),
(476,'3','收到其他与经营活动有关的现金概述','XJLL_M1!=0&&XJLL_M-XJLL_M1>0','，增幅为{(XJLL_M- XJLL_M1)*100/Math.abs(XJLL_M1)}%。','{(XJLL_M- XJLL_M1)*100/Math.abs(XJLL_M1)}','','G3006','',476),
(477,'3','收到其他与经营活动有关的现金概述','XJLL_M1!=0&&XJLL_M1-XJLL_M>0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，较上年同期减少Rmb{(XJLL_M1-XJLL_M)/10000}万元','{XJLL_M/10000},{(XJLL_M1-XJLL_M)/10000}','','G3006','',477),
(478,'3','收到其他与经营活动有关的现金概述','XJLL_M1!=0&&XJLL_M1-XJLL_M>0','，降幅为{(XJLL_M1- XJLL_M)*100/Math.abs(XJLL_M1)}%。','{(XJLL_M1- XJLL_M)*100/Math.abs(XJLL_M1)}','','G3006','',478),
(479,'3','购买商品、接受劳务支付的现金概述','XJLL_O1!=0&&XJLL_O-XJLL_O1>0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，较上年同期增加了Rmb{(XJLL_O-XJLL_O1)/10000}万元','{XJLL_O/10000},{(XJLL_O-XJLL_O1)/10000}','','G3007','',479),
(480,'3','购买商品、接受劳务支付的现金概述','XJLL_O1!=0&&XJLL_O-XJLL_O1>0','，增幅为{(XJLL_O- XJLL_O1)*100/Math.abs(XJLL_O1)}%。','{(XJLL_O- XJLL_O1)*100/Math.abs(XJLL_O1)}','','G3007','',480),
(481,'3','购买商品、接受劳务支付的现金概述','XJLL_O1!=0&&XJLL_O1-XJLL_O>0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，较上年同期减少了Rmb{(XJLL_O1-XJLL_O)/10000}万元','{XJLL_O/10000},{(XJLL_O1-XJLL_O)/10000}','','G3007','',481),
(482,'3','购买商品、接受劳务支付的现金概述','XJLL_O1!=0&&XJLL_O1-XJLL_O>0','，降幅为{(XJLL_O1- XJLL_O)*100/Math.abs(XJLL_O1)}%。','{(XJLL_O1- XJLL_O)*100/Math.abs(XJLL_O1)}','','G3007','',482),
(483,'3','支付给职工以及为职工支付的现金概述','XJLL_U1!=0 && XJLL_U-XJLL_U1>0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，较上年同期增加了Rmb{(XJLL_U-XJLL_U1)/10000}万元','{XJLL_U/10000},{(XJLL_U-XJLL_U1)/10000}','','G3008','',483),
(484,'3','支付给职工以及为职工支付的现金概述','XJLL_U1!=0&& XJLL_U-XJLL_U1>0','，增幅为{(XJLL_U- XJLL_U1)*100/Math.abs(XJLL_U1)}%。','{(XJLL_U- XJLL_U1)*100/Math.abs(XJLL_U1)}','','G3008','',484),
(485,'3','支付给职工以及为职工支付的现金概述','XJLL_U1!=0&&XJLL_U1-XJLL_U>0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，较上年同期减少了Rmb{(XJLL_U1-XJLL_U)/10000}万元','{XJLL_U/10000},{(XJLL_U1-XJLL_U)/10000}','','G3008','',485),
(486,'3','支付给职工以及为职工支付的现金概述','XJLL_U1!=0&&XJLL_U1-XJLL_U>0','，降幅为{(XJLL_U1- XJLL_U)*100/Math.abs(XJLL_U1)}%。','{(XJLL_U1- XJLL_U)*100/Math.abs(XJLL_U1)}','','G3008','',486),
(487,'3','支付的各项税费概述','XJLL_V1!=0&&XJLL_V>XJLL_V1','本期支付的各项税费为Rmb{XJLL_V/10000}万元，较上年同期增加了Rmb{(XJLL_V-XJLL_V1)/10000}万元','{XJLL_V/10000},{(XJLL_V-XJLL_V1)/10000}','','G3009','',487),
(488,'3','支付的各项税费概述','XJLL_V1!=0&&XJLL_V>XJLL_V1','，增幅为{(XJLL_V- XJLL_V1)*100/Math.abs(XJLL_V1)}%。','{(XJLL_V- XJLL_V1)*100/Math.abs(XJLL_V1)}','','G3009','',488),
(489,'3','支付的各项税费概述','XJLL_V1!=0&&XJLL_V1>XJLL_V','本期支付的各项税费为Rmb{XJLL_V/10000}万元，较上年同期减少了Rmb{(XJLL_V1-XJLL_V)/10000}万元','{XJLL_V/10000},{(XJLL_V1-XJLL_V)/10000}','','G3009','',489),
(490,'3','支付的各项税费概述','XJLL_V1!=0&&XJLL_V1>XJLL_V','，降幅为{(XJLL_V1- XJLL_V)*100/Math.abs(XJLL_V1)}%。','{(XJLL_V1- XJLL_V)*100/Math.abs(XJLL_V1)}','','G3009','',490),
(491,'3','支付其他与经营活动有关的现金概述','XJLL_W1!=0&&XJLL_W-XJLL_W1>0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，较上年同期增加了Rmb{(XJLL_W-XJLL_W1)/10000}万元','{XJLL_W/10000},{(XJLL_W-XJLL_W1)/10000}','','G3010','',491),
(492,'3','支付其他与经营活动有关的现金概述','XJLL_W1!=0&&XJLL_W-XJLL_W1>0','，增幅为{(XJLL_W- XJLL_W1)*100/Math.abs(XJLL_W1)}%。','{(XJLL_W- XJLL_W1)*100/Math.abs(XJLL_W1)}','','G3010','',492),
(493,'3','支付其他与经营活动有关的现金概述','XJLL_W1!=0&&XJLL_W1-XJLL_W>0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，较上年同期减少了Rmb{(XJLL_W1-XJLL_W)/10000}万元','{XJLL_W/10000},{(XJLL_W1-XJLL_W)/10000}','','G3010','',493),
(494,'3','支付其他与经营活动有关的现金概述','XJLL_W1!=0&&XJLL_W1-XJLL_W>0','，降幅为{(XJLL_W1- XJLL_W)*100/Math.abs(XJLL_W1)}%。','{(XJLL_W1- XJLL_W)*100/Math.abs(XJLL_W1)}','','G3010','',494),
(495,'3','收回投资收到的现金概述','XJLL_AA1!=0&&XJLL_AA-XJLL_AA1>0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，较上年同期增加了Rmb{(XJLL_AA-XJLL_AA1)/10000}万元','{XJLL_AA/10000},{(XJLL_AA-XJLL_AA1)/10000}','','G3011','',495),
(496,'3','收回投资收到的现金概述','XJLL_AA1!=0&&XJLL_AA-XJLL_AA1>0','，增幅为{(XJLL_AA- XJLL_AA1)*100/Math.abs(XJLL_AA1)}%。','{(XJLL_AA- XJLL_AA1)*100/Math.abs(XJLL_AA1)}','','G3011','',496),
(497,'3','收回投资收到的现金概述','XJLL_AA1!=0&&XJLL_AA1-XJLL_AA>0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，较上年同期减少了Rmb{(XJLL_AA1-XJLL_AA)/10000}万元','{XJLL_AA/10000},{(XJLL_AA1-XJLL_AA)/10000}','','G3011','',497),
(498,'3','收回投资收到的现金概述','XJLL_AA1!=0&&XJLL_AA1-XJLL_AA>0','，降幅为{(XJLL_AA1- XJLL_AA)*100/Math.abs(XJLL_AA1)}%。','{(XJLL_AA1- XJLL_AA)*100/Math.abs(XJLL_AA1)}','','G3011','',498),
(499,'3','取得投资收益收到的现金概述','XJLL_AB1!=0&&XJLL_AB-XJLL_AB1>0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，较上年同期增加了Rmb{(XJLL_AB-XJLL_AB1)/10000}万元','{XJLL_AB/10000},{(XJLL_AB-XJLL_AB1)/10000}','','G3012','',499),
(500,'3','取得投资收益收到的现金概述','XJLL_AB1!=0&&XJLL_AB-XJLL_AB1>0','，增幅为{(XJLL_AB- XJLL_AB1)*100/Math.abs(XJLL_AB1)}%。','{(XJLL_AB- XJLL_AB1)*100/Math.abs(XJLL_AB1)}','','G3012','',500),
(501,'3','取得投资收益收到的现金概述','XJLL_AB1!=0&&XJLL_AB1-XJLL_AB>0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，较上年同期减少了Rmb{(XJLL_AB1-XJLL_AB)/10000}万元','{XJLL_AB/10000},{(XJLL_AB1-XJLL_AB)/10000}','','G3012','',501),
(502,'3','取得投资收益收到的现金概述','XJLL_AB1!=0&&XJLL_AB1-XJLL_AB>0','，降幅为{(XJLL_AB1- XJLL_AB)*100/Math.abs(XJLL_AB1)}%。','{(XJLL_AB1- XJLL_AB)*100/Math.abs(XJLL_AB1)}','','G3012','',502),
(503,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1!=0&&XJLL_AC-XJLL_AC1>0','本期处置固定资产、无形资产和其他长期资产收回的现金净额为Rmb{XJLL_AC/10000}万元，较上年同期增加Rmb{(XJLL_AC-XJLL_AC1)/10000}万元','{XJLL_AC/10000},{(XJLL_AC-XJLL_AC1)/10000}','','G3013','',503),
(504,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1!=0&&XJLL_AC-XJLL_AC1>0','，增幅为{(XJLL_AC- XJLL_AC1)*100/Math.abs(XJLL_AC1)}%。','{(XJLL_AC- XJLL_AC1)*100/Math.abs(XJLL_AC1)}','','G3013','',504),
(505,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1!=0&&XJLL_AC1-XJLL_AC>0','本期处置固定资产、无形资产和其他长期资产收回的现金净额为Rmb{XJLL_AC/10000}万元，较上年同期减少Rmb{(XJLL_AC1-XJLL_AC)/10000}万元','{XJLL_AC/10000},{(XJLL_AC1-XJLL_AC)/10000}','','G3013','',505),
(506,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1!=0&&XJLL_AC1-XJLL_AC>0','，降幅为{(XJLL_AC1- XJLL_AC)*100/Math.abs(XJLL_AC1)}%。','{(XJLL_AC1- XJLL_AC)*100/Math.abs(XJLL_AC1)}','','G3013','',506),
(507,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1!=0&&XJLL_AD-XJLL_AD1>0','本期处置子公司及其他经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，较上年同期增加Rmb{(XJLL_AD-XJLL_AD1)/10000}万元','{XJLL_AD/10000},{(XJLL_AD-XJLL_AD1)/10000}','','G3014','',507),
(508,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1!=0&&XJLL_AD-XJLL_AD1>0','，增幅为{(XJLL_AD- XJLL_AD1)*100/Math.abs(XJLL_AD1)}%。','{(XJLL_AD- XJLL_AD1)*100/Math.abs(XJLL_AD1)}','','G3014','',508),
(509,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1!=0&&XJLL_AD1-XJLL_AD>0','本期处置子公司及其他经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，较上年同期减少Rmb{(XJLL_AD1-XJLL_AD)/10000}万元','{XJLL_AD/10000},{(XJLL_AD1-XJLL_AD)/10000}','','G3014','',509),
(510,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1!=0&&XJLL_AD1-XJLL_AD>0','，降幅为{(XJLL_AD1- XJLL_AD)*100/Math.abs(XJLL_AD1)}%。','{(XJLL_AD1- XJLL_AD)*100/Math.abs(XJLL_AD1)}','','G3014','',510),
(511,'3','收到其他与投资活动有关的现金概述','XJLL_AE1!=0&&XJLL_AE-XJLL_AE1>0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，较上年同期增加Rmb{(XJLL_AE-XJLL_AE1)/10000}万元，增幅为{(XJLL_AE- XJLL_AE1)*100/Math.abs(XJLL_AE1)}%。','{XJLL_AE/10000},{(XJLL_AE-XJLL_AE1)/10000},{(XJLL_AE- XJLL_AE1)*100/Math.abs(XJLL_AE1)}','','G3015','',511),
(513,'3','收到其他与投资活动有关的现金概述','XJLL_AE1!=0&&XJLL_AE1-XJLL_AE>0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，较上年同期减少Rmb{(XJLL_AE1-XJLL_AE)/10000}万元','{XJLL_AE/10000},{(XJLL_AE1-XJLL_AE)/10000}','','G3015','',513),
(514,'3','收到其他与投资活动有关的现金概述','XJLL_AE1!=0&&XJLL_AE1-XJLL_AE>0','，降幅为{(XJLL_AE1- XJLL_AE)*100/Math.abs(XJLL_AE1)}%。','{(XJLL_AE1- XJLL_AE)*100/Math.abs(XJLL_AE1)}','','G3015','',514),
(515,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1!=0&&XJLL_AG-XJLL_AG1>0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，较上年同期增加Rmb{(XJLL_AG-XJLL_AG1)/10000}万元','{XJLL_AG/10000},{(XJLL_AG-XJLL_AG1)/10000}','','G3016','',515),
(516,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1!=0&&XJLL_AG-XJLL_AG1>0','，增幅为{(XJLL_AG- XJLL_AG1)*100/Math.abs(XJLL_AG1)}%。','{(XJLL_AG- XJLL_AG1)*100/Math.abs(XJLL_AG1)}','','G3016','',516),
(517,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1!=0&&XJLL_AG1-XJLL_AG>0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，较上年同期减少Rmb{(XJLL_AG1-XJLL_AG)/10000}万元','{XJLL_AG/10000},{(XJLL_AG1-XJLL_AG)/10000}','','G3016','',517),
(518,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1!=0&&XJLL_AG1-XJLL_AG>0','，降幅为{(XJLL_AG1- XJLL_AG)*100/Math.abs(XJLL_AG1)}%。','{(XJLL_AG1- XJLL_AG)*100/Math.abs(XJLL_AG1)}','','G3016','',518),
(519,'3','投资支付的现金概述','XJLL_AH1!=0&&XJLL_AH-XJLL_AH1>0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，较上年同期增加Rmb{(XJLL_AH-XJLL_AH1)/10000}万元','{XJLL_AH/10000},{(XJLL_AH-XJLL_AH1)/10000}','','G3017','',519),
(520,'3','投资支付的现金概述','XJLL_AH1!=0&&XJLL_AH-XJLL_AH1>0','，增幅为{(XJLL_AH- XJLL_AH1)*100/Math.abs(XJLL_AH1)}%。','{(XJLL_AH- XJLL_AH1)*100/Math.abs(XJLL_AH1)}','','G3017','',520),
(521,'3','投资支付的现金概述','XJLL_AH1!=0&&XJLL_AH1-XJLL_AH>0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，较上年同期减少Rmb{(XJLL_AH1-XJLL_AH)/10000}万元','{XJLL_AH/10000},{(XJLL_AH1-XJLL_AH)/10000}','','G3017','',521),
(522,'3','投资支付的现金概述','XJLL_AH1!=0&&XJLL_AH1-XJLL_AH>0','，降幅为{(XJLL_AH1- XJLL_AH)*100/Math.abs(XJLL_AH1)}%。','{(XJLL_AH1- XJLL_AH)*100/Math.abs(XJLL_AH1)}','','G3017','',522),
(523,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1!=0&&XJLL_AJ-XJLL_AJ1>0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，较上年同期增加Rmb{(XJLL_AJ-XJLL_AJ1)/10000}万元','{XJLL_AJ/10000},{(XJLL_AJ-XJLL_AJ1)/10000}','','G3018','',523),
(524,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1!=0&&XJLL_AJ-XJLL_AJ1>0','，增幅为{(XJLL_AJ- XJLL_AJ1)*100/Math.abs(XJLL_AJ1)}%。','{(XJLL_AJ- XJLL_AJ1)*100/Math.abs(XJLL_AJ1)}','','G3018','',524),
(525,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1!=0&&XJLL_AJ1-XJLL_AJ>0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，较上年同期减少Rmb{(XJLL_AJ1-XJLL_AJ)/10000}万元','{XJLL_AJ/10000},{(XJLL_AJ1-XJLL_AJ)/10000}','','G3018','',525),
(526,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1!=0&&XJLL_AJ1-XJLL_AJ>0','，降幅为{(XJLL_AJ1- XJLL_AJ)*100/Math.abs(XJLL_AJ1)}%。','{(XJLL_AJ1- XJLL_AJ)*100/Math.abs(XJLL_AJ1)}','','G3018','',526),
(527,'3','支付其他与投资活动有关的现金概述','XJLL_AK1!=0&&XJLL_AK-XJLL_AK1>0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，较上年同期增加Rmb{(XJLL_AK-XJLL_AK1)/10000}万元','{XJLL_AK/10000},{(XJLL_AK-XJLL_AK1)/10000}','','G3019','',527),
(528,'3','支付其他与投资活动有关的现金概述','XJLL_AK1!=0&&XJLL_AK-XJLL_AK1>0','，增幅为{(XJLL_AK- XJLL_AK1)*100/Math.abs(XJLL_AK1)}%。','{(XJLL_AK- XJLL_AK1)*100/Math.abs(XJLL_AK1)}','','G3019','',528),
(529,'3','支付其他与投资活动有关的现金概述','XJLL_AK1!=0&&XJLL_AK1-XJLL_AK>0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，较上年同期减少Rmb{(XJLL_AK1-XJLL_AK)/10000}万元','{XJLL_AK/10000},{(XJLL_AK1-XJLL_AK)/10000}','','G3019','',529),
(530,'3','支付其他与投资活动有关的现金概述','XJLL_AK1!=0&&XJLL_AK1-XJLL_AK>0','，降幅为{(XJLL_AK1- XJLL_AK)*100/Math.abs(XJLL_AK1)}%。','{(XJLL_AK1- XJLL_AK)*100/Math.abs(XJLL_AK1)}','','G3019','',530),
(531,'3','吸收投资收到的现金概述','XJLL_AO1!=0&&XJLL_AO-XJLL_AO1>0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，较上年同期增加Rmb{(XJLL_AO-XJLL_AO1)/10000}万元','{XJLL_AO/10000},{(XJLL_AO-XJLL_AO1)/10000}','','G3020','',531),
(532,'3','吸收投资收到的现金概述','XJLL_AO1!=0&&XJLL_AO-XJLL_AO1>0','，增幅为{(XJLL_AO- XJLL_AO1)*100/Math.abs(XJLL_AO1)}%。','{(XJLL_AO- XJLL_AO1)*100/Math.abs(XJLL_AO1)}','','G3020','',532),
(533,'3','吸收投资收到的现金概述','XJLL_AO1!=0&&XJLL_AO1-XJLL_AO>0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，较上年同期减少Rmb{(XJLL_AO1-XJLL_AO)/10000}万元','{XJLL_AO/10000},{(XJLL_AO1-XJLL_AO)/10000}','','G3020','',533),
(534,'3','吸收投资收到的现金概述','XJLL_AO1!=0&&XJLL_AO1-XJLL_AO>0','，降幅为{(XJLL_AO1- XJLL_AO)*100/Math.abs(XJLL_AO1)}%。','{(XJLL_AO1- XJLL_AO)*100/Math.abs(XJLL_AO1)}','','G3020','',534),
(535,'3','取得借款收到的现金概述','XJLL_AQ1!=0&&XJLL_AQ-XJLL_AQ1>0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，较上年同期增加Rmb{(XJLL_AQ-XJLL_AQ1)/10000}万元','{XJLL_AQ/10000},{(XJLL_AQ-XJLL_AQ1)/10000}','','G3021','',535),
(536,'3','取得借款收到的现金概述','XJLL_AQ1!=0&&XJLL_AQ-XJLL_AQ1>0','，增幅为{(XJLL_AQ- XJLL_AQ1)*100/Math.abs(XJLL_AQ1)}%。','{(XJLL_AQ- XJLL_AQ1)*100/Math.abs(XJLL_AQ1)}','','G3021','',536),
(537,'3','取得借款收到的现金概述','XJLL_AQ1!=0&&XJLL_AQ1-XJLL_AQ>0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，较上年同期减少Rmb{(XJLL_AQ1-XJLL_AQ)/10000}万元','{XJLL_AQ/10000},{(XJLL_AQ1-XJLL_AQ)/10000}','','G3021','',537),
(538,'3','取得借款收到的现金概述','XJLL_AQ1!=0&&XJLL_AQ1-XJLL_AQ>0','，降幅为{(XJLL_AQ1- XJLL_AQ)*100/Math.abs(XJLL_AQ1)}%。','{(XJLL_AQ1- XJLL_AQ)*100/Math.abs(XJLL_AQ1)}','','G3021','',538),
(539,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1!=0&&XJLL_AS-XJLL_AS1>0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，较上年同期增加Rmb{(XJLL_AS-XJLL_AS1)/10000}万元','{XJLL_AS/10000},{(XJLL_AS-XJLL_AS1)/10000}','','G3022','',539),
(540,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1!=0&&XJLL_AS-XJLL_AS1>0','，增幅为{(XJLL_AS- XJLL_AS1)*100/Math.abs(XJLL_AS1)}%。','{(XJLL_AS- XJLL_AS1)*100/Math.abs(XJLL_AS1)}','','G3022','',540),
(541,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1!=0&&XJLL_AS1-XJLL_AS>0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，较上年同期减少Rmb{(XJLL_AS1-XJLL_AS)/10000}万元','{XJLL_AS/10000},{(XJLL_AS1-XJLL_AS)/10000}','','G3022','',541),
(542,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1!=0&&XJLL_AS1-XJLL_AS>0','，降幅为{(XJLL_AS1- XJLL_AS)*100/Math.abs(XJLL_AS1)}%。','{(XJLL_AS1- XJLL_AS)*100/Math.abs(XJLL_AS1)}','','G3022','',542),
(543,'3','偿还债务支付的现金概述','XJLL_AU1!=0&&XJLL_AU-XJLL_AU1>0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，较上年同期增加Rmb{(XJLL_AU-XJLL_AU1)/10000}万元','{XJLL_AU/10000},{(XJLL_AU-XJLL_AU1)/10000}','','G3023','',543),
(544,'3','偿还债务支付的现金概述','XJLL_AU1!=0&&XJLL_AU-XJLL_AU1>0','，增幅为{(XJLL_AU- XJLL_AU1)*100/Math.abs(XJLL_AU1)}%。','{(XJLL_AU- XJLL_AU1)*100/Math.abs(XJLL_AU1)}','','G3023','',544),
(545,'3','偿还债务支付的现金概述','XJLL_AU1!=0&&XJLL_AU1-XJLL_AU>0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，较上年同期减少Rmb{(XJLL_AU1-XJLL_AU)/10000}万元','{XJLL_AU/10000},{(XJLL_AU1-XJLL_AU)/10000}','','G3023','',545),
(546,'3','偿还债务支付的现金概述','XJLL_AU1!=0&&XJLL_AU1-XJLL_AU>0','，降幅为{(XJLL_AU1- XJLL_AU)*100/Math.abs(XJLL_AU1)}%。','{(XJLL_AU1- XJLL_AU)*100/Math.abs(XJLL_AU1)}','','G3023','',546),
(547,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1!=0&&XJLL_AV-XJLL_AV1>0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，较上年同期增加Rmb{(XJLL_AV-XJLL_AV1)/10000}万元','{XJLL_AV/10000},{(XJLL_AV-XJLL_AV1)/10000}','','G3024','',547),
(548,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1!=0&&XJLL_AV-XJLL_AV1>0','，增幅为{(XJLL_AV- XJLL_AV1)*100/Math.abs(XJLL_AV1)}%。','{(XJLL_AV- XJLL_AV1)*100/Math.abs(XJLL_AV1)}','','G3024','',548),
(549,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1!=0&&XJLL_AV1-XJLL_AV>0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，较上年同期减少Rmb{(XJLL_AV1-XJLL_AV)/10000}万元','{XJLL_AV/10000},{(XJLL_AV1-XJLL_AV)/10000}','','G3024','',549),
(550,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1!=0&&XJLL_AV1-XJLL_AV>0','，降幅为{(XJLL_AV1- XJLL_AV)*100/Math.abs(XJLL_AV1)}%。','{(XJLL_AV1- XJLL_AV)*100/Math.abs(XJLL_AV1)}','','G3024','',550),
(551,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1!=0&&XJLL_AX -  XJLL_AX1>0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，较上年同期增加Rmb{(XJLL_AX-XJLL_AX1)/10000}万元','{XJLL_AX/10000},{(XJLL_AX-XJLL_AX1)/10000}','','G3025','',551),
(552,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1!=0&&XJLL_AX - XJLL_AX1>0','，增幅为{(XJLL_AX- XJLL_AX1)*100/Math.abs(XJLL_AX1)}%。','{(XJLL_AX- XJLL_AX1)*100/Math.abs(XJLL_AX1)}','','G3025','',552),
(553,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1!=0&&XJLL_AX1-XJLL_AX>0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，较上年同期减少Rmb{(XJLL_AX1-XJLL_AX)/10000}万元','{XJLL_AX/10000},{(XJLL_AX1-XJLL_AX)/10000}','','G3025','',553),
(554,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1!=0&&XJLL_AX1-XJLL_AX>0','，降幅为{(XJLL_AX1- XJLL_AX)*100/Math.abs(XJLL_AX1)}%。','{(XJLL_AX1- XJLL_AX)*100/Math.abs(XJLL_AX1)}','','G3025','',554),
(555,'2','营业成本概述','LR_F1!=0 && LR_F-LR_F1>0','营业成本从上年同期的Rmb{LR_F1/10000}万元增长至本期的Rmb{LR_F/10000}万元','{LR_F1/10000},{LR_F/10000}','','G2015','',555),
(556,'2','营业成本概述','LR_F1!=0 && LR_F-LR_F1>0','，增幅为{(LR_F- LR_F1)*100/LR_F1}%。','{(LR_F- LR_F1)*100/LR_F1}','','G2015','',556),
(557,'2','营业成本概述','LR_F1!=0 && LR_F1-LR_F>0','营业成本从上年同期的Rmb{LR_F1/10000}万元下降至本期的Rmb{LR_F/10000}万元','{LR_F1/10000},{LR_F/10000}','','G2015','',557),
(558,'2','营业成本概述','LR_F1!=0 && LR_F1-LR_F>0','，降幅为{(LR_F1- LR_F)*100/LR_F1}%。','{(LR_F1- LR_F)*100/LR_F1}','','G2015','',558),
(560,'1','衍生金融资产概述','ZCFZ_E1!=0&&ZCFZ_E-ZCFZ_E1>0','衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元增加至本期的Rmb{ZCFZ_E/10000}万元','{ZCFZ_E1/10000},{ZCFZ_E/10000}','','G1067','',560),
(561,'1','衍生金融资产概述','ZCFZ_E1!=0&&ZCFZ_E-ZCFZ_E1>0','，增幅为{(ZCFZ_E- ZCFZ_E1)*100/ZCFZ_E1}%','{(ZCFZ_E- ZCFZ_E1)*100/ZCFZ_E1}','','G1067','',561),
(562,'1','衍生金融资产概述','ZCFZ_E1!=0&&ZCFZ_E-ZCFZ_E1<0','衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元减少至本期的Rmb{ZCFZ_E/10000}万元','{ZCFZ_E1/10000},{ZCFZ_E/10000}','','G1067','',562),
(563,'1','衍生金融资产概述','ZCFZ_E1!=0&&ZCFZ_E-ZCFZ_E1<0','，降幅为{(ZCFZ_E1- ZCFZ_E)*100/ZCFZ_E1}%','{(ZCFZ_E1- ZCFZ_E)*100/ZCFZ_E1}','','G1067','',563),
(603,'1','应收利息持平','ZCFZ_L-ZCFZ_L1==0','对于应收利息不变的情况，管理层需区分是因购买的债券余额和利率未变还是因本金已收回的债券的剩余利息未能回收导致的。若是未能回收的剩余利息，则需加强回收力度。','','','10001','',603),
(604,'1','应收股利持平','ZCFZ_M-ZCFZ_M1==0','对于应收股利不变的情况，管理层需区分是因每年分红不变还是因上期分红一直未收到导致的。若是未收到上期分红，则需重点关注未收到的原因，并分析长期股权投资的减值风险。','','','10002','',604),
(605,'1','以公允价值计量且其变动计入当期损益的金融资产持平','ZCFZ_D==ZCFZ_D1','无预警','','','10003','',605),
(606,'1','一年内到期的非流动资产持平','ZCFZ_R1!=0&&ZCFZ_R-ZCFZ_R1==0','与上期相比，本期一年内到期的非流动资产与上期余额一致，变动为0，管理层需对整个融资规划进行核查，评估融资结构是否有产生变化，同时结合生产运营及投资计划，评估贷款金额是否足以支撑企业正常运营，并相应进行资金规划，合理安排资金归还即将到期的长期借款。','','','10004','',606),
(607,'1','持有待售的资产持平','ZCFZ_Q1!=0&&ZCFZ_Q-ZCFZ_Q1==0','由于该科目核算类别较为特殊，针对该科目当期及上期余额不变的情况，建议管理层关注资产性质，核查项目类别，考虑是否需要对该科目核算下的资产进行清理，注意风险控制。','','','10006','',607),
(608,'1','可供出售金融资产持平','ZCFZ_V1!=0&&ZCFZ_V-ZCFZ_V1==0','由于可供出售金融资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额与上期无任何变动，管理层需连同财务部查找原因，同时需注意核算时点、计量金额是否符合会计准则要求。且需警惕因期末可供出售金融资产市场价值变动存在变现的不确定性。','','','10007','',608),
(609,'1','持有至到期投资持平','ZCFZ_W1!=0&&ZCFZ_W-ZCFZ_W1==0','建议管理层了解该科目的资产类别，合理规划资金使用及流转速度，并结合现金流情况，考虑是否需要对该类资产进行增持或减持。','','','10008','',609),
(610,'1','固定资产持平','ZCFZ_AA1!=0&&ZCFZ_AA-ZCFZ_AA1==0','与上期相比，本期固定资产余额与上期一致，变动为0，建议管理层核查固定资产结构，并结合未来生产经营规划及布局，考虑固定资产是否需要添置或清理。','','','10009','',610),
(611,'1','在建工程持平','ZCFZ_AB1!=0&&ZCFZ_AB-ZCFZ_AB1==0','与上期相比，本期在建工程余额与上期一致，变动为0，此情况较为特殊，建议管理层与财务部核查余额是否正确，如无误，则需核查工程停滞的原因，并分析工程停滞对生产经营规划的影响，及早做出相应应对措施。','','','10010','',611),
(612,'1','长期应收款持平','ZCFZ_X-ZCFZ_X1==0','无预警。','','','10011','',612),
(613,'1','长期股权投资持平','ZCFZ_Y-ZCFZ_Y1==0','无预警。','','','10012','',613),
(614,'1','投资性房地产持平','ZCFZ_Z1!=0&&ZCFZ_Z-ZCFZ_Z1==0','由于投资性房地产核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，建议管理层在确保余额正确的情况下，结合企业生产经营布局及规划，评估继续持有或减持该类资产对企业可能产生的影响。','','','10013','',614),
(615,'1','工程物资持平','ZCFZ_AC1!=0&&ZCFZ_AC-ZCFZ_AC1==0','与上期相比，本期工程物资与上期余额一致，变动为0，建议管理层查看工程物资是否存在囤积或与相关工程所需不匹配的情况，对长期未领用或不适合工程所需的工程物资进行清理，结合工程建设计划，合理规划工程物资的采购及领用。','','','10014','',615),
(616,'1','固定资产清理持平','ZCFZ_AD==ZCFZ_AD1','无预警。','','','10015','',616),
(617,'1','无形资产持平','ZCFZ_AG1!=0&&ZCFZ_AG-ZCFZ_AG1==0','与上期相比，本期无形资产余额与上期一致，变动为0，此情况较为特殊，建议管理层在确保余额正确的情况下，分析无形资产构成，针对本期新增无形资产，查看其金额核算是否正确，是否符合会计准则对于无形资产确定的要求。','','','10016','',617),
(618,'1','开发支出持平','ZCFZ_AH1!=0&&ZCFZ_AH-ZCFZ_AH1==0','与上期相比，本期开发支出余额与上期一致，变动为0，此情况较为特殊，建议管理层在确保余额正确的情况下，分析开发支出构成，并核查开发支出的确认是否符合会计准则对于无形资产确定的要求。','','','10017','',618),
(619,'1','商誉持平','ZCFZ_AI-ZCFZ_AI1==0','无预警。','','','10018','',619),
(620,'1','长期待摊费用持平','ZCFZ_AJ1!=0&&ZCFZ_AJ-ZCFZ_AJ1==0','与上期相比，本期长期待摊费用与上期余额一致，变动为0，建议管理层在确保余额正确的情况下，核查长期待摊费用的构成，评估科目设置及核算是否符合会计准则的要求。对于本期计入的长期待摊费用，核查其金额正确性。','','','10019','',620),
(621,'1','递延所得税资产持平','ZCFZ_AK1!=0&&ZCFZ_AK-ZCFZ_AK1==0','递延所得税资产的产生，是因为资产的账面价值大于计税基础，或负债的账面价值小于计税基础，导致会计确认的所得税小于税法确认的所得税，从而产生递延所得税资产。递延所得税资产不变，需关注其确认条件、计量金额是否符合会计准则。建议管理层使用在线顾问模块中的专项顾问功能，为企业进行整体税收筹划，进行合理避税，减少企业利润不必要的损耗。同时，建议管理层检查是否已按要求设立备查薄。','','','10020','',621),
(622,'1','其他非流动资产持平','ZCFZ_AL-ZCFZ_AL1==0','无预警。','','','10021','',622),
(624,'1','短期借款持平','ZCFZ_AO1!=0&&ZCFZ_AO-ZCFZ_AO1==0','与上期相比，本期短期借款余额与上期保持一致，变动为0，建议管理层在确保余额核算无误的情况下，根据企业未来生产经营计划及融资规划，结合现金流情况，合理安排资金筹措及归还，避免出现资金紧张的情况。此外，管理层可考虑使用票据作为短期融资的途径，开拓不同类型的资金筹措方式，盘活现金流。','','','10023','',624),
(625,'1','一年内到期的非流动负债持平','ZCFZ_BJ-ZCFZ_BJ1==0','由于一年内到期的非流动负债主要为一年内到期的长期借款等，对于企业来说，由于之前的资金需求产生的贷款在近期内需进行偿还，因此需分析资金状况在未来一年内是否可以满足其偿还需求。若资金紧张，则需考虑通过借款、延长支付期限等方式缓解资金压力。','','','10025','',625),
(626,'1','应付职工薪酬持平','ZCFZ_AZ-ZCFZ_AZ1==0','无预警。','','','10026','',626),
(627,'1','应交税费持平','ZCFZ_BA==ZCFZ_BA1','与上期相比，本期应交税费余额与上期一致，变动为0，此情况较为特殊，建议管理层在确保余额正确的情况下，与财务部查看应交税费与收入的比例是否正常，此外，针对本期与上期应交税费一致的情况，建议管理层查看有无应缴未缴之税费，评估由此可能产生的滞纳金，行政处分等风险及影响。','','','10027','',627),
(628,'1','其他流动负债上期为0的变动','ZCFZ_BK1==0&&ZCFZ_BK-ZCFZ_BK1>0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10030','',628),
(629,'1','长期借款持平','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1==0','与上期相比，本期长期借款余额与上期保持一致，变动为0，建议管理层在确保余额核算无误的情况下，根据企业未来生产经营计划及融资规划，结合现金流情况，合理安排资金筹措及归还，避免出现资金紧张的情况。','','','10031','',629),
(630,'1','应付债券持平','ZCFZ_BN-ZCFZ_BN1==0','无预警。','','','10032','',630),
(631,'1','递延所得税负债持平','ZCFZ_BV-ZCFZ_BV1==0','递延所得税负债的产生，是因为资产的账面价值小于计税基础，或负债的账面价值大于计税基础，而导致会计确认的所得税大于税法确认的所得税，从而产生递延所得税负债。建议管理层关注其确认条件、计量金额是否符合会计准则。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10036','',631),
(632,'1','其他非流动负债上期为0的情况','ZCFZ_BW1==0&&ZCFZ_BW!=0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。','','','10037','',632),
(633,'1','其他非流动负债变动在正负0.2以内','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1+0.2>0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1-0.2<0','无预警。','','','10037','',633),
(634,'1','递延收益持平','ZCFZ_BU-ZCFZ_BU1==0','递延收益科目较为特殊，建议管理层关注其产生的原因及核算是否符合会计准则的要求，尤其是针对政府补贴产生的递延收益，管理层需重点关注补贴收入实现的相关条件，确保项目的开展符合政府相关规定。','','','10038','',634),
(635,'1','长期应付职工薪酬','ZCFZ_BR==ZCFZ_BR1','无预警。','','','10039','',635),
(636,'1','实收资本持平','ZCFZ_BZ==ZCFZ_BZ1','无','','','10040','',636),
(637,'1','资本公积持平','ZCFZ_CD-ZCFZ_CD1==0','无预警。','','','10041','',637),
(638,'1','盈余公积持平','ZCFZ_CH==ZCFZ_CH1','根据公司法的规定，公司分配当年税后利润时，应当提取利润的百分之十列入公司法定公积金。公司法定公积金累计额为公司注册资本的百分之五十以上的，可以不再提取。 \r\n公司从税后利润中提取法定公积金后，经股东会或者股东大会决议，还可以从税后利润中提取任意公积金。建议管理层结合CFO系统分析模块中年度净利润的情况，结合上述条款，查看企业是否已按公司法规定对盈余公积进行计提，对未按规定计提的，及时进行调整。','','','10042','',638),
(639,'1','未分配利润持平','ZCFZ_CJ-ZCFZ_CJ1==0','与上期相比，本期未分配利润与上期一致，变动为0，此情况较为特殊。建议管理层结合本期净利润及利润分配的情况，查看金额是否正确。','','','10043','',639),
(640,'1','衍生金融资产变动','ZCFZ_E!=ZCFZ_E1','无预警。',NULL,NULL,'50001',NULL,640),
(641,'1','生产性生物资产变动','ZCFZ_AE>ZCFZ_AE1||ZCFZ_AE<ZCFZ_AE1','无预警。','','','50002','',641),
(642,'1','油气资产变动','ZCFZ_AF-ZCFZ_AF1>0||ZCFZ_AF-ZCFZ_AF1<0','无预警。','','','50003','',642),
(643,'1','以公允价值计量且其变动计入当期损益的金融负债增加','ZCFZ_AS-ZCFZ_AS1>0','由于以公允价值计量且其变动计入当期损益的金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','','','50004','',643),
(644,'1','以公允价值计量且其变动计入当期损益的金融负债减少','ZCFZ_AS-ZCFZ_AS1<0','由于以公允价值计量且其变动计入当期损益的金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','','','50004','',644),
(645,'1','以公允价值计量且其变动计入当期损益的金融负债持平','ZCFZ_AS-ZCFZ_AS1==0','由于以公允价值计量且其变动计入当期损益的金融负债核算的类别较为特殊，且此类负债为非经营类负债，建议管理层在确保余额无误的情况下，结合市场情况，评估该类负债未来的市场价值变动对企业可能产生的影响，针对余额不变的类别，考虑是否需要进行清理等。','','','50004','',645),
(647,'1','衍生金融负债增加','ZCFZ_AT-ZCFZ_AT1>0','由于衍生金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','','','50005','',647),
(648,'1','衍生金融负债减少','ZCFZ_AT-ZCFZ_AT1<0','由于衍生金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','','','50005','',648),
(649,'1','衍生金融负债不变','ZCFZ_AT-ZCFZ_AT1==0','由于衍生金融负债核算的类别较为特殊，且此类负债为非经营类负债，建议管理层在确保余额无误的情况下，结合市场情况，评估该类负债未来的市场价值变动对企业可能产生的影响，针对余额不变的类别，考虑是否需要进行清理等。','','','50005','',649),
(650,'1','预计负债增加','ZCFZ_BT-ZCFZ_BT1>0','预计负债增加，企业需提高警惕，关于增加的原因。同时由于预计负债的特殊性，建议管理层针对预计负债专门进行实现程度的可能性分析，针对风险较高，较可能需要实际支付的预计负债，除考虑对现金流的影响外，还要考虑负债产生同时可能伴随的法律责任或风险，以及如未能承担负债偿还的情况下可能产生的法律责任及风险。尤其在股权转让中，受让方更应重视目标公司的预计负债问题。当发生债务追索时，将严重影响受让方的股份转让合同的利益和预期的收益。预计债务的承担问题建议列入风险负担条款在股权转让合同中予以约定。同时注意股权的转移并不影响到追索的对象，受让方在成为目标公司股东后，目标公司仍需对外承担相应责任，受让方再根据股权转让合同向出让方追偿。','','','50006','',650),
(651,'1','预计负债减少','ZCFZ_BT-ZCFZ_BT1<0','预计负债有所减少，需关注已支付负债的原因及数值，同时评估企业现有资金情况。同时由于预计负债的特殊性，建议管理层针对剩余预计负债专门进行实现程度的可能性分析，针对风险较高，较可能需要实际支付的预计负债，除考虑对现金流的影响外，还要考虑负债产生同时可能伴随的法律责任或风险，以及如未能承担负债偿还的情况下可能产生的法律责任及风险。尤其在股权转让中，受让方更应重视目标公司的预计负债问题。当发生债务追索时，将严重影响受让方的股份转让合同的利益和预期的收益。预计债务的承担问题建议列入风险负担条款在股权转让合同中予以约定。同时注意股权的转移并不影响到追索的对象，受让方在成为目标公司股东后，目标公司仍需对外承担相应责任，受让方再根据股权转让合同向出让方追偿。','','','50006','',651),
(652,'1','预计负债持平','ZCFZ_BT-ZCFZ_BT1==0','预计负债科目较为特殊，建议管理层针对预计负债专门进行实现程度的可能性分析，针对风险较高，较可能需要实际支付的预计负债，除考虑对现金流的影响外，还要考虑负债产生同时可能伴随的法律责任或风险，以及如未能承担负债偿还的情况下可能产生的法律责任及风险。尤其在股权转让中，受让方更应重视目标公司的预计负债问题。当发生债务追索时，将严重影响受让方的股份转让合同的利益和预期的收益。预计债务的承担问题建议列入风险负担条款在股权转让合同中予以约定。同时注意股权的转移并不影响到追索的对象，受让方在成为目标公司股东后，目标公司仍需对外承担相应责任，受让方再根据股权转让合同向出让方追偿。','','','50006','',652),
(653,'3','现金流量表1.1','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AZ<0&&XJLL_AM-XJLL_AZ<0','本期现金及现金等价物的增长主要靠筹资活动的现金流带动，经营活动产生的现金流非主要增长来源，管理层需警惕非经营性活动产生的现金流入的可持续性，同时，需加强经营活动现金流的管理，使现金流更健康。','','','300001','',653),
(654,'3','现金流量表1.2','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AM<0&&XJLL_AZ-XJLL_AM<0','本期现金及现金等价物的增长主要靠投资活动的现金流带动，经营活动产生的现金流非主要增长来源，管理层需警惕非经营性活动产生的现金流入的可持续性，同时，需加强经营活动现金流的管理，使现金流更健康。','','','300001','',654),
(655,'3','现金流量表1.3','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AM>0&&XJLL_Y-XJLL_AZ>0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',655),
(656,'3','现金流量表1.4','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AM<0&&XJLL_AM-XJLL_AZ==0','本期现金及现金等价物的增长主要靠投资活动及筹资活动的现金流带动，经营活动产生的现金流非主要增长来源，管理层需警惕非经营性活动产生的现金流入的可持续性，同时，需加强经营活动现金流的管理，使现金流更健康。','','','300001','',656),
(657,'3','现金流量表1.5','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AZ==0&&XJLL_Y-XJLL_AM>0','本期现金及现金等价物的增长主要靠经营活动及筹资活动产生的现金流带动，管理层需警惕筹资活动对现金流的影响是否将逐渐增大，关注未来的还本付息压力，同时考虑是否需要调整资金结构，从而达到增大经营活动现金流入的目的，使企业发展更为健康。','','','300001','',657),
(658,'3','现金流量表1.6','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AM==0&&XJLL_Y-XJLL_AZ>0','本期现金及现金等价物的增长主要靠经营活动及投资活动产生的现金流带动，管理层需警惕投资活动对现金流的影响是否将逐渐增大，并考虑是否需要调整资金结构，从而达到增大经营活动现金流入的目的，使企业发展更为健康。','','','300001','',658),
(659,'3','现金流量表1.7','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AM==0&&XJLL_Y-XJLL_AZ==0','本期现金及现金等价物的增长主要靠经营活动、投资活动及筹资活动产生的现金流带动，管理层需警惕非经营性活动产生的现金流入的可持续性及对净现金流的影响是否逐渐增大，关注投资效益及未来的还本付息压力，同时，需加强经营活动现金流的管理，使现金流更健康。','','','300001','',659),
(660,'3','现金流量表2.1','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ<0&&XJLL_BB>0&&XJLL_Y-XJLL_AM<0','本期现金及现金等价物的增长主要靠投资活动产生的现金流带动，经营活动产生的现金流非主要增长来源，管理层需警惕非经营性活动产生的现金流入的可持续性，同时，需加强经营活动现金流的管理，使现金流更健康。','','','300001','',660),
(661,'3','现金流量表2.3','XJLL_Y>0&&XJLL_AM>0&&XJLL_AZ<0&&XJLL_BB>0&&XJLL_Y-XJLL_AM==0','企业本期现金流由良好的经营活动支撑，但管理层需警惕投资活动对现金流的影响是否将逐渐增大，并考虑是否需要调整资金结构，从而达到增大经营活动现金流入的目的，使企业发展更为健康。','','','300001','',661),
(662,'3','现金流量3.3','XJLL_Y>0&&XJLL_AM<0&&XJLL_AZ>0&&XJLL_BB>0&&XJLL_Y-XJLL_AZ==0','筹资活动产生的现金流为企业现金流的重要支撑，管理层需警惕未来资金筹措是否将存在风险，从而导致影响企业现金流的健康发展。此外，筹资活动产生的现金流对企业现金流影响较大，管理层需高度警惕，尽量维持经营活动现金流对现金流量的良性引导，避免生产经营过于依赖筹资活动。','','','300001','',662),
(663,'3','现金流量预警21','XJLL_Y == 0 && XJLL_AM > 0 && XJLL_AZ > 0 && XJLL_BB > 0','尽管企业最终现金及现金等价物净增加额为正数，本期现金及现金等价物的增长完全依靠投资活动及筹资活动产生的现金流带动，经营活动产生的现金流为0，证明企业生产经营已处于危险状态，主要收入来源及现金流已非经营活动产生，对于投资者而言，释放危险信号，不利于企业未来融资规划及发展，建议管理层认真了解经营活动现金流量净额为0的原因，努力提高生产效率，降低成本，对业务板块或发展规划等进行重新调整，使企业尽快扭转经营活动现金流的不利状态。','','','300001','',663),
(664,'3','现金流量预警22','XJLL_Y == 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB > 0','尽管企业最终现金及现金等价物净增加额为正数，本期现金及现金等价物的增长完全依靠投资活动的现金流带动，经营活动产生的现金流为0，证明企业生产经营已处于危险状态，主要收入来源及现金流已非经营活动产生，对于投资者而言，释放危险信号，不利于企业未来融资规划及发展。同时，筹资活动产生的现金流量净额已为负数，企业存在巨大的资金链断裂的风险，建议管理层认真了解经营活动现金流量净额为0的原因，努力提高生产效率，降低成本，对业务板块或发展规划等进行重新调整，使企业尽快扭转经营活动现金流的不利状态。','','','300001','',664),
(666,'2','财务费用预警','LR_R1!=0&&LR_R==LR_R1','与上年同期相比，本期财务费用金额与上期一致，此情况较为特殊，建议管理层：1）与财务人员进行核查，确认金额是否正确；2）如金额无误，建议管理层查看本期及上期财务费用与长短期贷款，票据等各项融资措施的匹配关系，考虑比例是否正常；3）建议管理层可使用票据等作为短期融资途径，并积极开拓多种融资渠道，降低融资成本。','','','20010','',666),
(667,'2','投资收益预警','LR_U-LR_U1==0','无预警。','','','20011','',667),
(668,'2','营业外收入预警','LR_Z-LR_Z1==0','无预警。','','','20012','',668),
(669,'2','营业外支出持平','LR_AB-LR_AB1==0','无预警。','','','20013','',669),
(670,'2','税金及附加预警','LR_O-LR_O1==0','无预警。','','','20014','',670),
(671,'2','资产减值损失预警','LR_S-LR_S1==0','无预警。','','','20015','',671),
(672,'2','公允价值变动收益预警','LR_T-LR_T1==0','无预警。','','','20016','',672),
(673,'2','所得税费用预警','LR_AE1!=0&&LR_AE==LR_AE1','与上期相比，本期管理费用金额与上期一致，此情况较为特殊，建议管理层：1）与财务人员进行核查，确认金额是否正确；2）如金额无误，查看本期所得税费用与营业收入的占比关系，可考虑使用CFO系统中的咨询模块，聘请专业顾问进行税收筹划，合理避税，降低税赋成本。','','','20017','',673),
(674,'2','其他收益预警','LR_X1!=0&&LR_X-LR_X1>0','其他收益本期比上年同期增长{(LR_X-LR_X1)/Math.abs(LR_X1)*100}%，本期其他收益有所增加。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其增加原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X-LR_X1)/Math.abs(LR_X1)*100}','','50010','',674),
(675,'2','其他收益预警','LR_X1!=0&&LR_X-LR_X1<0','其他收益本期比上年同期减少{(LR_X1-LR_X)/Math.abs(LR_X1)*100}%，本期其他收益有所下降。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其减少原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X1-LR_X)/Math.abs(LR_X1)*100}','','50010','',675),
(676,'2','其他收益预警','LR_X-LR_X1==0','无预警。','','','50010','',676),
(677,'3','现金流量预警23','XJLL_Y == 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB > 0','企业现金流完全靠投资活动产生的现金流来支撑，整个企业已经处于资金链可能断裂以及生产经营可能存在巨大困难的状态，建议管理层调整发展规划，在开源节流的同时，考虑是否需要调整产品结构或销售布局及策略等，尽快扭转现金流的不健康状态。','','','300001','',677),
(678,'3','现金流量预警24.1','XJLL_Y > 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB > 0 && XJLL_Y - XJLL_AM< 0','本期现金及现金等价物的增长主要靠投资活动的现金流带动，经营活动产生的现金流非主要增长来源，管理层需警惕非经营性活动产生的现金流入的可持续性，同时，需加强经营活动现金流的管理，考虑筹资活动可能为企业带来的正向现金流，评估企业是否存在融资空间，并评估股权融资或债权融资的必要性，使现金流更健康。','','','300001','',678),
(679,'3','现金流量预警24.2','XJLL_Y > 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB > 0 && XJLL_Y - XJLL_AM>0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',679),
(680,'3','现金流量预警25','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ == 0 && XJLL_BB > 0','企业本期现金流由良好的经营活动支撑，然而，现金流完全由经营活动支撑，可能存在资金链断链的风险，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，针对不良投资项目，考虑止血出售。','','','300001','',680),
(681,'3','现金流量预警26','XJLL_Y > 0 && XJLL_AM == 0 && XJLL_AZ > 0 && XJLL_BB > 0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑加大效益高项目的投资。','','','300001','',681),
(682,'3','现金流量预警27','XJLL_Y > 0 && XJLL_AM == 0 && XJLL_AZ < 0 && XJLL_BB > 0','即使经营活动现金流量净额为正，但因大量归还筹资活动借入的款项，未来可能出现现金流紧张的情况，建议管理层查看未来是否仍存在大量的归还筹资活动款项的支出，合理规划资金使用，考虑对现金流的影响，避免资金链出现问题。','','','300001','',682),
(683,'3','现金流量预警28','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB > 0','由于经营活动的现金流量净额为负数，但最终的现金及现金等价物净增加额为正数，说明企业的现金流实际上是依靠投资活动产生，并非健康的现金流状况。建议管理层做好现金流管理，查看经营活动现金流为负数的主要原因。同时，可考虑进行合理的债权或股权融资，增加现金流，使企业能更加快速健康的发展。','','','300001','',683),
(684,'3','现金流量预警29','XJLL_Y < 0 && XJLL_AM == 0 && XJLL_AZ > 0 && XJLL_BB > 0','由于经营活动的现金流量净额为负数，但最终的现金及现金等价物净增加额为正数，说明企业的现金流实际上是依靠筹资活动产生，并非健康的现金流状况。建议管理层做好现金流管理，查看经营活动现金流为负数的主要原因。同时，合理规划筹资活动产生的现金流的使用及未来归还规划，避免产生资金链断裂的可能，使企业发展更为健康。','','','300001','',684),
(685,'3','现金流量预警30','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ == 0 && XJLL_BB < 0','尽管经营活动产生的现金流为正数，企业生产经营运作较为正常，然而最终的现金及现金等价物为负数，企业生产活动产生的现金流全部被投资活动所消耗掉，管理层需警惕出现资金链断裂的可能。建议管理层分析投资可行性，考虑是否需要调整投资策略。','','','300001','',685),
(686,'3','现金流量预警31','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB < 0','即使投资活动产生了正现金流，但本期现金及现金等价物净增加额为负，经营活动的负现金流说明企业生产运营存在较大问题，管理层需高度警惕，预防现金流不足对未来经营肯可能产生的影响。经营活动产生的现金流量净额为负数，反映企业经营不善，对未来进行贷款及信用评级等均有可能受到影响。建议管理层考虑通过股权融资等方式增加现金流入，预防资金链断裂。','','','300001','',686),
(687,'3','现金流量预警32','XJLL_Y == 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB < 0','本期经营活动产生的现金流量净额为0，企业经营可能存在问题，同时，投资活动产生的正向现金流完全被筹资活动所消耗，导致期末现金及现金等价物为负数，说明企业正在大笔偿还银行贷款。建议管理层查看银行还贷情况，评估未来偿贷所需资金对生产经营可能产生的影响，合理分配规划资金利用。','','','300001','',687),
(688,'3','现金流量预警33','XJLL_Y == 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB < 0','本期经营活动产生的现金流量净额为0，企业经营可能存在问题，同时，筹资活动产生的正向现金流完全被投资活动所消耗，导致期末现金及现金等价物为负数，企业完全依靠融资支撑现金流，管理层需高度重视到期无法偿还贷款的风险。建议管理层在合理开源节流，引导生产经营良性发展的同时，评估投资风险及可行性等，考虑是否需要调整投资策略。','','','300001','',688),
(689,'3','现金流量预警34','XJLL_Y > 0 && XJLL_AM == 0 && XJLL_AZ < 0 && XJLL_BB < 0','尽管经营活动产生的现金流为正数，企业生产经营运作较为正常，然而最终的现金及现金等价物为负数，企业生产活动产生的现金流全部被筹资活动所消耗掉，管理层需警惕出现资金链断裂的可能。建议管理层查看贷款到期情况，合理进行资金规划及筹措，使现金流更为健康。','','','300001','',689),
(690,'3','现金流量预警35','XJLL_Y < 0 && XJLL_AM == 0 && XJLL_AZ > 0 && XJLL_BB < 0','即使筹资活动产生了正现金流，但本期现金及现金等价物净增加额为负，经营活动的负现金流说明企业生产运营存在较大问题，管理层需高度警惕，预防现金流不足对未来经营肯可能产生的影响。经营活动产生的现金流量净额为负数，反映企业经营不善，对未来进行贷款及信用评级等均有可能受到影响。建议管理层考虑通过股权融资等方式增加现金流入，预防资金链断裂，同时需合理规划贷款归还所需资金，避免出现资金紧张的情况。','','','300001','',690),
(691,'3','现金流量预警36','XJLL_Y == 0 && XJLL_AM < 0 && XJLL_AZ < 0 && XJLL_BB < 0','投资活动及筹资活动产生的现金流量净额均为负数，经营活动现金流量净额则为0，企业现金流状况十分差，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',691),
(692,'3','现金流量预警37','XJLL_Y < 0 && XJLL_AM == 0 && XJLL_AZ < 0 && XJLL_BB < 0','经营活动及筹资活动产生的现金流量净额均为负数，投资活动现金流量净额则为0，企业现金流状况十分差，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',692),
(693,'3','现金流量预警38','XJLL_Y < 0 && XJLL_AM < 0 && XJLL_AZ== 0 && XJLL_BB < 0','经营活动及投资活动产生的现金流量净额均为负数，筹资活动现金流量净额则为0，企业现金流状况十分差，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力；6）评估投资风险及可行性等，考虑是否需要调整投资策略，在必要情况下，对部分亏损投资进行止损处理。','','','300001','',693),
(694,'3','现金流量预警39','XJLL_Y == 0 && XJLL_AM > 0 && XJLL_AZ < 0 && XJLL_BB == 0','企业经营活动产生的现金流量净额为0，证明企业生产运作处于较危险状态，建议管理层考虑是否需要调整生产经营策略，清理库存，通过加快催收应收款项，与供应商针对数期进行谈判等方式，改善企业经营活动现金流。此外，筹资活动现金流量净额为负数，企业可能正在大量偿还贷款，建议管理层查看贷款到期情况，对资金进行合理规划，避免出现资金链断链的可能。','','','300001','',694),
(695,'3','现金流量预警40','XJLL_Y == 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB == 0','企业经营活动产生的现金流量净额为0，证明企业生产运作处于较危险状态，建议管理层考虑是否需要调整生产经营策略，清理库存，通过加快催收应收款项，与供应商针对数期进行谈判等方式，改善企业经营活动现金流。此外，期末现金及现金等价物净增加额为0，企业依靠债权及股权融资借入的款项完全被投资活动所消耗，建议管理层评估投资风险及项目投资可行性及必要性，考虑是否需要调整投资策略。','','','300001','',695),
(696,'3','现金流量预警41','XJLL_Y > 0 && XJLL_AM < 0 && XJLL_AZ == 0 && XJLL_BB == 0','尽管企业经营活动产生的现金流量净额为正数，生产经营状况良好，然而，期末现金及现金等价物净增加额为0，经营活动产生的正向现金流均被投资活动所消耗，建议管理层评估投资风险及项目投资可行性及必要性，考虑是否需要调整投资策略。此外，建议管理层通过以下方式增大筹资活动产生的现金流，舒缓目前现金流的紧张状态：1）股东考虑进行增资缓解企业资金压力；2）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',696),
(697,'3','现金流量预警42','XJLL_Y < 0 && XJLL_AM > 0 && XJLL_AZ == 0 && XJLL_BB == 0','经营活动现金流量净额为负数，企业现金流状况十分差，此外，企业整个现金流由投资活动支撑，现金流处于不健康状态，建议管理层考虑以下措施对现金流进行改善：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',697),
(698,'3','现金流量预警43','XJLL_Y > 0 && XJLL_AM == 0 && XJLL_AZ < 0 && XJLL_BB == 0','尽管经营活动产生的现金流为正数，企业生产经营运作较为正常，然而最终的现金及现金等价物为0，企业生产活动产生的现金流全部被筹资活动所消耗掉，管理层需警惕出现资金链断裂的可能。建议管理层查看贷款到期情况，合理进行资金规划及筹措，使现金流更为健康。','','','300001','',698),
(699,'3','现金流量预警44','XJLL_Y < 0 && XJLL_AM == 0 && XJLL_AZ > 0 && XJLL_BB == 0','即使筹资活动产生了正现金流，但本期现金及现金等价物净增加额为0，经营活动的负现金流说明企业生产运营存在较大问题，管理层需高度警惕，预防现金流不足对未来经营肯可能产生的影响。经营活动产生的现金流量净额为负数，反映企业经营不善，对未来进行贷款及信用评级等均有可能受到影响。建议管理层考虑通过股权融资或增资等方式增加现金流入，预防资金链断裂，同时需合理规划贷款归还所需资金，避免出现资金紧张的情况。','','','300001','',699),
(700,'3','现金流量预警45','XJLL_Y == 0 && XJLL_AM == 0 && XJLL_AZ > 0 && XJLL_BB > 0','企业整个现金流完全单纯依靠融资活动支撑，生产经营现金流状况不佳，建议管理层采取以下措施改善现金流状况：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力。此外，建议管理层查看贷款到期情况，合理进行资金规划及筹措，避免出现因大批量大额偿还贷款产生资金链断链的风险。','','','300001','',700),
(701,'3','现金流量预警46','XJLL_Y > 0 && XJLL_AM == 0 && XJLL_AZ == 0 && XJLL_BB > 0','企业本期现金流由良好的经营活动支撑，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。同时，在良好的经营现金流支撑下，可考虑通过外部融资进一步增强现金流，加大效益高项目的投资。','','','300001','',701),
(702,'3','现金流量预警47','XJLL_Y == 0 && XJLL_AM == 0 && XJLL_AZ < 0 && XJLL_BB < 0','本期现金及现金等价物净增加额为负数，管理层需高度警惕，防止出现资金链断链的风险。筹资活动现金流量净额为负数，说明企业可能正在大笔偿还贷款，建议管理层查看贷款到期情况，合理进行资金规划及筹措。此外，建议管理层采取以下措施改善现金流：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力。','','','300001','',702),
(704,'3','现金流量预警48','XJLL_Y == 0 && XJLL_AM < 0 && XJLL_AZ == 0 && XJLL_BB < 0','本期现金及现金等价物净增加额为负数，管理层需高度警惕，防止出现资金链断链的风险。投资活动现金流量净额为负数，建议管理层评估投资风险及项目投资可行性及必要性，考虑是否需要调整投资策略，对部分严重亏损项目，考虑止损出售。此外，建议管理层采取以下措施改善现金流：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',704),
(705,'3','现金流量预警49','XJLL_Y < 0 && XJLL_AM == 0 && XJLL_AZ == 0 && XJLL_BB < 0','经营活动产生的现金流量净额为负数，证明企业生产经营现金流状况不佳，建议管理层采取以下措施改善现金流状况：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',705),
(706,'3','现金流量预警50','XJLL_Y == 0 && XJLL_AM == 0 && XJLL_AZ == 0 && XJLL_BB == 0','本期企业无任何现金流净增加额，资金链处于较危险状态，建议管理层采取以下措施改善现金流状况：1）对库存商品进行促销，增加收入，改善现金流入；2）加快应收款的催收，加速现金回笼；3）对成本及费用进行严格控制，减少不必要开支，从而做到开源节流；4）股东考虑进行增资缓解企业资金压力；5）查看是否存在可抵押的固定资产进行抵押贷款，或进行股权质押，或进行收款权质押等，通过各种途径进行筹资，改善总体现金流状况，但需考虑未来还本付息的压力。','','','300001','',706),
(709,'3','现金流量预警51','XJLL_Y == 0 && XJLL_AM < 0 && XJLL_AZ > 0 && XJLL_BB > 0','尽管企业最终现金及现金等价物净增加额为正数，本期现金及现金等价物的增长完全依靠筹资活动的现金流带动，经营活动产生的现金流为0，证明企业生产经营已处于危险状态，主要收入来源及现金流已非经营活动产生，对于投资者而言，释放危险信号，不利于企业未来融资规划及发展。同时，靠筹资活动产生的现金流入用于固定资产投资，建议管理层认真考虑投资的必要性、可行性、盈利性以及借款带来的未来还本付息的压力，需尽量规避因投资不慎导致无法还本付息，从而带来资金流断裂的风险。','','','300001','',709),
(716,'1','固定资产概述','ZCFZ_AA1!=0&&ZCFZ_AA-ZCFZ_AA1==0','与上年同期相比，本期固定资产金额为Rmb{ZCFZ_AA/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AA/10000}','','G1002','',716),
(717,'1','应收账款概述','ZCFZ_G1!=0&&ZCFZ_G-ZCFZ_G1==0','与上年同期相比，本期应收账款金额为Rmb{ZCFZ_G/10000}万元，与上期一致，变动为0。','{ZCFZ_G/10000}','','G1005','',717),
(718,'1','预付款项概述','ZCFZ_H1!=0&&ZCFZ_H-ZCFZ_H1==0','与上年同期相比，本期预付款项金额为Rmb{ZCFZ_H/10000}万元，与上期一致，变动为0。','{ZCFZ_H/10000}','','G1006','',718),
(719,'1','其他应收款概述','ZCFZ_N1!=0&&ZCFZ_N==ZCFZ_N1','与上年同期相比，本期其他应收款金额为Rmb{ZCFZ_N/10000}万元，与上年同期一致，变动为0。','{ZCFZ_N/10000}','','G1007','',719),
(720,'1','存货概况','ZCFZ_P1!=0&&ZCFZ_P-ZCFZ_P1==0','与上期相比，本期存货金额为Rmb{ZCFZ_P/10000}万元，与上期一致，变动为0。','{ZCFZ_P/10000}','','G1008','',720),
(721,'1','持有待售的资产概述','ZCFZ_Q1!=0&&ZCFZ_Q==ZCFZ_Q1','与上年同期相比，本期持有待售的资产金额为Rmb{ZCFZ_Q/10000}万元，与上年同期一致，变动为0。','{ZCFZ_Q/10000}','','G1009','',721),
(722,'1','持有待售的资产概述','ZCFZ_Q1==0','持有待售的资产从上年同期的Rmb{ZCFZ_Q1/10000}万元增长至本期的Rmb{ZCFZ_Q/10000}万元，变动率为-%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000}','','G1009','',722),
(723,'1','应收利息概述','ZCFZ_L1!=0 && ZCFZ_L-ZCFZ_L1==0','与上期相比，本期应收利息金额为Rmb{ZCFZ_L/10000}万元，与上期一致，变动为0。','{ZCFZ_L/10000}','','G1013','',723),
(724,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1!=0&&ZCFZ_D-ZCFZ_D1==0','与上年同期相比，本期以公允价值计量且其变动计入当期损益的金融资产金额为Rmb{ZCFZ_D/10000}万元，与上年同期一致，变动为0。','{ZCFZ_D/10000}','','G1011','',724),
(725,'1','应收票据概述','ZCFZ_F1!=0&&ZCFZ_F-ZCFZ_F1==0','与上年同期相比，本期应收票据金额为Rmb{ZCFZ_F/10000}万元，与上年同期一致，变动为0。','{ZCFZ_F/10000}','','G1012','',725),
(731,'1','应收股利概述','ZCFZ_M1!=0 &&ZCFZ_M-ZCFZ_M1==0','与上年同期相比，本期应收股利金额为Rmb{ZCFZ_M/10000}万元，与上年同期一致，变动为0。','{ZCFZ_M/10000}','','G1014','',731),
(732,'1','一年内到期的非流动资产概述','ZCFZ_R1!=0&&ZCFZ_R-ZCFZ_R1==0','与上期相比，本期一年内到期的非流动资产金额为Rmb{ZCFZ_R/10000}万元，与上期一致，变动为0。','{ZCFZ_R/10000}','','G1015','',732),
(736,'1','其他流动资产概述','ZCFZ_S1!=0&&ZCFZ_S-ZCFZ_S1==0','与上年同期相比，本期其他流动资产金额为Rmb{ZCFZ_S/10000}万元，与上年同期一致，变动为0。','{ZCFZ_S/10000}','','G1016','',736),
(739,'1','可供出售金融资产概述','ZCFZ_V1!=0&&ZCFZ_V-ZCFZ_V1==0','与上年同期相比，本期可供出售金融资产金额为Rmb{ZCFZ_V/10000}万元，与上年同期一致，变动为0。','{ZCFZ_V/10000}','','G1017','',739),
(742,'1','持有至到期投资概述','ZCFZ_W1!=0&&ZCFZ_W-ZCFZ_W1==0','与上年同期相比，本期持有至到期投资金额为Rmb{ZCFZ_W/10000}万元，与上年同期一致，变动为0。','{ZCFZ_W/10000}','','G1018','',742),
(745,'1','长期应收款概述','ZCFZ_X1!=0&&ZCFZ_X-ZCFZ_X1==0','与上年同期相比，本期长期应收款金额为Rmb{ZCFZ_X/10000}万元，与上年同期一致，变动为0。','{ZCFZ_X/10000}','','G1019','',745),
(748,'1','长期股权投资概述','ZCFZ_Y1!=0&&ZCFZ_Y-ZCFZ_Y1==0','与上年同期相比，本期长期股权投资金额为Rmb{ZCFZ_Y/10000}万元，与上年同期一致，变动为0。','{ZCFZ_Y/10000}','','G1020','',748),
(755,'1','投资性房地产概述','ZCFZ_Z1!=0&&ZCFZ_Z==ZCFZ_Z1','与上年同期相比，本期投资性房地产金额为Rmb{ZCFZ_Z/10000}万元，与上年同期一致，变动为0。','{ZCFZ_Z/10000}','','G1021','',755),
(756,'1','在建工程概述','ZCFZ_AB1!=0&&ZCFZ_AB-ZCFZ_AB1==0','与上年同期相比，本期在建工程金额为Rmb{ZCFZ_AB/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AB/10000}','','G1022','',756),
(757,'1','工程物资概述','ZCFZ_AC1!=0&&ZCFZ_AC-ZCFZ_AC1==0','与上年同期相比，本期工程物资金额为Rmb{ZCFZ_AC/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AC/10000}','','G1023','',757),
(758,'1','固定资产清理概述','ZCFZ_AD1!=0&&ZCFZ_AD-ZCFZ_AD1==0','与上年同期相比，本期固定资产清理金额为Rmb{ZCFZ_AD/10000}万元，与上期一致，变动为0。','{ZCFZ_AD/10000}','','G1024','',758),
(759,'1','生产性生物资产概述','ZCFZ_AE1!=0&&ZCFZ_AE-ZCFZ_AE1==0','与上年同期相比，本期生产性生物资产金额为Rmb{ZCFZ_AE/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AE/10000}','','G1025','',759),
(760,'1','油气资产概述','ZCFZ_AF1!=0&&ZCFZ_AF-ZCFZ_AF1==0','与上年同期相比，本期油气资产金额为Rmb{ZCFZ_AF/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AF/10000}','','G1026','',760),
(761,'3','经营活动产生的现金流量净额概述','XJLL_Y1!=0&&XJLL_Y-XJLL_Y1>0','经营活动产生的现金流量净额从上年同期的Rmb{XJLL_Y1/10000}万元增加至本期的Rmb{XJLL_Y/10000}万元，增幅达{(XJLL_Y- XJLL_Y1)*100/Math.abs(XJLL_Y1)}%。','{XJLL_Y1/10000},{XJLL_Y/10000},{(XJLL_Y- XJLL_Y1)*100/Math.abs(XJLL_Y1)}','','7001','',761),
(762,'3','经营活动产生的现金流量净额概述','XJLL_Y1!=0&&XJLL_Y - XJLL_Y1 < 0','经营活动产生的现金流量净额从上期的Rmb{XJLL_Y1/10000}万元减少至本期的Rmb{XJLL_Y/10000}万元，降幅达{(XJLL_Y1- XJLL_Y)*100/Math.abs(XJLL_Y1)}%。','{XJLL_Y1/10000},{XJLL_Y/10000},{(XJLL_Y1- XJLL_Y)*100/Math.abs(XJLL_Y1)}','','7001','',762),
(763,'1','无形资产概述','ZCFZ_AG1!=0&&ZCFZ_AG-ZCFZ_AG1==0','与上年同期相比，本期无形资产金额为Rmb{ZCFZ_AG/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AG/10000}','','G1027','',763),
(764,'1','开发支出概述','ZCFZ_AH1!=0&&ZCFZ_AH-ZCFZ_AH1==0','与上年同期相比，本期开发支出金额为Rmb{ZCFZ_AH/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AH/10000}','','G1028','',764),
(765,'3','经营活动产生的现金流量净额概述','XJLL_Y1!=0&&XJLL_Y-XJLL_Y1==0','本期经营活动产生的现金流量净额为Rmb{XJLL_Y/10000}万元，与上年同期持平，变动为0。','{XJLL_Y/10000}','','7001','',765),
(766,'3','投资活动产生的现金流量净额概述','XJLL_AM1!=0&&XJLL_AM-XJLL_AM1>0','投资活动产生的现金流量净额从上年同期的Rmb{XJLL_AM1/10000}万元增加至本期的Rmb{XJLL_AM/10000}万元，增幅达{(XJLL_AM- XJLL_AM1)*100/Math.abs(XJLL_AM1)}%。','{XJLL_AM1/10000},{XJLL_AM/10000},{(XJLL_AM- XJLL_AM1)*100/Math.abs(XJLL_AM1)}','','7002','',766),
(767,'1','商誉概述','ZCFZ_AI1!=0&&ZCFZ_AI-ZCFZ_AI1==0','与上年同期相比，本期商誉金额为Rmb{ZCFZ_AI/10000}万元，与上期一致，变动为0。','{ZCFZ_AI/10000}','','G1029','',767),
(768,'3','投资活动产生的现金流量净额概述','XJLL_AM1!=0&&XJLL_AM - XJLL_AM1 < 0','投资活动产生的现金流量净额从上年同期的Rmb{XJLL_AM1/10000}万元减少至本期的Rmb{XJLL_AM/10000}万元，降幅达{(XJLL_AM1- XJLL_AM)*100/Math.abs(XJLL_AM1)}%。','{XJLL_AM1/10000},{XJLL_AM/10000},{(XJLL_AM1- XJLL_AM)*100/Math.abs(XJLL_AM1)}','','7002','',768),
(769,'3','投资活动产生的现金流量净额概述','XJLL_AM1!=0&&XJLL_AM-XJLL_AM1==0','本期投资活动产生的现金流量净额为Rmb{XJLL_AM/10000}万元，与上年同期持平，变动为0。','{XJLL_AM/10000}','','7002','',769),
(770,'1','长期待摊费用概述','ZCFZ_AJ1!=0&&ZCFZ_AJ-ZCFZ_AJ1==0','与上年同期相比，本期长期待摊费用金额为Rmb{ZCFZ_AJ/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AJ/10000}','','G1030','',770),
(771,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1!=0&&XJLL_AZ-XJLL_AZ1>0','筹资活动产生的现金流量净额从上年同期的Rmb{XJLL_AZ1/10000}万元增加至本期的Rmb{XJLL_AZ/10000}万元，增幅达{(XJLL_AZ- XJLL_AZ1)*100/Math.abs(XJLL_AZ1)}%。','{XJLL_AZ1/10000},{XJLL_AZ/10000},{(XJLL_AZ- XJLL_AZ1)*100/Math.abs(XJLL_AZ1)}','','7003','',771),
(772,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1!=0&&XJLL_AZ-XJLL_AZ1<0','筹资活动产生的现金流量净额从上年同期的Rmb{XJLL_AZ1/10000}万元减少至本期的Rmb{XJLL_AZ/10000}万元，降幅达{(XJLL_AZ1- XJLL_AZ)*100/Math.abs(XJLL_AZ1)}%。','{XJLL_AZ1/10000},{XJLL_AZ/10000},{(XJLL_AZ1- XJLL_AZ)*100/Math.abs(XJLL_AZ1)}','','7003','',772),
(773,'1','递延所得税资产概述','ZCFZ_AK1!=0&&ZCFZ_AK-ZCFZ_AK1==0','与上年同期相比，本期递延所得税资产金额为Rmb{ZCFZ_AK/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AK/10000}','','G1031','',773),
(774,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1!=0&&XJLL_AZ-XJLL_AZ1==0','本期筹资活动产生的现金流量净额为Rmb{XJLL_AZ/10000}万元，与上年同期持平，变动为0。','{XJLL_AZ/10000}','','7003','',774),
(775,'1','其他非流动资产概述','ZCFZ_AL1!=0&&ZCFZ_AL==ZCFZ_AL1','与上年同期相比，本期其他非流动资产金额为Rmb{ZCFZ_AL/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AL/10000}','','G1032','',775),
(776,'3','现金及现金等价物净增加额概述','XJLL_BB1!=0&&XJLL_BB-XJLL_BB1>0','现金及现金等价物增加额从上年同期的Rmb{XJLL_BB1/10000}万元增加至本期的Rmb{XJLL_BB/10000}万元，增幅达{(XJLL_BB- XJLL_BB1)*100/Math.abs(XJLL_BB1)}%。','{XJLL_BB1/10000},{XJLL_BB/10000},{(XJLL_BB- XJLL_BB1)*100/Math.abs(XJLL_BB1)}','','7004','',776),
(777,'1','短期借款概述','ZCFZ_AO1!=0&&ZCFZ_AO-ZCFZ_AO1==0','与上年同期相比，本期短期借款金额为Rmb{ZCFZ_AO/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AO/10000}','','G1033','',777),
(778,'3','现金及现金等价物净增加额概述','XJLL_BB1!=0&&XJLL_BB-XJLL_BB1<0','现金及现金等价物增加额从上年同期的Rmb{XJLL_BB1/10000}万元减少至本期的Rmb{XJLL_BB/10000}万元，降幅达{(XJLL_BB1- XJLL_BB)*100/Math.abs(XJLL_BB1)}%。','{XJLL_BB1/10000},{XJLL_BB/10000},{(XJLL_BB1- XJLL_BB)*100/Math.abs(XJLL_BB1)}','','7004','',778),
(779,'3','现金及现金等价物净增加额概述','XJLL_BB1!=0&&XJLL_BB-XJLL_BB1==0','本期现金及现金等价物增加额为Rmb{XJLL_BB/10000}万元，与上年同期持平，变动为0。','{XJLL_BB/10000}','','7004','',779),
(780,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1!=0&&ZCFZ_AS-ZCFZ_AS1==0','与上年同期相比，本期以公允价值计量且其变动计入当期损益的金融负债金额为Rmb{ZCFZ_AS/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AS/10000}','','G1034','',780),
(781,'1','衍生金融负债概述','ZCFZ_AT1!=0&&ZCFZ_AT-ZCFZ_AT1==0','与上年同期相比，本期衍生金融负债金额为Rmb{ZCFZ_AT/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AT/10000}','','G1035','',781),
(782,'1','应付票据概述','ZCFZ_AU1!=0&&ZCFZ_AU-ZCFZ_AU1==0','与上年同期相比，本期应付票据金额为Rmb{ZCFZ_AU/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AU/10000}','','G1036','',782),
(783,'1','应付账款概述','ZCFZ_AV1!=0&&ZCFZ_AV-ZCFZ_AV1==0','与上年同期相比，本期应付账款金额为Rmb{ZCFZ_AV/10000}万元，与上年同期一致，变动为0。','{ZCFZ_AV/10000}','','G1037','',783),
(784,'2','税金及附加概述','(LR_O-LR_O1==0) && LR_O1!=0','与上年同期相比，本期税金及附加金额为Rmb{LR_O/10000}万元，与上年同期一致，变动为0。','{LR_O/10000}','','G2002','',784),
(785,'2','销售费用概述','LR_P1!=0 && LR_P-LR_P1==0','与上年同期相比，本期销售费用金额为Rmb{LR_P/10000}万元，与上年同期一致，变动为0。','{LR_P/10000}','','G2003','',785),
(786,'2','管理费用概述','LR_Q1!=0 && LR_Q-LR_Q1==0','与上年同期相比，本期管理费用金额为Rmb{LR_Q/10000}万元，与上年同期一致，变动为0。','{LR_Q/10000}','','G2004','',786),
(787,'2','财务费用概述','LR_R==LR_R1','本期财务费用金额为Rmb{LR_R/10000}万元，与上年同期一致，变动为0。','{LR_R/10000}','','G2005','',787),
(788,'1','预收款项概述','ZCFZ_AW1!=0&&ZCFZ_AW==ZCFZ_AW1','本期预收款项为Rmb{ZCFZ_AW/10000}万元，与上年同期持平，变动为0。','{ZCFZ_AW/10000}','','G1038','',788),
(789,'1','应付职工薪酬概述','ZCFZ_AZ1!=0&&ZCFZ_AZ-ZCFZ_AZ1==0','本期应付职工薪酬为Rmb{ZCFZ_AZ/10000}万元，与上年同期持平，变动为0。','{ZCFZ_AZ/10000}','','G1039','',789),
(790,'1','应交税费概述','ZCFZ_BA1!=0&&ZCFZ_BA==ZCFZ_BA1','本期应交税费为Rmb{ZCFZ_BA/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BA/10000}','','G1040','',790),
(791,'1','应付利息概述','ZCFZ_BB1!=0&&ZCFZ_BB==ZCFZ_BB1','本期应付利息为Rmb{ZCFZ_BB/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BB/10000}','','G1041','',791),
(792,'1','应付股利概述','ZCFZ_BC1!=0&&ZCFZ_BC-ZCFZ_BC1==0','本期应付股利为Rmb{ZCFZ_BC/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BC/10000}','','G1042','',792),
(793,'1','其他应付款概述','ZCFZ_BD1!=0&&ZCFZ_BD==ZCFZ_BD1','本期其他应付款为Rmb{ZCFZ_BD/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BD/10000}','','G1043','',793),
(794,'1','持有待售的负债概述','ZCFZ_BI1!=0&&ZCFZ_BI-ZCFZ_BI1==0','本期持有待售负债为Rmb{ZCFZ_BI/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BI/10000}','','G1044','',794),
(795,'1','一年内到期的非流动负债概述','ZCFZ_BJ1!=0&&ZCFZ_BJ-ZCFZ_BJ1==0','本期一年内到期的非流动负债为Rmb{ZCFZ_BJ/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BJ/10000}','','G1045','',795),
(796,'1','其他流动负债概述','ZCFZ_BK1!=0&&ZCFZ_BK-ZCFZ_BK1==0','本期其他流动负债为Rmb{ZCFZ_BK/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BK/10000}','','G1046','',796),
(797,'1','长期借款概述','ZCFZ_BM1!=0&&ZCFZ_BM-ZCFZ_BM1==0','本期长期借款为Rmb{ZCFZ_BM/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BM/10000}','','G1047','',797),
(798,'1','应付债券概述','ZCFZ_BN1!=0&&ZCFZ_BN-ZCFZ_BN1==0','本期应付债券为Rmb{ZCFZ_BN/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BN/10000}','','G1048','',798),
(799,'1','长期应付款概述','ZCFZ_BQ1!=0&&ZCFZ_BQ1==ZCFZ_BQ','本期长期应付款为Rmb{ZCFZ_BQ/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BQ/10000}','','G1051','',799),
(800,'1','专项应付款概述','ZCFZ_BS1!=0&&ZCFZ_BS-ZCFZ_BS1==0','本期专项应付款为Rmb{ZCFZ_BS/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BS/10000}','','G1052','',800),
(801,'1','预计负债概述','ZCFZ_BT1!=0&&ZCFZ_BT-ZCFZ_BT1==0','本期预计负债为Rmb{ZCFZ_BT/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BT/10000}','','G1053','',801),
(802,'1','递延收益概述','ZCFZ_BU1!=0&&ZCFZ_BU-ZCFZ_BU1==0','本期递延收益为Rmb{ZCFZ_BU/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BU/10000}','','G1054','',802),
(803,'1','递延所得税负债概述','ZCFZ_BV1!=0&&ZCFZ_BV-ZCFZ_BV1==0','本期递延所得税负债为Rmb{ZCFZ_BV/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BV/10000}','','G1055','',803),
(804,'1','其他非流动负债概述','ZCFZ_BW1!=0&&ZCFZ_BW-ZCFZ_BW1==0','本期其他非流动负债为Rmb{ZCFZ_BW/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BW/10000}','','G1056','',804),
(805,'1','实收资本（股本）概述','ZCFZ_BZ1!=0 && ZCFZ_BZ-ZCFZ_BZ1==0','本期实收资本（股本）为Rmb{ZCFZ_BZ/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BZ/10000}','','G1057','',805),
(806,'1','其他权益工具概述','ZCFZ_CA1!=0&&ZCFZ_CA-ZCFZ_CA1==0','本期其他权益工具为Rmb{ZCFZ_CA/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CA/10000}','','G1058','',806),
(807,'1','资本公积概述','ZCFZ_CD1!=0&&ZCFZ_CD-ZCFZ_CD1==0','本期资本公积为Rmb{ZCFZ_CD/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CD/10000}','','G1061','',807),
(808,'1','库存股概述','ZCFZ_CE1!=0&&ZCFZ_CE==ZCFZ_CE1','本期库存股为Rmb{ZCFZ_CE/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CE/10000}','','G1062','',808),
(809,'1','其他综合收益概述','ZCFZ_CF1!=0&&ZCFZ_CF-ZCFZ_CF1==0','本期其他综合收益为Rmb{ZCFZ_CF/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CF/10000}','','G1063','',809),
(810,'1','未分配利润概述','ZCFZ_CJ1!=0&&ZCFZ_CJ-ZCFZ_CJ1==0','本期未分配利润为Rmb{ZCFZ_CJ/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CJ/10000}','','G1064','',810),
(811,'1','货币资金概述','ZCFZ_A1!=0&&ZCFZ_A-ZCFZ_A1==0','本期货币资金为Rmb{ZCFZ_A/10000}万元，与上年同期持平，变动率为0。','{ZCFZ_A/10000}','','G1065','',811),
(812,'3','销售商品、提供劳务收到的现金概述','XJLL_A1!=0&&XJLL_A-XJLL_A1==0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，与上年同期持平，变动为0。','{XJLL_A/10000}','','G3004','',812),
(813,'3','收到的税费返还概述','XJLL_L1!=0&&XJLL_L-XJLL_L1==0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，与上年同期持平，变动为0。','{XJLL_L/10000}','','G3005','',813),
(814,'3','收到其他与经营活动有关的现金概述','XJLL_M1!=0&&XJLL_M-XJLL_M1==0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，与上年同期持平，变动为0。','{XJLL_M/10000}','','G3006','',814),
(815,'3','购买商品、接受劳务支付的现金概述','XJLL_O1!=0&&XJLL_O-XJLL_O1==0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，与上年同期持平，变动为0。','{XJLL_O/10000}','','G3007','',815),
(816,'3','支付给职工以及为职工支付的现金概述','XJLL_U1!=0&&XJLL_U-XJLL_U1==0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，与上年同期持平，变动为0。','{XJLL_U/10000}','','G3008','',816),
(817,'3','支付的各项税费概述','XJLL_V1!=0&&XJLL_V==XJLL_V1','本期支付的各项税费为Rmb{XJLL_V/10000}万元，与上年同期持平，变动为0。','{XJLL_V/10000}','','G3009','',817),
(818,'3','支付其他与经营活动有关的现金概述','XJLL_W1!=0&&XJLL_W-XJLL_W1==0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，与上年同期持平，变动为0。','{XJLL_W/10000}','','G3010','',818),
(819,'3','收回投资收到的现金概述','XJLL_AA1!=0&&XJLL_AA-XJLL_AA1==0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，与上年同期持平，变动为0。','{XJLL_AA/10000}','','G3011','',819),
(820,'3','取得投资收益收到的现金概述','XJLL_AB1!=0&&XJLL_AB-XJLL_AB1==0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，与上年同期持平，变动为0。','{XJLL_AB/10000}','','G3012','',820),
(821,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1!=0&&XJLL_AC-XJLL_AC1==0','本期处置固定资产、无形资产收回的现金净额为Rmb{XJLL_AC/10000}万元，与上年同期持平，变动为0。','{XJLL_AC/10000}','','G3013','',821),
(822,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1!=0&&XJLL_AD-XJLL_AD1==0','处置子公司及其它经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，与上年同期持平，变动为0。','{XJLL_AD/10000}','','G3014','',822),
(823,'3','收到其他与投资活动有关的现金概述','XJLL_AE1!=0&&XJLL_AE-XJLL_AE1==0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，与上年同期持平，变动为0。','{XJLL_AE/10000}','','G3015','',823),
(824,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1!=0&&XJLL_AG-XJLL_AG1==0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，与上年同期持平，变动为0。','{XJLL_AG/10000}','','G3016','',824),
(825,'3','投资支付的现金概述','XJLL_AH1!=0&&XJLL_AH1-XJLL_AH==0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，与上年同期持平，变动为0。','{XJLL_AH/10000}','','G3017','',825),
(826,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1!=0&&XJLL_AJ-XJLL_AJ1==0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，与上年同期持平，变动为0。','{XJLL_AJ/10000}','','G3018','',826),
(827,'3','支付其他与投资活动有关的现金概述','XJLL_AK1!=0&&XJLL_AK-XJLL_AK1==0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，与上年同期持平，变动为0。','{XJLL_AK/10000}','','G3019','',827),
(828,'3','吸收投资收到的现金概述','XJLL_AO1!=0&&XJLL_AO-XJLL_AO1==0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，与上年同期持平，变动为0。','{XJLL_AO/10000}','','G3020','',828),
(829,'3','取得借款收到的现金概述','XJLL_AQ1!=0&&XJLL_AQ-XJLL_AQ1==0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，与上年同期持平，变动为0。','{XJLL_AQ/10000}','','G3021','',829),
(830,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1!=0&&XJLL_AS-XJLL_AS1==0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，与上年同期持平，变动为0。','{XJLL_AS/10000}','','G3022','',830),
(831,'3','偿还债务支付的现金概述','XJLL_AU1!=0&&XJLL_AU-XJLL_AU1==0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，与上年同期持平，变动为0。','{XJLL_AU/10000}','','G3023','',831),
(832,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1!=0&&XJLL_AV-XJLL_AV1==0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，与上年同期持平，变动为0。','{XJLL_AV/10000}','','G3024','',832),
(833,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1!=0&&XJLL_AX-XJLL_AX1==0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，与上年同期持平，变动为0。','{XJLL_AX/10000}','','G3025','',833),
(834,'1','衍生金融资产概述','ZCFZ_E1!=0&&ZCFZ_E-ZCFZ_E1==0','本期衍生金融资产为Rmb{ZCFZ_E/10000}万元，与上年同期持平，变动率为0。','{ZCFZ_E/10000}','','G1067','',834),
(835,'1','其他流动资产预警','ZCFZ_S1==0&&ZCFZ_S>0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10005','',835),
(836,'1','其他非流动资产上期为0本期非0','ZCFZ_AL1==0&&ZCFZ_AL>0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10021','',836),
(839,'1','持有待售的负债增加','ZCFZ_BI-ZCFZ_BI1>0','由于持有待售的负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','','','50011','',839),
(840,'1','持有待售的负债减少','ZCFZ_BI-ZCFZ_BI1<0','由于持有待售的负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','','','50011','',840),
(841,'1','持有待售的负债持平','ZCFZ_BI-ZCFZ_BI1==0','由于持有待售的负债核算的类别较为特殊，且此类负债为非经营类负债，建议管理层在确保余额无误的情况下，结合市场情况，评估该类负债未来的市场价值变动对企业可能产生的影响，针对余额不变的类别，考虑是否需要进行清理等。','','','50011','',841),
(842,'1','其他综合收益','ZCFZ_CF-ZCFZ_CF1>0','其他综合收益属于非经常性科目，若在期末发生变化，建议管理层关注该变化的原因','','','50012','',842),
(843,'1','其他综合收益持平','ZCFZ_CF-ZCFZ_CF1==0','无预警。哈哈','','','50012','',843),
(844,'1','其他权益工具变动预警','ZCFZ_CA1!=0&&ZCFZ_CA-ZCFZ_CA1>0','其他权益工具属于非经常性科目，若在期末发生变动，建议管理层关注该变化的原因。','','','50013','',844),
(845,'2','资产处置收益预警','LR_W-LR_W1>0','资产处置收益大幅度增加，建议管理层关注处置资产的金额、原因和必要性。由于资产处置收益为非经常性收益，剔除后，营业利润将下降。建议管理层考虑资产处置收益变动的性质及原因，减少其对净利润的影响金额，从而增强投资者对企业业务经营的信心。','','','7005','',845),
(846,'2','资产处置收益预警','LR_W-LR_W1<0','资产处置收益大幅度减少，建议管理层关注减少的原因。由于资产处置收益为非经常性收益，剔除后，营业利润将下降。建议管理层考虑资产处置收益的性质，减少其对净利润的影响金额，从而增强投资者对企业业务经营的信心。','','','7005','',846),
(847,'2','资产处置收益预警','LR_W-LR_W1==0','本期和上年同期的资产处置收益一致，若资产处置收益不为0，则建议管理层关注资产处置收益产生的原因。由于资产处置收益为非经常性收益，剔除后，营业利润将下降。建议管理层考虑资产处置收益的性质，减少其对净利润的影响金额，从而增强投资者对企业业务经营的信心。','','','7005','',847),
(851,'1','应付票据变动为0','ZCFZ_AU-ZCFZ_AU1==0','由于银行承兑汇票的付款期限最长为6个月，因此，使用票据实际上对企业来说可实现短期融资的目的，在短期现金流较为紧张的情况下，可考虑采取使用开具应付票据的方式减轻企业现金负担。然而，需注意以下可能产生的问题及风险：应付商业票据是购买企业在正常商业活动中向供应商承诺在将来特定时日、支付一笔固定货款的票据。与应付账款相比，应付商业票据由于提出了付款的书面承诺，因而更具有法律上的约束力。此外，企业应于汇票到期前将票款足额交存其开户银行，以免银行对企业进行计收利息及引起相关法律诉讼纠纷。同时建议管理层检查是否按要求设立备查薄，方便管理。','','','10024','',851),
(855,'1','应付利息持平的预警','ZCFZ_BB==ZCFZ_BB1','针对应付利息，提请管理层关注以下方面的问题：1、需查看借款合同，核查应付利息的确认时间和计量金额是否符合会计准则；2、关注付款期限及已支付金额，考虑自身资金压力；3、关注逾期未支付的违约责任及违约时间点。','','','10028','',855),
(856,'1','应付股利持平的预警','ZCFZ_BC-ZCFZ_BC1==0','关注该科目的变动是否与企业宣告派发的股利相符合，同时需考虑支付能力，结合企业未来的生产经营计划关注资金压力问题。','','','10029','',856),
(858,'1','长期应付款不变的预警','ZCFZ_BQ1!=0&&ZCFZ_BQ-ZCFZ_BQ1==0','由于一般性经营较少使用此科目，建议管理层查看此科目核算的内容，关注发生的原因及合理性，看是否存在因记账错误导致的余额变动。如非上述原因，则需根据科目核算的性质，考虑未来分期付款或融资租赁时支付款项对现金流的影响。','','','10033','',858),
(859,'1','专项应付款不变的预警','ZCFZ_BS-ZCFZ_BS1==0','由于此科目的特殊性，建议管理层设置专人管理此科目的变动情况，并且针对用款进行专项审核及登记，做到专款专用，详细记录专款的增减情况。','','','10034','',859),
(860,'1','应收利息上期为0概述','ZCFZ_L1==0','应收利息从上年同期的Rmb{ZCFZ_L1/10000}万元增长至本期的Rmb{ZCFZ_L/10000}万元，变动率为-%。','{ZCFZ_L1/10000},{ZCFZ_L/10000}','','G1013','',860),
(871,'1','货币资金概述','ZCFZ_A1==0','货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元增长至本期的Rmb{ZCFZ_A/10000}万元，变动率为-%。','{ZCFZ_A1/10000},{ZCFZ_A/10000}',NULL,'G1065',NULL,871),
(873,'1','以公允价值计量且其变动计入当期损益的金融资产概述','ZCFZ_D1==0','以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元增长至本期的Rmb{ZCFZ_D/10000}万元，变动率为-%。','{ZCFZ_D1/10000},{ZCFZ_D/10000}',NULL,'G1011',NULL,873),
(874,'1','衍生金融资产概述','ZCFZ_E1==0','衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元增长至本期的Rmb{ZCFZ_E/10000}万元，变动率为-%。','{ZCFZ_E1/10000},{ZCFZ_E/10000}','','G1067','',874),
(875,'1','应收票据概述','ZCFZ_F1==0','应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元增加至本期的Rmb{ZCFZ_F/10000}万元，变动率为-%。','{ZCFZ_F1/10000},{ZCFZ_F/10000}',NULL,'G1012',NULL,875),
(876,'1','应收账款概述','ZCFZ_G1==0','应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元增加至本期的Rmb{ZCFZ_G/10000}万元，变动率为-%。','{ZCFZ_G1/10000},{ZCFZ_G/10000}',NULL,'G1005',NULL,876),
(877,'1','预付款项概述','ZCFZ_H1==0','预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元增加至本期的Rmb{ZCFZ_H/10000}万元，变动率为-%。','{ZCFZ_H1/10000},{ZCFZ_H/10000}','','G1006','',877),
(878,'1','应收股利概述','ZCFZ_M1==0','应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元增加至本期的Rmb{ZCFZ_M/10000}万元，变动率为-%。','{ZCFZ_M1/10000},{ZCFZ_M/10000}',NULL,'G1014',NULL,878),
(879,'1','其他应收款概述','ZCFZ_N1==0','其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元增加至本期的Rmb{ZCFZ_N/10000}万元，变动率为-%。','{ZCFZ_N/10000},{ZCFZ_N1/10000}',NULL,'G1007',NULL,879),
(880,'1','存货概述','ZCFZ_P1==0','存货从上期的Rmb{ZCFZ_P1/10000}万元增加至本期的Rmb{ZCFZ_P/10000}万元，变动率为-%。','{ZCFZ_P1/10000},{ZCFZ_P/10000}','','G1008','',880),
(881,'1','一年内到期的非流动资产概述','ZCFZ_R1==0','一年内到期的非流动资产从上年同期的Rmb{ZCFZ_R1/10000}万元增加至本期的Rmb{ZCFZ_R/10000}万元，变动率为-%。','{ZCFZ_R1/10000},{ZCFZ_R/10000}',NULL,'G1015',NULL,881),
(882,'1','其他流动资产概述','ZCFZ_S1==0','其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元增加至本期的Rmb{ZCFZ_S/10000}万元，变动率为-%。','{ZCFZ_S1/10000},{ZCFZ_S/10000}',NULL,'G1016',NULL,882),
(883,'1','可供出售金融资产概述','ZCFZ_V1==0','可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元增加至本期的Rmb{ZCFZ_V/10000}万元，变动率为-%。','{ZCFZ_V1/10000},{ZCFZ_V/10000}','','G1017','',883),
(884,'1','持有至到期投资概述','ZCFZ_W1==0','持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元增加至本期的Rmb{ZCFZ_W/10000}万元，变动率为-%。','{ZCFZ_W1/10000},{ZCFZ_W/10000}','','G1018','',884),
(885,'1','长期应收款概述','ZCFZ_X1==0','长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元增加至本期的Rmb{ZCFZ_X /10000}万元，变动率为-%。','{ZCFZ_X1/10000},{ZCFZ_X /10000}','','G1019','',885),
(886,'1','长期股权投资概述','ZCFZ_Y1==0','长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元增加至本期的Rmb{ZCFZ_Y/10000}万元，变动率为-%。','{ZCFZ_Y1/10000},{ZCFZ_Y/10000}',NULL,'G1020',NULL,886),
(887,'1','投资性房地产概述','ZCFZ_Z1==0','投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元增加至本期的Rmb{ZCFZ_Z/10000}万元，变动率为-%。','{ZCFZ_Z1/10000},{ZCFZ_Z/10000}','','G1021','',887),
(888,'1','固定资产概述','ZCFZ_AA1==0','固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元增至本期的Rmb{ZCFZ_AA/10000}万元，变动率为-%。','{ZCFZ_AA1/10000},{ZCFZ_AA/10000}',NULL,'G1002',NULL,888),
(889,'1','在建工程概述','ZCFZ_AB1==0','在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元增加至本期的Rmb{ZCFZ_AB/10000}万元，变动率为-%。','{ZCFZ_AB1/10000},{ZCFZ_AB/10000}',NULL,'G1022',NULL,889),
(890,'1','工程物资概述','ZCFZ_AC1==0','工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元增加至本期的Rmb{ZCFZ_AC/10000}万元，变动率为-%。','{ZCFZ_AC1/10000},{ZCFZ_AC/10000}','','G1023','',890),
(891,'1','固定资产清理概述','ZCFZ_AD1==0','固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元增加至本期的Rmb{ZCFZ_AD/10000}万元，变动率为-%。','{ZCFZ_AD1/10000},{ZCFZ_AD/10000}',NULL,'G1024',NULL,891),
(892,'1','生产性生物资产概述','ZCFZ_AE1==0','生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元增加至本期的Rmb{ZCFZ_AE/10000}万元，变动率为-%。','{ZCFZ_AE1/10000},{ZCFZ_AE/10000}',NULL,'G1025',NULL,892),
(893,'1','油气资产概述','ZCFZ_AF1==0','油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元增加至本期的Rmb{ZCFZ_AF/10000}万元，变动率为-%。','{ZCFZ_AF1/10000},{ZCFZ_AF/10000}',NULL,'G1026',NULL,893),
(894,'1','无形资产概述','ZCFZ_AG1==0','无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元增加至本期的Rmb{ZCFZ_AG/10000}万元，变动率为-%。','{ZCFZ_AG1/10000},{ZCFZ_AG/10000}',NULL,'G1027',NULL,894),
(895,'1','开发支出概述','ZCFZ_AH1==0','开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元增加至本期的Rmb{ZCFZ_AH/10000}万元，变动率为-%。','{ZCFZ_AH1/10000},{ZCFZ_AH/10000}',NULL,'G1028',NULL,895),
(896,'1','商誉概述','ZCFZ_AI1==0','商誉从上年同期的Rmb{ZCFZ_AI1/10000}万元增加至本期的Rmb{ZCFZ_AI/10000}万元，变动率为-%。','{ZCFZ_AI1/10000},{ZCFZ_AI/10000}',NULL,'G1029',NULL,896),
(897,'1','长期待摊费用概述','ZCFZ_AJ1==0','长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元增加至本期的Rmb{ZCFZ_AJ/10000}万元，变动率为-%。','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000}',NULL,'G1030',NULL,897),
(898,'1','递延所得税资产概述','ZCFZ_AK1==0','递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元增加至本期的Rmb{ZCFZ_AK/10000}万元，变动率为-%。','{ZCFZ_AK1/10000},{ZCFZ_AK/10000}',NULL,'G1031',NULL,898),
(899,'1','其他非流动资产概述','ZCFZ_AL1==0','其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元增加至本期的Rmb{ZCFZ_AL/10000}万元，变动率为-%。','{ZCFZ_AL1/10000},{ZCFZ_AL/10000}',NULL,'G1032',NULL,899),
(900,'1','短期借款概述','ZCFZ_AO1==0','短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元增加至本期的Rmb{ZCFZ_AO/10000}万元，变动率为-%。','{ZCFZ_AO1/10000},{ZCFZ_AO/10000}','','G1033','',900),
(901,'1','以公允价值计量且其变动计入当期损益的金融负债概述','ZCFZ_AS1==0','以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元增加至本期的Rmb{ZCFZ_AS/10000}万元，变动率为-%。','{ZCFZ_AS1/10000},{ZCFZ_AS/10000}',NULL,'G1034',NULL,901),
(902,'1','衍生金融负债概述','ZCFZ_AT1==0','衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元增加至本期的Rmb{ZCFZ_AT/10000}万元，增长率为-%。','{ZCFZ_AT1/10000},{ZCFZ_AT/10000}','','G1035','',902),
(903,'1','应付票据概述','ZCFZ_AU1==0','应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元增加至本期的Rmb{ZCFZ_AU/10000}万元，变动率为-%。','{ZCFZ_AU1/10000},{ZCFZ_AU/10000}',NULL,'G1036',NULL,903),
(904,'1','应付账款概述','ZCFZ_AV1==0','应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元增加至本期的Rmb{ZCFZ_AV/10000}万元，变动率为-%。','{ZCFZ_AV1/10000},{ZCFZ_AV/10000}',NULL,'G1037',NULL,904),
(905,'1','预收款项概述','ZCFZ_AW1==0','预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元增加至本期的Rmb{ZCFZ_AW/10000}万元，变动率为-%。','{ZCFZ_AW1/10000},{ZCFZ_AW/10000}',NULL,'G1038',NULL,905),
(906,'1','应付职工薪酬概述','ZCFZ_AZ1==0','应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元增加至本期的Rmb{ZCFZ_AZ/10000}万元，变动率为-%。','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000}','','G1039','',906),
(908,'1','应交税费概述','ZCFZ_BA1==0','应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元增加至本期的Rmb{ZCFZ_BA/10000}万元，变动率为-%。','{ZCFZ_BA1/10000},{ZCFZ_BA/10000}',NULL,'G1040',NULL,908),
(909,'1','应付利息概述','ZCFZ_BB1==0','应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元增加至本期的Rmb{ZCFZ_BB/10000}万元，变动率为-%。','{ZCFZ_BB1/10000},{ZCFZ_BB/10000}','','G1041','',909),
(910,'1','应付股利概述','ZCFZ_BC1==0','应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元增加至本期的Rmb{ZCFZ_BC/10000}万元，变动率为-%。','ZCFZ_BC1/10000},{ZCFZ_BC/10000}',NULL,'G1042',NULL,910),
(911,'1','其他应付款概述','ZCFZ_BD1==0','其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元增加至本期的Rmb{ZCFZ_BD/10000}万元，变动率为-%。','{ZCFZ_BD1/10000},{ZCFZ_BD/10000}',NULL,'G1043',NULL,911),
(912,'1','持有待售的负债概述','ZCFZ_BI1==0','持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元增加至本期的Rmb{ZCFZ_BI/10000}万元，变动率为-%。','{ZCFZ_BI1/10000},{ZCFZ_BI/10000}','','G1044','',912),
(913,'1','一年内到期的非流动负债概述','ZCFZ_BJ1==0','一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元增加至本期的Rmb{ZCFZ_BJ/10000}万元，变动率为-%。','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000}',NULL,'G1045',NULL,913),
(914,'1','其他流动负债概述','ZCFZ_BK1==0','其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元增加至本期的Rmb{ZCFZ_BK/10000}万元，变动率为-%。','{ZCFZ_BK1/10000},{ZCFZ_BK/10000}',NULL,'G1046',NULL,914),
(915,'1','长期借款概述','ZCFZ_BM1==0','长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元增加至本期的Rmb{ZCFZ_BM/10000}万元，变动率为-%。','{ZCFZ_BM1/10000},{ZCFZ_BM/10000}','','G1047','',915),
(916,'1','应付债券概述','ZCFZ_BN1==0','应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元增加至本期的Rmb{ZCFZ_BN/10000}万元，变动率为-%。','{ZCFZ_BN1/10000},{ZCFZ_BN/10000}',NULL,'G1048',NULL,916),
(917,'1','长期应付款概述','ZCFZ_BQ1==0','长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元增加至本期的Rmb{ZCFZ_BQ/10000}万元，变动率为-%。','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000}',NULL,'G1051',NULL,917),
(918,'1','专项应付款概述','ZCFZ_BS1==0','专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元增加至本期的Rmb{ZCFZ_BS/10000}万元，变动率为-%。','{ZCFZ_BS1/10000},{ZCFZ_BS/10000}',NULL,'G1052',NULL,918),
(919,'1','预计负债概述','ZCFZ_BT1==0','预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元增加至本期的Rmb{ZCFZ_BT/10000}万元，变动率为-%。','{ZCFZ_BT1/10000},{ZCFZ_BT/10000}',NULL,'G1053',NULL,919),
(920,'1','递延收益概述','ZCFZ_BU1==0','递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元增加至本期的Rmb{ZCFZ_BU/10000}万元，变动率为-%。','{ZCFZ_BU1/10000},{ZCFZ_BU/10000}',NULL,'G1054',NULL,920),
(921,'1','递延所得税负债概述','ZCFZ_BV1==0','递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元增加至本期的Rmb{ZCFZ_BV/10000}万元，变动率为-%。','{ZCFZ_BV1/10000},{ZCFZ_BV/10000}',NULL,'G1055',NULL,921),
(922,'1','其他非流动负债概述','ZCFZ_BW1==0','其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元增加至本期的Rmb{ZCFZ_BW/10000}万元，变动率为-%。','{ZCFZ_BW1/10000},{ZCFZ_BW/10000}',NULL,'G1056',NULL,922),
(923,'1','实收资本（股本）概述','ZCFZ_BZ1==0','实收资本（股本）从上年同期的Rmb{ZCFZ_BZ1/10000}万元增加至本期的Rmb{ZCFZ_BZ/10000}万元，变动率为-%。','{ZCFZ_BZ1/10000},{ZCFZ_BZ/10000}',NULL,'G1057',NULL,923),
(924,'1','库存股概述','ZCFZ_CE1==0','库存股从上年同期的Rmb{ZCFZ_CE1/10000}万元增加至本期的Rmb{ZCFZ_CE/10000}万元，变动率为-%。','{ZCFZ_CE1/10000},{ZCFZ_CE/10000}',NULL,'G1062',NULL,924),
(925,'1','其他权益工具概述','ZCFZ_CA1==0','其他权益工具从上年同期的Rmb{ZCFZ_CA1/10000}万元增加至本期的Rmb{ZCFZ_CA/10000}万元，变动率为-%。','{ZCFZ_CA1/10000},{ZCFZ_CA/10000}',NULL,'G1058',NULL,925),
(926,'1','资本公积概述','ZCFZ_CD1==0','资本公积从上年同期的Rmb{ZCFZ_CD1/10000}万元增加至本期的Rmb{ZCFZ_CD/10000}万元，变动率为-%。','{ZCFZ_CD1/10000},{ZCFZ_CD/10000}',NULL,'G1061',NULL,926),
(927,'1','其他综合收益概述','ZCFZ_CF1==0','其他综合收益从上年同期的Rmb{ZCFZ_CF1/10000}万元增加至本期的Rmb{ZCFZ_CF/10000}万元，变动率为-%。','{ZCFZ_CF1/10000},{ZCFZ_CF/10000}',NULL,'G1063',NULL,927),
(928,'1','未分配利润概述','ZCFZ_CJ1==0','未分配利润从上年同期的Rmb{ZCFZ_CJ1/10000}万元增加至本期的Rmb{ZCFZ_CJ/10000}万元，变动率为-%。','{ZCFZ_CJ1/10000},{ZCFZ_CJ/10000}',NULL,'G1064',NULL,928),
(991,'2','税金及附加概述','LR_O1==0','税金及附加从上年同期的Rmb{LR_O1/10000}万元增加至本期的Rmb{LR_O/10000}万元，增加率达-%。','{LR_O1/10000},{LR_O/10000}','','G2002','',991),
(992,'2','销售费用概述','LR_P1==0','销售费用从上年同期的Rmb{LR_P1/10000}万元增加至本期的Rmb{LR_P/10000}万元，增长率达-%。','{LR_P1/10000},{LR_P/10000}','','G2003','',992),
(993,'2','营业成本概述','LR_F1!=0 && LR_F-LR_F1==0','本期营业成本为Rmb{LR_F/10000}万元，与上年同期金额一致，变动为0。','{LR_F/10000}','','G2015','',993),
(994,'2','营业成本概述','LR_F1==0','营业成本本期金额为Rmb{LR_F/10000}万元，上年同期金额为Rmb{LR_F1/10000}万元，变动率为-%。','{LR_F/10000},{LR_F1/10000}','','G2015','',994),
(995,'2','管理费用概述','LR_Q1==0','管理费用从上年同期的Rmb{LR_Q1/10000}万元增长至本期的Rmb{LR_Q/10000}万元，变动为-%。','{LR_Q1/10000},{LR_Q/10000}',NULL,'G2004',NULL,995),
(996,'2','财务费用概述','LR_R1==0&&LR_R>LR_R1','财务费用从上年同期的Rmb{LR_R1/10000}万元增长至本期的Rmb{LR_R/10000}万元，变动率为-%。','{LR_R1/10000},{LR_R/10000}','','G2005','',996),
(997,'2','资产减值损失概述','LR_S1!=0 && LR_S1-LR_S==0','与上年同期相比，本期资产减值损失金额为Rmb{LR_S/10000}万元，与上年同期一致，变动为0。','{LR_S/10000}','','G2006','',997),
(998,'2','资产减值损失概述','LR_S1==0','资产减值损失从上年同期的Rmb{LR_S1/10000}万元增长至本期的Rmb{LR_S/10000}万元，增长率达-%。','{LR_S1/10000},{LR_S/10000}','','G2006','',998),
(999,'2','公允价值变动收益概述','LR_T1!=0 && LR_T1-LR_T==0','与上年同期相比，本期公允价值变动收益为Rmb{LR_T/10000}万元，与上年同期一致，变动为0。','{LR_T/10000}','','G2007','',999),
(1000,'2','公允价值变动收益概述','LR_T1==0','公允价值变动收益从上年同期的Rmb{LR_T1/10000}万元增长至本期的Rmb{LR_T/10000}万元，增长率为-%。','{LR_T1/10000},{LR_T/10000}',NULL,'G2007',NULL,1000),
(1001,'2','投资收益概述','LR_U1!=0 && LR_U1-LR_U==0','与上年同期相比，本期投资收益为Rmb{LR_U/10000}万元，与上年同期一致，变动为0。','{LR_U/10000}','','G2008','',1001),
(1002,'2','投资收益概述','LR_U1==0','投资收益从上年同期的Rmb{LR_U1/10000}万元增长至本期的Rmb{LR_U/10000}万元，增长率为-%。','{LR_U1/10000},{LR_U/10000}',NULL,'G2008',NULL,1002),
(1003,'2','对联营企业和合营企业的投资收益概述','LR_V1!=0 && LR-V==LR-V1','与上年同期相比，本期对联营企业和合营企业的投资收益为Rmb{LR_V/10000}万元，与上年同期一致，变动为0。','{LR_V/10000}',NULL,'G2009',NULL,1003),
(1004,'2','对联营企业和合营企业的投资收益概述','LR_V1==0','对联营企业和合营企业的投资收益从上年同期的Rmb{LR_V1/10000}万元增长至本期的Rmb{LR_V/10000}万元，增长率为-%。','{LR_V1/10000},{LR_V/10000}',NULL,'G2009',NULL,1004),
(1005,'2','汇兑收益概述','LR_W1!=0 && LR_W-LR_W1==0','与上年同期相比，本期汇兑收益为Rmb{LR_W/10000}万元，与上年同期一致，变动为0。','{LR_W/10000}','','G2010','',1005),
(1006,'2','汇兑收益概述','LR_W1==0','汇兑收益从上年同期的Rmb{LR_W1/10000}万元增长至本期的Rmb{LR_W/10000}万元，增长率为-%。','{LR_W1/10000},{LR_W/10000}',NULL,'G2010',NULL,1006),
(1007,'2','其他收益概述','LR_X1==0','其他收益从上年同期的Rmb{LR_X1/10000}万元增长至本期的Rmb{LR_X1/10000}万元，增长率为-%。','{LR_X1/10000},{LR_X1/10000}','','G2011','',1007),
(1008,'2','其他收益概述','LR_X1!=0 && LR_X-LR_X1==0','与上年同期相比，本期其他收益为Rmb{LR_X/10000}万元，与上年同期一致，变动为0。','{LR_X/10000}','','G2011','',1008),
(1009,'3','销售商品、提供劳务收到的现金概述','XJLL_A1==0&&XJLL_A>0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，较上年同期增加了Rmb{(XJLL_A-XJLL_A1)/10000}万元，增幅为-%。','{XJLL_A/10000},{(XJLL_A-XJLL_A1)/10000}','','G3004','',1009),
(1010,'2','营业外收入概述','LR_Z1!=0 &&  LR_Z1-LR_Z==0','与上年同期相比，本期营业外收入为Rmb{LR_Z/10000}万元，与上年同期一致，变动为0。','{LR_Z/10000}','','G2012','',1010),
(1011,'3','收到的税费返还概述','XJLL_L1==0&&XJLL_L>0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，较上年同期增加了Rmb{(XJLL_L-XJLL_L1)/10000}万元，增幅为-%。','{XJLL_L/10000},{(XJLL_L-XJLL_L1)/10000}','','G3005','',1011),
(1012,'2','营业外收入概述','LR_Z1==0','营业外收入从上年同期的Rmb{LR_Z1/10000}万元增长至本期的Rmb{LR_Z/10000}万元，增长率为-%。','{LR_Z1/10000},{LR_Z/10000}',NULL,'G2012',NULL,1012),
(1013,'2','营业外支出概述','LR_AB1!=0 && LR_AB-LR_AB1==0','与上年同期相比，本期营业外支出为Rmb{LR_AB/10000}万元，与上年同期一致，变动为0。','{LR_AB/10000}','','G2013','',1013),
(1014,'2','营业外支出概述','LR_AB1==0','营业外支出从上年同期的Rmb{LR_AB1/10000}万元增长至本期的Rmb{LR_AB/10000}万元，增长率为-%。','{LR_AB1/10000},{LR_AB/10000}',NULL,'G2013',NULL,1014),
(1015,'3','收到其他与经营活动有关的现金概述','XJLL_M1==0&&XJLL_M>0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，较上年同期增加了Rmb{(XJLL_M-XJLL_M1)/10000}万元，增幅为-%。','{XJLL_M/10000},{(XJLL_M-XJLL_M1)/10000}','','G3006','',1015),
(1016,'2','所得税费用概述','LR_AE1!=0 && LR_AE==LR_AE1','与上年同期相比，本期所得税费用为Rmb{LR_AE/10000}万元，与上年同期一致，变动为0。','{LR_AE/10000}','','G2014','',1016),
(1017,'2','所得税费用概述','LR_AE1==0','所得税费用从上年同期的Rmb{LR_AE1/10000}万元增长至本期的Rmb{LR_AE/10000}万元，增长率为-%。','{LR_AE1/10000},{LR_AE/10000}',NULL,'G2014',NULL,1017),
(1022,'2','利润总额概述','LR_AD1!=0 && LR_AD-LR_AD1==0','与上年同期相比，本期利润总额为Rmb{LR_AD/10000}万元，与上年同期一致，变动为0。','{LR_AD/10000}','','G2017','',1022),
(1023,'2','利润总额概述','LR_AD1!=0 && LR_AD-LR_AD1>0','利润总额从上年同期的Rmb{LR_AD1/10000}万元增长至本期的Rmb{LR_AD/10000}万元，增长率为{(LR_AD-LR_AD1)/Math.abs(LR_AD1)*100}%。','{LR_AD1/10000},{LR_AD/10000},{(LR_AD-LR_AD1)/Math.abs(LR_AD1)*100}','','G2017','',1023),
(1024,'2','利润总额概述','LR_AD1!=0 && LR_AD-LR_AD1<0','利润总额从上年同期的Rmb{LR_AD1/10000}万元下降至本期的Rmb{LR_AD/10000}万元，下降率达{(LR_AD1-LR_AD)/Math.abs(LR_AD1)*100}%。','{LR_AD1/10000},{LR_AD/10000},{(LR_AD1-LR_AD)/Math.abs(LR_AD1)*100}','','G2017','',1024),
(1025,'2','利润总额概述','LR_AD1==0','利润总额从上年同期的Rmb{LR_AD1/10000}万元增长至本期的Rmb{LR_AD/10000}万元，增长率为-%。','{LR_AD1/10000},{LR_AD/10000}',NULL,'G2017',NULL,1025),
(1026,'2','净利润概述','LR_AF1!=0 && LR_AF-LR_AF1>0','净利润从上年同期的Rmb{LR_AF1/10000}万元增长至本期的Rmb{LR_AF/10000}万元，增长率达{(LR_AF-LR_AF1)/Math.abs(LR_AF1)*100}%。','{LR_AF1/10000},{LR_AF/10000},{(LR_AF-LR_AF1)/Math.abs(LR_AF1)*100}','','G2018','',1026),
(1027,'2','净利润概述','LR_AF1!=0 && LR_AF-LR_AF1<0','净利润从上年同期的Rmb{LR_AF1/10000}万元下降至本期的Rmb{LR_AF/10000}万元，下降率达{(LR_AF1-LR_AF)/Math.abs(LR_AF1)*100}%。','{LR_AF1/10000},{LR_AF/10000},{(LR_AF1-LR_AF)/Math.abs(LR_AF1)*100}','','G2018','',1027),
(1028,'2','净利润概述','LR_AF1!=0 && LR_AF1-LR_AF==0','与上年同期相比，本期净利润为Rmb{LR_AF/10000}万元，与上年同期一致，变动为0。','{LR_AF/10000}','','G2018','',1028),
(1029,'2','净利润概述','LR_AF1==0','净利润从上年同期的Rmb{LR_AF1/10000}万元增长至本期的Rmb{LR_AF/10000}万元，增长率为-%。','{LR_AF1/10000},{LR_AF/10000}',NULL,'G2018',NULL,1029),
(1030,'3','购买商品、接受劳务支付的现金概述','XJLL_O1==0&&XJLL_O>0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，较上年同期增加了Rmb{(XJLL_O-XJLL_O1)/10000}万元，增幅为-%。','{XJLL_O/10000},{(XJLL_O-XJLL_O1)/10000}','','G3007','',1030),
(1031,'2','汇兑收益预警','LR_W-LR_W1>0','无预警。','','','50014','',1031),
(1032,'2','汇兑收益预警','LR_W-LR_W1<0','无预警。','','','50014','',1032),
(1033,'2','汇兑收益预警','LR_W-LR_W1==0','无预警。','','','50014','',1033),
(1034,'3','支付给职工以及为职工支付的现金概述','XJLL_U1==0&&XJLL_U>0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，较上年同期增加了Rmb{(XJLL_U-XJLL_U1)/10000}万元，增幅为-%。','{XJLL_U/10000},{(XJLL_U-XJLL_U1)/10000}','','G3008','',1034),
(1035,'3','支付的各项税费概述','XJLL_V1==0&&XJLL_V>0','本期支付的各项税费为Rmb{XJLL_V/10000}万元，较上年同期增加了Rmb{(XJLL_V-XJLL_V1)/10000}万元，增幅为-%。','{XJLL_V/10000},{(XJLL_V-XJLL_V1)/10000}','','G3009','',1035),
(1036,'3','支付其他与经营活动有关的现金概述','XJLL_W1==0&&XJLL_W>0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，较上年同期增加了Rmb{(XJLL_W-XJLL_W1)/10000}万元，增幅为-%。','{XJLL_W/10000},{(XJLL_W-XJLL_W1)/10000}','','G3010','',1036),
(1037,'3','收回投资收到的现金概述','XJLL_AA1==0&&XJLL_AA>0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，较上年同期增加了Rmb{(XJLL_AA-XJLL_AA1)/10000}万元，增幅为-%。','{XJLL_AA/10000},{(XJLL_AA-XJLL_AA1)/10000}','','G3011','',1037),
(1038,'3','取得投资收益收到的现金概述','XJLL_AB1==0&&XJLL_AB>0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，较上年同期增加了Rmb{(XJLL_AB-XJLL_AB1)/10000}万元，增幅为-%。','{XJLL_AB/10000},{(XJLL_AB-XJLL_AB1)/10000}','','G3012','',1038),
(1039,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1==0&&XJLL_AC>0','本期处置固定资产、无形资产和其他长期资产收回的现金净额为Rmb{XJLL_AC/10000}万元，较上年同期增加Rmb{(XJLL_AC-XJLL_AC1)/10000}万元，增幅为-%。','{XJLL_AC/10000},{(XJLL_AC-XJLL_AC1)/10000}','','G3013','',1039),
(1040,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1==0&&XJLL_AD>0','本期处置子公司及其他经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，较上年同期增加Rmb{(XJLL_AD-XJLL_AD1)/10000}万元，增幅为-%。','{XJLL_AD/10000},{(XJLL_AD-XJLL_AD1)/10000}','','G3014','',1040),
(1041,'3','收到其他与投资活动有关的现金概述','XJLL_AE1==0&&XJLL_AE>0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，较上年同期增加Rmb{(XJLL_AE-XJLL_AE1)/10000}万元，增幅为-%。','{XJLL_AE/10000},{(XJLL_AE-XJLL_AE1)/10000}','','G3015','',1041),
(1042,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1==0&&XJLL_AG>0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，较上年同期增加Rmb{(XJLL_AG-XJLL_AG1)/10000}万元，增幅为-%。','{XJLL_AG/10000},{(XJLL_AG-XJLL_AG1)/10000}','','G3016','',1042),
(1043,'3','投资支付的现金概述','XJLL_AH1==0&&XJLL_AH>0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，较上年同期增加Rmb{(XJLL_AH-XJLL_AH1)/10000}万元，增幅为-%。','{XJLL_AH/10000},{(XJLL_AH-XJLL_AH1)/10000}','','G3017','',1043),
(1044,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1==0&&XJLL_AJ>0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，较上年同期增加Rmb{(XJLL_AJ-XJLL_AJ1)/10000}万元，增幅为-%。','{XJLL_AJ/10000},{(XJLL_AJ-XJLL_AJ1)/10000}','','G3018','',1044),
(1045,'3','支付其他与投资活动有关的现金概述','XJLL_AK1==0&&XJLL_AK>0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，较上年同期增加Rmb{(XJLL_AK-XJLL_AK1)/10000}万元，增幅为-%。','{XJLL_AK/10000},{(XJLL_AK-XJLL_AK1)/10000}','','G3019','',1045),
(1046,'3','吸收投资收到的现金概述','XJLL_AO1==0&&XJLL_AO>0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，较上年同期增加Rmb{(XJLL_AO-XJLL_AO1)/10000}万元，增幅为-%。','{XJLL_AO/10000},{(XJLL_AO-XJLL_AO1)/10000}','','G3020','',1046),
(1047,'3','取得借款收到的现金概述','XJLL_AQ1==0&&XJLL_AQ>0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，较上年同期增加Rmb{(XJLL_AQ-XJLL_AQ1)/10000}万元，增幅为-%。','{XJLL_AQ/10000},{(XJLL_AQ-XJLL_AQ1)/10000}','','G3021','',1047),
(1048,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1==0&&XJLL_AS>0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，较上年同期增加Rmb{(XJLL_AS-XJLL_AS1)/10000}万元，增幅为-%。','{XJLL_AS/10000},{(XJLL_AS-XJLL_AS1)/10000}','','G3022','',1048),
(1049,'3','偿还债务支付的现金概述','XJLL_AU1==0&&XJLL_AU>0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，较上年同期增加Rmb{(XJLL_AU-XJLL_AU1)/10000}万元，增幅为-%。','{XJLL_AU/10000},{(XJLL_AU-XJLL_AU1)/10000}','','G3023','',1049),
(1050,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1==0&&XJLL_AV>0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，较上年同期增加Rmb{(XJLL_AV-XJLL_AV1)/10000}万元，增幅为-%。','{XJLL_AV/10000},{(XJLL_AV-XJLL_AV1)/10000}','','G3024','',1050),
(1051,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1==0&&XJLL_AX>0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，较上年同期增加Rmb{(XJLL_AX-XJLL_AX1)/10000}万元，增幅为-%。','{XJLL_AX/10000},{(XJLL_AX-XJLL_AX1)/10000}','','G3025','',1051),
(1052,'3','经营活动产生的现金流量净额概述','XJLL_Y1==0&&XJLL_Y>0','经营活动产生的现金流量净额从上年同期的Rmb{XJLL_Y1/10000}万元增加至本期的Rmb{XJLL_Y/10000}万元，增幅为-%。','{XJLL_Y1/10000},{XJLL_Y/10000}','','7001','',1052),
(1053,'3','投资活动产生的现金流量净额概述','XJLL_AM1==0&&XJLL_AM>0','投资活动产生的现金流量净额从上年同期的Rmb{XJLL_AM1/10000}万元增加至本期的Rmb{XJLL_AM/10000}万元，增幅为-%。','{XJLL_AM1/10000},{XJLL_AM/10000}','','7002','',1053),
(1054,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1==0&&XJLL_AZ>0','筹资活动产生的现金流量净额从上年同期的Rmb{XJLL_AZ1/10000}万元增加至本期的Rmb{XJLL_AZ/10000}万元，增幅为-%。','{XJLL_AZ1/10000},{XJLL_AZ/10000}','','7003','',1054),
(1055,'3','现金及现金等价物净增加额概述','XJLL_BB1==0&&XJLL_BB>0','现金及现金等价物增加额从上年同期的Rmb{XJLL_BB1/10000}万元增加至本期的Rmb{XJLL_BB/10000}万元，增幅为-%。','{XJLL_BB1/10000},{XJLL_BB/10000}','','7004','',1055),
(1056,'2','营业收入概述','LR_A1!=0&&LR_A-LR_A1>0','营业收入从上年同期的Rmb{LR_A1/10000}万元增长至本期的Rmb{LR_A/10000}万元，增长率为{(LR_A-LR_A1)/LR_A1*100}%。','{LR_A1/10000},{LR_A/10000},{(LR_A-LR_A1)/LR_A1*100}','','G2021','',1056),
(1057,'2','营业收入概述','LR_A1!=0&&LR_A1-LR_A>0','营业收入从上年同期的Rmb{LR_A1/10000}万元降低至本期的Rmb{LR_A/10000}万元，降低率为{(LR_A1-LR_A)/LR_A1*100}%。','{LR_A1/10000},{LR_A/10000},{(LR_A1-LR_A)/LR_A1*100}','','G2021','',1057),
(1058,'2','营业收入概述','LR_A1!=0&&LR_A1-LR_A==0','与上年同期相比，本期营业收入为Rmb{LR_A/10000}万元，与上年同期一致，变动为0。','{LR_A/10000}','','G2021','',1058),
(1059,'2','营业收入概述','LR_A1==0','营业收入从上年同期的Rmb{LR_A1/10000}万元增长至本期的Rmb{LR_A/10000}万元，增长率为-%。','{LR_A1/10000},{LR_A/10000}','','G2021','',1059),
(1063,'1','长期应付职工薪酬概述','ZCFZ_BR1!=0&&ZCFZ_BR>ZCFZ_BR1','长期应付职工薪酬从上年同期的Rmb{ZCFZ_BR1/10000}万元增加至本期的Rmb{ZCFZ_BR/10000}万元，增幅为{(ZCFZ_BR- ZCFZ_BR1)*100/ZCFZ_BR1}%。','{ZCFZ_BR1/10000},{ZCFZ_BR/10000},{(ZCFZ_BR- ZCFZ_BR1)*100/ZCFZ_BR1}',NULL,'G1068',NULL,1063),
(1064,'1','长期应付职工薪酬概述','ZCFZ_BR1!=0&&ZCFZ_BR1>ZCFZ_BR','长期应付职工薪酬从上年同期的Rmb{ZCFZ_BR1/10000}万元降低至本期的Rmb{ZCFZ_BR/10000}万元，降幅为{(ZCFZ_BR1- ZCFZ_BR)*100/ZCFZ_BR1}%。','{ZCFZ_BR1/10000},{ZCFZ_BR/10000},{(ZCFZ_BR1- ZCFZ_BR)*100/ZCFZ_BR1}',NULL,'G1068',NULL,1064),
(1065,'1','长期应付职工薪酬概述','ZCFZ_BR1!=0&&ZCFZ_BR1==ZCFZ_BR','本期长期应付职工薪酬为Rmb{ZCFZ_BR/10000}万元，与上年同期持平，变动为0。','{ZCFZ_BR/10000}','','G1068','',1065),
(1066,'1','长期应付职工薪酬概述','ZCFZ_BR1==0','长期应付职工薪酬从上年同期的Rmb{ZCFZ_BR1/10000}万元增加至本期的Rmb{ZCFZ_BR/10000}万元，变动率为-%。','{ZCFZ_BR1/10000},{ZCFZ_BR/10000}','','G1068','',1066),
(1067,'1','盈余公积概述','ZCFZ_CH1!=0&&ZCFZ_CH>ZCFZ_CH1','盈余公积从上年同期的Rmb{ZCFZ_CH1/10000}万元增加至本期的Rmb{ZCFZ_CH/10000}万元，增幅为{(ZCFZ_CH- ZCFZ_CH1)*100/ZCFZ_CH1}%。','{ZCFZ_CH1/10000},{ZCFZ_CH/10000},{(ZCFZ_CH- ZCFZ_CH1)*100/ZCFZ_CH1}',NULL,'G1069',NULL,1067),
(1068,'1','盈余公积概述','ZCFZ_CH1!=0&&ZCFZ_CH1>ZCFZ_CH','盈余公积从上年同期的Rmb{ZCFZ_CH1/10000}万元降低至本期的Rmb{ZCFZ_CH/10000}万元，降幅为{(ZCFZ_CH1- ZCFZ_CH)*100/ZCFZ_CH1}%。','{ZCFZ_CH1/10000},{ZCFZ_CH/10000},{(ZCFZ_CH1- ZCFZ_CH)*100/ZCFZ_CH1}',NULL,'G1069',NULL,1068),
(1069,'1','盈余公积概述','ZCFZ_CH1!=0&&ZCFZ_CH1==ZCFZ_CH','本期盈余公积为Rmb{ZCFZ_CH/10000}万元，与上年同期持平，变动为0。','{ZCFZ_CH/10000}',NULL,'G1069',NULL,1069),
(1070,'1','盈余公积概述','ZCFZ_CH1==0','盈余公积从上年同期的Rmb{ZCFZ_CH1/10000}万元增加至本期的Rmb{ZCFZ_CH/10000}万元，变动率为-%。','{ZCFZ_CH1/10000},{ZCFZ_CH/10000}',NULL,'G1069',NULL,1070),
(1075,'3','销售商品、提供劳务收到的现金概述','XJLL_A1==0&&XJLL_A<0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，较上年同期减少了Rmb{(XJLL_A1-XJLL_A)/10000}万元，降幅为-%。','{XJLL_A/10000},{(XJLL_A1-XJLL_A)/10000}','','G3004','',1075),
(1076,'3','销售商品、提供劳务收到的现金概述','XJLL_A1==0&&XJLL_A==0','本期销售商品、提供劳务收到的现金为Rmb{XJLL_A/10000}万元，与上年同期持平，变动为0。','{XJLL_A/10000}','','G3004','',1076),
(1077,'1','衍生金融资产预警','ZCFZ_E-ZCFZ_E1==0','无预警。','','','50001','',1077),
(1078,'1','应收票据预警','ZCFZ_F-ZCFZ_F1==0','企业应根据汇票的种类及规定及时行使提示承兑、提示付款等权利。否则，汇票未按照规定期限提示承兑的，持票人丧失对其前手的追索权；持票人超过提示付款期限提示付款的，持票人开户银行不予受理，此时企业需通过其他方式或途径追偿其应收款项。同时，建议管理层检查是否按要求设立备查薄，方便管理。','','','10022','',1078),
(1079,'3','收到的税费返还概述','XJLL_L1==0&&XJLL_L<0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，较上年同期减少了Rmb{(XJLL_L1-XJLL_L)/10000}万元，降幅为-%。','{XJLL_L/10000},{(XJLL_L1-XJLL_L)/10000}',NULL,'G3005',NULL,1079),
(1080,'3','收到的税费返还概述','XJLL_L1==0&&XJLL_L==0','本期收到的税费返还为Rmb{XJLL_L/10000}万元，与上年同期持平，变动为0。','{XJLL_L/10000}',NULL,'G3005',NULL,1080),
(1081,'3','收到其他与经营活动有关的现金概述','XJLL_M1==0&&XJLL_M<0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，较上年同期减少了Rmb{(XJLL_M1-XJLL_M)/10000}万元，降幅为-%。','{XJLL_M/10000},{(XJLL_M1-XJLL_M)/10000}',NULL,'G3006',NULL,1081),
(1082,'3','收到其他与经营活动有关的现金概述','XJLL_M1==0&&XJLL_M==0','本期收到的其他与经营活动有关的现金为Rmb{XJLL_M/10000}万元，与上年同期持平，变动为0。','{XJLL_M/10000}',NULL,'G3006',NULL,1082),
(1083,'3','购买商品、接受劳务支付的现金概述','XJLL_O1==0&&XJLL_O<0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，较上年同期减少了Rmb{(XJLL_O1-XJLL_O)/10000}万元，降幅为-%。','{XJLL_O/10000},{(XJLL_O1-XJLL_O)/10000}',NULL,'G3007',NULL,1083),
(1084,'3','购买商品、接受劳务支付的现金概述','XJLL_O1==0&&XJLL_O==0','本期购买商品、接受劳务支付的现金为Rmb{XJLL_O/10000}万元，与上年同期持平，变动为0。','{XJLL_O/10000}',NULL,'G3007',NULL,1084),
(1085,'1','持有待售的资产预警','ZCFZ_Q1==0','无预警',NULL,NULL,'10006',NULL,1085),
(1086,'3','支付给职工以及为职工支付的现金概述','XJLL_U1==0&&XJLL_U<0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，较上年同期减少了Rmb{(XJLL_U1-XJLL_U)/10000}万元，降幅为-%。','{XJLL_U/10000},{(XJLL_U1-XJLL_U)/10000}',NULL,'G3008',NULL,1086),
(1087,'3','支付给职工以及为职工支付的现金概述','XJLL_U1==0&&XJLL_U==0','本期支付给职工以及为职工支付的现金为Rmb{XJLL_U/10000}万元，与上年同期持平，变动为0。','{XJLL_U/10000}',NULL,'G3008',NULL,1087),
(1088,'3','支付的各项税费概述','XJLL_V1==0&&XJLL_V<0','本期支付的各项税费为Rmb{XJLL_V/10000}万元，较上年同期减少了Rmb{(XJLL_V1-XJLL_V)/10000}万元，降幅为-%。','{XJLL_V/10000},{(XJLL_V1-XJLL_V)/10000}',NULL,'G3009',NULL,1088),
(1089,'3','支付的各项税费概述','XJLL_V1==0&&XJLL_V==0','本期支付的各项税费为Rmb{XJLL_V/10000}万元，与上年同期持平，变动为0。','{XJLL_V/10000}',NULL,'G3009',NULL,1089),
(1090,'3','支付其他与经营活动有关的现金概述','XJLL_W1==0&&XJLL_W<0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，较上年同期减少了Rmb{(XJLL_W1-XJLL_W)/10000}万元，降幅为-%。','{XJLL_W/10000},{(XJLL_W1-XJLL_W)/10000}',NULL,'G3010',NULL,1090),
(1091,'3','支付其他与经营活动有关的现金概述','XJLL_W1==0&&XJLL_W==0','本期支付的其他与经营活动有关的现金为Rmb{XJLL_W/10000}万元，与上年同期持平，变动为0。','{XJLL_W/10000}',NULL,'G3010',NULL,1091),
(1092,'1','一年内到期的非流动资产持平','ZCFZ_R1==0&&ZCFZ_R-ZCFZ_R1==0','无预警。','','','10004','',1092),
(1093,'3','收回投资收到的现金概述','XJLL_AA1==0&&XJLL_AA<0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，较上年同期减少了Rmb{(XJLL_AA1-XJLL_AA)/10000}万元，降幅为-%。','{XJLL_AA/10000},{(XJLL_AA1-XJLL_AA)/10000}',NULL,'G3011',NULL,1093),
(1094,'3','收回投资收到的现金概述','XJLL_AA1==0&&XJLL_AA==0','本期收回投资收到的现金为Rmb{XJLL_AA/10000}万元，与上年同期持平，变动为0。','{XJLL_AA/10000}',NULL,'G3011',NULL,1094),
(1095,'3','取得投资收益收到的现金概述','XJLL_AB1==0&&XJLL_AB<0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，较上年同期减少了Rmb{(XJLL_AB1-XJLL_AB)/10000}万元，降幅为-%。','{XJLL_AB/10000},{(XJLL_AB1-XJLL_AB)/10000}','','G3012','',1095),
(1096,'3','取得投资收益收到的现金概述','XJLL_AB1==0&&XJLL_AB==0','本期取得投资收益收到的现金为Rmb{XJLL_AB/10000}万元，与上年同期持平，变动为0。','{XJLL_AB/10000}',NULL,'G3012',NULL,1096),
(1097,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1==0&&XJLL_AC<0','本期处置固定资产、无形资产和其他长期资产收回的现金净额为Rmb{XJLL_AC/10000}万元，较上年同期减少Rmb{(XJLL_AC1-XJLL_AC)/10000}万元，降幅为-%。','{XJLL_AC/10000},{(XJLL_AC1-XJLL_AC)/10000}',NULL,'G3013',NULL,1097),
(1098,'3','处置固定资产、无形资产和其他长期资产收回的现金净额概述','XJLL_AC1==0&&XJLL_AC==0','本期处置固定资产、无形资产和其他长期资产收回的现金净额为Rmb{XJLL_AC/10000}万元，与上年同期持平，变动为0。','{XJLL_AC/10000}',NULL,'G3013',NULL,1098),
(1099,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1==0&&XJLL_AD<0','本期处置子公司及其他经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，较上年同期减少Rmb{(XJLL_AD1-XJLL_AD)/10000}万元，降幅为-%。','{XJLL_AD/10000},{(XJLL_AD1-XJLL_AD)/10000}',NULL,'G3014',NULL,1099),
(1100,'3','处置子公司及其他经营单位收到的现金净额概述','XJLL_AD1==0&&XJLL_AD==0','本期处置子公司及其他经营单位收到的现金净额为Rmb{XJLL_AD/10000}万元，与上年同期持平，变动为0。','{XJLL_AD/10000}',NULL,'G3014',NULL,1100),
(1101,'1','其他流动资产预警','ZCFZ_S1==0&&ZCFZ_S-ZCFZ_S1==0','无预警。',NULL,NULL,'10005',NULL,1101),
(1102,'1','其他流动资产变动超过0.2','(ZCFZ_S-ZCFZ_S1)/ZCFZ_S-0.2>0||(ZCFZ_S-ZCFZ_S1)/ZCFZ_S-0.2==0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10005','',1102),
(1103,'1','其他流动资产变动超过0.2','(ZCFZ_S1-ZCFZ_S)/ZCFZ_S1>0.2||(ZCFZ_S1-ZCFZ_S)/ZCFZ_S1==0.2','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。',NULL,NULL,'10005',NULL,1103),
(1104,'1','可供出售金融资产两期为0','ZCFZ_V1==0&&ZCFZ_V-ZCFZ_V1==0','无预警。',NULL,NULL,'10007',NULL,1104),
(1105,'3','收到其他与投资活动有关的现金概述','XJLL_AE1==0&&XJLL_AE<0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，较上年同期减少Rmb{(XJLL_AE1-XJLL_AE)/10000}万元，降幅为-%。','{XJLL_AE/10000},{(XJLL_AE1-XJLL_AE)/10000}','','G3015','',1105),
(1106,'3','收到其他与投资活动有关的现金概述','XJLL_AE1==0&&XJLL_AE==0','本期收到的其他与投资活动有关的现金为Rmb{XJLL_AE/10000}万元，与上年同期持平，变动为0。','{XJLL_AE/10000}','','G3015','',1106),
(1107,'1','持有至到期投资两期为0预警','ZCFZ_W1==0&&ZCFZ_W-ZCFZ_W1==0','无预警。',NULL,NULL,'10008',NULL,1107),
(1108,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1==0&&XJLL_AG<0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，较上年同期减少Rmb{(XJLL_AG1-XJLL_AG)/10000}万元，降幅为-%。','{XJLL_AG/10000},{(XJLL_AG1-XJLL_AG)/10000}',NULL,'G3016',NULL,1108),
(1109,'3','购建固定资产、无形资产和其他长期资产支付的现金概述','XJLL_AG1==0&&XJLL_AG==0','本期购建固定资产、无形资产和其他长期资产支付的现金为Rmb{XJLL_AG/10000}万元，与上年同期持平，变动为0。','{XJLL_AG/10000}',NULL,'G3016',NULL,1109),
(1110,'3','投资支付的现金概述','XJLL_AH1==0&&XJLL_AH<0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，较上年同期减少Rmb{(XJLL_AH1-XJLL_AH)/10000}万元，降幅为-%。','{XJLL_AH/10000},{(XJLL_AH1-XJLL_AH)/10000}',NULL,'G3017',NULL,1110),
(1111,'3','投资支付的现金概述','XJLL_AH1==0&&XJLL_AH==0','本期投资支付的现金为Rmb{XJLL_AH/10000}万元，与上年同期持平，变动为0。','{XJLL_AH/10000}',NULL,'G3017',NULL,1111),
(1112,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1==0&&XJLL_AJ<0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，较上年同期减少Rmb{(XJLL_AJ1-XJLL_AJ)/10000}万元，降幅为-%。','{XJLL_AJ/10000},{(XJLL_AJ1-XJLL_AJ)/10000}',NULL,'G3018',NULL,1112),
(1113,'3','取得子公司及其他经营单位支付的现金净额概述','XJLL_AJ1==0&&XJLL_AJ==0','本期取得子公司及其他经营单位支付的现金净额为Rmb{XJLL_AJ/10000}万元，与上年同期持平，变动为0。','{XJLL_AJ/10000}',NULL,'G3018',NULL,1113),
(1114,'1','投资性房地产两期为0预警','ZCFZ_Z1==0&&ZCFZ_Z-ZCFZ_Z1==0','无预警。',NULL,NULL,'10013',NULL,1114),
(1115,'3','支付其他与投资活动有关的现金概述','XJLL_AK1==0&&XJLL_AK<0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，较上年同期减少Rmb{(XJLL_AK1-XJLL_AK)/10000}万元，降幅为-%。','{XJLL_AK/10000},{(XJLL_AK1-XJLL_AK)/10000}',NULL,'G3019',NULL,1115),
(1116,'3','支付其他与投资活动有关的现金概述','XJLL_AK1==0&&XJLL_AK==0','本期支付的其他与投资活动有关的现金为Rmb{XJLL_AK/10000}万元，较上年同期持平，变动为0。','{XJLL_AK/10000}',NULL,'G3019',NULL,1116),
(1117,'1','固定资产预警','ZCFZ_AA1==0&&ZCFZ_AA-ZCFZ_AA1==0','无预警。',NULL,NULL,'10009',NULL,1117),
(1118,'3','吸收投资收到的现金概述','XJLL_AO1==0&&XJLL_AO<0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，较上年同期减少Rmb{(XJLL_AO1-XJLL_AO)/10000}万元，降幅为-%。','{XJLL_AO/10000},{(XJLL_AO1-XJLL_AO)/10000}',NULL,'G3020',NULL,1118),
(1119,'3','吸收投资收到的现金概述','XJLL_AO1==0&&XJLL_AO==0','本期吸收投资收到的现金为Rmb{XJLL_AO/10000}万元，与上年同期持平，变动为0。','{XJLL_AO/10000}',NULL,'G3020',NULL,1119),
(1120,'1','在建工程两期为0预警','ZCFZ_AB1==0&&ZCFZ_AB-ZCFZ_AB1==0','无预警。',NULL,NULL,'10010',NULL,1120),
(1121,'3','取得借款收到的现金概述','XJLL_AQ1==0&&XJLL_AQ<0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，较上年同期减少Rmb{(XJLL_AQ1-XJLL_AQ)/10000}万元，降幅为-%。','{XJLL_AQ/10000},{(XJLL_AQ1-XJLL_AQ)/10000}',NULL,'G3021',NULL,1121),
(1122,'3','取得借款收到的现金概述','XJLL_AQ1==0&&XJLL_AQ==0','本期取得借款收到的现金为Rmb{XJLL_AQ/10000}万元，与上年同期持平，变动为0。','{XJLL_AQ/10000}',NULL,'G3021',NULL,1122),
(1123,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1==0&&XJLL_AS<0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，较上年同期减少Rmb{(XJLL_AS1-XJLL_AS)/10000}万元，降幅为-%。','{XJLL_AS/10000},{(XJLL_AS1-XJLL_AS)/10000}',NULL,'G3022',NULL,1123),
(1124,'3','收到其他与筹资活动有关的现金概述','XJLL_AS1==0&&XJLL_AS==0','本期收到的其他与筹资活动有关的现金为Rmb{XJLL_AS/10000}万元，与上年同期持平，变动为0。','{XJLL_AS/10000}',NULL,'G3022',NULL,1124),
(1125,'3','偿还债务支付的现金概述','XJLL_AU1==0&&XJLL_AU<0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，较上年同期减少Rmb{(XJLL_AU1-XJLL_AU)/10000}万元，降幅为-%。','{XJLL_AU/10000},{(XJLL_AU1-XJLL_AU)/10000}',NULL,'G3023',NULL,1125),
(1126,'3','偿还债务支付的现金概述','XJLL_AU1==0&&XJLL_AU==0','本期偿还债务支付的现金为Rmb{XJLL_AU/10000}万元，与上年同期持平，变动为0。','{XJLL_AU/10000}',NULL,'G3023',NULL,1126),
(1127,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1==0&&XJLL_AV<0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，较上年同期减少Rmb{(XJLL_AV1-XJLL_AV)/10000}万元，降幅为-%。','{XJLL_AV/10000},{(XJLL_AV1-XJLL_AV)/10000}',NULL,'G3024',NULL,1127),
(1128,'3','分配股利、利润或偿付利息支付的现金概述','XJLL_AV1==0&&XJLL_AV==0','本期分配股利、利润或偿付利息支付的现金为Rmb{XJLL_AV/10000}万元，与上年同期持平，变动为0。','{XJLL_AV/10000}',NULL,'G3024',NULL,1128),
(1129,'1','工程物资两期为0预警','ZCFZ_AC1==0&&ZCFZ_AC-ZCFZ_AC1==0','无预警。',NULL,NULL,'10014',NULL,1129),
(1130,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1==0&&XJLL_AX<0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，较上年同期减少Rmb{(XJLL_AX1-XJLL_AX)/10000}万元，降幅为-%。','{XJLL_AX/10000},{(XJLL_AX1-XJLL_AX)/10000}',NULL,'G3025',NULL,1130),
(1131,'3','支付其他与筹资活动有关的现金概述','XJLL_AX1==0&&XJLL_AX==0','本期支付的其他与筹资活动有关的现金为Rmb{XJLL_AX/10000}万元，与上年同期持平，变动为0。','{XJLL_AX/10000}',NULL,'G3025',NULL,1131),
(1132,'3','经营活动产生的现金流量净额概述','XJLL_Y1==0&&XJLL_Y<0','经营活动产生的现金流量净额从上年同期的Rmb{XJLL_Y1/10000}万元减少至本期的Rmb{XJLL_Y/10000}万元，降幅为-%。','{XJLL_Y1/10000},{XJLL_Y/10000}','','7001','',1132),
(1133,'3','经营活动产生的现金流量净额概述','XJLL_Y1==0&&XJLL_Y==0','本期经营活动产生的现金流量净额为Rmb{XJLL_Y/10000}万元，与上年同期持平，变动为0。','{XJLL_Y/10000}',NULL,'7001',NULL,1133),
(1134,'1','生产性生物资产预警','ZCFZ_AE==ZCFZ_AE1','无预警。',NULL,NULL,'50002',NULL,1134),
(1135,'3','投资活动产生的现金流量净额概述','XJLL_AM1==0&&XJLL_AM<0','投资活动产生的现金流量净额从上年同期的Rmb{XJLL_AM1/10000}万元减少至本期的Rmb{XJLL_AM/10000}万元，降幅为-%。','{XJLL_AM1/10000},{XJLL_AM/10000}',NULL,'7002',NULL,1135),
(1136,'3','投资活动产生的现金流量净额概述','XJLL_AM1==0&&XJLL_AM==0','本期投资活动产生的现金流量净额为Rmb{XJLL_AM/10000}万元，与上年同期持平，变动为0。','{XJLL_AM/10000}',NULL,'7002',NULL,1136),
(1137,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1==0&&XJLL_AZ<0','筹资活动产生的现金流量净额从上年同期的Rmb{XJLL_AZ1/10000}万元减少至本期的Rmb{XJLL_AZ/10000}万元，降幅为-%。','{XJLL_AZ1/10000},{XJLL_AZ/10000}',NULL,'7003',NULL,1137),
(1138,'3','筹资活动产生的现金流量净额概述','XJLL_AZ1==0&&XJLL_AZ==0','本期筹资活动产生的现金流量净额为Rmb{XJLL_AZ/10000}万元，与上年同期持平，变动为0。','{XJLL_AZ/10000}',NULL,'7003',NULL,1138),
(1140,'3','现金及现金等价物净增加额概述','XJLL_BB1==0&&XJLL_BB<0','现金及现金等价物增加额从上年同期的Rmb{XJLL_BB1/10000}万元减少至本期的Rmb{XJLL_BB/10000}万元，降幅为-%。','{XJLL_BB1/10000},{XJLL_BB/10000}',NULL,'7004',NULL,1140),
(1141,'3','现金及现金等价物净增加额概述','XJLL_BB1==0&&XJLL_BB==0','本期现金及现金等价物增加额为Rmb{XJLL_BB/10000}万元，与上年同期持平，变动为0。','{XJLL_BB/10000}',NULL,'7004',NULL,1141),
(1142,'3','期末现金及现金等价物余额概述','XJLL_BD1!=0&&XJLL_BD-XJLL_BD1>0','期末现金及现金等价物余额从上年同期的Rmb{XJLL_BD1/10000}万元增加至本期的Rmb{XJLL_BD/10000}万元，增幅达{(XJLL_BD- XJLL_BD1)*100/Math.abs(XJLL_BD1)}%。','{XJLL_BD1/10000},{XJLL_BD/10000},{(XJLL_BD- XJLL_BD1)*100/Math.abs(XJLL_BD1)}',NULL,'7006',NULL,1142),
(1143,'3','期末现金及现金等价物余额概述','XJLL_BD1!=0&&XJLL_BD-XJLL_BD1<0','期末现金及现金等价物余额从上年同期的Rmb{XJLL_BD1/10000}万元减少至本期的Rmb{XJLL_BD/10000}万元，降幅达{(XJLL_BD1- XJLL_BD)*100/Math.abs(XJLL_BD1)}%。','{XJLL_BD1/10000},{XJLL_BD/10000},{(XJLL_BD1- XJLL_BD)*100/Math.abs(XJLL_BD1)}',NULL,'7006',NULL,1143),
(1144,'3','期末现金及现金等价物余额概述','XJLL_BD1!=0&&XJLL_BD-XJLL_BD1=0','本期期末现金及现金等价物余额为Rmb{XJLL_BD/10000}万元，与上期持平，变动为0。','{XJLL_BD/10000}',NULL,'7006',NULL,1144),
(1145,'3','期末现金及现金等价物余额概述','XJLL_BD1==0&&XJLL_BD>0','期末现金及现金等价物余额从上年同期的Rmb{XJLL_BD1/10000}万元增加至本期的Rmb{XJLL_BD/10000}万元，增幅达-%。','{XJLL_BD1/10000},{XJLL_BD/10000}',NULL,'7006',NULL,1145),
(1146,'3','期末现金及现金等价物余额概述','XJLL_BD1==0&&XJLL_BD<0','期末现金及现金等价物余额从上年同期的Rmb{XJLL_BD1/10000}万元减少至本期的Rmb{XJLL_BD/10000}万元，降幅达-%。','{XJLL_BD1/10000},{XJLL_BD/10000}',NULL,'7006',NULL,1146),
(1147,'3','期末现金及现金等价物余额概述','XJLL_BD1==0&&XJLL_BD==0','本期期末现金及现金等价物余额为Rmb{XJLL_BD/10000}万元，与上期持平，变动为0。','{XJLL_BD/10000}',NULL,'7006',NULL,1147),
(1148,'1','油气资产预警','ZCFZ_AF-ZCFZ_AF1==0','无预警。','','','50003','',1148),
(1151,'1','无形资产预警','ZCFZ_AG1==0&&ZCFZ_AG-ZCFZ_AG1==0','无预警。','','','10016','',1151),
(1153,'1','开发支出预警','ZCFZ_AH1==0&&ZCFZ_AH-ZCFZ_AH1==0','无预警。',NULL,NULL,'10017',NULL,1153),
(1154,'1','开发支出预警','ZCFZ_AH1==0&&ZCFZ_AH-ZCFZ_AH1==0','无预警。',NULL,NULL,'10017',NULL,1154),
(1155,'1','长期待摊费用预警','ZCFZ_AJ1==0&&ZCFZ_AJ-ZCFZ_AJ1==0','无预警。','','','10019','',1155),
(1156,'1','递延所得税资产预警','ZCFZ_AK1==0&&ZCFZ_AK-ZCFZ_AK1==0','无预警。','','','10020','',1156),
(1157,'1','其他非流动资产较上期下降>=-0.2','ZCFZ_AL1!=0&&(ZCFZ_AL1-ZCFZ_AL)/ZCFZ_AL1+0.2<0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10021','',1157),
(1158,'1','其他流动资产预警','ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1+0.2>0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1-0.2<0','无预警。',NULL,NULL,'10021',NULL,1158),
(1159,'1','其他非流动资产预警','ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1-0.2==0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。',NULL,NULL,'10021',NULL,1159),
(1160,'1','其他非流动资产预警','ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1+0.2<0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10021','',1160),
(1161,'1','其他非流动资产预警','ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1+0.2==0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。',NULL,NULL,'10021',NULL,1161),
(1162,'1','短期借款预警','ZCFZ_AO1==0&&ZCFZ_AO-ZCFZ_AO1==0','建议管理层在确保余额核算无误的情况下，根据企业未来生产经营计划及融资规划，结合现金流情况，考虑是否需要合理安排进行短期借款，避免出现资金紧张的情况。此外，管理层可考虑使用票据作为短期融资的途径，开拓不同类型的资金筹措方式，盘活现金流。',NULL,NULL,'10023',NULL,1162),
(1163,'1','应付票据预警','ZCFZ_AU-ZCFZ_AU1<0','由于银行承兑汇票的付款期限最长为6个月，因此，使用票据实际上对企业来说可实现短期融资的目的，在短期现金流较为紧张的情况下，可考虑采取使用开具应付票据的方式减轻企业现金负担。然而，需注意以下可能产生的问题及风险：应付商业票据是购买企业在正常商业活动中向供应商承诺在将来特定时日、支付一笔固定货款的票据。与应付账款相比，应付商业票据由于提出了付款的书面承诺，因而更具有法律上的约束力。此外，企业应于汇票到期前将票款足额交存其开户银行，以免银行对企业进行计收利息及引起相关法律诉讼纠纷。同时建议管理层检查是否按要求设立备查薄，方便管理。',NULL,NULL,'10024',NULL,1163),
(1165,'1','应付股利预警','ZCFZ_BC-ZCFZ_BC1<0','关注该科目的变动是否与企业宣告派发的股利相符合，同时需考虑支付能力，结合企业未来的生产经营计划关注资金压力问题。',NULL,NULL,'10029',NULL,1165),
(1167,'1','其他流动负债预警','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1-0.2==0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10030','',1167),
(1168,'1','其他流动负债预警','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1+0.2<0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10030','',1168),
(1169,'1','其他流动负债预警','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1+0.2==0','其他流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','','','10030','',1169),
(1170,'1','其他流动负债预警','ZCFZ_BK1!=0&&ZCFZ_BK-ZCFZ_BK1==0','无预警。','','','10030','',1170),
(1171,'1','其他流动负债预警','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1+0.2>0','无预警。','','','10030','',1171),
(1172,'1','其他流动负债预警','ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1-0.2<0','无预警。','','','10030','',1172),
(1176,'2','资产处置收益概述','LR_W1!=0 && LR_W-LR_W1>0','本期资产处置收益为Rmb{LR_W/10000}万元，上年同期为Rmb{LR_W1/10000}万元，增加了{(LR_W- LR_W1)*100/Math.abs(LR_W1)}%。','{LR_W/10000},{LR_W1/10000},{(LR_W- LR_W1)*100/Math.abs(LR_W1)}','','G2020','',1176),
(1177,'2','资产处置收益概述','LR_W1!=0 && LR_W1-LR_W>0','本期资产处置收益为Rmb{LR_W/10000}万元，上年同期为Rmb{LR_W1/10000}万元，减少了{(LR_W1- LR_W)*100/Math.abs(LR_W1)}%。','{LR_W/10000},{LR_W1/10000},{(LR_W1- LR_W)*100/Math.abs(LR_W1)}','','G2020','',1177),
(1178,'2','资产处置收益概述','LR_W1!=0 && LR_W1-LR_W==0','与上年同期相比，本期资产处置收益为Rmb{LR_W/10000}万元，与上年同期一致，变动为0。','{LR_W/10000}','','G2020','',1178),
(1179,'2','资产处置收益概述','LR_W1==0','资产处置收益从上年同期的Rmb{LR_W1/10000}万元增长至本期的Rmb{LR_W/10000}万元，增长率为-%。','{LR_W1/10000},{LR_W/10000}','','G2020','',1179),
(1180,'1','长期借款预警','ZCFZ_BM1==0&&ZCFZ_BM-ZCFZ_BM1==0','建议管理层在确保余额核算无误的情况下，根据企业未来生产经营计划及融资规划，结合现金流情况，考虑是否需要借入长期借款，避免出现资金紧张的情况。如有进行长期借款的计划，则需就抵押物、贷款期限、资金归还等进行合理规划。',NULL,NULL,'10031',NULL,1180),
(1183,'1','长期应付款预警','ZCFZ_BQ1!=0&&ZCFZ_BQ-ZCFZ_BQ1<0','由于一般性经营较少使用此科目，建议管理层查看此科目核算的内容，关注发生的原因及合理性，看是否存在因记账错误导致的余额变动。如非上述原因，则需根据科目核算的性质，考虑未来分期付款或融资租赁时支付款项对现金流的影响。',NULL,NULL,'10033',NULL,1183),
(1184,'1','长期应付款预警','ZCFZ_BQ==0&&ZCFZ_BQ-ZCFZ_BQ1==0','无预警。','','','10033','',1184),
(1185,'1','专项应付款预警','ZCFZ_BS-ZCFZ_BS1!=0','由于此科目的特殊性，建议管理层设置专人管理此科目的变动情况，并且针对用款进行专项审核及登记，做到专款专用，详细记录专款的增减情况。','','','10034','',1185),
(1188,'1','其他非流动负债预警','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1-0.2==0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。','','','10037','',1188),
(1189,'1','其他非流动负债预警','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1+0.2<0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。',NULL,NULL,'10037',NULL,1189),
(1190,'1','其他非流动负债预警','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1+0.2==0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。',NULL,NULL,'10037',NULL,1190),
(1191,'1','其他非流动负债预警','ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1+0.2==0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。',NULL,NULL,'10037',NULL,1191),
(1192,'1','其他非流动负债预警','ZCFZ_BW1==0&&ZCFZ_BW1-ZCFZ_BW==0','无预警。','','','10037','',1192),
(1193,'1','其他权益工具预警','ZCFZ_CA1!=0&&ZCFZ_CA-ZCFZ_CA1<0','其他权益工具属于非经常性科目，若在期末发生变动，建议管理层关注该变化的原因。',NULL,NULL,'50013',NULL,1193),
(1194,'1','其他权益工具预警','ZCFZ_CA-ZCFZ_CA1==0','无预警。哈哈','','','50013','',1194),
(1195,'1','其他综合收益预警','ZCFZ_CF-ZCFZ_CF1<0','其他综合收益属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。',NULL,NULL,'50012',NULL,1195),
(1198,'2','所得税费用预警','LR_AE1==0&&LR_AE>LR_AE1','所得税费用本期比上年同期增长-%，建议管理层关注所得税申报中不得抵扣项的原因及金额，考虑是否需要聘请专业团队为企业进行税收筹划，达到合理避税，增加净利润的目的。','','','20017','',1198),
(1200,'2','所得税费用预警','LR_AE1==0&&LR_AE-LR_AE1==0','无预警。','','','20017','',1200),
(1201,'1','营运资本概述','YBLFX-A!=YBLFX-A1','haha',NULL,NULL,'8888',NULL,1201),
(1202,'5','营运资本概述','YBLFX_A-YBLFX_A==0','营运资本=流动资产-流动负债\r\n营运资本可以用来衡量公司的短期偿债能力。营运资本越多，说明公司对于短期支付义务的准备越充足，短期偿债能力越好。当运营资本为负数时，表明流动资产已不足以支撑短期债务，正常运营所需资金短缺，公司需缩短收入的回款期、加快应收款的回收或进行外部融资。\r\n一家企业的营运资本到底多少才算足够，各公司间因运营模式不同而差异大，因此，可对本公司不同历史时期的运营资本周转期进行比较，分析公司自身运营资本周转期的合理范围。','','','GBL8001','',1202),
(1203,'5','流动比率概述','YBLFX_B-YBLFX_B==0','流动比率=流动资产/流动负债\r\n流动比率用来衡量企业流动资产在短期债务到期以前，可以变为现金用于偿还负债的能力。流动比率越高，公司的资产变现能力和短期偿债能力越强，反之越弱，但并非越高越好。流动比率太高，则可能存在资金闲置、存货积压等问题，说明企业经营管理不善。通常认为生产型公司比较合理的流动比率为2:1，但各公司可根据不同历史时期和同行业的数据，比较分析自身流动比率的合理范围，对不属于合理范围的流动比率需查明原因并采取相应措施。',NULL,NULL,'GBL8002',NULL,1203),
(1204,'5','速动比率概述','YBLFX_C-YBLFX_C==0','速动比率=速动资产（流动资产-存货）/流动负债\r\n速动比率衡量企业流动资产中可以立即变现用于偿还流动负债的能力。速动比率越高，公司的资产较快变现能力和短期偿债能力越强，反之越弱，但并非越高越好。速动比率太高，则可能存在资金闲置问题。通常认为生产型公司的比较合理的速动比率为1:1，但各公司可根据不同历史时期和同行业的数据，比较分析自身速动比率的合理范围，对不属于合理范围的流动比率需查明原因并采取相应措施。',NULL,NULL,'GBL8003',NULL,1204),
(1205,'5','现金比率概述','YBLFX_D-YBLFX_D==0','现金比率=(货币资金+交易性金融资产)/流动负债\r\n现金比率通过计算公司现金以及现金等价资产总量与当前流动负债的比率，来衡量公司资产的流动性。现金比率越高，企业即时付现能力越强，但并非越高越好。现金比率太高，则资金闲置、资金规划不合理。各公司可根据不同历史时期和同行业的数据，比较分析自身现金比率的合理范围，对不属于合理范围的现金比率需查明原因并采取相应措施。',NULL,NULL,'GBL8004',NULL,1205),
(1206,'5','现金流量比率概述','YBLFX_E-YBLFX_E==0','现金流量比率=经营活动产生的现金净流量/期末流动负债\r\n现金流量比率用于衡量企业经营活动所产生的现金流量可以抵偿流动负债的程度，比率越高，说明企业的财务弹性越好。一般而言，当经营现金流量比率低于50%时，企业应该警惕。但各公司可根据不同历史时期和同行业的数据，比较分析自身现金流量比率的合理范围，对不属于合理范围的现金流量比率需查明原因并采取相应措施。',NULL,NULL,'GBL8005',NULL,1206),
(1207,'5','资产负债率概述','YBLFX_F-YBLFX_F==0','资产负债率=总资产/总负债×100%\r\n资产负债率反映总资产中由债权人提供的资产所占比重的大小，可以用来衡量企业清算时对债权人利益的保护程度。一般认为，资产负债率的适宜水平是40%～60%，过高则企业举债经营能力越弱、偿债风险越高，过低则不能充分发挥财务杠杠作用。但各公司可根据不同历史时期和同行业的数据，比较分析自身资产负债率的合理范围，对不属于合理范围的资产负债率需查明原因并采取相应措施。\r\n资产负债比率高达100%时，公司已资不抵债，可能面临破产清算风险。即使公司资产负债率不高，但管理层也需关注潜在债务、担保风险等，以防突发性债务给企业造成巨大资金压力。',NULL,NULL,'GBL8006',NULL,1207),
(1208,'5','产权比率概述','YBLFX_G-YBLFX_G==0','产权比率=负债总额/所有者权益×100%\r\n产权比率可用来评估资金结构的合理性。产权比率越低，表明企业自有资本占总资产的比重越大，长期偿债能力越强。比率越高，表明自有资金占总资产比率越小，基本财务结构越不稳定，长期偿债能力越低。同时，若产权比率偏高，管理层也需关注注册资本是否实缴。若未实缴，可要求股东进行缴纳，补充企业流动资金。各公司可根据不同历史时期和同行业的数据，比较分析自身产权比率的合理范围，对不属于合理范围的产权比率需查明原因并采取相应措施。',NULL,NULL,'GBL8007',NULL,1208),
(1209,'5','权益乘数概述','YBLFX_H-YBLFX_H==0','权益乘数=资产总额/所有者权益总额\r\n权益乘数反映了企业财务杠杆的大小。权益乘数越小，表明所有者投入企业的资本占全部资产的比重越大，企业的负债程度越低，长期偿债能力越强。权益乘数越大，说明股东投入的资本在资产中所占的比重越小，长期偿债能力越低。同时，若权益乘数偏高，管理层也需关注注册资本是否实缴。若未实缴，可要求股东进行缴纳，补充企业流动资金。各公司可根据不同历史时期和同行业的数据，比较分析自身权益乘数的合理范围，对不属于合理范围的权益乘数需查明原因并采取相应措施。',NULL,NULL,'GBL8008',NULL,1209),
(1210,'5','长期资本负债率概述','YBLFX_I-YBLFX_I==0','长期资本负债率=[非流动负债/(非流动负债+股东权益)]×100%\r\n长期资本负债率反映企业的长期资本的结构，且更为客观地反映企业的长期偿债能力。长期资本负债率越高，长期偿债能力越弱。同时，若该比率偏高，管理层也需关注注册资本是否实缴。若未实缴，可要求股东进行缴纳，补充企业流动资金。各公司可根据不同历史时期和同行业的数据，比较分析自身长期资本负债率的合理范围，对不属于合理范围的需查明原因并采取相应措施。',NULL,NULL,'GBL8009',NULL,1210),
(1211,'5','现金流量债务比概述','YBLFX_M-YBLFX_M==0','现金流量利息保障倍数=经营活动产生的现金净流量/利息费用\r\n现金流量利息保障倍数是指经营现金净流量为利息费用的倍数。它比收益基础的利息保障倍数更可靠，因为实际用以支付利息的是现金，而非收益。比率越高，偿还债务总额的能力越强。比率大于等于1时，则意味着企业的经营现金净流量可完全覆盖全部债务，偿债能力高。',NULL,NULL,'GBL8010',NULL,1211),
(1212,'5','应收账款周转天数概述','YBLFX_L-YBLFX_L==0','应收账款周转天数=平均应收账款余额/营业收入×天数\r\n应收账款周转天数表明从销售开始到收回现金平均需要的天数。应收账款周转天数越短，说明流动资金使用效率越好。大多数公司都存在信用销售，形成大量应收账款，如何快速将应收账款收回变成现金对公司持续运转至关重要。如果周转天数过长，公司将不得不通过借债等方式来补充营运资金，会造成财务费用的上涨和经营利润的压缩。在相同行业内，应收账款周转天数越短的公司通常有较强的竞争力。但值得指出的是，过短的应收账款周转天数，可能导致与客户的关系恶化。管理层需合理平衡延长付款期与维护客户关系之间的关系。\r\n一般情况下，建议企业应收账款周转天数不超过90天对企业运作较为有利。各公司可根据不同历史时期和同行业的数据，比较分析自身应收账款周转天数的合理范围，对不属于合理范围的需查明原因并采取相应措施。',NULL,NULL,'GBL8011',NULL,1212),
(1213,'5','存货周转天数概述','YBLFX_N-YBLFX_N==0','存货周转天数=平均存货余额/营业成本×天数\r\n   存货周转天数是指企业从取得存货开始，至消耗、销售为止所经历的天数。存货周转天数越低，公司存货周转速度快，销售状况更好。周转天数越高，则存货过多积压，造成资金浪费，不利于企业运营。 \r\n一般情况下，建议企业存货周转天数不超过90天对企业运作较为有利。各公司可根据不同历史时期和同行业的数据，比较分析自身存货周转天数的合理范围，对不属于合理范围的需查明原因并采取相应措施。',NULL,NULL,'GBL8012',NULL,1213),
(1214,'5','应付账款周转天数概述','YBLFX_O-YBLFX_O==0','应付账款周转天数=平均应付账款余额/营业成本×天数\r\n应付账款周转天数是衡量公司需要多长时间付清供应商的欠款。与应收账款周转天数不同的是，通常来说，应付账款周转天数越长越好。周转天数越长，企业可控制的现金越多，越有利于企业的资金利用。但值得指出的是，过长的应付账款周转天数，可能导致与供应商的关系恶化。管理层需合理平衡延长付款期与维护供应商关系之间的关系。各公司可根据不同历史时期和同行业的数据，比较分析自身应付账款周转天数的合理范围，对不属于合理范围的需查明原因并采取相应措施。',NULL,NULL,'GBL8013',NULL,1214),
(1215,'5','流动资产周转天数概述','YBLFX_P-YBLFX_P==0','流动资产周转天数=平均流动资产总额/营业收入×天数\r\n流动资产周转天数表明流动资产周转一次需要的时间，也就是流动资产转换成现金平均需要的时间。流动资产周转天数越短，企业现金流越健康，运营效果更好。',NULL,NULL,'GBL8014',NULL,1215),
(1216,'5','营业资本周转天数概述','YBLFX_Q-YBLFX_Q==0','营业资本周转天数=平均营运资本/营业收入×天数\r\n营运资本周转天数表明营业资本周转一次需要的时间。不存在衡量营运资本周转率的通用标准，只有将这一指标与企业历史水平，其他企业或同行业平均水平相比才有意义。如果营运资本周转率过低，表明营运资本使用率太低，即相对营运资本来讲，销售不足，有潜力可挖；如果营运资本周转率过高，则表明资本不足，业务清偿债务危机之中。',NULL,NULL,'GBL8015',NULL,1216),
(1217,'5','非流动资产周转天数概述','YBLFX_R-YBLFX_R==0','非流动资产周转天数=平均非流动资产/营业收入×天数\r\n非流动资产周转天数反映非流动资产的管理效率，主要用于投资预算和项目管理分析，以确定投资于竞争战略是否一致，收购和剥离政策是否合理等。',NULL,NULL,'GBL8016',NULL,1217),
(1218,'5','总资产周转天数概述','YBLFX_S-YBLFX_S==0','总资产周转天数=平均资产总额/营业收入×天数\r\n总资产周转天数反映企业经营期间全部资产从投入到产出的流转速度，反映了企业全部资产的管理质量和利用效率。总资产周转天数越小，说明总资产周转越快，销售能力越强，企业运营效率越高。\r\n如果企业的总资产周转天数突然下降，而企业的销售收入却无多大变化，则可能是企业本期报废了大量固定资产造成的，而不是企业的资产利用效率提高。\r\n如果企业的总资产天数较高，且长期处于较高的状态，企业应采取措施提高各项资产的利用效率，处置多余，闲置不用的资产，提高销售收入，从而提高总资产周转率。',NULL,NULL,'GBL8017',NULL,1218),
(1219,'5','销售净利润率概述','YBLFX_T-YBLFX_T==0','销售净利润率=净利润/营业收入×100%\r\n销售净利润率表明企业每单位销售收入净额可实现的净利润。销售净利润率越高，说明企业的获利能力越强，但它受行业特点影响较大，在分析时应该结合不同行业具体情况进行分析。','','','GBL8018','',1219),
(1220,'5','总资产净利润率概述','YBLFX_W-YBLFX_W==0','总资产净利润率=净利润/总资产×100%\r\n总资产净利润率是反映企业资产综合利用效果的指标，也是衡量企业利用债权人和所有者权益总额所取得盈利的重要指标。总资产净利润率越高，说明企业的每单位资产赚取的利润率越高。各公司可根据不同历史时期和同行业的数据，比较分析自身总资产净利润率的合理范围，并以此为依据制定预算并执行。',NULL,NULL,'GBL8019',NULL,1220),
(1221,'5','权益净利润率概述','YBLFX_Y-YBLFX_Y==0','权益净利润率=所有者权益/总资产×100%\r\n权益净利润率反映所有者权益所获报酬的水平。比率越高，股东的投资获利越高。各公司可根据不同历史时期和同行业的数据，比较分析自身权益净利润率的合理范围，并以此为依据制定预算并执行。',NULL,NULL,'GBL8020',NULL,1221),
(1222,'1','经营报告偿债能力分析','YBLFX_F-YBLFX_F1>0&&ZCFZ_BY-ZCFZ_BY1<0&&ZXFZ_AN-ZXFZ_AN1<0','本期资产负债率比上期有所上升，主要是因为负债的变动导致','','','GJYBG9001','',1222),
(1223,'1','经营报告营运情况分析','XJLL_Y>0&&XJLL_Y-XJLL_Y1>0','本期经营活动产生的现金流量净额为正数，且较上期有所增长，说明企业经营较为良好，建议管理层在维持现经营状况的前提下积极开源节流，争取占领更大的市场份额。除此以为，建议企业结合投资活动现金流入、投资活动现金流出及筹资活动现金流入、筹资活动现金流出的总体情况，对现金流量表进行总体分析。',NULL,NULL,'GJYBG9002',NULL,1223),
(1224,'1','经营报告营运情况分析','XJLL_Y>0&&XJLL_Y-XJLL_Y1<0','本期经营活动产生的现金流量净额为正数，说明企业经营较为良好，然而，目前企业经营活动产生的现金流仍存在以下问题：a)本期经营活动产生的现金流量净额比上期减少了Rmb{(XJLL_Y1-XJLL_Y)/10000}万元，说明企业本期经营活动未如上期理想。建议管理层结合应收账款周转期，应付账款周转期等指标，综合考虑本期经营活动产生的现金流量净额的减少的导因。如因应收账款回收期拖长导致现金流状况的改变，建议管理层与市场部讨论款项催收的措施，或考虑修改合同货期条款对企业可能产生的利益影响；如因付款周期变短引起现金流的波动，则考虑与供应商，尤其是主要供应商，讨论付款期的延长；如因内部开支等剧增导致经营性现金流出现下滑趋势，则需考虑调整绩效考核，评估人员配置等措施达到开源节流的目的，从而使现金流得到相应的改善。除此以为，建议企业结合投资活动现金流入、投资活动现金流出及筹资活动现金流入、筹资活动现金流出的总体情况，对现金流量表进行总体分析。','{(XJLL_Y1-XJLL_Y)/10000}',NULL,'GJYBG9002',NULL,1224),
(1225,'1','经营报告营运情况分析','XJLL_Y<0','本期经营活动产生的现金流量净额为负数，说明企业经营较为不理想，现金流管理存在较大问题。建议管理层结合应收账款及应付账款周转期等，综合分析经营活动现金流存在的问题，从以下方面着手进行整改：a)与供应商，尤其是主要供应商，就数期与供应商进行沟通，尽量延长付款期，以改善现金流出状况；b)与客户，尤其是前十大客户，就账期进行沟通，尽量缩短收款期，但是要注意收款期缩短可能导致的客户流失，管理层需分析收款期缩短对销售的敏感度，进行合理的调整；c)通过与绩效考核相挂钩等方式，控制日常经营活动中产生的费用支出以及人工支出，减少现金流出，从而达到使经营活动现金流净额扭负为正的目的。除此以为，建议企业结合投资活动现金流入、投资活动现金流出及筹资活动现金流入、筹资活动现金流出的总体情况，对现金流量表进行总体分析。',NULL,NULL,'GJYBG9002',NULL,1225),
(1892,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_A-ZCFZ_A1>0&& ZCFZ_A1!=0&&(ZCFZ_A-ZCFZ_A1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元增至本期的Rmb{ZCFZ_A/10000}万元，增长率达{(ZCFZ_A-ZCFZ_A1)/ZCFZ_A1*100}%，占总资产变动的{(ZCFZ_A-ZCFZ_A1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_A1/10000},{ZCFZ_A/10000},{(ZCFZ_A-ZCFZ_A1)/ZCFZ_A1*100},{(ZCFZ_A-ZCFZ_A1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1892),
(1893,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_D-ZCFZ_D1>0&& ZCFZ_D1!=0&&(ZCFZ_D-ZCFZ_D1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元增至本期的Rmb{ZCFZ_D/10000}万元，增长率达{(ZCFZ_D-ZCFZ_D1)/ZCFZ_D1*100}%，占总资产变动的{(ZCFZ_D-ZCFZ_D1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_D1/10000},{ZCFZ_D/10000},{(ZCFZ_D-ZCFZ_D1)/ZCFZ_D1*100},{(ZCFZ_D-ZCFZ_D1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1893),
(1894,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_E-ZCFZ_E1>0&& ZCFZ_E1!=0&&(ZCFZ_E-ZCFZ_E1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元增至本期的Rmb{ZCFZ_E/10000}万元，增长率达{(ZCFZ_E-ZCFZ_E1)/ZCFZ_E1*100}%，占总资产变动的{(ZCFZ_E-ZCFZ_E1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_E1/10000},{ZCFZ_E/10000},{(ZCFZ_E-ZCFZ_E1)/ZCFZ_E1*100},{(ZCFZ_E-ZCFZ_E1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1894),
(1895,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_F-ZCFZ_F1>0&& ZCFZ_F1!=0&&(ZCFZ_F-ZCFZ_F1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元增至本期的Rmb{ZCFZ_F/10000}万元，增长率达{(ZCFZ_F-ZCFZ_F1)/ZCFZ_F1*100}%，占总资产变动的{(ZCFZ_F-ZCFZ_F1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_F1/10000},{ZCFZ_F/10000},{(ZCFZ_F-ZCFZ_F1)/ZCFZ_F1*100},{(ZCFZ_F-ZCFZ_F1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1895),
(1896,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&& ZCFZ_G1!=0&&(ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元增至本期的Rmb{ZCFZ_G/10000}万元，增长率达{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100}%，占总资产变动的{(ZCFZ_G-ZCFZ_G1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_G1/10000},{ZCFZ_G/10000},{(ZCFZ_G-ZCFZ_G1)/ZCFZ_G1*100},{(ZCFZ_G-ZCFZ_G1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1896),
(1897,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_H-ZCFZ_H1>0&& ZCFZ_H1!=0&&(ZCFZ_H-ZCFZ_H1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元增至本期的Rmb{ZCFZ_H/10000}万元，增长率达{(ZCFZ_H-ZCFZ_H1)/ZCFZ_H1*100}%，占总资产变动的{(ZCFZ_H-ZCFZ_H1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_H1/10000},{ZCFZ_H/10000},{(ZCFZ_H-ZCFZ_H1)/ZCFZ_H1*100},{(ZCFZ_H-ZCFZ_H1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1897),
(1898,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_L-ZCFZ_L1>0&& ZCFZ_L1!=0&&(ZCFZ_L-ZCFZ_L1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收利息从上年同期的Rmb{ZCFZ_L1/10000}万元增至本期的Rmb{ZCFZ_L/10000}万元，增长率达{(ZCFZ_L-ZCFZ_L1)/ZCFZ_L1*100}%，占总资产变动的{(ZCFZ_L-ZCFZ_L1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_L1/10000},{ZCFZ_L/10000},{(ZCFZ_L-ZCFZ_L1)/ZCFZ_L1*100},{(ZCFZ_L-ZCFZ_L1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1898),
(1899,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_M-ZCFZ_M1>0&& ZCFZ_M1!=0&&(ZCFZ_M-ZCFZ_M1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元增至本期的Rmb{ZCFZ_M/10000}万元，增长率达{(ZCFZ_M-ZCFZ_M1)/ZCFZ_M1*100}%，占总资产变动的{(ZCFZ_M-ZCFZ_M1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_M1/10000},{ZCFZ_M/10000},{(ZCFZ_M-ZCFZ_M1)/ZCFZ_M1*100},{(ZCFZ_M-ZCFZ_M1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1899),
(1900,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_N-ZCFZ_N1>0&& ZCFZ_N1!=0&&(ZCFZ_N-ZCFZ_N1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元增至本期的Rmb{ZCFZ_N/10000}万元，增长率达{(ZCFZ_N-ZCFZ_N1)/ZCFZ_N1*100}%，占总资产变动的{(ZCFZ_N-ZCFZ_N1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_N1/10000},{ZCFZ_N/10000},{(ZCFZ_N-ZCFZ_N1)/ZCFZ_N1*100},{(ZCFZ_N-ZCFZ_N1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1900),
(1901,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&& ZCFZ_P1!=0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为存货从上年同期的Rmb{ZCFZ_P1/10000}万元增至本期的Rmb{ZCFZ_P/10000}万元，增长率达{(ZCFZ_P-ZCFZ_P1)/ZCFZ_P1*100}%，占总资产变动的{(ZCFZ_P-ZCFZ_P1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_P1/10000},{ZCFZ_P/10000},{(ZCFZ_P-ZCFZ_P1)/ZCFZ_P1*100},{(ZCFZ_P-ZCFZ_P1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1901),
(1902,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Q-ZCFZ_Q1>0&& ZCFZ_Q1!=0&&(ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为持有待售资产从上年同期的Rmb{ZCFZ_Q1/10000}万元增至本期的Rmb{ZCFZ_Q/10000}万元，增长率达{(ZCFZ_Q-ZCFZ_Q1)/ZCFZ_Q1*100}%，占总资产变动的{(ZCFZ_Q-ZCFZ_Q1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000},{(ZCFZ_Q-ZCFZ_Q1)/ZCFZ_Q1*100},{(ZCFZ_Q-ZCFZ_Q1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1902),
(1903,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_R-ZCFZ_R1>0&& ZCFZ_R1!=0&&(ZCFZ_R-ZCFZ_R1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为一年内到期的非流动资产从上年同期的Rmb{ZCFZ_R1/10000}万元增至本期的Rmb{ZCFZ_R/10000}万元，增长率达{(ZCFZ_R-ZCFZ_R1)/ZCFZ_R1*100}%，占总资产变动的{(ZCFZ_R-ZCFZ_R1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_R1/10000},{ZCFZ_R/10000},{(ZCFZ_R-ZCFZ_R1)/ZCFZ_R1*100},{(ZCFZ_R-ZCFZ_R1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1903),
(1904,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_S-ZCFZ_S1>0&& ZCFZ_S1!=0&&(ZCFZ_S-ZCFZ_S1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元增至本期的Rmb{ZCFZ_S/10000}万元，增长率达{(ZCFZ_S-ZCFZ_S1)/ZCFZ_S1*100}%，占总资产变动的{(ZCFZ_S-ZCFZ_S1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_S1/10000},{ZCFZ_S/10000},{(ZCFZ_S-ZCFZ_S1)/ZCFZ_S1*100},{(ZCFZ_S-ZCFZ_S1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1904),
(1905,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_V-ZCFZ_V1>0&& ZCFZ_V1!=0&&(ZCFZ_V-ZCFZ_V1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元增至本期的Rmb{ZCFZ_V/10000}万元，增长率达{(ZCFZ_V-ZCFZ_V1)/ZCFZ_V1*100}%，占总资产变动的{(ZCFZ_V-ZCFZ_V1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_V1/10000},{ZCFZ_V/10000},{(ZCFZ_V-ZCFZ_V1)/ZCFZ_V1*100},{(ZCFZ_V-ZCFZ_V1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1905),
(1906,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_W-ZCFZ_W1>0&& ZCFZ_W1!=0&&(ZCFZ_W-ZCFZ_W1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元增至本期的Rmb{ZCFZ_W/10000}万元，增长率达{(ZCFZ_W-ZCFZ_W1)/ZCFZ_W1*100}%，占总资产变动的{(ZCFZ_W-ZCFZ_W1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_W1/10000},{ZCFZ_W/10000},{(ZCFZ_W-ZCFZ_W1)/ZCFZ_W1*100},{(ZCFZ_W-ZCFZ_W1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1906),
(1907,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_X-ZCFZ_X1>0&& ZCFZ_X1!=0&&(ZCFZ_X-ZCFZ_X1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元增至本期的Rmb{ZCFZ_X/10000}万元，增长率达{(ZCFZ_X-ZCFZ_X1)/ZCFZ_X1*100}%，占总资产变动的{(ZCFZ_X-ZCFZ_X1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_X1/10000},{ZCFZ_X/10000},{(ZCFZ_X-ZCFZ_X1)/ZCFZ_X1*100},{(ZCFZ_X-ZCFZ_X1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1907),
(1908,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Y-ZCFZ_Y1>0&& ZCFZ_Y1!=0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元增至本期的Rmb{ZCFZ_Y/10000}万元，增长率达{(ZCFZ_Y-ZCFZ_Y1)/ZCFZ_Y1*100}%，占总资产变动的{(ZCFZ_Y-ZCFZ_Y1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Y1/10000},{ZCFZ_Y/10000},{(ZCFZ_Y-ZCFZ_Y1)/ZCFZ_Y1*100},{(ZCFZ_Y-ZCFZ_Y1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1908),
(1909,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Z-ZCFZ_Z1>0&& ZCFZ_Z1!=0&&(ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元增至本期的Rmb{ZCFZ_Z/10000}万元，增长率达{(ZCFZ_Z-ZCFZ_Z1)/ZCFZ_Z1*100}%，占总资产变动的{(ZCFZ_Z-ZCFZ_Z1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Z1/10000},{ZCFZ_Z/10000},{(ZCFZ_Z-ZCFZ_Z1)/ZCFZ_Z1*100},{(ZCFZ_Z-ZCFZ_Z1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1909),
(1910,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AA-ZCFZ_AA1>0&& ZCFZ_AA1!=0&&(ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元增至本期的Rmb{ZCFZ_AA/10000}万元，增长率达{(ZCFZ_AA-ZCFZ_AA1)/ZCFZ_AA1*100}%，占总资产变动的{(ZCFZ_AA-ZCFZ_AA1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AA1/10000},{ZCFZ_AA/10000},{(ZCFZ_AA-ZCFZ_AA1)/ZCFZ_AA1*100},{(ZCFZ_AA-ZCFZ_AA1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1910),
(1911,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AB-ZCFZ_AB1>0&& ZCFZ_AB1!=0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元增至本期的Rmb{ZCFZ_AB/10000}万元，增长率达{(ZCFZ_AB-ZCFZ_AB1)/ZCFZ_AB1*100}%，占总资产变动的{(ZCFZ_AB-ZCFZ_AB1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AB1/10000},{ZCFZ_AB/10000},{(ZCFZ_AB-ZCFZ_AB1)/ZCFZ_AB1*100},{(ZCFZ_AB-ZCFZ_AB1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1911),
(1912,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AC-ZCFZ_AC1>0&&ZCFZ_AC1!=0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元增至本期的Rmb{ZCFZ_AC/10000}万元，增长率达{(ZCFZ_AC-ZCFZ_AC1)/ZCFZ_AC1*100}%，占总资产变动的{(ZCFZ_AC-ZCFZ_AC1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AC1/10000},{ZCFZ_AC/10000},{(ZCFZ_AC-ZCFZ_AC1)/ZCFZ_AC1*100},{(ZCFZ_AC-ZCFZ_AC1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1912),
(1913,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AD-ZCFZ_AD1>0&&ZCFZ_AD1!=0&&(ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元增至本期的Rmb{ZCFZ_AD/10000}万元，增长率达{(ZCFZ_AD-ZCFZ_AD1)/ZCFZ_AD1*100}%，占总资产变动的{(ZCFZ_AD-ZCFZ_AD1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AD1/10000},{ZCFZ_AD/10000},{(ZCFZ_AD-ZCFZ_AD1)/ZCFZ_AD1*100},{(ZCFZ_AD-ZCFZ_AD1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1913),
(1914,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AE-ZCFZ_AE1>0&&ZCFZ_AE1!=0&&(ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元增至本期的Rmb{ZCFZ_AE/10000}万元，增长率达{(ZCFZ_AE-ZCFZ_AE1)/ZCFZ_AE1*100}%，占总资产变动的{(ZCFZ_AE-ZCFZ_AE1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AE1/10000},{ZCFZ_AE/10000},{(ZCFZ_AE-ZCFZ_AE1)/ZCFZ_AE1*100},{(ZCFZ_AE-ZCFZ_AE1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1914),
(1915,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AF-ZCFZ_AF1>0&&ZCFZ_AF1!=0&&(ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元增至本期的Rmb{ZCFZ_AF/10000}万元，增长率达{(ZCFZ_AF-ZCFZ_AF1)/ZCFZ_AF1*100}%，占总资产变动的{(ZCFZ_AF-ZCFZ_AF1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AF1/10000},{ZCFZ_AF/10000},{(ZCFZ_AF-ZCFZ_AF1)/ZCFZ_AF1*100},{(ZCFZ_AF-ZCFZ_AF1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1915),
(1916,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AG-ZCFZ_AG1>0&&ZCFZ_AG1!=0&&(ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元增至本期的Rmb{ZCFZ_AG/10000}万元，增长率达{(ZCFZ_AG-ZCFZ_AG1)/ZCFZ_AG1*100}%，占总资产变动的{(ZCFZ_AG-ZCFZ_AG1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AG1/10000},{ZCFZ_AG/10000},{(ZCFZ_AG-ZCFZ_AG1)/ZCFZ_AG1*100},{(ZCFZ_AG-ZCFZ_AG1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1916),
(1917,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AH-ZCFZ_AH1>0&&ZCFZ_AH1!=0&&(ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元增至本期的Rmb{ZCFZ_AH/10000}万元，增长率达{(ZCFZ_AH-ZCFZ_AH1)/ZCFZ_AH1*100}%，占总资产变动的{(ZCFZ_AH-ZCFZ_AH1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AH1/10000},{ZCFZ_AH/10000},{(ZCFZ_AH-ZCFZ_AH1)/ZCFZ_AH1*100},{(ZCFZ_AH-ZCFZ_AH1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1917),
(1918,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AI-ZCFZ_AI1>0&&ZCFZ_AI1!=0&&(ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为商誉从上年同期的Rmb{ZCFZ_AI1/10000}万元增至本期的Rmb{ZCFZ_AI/10000}万元，增长率达{(ZCFZ_AI-ZCFZ_AI1)/ZCFZ_AI1*100}%，占总资产变动的{(ZCFZ_AI-ZCFZ_AI1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AI1/10000},{ZCFZ_AI/10000},{(ZCFZ_AI-ZCFZ_AI1)/ZCFZ_AI1*100},{(ZCFZ_AI-ZCFZ_AI1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1918),
(1919,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AJ-ZCFZ_AJ1>0&&ZCFZ_AJ1!=0&&(ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元增至本期的Rmb{ZCFZ_AJ/10000}万元，增长率达{(ZCFZ_AJ-ZCFZ_AJ1)/ZCFZ_AJ1*100}%，占总资产变动的{(ZCFZ_AJ-ZCFZ_AJ1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000},{(ZCFZ_AJ-ZCFZ_AJ1)/ZCFZ_AJ1*100},{(ZCFZ_AJ-ZCFZ_AJ1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1919),
(1920,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AK-ZCFZ_AK1>0&&ZCFZ_AK1!=0&&(ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元增至本期的Rmb{ZCFZ_AK/10000}万元，增长率达{(ZCFZ_AK-ZCFZ_AK1)/ZCFZ_AK1*100}%，占总资产变动的{(ZCFZ_AK-ZCFZ_AK1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AK1/10000},{ZCFZ_AK/10000},{(ZCFZ_AK-ZCFZ_AK1)/ZCFZ_AK1*100},{(ZCFZ_AK-ZCFZ_AK1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1920),
(1921,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AL-ZCFZ_AL1>0&&ZCFZ_AL1!=0&&(ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AK-ZCFZ_AK1)>0','本期总资产较上年同期有所增长，主要是因为其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元增至本期的Rmb{ZCFZ_AL/10000}万元，增长率达{(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1*100}%，占总资产变动的{(ZCFZ_AL-ZCFZ_AL1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AL1/10000},{ZCFZ_AL/10000},{(ZCFZ_AL-ZCFZ_AL1)/ZCFZ_AL1*100},{(ZCFZ_AL-ZCFZ_AL1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1921),
(1922,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_A-ZCFZ_A1>0&&ZCFZ_A1==0&&(ZCFZ_A-ZCFZ_A1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元增至本期的Rmb{ZCFZ_A/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_A-ZCFZ_A1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_A1/10000},{ZCFZ_A/10000},{(ZCFZ_A-ZCFZ_A1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1922),
(1923,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_D-ZCFZ_D1>0&&ZCFZ_D1==0&&(ZCFZ_D-ZCFZ_D1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元增至本期的Rmb{ZCFZ_D/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_D-ZCFZ_D1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_D1/10000},{ZCFZ_D/10000},{(ZCFZ_D-ZCFZ_D1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1923),
(1924,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_E-ZCFZ_E1>0&&ZCFZ_E1==0&&(ZCFZ_E-ZCFZ_E1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元增至本期的Rmb{ZCFZ_E/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_E-ZCFZ_E1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_E1/10000},{ZCFZ_E/10000},{(ZCFZ_E-ZCFZ_E1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1924),
(1925,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_F-ZCFZ_F1>0&&ZCFZ_F1==0&&(ZCFZ_F-ZCFZ_F1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元增至本期的Rmb{ZCFZ_F/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_F-ZCFZ_F1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_F1/10000},{ZCFZ_F/10000},{(ZCFZ_F-ZCFZ_F1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1925),
(1926,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&&ZCFZ_G1==0&&(ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元增至本期的Rmb{ZCFZ_G/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_G-ZCFZ_G1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_G1/10000},{ZCFZ_G/10000},{(ZCFZ_G-ZCFZ_G1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1926),
(1927,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_H-ZCFZ_H1>0&&ZCFZ_H1==0&&(ZCFZ_H-ZCFZ_H1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元增至本期的Rmb{ZCFZ_H/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_H-ZCFZ_H1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_H1/10000},{ZCFZ_H/10000},{(ZCFZ_H-ZCFZ_H1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1927),
(1928,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_L-ZCFZ_L1>0&&ZCFZ_L1==0&&(ZCFZ_L-ZCFZ_L1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收利息从上年同期的Rmb{ZCFZ_L1/10000}万元增至本期的Rmb{ZCFZ_L/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_L-ZCFZ_L1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_L1/10000},{ZCFZ_L/10000},{(ZCFZ_L-ZCFZ_L1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1928),
(1929,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_M-ZCFZ_M1>0&&ZCFZ_M1==0&&(ZCFZ_M-ZCFZ_M1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元增至本期的Rmb{ZCFZ_M/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_M-ZCFZ_M1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_M1/10000},{ZCFZ_M/10000},{(ZCFZ_M-ZCFZ_M1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1929),
(1930,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_N-ZCFZ_N1>0&&ZCFZ_N1==0&&(ZCFZ_N-ZCFZ_N1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元增至本期的Rmb{ZCFZ_N/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_N-ZCFZ_N1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_N1/10000},{ZCFZ_N/10000},{(ZCFZ_N-ZCFZ_N1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1930),
(1931,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&&ZCFZ_P1==0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为存货从上年同期的Rmb{ZCFZ_P1/10000}万元增至本期的Rmb{ZCFZ_P/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_P-ZCFZ_P1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_P1/10000},{ZCFZ_P/10000},{(ZCFZ_P-ZCFZ_P1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1931),
(1932,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Q-ZCFZ_Q1>0&&ZCFZ_Q1==0&&(ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为持有待售资产从上年同期的Rmb{ZCFZ_Q1/10000}万元增至本期的Rmb{ZCFZ_Q/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_Q-ZCFZ_Q1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000},{(ZCFZ_Q-ZCFZ_Q1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1932),
(1933,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_R-ZCFZ_R1>0&&ZCFZ_R1==0&&(ZCFZ_R-ZCFZ_R1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为一年内到期的非流动资产从上年同期的Rmb{ZCFZ_R1/10000}万元增至本期的Rmb{ZCFZ_R/10000}万元，增长率达%，占总资产变动的{(ZCFZ_R-ZCFZ_R1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_R1/10000},{ZCFZ_R/10000},{(ZCFZ_R-ZCFZ_R1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1933),
(1934,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_S-ZCFZ_S1>0&&ZCFZ_S1==0&&(ZCFZ_S-ZCFZ_S1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元增至本期的Rmb{ZCFZ_S/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_S-ZCFZ_S1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_S1/10000},{ZCFZ_S/10000},{(ZCFZ_S-ZCFZ_S1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1934),
(1935,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_V-ZCFZ_V1>0&&ZCFZ_V1==0&&(ZCFZ_V-ZCFZ_V1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元增至本期的Rmb{ZCFZ_V/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_V-ZCFZ_V1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_V1/10000},{ZCFZ_V/10000},{(ZCFZ_V-ZCFZ_V1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1935),
(1936,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_W-ZCFZ_W1>0&&ZCFZ_W1==0&&(ZCFZ_W-ZCFZ_W1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元增至本期的Rmb{ZCFZ_W/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_W-ZCFZ_W1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_W1/10000},{ZCFZ_W/10000},{(ZCFZ_W-ZCFZ_W1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1936),
(1937,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_X-ZCFZ_X1>0&&ZCFZ_X1==0&&(ZCFZ_X-ZCFZ_X1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元增至本期的Rmb{ZCFZ_X/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_X-ZCFZ_X1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_X1/10000},{ZCFZ_X/10000},{(ZCFZ_X-ZCFZ_X1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1937),
(1938,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Y-ZCFZ_Y1>0&&ZCFZ_Y1==0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元增至本期的Rmb{ZCFZ_Y/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_Y-ZCFZ_Y1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Y1/10000},{ZCFZ_Y/10000},{(ZCFZ_Y-ZCFZ_Y1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1938),
(1939,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Z-ZCFZ_Z1>0&&ZCFZ_Z1==0&&(ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元增至本期的Rmb{ZCFZ_Z/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_Z-ZCFZ_Z1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_Z1/10000},{ZCFZ_Z/10000},{(ZCFZ_Z-ZCFZ_Z1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1939),
(1940,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AA-ZCFZ_AA1>0&&ZCFZ_AA1==0&&(ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元增至本期的Rmb{ZCFZ_AA/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AA-ZCFZ_AA1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AA1/10000},{ZCFZ_AA/10000},{(ZCFZ_AA-ZCFZ_AA1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1940),
(1941,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AB-ZCFZ_AB1>0&&ZCFZ_AB1==0&&(ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元增至本期的Rmb{ZCFZ_AB/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AB-ZCFZ_AB1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AB1/10000},{ZCFZ_AB/10000},{(ZCFZ_AB-ZCFZ_AB1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1941),
(1942,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AC-ZCFZ_AC1>0&&ZCFZ_AC1==0&&(ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元增至本期的Rmb{ZCFZ_AC/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AC-ZCFZ_AC1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AC1/10000},{ZCFZ_AC/10000},{(ZCFZ_AC-ZCFZ_AC1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1942),
(1943,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AD-ZCFZ_AD1>0&&ZCFZ_AD1==0&&(ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元增至本期的Rmb{ZCFZ_AD/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AD-ZCFZ_AD1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AD1/10000},{ZCFZ_AD/10000},{(ZCFZ_AD-ZCFZ_AD1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1943),
(1944,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AE-ZCFZ_AE1>0&&ZCFZ_AE1==0&&(ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元增至本期的Rmb{ZCFZ_AE/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AE-ZCFZ_AE1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AE1/10000},{ZCFZ_AE/10000},{(ZCFZ_AE-ZCFZ_AE1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1944),
(1945,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AF-ZCFZ_AF1>0&&ZCFZ_AF1==0&&(ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元增至本期的Rmb{ZCFZ_AF/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AF-ZCFZ_AF1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AF1/10000},{ZCFZ_AF/10000},{(ZCFZ_AF-ZCFZ_AF1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1945),
(1946,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AG-ZCFZ_AG1>0&&ZCFZ_AG1==0&&(ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元增至本期的Rmb{ZCFZ_AG/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AG-ZCFZ_AG1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AG1/10000},{ZCFZ_AG/10000},{(ZCFZ_AG-ZCFZ_AG1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1946),
(1947,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AH-ZCFZ_AH1>0&&ZCFZ_AH1==0&&(ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元增至本期的Rmb{ZCFZ_AH/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AH-ZCFZ_AH1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AH1/10000},{ZCFZ_AH/10000},{(ZCFZ_AH-ZCFZ_AH1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1947),
(1948,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AI-ZCFZ_AI1>0&&ZCFZ_AI1==0&&(ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为商誉从上年同期的Rmb{ZCFZ_AI1/10000}万元增至本期的Rmb{ZCFZ_AI/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AI-ZCFZ_AI1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AI1/10000},{ZCFZ_AI/10000},{(ZCFZ_AI-ZCFZ_AI1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1948),
(1949,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AJ-ZCFZ_AJ1>0&&ZCFZ_AJ1==0&&(ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元增至本期的Rmb{ZCFZ_AJ/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AJ-ZCFZ_AJ1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000},{(ZCFZ_AJ-ZCFZ_AJ1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1949),
(1950,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AK-ZCFZ_AK1>0&&ZCFZ_AK1==0&&(ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期总资产较上年同期有所增长，主要是因为递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元增至本期的Rmb{ZCFZ_AK/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AK-ZCFZ_AK1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AK1/10000},{ZCFZ_AK/10000},{(ZCFZ_AK-ZCFZ_AK1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1950),
(1951,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AL-ZCFZ_AL1>0&&ZCFZ_AL1==0&&(ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AK-ZCFZ_AK1)>0','本期总资产较上年同期有所增长，主要是因为其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元增至本期的Rmb{ZCFZ_AL/10000}万元，增长率达-%，占总资产变动的{(ZCFZ_AL-ZCFZ_AL1)/(ZCFZ_AN-ZCFZ_AN1)*100}%。','{ZCFZ_AL1/10000},{ZCFZ_AL/10000},{(ZCFZ_AL-ZCFZ_AL1)/(ZCFZ_AN-ZCFZ_AN1)*100}',NULL,'G1001',NULL,1951),
(1952,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_A1-ZCFZ_A>0&&(ZCFZ_A1-ZCFZ_A)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为货币资金从上年同期的Rmb{ZCFZ_A1/10000}万元下降至本期的Rmb{ZCFZ_A/10000}万元，下降率达{(ZCFZ_A1-ZCFZ_A)/ZCFZ_A1*100}%，占总资产变动的{(ZCFZ_A1-ZCFZ_A)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_A1/10000},{ZCFZ_A/10000},{(ZCFZ_A1-ZCFZ_A)/ZCFZ_A1*100},{(ZCFZ_A1-ZCFZ_A)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1952),
(1953,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_D1-ZCFZ_D>0&&(ZCFZ_D1-ZCFZ_D)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为以公允价值计量且其变动计入当期损益的金融资产从上年同期的Rmb{ZCFZ_D1/10000}万元下降至本期的Rmb{ZCFZ_D/10000}万元，下降率达{(ZCFZ_D1-ZCFZ_D)/ZCFZ_D1*100}%，占总资产变动的{(ZCFZ_D1-ZCFZ_D)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_D1/10000},{ZCFZ_D/10000},{(ZCFZ_D1-ZCFZ_D)/ZCFZ_D1*100},{(ZCFZ_D1-ZCFZ_D)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1953),
(1954,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_E1-ZCFZ_E>0&&(ZCFZ_E1-ZCFZ_E)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为衍生金融资产从上年同期的Rmb{ZCFZ_E1/10000}万元下降至本期的Rmb{ZCFZ_E/10000}万元，下降率达{(ZCFZ_E1-ZCFZ_E)/ZCFZ_E1*100}%，占总资产变动的{(ZCFZ_E1-ZCFZ_E)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_E1/10000},{ZCFZ_E/10000},{(ZCFZ_E1-ZCFZ_E)/ZCFZ_E1*100},{(ZCFZ_E1-ZCFZ_E)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1954),
(1955,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_F1-ZCFZ_F>0&&(ZCFZ_F1-ZCFZ_F)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为应收票据从上年同期的Rmb{ZCFZ_F1/10000}万元下降至本期的Rmb{ZCFZ_F/10000}万元，下降率达{(ZCFZ_F1-ZCFZ_F)/ZCFZ_F1*100}%，占总资产变动的{(ZCFZ_F1-ZCFZ_F)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_F1/10000},{ZCFZ_F/10000},{(ZCFZ_F1-ZCFZ_F)/ZCFZ_F1*100},{(ZCFZ_F1-ZCFZ_F)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1955),
(1956,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_G1-ZCFZ_G>0&&(ZCFZ_G1-ZCFZ_G)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为应收账款从上年同期的Rmb{ZCFZ_G1/10000}万元下降至本期的Rmb{ZCFZ_G/10000}万元，下降率达{(ZCFZ_G1-ZCFZ_G)/ZCFZ_G1*100}%，占总资产变动的{(ZCFZ_G1-ZCFZ_G)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_G1/10000},{ZCFZ_G/10000},{(ZCFZ_G1-ZCFZ_G)/ZCFZ_G1*100},{(ZCFZ_G1-ZCFZ_G)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1956),
(1957,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_H1-ZCFZ_H>0&&(ZCFZ_H1-ZCFZ_H)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为预付款项从上年同期的Rmb{ZCFZ_H1/10000}万元下降至本期的Rmb{ZCFZ_H/10000}万元，下降率达{(ZCFZ_H1-ZCFZ_H)/ZCFZ_H1*100}%，占总资产变动的{(ZCFZ_H1-ZCFZ_H)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_H1/10000},{ZCFZ_H/10000},{(ZCFZ_H1-ZCFZ_H)/ZCFZ_H1*100},{(ZCFZ_H1-ZCFZ_H)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1957),
(1958,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_L1-ZCFZ_L>0&&(ZCFZ_L1-ZCFZ_L)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为应收利息从上年同期的Rmb{ZCFZ_L1/10000}万元下降至本期的Rmb{ZCFZ_L/10000}万元，下降率达{(ZCFZ_L1-ZCFZ_L)/ZCFZ_L1*100}%，占总资产变动的{(ZCFZ_L1-ZCFZ_L)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_L1/10000},{ZCFZ_L/10000},{(ZCFZ_L1-ZCFZ_L)/ZCFZ_L1*100},{(ZCFZ_L1-ZCFZ_L)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1958),
(1959,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_M1-ZCFZ_M>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为应收股利从上年同期的Rmb{ZCFZ_M1/10000}万元下降至本期的Rmb{ZCFZ_M/10000}万元，下降率达{(ZCFZ_M1-ZCFZ_M)/ZCFZ_M1*100}%，占总资产变动的{(ZCFZ_M1-ZCFZ_M)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_M1/10000},{ZCFZ_M/10000},{(ZCFZ_M1-ZCFZ_M)/ZCFZ_M1*100},{(ZCFZ_M1-ZCFZ_M)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1959),
(1960,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_N1-ZCFZ_N>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为其他应收款从上年同期的Rmb{ZCFZ_N1/10000}万元下降至本期的Rmb{ZCFZ_N/10000}万元，下降率达{(ZCFZ_N1-ZCFZ_N)/ZCFZ_N1*100}%，占总资产变动的{(ZCFZ_N1-ZCFZ_N)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_N1/10000},{ZCFZ_N/10000},{(ZCFZ_N1-ZCFZ_N)/ZCFZ_N1*100},{(ZCFZ_N1-ZCFZ_N)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1960),
(1961,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_P1-ZCFZ_P>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为存货从上年同期的Rmb{ZCFZ_P1/10000}万元下降至本期的Rmb{ZCFZ_P/10000}万元，下降率达{(ZCFZ_P1-ZCFZ_P)/ZCFZ_P1*100}%，占总资产变动的{(ZCFZ_P1-ZCFZ_P)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_P1/10000},{ZCFZ_P/10000},{(ZCFZ_P1-ZCFZ_P)/ZCFZ_P1*100},{(ZCFZ_P1-ZCFZ_P)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1961),
(1962,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Q1-ZCFZ_Q>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为持有待售的资产从上年同期的Rmb{ZCFZ_Q1/10000}万元下降至本期的Rmb{ZCFZ_Q/10000}万元，下降率达{(ZCFZ_Q1-ZCFZ_Q)/ZCFZ_Q1*100}%，占总资产变动的{(ZCFZ_Q1-ZCFZ_Q)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_Q1/10000},{ZCFZ_Q/10000},{(ZCFZ_Q1-ZCFZ_Q)/ZCFZ_Q1*100},{(ZCFZ_Q1-ZCFZ_Q)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1962),
(1963,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_R1-ZCFZ_R>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为一年内到期的非流动资产从上年同期的Rmb{ZCFZ_R1/10000}万元下降至本期的Rmb{ZCFZ_R/10000}万元，下降率达{(ZCFZ_R1-ZCFZ_R)/ZCFZ_R1*100}%，占总资产变动的{(ZCFZ_R1-ZCFZ_R)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_R1/10000},{ZCFZ_R/10000},{(ZCFZ_R1-ZCFZ_R)/ZCFZ_R1*100},{(ZCFZ_R1-ZCFZ_R)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1963),
(1964,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_S1-ZCFZ_S>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为其他流动资产从上年同期的Rmb{ZCFZ_S1/10000}万元下降至本期的Rmb{ZCFZ_S/10000}万元，下降率达{(ZCFZ_S1-ZCFZ_S)/ZCFZ_S1*100}%，占总资产变动的{(ZCFZ_S1-ZCFZ_S)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_S1/10000},{ZCFZ_S/10000},{(ZCFZ_S1-ZCFZ_S)/ZCFZ_S1*100},{(ZCFZ_S1-ZCFZ_S)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1964),
(1965,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_V1-ZCFZ_V>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为可供出售金融资产从上年同期的Rmb{ZCFZ_V1/10000}万元下降至本期的Rmb{ZCFZ_V/10000}万元，下降率达{(ZCFZ_V1-ZCFZ_V)/ZCFZ_V1*100}%，占总资产变动的{(ZCFZ_V1-ZCFZ_V)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_V1/10000},{ZCFZ_V/10000},{(ZCFZ_V1-ZCFZ_V)/ZCFZ_V1*100},{(ZCFZ_V1-ZCFZ_V)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1965),
(1966,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_W1-ZCFZ_W>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为持有至到期投资从上年同期的Rmb{ZCFZ_W1/10000}万元下降至本期的Rmb{ZCFZ_W/10000}万元，下降率达{(ZCFZ_W1-ZCFZ_W)/ZCFZ_W1*100}%，占总资产变动的{(ZCFZ_W1-ZCFZ_W)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_W1/10000},{ZCFZ_W/10000},{(ZCFZ_W1-ZCFZ_W)/ZCFZ_W1*100},{(ZCFZ_W1-ZCFZ_W)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1966),
(1967,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_X1-ZCFZ_X>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为长期应收款从上年同期的Rmb{ZCFZ_X1/10000}万元下降至本期的Rmb{ZCFZ_X/10000}万元，下降率达{(ZCFZ_X1-ZCFZ_X)/ZCFZ_X1*100}%，占总资产变动的{(ZCFZ_X1-ZCFZ_X)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_X1/10000},{ZCFZ_X/10000},{(ZCFZ_X1-ZCFZ_X)/ZCFZ_X1*100},{(ZCFZ_X1-ZCFZ_X)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1967),
(1968,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Y1-ZCFZ_Y>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为长期股权投资从上年同期的Rmb{ZCFZ_Y1/10000}万元下降至本期的Rmb{ZCFZ_Y/10000}万元，下降率达{(ZCFZ_Y1-ZCFZ_Y)/ZCFZ_Y1*100}%，占总资产变动的{(ZCFZ_Y1-ZCFZ_Y)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_Y1/10000},{ZCFZ_Y/10000},{(ZCFZ_Y1-ZCFZ_Y)/ZCFZ_Y1*100},{(ZCFZ_Y1-ZCFZ_Y)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1968),
(1969,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Z1-ZCFZ_Z>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为投资性房地产从上年同期的Rmb{ZCFZ_Z1/10000}万元下降至本期的Rmb{ZCFZ_Z/10000}万元，下降率达{(ZCFZ_Z1-ZCFZ_Z)/ZCFZ_Z1*100}%，占总资产变动的{(ZCFZ_Z1-ZCFZ_Z)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_Z1/10000},{ZCFZ_Z/10000},{(ZCFZ_Z1-ZCFZ_Z)/ZCFZ_Z1*100},{(ZCFZ_Z1-ZCFZ_Z)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1969),
(1970,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AA1-ZCFZ_AA>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为固定资产从上年同期的Rmb{ZCFZ_AA1/10000}万元下降至本期的Rmb{ZCFZ_AA/10000}万元，下降率达{(ZCFZ_AA1-ZCFZ_AA)/ZCFZ_AA1*100}%，占总资产变动的{(ZCFZ_AA1-ZCFZ_AA)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AA1/10000},{ZCFZ_AA/10000},{(ZCFZ_AA1-ZCFZ_AA)/ZCFZ_AA1*100},{(ZCFZ_AA1-ZCFZ_AA)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1970),
(1971,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AB1-ZCFZ_AB>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为在建工程从上年同期的Rmb{ZCFZ_AB1/10000}万元下降至本期的Rmb{ZCFZ_AB/10000}万元，下降率达{(ZCFZ_AB1-ZCFZ_AB)/ZCFZ_AB1*100}%，占总资产变动的{(ZCFZ_AB1-ZCFZ_AB)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AB1/10000},{ZCFZ_AB/10000},{(ZCFZ_AB1-ZCFZ_AB)/ZCFZ_AB1*100},{(ZCFZ_AB1-ZCFZ_AB)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1971),
(1972,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AC1-ZCFZ_AC>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为工程物资从上年同期的Rmb{ZCFZ_AC1/10000}万元下降至本期的Rmb{ZCFZ_AC/10000}万元，下降率达{(ZCFZ_AC1-ZCFZ_AC)/ZCFZ_AC1*100}%，占总资产变动的{(ZCFZ_AC1-ZCFZ_AC)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AC1/10000},{ZCFZ_AC/10000},{(ZCFZ_AC1-ZCFZ_AC)/ZCFZ_AC1*100},{(ZCFZ_AC1-ZCFZ_AC)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1972),
(1973,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AD1-ZCFZ_AD>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为固定资产清理从上年同期的Rmb{ZCFZ_AD1/10000}万元下降至本期的Rmb{ZCFZ_AD/10000}万元，下降率达{(ZCFZ_AD1-ZCFZ_AD)/ZCFZ_AD1*100}%，占总资产变动的{(ZCFZ_AD1-ZCFZ_AD)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AD1/10000},{ZCFZ_AD/10000},{(ZCFZ_AD1-ZCFZ_AD)/ZCFZ_AD1*100},{(ZCFZ_AD1-ZCFZ_AD)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1973),
(1974,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AE1-ZCFZ_AE>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为生产性生物资产从上年同期的Rmb{ZCFZ_AE1/10000}万元下降至本期的Rmb{ZCFZ_AE/10000}万元，下降率达{(ZCFZ_AE1-ZCFZ_AE)/ZCFZ_AE1*100}%，占总资产变动的{(ZCFZ_AE1-ZCFZ_AE)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AE1/10000},{ZCFZ_AE/10000},{(ZCFZ_AE1-ZCFZ_AE)/ZCFZ_AE1*100},{(ZCFZ_AE1-ZCFZ_AE)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1974),
(1975,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AF1-ZCFZ_AF>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为油气资产从上年同期的Rmb{ZCFZ_AF1/10000}万元下降至本期的Rmb{ZCFZ_AF/10000}万元，下降率达{(ZCFZ_AF1-ZCFZ_AF)/ZCFZ_AF1*100}%，占总资产变动的{(ZCFZ_AF1-ZCFZ_AF)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AF1/10000},{ZCFZ_AF/10000},{(ZCFZ_AF1-ZCFZ_AF)/ZCFZ_AF1*100},{(ZCFZ_AF1-ZCFZ_AF)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1975),
(1976,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AG1-ZCFZ_AG>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为无形资产从上年同期的Rmb{ZCFZ_AG1/10000}万元下降至本期的Rmb{ZCFZ_AG/10000}万元，下降率达{(ZCFZ_AG1-ZCFZ_AG)/ZCFZ_AG1*100}%，占总资产变动的{(ZCFZ_AG1-ZCFZ_AG)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AG1/10000},{ZCFZ_AG/10000},{(ZCFZ_AG1-ZCFZ_AG)/ZCFZ_AG1*100},{(ZCFZ_AG1-ZCFZ_AG)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1976),
(1977,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AH1-ZCFZ_AH>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为开发支出从上年同期的Rmb{ZCFZ_AH1/10000}万元下降至本期的Rmb{ZCFZ_AH/10000}万元，下降率达{(ZCFZ_AH1-ZCFZ_AH)/ZCFZ_AH1*100}%，占总资产变动的{(ZCFZ_AH1-ZCFZ_AH)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AH1/10000},{ZCFZ_AH/10000},{(ZCFZ_AH1-ZCFZ_AH)/ZCFZ_AH1*100},{(ZCFZ_AH1-ZCFZ_AH)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1977),
(1978,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AI1-ZCFZ_AI>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为商誉从上年同期的Rmb{ZCFZ_AI1/10000}万元下降至本期的Rmb{ZCFZ_AI/10000}万元，下降率达{(ZCFZ_AI1-ZCFZ_AI)/ZCFZ_AI1*100}%，占总资产变动的{(ZCFZ_AI1-ZCFZ_AI)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AI1/10000},{ZCFZ_AI/10000},{(ZCFZ_AI1-ZCFZ_AI)/ZCFZ_AI1*100},{(ZCFZ_AI1-ZCFZ_AI)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1978),
(1979,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AJ1-ZCFZ_AJ>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为长期待摊费用从上年同期的Rmb{ZCFZ_AJ1/10000}万元下降至本期的Rmb{ZCFZ_AJ/10000}万元，下降率达{(ZCFZ_AJ1-ZCFZ_AJ)/ZCFZ_AJ1*100}%，占总资产变动的{(ZCFZ_AJ1-ZCFZ_AJ)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AJ1/10000},{ZCFZ_AJ/10000},{(ZCFZ_AJ1-ZCFZ_AJ)/ZCFZ_AJ1*100},{(ZCFZ_AJ1-ZCFZ_AJ)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1979),
(1980,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AK1-ZCFZ_AK>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AL1-ZCFZ_AL)>0','本期总资产较上年同期有所减少，主要是因为递延所得税资产从上年同期的Rmb{ZCFZ_AK1/10000}万元下降至本期的Rmb{ZCFZ_AK/10000}万元，下降率达{(ZCFZ_AK1-ZCFZ_AK)/ZCFZ_AK1*100}%，占总资产变动的{(ZCFZ_AK1-ZCFZ_AK)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AK1/10000},{ZCFZ_AK/10000},{(ZCFZ_AK1-ZCFZ_AK)/ZCFZ_AK1*100},{(ZCFZ_AK1-ZCFZ_AK)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1980),
(1981,'1','资产负债表首页概况','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AL1-ZCFZ_AL>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AK1-ZCFZ_AK)>0','本期总资产较上年同期有所减少，主要是因为其他非流动资产从上年同期的Rmb{ZCFZ_AL1/10000}万元下降至本期的Rmb{ZCFZ_AL/10000}万元，下降率达{(ZCFZ_AL1-ZCFZ_AL)/ZCFZ_AL1*100}%，占总资产变动的{(ZCFZ_AL1-ZCFZ_AL)/(ZCFZ_AN1-ZCFZ_AN)*100}%。','{ZCFZ_AL1/10000},{ZCFZ_AL/10000},{(ZCFZ_AL1-ZCFZ_AL)/ZCFZ_AL1*100},{(ZCFZ_AL1-ZCFZ_AL)/(ZCFZ_AN1-ZCFZ_AN)*100}',NULL,'G1001',NULL,1981),
(1982,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AO-ZCFZ_AO1>0&& ZCFZ_AO1!=0&&(ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元增至本期的Rmb{ZCFZ_AO/10000}万元，增长率达{(ZCFZ_AO-ZCFZ_AO1)/ZCFZ_AO1*100}%，占总负债变动的{(ZCFZ_AO-ZCFZ_AO1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AO1/10000},{ZCFZ_AO/10000},{(ZCFZ_AO-ZCFZ_AO1)/ZCFZ_AO1*100},{(ZCFZ_AO-ZCFZ_AO1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1982),
(1983,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AS-ZCFZ_AS1>0&& ZCFZ_AS1!=0&&(ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元增至本期的Rmb{ZCFZ_AS/10000}万元，增长率达{(ZCFZ_AS-ZCFZ_AS1)/ZCFZ_AS1*100}%，占总负债变动的{(ZCFZ_AS-ZCFZ_AS1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AS1/10000},{ZCFZ_AS/10000},{(ZCFZ_AS-ZCFZ_AS1)/ZCFZ_AS1*100},{(ZCFZ_AS-ZCFZ_AS1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1983),
(1984,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AT-ZCFZ_AT1>0&& ZCFZ_AT1!=0&&(ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元增至本期的Rmb{ZCFZ_AT/10000}万元，增长率达{(ZCFZ_AT-ZCFZ_AT1)/ZCFZ_AT1*100}%，占总负债变动的{(ZCFZ_AT-ZCFZ_AT1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AT1/10000},{ZCFZ_AT/10000},{(ZCFZ_AT-ZCFZ_AT1)/ZCFZ_AT1*100},{(ZCFZ_AT-ZCFZ_AT1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1984),
(1985,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AU-ZCFZ_AU1>0&& ZCFZ_AU1!=0&&(ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元增至本期的Rmb{ZCFZ_AU/10000}万元，增长率达{(ZCFZ_AU-ZCFZ_AU1)/ZCFZ_AU1*100}%，占总负债变动的{(ZCFZ_AU-ZCFZ_AU1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AU1/10000},{ZCFZ_AU/10000},{(ZCFZ_AU-ZCFZ_AU1)/ZCFZ_AU1*100},{(ZCFZ_AU-ZCFZ_AU1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1985),
(1986,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&& ZCFZ_AV1!=0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元增至本期的Rmb{ZCFZ_AV/10000}万元，增长率达{(ZCFZ_AV-ZCFZ_AV1)/ZCFZ_AV1*100}%，占总负债变动的{(ZCFZ_AV-ZCFZ_AV1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AV1/10000},{ZCFZ_AV/10000},{(ZCFZ_AV-ZCFZ_AV1)/ZCFZ_AV1*100},{(ZCFZ_AV-ZCFZ_AV1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1986),
(1987,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AW-ZCFZ_AW1>0&& ZCFZ_AW1!=0&&(ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元增至本期的Rmb{ZCFZ_AW/10000}万元，增长率达{(ZCFZ_AW-ZCFZ_AW1)/ZCFZ_AW1*100}%，占总负债变动的{(ZCFZ_AW-ZCFZ_AW1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AW1/10000},{ZCFZ_AW/10000},{(ZCFZ_AW-ZCFZ_AW1)/ZCFZ_AW1*100},{(ZCFZ_AW-ZCFZ_AW1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1987),
(1988,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AZ-ZCFZ_AZ1>0&& ZCFZ_AZ1!=0&&(ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元增至本期的Rmb{ZCFZ_AZ/10000}万元，增长率达{(ZCFZ_AZ-ZCFZ_AZ1)/ZCFZ_AZ1*100}%，占总负债变动的{(ZCFZ_AZ-ZCFZ_AZ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000},{(ZCFZ_AZ-ZCFZ_AZ1)/ZCFZ_AZ1*100},{(ZCFZ_AZ-ZCFZ_AZ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1988),
(1989,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BA-ZCFZ_BA1>0&& ZCFZ_BA1!=0&&(ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元增至本期的Rmb{ZCFZ_BA/10000}万元，增长率达{(ZCFZ_BA-ZCFZ_BA1)/ZCFZ_BA1*100}%，占总负债变动的{(ZCFZ_BA-ZCFZ_BA1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BA1/10000},{ZCFZ_BA/10000},{(ZCFZ_BA-ZCFZ_BA1)/ZCFZ_BA1*100},{(ZCFZ_BA-ZCFZ_BA1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1989),
(1990,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BB-ZCFZ_BB1>0&& ZCFZ_BB1!=0&&(ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元增至本期的Rmb{ZCFZ_BB/10000}万元，增长率达{(ZCFZ_BB-ZCFZ_BB1)/ZCFZ_BB1*100}%，占总负债变动的{(ZCFZ_BB-ZCFZ_BB1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BB1/10000},{ZCFZ_BB/10000},{(ZCFZ_BB-ZCFZ_BB1)/ZCFZ_BB1*100},{(ZCFZ_BB-ZCFZ_BB1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1990),
(1991,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BC-ZCFZ_BC1>0&& ZCFZ_BC1!=0&&(ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元增至本期的Rmb{ZCFZ_BC/10000}万元，增长率达{(ZCFZ_BC-ZCFZ_BC1)/ZCFZ_BC1*100}%，占总负债变动的{(ZCFZ_BC-ZCFZ_BC1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BC1/10000},{ZCFZ_BC/10000},{(ZCFZ_BC-ZCFZ_BC1)/ZCFZ_BC1*100},{(ZCFZ_BC-ZCFZ_BC1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1991),
(1992,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BD-ZCFZ_BD1>0&& ZCFZ_BD1!=0&&(ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元增至本期的Rmb{ZCFZ_BD/10000}万元，增长率达{(ZCFZ_BD-ZCFZ_BD1)/ZCFZ_BD1*100}%，占总负债变动的{(ZCFZ_BD-ZCFZ_BD1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BD1/10000},{ZCFZ_BD/10000},{(ZCFZ_BD-ZCFZ_BD1)/ZCFZ_BD1*100},{(ZCFZ_BD-ZCFZ_BD1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1992),
(1993,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BI-ZCFZ_BI1>0&& ZCFZ_BI1!=0&&(ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元增至本期的Rmb{ZCFZ_BI/10000}万元，增长率达{(ZCFZ_BI-ZCFZ_BI1)/ZCFZ_BI1*100}%，占总负债变动的{(ZCFZ_BI-ZCFZ_BI1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BI1/10000},{ZCFZ_BI/10000},{(ZCFZ_BI-ZCFZ_BI1)/ZCFZ_BI1*100},{(ZCFZ_BI-ZCFZ_BI1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1993),
(1994,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BJ-ZCFZ_BJ1>0&& ZCFZ_BJ1!=0&&(ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元增至本期的Rmb{ZCFZ_BJ/10000}万元，增长率达{(ZCFZ_BJ-ZCFZ_BJ1)/ZCFZ_BJ1*100}%，占总负债变动的{(ZCFZ_BJ-ZCFZ_BJ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000},{(ZCFZ_BJ-ZCFZ_BJ1)/ZCFZ_BJ1*100},{(ZCFZ_BJ-ZCFZ_BJ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1994),
(1995,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BK-ZCFZ_BK1>0&& ZCFZ_BK1!=0&&(ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元增至本期的Rmb{ZCFZ_BK/10000}万元，增长率达{(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1*100}%，占总负债变动的{(ZCFZ_BK-ZCFZ_BK1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BK1/10000},{ZCFZ_BK/10000},{(ZCFZ_BK-ZCFZ_BK1)/ZCFZ_BK1*100},{(ZCFZ_BK-ZCFZ_BK1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1995),
(1996,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BM-ZCFZ_BM1>0&& ZCFZ_BM1!=0&&(ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元增至本期的Rmb{ZCFZ_BM/10000}万元，增长率达{(ZCFZ_BM-ZCFZ_BM1)/ZCFZ_BM1*100}%，占总负债变动的{(ZCFZ_BM-ZCFZ_BM1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BM1/10000},{ZCFZ_BM/10000},{(ZCFZ_BM-ZCFZ_BM1)/ZCFZ_BM1*100},{(ZCFZ_BM-ZCFZ_BM1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1996),
(1997,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BN-ZCFZ_BN1>0&& ZCFZ_BN1!=0&&(ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元增至本期的Rmb{ZCFZ_BN/10000}万元，增长率达{(ZCFZ_BN-ZCFZ_BN1)/ZCFZ_BN1*100}%，占总负债变动的{(ZCFZ_BN-ZCFZ_BN1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BN1/10000},{ZCFZ_BN/10000},{(ZCFZ_BN-ZCFZ_BN1)/ZCFZ_BN1*100},{(ZCFZ_BN-ZCFZ_BN1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1997),
(1998,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BQ-ZCFZ_BQ1>0&& ZCFZ_BQ1!=0&&(ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元增至本期的Rmb{ZCFZ_BQ/10000}万元，增长率达{(ZCFZ_BQ-ZCFZ_BQ1)/ZCFZ_BQ1*100}%，占总负债变动的{(ZCFZ_BQ-ZCFZ_BQ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000},{(ZCFZ_BQ-ZCFZ_BQ1)/ZCFZ_BQ1*100},{(ZCFZ_BQ-ZCFZ_BQ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1998),
(1999,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BS-ZCFZ_BS1>0&& ZCFZ_BS1!=0&&(ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元增至本期的Rmb{ZCFZ_BS/10000}万元，增长率达{(ZCFZ_BS-ZCFZ_BS1)/ZCFZ_BS1*100}%，占总负债变动的{(ZCFZ_BS-ZCFZ_BS1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BS1/10000},{ZCFZ_BS/10000},{(ZCFZ_BS-ZCFZ_BS1)/ZCFZ_BS1*100},{(ZCFZ_BS-ZCFZ_BS1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,1999),
(2000,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BT-ZCFZ_BT1>0&& ZCFZ_BT1!=0&&(ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元增至本期的Rmb{ZCFZ_BT/10000}万元，增长率达{(ZCFZ_BT-ZCFZ_BT1)/ZCFZ_BT1*100}%，占总负债变动的{(ZCFZ_BT-ZCFZ_BT1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BT1/10000},{ZCFZ_BT/10000},{(ZCFZ_BT-ZCFZ_BT1)/ZCFZ_BT1*100},{(ZCFZ_BT-ZCFZ_BT1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2000),
(2001,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BU-ZCFZ_BU1>0&& ZCFZ_BU1!=0&&(ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元增至本期的Rmb{ZCFZ_BU/10000}万元，增长率达{(ZCFZ_BU-ZCFZ_BU1)/ZCFZ_BU1*100}%，占总负债变动的{(ZCFZ_BU-ZCFZ_BU1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BU1/10000},{ZCFZ_BU/10000},{(ZCFZ_BU-ZCFZ_BU1)/ZCFZ_BU1*100},{(ZCFZ_BU-ZCFZ_BU1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2001),
(2002,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BV-ZCFZ_BV1>0&& ZCFZ_BV1!=0&&(ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元增至本期的Rmb{ZCFZ_BV/10000}万元，增长率达{(ZCFZ_BV-ZCFZ_BV1)/ZCFZ_BV1*100}%，占总负债变动的{(ZCFZ_BV-ZCFZ_BV1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BV1/10000},{ZCFZ_BV/10000},{(ZCFZ_BV-ZCFZ_BV1)/ZCFZ_BV1*100},{(ZCFZ_BV-ZCFZ_BV1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2002),
(2003,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BW-ZCFZ_BW1>0&& ZCFZ_BW1!=0&&(ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BV-ZCFZ_BV1)>0','此外，总负债较上年同期有所增加，主要是因为其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元增至本期的Rmb{ZCFZ_BW/10000}万元，增长率达{(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1*100}%，占总负债变动的{(ZCFZ_BW-ZCFZ_BW1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BW1/10000},{ZCFZ_BW/10000},{(ZCFZ_BW-ZCFZ_BW1)/ZCFZ_BW1*100},{(ZCFZ_BW-ZCFZ_BW1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2003),
(2004,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AO1-ZCFZ_AO>0&& ZCFZ_AO1!=0&&(ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元下降至本期的Rmb{ZCFZ_AO/10000}万元，下降率达{(ZCFZ_AO1-ZCFZ_AO)/ZCFZ_AO1*100}%，占总负债变动的{(ZCFZ_AO1-ZCFZ_AO)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AO1/10000},{ZCFZ_AO/10000},{(ZCFZ_AO1-ZCFZ_AO)/ZCFZ_AO1*100},{(ZCFZ_AO1-ZCFZ_AO)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2004),
(2005,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AS1-ZCFZ_AS>0&& ZCFZ_AS1!=0&&(ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元下降至本期的Rmb{ZCFZ_AS/10000}万元，下降率达{(ZCFZ_AS1-ZCFZ_AS)/ZCFZ_AS1*100}%，占总负债变动的{(ZCFZ_AS1-ZCFZ_AS)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AS1/10000},{ZCFZ_AS/10000},{(ZCFZ_AS1-ZCFZ_AS)/ZCFZ_AS1*100},{(ZCFZ_AS1-ZCFZ_AS)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2005),
(2006,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AT1-ZCFZ_AT>0&& ZCFZ_AT1!=0&&(ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元下降至本期的Rmb{ZCFZ_AT/10000}万元，下降率达{(ZCFZ_AT1-ZCFZ_AT)/ZCFZ_AT1*100}%，占总负债变动的{(ZCFZ_AT1-ZCFZ_AT)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AT1/10000},{ZCFZ_AT/10000},{(ZCFZ_AT1-ZCFZ_AT)/ZCFZ_AT1*100},{(ZCFZ_AT1-ZCFZ_AT)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2006),
(2007,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AU1-ZCFZ_AU>0&& ZCFZ_AU1!=0&&(ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元下降至本期的Rmb{ZCFZ_AU/10000}万元，下降率达{(ZCFZ_AU1-ZCFZ_AU)/ZCFZ_AU1*100}%，占总负债变动的{(ZCFZ_AU1-ZCFZ_AU)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AU1/10000},{ZCFZ_AU/10000},{(ZCFZ_AU1-ZCFZ_AU)/ZCFZ_AU1*100},{(ZCFZ_AU1-ZCFZ_AU)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2007),
(2008,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AV1-ZCFZ_AV>0&& ZCFZ_AV1!=0&&(ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元下降至本期的Rmb{ZCFZ_AV/10000}万元，下降率达{(ZCFZ_AV1-ZCFZ_AV)/ZCFZ_AV1*100}%，占总负债变动的{(ZCFZ_AV1-ZCFZ_AV)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AV1/10000},{ZCFZ_AV/10000},{(ZCFZ_AV1-ZCFZ_AV)/ZCFZ_AV1*100},{(ZCFZ_AV1-ZCFZ_AV)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2008),
(2009,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AW1-ZCFZ_AW>0&& ZCFZ_AW1!=0&&(ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元下降至本期的Rmb{ZCFZ_AW/10000}万元，下降率达{(ZCFZ_AW1-ZCFZ_AW)/ZCFZ_AW1*100}%，占总负债变动的{(ZCFZ_AW1-ZCFZ_AW)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AW1/10000},{ZCFZ_AW/10000},{(ZCFZ_AW1-ZCFZ_AW)/ZCFZ_AW1*100},{(ZCFZ_AW1-ZCFZ_AW)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2009),
(2010,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AZ1-ZCFZ_AZ>0&& ZCFZ_AZ1!=0&&(ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元下降至本期的Rmb{ZCFZ_AZ/10000}万元，下降率达{(ZCFZ_AZ1-ZCFZ_AZ)/ZCFZ_AZ1*100}%，占总负债变动的{(ZCFZ_AZ1-ZCFZ_AZ)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000},{(ZCFZ_AZ1-ZCFZ_AZ)/ZCFZ_AZ1*100},{(ZCFZ_AZ1-ZCFZ_AZ)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2010),
(2011,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BA1-ZCFZ_BA>0&& ZCFZ_BA1!=0&&(ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元下降至本期的Rmb{ZCFZ_BA/10000}万元，下降率达{(ZCFZ_BA1-ZCFZ_BA)/ZCFZ_BA1*100}%，占总负债变动的{(ZCFZ_BA1-ZCFZ_BA)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BA1/10000},{ZCFZ_BA/10000},{(ZCFZ_BA1-ZCFZ_BA)/ZCFZ_BA1*100},{(ZCFZ_BA1-ZCFZ_BA)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2011),
(2012,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BB1-ZCFZ_BB>0&& ZCFZ_BB1!=0&&(ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元下降至本期的Rmb{ZCFZ_BB/10000}万元，下降率达{(ZCFZ_BB1-ZCFZ_BB)/ZCFZ_BB1*100}%，占总负债变动的{(ZCFZ_BB1-ZCFZ_BB)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BB1/10000},{ZCFZ_BB/10000},{(ZCFZ_BB1-ZCFZ_BB)/ZCFZ_BB1*100},{(ZCFZ_BB1-ZCFZ_BB)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2012),
(2013,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BC1-ZCFZ_BC>0&& ZCFZ_BC1!=0&&(ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元下降至本期的Rmb{ZCFZ_BC/10000}万元，下降率达{(ZCFZ_BC1-ZCFZ_BC)/ZCFZ_BC1*100}%，占总负债变动的{(ZCFZ_BC1-ZCFZ_BC)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BC1/10000},{ZCFZ_BC/10000},{(ZCFZ_BC1-ZCFZ_BC)/ZCFZ_BC1*100},{(ZCFZ_BC1-ZCFZ_BC)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2013),
(2014,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BD1-ZCFZ_BD>0&& ZCFZ_BD1!=0&&(ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元下降至本期的Rmb{ZCFZ_BD/10000}万元，下降率达{(ZCFZ_BD1-ZCFZ_BD)/ZCFZ_BD1*100}%，占总负债变动的{(ZCFZ_BD1-ZCFZ_BD)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BD1/10000},{ZCFZ_BD/10000},{(ZCFZ_BD1-ZCFZ_BD)/ZCFZ_BD1*100},{(ZCFZ_BD1-ZCFZ_BD)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2014),
(2015,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BI1-ZCFZ_BI>0&& ZCFZ_BI1!=0&&(ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元下降至本期的Rmb{ZCFZ_BI/10000}万元，下降率达{(ZCFZ_BI1-ZCFZ_BI)/ZCFZ_BI1*100}%，占总负债变动的{(ZCFZ_BI1-ZCFZ_BI)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BI1/10000},{ZCFZ_BI/10000},{(ZCFZ_BI1-ZCFZ_BI)/ZCFZ_BI1*100},{(ZCFZ_BI1-ZCFZ_BI)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2015),
(2016,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BJ1-ZCFZ_BJ>0&& ZCFZ_BJ1!=0&&(ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元下降至本期的Rmb{ZCFZ_BJ/10000}万元，下降率达{(ZCFZ_BJ1-ZCFZ_BJ)/ZCFZ_BJ1*100}%，占总负债变动的{(ZCFZ_BJ1-ZCFZ_BJ)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000},{(ZCFZ_BJ1-ZCFZ_BJ)/ZCFZ_BJ1*100},{(ZCFZ_BJ1-ZCFZ_BJ)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2016),
(2017,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BK1-ZCFZ_BK>0&& ZCFZ_BK1!=0&&(ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元下降至本期的Rmb{ZCFZ_BK/10000}万元，下降率达{(ZCFZ_BK1-ZCFZ_BK)/ZCFZ_BK1*100}%，占总负债变动的{(ZCFZ_BK1-ZCFZ_BK)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BK1/10000},{ZCFZ_BK/10000},{(ZCFZ_BK1-ZCFZ_BK)/ZCFZ_BK1*100},{(ZCFZ_BK1-ZCFZ_BK)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2017),
(2018,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BM1-ZCFZ_BM>0&& ZCFZ_BM1!=0&&(ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元下降至本期的Rmb{ZCFZ_BM/10000}万元，下降率达{(ZCFZ_BM1-ZCFZ_BM)/ZCFZ_BM1*100}%，占总负债变动的{(ZCFZ_BM1-ZCFZ_BM)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BM1/10000},{ZCFZ_BM/10000},{(ZCFZ_BM1-ZCFZ_BM)/ZCFZ_BM1*100},{(ZCFZ_BM1-ZCFZ_BM)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2018),
(2019,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BN1-ZCFZ_BN>0&& ZCFZ_BN1!=0&&(ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元下降至本期的Rmb{ZCFZ_BN/10000}万元，下降率达{(ZCFZ_BN1-ZCFZ_BN)/ZCFZ_BN1*100}%，占总负债变动的{(ZCFZ_BN1-ZCFZ_BN)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BN1/10000},{ZCFZ_BN/10000},{(ZCFZ_BN1-ZCFZ_BN)/ZCFZ_BN1*100},{(ZCFZ_BN1-ZCFZ_BN)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2019),
(2020,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BQ1-ZCFZ_BQ>0&& ZCFZ_BQ1!=0&&(ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元下降至本期的Rmb{ZCFZ_BQ/10000}万元，下降率达{(ZCFZ_BQ1-ZCFZ_BQ)/ZCFZ_BQ1*100}%，占总负债变动的{(ZCFZ_BQ1-ZCFZ_BQ)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000},{(ZCFZ_BQ1-ZCFZ_BQ)/ZCFZ_BQ1*100},{(ZCFZ_BQ1-ZCFZ_BQ)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2020),
(2021,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BS1-ZCFZ_BS>0&& ZCFZ_BS1!=0&&(ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元下降至本期的Rmb{ZCFZ_BS/10000}万元，下降率达{(ZCFZ_BS1-ZCFZ_BS)/ZCFZ_BS1*100}%，占总负债变动的{(ZCFZ_BS1-ZCFZ_BS)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BS1/10000},{ZCFZ_BS/10000},{(ZCFZ_BS1-ZCFZ_BS)/ZCFZ_BS1*100},{(ZCFZ_BS1-ZCFZ_BS)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2021),
(2022,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BT1-ZCFZ_BT>0&& ZCFZ_BT1!=0&&(ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元下降至本期的Rmb{ZCFZ_BT/10000}万元，下降率达{(ZCFZ_BT1-ZCFZ_BT)/ZCFZ_BT1*100}%，占总负债变动的{(ZCFZ_BT1-ZCFZ_BT)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BT1/10000},{ZCFZ_BT/10000},{(ZCFZ_BT1-ZCFZ_BT)/ZCFZ_BT1*100},{(ZCFZ_BT1-ZCFZ_BT)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2022),
(2023,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BU1-ZCFZ_BU>0&& ZCFZ_BU1!=0&&(ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元下降至本期的Rmb{ZCFZ_BU/10000}万元，下降率达{(ZCFZ_BU1-ZCFZ_BU)/ZCFZ_BU1*100}%，占总负债变动的{(ZCFZ_BU1-ZCFZ_BU)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BU1/10000},{ZCFZ_BU/10000},{(ZCFZ_BU1-ZCFZ_BU)/ZCFZ_BU1*100},{(ZCFZ_BU1-ZCFZ_BU)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2023),
(2024,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BV1-ZCFZ_BV>0&& ZCFZ_BV1!=0&&(ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BW1-ZCFZ_BW)>0','此外，总负债较上年同期有所减少，主要是因为递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元下降至本期的Rmb{ZCFZ_BV/10000}万元，下降率达{(ZCFZ_BV1-ZCFZ_BV)/ZCFZ_BV1*100}%，占总负债变动的{(ZCFZ_BV1-ZCFZ_BV)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BV1/10000},{ZCFZ_BV/10000},{(ZCFZ_BV1-ZCFZ_BV)/ZCFZ_BV1*100},{(ZCFZ_BV1-ZCFZ_BV)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2024),
(2025,'1','资产负债表首页概述','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BW1-ZCFZ_BW>0&& ZCFZ_BW1!=0&&(ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BV1-ZCFZ_BV)>0','此外，总负债较上年同期有所减少，主要是因为其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元下降至本期的Rmb{ZCFZ_BW/10000}万元，下降率达{(ZCFZ_BW1-ZCFZ_BW)/ZCFZ_BW1*100}%，占总负债变动的{(ZCFZ_BW1-ZCFZ_BW)/(ZCFZ_BY1-ZCFZ_BY)*100}%。','{ZCFZ_BW1/10000},{ZCFZ_BW/10000},{(ZCFZ_BW1-ZCFZ_BW)/ZCFZ_BW1*100},{(ZCFZ_BW1-ZCFZ_BW)/(ZCFZ_BY1-ZCFZ_BY)*100}',NULL,'G1001',NULL,2025),
(2026,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AO-ZCFZ_AO1>0&& ZCFZ_AO1==0&&(ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为短期借款从上年同期的Rmb{ZCFZ_AO1/10000}万元增至本期的Rmb{ZCFZ_AO/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AO-ZCFZ_AO1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AO1/10000},{ZCFZ_AO/10000},{(ZCFZ_AO-ZCFZ_AO1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2026),
(2027,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AS-ZCFZ_AS1>0&& ZCFZ_AS1==0&&(ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为以公允价值计量且其变动计入当期损益的金融负债从上年同期的Rmb{ZCFZ_AS1/10000}万元增至本期的Rmb{ZCFZ_AS/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AS-ZCFZ_AS1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AS1/10000},{ZCFZ_AS/10000},{(ZCFZ_AS-ZCFZ_AS1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2027),
(2028,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AT-ZCFZ_AT1>0&& ZCFZ_AT1==0&&(ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为衍生金融负债从上年同期的Rmb{ZCFZ_AT1/10000}万元增至本期的Rmb{ZCFZ_AT/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AT-ZCFZ_AT1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AT1/10000},{ZCFZ_AT/10000},{(ZCFZ_AT-ZCFZ_AT1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2028),
(2029,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AU-ZCFZ_AU1>0&& ZCFZ_AU1==0&&(ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付票据从上年同期的Rmb{ZCFZ_AU1/10000}万元增至本期的Rmb{ZCFZ_AU/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AU-ZCFZ_AU1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AU1/10000},{ZCFZ_AU/10000},{(ZCFZ_AU-ZCFZ_AU1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2029),
(2030,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&& ZCFZ_AV1==0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付账款从上年同期的Rmb{ZCFZ_AV1/10000}万元增至本期的Rmb{ZCFZ_AV/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AV-ZCFZ_AV1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AV1/10000},{ZCFZ_AV/10000},{(ZCFZ_AV-ZCFZ_AV1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2030),
(2031,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AW-ZCFZ_AW1>0&& ZCFZ_AW1==0&&(ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为预收款项从上年同期的Rmb{ZCFZ_AW1/10000}万元增至本期的Rmb{ZCFZ_AW/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AW-ZCFZ_AW1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AW1/10000},{ZCFZ_AW/10000},{(ZCFZ_AW-ZCFZ_AW1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2031),
(2032,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AZ-ZCFZ_AZ1>0&& ZCFZ_AZ1==0&&(ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付职工薪酬从上年同期的Rmb{ZCFZ_AZ1/10000}万元增至本期的Rmb{ZCFZ_AZ/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_AZ-ZCFZ_AZ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_AZ1/10000},{ZCFZ_AZ/10000},{(ZCFZ_AZ-ZCFZ_AZ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2032),
(2033,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BA-ZCFZ_BA1>0&& ZCFZ_BA1==0&&(ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应交税费从上年同期的Rmb{ZCFZ_BA1/10000}万元增至本期的Rmb{ZCFZ_BA/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BA-ZCFZ_BA1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BA1/10000},{ZCFZ_BA/10000},{(ZCFZ_BA-ZCFZ_BA1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2033),
(2034,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BB-ZCFZ_BB1>0&& ZCFZ_BB1==0&&(ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付利息从上年同期的Rmb{ZCFZ_BB1/10000}万元增至本期的Rmb{ZCFZ_BB/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BB-ZCFZ_BB1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BB1/10000},{ZCFZ_BB/10000},{(ZCFZ_BB-ZCFZ_BB1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2034),
(2035,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BC-ZCFZ_BC1>0&& ZCFZ_BC1==0&&(ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付股利从上年同期的Rmb{ZCFZ_BC1/10000}万元增至本期的Rmb{ZCFZ_BC/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BC-ZCFZ_BC1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BC1/10000},{ZCFZ_BC/10000},{(ZCFZ_BC-ZCFZ_BC1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2035),
(2036,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BD-ZCFZ_BD1>0&& ZCFZ_BD1==0&&(ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为其他应付款从上年同期的Rmb{ZCFZ_BD1/10000}万元增至本期的Rmb{ZCFZ_BD/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BD-ZCFZ_BD1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BD1/10000},{ZCFZ_BD/10000},{(ZCFZ_BD-ZCFZ_BD1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2036),
(2037,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BI-ZCFZ_BI1>0&& ZCFZ_BI1==0&&(ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为持有待售的负债从上年同期的Rmb{ZCFZ_BI1/10000}万元增至本期的Rmb{ZCFZ_BI/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BI-ZCFZ_BI1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BI1/10000},{ZCFZ_BI/10000},{(ZCFZ_BI-ZCFZ_BI1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2037),
(2038,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BJ-ZCFZ_BJ1>0&& ZCFZ_BJ1==0&&(ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为一年内到期的非流动负债从上年同期的Rmb{ZCFZ_BJ1/10000}万元增至本期的Rmb{ZCFZ_BJ/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BJ-ZCFZ_BJ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BJ1/10000},{ZCFZ_BJ/10000},{(ZCFZ_BJ-ZCFZ_BJ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2038),
(2039,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BK-ZCFZ_BK1>0&& ZCFZ_BK1==0&&(ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为其他流动负债从上年同期的Rmb{ZCFZ_BK1/10000}万元增至本期的Rmb{ZCFZ_BK/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BK-ZCFZ_BK1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BK1/10000},{ZCFZ_BK/10000},{(ZCFZ_BK-ZCFZ_BK1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2039),
(2040,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BM-ZCFZ_BM1>0&& ZCFZ_BM1==0&&(ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为长期借款从上年同期的Rmb{ZCFZ_BM1/10000}万元增至本期的Rmb{ZCFZ_BM/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BM-ZCFZ_BM1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BM1/10000},{ZCFZ_BM/10000},{(ZCFZ_BM-ZCFZ_BM1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2040),
(2041,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BN-ZCFZ_BN1>0&& ZCFZ_BN1==0&&(ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为应付债券从上年同期的Rmb{ZCFZ_BN1/10000}万元增至本期的Rmb{ZCFZ_BN/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BN-ZCFZ_BN1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BN1/10000},{ZCFZ_BN/10000},{(ZCFZ_BN-ZCFZ_BN1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2041),
(2042,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BQ-ZCFZ_BQ1>0&& ZCFZ_BQ1==0&&(ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为长期应付款从上年同期的Rmb{ZCFZ_BQ1/10000}万元增至本期的Rmb{ZCFZ_BQ/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BQ-ZCFZ_BQ1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BQ1/10000},{ZCFZ_BQ/10000},{(ZCFZ_BQ-ZCFZ_BQ1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2042),
(2043,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BS-ZCFZ_BS1>0&& ZCFZ_BS1==0&&(ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为专项应付款从上年同期的Rmb{ZCFZ_BS1/10000}万元增至本期的Rmb{ZCFZ_BS/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BS-ZCFZ_BS1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BS1/10000},{ZCFZ_BS/10000},{(ZCFZ_BS-ZCFZ_BS1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2043),
(2044,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BT-ZCFZ_BT1>0&& ZCFZ_BT1==0&&(ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为预计负债从上年同期的Rmb{ZCFZ_BT1/10000}万元增至本期的Rmb{ZCFZ_BT/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BT-ZCFZ_BT1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BT1/10000},{ZCFZ_BT/10000},{(ZCFZ_BT-ZCFZ_BT1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2044),
(2045,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BU-ZCFZ_BU1>0&& CFZ_BU1==0&&(ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为递延收益从上年同期的Rmb{ZCFZ_BU1/10000}万元增至本期的Rmb{ZCFZ_BU/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BU-ZCFZ_BU1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BU1/10000},{ZCFZ_BU/10000},{(ZCFZ_BU-ZCFZ_BU1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2045),
(2046,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BV-ZCFZ_BV1>0&& ZCFZ_BV1==0&&(ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BW-ZCFZ_BW1)>0','此外，总负债较上年同期有所增加，主要是因为递延所得税负债从上年同期的Rmb{ZCFZ_BV1/10000}万元增至本期的Rmb{ZCFZ_BV/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BV-ZCFZ_BV1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BV1/10000},{ZCFZ_BV/10000},{(ZCFZ_BV-ZCFZ_BV1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2046),
(2047,'1','资产负债表首页概述','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BW-ZCFZ_BW1>0&& ZCFZ_BW1==0&&(ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BV-ZCFZ_BV1)>0','此外，总负债较上年同期有所增加，主要是因为其他非流动负债从上年同期的Rmb{ZCFZ_BW1/10000}万元增至本期的Rmb{ZCFZ_BW/10000}万元，增长率达-%，占总负债变动的{(ZCFZ_BW-ZCFZ_BW1)/(ZCFZ_BY-ZCFZ_BY1)*100}%。','{ZCFZ_BW1/10000},{ZCFZ_BW/10000},{(ZCFZ_BW-ZCFZ_BW1)/(ZCFZ_BY-ZCFZ_BY1)*100}',NULL,'G1001',NULL,2047),
(2260,'2','税金及附加预警','LR_O1==0&&LR_O-LR_O1>0','税金及附加从上期的Rmb0.00万元增长至本期的Rmb{LR_O/10000}万元。税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入的比率变动关系，同时关注税收政策变化、进一步核查本期可抵扣税额，查看是否存在税率调增、不再享有免税政策以及大量发票不可抵扣的情况，从而规范发票管理及排查税务风险。','{LR_O/10000}',NULL,'20014',NULL,2260),
(2261,'2','财务费用预警','LR_R1==0&&LR_R-LR_R1>0','财务费用从上期的Rmb0.00万元增长至本期的Rmb{LR_R/10000}万元，财务费用大幅度增加，成为净利润减少的主因。财务费用的大幅度增加，主要是因为本期贷款金额的增加。建议管理层结合资金情况，贷款情况，做好资金用途的管理，同时评估未来还款付息对资金流产生的压力，评估资金状况是否足以承受未来的还本付息所需的现金流。','{LR_R/10000}',NULL,'20010',NULL,2261),
(2262,'2','资产减值损失预警','LR_S1==0&&LR_S-LR_S1>0','资产减值损失从上期的Rmb0.00万元增长至本期的Rmb{LR_S/10000}万元，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施减少损失，同时，特别警惕因技术变革、行业创新导致公司资产大幅度减值的情况。','{LR_S/10000}',NULL,'20015',NULL,2262),
(2263,'2','公允价值变动收益预警','LR_T1==0&&LR_T-LR_T1>0','公允价值变动收益从上期的Rmb0.00万元增长至本期的Rmb{LR_T/10000}万元。由于公允价值变动为非经常性收益，剔除后，营业利润将下降。建议管理层考虑公允价值变动的性质，具体分析其增加原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{LR_T/10000}',NULL,'20016',NULL,2263),
(2264,'2','投资收益预警','LR_U1==0&&LR_U-LR_U1>0','投资收益从上期的Rmb0.00万元增长至本期的Rmb{LR_U/10000}万元，本期投资收益大幅度增加。由于投资收益为非经常性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，具体分析其增加原因，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{LR_U/10000}','','20011','',2264),
(2265,'2','其他收益预警','LR_X1==0&&LR_X-LR_X1>0','其他收益从上期的Rmb0.00万元增长至本期的Rmb{LR_X/10000}万元，本期其他收益大幅度增加。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其增加原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{LR_X/10000}',NULL,'50010',NULL,2265),
(2266,'2','营业外收入预警','LR_Z1==0&&LR_Z-LR_Z1>0','营业外收入从上期的Rmb0.00万元增长至本期的Rmb{LR_Z/10000}万元，由于营业外收入为非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，并剔除历史数据中营业外收入对净利润的影响后，再分析净利润的变动原因。','{LR_Z/10000}',NULL,'20012',NULL,2266),
(2267,'2','营业外支出预警','LR_AB1==0&&LR_AB-LR_AB1>0','营业外支出从上期的Rmb0.00万元增长至本期的Rmb{LR_AB/10000}万元，营业外支出大幅增加，建议管理层关注是否发生了大额的资产处置损失，资产处置是否履行了审批制度并关注大额资产处置的原因。另外，营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','{LR_AB/10000}',NULL,'20013',NULL,2267),
(2268,'2','财务费用预警','LR_R1==0&&LR_R==LR_R1','本期与上期一致，财务费用为0，此情况较为异常。且若企业货币资金非0，财务费用不应为0，建议管理层查看详细账务记录，进行相应调整。此外，可考虑适当进行长期或短期贷款筹借，减少企业现金流负担，但需考虑未来还本付息对现金流可能产生的影响。','','','20010','',2268),
(2391,'1','应收账款预警','ZCFZ_G-ZCFZ_G1>0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2391),
(2392,'1','应收账款预警','ZCFZ_G-ZCFZ_G1>0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。','',NULL,'11002',NULL,2392),
(2393,'1','应收账款预警','ZCFZ_G-ZCFZ_G1>0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2393),
(2394,'1','应收账款预警','ZCFZ_G-ZCFZ_G1>0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。','',NULL,'11002',NULL,2394),
(2395,'1','应收账款预警','ZCFZ_G-ZCFZ_G1<0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，可能产生的坏账损失可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2395),
(2396,'1','应收账款预警','ZCFZ_G-ZCFZ_G1<0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，可能产生的坏账损失可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。','',NULL,'11002',NULL,2396),
(2397,'1','应收账款预警','ZCFZ_G-ZCFZ_G1<0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2397),
(2398,'1','应收账款预警','ZCFZ_G-ZCFZ_G1<0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。','',NULL,'11002',NULL,2398),
(2399,'1','应收账款预警','ZCFZ_G-ZCFZ_G1==0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末与上年同期持平，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2399),
(2400,'1','应收账款预警','ZCFZ_G-ZCFZ_G1==0&&YBLFX_L>90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末与上年同期持平，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。','',NULL,'11002',NULL,2400),
(2401,'1','应收账款预警','ZCFZ_G-ZCFZ_G1==0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','应收账款期末与上年同期持平，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'11002',NULL,2401),
(2402,'1','应收账款预警','ZCFZ_G-ZCFZ_G1==0&&YBLFX_L<=90&&YSZKZL_D+YSZKZL_E+YSZKZL_F==0','应收账款期末与上年同期持平，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。','',NULL,'11002',NULL,2402),
(2403,'1','预付款项预警','ZCFZ_H-ZCFZ_H1>0&&YFKXZL_D+YFKXZL_E+YFKXZL_F>0','预付款项在期末较上年同期有所增加，建议管理层查看增加情况，考虑是否属于年底正常业务增长需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。本期账龄超过360日的预付款项金额为Rmb{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}万元，建议管理层查看预付账款的账龄分析，对账龄超过1年的预付账款确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}',NULL,'11003',NULL,2403),
(2404,'1','预付款项预警','ZCFZ_H-ZCFZ_H1>0&&YFKXZL_D+YFKXZL_E+YFKXZL_F==0','预付款项在期末较上年同期有所增加，建议管理层查看增加情况，考虑是否属于年底正常业务增长需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。','',NULL,'11003',NULL,2404),
(2405,'1','预付款项预警','ZCFZ_H-ZCFZ_H1<0&&YFKXZL_D+YFKXZL_E+YFKXZL_F>0','预付款项在期末较上年同期有所减少，建议管理层查看减少情况，考虑是否属于年底正常业务减少需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付形式。本期账龄超过360日的预付款项金额为Rmb{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}万元，建议管理层查看预付账款的账龄分析，对账龄超过1年的预付账款确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}',NULL,'11003',NULL,2405),
(2406,'1','预付款项预警','ZCFZ_H-ZCFZ_H1<0&&YFKXZL_D+YFKXZL_E+YFKXZL_F==0','预付款项在期末较上年同期有所减少，建议管理层查看减少情况，考虑是否属于年底正常业务减少需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付形式。','',NULL,'11003',NULL,2406),
(2407,'1','预付款项预警','ZCFZ_H-ZCFZ_H1==0&&YFKXZL_D+YFKXZL_E+YFKXZL_F>0','预付款项在期末与上年同期持平，建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。本期账龄超过360日的预付款项金额为Rmb{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}万元，建议管理层查看预付账款的账龄分析，对账龄超过1年的预付账款确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}',NULL,'11003',NULL,2407),
(2408,'1','预付款项预警','ZCFZ_H-ZCFZ_H1==0&&YFKXZL_D+YFKXZL_E+YFKXZL_F==0','预付款项在期末与上年同期持平，建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。','',NULL,'11003',NULL,2408),
(2409,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F>0','其他应收款在期末较上年同期有所增加，此现象较为异常，考虑是否因股东间拆借或他方违约引起。建议管理层查看其他应收款明细及相应信息。其他应收款期末的异常变动为年度审计、IPO审计、银行贷款的重点关注情况，建议管理层高度重视。其他应收款中有Rmb{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}万元账龄已超360日，对账龄超过1年的其他应收款需引起管理层的重视，建议管理层查看该部分较长账龄的其他应收款是否属于关联交易，并确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}',NULL,'11004',NULL,2409),
(2410,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F==0','其他应收款在期末较上年同期有所增加，此现象较为异常，考虑是否因股东间拆借或他方违约引起。建议管理层查看其他应收款明细及相应信息。其他应收款期末的异常变动为年度审计、IPO审计、银行贷款的重点关注情况，建议管理层高度重视。','',NULL,'11004',NULL,2410),
(2411,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1<0&&QTYSZL_D+QTYSZL_E+QTYSZL_F>0','其他应收款在期末较上年同期有所减少，考虑是否因为资金回收、坏账处置引起。若因处置引起，则建议管理层重点关注处置的原因、必要性及结果，是否损害公司利益。同时，需关注剩余的其他应收款是否属于关联交易，若是，需考虑企业短期内是否有IPO计划，如有，则可能对企业的IPO造成不利影响。其他应收款中有Rmb{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}万元账龄已超360日，对账龄超过1年的其他应收款需引起管理层的重视，建议管理层查看该部分较长账龄的其他应收款是否属于关联交易，并确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}',NULL,'11004',NULL,2411),
(2412,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1<0&&QTYSZL_D+QTYSZL_E+QTYSZL_F==0','其他应收款在期末较上年同期有所减少，考虑是否因为资金回收、坏账处置引起。若因处置引起，则建议管理层重点关注处置的原因、必要性及结果，是否损害公司利益。同时，需关注剩余的其他应收款是否属于关联交易，若是，需考虑企业短期内是否有IPO计划，如有，则可能对企业的IPO造成不利影响。','',NULL,'11004',NULL,2412),
(2413,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1==0&&QTYSZL_D+QTYSZL_E+QTYSZL_F>0','其他应收款在期末与上年同期持平，建议管理层查看其他应收款明细及相应信息。其他应收款为年度审计、IPO审计、银行贷款的重点关注科目，建议管理层高度重视。其他应收款中有Rmb{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}万元账龄已超360日，对账龄超过1年的其他应收款需引起管理层的重视，建议管理层查看该部分较长账龄的其他应收款是否属于关联交易，并确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}',NULL,'11004',NULL,2413),
(2414,'1','其他应收款预警','ZCFZ_N-ZCFZ_N1==0&&QTYSZL_D+QTYSZL_E+QTYSZL_F==0','其他应收款在期末与上年同期持平，建议管理层查看其他应收款明细及相应信息。其他应收款为年度审计、IPO审计、银行贷款的重点关注科目，建议管理层高度重视。','',NULL,'11004',NULL,2414),
(2415,'1','存货预警','ZCFZ_P-ZCFZ_P1>0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F>0','本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。库龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2415),
(2416,'1','存货预警','ZCFZ_P-ZCFZ_P1>0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F==0','本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。','',NULL,'11005',NULL,2416),
(2417,'1','存货预警','ZCFZ_P-ZCFZ_P1>0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F>0','本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。库龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2417),
(2418,'1','存货预警','ZCFZ_P-ZCFZ_P1>0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F==0','本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。','',NULL,'11005',NULL,2418),
(2419,'1','存货预警','ZCFZ_P-ZCFZ_P1<0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F>0','存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2419),
(2420,'1','存货预警','ZCFZ_P-ZCFZ_P1<0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F==0','存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。','',NULL,'11005',NULL,2420),
(2421,'1','存货预警','ZCFZ_P-ZCFZ_P1<0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F>0','存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2421),
(2422,'1','存货预警','ZCFZ_P-ZCFZ_P1<0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F==0','存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。','',NULL,'11005',NULL,2422),
(2423,'1','存货预警','ZCFZ_P-ZCFZ_P1==0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F>0','期末存货与上年同期持平。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2423),
(2424,'1','存货预警','ZCFZ_P-ZCFZ_P1==0&&YBLFX_N>60&&CHKL_D+CHKL_E+CHKL_F==0','期末存货与上年同期持平。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。','',NULL,'11005',NULL,2424),
(2425,'1','存货预警','ZCFZ_P-ZCFZ_P1==0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F>0','期末存货与上年同期持平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'11005',NULL,2425),
(2426,'1','存货预警','ZCFZ_P-ZCFZ_P1==0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F==0','期末存货与上年同期持平。','',NULL,'11005',NULL,2426),
(2427,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1>0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层相对提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。但要留意，过度集中的采购，对企业存在风险，管理层需在两者之间取得平衡。在应付账款中，账龄超360日的应付账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}万元。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任及确认违约时间点等问题，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2427),
(2428,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1>0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层相对提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。但要留意，过度集中的采购，对企业存在风险，管理层需在两者之间取得平衡。','',NULL,'11006',NULL,2428),
(2429,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1>0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。在应付账款中，账龄超360日的应付账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}万元。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任及确认违约时间点等问题，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2429),
(2430,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1>0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。','',NULL,'11006',NULL,2430),
(2431,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1<0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2431),
(2432,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1<0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。','',NULL,'11006',NULL,2432),
(2433,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1<0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2433),
(2434,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1<0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'11006',NULL,2434),
(2435,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1==0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款与上年同期持平。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2435),
(2436,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1==0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款与上年同期持平。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。','',NULL,'11006',NULL,2436),
(2437,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1==0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','应付账款与上年同期持平。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'11006',NULL,2437),
(2438,'1','应付账款预警','ZCFZ_AV-ZCFZ_AV1==0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','应付账款与上年同期持平。','',NULL,'11006',NULL,2438),
(2439,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F>0','预收款项有所增加，建议管理层结合本系统的收入分析及应收账款分析等模块，如呈反趋势增长，需与销售部门分析预收账款增加的原因，是否有合同条款的调整，同时分析调整收款条件对维护客户关系可能产生的影响。此外，在同等销售规模前提下，改应收为预收，实际上对企业现金流有良性作用，建议管理层在不影响客户关系的前提下，适当增加销售预收。在预收账款中，账龄超360日的预收账款余额为Rmb{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}万元。针对账龄超1年的预收账款，建议管理层结合销售合同，关注是否存在收入核算时点、计量金额不准确的问题。此外，建议管理层评估款该部分账龄较长之应收款项是否仍需发货或支付返还，并进行相应的账务处理。','{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}',NULL,'11007',NULL,2439),
(2440,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F==0','预收款项有所增加，建议管理层结合本系统的收入分析及应收账款分析等模块，如呈反趋势增长，需与销售部门分析预收账款增加的原因，是否有合同条款的调整，同时分析调整收款条件对维护客户关系可能产生的影响。此外，在同等销售规模前提下，改应收为预收，实际上对企业现金流有良性作用，建议管理层在不影响客户关系的前提下，适当增加销售预收。','',NULL,'11007',NULL,2440),
(2441,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1<0&&YSKXZL_D+YSKXZL_E+YSKXZL_F>0','预收款项有所减少，首先需考虑是否与收入变动趋势一致，在不一致的情况下，需重点分析其减少原因。建议管理层与销售部门查看销售合同，并结合市场大环境，考虑预收款项的减少是否因产业经济环境下滑导致下游客户转嫁资金时间成本，合同收款条款进行了修改引起。在预收款项中，账龄超360日的预收款项余额为Rmb{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}万元。针对账龄超1年的预收款项，建议管理层结合销售合同，关注是否存在收入核算时点、计量金额不准确的问题。若不存在核算问题，则建议管理层关注是否因逾期1年的预收账款减少导致预收账款整体减少。若是，则建议继续跟进逾期1年预收账款减少是因转入收入还是因我司无法发货导致退款，若因我司无法发货导致退款，则需重点关注违约风险以及退款对我司资金流的影响。若否，则建议管理层重点关注逾期1年预收账款涉及的销售合同中收款方式、发货时点、违约责任等相关条款，若我司存在收到预收款后违约发货问题，则需评估违约风险对公司的不利影响。','{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}',NULL,'11007',NULL,2441),
(2442,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1<0&&YSKXZL_D+YSKXZL_E+YSKXZL_F==0','预收款项有所减少，首先需考虑是否与收入变动趋势一致，在不一致的情况下，需重点分析其减少原因。建议管理层与销售部门查看销售合同，并结合市场大环境，考虑预收款项的减少是否因产业经济环境下滑导致下游客户转嫁资金时间成本，合同收款条款进行了修改引起。','',NULL,'11007',NULL,2442),
(2443,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1==0&&YSKXZL_D+YSKXZL_E+YSKXZL_F>0','预收款项与上年同期持平。在预收款项中，账龄超360日的预收款项余额为Rmb{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}万元。针对账龄超1年的预收款项，建议管理层结合销售合同，关注是否存在收入核算时点、计量金额不准确的问题。此外，建议管理层评估款该部分账龄较长之应收款项是否仍需发货或支付返还，并进行相应的账务处理。','',NULL,'11007',NULL,2443),
(2444,'1','预收款项预警','ZCFZ_AW-ZCFZ_AW1==0&&YSKXZL_D+YSKXZL_E+YSKXZL_F==0','预收款项与上年同期持平。','',NULL,'11007',NULL,2444),
(2445,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F>0','其他应付款的有所增加，需考虑对未来偿还款项的资金风险。建议管理层查看增长幅度较大的其他应付款的合同，留意其中的偿还条款，根据本系统货币资金模块中的货币资金预警分析未来期间内是否会对资金造成影响。如为关联企业之间的资金拆借，需与企业未来发展相结合，如在短期内有上市计划，则需对其进行清理，如无，则需考虑关联企业之间的资金拆解是否符合相关的法律及监管条例的约束，例如：借款利率是否符合法律法规的要求；如为无息贷款，是否符合税法的要求。其他应付款中，账龄超360日的其他应付款余额为Rmb{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}万元。针对账龄超1年的其他应付款，建议管理层分析其是否属于关联方往来，并预估需付款的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流等方式，择优选择对自身最有利的方案，以防出现现金断流情况。','{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}',NULL,'11008',NULL,2445),
(2446,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F==0','其他应付款的有所增加，需考虑对未来偿还款项的资金风险。建议管理层查看增长幅度较大的其他应付款的合同，留意其中的偿还条款，根据本系统货币资金模块中的货币资金预警分析未来期间内是否会对资金造成影响。如为关联企业之间的资金拆借，需与企业未来发展相结合，如在短期内有上市计划，则需对其进行清理，如无，则需考虑关联企业之间的资金拆解是否符合相关的法律及监管条例的约束，例如：借款利率是否符合法律法规的要求；如为无息贷款，是否符合税法的要求。','',NULL,'11008',NULL,2446),
(2447,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1<0&&QTYFZL_D+QTYFZL_E+QTYFZL_F>0','其他应付款有所减少，需关注当前的资金状况是否充裕。此外，其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。在其他应付账款中，账龄超360日的其他应付款余额为Rmb{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}万元。针对账龄超1年的其他应付款，建议管理层分析其是否属于关联交易，并预估需付款的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流等方式，择优选择对自身最有利的方案，以防出现现金断流情况。','{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}',NULL,'11008',NULL,2447),
(2448,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1<0&&QTYFZL_D+QTYFZL_E+QTYFZL_F==0','其他应付款有所减少，需关注当前的资金状况是否充裕。此外，其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。','',NULL,'11008',NULL,2448),
(2449,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1==0&&QTYFZL_D+QTYFZL_E+QTYFZL_F>0','其他应付款与上年同期持平。其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。在其他应付账款中，账龄超360日的其他应付款余额为Rmb{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}万元。针对账龄超1年的其他应付款，建议管理层分析其是否属于关联交易，并预估需付款的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流等方式，择优选择对自身最有利的方案，以防出现现金断流情况。','{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}',NULL,'11008',NULL,2449),
(2450,'1','其他应付款','ZCFZ_BD-ZCFZ_BD1==0&&QTYFZL_D+QTYFZL_E+QTYFZL_F==0','其他应付款与上年同期持平。其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。','',NULL,'11008',NULL,2450),
(2451,'2','营业收入预警','LR_A1!=0&& LR_A-LR_A1>0&&LR_A/XSSL_A-LR_A1/XSSL_A1>0&& (LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','营业收入本期比上年同期增长{(LR_A-LR_A1)/LR_A1*100}%，主要是因为平均销售单价的上升。建议管理层与销售部分析销售单价上涨的产品及地区，评估产品群对价格上涨的接受程度，考虑是否所有产品均可涨价，抑或存在一定的局限性。如果单价上涨主要由于针对某一大产品，需考虑单价上涨对双方长期合作关系可能产生的影响。评估竞争对手的价格与企业相比是否具有较强的价格竞争力，企业的涨价行为是否会因此造成客源的流失。','{(LR_A-LR_A1)/LR_A1*100}',NULL,'20001',NULL,2451),
(2452,'2','营业收入预警','LR_A1!=0&& LR_A-LR_A1>0&&XSSL_A-XSSL_A1>0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)>0','营业收入本期比上年同期增长{(LR_A-LR_A1)/LR_A1*100}%，主要是因为销售量的大幅度增加。建议管理层与销售部分析销售量增长幅度最大的区域及产品，与市场部研究其增长模式是否可以在其他区域或产品中进行复制。同时，考虑销售量的增长是否具有可持续性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长。','{(LR_A-LR_A1)/LR_A1*100}',NULL,'20001',NULL,2452),
(2453,'2','营业收入预警','LR_A1==0&& LR_A-LR_A1>0&&LR_A/XSSL_A-LR_A1/XSSL_A1>0&& (LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','营业收入本期比上年同期增长-%，主要是因为平均销售单价的上升。建议管理层与销售部分析销售单价上涨的产品及地区，评估产品群对价格上涨的接受程度，考虑是否所有产品均可涨价，抑或存在一定的局限性。如果单价上涨主要由于针对某一大产品，需考虑单价上涨对双方长期合作关系可能产生的影响。评估竞争对手的价格与企业相比是否具有较强的价格竞争力，企业的涨价行为是否会因此造成客源的流失。','',NULL,'20001',NULL,2453),
(2454,'2','营业收入预警','LR_A1==0&& LR_A-LR_A1>0&&XSSL_A-XSSL_A1>0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)>0','营业收入本期比上年同期增长-%，主要是因为销售量的大幅度增加。建议管理层与销售部分析销售量增长幅度最大的区域及产品，与市场部研究其增长模式是否可以在其他区域或产品中进行复制。同时，考虑销售量的增长是否具有可持续性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长。','',NULL,'20001',NULL,2454),
(2455,'2','营业收入预警','LR_A-LR_A1<0&&LR_A/XSSL_A-LR_A1/XSSL_A1<0&& (LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','营业收入本期比上年同期减少{(LR_A1-LR_A)/LR_A1*100}%，主要是因为平均销售单价的降低。建议管理层与销售部分析销售单价降低的产品及地区，评估产品群对价格的敏感性，考虑是否所有产品均可适当涨价，提高企业利润。如果单价降低主要由于针对某一大产品，需考虑单价降低对双方长期合作关系可能产生的影响及评估该措施的利弊。同时，评估竞争对手的价格与企业相比是否具有较强的价格竞争力，后期企业的涨价行为是否会因此造成客源的流失。','{(LR_A1-LR_A)/LR_A1*100}',NULL,'20001',NULL,2455),
(2456,'2','营业收入预警','LR_A-LR_A1<0&&XSSL_A-XSSL_A1<0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)<0','营业收入本期比上年同期减少{(LR_A1-LR_A)/LR_A1*100}%，主要是因为销售量的大幅度降低。建议管理层与销售部分析销售量降低幅度最大的区域及产品，与市场部研究其降低原因，考虑销售量的降低是否具有不可逆转性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长，维持市场份额。','{(LR_A1-LR_A)/LR_A1*100}',NULL,'20001',NULL,2456),
(2457,'2','营业收入预警','LR_A-LR_A1==0','营业收入本期与上期持平，此情况较为特殊，建议管理层核对数据是否正确，如无误，需结合本系统中具体科目的详细分析，考虑以下问题：1. 营业收入与应收账款变动趋势是否一致，如存在应收账款仍然不断增加，但是营业收入则两期不变的情况，管理层需高度重视现金流状况，结合本系统中未来6个月货币资金的预测图，查看未来是否存在资金紧缺的情况，相应对应收账款进行催收，增大现金流。','',NULL,'20001',NULL,2457),
(2674,'2','销售费用预警','LR_A!=0&&LR_A1!=0','本期销售费用占营业收入的比率为{LR_P/LR_A*100}%，上年同期该比率为{LR_P1/LR_A1*100}%。','{LR_P/LR_A*100},{LR_P1/LR_A1*100}',NULL,'G20004',NULL,2674),
(2675,'2','销售费用预警','LR_A!=0&&LR_A1==0','本期销售费用占营业收入的比率为{LR_P/LR_A*100}%，上年同期该比率为-%。','{LR_P/LR_A*100}',NULL,'G20004',NULL,2675),
(2676,'2','销售费用预警','LR_A==0&&LR_A1!=0','本期销售费用占营业收入的比率为-%，上年同期该比率为{LR_P1/LR_A1*100}%。','{LR_P1/LR_A1*100}',NULL,'G20004',NULL,2676),
(2677,'2','销售费用预警','LR_A==0&&LR_A1==0','本期销售费用占营业收入的比率为-%，上年同期该比率为-%。','',NULL,'G20004',NULL,2677),
(2678,'2','销售费用预警','1-1==0','建议管理层关注销售费用的变动趋势是否与收入变化趋势一致，从而考虑目前的销售部门的激励政策、市场策略、销售政策是否达到预期的效果。建议管理层与销售部门研讨市场开拓的投入是否将在未来体现，同时，研究市场开拓的成本控制问题，可考虑将市场开拓成本与销售情况的匹配程度作为销售人员的工资调整KPI ，以达到控制市场开拓成本的目的。同时，对于不必要的市场开拓及广告费用等，进行缩减。','',NULL,'G20004',NULL,2678),
(2679,'2','销售费用预警','LR_P1!=0&&                            LR_P-LR_P1>0&& XSFY_RG-XSFY_RG1>0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为销售人工成本的增加。建议管理层查看人工成本增加的原因。如为员工人数增加导致的总体人工金额增加，需考虑销售团队人员数量与销售计划的匹配性；如为销售人员工资构成的调整等因素引起的人工成本的增加，需考虑销售人员的薪酬机制是否合理，是否与市场水平挂钩，薪酬的增加是否达到预期的市场开拓效果。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G20004',NULL,2679),
(2680,'2','销售费用预警','LR_P1!=0&&                            LR_P-LR_P1>0&& XSFY_CL-XSFY_CL1>0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为差旅费用的大幅度增加。建议管理层查看差旅费用增加幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加强成本费用的控制。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G20004',NULL,2680),
(2681,'2','销售费用预警','LR_P1!=0&&                            LR_P-LR_P1>0&& XSFY_TG-XSFY_TG1>0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为广告费、促销费、推广费、设计费支出的增加。建议管理层查看广告及促销费用增加的趋势与销售收入的变动趋势是否一致，评估费用增加对收入的影响，是否带来了预期的市场效果，从而考虑是否需要调整市场开拓方针。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G20004',NULL,2681),
(2682,'2','销售费用预警','LR_P1!=0&&                            LR_P-LR_P1>0&& XSFY_ZD-XSFY_ZD1>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为业务招待费的增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G20004',NULL,2682),
(2683,'2','销售费用预警','LR_P1!=0&&                            LR_P-LR_P1>0&& XSFY_QT-XSFY_QT1>0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)>0','销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用增长。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G20004',NULL,2683),
(2684,'2','销售费用预警','LR_P1==0&&                            LR_P-LR_P1>0&& XSFY_RG-XSFY_RG1>0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长-%，主要是因为销售人工成本的增加。建议管理层查看人工成本增加的原因。如为员工人数增加导致的总体人工金额增加，需考虑销售团队人员数量与销售计划的匹配性；如为销售人员工资构成的调整等因素引起的人工成本的增加，需考虑销售人员的薪酬机制是否合理，是否与市场水平挂钩，薪酬的增加是否达到预期的市场开拓效果。','',NULL,'G20004',NULL,2684),
(2685,'2','销售费用预警','LR_P1==0&&                            LR_P-LR_P1>0&& XSFY_CL-XSFY_CL1>0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长-%，主要是因为差旅费用的大幅度增加。建议管理层查看差旅费用增加幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加强成本费用的控制。','',NULL,'G20004',NULL,2685),
(2686,'2','销售费用预警','LR_P1==0&&                            LR_P-LR_P1>0&& XSFY_TG-XSFY_TG1>0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长-%，主要是因为广告费、促销费、推广费、设计费支出的增加。建议管理层查看广告及促销费用增加的趋势与销售收入的变动趋势是否一致，评估费用增加对收入的影响，是否带来了预期的市场效果，从而考虑是否需要调整市场开拓方针。','',NULL,'G20004',NULL,2686),
(2687,'2','销售费用预警','LR_P1==0&&                            LR_P-LR_P1>0&& XSFY_ZD-XSFY_ZD1>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)>0','销售费用本期比上年同期增长-%，主要是因为业务招待费的增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','',NULL,'G20004',NULL,2687),
(2688,'2','销售费用预警','LR_P1==0&&                            LR_P-LR_P1>0&& XSFY_QT-XSFY_QT1>0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)>0','销售费用本期比上年同期增长-%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用增长。','',NULL,'G20004',NULL,2688),
(2689,'2','销售费用预警','LR_P-LR_P1<0&& XSFY_RG-XSFY_RG1<0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)<0','销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为销售人工成本的减少。建议管理层查看人工成本减少的原因。如为员工人数减少导致的总体人工金额减少，需考虑销售团队人员的调整对销售计划已经未来销售收入的总体影响；如为销售人员工资构成的调整等因素引起的人工成本的减少，需考虑销售人员对薪酬机制的满意程度以及可能引起的人员流动，从而评估销售人员流动对销售收入及增长可能产生的影响。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G20004',NULL,2689),
(2690,'2','销售费用预警','LR_P-LR_P1<0&& XSFY_CL-XSFY_CL1<0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)<0','销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为差旅费用的大幅度减少。建议管理层查看差旅费用减少幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加大市场开拓的力度，调整市场开拓的方式。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G20004',NULL,2690),
(2691,'2','销售费用预警','LR_P-LR_P1<0&& XSFY_TG-XSFY_TG1<0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)<0','销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为广告费、促销费、推广费、设计费支出的减少。建议管理层查看广告及促销费用减少的趋势与销售收入的变动趋势是否一致，评估费用缩减对收入的影响，从而考虑是否需要调整市场开拓方针。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G20004',NULL,2691),
(2692,'2','销售费用预警','LR_P-LR_P1<0&& XSFY_ZD-XSFY_ZD1<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)<0','销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为业务招待费的减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G20004',NULL,2692),
(2693,'2','销售费用预警','LR_P-LR_P1<0&& XSFY_QT-XSFY_QT1<0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)<0','销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出减少所导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用减少。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G20004',NULL,2693),
(2694,'2','销售费用预警','LR_P-LR_P1==0','销售费用本期与上期持平，此现象较为特殊，建议管理层在确认数据无误的情况下，分析两期费用构成的变动，对于波动较大的明细科目，需重点关注其变动原因，其存在风险，可通过本系统咨询模块向专业顾问进行沟通咨询。','',NULL,'G20004',NULL,2694),
(2695,'2','管理费用预警','LR_A!=0&&LR_A1!=0','本期管理费用占营业收入的比率为{LR_Q/LR_A*100}%，上年同期该比率为{LR_Q1/LR_A1*100}%。建议管理层关注管理费用的变动趋势是否与收入变化趋势一致，从而考虑目前的管理部门的成本控制是否合理。','{LR_Q/LR_A*100},{LR_Q1/LR_A1*100}',NULL,'G20007',NULL,2695),
(2696,'2','管理费用预警','LR_A!=0&&LR_A1==0','本期管理费用占营业收入的比率为{LR_Q/LR_A*100}%，上年同期该比率为-%。建议管理层关注管理费用的变动趋势是否与收入变化趋势一致，从而考虑目前的管理部门的成本控制是否合理。','{LR_Q/LR_A*100}',NULL,'G20007',NULL,2696),
(2697,'2','管理费用预警','LR_A==0&&LR_A1!=0','本期管理费用占营业收入的比率为-%，上年同期该比率为{LR_Q1/LR_A1*100}%。建议管理层关注管理费用的变动趋势是否与收入变化趋势一致，从而考虑目前的管理部门的成本控制是否合理。','{LR_Q1/LR_A1*100}',NULL,'G20007',NULL,2697),
(2698,'2','管理费用预警','LR_A==0&&LR_A1==0','本期管理费用占营业收入的比率为-%，上年同期该比率为-%。建议管理层关注管理费用的变动趋势是否与收入变化趋势一致，从而考虑目前的管理部门的成本控制是否合理。','',NULL,'G20007',NULL,2698),
(2699,'2','管理费用预警','LR_Q1!=0&&LR_Q-LR_Q1>0&& GLFY_RG-GLFY_RG1>0&&(GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为管理人员人工成本增加。建议管理层查看工资上涨的原因，与人力资源部门讨论控制工资上涨的方式。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G20007',NULL,2699),
(2700,'2','管理费用预警','LR_Q1!=0&&LR_Q-LR_Q1>0&& GLFY_ZJ-GLFY_ZJ1>0&&(GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为办公用固定资产大幅度增加，导致折旧金额相应增加，建议管理层做好固定资产管理，包括固定资产卡片，台账等的管理等。此外，建议管理层评估大幅度增加管理用固定资产的必要性，做好支出管理。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G20007',NULL,2700),
(2701,'2','管理费用预警','LR_Q1!=0&&LR_Q-LR_Q1>0&& GLFY_ZD-GLFY_ZD1>0&&(GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为业务招待费增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G20007',NULL,2701),
(2702,'2','管理费用预警','LR_Q1!=0&&LR_Q-LR_Q1>0&& GLFY_QT-GLFY_QT1>0&&(GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)>0','管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是由于除人工、折旧、业务招待外的剩余支出的增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层采用本系统在线顾问服务模块中的顾问咨询功能，对可能存在或延续的问题咨询专家意见。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G20007',NULL,2702),
(2703,'2','管理费用预警','LR_Q1==0&&LR_Q-LR_Q1>0&& GLFY_RG-GLFY_RG1>0&&(GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长-%，主要是因为管理人员人工成本增加。建议管理层查看工资上涨的原因，与人力资源部门讨论控制工资上涨的方式。','',NULL,'G20007',NULL,2703),
(2704,'2','管理费用预警','LR_Q1==0&&LR_Q-LR_Q1>0&& GLFY_ZJ-GLFY_ZJ1>0&&(GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长-%，主要是因为办公用固定资产大幅度增加，导致折旧金额相应增加，建议管理层做好固定资产管理，包括固定资产卡片，台账等的管理等。此外，建议管理层评估大幅度增加管理用固定资产的必要性，做好支出管理。','',NULL,'G20007',NULL,2704),
(2705,'2','管理费用预警','LR_Q1==0&&LR_Q-LR_Q1>0&& GLFY_ZD-GLFY_ZD1>0&&(GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)>0','管理费用本期比上年同期增长-%，主要是因为业务招待费增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','',NULL,'G20007',NULL,2705),
(2706,'2','管理费用预警','LR_Q1==0&& LR_Q-LR_Q1>0&&GLFY_QT-GLFY_QT1>0&&(GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)>0','管理费用本期比上年同期增长-%，主要是由于除人工、折旧、业务招待外的剩余支出的增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层采用本系统在线顾问服务模块中的顾问咨询功能，对可能存在或延续的问题咨询专家意见。','',NULL,'G20007',NULL,2706),
(2707,'2','管理费用预警','LR_Q-LR_Q1<0&& GLFY_RG-GLFY_RG1<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)<0','管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为管理人员人工成本减少。建议管理层查看人工减少的原因，考虑未来人员配置的调整，并评估对净利润以及现金流的影响。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G20007',NULL,2707),
(2708,'2','管理费用预警','LR_Q-LR_Q1<0&& GLFY_ZJ-GLFY_ZJ1<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)<0','管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为折旧减少。建议管理层查看折旧减少原因，如本年内大量报废办公设备，需考虑未来的固定资产购置计划，以及办公设备的购置对现金流以及净利润的影响。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G20007',NULL,2708),
(2709,'2','管理费用预警','LR_Q-LR_Q1<0&& GLFY_ZD-GLFY_ZD1<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)<0','管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为业务招待费减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G20007',NULL,2709),
(2710,'2','管理费用预警','LR_Q-LR_Q1<0&& GLFY_QT-GLFY_QT1<0&& (GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)<0','管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是由于除人工、折旧、业务招待外的剩余支出的减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，应扣除这一事项后进行分析。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G20007',NULL,2710),
(2711,'2','管理费用预警','LR_Q-LR_Q1==0','管理费用本期与上期一致，此情况较为特殊，建议管理层在确认数据无误的情况下，重点关注以下问题：1. 本期与上期是否存在“咨询费用”或者“顾问费用”支出。此类支出为审计重点关注对象，可能涉及因诉讼等产生的支出，因此，如存在此类支出，尤其是在本期比上期支出增长的情况下，管理层需就其增长合理性及可能存在的风险进行分析，如：诉讼是否会产生预计负债等，均为投资者、审计师重点关注问题；2. 针对两期对比变动较大支出类别，需查找原因，了解变动合理性，减少可能存在的风险。建议使用本系统中咨询模块，聘请专业顾问就潜在风险及应对措施等进行咨询。','','','G20007','',2711),
(2739,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_A-LR_A1>0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&&(LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&    (LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&&(LR_A-LR_A1)-(LR_W-LR_W1)>0&&   (LR_A-LR_A1)-(LR_X-LR_X1)>0&&','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为营业收入的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2739),
(2740,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_A1-LR_A>0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&&(LR_A1-LR_A)-(LR_O-LR_O1)>0&&(LR_A1-LR_A)-(LR_P-LR_P1)>0&&(LR_A1-LR_A)-(LR_Q-LR_Q1)>0&&(LR_A1-LR_A)-(LR_R-LR_R1)>0&&(LR_A1-LR_A)-(LR_S-LR_S1)>0&&(LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&&(LR_A1-LR_A)-(LR_W1-LR_W)>0&&(LR_A1-LR_A)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元减少至本期的Rmb{LR_Y/10000}万元，主要是因为营业收入的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2740),
(2741,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_F-LR_F1>0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&(LR_F-LR_F1)-(LR_W1-LR_W)>0&&(LR_F-LR_F1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元减少至本期的Rmb{LR_Y/10000}万元，主要是因为营业成本的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2741),
(2742,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_F1-LR_F>0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&&(LR_F1-LR_F)-(LR_P1-LR_P)>0&&(LR_F1-LR_F)-(LR_Q1-LR_Q)>0&&(LR_F1-LR_F)-(LR_R1-LR_R)>0&&(LR_F1-LR_F)-(LR_S1-LR_S)>0&&(LR_F1-LR_F)-(LR_T-LR_T1)>0&&(LR_F1-LR_F)-(LR_U-LR_U1)>0&&(LR_F1-LR_F)-(LR_W-LR_W1)>0&&(LR_F1-LR_F)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为营业成本的下降导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2742),
(2743,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_O-LR_O1>0&&(LR_O-LR_O1)-(LR_A1-LR_A)>0&&(LR_O-LR_O1)-(LR_F-LR_F1)>0&&(LR_O-LR_O1)-(LR_P-LR_P1)>0&&(LR_O-LR_O1)-(LR_Q-LR_Q1)>0&&(LR_O-LR_O1)-(LR_R-LR_R1)>0&&(LR_O-LR_O1)-(LR_S-LR_S1)>0&&(LR_O-LR_O1)-(LR_T1-LR_T)>0&&(LR_O-LR_O1)-(LR_U1-LR_U)>0&&(LR_O-LR_O1)-(LR_W1-LR_W)>0&&(LR_O-LR_O1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元减少至本期的Rmb{LR_Y/10000}万元，主要是因为税金及附加的增加导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2743),
(2744,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_O1-LR_O>0&&(LR_O1-LR_O)-(LR_A-LR_A1)>0&&(LR_O1-LR_O)-(LR_F1-LR_F)>0&&(LR_O1-LR_O)-(LR_P1-LR_P)>0&&(LR_O1-LR_O)-(LR_Q1-LR_Q)>0&&(LR_O1-LR_O)-(LR_R1-LR_R)>0&&(LR_O1-LR_O)-(LR_S1-LR_S)>0&&(LR_O1-LR_O)-(LR_T-LR_T1)>0&&(LR_O1-LR_O)-(LR_U-LR_U1)>0&&(LR_O1-LR_O)-(LR_W-LR_W1)>0&&(LR_O1-LR_O)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为税金及附加的下降导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2744),
(2745,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_P-LR_P1>0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&(LR_P-LR_P1)-(LR_F-LR_F1)>0&&(LR_P-LR_P1)-(LR_O-LR_O1)>0&&(LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&(LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&(LR_P-LR_P1)-(LR_W1-LR_W)>0&&(LR_P-LR_P1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为销售费用的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2745),
(2746,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_P1-LR_P>&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&&(LR_P1-LR_P)-(LR_F1-LR_F)>0&&(LR_P1-LR_P)-(LR_O1-LR_O)>0&&(LR_P1-LR_P)-(LR_Q1-LR_Q)>0&&(LR_P1-LR_P)-(LR_R1-LR_R)>0&&(LR_P1-LR_P)-(LR_S1-LR_S)>0&&(LR_P1-LR_P)-(LR_T-LR_T1)>0&&(LR_P1-LR_P)-(LR_U-LR_U1)>0&&(LR_P1-LR_P)-(LR_W-LR_W1)>0&&(LR_P1-LR_P)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为销售费用的下降导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2746),
(2747,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_Q-LR_Q1>0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&&(LR_Q-LR_Q1)-(LR_F-LR_F1)>0&&(LR_Q-LR_Q1)-(LR_O-LR_O1)>0&&(LR_Q-LR_Q1)-(LR_P-LR_P1)>0&&(LR_Q-LR_Q1)-(LR_R-LR_R1)>0&&(LR_Q-LR_Q1)-(LR_S-LR_S1)>0&&(LR_Q-LR_Q1)-(LR_T1-LR_T)>0&&(LR_Q-LR_Q1)-(LR_U1-LR_U)>0&&(LR_Q-LR_Q1)-(LR_W1-LR_W)>0&&(LR_Q-LR_Q1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为管理费用的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2747),
(2748,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_Q1-LR_Q>0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&&(LR_Q1-LR_Q)-(LR_F1-LR_F)>0&&(LR_Q1-LR_Q)-(LR_O1-LR_O)>0&&(LR_Q1-LR_Q)-(LR_P1-LR_P)>0&&(LR_Q1-LR_Q)-(LR_R1-LR_R)>0&&(LR_Q1-LR_Q)-(LR_S1-LR_S)>0&&(LR_Q1-LR_Q)-(LR_T-LR_T1)>0&&(LR_Q1-LR_Q)-(LR_U-LR_U1)>0&&(LR_Q1-LR_Q)-(LR_W-LR_W1)>0&&(LR_Q1-LR_Q)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为管理费用的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2748),
(2749,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_R-LR_R1>0&&(LR_R-LR_R1)-(LR_A1-LR_A)>0&&(LR_R-LR_R1)-(LR_F-LR_F1)>0&&(LR_R-LR_R1)-(LR_O-LR_O1)>0&&(LR_R-LR_R1)-(LR_P-LR_P1)>0&&(LR_R-LR_R1)-(LR_Q-LR_Q1)>0&&(LR_R-LR_R1)-(LR_S-LR_S1)>0&&(LR_R-LR_R1)-(LR_T1-LR_T)>0&&(LR_R-LR_R1)-(LR_U1-LR_U)>0&&(LR_R-LR_R1)-(LR_W1-LR_W)>0&&(LR_R-LR_R1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为财务费用的增加导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2749),
(2750,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_R1-LR_R>0&&(LR_R1-LR_R)-(LR_A-LR_A1)>0&&(LR_R1-LR_R)-(LR_F1-LR_F)>0&&(LR_R1-LR_R)-(LR_O1-LR_O)>0&&(LR_R1-LR_R)-(LR_P1-LR_P)>0&&(LR_R1-LR_R)-(LR_Q1-LR_Q)>0&&(LR_R1-LR_R)-(LR_S1-LR_S)>0&&(LR_R1-LR_R)-(LR_T-LR_T1)>0&&(LR_R1-LR_R)-(LR_U-LR_U1)>0&&(LR_R1-LR_R)-(LR_W-LR_W1)>0&&(LR_R1-LR_R)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为财务费用的下降导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2750),
(2751,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_S-LR_S1>0&&(LR_S-LR_S1)-(LR_A1-LR_A)>0&&(LR_S-LR_S1)-(LR_F-LR_F1)>0&&(LR_S-LR_S1)-(LR_O-LR_O1)>0&&(LR_S-LR_S1)-(LR_P-LR_P1)>0&&(LR_S-LR_S1)-(LR_Q-LR_Q1)>0&&(LR_S-LR_S1)-(LR_R-LR_R1)>0&&(LR_S-LR_S1)-(LR_T1-LR_T)>0&&(LR_S-LR_S1)-(LR_U1-LR_U)>0&&(LR_S-LR_S1)-(LR_W1-LR_W)>0&&(LR_S-LR_S1)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为资产减值损失的增加导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2751),
(2752,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_S1-LR_S>0&&(LR_S1-LR_S)-(LR_A-LR_A1)>0&&(LR_S1-LR_S)-(LR_F1-LR_F)>0&&(LR_S1-LR_S)-(LR_O1-LR_O)>0&&(LR_S1-LR_S)-(LR_P1-LR_P)>0&&(LR_S1-LR_S)-(LR_Q1-LR_Q)>0&&(LR_S1-LR_S)-(LR_R1-LR_R)>0&&(LR_S1-LR_S)-(LR_T-LR_T1)>0&&(LR_S1-LR_S)-(LR_U-LR_U1)>0&&(LR_S1-LR_S)-(LR_W-LR_W1)>0&&(LR_S1-LR_S)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为资产减值损失的下降导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2752),
(2753,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_T-LR_T1>0&&(LR_T-LR_T1)-(LR_F1-LR_F)>0&&(LR_T-LR_T1)-(LR_O1-LR_O)>0&&(LR_T-LR_T1)-(LR_P1-LR_P)>0&&(LR_T-LR_T1)-(LR_Q1-LR_Q)>0&&(LR_T-LR_T1)-(LR_R1-LR_R)>0&&(LR_T-LR_T1)-(LR_S1-LR_S)>0&&(LR_T-LR_T1)-(LR_A-LR_A1)>0&&(LR_T-LR_T1)-(LR_U-LR_U1)>0&&(LR_T-LR_T1)-(LR_W-LR_W1)>0&&(LR_T-LR_T1)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为公允价值变动收益的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2753),
(2754,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_T1-LR_T>0&&(LR_T1-LR_T)-(LR_F-LR_F1)>0&&(LR_T1-LR_T)-(LR_O-LR_O1)>0&&(LR_T1-LR_T)-(LR_P-LR_P1)>0&&(LR_T1-LR_T)-(LR_Q-LR_Q1)>0&&(LR_T1-LR_T)-(LR_R-LR_R1)>0&&(LR_T1-LR_T)-(LR_S-LR_S1)>0&&(LR_T1-LR_T)-(LR_A1-LR_A)>0&&(LR_T1-LR_T)-(LR_U1-LR_U)>0&&(LR_T1-LR_T)-(LR_W1-LR_W)>0&&(LR_T1-LR_T)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为公允价值变动收益的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2754),
(2755,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_U-LR_U1>0&&(LR_U-LR_U1)-(LR_F1-LR_F)>0&&(LR_U-LR_U1)-(LR_O1-LR_O)>0&&(LR_U-LR_U1)-(LR_P1-LR_P)>0&&(LR_U-LR_U1)-(LR_Q1-LR_Q)>0&&(LR_U-LR_U1)-(LR_R1-LR_R)>0&&(LR_U-LR_U1)-(LR_S1-LR_S)>0&&(LR_U-LR_U1)-(LR_A-LR_A1)>0&&(LR_U-LR_U1)-(LR_T-LR_T1)>0&&(LR_U-LR_U1)-(LR_W-LR_W1)>0&&(LR_U-LR_U1)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为投资收益的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2755),
(2756,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_U1-LR_U>0&&(LR_U1-LR_U)-(LR_F-LR_F1)>0&&(LR_U1-LR_U)-(LR_O-LR_O1)>0&&(LR_U1-LR_U)-(LR_P-LR_P1)>0&&(LR_U1-LR_U)-(LR_Q-LR_Q1)>0&&(LR_U1-LR_U)-(LR_R-LR_R1)>0&&(LR_U1-LR_U)-(LR_S-LR_S1)>0&&(LR_U1-LR_U)-(LR_A1-LR_A)>0&&(LR_U1-LR_U)-(LR_T1-LR_T)>0&&(LR_U1-LR_U)-(LR_W1-LR_W)>0&&(LR_U1-LR_U)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为投资收益的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2756),
(2757,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_W-LR_W1>0&&(LR_W-LR_W1)-(LR_F1-LR_F)>0&&(LR_W-LR_W1)-(LR_O1-LR_O)>0&&(LR_W-LR_W1)-(LR_P1-LR_P)>0&&(LR_W-LR_W1)-(LR_Q1-LR_Q)>0&&(LR_W-LR_W1)-(LR_R1-LR_R)>0&&(LR_W-LR_W1)-(LR_S1-LR_S)>0&&(LR_W-LR_W1)-(LR_A-LR_A1)>0&&(LR_W-LR_W1)-(LR_T-LR_T1)>0&&(LR_W-LR_W1)-(LR_U-LR_U1)>0&&(LR_W-LR_W1)-(LR_X-LR_X1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为汇兑收益的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2757),
(2758,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_W1-LR_W>0&&(LR_W1-LR_W)-(LR_F-LR_F1)>0&&(LR_W1-LR_W)-(LR_O-LR_O1)>0&&(LR_W1-LR_W)-(LR_P-LR_P1)>0&&(LR_W1-LR_W)-(LR_Q-LR_Q1)>0&&(LR_W1-LR_W)-(LR_R-LR_R1)>0&&(LR_W1-LR_W)-(LR_S-LR_S1)>0&&(LR_W1-LR_W)-(LR_A1-LR_A)>0&&(LR_W1-LR_W)-(LR_T1-LR_T)>0&&(LR_W1-LR_W)-(LR_U1-LR_U)>0&&(LR_W1-LR_W)-(LR_X1-LR_X)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为汇兑收益的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2758),
(2759,'2','营业利润概述','LR_Y-LR_Y1>0&&LR_X-LR_X1>0&&(LR_X-LR_X1)-(LR_F1-LR_F)>0&&(LR_X-LR_X1)-(LR_O1-LR_O)>0&&(LR_X-LR_X1)-(LR_P1-LR_P)>0&&(LR_X-LR_X1)-(LR_Q1-LR_Q)>0&&(LR_X-LR_X1)-(LR_R1-LR_R)>0&&(LR_X-LR_X1)-(LR_S1-LR_S)>0&&(LR_X-LR_X1)-(LR_A-LR_A1)>0&&(LR_X-LR_X1)-(LR_T-LR_T1)>0&&(LR_X-LR_X1)-(LR_U-LR_U1)>0&&(LR_X-LR_X1)-(LR_W-LR_W1)>0','营业利润从上期的Rmb{LR_Y1/10000}万元增长至本期的Rmb{LR_Y/10000}万元，主要是因为其他收益的增长导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2759),
(2760,'2','营业利润概述','LR_Y1-LR_Y>0&&LR_X1-LR_X>0&&(LR_X1-LR_X)-(LR_F-LR_F1)>0&&(LR_X1-LR_X)-(LR_O-LR_O1)>0&&(LR_X1-LR_X)-(LR_P-LR_P1)>0&&(LR_X1-LR_X)-(LR_Q-LR_Q1)>0&&(LR_X1-LR_X)-(LR_R-LR_R1)>0&&(LR_X1-LR_X)-(LR_S-LR_S1)>0&&(LR_X1-LR_X)-(LR_A1-LR_A)>0&&(LR_X1-LR_X)-(LR_T1-LR_T)>0&&(LR_X1-LR_X)-(LR_U1-LR_U)>0&&(LR_X1-LR_X)-(LR_W1-LR_W)>0','营业利润从上期的Rmb{LR_Y1/10000}万元下降至本期的Rmb{LR_Y/10000}万元，主要是因为其他收益的减少导致。','{LR_Y1/10000},{LR_Y/10000}',NULL,'G2016',NULL,2760),
(2761,'2','营业利润概述','LR_Y-LR_Y1==0','本期营业利润与上期一致，为Rmb{LR_Y/10000}万元。','{LR_Y/10000}',NULL,'G2016',NULL,2761),
(2765,'2','营业利润预警','LR_Y-LR_Y1>0&&LR_Y1<0&&LR_Y>0','营业利润反映公司正常经营情况下产生的利润，本期营业利润有较大改进，从上期的亏损改善至盈利状态，管理层可维持目前的经营战略，但应注意与现金流情况结合分析，如单纯出现盈利，但现金流仍处于紧张状态，需高度关注，通过改善应收款回收等方式，改善现金流，防止因资金链断裂导致经营困难。','',NULL,'20018',NULL,2765),
(2766,'2','营业利润预警','LR_Y-LR_Y1>0&&LR_Y1<0&&LR_Y<0','尽管本期营业利润较上期有所增长，但仍处于亏损状态，建议管理层参考分析模块中各科目存在的重点问题，可就相关问题通过本系统咨询模块咨询专家顾问。','',NULL,'20018',NULL,2766),
(2767,'2','营业利润预警','LR_Y-LR_Y1>0&&LR_Y1>0','营业利润本期较上期有所增长，呈较好发展势头，管理层可维持目前的经营策略，但应注意与现金流情况结合分析，避免账面出现利润，但因资金链断链导致无法持续经营的情况出现。建议结合分析模块现金流量表的分析结果，咨询专业顾问，为企业健康发展出谋划策。','',NULL,'20018',NULL,2767),
(2768,'2','营业利润预警','LR_Y-LR_Y1>0&&LR_Y1==0','营业利润本期较上期有所增长，呈较好发展势头，管理层可维持目前的经营策略，但应注意与现金流情况结合分析，避免账面出现利润，但因资金链断链导致无法持续经营的情况出现。建议结合分析模块现金流量表的分析结果，咨询专业顾问，为企业健康发展出谋划策。','',NULL,'20018',NULL,2768),
(2769,'2','营业利润预警','LR_Y1-LR_Y>0&&LR_Y1>0&&LR_Y<0','营业利润从上期盈利下降至本期亏损状态，管理层需高度警惕，同时结合现金流分析以及分析模块中货币资金的未来6个月现金流情况预测，判断未来短期内现金流是否足以支撑经营，是否需要通过债权或股权融资改善现金流，结合营业收入及营业成本、存货等的分析结果，考虑是否需要调整库存结构，市场开拓方向及策略等。','',NULL,'20018',NULL,2769),
(2770,'2','营业利润预警','LR_Y1-LR_Y>0&&LR_Y1<0&&LR_Y<0','营业利润本期及上期均处于亏损状态，且呈下降趋势，管理层需高度警惕。建议在利润表首页分析结果查看变动最大科目及其原因，并进入具体科目查看分析结果，结合现金流分析情况，考虑是否需要通过债权或股权融资改善现金流，并结合营业收入、营业成本等重点科目，以及应收款项等的周转期情况，判断是否需要调整市场及生产策略，建议使用本系统咨询模块向专业顾问进行咨询。','',NULL,'20018',NULL,2770),
(2771,'2','营业利润预警','LR_Y1-LR_Y>0&&LR_Y>0','营业利润出现下滑，尽管本期仍维持在盈利状态，但需警惕下滑趋势，建议结合分析模块的各科目具体分析情况，并结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20018',NULL,2771),
(2772,'2','营业利润预警','LR_Y1-LR_Y>0&&LR_Y1==0','营业利润出现下滑，且本期营业利润变为亏损状态，管理层需高度警惕，建议结合分析模块中收入、成本、费用各科目的分析预警结果，分析出现亏损状态的原因，考虑是否需要调整经营策略，同时结合现金流状况，避免出现因现金流紧张出现资金断链的可能。','',NULL,'20018',NULL,2772),
(2773,'2','营业利润预警','LR_Y-LR_Y1==0&&LR_Y1>0','营业利润两期持平，且为盈利状态，建议管理层结合未来经营策略，分析利润的变动趋势与销售费用中市场支出的变动趋势是否一致，如不一致，需考虑市场推广效果是否达预期，是否需要调整市场拓展策略及方式等。','',NULL,'20018',NULL,2773),
(2774,'2','营业利润预警','LR_Y-LR_Y1==0&&LR_Y1<0','营业利润两期持平，且为亏损状态，管理层需警惕利润持续下滑的可能性，结合主要科目，如营业收入、营业成本、应收款项、存货等的分析结果，如为销售单价或成本上涨导致利润下滑亏损，需考虑产品结构或市场分布是否需要调整。此外，营业利润为负数，管理层需结合现金流分析结果，结合货币资金中未来6个月的现金流状况预测图，考虑是否需要进行债权或股权融资以减轻现金流负担，支撑企业在亏损状态下改善经营及发展。','',NULL,'20018',NULL,2774),
(2775,'2','营业利润预警','LR_Y-LR_Y1==0&&LR_Y1==0','营业利润两期持平，均为0，此情况较为特殊，建议管理层在确保数字正确的前提下，根据分析模块的预警，结合企业生产经营实际情况，考虑是否需要调整生产经营策略，此外，件内衣管理层结合现金流状况，避免出现资金链断链的情况。','',NULL,'20018',NULL,2775),
(2776,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_AD>0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0','利润总额呈增长趋势，且营业利润为正数，企业呈良性发展，建议管理层结合现金流分析，判断现金流是否充裕，是否足以支撑未来发展规划。如货币资金中未来6个月资金预测图显示未来可能有闲置资金，可考虑适当进行投资或业务扩张。','',NULL,'20019',NULL,2776),
(2777,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD>0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','利润总额呈增长趋势，且营业利润、利润总额均体现为盈利，企业发展较为良性；但营业外收支净额对利润总额的增加形成较大影响，由于营业外收支为非经营性科目，不具备可持续性，建议管理层剔除其对利润的影响，重点关注营业利润的分析情况，及时调整经营策略等，结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20019',NULL,2777),
(2778,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD==0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','利润总额呈增长趋势，且营业利润为正数，企业呈良性发展，建议管理层结合现金流分析，判断现金流是否充裕，是否足以支撑未来发展规划。如货币资金中未来6个月资金预测图显示未来可能有闲置资金，可考虑适当进行投资或业务扩张。','',NULL,'20019',NULL,2778),
(2779,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD==0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','利润总额呈增长趋势，且营业利润体现为盈利，企业发展较为良性；但营业外收支净额对利润总额的增加形成较大影响，由于营业外收支为非经营性科目，不具备可持续性，建议管理层剔除其对利润的影响，重点关注营业利润的分析情况，及时调整经营策略等，结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20019',NULL,2779),
(2780,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_AD>0&&LR_Y==0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0','利润总额呈增长趋势，且利润总额为正数，企业呈良性发展，建议管理层结合现金流分析，判断现金流是否充裕，是否足以支撑未来发展规划。如货币资金中未来6个月资金预测图显示未来可能有闲置资金，可考虑适当进行投资或业务扩张。','',NULL,'20019',NULL,2780),
(2781,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD>0&&LR_Y==0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','利润总额呈增长趋势，且利润总额体现为盈利，企业发展较为良性；但营业外收支净额对利润总额的增加形成较大影响，由于营业外收支为非经营性科目，不具备可持续性，建议管理层剔除其对利润的影响，重点关注营业利润的分析情况，及时调整经营策略等，结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20019',NULL,2781),
(2782,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_AD<0&&LR_Y>0','利润总额呈增长趋势，且主要业务活动已实现盈利，但由于营业外收支项目的影响，利润总额仍为亏损，建议予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2782),
(2783,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_AD==0&&LR_Y>0','利润总额呈增长趋势，且主要业务活动已实现盈利，但由于营业外收支项目的影响，利润总额仍为亏损，建议予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2783),
(2784,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_AD<0&&LR_Y==0','利润总额呈增长趋势，但由于营业外收支项目的影响，利润总额仍为亏损，建议予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2784),
(2785,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0  ','利润总额呈增长趋势，且主要由营业利润增长主导其变动，企业呈良性发展。然而，营业利润仍处于亏损状态，建议管理层结合现金流分析，判断现金流是否充裕，是否足以支撑未来发展规划。考虑是否需要通过债权或股权融资补充现金流。','',NULL,'20019',NULL,2785),
(2786,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD>0&&LR_Y<0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','尽管利润总额有所上涨，但该上涨主要是因为营业外收支净额的增加导致，营业利润实际为负数，在此情况下，由非日常经营产生的利润主导了利润总额的上涨，整个企业利润构成呈不健康状态。由于营业外收入为非经营性收入，为不可持续性收入，管理层应剔除此部分利润来分析整个企业的利润构成，建议管理层查看营业利润的分析结果，分析企业存在问题及调整方向。','',NULL,'20019',NULL,2786),
(2787,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD==0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0  ','利润总额呈增长趋势，且主要由营业利润增长主导其变动，企业呈良性发展。然而，营业利润仍处于亏损状态，建议管理层结合现金流分析，判断现金流是否充裕，是否足以支撑未来发展规划。考虑是否需要通过债权或股权融资补充现金流。','',NULL,'20019',NULL,2787),
(2788,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD==0&&LR_Y<0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','尽管利润总额有所上涨，但该上涨主要是因为营业外收支净额的增加导致，营业利润实际为负数，在此情况下，由非日常经营产生的利润主导了利润总额的上涨，整个企业利润构成呈不健康状态。由于营业外收入为非经营性收入，为不可持续性收入，管理层应剔除此部分利润来分析整个企业的利润构成，建议管理层查看营业利润的分析结果，分析企业存在问题及调整方向。','',NULL,'20019',NULL,2788),
(2789,'2','利润总额预警','LR_AD-LR_AD1>0&&LR_Y-LR_Y1>0&&LR_AD<0&&LR_Y1<0','本期亏损状况虽有所缓解，但营业利润、利润总额均未能实现扭亏，建议管理层结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2789),
(2790,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，且体现企业日常经营业绩的营业利润的下降成为利润下降的主导因素，这是一个危险信号，应引起充分关注，建议管理层查看营业利润的分析结果，并结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2790),
(2791,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD==0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，且体现企业日常经营业绩的营业利润的下降成为利润下降的主导因素，这是一个危险信号，应引起充分关注，建议管理层查看营业利润的分析结果，并结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2791),
(2792,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y==0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)<0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，且体现企业日常经营业绩的营业利润的下降成为利润下降的主导因素，这是一个危险信号，应引起充分关注，建议管理层查看营业利润的分析结果，并结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2792),
(2793,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，营业外收支净额的变动对利润总额的下滑产生较大影响。由于营业外收支为非经营性收支，建议管理层在剔除营业外收支净额的影响后，结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2793),
(2794,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD==0&&LR_Y>0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，营业外收支净额的变动对利润总额的下滑产生较大影响。由于营业外收支为非经营性收支，建议管理层在剔除营业外收支净额的影响后，结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2794),
(2795,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y==0&&(LR_Y-LR_Y1)-(LR_Z-LR_AB-LR_Z1+LR_AB1)>0','企业虽实现盈利，但营业利润、利润总额均呈下降趋势，营业外收支净额的变动对利润总额的下滑产生较大影响。由于营业外收支为非经营性收支，建议管理层在剔除营业外收支净额的影响后，结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2795),
(2796,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y<0','利润总额呈下降趋势，虽仍维持在盈利状态，但主要由营业外收支净额支撑其利润空间，营业外收支为非经营性收支，缺乏持续性；而能够反映企业日常经营业绩的营业利润已出现亏损且呈下降趋势。因此，建议管理层从剔除非经营性收支后的营业利润角度出发分析利润下降趋势，结合系统对主要科目，如：营业收入、营业成本、应收款项、存货等的变动分析，综合判断企业需调整改善的地方，制定相应策略。','',NULL,'20019',NULL,2796),
(2797,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD==0&&LR_Y<0','利润总额呈下降趋势，虽仍维持在盈利状态，但主要由营业外收支净额支撑其利润空间，营业外收支为非经营性收支，缺乏持续性；而能够反映企业日常经营业绩的营业利润已出现亏损且呈下降趋势。因此，建议管理层从剔除非经营性收支后的营业利润角度出发分析利润下降趋势，结合系统对主要科目，如：营业收入、营业成本、应收款项、存货等的变动分析，综合判断企业需调整改善的地方，制定相应策略。','',NULL,'20019',NULL,2797),
(2798,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD>0&&LR_Y==0','利润总额呈下降趋势，虽仍维持在盈利状态，但主要由营业外收支净额支撑其利润空间，营业外收支为非经营性收支，缺乏持续性；而能够反映企业日常经营业绩的营业利润已出现亏损且呈下降趋势。因此，建议管理层从剔除非经营性收支后的营业利润角度出发分析利润下降趋势，结合系统对主要科目，如：营业收入、营业成本、应收款项、存货等的变动分析，综合判断企业需调整改善的地方，制定相应策略。','',NULL,'20019',NULL,2798),
(2799,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD<0&&LR_Y>0','利润总额持续下降，且处于亏损状态，营业利润虽为盈利但呈现下降趋势，建议管理层结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2799),
(2800,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD==0&&LR_Y>0','利润总额持续下降，营业利润虽为盈利但呈现下降趋势，建议管理层结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2800),
(2801,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD<0&&LR_Y==0','利润总额持续下降，且处于亏损状态，营业利润虽为盈利但呈现下降趋势，建议管理层结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2801),
(2802,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1<0&&LR_AD<0&&LR_Y<0','利润总额持续下降，且处于亏损状态，营业利润亦为负数，建议管理层结合本系统主要科目，如：营业收入、营业成本、应收款项、存货等的分析结果，结合货币资金中未来6个月的资金状况预测，判断是否需要进行融资，同时考虑是否需要根据具体科目分析结果调整经营策略或方向等。','',NULL,'20019',NULL,2802),
(2803,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD>0','尽管本期利润总额为正数，但利润总额呈现下滑趋势，且营业利润实际为负数，证明企业利润总额的主要变动因素为营业外收支净额的影响，使得从经营类收入所得为负变为利润总额转盈利。由于营业外收支净额属于非经营性所得，不具有持续性，因此，管理层需对此情况高度警惕。建议结合分析模块的主要科目分析结果，了解实际经营亏损的原因，并评估是否需要调整生产经营策略。','',NULL,'20019',NULL,2803),
(2804,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD>0','受营业外收支项目的影响，尽管营业利润为亏损状态，但利润总额显示出盈利情况。由于营业外收支为非经营性科目，不具备可持续性，建议管理层剔除其对利润的影响，重点关注营业利润的分析情况，及时调整经营策略等，结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20019',NULL,2804),
(2805,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD==0&&(LR_Z-LR_AB)-(LR_Y1-LR_Y)>0','受营业外收支项目的影响，尽管营业利润为亏损状态，但利润总额为0，证明营业外收支净额使得利润总额有所增加。由于营业外收支为非经营性科目，不具备可持续性，建议管理层剔除其对利润的影响，重点关注营业利润的分析情况，及时调整经营策略等，结合现金流分析结果，避免出现资金链断裂的情况。','',NULL,'20019',NULL,2805),
(2806,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y>0&&LR_AD>0','本期营业利润有所上升，但利润总额有所下降，主要受营业外支出较上年同期有大幅度增加的影响。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2806),
(2807,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y==0&&LR_AD>0','本期营业利润有所上升，但利润总额有所下降，受营业外收支净额影响较大。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2807),
(2808,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y>0&&LR_AD==0','本期营业利润有所上升，但利润总额有所下降，主要受营业外支出较上年同期有大幅度增加的影响。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2808),
(2809,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y>0&&LR_AD<0','本期营业利润有所上升，但利润总额有所下降，主要受营业外支出较上年同期有大幅度增加的影响。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2809),
(2810,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y==0&&LR_AD>0','本期营业利润有所上升，但利润总额有所下降，主要受营业外支出较上年同期有大幅度增加的影响。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2810),
(2811,'2','利润总额预警','LR_AD-LR_AD1<0&& LR_Y-LR_Y1>0&&LR_Y<0&&LR_AD<0','本期营业利润有所上升，但利润总额有所下降，受营业外收支净额影响较大。由于营业外收支属于非经营性收支，不具有可持续性，对后续期间的生产经营所得产生的影响可能不复存在，因此，本期利润的下滑，建议管理层在撇除非经营性支出的影响后再做评估。','',NULL,'20019',NULL,2811),
(2812,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y>0&&LR_AD>0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2812),
(2813,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y==0&&LR_AD>0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2813),
(2814,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y>0&&LR_AD==0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2814),
(2815,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y>0&&LR_AD<0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2815),
(2816,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y==0&&LR_AD<0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2816),
(2817,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y<0&&LR_AD>0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2817),
(2818,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y<0&&LR_AD==0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2818),
(2819,'2','利润总额预警','LR_AD-LR_AD1>0&& LR_Y-LR_Y1<0&&LR_Y<0&&LR_AD<0','本期利润总额由于营业外收支项目的影响较大。由于营业外收支属非经营性项目，对生产经营所得不具有持续性影响，因此，建议查看营业利润的分析结果，结合营业收入、营业成本、应收款项、存货等的分析结果，分析企业存在问题及调整方向；并对营业外收支项目予以关注并加以管控，以降低其对利润的不良影响。','',NULL,'20019',NULL,2819),
(2820,'2','利润总额预警','LR_AD-LR_AD1==0&&LR_AD1!=0','利润总额两期相等，此情况较为特殊，建议管理层在确认数据无误的情况下，撇除营业外收支等非经营性项目对利润总额的影响，对利润总额再进行分析，根据分析结果，结合现金流分析状况，考虑是否需要扩大市场开拓或调整经营管理策略。','',NULL,'20019',NULL,2820),
(2821,'2','利润总额预警','LR_AD-LR_AD1==0&&LR_AD1==0','利润总额两期相等，且均为0，此情况较为特殊，建议管理层在确认数据无误的情况下，撇除营业外收支等非经营性项目对利润总额的影响，对利润总额再进行分析，根据分析结果，结合现金流分析状况，考虑是否需要扩大市场开拓或调整经营管理策略。','',NULL,'20019',NULL,2821),
(2822,'2','净利润预警','LR_AF-LR_AF1>0&&LR_AD>0&&LR_AE!=0&&LR_AF1!=0','净利润有所增长，且利润总额为正数。建议管理层剔除非经营性收支，如：营业外收支等科目的影响后，重新评估净利润状况，使其真实反应主体业务实际运营状态。可使用本系统咨询模块向专家顾问进行咨询。','','','20020','',2822),
(2823,'2','净利润预警','LR_AF-LR_AF1>0&&LR_AD>0&&LR_AE==0&&LR_AF1!=0','净利润有所增长，且所得税为0，企业仍处于税收优惠期。建议管理层结合所在地区税收政策，考虑在税收优惠期结束后，税金对净利润的影响。可使用本系统咨询模块，向专家进行咨询，通过税务筹划，进行合理避税，降低企业经营成本，实现利润最大化。','','','20020','',2823),
(2824,'2','净利润预警','LR_AF1-LR_AF>0&&LR_AD<0&&LR_AF1!=0','净利润有所下降，且利润总额为负数。建议管理层剔除非经营性收支，如：营业外收支等科目的影响后，重新评估净利润状况，使其真实反应主体业务实际运营状态。可使用本系统咨询模块向专家顾问进行咨询。','','','20020','',2824),
(2825,'2','净利润预警','LR_AF-LR_AF1==0&&LR_AF1!=0','净利润两期相等，建议管理层在确认数据无误的情况下，分别对比分析两期净利润构成，针对变动较大科目，查看系统分析结果，考虑是否存在管理漏洞，评估经营发展规划及策略是否存在调整空间内。','',NULL,'20020',NULL,2825),
(2826,'2','净利润预警','LR_AF1==0','净利润上期为0，建议管理层在确认数据无误的情况下，分别对比分析两期净利润构成，针对变动较大科目，查看系统分析结果，考虑是否存在管理漏洞，评估经营发展规划及策略是否存在调整空间内。此外，需关注现金流状况，防止出现资金链断链的可能。','','','20020','',2826),
(2827,'2','净利润预警','LR_AF1-LR_AF>0&&LR_AD>0&&LR_AF1!=0','净利润有所下降，且利润总额为正数。建议管理层剔除非经营性收支，如：营业外收支等科目的影响后，重新评估净利润状况，使其真实反应主体业务实际运营状态。可使用本系统咨询模块向专家顾问进行咨询。',NULL,NULL,'20020',NULL,0),
(2828,'2','营业收入预警','LR_A1==0&&LR_A-LR_A1>0&&XSSL_A1==0','营业收入本期比上年同期增长-%。由于上期数据缺失，导致无法分析收入变动的主要驱动因素。建议管理层补充系统数据以便进行分析。',NULL,NULL,'20001',NULL,2828),
(2829,'2','营业收入预警','LR_A==0&&LR_A-LR_A1<0&&XSSL_A==0','营业收入本期比上年同期下降-%。由于本期数据缺失，导致无法分析收入变动的主要驱动因素。建议管理层补充系统数据以便进行分析。',NULL,NULL,'20001',NULL,2829),
(2830,'2','管理费用预警','LR_Q1==0','因缺失上期数据，无法对管理费用变动原因进行分析，建议管理层补充数据，以便提供进一步分析结果。',NULL,NULL,'G20007',NULL,0),
(2831,'2','管理费用预警','LR_Q==0','因缺失本期数据，无法对管理费用变动原因进行分析，建议管理层补充数据，以便提供进一步分析结果。',NULL,NULL,'G20007',NULL,0),
(2832,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&&(LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&&(LR_A-LR_A1)-(LR_W-LR_W1)>0&&(LR_A-LR_A1)-(LR_X-LR_X1)>0&&(LR_A-LR_A1)-(LR_Z-LR_Z1)>0&&(LR_A-LR_A1)-(LR_AB1-LR_AB)>0&&(LR_A-LR_A1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中营业收入上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2833,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&&(LR_F1-LR_F)-(LR_P1-LR_P)>0&&(LR_F1-LR_F)-(LR_Q1-LR_Q)>0&&(LR_F1-LR_F)-(LR_R1-LR_R)>0&&(LR_F1-LR_F)-(LR_S1-LR_S)>0&&(LR_F1-LR_F)-(LR_T-LR_T1)>0&&(LR_F1-LR_F)-(LR_U-LR_U1)>0&&(LR_F1-LR_F)-(LR_W-LR_W1)>0&&(LR_F1-LR_F)-(LR_X-LR_X1)>0&&(LR_F1-LR_F)-(LR_Z-LR_Z1)>0&&(LR_F1-LR_F)-(LR_AB1-LR_AB)>0&&(LR_F1-LR_F)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中营业成本下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2834,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_O1-LR_O)-(LR_A-LR_A1)>0&&(LR_O1-LR_O)-(LR_F1-LR_F)>0&&(LR_O1-LR_O)-(LR_P1-LR_P)>0&&(LR_O1-LR_O)-(LR_Q1-LR_Q)>0&&(LR_O1-LR_O)-(LR_R1-LR_R)>0&&(LR_O1-LR_O)-(LR_S1-LR_S)>0&&(LR_O1-LR_O)-(LR_T-LR_T1)>0&&(LR_O1-LR_O)-(LR_U-LR_U1)>0&&(LR_O1-LR_O)-(LR_W-LR_W1)>0&&(LR_O1-LR_O)-(LR_X-LR_X1)>0&&(LR_O1-LR_O)-(LR_Z-LR_Z1)>0&&(LR_O1-LR_O)-(LR_AB1-LR_AB)>0&&(LR_O1-LR_O)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中税金及附加下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2835,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&&(LR_P1-LR_P)-(LR_F1-LR_F)>0&&(LR_P1-LR_P)-(LR_O1-LR_O)>0&&(LR_P1-LR_P)-(LR_Q1-LR_Q)>0&&(LR_P1-LR_P)-(LR_R1-LR_R)>0&&(LR_P1-LR_P)-(LR_S1-LR_S)>0&&(LR_P1-LR_P)-(LR_T-LR_T1)>0&&(LR_P1-LR_P)-(LR_U-LR_U1)>0&&(LR_P1-LR_P)-(LR_W-LR_W1)>0&&(LR_P1-LR_P)-(LR_X-LR_X1)>0&&(LR_P1-LR_P)-(LR_Z-LR_Z1)>0&&(LR_P1-LR_P)-(LR_AB1-LR_AB)>0&&(LR_P1-LR_P)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中销售费用下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2836,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&&(LR_Q1-LR_Q)-(LR_F1-LR_F)>0&&(LR_Q1-LR_Q)-(LR_O1-LR_O)>0&&(LR_Q1-LR_Q)-(LR_P1-LR_P)>0&&(LR_Q1-LR_Q)-(LR_R1-LR_R)>0&&(LR_Q1-LR_Q)-(LR_S1-LR_S)>0&&(LR_Q1-LR_Q)-(LR_T-LR_T1)>0&&(LR_Q1-LR_Q)-(LR_U-LR_U1)>0&&(LR_Q1-LR_Q)-(LR_W-LR_W1)>0&&(LR_Q1-LR_Q)-(LR_X-LR_X1)>0&&(LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&&(LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&&(LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中管理费用下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2837,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_R1-LR_R)-(LR_A-LR_A1)>0&&(LR_R1-LR_R)-(LR_F1-LR_F)>0&&(LR_R1-LR_R)-(LR_O1-LR_O)>0&&(LR_R1-LR_R)-(LR_P1-LR_P)>0&&(LR_R1-LR_R)-(LR_Q1-LR_Q)>0&&(LR_R1-LR_R)-(LR_S1-LR_S)>0&&(LR_R1-LR_R)-(LR_T-LR_T1)>0&&(LR_R1-LR_R)-(LR_U-LR_U1)>0&&(LR_R1-LR_R)-(LR_W-LR_W1)>0&&(LR_R1-LR_R)-(LR_X-LR_X1)>0&&(LR_R1-LR_R)-(LR_Z-LR_Z1)>0&&(LR_R1-LR_R)-(LR_AB1-LR_AB)>0&&(LR_R1-LR_R)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中财务费用下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2838,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_S1-LR_S)-(LR_A-LR_A1)>0&&(LR_S1-LR_S)-(LR_F1-LR_F)>0&&(LR_S1-LR_S)-(LR_O1-LR_O)>0&&(LR_S1-LR_S)-(LR_P1-LR_P)>0&&(LR_S1-LR_S)-(LR_Q1-LR_Q)>0&&(LR_S1-LR_S)-(LR_R1-LR_R)>0&&(LR_S1-LR_S)-(LR_T-LR_T1)>0&&(LR_S1-LR_S)-(LR_U-LR_U1)>0&&(LR_S1-LR_S)-(LR_W-LR_W1)>0&&(LR_S1-LR_S)-(LR_X-LR_X1)>0&&(LR_S1-LR_S)-(LR_Z-LR_Z1)>0&&(LR_S1-LR_S)-(LR_AB1-LR_AB)>0&&(LR_S1-LR_S)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中资产减值损失下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2839,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_T-LR_T1)-(LR_A-LR_A1)>0&&(LR_T-LR_T1)-(LR_F1-LR_F)>0&&(LR_T-LR_T1)-(LR_O1-LR_O)>0&&(LR_T-LR_T1)-(LR_P1-LR_P)>0&&(LR_T-LR_T1)-(LR_Q1-LR_Q)>0&&(LR_T-LR_T1)-(LR_R1-LR_R)>0&&(LR_T-LR_T1)-(LR_S1-LR_S)>0&&(LR_T-LR_T1)-(LR_U-LR_U1)>0&&(LR_T-LR_T1)-(LR_W-LR_W1)>0&&(LR_T-LR_T1)-(LR_X-LR_X1)>0&&(LR_T-LR_T1)-(LR_Z-LR_Z1)>0&&(LR_T-LR_T1)-(LR_AB1-LR_AB)>0&&(LR_T-LR_T1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中公允价值变动收益上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2840,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_U-LR_U1)-(LR_A-LR_A1)>0&&(LR_U-LR_U1)-(LR_F1-LR_F)>0&&(LR_U-LR_U1)-(LR_O1-LR_O)>0&&(LR_U-LR_U1)-(LR_P1-LR_P)>0&&(LR_U-LR_U1)-(LR_Q1-LR_Q)>0&&(LR_U-LR_U1)-(LR_R1-LR_R)>0&&(LR_U-LR_U1)-(LR_S1-LR_S)>0&&(LR_U-LR_U1)-(LR_T-LR_T1)>0&&(LR_U-LR_U1)-(LR_W-LR_W1)>0&&(LR_U-LR_U1)-(LR_X-LR_X1)>0&&(LR_U-LR_U1)-(LR_Z-LR_Z1)>0&&(LR_U-LR_U1)-(LR_AB1-LR_AB)>0&&(LR_U-LR_U1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中投资收益上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2841,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_W-LR_W1)-(LR_A-LR_A1)>0&&(LR_W-LR_W1)-(LR_F1-LR_F)>0&&(LR_W-LR_W1)-(LR_O1-LR_O)>0&&(LR_W-LR_W1)-(LR_P1-LR_P)>0&&(LR_W-LR_W1)-(LR_Q1-LR_Q)>0&&(LR_W-LR_W1)-(LR_R1-LR_R)>0&&(LR_W-LR_W1)-(LR_S1-LR_S)>0&&(LR_W-LR_W1)-(LR_T-LR_T1)>0&&(LR_W-LR_W1)-(LR_U-LR_U1)>0&&(LR_W-LR_W1)-(LR_X-LR_X1)>0&&(LR_W-LR_W1)-(LR_Z-LR_Z1)>0&&(LR_W-LR_W1)-(LR_AB1-LR_AB)>0&&(LR_W-LR_W1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中汇兑收益上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2842,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_X-LR_X1)-(LR_A-LR_A1)>0&&(LR_X-LR_X1)-(LR_F1-LR_F)>0&&(LR_X-LR_X1)-(LR_O1-LR_O)>0&&(LR_X-LR_X1)-(LR_P1-LR_P)>0&&(LR_X-LR_X1)-(LR_Q1-LR_Q)>0&&(LR_X-LR_X1)-(LR_R1-LR_R)>0&&(LR_X-LR_X1)-(LR_S1-LR_S)>0&&(LR_X-LR_X1)-(LR_T-LR_T1)>0&&(LR_X-LR_X1)-(LR_U-LR_U1)>0&&(LR_X-LR_X1)-(LR_W-LR_W1)>0&&(LR_X-LR_X1)-(LR_Z-LR_Z1)>0&&(LR_X-LR_X1)-(LR_AB1-LR_AB)>0&&(LR_X-LR_X1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中其他收益上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2843,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_Z-LR_Z1)-(LR_A-LR_A1)>0&&(LR_Z-LR_Z1)-(LR_F1-LR_F)>0&&(LR_Z-LR_Z1)-(LR_O1-LR_O)>0&&(LR_Z-LR_Z1)-(LR_P1-LR_P)>0&&(LR_Z-LR_Z1)-(LR_Q1-LR_Q)>0&&(LR_Z-LR_Z1)-(LR_R1-LR_R)>0&&(LR_Z-LR_Z1)-(LR_S1-LR_S)>0&&(LR_Z-LR_Z1)-(LR_T-LR_T1)>0&&(LR_Z-LR_Z1)-(LR_U-LR_U1)>0&&(LR_Z-LR_Z1)-(LR_W-LR_W1)>0&&(LR_Z-LR_Z1)-(LR_X-LR_X1)>0&&(LR_Z-LR_Z1)-(LR_AB1-LR_AB)>0&&(LR_Z-LR_Z1)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中营业外收入上涨较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2844,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_AB1-LR_AB)-(LR_A-LR_A1)>0&&(LR_AB1-LR_AB)-(LR_F1-LR_F)>0&&(LR_AB1-LR_AB)-(LR_O1-LR_O)>0&&(LR_AB1-LR_AB)-(LR_P1-LR_P)>0&&(LR_AB1-LR_AB)-(LR_Q1-LR_Q)>0&&(LR_AB1-LR_AB)-(LR_R1-LR_R)>0&&(LR_AB1-LR_AB)-(LR_S1-LR_S)>0&&(LR_AB1-LR_AB)-(LR_T-LR_T1)>0&&(LR_AB1-LR_AB)-(LR_U-LR_U1)>0&&(LR_AB1-LR_AB)-(LR_W-LR_W1)>0&&(LR_AB1-LR_AB)-(LR_X-LR_X1)>0&&(LR_AB1-LR_AB)-(LR_Z-LR_Z1)>0&&(LR_AB1-LR_AB)-(LR_AE1-LR_AE)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中营业外支出下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2845,'2','企业经营报告净利润','LR_AF!=0&&LR_AF-LR_AF1>0&&(LR_AE1-LR_AE)-(LR_A-LR_A1)>0&&(LR_AE1-LR_AE)-(LR_F1-LR_F)>0&&(LR_AE1-LR_AE)-(LR_O1-LR_O)>0&&(LR_AE1-LR_AE)-(LR_P1-LR_P)>0&&(LR_AE1-LR_AE)-(LR_Q1-LR_Q)>0&&(LR_AE1-LR_AE)-(LR_R1-LR_R)>0&&(LR_AE1-LR_AE)-(LR_S1-LR_S)>0&&(LR_AE1-LR_AE)-(LR_T-LR_T1)>0&&(LR_AE1-LR_AE)-(LR_U-LR_U1)>0&&(LR_AE1-LR_AE)-(LR_W-LR_W1)>0&&(LR_AE1-LR_AE)-(LR_X-LR_X1)>0&&(LR_AE1-LR_AE)-(LR_Z-LR_Z1)>0&&(LR_AE1-LR_AE)-(LR_AB1-LR_AB)>0','本期净利润比上期有所增长，增长金额为Rmb{(LR_AF-LR_AF1)/10000}万元，其中所得税下降较为厉害，成为利润增加的主导因素。建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF-LR_AF1)/10000}','','G20030','',0),
(2846,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&&(LR_A1-LR_A)-(LR_O-LR_O1)>0&&(LR_A1-LR_A)-(LR_P-LR_P1)>0&&(LR_A1-LR_A)-(LR_Q-LR_Q1)>0&&(LR_A1-LR_A)-(LR_R-LR_R1)>0&&(LR_A1-LR_A)-(LR_S-LR_S1)>0&&(LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&&(LR_A1-LR_A)-(LR_W1-LR_W)>0&&(LR_A1-LR_A)-(LR_X1-LR_X)>0&&(LR_A1-LR_A)-(LR_Z1-LR_Z)>0&&(LR_A1-LR_A)-(LR_AB-LR_AB1)>0&&(LR_A1-LR_A)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为营业收入的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2847,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&(LR_F-LR_F1)-(LR_W1-LR_W)>0&&(LR_F-LR_F1)-(LR_X1-LR_X)>0&&(LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&(LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&(LR_F-LR_F1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为营业成本的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2848,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_O-LR_O1)-(LR_A1-LR_A)>0&&(LR_O-LR_O1)-(LR_F-LR_F1)>0&&(LR_O-LR_O1)-(LR_P-LR_P1)>0&&(LR_O-LR_O1)-(LR_Q-LR_Q1)>0&&(LR_O-LR_O1)-(LR_R-LR_R1)>0&&(LR_O-LR_O1)-(LR_S-LR_S1)>0&&(LR_O-LR_O1)-(LR_T1-LR_T)>0&&(LR_O-LR_O1)-(LR_U1-LR_U)>0&&(LR_O-LR_O1)-(LR_W1-LR_W)>0&&(LR_O-LR_O1)-(LR_X1-LR_X)>0&&(LR_O-LR_O1)-(LR_Z1-LR_Z)>0&&(LR_O-LR_O1)-(LR_AB-LR_AB1)>0&&(LR_O-LR_O1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为税金及附加的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2849,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&(LR_P-LR_P1)-(LR_F-LR_F1)>0&&(LR_P-LR_P1)-(LR_O-LR_O1)>0&&(LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&(LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&(LR_P-LR_P1)-(LR_W1-LR_W)>0&&(LR_P-LR_P1)-(LR_X1-LR_X)>0&&(LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&(LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&(LR_P-LR_P1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为销售费用的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2850,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&&(LR_Q-LR_Q1)-(LR_F-LR_F1)>0&&(LR_Q-LR_Q1)-(LR_O-LR_O1)>0&&(LR_Q-LR_Q1)-(LR_P-LR_P1)>0&&(LR_Q-LR_Q1)-(LR_R-LR_R1)>0&&(LR_Q-LR_Q1)-(LR_S-LR_S1)>0&&(LR_Q-LR_Q1)-(LR_T1-LR_T)>0&&(LR_Q-LR_Q1)-(LR_U1-LR_U)>0&&(LR_Q-LR_Q1)-(LR_W1-LR_W)>0&&(LR_Q-LR_Q1)-(LR_X1-LR_X)>0&&(LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&&(LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&&(LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为管理费用的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2851,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_R-LR_R1)-(LR_A1-LR_A)>0&&(LR_R-LR_R1)-(LR_F-LR_F1)>0&&(LR_R-LR_R1)-(LR_O-LR_O1)>0&&(LR_R-LR_R1)-(LR_P-LR_P1)>0&&(LR_R-LR_R1)-(LR_Q-LR_Q1)>0&&(LR_R-LR_R1)-(LR_S-LR_S1)>0&&(LR_R-LR_R1)-(LR_T1-LR_T)>0&&(LR_R-LR_R1)-(LR_U1-LR_U)>0&&(LR_R-LR_R1)-(LR_W1-LR_W)>0&&(LR_R-LR_R1)-(LR_X1-LR_X)>0&&(LR_R-LR_R1)-(LR_Z1-LR_Z)>0&&(LR_R-LR_R1)-(LR_AB-LR_AB1)>0&&(LR_R-LR_R1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为财务费用的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2852,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_S-LR_S1)-(LR_A1-LR_A)>0&&(LR_S-LR_S1)-(LR_F-LR_F1)>0&&(LR_S-LR_S1)-(LR_O-LR_O1)>0&&(LR_S-LR_S1)-(LR_P-LR_P1)>0&&(LR_S-LR_S1)-(LR_Q-LR_Q1)>0&&(LR_S-LR_S1)-(LR_R-LR_R1)>0&&(LR_S-LR_S1)-(LR_T1-LR_T)>0&&(LR_S-LR_S1)-(LR_U1-LR_U)>0&&(LR_S-LR_S1)-(LR_W1-LR_W)>0&&(LR_S-LR_S1)-(LR_X1-LR_X)>0&&(LR_S-LR_S1)-(LR_Z1-LR_Z)>0&&(LR_S-LR_S1)-(LR_AB-LR_AB1)>0&&(LR_S-LR_S1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为资产减值损失的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2853,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_T1-LR_T)-(LR_A1-LR_A)>0&&(LR_T1-LR_T)-(LR_F-LR_F1)>0&&(LR_T1-LR_T)-(LR_O-LR_O1)>0&&(LR_T1-LR_T)-(LR_P-LR_P1)>0&&(LR_T1-LR_T)-(LR_Q-LR_Q1)>0&&(LR_T1-LR_T)-(LR_R-LR_R1)>0&&(LR_T1-LR_T)-(LR_S-LR_S1)>0&&(LR_T1-LR_T)-(LR_U1-LR_U)>0&&(LR_T1-LR_T)-(LR_W1-LR_W)>0&&(LR_T1-LR_T)-(LR_X1-LR_X)>0&&(LR_T1-LR_T)-(LR_Z1-LR_Z)>0&&(LR_T1-LR_T)-(LR_AB-LR_AB1)>0&&(LR_T1-LR_T)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为公允价值变动收益的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2854,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_U1-LR_U)-(LR_A1-LR_A)>0&&(LR_U1-LR_U)-(LR_F-LR_F1)>0&&(LR_U1-LR_U)-(LR_O-LR_O1)>0&&(LR_U1-LR_U)-(LR_P-LR_P1)>0&&(LR_U1-LR_U)-(LR_Q-LR_Q1)>0&&(LR_U1-LR_U)-(LR_R-LR_R1)>0&&(LR_U1-LR_U)-(LR_S-LR_S1)>0&&(LR_U1-LR_U)-(LR_T1-LR_T)>0&&(LR_U1-LR_U)-(LR_W1-LR_W)>0&&(LR_U1-LR_U)-(LR_X1-LR_X)>0&&(LR_U1-LR_U)-(LR_Z1-LR_Z)>0&&(LR_U1-LR_U)-(LR_AB-LR_AB1)>0&&(LR_U1-LR_U)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为投资收益的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2855,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_W1-LR_W)-(LR_A1-LR_A)>0&&(LR_W1-LR_W)-(LR_F-LR_F1)>0&&(LR_W1-LR_W)-(LR_O-LR_O1)>0&&(LR_W1-LR_W)-(LR_P-LR_P1)>0&&(LR_W1-LR_W)-(LR_Q-LR_Q1)>0&&(LR_W1-LR_W)-(LR_R-LR_R1)>0&&(LR_W1-LR_W)-(LR_S-LR_S1)>0&&(LR_W1-LR_W)-(LR_T1-LR_T)>0&&(LR_W1-LR_W)-(LR_U1-LR_U)>0&&(LR_W1-LR_W)-(LR_X1-LR_X)>0&&(LR_W1-LR_W)-(LR_Z1-LR_Z)>0&&(LR_W1-LR_W)-(LR_AB-LR_AB1)>0&&(LR_W1-LR_W)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为汇兑收益的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2856,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_X1-LR_X)-(LR_A1-LR_A)>0&&(LR_X1-LR_X)-(LR_F-LR_F1)>0&&(LR_X1-LR_X)-(LR_O-LR_O1)>0&&(LR_X1-LR_X)-(LR_P-LR_P1)>0&&(LR_X1-LR_X)-(LR_Q-LR_Q1)>0&&(LR_X1-LR_X)-(LR_R-LR_R1)>0&&(LR_X1-LR_X)-(LR_S-LR_S1)>0&&(LR_X1-LR_X)-(LR_T1-LR_T)>0&&(LR_X1-LR_X)-(LR_U1-LR_U)>0&&(LR_X1-LR_X)-(LR_W1-LR_W)>0&&(LR_X1-LR_X)-(LR_Z1-LR_Z)>0&&(LR_X1-LR_X)-(LR_AB-LR_AB1)>0&&(LR_X1-LR_X)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为其他收益的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2857,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_Z1-LR_Z)-(LR_A1-LR_A)>0&&(LR_Z1-LR_Z)-(LR_F-LR_F1)>0&&(LR_Z1-LR_Z)-(LR_O-LR_O1)>0&&(LR_Z1-LR_Z)-(LR_P-LR_P1)>0&&(LR_Z1-LR_Z)-(LR_Q-LR_Q1)>0&&(LR_Z1-LR_Z)-(LR_R-LR_R1)>0&&(LR_Z1-LR_Z)-(LR_S-LR_S1)>0&&(LR_Z1-LR_Z)-(LR_T1-LR_T)>0&&(LR_Z1-LR_Z)-(LR_U1-LR_U)>0&&(LR_Z1-LR_Z)-(LR_W1-LR_W)>0&&(LR_Z1-LR_Z)-(LR_X1-LR_X)>0&&(LR_Z1-LR_Z)-(LR_AB-LR_AB1)>0&&(LR_Z1-LR_Z)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为营业外收入的减少，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2858,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_AB-LR_AB1)-(LR_A1-LR_A)>0&&(LR_AB-LR_AB1)-(LR_F-LR_F1)>0&&(LR_AB-LR_AB1)-(LR_O-LR_O1)>0&&(LR_AB-LR_AB1)-(LR_P-LR_P1)>0&&(LR_AB-LR_AB1)-(LR_Q-LR_Q1)>0&&(LR_AB-LR_AB1)-(LR_R-LR_R1)>0&&(LR_AB-LR_AB1)-(LR_S-LR_S1)>0&&(LR_AB-LR_AB1)-(LR_T1-LR_T)>0&&(LR_AB-LR_AB1)-(LR_U1-LR_U)>0&&(LR_AB-LR_AB1)-(LR_W1-LR_W)>0&&(LR_AB-LR_AB1)-(LR_X1-LR_X)>0&&(LR_AB-LR_AB1)-(LR_Z1-LR_Z)>0&&(LR_AB-LR_AB1)-(LR_AE-LR_AE1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为营业外支出的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2859,'2','企业经营报告净利润','LR_AF!=0&&LR_AF1-LR_AF>0&&(LR_AE-LR_AE1)-(LR_A1-LR_A)>0&&(LR_AE-LR_AE1)-(LR_F-LR_F1)>0&&(LR_AE-LR_AE1)-(LR_O-LR_O1)>0&&(LR_AE-LR_AE1)-(LR_P-LR_P1)>0&&(LR_AE-LR_AE1)-(LR_Q-LR_Q1)>0&&(LR_AE-LR_AE1)-(LR_R-LR_R1)>0&&(LR_AE-LR_AE1)-(LR_S-LR_S1)>0&&(LR_AE-LR_AE1)-(LR_T1-LR_T)>0&&(LR_AE-LR_AE1)-(LR_U1-LR_U)>0&&(LR_AE-LR_AE1)-(LR_W1-LR_W)>0&&(LR_AE-LR_AE1)-(LR_X1-LR_X)>0&&(LR_AE-LR_AE1)-(LR_Z1-LR_Z)>0&&(LR_AE-LR_AE1)-(LR_AB-LR_AB1)>0','本期净利润比上期有所下降，减少金额达Rmb{(LR_AF1-LR_AF)/10000}万元。净利润下降主要是因为所得税费用的增加，建议到分析模块查看具体科目变动原因及相关预警。','{(LR_AF1-LR_AF)/10000}','','G20030','',0),
(2860,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_A-LR_A1)/LR_A1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为营业收入，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2861,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_F-LR_F1)/LR_F1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为营业成本，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2862,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_O-LR_O1)/LR_O1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为税金及附加，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2863,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_P-LR_P1)/LR_P1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为销售费用，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2864,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_Q-LR_Q1)/LR_Q1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为管理费用，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2865,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_R-LR_R1)/LR_R1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为财务费用，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2866,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_S-LR_S1)/LR_S1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为资产减值损失，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2867,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_T-LR_T1)/LR_T1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为公允价值变动收益，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2868,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_U-LR_U1)/LR_U1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为投资收益，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2869,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_W-LR_W1)/LR_W1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为汇兑收益，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2870,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_X-LR_X1)/LR_X1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为其他收益，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2871,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0&&Math.abs((LR_Z-LR_Z1)/LR_Z1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为营业外收入，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2872,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_AB-LR_AB1)/LR_AB1)-Math.abs((LR_AE-LR_AE1)/LR_AE1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为营业外支出，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2873,'2','企业经营报告净利润','LR_AF1!=0&&LR_AF-LR_AF1==0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_A-LR_A1)/LR_A1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_F-LR_F1)/LR_F1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_O-LR_O1)/LR_O1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_P-LR_P1)/LR_P1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_Q-LR_Q1)/LR_Q1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_R-LR_R1)/LR_R1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_S-LR_S1)/LR_S1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_T-LR_T1)/LR_T1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_U-LR_U1)/LR_U1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_W-LR_W1)/LR_W1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_X-LR_X1)/LR_X1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_Z-LR_Z1)/LR_Z1)>0&&Math.abs((LR_AE-LR_AE1)/LR_AE1)-Math.abs((LR_AB-LR_AB1)/LR_AB1)>0','本期净利润与上期一致，此情况较为特殊。其中，两期相比波动最大的为所得税费用，建议进入相应科目分析，查看异常变动原因及存在的问题。','','','G20030','',0),
(2874,'2','企业经营报告净利润','LR_AF==0','净利润为0，企业处于收支临界点你，此时现金流状况尤为关键，直接影响是否会出现因资金链断裂而导致企业无法持续经营的情况，企业需结合现金流分析情况，考虑是否需要进行新一轮债权或股权融资。','','','G20030','',0),
(2876,'2','企业经营报告营业收入','LR_A1!=0&&LR_A!=0&&LR_A1-LR_A>0&&LR_A1/XSSL_A1-LR_A/XSSL_A>0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','本期营业收入存在以下问题：销售单价较同期比有所下滑，是收入下降的主导因素。','','','G20030','',0),
(2877,'2','企业经营报告营业收入','LR_A1!=0&&LR_A!=0&&LR_A1-LR_A>0&&XSSL_A1-XSSL_A>0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','本期营业收入存在以下问题：销售数量较同期比有所下滑，是收入下降的主导因素。','','','G20030','',0),
(2878,'2','企业经营报告营业收入','LR_A1!=0&&LR_A!=0&&LR_A1-LR_A<0&&LR_A1/XSSL_A1-LR_A/XSSL_A<0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','本期营业收入存在以下问题：本期营业收入较同期比有所上涨，销售单价的上升是主导因素，需提防单价上涨导致的收入上升的可持续性。','','','G20030','',0),
(2879,'2','企业经营报告营业收入','LR_A1!=0&&LR_A!=0&&LR_A/XSSL_A-LR_A1/XSSL_A1<0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','本期营业收入存在以下问题：本期营业收入较同期比有所上涨，销售数量的上升是主导因素，同时销售单价同比有所下滑，因此需考虑降价攻占市场的方式是否具有可持续性，根据市场反馈情况调整库存结构及销售策略。','','','G20030','',0),
(2880,'2','企业经营报告营业收入','LR_A1!=0&&LR_A!=0&&LR_A/XSSL_A-LR_A1/XSSL_A1>0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','本期营业收入存在以下问题：本期营业收入较同期比有所上涨，销售数量的上升是主导因素，同时销售单价较同期比亦有所上升，需考虑单价上涨对拉升营业收入的可持续性。应以增加销售数量，占领市场为主要增收措施。','','','G20030','',0),
(2881,'2','企业经营报告营业收入','LR_A==0','本期营业收入存在以下问题：本期营业收入为0，企业未能产生任何收入，如为筹建期或市场开拓期，需考虑控制费用支出，可参考分析模块中成本及费用构成分析，考虑如何节省成本及开支。','','','G20030','',0),
(2883,'2','企业经营报告营业成本','LR_F1!=0&&LR_F-LR_F1>0&&(LR_F/XSSL_A)/(LR_F1/XSSL_A1)-XSSL_A/XSSL_A1>0','本期营业收入存在以下问题：单位成本较同期比有所上涨，是营业成本上涨的主导因素。','','','G20030','',0),
(2884,'2','企业经营报告营业成本','LR_F1!=0&&LR_F-LR_F1>0&&(LR_F/XSSL_A)/(LR_F1/XSSL_A1)-XSSL_A/XSSL_A1>0&&LR_F/XSSL_A-LR_F1/XSSL_A1==0','本期营业收入存在以下问题：单位成本不变，但销售数量较同期比有所下降，固定成本开支不变，是导致成本上涨的主导因素。','','','G20030','',0),
(2885,'2','企业经营报告营业成本','LR_F1-LR_F>0&&(LR_F/XSSL_A)/(LR_F1/XSSL_A1)-XSSL_A/XSSL_A1<0','本期营业收入存在以下问题：营业成本有所下降，销售数量的下降为主导因素，注意市场占有率持续下降，管理层需就销售策略进行调整。','','','G20030','',0),
(2886,'2','企业经营报告营业成本','LR_F1-LR_F>0&&(LR_F/XSSL_A)/(LR_F1/XSSL_A1)-XSSL_A/XSSL_A1>0&&XSSL_A1-XSSL_A>0','本期营业收入存在以下问题：营业成本有所下降，单位成本的下降为主导因素。同时，销售数量的下降亦对营业成本下降造成一定影响，管理层在维持压缩成本的情况下，需同时注意市场开拓的重要性，考虑降价促销、开拓新市场等方式减少市场占有率的流失。','','','G20030','',0),
(2887,'2','企业经营报告营业成本','LR_F==0','本期营业收入存在以下问题：本期营业成本为0，无法进行数据分析。如因企业仍在产品研发或市场推广期，未产生任何营业收入及相应结转营业成本，则需考虑加快市场开拓力度，建议聘请专业销售团队进行销售策划。如为数据缺失，建议管理层补充完整数据以便进行相应分析。','','','G20030','',0),
(2888,'3','企业经营报告现金流量表','XJLL_BB>0','本期现金流较好，现金及现金等价物净增加额为正数，主要是因为','',NULL,'G30002',NULL,0),
(2889,'3','企业经营报告现金流量表','XJLL_BB>0&&XJLL_N-XJLL_AF>0&&XJLL_N-XJLL_AT>0','经营活动产生的现金流量净额的增长所引起，现金流较为健康。','','','G30002','',0),
(2890,'3','企业经营报告现金流量表','XJLL_BB>0&&XJLL_AM-XJLL_Y>0&&XJLL_AM-XJLL_AZ>0','投资活动产生的现金流量净额的增长所引起。主要现金流非主营业务产生，需警惕。投资者及银行在查看现金流量表时，重点关注现金流的产生是否健康，即是否由经营活动产生的现金流为主导，因此，现金流量表反应的该种情况，可能对未来引入投资者或者进行银行贷款产生一定的影响。','',NULL,'G30002',NULL,0),
(2891,'3','企业经营报告现金流量表','XJLL_BB>0&&XJLL_AZ-XJLL_Y>0&&XJLL_AZ-XJLL_AM>0','筹资活动产生的现金流量净额的增长所引起。单纯考虑企业因经营活动产生的现金流，实际为负数，说明企业实际生产运营存在问题，管理层需高度重视，充分利用本次融资或贷款流入的资金，盘活企业。','',NULL,'G30002',NULL,0),
(2892,'3','企业经营报告现金流量表','XJLL_BB<0','本期现金流存在较大问题，现金及现金等价物净增加额为负数，主要是因为','',NULL,'G30002',NULL,0),
(2893,'3','企业经营报告现金流量表','XJLL_BB<0&&XJLL_X-XJLL_AL>0&&XJLL_X-XJLL_AY>0','与经营活动相关的现金大量流出所引起。需考虑进行股权或债权融资，减轻现金流负担，避免出现资金链断裂的可能。同时，管理层需查看本期大量支付经营活动所需款项的原因，同时改善销售回款，尽量缩小目前经营活动现金流入与流出的较大差异。','','','G30002','',0),
(2894,'3','企业经营报告现金流量表','XJLL_BB<0&&XJLL_AL-XJLL_X>0&&XJLL_AL-XJLL_AY>0','大量与投资活动相关的现金流出所引起。需进行企业未来现金流状况预测，考虑投资对未来现金流的影响程度，从而判断是否需要进一步进行贷款或股权融资以缓解大额投资对现金流产生的巨大压力。','','','G30002','',0),
(2895,'3','企业经营报告现金流量表','XJLL_BB<0&&XJLL_AY-XJLL_AL>0&&XJLL_AY-XJLL_X>0','大量与筹资活动相关的现金流出所引起。需考虑该情况的出现是因短期归还贷款引起亦或会有长期影响，考虑续借或者再融资的可能性，以减轻大量归还贷款对现金流产生的影响。','','','G30002','',0),
(2896,'3','企业经营报告现金流量表','XJLL_BB==0','本期现金及现金等价物净增加额为0，说明企业现金流处于临界点，管理层需高度关注，避免出现资金链断裂的情况。建议管理层结合分析模块中货币资金的现金流预测图，评估未来6个月内现金流情况，并进行相应的融资规划。',NULL,NULL,'G30002',NULL,0),
(2898,'1','企业经营报告资产负债表','ZCFZ_G!=0','1、应收账款：本期前五大应收款客户占总应收的{YSQWD_C/ZCFZ_G*100}%，占比较高，需提防失去其中某一客户对生产经营所产生的较大影响。','{YSQWD_C/ZCFZ_G*100}','','G10045','',0),
(2899,'1','企业经营报告资产负债表','ZCFZ_G!=0&&YSZKZL_D+YSZKZL_E+YSZKZL_F>0','1、应收账款：本期应收账款账龄超1年的款项余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元，占应收账款余额的{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/ZCFZ_G*100}%。建议分析收回可能性，并尽力进行催收，以保障企业利益。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000},{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/ZCFZ_G*100}','','G10045','',0),
(2900,'1','企业经营报告资产负债表','ZCFZ_G!=0&&YBLFX_L-90>0','1、应收账款：应收账款周转期超过90天，收款较慢，需警惕收款期长对企业现金流的影响，避免出现因资金紧张导致企业运转困难的情况。','','','G10045','',0),
(2901,'1','企业经营报告资产负债表','ZCFZ_G==0','1、应收账款：本期应收账款为0，此情况较为特殊，建议管理层在确保数字无误及非数据缺失导致应收账款数据为0的情况下，结合现金流情况分析，在现金流状况良好及允许的情况下，可适当加大应收账款周转开拓及占据。','',NULL,'G10045',NULL,0),
(2903,'1','企业经营报告资产负债表','ZCFZ_AV!=0','2、应付账款：本期前五大应付供应商占总应付款项的{YFQWD_S/ZCFZ_AV*100}%，占比较高，需提放供应商过度集中对企业生产经营的影响。一旦上游主要供应商出现问题，则可能连带影响企业的生产经营，建议分散采购，减少供应商过度集中的情况。','{YFQWD_S/ZCFZ_AV*100}',NULL,'G10045',NULL,0),
(2904,'1','企业经营报告资产负债表','ZCFZ_AV!=0&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','2、应付账款：本期应付账款账龄超1年的款项余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}万元，占应付账款余额的{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/ZCFZ_AV*100}%。建议查看相关合同条款，评估是否存在付款违约等法律风险。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000},{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/ZCFZ_AV*100}',NULL,'G10045',NULL,0),
(2905,'1','企业经营报告资产负债表','ZCFZ_AV!=0&&YBLFX_O-60<0&&YBLFX_L-90<=0','2、应付账款：应付账款周转期短于60天，企业支付供应商款项速度较快，可考虑与供应商洽谈延长付款期，优化企业现金流。','',NULL,'G10045',NULL,0),
(2906,'1','企业经营报告资产负债表','ZCFZ_AV!=0&&YBLFX_O-60<0&&YBLFX_L-90>0','2、应付账款：应付账款周转期短于60天，且应收账款周转期超过90天，可能导致企业资金周转困难，应加大应收款催收力度，同时与供应商洽谈付款期的延长，或者利用票据进行短期融资，优化现金流。','',NULL,'G10045',NULL,0),
(2907,'1','企业经营报告资产负债表','ZCFZ_AV==0','2、应付账款：本期应付账款为0，此情况较为特殊，建议管理层在确保数据无误及非数据缺失的情况下，与供应商谈判，适当延长付款周期，以使现金流状况更为健康。','',NULL,'G10045',NULL,0),
(2909,'1','企业经营报告资产负债表','ZCFZ_P!=0&&RM_D+RM_E+RM_F>0','3、存货：原材料中库龄超1年的原材料金额为Rmb{(RM_D+RM_E+RM_F)/10000}万元，占原材料总库存的{(RM_D+RM_E+RM_F)/YCLKC_B*100}%，建议管理层查看该部分材料是否仍可用于生产，如否，则需考虑将其进行处理。','{(RM_D+RM_E+RM_F)/10000},{(RM_D+RM_E+RM_F)/ZCFZ_P*100}',NULL,'G10045',NULL,0),
(2910,'1','企业经营报告资产负债表','ZCFZ_P!=0&&CHKL_D+CHKL_E+CHKL_F>0','3、存货：产成品中库龄超1年的产成品金额为Rmb{(FG_D+FG_E+FG_F)/10000}万元，占产成品总库存的{(FG_D+FG_E+FG_F)/CCPKC_B*100}%，建议管理层查看该部分产成品是否有销售的可能性，如产品具有时效性、季节性或已过时，需进行进行降价销售处理。','{(FG_D+FG_E+FG_F)/10000},{(FG_D+FG_E+FG_F)/CCPKC_B*100}',NULL,'G10045',NULL,0),
(2911,'1','企业经营报告资产负债表','ZCFZ_P==0','3、存货：本期存货金额为0，此情况较为特殊，建议管理层在确保数字无误或非数据缺失的情况下，结合生产所需，适当储备生产用材料。同时，结合分析模块中的单价分析结果，针对部分有季节性或预测未来期间有涨价可能的生产所需原材料，进行适当调整储备，以达到降低成本，规避经营风险的目的。','',NULL,'G10045',NULL,0),
(3411,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_A-ZCFZ_A1>0&&  (ZCFZ_A-ZCFZ_A1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_A-ZCFZ_A1)-(ZCFZ_AL-ZCFZ_AL1)>0','待添加','',NULL,'G100001',NULL,0),
(3412,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_D-ZCFZ_D1>0&&  (ZCFZ_D-ZCFZ_D1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_D-ZCFZ_D1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于以公允价值计量且其变动计入当期损益的金融资产核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的增加提请管理层关注进行该资产交易的原因以及其增减值情况，注重风险控制。','',NULL,'G100001',NULL,0),
(3413,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_E-ZCFZ_E1>0&&   (ZCFZ_E-ZCFZ_E1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_E-ZCFZ_E1)-(ZCFZ_AL-ZCFZ_AL1)>0','无预警。','',NULL,'G100001',NULL,0),
(3414,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_F-ZCFZ_F1>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_F-ZCFZ_F1)-(ZCFZ_AL-ZCFZ_AL1)>0','企业应根据汇票的种类及规定及时行使提示承兑、提示付款等权利。否则，汇票未按照规定期限提示承兑的，持票人丧失对其前手的追索权；持票人超过提示付款期限提示付款的，持票人开户银行不予受理，此时企业需通过其他方式或途径追偿其应收款项。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3415,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_L>90&& YSZKZL_D+YSZKZL_E+YSZKZL_F>0','本期总资产较上期有所增加，主要是因为应收账款的增加。应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3416,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_L>90&& YSZKZL_D+YSZKZL_E+YSZKZL_F==0','本期总资产较上期有所增加，主要是因为应收账款的增加。应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生.应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，产生坏账损失的可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。','',NULL,'G100001',NULL,0),
(3417,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_L<=90&& YSZKZL_D+YSZKZL_E+YSZKZL_F>0','本期总资产较上期有所增加，主要是因为应收账款的增加。应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。在应收账款中，账龄超过360日的应收账款余额为Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3418,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_G-ZCFZ_G1>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_G-ZCFZ_G1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_L<=90&& YSZKZL_D+YSZKZL_E+YSZKZL_F==0','本期总资产较上期有所增加，主要是因为应收账款的增加。应收账款期末较上年同期有所上涨，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。','',NULL,'G100001',NULL,0),
(3419,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_H-ZCFZ_H1>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AL-ZCFZ_AL1)>0&& YFKXZL_D+YFKXZL_E+YFKXZL_F>0','本期总资产较上期有所增长，主要是因为预付账款的增加。预付款项在期末较上年同期有所增加，建议管理层查看增加情况，考虑是否属于年底正常业务增长需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。本期账龄超过360日的预付款项金额为Rmb{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}万元，建议管理层查看预付账款的账龄分析，对账龄超过1年的预付账款确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}',NULL,'G100001',NULL,0),
(3420,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_H-ZCFZ_H1>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_H-ZCFZ_H1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YFKXZL_D+YFKXZL_E+YFKXZL_F==0','本期总资产较上期有所增长，主要是因为预付账款的增加。预付款项在期末较上年同期有所增加，建议管理层查看增加情况，考虑是否属于年底正常业务增长需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付比例。','',NULL,'G100001',NULL,0),
(3421,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_L-ZCFZ_L1>0&&  (ZCFZ_L-ZCFZ_L1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_L-ZCFZ_L1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于应收利息为购买债券的到期应收未收利息，因此，针对应收利息的增加，建议管理层需结合货币资金中的资金预警考虑，是否存在过度投资，导致现金不足的情况。建议针对债券进行专人专管，检查是否按要求设立备查薄，方便管理。同时，建议管理层使用本系统的在线咨询模块中的顾问咨询，由专业顾问提供针对性分析及建议。','',NULL,'G100001',NULL,0),
(3422,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_M-ZCFZ_M1>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_M-ZCFZ_M1)-(ZCFZ_AL-ZCFZ_AL1)>0','应收股利增加，建议结合长期股权投资、可供出售金融资产等科目情况，关注是否与股权投资收益情况相符，同时需关注后期股利资金发放。','',NULL,'G100001',NULL,0),
(3423,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_N-ZCFZ_N1>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AL-ZCFZ_AL1)>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F>0','本期总资产较上期有所增长，主要是因为其他应收款的增加。其他应收款在期末较上年同期有所增加，此现象较为异常，考虑是否因股东间拆借或他方违约引起。建议管理层查看其他应收款明细及相应信息。其他应收款期末的异常变动为年度审计、IPO审计、银行贷款的重点关注情况，建议管理层高度重视。其他应收款中有Rmb{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}万元账龄已超360日，对账龄超过1年的其他应收款需引起管理层的重视，建议管理层查看该部分较长账龄的其他应收款是否属于关联交易，并确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}',NULL,'G100001',NULL,0),
(3424,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_N-ZCFZ_N1>0&&(ZCFZ_N-ZCFZ_N1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_N-ZCFZ_N1)-(ZCFZ_AL-ZCFZ_AL1)>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F==0','本期总资产较上期有所增长，主要是因为其他应收款的增加。其他应收款在期末较上年同期有所增加，此现象较为异常，考虑是否因股东间拆借或他方违约引起。建议管理层查看其他应收款明细及相应信息。其他应收款期末的异常变动为年度审计、IPO审计、银行贷款的重点关注情况，建议管理层高度重视。','',NULL,'G100001',NULL,0),
(3425,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_N>60&& CHKL_D+CHKL_E+CHKL_F>0','本期总资产较上期有所增加，主要是因为存货的增加。本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。库龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'G100001',NULL,0),
(3426,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_N>60&&  CHKL_D+CHKL_E+CHKL_F==0','本期总资产较上期有所增加，主要是因为存货的增加。本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。','',NULL,'G100001',NULL,0),
(3427,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F>0','本期总资产较上期有所增加，主要是因为存货的增加。本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。库龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'G100001',NULL,0),
(3428,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_P-ZCFZ_P1>0&&(ZCFZ_P-ZCFZ_P1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_P-ZCFZ_P1)-(ZCFZ_AL-ZCFZ_AL1)>0&&YBLFX_N<=60&& CHKL_D+CHKL_E+CHKL_F==0','本期总资产较上期有所增加，主要是因为存货的增加。本期末存货有所增加，考虑是否存在存货积压情况。建议管理层扩大销售渠道，增大销售额，同时合理安排原材料的采购时间和生产计划时间，通过设立安全库存等方式，尽量做到库存不积压，优化现金流管理。','',NULL,'G100001',NULL,0),
(3429,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Q-ZCFZ_Q1>0&&(ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Q-ZCFZ_Q1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于持有待售资产较为特殊，且此类资产为非经营类资产，因此期末值的增加提请管理层关注进行该资产交易的原因以及其增减值情况，注重风险控制。','',NULL,'G100001',NULL,0),
(3430,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&& ZCFZ_R-ZCFZ_R1>0&&(ZCFZ_R-ZCFZ_R1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_R-ZCFZ_R1)-(ZCFZ_AL-ZCFZ_AL1)>0','一年内到期的非流动资产增加，仍需持续关注该资产的回收可能性。此外，管理层需结合资金情况及资金预警，做好未来的资金投资规划，避免资金闲置或紧张情况的出现。','',NULL,'G100001',NULL,0),
(3431,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_S-ZCFZ_S1>0&&(ZCFZ_S-ZCFZ_S1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_S-ZCFZ_S1)-(ZCFZ_AL-ZCFZ_AL1)>0','其他流动资产在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3432,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_V-ZCFZ_V1>0&&(ZCFZ_V-ZCFZ_V1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_V-ZCFZ_V1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于可供出售金融资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上年同期有所增加，需查找原因并关注已实现的增值额，同时需注意核算时点、计量金额是否符合会计准则要求。且需警惕因期末可供出售金融资产市场价值变动产生的增值，存在变现的不确定性。','',NULL,'G100001',NULL,0),
(3433,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_W-ZCFZ_W1>0&&(ZCFZ_W-ZCFZ_W1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_W-ZCFZ_W1)-(ZCFZ_AL-ZCFZ_AL1)>0','持有至到期投资在较上年同期显著增加，建议管理层了解该科目的资产类别，如为理财类投资支出的增加引起，需考虑闲置资金较多，建议合理规划资金使用及流转速度，避免资金闲置引起的浪费。同时需注意核算时点、计量金额是否符合会计准则要求。','',NULL,'G100001',NULL,0),
(3434,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_X-ZCFZ_X1>0&&(ZCFZ_X-ZCFZ_X1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_X-ZCFZ_X1)-(ZCFZ_AL-ZCFZ_AL1)>0','本期长期应收款较上年同期有所增加，考虑是否存在期末大量发生融资租赁的情况而导致长期应收款的增加。由于融资租赁的特殊性，建议管理层对该部分资产进行专人管理，设立专门的登记薄记录相关情况，同时，考虑融资租赁业务对整个企业业务及收益的影响。','',NULL,'G100001',NULL,0),
(3435,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Y-ZCFZ_Y1>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_E-ZCFZ_E1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_L-ZCFZ_L1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Q-ZCFZ_Q1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_W-ZCFZ_W1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AB-ZCFZ_AB1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AF-ZCFZ_AF1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&&(ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Y-ZCFZ_Y1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于长期股权投资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上年同期有所增加，需查找原因，同时需注意核算时点、计量金额是否会计准则要求。注意按收益法核算的长期股权投资在期末根据被投资企业的经营结果调整长期股权投资的账面价值。同时，需关注按成本法核算的长期股权投资是否存在减值情况。此外，如果长期股权投资金额的增加是因为债务重组或非货币性资产交换获得，建议考虑评估该部分资产未来可能产生的收益，以及对企业利润的影响。','',NULL,'G100001',NULL,0),
(3436,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_Z-ZCFZ_Z1>0&&   (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_Z-ZCFZ_Z1)-(ZCFZ_AL-ZCFZ_AL1)>0','由于投资性房地产核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上年同期有所增加，需查找原因并关注已实现的增值额，同时需注意核算时点、计量金额是否会计准则要求。且需警惕因期末投资性房地产市场价值变动产生的增值，存在变现的不确定性。另外，建议管理层考虑目前房地产产业发展的减缓趋势，结合国家对房地产业的宏观政策，评判投资性房地产在企业利润中所占的份额，考虑是否需要调整对投资性房地产的投入。','',NULL,'G100001',NULL,0),
(3437,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AA-ZCFZ_AA1>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AA-ZCFZ_AA1)-(ZCFZ_AL-ZCFZ_AL1)>0','固定资产有所增加，管理层应注意关注固定资产的转固时间及条件是否符合会计准则的要求，是否需要进行账务调整。另外，本期投入大量固定资产，建议管理层结合相关资产的付款期限考虑后期付款资金的充足性。','',NULL,'G100001',NULL,0),
(3438,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AB-ZCFZ_AB1>0&&  (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AB-ZCFZ_AB1)-(ZCFZ_AL-ZCFZ_AL1)>0','在建工程的增加，需考虑在未来几年对工程需投入的资金，考虑未来期间对现金流可能产生的压力。','',NULL,'G100001',NULL,0),
(3439,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AC-ZCFZ_AC1>0&&(ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AC-ZCFZ_AC1)-(ZCFZ_AL-ZCFZ_AL1)>0','工程物资期末余额比上年同期有所增加，需查找原因，关注与在建工程的关联关系。此外，管理层需考虑工程进度对工程物资的采购的影响，合理规划，避免工程物资的囤积，同时对采购工程物资需投入的资金进行合理规划，避免出现资金紧张的情况。','',NULL,'G100001',NULL,0),
(3440,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AD-ZCFZ_AD1>0&&(ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AD-ZCFZ_AD1)-(ZCFZ_AL-ZCFZ_AL1)>0','固定资产清理有所增加，需关注清理固定资产的原因及必要性，并预估清理所得及对企业造成的损失。同时，管理层需考虑是否需要投入资金重置相关固定资产以对清理资产进行置换，如需，则建议结合货币资金中的资金预测，分析对未来现金流的影响程度，合理规划资金使用及购置计划，避免资金紧张的情况出现。','',NULL,'G100001',NULL,0),
(3441,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AE-ZCFZ_AE1>0&&(ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AE-ZCFZ_AE1)-(ZCFZ_AL-ZCFZ_AL1)>0','无预警。','',NULL,'G100001',NULL,0),
(3442,'1','资产负债表首页概况','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AF-ZCFZ_AF1>0&&(ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AF-ZCFZ_AF1)-(ZCFZ_AL-ZCFZ_AL1)>0','无预警。','',NULL,'G100001',NULL,0),
(3443,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AG-ZCFZ_AG1>0&&(ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AG-ZCFZ_AG1)-(ZCFZ_AL-ZCFZ_AL1)>0','无形资产有所增加，应考虑是属于自主开发亦或购买形成，若为自主开发，应注意关注无形资产的确认时间及条件是否符合会计准则的要求，是否需要进行账务调整。同时，需持续关注无形资产对生产运营所带来的效益情况，注意重要技术的排他性和保密性。','',NULL,'G100001',NULL,0),
(3444,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AH-ZCFZ_AH1>0&&(ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AH-ZCFZ_AH1)-(ZCFZ_AL-ZCFZ_AL1)>0','开发支出有所增加，应注意关注开发支出的确认时间及条件是否符合会计准则的要求，并相应进行账务调整。建议管理层就开发支出是否可以资本化的问题使用在线顾问模块中的企业顾问功能，咨询专业顾问具体支出的性质，达到企业利益最大化。','',NULL,'G100001',NULL,0),
(3445,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AI-ZCFZ_AI1>0&&(ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AI-ZCFZ_AI1)-(ZCFZ_AL-ZCFZ_AL1)>0','商誉的增加，往往出现在资产并购情况中，需重点关注事项发生的全过程，注意商誉变动的原因，并合理判断商誉计量金额的准确性。','',NULL,'G100001',NULL,0),
(3446,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AJ-ZCFZ_AJ1>0&&(ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AK-ZCFZ_AK1)>0&& (ZCFZ_AJ-ZCFZ_AJ1)-(ZCFZ_AL-ZCFZ_AL1)>0','长期待摊费用有所增加，需查明原因，并注意区分待摊费用和直接费用化情形，确保核算符合会计准则。','',NULL,'G100001',NULL,0),
(3447,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AK-ZCFZ_AK1>0&&(ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AK-ZCFZ_AK1)-(ZCFZ_AL-ZCFZ_AL1)>0','递延所得税资产的产生，是因为资产的账面价值大于计税基础，或负债的账面价值小于计税基础，导致会计确认的所得税小于税法确认的所得税，从而产生递延所得税资产。递延所得税资产增加，需关注其确认条件、计量金额是否符合会计准则。建议管理层使用在线顾问模块中的专项顾问功能，为企业进行整体税收筹划，进行合理避税，减少企业利润不必要的损耗。同时，建议管理层检查是否已按要求设立备查薄。','',NULL,'G100001',NULL,0),
(3448,'1','资产负债表首页预警','ZCFZ_AN-ZCFZ_AN1>0&&ZCFZ_AL-ZCFZ_AL1>0&&(ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_A-ZCFZ_A1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_D-ZCFZ_D1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_E-ZCFZ_E1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_F-ZCFZ_F1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_G-ZCFZ_G1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_H-ZCFZ_H1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_L-ZCFZ_L1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_M-ZCFZ_M1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_N-ZCFZ_N1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_P-ZCFZ_P1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Q-ZCFZ_Q1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_R-ZCFZ_R1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_S-ZCFZ_S1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_V-ZCFZ_V1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_W-ZCFZ_W1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_X-ZCFZ_X1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Y-ZCFZ_Y1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_Z-ZCFZ_Z1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AA-ZCFZ_AA1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AB-ZCFZ_AB1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AC-ZCFZ_AC1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AD-ZCFZ_AD1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AE-ZCFZ_AE1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AF-ZCFZ_AF1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AG-ZCFZ_AG1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AH-ZCFZ_AH1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AI-ZCFZ_AI1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AJ-ZCFZ_AJ1)>0&& (ZCFZ_AL-ZCFZ_AL1)-(ZCFZ_AK-ZCFZ_AK1)>0','其他非流动资产若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3449,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_A1-ZCFZ_A>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_A1-ZCFZ_A)-(ZCFZ_AL1-ZCFZ_AL)>0','待添加','',NULL,'G100001',NULL,0),
(3450,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_D1-ZCFZ_D>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_D1-ZCFZ_D)-(ZCFZ_AL1-ZCFZ_AL)>0','由于以公允价值计量且其变动计入当期损益的金融资产核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的减少提请管理层考虑是有因减值还是资产处置导致期末值减少。若为减值造成，则需重点注意该资产的价值变动，注意风险控制。若为资产处置造成，则提醒管理层关注处置的原因、必要性及结果，以防做出不利于企业利益的行为。','',NULL,'G100001',NULL,0),
(3451,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_E1-ZCFZ_E>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_E1-ZCFZ_E)-(ZCFZ_AL1-ZCFZ_AL)>0','无预警。','',NULL,'G100001',NULL,0),
(3452,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_F1-ZCFZ_F>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_F1-ZCFZ_F)-(ZCFZ_AL1-ZCFZ_AL)>0','应收票据减少，企业应根据汇票的种类及规定及时行使提示承兑、提示付款等权利。否则，汇票未按照规定期限提示承兑的，持票人丧失对其前手的追索权；持票人超过提示付款期限提示付款的，持票人开户银行不予受理，此时企业需通过其他方式或途径追偿其应收款项。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3453,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_G1-ZCFZ_G>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_L>90&& YSZKZL_D+YSZKZL_E+YSZKZL_F>0','本期总资产较上期有所减少，主要是因为应收账款的减少。应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，可能产生的坏账损失可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。在应收账款中，账龄超过360日的应收账款余额为 Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3454,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_G1-ZCFZ_G>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_L>90&& YSZKZL_D+YSZKZL_E+YSZKZL_F==0','本期总资产较上期有所减少，主要是因为应收账款的减少。应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。应收账款周转天数>90天，企业收账速度较慢、平均收账期较长，可能产生的坏账损失可能性较高。建议管理层需加强账款的催收，保障资产的流动性，有利于企业的正常生产运营。','',NULL,'G100001',NULL,0),
(3455,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_G1-ZCFZ_G>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_L<=90&& YSZKZL_D+YSZKZL_E+YSZKZL_F>0','本期总资产较上期有所减少，主要是因为应收账款的减少。应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。在应收账款中，账龄超过360日的应收账款余额为 Rmb{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}万元。针对账龄超1年的应收账款，建议管理层分析其回收可能性以及出售的可能性，择优选择对自身最有利的方案，并相应进行账务调整。同时，查看与相关客户的合同，针对合同提及的违约责任等，考虑是否追究其法律责任。','{(YSZKZL_D+YSZKZL_E+YSZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3456,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_G1-ZCFZ_G>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_G1-ZCFZ_G)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_L<=90&& YSZKZL_D+YSZKZL_E+YSZKZL_F==0','本期总资产较上期有所减少，主要是因为应收账款的减少。应收账款期末较上年同期有所减少，建议管理层查看营业收入模块中的应收收入趋势分析，如趋势一致，则较为健康，如趋势不一致，需与市场部查找不一致的原因，避免对企业未来经营产生重大影响的问题的发生。','',NULL,'G100001',NULL,0),
(3457,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_H1-ZCFZ_H>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AL1-ZCFZ_AL)>0&&YFKXZL_D+YFKXZL_E+YFKXZL_F>0','本期总资产较上期有所减少，主要是因为预付账款的减少。预付款项在期末较上年同期有所减少，建议管理层查看减少情况，考虑是否属于年底正常业务减少需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付形式。本期账龄超过360日的预付款项金额为Rmb{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}万元，建议管理层查看预付账款的账龄分析，对账龄超过1年的预付账款确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(YFKXZL_D+YFKXZL_E+YFKXZL_F)/10000}',NULL,'G100001',NULL,0),
(3458,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_H1-ZCFZ_H>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_H1-ZCFZ_H)-(ZCFZ_AL1-ZCFZ_AL)>0&&YFKXZL_D+YFKXZL_E+YFKXZL_F==0','本期总资产较上期有所减少，主要是因为预付账款的减少。预付款项在期末较上年同期有所减少，建议管理层查看减少情况，考虑是否属于年底正常业务减少需求，若不属于，则建议管理层关注自身在采购及销售方面的谈判能力以及整个行业的采购及销售模式的变化。同时，注意预付账款对现金流带来的不利影响，建议管理层积极同供应商沟通，尽量在采购时减少预付形式。','',NULL,'G100001',NULL,0),
(3459,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_L1-ZCFZ_L>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_L1-ZCFZ_L)-(ZCFZ_AL1-ZCFZ_AL)>0','应收利息的减少，建议管理层结合债券的购买及到期情况做判断，如减少由债券购买的减少导致，或者因债券到期所导致，均属于正常情况，如出现相反趋势，建议管理层对其进行查询。建议针对债券进行专人专管，检查是否按要求设立备查薄，方便管理。可使用本系统在线咨询模块中的专项咨询服务，为企业设立完善的管理控制流程，提高管理效率。','',NULL,'G100001',NULL,0),
(3460,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_M1-ZCFZ_M>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_M1-ZCFZ_M)-(ZCFZ_AL1-ZCFZ_AL)>0','应收股利减少，建议结合长期股权投资、可供出售金融资产等科目情况，关注是否与股权投资收益情况或处置股权资产相符。若因资产处置，则需重点关注处置原因、必要性及结果，以防不利于企业利益的情形出现。','',NULL,'G100001',NULL,0),
(3461,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_N1-ZCFZ_N>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AL1-ZCFZ_AL)>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F>0','本期总资产较上期有所减少，主要是因为其他应收款的减少。其他应收款在期末较上年同期有所减少，考虑是否因为资金回收、坏账处置引起。若因处置引起，则建议管理层重点关注处置的原因、必要性及结果，是否损害公司利益。同时，需关注剩余的其他应收款是否属于关联交易，若是，需考虑企业短期内是否有IPO计划，如有，则可能对企业的IPO造成不利影响。其他应收款中有Rmb{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}万元账龄已超360日，对账龄超过1年的其他应收款需引起管理层的重视，建议管理层查看该部分较长账龄的其他应收款是否属于关联交易，并确认其回收可能性以及处置的可能性，择优选择对自身最有利的方案，并进行相应账务处理。','{(QTYSZL_D+QTYSZL_E+QTYSZL_F)/10000}',NULL,'G100001',NULL,0),
(3462,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_N1-ZCFZ_N>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_N1-ZCFZ_N)-(ZCFZ_AL1-ZCFZ_AL)>0&&QTYSZL_D+QTYSZL_E+QTYSZL_F==0','本期总资产较上期有所减少，主要是因为其他应收款的减少。其他应收款在期末较上年同期有所减少，考虑是否因为资金回收、坏账处置引起。若因处置引起，则建议管理层重点关注处置的原因、必要性及结果，是否损害公司利益。同时，需关注剩余的其他应收款是否属于关联交易，若是，需考虑企业短期内是否有IPO计划，如有，则可能对企业的IPO造成不利影响。','',NULL,'G100001',NULL,0),
(3463,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_P1-ZCFZ_P>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_N>60&& CHKL_D+CHKL_E+CHKL_F>0','本期总资产较上期有所减少，主要是因为存货的减少。存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'G100001',NULL,0),
(3464,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_P1-ZCFZ_P>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_N>60&& CHKL_D+CHKL_E+CHKL_F==0','本期总资产较上期有所减少，主要是因为存货的减少。存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。存货周转天数>60天，资金占用水平较高，流动性偏弱，存货转化为现金或应收帐款的速度就较慢，削弱了企业的短期偿债能力及获利能力。建议管理层关注存货管理中存在的问题，结合生产销售计划，尽可能降低存货的资金占用水平。','',NULL,'G100001',NULL,0),
(3465,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_P1-ZCFZ_P>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_N<=60&&CHKL_D+CHKL_E+CHKL_F>0','本期总资产较上期有所减少，主要是因为存货的减少。存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。期末存货中库龄超360日的存货有Rmb{(CHKL_D+CHKL_E+CHKL_F)/10000}万元。账龄超过1年的存货需引起管理层的重视，建议管理层查看该部分较长账龄的存货是否属于滞销产品和相关原材料，并确认其出售可能性，根据市场动态择优选择对自身最有利的方案，并进行相应账务处理。','{(CHKL_D+CHKL_E+CHKL_F)/10000}',NULL,'G100001',NULL,0),
(3466,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_P1-ZCFZ_P>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_P1-ZCFZ_P)-(ZCFZ_AL1-ZCFZ_AL)>0&&YBLFX_N<=60&& CHKL_D+CHKL_E+CHKL_F==0','本期总资产较上期有所减少，主要是因为存货的减少。存货大幅度减少，考虑是否存在因销售额降低从而导致原材料的采购量降低或因销售额大增而导致产成品不足情形。若销售额降低，则建议管理层扩大销售渠道，增大销售额；若产成品不足，则建议管理层合理安排原材料的采购时间和生产计划时间，保障库存充足。','',NULL,'G100001',NULL,0),
(3467,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Q1-ZCFZ_Q>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Q1-ZCFZ_Q)-(ZCFZ_AL1-ZCFZ_AL)>0','由于持有待售资产核算的类别较为特殊，且此类资产为非经营类资产，因此期末值的减少提请管理层考虑是有因减值还是资产处置导致期末值减少。若为减值造成，则需重点注意该资产的价值变动，注意风险控制。若为资产处置造成，则提醒管理层关注处置的原因、必要性及结果，以防做出不利于企业利益的行为。','',NULL,'G100001',NULL,0),
(3468,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_R1-ZCFZ_R>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_R1-ZCFZ_R)-(ZCFZ_AL1-ZCFZ_AL)>0','一年内到期的非流动资产减少，考虑是否因为资金回笼还是对该资产进行处置。若为对资产进行处置，建议管理层关注处置的原因、必要性及所得情况。同时，需结合资金情况及资金预警，做好未来的资金投资规划，避免资金闲置或紧张情况的出现。','',NULL,'G100001',NULL,0),
(3469,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_S1-ZCFZ_S>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_S1-ZCFZ_S)-(ZCFZ_AL1-ZCFZ_AL)>0','其他流动资产在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3470,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_V1-ZCFZ_V>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_V1-ZCFZ_V)-(ZCFZ_AL1-ZCFZ_AL)>0','由于可供出售金融资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末改科目余额比上年同期有所减少，需查找原因并关注已实现的减值额，且需警惕可供出售金融资产市场价值变动产生的损失，存在不确定性。同时，若存在处置该资产的情形，则需注意处置的原因、必要性及结果，以防不利于企业利益的行为发生。','',NULL,'G100001',NULL,0),
(3471,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_W1-ZCFZ_W>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_W1-ZCFZ_W)-(ZCFZ_AL1-ZCFZ_AL)>0','建议管理层了解该科目的资产类别，关注其减少的原因。同时，需考虑是否存在运营资金不充足而出售长期股权投资的情形，建议管理层合理规划资金使用及流转速度，避免资金不足影响生产经营。同时需注意核算时点、计量金额是否会计准则要求。','',NULL,'G100001',NULL,0),
(3472,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_X1-ZCFZ_X>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_X1-ZCFZ_X)-(ZCFZ_AL1-ZCFZ_AL)>0','长期应收款在期末有所减少，考虑是因为资金回笼亦或是公司融资租赁业务的缩减。若因业务缩减引起长期应收款的期末减少，建议管理层联合市场部等相关部门，评判融资租赁业务对企业总体收益的影响，从而对融资租赁业务的发展做出合理规划。','',NULL,'G100001',NULL,0),
(3473,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Y1-ZCFZ_Y>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Y1-ZCFZ_Y)-(ZCFZ_AL1-ZCFZ_AL)>0','由于长期股权投资核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上年同期有所减少，需查找原因并关注已实现的减值额，同时需注意核算时点、计量金额等是否会计准则要求。注意按收益法核算的长期股权投资在期末根据被投资企业的经营结果调整长期股权投资的账面价值。同时，需关注按成本法核算的长期股权投资是否存在减值情况以及是否存在大量处置该资产情况，若存在处置资产情况，则需关注处置的原因、必要性及结果，以防不利于企业利益的情况发生。','',NULL,'G100001',NULL,0),
(3474,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_Z1-ZCFZ_Z>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_Z1-ZCFZ_Z)-(ZCFZ_AL1-ZCFZ_AL)>0','由于投资性房地产核算的类别较为特殊，且此类资产为非经营性活动类资产，因此，期末该科目余额比上年同期有所减少，需查找原因并关注已实现的减值额，同时需注意核算时点、计量金额是否会计准则要求。同时，需关注是否存在大量处置该资产情况，若存在处置资产情况，则需关注处置的原因、必要性及结果，以防不利于企业利益的情况发生。','',NULL,'G100001',NULL,0),
(3475,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AA1-ZCFZ_AA>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AA1-ZCFZ_AA)-(ZCFZ_AL1-ZCFZ_AL)>0','固定资产有所减少，管理层需注意区分是因资产处置还是折旧年限已到期。若为资产处置，需关注处置的原因、必要性及所得情况；若为资产折旧年限已到期，则需注意是否有重要设备折旧年限已到期，需提前准备新设备的采购或对旧设备进一步维护维修，确保生产正产运作。','',NULL,'G100001',NULL,0),
(3476,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AB1-ZCFZ_AB>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AB1-ZCFZ_AB)-(ZCFZ_AL1-ZCFZ_AL)>0','在建工程的减少，需注意区分是转入固定资产还是资产处置原因。若为转入固定资产，则需关注转入的时点、条件以及计量金额是否符合会计准则的要求，确保账务核算准确；若为资产处置原因，则需关注处置的原因、必要性以及所得情况。','',NULL,'G100001',NULL,0),
(3477,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AC1-ZCFZ_AC>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AC1-ZCFZ_AC)-(ZCFZ_AL1-ZCFZ_AL)>0','期末该科目余额比上年同期有所减少，需查找原因，关注与在建工程的关联关系。同时，由于工程物资的特殊性，建议管理层关注。','',NULL,'G100001',NULL,0),
(3478,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AD1-ZCFZ_AD>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AD1-ZCFZ_AD)-(ZCFZ_AL1-ZCFZ_AL)>0','固定资产清理有所减少，建议管理层评估已清理的固定资产的所得。此外，鉴于固定资产清理科目的性质，建议管理层评估该科目波动的合理性。','',NULL,'G100001',NULL,0),
(3479,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AE1-ZCFZ_AE>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AE1-ZCFZ_AE)-(ZCFZ_AL1-ZCFZ_AL)>0','无预警。','',NULL,'G100001',NULL,0),
(3480,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AF1-ZCFZ_AF>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AF1-ZCFZ_AF)-(ZCFZ_AL1-ZCFZ_AL)>0','无预警。','',NULL,'G100001',NULL,0),
(3481,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AG1-ZCFZ_AG>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AG1-ZCFZ_AG)-(ZCFZ_AL1-ZCFZ_AL)>0','无形资产有所减少，需考虑是由于摊销导致的正常减少，亦或因为处置或减值造成。若因处置导致，需关注处置的原因、必要性和所得；若因减值导致，建议管理层评估因技术落后可能给企业未来运营及发展带来的风险，考虑是否需要重新投入研发，如需投入研发新技术，则需考虑研发支出对未来现金流的需求以及影响，合理规划。','',NULL,'G100001',NULL,0),
(3482,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AH1-ZCFZ_AH>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AH1-ZCFZ_AH)-(ZCFZ_AL1-ZCFZ_AL)>0','开发支出有所减少，需考虑是由于转入无形资产、处置还是减值造成。若为处置情况，需关注处置的原因、必要性和所得；若为减值情况，建议管理层需重视企业的技术创新，评估技术风险。','',NULL,'G100001',NULL,0),
(3483,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AI1-ZCFZ_AI>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AI1-ZCFZ_AI)-(ZCFZ_AL1-ZCFZ_AL)>0','商誉的减少，需考虑是由于资产处置还是资产减值造成，若为资产处置，需关注处置事项的原因及、必要性及所得；若为资产减值，则需查明减值原因，并防范该减值所带来的不利影响。','',NULL,'G100001',NULL,0),
(3484,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AJ1-ZCFZ_AJ>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AK1-ZCFZ_AK)>0&& (ZCFZ_AJ1-ZCFZ_AJ)-(ZCFZ_AL1-ZCFZ_AL)>0','长期待摊费用有所减少，需查明原因，考虑是否因正常摊销引起，若非，则需关注减少原因。','',NULL,'G100001',NULL,0),
(3485,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AK1-ZCFZ_AK>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AK1-ZCFZ_AK)-(ZCFZ_AL1-ZCFZ_AL)>0','递延所得税资产的产生，是因为资产的账面价值大于计税基础，或负债的账面价值小于计税基础，导致会计确认的所得税小于税法确认的所得税，从而产生递延所得税资产。递延所得税资产减少，需关注其确认条件、计量金额是否符合会计准则。建议管理层使用在线顾问模块中的专项顾问功能，为企业进行整体税收筹划，进行合理避税，减少企业利润不必要的损耗。同时，建议管理层检查是否已按要求设立备查薄。','',NULL,'G100001',NULL,0),
(3486,'1','资产负债表首页预警','ZCFZ_AN1-ZCFZ_AN>0&&ZCFZ_AL1-ZCFZ_AL>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_A1-ZCFZ_A)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_D1-ZCFZ_D)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_E1-ZCFZ_E)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_F1-ZCFZ_F)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_G1-ZCFZ_G)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_H1-ZCFZ_H)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_L1-ZCFZ_L)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_M1-ZCFZ_M)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_N1-ZCFZ_N)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_P1-ZCFZ_P)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Q1-ZCFZ_Q)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_R1-ZCFZ_R)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_S1-ZCFZ_S)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_V1-ZCFZ_V)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_W1-ZCFZ_W)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_X1-ZCFZ_X)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Y1-ZCFZ_Y)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_Z1-ZCFZ_Z)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AA1-ZCFZ_AA)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AB1-ZCFZ_AB)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AC1-ZCFZ_AC)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AD1-ZCFZ_AD)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AE1-ZCFZ_AE)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AF1-ZCFZ_AF)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AG1-ZCFZ_AG)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AH1-ZCFZ_AH)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AI1-ZCFZ_AI)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AJ1-ZCFZ_AJ)>0&& (ZCFZ_AL1-ZCFZ_AL)-(ZCFZ_AK1-ZCFZ_AK)>0','其他非流动资产在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3487,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AO-ZCFZ_AO1>0&&(ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AO-ZCFZ_AO1)-(ZCFZ_BW-ZCFZ_BW1)>0','短期借款的增加，说明企业现金流较为紧张，需要通过银行贷款缓解资金压力，建议合理规划资金使用情况，同时，查看应收账款的情况，对应收账款进行催收，亦可与供应商进行谈判，延长付款期，缓解资金压力。','',NULL,'G100001',NULL,0),
(3488,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AS-ZCFZ_AS1>0&&(ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AS-ZCFZ_AS1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于以公允价值计量且其变动计入当期损益的金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','',NULL,'G100001',NULL,0),
(3489,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AT-ZCFZ_AT1>0&&(ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AT-ZCFZ_AT1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于衍生金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','',NULL,'G100001',NULL,0),
(3490,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AU-ZCFZ_AU1>0&&(ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AU-ZCFZ_AU1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于银行承兑汇票的付款期限最长为6个月，因此，使用票据实际上对企业来说可实现短期融资的目的，在短期现金流较为紧张的情况下，可考虑采取使用开具应付票据的方式减轻企业现金负担。然而，需注意以下可能产生的问题及风险：应付商业票据是购买企业在正常商业活动中向供应商承诺在将来特定时日、支付一笔固定货款的票据。与应付账款相比，应付商业票据由于提出了付款的书面承诺，因而更具有法律上的约束力。此外，企业应于汇票到期前将票款足额交存其开户银行，以免银行对企业进行计收利息及引起相关法律诉讼纠纷。同时建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3491,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','本期总负债较上期有所增加，主要是因为应付账款的增加。应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层相对提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。但要留意，过度集中的采购，对企业存在风险，管理层需在两者之间取得平衡。在应付账款中，账龄超360日的应付账款余额为 Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}万元。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任及确认违约时间点等问题，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3492,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YBLFX_O<60&& YFZKZL_D+YFZKZL_E+YFZKZL_F==0','本期总负债较上期有所增加，主要是因为应付账款的增加。应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层相对提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。但要留意，过度集中的采购，对企业存在风险，管理层需在两者之间取得平衡。','',NULL,'G100001',NULL,0),
(3493,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YBLFX_O>=60&& YFZKZL_D+YFZKZL_E+YFZKZL_F>0','本期总负债较上期有所增加，主要是因为应付账款的增加。应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。在应付账款中，账龄超360日的应付账款余额为 Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}万元。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任及确认违约时间点等问题，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3494,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AV-ZCFZ_AV1>0&&(ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AV-ZCFZ_AV1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YBLFX_O>=60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','本期总负债较上期有所增加，主要是因为应付账款的增加。应付账款有所增加，管理层需关注增加原因及后期还款压力。建议管理层结合货币资金中的资金预警，评估应付账款增加对未来现金流产生的影响。管理层可选用本系统中顾问咨询模块的企业咨询功能，由专家顾问为企业设计方案。','',NULL,'G100001',NULL,0),
(3495,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AW-ZCFZ_AW1>0&&(ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F>0','总负债较上期有所增长，主要是因为预收款项的增加。预收款项有所增加，建议管理层结合本系统的收入分析及应收账款分析等模块，如呈反趋势增长，需与销售部门分析预收账款增加的原因，是否有合同条款的调整，同时分析调整收款条件对维护客户关系可能产生的影响。此外，在同等销售规模前提下，改应收为预收，实际上对企业现金流有良性作用，建议管理层在不影响客户关系的前提下，适当增加销售预收。在预收账款中，账龄超360日的预收账款余额为Rmb{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}万元。针对账龄超1年的预收账款，建议管理层结合销售合同，关注是否存在收入核算时点、计量金额不准确的问题。此外，建议管理层评估款该部分账龄较长之应收款项是否仍需发货或支付返还，并进行相应的账务处理。','{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}',NULL,'G100001',NULL,0),
(3496,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AW-ZCFZ_AW1>0&&(ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AW-ZCFZ_AW1)-(ZCFZ_BW-ZCFZ_BW1)>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F==0','总负债较上期有所增长，主要是因为预收款项的增加。预收款项有所增加，建议管理层结合本系统的收入分析及应收账款分析等模块，如呈反趋势增长，需与销售部门分析预收账款增加的原因，是否有合同条款的调整，同时分析调整收款条件对维护客户关系可能产生的影响。此外，在同等销售规模前提下，改应收为预收，实际上对企业现金流有良性作用，建议管理层在不影响客户关系的前提下，适当增加销售预收。','',NULL,'G100001',NULL,0),
(3497,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_AZ-ZCFZ_AZ1>0&&(ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_AZ-ZCFZ_AZ1)-(ZCFZ_BW-ZCFZ_BW1)>0','应付职工薪酬大幅度增加，考虑是否因正常人员增加所引起的。若员工大量增加，需关注企业的人工成本、人工效率。同时，若计划进行资本运作，则还需关注员工五险一金的缴纳是否按照相关规定执行，否则可能面临被主管单位要求补缴和处罚的情形。','',NULL,'G100001',NULL,0),
(3498,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BA-ZCFZ_BA1>0&&(ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BA-ZCFZ_BA1)-(ZCFZ_BW-ZCFZ_BW1)>0','应交税费的大幅度增加，主要考虑是否因业务的增长造成。若与业务不匹配，则考虑是否存在税收政策变化等特殊情况。建议使用本系统顾问咨询中的专项咨询，由专业顾问为企业进行税收筹划，达到合理避税，利润最大化的目的。','',NULL,'G100001',NULL,0),
(3499,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BB-ZCFZ_BB1>0&&(ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BB-ZCFZ_BB1)-(ZCFZ_BW-ZCFZ_BW1)>0','针对应付利息，提请管理层关注以下方面的问题：1、需查看借款合同，核查应付利息的确认时间和计量金额是否符合会计准则；2、关注付款期限及已支付金额，考虑自身资金压力；3、关注逾期未支付的违约责任及违约时间点。','',NULL,'G100001',NULL,0),
(3500,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BC-ZCFZ_BC1>0&&(ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BC-ZCFZ_BC1)-(ZCFZ_BW-ZCFZ_BW1)>0','关注该科目的变动是否与企业宣告派发的股利相符合，同时需考虑支付能力，结合企业未来的生产经营计划关注资金压力问题。','',NULL,'G100001',NULL,0),
(3501,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BD-ZCFZ_BD1>0&&(ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BW-ZCFZ_BW1)>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F>0','本期总负债较上期有所增加，主要是因为其他应付款的增加。其他应付款的有所增加，需考虑对未来偿还款项的资金风险。建议管理层查看增长幅度较大的其他应付款的合同，留意其中的偿还条款，根据本系统货币资金模块中的货币资金预警分析未来期间内是否会对资金造成影响。如为关联企业之间的资金拆借，需与企业未来发展相结合，如在短期内有上市计划，则需对其进行清理，如无，则需考虑关联企业之间的资金拆解是否符合相关的法律及监管条例的约束，例如：借款利率是否符合法律法规的要求；如为无息贷款，是否符合税法的要求。其他应付款中，账龄超360日的其他应付款余额为Rmb{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}万元。针对账龄超1年的其他应付款，建议管理层分析其是否属于关联方往来，并预估需付款的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流等方式，择优选择对自身最有利的方案，以防出现现金断流情况。','{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}',NULL,'G100001',NULL,0),
(3502,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BD-ZCFZ_BD1>0&&(ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BD-ZCFZ_BD1)-(ZCFZ_BW-ZCFZ_BW1)>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F==0','本期总负债较上期有所增加，主要是因为其他应付款的增加。其他应付款的有所增加，需考虑对未来偿还款项的资金风险。建议管理层查看增长幅度较大的其他应付款的合同，留意其中的偿还条款，根据本系统货币资金模块中的货币资金预警分析未来期间内是否会对资金造成影响。如为关联企业之间的资金拆借，需与企业未来发展相结合，如在短期内有上市计划，则需对其进行清理，如无，则需考虑关联企业之间的资金拆解是否符合相关的法律及监管条例的约束，例如：借款利率是否符合法律法规的要求；如为无息贷款，是否符合税法的要求。','',NULL,'G100001',NULL,0),
(3503,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BI-ZCFZ_BI1>0&&(ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BI-ZCFZ_BI1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于持有待售的负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的增加提请管理层关注进行该负债增加的原因以及具体值，注重风险控制。同时，需注意新增负债的利率、归还期限、担保情况等，评估企业未来的现金流情况。','',NULL,'G100001',NULL,0),
(3504,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BJ-ZCFZ_BJ1>0&&(ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BJ-ZCFZ_BJ1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于一年内到期的非流动负债主要为从长期借款转入的负债，长期借款即将到期，需考虑是否需要对长期借款进行续借或新借。建议分析未来5年资金需求，合理规划贷款金额。同时，如需新增长期借款，需考虑企业固定资产等是否有足够的抵押物进行抵押借款，或是否有足够的资信可进行其他类型的贷款。','',NULL,'G100001',NULL,0),
(3505,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BK-ZCFZ_BK1>0&&(ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BK-ZCFZ_BK1)-(ZCFZ_BW-ZCFZ_BW1)>0','其他流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3506,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BM-ZCFZ_BM1>0&&(ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BM-ZCFZ_BM1)-(ZCFZ_BW-ZCFZ_BW1)>0','长期借款的增加，需关注未来还本付息对现金流的影响，除此之外，建议管理层整理贷款明细表对贷款情况进行归纳统计，关注合同中对贷款使用的限定，并责成专人负责对资金使用情况等进行追踪，规避因违规使用资金可能产生的风险。','',NULL,'G100001',NULL,0),
(3507,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BN-ZCFZ_BN1>0&&(ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BN-ZCFZ_BN1)-(ZCFZ_BW-ZCFZ_BW1)>0','应付债券的增加，需关注未来还本付息对现金流的影响以及如未能按期支付利息或本金可能产生的法律风险。除此之外，提请管理层关注债券的募集说明书中赋予投资者的权利，避免因投资者根据募集说明书行使权利时双方可能产生的分歧。另外，建议管理层对债券设专人管理及专门的登记本，记录债券相关情况。','',NULL,'G100001',NULL,0),
(3508,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BQ-ZCFZ_BQ1>0&&(ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BQ-ZCFZ_BQ1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于一般性经营较少使用此科目，建议管理层查看此科目核算的内容，关注发生的原因及合理性，看是否存在因记账错误导致的余额变动。如非上述原因，则需根据科目核算的性质，考虑未来分期付款或融资租赁时支付款项对现金流的影响。','',NULL,'G100001',NULL,0),
(3509,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BS-ZCFZ_BS1>0&&(ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BS-ZCFZ_BS1)-(ZCFZ_BW-ZCFZ_BW1)>0','由于此科目的特殊性，建议管理层设置专人管理此科目的变动情况，并且针对用款进行专项审核及登记，做到专款专用，详细记录转款的增减情况。','',NULL,'G100001',NULL,0),
(3510,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BT-ZCFZ_BT1>0&&(ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BT-ZCFZ_BT1)-(ZCFZ_BW-ZCFZ_BW1)>0','预计负债大幅度增加，企业需提高警惕，关于增加的原因。同时由于预计负债的特殊性，建议管理层针对预计负债专门进行实现程度的可能性分析，针对风险较高，较可能需要实际支付的预计负债，除考虑对现金流的影响外，还要考虑负债产生同时可能伴随的法律责任或风险，以及如未能承担负债偿还的情况下可能产生的法律责任及风险。尤其在股权转让中，受让方更应重视目标公司的预计负债问题。当发生债务追索时，将严重影响受让方的股份转让合同的利益和预期的收益。预计债务的承担问题建议列入风险负担条款在股权转让合同中予以约定。同时注意股权的转移并不影响到追索的对象，受让方在成为目标公司股东后，目标公司仍需对外承担相应责任，受让方再根据股权转让合同向出让方追偿。','',NULL,'G100001',NULL,0),
(3511,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BU-ZCFZ_BU1>0&&(ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BV-ZCFZ_BV1)>0&& (ZCFZ_BU-ZCFZ_BU1)-(ZCFZ_BW-ZCFZ_BW1)>0','递延收益的增加，需关注增加的原因及递延收益确认的条件是否合规。若为政府补贴产生的递延收益，则建议管理层重点关注补贴收入实现的相关条件，确保项目的开展符合政府相关规定。','',NULL,'G100001',NULL,0),
(3512,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BV-ZCFZ_BV1>0&&(ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BV-ZCFZ_BV1)-(ZCFZ_BW-ZCFZ_BW1)>0','递延所得税负债的产生，是因为资产的账面价值小于计税基础，或负债的账面价值大于计税基础而，导致会计确认的所得税大于税法确认的所得税，从而产生递延所得税负债。递延所得税负债大幅度增加，需关注其确认条件、计量金额是否符合会计准则。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3513,'1','资产负债表首页预警','ZCFZ_BY-ZCFZ_BY1>0&& ZCFZ_BW-ZCFZ_BW1>0&&(ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AO-ZCFZ_AO1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AS-ZCFZ_AS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AT-ZCFZ_AT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AU-ZCFZ_AU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AV-ZCFZ_AV1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AW-ZCFZ_AW1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_AZ-ZCFZ_AZ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BA-ZCFZ_BA1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BB-ZCFZ_BB1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BC-ZCFZ_BC1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BD-ZCFZ_BD1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BI-ZCFZ_BI1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BJ-ZCFZ_BJ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BK-ZCFZ_BK1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BM-ZCFZ_BM1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BN-ZCFZ_BN1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BQ-ZCFZ_BQ1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BS-ZCFZ_BS1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BT-ZCFZ_BT1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BU-ZCFZ_BU1)>0&& (ZCFZ_BW-ZCFZ_BW1)-(ZCFZ_BV-ZCFZ_BV1)>0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。','',NULL,'G100001',NULL,0),
(3514,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AO1-ZCFZ_AO>0&&(ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AO1-ZCFZ_AO)-(ZCFZ_BW1-ZCFZ_BW)>0','短期借款大幅度减少，考虑该借款是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，合理规划资金安排，控制资金压力。','',NULL,'G100001',NULL,0),
(3515,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AS1-ZCFZ_AS>0&&(ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AS1-ZCFZ_AS)-(ZCFZ_BW1-ZCFZ_BW)>0','由于以公允价值计量且其变动计入当期损益的金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','',NULL,'G100001',NULL,0),
(3516,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AT1-ZCFZ_AT>0&&(ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AT1-ZCFZ_AT)-(ZCFZ_BW1-ZCFZ_BW)>0','由于衍生金融负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','',NULL,'G100001',NULL,0),
(3517,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AU1-ZCFZ_AU>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AU1-ZCFZ_AU)-(ZCFZ_BW1-ZCFZ_BW)>0','由于银行承兑汇票的付款期限最长为6个月，因此，使用票据实际上对企业来说可实现短期融资的目的，在短期现金流较为紧张的情况下，可考虑采取使用开具应付票据的方式减轻企业现金负担。然而，需注意以下可能产生的问题及风险：应付商业票据是购买企业在正常商业活动中向供应商承诺在将来特定时日、支付一笔固定货款的票据。与应付账款相比，应付商业票据由于提出了付款的书面承诺，因而更具有法律上的约束力。此外，企业应于汇票到期前将票款足额交存其开户银行，以免银行对企业进行计收利息及引起相关法律诉讼纠纷。同时建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3518,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AV1-ZCFZ_AV>0&&  (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BW1-ZCFZ_BW)>0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F>0','本期总负债较上期有所减少，主要是因为应付账款的减少。应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3519,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AV1-ZCFZ_AV>0&&  (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BW1-ZCFZ_BW)>0&&YBLFX_O<60&&YFZKZL_D+YFZKZL_E+YFZKZL_F==0','本期总负债较上期有所减少，主要是因为应付账款的减少。应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。应付账款周转天数<60天，企业付款速度较高、资金占有率低，建议企业对比应收账款的周转天数，如果应付账款周转天数少于应收账款的周转天数，企业流动资金不充足的可能性较高，需要通过融资等手段解决资金缺口。建议管理层提高采购的集中度从而加大对供应商的话语权，延长付款期限，便于企业资金运转。','',NULL,'G100001',NULL,0),
(3520,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AV1-ZCFZ_AV>0&&  (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BW1-ZCFZ_BW)>0&&YBLFX_O>=60&& YFZKZL_D+YFZKZL_E+YFZKZL_F>0','本期总负债较上期有所减少，主要是因为应付账款的减少。应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。在应付账款中，账龄超360日的应收账款余额为Rmb{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}。针对账龄超1年的应付账款，建议管理层分析其需偿还的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流或同供应商谈判延后付款等方式，择优选择对自身最有利的方案，以防出现现金断流情况。同时，查看与相关供应商的合同，针对合同提及的违约责任等，考虑企业可能需承担的法律责任和违约赔偿。','{(YFZKZL_D+YFZKZL_E+YFZKZL_F)/10000}',NULL,'G100001',NULL,0),
(3521,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AV1-ZCFZ_AV>0&&  (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AV1-ZCFZ_AV)-(ZCFZ_BW1-ZCFZ_BW)>0&&YBLFX_O>=60&& YFZKZL_D+YFZKZL_E+YFZKZL_F==0','本期总负债较上期有所减少，主要是因为应付账款的减少。应付账款有所减少，管理层需关注减少原因及还款后企业现金流是否充足。此外，建议管理层与采购部查看针对主要供应商的付款数期变化，如应付账款的减少是因为数期缩短导致，管理层需考虑与供应商就数期问题进行协商，尽量延长付款周期。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3522,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AW1-ZCFZ_AW>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BW1-ZCFZ_BW)>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F>0','本期总负债较上期有所减少，主要是因为预收款项的下降。预收款项有所减少，首先需考虑是否与收入变动趋势一致，在不一致的情况下，需重点分析其减少原因。建议管理层与销售部门查看销售合同，并结合市场大环境，考虑预收款项的减少是否因产业经济环境下滑导致下游客户转嫁资金时间成本，合同收款条款进行了修改引起。在预收款项中，账龄超360日的预收款项余额为Rmb{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}万元。针对账龄超1年的预收款项，建议管理层结合销售合同，关注是否存在收入核算时点、计量金额不准确的问题。若不存在核算问题，则建议管理层关注是否因逾期1年的预收账款减少导致预收账款整体减少。若是，则建议继续跟进逾期1年预收账款减少是因转入收入还是因我司无法发货导致退款，若因我司无法发货导致退款，则需重点关注违约风险以及退款对我司资金流的影响。若否，则建议管理层重点关注逾期1年预收账款涉及的销售合同中收款方式、发货时点、违约责任等相关条款，若我司存在收到预收款后违约发货问题，则需评估违约风险对公司的不利影响。','{(YSKXZL_D+YSKXZL_E+YSKXZL_F)/10000}',NULL,'G100001',NULL,0),
(3523,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AW1-ZCFZ_AW>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AW1-ZCFZ_AW)-(ZCFZ_BW1-ZCFZ_BW)>0&&YSKXZL_D+YSKXZL_E+YSKXZL_F==0','本期总负债较上期有所减少，主要是因为预收款项的下降。预收款项有所减少，首先需考虑是否与收入变动趋势一致，在不一致的情况下，需重点分析其减少原因。建议管理层与销售部门查看销售合同，并结合市场大环境，考虑预收款项的减少是否因产业经济环境下滑导致下游客户转嫁资金时间成本，合同收款条款进行了修改引起。','',NULL,'G100001',NULL,0),
(3524,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_AZ1-ZCFZ_AZ>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_AZ1-ZCFZ_AZ)-(ZCFZ_BW1-ZCFZ_BW)>0','应付职工薪酬大幅度减少，考虑是否因正常人员减少引起的。若员工大量减少，需关注核心技术人员是否离职，人员减少后是否会对企业运营产生影响，需注意企业生产运营的稳定性。同时，若计划进行资本运作，则还需关注员工五险一金的缴纳是否按照相关规定执行，可能面临被主管单位要求补缴和处罚的情形。','',NULL,'G100001',NULL,0),
(3525,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BA1-ZCFZ_BA>0&&  (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BA1-ZCFZ_BA)-(ZCFZ_BW1-ZCFZ_BW)>0','应交税费的大幅度减少，主要考虑是否因业务的减少造成。若与业务不匹配，则考虑是否存在税收政策变化等特殊情况。建议使用本系统顾问咨询中的专项咨询，由专业顾问为企业进行税收筹划，达到合理避税，利润最大化的目的。','',NULL,'G100001',NULL,0),
(3526,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BB1-ZCFZ_BB>0&&  (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BB1-ZCFZ_BB)-(ZCFZ_BW1-ZCFZ_BW)>0','针对应付利息，提请管理层关注以下方面的问题：1、需查看借款合同，核查应付利息的确认时间和计量金额是否符合会计准则；2、关注付款期限及已支付金额，考虑自身资金压力；3、关注逾期未支付的违约责任及违约时间点。','',NULL,'G100001',NULL,0),
(3527,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BC1-ZCFZ_BC>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BC1-ZCFZ_BC)-(ZCFZ_BW1-ZCFZ_BW)>0','关注该科目的变动是否与企业宣告派发的股利相符合，同时需考虑支付能力，结合企业未来的生产经营计划关注资金压力问题。','',NULL,'G100001',NULL,0),
(3528,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BD1-ZCFZ_BD>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BW1-ZCFZ_BW)>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F>0','本期总负债较上期有所减少，主要是因为其他应付款的减少。其他应付款有所减少，需关注当前的资金状况是否充裕。此外，其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。在其他应付账款中，账龄超360日的其他应付款余额为Rmb{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}万元。针对账龄超1年的其他应付款，建议管理层分析其是否属于关联交易，并预估需付款的最快时间和最小金额，再结合企业自身资金情况，通过扩大销售增大现金流等方式，择优选择对自身最有利的方案，以防出现现金断流情况。','{(QTYFZL_D+QTYFZL_E+QTYFZL_F)/10000}',NULL,'G100001',NULL,0),
(3529,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BD1-ZCFZ_BD>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BD1-ZCFZ_BD)-(ZCFZ_BW1-ZCFZ_BW)>0&&QTYFZL_D+QTYFZL_E+QTYFZL_F==0','本期总负债较上期有所减少，主要是因为其他应付款的减少。其他应付款有所减少，需关注当前的资金状况是否充裕。此外，其他应付款为年度审计，上市审计的重点关注对象，建议管理层了解其构成，针对关联方往来，及时进行清理。','',NULL,'G100001',NULL,0),
(3530,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BI1-ZCFZ_BI>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BI1-ZCFZ_BI)-(ZCFZ_BW1-ZCFZ_BW)>0','由于持有待售的负债核算的类别较为特殊，且此类资产为非经营类负债，因此期末值的减少提请管理层考虑该负债减少的原因及金额，关注该变动金额的不确定性。若金额减少是因偿还债务，则还需考虑是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','',NULL,'G100001',NULL,0),
(3531,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BJ1-ZCFZ_BJ>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BJ1-ZCFZ_BJ)-(ZCFZ_BW1-ZCFZ_BW)>0','由于一年内到期的非流动负债主要为一年内到期的长期借款等，对于企业来说，由于之前的资金需求产生的贷款在近期内需进行偿还，因此需分析资金状况在未来一年内是否可以满足其偿还需求。若资金紧张，则需考虑通过借款、延长支付期限等方式缓解资金压力。','',NULL,'G100001',NULL,0),
(3532,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BK1-ZCFZ_BK>0&&  (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BK1-ZCFZ_BK)-(ZCFZ_BW1-ZCFZ_BW)>0','其他流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因及合理性。','',NULL,'G100001',NULL,0),
(3533,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BM1-ZCFZ_BM>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BM1-ZCFZ_BM)-(ZCFZ_BW1-ZCFZ_BW)>0','长期借款的减少，考虑该借款是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','',NULL,'G100001',NULL,0),
(3534,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BN1-ZCFZ_BN>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BN1-ZCFZ_BN)-(ZCFZ_BW1-ZCFZ_BW)>0','应付债券的大幅度减少，考虑该债券是以自有资金还是以新增贷款偿还。若因自有资金偿还，则还需关注目前的资金余额；若以新增贷款偿还，则需考虑新增贷款的利率及期限、企业自身的现金流情况，重点注意新增短期贷款可能带来近期较大的还本付息压力。','',NULL,'G100001',NULL,0),
(3535,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BQ1-ZCFZ_BQ>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BQ1-ZCFZ_BQ)-(ZCFZ_BW1-ZCFZ_BW)>0','由于一般性经营较少使用此科目，建议管理层查看此科目核算的内容，关注发生的原因及合理性，看是否存在因记账错误导致的余额变动。如非上述原因，则需根据科目核算的性质，考虑未来分期付款或融资租赁时支付款项对现金流的影响。','',NULL,'G100001',NULL,0),
(3536,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BS1-ZCFZ_BS>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BS1-ZCFZ_BS)-(ZCFZ_BW1-ZCFZ_BW)>0','由于此科目的特殊性，建议管理层设置专人管理此科目的变动情况，并且针对用款进行专项审核及登记，做到专款专用，详细记录转款的增减情况。','',NULL,'G100001',NULL,0),
(3537,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BT1-ZCFZ_BT>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BT1-ZCFZ_BT)-(ZCFZ_BW1-ZCFZ_BW)>0','预计负债大额减少，需关注已支付负债的原因及数值，同时评估企业现有资金情况。同时由于预计负债的特殊性，建议管理层针对剩余预计负债专门进行实现程度的可能性分析，针对风险较高，较可能需要实际支付的预计负债，除考虑对现金流的影响外，还要考虑负债产生同时可能伴随的法律责任或风险，以及如未能承担负债偿还的情况下可能产生的法律责任及风险。尤其在股权转让中，受让方更应重视目标公司的预计负债问题。当发生债务追索时，将严重影响受让方的股份转让合同的利益和预期的收益。预计债务的承担问题建议列入风险负担条款在股权转让合同中予以约定。同时注意股权的转移并不影响到追索的对象，受让方在成为目标公司股东后，目标公司仍需对外承担相应责任，受让方再根据股权转让合同向出让方追偿。','',NULL,'G100001',NULL,0),
(3538,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BU1-ZCFZ_BU>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BV1-ZCFZ_BV)>0&& (ZCFZ_BU1-ZCFZ_BU)-(ZCFZ_BW1-ZCFZ_BW)>0','递延收益的减少，需关注减少的原因及转入收益的条件是否合规。特别是政府补贴产生的递延收益，管理层需重点关注补贴收入实现的相关条件，确保项目的开展符合政府相关规定。','',NULL,'G100001',NULL,0),
(3539,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BV1-ZCFZ_BV>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BV1-ZCFZ_BV)-(ZCFZ_BW1-ZCFZ_BW)>0','递延所得税负债的产生，是因为资产的账面价值小于计税基础，或负债的账面价值大于计税基础而，导致会计确认的所得税大于税法确认的所得税，从而产生递延所得税负债。递延所得税负债大幅度减少，需关注其确认条件、计量金额是否符合会计准则。同时，建议管理层检查是否按要求设立备查薄，方便管理。','',NULL,'G100001',NULL,0),
(3540,'1','资产负债表首页预警','ZCFZ_BY1-ZCFZ_BY>0&& ZCFZ_BW1-ZCFZ_BW>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AO1-ZCFZ_AO)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AS1-ZCFZ_AS)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AT1-ZCFZ_AT)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AU1-ZCFZ_AU)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AV1-ZCFZ_AV)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AW1-ZCFZ_AW)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_AZ1-ZCFZ_AZ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BA1-ZCFZ_BA)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BB1-ZCFZ_BB)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BC1-ZCFZ_BC)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BD1-ZCFZ_BD)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BI1-ZCFZ_BI)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BJ1-ZCFZ_BJ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BK1-ZCFZ_BK)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BM1-ZCFZ_BM)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BN1-ZCFZ_BN)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BQ1-ZCFZ_BQ)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BS1-ZCFZ_BS)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BT1-ZCFZ_BT)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BU1-ZCFZ_BU)>0&& (ZCFZ_BW1-ZCFZ_BW)-(ZCFZ_BV1-ZCFZ_BV)>0','其他非流动负债属于非经常性科目，若在期末发生大幅度的变动，建议管理层关注该变化的原因。','',NULL,'G100001',NULL,0),
(3651,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_A1!=0&& LR_A-LR_A1>0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0&&LR_A/XSSL_A-LR_A1/XSSL_A1>0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','净利润本期比上期有所增加，主要是因为营业收入的增加。营业收入本期比上年同期增长{(LR_A-LR_A1)/LR_A1*100}%，主要是因为平均销售单价的上升。建议管理层与销售部分析销售单价上涨的产品及地区，评估产品群对价格上涨的接受程度，考虑是否所有产品均可涨价，抑或存在一定的局限性。如果单价上涨主要由于针对某一大产品，需考虑单价上涨对双方长期合作关系可能产生的影响。评估竞争对手的价格与企业相比是否具有较强的价格竞争力，企业的涨价行为是否会因此造成客源的流失。','{(LR_A-LR_A1)/LR_A1*100}',NULL,'G200001',NULL,0),
(3652,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_A-LR_A1>0&& LR_A1!=0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0&&XSSL_A-XSSL_A1>0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)>0','净利润本期比上期有所增加，主要是因为营业收入的增加。营业收入本期比上年同期增长{(LR_A-LR_A1)/LR_A1*100}%，主要是因为销售量的大幅度增加。建议管理层与销售部分析销售量增长幅度最大的区域及产品，与市场部研究其增长模式是否可以在其他区域或产品中进行复制。同时，考虑销售量的增长是否具有可持续性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长。','{(LR_A-LR_A1)/LR_A1*100}',NULL,'G200001',NULL,0),
(3653,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_A1==0&& LR_A-LR_A1>0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0&&LR_A/XSSL_A-LR_A1/XSSL_A1>0&&(LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1>0','净利润本期比上期有所增加，主要是因为营业收入的增加。营业收入本期比上年同期增长-%，主要是因为平均销售单价的上升。建议管理层与销售部分析销售单价上涨的产品及地区，评估产品群对价格上涨的接受程度，考虑是否所有产品均可涨价，抑或存在一定的局限性。如果单价上涨主要由于针对某一大产品，需考虑单价上涨对双方长期合作关系可能产生的影响。评估竞争对手的价格与企业相比是否具有较强的价格竞争力，企业的涨价行为是否会因此造成客源的流失。','',NULL,'G200001',NULL,0),
(3654,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_A-LR_A1>0&& LR_A1==0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&&(LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0&&XSSL_A-XSSL_A1>0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)>0','净利润本期比上期有所增加，主要是因为营业收入的增加。营业收入本期比上年同期增长-%，主要是因为销售量的大幅度增加。建议管理层与销售部分析销售量增长幅度最大的区域及产品，与市场部研究其增长模式是否可以在其他区域或产品中进行复制。同时，考虑销售量的增长是否具有可持续性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长。','',NULL,'G200001',NULL,0),
(3655,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_A1==0&&LR_A-LR_A1>0&&(LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&&(LR_A-LR_A1)-(LR_P1-LR_P)>0&&(LR_A-LR_A1)-(LR_Q1-LR_Q)>0&& (LR_A-LR_A1)-(LR_R1-LR_R)>0&&(LR_A-LR_A1)-(LR_S1-LR_S)>0&&(LR_A-LR_A1)-(LR_T-LR_T1)>0&&(LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0&&XSSL_A-XSSL_A1>0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)>0&&XSSL_A1==0','净利润本期比上期有所增加，主要是因为营业收入的增加。营业收入本期比上年同期增长-%。由于上期数据缺失，导致无法分析收入变动的主要驱动因素。建议管理层补充系统数据以便进行分析。','',NULL,'G200001',NULL,0),
(3656,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_A1-LR_A>0&& LR_A1!=0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&& (LR_A1-LR_A)-(LR_O-LR_O1)>0&& (LR_A1-LR_A)-(LR_P-LR_P1)>0&&(LR_A1-LR_A)-(LR_Q-LR_Q1)>0&& (LR_A1-LR_A)-(LR_R-LR_R1)>0&& (LR_A1-LR_A)-(LR_S-LR_S1)>0&& (LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&& (LR_A1-LR_A)-(LR_W1-LR_W)>0&& (LR_A1-LR_A)-(LR_X1-LR_X)>0&& (LR_A1-LR_A)-(LR_Z1-LR_Z)>0&& (LR_A1-LR_A)-(LR_AB-LR_AB1)>0&& (LR_A1-LR_A)-(LR_AE-LR_AE1)>0&&LR_A/XSSL_A-LR_A1/XSSL_A1<0&& (LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','净利润本期比上期有所减少，主要是因为营业收入的减少。营业收入本期比上年同期减少{(LR_A1-LR_A)/LR_A1*100}%，主要是因为平均销售单价的降低。建议管理层与销售部分析销售单价降低的产品及地区，评估产品群对价格的敏感性，考虑是否所有产品均可适当涨价，提高企业利润。如果单价降低主要由于针对某一大产品，需考虑单价降低对双方长期合作关系可能产生的影响及评估该措施的利弊。同时，评估竞争对手的价格与企业相比是否具有较强的价格竞争力，后期企业的涨价行为是否会因此造成客源的流失。','{(LR_A1-LR_A)/LR_A1*100}',NULL,'G200001',NULL,0),
(3657,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_A1-LR_A>0&&LR_A1!=0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&& (LR_A1-LR_A)-(LR_O-LR_O1)>0&& (LR_A1-LR_A)-(LR_P-LR_P1)>0&&(LR_A1-LR_A)-(LR_Q-LR_Q1)>0&& (LR_A1-LR_A)-(LR_R-LR_R1)>0&& (LR_A1-LR_A)-(LR_S-LR_S1)>0&& (LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&& (LR_A1-LR_A)-(LR_W1-LR_W)>0&& (LR_A1-LR_A)-(LR_X1-LR_X)>0&& (LR_A1-LR_A)-(LR_Z1-LR_Z)>0&& (LR_A1-LR_A)-(LR_AB-LR_AB1)>0&& (LR_A1-LR_A)-(LR_AE-LR_AE1)>0&&XSSL_A-XSSL_A1<0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)<0','净利润本期比上期有所减少，主要是因为营业收入的减少。营业收入本期比上年同期减少{(LR_A1-LR_A)/LR_A1*100}%，主要是因为销售量的大幅度降低。建议管理层与销售部分析销售量降低幅度最大的区域及产品，与市场部研究其降低原因，考虑销售量的降低是否具有不可逆转性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长，维持市场份额。','{(LR_A1-LR_A)/LR_A1*100}',NULL,'G200001',NULL,0),
(3658,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_A1-LR_A>0&& LR_A1==0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&& (LR_A1-LR_A)-(LR_O-LR_O1)>0&& (LR_A1-LR_A)-(LR_P-LR_P1)>0&&(LR_A1-LR_A)-(LR_Q-LR_Q1)>0&& (LR_A1-LR_A)-(LR_R-LR_R1)>0&& (LR_A1-LR_A)-(LR_S-LR_S1)>0&& (LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&& (LR_A1-LR_A)-(LR_W1-LR_W)>0&& (LR_A1-LR_A)-(LR_X1-LR_X)>0&& (LR_A1-LR_A)-(LR_Z1-LR_Z)>0&& (LR_A1-LR_A)-(LR_AB-LR_AB1)>0&& (LR_A1-LR_A)-(LR_AE-LR_AE1)>0&&LR_A/XSSL_A-LR_A1/XSSL_A1<0&& (LR_A/XSSL_A)/(LR_A1/XSSL_A1)-XSSL_A/XSSL_A1<0','净利润本期比上期有所减少，主要是因为营业收入的减少。营业收入本期比上年同期减少-%，主要是因为平均销售单价的降低。建议管理层与销售部分析销售单价降低的产品及地区，评估产品群对价格的敏感性，考虑是否所有产品均可适当涨价，提高企业利润。如果单价降低主要由于针对某一大产品，需考虑单价降低对双方长期合作关系可能产生的影响及评估该措施的利弊。同时，评估竞争对手的价格与企业相比是否具有较强的价格竞争力，后期企业的涨价行为是否会因此造成客源的流失。','',NULL,'G200001',NULL,0),
(3659,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_A1-LR_A>0&&LR_A1==0&&(LR_A1-LR_A)-(LR_F-LR_F1)>0&& (LR_A1-LR_A)-(LR_O-LR_O1)>0&& (LR_A1-LR_A)-(LR_P-LR_P1)>0&& (LR_A1-LR_A)-(LR_Q-LR_Q1)>0&& (LR_A1-LR_A)-(LR_R-LR_R1)>0&& (LR_A1-LR_A)-(LR_S-LR_S1)>0&& (LR_A1-LR_A)-(LR_T1-LR_T)>0&&(LR_A1-LR_A)-(LR_U1-LR_U)>0&& (LR_A1-LR_A)-(LR_W1-LR_W)>0&& (LR_A1-LR_A)-(LR_X1-LR_X)>0&& (LR_A1-LR_A)-(LR_Z1-LR_Z)>0&& (LR_A1-LR_A)-(LR_AB-LR_AB1)>0&& (LR_A1-LR_A)-(LR_AE-LR_AE1)>0&&XSSL_A-XSSL_A1<0&&XSSL_A/XSSL_A1-(LR_A/XSSL_A)/(LR_A1/XSSL_A1)<0','净利润本期比上期有所减少，主要是因为营业收入的减少。营业收入本期比上年同期减少-%，主要是因为销售量的大幅度降低。建议管理层与销售部分析销售量降低幅度最大的区域及产品，与市场部研究其降低原因，考虑销售量的降低是否具有不可逆转性，如为偶发行为，则需考虑促销、广告宣传等措施刺激销售增长，维持市场份额。','',NULL,'G200001',NULL,0),
(3660,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)>0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为原材料单价的上涨。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 与供应商商讨原材料议价空间，同时加强成本控制管理，降低成本，提高利润。此外，建议管理层咨询市场部及采购部相关人员，如短期内原材料采购成本无法降低，则由市场部评估价格调整的可能性，以及产品对价格上升空间的接纳程度。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3661,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& CLCB_B-CLCB_B1>0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为材料耗用数量的增加。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 是否生产流程管理不善导致的材料损耗上升，管理层应考虑加强生产管理，减少损耗和质量事故，改善生产工艺；3. 是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑加强原材料入库前检测并对采购部进行相关考核；4. 耗用量增加可能导致原来的安全库存达不到生产的要求。管理层需考虑调整或优化安全库存的必要性，对原材料进行有效管理。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3662,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&ZJCB_A-ZJCB_A1>0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)>0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为折旧成本的大幅度上涨。建议管理层查看设备投入以及设备运作情况，加大适用效率，与生产部及市场部讨论产量与销量的最合适配比，以达到利润最大化。同时，做好设备维护，减少大修及设备修理的支出，以达到控制成本的目的。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3663,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&SDCB_A-SDCB_A1>0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)>0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)>0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)>0 ','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为水电成本的大幅度上涨。建议管理层关注水电成本的增长是因为水电单价的增长亦或因水电耗量增大而导致成本的增长，同时做好设备检修维护以及提高人工效率，确保设备在更低的耗电量中输出更大功率，从而控制成本。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3664,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&RGCB_A-RGCB_A1>0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)>0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)>0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为人工成本及费用的上涨。建议管理层考虑通过绩效改革，控制加班时间等措施，尽量减低人工成本上涨对总成本造成的压力。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3665,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1!=0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&QTCB_A-QTCB_A1>0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)>0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)>0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层咨询专业机构或采用企业咨询服务模块，对可能存在或延续的问题咨询专家意见。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'G200001',NULL,0),
(3666,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)>0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要是因为原材料单价的上涨。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 与供应商商讨原材料议价空间，同时加强成本控制管理，降低成本，提高利润。此外，建议管理层咨询市场部及采购部相关人员，如短期内原材料采购成本无法降低，则由市场部评估价格调整的可能性，以及产品对价格上升空间的接纳程度。','',NULL,'G200001',NULL,0),
(3667,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& CLCB_B-CLCB_B1>0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要是因为材料耗用数量的增加。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 是否生产流程管理不善导致的材料损耗上升，管理层应考虑加强生产管理，减少损耗和质量事故，改善生产工艺；3. 是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑加强原材料入库前检测并对采购部进行相关考核；4. 耗用量增加可能导致原来的安全库存达不到生产的要求。管理层需考虑调整或优化安全库存的必要性，对原材料进行有效管理。','',NULL,'G200001',NULL,0),
(3668,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&ZJCB_A-ZJCB_A1>0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)>0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要是因为折旧成本的大幅度上涨。建议管理层查看设备投入以及设备运作情况，加大适用效率，与生产部及市场部讨论产量与销量的最合适配比，以达到利润最大化。同时，做好设备维护，减少大修及设备修理的支出，以达到控制成本的目的。','',NULL,'G200001',NULL,0),
(3669,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&SDCB_A-SDCB_A1>0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)>0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)>0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)>0 ','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要是因为水电成本的大幅度上涨。建议管理层关注水电成本的增长是因为水电单价的增长亦或因水电耗量增大而导致成本的增长，同时做好设备检修维护以及提高人工效率，确保设备在更低的耗电量中输出更大功率，从而控制成本。','',NULL,'G200001',NULL,0),
(3670,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&RGCB_A-RGCB_A1>0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)>0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)>0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要是因为人工成本及费用的上涨。建议管理层考虑通过绩效改革，控制加班时间等措施，尽量减低人工成本上涨对总成本造成的压力。','',NULL,'G200001',NULL,0),
(3671,'2','利润表首页预警','LR_AF-LR_AF1<0&&LR_F-LR_F1>0&&LR_F1==0&&(LR_F-LR_F1)-(LR_A1-LR_A)>0&&(LR_F-LR_F1)-(LR_O-LR_O1)>0&&(LR_F-LR_F1)-(LR_P-LR_P1)>0&&(LR_F-LR_F1)-(LR_Q-LR_Q1)>0&&(LR_F-LR_F1)-(LR_R-LR_R1)>0&&(LR_F-LR_F1)-(LR_S-LR_S1)>0&&(LR_F-LR_F1)-(LR_T1-LR_T)>0&&(LR_F-LR_F1)-(LR_U1-LR_U)>0&&  (LR_F-LR_F1)-(LR_W1-LR_W)>0&&  (LR_F-LR_F1)-(LR_X1-LR_X)>0&&  (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&&  (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&&  (LR_F-LR_F1)-(LR_AE-LR_AE1)>0&&QTCB_A-QTCB_A1>0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)>0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)>0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)>0','净利润本期比上期有所减少，主要是因为营业成本的增加。营业成本本期比上年同期增长-%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层咨询专业机构或采用企业咨询服务模块，对可能存在或延续的问题咨询专家意见。','',NULL,'G200001',NULL,0),
(3672,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)<0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为原材料单价的下降。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 是否加强了供应商的管理，提升了对供应商的议价能力，以及成本控制管理取得成效，考虑成本进一步压缩的可能性以及如何在降低单价的同时保证原材料的质量。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3673,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& CLCB_B-CLCB_B1<0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为材料耗用数量的减少。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 材料耗用减少的幅度如接近或低于订单减少幅度，这种情况应考虑是否生产流程管理不善导致的材料损耗上升以及是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑采取措施改善生产管理及加强材料采购控制。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3674,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&ZJCB_A-ZJCB_A1<0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)<0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为折旧成本的下降。建议管理层分析折旧成本下降的原因，考虑是否因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3675,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&SDCB_A-SDCB_A1<0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)<0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)<0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)<0 ','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为水电成本的大幅度降低。建议管理层关注水电单价是否统一降低或因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3676,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&&(LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&RGCB_A-RGCB_A1<0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)<0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)<0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为人工成本下降。建议管理层查看人工成本下降的原因，如为员工人数减少导致的人工成本总体金额的减少，要考虑人员的缩减是否与未来销售与生产计划相匹配；如为人工构成变化导致的下降，需与人力资源管理部门研究员工对人工构成的变化调整的接纳程度以及对人员稳定性的影响，从而评估人员流动性对未来销售及生产计划可能产生的影响。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3677,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1!=0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&QTCB_A-QTCB_A1<0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)<0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)<0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后营业成本增长。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'G200001',NULL,0),
(3678,'2','利润表首页预警','LR_AF-LR_AF1>0&&LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)<0&& (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要是因为原材料单价的下降。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 是否加强了供应商的管理，提升了对供应商的议价能力，以及成本控制管理取得成效，考虑成本进一步压缩的可能性以及如何在降低单价的同时保证原材料的质量。','',NULL,'G200001',NULL,0),
(3679,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&&CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& CLCB_B-CLCB_B1>0&& CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要是因为材料耗用数量的减少。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 材料耗用减少的幅度如接近或低于订单减少幅度，这种情况应考虑是否生产流程管理不善导致的材料损耗上升以及是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑采取措施改善生产管理及加强材料采购控制。','',NULL,'G200001',NULL,0),
(3680,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&& ZJCB_A-ZJCB_A1<0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)<0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要是因为折旧成本的下降。建议管理层分析折旧成本下降的原因，考虑是否因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','',NULL,'G200001',NULL,0),
(3681,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&& SDCB_A-SDCB_A1<0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)<0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)<0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要是因为水电成本的大幅度降低。建议管理层关注水电单价是否统一降低或因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','',NULL,'G200001',NULL,0),
(3682,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&& RGCB_A-RGCB_A1<0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)<0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)<0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要是因为人工成本下降。建议管理层查看人工成本下降的原因，如为员工人数减少导致的人工成本总体金额的减少，要考虑人员的缩减是否与未来销售与生产计划相匹配；如为人工构成变化导致的下降，需与人力资源管理部门研究员工对人工构成的变化调整的接纳程度以及对人员稳定性的影响，从而评估人员流动性对未来销售及生产计划可能产生的影响。','',NULL,'G200001',NULL,0),
(3683,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& LR_F1==0&&(LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0&& QTCB_A-QTCB_A1<0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)<0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)<0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)<0','净利润本期比上期有所增加，主要是因为营业成本的减少。营业成本本期比上年同期减少-%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后营业成本增长。','',NULL,'G200001',NULL,0),
(3684,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_O-LR_O1>0&&  LR_O1!=0&&(LR_O-LR_O1)-(LR_A1-LR_A)>0&&  (LR_O-LR_O1)-(LR_F-LR_F1)>0&&  (LR_O-LR_O1)-(LR_P-LR_P1)>0&&  (LR_O-LR_O1)-(LR_Q-LR_Q1)>0&&  (LR_O-LR_O1)-(LR_R-LR_R1)>0&&  (LR_O-LR_O1)-(LR_S-LR_S1)>0&&  (LR_O-LR_O1)-(LR_T1-LR_T)>0&&  (LR_O-LR_O1)-(LR_U1-LR_U)>0&&  (LR_O-LR_O1)-(LR_W1-LR_W)>0&&  (LR_O-LR_O1)-(LR_X1-LR_X)>0&&  (LR_O-LR_O1)-(LR_Z1-LR_Z)>0&&  (LR_O-LR_O1)-(LR_AB-LR_AB1)>0&&  (LR_O-LR_O1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为税金及附加的增加。税金及附加本期比上期增长{(LR_O-LR_O1)/LR_O1*100}%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收政策变化、进一步核查本期可抵扣税额，查看是否存在税率调增、不再享有免税政策以及大量发票不可抵扣的情况，从而规范发票管理及排查税务风险。','{(LR_O-LR_O1)/LR_O1*100}',NULL,'G200001',NULL,0),
(3685,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_O-LR_O1>0&&  LR_O1==0&&(LR_O-LR_O1)-(LR_A1-LR_A)>0&&  (LR_O-LR_O1)-(LR_F-LR_F1)>0&&  (LR_O-LR_O1)-(LR_P-LR_P1)>0&&  (LR_O-LR_O1)-(LR_Q-LR_Q1)>0&&  (LR_O-LR_O1)-(LR_R-LR_R1)>0&&  (LR_O-LR_O1)-(LR_S-LR_S1)>0&&  (LR_O-LR_O1)-(LR_T1-LR_T)>0&&  (LR_O-LR_O1)-(LR_U1-LR_U)>0&&  (LR_O-LR_O1)-(LR_W1-LR_W)>0&&  (LR_O-LR_O1)-(LR_X1-LR_X)>0&&  (LR_O-LR_O1)-(LR_Z1-LR_Z)>0&&  (LR_O-LR_O1)-(LR_AB-LR_AB1)>0&&  (LR_O-LR_O1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为税金及附加的增加。税金及附加本期比上期增长-%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收政策变化、进一步核查本期可抵扣税额，查看是否存在税率调增、不再享有免税政策以及大量发票不可抵扣的情况，从而规范发票管理及排查税务风险。','',NULL,'G200001',NULL,0),
(3686,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_O1-LR_O>0&& LR_O1!=0&&(LR_O1-LR_O)-(LR_A-LR_A1)>0&& (LR_O1-LR_O)-(LR_F1-LR_F)>0&& (LR_O1-LR_O)-(LR_P1-LR_P)>0&& (LR_O1-LR_O)-(LR_Q1-LR_Q)>0&& (LR_O1-LR_O)-(LR_R1-LR_R)>0&& (LR_O1-LR_O)-(LR_S1-LR_S)>0&& (LR_O1-LR_O)-(LR_T-LR_T1)>0&& (LR_O1-LR_O)-(LR_U-LR_U1)>0&& (LR_O1-LR_O)-(LR_W-LR_W1)>0&& (LR_O1-LR_O)-(LR_X-LR_X1)>0&& (LR_O1-LR_O)-(LR_Z-LR_Z1)>0&& (LR_O1-LR_O)-(LR_AB1-LR_AB)>0&& (LR_O1-LR_O)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为税金及附加的减少。税金及附加本期比上期下降{(LR_O1-LR_O)/LR_O1*100}%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收是否存在税率调减、享有免税政策的情况，确保税负降低的合理性。','{(LR_O1-LR_O)/LR_O1*100}',NULL,'G200001',NULL,0),
(3687,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_O1-LR_O>0&& LR_O1==0&&(LR_O1-LR_O)-(LR_A-LR_A1)>0&& (LR_O1-LR_O)-(LR_F1-LR_F)>0&& (LR_O1-LR_O)-(LR_P1-LR_P)>0&& (LR_O1-LR_O)-(LR_Q1-LR_Q)>0&& (LR_O1-LR_O)-(LR_R1-LR_R)>0&& (LR_O1-LR_O)-(LR_S1-LR_S)>0&& (LR_O1-LR_O)-(LR_T-LR_T1)>0&& (LR_O1-LR_O)-(LR_U-LR_U1)>0&& (LR_O1-LR_O)-(LR_W-LR_W1)>0&& (LR_O1-LR_O)-(LR_X-LR_X1)>0&& (LR_O1-LR_O)-(LR_Z-LR_Z1)>0&& (LR_O1-LR_O)-(LR_AB1-LR_AB)>0&& (LR_O1-LR_O)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为税金及附加的减少。税金及附加本期比上期下降-%，税金及附加同营业收入关联性较强，比较分析两期的税金及附加/营业收入，同时关注税收是否存在税率调减、享有免税政策的情况，确保税负降低的合理性。','',NULL,'G200001',NULL,0),
(3688,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1!=0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_RG-XSFY_RG1>0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为销售人工成本的增加。建议管理层查看人工成本增加的原因。如为员工人数增加导致的总体人工金额增加，需考虑销售团队人员数量与销售计划的匹配性；如为销售人员工资构成的调整等因素引起的人工成本的增加，需考虑销售人员的薪酬机制是否合理，是否与市场水平挂钩，薪酬的增加是否达到预期的市场开拓效果。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G200001',NULL,0),
(3689,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1!=0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_CL-XSFY_CL1>0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为差旅费用的大幅度增加。建议管理层查看差旅费用增加幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加强成本费用的控制。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G200001',NULL,0),
(3690,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1!=0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_TG-XSFY_TG1>0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为广告费、促销费、推广费、设计费支出的增加。建议管理层查看广告及促销费用增加的趋势与销售收入的变动趋势是否一致，评估费用增加对收入的影响，是否带来了预期的市场效果，从而考虑是否需要调整市场开拓方针。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G200001',NULL,0),
(3691,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1!=0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_ZD-XSFY_ZD1>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要是因为业务招待费的增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G200001',NULL,0),
(3692,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1!=0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_QT-XSFY_QT1>0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长{(LR_P-LR_P1)/LR_P1*100}%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用增长。','{(LR_P-LR_P1)/LR_P1*100}',NULL,'G200001',NULL,0),
(3693,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1==0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_RG-XSFY_RG1>0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长-%，主要是因为销售人工成本的增加。建议管理层查看人工成本增加的原因。如为员工人数增加导致的总体人工金额增加，需考虑销售团队人员数量与销售计划的匹配性；如为销售人员工资构成的调整等因素引起的人工成本的增加，需考虑销售人员的薪酬机制是否合理，是否与市场水平挂钩，薪酬的增加是否达到预期的市场开拓效果。','',NULL,'G200001',NULL,0),
(3694,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1==0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_CL-XSFY_CL1>0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长-%，主要是因为差旅费用的大幅度增加。建议管理层查看差旅费用增加幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加强成本费用的控制。','',NULL,'G200001',NULL,0),
(3695,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1==0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_TG-XSFY_TG1>0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长-%，主要是因为广告费、促销费、推广费、设计费支出的增加。建议管理层查看广告及促销费用增加的趋势与销售收入的变动趋势是否一致，评估费用增加对收入的影响，是否带来了预期的市场效果，从而考虑是否需要调整市场开拓方针。','',NULL,'G200001',NULL,0),
(3696,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1==0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_ZD-XSFY_ZD1>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)>0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长-%，主要是因为业务招待费的增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','',NULL,'G200001',NULL,0),
(3697,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&&  LR_P1==0&&(LR_P-LR_P1)-(LR_A1-LR_A)>0&&  (LR_P-LR_P1)-(LR_F-LR_F1)>0&&  (LR_P-LR_P1)-(LR_O-LR_O1)>0&&  (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&&  (LR_P-LR_P1)-(LR_R-LR_R1)>0&&(LR_P-LR_P1)-(LR_S-LR_S1)>0&&(LR_P-LR_P1)-(LR_T1-LR_T)>0&&(LR_P-LR_P1)-(LR_U1-LR_U)>0&&  (LR_P-LR_P1)-(LR_W1-LR_W)>0&&  (LR_P-LR_P1)-(LR_X1-LR_X)>0&&  (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&&  (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&&  (LR_P-LR_P1)-(LR_AE-LR_AE1)>0&&XSFY_QT-XSFY_QT1>0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)>0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)>0','净利润本期比上期有所减少，主要是因为销售费用的增加。销售费用本期比上年同期增长-%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用增长。','',NULL,'G200001',NULL,0),
(3698,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1!=0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_RG-XSFY_RG1<0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为销售人工成本的减少。建议管理层查看人工成本减少的原因。如为员工人数减少导致的总体人工金额减少，需考虑销售团队人员的调整对销售计划已经未来销售收入的总体影响；如为销售人员工资构成的调整等因素引起的人工成本的减少，需考虑销售人员对薪酬机制的满意程度以及可能引起的人员流动，从而评估销售人员流动对销售收入及增长可能产生的影响。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G200001',NULL,0),
(3699,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1!=0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_CL-XSFY_CL1<0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为差旅费用的大幅度减少。建议管理层查看差旅费用减少幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加大市场开拓的力度，调整市场开拓的方式。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G200001',NULL,0),
(3700,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1!=0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_TG-XSFY_TG1<0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为广告费、促销费、推广费、设计费支出的减少。建议管理层查看广告及促销费用减少的趋势与销售收入的变动趋势是否一致，评估费用缩减对收入的影响，从而考虑是否需要调整市场开拓方针。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G200001',NULL,0),
(3701,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1!=0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_ZD-XSFY_ZD1<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要是因为业务招待费的减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G200001',NULL,0),
(3702,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1!=0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_QT-XSFY_QT1<0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少{(LR_P1-LR_P)/LR_P1*100}%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出减少所导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用减少。','{(LR_P1-LR_P)/LR_P1*100}',NULL,'G200001',NULL,0),
(3703,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1==0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_RG-XSFY_RG1<0&& (XSFY_RG-XSFY_RG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_RG-XSFY_RG1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少-%，主要是因为销售人工成本的减少。建议管理层查看人工成本减少的原因。如为员工人数减少导致的总体人工金额减少，需考虑销售团队人员的调整对销售计划已经未来销售收入的总体影响；如为销售人员工资构成的调整等因素引起的人工成本的减少，需考虑销售人员对薪酬机制的满意程度以及可能引起的人员流动，从而评估销售人员流动对销售收入及增长可能产生的影响。','',NULL,'G200001',NULL,0),
(3704,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1==0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_CL-XSFY_CL1<0&& (XSFY_CL-XSFY_CL1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_CL-XSFY_CL1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少-%，主要是因为差旅费用的大幅度减少。建议管理层查看差旅费用减少幅度与人工成本、销售收入等的总体趋势是否一致，考虑是否需要加大市场开拓的力度，调整市场开拓的方式。','',NULL,'G200001',NULL,0),
(3705,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1==0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_TG-XSFY_TG1<0&& (XSFY_TG-XSFY_TG1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_TG-XSFY_TG1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少-%，主要是因为广告费、促销费、推广费、设计费支出的减少。建议管理层查看广告及促销费用减少的趋势与销售收入的变动趋势是否一致，评估费用缩减对收入的影响，从而考虑是否需要调整市场开拓方针。','',NULL,'G200001',NULL,0),
(3706,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1==0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_ZD-XSFY_ZD1<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_RG-XSFY_RG1)<0&& (XSFY_ZD-XSFY_ZD1)-(XSFY_QT-XSFY_QT1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少-%，主要是因为业务招待费的减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','',NULL,'G200001',NULL,0),
(3707,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& LR_P1==0&&(LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0&&XSFY_QT-XSFY_QT1<0&& (XSFY_QT-XSFY_QT1)-(XSFY_CL-XSFY_CL1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_TG-XSFY_TG1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_ZD-XSFY_ZD1)<0&& (XSFY_QT-XSFY_QT1)-(XSFY_RG-XSFY_RG1)<0','净利润本期比上期有所增加，主要是因为销售费用的减少。销售费用本期比上年同期减少-%，主要由除人工、差旅、市场推广、业务招待等主要项目外的剩余支出减少所导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后的费用减少。','',NULL,'G200001',NULL,0),
(3708,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1!=0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_RG-GLFY_RG1>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为管理人员人工成本增加。建议管理层查看工资上涨的原因，与人力资源部门讨论控制工资上涨的方式。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3709,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1!=0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_ZJ-GLFY_ZJ1>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为办公用固定资产大幅度增加，导致折旧金额相应增加，建议管理层做好固定资产管理，包括固定资产卡片，台账等的管理等。此外，建议管理层评估大幅度增加管理用固定资产的必要性，做好支出管理。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3710,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1!=0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_ZD-GLFY_ZD1>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是因为业务招待费增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3711,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1!=0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_QT-GLFY_QT1>0&& (GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长{(LR_Q-LR_Q1)/LR_Q1*100}%，主要是由于除人工、折旧、业务招待外的剩余支出的增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层采用本系统在线顾问服务模块中的顾问咨询功能，对可能存在或延续的问题咨询专家意见。','{(LR_Q-LR_Q1)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3712,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1==0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_RG-GLFY_RG1>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长-%，主要是因为管理人员人工成本增加。建议管理层查看工资上涨的原因，与人力资源部门讨论控制工资上涨的方式。','',NULL,'G200001',NULL,0),
(3713,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1==0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_ZJ-GLFY_ZJ1>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)>0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长-%，主要是因为办公用固定资产大幅度增加，导致折旧金额相应增加，建议管理层做好固定资产管理，包括固定资产卡片，台账等的管理等。此外，建议管理层评估大幅度增加管理用固定资产的必要性，做好支出管理。','',NULL,'G200001',NULL,0),
(3714,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1==0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_ZD-GLFY_ZD1>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长-%，主要是因为业务招待费增加。建议管理层关注业务招待费增长的主要原因，防范出现员工大量不合理费用支出情形。','',NULL,'G200001',NULL,0),
(3715,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& LR_Q1==0&&(LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0&&GLFY_QT-GLFY_QT1>0&& (GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)>0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)>0','净利润本期比上期有所减少，主要是因为管理费用的增加。管理费用本期比上年同期增长-%，主要是由于除人工、折旧、业务招待外的剩余支出的增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层采用本系统在线顾问服务模块中的顾问咨询功能，对可能存在或延续的问题咨询专家意见。','',NULL,'G200001',NULL,0),
(3716,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1!=0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_RG-GLFY_RG1<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为管理人员人工成本减少。建议管理层查看人工减少的原因，考虑未来人员配置的调整，并评估对净利润以及现金流的影响。','',NULL,'G200001',NULL,0),
(3717,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1!=0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_ZJ-GLFY_ZJ1<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为折旧减少。建议管理层查看折旧减少原因，如本年内大量报废办公设备，需考虑未来的固定资产购置计划，以及办公设备的购置对现金流以及净利润的影响。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3718,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1!=0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_ZD-GLFY_ZD1<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是因为业务招待费减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3719,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1!=0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_QT-GLFY_QT1<0&& (GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少{(LR_Q1-LR_Q)/LR_Q1*100}%，主要是由于除人工、折旧、业务招待外的剩余支出的减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，应扣除这一事项后进行分析。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。','{(LR_Q1-LR_Q)/LR_Q1*100}',NULL,'G200001',NULL,0),
(3720,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1==0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_RG-GLFY_RG1<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_RG-GLFY_RG1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少-%，主要是因为管理人员人工成本减少。建议管理层查看人工减少的原因，考虑未来人员配置的调整，并评估对净利润以及现金流的影响。','',NULL,'G200001',NULL,0),
(3721,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1==0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_ZJ-GLFY_ZJ1<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_ZD-GLFY_ZD1)<0&& (GLFY_ZJ-GLFY_ZJ1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少-%，主要是因为折旧减少。建议管理层查看折旧减少原因，如本年内大量报废办公设备，需考虑未来的固定资产购置计划，以及办公设备的购置对现金流以及净利润的影响。','',NULL,'G200001',NULL,0),
(3722,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1==0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_ZD-GLFY_ZD1<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_ZD-GLFY_ZD1)-(GLFY_QT-GLFY_QT1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少-%，主要是因为业务招待费减少。建议管理层关注业务招待费降低的主要原因，如外部形势好，无需大量的公共支出或内部费用控制合理，并评估费用进一步压缩的可能性。','',NULL,'G200001',NULL,0),
(3723,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&& LR_Q1==0&&(LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0&&GLFY_QT-GLFY_QT1<0&& (GLFY_QT-GLFY_QT1)-(GLFY_RG-GLFY_RG1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZJ-GLFY_ZJ1)<0&& (GLFY_QT-GLFY_QT1)-(GLFY_ZD-GLFY_ZD1)<0','净利润本期比上期有所增加，主要是因为管理费用的减少。管理费用本期比上年同期减少-%，主要是由于除人工、折旧、业务招待外的剩余支出的减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，应扣除这一事项后进行分析。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。','',NULL,'G200001',NULL,0),
(3724,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_R-LR_R1>0&& LR_R1!=0&&(LR_R-LR_R1)-(LR_A1-LR_A)>0&& (LR_R-LR_R1)-(LR_F-LR_F1)>0&& (LR_R-LR_R1)-(LR_O-LR_O1)>0&& (LR_R-LR_R1)-(LR_P-LR_P1)>0&& (LR_R-LR_R1)-(LR_Q-LR_Q1)>0&& (LR_R-LR_R1)-(LR_S-LR_S1)>0&& (LR_R-LR_R1)-(LR_T1-LR_T)>0&& (LR_R-LR_R1)-(LR_U1-LR_U)>0&& (LR_R-LR_R1)-(LR_W1-LR_W)>0&& (LR_R-LR_R1)-(LR_X1-LR_X)>0&& (LR_R-LR_R1)-(LR_Z1-LR_Z)>0&& (LR_R-LR_R1)-(LR_AB-LR_AB1)>0&& (LR_R-LR_R1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为财务费用的增加。财务费用本期比上期增长{(LR_R-LR_R1)/LR_R1*100}%，财务费用大幅度增加，成为净利润减少的主因。财务费用的大幅度增加，主要是因为本期贷款金额的增加。建议管理层结合资金情况，贷款情况，做好资金用途的管理，同时评估未来还款付息对资金流产生的压力，评估资金状况是否足以承受未来的还本付息所需的现金流。','{(LR_R-LR_R1)/LR_R1*100}',NULL,'G200001',NULL,0),
(3725,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_R-LR_R1>0&& LR_R1==0&&(LR_R-LR_R1)-(LR_A1-LR_A)>0&& (LR_R-LR_R1)-(LR_F-LR_F1)>0&& (LR_R-LR_R1)-(LR_O-LR_O1)>0&& (LR_R-LR_R1)-(LR_P-LR_P1)>0&& (LR_R-LR_R1)-(LR_Q-LR_Q1)>0&& (LR_R-LR_R1)-(LR_S-LR_S1)>0&& (LR_R-LR_R1)-(LR_T1-LR_T)>0&& (LR_R-LR_R1)-(LR_U1-LR_U)>0&& (LR_R-LR_R1)-(LR_W1-LR_W)>0&& (LR_R-LR_R1)-(LR_X1-LR_X)>0&& (LR_R-LR_R1)-(LR_Z1-LR_Z)>0&& (LR_R-LR_R1)-(LR_AB-LR_AB1)>0&& (LR_R-LR_R1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为财务费用的增加。财务费用本期比上期增长-%，财务费用大幅度增加，成为净利润减少的主因。财务费用的大幅度增加，主要是因为本期贷款金额的增加。建议管理层结合资金情况，贷款情况，做好资金用途的管理，同时评估未来还款付息对资金流产生的压力，评估资金状况是否足以承受未来的还本付息所需的现金流。','',NULL,'G200001',NULL,0),
(3726,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_R1-LR_R>0&& LR_R1!=0&&(LR_R1-LR_R)-(LR_A-LR_A1)>0&& (LR_R1-LR_R)-(LR_F1-LR_F)>0&& (LR_R1-LR_R)-(LR_O1-LR_O)>0&& (LR_R1-LR_R)-(LR_P1-LR_P)>0&& (LR_R1-LR_R)-(LR_Q1-LR_Q)>0&& (LR_R1-LR_R)-(LR_S1-LR_S)>0&& (LR_R1-LR_R)-(LR_T-LR_T1)>0&& (LR_R1-LR_R)-(LR_U-LR_U1)>0&& (LR_R1-LR_R)-(LR_W-LR_W1)>0&& (LR_R1-LR_R)-(LR_X-LR_X1)>0&& (LR_R1-LR_R)-(LR_Z-LR_Z1)>0&& (LR_R1-LR_R)-(LR_AB1-LR_AB)>0&& (LR_R1-LR_R)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为财务费用的减少。财务费用本期比上期减少{(LR_R1-LR_R)/LR_R1*100}%，本期财务费用大幅度减少，主要是因为利息支出的减少。建议管理层结合贷款及现金流情况，考虑是否需要更新融资计划或进行增资，如需进行股权或债权融资，需考虑未来换本付息等对现金流的压力。','{(LR_R1-LR_R)/LR_R1*100}',NULL,'G200001',NULL,0),
(3727,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_R1-LR_R>0&& LR_R1==0&&(LR_R1-LR_R)-(LR_A-LR_A1)>0&& (LR_R1-LR_R)-(LR_F1-LR_F)>0&& (LR_R1-LR_R)-(LR_O1-LR_O)>0&& (LR_R1-LR_R)-(LR_P1-LR_P)>0&& (LR_R1-LR_R)-(LR_Q1-LR_Q)>0&& (LR_R1-LR_R)-(LR_S1-LR_S)>0&& (LR_R1-LR_R)-(LR_T-LR_T1)>0&& (LR_R1-LR_R)-(LR_U-LR_U1)>0&& (LR_R1-LR_R)-(LR_W-LR_W1)>0&& (LR_R1-LR_R)-(LR_X-LR_X1)>0&& (LR_R1-LR_R)-(LR_Z-LR_Z1)>0&& (LR_R1-LR_R)-(LR_AB1-LR_AB)>0&& (LR_R1-LR_R)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为财务费用的减少。财务费用本期比上期减少-%，本期财务费用大幅度减少，主要是因为利息支出的减少。建议管理层结合贷款及现金流情况，考虑是否需要更新融资计划或进行增资，如需进行股权或债权融资，需考虑未来换本付息等对现金流的压力。','',NULL,'G200001',NULL,0),
(3728,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_S-LR_S1>0&& LR_S1!=0&&(LR_S-LR_S1)-(LR_A1-LR_A)>0&& (LR_S-LR_S1)-(LR_F-LR_F1)>0&& (LR_S-LR_S1)-(LR_O-LR_O1)>0&& (LR_S-LR_S1)-(LR_P-LR_P1)>0&& (LR_S-LR_S1)-(LR_Q-LR_Q1)>0&& (LR_S-LR_S1)-(LR_R-LR_R1)>0&& (LR_S-LR_S1)-(LR_T1-LR_T)>0&& (LR_S-LR_S1)-(LR_U1-LR_U)>0&& (LR_S-LR_S1)-(LR_W1-LR_W)>0&& (LR_S-LR_S1)-(LR_X1-LR_X)>0&& (LR_S-LR_S1)-(LR_Z1-LR_Z)>0&& (LR_S-LR_S1)-(LR_AB-LR_AB1)>0&& (LR_S-LR_S1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为资产减值损失的增加。资产减值损失本期比上期增长{(LR_S-LR_S1)/LR_S1*100}%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施减少损失，同时，特别警惕因技术变革、行业创新导致公司资产大幅度减值的情况。','{(LR_S-LR_S1)/LR_S1*100}',NULL,'G200001',NULL,0),
(3729,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_S-LR_S1>0&& LR_S1==0&&(LR_S-LR_S1)-(LR_A1-LR_A)>0&& (LR_S-LR_S1)-(LR_F-LR_F1)>0&& (LR_S-LR_S1)-(LR_O-LR_O1)>0&& (LR_S-LR_S1)-(LR_P-LR_P1)>0&& (LR_S-LR_S1)-(LR_Q-LR_Q1)>0&& (LR_S-LR_S1)-(LR_R-LR_R1)>0&& (LR_S-LR_S1)-(LR_T1-LR_T)>0&& (LR_S-LR_S1)-(LR_U1-LR_U)>0&& (LR_S-LR_S1)-(LR_W1-LR_W)>0&& (LR_S-LR_S1)-(LR_X1-LR_X)>0&& (LR_S-LR_S1)-(LR_Z1-LR_Z)>0&& (LR_S-LR_S1)-(LR_AB-LR_AB1)>0&& (LR_S-LR_S1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为资产减值损失的增加。资产减值损失本期比上期增长-%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施减少损失，同时，特别警惕因技术变革、行业创新导致公司资产大幅度减值的情况。','',NULL,'G200001',NULL,0),
(3730,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_S1-LR_S>0&& LR_S1!=0&&(LR_S1-LR_S)-(LR_A-LR_A1)>0&& (LR_S1-LR_S)-(LR_F1-LR_F)>0&& (LR_S1-LR_S)-(LR_O1-LR_O)>0&& (LR_S1-LR_S)-(LR_P1-LR_P)>0&& (LR_S1-LR_S)-(LR_Q1-LR_Q)>0&& (LR_S1-LR_S)-(LR_R1-LR_R)>0&& (LR_S1-LR_S)-(LR_T-LR_T1)>0&& (LR_S1-LR_S)-(LR_U-LR_U1)>0&& (LR_S1-LR_S)-(LR_W-LR_W1)>0&& (LR_S1-LR_S)-(LR_X-LR_X1)>0&& (LR_S1-LR_S)-(LR_Z-LR_Z1)>0&& (LR_S1-LR_S)-(LR_AB1-LR_AB)>0&& (LR_S1-LR_S)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为资产减值损失的减少。资产减值损失本期比上期减少{(LR_S1-LR_S)/LR_S1*100}%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施进一步降低损失，提升利润空间，同时，需防范因技术变革、行业创新初步导致公司资产减值的情形。','{(LR_S1-LR_S)/LR_S1*100}',NULL,'G200001',NULL,0),
(3731,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_S1-LR_S>0&& LR_S1==0&&(LR_S1-LR_S)-(LR_A-LR_A1)>0&& (LR_S1-LR_S)-(LR_F1-LR_F)>0&& (LR_S1-LR_S)-(LR_O1-LR_O)>0&& (LR_S1-LR_S)-(LR_P1-LR_P)>0&& (LR_S1-LR_S)-(LR_Q1-LR_Q)>0&& (LR_S1-LR_S)-(LR_R1-LR_R)>0&& (LR_S1-LR_S)-(LR_T-LR_T1)>0&& (LR_S1-LR_S)-(LR_U-LR_U1)>0&& (LR_S1-LR_S)-(LR_W-LR_W1)>0&& (LR_S1-LR_S)-(LR_X-LR_X1)>0&& (LR_S1-LR_S)-(LR_Z-LR_Z1)>0&& (LR_S1-LR_S)-(LR_AB1-LR_AB)>0&& (LR_S1-LR_S)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为资产减值损失的减少。资产减值损失本期比上期减少-%，建议管理层关注资产减值损失的明细，了解减值原因和具体金额，考虑是否可采取相应措施进一步降低损失，提升利润空间，同时，需防范因技术变革、行业创新初步导致公司资产减值的情形。','',NULL,'G200001',NULL,0),
(3732,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_T-LR_T1>0&& LR_T1!=0&&(LR_T-LR_T1)-(LR_F1-LR_F)>0&& (LR_T-LR_T1)-(LR_O1-LR_O)>0&& (LR_T-LR_T1)-(LR_P1-LR_P)>0&& (LR_T-LR_T1)-(LR_Q1-LR_Q)>0&& (LR_T-LR_T1)-(LR_R1-LR_R)>0&& (LR_T-LR_T1)-(LR_S1-LR_S)>0&& (LR_T-LR_T1)-(LR_A-LR_A1)>0&& (LR_T-LR_T1)-(LR_U-LR_U1)>0&& (LR_T-LR_T1)-(LR_W-LR_W1)>0&& (LR_T-LR_T1)-(LR_X-LR_X1)>0&& (LR_T-LR_T1)-(LR_Z-LR_Z1)>0&& (LR_T-LR_T1)-(LR_AB1-LR_AB)>0&& (LR_T-LR_T1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为公允价值变动的增加。公允价值变动本期比上期增长{(LR_T-LR_T1)/LR_T1*100}%，由于公允价值变动为非经常性收益，剔除后，营业利润将下降。建议管理层考虑公允价值变动的性质，具体分析其增加原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_T-LR_T1)/LR_T1*100}',NULL,'G200001',NULL,0),
(3733,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_T-LR_T1>0&& LR_T1==0&&(LR_T-LR_T1)-(LR_F1-LR_F)>0&& (LR_T-LR_T1)-(LR_O1-LR_O)>0&& (LR_T-LR_T1)-(LR_P1-LR_P)>0&& (LR_T-LR_T1)-(LR_Q1-LR_Q)>0&& (LR_T-LR_T1)-(LR_R1-LR_R)>0&& (LR_T-LR_T1)-(LR_S1-LR_S)>0&& (LR_T-LR_T1)-(LR_A-LR_A1)>0&& (LR_T-LR_T1)-(LR_U-LR_U1)>0&& (LR_T-LR_T1)-(LR_W-LR_W1)>0&& (LR_T-LR_T1)-(LR_X-LR_X1)>0&& (LR_T-LR_T1)-(LR_Z-LR_Z1)>0&& (LR_T-LR_T1)-(LR_AB1-LR_AB)>0&& (LR_T-LR_T1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为公允价值变动的增加。公允价值变动本期比上期增长-%，由于公允价值变动为非经常性收益，剔除后，营业利润将下降。建议管理层考虑公允价值变动的性质，具体分析其增加原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3734,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_T1-LR_T>0&& LR_T1!=0&&(LR_T1-LR_T)-(LR_F-LR_F1)>0&& (LR_T1-LR_T)-(LR_O-LR_O1)>0&& (LR_T1-LR_T)-(LR_P-LR_P1)>0&& (LR_T1-LR_T)-(LR_Q-LR_Q1)>0&& (LR_T1-LR_T)-(LR_R-LR_R1)>0&& (LR_T1-LR_T)-(LR_S-LR_S1)>0&& (LR_T1-LR_T)-(LR_A1-LR_A)>0&& (LR_T1-LR_T)-(LR_U1-LR_U)>0&& (LR_T1-LR_T)-(LR_W1-LR_W)>0&& (LR_T1-LR_T)-(LR_X1-LR_X)>0&& (LR_T1-LR_T)-(LR_Z1-LR_Z)>0&& (LR_T1-LR_T)-(LR_AB-LR_AB1)>0&& (LR_T1-LR_T)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为公允价值变动的减少。公允价值变动本期比上期减少{(LR_T1-LR_T)/LR_T1*100}%，本期公允价值变动大幅度下降，管理层需关注变动原因，评估现有投资风险。由于公允价值变动为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑公允价值变动的性质及原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_T1-LR_T)/LR_T1*100}',NULL,'G200001',NULL,0),
(3735,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_T1-LR_T>0&& LR_T1==0&&(LR_T1-LR_T)-(LR_F-LR_F1)>0&& (LR_T1-LR_T)-(LR_O-LR_O1)>0&& (LR_T1-LR_T)-(LR_P-LR_P1)>0&& (LR_T1-LR_T)-(LR_Q-LR_Q1)>0&& (LR_T1-LR_T)-(LR_R-LR_R1)>0&& (LR_T1-LR_T)-(LR_S-LR_S1)>0&& (LR_T1-LR_T)-(LR_A1-LR_A)>0&& (LR_T1-LR_T)-(LR_U1-LR_U)>0&& (LR_T1-LR_T)-(LR_W1-LR_W)>0&& (LR_T1-LR_T)-(LR_X1-LR_X)>0&& (LR_T1-LR_T)-(LR_Z1-LR_Z)>0&& (LR_T1-LR_T)-(LR_AB-LR_AB1)>0&& (LR_T1-LR_T)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为公允价值变动的减少。公允价值变动本期比上期减少-%，本期公允价值变动大幅度下降，管理层需关注变动原因，评估现有投资风险。由于公允价值变动为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑公允价值变动的性质及原因，减少公允价值变动对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3736,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_U-LR_U1>0&& LR_U1!=0&&(LR_U-LR_U1)-(LR_F1-LR_F)>0&& (LR_U-LR_U1)-(LR_O1-LR_O)>0&& (LR_U-LR_U1)-(LR_P1-LR_P)>0&& (LR_U-LR_U1)-(LR_Q1-LR_Q)>0&& (LR_U-LR_U1)-(LR_R1-LR_R)>0&& (LR_U-LR_U1)-(LR_S1-LR_S)>0&& (LR_U-LR_U1)-(LR_A-LR_A1)>0&& (LR_U-LR_U1)-(LR_T-LR_T1)>0&& (LR_U-LR_U1)-(LR_W-LR_W1)>0&& (LR_U-LR_U1)-(LR_X-LR_X1)>0&& (LR_U-LR_U1)-(LR_Z-LR_Z1)>0&& (LR_U-LR_U1)-(LR_AB1-LR_AB)>0&& (LR_U-LR_U1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为投资收益的增加。投资收益本期比上期增长{(LR_U-LR_U1)/LR_U1*100}%，本期投资收益大幅度增加。由于投资收益为非经常性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，具体分析其增加原因，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_U-LR_U1)/LR_U1*100}',NULL,'G200001',NULL,0),
(3737,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_U-LR_U1>0&& LR_U1==0&&(LR_U-LR_U1)-(LR_F1-LR_F)>0&& (LR_U-LR_U1)-(LR_O1-LR_O)>0&& (LR_U-LR_U1)-(LR_P1-LR_P)>0&& (LR_U-LR_U1)-(LR_Q1-LR_Q)>0&& (LR_U-LR_U1)-(LR_R1-LR_R)>0&& (LR_U-LR_U1)-(LR_S1-LR_S)>0&& (LR_U-LR_U1)-(LR_A-LR_A1)>0&& (LR_U-LR_U1)-(LR_T-LR_T1)>0&& (LR_U-LR_U1)-(LR_W-LR_W1)>0&& (LR_U-LR_U1)-(LR_X-LR_X1)>0&& (LR_U-LR_U1)-(LR_Z-LR_Z1)>0&& (LR_U-LR_U1)-(LR_AB1-LR_AB)>0&& (LR_U-LR_U1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为投资收益的增加。投资收益本期比上期增长-%，本期投资收益大幅度增加。由于投资收益为非经常性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，具体分析其增加原因，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3738,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_U1-LR_U>0&& LR_U1!=0&&(LR_U1-LR_U)-(LR_F-LR_F1)>0&& (LR_U1-LR_U)-(LR_O-LR_O1)>0&& (LR_U1-LR_U)-(LR_P-LR_P1)>0&& (LR_U1-LR_U)-(LR_Q-LR_Q1)>0&& (LR_U1-LR_U)-(LR_R-LR_R1)>0&& (LR_U1-LR_U)-(LR_S-LR_S1)>0&& (LR_U1-LR_U)-(LR_A1-LR_A)>0&& (LR_U1-LR_U)-(LR_T1-LR_T)>0&& (LR_U1-LR_U)-(LR_W1-LR_W)>0&& (LR_U1-LR_U)-(LR_X1-LR_X)>0&& (LR_U1-LR_U)-(LR_Z1-LR_Z)>0&& (LR_U1-LR_U)-(LR_AB-LR_AB1)>0&& (LR_U1-LR_U)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为投资收益的减少。投资收益本期比上期减少{(LR_U1-LR_U)/LR_U1*100}%，本期投资收益大幅度下降，管理层需关注投资收益下降原因，审慎评估投资风险。由于投资收益为非经营性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_U1-LR_U)/LR_U1*100}',NULL,'G200001',NULL,0),
(3739,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_U1-LR_U>0&& LR_U1==0&&(LR_U1-LR_U)-(LR_F-LR_F1)>0&& (LR_U1-LR_U)-(LR_O-LR_O1)>0&& (LR_U1-LR_U)-(LR_P-LR_P1)>0&& (LR_U1-LR_U)-(LR_Q-LR_Q1)>0&& (LR_U1-LR_U)-(LR_R-LR_R1)>0&& (LR_U1-LR_U)-(LR_S-LR_S1)>0&& (LR_U1-LR_U)-(LR_A1-LR_A)>0&& (LR_U1-LR_U)-(LR_T1-LR_T)>0&& (LR_U1-LR_U)-(LR_W1-LR_W)>0&& (LR_U1-LR_U)-(LR_X1-LR_X)>0&& (LR_U1-LR_U)-(LR_Z1-LR_Z)>0&& (LR_U1-LR_U)-(LR_AB-LR_AB1)>0&& (LR_U1-LR_U)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为投资收益的减少。投资收益本期比上期减少-%，本期投资收益大幅度下降，管理层需关注投资收益下降原因，审慎评估投资风险。由于投资收益为非经营性收益，剔除投资收益后，营业利润将大幅度下降。建议管理层考虑投资收益的性质，减少投资收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3740,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_W-LR_W1>0&& LR_W1!=0&&(LR_W-LR_W1)-(LR_F1-LR_F)>0&& (LR_W-LR_W1)-(LR_O1-LR_O)>0&& (LR_W-LR_W1)-(LR_P1-LR_P)>0&& (LR_W-LR_W1)-(LR_Q1-LR_Q)>0&& (LR_W-LR_W1)-(LR_R1-LR_R)>0&& (LR_W-LR_W1)-(LR_S1-LR_S)>0&& (LR_W-LR_W1)-(LR_A-LR_A1)>0&& (LR_W-LR_W1)-(LR_T-LR_T1)>0&& (LR_W-LR_W1)-(LR_U-LR_U1)>0&& (LR_W-LR_W1)-(LR_X-LR_X1)>0&& (LR_W-LR_W1)-(LR_Z-LR_Z1)>0&& (LR_W-LR_W1)-(LR_AB1-LR_AB)>0&& (LR_W-LR_W1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为资产处置收益的增加。资产处置收益本期比上期增长{(LR_X-LR_X1)/LR_X1*100}%，本期资产处置收益大幅度增加。由于资产处置收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑资产处置收益的性质，具体分析其增加原因，减少资产处置收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X-LR_X1)/LR_X1*100}',NULL,'G200001',NULL,0),
(3741,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_W-LR_W1>0&& LR_W1==0&&(LR_W-LR_W1)-(LR_F1-LR_F)>0&& (LR_W-LR_W1)-(LR_O1-LR_O)>0&& (LR_W-LR_W1)-(LR_P1-LR_P)>0&& (LR_W-LR_W1)-(LR_Q1-LR_Q)>0&& (LR_W-LR_W1)-(LR_R1-LR_R)>0&& (LR_W-LR_W1)-(LR_S1-LR_S)>0&& (LR_W-LR_W1)-(LR_A-LR_A1)>0&& (LR_W-LR_W1)-(LR_T-LR_T1)>0&& (LR_W-LR_W1)-(LR_U-LR_U1)>0&& (LR_W-LR_W1)-(LR_X-LR_X1)>0&& (LR_W-LR_W1)-(LR_Z-LR_Z1)>0&& (LR_W-LR_W1)-(LR_AB1-LR_AB)>0&& (LR_W-LR_W1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为资产处置收益的增加。资产处置收益本期比上期增长-%，本期资产处置收益大幅度增加。由于资产处置收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑资产处置收益的性质，具体分析其增加原因，减少资产处置收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3742,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_W1-LR_W>0&& LR_W1!=0&&(LR_W1-LR_W)-(LR_F-LR_F1)>0&& (LR_W1-LR_W)-(LR_O-LR_O1)>0&& (LR_W1-LR_W)-(LR_P-LR_P1)>0&& (LR_W1-LR_W)-(LR_Q-LR_Q1)>0&& (LR_W1-LR_W)-(LR_R-LR_R1)>0&& (LR_W1-LR_W)-(LR_S-LR_S1)>0&& (LR_W1-LR_W)-(LR_A1-LR_A)>0&& (LR_W1-LR_W)-(LR_T1-LR_T)>0&& (LR_W1-LR_W)-(LR_U1-LR_U)>0&& (LR_W1-LR_W)-(LR_X1-LR_X)>0&& (LR_W1-LR_W)-(LR_Z1-LR_Z)>0&& (LR_W1-LR_W)-(LR_AB-LR_AB1)>0&& (LR_W1-LR_W)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为资产处置收益的减少。资产处置收益本期比上期减少{(LR_X1-LR_X)/LR_X1*100}%，本期资产处置收益大幅度下降。由于资产处置收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑资产处置收益的性质，具体分析其减少原因，减少资产处置收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X1-LR_X)/LR_X1*100}',NULL,'G200001',NULL,0),
(3743,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_W1-LR_W>0&& LR_W1==0&&(LR_W1-LR_W)-(LR_F-LR_F1)>0&& (LR_W1-LR_W)-(LR_O-LR_O1)>0&& (LR_W1-LR_W)-(LR_P-LR_P1)>0&& (LR_W1-LR_W)-(LR_Q-LR_Q1)>0&& (LR_W1-LR_W)-(LR_R-LR_R1)>0&& (LR_W1-LR_W)-(LR_S-LR_S1)>0&& (LR_W1-LR_W)-(LR_A1-LR_A)>0&& (LR_W1-LR_W)-(LR_T1-LR_T)>0&& (LR_W1-LR_W)-(LR_U1-LR_U)>0&& (LR_W1-LR_W)-(LR_X1-LR_X)>0&& (LR_W1-LR_W)-(LR_Z1-LR_Z)>0&& (LR_W1-LR_W)-(LR_AB-LR_AB1)>0&& (LR_W1-LR_W)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为资产处置收益的减少。资产处置收益本期比上期减少-%，本期资产处置收益大幅度下降。由于资产处置收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑资产处置收益的性质，具体分析其减少原因，减少资产处置收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3744,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_X-LR_X1>0&& LR_X1!=0&&(LR_X-LR_X1)-(LR_F1-LR_F)>0&& (LR_X-LR_X1)-(LR_O1-LR_O)>0&& (LR_X-LR_X1)-(LR_P1-LR_P)>0&& (LR_X-LR_X1)-(LR_Q1-LR_Q)>0&& (LR_X-LR_X1)-(LR_R1-LR_R)>0&& (LR_X-LR_X1)-(LR_S1-LR_S)>0&& (LR_X-LR_X1)-(LR_A-LR_A1)>0&& (LR_X-LR_X1)-(LR_T-LR_T1)>0&& (LR_X-LR_X1)-(LR_U-LR_U1)>0&& (LR_X-LR_X1)-(LR_W-LR_W1)>0&& (LR_X-LR_X1)-(LR_Z-LR_Z1)>0&& (LR_X-LR_X1)-(LR_AB1-LR_AB)>0&& (LR_X-LR_X1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为其他收益的增加。其他收益本期比上期增长{(LR_X-LR_X1)/LR_X1*100}%，本期其他收益大幅度增加。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其增加原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X-LR_X1)/LR_X1*100}',NULL,'G200001',NULL,0),
(3745,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_X-LR_X1>0&& LR_X1==0&&(LR_X-LR_X1)-(LR_F1-LR_F)>0&& (LR_X-LR_X1)-(LR_O1-LR_O)>0&& (LR_X-LR_X1)-(LR_P1-LR_P)>0&& (LR_X-LR_X1)-(LR_Q1-LR_Q)>0&& (LR_X-LR_X1)-(LR_R1-LR_R)>0&& (LR_X-LR_X1)-(LR_S1-LR_S)>0&& (LR_X-LR_X1)-(LR_A-LR_A1)>0&& (LR_X-LR_X1)-(LR_T-LR_T1)>0&& (LR_X-LR_X1)-(LR_U-LR_U1)>0&& (LR_X-LR_X1)-(LR_W-LR_W1)>0&& (LR_X-LR_X1)-(LR_Z-LR_Z1)>0&& (LR_X-LR_X1)-(LR_AB1-LR_AB)>0&& (LR_X-LR_X1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为其他收益的增加。其他收益本期比上期增长-%，本期其他收益大幅度增加。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其增加原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3746,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_X1-LR_X>0&& LR_X1!=0&&(LR_X1-LR_X)-(LR_F-LR_F1)>0&& (LR_X1-LR_X)-(LR_O-LR_O1)>0&& (LR_X1-LR_X)-(LR_P-LR_P1)>0&& (LR_X1-LR_X)-(LR_Q-LR_Q1)>0&& (LR_X1-LR_X)-(LR_R-LR_R1)>0&& (LR_X1-LR_X)-(LR_S-LR_S1)>0&& (LR_X1-LR_X)-(LR_A1-LR_A)>0&& (LR_X1-LR_X)-(LR_T1-LR_T)>0&& (LR_X1-LR_X)-(LR_U1-LR_U)>0&& (LR_X1-LR_X)-(LR_W1-LR_W)>0&& (LR_X1-LR_X)-(LR_Z1-LR_Z)>0&& (LR_X1-LR_X)-(LR_AB-LR_AB1)>0&& (LR_X1-LR_X)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为其他收益的减少。其他收益本期比上期减少{(LR_X1-LR_X)/LR_X1*100}%，本期其他收益大幅度下降。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其减少原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','{(LR_X1-LR_X)/LR_X1*100}',NULL,'G200001',NULL,0),
(3747,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_X1-LR_X>0&& LR_X1==0&&(LR_X1-LR_X)-(LR_F-LR_F1)>0&& (LR_X1-LR_X)-(LR_O-LR_O1)>0&& (LR_X1-LR_X)-(LR_P-LR_P1)>0&& (LR_X1-LR_X)-(LR_Q-LR_Q1)>0&& (LR_X1-LR_X)-(LR_R-LR_R1)>0&& (LR_X1-LR_X)-(LR_S-LR_S1)>0&& (LR_X1-LR_X)-(LR_A1-LR_A)>0&& (LR_X1-LR_X)-(LR_T1-LR_T)>0&& (LR_X1-LR_X)-(LR_U1-LR_U)>0&& (LR_X1-LR_X)-(LR_W1-LR_W)>0&& (LR_X1-LR_X)-(LR_Z1-LR_Z)>0&& (LR_X1-LR_X)-(LR_AB-LR_AB1)>0&& (LR_X1-LR_X)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为其他收益的减少。其他收益本期比上期减少-%，本期其他收益大幅度下降。由于其他收益为非经常性收益，剔除后，营业利润将大幅度下降。建议管理层考虑其他收益的性质，具体分析其减少原因，减少其他收益对净利润的影响金额，从而增强投资者对企业业务经营的信心。','',NULL,'G200001',NULL,0),
(3748,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Z-LR_Z1>0&& LR_Z1!=0&&(LR_Z-LR_Z1)-(LR_F1-LR_F)>0&& (LR_Z-LR_Z1)-(LR_O1-LR_O)>0&& (LR_Z-LR_Z1)-(LR_P1-LR_P)>0&& (LR_Z-LR_Z1)-(LR_Q1-LR_Q)>0&& (LR_Z-LR_Z1)-(LR_R1-LR_R)>0&& (LR_Z-LR_Z1)-(LR_S1-LR_S)>0&& (LR_Z-LR_Z1)-(LR_A-LR_A1)>0&& (LR_Z-LR_Z1)-(LR_T-LR_T1)>0&& (LR_Z-LR_Z1)-(LR_U-LR_U1)>0&& (LR_Z-LR_Z1)-(LR_W-LR_W1)>0&& (LR_Z-LR_Z1)-(LR_X-LR_X1)>0&& (LR_Z-LR_Z1)-(LR_AB1-LR_AB)>0&& (LR_Z-LR_Z1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为营业外收入的增加。营业外收入本期比上期增长{(LR_Z-LR_Z1)/LR_Z1*100}%，由于营业外收入为非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，并剔除历史数据中营业外收入对净利润的影响后，再分析净利润的变动原因。','{(LR_Z-LR_Z1)/LR_Z1*100}',NULL,'G200001',NULL,0),
(3749,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_Z-LR_Z1>0&& LR_Z1==0&&(LR_Z-LR_Z1)-(LR_F1-LR_F)>0&& (LR_Z-LR_Z1)-(LR_O1-LR_O)>0&& (LR_Z-LR_Z1)-(LR_P1-LR_P)>0&& (LR_Z-LR_Z1)-(LR_Q1-LR_Q)>0&& (LR_Z-LR_Z1)-(LR_R1-LR_R)>0&& (LR_Z-LR_Z1)-(LR_S1-LR_S)>0&& (LR_Z-LR_Z1)-(LR_A-LR_A1)>0&& (LR_Z-LR_Z1)-(LR_T-LR_T1)>0&& (LR_Z-LR_Z1)-(LR_U-LR_U1)>0&& (LR_Z-LR_Z1)-(LR_W-LR_W1)>0&& (LR_Z-LR_Z1)-(LR_X-LR_X1)>0&& (LR_Z-LR_Z1)-(LR_AB1-LR_AB)>0&& (LR_Z-LR_Z1)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为营业外收入的增加。营业外收入本期比上期增长-%，由于营业外收入为非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，并剔除历史数据中营业外收入对净利润的影响后，再分析净利润的变动原因。','',NULL,'G200001',NULL,0),
(3750,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Z1-LR_Z>0&& LR_Z1!=0&&(LR_Z1-LR_Z)-(LR_F-LR_F1)>0&& (LR_Z1-LR_Z)-(LR_O-LR_O1)>0&& (LR_Z1-LR_Z)-(LR_P-LR_P1)>0&& (LR_Z1-LR_Z)-(LR_Q-LR_Q1)>0&& (LR_Z1-LR_Z)-(LR_R-LR_R1)>0&& (LR_Z1-LR_Z)-(LR_S-LR_S1)>0&& (LR_Z1-LR_Z)-(LR_A1-LR_A)>0&& (LR_Z1-LR_Z)-(LR_T1-LR_T)>0&& (LR_Z1-LR_Z)-(LR_U1-LR_U)>0&& (LR_Z1-LR_Z)-(LR_W1-LR_W)>0&& (LR_Z1-LR_Z)-(LR_X1-LR_X)>0&& (LR_Z1-LR_Z)-(LR_AB-LR_AB1)>0&& (LR_Z1-LR_Z)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为营业外收入的减少。营业外收入本期比上期减少{(LR_Z1-LR_Z)/LR_Z1*100}%，营业外收入的减少，管理层需警惕。由于营业外收入非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，考虑主营业务的发展是否足以支撑企业未来的需求。','{(LR_Z1-LR_Z)/LR_Z1*100}',NULL,'G200001',NULL,0),
(3751,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_Z1-LR_Z>0&& LR_Z1==0&&(LR_Z1-LR_Z)-(LR_F-LR_F1)>0&& (LR_Z1-LR_Z)-(LR_O-LR_O1)>0&& (LR_Z1-LR_Z)-(LR_P-LR_P1)>0&& (LR_Z1-LR_Z)-(LR_Q-LR_Q1)>0&& (LR_Z1-LR_Z)-(LR_R-LR_R1)>0&& (LR_Z1-LR_Z)-(LR_S-LR_S1)>0&& (LR_Z1-LR_Z)-(LR_A1-LR_A)>0&& (LR_Z1-LR_Z)-(LR_T1-LR_T)>0&& (LR_Z1-LR_Z)-(LR_U1-LR_U)>0&& (LR_Z1-LR_Z)-(LR_W1-LR_W)>0&& (LR_Z1-LR_Z)-(LR_X1-LR_X)>0&& (LR_Z1-LR_Z)-(LR_AB-LR_AB1)>0&& (LR_Z1-LR_Z)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为营业外收入的减少。营业外收入本期比上期减少-%，营业外收入的减少，管理层需警惕。由于营业外收入非经营性收入，不具有持续性，在融资、上市等接受尽调或者审计时，均将作为模拟调整的对象，因此，建议管理层查看以前年度营业外收入的性质，考虑主营业务的发展是否足以支撑企业未来的需求。','',NULL,'G200001',NULL,0),
(3752,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_AB-LR_AB1>0&& LR_AB1!=0&&(LR_AB-LR_AB1)-(LR_A1-LR_A)>0&& (LR_AB-LR_AB1)-(LR_O-LR_O1)>0&& (LR_AB-LR_AB1)-(LR_P-LR_P1)>0&& (LR_AB-LR_AB1)-(LR_Q-LR_Q1)>0&& (LR_AB-LR_AB1)-(LR_R-LR_R1)>0&& (LR_AB-LR_AB1)-(LR_S-LR_S1)>0&& (LR_AB-LR_AB1)-(LR_T1-LR_T)>0&& (LR_AB-LR_AB1)-(LR_U1-LR_U)>0&& (LR_AB-LR_AB1)-(LR_W1-LR_W)>0&& (LR_AB-LR_AB1)-(LR_X1-LR_X)>0&& (LR_AB-LR_AB1)-(LR_Z1-LR_Z)>0&& (LR_AB-LR_AB1)-(LR_F-LR_F1)>0&& (LR_AB-LR_AB1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为营业外支出的增加。营业外支出本期比上期增长{(LR_AB-LR_AB1)/LR_AB1*100}%，营业外支出大幅增加，建议管理层关注是否发生了大额的资产处置损失，资产处置是否履行了审批制度并关注大额资产处置的原因。另外，营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','{(LR_AB-LR_AB1)/LR_AB1*100}',NULL,'G200001',NULL,0),
(3753,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_AB-LR_AB1>0&& LR_AB1==0&&(LR_AB-LR_AB1)-(LR_A1-LR_A)>0&& (LR_AB-LR_AB1)-(LR_O-LR_O1)>0&& (LR_AB-LR_AB1)-(LR_P-LR_P1)>0&& (LR_AB-LR_AB1)-(LR_Q-LR_Q1)>0&& (LR_AB-LR_AB1)-(LR_R-LR_R1)>0&& (LR_AB-LR_AB1)-(LR_S-LR_S1)>0&& (LR_AB-LR_AB1)-(LR_T1-LR_T)>0&& (LR_AB-LR_AB1)-(LR_U1-LR_U)>0&& (LR_AB-LR_AB1)-(LR_W1-LR_W)>0&& (LR_AB-LR_AB1)-(LR_X1-LR_X)>0&& (LR_AB-LR_AB1)-(LR_Z1-LR_Z)>0&& (LR_AB-LR_AB1)-(LR_F-LR_F1)>0&& (LR_AB-LR_AB1)-(LR_AE-LR_AE1)>0','净利润本期比上期有所减少，主要是因为营业外支出的增加。营业外支出本期比上期增长-%，营业外支出大幅增加，建议管理层关注是否发生了大额的资产处置损失，资产处置是否履行了审批制度并关注大额资产处置的原因。另外，营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','',NULL,'G200001',NULL,0),
(3754,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_AB1-LR_AB>0&& LR_AB1!=0&&(LR_AB1-LR_AB)-(LR_A-LR_A1)>0&& (LR_AB1-LR_AB)-(LR_O1-LR_O)>0&& (LR_AB1-LR_AB)-(LR_P1-LR_P)>0&& (LR_AB1-LR_AB)-(LR_Q1-LR_Q)>0&& (LR_AB1-LR_AB)-(LR_R1-LR_R)>0&& (LR_AB1-LR_AB)-(LR_S1-LR_S)>0&& (LR_AB1-LR_AB)-(LR_T-LR_T1)>0&& (LR_AB1-LR_AB)-(LR_U-LR_U1)>0&& (LR_AB1-LR_AB)-(LR_W-LR_W1)>0&& (LR_AB1-LR_AB)-(LR_X-LR_X1)>0&& (LR_AB1-LR_AB)-(LR_Z-LR_Z1)>0&& (LR_AB1-LR_AB)-(LR_F1-LR_F)>0&& (LR_AB1-LR_AB)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为营业外支出的减少。营业外支出本期比上期减少{(LR_AB1-LR_AB)/LR_AB1*100}%，由于营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','{(LR_AB1-LR_AB)/LR_AB1*100}',NULL,'G200001',NULL,0),
(3755,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_AB1-LR_AB>0&& LR_AB1==0&&(LR_AB1-LR_AB)-(LR_A-LR_A1)>0&& (LR_AB1-LR_AB)-(LR_O1-LR_O)>0&& (LR_AB1-LR_AB)-(LR_P1-LR_P)>0&& (LR_AB1-LR_AB)-(LR_Q1-LR_Q)>0&& (LR_AB1-LR_AB)-(LR_R1-LR_R)>0&& (LR_AB1-LR_AB)-(LR_S1-LR_S)>0&& (LR_AB1-LR_AB)-(LR_T-LR_T1)>0&& (LR_AB1-LR_AB)-(LR_U-LR_U1)>0&& (LR_AB1-LR_AB)-(LR_W-LR_W1)>0&& (LR_AB1-LR_AB)-(LR_X-LR_X1)>0&& (LR_AB1-LR_AB)-(LR_Z-LR_Z1)>0&& (LR_AB1-LR_AB)-(LR_F1-LR_F)>0&& (LR_AB1-LR_AB)-(LR_AE1-LR_AE)>0','净利润本期比上期有所增加，主要是因为营业外支出的减少。营业外支出本期比上期减少-%，由于营业外支出为非经营性支出，不具有持续性。建议管理层剔除两期营业外支出后，重新评估净利润的变动情况及趋势，并相应做出管理决策。','',NULL,'G200001',NULL,0),
(3756,'2','利润表首页预警','LR_AF1-LR_AF>0&& LR_AE-LR_AE1>0&& LR_AE1!=0&&(LR_AE-LR_AE1)-(LR_A1-LR_A)>0&& (LR_AE-LR_AE1)-(LR_O-LR_O1)>0&& (LR_AE-LR_AE1)-(LR_P-LR_P1)>0&& (LR_AE-LR_AE1)-(LR_Q-LR_Q1)>0&& (LR_AE-LR_AE1)-(LR_R-LR_R1)>0&& (LR_AE-LR_AE1)-(LR_S-LR_S1)>0&& (LR_AE-LR_AE1)-(LR_T1-LR_T)>0&& (LR_AE-LR_AE1)-(LR_U1-LR_U)>0&& (LR_AE-LR_AE1)-(LR_W1-LR_W)>0&& (LR_AE-LR_AE1)-(LR_X1-LR_X)>0&& (LR_AE-LR_AE1)-(LR_Z1-LR_Z)>0&& (LR_AE-LR_AE1)-(LR_F-LR_F1)>0&& (LR_AE-LR_AE1)-(LR_AB-LR_AB1)>0','净利润本期比上期有所减少，主要是因为所得税费用的增加。所得税费用本期比上期增长{(LR_AE-LR_AE1)/LR_AE1*100}%，建议管理层关注所得税申报中不得抵扣项的原因及金额，考虑是否需要聘请专业团队为企业进行税收筹划，达到合理避税，增加净利润的目的。','{(LR_AE-LR_AE1)/LR_AE1*100}',NULL,'G200001',NULL,0),
(3757,'2','利润表首页预警','LR_AF1-LR_AF>0&&LR_AE-LR_AE1>0&& LR_AE1==0&&(LR_AE-LR_AE1)-(LR_A1-LR_A)>0&& (LR_AE-LR_AE1)-(LR_O-LR_O1)>0&& (LR_AE-LR_AE1)-(LR_P-LR_P1)>0&& (LR_AE-LR_AE1)-(LR_Q-LR_Q1)>0&& (LR_AE-LR_AE1)-(LR_R-LR_R1)>0&& (LR_AE-LR_AE1)-(LR_S-LR_S1)>0&& (LR_AE-LR_AE1)-(LR_T1-LR_T)>0&& (LR_AE-LR_AE1)-(LR_U1-LR_U)>0&& (LR_AE-LR_AE1)-(LR_W1-LR_W)>0&& (LR_AE-LR_AE1)-(LR_X1-LR_X)>0&& (LR_AE-LR_AE1)-(LR_Z1-LR_Z)>0&& (LR_AE-LR_AE1)-(LR_F-LR_F1)>0&& (LR_AE-LR_AE1)-(LR_AB-LR_AB1)>0','净利润本期比上期有所减少，主要是因为所得税费用的增加。所得税费用本期比上期增长-%，建议管理层关注所得税申报中不得抵扣项的原因及金额，考虑是否需要聘请专业团队为企业进行税收筹划，达到合理避税，增加净利润的目的。','',NULL,'G200001',NULL,0),
(3758,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_AE1-LR_AE>0&& LR_AE1!=0&&(LR_AE1-LR_AE)-(LR_A-LR_A1)>0&& (LR_AE1-LR_AE)-(LR_O1-LR_O)>0&& (LR_AE1-LR_AE)-(LR_P1-LR_P)>0&& (LR_AE1-LR_AE)-(LR_Q1-LR_Q)>0&& (LR_AE1-LR_AE)-(LR_R1-LR_R)>0&& (LR_AE1-LR_AE)-(LR_S1-LR_S)>0&& (LR_AE1-LR_AE)-(LR_T-LR_T1)>0&& (LR_AE1-LR_AE)-(LR_U-LR_U1)>0&& (LR_AE1-LR_AE)-(LR_W-LR_W1)>0&& (LR_AE1-LR_AE)-(LR_X-LR_X1)>0&& (LR_AE1-LR_AE)-(LR_Z-LR_Z1)>0&& (LR_AE1-LR_AE)-(LR_F1-LR_F)>0&& (LR_AE1-LR_AE)-(LR_AB1-LR_AB)>0','净利润本期比上期有所增加，主要是因为所得税费用的减少。所得税费用本期比上期减少{(LR_AE1-LR_AE)/LR_AE1*100}%，所得税费用的大幅度降低属于非经常性情况，建议管理层关注减少的原因，是否有享受优惠政策，注意优惠政策的可持续性。','{(LR_AE1-LR_AE)/LR_AE1*100}',NULL,'G200001',NULL,0),
(3759,'2','利润表首页预警','LR_AF-LR_AF1>0&& LR_AE1-LR_AE>0&& LR_AE1==0&&(LR_AE1-LR_AE)-(LR_A-LR_A1)>0&& (LR_AE1-LR_AE)-(LR_O1-LR_O)>0&& (LR_AE1-LR_AE)-(LR_P1-LR_P)>0&& (LR_AE1-LR_AE)-(LR_Q1-LR_Q)>0&& (LR_AE1-LR_AE)-(LR_R1-LR_R)>0&& (LR_AE1-LR_AE)-(LR_S1-LR_S)>0&& (LR_AE1-LR_AE)-(LR_T-LR_T1)>0&& (LR_AE1-LR_AE)-(LR_U-LR_U1)>0&& (LR_AE1-LR_AE)-(LR_W-LR_W1)>0&& (LR_AE1-LR_AE)-(LR_X-LR_X1)>0&& (LR_AE1-LR_AE)-(LR_Z-LR_Z1)>0&& (LR_AE1-LR_AE)-(LR_F1-LR_F)>0&& (LR_AE1-LR_AE)-(LR_AB1-LR_AB)>0','净利润本期比上期有所增加，主要是因为所得税费用的减少。所得税费用本期比上期减少-%，所得税费用的大幅度降低属于非经常性情况，建议管理层关注减少的原因，是否有享受优惠政策，注意优惠政策的可持续性。','',NULL,'G200001',NULL,0),
(3760,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)>0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1>0','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为原材料单价的上涨。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 与供应商商讨原材料议价空间，同时加强成本控制管理，降低成本，提高利润。此外，建议管理层咨询市场部及采购部相关人员，如短期内原材料采购成本无法降低，则由市场部评估价格调整的可能性，以及产品对价格上升空间的接纳程度。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3761,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& CLCB_B-CLCB_B1>0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)>0','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为材料耗用数量的增加。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 是否生产流程管理不善导致的材料损耗上升，管理层应考虑加强生产管理，减少损耗和质量事故，改善生产工艺；3. 是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑加强原材料入库前检测并对采购部进行相关考核；4. 耗用量增加可能导致原来的安全库存达不到生产的要求。管理层需考虑调整或优化安全库存的必要性，对原材料进行有效管理。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3762,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& ZJCB_A-ZJCB_A1>0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)>0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)>0','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为折旧成本的大幅度上涨。建议管理层查看设备投入以及设备运作情况，加大适用效率，与生产部及市场部讨论产量与销量的最合适配比，以达到利润最大化。同时，做好设备维护，减少大修及设备修理的支出，以达到控制成本的目的。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3763,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& SDCB_A-SDCB_A1>0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)>0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)>0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)>0 ','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为水电成本的大幅度上涨。建议管理层关注水电成本的增长是因为水电单价的增长亦或因水电耗量增大而导致成本的增长，同时做好设备检修维护以及提高人工效率，确保设备在更低的耗电量中输出更大功率，从而控制成本。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3764,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& RGCB_A-RGCB_A1>0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)>0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)>0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)>0','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要是因为人工成本及费用的上涨。建议管理层考虑通过绩效改革，控制加班时间等措施，尽量减低人工成本上涨对总成本造成的压力。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3765,'2','营业成本预警','LR_F1!=0&&LR_F-LR_F1>0&& QTCB_A-QTCB_A1>0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)>0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)>0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)>0','营业成本本期比上年同期增长{(LR_F-LR_F1)/LR_F1*100}%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层咨询专业机构或采用企业咨询服务模块，对可能存在或延续的问题咨询专家意见。','{(LR_F-LR_F1)/LR_F1*100}',NULL,'20002',NULL,0),
(3766,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)>0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1>0','营业成本本期比上年同期增长-%，主要是因为原材料单价的上涨。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 与供应商商讨原材料议价空间，同时加强成本控制管理，降低成本，提高利润。此外，建议管理层咨询市场部及采购部相关人员，如短期内原材料采购成本无法降低，则由市场部评估价格调整的可能性，以及产品对价格上升空间的接纳程度。','',NULL,'20002',NULL,0),
(3767,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& CLCB_C-CLCB_C1>0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)>0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)>0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)>0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)>0&& CLCB_B-CLCB_B1>0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)>0','营业成本本期比上年同期增长-%，主要是因为材料耗用数量的增加。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本增加；2. 是否生产流程管理不善导致的材料损耗上升，管理层应考虑加强生产管理，减少损耗和质量事故，改善生产工艺；3. 是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑加强原材料入库前检测并对采购部进行相关考核；4. 耗用量增加可能导致原来的安全库存达不到生产的要求。管理层需考虑调整或优化安全库存的必要性，对原材料进行有效管理。','',NULL,'20002',NULL,0),
(3768,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& ZJCB_A-ZJCB_A1>0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)>0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)>0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)>0','营业成本本期比上年同期增长-%，主要是因为折旧成本的大幅度上涨。建议管理层查看设备投入以及设备运作情况，加大适用效率，与生产部及市场部讨论产量与销量的最合适配比，以达到利润最大化。同时，做好设备维护，减少大修及设备修理的支出，以达到控制成本的目的。','',NULL,'20002',NULL,0),
(3769,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& SDCB_A-SDCB_A1>0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)>0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)>0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)>0 ','营业成本本期比上年同期增长-%，主要是因为水电成本的大幅度上涨。建议管理层关注水电成本的增长是因为水电单价的增长亦或因水电耗量增大而导致成本的增长，同时做好设备检修维护以及提高人工效率，确保设备在更低的耗电量中输出更大功率，从而控制成本。','',NULL,'20002',NULL,0),
(3770,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& RGCB_A-RGCB_A1>0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)>0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)>0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)>0','营业成本本期比上年同期增长-%，主要是因为人工成本及费用的上涨。建议管理层考虑通过绩效改革，控制加班时间等措施，尽量减低人工成本上涨对总成本造成的压力。','',NULL,'20002',NULL,0),
(3771,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1>0&& QTCB_A-QTCB_A1>0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)>0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)>0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)>0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)>0','营业成本本期比上年同期增长-%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出增加导致。建议管理层与财务人员查看增长原因，如为特殊时点或时间导致，属于非经常性事项，可以忽略。对于可能对未来生产经营产生重大影响的事项，需进行进一步分析。建议管理层咨询专业机构或采用企业咨询服务模块，对可能存在或延续的问题咨询专家意见。','',NULL,'20002',NULL,0),
(3772,'2','营业成本预警','LR_F-LR_F1<0&& CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)<0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为原材料单价的下降。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 是否加强了供应商的管理，提升了对供应商的议价能力，以及成本控制管理取得成效，考虑成本进一步压缩的可能性以及如何在降低单价的同时保证原材料的质量。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3773,'2','营业成本预警','LR_F-LR_F1<0&& CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& CLCB_B-CLCB_B1<0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为材料耗用数量的减少。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 材料耗用减少的幅度如接近或低于订单减少幅度，这种情况应考虑是否生产流程管理不善导致的材料损耗上升以及是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑采取措施改善生产管理及加强材料采购控制。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3774,'2','营业成本预警','LR_F-LR_F1<0&& ZJCB_A-ZJCB_A1<0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)<0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为折旧成本的下降。建议管理层分析折旧成本下降的原因，考虑是否因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3775,'2','营业成本预警','LR_F-LR_F1<0&& SDCB_A-SDCB_A1<0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)<0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)<0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为水电成本的大幅度降低。建议管理层关注水电单价是否统一降低或因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3776,'2','营业成本预警','LR_F-LR_F1<0&& RGCB_A-RGCB_A1<0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)<0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)<0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要是因为人工成本下降。建议管理层查看人工成本下降的原因，如为员工人数减少导致的人工成本总体金额的减少，要考虑人员的缩减是否与未来销售与生产计划相匹配；如为人工构成变化导致的下降，需与人力资源管理部门研究员工对人工构成的变化调整的接纳程度以及对人员稳定性的影响，从而评估人员流动性对未来销售及生产计划可能产生的影响。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3777,'2','营业成本预警','LR_F-LR_F1<0&& QTCB_A-QTCB_A1<0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)<0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)<0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)<0','营业成本本期比上年同期减少{(LR_F1-LR_F)/LR_F1*100}%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后营业成本增长。','{(LR_F1-LR_F)/LR_F1*100}',NULL,'20002',NULL,0),
(3778,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& (CLCB_A/CLCB_B-CLCB_A1/CLCB_B1)<0&&  (CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)-CLCB_B/CLCB_B1<0','营业成本本期比上年同期减少-%，主要是因为原材料单价的下降。建议管理层考虑：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 考虑原材料单价变动趋势是否与市场趋势相一致；3. 是否加强了供应商的管理，提升了对供应商的议价能力，以及成本控制管理取得成效，考虑成本进一步压缩的可能性以及如何在降低单价的同时保证原材料的质量。','',NULL,'20002',NULL,0),
(3779,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& CLCB_C-CLCB_C1<0&& (CLCB_C-CLCB_C1)-(ZJCB_A-ZJCB_A1)<0&& (CLCB_C-CLCB_C1)-(SDCB_A-SDCB_A1)<0&& (CLCB_C-CLCB_C1)-(RGCB_A-RGCB_A1)<0&& (CLCB_C-CLCB_C1)-(QTCB_A-QTCB_A1)<0&& CLCB_B-CLCB_B1<0&&                CLCB_B/CLCB_B1-(CLCB_A/CLCB_B)/(CLCB_A1/CLCB_B1)<0','营业成本本期比上年同期减少-%，主要是因为材料耗用数量的减少。建议管理层考虑耗用数量增长幅度及趋势是否与订单一致，如与订单趋势不一致，进一步分析其原因：1. 是否因为进销存数据问题导致成本核算出现问题，从而引起本期结转的营业成本减少；2. 材料耗用减少的幅度如接近或低于订单减少幅度，这种情况应考虑是否生产流程管理不善导致的材料损耗上升以及是否采购部采购过程的材料不达标造成的材料损耗增大，管理层应考虑采取措施改善生产管理及加强材料采购控制。','',NULL,'20002',NULL,0),
(3780,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& ZJCB_A-ZJCB_A1<0&& (ZJCB_A-ZJCB_A1)-(CLCB_C-CLCB_C1)<0&& (ZJCB_A-ZJCB_A1)-(SDCB_A-SDCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(RGCB_A-RGCB_A1)<0&& (ZJCB_A-ZJCB_A1)-(QTCB_A-QTCB_A1)<0','营业成本本期比上年同期减少-%，主要是因为折旧成本的下降。建议管理层分析折旧成本下降的原因，考虑是否因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','',NULL,'20002',NULL,0),
(3781,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& SDCB_A-SDCB_A1<0&& (SDCB_A-SDCB_A1)-(CLCB_C-CLCB_C1)<0&& (SDCB_A-SDCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (SDCB_A-SDCB_A1)-(RGCB_A-RGCB_A1)<0&& (SDCB_A-SDCB_A1)-(QTCB_A-QTCB_A1)<0 ','营业成本本期比上年同期减少-%，主要是因为水电成本的大幅度降低。建议管理层关注水电单价是否统一降低或因工艺改进、人工效率提高所致，同时，评估利润进一步提升的可能性。','',NULL,'20002',NULL,0),
(3782,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& RGCB_A-RGCB_A1<0&& (RGCB_A-RGCB_A1)-(CLCB_C-CLCB_C1)<0&& (RGCB_A-RGCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (RGCB_A-RGCB_A1)-(SDCB_A-SDCB_A1)<0&& (RGCB_A-RGCB_A1)-(QTCB_A-QTCB_A1)<0','营业成本本期比上年同期减少-%，主要是因为人工成本下降。建议管理层查看人工成本下降的原因，如为员工人数减少导致的人工成本总体金额的减少，要考虑人员的缩减是否与未来销售与生产计划相匹配；如为人工构成变化导致的下降，需与人力资源管理部门研究员工对人工构成的变化调整的接纳程度以及对人员稳定性的影响，从而评估人员流动性对未来销售及生产计划可能产生的影响。','',NULL,'20002',NULL,0),
(3783,'2','营业成本预警','LR_F1==0&&LR_F-LR_F1<0&& QTCB_A-QTCB_A1<0&& (QTCB_A-QTCB_A1)-(CLCB_C-CLCB_C1)<0&& (QTCB_A-QTCB_A1)-(ZJCB_A-ZJCB_A1)<0&& (QTCB_A-QTCB_A1)-(SDCB_A-SDCB_A1)<0&& (QTCB_A-QTCB_A1)-(RGCB_A-RGCB_A1)<0','营业成本本期比上年同期减少-%，主要由除人工、生产材料耗费、水电、折旧等主要项目外的剩余支出减少导致。建议管理层与财务人员查看减少原因，如为特殊时点或时间导致，属于非经常性事项，则需注意后续导致因素消失后营业成本增长。','',NULL,'20002',NULL,0),
(3784,'2','营业成本预警','LR_F-LR_F1==0','与上年同期相比，本期营业成本金额与上年同期保持一致，此情况较为特殊，建议管理层：1. 与财务人员核查金额准确性；2. 与营业收入进行对比，查看营业成本的维持不变是否合理；3. 通过与供应商谈判降低采购单价，调整产能利用率，通过绩效考核促进成本降低，或者调整人员结构等方式，降低成本，从而达到节流的目的，增大企业利润。','',NULL,'20002',NULL,0),
(3785,'2','利润表首页概述','LR_AF1!=0&&LR_AF - LR_AF1>0','本期净利润为Rmb{LR_AF/10000}万元，比上年同期增加{(LR_AF - LR_AF1)*100/Math.abs(LR_AF1)}%。','{LR_AF/10000},{(LR_AF - LR_AF1)*100/Math.abs(LR_AF1)}',NULL,'G2001',NULL,0),
(3786,'2','利润表首页概述','LR_AF1!=0&&LR_AF -LR_AF1<0','本期净利润为Rmb{LR_AF/10000}万元，比上年同期减少{(LR_AF1 - LR_AF)*100/Math.abs(LR_AF1)}%。','{LR_AF/10000},{(LR_AF1 - LR_AF)*100/Math.abs(LR_AF1)}',NULL,'G2001',NULL,0),
(3787,'2','利润表首页概述','LR_AF1!=0&&LR_AF-LR_AF1==0','本期净利润为Rmb{LR_AF/10000}万元，与上年同期持平，变动为0。','{LR_AF/10000}',NULL,'G2001',NULL,0),
(3788,'2','利润表首页概述','LR_AF1==0&&LR_AF>0','本期净利润为Rmb{LR_AF/10000}万元，比上年同期增加{(LR_AF-LR_AF1)/10000}万元，增幅为-%。','{LR_AF/10000},{(LR_AF-LR_AF1)/10000}',NULL,'G2001',NULL,0),
(3789,'2','利润表首页概述','LR_AF1==0&&LR_AF<0','本期净利润为Rmb{LR_AF/10000}万元，比上年同期减少{(LR_AF1-LR_AF)/10000}万元，减幅为-%。','{LR_AF/10000},{(LR_AF1-LR_AF)/10000}',NULL,'G2001',NULL,0),
(3790,'2','利润表首页概述','LR_AF1==0&&LR_AF==0','本期净利润为Rmb{LR_AF/10000}万元，比上年同期持平。','{LR_AF/10000}',NULL,'G2001',NULL,0),
(3791,'2','利润表首页概述','LR_AF-LR_AF1>0&&LR_A-LR_A1>0&& (LR_A-LR_A1)-(LR_F1-LR_F)>0&& (LR_A-LR_A1)-(LR_O1-LR_O)>0&& (LR_A-LR_A1)-(LR_P1-LR_P)>0&& (LR_A-LR_A1)-(LR_Q1-LR_Q)>0&& (LR_A-LR_A1)-(LR_R1-LR_R)>0&& (LR_A-LR_A1)-(LR_S1-LR_S)>0&& (LR_A-LR_A1)-(LR_T-LR_T1)>0&& (LR_A-LR_A1)-(LR_U-LR_U1)>0&& (LR_A-LR_A1)-(LR_W-LR_W1)>0&& (LR_A-LR_A1)-(LR_X-LR_X1)>0&& (LR_A-LR_A1)-(LR_Z-LR_Z1)>0&& (LR_A-LR_A1)-(LR_AB1-LR_AB)>0&& (LR_A-LR_A1)-(LR_AE1-LR_AE)>0','主要是因为营业收入从上期的Rmb{LR_A1/10000}万元增长至本期的Rmb{LR_A/10000}万元。','{LR_A1/10000},{LR_A/10000}',NULL,'G2001',NULL,0),
(3792,'2','利润表首页概述','LR_AF1-LR_AF>0&&LR_A1-LR_A>0&& (LR_A1-LR_A)-(LR_F-LR_F1)>0&& (LR_A1-LR_A)-(LR_O-LR_O1)>0&& (LR_A1-LR_A)-(LR_P-LR_P1)>0&& (LR_A1-LR_A)-(LR_Q-LR_Q1)>0&& (LR_A1-LR_A)-(LR_R-LR_R1)>0&& (LR_A1-LR_A)-(LR_S-LR_S1)>0&& (LR_A1-LR_A)-(LR_T1-LR_T)>0&& (LR_A1-LR_A)-(LR_U1-LR_U)>0&& (LR_A1-LR_A)-(LR_W1-LR_W)>0&& (LR_A1-LR_A)-(LR_X1-LR_X)>0&& (LR_A1-LR_A)-(LR_Z1-LR_Z)>0&& (LR_A1-LR_A)-(LR_AB-LR_AB1)>0&& (LR_A1-LR_A)-(LR_AE-LR_AE1)>0','主要是因为营业收入从上期的Rmb{LR_A1/10000}万元下降至本期的Rmb{LR_A/10000}万元。','{LR_A1/10000},{LR_A/10000}',NULL,'G2001',NULL,0),
(3793,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_F-LR_F1>0&& (LR_F-LR_F1)-(LR_A1-LR_A)>0&& (LR_F-LR_F1)-(LR_O-LR_O1)>0&& (LR_F-LR_F1)-(LR_P-LR_P1)>0&& (LR_F-LR_F1)-(LR_Q-LR_Q1)>0&& (LR_F-LR_F1)-(LR_R-LR_R1)>0&& (LR_F-LR_F1)-(LR_S-LR_S1)>0&& (LR_F-LR_F1)-(LR_T1-LR_T)>0&& (LR_F-LR_F1)-(LR_U1-LR_U)>0&& (LR_F-LR_F1)-(LR_W1-LR_W)>0&& (LR_F-LR_F1)-(LR_X1-LR_X)>0&& (LR_F-LR_F1)-(LR_Z1-LR_Z)>0&& (LR_F-LR_F1)-(LR_AB-LR_AB1)>0&& (LR_F-LR_F1)-(LR_AE-LR_AE1)>0','主要是因为营业成本从上期的Rmb{LR_F1/10000}万元增加至本期的Rmb{LR_F/10000}万元。','{LR_F1/10000},{LR_F/10000}',NULL,'G2001',NULL,0),
(3794,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_F1-LR_F>0&& (LR_F1-LR_F)-(LR_A-LR_A1)>0&& (LR_F1-LR_F)-(LR_O1-LR_O)>0&& (LR_F1-LR_F)-(LR_P1-LR_P)>0&& (LR_F1-LR_F)-(LR_Q1-LR_Q)>0&& (LR_F1-LR_F)-(LR_R1-LR_R)>0&& (LR_F1-LR_F)-(LR_S1-LR_S)>0&& (LR_F1-LR_F)-(LR_T-LR_T1)>0&& (LR_F1-LR_F)-(LR_U-LR_U1)>0&& (LR_F1-LR_F)-(LR_W-LR_W1)>0&& (LR_F1-LR_F)-(LR_X-LR_X1)>0&& (LR_F1-LR_F)-(LR_Z-LR_Z1)>0&& (LR_F1-LR_F)-(LR_AB1-LR_AB)>0&& (LR_F1-LR_F)-(LR_AE1-LR_AE)>0','主要是因为营业成本从上期的Rmb{LR_F1/10000}万元下降至本期的Rmb{LR_F/10000}万元。','{LR_F1/10000},{LR_F/10000}',NULL,'G2001',NULL,0),
(3795,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_O-LR_O1>0&& (LR_O-LR_O1)-(LR_A1-LR_A)>0&& (LR_O-LR_O1)-(LR_F-LR_F1)>0&& (LR_O-LR_O1)-(LR_P-LR_P1)>0&& (LR_O-LR_O1)-(LR_Q-LR_Q1)>0&& (LR_O-LR_O1)-(LR_R-LR_R1)>0&& (LR_O-LR_O1)-(LR_S-LR_S1)>0&& (LR_O-LR_O1)-(LR_T1-LR_T)>0&& (LR_O-LR_O1)-(LR_U1-LR_U)>0&& (LR_O-LR_O1)-(LR_W1-LR_W)>0&& (LR_O-LR_O1)-(LR_X1-LR_X)>0&& (LR_O-LR_O1)-(LR_Z1-LR_Z)>0&& (LR_O-LR_O1)-(LR_AB-LR_AB1)>0&& (LR_O-LR_O1)-(LR_AE-LR_AE1)>0','主要是因为税金及附加从上期的Rmb{LR_O1/10000}万元增加至本期的Rmb{LR_O/10000}万元。','{LR_O1/10000},{LR_O/10000}',NULL,'G2001',NULL,0),
(3796,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_O1-LR_O>0&& (LR_O1-LR_O)-(LR_A-LR_A1)>0&& (LR_O1-LR_O)-(LR_F1-LR_F)>0&& (LR_O1-LR_O)-(LR_P1-LR_P)>0&& (LR_O1-LR_O)-(LR_Q1-LR_Q)>0&& (LR_O1-LR_O)-(LR_R1-LR_R)>0&& (LR_O1-LR_O)-(LR_S1-LR_S)>0&& (LR_O1-LR_O)-(LR_T-LR_T1)>0&& (LR_O1-LR_O)-(LR_U-LR_U1)>0&& (LR_O1-LR_O)-(LR_W-LR_W1)>0&& (LR_O1-LR_O)-(LR_X-LR_X1)>0&& (LR_O1-LR_O)-(LR_Z-LR_Z1)>0&& (LR_O1-LR_O)-(LR_AB1-LR_AB)>0&& (LR_O1-LR_O)-(LR_AE1-LR_AE)>0','主要是因为税金及附加从上期的Rmb{LR_O1/10000}万元下降至本期的Rmb{LR_O/10000}万元。','{LR_O1/10000},{LR_O/10000}',NULL,'G2001',NULL,0),
(3797,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_P-LR_P1>0&& (LR_P-LR_P1)-(LR_A1-LR_A)>0&& (LR_P-LR_P1)-(LR_F-LR_F1)>0&& (LR_P-LR_P1)-(LR_O-LR_O1)>0&& (LR_P-LR_P1)-(LR_Q-LR_Q1)>0&& (LR_P-LR_P1)-(LR_R-LR_R1)>0&& (LR_P-LR_P1)-(LR_S-LR_S1)>0&& (LR_P-LR_P1)-(LR_T1-LR_T)>0&& (LR_P-LR_P1)-(LR_U1-LR_U)>0&& (LR_P-LR_P1)-(LR_W1-LR_W)>0&& (LR_P-LR_P1)-(LR_X1-LR_X)>0&& (LR_P-LR_P1)-(LR_Z1-LR_Z)>0&& (LR_P-LR_P1)-(LR_AB-LR_AB1)>0&& (LR_P-LR_P1)-(LR_AE-LR_AE1)>0','主要是因为销售费用从上期的Rmb{LR_P1/10000}万元增长至本期的Rmb{LR_P/10000}万元。','{LR_P1/10000},{LR_P/10000}',NULL,'G2001',NULL,0),
(3798,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_P1-LR_P>0&& (LR_P1-LR_P)-(LR_A-LR_A1)>0&& (LR_P1-LR_P)-(LR_F1-LR_F)>0&& (LR_P1-LR_P)-(LR_O1-LR_O)>0&& (LR_P1-LR_P)-(LR_Q1-LR_Q)>0&& (LR_P1-LR_P)-(LR_R1-LR_R)>0&& (LR_P1-LR_P)-(LR_S1-LR_S)>0&& (LR_P1-LR_P)-(LR_T-LR_T1)>0&& (LR_P1-LR_P)-(LR_U-LR_U1)>0&& (LR_P1-LR_P)-(LR_W-LR_W1)>0&& (LR_P1-LR_P)-(LR_X-LR_X1)>0&& (LR_P1-LR_P)-(LR_Z-LR_Z1)>0&& (LR_P1-LR_P)-(LR_AB1-LR_AB)>0&& (LR_P1-LR_P)-(LR_AE1-LR_AE)>0','主要是因为销售费用从上期的Rmb{LR_P1/10000}万元下降至本期的Rmb{LR_P/10000}万元。','{LR_P1/10000},{LR_P/10000}',NULL,'G2001',NULL,0),
(3799,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_Q-LR_Q1>0&& (LR_Q-LR_Q1)-(LR_A1-LR_A)>0&& (LR_Q-LR_Q1)-(LR_F-LR_F1)>0&& (LR_Q-LR_Q1)-(LR_O-LR_O1)>0&& (LR_Q-LR_Q1)-(LR_P-LR_P1)>0&& (LR_Q-LR_Q1)-(LR_R-LR_R1)>0&& (LR_Q-LR_Q1)-(LR_S-LR_S1)>0&& (LR_Q-LR_Q1)-(LR_T1-LR_T)>0&& (LR_Q-LR_Q1)-(LR_U1-LR_U)>0&& (LR_Q-LR_Q1)-(LR_W1-LR_W)>0&& (LR_Q-LR_Q1)-(LR_X1-LR_X)>0&& (LR_Q-LR_Q1)-(LR_Z1-LR_Z)>0&& (LR_Q-LR_Q1)-(LR_AB-LR_AB1)>0&& (LR_Q-LR_Q1)-(LR_AE-LR_AE1)>0','主要是因为管理费用从上期的Rmb{LR_Q1/10000}万元增长至本期的Rmb{LR_Q/10000}万元。','{LR_Q1/10000},{LR_Q/10000}',NULL,'G2001',NULL,0),
(3800,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_Q1-LR_Q>0&&  (LR_Q1-LR_Q)-(LR_A-LR_A1)>0&& (LR_Q1-LR_Q)-(LR_F1-LR_F)>0&& (LR_Q1-LR_Q)-(LR_O1-LR_O)>0&& (LR_Q1-LR_Q)-(LR_P1-LR_P)>0&& (LR_Q1-LR_Q)-(LR_R1-LR_R)>0&& (LR_Q1-LR_Q)-(LR_S1-LR_S)>0&& (LR_Q1-LR_Q)-(LR_T-LR_T1)>0&& (LR_Q1-LR_Q)-(LR_U-LR_U1)>0&& (LR_Q1-LR_Q)-(LR_W-LR_W1)>0&& (LR_Q1-LR_Q)-(LR_X-LR_X1)>0&& (LR_Q1-LR_Q)-(LR_Z-LR_Z1)>0&& (LR_Q1-LR_Q)-(LR_AB1-LR_AB)>0&& (LR_Q1-LR_Q)-(LR_AE1-LR_AE)>0','主要是因为管理费用从上期的Rmb{LR_Q1/10000}万元下降至本期的Rmb{LR_Q/10000}万元。','{LR_Q1/10000},{LR_Q/10000}',NULL,'G2001',NULL,0),
(3801,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_R-LR_R1>0&& (LR_R-LR_R1)-(LR_A1-LR_A)>0&& (LR_R-LR_R1)-(LR_F-LR_F1)>0&& (LR_R-LR_R1)-(LR_O-LR_O1)>0&& (LR_R-LR_R1)-(LR_P-LR_P1)>0&& (LR_R-LR_R1)-(LR_Q-LR_Q1)>0&& (LR_R-LR_R1)-(LR_S-LR_S1)>0&& (LR_R-LR_R1)-(LR_T1-LR_T)>0&& (LR_R-LR_R1)-(LR_U1-LR_U)>0&& (LR_R-LR_R1)-(LR_W1-LR_W)>0&& (LR_R-LR_R1)-(LR_X1-LR_X)>0&& (LR_R-LR_R1)-(LR_Z1-LR_Z)>0&& (LR_R-LR_R1)-(LR_AB-LR_AB1)>0&& (LR_R-LR_R1)-(LR_AE-LR_AE1)>0','主要是因为财务费用从上期的Rmb{LR_R1/10000}万元增长至本期的Rmb{LR_R/10000}万元。','{LR_R1/10000},{LR_R/10000}',NULL,'G2001',NULL,0),
(3802,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_R1-LR_R>0&& (LR_R1-LR_R)-(LR_A-LR_A1)>0&& (LR_R1-LR_R)-(LR_F1-LR_F)>0&& (LR_R1-LR_R)-(LR_O1-LR_O)>0&& (LR_R1-LR_R)-(LR_P1-LR_P)>0&& (LR_R1-LR_R)-(LR_Q1-LR_Q)>0&& (LR_R1-LR_R)-(LR_S1-LR_S)>0&& (LR_R1-LR_R)-(LR_T-LR_T1)>0&& (LR_R1-LR_R)-(LR_U-LR_U1)>0&& (LR_R1-LR_R)-(LR_W-LR_W1)>0&& (LR_R1-LR_R)-(LR_X-LR_X1)>0&& (LR_R1-LR_R)-(LR_Z-LR_Z1)>0&& (LR_R1-LR_R)-(LR_AB1-LR_AB)>0&& (LR_R1-LR_R)-(LR_AE1-LR_AE)>0','主要是因为财务费用从上期的Rmb{LR_R1/10000}万元下降至本期的Rmb{LR_R/10000}万元。','{LR_R1/10000},{LR_R/10000}',NULL,'G2001',NULL,0),
(3803,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_S-LR_S1>0&& (LR_S-LR_S1)-(LR_A1-LR_A)>0&& (LR_S-LR_S1)-(LR_F-LR_F1)>0&& (LR_S-LR_S1)-(LR_O-LR_O1)>0&& (LR_S-LR_S1)-(LR_P-LR_P1)>0&& (LR_S-LR_S1)-(LR_Q-LR_Q1)>0&& (LR_S-LR_S1)-(LR_R-LR_R1)>0&& (LR_S-LR_S1)-(LR_T1-LR_T)>0&& (LR_S-LR_S1)-(LR_U1-LR_U)>0&& (LR_S-LR_S1)-(LR_W1-LR_W)>0&& (LR_S-LR_S1)-(LR_X1-LR_X)>0&& (LR_S-LR_S1)-(LR_Z1-LR_Z)>0&& (LR_S-LR_S1)-(LR_AB-LR_AB1)>0&& (LR_S-LR_S1)-(LR_AE-LR_AE1)>0','主要是因为资产减值损失从上期的Rmb{LR_S1/10000}万元增长至本期的Rmb{LR_S/10000}万元。','{LR_S1/10000},{LR_S/10000}',NULL,'G2001',NULL,0),
(3804,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_S1-LR_S>0&& (LR_S1-LR_S)-(LR_A-LR_A1)>0&& (LR_S1-LR_S)-(LR_F1-LR_F)>0&& (LR_S1-LR_S)-(LR_O1-LR_O)>0&& (LR_S1-LR_S)-(LR_P1-LR_P)>0&& (LR_S1-LR_S)-(LR_Q1-LR_Q)>0&& (LR_S1-LR_S)-(LR_R1-LR_R)>0&& (LR_S1-LR_S)-(LR_T-LR_T1)>0&& (LR_S1-LR_S)-(LR_U-LR_U1)>0&& (LR_S1-LR_S)-(LR_W-LR_W1)>0&& (LR_S1-LR_S)-(LR_X-LR_X1)>0&& (LR_S1-LR_S)-(LR_Z-LR_Z1)>0&& (LR_S1-LR_S)-(LR_AB1-LR_AB)>0&& (LR_S1-LR_S)-(LR_AE1-LR_AE)>0','主要是因为资产减值损失从上期的Rmb{LR_S1/10000}万元下降至本期的Rmb{LR_S/10000}万元。','{LR_S1/10000},{LR_S/10000}',NULL,'G2001',NULL,0),
(3805,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_T-LR_T1>0&& (LR_T-LR_T1)-(LR_F1-LR_F)>0&& (LR_T-LR_T1)-(LR_O1-LR_O)>0&& (LR_T-LR_T1)-(LR_P1-LR_P)>0&& (LR_T-LR_T1)-(LR_Q1-LR_Q)>0&& (LR_T-LR_T1)-(LR_R1-LR_R)>0&& (LR_T-LR_T1)-(LR_S1-LR_S)>0&& (LR_T-LR_T1)-(LR_A-LR_A1)>0&& (LR_T-LR_T1)-(LR_U-LR_U1)>0&& (LR_T-LR_T1)-(LR_W-LR_W1)>0&& (LR_T-LR_T1)-(LR_X-LR_X1)>0&& (LR_T-LR_T1)-(LR_Z-LR_Z1)>0&& (LR_T-LR_T1)-(LR_AB1-LR_AB)>0&& (LR_T-LR_T1)-(LR_AE1-LR_AE)>0','主要是因为公允价值变动收益从上期的Rmb{LR_T1/10000}万元增长至本期的Rmb{LR_T/10000}万元。','{LR_T1/10000},{LR_T/10000}',NULL,'G2001',NULL,0),
(3806,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_T1-LR_T>0&& (LR_T1-LR_T)-(LR_F-LR_F1)>0&& (LR_T1-LR_T)-(LR_O-LR_O1)>0&& (LR_T1-LR_T)-(LR_P-LR_P1)>0&& (LR_T1-LR_T)-(LR_Q-LR_Q1)>0&& (LR_T1-LR_T)-(LR_R-LR_R1)>0&& (LR_T1-LR_T)-(LR_S-LR_S1)>0&& (LR_T1-LR_T)-(LR_A1-LR_A)>0&& (LR_T1-LR_T)-(LR_U1-LR_U)>0&& (LR_T1-LR_T)-(LR_W1-LR_W)>0&& (LR_T1-LR_T)-(LR_X1-LR_X)>0&& (LR_T1-LR_T)-(LR_Z1-LR_Z)>0&& (LR_T1-LR_T)-(LR_AB-LR_AB1)>0&& (LR_T1-LR_T)-(LR_AE-LR_AE1)>0','主要是因为公允价值变动收益从上期的Rmb{LR_T1/10000}万元下降至本期的Rmb{LR_T/10000}万元。','{LR_T1/10000},{LR_T/10000}',NULL,'G2001',NULL,0),
(3807,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_U-LR_U1>0&& (LR_U-LR_U1)-(LR_F1-LR_F)>0&& (LR_U-LR_U1)-(LR_O1-LR_O)>0&& (LR_U-LR_U1)-(LR_P1-LR_P)>0&& (LR_U-LR_U1)-(LR_Q1-LR_Q)>0&& (LR_U-LR_U1)-(LR_R1-LR_R)>0&& (LR_U-LR_U1)-(LR_S1-LR_S)>0&& (LR_U-LR_U1)-(LR_A-LR_A1)>0&& (LR_U-LR_U1)-(LR_T-LR_T1)>0&& (LR_U-LR_U1)-(LR_W-LR_W1)>0&& (LR_U-LR_U1)-(LR_X-LR_X1)>0&& (LR_U-LR_U1)-(LR_Z-LR_Z1)>0&& (LR_U-LR_U1)-(LR_AB1-LR_AB)>0&& (LR_U-LR_U1)-(LR_AE1-LR_AE)>0','主要是因为投资收益从上期的Rmb{LR_U1/10000}万元增长至本期的Rmb{LR_U/10000}万元。','{LR_U1/10000},{LR_U/10000}',NULL,'G2001',NULL,0),
(3808,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_U1-LR_U>0&& (LR_U1-LR_U)-(LR_F-LR_F1)>0&& (LR_U1-LR_U)-(LR_O-LR_O1)>0&& (LR_U1-LR_U)-(LR_P-LR_P1)>0&& (LR_U1-LR_U)-(LR_Q-LR_Q1)>0&& (LR_U1-LR_U)-(LR_R-LR_R1)>0&& (LR_U1-LR_U)-(LR_S-LR_S1)>0&& (LR_U1-LR_U)-(LR_A1-LR_A)>0&& (LR_U1-LR_U)-(LR_T1-LR_T)>0&& (LR_U1-LR_U)-(LR_W1-LR_W)>0&& (LR_U1-LR_U)-(LR_X1-LR_X)>0&& (LR_U1-LR_U)-(LR_Z1-LR_Z)>0&& (LR_U1-LR_U)-(LR_AB-LR_AB1)>0&& (LR_U1-LR_U)-(LR_AE-LR_AE1)>0','主要是因为投资收益从上期的Rmb{LR_U1/10000}万元下降至本期的Rmb{LR_U/10000}万元。','{LR_U1/10000},{LR_U/10000}',NULL,'G2001',NULL,0),
(3809,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_W-LR_W1>0&& (LR_W-LR_W1)-(LR_F1-LR_F)>0&& (LR_W-LR_W1)-(LR_O1-LR_O)>0&& (LR_W-LR_W1)-(LR_P1-LR_P)>0&& (LR_W-LR_W1)-(LR_Q1-LR_Q)>0&& (LR_W-LR_W1)-(LR_R1-LR_R)>0&& (LR_W-LR_W1)-(LR_S1-LR_S)>0&& (LR_W-LR_W1)-(LR_A-LR_A1)>0&& (LR_W-LR_W1)-(LR_T-LR_T1)>0&& (LR_W-LR_W1)-(LR_U-LR_U1)>0&& (LR_W-LR_W1)-(LR_X-LR_X1)>0&& (LR_W-LR_W1)-(LR_Z-LR_Z1)>0&& (LR_W-LR_W1)-(LR_AB1-LR_AB)>0&& (LR_W-LR_W1)-(LR_AE1-LR_AE)>0','主要是因为资产处置收益从上期的Rmb{LR_W1/10000}万元增长至本期的Rmb{LR_W/10000}万元。','{LR_W1/10000},{LR_W/10000}',NULL,'G2001',NULL,0),
(3810,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_W1-LR_W>0&& (LR_W1-LR_W)-(LR_F-LR_F1)>0&& (LR_W1-LR_W)-(LR_O-LR_O1)>0&& (LR_W1-LR_W)-(LR_P-LR_P1)>0&& (LR_W1-LR_W)-(LR_Q-LR_Q1)>0&& (LR_W1-LR_W)-(LR_R-LR_R1)>0&& (LR_W1-LR_W)-(LR_S-LR_S1)>0&& (LR_W1-LR_W)-(LR_A1-LR_A)>0&& (LR_W1-LR_W)-(LR_T1-LR_T)>0&& (LR_W1-LR_W)-(LR_U1-LR_U)>0&& (LR_W1-LR_W)-(LR_X1-LR_X)>0&& (LR_W1-LR_W)-(LR_Z1-LR_Z)>0&& (LR_W1-LR_W)-(LR_AB-LR_AB1)>0&& (LR_W1-LR_W)-(LR_AE-LR_AE1)>0','主要是因为资产处置收益从上期的Rmb{LR_W1/10000}万元下降至本期的Rmb{LR_W/10000}万元。','{LR_W1/10000},{LR_W/10000}',NULL,'G2001',NULL,0),
(3811,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_X-LR_X1>0&& (LR_X-LR_X1)-(LR_F1-LR_F)>0&& (LR_X-LR_X1)-(LR_O1-LR_O)>0&& (LR_X-LR_X1)-(LR_P1-LR_P)>0&& (LR_X-LR_X1)-(LR_Q1-LR_Q)>0&& (LR_X-LR_X1)-(LR_R1-LR_R)>0&& (LR_X-LR_X1)-(LR_S1-LR_S)>0&& (LR_X-LR_X1)-(LR_A-LR_A1)>0&& (LR_X-LR_X1)-(LR_T-LR_T1)>0&& (LR_X-LR_X1)-(LR_U-LR_U1)>0&& (LR_X-LR_X1)-(LR_W-LR_W1)>0&& (LR_X-LR_X1)-(LR_Z-LR_Z1)>0&& (LR_X-LR_X1)-(LR_AB1-LR_AB)>0&& (LR_X-LR_X1)-(LR_AE1-LR_AE)>0','主要是因为其他收益从上期的Rmb{LR_X1/10000}万元增长至本期的Rmb{LR_X/10000}万元。','{LR_X1/10000},{LR_X/10000}',NULL,'G2001',NULL,0),
(3812,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_X1-LR_X>0&& (LR_X1-LR_X)-(LR_F-LR_F1)>0&& (LR_X1-LR_X)-(LR_O-LR_O1)>0&& (LR_X1-LR_X)-(LR_P-LR_P1)>0&& (LR_X1-LR_X)-(LR_Q-LR_Q1)>0&& (LR_X1-LR_X)-(LR_R-LR_R1)>0&& (LR_X1-LR_X)-(LR_S-LR_S1)>0&& (LR_X1-LR_X)-(LR_A1-LR_A)>0&& (LR_X1-LR_X)-(LR_T1-LR_T)>0&& (LR_X1-LR_X)-(LR_U1-LR_U)>0&& (LR_X1-LR_X)-(LR_W1-LR_W)>0&& (LR_X1-LR_X)-(LR_Z1-LR_Z)>0&& (LR_X1-LR_X)-(LR_AB-LR_AB1)>0&& (LR_X1-LR_X)-(LR_AE-LR_AE1)>0','主要是因为其他收益从上期的Rmb{LR_X1/10000}万元下降至本期的Rmb{LR_X/10000}万元。','{LR_X1/10000},{LR_X/10000}',NULL,'G2001',NULL,0),
(3813,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_Z-LR_Z1>0&& (LR_Z-LR_Z1)-(LR_F1-LR_F)>0&& (LR_Z-LR_Z1)-(LR_O1-LR_O)>0&& (LR_Z-LR_Z1)-(LR_P1-LR_P)>0&& (LR_Z-LR_Z1)-(LR_Q1-LR_Q)>0&& (LR_Z-LR_Z1)-(LR_R1-LR_R)>0&& (LR_Z-LR_Z1)-(LR_S1-LR_S)>0&& (LR_Z-LR_Z1)-(LR_A-LR_A1)>0&& (LR_Z-LR_Z1)-(LR_T-LR_T1)>0&& (LR_Z-LR_Z1)-(LR_U-LR_U1)>0&& (LR_Z-LR_Z1)-(LR_W-LR_W1)>0&& (LR_Z-LR_Z1)-(LR_X-LR_X1)>0&& (LR_Z-LR_Z1)-(LR_AB1-LR_AB)>0&& (LR_Z-LR_Z1)-(LR_AE1-LR_AE)>0','主要是因为营业外收入从上期的Rmb{LR_Z1/10000}万元增长至本期的Rmb{LR_Z/10000}万元。','{LR_Z1/10000},{LR_Z/10000}',NULL,'G2001',NULL,0),
(3814,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_Z1-LR_Z>0&& (LR_Z1-LR_Z)-(LR_F-LR_F1)>0&& (LR_Z1-LR_Z)-(LR_O-LR_O1)>0&& (LR_Z1-LR_Z)-(LR_P-LR_P1)>0&& (LR_Z1-LR_Z)-(LR_Q-LR_Q1)>0&& (LR_Z1-LR_Z)-(LR_R-LR_R1)>0&& (LR_Z1-LR_Z)-(LR_S-LR_S1)>0&& (LR_Z1-LR_Z)-(LR_A1-LR_A)>0&& (LR_Z1-LR_Z)-(LR_T1-LR_T)>0&& (LR_Z1-LR_Z)-(LR_U1-LR_U)>0&& (LR_Z1-LR_Z)-(LR_W1-LR_W)>0&& (LR_Z1-LR_Z)-(LR_X1-LR_X)>0&& (LR_Z1-LR_Z)-(LR_AB-LR_AB1)>0&& (LR_Z1-LR_Z)-(LR_AE-LR_AE1)>0','主要是因为营业外收入从上期的Rmb{LR_Z1/10000}万元下降至本期的Rmb{LR_Z/10000}万元。','{LR_Z1/10000},{LR_Z/10000}',NULL,'G2001',NULL,0),
(3815,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_AB-LR_AB1>0&& (LR_AB-LR_AB1)-(LR_A1-LR_A)>0&& (LR_AB-LR_AB1)-(LR_O-LR_O1)>0&& (LR_AB-LR_AB1)-(LR_P-LR_P1)>0&& (LR_AB-LR_AB1)-(LR_Q-LR_Q1)>0&& (LR_AB-LR_AB1)-(LR_R-LR_R1)>0&& (LR_AB-LR_AB1)-(LR_S-LR_S1)>0&& (LR_AB-LR_AB1)-(LR_T1-LR_T)>0&& (LR_AB-LR_AB1)-(LR_U1-LR_U)>0&& (LR_AB-LR_AB1)-(LR_W1-LR_W)>0&& (LR_AB-LR_AB1)-(LR_X1-LR_X)>0&& (LR_AB-LR_AB1)-(LR_Z1-LR_Z)>0&& (LR_AB-LR_AB1)-(LR_F-LR_F1)>0&& (LR_AB-LR_AB1)-(LR_AE-LR_AE1)>0','主要是因为营业外支出从上期的Rmb{LR_AB1/10000}万元增长至本期的Rmb{LR_AB/10000}万元。','{LR_AB1/10000},{LR_AB/10000}',NULL,'G2001',NULL,0),
(3816,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_AB1-LR_AB>0&& (LR_AB1-LR_AB)-(LR_A-LR_A1)>0&& (LR_AB1-LR_AB)-(LR_O1-LR_O)>0&& (LR_AB1-LR_AB)-(LR_P1-LR_P)>0&& (LR_AB1-LR_AB)-(LR_Q1-LR_Q)>0&& (LR_AB1-LR_AB)-(LR_R1-LR_R)>0&& (LR_AB1-LR_AB)-(LR_S1-LR_S)>0&& (LR_AB1-LR_AB)-(LR_T-LR_T1)>0&& (LR_AB1-LR_AB)-(LR_U-LR_U1)>0&& (LR_AB1-LR_AB)-(LR_W-LR_W1)>0&& (LR_AB1-LR_AB)-(LR_X-LR_X1)>0&& (LR_AB1-LR_AB)-(LR_Z-LR_Z1)>0&& (LR_AB1-LR_AB)-(LR_F1-LR_F)>0&& (LR_AB1-LR_AB)-(LR_AE1-LR_AE)>0','主要是因为营业外支出从上期的Rmb{LR_AB1/10000}万元下降至本期的Rmb{LR_AB/10000}万元。','{LR_AB1/10000},{LR_AB/10000}',NULL,'G2001',NULL,0),
(3817,'2','利润表首页概述','LR_AF1-LR_AF>0&& LR_AE-LR_AE1>0&& (LR_AE-LR_AE1)-(LR_A1-LR_A)>0&& (LR_AE-LR_AE1)-(LR_O-LR_O1)>0&& (LR_AE-LR_AE1)-(LR_P-LR_P1)>0&& (LR_AE-LR_AE1)-(LR_Q-LR_Q1)>0&& (LR_AE-LR_AE1)-(LR_R-LR_R1)>0&& (LR_AE-LR_AE1)-(LR_S-LR_S1)>0&& (LR_AE-LR_AE1)-(LR_T1-LR_T)>0&& (LR_AE-LR_AE1)-(LR_U1-LR_U)>0&& (LR_AE-LR_AE1)-(LR_W1-LR_W)>0&& (LR_AE-LR_AE1)-(LR_X1-LR_X)>0&& (LR_AE-LR_AE1)-(LR_Z1-LR_Z)>0&& (LR_AE-LR_AE1)-(LR_F-LR_F1)>0&& (LR_AE-LR_AE1)-(LR_AB-LR_AB1)>0','主要是因为所得税从上期的Rmb{LR_AE1/10000}万元增长至本期的Rmb{LR_AE/10000}万元。','{LR_AE1/10000},{LR_AE/10000}',NULL,'G2001',NULL,0),
(3818,'2','利润表首页概述','LR_AF-LR_AF1>0&& LR_AE1-LR_AE>0&& (LR_AE1-LR_AE)-(LR_A-LR_A1)>0&& (LR_AE1-LR_AE)-(LR_O1-LR_O)>0&& (LR_AE1-LR_AE)-(LR_P1-LR_P)>0&& (LR_AE1-LR_AE)-(LR_Q1-LR_Q)>0&& (LR_AE1-LR_AE)-(LR_R1-LR_R)>0&& (LR_AE1-LR_AE)-(LR_S1-LR_S)>0&& (LR_AE1-LR_AE)-(LR_T-LR_T1)>0&& (LR_AE1-LR_AE)-(LR_U-LR_U1)>0&& (LR_AE1-LR_AE)-(LR_W-LR_W1)>0&& (LR_AE1-LR_AE)-(LR_X-LR_X1)>0&& (LR_AE1-LR_AE)-(LR_Z-LR_Z1)>0&& (LR_AE1-LR_AE)-(LR_F1-LR_F)>0&& (LR_AE1-LR_AE)-(LR_AB1-LR_AB)>0','主要是因为所得税从上期的Rmb{LR_AE1/10000}万元下降至本期的Rmb{LR_AE/10000}万元。','{LR_AE1/10000},{LR_AE/10000}',NULL,'G2001',NULL,0),
(3819,'2','财务费用概述','LR_R1==0&&LR_R-LR_R1<0','财务费用从上年同期的Rmb{LR_R1/10000}万元减少至本期的Rmb{LR_R/10000}万元，变动率为-%。','{LR_R1/10000},{LR_R/10000}','','G2005','',3819),
(3820,'2','财务费用预警','LR_R1==0&&LR_R-LR_R1<0','与上年同期相比，财务费用从Rmb{LR_R1/10000}万元减少至Rmb{LR_R/10000}万元。财务费用的减少主要是因为利息支出的减少。建议管理层结合贷款及现金流情况，考虑是否需要更新融资计划或进行增资，如需进行股权或债权融资，需考虑未来还本付息等对现金流的压力。','{LR_R1/10000},{LR_R/10000}','','20010','',3820),
(3821,'1','钻井预警','WELL-D*WELL-D*WELL-H>0','一切数据正常，继续保持','','','10000011','',0),
(3822,'1','钻井预警','WELL-D*WELL-D*WELL-H<0','数据不正常，清注意','','','10000011','',0),
(3823,'1','一年内到期的非流动资产在期末减少','ZCFZ_R - ZCFZ_R1 < 0','一年内到期的非流动资产减少，考虑是否因为资金回笼还是对该资产进行处置。若为对资产进行处置，建议管理层关注处置的原因、必要性及所得情况。同时，需结合资金情况及资金预警，做好未来的资金投资规划，避免资金闲置或紧张情况的出现。','','','10004','',20);

/*Table structure for table `t_org_info` */

DROP TABLE IF EXISTS `t_org_info`;

CREATE TABLE `t_org_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ORG_NAME` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司名称',
  `SHORT_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '简称',
  `ORG_REMARK` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '机构简介',
  `BUSINESS_NUM` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '营业号',
  `LEGALER_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '法人',
  `PAID_CAPITAL` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '实缴资本',
  `CONFUSING_CAPITAL` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '认缴资本',
  `REGISTERED_ADDR` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '注册地址',
  `INDUSTRY` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '所属行业',
  `IS_LIST` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '是否上市(0：是；1：否)',
  `ORG_PROPERTY` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '性质',
  `RES_PERSON_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '负责人',
  `ORG_TOTAL_PER` decimal(10,0) DEFAULT NULL COMMENT '公司人数',
  `RES_PERSON_TEL` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '负责人电话',
  `REGISTERED_DATE` date DEFAULT NULL COMMENT '注册时间',
  `ORG_ADDR` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司地址',
  `SHARES` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '股票代码',
  `CUST_TYPE` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '客户类型',
  `REPORT_LIMIT` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '报表标准',
  `parent_id` bigint DEFAULT NULL COMMENT '父类id',
  `url` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_org_info` */

/*Table structure for table `t_report` */

DROP TABLE IF EXISTS `t_report`;

CREATE TABLE `t_report` (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `RYEAR` int DEFAULT NULL,
  `RMONTH` int DEFAULT NULL,
  `RYEAR_AND_MONTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_NO` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATA_VALUE` decimal(65,4) DEFAULT NULL,
  `ORG_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `bj` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '0,原数据，1预测数据',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_report` */

/*Table structure for table `t_report_name` */

DROP TABLE IF EXISTS `t_report_name`;

CREATE TABLE `t_report_name` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `IMP_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '文件名',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7523 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT COMMENT='辅助表';

/*Data for the table `t_report_name` */

/*Table structure for table `t_report_property` */

DROP TABLE IF EXISTS `t_report_property`;

CREATE TABLE `t_report_property` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pro_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '属性名称',
  `pro_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '属性编码，与字段名称一致',
  `pro_row` int DEFAULT '0' COMMENT '开始的行数',
  `pro_column` int DEFAULT '0' COMMENT '开始的列数',
  `pro_money_row` int DEFAULT '0' COMMENT '是否是多行（0否，1是）',
  `pro_end` int DEFAULT NULL COMMENT '结束行（倒数第几行）',
  `pro_row_or_column` int DEFAULT '0' COMMENT '行或者列计算，0行，1列',
  `pro_class` int DEFAULT '0' COMMENT '财务系统类别，数据字段取',
  `pro_subject` int DEFAULT '0' COMMENT '报表类别,数据字典取',
  `pro_public` int DEFAULT '0' COMMENT '是否公用字段（1公用）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1622 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='报表属性表';

/*Data for the table `t_report_property` */

insert  into `t_report_property`(`id`,`pro_name`,`pro_code`,`pro_row`,`pro_column`,`pro_money_row`,`pro_end`,`pro_row_or_column`,`pro_class`,`pro_subject`,`pro_public`,`remark`) values 
(1,'会计年月','KJYEAR_MOTH',2,1,0,NULL,0,1,1,0,NULL),
(75,'单位','JEDW',2,3,0,NULL,0,1,1,0,NULL),
(76,'营业收入(本期)','BY_ZYYWSR',4,2,0,NULL,0,1,1,0,NULL),
(77,'营业收入(本年)','BN_ZYYWSR',4,3,0,NULL,0,1,1,0,NULL),
(78,'业务成本(本期)','BY_ZYYWCB',5,2,0,NULL,0,1,1,0,NULL),
(79,'业务成本(本年)','BN_ZYYWCB',5,3,0,NULL,0,1,1,0,NULL),
(80,'营业税金及附加(本期)','BY_ZYYWSJJFJ',6,2,0,NULL,0,1,1,0,NULL),
(81,'营业税金及附加(本年)','BN_ZYYWSJJFJ',6,3,0,NULL,0,1,1,0,NULL),
(82,'销售费用(本期)','BY_XSFY',7,2,0,NULL,0,1,1,0,NULL),
(83,'销售费用(本年)','BN_XSFY',7,3,0,NULL,0,1,1,0,NULL),
(84,'管理费用(本期)','BY_GLFY',8,2,0,NULL,0,1,1,0,NULL),
(85,'管理费用(本年)','BN_GLFY',8,3,0,NULL,0,1,1,0,NULL),
(86,'财务费用(本期)','BY_CWFY',9,2,0,NULL,0,1,1,0,NULL),
(87,'财务费用(本年)','BN_CWFY',9,3,0,NULL,0,1,1,0,NULL),
(88,'资产减值损失(本期)','BY_ZCJZSS',10,2,0,NULL,0,1,1,0,NULL),
(89,'资产减值损失(本年)','BN_ZCJZSS',10,3,0,NULL,0,1,1,0,NULL),
(90,'公允价值变动收益(本期)','BY_GYJZBDSY',11,2,0,NULL,0,1,1,0,NULL),
(91,'公允价值变动收益(本年)','BN_GYJZBDSY',11,3,0,NULL,0,1,1,0,NULL),
(92,'投资收益(本期)','BY_TZSY',12,2,0,NULL,0,1,1,0,NULL),
(93,'投资收益(本年)','BN_TZSY',12,3,0,NULL,0,1,1,0,NULL),
(94,'对联营企业和合营企业的投资收益(本期)','BY_DLYQYHHYQYDTZSY',13,2,0,NULL,0,1,1,0,NULL),
(95,'对联营企业和合营企业的投资收益(本年)','BN_DLYQYHHYQYDTZSY',13,3,0,NULL,0,1,1,0,NULL),
(96,'营业利润(本期)','BY_YYLR',14,2,0,NULL,0,1,1,0,NULL),
(97,'营业利润(本年)','BN_YYLR',14,3,0,NULL,0,1,1,0,NULL),
(98,'营业外收入(本期)','BY_YYWSR',15,2,0,NULL,0,1,1,0,NULL),
(99,'营业外收入(本年)','BN_YYWSR',15,3,0,NULL,0,1,1,0,NULL),
(100,'营业外支出(本期)','BY_YYWZC',16,2,0,NULL,0,1,1,0,NULL),
(101,'营业外支出(本年)','BN_YYWZC',16,3,0,NULL,0,1,1,0,NULL),
(102,'非流动资产处置损失(本期)','BY_FLDZCCZSS',17,2,0,NULL,0,1,1,0,NULL),
(103,'非流动资产处置损失(本年)','BN_FLDZCCZSS',17,3,0,NULL,0,1,1,0,NULL),
(104,'利润总额(本期)','BY_LRZE',18,2,0,NULL,0,1,1,0,NULL),
(105,'利润总额(本年)','BN_LRZE',18,3,0,NULL,0,1,1,0,NULL),
(106,'所得税费用(本期)','BY_SDS',19,2,0,NULL,0,1,1,0,NULL),
(107,'所得税费用(本年)','BN_SDS',19,3,0,NULL,0,1,1,0,NULL),
(108,'净利润(本期)','BY_JLR',20,2,0,NULL,0,1,1,0,NULL),
(109,'净利润(本年)','BN_JLR',20,3,0,NULL,0,1,1,0,NULL),
(110,'每股收益(本期)','BY_MGSY',21,2,0,NULL,0,1,1,0,NULL),
(111,'每股收益(本年)','BN_MGSY',21,3,0,NULL,0,1,1,0,NULL),
(112,'基本每股收益(本期)','BY_JBMGSY',22,2,0,NULL,0,1,1,0,NULL),
(113,'基本每股收益(本年)','BN_JBMGSY',22,3,0,NULL,0,1,1,0,NULL),
(114,'稀释每股收益(本期)','BY_XSMGSY',23,2,0,NULL,0,1,1,0,NULL),
(115,'稀释每股收益(本年)','BN_XSMGSY',23,3,0,NULL,0,1,1,0,NULL),
(116,'导入用户Id','IMP_USER',0,0,0,NULL,0,0,0,1,NULL),
(117,'导入公司Id','ORG_ID',0,0,0,NULL,0,0,0,1,NULL),
(118,'会计年月','KJYEAR_MOTH',2,5,0,NULL,0,1,2,0,NULL),
(119,'单位','JEDW',2,8,0,NULL,0,1,2,0,NULL),
(120,'货币资金(流动资产)','QM_LDZC_HBZJ',5,3,0,NULL,0,1,2,0,NULL),
(121,'货币资金(流动资产)','NC_LDZC_HBZJ',5,4,0,NULL,0,1,2,0,NULL),
(122,'交易性金融资产(流动资产)','QM_LDZC_JYXJRZC',6,3,0,NULL,0,1,2,0,NULL),
(123,'交易性金融资产(流动资产)','NC_LDZC_JYXJRZC',6,4,0,NULL,0,1,2,0,NULL),
(124,'应收票据(流动资产)','QM_LDZC_YSPJ',7,3,0,NULL,0,1,2,0,NULL),
(125,'应收票据(流动资产)','NC_LDZC_YSPJ',7,4,0,NULL,0,1,2,0,NULL),
(126,'应收账款(流动资产)','QM_LDZC_YSZK',8,3,0,NULL,0,1,2,0,NULL),
(127,'应收账款(流动资产)','NC_LDZC_YSZK',8,4,0,NULL,0,1,2,0,NULL),
(128,'预付款项(流动资产)','QM_LDZC_YFZK',9,3,0,NULL,0,1,2,0,NULL),
(129,'预付款项(流动资产)','NC_LDZC_YFZK',9,4,0,NULL,0,1,2,0,NULL),
(130,'应收利息(流动资产)','QM_LDZC_YSLX',10,3,0,NULL,0,1,2,0,NULL),
(131,'应收利息(流动资产)','NC_LDZC_YSLX',10,4,0,NULL,0,1,2,0,NULL),
(132,'应收股利(流动资产)','QM_LDZC_YSGL',11,3,0,NULL,0,1,2,0,NULL),
(133,'应收股利(流动资产)','NC_LDZC_YSGL',11,4,0,NULL,0,1,2,0,NULL),
(134,'其他应收款(流动资产)','QM_LDZC_QTYSK',12,3,0,NULL,0,1,2,0,NULL),
(135,'其他应收款(流动资产)','NC_LDZC_QTYSK',12,4,0,NULL,0,1,2,0,NULL),
(136,'存货(流动资产)','QM_LDZC_CH',13,3,0,NULL,0,1,2,0,NULL),
(137,'存货(流动资产)','NC_LDZC_CH',13,4,0,NULL,0,1,2,0,NULL),
(138,'一年内到期的非流动资产(流动资产)','QM_LDZC_YNNDQCQZQTZ',14,3,0,NULL,0,1,2,0,NULL),
(139,'一年内到期的非流动资产(流动资产)','NC_LDZC_YNNDQCQZQTZ',14,4,0,NULL,0,1,2,0,NULL),
(140,'其他流动资产(流动资产)','QM_LDZC_QTLDZC',15,3,0,NULL,0,1,2,0,NULL),
(141,'其他流动资产(流动资产)','NC_LDZC_QTLDZC',15,4,0,NULL,0,1,2,0,NULL),
(142,'流动资产合计','QM_LDZC_HJ',16,3,0,NULL,0,1,2,0,NULL),
(143,'流动资产合计','NC_LDZC_HJ',16,4,0,NULL,0,1,2,0,NULL),
(144,'可供出售金融资产(非流动资产)','QM_FLDZC_KGCSJRZC',18,3,0,NULL,0,1,2,0,NULL),
(145,'可供出售金融资产(非流动资产)','NC_FLDZC_KGCSJRZC',18,4,0,NULL,0,1,2,0,NULL),
(146,'持有至到期投资(非流动资产)','QM_FLDZC_CYZDQTZ',19,3,0,NULL,0,1,2,0,NULL),
(147,'持有至到期投资(非流动资产)','NC_FLDZC_CYZDQTZ',19,4,0,NULL,0,1,2,0,NULL),
(148,'长期应收款(非流动资产)','QM_FLDZC_CQYSK',20,3,0,NULL,0,1,2,0,NULL),
(149,'长期应收款(非流动资产)','NC_FLDZC_CQYSK',20,4,0,NULL,0,1,2,0,NULL),
(150,'长期股权投资(非流动资产)','QM_FLDZC_CQGQTZ',21,3,0,NULL,0,1,2,0,NULL),
(151,'长期股权投资(非流动资产)','NC_FLDZC_CQGQTZ',21,4,0,NULL,0,1,2,0,NULL),
(152,'投资性房地产(非流动资产)','QM_FLDZC_TZXFDC',22,3,0,NULL,0,1,2,0,NULL),
(153,'投资性房地产(非流动资产)','NC_FLDZC_TZXFDC',22,4,0,NULL,0,1,2,0,NULL),
(154,'固定资产(非流动资产)','QM_FLDZC_GDZC',23,3,0,NULL,0,1,2,0,NULL),
(155,'固定资产(非流动资产)','NC_FLDZC_GDZC',23,4,0,NULL,0,1,2,0,NULL),
(156,'在建工程(非流动资产)','QM_FLDZC_ZJGC',24,3,0,NULL,0,1,2,0,NULL),
(157,'在建工程(非流动资产)','NC_FLDZC_ZJGC',24,4,0,NULL,0,1,2,0,NULL),
(158,'工程物资(非流动资产)','QM_FLDZC_GCWZ',25,3,0,NULL,0,1,2,0,NULL),
(159,'工程物资(非流动资产)','NC_FLDZC_GCWZ',25,4,0,NULL,0,1,2,0,NULL),
(160,'固定资产清理(非流动资产)','QM_FLDZC_GDZCQL',26,3,0,NULL,0,1,2,0,NULL),
(161,'固定资产清理(非流动资产)','NC_FLDZC_GDZCQL',26,4,0,NULL,0,1,2,0,NULL),
(162,'生产性生物资产(非流动资产)','QM_FLDZC_SCXSWZC',27,3,0,NULL,0,1,2,0,NULL),
(163,'生产性生物资产(非流动资产)','NC_FLDZC_SCXSWZC',27,4,0,NULL,0,1,2,0,NULL),
(164,'油气资产(非流动资产)','QM_FLDZC_YQZC',28,3,0,NULL,0,1,2,0,NULL),
(165,'油气资产(非流动资产)','NC_FLDZC_YQZC',28,4,0,NULL,0,1,2,0,NULL),
(166,'无形资产(非流动资产)','QM_FLDZC_WXZC',29,3,0,NULL,0,1,2,0,NULL),
(167,'无形资产(非流动资产)','NC_FLDZC_WXZC',29,4,0,NULL,0,1,2,0,NULL),
(168,'开发支出(非流动资产)','QM_FLDZC_KFZC',30,3,0,NULL,0,1,2,0,NULL),
(169,'开发支出(非流动资产)','NC_FLDZC_KFZC',30,4,0,NULL,0,1,2,0,NULL),
(170,'商誉(非流动资产)','QM_FLDZC_SY',31,3,0,NULL,0,1,2,0,NULL),
(171,'商誉(非流动资产)','NC_FLDZC_SY',31,4,0,NULL,0,1,2,0,NULL),
(172,'长期待摊费用(非流动资产)','QM_FLDZC_CQDTFY',32,3,0,NULL,0,1,2,0,NULL),
(173,'长期待摊费用(非流动资产)','NC_FLDZC_CQDTFY',32,4,0,NULL,0,1,2,0,NULL),
(174,'递延所得税资产(非流动资产)','QM_FLDZC_DYSDSZC',33,3,0,NULL,0,1,2,0,NULL),
(175,'递延所得税资产(非流动资产)','NC_FLDZC_DYSDSZC',33,4,0,NULL,0,1,2,0,NULL),
(176,'其他非流动资产','QM_FLDZC_QTFLDZC',34,3,0,NULL,0,1,2,0,NULL),
(177,'其他非流动资产','NC_FLDZC_QTFLDZC',34,4,0,NULL,0,1,2,0,NULL),
(178,'非流动资产合计','QM_FLDZC_FLDZCHJ',35,3,0,NULL,0,1,2,0,NULL),
(179,'非流动资产合计','NC_FLDZC_FLDZCHJ',35,4,0,NULL,0,1,2,0,NULL),
(180,'资产总计','QM_ZCZJ',36,3,0,NULL,0,1,2,0,NULL),
(181,'资 产 总 计','NC_ZCZJ',36,4,0,NULL,0,1,2,0,NULL),
(182,'短期借款(流动负债)','QM_LDFZ_DQJK',5,7,0,NULL,0,1,2,0,NULL),
(183,'短期借款(流动负债)','NC_LDFZ_DQJK',5,8,0,NULL,0,1,2,0,NULL),
(184,'交易性金融负债(流动负债)','QM_LDFZ_JYXJRFZ',6,7,0,NULL,0,1,2,0,NULL),
(185,'交易性金融负债(流动负债)','NC_LDFZ_JYXJRFZ',6,8,0,NULL,0,1,2,0,NULL),
(186,'应付票据','QM_LDFZ_YFPJ',7,7,0,NULL,0,1,2,0,NULL),
(187,'应付票据','NC_LDFZ_YFPJ',7,8,0,NULL,0,1,2,0,NULL),
(188,'应付账款','QM_LDFZ_YFZK',8,7,0,NULL,0,1,2,0,NULL),
(189,'应付账款','NC_LDFZ_YFZK',8,8,0,NULL,0,1,2,0,NULL),
(190,'预收款项','QM_LDFZ_YSZK',9,7,0,NULL,0,1,2,0,NULL),
(191,'预收款项','NC_LDFZ_YSZK',9,8,0,NULL,0,1,2,0,NULL),
(192,'应付职工薪酬(应付工资)','QM_LDFZ_YFGZ',10,7,0,NULL,0,1,2,0,NULL),
(193,'应付职工薪酬(应付工资)','NC_LDFZ_YFGZ',10,8,0,NULL,0,1,2,0,NULL),
(194,'应交税费(应交税金)','QM_LDFZ_YJSJ',11,7,0,NULL,0,1,2,0,NULL),
(195,'应交税费(应交税金)','NC_LDFZ_YJSJ',11,8,0,NULL,0,1,2,0,NULL),
(196,'应付利息','QM_LDFZ_YFLX',12,7,0,NULL,0,1,2,0,NULL),
(197,'应付利息','NC_LDFZ_YFLX',12,8,0,NULL,0,1,2,0,NULL),
(198,'应付股利','QM_LDFZ_YFGL',13,7,0,NULL,0,1,2,0,NULL),
(199,'应付股利','NC_LDFZ_YFGL',13,8,0,NULL,0,1,2,0,NULL),
(200,'其他应付款','QM_LDFZ_QTYFK',14,7,0,NULL,0,1,2,0,NULL),
(201,'其他应付款','NC_LDFZ_QTYFK',14,8,0,NULL,0,1,2,0,NULL),
(202,'一年内到期的非流动负债(一年内到期的长期负债)','QM_LDFZ_YNNDQCQFZ',15,7,0,NULL,0,1,2,0,NULL),
(203,'一年内到期的非流动负债(一年内到期的长期负债)','NC_LDFZ_YNNDQCQFZ',15,8,0,NULL,0,1,2,0,NULL),
(204,'其他流动负债','QM_LDFZ_QTLDFZ',16,7,0,NULL,0,1,2,0,NULL),
(205,'其他流动负债','NC_LDFZ_QTLDFZ',16,8,0,NULL,0,1,2,0,NULL),
(206,'流动负债合计','QM_LDFZ_LDFZHJ',17,7,0,NULL,0,1,2,0,NULL),
(207,'流动负债合计','NC_LDFZ_LDFZHJ',17,8,0,NULL,0,1,2,0,NULL),
(208,'长期借款','QM_FLDFZ_CQJK',19,7,0,NULL,0,1,2,0,NULL),
(209,'长期借款','NC_FLDFZ_CQJK',19,8,0,NULL,0,1,2,0,NULL),
(210,'应付债券','QM_FLDFZ_YFZQ',20,7,0,NULL,0,1,2,0,NULL),
(211,'应付债券','NC_FLDFZ_YFZQ',20,8,0,NULL,0,1,2,0,NULL),
(212,'长期应付款','QM_FLDFZ_CQYFK',21,7,0,NULL,0,1,2,0,NULL),
(213,'长期应付款','NC_FLDFZ_CQYFK',21,8,0,NULL,0,1,2,0,NULL),
(214,'专项应付款','QM_FLDFZ_ZXYFK',22,7,0,NULL,0,1,2,0,NULL),
(215,'专项应付款','NC_FLDFZ_ZXYFK',22,8,0,NULL,0,1,2,0,NULL),
(216,'预计负债','QM_FLDFZ_YJFZ',23,7,0,NULL,0,1,2,0,NULL),
(217,'预计负债','NC_FLDFZ_YJFZ',23,8,0,NULL,0,1,2,0,NULL),
(218,'递延所得税负债(递延税款货项)','QM_DYSX_DYSKHX',24,7,0,NULL,0,1,2,0,NULL),
(219,'递延所得税负债(递延税款货项)','NC_DYSX_DYSKHX',24,8,0,NULL,0,1,2,0,NULL),
(220,'其他非流动负债(其他长期负债','QM_FLDFZ_QTCQFZ',25,7,0,NULL,0,1,2,0,NULL),
(221,'其他非流动负债(其他长期负债','NC_FLDFZ_QTCQFZ',25,8,0,NULL,0,1,2,0,NULL),
(222,'非流动负债合计(长期负债合计)','QM_FLDFZ_CQFZHJ',26,7,0,NULL,0,1,2,0,NULL),
(223,'流动负债合计(长期负债合计)','NC_FLDFZ_CQFZHJ',26,8,0,NULL,0,1,2,0,NULL),
(224,' 负债合计(递延税项:负债合计 )','QM_DYSX_FZHJ',27,7,0,NULL,0,1,2,0,NULL),
(225,' 负债合计(递延税项:负债合计 )','NC_DYSX_FZHJ',27,8,0,NULL,0,1,2,0,NULL),
(228,'实收资本（或股本）','QM_GDQY_SSZB',29,7,0,NULL,0,1,2,0,NULL),
(229,'实收资本（或股本）','NC_GDQY_SSZB',29,8,0,NULL,0,1,2,0,NULL),
(230,'资本公积','QM_GDQY_ZBGJ',30,7,0,NULL,0,1,2,0,NULL),
(231,'资本公积','NC_GDQY_ZBGJ',30,8,0,NULL,0,1,2,0,NULL),
(232,'减：库存股','QM_GDQY_KCG',31,7,0,NULL,0,1,2,0,NULL),
(233,'减：库存股','NC_GDQY_KCG',31,8,0,NULL,0,1,2,0,NULL),
(234,'盈余公积','QM_GDQY_YYGJ',32,7,0,NULL,0,1,2,0,NULL),
(235,'盈余公积','NC_GDQY_YYGJ',32,8,0,NULL,0,1,2,0,NULL),
(236,'未分配利润','QM_GDQY_WFPLR',33,7,0,NULL,0,1,2,0,NULL),
(237,'未分配利润','NC_GDQY_WFPLR',33,8,0,NULL,0,1,2,0,NULL),
(238,'所 有 者 权 益 合 计','QM_GDQY_SYZQYHJ',34,7,0,NULL,0,1,2,0,NULL),
(239,'所 有 者 权 益 合 计','NC_GDQY_SYZQYHJ',34,8,0,NULL,0,1,2,0,NULL),
(242,' 负债和所有者权益（或股东权益）总计','QM_GDQY_FZHSYZQY',36,7,0,NULL,0,1,2,0,NULL),
(243,' 负债和所有者权益（或股东权益）总计','NC_GDQY_FZHSYZQY',36,8,0,NULL,0,1,2,0,NULL),
(246,'会计年月','KJYEAR_MOTH',1,4,0,NULL,0,1,3,0,NULL),
(247,'币种','HBZL',1,10,0,NULL,0,1,3,0,NULL),
(248,'主体账簿','ZTZB',4,0,1,2,0,1,3,0,NULL),
(249,'科目编码','SUBJECT_CODE',4,1,1,2,0,1,3,0,NULL),
(250,'科目名称','SUBJECT_NAME',4,2,1,2,0,1,3,0,NULL),
(252,'期初余额(期初借方余额)','QCJFYE',4,4,1,2,0,1,3,0,NULL),
(253,'本期借方发生','BQJFFSE',4,5,1,2,0,1,3,0,NULL),
(254,'本期贷方发生','BQDFFSE',4,6,1,2,0,1,3,0,NULL),
(255,'累计借方发生','BNJFLJ',4,7,1,2,0,1,3,0,NULL),
(258,'累计贷方发生','BNDFLJ',4,8,1,2,0,1,3,0,NULL),
(259,'方向','FX',4,9,1,2,0,1,3,0,NULL),
(260,'期末余额(期末借方余额)','QMJFYE',4,10,1,2,0,1,3,0,NULL),
(261,'会计年月','KJYEAR_MOTH_DAY',2,4,0,NULL,0,1,4,0,NULL),
(262,'币种','HBZL',2,9,0,NULL,0,1,4,0,NULL),
(263,'年','KJYEAR',4,0,0,NULL,0,1,4,0,NULL),
(264,'月','KJMOTH',6,0,1,2,0,1,4,0,NULL),
(265,'日','KJDAY',6,1,1,2,0,1,4,0,NULL),
(266,'科目','SUBJECT_NAME',2,2,0,NULL,0,1,4,0,NULL),
(267,'主体账簿','ZTZB',6,2,1,2,0,1,4,0,NULL),
(268,'凭证号','BZH',6,3,1,2,0,1,4,0,NULL),
(269,'摘要','REMARK',6,4,1,2,0,1,4,0,NULL),
(270,'对方科目','OHTER_SUB_NAME',6,5,1,2,0,1,4,0,NULL),
(271,'借方','JF',6,6,1,2,0,1,4,0,NULL),
(272,'贷方','DF',6,7,1,2,0,1,4,0,NULL),
(273,'方向','FX',6,8,1,2,0,1,4,0,NULL),
(274,'余额','YE',6,9,1,2,0,1,4,0,NULL),
(275,'会计年月','KJYEAR_MOTH',2,2,0,NULL,0,2,5,0,NULL),
(276,'单位','JEDW',2,0,0,NULL,0,2,5,0,NULL),
(277,'销售商品、提供劳务收到的现金（本期）','BQ_JYHD_XSSPTGLWSDDXJ',5,2,0,NULL,0,2,5,0,NULL),
(278,'销售商品、提供劳务收到的现金（本年）','JYHD_XSSPTGLWSDDXJ',5,3,0,NULL,0,2,5,0,NULL),
(279,'收到的税费返还（本期）','BQ_JYHD_SDDSFFH',6,2,0,NULL,0,2,5,0,NULL),
(280,'收到的税费返还（本年）','JYHD_SDDSFFH',6,3,0,NULL,0,2,5,0,NULL),
(281,'收到其他与经营活动有关的现金(本期）','BQ_JYHD_SDDQTYGDXJ',7,2,0,NULL,0,2,5,0,NULL),
(282,'收到其他与经营活动有关的现金(本年）','JYHD_SDDQTYGDXJ',7,3,0,NULL,0,2,5,0,NULL),
(283,'经营活动现金流入小计（本期）','BQ_JYHD_XJLRXJ',8,2,0,NULL,0,2,5,0,NULL),
(284,'经营活动现金流入小计（本年）','JYHD_XJLRXJ',8,3,0,NULL,0,2,5,0,NULL),
(285,' 购买商品、接受劳务支付的现金(本期）','BQ_JYHD_GJZFDXJ',9,2,0,NULL,0,2,5,0,NULL),
(286,' 购买商品、接受劳务支付的现金（本年）','JYHD_GJZFDXJ',9,3,0,NULL,0,2,5,0,NULL),
(287,'支付给职工以及为职工支付的现金(本期）','BQ_JYHD_ZFGZGDXJ',10,2,0,NULL,0,2,5,0,NULL),
(288,'支付给职工以及为职工支付的现金(本年）','JYHD_ZFGZGDXJ',10,3,0,NULL,0,2,5,0,NULL),
(289,' 支付的各项税费(本期）','BQ_JYHD_ZFDGXSF',11,2,0,NULL,0,2,5,0,NULL),
(290,' 支付的各项税费（本年）','JYHD_ZFDGXSF',11,3,0,NULL,0,2,5,0,NULL),
(291,'支付其他与经营活动有关的现金（本期）','BQ_JYHD_ZFDQTDXJ',12,2,0,NULL,0,2,5,0,NULL),
(292,'支付其他与经营活动有关的现金（本年）','JYHD_ZFDQTDXJ',12,3,0,NULL,0,2,5,0,NULL),
(293,'经营活动现金流出小计(本期）','BQ_JYHD_XJLCXJ',13,2,0,NULL,0,2,5,0,NULL),
(294,'经营活动现金流出小计（本年）','JYHD_XJLCXJ',13,3,0,NULL,0,2,5,0,NULL),
(295,'经营活动产生的现金流量净额(本期）','BQ_JYHD_JYHDCSDJE',14,2,0,NULL,0,2,5,0,NULL),
(296,'经营活动产生的现金流量净额（本年）','JYHD_JYHDCSDJE',14,3,0,NULL,0,2,5,0,NULL),
(297,'收回投资收到的现金(本期）','BQ_TZHD_SHTZSSDXJ',16,2,0,NULL,0,2,5,0,NULL),
(298,'收回投资收到的现金（本年）','TZHD_SHTZSSDXJ',16,3,0,NULL,0,2,5,0,NULL),
(299,'取得投资收益收到的现金(本期）','BQ_TZHD_QDSYSSDXJ',17,2,0,NULL,0,2,5,0,NULL),
(300,'取得投资收益收到的现金（本年）','TZHD_QDSYSSDXJ',17,3,0,NULL,0,2,5,0,NULL),
(301,'处置固定资产、无形资产和其他长期资产收回的现金净额（本期）','BQ_TZHD_CZWXHQTSHDXJJE',18,2,0,NULL,0,2,5,0,NULL),
(302,'处置固定资产、无形资产和其他长期资产收回的现金净额（本年）','TZHD_CZWXHQTSHDXJJE',18,3,0,NULL,0,2,5,0,NULL),
(303,'处置子公司及其他营业单位收到的现金净额（本期）','BQ_TZHD_CZZGSJQTZFDXJJE',19,2,0,NULL,0,2,5,0,NULL),
(304,'处置子公司及其他营业单位收到的现金净额（本年）','TZHD_CZZGSJQTZFDXJJE',19,3,0,NULL,0,2,5,0,NULL),
(305,'收到其他与投资活动有关的现金(本期）','BQ_TZHD_SDDQTYGDXJ',20,2,0,NULL,0,2,5,0,NULL),
(306,'收到其他与投资活动有关的现金（本年）','TZHD_SDDQTYGDXJ',20,3,0,NULL,0,2,5,0,NULL),
(307,'投资活动现金流入小计(本期）','BQ_TZHD_XJLRXJ',21,2,0,NULL,0,2,5,0,NULL),
(308,'投资活动现金流入小计（本年）','TZHD_XJLRXJ',21,3,0,NULL,0,2,5,0,NULL),
(309,'购建固定资产、无形资产和其他长期资产支付的现金(本期）','BQ_TZHD_GJGDWXHQTZFDXJ',22,2,0,NULL,0,2,5,0,NULL),
(310,'购建固定资产、无形资产和其他长期资产支付的现金（本年）','TZHD_GJGDWXHQTZFDXJ',22,3,0,NULL,0,2,5,0,NULL),
(311,'投资支付的现金（本期）','BQ_TZHD_TZSZFDXJ',23,2,0,NULL,0,2,5,0,NULL),
(312,'投资支付的现金（本年）','TZHD_TZSZFDXJ',23,3,0,NULL,0,2,5,0,NULL),
(313,'取得子公司及其他营业单位支付的现金净额(本期）','BQ_TZHD_QDZGSJQTZFDXJJE',24,2,0,NULL,0,2,5,0,NULL),
(314,'取得子公司及其他营业单位支付的现金净额（本年）','TZHD_QDZGSJQTZFDXJJE',24,3,0,NULL,0,2,5,0,NULL),
(315,'支付其他与投资活动有关的现金（本期）','BQ_TZHD_ZFQTDXJ',25,2,0,NULL,0,2,5,0,NULL),
(316,'支付其他与投资活动有关的现金（本年）','TZHD_ZFQTDXJ',25,3,0,NULL,0,2,5,0,NULL),
(317,'投资活动现金流出小计(本期）','BQ_TZHD_XJLCXJ',26,2,0,NULL,0,2,5,0,NULL),
(318,'投资活动现金流出小计（本年）','TZHD_XJLCXJ',26,3,0,NULL,0,2,5,0,NULL),
(319,'投资活动产生的现金流量净额(本期）','BQ_TZHD_TZHDSCSDXJLLJE',27,2,0,NULL,0,2,5,0,NULL),
(320,'投资活动产生的现金流量净额（本年）','TZHD_TZHDSCSDXJLLJE',27,3,0,NULL,0,2,5,0,NULL),
(321,'吸收投资收到的现金(本期）','BQ_CZHD_XSTZSSDDXJ',29,2,0,NULL,0,2,5,0,NULL),
(322,'吸收投资收到的现金(本年）','CZHD_XSTZSSDDXJ',29,3,0,NULL,0,2,5,0,NULL),
(323,'子公司吸收少数股东投资收到的现金(本期）','BQ_CZHD_ZGSXSSDDXJ',30,2,0,NULL,0,2,5,0,NULL),
(324,'子公司吸收少数股东投资收到的现金（本年）','CZHD_ZGSXSSDDXJ',30,3,0,NULL,0,2,5,0,NULL),
(325,' 取得借款收到的现金(本期）','BQ_CZHD_JKSSDDXJ',31,2,0,NULL,0,2,5,0,NULL),
(326,' 取得借款收到的现金（本年）','CZHD_JKSSDDXJ',31,3,0,NULL,0,2,5,0,NULL),
(327,'收到其他与筹资活动有关的现金(本期）','BQ_CZHD_SDQTYGDXJ',32,2,0,NULL,0,2,5,0,NULL),
(328,'收到其他与筹资活动有关的现金（本年）','CZHD_SDQTYGDXJ',32,3,0,NULL,0,2,5,0,NULL),
(329,'筹资活动现金流入小计(本期）','BQ_CZHD_XJLRXJ',33,2,0,NULL,0,2,5,0,NULL),
(330,'筹资活动现金流入小计（本年）','CZHD_XJLRXJ',33,3,0,NULL,0,2,5,0,NULL),
(331,'偿还债务支付的现金(本期）','BQ_CZHD_CHZWSZFDXJ',34,2,0,NULL,0,2,5,0,NULL),
(332,'偿还债务支付的现金（本年）','CZHD_CHZWSZFDXJ',34,3,0,NULL,0,2,5,0,NULL),
(333,'分配股利、利润或偿付利息支付的现金(本期）','BQ_CZHD_FPGLSZFDXJ',35,2,0,NULL,0,2,5,0,NULL),
(334,'分配股利、利润或偿付利息支付的现金（本年）','CZHD_FPGLSZFDXJ',35,3,0,NULL,0,2,5,0,NULL),
(335,'子公司支付给少数股东的股利、利润（本期）','BQ_CZHD_ZGSZFGLLR',36,2,0,NULL,0,2,5,0,NULL),
(336,'子公司支付给少数股东的股利、利润（本年）','CZHD_ZGSZFGLLR',36,3,0,NULL,0,2,5,0,NULL),
(337,'支付其他与筹资活动有关的现金(本期）','BQ_CZHD_ZFQTYGDXJ',37,2,0,NULL,0,2,5,0,NULL),
(338,'支付其他与筹资活动有关的现金（本年）','CZHD_ZFQTYGDXJ',37,3,0,NULL,0,2,5,0,NULL),
(339,'筹资活动现金流出小计(本期）','BQ_CZHD_XJLCXJ',38,2,0,NULL,0,2,5,0,NULL),
(340,'筹资活动现金流出小计（本年）','CZHD_XJLCXJ',38,3,0,NULL,0,2,5,0,NULL),
(341,'筹资活动产生的现金流量净额(本期）','BQ_CZHD_CZHDCSDXJLLJE',39,2,0,NULL,0,2,5,0,NULL),
(342,'筹资活动产生的现金流量净额（本年）','CZHD_CZHDCSDXJLLJE',39,3,0,NULL,0,2,5,0,NULL),
(343,'汇率变动对现金及现金等价物的影响（本期）','BQ_CZHD_HLBDXJDYX',40,2,0,NULL,0,2,5,0,NULL),
(344,'汇率变动对现金及现金等价物的影响（本年）','CZHD_HLBDXJDYX',40,3,0,NULL,0,2,5,0,NULL),
(345,'现金及现金等价物净增加额(本期）','BQ_XJJXJDJWJZJE',41,2,0,NULL,0,2,5,0,NULL),
(346,'现金及现金等价物净增加额（本年）','XJJXJDJWJZJE',41,3,0,NULL,0,2,5,0,NULL),
(347,'期初现金及现金等价物余额（本期）','BQ_QCXJJXJDJWYE',42,2,0,NULL,0,2,5,0,NULL),
(348,'期初现金及现金等价物余额（本年）','QCXJJXJDJWYE',42,3,0,NULL,0,2,5,0,NULL),
(349,'期末现金及现金等价物余额（本期）','BQ_QMXJJXJDJWYE',43,2,0,NULL,0,2,5,0,NULL),
(350,'期末现金及现金等价物余额（本年）','QMXJJXJDJWYE',43,3,0,NULL,0,2,5,0,NULL),
(351,'会计年月','KJYEAR_MOTH',2,1,0,NULL,0,2,1,0,NULL),
(352,'单位','JEDW',2,3,0,NULL,0,2,1,0,NULL),
(353,'营业收入(本期)','BY_ZYYWSR',4,2,0,NULL,0,2,1,0,NULL),
(354,'营业收入(本年)','BN_ZYYWSR',4,3,0,NULL,0,2,1,0,NULL),
(355,'业务成本(本期)','BY_ZYYWCB',6,2,0,NULL,0,2,1,0,NULL),
(356,'业务成本(本年)','BN_ZYYWCB',6,3,0,NULL,0,2,1,0,NULL),
(357,'营业税金及附加(本期)','BY_ZYYWSJJFJ',7,2,0,NULL,0,2,1,0,NULL),
(358,'营业税金及附加(本年)','BN_ZYYWSJJFJ',7,3,0,NULL,0,2,1,0,NULL),
(359,'销售费用(本期)','BY_XSFY',8,2,0,NULL,0,2,1,0,NULL),
(360,'销售费用(本年)','BN_XSFY',8,3,0,NULL,0,2,1,0,NULL),
(361,'管理费用(本期)','BY_GLFY',9,2,0,NULL,0,2,1,0,NULL),
(362,'管理费用(本年)','BN_GLFY',9,3,0,NULL,0,2,1,0,NULL),
(363,'财务费用(本期)','BY_CWFY',10,2,0,NULL,0,2,1,0,NULL),
(364,'财务费用(本年)','BN_CWFY',10,3,0,NULL,0,2,1,0,NULL),
(365,'资产减值损失(本期)','BY_ZCJZSS',11,2,0,NULL,0,2,1,0,NULL),
(366,'资产减值损失(本年)','BN_ZCJZSS',11,3,0,NULL,0,2,1,0,NULL),
(367,'公允价值变动收益(本期)','BY_GYJZBDSY',12,2,0,NULL,0,2,1,0,NULL),
(368,'公允价值变动收益(本年)','BN_GYJZBDSY',12,3,0,NULL,0,2,1,0,NULL),
(369,'投资收益(本期)','BY_TZSY',13,2,0,NULL,0,2,1,0,NULL),
(370,'投资收益(本年)','BN_TZSY',13,3,0,NULL,0,2,1,0,NULL),
(371,'对联营企业和合营企业的投资收益(本期)','BY_DLYQYHHYQYDTZSY',14,2,0,NULL,0,2,1,0,NULL),
(372,'对联营企业和合营企业的投资收益(本年)','BN_DLYQYHHYQYDTZSY',14,3,0,NULL,0,2,1,0,NULL),
(373,'营业利润(本期)','BY_YYLR',15,2,0,NULL,0,2,1,0,NULL),
(374,'营业利润(本年)','BN_YYLR',15,3,0,NULL,0,2,1,0,NULL),
(375,'营业外收入(本期)','BY_YYWSR',16,2,0,NULL,0,2,1,0,NULL),
(376,'营业外收入(本年)','BN_YYWSR',16,3,0,NULL,0,2,1,0,NULL),
(377,'营业外支出(本期)','BY_YYWZC',17,2,0,NULL,0,2,1,0,NULL),
(378,'营业外支出(本年)','BN_YYWZC',17,3,0,NULL,0,2,1,0,NULL),
(379,'非流动资产处置损失(本期)','BY_FLDZCCZSS',18,2,0,NULL,0,2,1,0,NULL),
(380,'非流动资产处置损失(本年)','BN_FLDZCCZSS',18,3,0,NULL,0,2,1,0,NULL),
(381,'利润总额(本期)','BY_LRZE',19,2,0,NULL,0,2,1,0,NULL),
(382,'利润总额(本年)','BN_LRZE',19,3,0,NULL,0,2,1,0,NULL),
(383,'所得税费用(本期)','BY_SDS',20,2,0,NULL,0,2,1,0,NULL),
(384,'所得税费用(本年)','BN_SDS',20,3,0,NULL,0,2,1,0,NULL),
(385,'净利润(本期)','BY_JLR',21,2,0,NULL,0,2,1,0,NULL),
(386,'净利润(本年)','BN_JLR',21,3,0,NULL,0,2,1,0,NULL),
(389,'基本每股收益(本期)','BY_JBMGSY',25,2,0,NULL,0,2,1,0,NULL),
(390,'基本每股收益(本年)','BN_JBMGSY',25,3,0,NULL,0,2,1,0,NULL),
(391,'稀释每股收益(本期)','BY_XSMGSY',26,2,0,NULL,0,2,1,0,NULL),
(392,'稀释每股收益(本年)','BN_XSMGSY',26,3,0,NULL,0,2,1,0,NULL),
(414,'营业总成本(本期)','BY_YYZCB',5,2,0,NULL,0,2,1,0,NULL),
(415,'营业总成本(本年)','BN_YYZCB',5,3,0,NULL,0,2,1,0,NULL),
(416,'归属于母公司所有者的净利润(本期)','BY_GSYMGSJLR',22,2,0,NULL,0,2,1,0,NULL),
(417,'归属于母公司所有者的净利润(本年)','BN_GSYMGSJLR',22,3,0,NULL,0,2,1,0,NULL),
(418,'少数股东损益(本期)','BY_SSGDSY',23,2,0,NULL,0,2,1,0,NULL),
(419,'少数股东损益(本年)','BN_SSGDSY',23,3,0,NULL,0,2,1,0,NULL),
(420,'会计年月','KJYEAR_MOTH',2,4,0,NULL,0,2,2,0,NULL),
(421,'单位','JEDW',2,8,0,NULL,0,2,2,0,NULL),
(422,'货币资金(流动资产)','QM_LDZC_HBZJ',5,3,0,NULL,0,2,2,0,NULL),
(423,'货币资金(流动资产)','NC_LDZC_HBZJ',5,4,0,NULL,0,2,2,0,NULL),
(424,'交易性金融资产(流动资产)','QM_LDZC_JYXJRZC',6,3,0,NULL,0,2,2,0,NULL),
(425,'交易性金融资产(流动资产)','NC_LDZC_JYXJRZC',6,4,0,NULL,0,2,2,0,NULL),
(426,'应收票据(流动资产)','QM_LDZC_YSPJ',7,3,0,NULL,0,2,2,0,NULL),
(427,'应收票据(流动资产)','NC_LDZC_YSPJ',7,4,0,NULL,0,2,2,0,NULL),
(428,'应收账款(流动资产)','QM_LDZC_YSZK',8,3,0,NULL,0,2,2,0,NULL),
(429,'应收账款(流动资产)','NC_LDZC_YSZK',8,4,0,NULL,0,2,2,0,NULL),
(430,'预付款项(流动资产)','QM_LDZC_YFZK',9,3,0,NULL,0,2,2,0,NULL),
(431,'预付款项(流动资产)','NC_LDZC_YFZK',9,4,0,NULL,0,2,2,0,NULL),
(432,'应收利息(流动资产)','QM_LDZC_YSLX',10,3,0,NULL,0,2,2,0,NULL),
(433,'应收利息(流动资产)','NC_LDZC_YSLX',10,4,0,NULL,0,2,2,0,NULL),
(434,'应收股利(流动资产)','QM_LDZC_YSGL',11,3,0,NULL,0,2,2,0,NULL),
(435,'应收股利(流动资产)','NC_LDZC_YSGL',11,4,0,NULL,0,2,2,0,NULL),
(436,'其他应收款(流动资产)','QM_LDZC_QTYSK',12,3,0,NULL,0,2,2,0,NULL),
(437,'其他应收款(流动资产)','NC_LDZC_QTYSK',12,4,0,NULL,0,2,2,0,NULL),
(438,'存货(流动资产)','QM_LDZC_CH',13,3,0,NULL,0,2,2,0,NULL),
(439,'存货(流动资产)','NC_LDZC_CH',13,4,0,NULL,0,2,2,0,NULL),
(440,'一年内到期的非流动资产(流动资产)','QM_LDZC_YNNDQCQZQTZ',14,3,0,NULL,0,2,2,0,NULL),
(441,'一年内到期的非流动资产(流动资产)','NC_LDZC_YNNDQCQZQTZ',14,4,0,NULL,0,2,2,0,NULL),
(442,'其他流动资产(流动资产)','QM_LDZC_QTLDZC',15,3,0,NULL,0,2,2,0,NULL),
(443,'其他流动资产(流动资产)','NC_LDZC_QTLDZC',15,4,0,NULL,0,2,2,0,NULL),
(444,'流动资产合计','QM_LDZC_HJ',16,3,0,NULL,0,2,2,0,NULL),
(445,'流动资产合计','NC_LDZC_HJ',16,4,0,NULL,0,2,2,0,NULL),
(446,'可供出售金融资产(非流动资产)','QM_FLDZC_KGCSJRZC',21,3,0,NULL,0,2,2,0,NULL),
(447,'可供出售金融资产(非流动资产)','NC_FLDZC_KGCSJRZC',21,4,0,NULL,0,2,2,0,NULL),
(448,'持有至到期投资(非流动资产)','QM_FLDZC_CYZDQTZ',22,3,0,NULL,0,2,2,0,NULL),
(449,'持有至到期投资(非流动资产)','NC_FLDZC_CYZDQTZ',22,4,0,NULL,0,2,2,0,NULL),
(450,'长期应收款(非流动资产)','QM_FLDZC_CQYSK',23,3,0,NULL,0,2,2,0,NULL),
(451,'长期应收款(非流动资产)','NC_FLDZC_CQYSK',23,4,0,NULL,0,2,2,0,NULL),
(452,'长期股权投资(非流动资产)','QM_FLDZC_CQGQTZ',24,3,0,NULL,0,2,2,0,NULL),
(453,'长期股权投资(非流动资产)','NC_FLDZC_CQGQTZ',24,4,0,NULL,0,2,2,0,NULL),
(454,'投资性房地产(非流动资产)','QM_FLDZC_TZXFDC',25,3,0,NULL,0,2,2,0,NULL),
(455,'投资性房地产(非流动资产)','NC_FLDZC_TZXFDC',25,4,0,NULL,0,2,2,0,NULL),
(456,'固定资产(非流动资产)','QM_FLDZC_GDZC',26,3,0,NULL,0,2,2,0,NULL),
(457,'固定资产(非流动资产)','NC_FLDZC_GDZC',26,4,0,NULL,0,2,2,0,NULL),
(458,'在建工程(非流动资产)','QM_FLDZC_ZJGC',27,3,0,NULL,0,2,2,0,NULL),
(459,'在建工程(非流动资产)','NC_FLDZC_ZJGC',27,4,0,NULL,0,2,2,0,NULL),
(460,'工程物资(非流动资产)','QM_FLDZC_GCWZ',28,3,0,NULL,0,2,2,0,NULL),
(461,'工程物资(非流动资产)','NC_FLDZC_GCWZ',28,4,0,NULL,0,2,2,0,NULL),
(462,'固定资产清理(非流动资产)','QM_FLDZC_GDZCQL',29,3,0,NULL,0,2,2,0,NULL),
(463,'固定资产清理(非流动资产)','NC_FLDZC_GDZCQL',29,4,0,NULL,0,2,2,0,NULL),
(468,'无形资产(非流动资产)','QM_FLDZC_WXZC',30,3,0,NULL,0,2,2,0,NULL),
(469,'无形资产(非流动资产)','NC_FLDZC_WXZC',30,4,0,NULL,0,2,2,0,NULL),
(470,'开发支出(非流动资产)','QM_FLDZC_KFZC',31,3,0,NULL,0,2,2,0,NULL),
(471,'开发支出(非流动资产)','NC_FLDZC_KFZC',31,4,0,NULL,0,2,2,0,NULL),
(472,'商誉(非流动资产)','QM_FLDZC_SY',32,3,0,NULL,0,2,2,0,NULL),
(473,'商誉(非流动资产)','NC_FLDZC_SY',32,4,0,NULL,0,2,2,0,NULL),
(474,'长期待摊费用(非流动资产)','QM_FLDZC_CQDTFY',33,3,0,NULL,0,2,2,0,NULL),
(475,'长期待摊费用(非流动资产)','NC_FLDZC_CQDTFY',33,4,0,NULL,0,2,2,0,NULL),
(476,'递延所得税资产(非流动资产)','QM_FLDZC_DYSDSZC',34,3,0,NULL,0,2,2,0,NULL),
(477,'递延所得税资产(非流动资产)','NC_FLDZC_DYSDSZC',34,4,0,NULL,0,2,2,0,NULL),
(478,'其他非流动资产','QM_FLDZC_QTFLDZC',35,3,0,NULL,0,2,2,0,NULL),
(479,'其他非流动资产','NC_FLDZC_QTFLDZC',35,4,0,NULL,0,2,2,0,NULL),
(480,'非流动资产合计','QM_FLDZC_FLDZCHJ',38,3,0,NULL,0,2,2,0,NULL),
(481,'非流动资产合计','NC_FLDZC_FLDZCHJ',38,4,0,NULL,0,2,2,0,NULL),
(482,'资 产 总 计','QM_ZCZJ',44,3,0,NULL,0,2,2,0,NULL),
(483,'资 产 总 计','NC_ZCZJ',44,4,0,NULL,0,2,2,0,NULL),
(484,'短期借款(流动负债)','QM_LDFZ_DQJK',5,7,0,NULL,0,2,2,0,NULL),
(485,'短期借款(流动负债)','NC_LDFZ_DQJK',5,8,0,NULL,0,2,2,0,NULL),
(486,'交易性金融负债(流动负债)','QM_LDFZ_JYXJRFZ',6,7,0,NULL,0,2,2,0,NULL),
(487,'交易性金融负债(流动负债)','NC_LDFZ_JYXJRFZ',6,8,0,NULL,0,2,2,0,NULL),
(488,'应付票据','QM_LDFZ_YFPJ',7,7,0,NULL,0,2,2,0,NULL),
(489,'应付票据','NC_LDFZ_YFPJ',7,8,0,NULL,0,2,2,0,NULL),
(490,'应付账款','QM_LDFZ_YFZK',8,7,0,NULL,0,2,2,0,NULL),
(491,'应付账款','NC_LDFZ_YFZK',8,8,0,NULL,0,2,2,0,NULL),
(492,'预收款项','QM_LDFZ_YSZK',9,7,0,NULL,0,2,2,0,NULL),
(493,'预收款项','NC_LDFZ_YSZK',9,8,0,NULL,0,2,2,0,NULL),
(494,'应付职工薪酬(应付工资)','QM_LDFZ_YFGZ',10,7,0,NULL,0,2,2,0,NULL),
(495,'应付职工薪酬(应付工资)','NC_LDFZ_YFGZ',10,8,0,NULL,0,2,2,0,NULL),
(496,'应交税费(应交税金)','QM_LDFZ_YJSJ',11,7,0,NULL,0,2,2,0,NULL),
(497,'应交税费(应交税金)','NC_LDFZ_YJSJ',11,8,0,NULL,0,2,2,0,NULL),
(498,'应付利息','QM_LDFZ_YFLX',12,7,0,NULL,0,2,2,0,NULL),
(499,'应付利息','NC_LDFZ_YFLX',12,8,0,NULL,0,2,2,0,NULL),
(500,'应付股利','QM_LDFZ_YFGL',13,7,0,NULL,0,2,2,0,NULL),
(501,'应付股利','NC_LDFZ_YFGL',13,8,0,NULL,0,2,2,0,NULL),
(502,'其他应付款','QM_LDFZ_QTYFK',14,7,0,NULL,0,2,2,0,NULL),
(503,'其他应付款','NC_LDFZ_QTYFK',14,8,0,NULL,0,2,2,0,NULL),
(504,'一年内到期的非流动负债(一年内到期的长期负债)','QM_LDFZ_YNNDQCQFZ',15,7,0,NULL,0,2,2,0,NULL),
(505,'一年内到期的非流动负债(一年内到期的长期负债)','NC_LDFZ_YNNDQCQFZ',15,8,0,NULL,0,2,2,0,NULL),
(506,'其他流动负债','QM_LDFZ_QTLDFZ',16,7,0,NULL,0,2,2,0,NULL),
(507,'其他流动负债','NC_LDFZ_QTLDFZ',16,8,0,NULL,0,2,2,0,NULL),
(508,'流动负债合计','QM_LDFZ_LDFZHJ',17,7,0,NULL,0,2,2,0,NULL),
(509,'流动负债合计','NC_LDFZ_LDFZHJ',17,8,0,NULL,0,2,2,0,NULL),
(510,'长期借款','QM_FLDFZ_CQJK',21,7,0,NULL,0,2,2,0,NULL),
(511,'长期借款','NC_FLDFZ_CQJK',21,8,0,NULL,0,2,2,0,NULL),
(512,'应付债券','QM_FLDFZ_YFZQ',22,7,0,NULL,0,2,2,0,NULL),
(513,'应付债券','NC_FLDFZ_YFZQ',22,8,0,NULL,0,2,2,0,NULL),
(514,'长期应付款','QM_FLDFZ_CQYFK',23,7,0,NULL,0,2,2,0,NULL),
(515,'长期应付款','NC_FLDFZ_CQYFK',23,8,0,NULL,0,2,2,0,NULL),
(516,'专项应付款','QM_FLDFZ_ZXYFK',24,7,0,NULL,0,2,2,0,NULL),
(517,'专项应付款','NC_FLDFZ_ZXYFK',24,8,0,NULL,0,2,2,0,NULL),
(518,'预计负债','QM_FLDFZ_YJFZ',25,7,0,NULL,0,2,2,0,NULL),
(519,'预计负债','NC_FLDFZ_YJFZ',25,8,0,NULL,0,2,2,0,NULL),
(520,'递延所得税负债(递延税款货项)','QM_DYSX_DYSKHX',26,7,0,NULL,0,2,2,0,NULL),
(521,'递延所得税负债(递延税款货项)','NC_DYSX_DYSKHX',26,8,0,NULL,0,2,2,0,NULL),
(522,'其他非流动负债(其他长期负债','QM_FLDFZ_QTCQFZ',27,7,0,NULL,0,2,2,0,NULL),
(523,'其他非流动负债(其他长期负债','NC_FLDFZ_QTCQFZ',27,8,0,NULL,0,2,2,0,NULL),
(524,'非流动负债合计(长期负债合计)','QM_FLDFZ_CQFZHJ',28,7,0,NULL,0,2,2,0,NULL),
(525,'非流动负债合计(长期负债合计)','NC_FLDFZ_CQFZHJ',28,8,0,NULL,0,2,2,0,NULL),
(526,' 负债合计(递延税项:负债合计 )','QM_DYSX_FZHJ',29,7,0,NULL,0,2,2,0,NULL),
(527,' 负债合计(递延税项:负债合计 )','NC_DYSX_FZHJ',29,8,0,NULL,0,2,2,0,NULL),
(528,'实收资本（或股本）','QM_GDQY_SSZB',34,7,0,NULL,0,2,2,0,NULL),
(529,'实收资本（或股本）','NC_GDQY_SSZB',34,8,0,NULL,0,2,2,0,NULL),
(530,'资本公积','QM_GDQY_ZBGJ',35,7,0,NULL,0,2,2,0,NULL),
(531,'资本公积','NC_GDQY_ZBGJ',35,8,0,NULL,0,2,2,0,NULL),
(532,'减：库存股','QM_GDQY_KCG',36,7,0,NULL,0,2,2,0,NULL),
(533,'减：库存股','NC_GDQY_KCG',36,8,0,NULL,0,2,2,0,NULL),
(534,'盈余公积','QM_GDQY_YYGJ',37,7,0,NULL,0,2,2,0,NULL),
(535,'盈余公积','NC_GDQY_YYGJ',37,8,0,NULL,0,2,2,0,NULL),
(536,'未分配利润','QM_GDQY_WFPLR',39,7,0,NULL,0,2,2,0,NULL),
(537,'未分配利润','NC_GDQY_WFPLR',39,8,0,NULL,0,2,2,0,NULL),
(538,'所 有 者 权 益 合 计','QM_GDQY_SYZQYHJ',43,7,0,NULL,0,2,2,0,NULL),
(539,'所 有 者 权 益 合 计','NC_GDQY_SYZQYHJ',43,8,0,NULL,0,2,2,0,NULL),
(540,' 负债和所有者权益（或股东权益）总计','QM_GDQY_FZHSYZQY',44,7,0,NULL,0,2,2,0,NULL),
(541,' 负债和所有者权益（或股东权益）总计','NC_GDQY_FZHSYZQY',44,8,0,NULL,0,2,2,0,NULL),
(547,' 一般风险准备','QM_YBFXZB',38,7,0,NULL,0,2,2,0,NULL),
(548,' 一般风险准备','NC_YBFXZB',38,8,0,NULL,0,2,2,0,NULL),
(549,'归属于母公司所有者权益合计','QM_GSYMGSQYHJ',41,7,0,NULL,0,2,2,0,NULL),
(550,'归属于母公司所有者权益合计','NC_GSYMGSQYHJ',41,8,0,NULL,0,2,2,0,NULL),
(551,'少数股东权益','QM_SSGDQY',42,7,0,NULL,0,2,2,0,NULL),
(552,'少数股东权益','NC_SSGDQY',42,8,0,NULL,0,2,2,0,NULL),
(553,'会计年月','KJYEAR_MOTH',1,6,0,0,0,2,3,0,NULL),
(554,'币种','HBZL',1,11,0,0,0,2,3,0,NULL),
(555,'主体账簿','ZTZB',5,0,1,0,0,2,3,0,NULL),
(556,'科目编码','SUBJECT_CODE',5,1,1,0,0,2,3,0,NULL),
(557,'科目名称','SUBJECT_NAME',5,2,1,0,0,2,3,0,NULL),
(558,'期初余额(期初借方余额)','QCJFYE',5,6,1,0,0,2,3,0,NULL),
(559,'本期借方发生','BQJFFSE',5,8,1,0,0,2,3,0,NULL),
(560,'本期贷方发生','BQDFFSE',5,10,1,0,0,2,3,0,NULL),
(561,'累计借方发生','BNJFLJ',5,12,1,0,0,2,3,0,NULL),
(562,'累计贷方发生','BNDFLJ',5,14,1,0,0,2,3,0,NULL),
(563,'方向','FX',5,15,1,0,0,2,3,0,NULL),
(564,'期末余额(期末借方余额)','QMJFYE',5,17,1,0,0,2,3,0,NULL),
(568,'科目编码','SUBJECT_CODE',1,0,1,0,0,3,3,0,NULL),
(569,'科目名称','SUBJECT_NAME',1,1,1,0,0,3,3,0,NULL),
(570,'期初借方余额','QCJFYE',1,3,1,0,0,3,3,0,NULL),
(571,'本期借方发生','BQJFFSE',1,5,1,0,0,3,3,0,NULL),
(572,'本期贷方发生','BQDFFSE',1,6,1,0,0,3,3,0,NULL),
(573,'累计借方发生','BNJFLJ',1,7,1,0,0,3,3,0,NULL),
(574,'累计贷方发生','BNDFLJ',1,8,1,0,0,3,3,0,NULL),
(576,'期末借方余额','QMJFYE',1,9,1,0,0,3,3,0,NULL),
(580,'期初贷方余额','QCDFYE',1,4,1,0,0,3,3,0,NULL),
(581,'期末贷方余额','QMDFYE',1,10,1,0,0,3,3,0,NULL),
(582,'导入用户Id','IMP_USER',0,0,0,0,0,0,0,1,NULL),
(583,'导入公司Id','ORG_ID',0,0,0,0,0,0,0,1,NULL),
(586,'货币资金(流动资产)','NC_LDZC_HBZJ',2,1,0,0,0,3,2,0,NULL),
(588,'交易性金融资产(流动资产)','NC_LDZC_JYXJRZC',3,1,0,0,0,3,2,0,NULL),
(590,'应收票据(流动资产)','NC_LDZC_YSPJ',4,1,0,0,0,3,2,0,NULL),
(592,'应收账款(流动资产)','NC_LDZC_YSZK',5,1,0,0,0,3,2,0,NULL),
(594,'预付款项(流动资产)','NC_LDZC_YFZK',6,1,0,0,0,3,2,0,NULL),
(596,'应收利息(流动资产)','NC_LDZC_YSLX',7,1,0,0,0,3,2,0,NULL),
(598,'应收股利(流动资产)','NC_LDZC_YSGL',8,1,0,0,0,3,2,0,NULL),
(600,'其他应收款(流动资产)','NC_LDZC_QTYSK',9,1,0,0,0,3,2,0,NULL),
(602,'存货(流动资产)','NC_LDZC_CH',10,1,0,0,0,3,2,0,NULL),
(604,'一年内到期的非流动资产(流动资产)','NC_LDZC_YNNDQCQZQTZ',11,1,0,0,0,3,2,0,NULL),
(606,'其他流动资产(流动资产)','NC_LDZC_QTLDZC',12,1,0,0,0,3,2,0,NULL),
(608,'流动资产合计','NC_LDZC_HJ',13,1,0,0,0,3,2,0,NULL),
(610,'可供出售金融资产(非流动资产)','NC_FLDZC_KGCSJRZC',15,1,0,0,0,3,2,0,NULL),
(612,'持有至到期投资(非流动资产)','NC_FLDZC_CYZDQTZ',16,1,0,0,0,3,2,0,NULL),
(614,'长期应收款(非流动资产)','NC_FLDZC_CQYSK',17,1,0,0,0,3,2,0,NULL),
(616,'长期股权投资(非流动资产)','NC_FLDZC_CQGQTZ',18,1,0,0,0,3,2,0,NULL),
(618,'投资性房地产(非流动资产)','NC_FLDZC_TZXFDC',19,1,0,0,0,3,2,0,NULL),
(620,'固定资产(非流动资产)','NC_FLDZC_GDZC',20,1,0,0,0,3,2,0,NULL),
(622,'在建工程(非流动资产)','NC_FLDZC_ZJGC',21,1,0,0,0,3,2,0,NULL),
(624,'工程物资(非流动资产)','NC_FLDZC_GCWZ',22,1,0,0,0,3,2,0,NULL),
(626,'固定资产清理(非流动资产)','NC_FLDZC_GDZCQL',23,1,0,0,0,3,2,0,NULL),
(628,'生产性生物资产(非流动资产)','NC_FLDZC_SCXSWZC',24,1,0,0,0,3,2,0,NULL),
(630,'油气资产(非流动资产)','NC_FLDZC_YQZC',25,1,0,0,0,3,2,0,NULL),
(632,'无形资产(非流动资产)','NC_FLDZC_WXZC',26,1,0,0,0,3,2,0,NULL),
(634,'开发支出(非流动资产)','NC_FLDZC_KFZC',27,1,0,0,0,3,2,0,NULL),
(636,'商誉(非流动资产)','NC_FLDZC_SY',28,1,0,0,0,3,2,0,NULL),
(638,'长期待摊费用(非流动资产)','NC_FLDZC_CQDTFY',29,1,0,0,0,3,2,0,NULL),
(640,'递延所得税资产(非流动资产)','NC_FLDZC_DYSDSZC',30,1,0,0,0,3,2,0,NULL),
(642,'其他非流动资产','NC_FLDZC_QTFLDZC',31,1,0,0,0,3,2,0,NULL),
(644,'非流动资产合计','NC_FLDZC_FLDZCHJ',32,1,0,0,0,3,2,0,NULL),
(646,'资 产 总 计','NC_ZCZJ',33,1,0,0,0,3,2,0,NULL),
(648,'短期借款(流动负债)','NC_LDFZ_DQJK',2,4,0,0,0,3,2,0,NULL),
(650,'交易性金融负债(流动负债)','NC_LDFZ_JYXJRFZ',3,4,0,0,0,3,2,0,NULL),
(652,'应付票据','NC_LDFZ_YFPJ',4,4,0,0,0,3,2,0,NULL),
(654,'应付账款','NC_LDFZ_YFZK',5,4,0,0,0,3,2,0,NULL),
(656,'预收款项','NC_LDFZ_YSZK',6,4,0,0,0,3,2,0,NULL),
(658,'应付职工薪酬(应付工资)','NC_LDFZ_YFGZ',7,4,0,0,0,3,2,0,NULL),
(660,'应交税费(应交税金)','NC_LDFZ_YJSJ',8,4,0,0,0,3,2,0,NULL),
(662,'应付利息','NC_LDFZ_YFLX',9,4,0,0,0,3,2,0,NULL),
(664,'应付股利','NC_LDFZ_YFGL',10,4,0,0,0,3,2,0,NULL),
(666,'其他应付款','NC_LDFZ_QTYFK',11,4,0,0,0,3,2,0,NULL),
(668,'一年内到期的非流动负债(一年内到期的长期负债)','NC_LDFZ_YNNDQCQFZ',12,4,0,0,0,3,2,0,NULL),
(670,'其他流动负债','NC_LDFZ_QTLDFZ',13,4,0,0,0,3,2,0,NULL),
(672,'流动负债合计','NC_LDFZ_LDFZHJ',14,4,0,0,0,3,2,0,NULL),
(674,'长期借款','NC_FLDFZ_CQJK',16,4,0,0,0,3,2,0,NULL),
(676,'应付债券','NC_FLDFZ_YFZQ',17,4,0,0,0,3,2,0,NULL),
(678,'长期应付款','NC_FLDFZ_CQYFK',18,4,0,0,0,3,2,0,NULL),
(680,'专项应付款','NC_FLDFZ_ZXYFK',19,4,0,0,0,3,2,0,NULL),
(682,'预计负债','NC_FLDFZ_YJFZ',20,4,0,0,0,3,2,0,NULL),
(684,'递延所得税负债(递延税款货项)','NC_DYSX_DYSKHX',21,4,0,0,0,3,2,0,NULL),
(686,'其他非流动负债(其他长期负债','NC_FLDFZ_QTCQFZ',22,4,0,0,0,3,2,0,NULL),
(688,'非流动负债合计(长期负债合计)','NC_FLDFZ_CQFZHJ',23,4,0,0,0,3,2,0,NULL),
(690,' 负债合计(递延税项:负债合计 )','NC_DYSX_FZHJ',24,4,0,0,0,3,2,0,NULL),
(692,'实收资本（或股本）','NC_GDQY_SSZB',26,4,0,0,0,3,2,0,NULL),
(694,'资本公积','NC_GDQY_ZBGJ',27,4,0,0,0,3,2,0,NULL),
(696,'库存股','NC_GDQY_KCG',28,4,0,0,0,3,2,0,NULL),
(698,'盈余公积','NC_GDQY_YYGJ',29,4,0,0,0,3,2,0,NULL),
(700,'未分配利润','NC_GDQY_WFPLR',30,4,0,0,0,3,2,0,NULL),
(702,'所 有 者 权 益 合 计','NC_GDQY_SYZQYHJ',31,4,0,0,0,3,2,0,NULL),
(704,' 负债和所有者权益（或股东权益）总计','NC_GDQY_FZHSYZQY',33,4,0,0,0,3,2,0,NULL),
(709,'营业收入(本期)','BY_ZYYWSR',1,1,0,0,0,3,1,0,NULL),
(710,'业务成本(本期)','BY_ZYYWCB',2,1,0,0,0,3,0,0,NULL),
(711,'营业税金及附加(本期)','BY_ZYYWSJJFJ',3,1,0,0,0,3,1,0,NULL),
(712,'销售费用(本期)','BY_XSFY',4,1,0,0,0,3,1,0,NULL),
(713,'管理费用(本期)','BY_GLFY',5,1,0,0,0,3,1,0,NULL),
(714,'财务费用(本期)','BY_CWFY',6,1,0,0,0,3,1,0,NULL),
(715,'资产减值损失(本期)','BY_ZCJZSS',7,1,0,0,0,3,1,0,NULL),
(716,'公允价值变动收益(本期)','BY_GYJZBDSY',8,1,0,0,0,3,1,0,NULL),
(717,'投资收益(本期)','BY_TZSY',9,1,0,0,0,3,1,0,NULL),
(718,'对联营企业和合营企业的投资收益(本期)','BY_DLYQYHHYQYDTZSY',10,1,0,0,0,3,1,0,NULL),
(719,'营业利润(本期)','BY_YYLR',11,1,0,0,0,3,1,0,NULL),
(720,'营业外收入(本期)','BY_YYWSR',12,1,0,0,0,3,1,0,NULL),
(721,'营业外支出(本期)','BY_YYWZC',13,1,0,0,0,3,1,0,NULL),
(722,'非流动资产处置损失(本期)','BY_FLDZCCZSS',14,1,0,0,0,3,1,0,NULL),
(723,'利润总额(本期)','BY_LRZE',15,1,0,0,0,3,1,0,NULL),
(724,'所得税费用(本期)','BY_SDS',16,1,0,0,0,3,1,0,NULL),
(725,'净利润(本期)','BY_JLR',17,1,0,0,0,3,1,0,NULL),
(726,'每股收益(本期)','BY_MGSY',18,1,0,0,0,3,1,0,NULL),
(727,'基本每股收益(本期)','BY_JBMGSY',19,1,0,0,0,3,1,0,NULL),
(728,'稀释每股收益(本期)','BY_XSMGSY',20,1,0,0,0,3,1,0,NULL),
(740,'销售商品、提供劳务收到的现金（本期）','BQ_JYHD_XSSPTGLWSDDXJ',2,1,0,0,0,3,5,0,NULL),
(741,'收到的税费返还（本期）','BQ_JYHD_SDDSFFH',3,1,0,0,0,3,5,0,NULL),
(742,'收到其他与经营活动有关的现金(本期）','BQ_JYHD_SDDQTYGDXJ',4,1,0,0,0,3,5,0,NULL),
(743,'经营活动现金流入小计（本期）','BQ_JYHD_XJLRXJ',5,1,0,0,0,3,5,0,NULL),
(744,' 购买商品、接受劳务支付的现金(本期）','BQ_JYHD_GJZFDXJ',6,1,0,0,0,3,5,0,NULL),
(745,'支付给职工以及为职工支付的现金(本期）','BQ_JYHD_ZFGZGDXJ',7,1,0,0,0,3,5,0,NULL),
(746,' 支付的各项税费(本期）','BQ_JYHD_ZFDGXSF',8,1,0,0,0,3,5,0,NULL),
(747,'支付其他与经营活动有关的现金（本期）','BQ_JYHD_ZFDQTDXJ',9,1,0,0,0,3,5,0,NULL),
(748,'经营活动现金流出小计(本期）','BQ_JYHD_XJLCXJ',10,1,0,0,0,3,5,0,NULL),
(749,'经营活动产生的现金流量净额(本期）','BQ_JYHD_JYHDCSDJE',11,1,0,0,0,3,5,0,NULL),
(750,'收回投资收到的现金(本期）','BQ_TZHD_SHTZSSDXJ',13,1,0,0,0,3,5,0,NULL),
(751,'取得投资收益收到的现金(本期）','BQ_TZHD_QDSYSSDXJ',14,1,0,0,0,3,5,0,NULL),
(752,'处置固定资产、无形资产和其他长期资产收回的现金净额（本期）','BQ_TZHD_CZWXHQTSHDXJJE',15,1,0,0,0,3,5,0,NULL),
(753,'处置子公司及其他营业单位收到的现金净额（本期）','BQ_TZHD_CZZGSJQTZFDXJJE',16,1,0,0,0,3,5,0,NULL),
(754,'收到其他与投资活动有关的现金(本期）','BQ_TZHD_SDDQTYGDXJ',17,1,0,0,0,3,5,0,NULL),
(755,'投资活动现金流入小计(本期）','BQ_TZHD_XJLRXJ',18,1,0,0,0,3,5,0,NULL),
(756,'购建固定资产、无形资产和其他长期资产支付的现金(本期）','BQ_TZHD_GJGDWXHQTZFDXJ',19,1,0,0,0,3,5,0,NULL),
(757,'投资支付的现金（本期）','BQ_TZHD_TZSZFDXJ',20,1,0,0,0,3,5,0,NULL),
(758,'取得子公司及其他营业单位支付的现金净额(本期）','BQ_TZHD_QDZGSJQTZFDXJJE',21,1,0,0,0,3,5,0,NULL),
(759,'支付其他与投资活动有关的现金（本期）','BQ_TZHD_ZFQTDXJ',22,1,0,0,0,3,5,0,NULL),
(760,'投资活动现金流出小计(本期）','BQ_TZHD_XJLCXJ',23,1,0,0,0,3,5,0,NULL),
(761,'投资活动产生的现金流量净额(本期）','BQ_TZHD_TZHDSCSDXJLLJE',24,1,0,0,0,3,5,0,NULL),
(762,'吸收投资收到的现金(本期）','BQ_CZHD_XSTZSSDDXJ',26,1,0,0,0,3,5,0,NULL),
(764,' 取得借款收到的现金(本期）','BQ_CZHD_JKSSDDXJ',27,1,0,0,0,3,5,0,NULL),
(765,'收到其他与筹资活动有关的现金(本期）','BQ_CZHD_SDQTYGDXJ',28,1,0,0,0,3,5,0,NULL),
(766,'筹资活动现金流入小计(本期）','BQ_CZHD_XJLRXJ',29,1,0,0,0,3,5,0,NULL),
(767,'偿还债务支付的现金(本期）','BQ_CZHD_CHZWSZFDXJ',30,1,0,0,0,3,5,0,NULL),
(768,'分配股利、利润或偿付利息支付的现金(本期）','BQ_CZHD_FPGLSZFDXJ',31,1,0,0,0,3,5,0,NULL),
(770,'支付其他与筹资活动有关的现金(本期）','BQ_CZHD_ZFQTYGDXJ',32,1,0,0,0,3,5,0,NULL),
(771,'筹资活动现金流出小计(本期）','BQ_CZHD_XJLCXJ',33,1,0,0,0,3,5,0,NULL),
(772,'筹资活动产生的现金流量净额(本期）','BQ_CZHD_CZHDCSDXJLLJE',34,1,0,0,0,3,5,0,NULL),
(773,'汇率变动对现金及现金等价物的影响（本期）','BQ_CZHD_HLBDXJDYX',35,1,0,0,0,3,5,0,NULL),
(774,'现金及现金等价物净增加额(本期）','BQ_XJJXJDJWJZJE',36,1,0,0,0,3,5,0,NULL),
(775,'期初现金及现金等价物余额（本期）','BQ_QCXJJXJDJWYE',37,1,0,0,0,3,5,0,NULL),
(776,'期末现金及现金等价物余额（本期）','BQ_QMXJJXJDJWYE',38,1,0,0,0,3,5,0,NULL),
(777,'核算项目代码','project_code',1,0,1,0,0,3,6,0,NULL),
(778,'核算项目名称','project_name',1,1,1,0,0,3,6,0,NULL),
(779,'余额','balance',1,2,1,0,0,3,6,0,NULL),
(782,'未到期1至30天','not_due1_to30_days',1,3,1,0,0,3,6,0,NULL),
(783,'未到期31至90天','not_due31_to90_days',1,4,1,0,0,3,6,0,NULL),
(784,'未到期91至180天','not_due91_to180_days',1,5,1,0,0,3,6,0,NULL),
(785,'未到期181天以上','not_due181_days',1,6,1,0,0,3,6,0,NULL),
(786,'到期1至30天','due1_to30_days',1,7,1,0,0,3,6,0,NULL),
(787,'到期31至90天','due31_to90_days',1,8,1,0,0,3,6,0,NULL),
(788,'到期91至180天','due91_to180_days',1,9,1,0,0,3,6,0,NULL),
(789,'到期181至360天','due181_to360_days',1,10,1,0,0,3,6,0,NULL),
(790,'到期361至720天','due361_to720_days',1,11,1,0,0,3,6,0,NULL),
(791,'到期721至1080天','due721_to1080_days',1,12,1,0,0,3,6,0,NULL),
(792,'到期1081至1440天','due1081_to1440_days',1,13,1,0,0,3,6,0,NULL),
(793,'到期1441天以上','due1441_days',1,14,1,0,0,3,6,0,NULL),
(794,'当日到期','due_today',1,15,1,0,0,3,6,0,NULL),
(796,'核算项目代码','project_code',1,0,1,0,0,3,7,0,NULL),
(797,'核算项目名称','project_name',1,1,1,0,0,3,7,0,NULL),
(798,'余额','balance',1,4,1,0,0,3,7,0,NULL),
(799,'信用期限','credit_period',1,2,1,0,0,3,7,0,NULL),
(800,'信用额度','credit_line',1,3,1,0,0,3,7,0,NULL),
(801,'未到期1至30天','not_due1_to30_days',1,5,1,0,0,3,7,0,NULL),
(802,'未到期31至90天','not_due31_to90_days',1,6,1,0,0,3,7,0,NULL),
(803,'未到期91至180天','not_due91_to180_days',1,7,1,0,0,3,7,0,NULL),
(804,'未到期181天以上','not_due181_days',1,8,1,0,0,3,7,0,NULL),
(805,'到期1至30天','due1_to30_days',1,9,1,0,0,3,7,0,NULL),
(806,'到期31至90天','due31_to90_days',1,10,1,0,0,3,7,0,NULL),
(807,'到期91至180天','due91_to180_days',1,11,1,0,0,3,7,0,NULL),
(808,'到期181至360天','due181_to360_days',1,12,1,0,0,3,7,0,NULL),
(809,'到期361至720天','due361_to720_days',1,13,1,0,0,3,7,0,NULL),
(810,'到期721至1080天','due721_to1080_days',1,14,1,0,0,3,7,0,NULL),
(811,'到期1081至1440天','due1081_to1440_days',1,15,1,0,0,3,7,0,NULL),
(812,'到期1441天以上','due1441_days',1,16,1,0,0,3,7,0,NULL),
(813,'当日到期','due_today',1,17,1,0,0,3,7,0,NULL),
(828,'会计期间','account_period',1,0,1,0,0,3,8,0,NULL),
(829,'1级物料类别','one_material_type',1,1,1,0,0,3,8,0,NULL),
(830,'物料代码','material_code',1,2,1,0,0,3,8,0,NULL),
(831,'物料名称','material_name',1,3,1,0,0,3,8,0,NULL),
(832,'规格型号','model',1,4,1,0,0,3,8,0,NULL),
(833,'计量单位','prickle',1,5,1,0,0,3,8,0,NULL),
(834,'单位(常用)','unit_use',1,6,1,0,0,3,8,0,NULL),
(835,'期初结存数量','qcjcsl',1,7,1,0,0,3,8,0,NULL),
(836,'期初结存单价','qcjcdj',1,8,1,0,0,3,8,0,NULL),
(837,'期初结存数量(常用)','qcjcsl_use',1,9,1,0,0,3,8,0,NULL),
(838,'期初结存单价(常用)','qcjcdj_use',1,10,1,0,0,3,8,0,NULL),
(839,'期初结存金额','qcjcje',1,11,1,0,0,3,8,0,NULL),
(840,'本期收入数量','bqsrsl',1,12,1,0,0,3,8,0,NULL),
(841,'本期收入单价','bqsrdj',1,13,1,0,0,3,8,0,NULL),
(842,'本期收入数量(常用)','bqsrsl_use',1,14,1,0,0,3,8,0,NULL),
(843,'本期收入单价(常用)','bqsrdj_use',1,15,1,0,0,3,8,0,NULL),
(844,'本期收入金额','bqsrje',1,16,1,0,0,3,8,0,NULL),
(845,'本期发出数量','bqfcsl',1,17,1,0,0,3,8,0,NULL),
(846,'本期发出单价','bqfcdj',1,18,1,0,0,3,8,0,NULL),
(847,'本期发出数量(常用)','bqfcsl_use',1,19,1,0,0,3,8,0,NULL),
(848,'本期发出单价(常用)','bqfcdj_use',1,20,1,0,0,3,8,0,NULL),
(849,'本期发出金额','bqfcje',1,21,1,0,0,3,8,0,NULL),
(850,'期末结存数量','qmjcsl',1,22,1,0,0,3,8,0,NULL),
(851,'期末结存单价','qmjcdj',1,23,1,0,0,3,8,0,NULL),
(852,'期末结存数量(常用)','qmjcsl_use',1,24,1,0,0,3,8,0,NULL),
(853,'期末结存单价（常用）','qmjcdj_use',1,25,1,0,0,3,8,0,NULL),
(854,'期末结存金额','qmjcje',1,26,1,0,0,3,8,0,NULL),
(857,'会计期间','account_period',1,0,1,0,0,3,9,0,NULL),
(858,'1级物料类别','one_material_type',1,1,1,0,0,3,9,0,NULL),
(859,'物料代码','material_code',1,3,1,0,0,3,9,0,NULL),
(860,'物料名称','material_name',1,4,1,0,0,3,9,0,NULL),
(861,'规格型号','model',1,5,1,0,0,3,9,0,NULL),
(862,'计量单位','prickle',1,6,1,0,0,3,9,0,NULL),
(863,'单位(常用)','unit_use',1,7,1,0,0,3,9,0,NULL),
(864,'期初结存数量','qcjcsl',1,8,1,0,0,3,9,0,NULL),
(865,'期初结存单价','qcjcdj',1,9,1,0,0,3,9,0,NULL),
(866,'期初结存数量(常用)','qcjcsl_use',1,10,1,0,0,3,9,0,NULL),
(867,'期初结存单价(常用)','qcjcdj_use',1,11,1,0,0,3,9,0,NULL),
(868,'期初结存金额','qcjcje',1,12,1,0,0,3,9,0,NULL),
(869,'本期收入数量','bqsrsl',1,13,1,0,0,3,9,0,NULL),
(870,'本期收入单价','bqsrdj',1,14,1,0,0,3,9,0,NULL),
(871,'本期收入数量(常用)','bqsrsl_use',1,15,1,0,0,3,9,0,NULL),
(872,'本期收入单价(常用)','bqsrdj_use',1,16,1,0,0,3,9,0,NULL),
(873,'本期收入金额','bqsrje',1,17,1,0,0,3,9,0,NULL),
(874,'本期发出数量','bqfcsl',1,18,1,0,0,3,9,0,NULL),
(875,'本期发出单价','bqfcdj',1,19,1,0,0,3,9,0,NULL),
(876,'本期发出数量(常用)','bqfcsl_use',1,20,1,0,0,3,9,0,NULL),
(877,'本期发出单价(常用)','bqfcdj_use',1,21,1,0,0,3,9,0,NULL),
(878,'本期发出金额','bqfcje',1,22,1,0,0,3,9,0,NULL),
(879,'期末结存数量','qmjcsl',1,23,1,0,0,3,9,0,NULL),
(880,'期末结存单价','qmjcdj',1,24,1,0,0,3,9,0,NULL),
(881,'期末结存数量(常用)','qmjcsl_use',1,25,1,0,0,3,9,0,NULL),
(882,'期末结存单价（常用）','qmjcdj_use',1,26,1,0,0,3,9,0,NULL),
(883,'期末结存金额','qmjcje',1,27,1,0,0,3,9,0,NULL),
(888,'2级物料类别','two_material_type',1,2,1,0,0,3,9,0,NULL),
(890,'营业成本','BY_YYZCB',2,1,0,0,0,3,1,0,NULL),
(891,'货币资金(流动资产)','QM_LDZC_HBZJ',2,2,0,0,0,3,2,0,NULL),
(892,'交易性金融资产(流动资产)','QM_LDZC_JYXJRZC',3,2,0,0,0,3,2,0,NULL),
(893,'应收票据(流动资产)','QM_LDZC_YSPJ',4,2,0,0,0,3,2,0,NULL),
(894,'应收账款(流动资产)','QM_LDZC_YSZK',5,2,0,0,0,3,2,0,NULL),
(895,'预付款项(流动资产)','QM_LDZC_YFZK',6,2,0,0,0,3,2,0,NULL),
(896,'应收利息(流动资产)','QM_LDZC_YSLX',7,2,0,0,0,3,2,0,NULL),
(897,'应收股利(流动资产)','QM_LDZC_YSGL',8,2,0,0,0,3,2,0,NULL),
(898,'其他应收款(流动资产)','QM_LDZC_QTYSK',9,2,0,0,0,3,2,0,NULL),
(899,'存货(流动资产)','QM_LDZC_CH',10,2,0,0,0,3,2,0,NULL),
(900,'一年内到期的非流动资产(流动资产)','QM_LDZC_YNNDQCQZQTZ',11,2,0,0,0,3,2,0,NULL),
(901,'其他流动资产(流动资产)','QM_LDZC_QTLDZC',12,2,0,0,0,3,2,0,NULL),
(902,'流动资产合计','QM_LDZC_HJ',13,2,0,0,0,3,2,0,NULL),
(903,'可供出售金融资产(非流动资产)','QM_FLDZC_KGCSJRZC',15,2,0,0,0,3,2,0,NULL),
(904,'持有至到期投资(非流动资产)','QM_FLDZC_CYZDQTZ',16,2,0,0,0,3,2,0,NULL),
(905,'长期应收款(非流动资产)','QM_FLDZC_CQYSK',17,2,0,0,0,3,2,0,NULL),
(906,'长期股权投资(非流动资产)','QM_FLDZC_CQGQTZ',18,2,0,0,0,3,2,0,NULL),
(907,'投资性房地产(非流动资产)','QM_FLDZC_TZXFDC',19,2,0,0,0,3,2,0,NULL),
(908,'固定资产(非流动资产)','QM_FLDZC_GDZC',20,2,0,0,0,3,2,0,NULL),
(909,'在建工程(非流动资产)','QM_FLDZC_ZJGC',21,2,0,0,0,3,2,0,NULL),
(910,'工程物资(非流动资产)','QM_FLDZC_GCWZ',22,2,0,0,0,3,2,0,NULL),
(911,'固定资产清理(非流动资产)','QM_FLDZC_GDZCQL',23,2,0,0,0,3,2,0,NULL),
(912,'生产性生物资产(非流动资产)','QM_FLDZC_SCXSWZC',24,2,0,0,0,3,2,0,NULL),
(913,'油气资产(非流动资产)','QM_FLDZC_YQZC',25,2,0,0,0,3,2,0,NULL),
(914,'无形资产(非流动资产)','QM_FLDZC_WXZC',26,2,0,0,0,3,2,0,NULL),
(915,'开发支出(非流动资产)','QM_FLDZC_KFZC',27,2,0,0,0,3,2,0,NULL),
(916,'商誉(非流动资产)','QM_FLDZC_SY',28,2,0,0,0,3,2,0,NULL),
(917,'长期待摊费用(非流动资产)','QM_FLDZC_CQDTFY',29,2,0,0,0,3,2,0,NULL),
(918,'递延所得税资产(非流动资产)','QM_FLDZC_DYSDSZC',30,2,0,0,0,3,2,0,NULL),
(919,'其他非流动资产','QM_FLDZC_QTFLDZC',31,2,0,0,0,3,2,0,NULL),
(920,'非流动资产合计','QM_FLDZC_FLDZCHJ',32,2,0,0,0,3,2,0,NULL),
(921,'资产总计','QM_ZCZJ',33,2,0,0,0,3,2,0,NULL),
(922,'短期借款(流动负债)','QM_LDFZ_DQJK',2,5,0,0,0,3,2,0,NULL),
(923,'交易性金融负债(流动负债)','QM_LDFZ_JYXJRFZ',3,5,0,0,0,3,2,0,NULL),
(924,'应付票据','QM_LDFZ_YFPJ',4,5,0,0,0,3,2,0,NULL),
(925,'应付账款','QM_LDFZ_YFZK',5,5,0,0,0,3,2,0,NULL),
(926,'预收款项','QM_LDFZ_YSZK',6,5,0,0,0,3,2,0,NULL),
(927,'应付职工薪酬(应付工资)','QM_LDFZ_YFGZ',7,5,0,0,0,3,2,0,NULL),
(928,'应交税费(应交税金)','QM_LDFZ_YJSJ',8,5,0,0,0,3,2,0,NULL),
(929,'应付利息','QM_LDFZ_YFLX',9,5,0,0,0,3,2,0,NULL),
(930,'应付股利','QM_LDFZ_YFGL',10,5,0,0,0,3,2,0,NULL),
(931,'其他应付款','QM_LDFZ_QTYFK',11,5,0,0,0,3,2,0,NULL),
(932,'一年内到期的非流动负债(一年内到期的长期负债)','QM_LDFZ_YNNDQCQFZ',12,5,0,0,0,3,2,0,NULL),
(933,'其他流动负债','QM_LDFZ_QTLDFZ',13,5,0,0,0,3,2,0,NULL),
(934,'流动负债合计','QM_LDFZ_LDFZHJ',14,5,0,0,0,3,2,0,NULL),
(935,'长期借款','QM_FLDFZ_CQJK',16,5,0,0,0,3,2,0,NULL),
(936,'应付债券','QM_FLDFZ_YFZQ',17,5,0,0,0,3,2,0,NULL),
(937,'长期应付款','QM_FLDFZ_CQYFK',18,5,0,0,0,3,2,0,NULL),
(938,'专项应付款','QM_FLDFZ_ZXYFK',19,5,0,0,0,3,2,0,NULL),
(939,'预计负债','QM_FLDFZ_YJFZ',20,5,0,0,0,3,2,0,NULL),
(940,'递延所得税负债(递延税款货项)','QM_DYSX_DYSKHX',21,5,0,0,0,3,2,0,NULL),
(941,'其他非流动负债(其他长期负债','QM_FLDFZ_QTCQFZ',22,5,0,0,0,3,2,0,NULL),
(942,'非流动负债合计(长期负债合计)','QM_FLDFZ_CQFZHJ',23,5,0,0,0,3,2,0,NULL),
(943,' 负债合计(递延税项:负债合计 )','QM_DYSX_FZHJ',24,5,0,0,0,3,2,0,NULL),
(944,'实收资本（或股本）','QM_GDQY_SSZB',26,5,0,0,0,3,2,0,NULL),
(945,'资本公积','QM_GDQY_ZBGJ',27,5,0,0,0,3,2,0,NULL),
(946,'库存股','QM_GDQY_KCG',28,5,0,0,0,3,2,0,NULL),
(947,'盈余公积','QM_GDQY_YYGJ',29,5,0,0,0,3,2,0,NULL),
(948,'未分配利润','QM_GDQY_WFPLR',30,5,0,0,0,3,2,0,NULL),
(949,'所 有 者 权 益 合 计','QM_GDQY_SYZQYHJ',31,5,0,0,0,3,2,0,NULL),
(950,' 负债和所有者权益（或股东权益）总计','QM_GDQY_FZHSYZQY',33,5,0,0,0,3,2,0,NULL),
(954,'期间','account_period',1,0,1,0,0,3,10,0,NULL),
(955,'项目代码','project_code',1,1,1,0,0,3,10,0,NULL),
(956,'项目名称','project_name',1,2,1,0,0,3,10,0,NULL),
(957,'币别','currency',1,3,1,0,0,3,10,0,NULL),
(958,'期初借方余额','qcjfye',1,4,1,0,0,3,10,0,NULL),
(959,'期初贷方余额','qcdfye',1,5,1,0,0,3,10,0,NULL),
(960,'本期借方金额','bqjfje',1,6,1,0,0,3,10,0,NULL),
(961,'本期贷方金额','bqdfje',1,7,1,0,0,3,10,0,NULL),
(962,'本年累计借方金额','bnljjfje',1,8,1,0,0,3,10,0,NULL),
(963,'本年累计贷方金额','bnljdfje',1,9,1,0,0,3,10,0,NULL),
(964,'期末借方余额','qmjfye',1,10,1,0,0,3,10,0,NULL),
(965,'期末贷方余额','qmdfye',1,11,1,0,0,3,10,0,NULL),
(968,'核算项目代码','project_code',1,0,1,0,0,3,14,0,NULL),
(969,'核算项目名称','project_name',1,1,1,0,0,3,14,0,NULL),
(970,'信用期限','credit_period',1,2,1,0,0,3,14,0,NULL),
(971,'信用额度','credit_line',1,3,1,0,0,3,14,0,NULL),
(972,'余额','balance',1,4,1,0,0,3,14,0,NULL),
(973,'0-90天','due1_to30_days',1,5,1,0,0,3,14,0,NULL),
(974,'90-180天','due91_to180_days',1,6,1,0,0,3,14,0,NULL),
(975,'180-360天','due181_to360_days',1,7,1,0,0,3,14,0,NULL),
(976,'360-720天','due361_to720_days',1,8,1,0,0,3,14,0,NULL),
(977,'720-1080天','due721_to1080_days',1,9,1,0,0,3,14,0,NULL),
(978,'1080天以上','due1081_to1440_days',1,10,1,0,0,3,14,0,NULL),
(980,'1级物料类别','one_material_type',1,0,1,0,0,3,20,0,NULL),
(981,'2级物料类别','two_material_type',1,1,1,0,0,3,20,0,NULL),
(982,'物料代码','material_code',1,2,1,0,0,3,20,0,NULL),
(983,'库存数量(基本)','kcsljb',1,3,1,0,0,3,20,0,NULL),
(984,'库存数量(常用)','kcslcy',1,4,1,0,0,3,20,0,NULL),
(985,'单价(基本)','djjb',1,5,1,0,0,3,20,0,NULL),
(986,'单价(常用)','djcy',1,6,1,0,0,3,20,0,NULL),
(987,'金额','je',1,7,1,0,0,3,20,0,NULL),
(988,'0天至6天数量(基本)','zeroday_tosixdayjb',1,8,1,0,0,3,20,0,NULL),
(989,'0天至6天数量(常用)','zeroday_tosixdaycy',1,9,1,0,0,3,20,0,NULL),
(990,'0天至6天金额','zeroday_tosixdayje',1,10,1,0,0,3,20,0,NULL),
(991,'7天以上数量(基本)','sevendayjb',1,11,1,0,0,3,20,0,NULL),
(992,'7天以上数量(常用)','sevendaycy',1,12,1,0,0,3,20,0,NULL),
(993,'7天以上金额','sevendayje',1,13,1,0,0,3,20,0,NULL),
(994,'会计期间','account_period',1,0,1,0,0,3,21,0,NULL),
(995,'分支机构','fzjg',1,1,1,0,0,3,21,0,NULL),
(996,'仓 库','ck',1,2,1,0,0,3,21,0,NULL),
(997,'仓 位','cw',1,3,1,0,0,3,21,0,NULL),
(998,'商品编码','spbh',1,4,1,0,0,3,21,0,NULL),
(999,'商品名称','spmc',1,5,1,0,0,3,21,0,NULL),
(1000,'商品条码','sptm',1,6,1,0,0,3,21,0,NULL),
(1001,'商品类别','splb',1,7,1,0,0,3,21,0,NULL),
(1002,'商品品牌','sppp',1,8,1,0,0,3,21,0,NULL),
(1003,'规格型号','ggxh',1,9,1,0,0,3,21,0,NULL),
(1004,'批 次','pc',1,10,1,0,0,3,21,0,NULL),
(1005,'基本单位','jbdw',1,11,1,0,0,3,21,0,NULL),
(1006,'期初结存数 量','qcjcsl',1,12,1,0,0,3,21,0,NULL),
(1007,'期初结存金额','qcjcje',1,13,1,0,0,3,21,0,NULL),
(1008,'销售出库数量','xscksl',1,14,1,0,0,3,21,0,NULL),
(1009,'销售出库金额','xsckje',1,15,1,0,0,3,21,0,NULL),
(1010,'本期退货数 量','bqthsl',1,16,1,0,0,3,21,0,NULL),
(1011,'本期退货金 额','bqthje',1,17,1,0,0,3,21,0,NULL),
(1012,'外购入库数量','wgrksl',1,18,1,0,0,3,21,0,NULL),
(1013,'外购入库金额','wgrkje',1,19,1,0,0,3,21,0,NULL),
(1014,'其他入库数 量','qtrksl',1,20,1,0,0,3,21,0,NULL),
(1015,'其他入库金 额','qtrkje',1,21,1,0,0,3,21,0,NULL),
(1016,'其他出库数 量','qtcksl',1,22,1,0,0,3,21,0,NULL),
(1017,'其他出库金 额','qtckje',1,23,1,0,0,3,21,0,NULL),
(1018,'调拨入库数 量','dbrksl',1,24,1,0,0,3,21,0,NULL),
(1019,'调拨入库金 额','dbrkje',1,25,1,0,0,3,21,0,NULL),
(1020,'调拨出库数 量','dbcksl',1,26,1,0,0,3,21,0,NULL),
(1021,'调拨出库金 额','dbckje',1,27,1,0,0,3,21,0,NULL),
(1022,'盘盈入库数 量','pyrksl',1,28,1,0,0,3,21,0,NULL),
(1023,'盘盈入库金 额','pyrkje',1,29,1,0,0,3,21,0,NULL),
(1024,'盘亏毁损数 量','pkhssl',1,30,1,0,0,3,21,0,NULL),
(1025,'盘亏毁损金 额','pkhsje',1,31,1,0,0,3,21,0,NULL),
(1026,'本期入库数 量','bqrksl',1,32,1,0,0,3,21,0,NULL),
(1027,'本期入库金 额','bqrkje',1,33,1,0,0,3,21,0,NULL),
(1028,'本期出库数 量','bqcksl',1,34,1,0,0,3,21,0,NULL),
(1029,'本期出库金 额','bqckje',1,35,1,0,0,3,21,0,NULL),
(1030,'期末结存数 量','qmjcsl',1,36,1,0,0,3,21,0,NULL),
(1031,'期末结存金 额','qmjcje',1,37,1,0,0,3,21,0,NULL),
(1032,'平均库存数 量','pjkcsl',1,38,1,0,0,3,21,0,NULL),
(1033,'平均库存金 额','pjkcje',1,39,1,0,0,3,21,0,NULL),
(1034,'库存周转率','kczzl',1,40,1,0,0,3,21,0,NULL),
(1035,'库存周转天数','kczzts',1,41,1,0,0,3,21,0,NULL),
(1038,'科目','project_code',1,0,1,0,0,100,1,0,NULL),
(1039,'本月数','BY_VALUE',1,2,1,0,0,100,1,0,NULL),
(1040,'本年累计数','BN_VALUE',1,3,1,0,0,100,1,0,NULL),
(1041,'科目','project_code',1,0,1,0,0,100,5,0,NULL),
(1042,'金额','VALUE',1,2,1,0,0,100,5,0,NULL),
(1043,'资产一','project_code',1,0,1,0,0,100,2,0,NULL),
(1044,'年初数一','NC_VALUE',1,2,1,0,0,100,2,0,NULL),
(1045,'期末数一','QM_VALUE',1,3,1,0,0,100,2,0,NULL),
(1046,'资产二','project_code_two',1,4,1,0,0,100,2,0,NULL),
(1047,'年初数二','NC_VALUE_TWO',1,6,1,0,0,100,2,0,NULL),
(1048,'期末数二','QM_VALUE_TWO',1,7,1,0,0,100,2,0,NULL),
(1049,'科目编码','SUBJECT_CODE',1,0,1,0,0,4,3,0,NULL),
(1050,'科目名称','SUBJECT_NAME',1,1,1,0,0,4,3,0,NULL),
(1051,'期初借方余额','QCJFYE',1,3,1,0,0,4,3,0,NULL),
(1052,'本期借方发生','BQJFFSE',1,5,1,0,0,4,3,0,NULL),
(1053,'本期贷方发生','BQDFFSE',1,6,1,0,0,4,3,0,NULL),
(1054,'累计借方发生','BNJFLJ',1,7,1,0,0,4,3,0,NULL),
(1055,'累计贷方发生','BNDFLJ',1,8,1,0,0,4,3,0,NULL),
(1056,'期末借方余额','QMJFYE',1,9,1,0,0,4,3,0,NULL),
(1057,'期初贷方余额','QCDFYE',1,4,1,0,0,4,3,0,NULL),
(1058,'期末贷方余额','QMDFYE',1,10,1,0,0,4,3,0,NULL),
(1064,'产品','project_code',1,0,1,0,0,4,11,0,NULL),
(1065,'发票号','fa_piao',1,1,1,0,0,4,11,0,NULL),
(1066,'发票日期','fa_piao_date',1,2,1,0,0,4,11,0,NULL),
(1067,'数量','count',1,3,1,0,0,4,11,0,NULL),
(1068,'金额','amount',1,4,1,0,0,4,11,0,NULL),
(1069,'百分比','percent',1,5,1,0,0,4,11,0,NULL),
(1070,'核算项目代码','project_code',1,0,1,0,0,4,12,0,NULL),
(1071,'核算项目名称','project_name',1,1,1,0,0,4,12,0,NULL),
(1072,'期间','qijian',1,2,1,0,0,4,12,0,NULL),
(1073,'期初余额','qcye',1,3,1,0,0,4,12,0,NULL),
(1074,'本期应付','bqyf',1,4,1,0,0,4,12,0,NULL),
(1075,'本期实付','bqsf',1,5,1,0,0,4,12,0,NULL),
(1076,'本年累计应付','bnljyf',1,6,1,0,0,4,12,0,NULL),
(1077,'本年累计实付','bnljsf',1,7,1,0,0,4,12,0,NULL),
(1078,'期末余额','qmye',1,8,1,0,0,4,12,0,NULL),
(1079,'核算项目代码','project_code',1,0,1,0,0,4,13,0,NULL),
(1080,'核算项目名称','project_name',1,1,1,0,0,4,13,0,NULL),
(1081,'期间','qijian',1,8,1,0,0,4,13,0,NULL),
(1082,'期初余额','qcye',1,9,1,0,0,4,13,0,NULL),
(1083,'本期应收','bqyf',1,10,1,0,0,4,13,0,NULL),
(1084,'本期实收','bqsf',1,11,1,0,0,4,13,0,NULL),
(1085,'本年累计应收','bnljyf',1,12,1,0,0,4,13,0,NULL),
(1086,'本年累计实收','bnljsf',1,13,1,0,0,4,13,0,NULL),
(1087,'期末余额','qmye',1,14,1,0,0,4,13,0,NULL),
(1094,'客户分类','khfl',1,2,1,0,0,4,13,0,NULL),
(1095,'区域','qy',1,3,1,0,0,4,13,0,NULL),
(1096,'专营业务员','zyywy',1,4,1,0,0,4,13,0,NULL),
(1097,'QQMSN','QQMSN',1,5,1,0,0,4,13,0,NULL),
(1098,'折扣','zk',1,6,1,0,0,4,13,0,NULL),
(1099,'区(县)','qx',1,7,1,0,0,4,13,0,NULL),
(1100,'核算项目代码','project_code',1,0,1,0,0,4,15,0,NULL),
(1101,'核算项目名称','project_name',1,1,1,0,0,4,15,0,NULL),
(1104,'余额','balance',1,2,1,0,0,4,15,0,NULL),
(1105,'0-90天','due1_to30_days',1,3,1,0,0,4,15,0,NULL),
(1106,'90-180天','due91_to180_days',1,4,1,0,0,4,15,0,NULL),
(1107,'180-360天','due181_to360_days',1,5,1,0,0,4,15,0,NULL),
(1108,'360-720天','due361_to720_days',1,6,1,0,0,4,15,0,NULL),
(1109,'720-1080天','due721_to1080_days',1,7,1,0,0,4,15,0,NULL),
(1110,'1080天以上','due1081_to1440_days',1,8,1,0,0,4,15,0,NULL),
(1115,'核算项目代码','project_code',1,0,1,0,0,4,14,0,NULL),
(1116,'核算项目名称','project_name',1,1,1,0,0,4,14,0,NULL),
(1117,'信用期限','credit_period',1,2,1,0,0,4,14,0,NULL),
(1118,'信用额度','credit_line',1,3,1,0,0,4,14,0,NULL),
(1119,'余额','balance',1,4,1,0,0,4,14,0,NULL),
(1120,'0-90天','due1_to30_days',1,5,1,0,0,4,14,0,NULL),
(1121,'90-180天','due91_to180_days',1,6,1,0,0,4,14,0,NULL),
(1122,'180-360天','due181_to360_days',1,7,1,0,0,4,14,0,NULL),
(1123,'360-720天','due361_to720_days',1,8,1,0,0,4,14,0,NULL),
(1124,'720-1080天','due721_to1080_days',1,9,1,0,0,4,14,0,NULL),
(1125,'1080天以上','due1081_to1440_days',1,10,1,0,0,4,14,0,NULL),
(1130,'1级物料类别','project_name',1,0,1,0,0,4,16,0,NULL),
(1131,'物料长代码','project_code',1,1,1,0,0,4,16,0,NULL),
(1132,'库存数量(基本)','kcsljb',1,2,1,0,0,4,16,0,NULL),
(1133,'库存数量(常用)','kcslcy',1,3,1,0,0,4,16,0,NULL),
(1134,'单价(基本)','djjb',1,4,1,0,0,4,16,0,NULL),
(1135,'单价(常用)','djcy',1,5,1,0,0,4,16,0,NULL),
(1136,'金额','balance',1,6,1,0,0,4,16,0,NULL),
(1137,'0天至90天数量(基本)','due0_to90_days_nm_jb',1,7,1,0,0,4,16,0,NULL),
(1138,'0天至90天数量(常用)','due0_to90_days_nm_cy',1,8,1,0,0,4,16,0,NULL),
(1139,'0天至90天金额','due1_to30_days',1,9,1,0,0,4,16,0,NULL),
(1140,'91天至180天数量(基本)','due91_to180_days_nm_jb',1,10,1,0,0,4,16,0,NULL),
(1141,'91天至180天数量(常用)','due91_to180_days_nm_cy',1,11,1,0,0,4,16,0,NULL),
(1142,'91天至180天金额','due91_to180_days',1,12,1,0,0,4,16,0,NULL),
(1143,'181天至360天数量(基本)','due181_to360_days_nm_jb',1,13,1,0,0,4,16,0,NULL),
(1144,'181天至360天数量(常用)','due181_to360_days_nm_cy',1,14,1,0,0,4,16,0,NULL),
(1145,'181天至360天金额','due181_to360_days',1,15,1,0,0,4,16,0,NULL),
(1146,'361天至720天数量(基本)','due361_to720_days_nm_jb',1,16,1,0,0,4,16,0,NULL),
(1147,'361天至720天数量(常用)','due361_to720_days_nm_cy',1,17,1,0,0,4,16,0,NULL),
(1148,'361天至720天金额','due361_to720_days',1,18,1,0,0,4,16,0,NULL),
(1149,'721天至1080天数量(基本)','due721_to1080_days_nm_jb',1,19,1,0,0,4,16,0,NULL),
(1150,'721天至1080天数量(常用)','due721_to1080_days_nm_cy',1,20,1,0,0,4,16,0,NULL),
(1151,'721天至1080天金额','due721_to1080_days',1,21,1,0,0,4,16,0,NULL),
(1152,'1081天以上数量(基本)','due1081_days_nm_jb',1,22,1,0,0,4,16,0,NULL),
(1153,'1081天以上数量(常用)','due1081_days_nm_cy',1,23,1,0,0,4,16,0,NULL),
(1154,'1081天以上金额','due1081_to1440_days',1,24,1,0,0,4,16,0,NULL),
(1155,'1级物料类别','project_name',1,0,1,0,0,4,21,0,NULL),
(1156,'2级物料类别','project_name_two',1,1,1,0,0,4,21,0,NULL),
(1157,'物料长代码','project_code',1,2,1,0,0,4,21,0,NULL),
(1158,'期初结存单位(基本)','qcjcdw_jb',1,3,1,0,0,4,21,0,NULL),
(1159,'期初结存单价(基本)','qcjcdj_jb',1,4,1,0,0,4,21,0,NULL),
(1160,'期初结存数量(基本)','qcjcsl_jb',1,5,1,0,0,4,21,0,NULL),
(1161,'期初结存单位(常用)','qcjcdw_cy',1,6,1,0,0,4,21,0,NULL),
(1162,'期初结存单价(常用)','qcjcdj_cy',1,7,1,0,0,4,21,0,NULL),
(1163,'期初结存数量(常用)','qcjcsl_cy',1,8,1,0,0,4,21,0,NULL),
(1164,'期初结存金额','qcjcje_cy',1,9,1,0,0,4,21,0,NULL),
(1165,'本期收入单位(基本)','bqsrdw_jb',1,10,1,0,0,4,21,0,NULL),
(1166,'本期收入单价(基本)','bqsrdj_jb',1,11,1,0,0,4,21,0,NULL),
(1167,'本期收入数量(基本)','bqsrsl_jb',1,12,1,0,0,4,21,0,NULL),
(1168,'本期收入单位(常用)','bqsrdw_cy',1,13,1,0,0,4,21,0,NULL),
(1169,'本期收入单价(常用)','bqsrdj_cy',1,14,1,0,0,4,21,0,NULL),
(1170,'本期收入数量(常用)','bqsrsl_cy',1,15,1,0,0,4,21,0,NULL),
(1171,'本期收入金额','bqsrje_cy',1,16,1,0,0,4,21,0,NULL),
(1172,'本期发出单位(基本)','bqfcdw_jb',1,17,1,0,0,4,21,0,NULL),
(1173,'本期发出单价(基本)','bqfcdj_jb',1,18,1,0,0,4,21,0,NULL),
(1174,'本期发出数量(基本)','bqfcsl_jb',1,19,1,0,0,4,21,0,NULL),
(1175,'本期发出单位(常用)','bqfcdw_cy',1,20,1,0,0,4,21,0,NULL),
(1176,'本期发出单价(常用)','bqfcdj_cy',1,21,1,0,0,4,21,0,NULL),
(1177,'本期发出数量(常用)','bqfcsl_cy',1,22,1,0,0,4,21,0,NULL),
(1178,'本期发出金额','bqfcje_cy',1,23,1,0,0,4,21,0,NULL),
(1179,'期末结存单位(基本)','qmjcdw_jb',1,24,1,0,0,4,21,0,NULL),
(1180,'期末结存单价(基本)','qmjcdj_jb',1,25,1,0,0,4,21,0,NULL),
(1181,'期末结存数量(基本)','qmjcsl_jb',1,26,1,0,0,4,21,0,NULL),
(1182,'期末结存单位(常用)','qmjcdw_cy',1,27,1,0,0,4,21,0,NULL),
(1183,'期末结存单价(常用)','qmjcdj_cy',1,28,1,0,0,4,21,0,NULL),
(1184,'期末结存数量(常用)','qmjcsl_cy',1,29,1,0,0,4,21,0,NULL),
(1185,'期末结存金额','qmjcje_cy',1,30,1,0,0,4,21,0,NULL),
(1186,'一、营业收入','BY_ZYYWSR',1,2,0,0,0,4,1,0,NULL),
(1187,'营业税金及附加/税金及附加','BY_ZYYWSJJFJ',3,2,0,0,0,4,1,0,NULL),
(1188,'销售费用/营业费用','BY_XSFY',4,2,0,0,0,4,1,0,NULL),
(1189,'管理费用','BY_GLFY',5,2,0,0,0,4,1,0,NULL),
(1190,'财务费用','BY_CWFY',6,2,0,0,0,4,1,0,NULL),
(1191,'资产减值损失','BY_ZCJZSS',7,2,0,0,0,4,1,0,NULL),
(1192,'加：公允价值变动收益（损失以“-”号填列）','BY_GYJZBDSY',8,2,0,0,0,4,1,0,NULL),
(1193,'投资收益（损失以“-”号填列）','BY_TZSY',9,2,0,0,0,4,1,0,NULL),
(1194,'其中：对联营企业和合营企业的投资收益','BY_DLYQYHHYQYDTZSY',10,2,0,0,0,4,1,0,NULL),
(1195,'二、营业利润（亏损以“-”号填列）','BY_YYLR',13,2,0,0,0,4,1,0,NULL),
(1196,'加：营业外收入','BY_YYWSR',14,2,0,0,0,4,1,0,NULL),
(1197,'减：营业外支出','BY_YYWZC',15,2,0,0,0,4,1,0,NULL),
(1198,'其中：非流动资产处置损失','BY_FLDZCCZSS',16,2,0,0,0,4,1,0,NULL),
(1199,'三、利润总额（亏损总额以“-”号填列）','BY_LRZE',17,2,0,0,0,4,1,0,NULL),
(1200,'减：所得税费用','BY_SDS',18,2,0,0,0,4,1,0,NULL),
(1201,'四、净利润（净亏损以“-”号填列）','BY_JLR',19,2,0,0,0,4,1,0,NULL),
(1202,'五、每股收益：','BY_MGSY',20,2,0,0,0,4,1,0,NULL),
(1203,'（一）基本每股收益','BY_JBMGSY',21,2,0,0,0,4,1,0,NULL),
(1204,'（二）稀释每股收益','BY_XSMGSY',22,2,0,0,0,4,1,0,NULL),
(1205,'减：营业成本','BY_YYZCB',2,2,0,0,0,4,1,0,NULL),
(1217,'资产处置收益（损失以“-”号填列）','BY_ZCCZSY',11,2,0,0,0,4,1,0,NULL),
(1218,'其他收益','BY_QTSY',12,2,0,0,0,4,1,0,NULL),
(1219,'被合并方在合并前实现的净利润变动','BY_BHBFJLRBD',0,2,0,0,0,4,1,0,NULL),
(1220,'归属于母公司所有者的净利润','BY_GSYMGSJLR',0,2,0,0,0,4,1,0,NULL),
(1221,'少数股东权益','BY_SSGDSY',0,2,0,0,0,4,1,0,NULL),
(1222,'1.出售、处理部门或被投资单位所得收益','BY_CSCLBMSY',0,2,0,0,0,4,1,0,NULL),
(1223,'2.自然灾害发生的损失','BY_ZRZHFSSS',0,2,0,0,0,4,1,0,NULL),
(1224,'3.会计政策变更增加（或减少）净利润','BY_KJZCBGZJJLR',0,2,0,0,0,4,1,0,NULL),
(1225,'4.会计估计变更增加（或减少）净利润','BY_KJGJBGZJJLR',0,2,0,0,0,4,1,0,NULL),
(1226,'5.债务重组损失','BY_ZWCZSS',0,2,0,0,0,4,1,0,NULL),
(1227,'6.其他','BY_QT',0,2,0,0,0,4,1,0,NULL),
(1228,'一、营业收入','BN_ZYYWSR',1,3,0,0,0,4,1,0,NULL),
(1229,'营业税金及附加/税金及附加','BN_ZYYWSJJFJ',3,3,0,0,0,4,1,0,NULL),
(1230,'销售费用/营业费用','BN_XSFY',4,3,0,0,0,4,1,0,NULL),
(1231,'管理费用','BN_GLFY',5,3,0,0,0,4,1,0,NULL),
(1232,'财务费用','BN_CWFY',6,3,0,0,0,4,1,0,NULL),
(1233,'资产减值损失','BN_ZCJZSS',7,3,0,0,0,4,1,0,NULL),
(1234,'加：公允价值变动收益（损失以“-”号填列）','BN_GYJZBDSY',8,3,0,0,0,4,1,0,NULL),
(1235,'投资收益（损失以“-”号填列）','BN_TZSY',9,3,0,0,0,4,1,0,NULL),
(1236,'其中：对联营企业和合营企业的投资收益','BN_DLYQYHHYQYDTZSY',10,3,0,0,0,4,1,0,NULL),
(1237,'二、营业利润（亏损以“-”号填列）','BN_YYLR',13,3,0,0,0,4,1,0,NULL),
(1238,'加：营业外收入','BN_YYWSR',14,3,0,0,0,4,1,0,NULL),
(1239,'减：营业外支出','BN_YYWZC',15,3,0,0,0,4,1,0,NULL),
(1240,'其中：非流动资产处置损失','BN_FLDZCCZSS',16,3,0,0,0,4,1,0,NULL),
(1241,'三、利润总额（亏损总额以“-”号填列）','BN_LRZE',17,3,0,0,0,4,1,0,NULL),
(1242,'减：所得税费用','BN_SDS',18,3,0,0,0,4,1,0,NULL),
(1243,'四、净利润（净亏损以“-”号填列）','BN_JLR',19,3,0,0,0,4,1,0,NULL),
(1244,'五、每股收益：','BN_MGSY',20,3,0,0,0,4,1,0,NULL),
(1245,'（一）基本每股收益','BN_JBMGSY',21,3,0,0,0,4,1,0,NULL),
(1246,'（二）稀释每股收益','BN_XSMGSY',22,3,0,0,0,4,1,0,NULL),
(1247,'减：营业成本','BN_YYZCB',2,3,0,0,0,4,1,0,NULL),
(1248,'资产处置收益（损失以“-”号填列）','BN_ZCCZSY',11,2,0,0,0,4,1,0,NULL),
(1249,'其他收益','BN_QTSY',12,2,0,0,0,4,1,0,NULL),
(1250,'被合并方在合并前实现的净利润变动','BN_BHBFJLRBD',0,3,0,0,0,4,1,0,NULL),
(1251,'归属于母公司所有者的净利润','BN_GSYMGSJLR',0,3,0,0,0,4,1,0,NULL),
(1252,'少数股东权益','BN_SSGDSY',0,3,0,0,0,4,1,0,NULL),
(1253,'1.出售、处理部门或被投资单位所得收益','BN_CSCLBMSY',0,3,0,0,0,4,1,0,NULL),
(1254,'2.自然灾害发生的损失','BN_ZRZHFSSS',0,3,0,0,0,4,1,0,NULL),
(1255,'3.会计政策变更增加（或减少）净利润','BN_KJZCBGZJJLR',0,3,0,0,0,4,1,0,NULL),
(1256,'4.会计估计变更增加（或减少）净利润','BN_KJGJBGZJJLR',0,3,0,0,0,4,1,0,NULL),
(1257,'5.债务重组损失','BN_ZWCZSS',0,3,0,0,0,4,1,0,NULL),
(1258,'6.其他','BN_QT',0,3,0,0,0,4,1,0,NULL),
(1322,'销售商品、提供劳务收到的现金','BQ_JYHD_XSSPTGLWSDDXJ',2,2,0,0,0,4,5,0,NULL),
(1323,'收到的税费返还','BQ_JYHD_SDDSFFH',3,2,0,0,0,4,5,0,NULL),
(1324,'收到其他与经营活动有关的现金','BQ_JYHD_SDDQTYGDXJ',4,2,0,0,0,4,5,0,NULL),
(1325,'经营活动现金流入小计','BQ_JYHD_XJLRXJ',5,2,0,0,0,4,5,0,NULL),
(1326,'购买商品、接受劳务支付的现金','BQ_JYHD_GJZFDXJ',6,2,0,0,0,4,5,0,NULL),
(1327,'支付给职工以及为职工支付的现金','BQ_JYHD_ZFGZGDXJ',7,2,0,0,0,4,5,0,NULL),
(1328,'支付的各项税费','BQ_JYHD_ZFDGXSF',8,2,0,0,0,4,5,0,NULL),
(1329,'支付其他与经营活动有关的现金','BQ_JYHD_ZFDQTDXJ',9,2,0,0,0,4,5,0,NULL),
(1330,'经营活动现金流出小计','BQ_JYHD_XJLCXJ',10,2,0,0,0,4,5,0,NULL),
(1331,'经营活动产生的现金流量净额','BQ_JYHD_JYHDCSDJE',11,2,0,0,0,4,5,0,NULL),
(1332,'收回投资收到的现金','BQ_TZHD_SHTZSSDXJ',13,2,0,0,0,4,5,0,NULL),
(1333,'取得投资收益收到的现金','BQ_TZHD_QDSYSSDXJ',14,2,0,0,0,4,5,0,NULL),
(1334,'处置固定资产、无形资产和其他长期资产收回的现金净额','BQ_TZHD_CZWXHQTSHDXJJE',15,2,0,0,0,4,5,0,NULL),
(1335,'处置子公司及其他营业单位收到的现金净额','BQ_TZHD_CZZGSJQTZFDXJJE',16,2,0,0,0,4,5,0,NULL),
(1336,'收到其他与投资活动有关的现金','BQ_TZHD_SDDQTYGDXJ',17,2,0,0,0,4,5,0,NULL),
(1337,'投资活动现金流入小计','BQ_TZHD_XJLRXJ',18,2,0,0,0,4,5,0,NULL),
(1338,'购建固定资产、无形资产和其他长期资产支付的现金','BQ_TZHD_GJGDWXHQTZFDXJ',19,2,0,0,0,4,5,0,NULL),
(1339,'投资支付的现金','BQ_TZHD_TZSZFDXJ',20,2,0,0,0,4,5,0,NULL),
(1340,'取得子公司及其他营业单位支付的现金净额','BQ_TZHD_QDZGSJQTZFDXJJE',21,2,0,0,0,4,5,0,NULL),
(1341,'支付其他与投资活动有关的现金','BQ_TZHD_ZFQTDXJ',22,2,0,0,0,4,5,0,NULL),
(1342,'投资活动现金流出小计','BQ_TZHD_XJLCXJ',23,2,0,0,0,4,5,0,NULL),
(1343,'投资活动产生的现金流量净额','BQ_TZHD_TZHDSCSDXJLLJE',24,2,0,0,0,4,5,0,NULL),
(1344,'吸收投资收到的现金','BQ_CZHD_XSTZSSDDXJ',26,2,0,0,0,4,5,0,NULL),
(1345,' 取得借款收到的现金','BQ_CZHD_JKSSDDXJ',27,2,0,0,0,4,5,0,NULL),
(1346,'收到其他与筹资活动有关的现金','BQ_CZHD_SDQTYGDXJ',28,2,0,0,0,4,5,0,NULL),
(1347,'筹资活动现金流入小计','BQ_CZHD_XJLRXJ',29,2,0,0,0,4,5,0,NULL),
(1348,'偿还债务支付的现金','BQ_CZHD_CHZWSZFDXJ',30,2,0,0,0,4,5,0,NULL),
(1349,'分配股利、利润或偿付利息支付的现金','BQ_CZHD_FPGLSZFDXJ',31,2,0,0,0,4,5,0,NULL),
(1350,'支付其他与筹资活动有关的现金','BQ_CZHD_ZFQTYGDXJ',32,2,0,0,0,4,5,0,NULL),
(1351,'筹资活动现金流出小计','BQ_CZHD_XJLCXJ',33,2,0,0,0,4,5,0,NULL),
(1352,'筹资活动产生的现金流量净额','BQ_CZHD_CZHDCSDXJLLJE',34,2,0,0,0,4,5,0,NULL),
(1353,'四、汇率变动对现金及现金等价物的影响','BQ_CZHD_HLBDXJDYX',35,2,0,0,0,4,5,0,NULL),
(1354,'五、现金及现金等价物净增加额','BQ_XJJXJDJWJZJE',36,2,0,0,0,4,5,0,NULL),
(1355,'加：期初现金及现金等价物余额','BQ_QCXJJXJDJWYE',37,2,0,0,0,4,5,0,NULL),
(1356,'六、期末现金及现金等价物余额','BQ_QMXJJXJDJWYE',38,2,0,0,0,4,5,0,NULL),
(1385,'净利润','BQ_JLR',0,2,0,0,0,4,5,0,NULL),
(1386,'加：计提的资产减值准备','BQ_JTDZCJZ',0,2,0,0,0,4,5,0,NULL),
(1387,'固定资产折旧','BQ_GDZCZJ',0,2,0,0,0,4,5,0,NULL),
(1388,'无形资产摊销','BQ_WXZCTX',0,2,0,0,0,4,5,0,NULL),
(1389,'长期待摊费用摊销','BQ_CQDTFYTX',0,2,0,0,0,4,5,0,NULL),
(1390,'待摊费用减少（减：增加）','BQ_DTFYJS',0,2,0,0,0,4,5,0,NULL),
(1391,'预提费用增加（减：减少）','BQ_YTFYZJ',0,2,0,0,0,4,5,0,NULL),
(1392,'处置固定资产、无形资产和其他长期资产的损失（减：收益）','BQ_CZGDZCWXZC',0,2,0,0,0,4,5,0,NULL),
(1393,'固定资产报废损失','BQ_GDZCBFSS',0,2,0,0,0,4,5,0,NULL),
(1394,'财务费用','BQ_CWFY',0,2,0,0,0,4,5,0,NULL),
(1395,'投资损失（减：收益）','BQ_TZSS',0,2,0,0,0,4,5,0,NULL),
(1396,'递延税款贷项（减：借项）','BQ_DYSKDX',0,2,0,0,0,4,5,0,NULL),
(1397,'存货的减少（减：增加）','BQ_CHDJS',0,2,0,0,0,4,5,0,NULL),
(1398,'经营性应收项目的减少（减：增加）','BQ_JYXYSXMDJS',0,2,0,0,0,4,5,0,NULL),
(1399,'经营性应付项目的增加（减：减少）','BQ_JYXYFXMDZJ',0,2,0,0,0,4,5,0,NULL),
(1400,'其他','BQ_QT',0,2,0,0,0,4,5,0,NULL),
(1401,'经营活动产生的现金流量净额','BQ_JYHDCSDXJLLJE',0,2,0,0,0,4,5,0,NULL),
(1402,'2、不涉及现金收支的投资和筹资活动：','BQ_BSJXJSZ',0,2,0,0,0,4,5,0,NULL),
(1403,'债务转为资本','BQ_ZWZWZB',0,2,0,0,0,4,5,0,NULL),
(1404,'一年内到期的可转换公司债券','BQ_YNNDQDKZHGSZJ',0,2,0,0,0,4,5,0,NULL),
(1405,'融资租入固定资产','BQ_RZZRGDZC',0,2,0,0,0,4,5,0,NULL),
(1406,'3、现金及现金等价物净增加情况','BQ_XJJXJDJWJZJQK',0,2,0,0,0,4,5,0,NULL),
(1407,'现金的期末余额','BQ_XJDQMYE',0,2,0,0,0,4,5,0,NULL),
(1408,'减：现金的期初余额','BQ_JXJDQCYE',0,2,0,0,0,4,5,0,NULL),
(1409,'加：现金等价物的期末余额','BQ_JXJDJWDQMYE',0,2,0,0,0,4,5,0,NULL),
(1410,'减：现金等价物的期初余额','BQ_JXJDJWDQCYE',0,2,0,0,0,4,5,0,NULL),
(1411,'现金及现金等价物净增加额','BQ_XJJXJDJWJZJE2',0,2,0,0,0,4,5,0,NULL),
(1412,'货币资金','NC_LDZC_HBZJ',2,2,0,0,0,4,2,0,NULL),
(1413,'交易性金融资产','NC_LDZC_JYXJRZC',3,2,0,0,0,4,2,0,NULL),
(1414,'应收票据','NC_LDZC_YSPJ',4,2,0,0,0,4,2,0,NULL),
(1415,'应收账款','NC_LDZC_YSZK',5,2,0,0,0,4,2,0,NULL),
(1416,'预付款项','NC_LDZC_YFZK',6,2,0,0,0,4,2,0,NULL),
(1417,'应收利息','NC_LDZC_YSLX',7,2,0,0,0,4,2,0,NULL),
(1418,'应收股利','NC_LDZC_YSGL',8,2,0,0,0,4,2,0,NULL),
(1419,'其他应收款','NC_LDZC_QTYSK',9,2,0,0,0,4,2,0,NULL),
(1420,'存货','NC_LDZC_CH',10,2,0,0,0,4,2,0,NULL),
(1421,'一年内到期的非流动资产','NC_LDZC_YNNDQCQZQTZ',11,2,0,0,0,4,2,0,NULL),
(1422,'其他流动资产','NC_LDZC_QTLDZC',12,2,0,0,0,4,2,0,NULL),
(1423,'流动资产合计','NC_LDZC_HJ',13,2,0,0,0,4,2,0,NULL),
(1424,'可供出售金融资产','NC_FLDZC_KGCSJRZC',15,2,0,0,0,4,2,0,NULL),
(1425,'持有至到期投资','NC_FLDZC_CYZDQTZ',16,2,0,0,0,4,2,0,NULL),
(1426,'长期应收款','NC_FLDZC_CQYSK',17,2,0,0,0,4,2,0,NULL),
(1427,'长期股权投资','NC_FLDZC_CQGQTZ',18,2,0,0,0,4,2,0,NULL),
(1428,'投资性房地产','NC_FLDZC_TZXFDC',19,2,0,0,0,4,2,0,NULL),
(1429,'固定资产','NC_FLDZC_GDZC',20,2,0,0,0,4,2,0,NULL),
(1430,'在建工程','NC_FLDZC_ZJGC',21,2,0,0,0,4,2,0,NULL),
(1431,'工程物资','NC_FLDZC_GCWZ',22,2,0,0,0,4,2,0,NULL),
(1432,'固定资产清理','NC_FLDZC_GDZCQL',23,2,0,0,0,4,2,0,NULL),
(1433,'生产性生物资产','NC_FLDZC_SCXSWZC',24,2,0,0,0,4,2,0,NULL),
(1434,'油气资产','NC_FLDZC_YQZC',25,2,0,0,0,4,2,0,NULL),
(1435,'无形资产','NC_FLDZC_WXZC',26,2,0,0,0,4,2,0,NULL),
(1436,'开发支出','NC_FLDZC_KFZC',27,2,0,0,0,4,2,0,NULL),
(1437,'商誉','NC_FLDZC_SY',28,2,0,0,0,4,2,0,NULL),
(1438,'长摊待摊费用','NC_FLDZC_CQDTFY',29,2,0,0,0,4,2,0,NULL),
(1439,'递延所得税资产','NC_FLDZC_DYSDSZC',30,2,0,0,0,4,2,0,NULL),
(1440,'其他非流动资产','NC_FLDZC_QTFLDZC',31,2,0,0,0,4,2,0,NULL),
(1441,'非流动资产合计','NC_FLDZC_FLDZCHJ',32,2,0,0,0,4,2,0,NULL),
(1442,'资产总计','NC_ZCZJ',33,2,0,0,0,4,2,0,NULL),
(1443,'短期借款','NC_LDFZ_DQJK',2,6,0,0,0,4,2,0,NULL),
(1444,'交易性金融负债','NC_LDFZ_JYXJRFZ',3,6,0,0,0,4,2,0,NULL),
(1445,'应付票据','NC_LDFZ_YFPJ',4,6,0,0,0,4,2,0,NULL),
(1446,'应付账款','NC_LDFZ_YFZK',5,6,0,0,0,4,2,0,NULL),
(1447,'预收款项','NC_LDFZ_YSZK',6,6,0,0,0,4,2,0,NULL),
(1448,'应付职工薪酬','NC_LDFZ_YFGZ',7,6,0,0,0,4,2,0,NULL),
(1449,'应交税费','NC_LDFZ_YJSJ',8,6,0,0,0,4,2,0,NULL),
(1450,'应付利息','NC_LDFZ_YFLX',9,6,0,0,0,4,2,0,NULL),
(1451,'应付股利','NC_LDFZ_YFGL',10,6,0,0,0,4,2,0,NULL),
(1452,'其他应付款','NC_LDFZ_QTYFK',11,6,0,0,0,4,2,0,NULL),
(1453,'一年内到期的非流动负债','NC_LDFZ_YNNDQCQFZ',12,6,0,0,0,4,2,0,NULL),
(1454,'其他流动负债','NC_LDFZ_QTLDFZ',13,6,0,0,0,4,2,0,NULL),
(1455,'流动负债合计','NC_LDFZ_LDFZHJ',14,6,0,0,0,4,2,0,NULL),
(1456,'长期借款','NC_FLDFZ_CQJK',16,6,0,0,0,4,2,0,NULL),
(1457,'应付债券','NC_FLDFZ_YFZQ',17,6,0,0,0,4,2,0,NULL),
(1458,'长期应付款','NC_FLDFZ_CQYFK',18,6,0,0,0,4,2,0,NULL),
(1459,'专项应付款','NC_FLDFZ_ZXYFK',19,6,0,0,0,4,2,0,NULL),
(1460,'预计负债','NC_FLDFZ_YJFZ',20,6,0,0,0,4,2,0,NULL),
(1461,'递延所得税负债','NC_DYSX_DYSKHX',21,6,0,0,0,4,2,0,NULL),
(1462,'其他非流动负债','NC_FLDFZ_QTCQFZ',22,6,0,0,0,4,2,0,NULL),
(1463,'非流动负债合计','NC_FLDFZ_CQFZHJ',23,6,0,0,0,4,2,0,NULL),
(1464,' 负债合计','NC_DYSX_FZHJ',24,6,0,0,0,4,2,0,NULL),
(1465,'实收资本（或股本）','NC_GDQY_SSZB',26,6,0,0,0,4,2,0,NULL),
(1466,'资本公积','NC_GDQY_ZBGJ',27,6,0,0,0,4,2,0,NULL),
(1467,'减：库存股','NC_GDQY_KCG',28,6,0,0,0,4,2,0,NULL),
(1468,'盈余公积','NC_GDQY_YYGJ',29,6,0,0,0,4,2,0,NULL),
(1469,'未分配利润','NC_GDQY_WFPLR',30,6,0,0,0,4,2,0,NULL),
(1470,'所有者权益（或股东权益）合计','NC_GDQY_SYZQYHJ',31,6,0,0,0,4,2,0,NULL),
(1471,'负债和所有者权益（或股东权益）总计','NC_GDQY_FZHSYZQY',33,6,0,0,0,4,2,0,NULL),
(1472,'货币资金','QM_LDZC_HBZJ',2,3,0,0,0,4,2,0,NULL),
(1473,'交易性金融资产','QM_LDZC_JYXJRZC',3,3,0,0,0,4,2,0,NULL),
(1474,'应收票据','QM_LDZC_YSPJ',4,3,0,0,0,4,2,0,NULL),
(1475,'应收账款','QM_LDZC_YSZK',5,3,0,0,0,4,2,0,NULL),
(1476,'预付款项','QM_LDZC_YFZK',6,3,0,0,0,4,2,0,NULL),
(1477,'应收利息','QM_LDZC_YSLX',7,3,0,0,0,4,2,0,NULL),
(1478,'应收股利','QM_LDZC_YSGL',8,3,0,0,0,4,2,0,NULL),
(1479,'其他应收款','QM_LDZC_QTYSK',9,3,0,0,0,4,2,0,NULL),
(1480,'存货','QM_LDZC_CH',10,3,0,0,0,4,2,0,NULL),
(1481,'一年内到期的非流动资产','QM_LDZC_YNNDQCQZQTZ',11,3,0,0,0,4,2,0,NULL),
(1482,'其他流动资产','QM_LDZC_QTLDZC',12,3,0,0,0,4,2,0,NULL),
(1483,'流动资产合计','QM_LDZC_HJ',13,3,0,0,0,4,2,0,NULL),
(1484,'可供出售金融资产','QM_FLDZC_KGCSJRZC',15,3,0,0,0,4,2,0,NULL),
(1485,'持有至到期投资','QM_FLDZC_CYZDQTZ',16,3,0,0,0,4,2,0,NULL),
(1486,'长期应收款','QM_FLDZC_CQYSK',17,3,0,0,0,4,2,0,NULL),
(1487,'长期股权投资','QM_FLDZC_CQGQTZ',18,3,0,0,0,4,2,0,NULL),
(1488,'投资性房地产','QM_FLDZC_TZXFDC',19,3,0,0,0,4,2,0,NULL),
(1489,'固定资产','QM_FLDZC_GDZC',20,3,0,0,0,4,2,0,NULL),
(1490,'在建工程','QM_FLDZC_ZJGC',21,3,0,0,0,4,2,0,NULL),
(1491,'工程物资','QM_FLDZC_GCWZ',22,3,0,0,0,4,2,0,NULL),
(1492,'固定资产清理','QM_FLDZC_GDZCQL',23,3,0,0,0,4,2,0,NULL),
(1493,'生产性生物资产','QM_FLDZC_SCXSWZC',24,3,0,0,0,4,2,0,NULL),
(1494,'油气资产','QM_FLDZC_YQZC',25,3,0,0,0,4,2,0,NULL),
(1495,'无形资产','QM_FLDZC_WXZC',26,3,0,0,0,4,2,0,NULL),
(1496,'开发支出','QM_FLDZC_KFZC',27,3,0,0,0,4,2,0,NULL),
(1497,'商誉','QM_FLDZC_SY',28,3,0,0,0,4,2,0,NULL),
(1498,'长摊待摊费用','QM_FLDZC_CQDTFY',29,3,0,0,0,4,2,0,NULL),
(1499,'递延所得税资产','QM_FLDZC_DYSDSZC',30,3,0,0,0,4,2,0,NULL),
(1500,'其他非流动资产','QM_FLDZC_QTFLDZC',31,3,0,0,0,4,2,0,NULL),
(1501,'非流动资产合计','QM_FLDZC_FLDZCHJ',32,3,0,0,0,4,2,0,NULL),
(1502,'资产总计','QM_ZCZJ',33,3,0,0,0,4,2,0,NULL),
(1503,'短期借款','QM_LDFZ_DQJK',2,7,0,0,0,4,2,0,NULL),
(1504,'交易性金融负债','QM_LDFZ_JYXJRFZ',3,7,0,0,0,4,2,0,NULL),
(1505,'应付票据','QM_LDFZ_YFPJ',4,7,0,0,0,4,2,0,NULL),
(1506,'应付账款','QM_LDFZ_YFZK',5,7,0,0,0,4,2,0,NULL),
(1507,'预收款项','QM_LDFZ_YSZK',6,7,0,0,0,4,2,0,NULL),
(1508,'应付职工薪酬','QM_LDFZ_YFGZ',7,7,0,0,0,4,2,0,NULL),
(1509,'应交税费','QM_LDFZ_YJSJ',8,7,0,0,0,4,2,0,NULL),
(1510,'应付利息','QM_LDFZ_YFLX',9,7,0,0,0,4,2,0,NULL),
(1511,'应付股利','QM_LDFZ_YFGL',10,7,0,0,0,4,2,0,NULL),
(1512,'其他应付款','QM_LDFZ_QTYFK',11,7,0,0,0,4,2,0,NULL),
(1513,'一年内到期的非流动负债','QM_LDFZ_YNNDQCQFZ',12,7,0,0,0,4,2,0,NULL),
(1514,'其他流动负债','QM_LDFZ_QTLDFZ',13,7,0,0,0,4,2,0,NULL),
(1515,'流动负债合计','QM_LDFZ_LDFZHJ',14,7,0,0,0,4,2,0,NULL),
(1516,'长期借款','QM_FLDFZ_CQJK',16,7,0,0,0,4,2,0,NULL),
(1517,'应付债券','QM_FLDFZ_YFZQ',17,7,0,0,0,4,2,0,NULL),
(1518,'长期应付款','QM_FLDFZ_CQYFK',18,7,0,0,0,4,2,0,NULL),
(1519,'专项应付款','QM_FLDFZ_ZXYFK',19,7,0,0,0,4,2,0,NULL),
(1520,'预计负债','QM_FLDFZ_YJFZ',20,7,0,0,0,4,2,0,NULL),
(1521,'递延所得税负债','QM_DYSX_DYSKHX',21,7,0,0,0,4,2,0,NULL),
(1522,'其他非流动负债','QM_FLDFZ_QTCQFZ',22,7,0,0,0,4,2,0,NULL),
(1523,'非流动负债合计','QM_FLDFZ_CQFZHJ',23,7,0,0,0,4,2,0,NULL),
(1524,' 负债合计','QM_DYSX_FZHJ',24,7,0,0,0,4,2,0,NULL),
(1525,'实收资本（或股本）','QM_GDQY_SSZB',26,7,0,0,0,4,2,0,NULL),
(1526,'资本公积','QM_GDQY_ZBGJ',27,7,0,0,0,4,2,0,NULL),
(1527,'减：库存股','QM_GDQY_KCG',28,7,0,0,0,4,2,0,NULL),
(1528,'盈余公积','QM_GDQY_YYGJ',29,7,0,0,0,4,2,0,NULL),
(1529,'未分配利润','QM_GDQY_WFPLR',30,7,0,0,0,4,2,0,NULL),
(1530,'所有者权益（或股东权益）合计','QM_GDQY_SYZQYHJ',31,7,0,0,0,4,2,0,NULL),
(1531,' 负债和所有者权益（或股东权益）总计','QM_GDQY_FZHSYZQY',33,7,0,0,0,4,2,0,NULL),
(1539,'以公允价值计量且其变动计入当期损益的金融资产','NC_YGYJZJLQQBD',0,2,0,0,0,4,2,0,NULL),
(1540,'以公允价值计量且其变动计入当期损益的金融资产','QM_YGYJZJLQQBD',0,3,0,0,0,4,2,0,NULL),
(1541,'衍生金融资产','NC_YSJRZC',0,2,0,0,0,4,2,0,NULL),
(1542,'衍生金融资产','QM_YSJRZC',0,3,0,0,0,4,2,0,NULL),
(1543,'持有待售的资产','NC_CYDSDZC',0,2,0,0,0,4,2,0,NULL),
(1544,'持有待售的资产','QM_CYDSDZC',0,3,0,0,0,4,2,0,NULL),
(1545,'持有待售的负债','NC_CYDSDFZ',0,6,0,0,0,4,2,0,NULL),
(1546,'持有待售的负债','QM_CYDSDFZ',0,7,0,0,0,4,2,0,NULL),
(1547,'其中：优先股','NC_QZYXG',0,6,0,0,0,4,2,0,NULL),
(1548,'其中：优先股','QM_QZYXG',0,7,0,0,0,4,2,0,NULL),
(1549,'永续债','NC_YXZ',0,6,0,0,0,4,2,0,NULL),
(1550,'永续债','QM_YXZ',0,7,0,0,0,4,2,0,NULL),
(1551,'以公允价值计量且其变动计入当期损益的金融负债','NC_YGYJZJLJRFZ',0,6,0,0,0,4,2,0,NULL),
(1552,'以公允价值计量且其变动计入当期损益的金融负债','QM_YGYJZJLJRFZ',0,7,0,0,0,4,2,0,NULL),
(1553,'衍生金融负债','NC_YSJRFZ',0,6,0,0,0,4,2,0,NULL),
(1554,'衍生金融负债','QM_YSJRFZ',0,7,0,0,0,4,2,0,NULL),
(1555,'持有待售的负债','NC_CYDSDFZ',0,6,0,0,0,4,2,0,NULL),
(1556,'持有待售的负债','QM_CYDSDFZ',0,7,0,0,0,4,2,0,NULL),
(1557,'其他权益工具','NC_QTQYGJ',0,6,0,0,0,4,2,0,NULL),
(1558,'其他权益工具','QM_QTQYGJ',0,7,0,0,0,4,2,0,NULL),
(1559,'核算项目代码','project_code',1,0,1,0,0,4,22,0,NULL),
(1560,'核算项目名称','project_name',1,1,1,0,0,4,22,0,NULL),
(1561,'余额','balance',1,2,1,0,0,4,22,0,NULL),
(1562,'到期1至90天','due1_to30_days',1,9,1,0,0,4,22,0,NULL),
(1563,'到期91至180天','due91_to180_days',1,10,1,0,0,4,22,0,NULL),
(1564,'到期181至360天','due181_to360_days',1,11,1,0,0,4,22,0,NULL),
(1565,'到期361至720天','due361_to720_days',1,12,1,0,0,4,22,0,NULL),
(1566,'到期721至1080天','due721_to1080_days',1,13,1,0,0,4,22,0,NULL),
(1567,'到期1081天以上','due1081_to1440_days',1,14,1,0,0,4,22,0,NULL),
(1574,'未到期1至90天','not_due1_to30_days',1,3,1,0,0,4,22,0,NULL),
(1575,'未到期91至180天','not_due31_to90_days',1,4,1,0,0,4,22,0,NULL),
(1576,'未到期181至360天','not_due91_to180_days',1,5,1,0,0,4,22,0,NULL),
(1577,'未到期361至720天','not_due181_days',1,6,1,0,0,4,22,0,NULL),
(1578,'未到期721至1080天','not_due721_to1080_days',1,7,1,0,0,4,22,0,NULL),
(1579,'未到期1081天以上','not_due1081_days',1,8,1,0,0,4,22,0,NULL),
(1580,'当日到期','due_today',1,15,1,0,0,4,22,0,NULL),
(1581,'核算项目代码','project_code',1,0,1,0,0,4,23,0,NULL),
(1582,'核算项目名称','project_name',1,1,1,0,0,4,23,0,NULL),
(1583,'余额','balance',1,4,1,0,0,4,23,0,NULL),
(1584,'到期1至90天','due1_to30_days',1,11,1,0,0,4,23,0,NULL),
(1585,'到期91至180天','due91_to180_days',1,12,1,0,0,4,23,0,NULL),
(1586,'到期181至360天','due181_to360_days',1,13,1,0,0,4,23,0,NULL),
(1587,'到期361至720天','due361_to720_days',1,14,1,0,0,4,23,0,NULL),
(1588,'到期721至1080天','due721_to1080_days',1,15,1,0,0,4,23,0,NULL),
(1589,'到期1081天以上','due1081_to1440_days',1,16,1,0,0,4,23,0,NULL),
(1590,'未到期1至90天','not_due1_to30_days',1,5,1,0,0,4,23,0,NULL),
(1591,'未到期91至180天','not_due31_to90_days',1,6,1,0,0,4,23,0,NULL),
(1592,'未到期181至360天','not_due91_to180_days',1,7,1,0,0,4,23,0,NULL),
(1593,'未到期361至720天','not_due181_days',1,8,1,0,0,4,23,0,NULL),
(1594,'未到期721至1080天','not_due721_to1080_days',1,9,1,0,0,4,23,0,NULL),
(1595,'未到期1081天以上','not_due1081_days',1,10,1,0,0,4,23,0,NULL),
(1596,'当日到期','due_today',1,17,1,0,0,4,23,0,NULL),
(1612,'信用期限','credit_period',1,2,1,0,0,4,23,0,NULL),
(1613,'信用额度','credit_line',1,3,1,0,0,4,23,0,NULL),
(1615,'其他综合收益','QM_QTZHSY',37,7,0,NULL,0,4,2,0,NULL),
(1616,'预计负债','QM_FLDFZ_YJFZ',38,7,0,NULL,0,4,2,0,NULL),
(1617,'递延收益','QM_DYSY',39,7,0,NULL,0,4,2,0,NULL),
(1618,'持有待售的负债','QM_CYDSFZ',40,7,0,NULL,0,4,2,0,NULL),
(1619,'以公允价值计量且其变动计入当期损益的金融负债','QM_JYXJRFZ',41,7,0,NULL,0,4,2,0,NULL),
(1620,'以公允价值计量且其变动计入当期损益的金融资产','QM_LDZC_JYXJRZC',42,7,0,NULL,0,4,2,0,NULL),
(1621,'减：库存股','QM_GDQY_KCG',31,7,0,NULL,0,1,2,0,'');

/*Table structure for table `t_report_result` */

DROP TABLE IF EXISTS `t_report_result`;

CREATE TABLE `t_report_result` (
  `ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `RYEAR` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `RMONTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `RYEAR_AND_MONTH` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_NO` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATA_VALUE` decimal(24,4) DEFAULT NULL,
  `ORG_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `t_report_result` */

/*Table structure for table `t_sys_dictionary` */

DROP TABLE IF EXISTS `t_sys_dictionary`;

CREATE TABLE `t_sys_dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cn_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字典中文名称',
  `en_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '字典英文名称',
  `flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标志位:0:不可编辑;1:可编辑;',
  `remark` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建用户',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `cn_name` (`cn_name`) USING BTREE,
  UNIQUE KEY `en_name` (`en_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统字典';

/*Data for the table `t_sys_dictionary` */

/*Table structure for table `t_sys_dictionary_detail` */

DROP TABLE IF EXISTS `t_sys_dictionary_detail`;

CREATE TABLE `t_sys_dictionary_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '值',
  `remark` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `dictionary_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK7AC6D4871858CAD1` (`dictionary_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=903 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统字典明细';

/*Data for the table `t_sys_dictionary_detail` */

/*Table structure for table `t_sys_resources` */

DROP TABLE IF EXISTS `t_sys_resources`;

CREATE TABLE `t_sys_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` int NOT NULL COMMENT '父节点',
  `res_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单键',
  `type` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '0:根菜单1:子菜单2:按钮',
  `res_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单地址',
  `order_no` int NOT NULL COMMENT '排序',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片',
  `btn` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '按钮',
  `is_hide` int NOT NULL DEFAULT '0' COMMENT '默认0:不隐藏1:隐藏',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台菜单表';

/*Data for the table `t_sys_resources` */

insert  into `t_sys_resources`(`id`,`name`,`parent_id`,`res_key`,`type`,`res_url`,`order_no`,`icon`,`btn`,`is_hide`,`description`) values 
(1,'系统管理',0,'system','0','/',1,'icon-desktop','',0,'系统管理'),
(2,'菜单管理',1,'resources','1','/admin/pc/resources/menuManageIndex',1,'icon-th','',0,'系统管理>>菜单管理'),
(20,'用户管理',1,'userManage','1','/admin/pc/administratorManage/administratorIndex',3,'icon-user','',0,'系统管理>>后台用户管理'),
(35,'新增菜单资源',2,'resources_add','2','/',1,NULL,'addFun,addFun,btn btn-xs btn-info,新增',0,'系统管理>>菜单管理>>新增菜单资源'),
(36,'修改菜单资源',2,'resources_edit','2','/',2,NULL,'editFun,editFun,btn btn-xs btn-info,编辑',0,'系统管理>>菜单管理>>修改菜单资源'),
(37,'删除菜单资源',2,'resources_delete','2','/',3,'','delFun,delFun,btn btn-xs btn-danger,删除',0,'系统管理>>菜单管理>>删除菜单资源'),
(38,'新增用户',20,'account_add','2','/',1,'','addAccount,addFun,btn btn-xs btn-info,新增',0,'系统管理>>后台用户管理>>新增用户'),
(39,'分配权限',20,'permissions','2','/',3,NULL,'permissions,permissions,btn btn-xs btn-info,分配权限',0,'系统管理>>后台用户管理>>分配权限'),
(72,'编辑用户',20,'account_edit','2','/',2,NULL,'editAccount,editFun,btn btn-xs btn-info,编辑',0,'系统管理>>后台用户管理>>修改用户'),
(73,'删除用户',20,'account_delete','2','/',4,NULL,'delAccount,delAccount,btn btn-xs btn-danger,删除',0,'系统管理>>后台用户管理>>删除用户'),
(99,'角色管理',1,'roleManage','1','/admin/pc/roleManage/roleManageIndex',2,'icon-eye-close',NULL,0,'系统管理>>角色管理'),
(100,'新增角色',99,'role_add','2','/',1,NULL,'addRole,addFun,btn btn-xs btn-info,新增',0,'系统管理>>角色管理>>新增角色'),
(101,'编辑角色',99,'role_edit','2','/',2,NULL,'editRole,editFun,btn btn-xs btn-info,编辑',0,'系统管理>>角色管理>>编辑角色'),
(102,'删除角色',99,'role_delete','2','/',3,NULL,'delRole,delRole,btn btn-xs btn-danger,删除',0,'系统管理>>角色管理>>删除角色'),
(119,'系统字典',1,'systemDictionary','1','/admin/pc/systemDictionary/systemDictionaryIndex',5,'icon-book','',0,'系统管理>>系统字典'),
(120,'新增系统字典',119,'systemDictionary_add','2','/',2,'','addSystemDictionary,addFun,btn btn-xs btn-info,新增',0,'系统管理>>系统字典>>新增系统字典'),
(121,'编辑系统字典',119,'systemDictionary_edit','2','/',3,'','editSystemDictionary,editFun,btn btn-xs btn-info,编辑',0,'系统管理>>系统字典>>编辑系统字典'),
(122,'删除系统字典',119,'systemDictionary_delete','2','/',4,'','delSystemDictionary,delAccount,btn btn-xs btn-danger,删除',0,'系统管理>>系统字典>>删除系统字典'),
(123,'查看系统字典',119,'systemDictionary_view','2','/',1,'','viewSystemDictionary,viewFun,btn btn-xs btn-info,查看',1,'系统管理>>系统字典>>查看系统字典'),
(128,'用户日志',112,'logManage','1','/admin/pc/userlogManage/logManageIndex',4,'icon-calendar','',0,'用户管理>>日志管理'),
(137,'数据导入',0,'1','0','1',2,'icon-credit-card','',0,''),
(140,'利润表导入',137,'tBasiProfit','1','/report/tBasiProfitIndex',2,'','',0,'财务管理>>利润表导入'),
(142,'资讯管理',175,'message','1','/msg/msgIndex',1,'icon-tasks','',0,'财务管理>>资讯管理'),
(143,'资产负债表导入',137,'tBasiAssetsAndLiabilities','1','/report/tBasiAssetsAndLiabilitiesIndex',3,'',NULL,0,'财务管理>>资产负债表导入'),
(144,'科目余额导入',137,'tKmye','1','/report/tKmyeIndex',5,'',NULL,0,'财务管理>>科目余额导入'),
(148,'编码字典',175,'codeLibr','1','/codeLibr/codeLibrIndex',1,'icon-book','',0,'财务管理>>编码字典'),
(149,'点击导入EXCEL',140,'upload','2','/',1,'','upload,upload,btn btn-xs btn-info,点击导入EXCEL',0,''),
(150,'导入',143,'upload','2','/',1,'','upload,upload,btn btn-xs btn-info,点击导入EXCEL',0,''),
(153,'公司管理',1,'com','1','/orgInfo/orgInfoIndex',1,'icon-home','',0,''),
(154,'新增',153,'addOrg','2','/',1,'','addFunOrg,addFunOrg,btn btn-xs btn-info,新增',0,''),
(155,'新增',148,'addCodeLibr','2','/',1,NULL,'addCodeLibr,addCodeLibr,btn btn-xs btn-info,新增',0,NULL),
(156,'编辑',148,'editCodeLibr','2','/',1,NULL,'editCodeLibr,editCodeLibr,btn btn-xs btn-info,编辑',0,NULL),
(158,'算法配置',175,'tModeIndex','1','/mode/tModeIndex',1,'icon-table','',0,'财务管理>>文字配置列表'),
(159,'新增',158,'addTMode','2','/',1,'','addTMode,addFun,btn btn-xs btn-info,新增',0,''),
(160,'编辑',158,'editTMode','2','/',1,'','editTMode,editFun,btn btn-xs btn-info,编辑',0,''),
(161,'删除',158,'delTMode','2','/',1,'','delTMode,delAccount,btn btn-xs btn-danger,删除',0,''),
(162,'现金流量导入',137,'tBasiCashFlowIndex','1','/report/tBasiCashFlowIndex',4,'',NULL,0,'财务管理>>现金流量导入'),
(163,'点击导入EXCEL',162,'upload','2','/',1,'','upload,upload,btn btn-xs btn-info,点击导入EXCEL',0,''),
(164,'增加',142,'addMsg','2','/',1,'','addMsg,addMsg,btn btn-xs btn-info,新增',0,''),
(165,'编辑',142,'editMsg','2','/',1,'','editMsg,editMsg,btn btn-xs btn-info,编辑',0,''),
(166,'删除',142,'delMsg','2','/',1,'','delMsg,delMsg,btn btn-xs btn-danger,删除',0,''),
(175,'模型管理',0,'pz','0','/',2,'icon-reorder','',0,''),
(176,'删除',148,'delCodeLibr','2','/',1,'','delCodeLibr,delAccount,btn btn-xs btn-danger,删除',0,''),
(179,'编码映射',175,'codeMapper','1','/codeLibr/codeMapperIndex',1,'icon-move','',0,''),
(180,'新增',179,'addCodeMapper','2','/',1,'','addCodeMapper,addCodeMapper,btn btn-xs btn-info,新增',0,''),
(181,'编辑',179,'editCodeMapper','2','/',1,'','editCodeMapper,editCodeMapper,btn btn-xs btn-info,编辑',0,''),
(182,'删除',179,'delCodeMapper','2','/',1,'','delCodeMapper,delCodeMapper,btn btn-xs btn-danger,删除',0,''),
(183,'其他应付(收)账龄分析',137,'otherTAgeAnalysisIndex','1','/report/otherTAgeAnalysisIndex',11,'','',0,'财务管理>>其他账龄分析'),
(184,'预付(收)账款账龄分析',137,'planTAgeAnalysisIndex','1','/report/planTAgeAnalysisIndex',6,'',NULL,0,'财务管理>>预付(收)账款账龄分析'),
(185,'应付(收)账款账龄分析',137,'mustTAgeAnalysisIndex','1','/report/mustTAgeAnalysisIndex',7,'',NULL,0,''),
(193,'批量导入',137,'bulkImportIndex','1','/report/bulkImportIndex',1,'',NULL,0,'财务管理>>批量导入'),
(194,'批量导入',193,'upload','2','/',1,'','upload,upload,btn btn-xs btn-info,批量导入Excel',0,''),
(195,'初始化密码',20,'Chushihua','2','/',1,'','chushihua,chushihua,btn btn-xs btn-info,初始化密码',0,''),
(196,'修改公司信息',153,'Com_update','2','/',1,'','editOrg,editOrg,btn btn-xs btn-info,编辑',0,''),
(197,'数据转换',175,'reportResult','1','/report/result/index',5,'icon-retweet','',0,''),
(198,'数据转换',197,'dataFormatAll','2','/',1,'','dataFormatAll,dataFormatAll,btn btn-xs btn-info,数据转换',0,'');

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `user_id` bigint NOT NULL COMMENT '创建人Id;-1手动创建',
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roleNameUnique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色表';

/*Data for the table `t_sys_role` */

/*Table structure for table `t_sys_role_action` */

DROP TABLE IF EXISTS `t_sys_role_action`;

CREATE TABLE `t_sys_role_action` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `res_id` bigint NOT NULL COMMENT '菜单ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色权限表';

/*Data for the table `t_sys_role_action` */

/*Table structure for table `t_sys_user` */

DROP TABLE IF EXISTS `t_sys_user`;

CREATE TABLE `t_sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `account_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号名称',
  `pwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `locked` int NOT NULL DEFAULT '0' COMMENT '默认0:不锁定1: 锁定',
  `account_type` int NOT NULL DEFAULT '1' COMMENT '账号类型0:root 1:用户',
  `create_user_id` bigint NOT NULL COMMENT '创建人Id;-1手动创建',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `create_time` datetime NOT NULL,
  `account_port_type` int DEFAULT NULL COMMENT '财务系统类别(如金蝶，用友)',
  `type` int DEFAULT '0' COMMENT '查询数据权限(0：所有；1：查询当前用户数据；2：查询用户ID为chrild_type的数据)',
  `chrild_type` varchar(2500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `org_id` bigint DEFAULT NULL COMMENT '公司id',
  `url` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `account_name` (`account_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户信息表';

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`id`,`user_name`,`account_name`,`pwd`,`locked`,`account_type`,`create_user_id`,`description`,`create_time`,`account_port_type`,`type`,`chrild_type`,`org_id`,`url`) values 
(1,'root','root','E10ADC3949BA59ABBE56E057F20F883E',0,0,1,'根账号','2017-08-16 18:34:39',4,0,NULL,8,NULL);

/*Table structure for table `t_sys_user_action` */

DROP TABLE IF EXISTS `t_sys_user_action`;

CREATE TABLE `t_sys_user_action` (
  `res_id` int NOT NULL COMMENT '菜单ID',
  `user_id` int NOT NULL COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='后台用户权限表';

/*Data for the table `t_sys_user_action` */

/*Table structure for table `t_sys_user_role` */

DROP TABLE IF EXISTS `t_sys_user_role`;

CREATE TABLE `t_sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色关联表';

/*Data for the table `t_sys_user_role` */

/* Procedure structure for procedure `report_divine` */

/*!50003 DROP PROCEDURE IF EXISTS  `report_divine` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`gxh`@`%` PROCEDURE `report_divine`(orgId VARCHAR(64))
begin
	DECLARE _now VARCHAR(100) DEFAULT DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s');          #当前时间	
	#DECLARE _nows datetime DEFAULT DATE_FORMAT(NOW(),'%Y-%m');
	DECLARE _nows VARCHAR(20) DEFAULT DATE_FORMAT(NOW(),'%Y-%m'); 
	DECLARE _nows_month VARCHAR(20) DEFAULT DATE_FORMAT(NOW(),'%Y-%m'); 
	DECLARE _int_nows_month VARCHAR(20) DEFAULT DATE_FORMAT(NOW(),'%Y-%m'); 
	DECLARE _int_nows INTEGER DEFAULT 0; 
	DECLARE _dt_now datetime DEFAULT NULL; 
	DECLARE _ryear_and_month VARCHAR(20) DEFAULT NULL;          #年月
  DECLARE _ryear INTEGER DEFAULT 0;
  DECLARE _rmonth INTEGER DEFAULT 0;
	DECLARE _org_id VARCHAR(48) DEFAULT NULL;
	DECLARE _values decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values1 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values2 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values3 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values4 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values5 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values6 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values7 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values8 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values9 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values10 decimal(65,2) DEFAULT '0.0000';
	DECLARE _values11 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values12 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values13 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values14 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values15 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values16 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values17 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values18 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values19 decimal(65,2) DEFAULT '0.0000'; 
	DECLARE _values20 decimal(65,2) DEFAULT '0.0000';
	DECLARE _pvalues decimal(24,2) DEFAULT '0.0000';
	DECLARE _pjvalues decimal(24,2) DEFAULT '0.0000';
	DECLARE _rate decimal(24,12) DEFAULT '0.0000';
	DECLARE _rate1 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate2 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate3 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate4 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate5 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate6 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate7 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate8 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate9 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate10 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate11 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate12 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate13 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate14 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate15 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate16 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate17 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate18 decimal(24,14) DEFAULT '0.0000';
	DECLARE _rate19 decimal(24,14) DEFAULT '0.0000';
	DECLARE _isnull INTEGER DEFAULT 0;
  DECLARE _code VARCHAR(20) DEFAULT NULL;
	DECLARE _max_year_month VARCHAR(20) DEFAULT NULL;
	DECLARE _year_months VARCHAR(20) DEFAULT NULL;
	DECLARE _dt_max_year_month datetime DEFAULT NULL; 
	#DECLARE _year_months VARCHAR(20) DEFAULT NULL;
	DECLARE _dt_year_months datetime DEFAULT NULL; 
	DECLARE _codes VARCHAR(20) DEFAULT NULL;
	DECLARE _max_month INTEGER DEFAULT 0;
	DECLARE _max_year INTEGER DEFAULT 0;
	DECLARE _max_year_in INTEGER DEFAULT 0;
	DECLARE _all_count_year INTEGER DEFAULT 0;
	DECLARE _min_year_in INTEGER DEFAULT 0;
	DECLARE _min_year_in2 INTEGER DEFAULT 0;
	DECLARE _min_year_in3 INTEGER DEFAULT 0;
	DECLARE _min_month_in INTEGER DEFAULT 0;
	DECLARE _min_year_month VARCHAR(20) DEFAULT NULL;
	DECLARE _dt_min_year_month datetime DEFAULT NULL; 
	DECLARE _min_month INTEGER DEFAULT 0;
	DECLARE _min_year INTEGER DEFAULT 0;
	DECLARE _last_month INTEGER DEFAULT 0;             #当年剩余年份
	DECLARE _tatol_month INTEGER DEFAULT 24;             #总共需要预测的月份,默认两年
	DECLARE _dq_year INTEGER DEFAULT 0;
	DECLARE _m_year INTEGER DEFAULT 0;
	DECLARE _count_year INTEGER DEFAULT 0;
	DECLARE _pjcount INTEGER DEFAULT 0;
	#循环标记
	DECLARE _i INTEGER DEFAULT 0;
	DECLARE _is INTEGER DEFAULT 0;
	DECLARE _yi INTEGER DEFAULT 0;
	DECLARE _bj INTEGER DEFAULT 0;
	DECLARE _counts INTEGER DEFAULT 0;
	DECLARE _ycounts INTEGER DEFAULT 0;
	DECLARE _counts2 INTEGER DEFAULT 0;
	DECLARE _counts3 INTEGER DEFAULT 0;
	DECLARE _counts4 INTEGER DEFAULT 0;
	DECLARE _counts5 INTEGER DEFAULT 0;
	DECLARE _ecounts INTEGER DEFAULT 0;
	DECLARE _scounts INTEGER DEFAULT 0;
	DECLARE _uuid VARCHAR(50) DEFAULT NULL;
	DECLARE _reason VARCHAR(1000) DEFAULT NULL;
	
	DECLARE _v1 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v2 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v3 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v4 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v5 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v6 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v7 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v8 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v9 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v10 decimal(24,2) DEFAULT '0.0000'; 
	DECLARE _v11 decimal(24,2) DEFAULT '0.0000'; 
	#定义错误
	DECLARE _error INTEGER DEFAULT 0;
	#标志回滚
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET _error = 1;
	START TRANSACTION;
	#DATE_FORMAT(NOW(),'%Y-%m');
	#SET _nows=substring(_now,0,7);
	#SET _org_id=orgId;
	#DELETE FROM t_result_reason WHERE org_id=_org_id; 
	
	DELETE FROM T_REPORT WHERE ORG_ID=orgId;       #先删除该公司所有预算
	INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID) SELECT a.ID,RYEAR,a.RMONTH,a.RYEAR_AND_MONTH,a.CODE_NO,a.DATA_VALUE,a.ORG_ID 
		FROM T_REPORT_RESULT a LEFT JOIN T_CODE_LIBR b ON a.CODE_NO=b.CODE_NO  WHERE REPORT_TYPE in ('2') AND ORG_ID=orgId;
	#SELECT _error,_i,_rate,_min_month_in;
	SELECT MAX(RYEAR_AND_MONTH) INTO _max_year_month FROM T_REPORT WHERE ORG_ID=orgId;
	SELECT MIN(RYEAR_AND_MONTH) INTO _min_year_month FROM T_REPORT WHERE ORG_ID=orgId;
	SELECT MAX(str_to_date(CONCAT(RYEAR_AND_MONTH,'-01'),'%Y-%m-%d')) INTO _dt_max_year_month FROM T_REPORT WHERE ORG_ID=orgId;
	SELECT MIN(str_to_date(CONCAT(RYEAR_AND_MONTH,'-01'),'%Y-%m-%d')) INTO _dt_min_year_month FROM T_REPORT WHERE ORG_ID=orgId;
	#SET _dt_max_year_month=str_to_date(CONCAT(_max_year_month,'-01'),'%Y-%m-%d');
	#SET _dt_min_year_month=str_to_date(CONCAT(_min_year_month,'-01'),'%Y-%m-%d');
	#SET _max_year_month=date_sub(str_to_date(CONCAT(_max_year_month)),interval -1 MONTH);
	SET _dt_now=str_to_date(CONCAT(_nows,'-01'),'%Y-%m-%d');
	SET _dt_now=date_sub(_dt_now,interval 1 MONTH);
	SET _nows=DATE_FORMAT(_dt_now,'%Y-%m');
	IF _dt_now>_dt_max_year_month THEN 
		SET _reason='当前最新时间为:';
		SET _reason=concat(_reason,_max_year_month,'不是当月最新时间',_nows);
		#INSERT INTO t_result_reason(reason,org_id) VALUES(_reason,orgId);
	END IF;
	SET _nows_month=DATE_FORMAT(_dt_now,'%m');
	SET _max_month=_nows_month;
	SET _nows=DATE_FORMAT(_dt_now,'%Y');
	SET _last_month=12-_max_month;
	SET _int_nows=_nows;
	SET _min_year=_int_nows-5;            #计算前5年
	SELECT COUNT(*) INTO _counts FROM T_CODE_LIBR WHERE REPORT_TYPE in ('2') AND CODE_NO NOT IN ('LR-AE','LR-AF','LR-Y','LR-AD') AND data_type='0';
	
	#SELECT _error,_i,_max_year_month,_nows,_dt_now,_max_year_month,_dt_max_year_month,_dt_min_year_month,_reason,_int_nows,_min_year,_counts,_all_count_year,_tatol_month;
	#SET _tatol_month=_tatol_month+_last_month;
	loop_label: LOOP        #循环code    
		SELECT CODE_NO INTO _codes FROM T_CODE_LIBR WHERE REPORT_TYPE in ('2') AND CODE_NO NOT IN ('LR-AE','LR-AF','LR-Y','LR-AD') AND data_type='0' LIMIT _i,1;		
		SELECT MIN(RYEAR) INTO _min_year_in FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO=_codes;
		#SELECT MIN(RMONTH) INTO _min_month_in FROM T_REPORT WHERE ORG_ID=orgId AND RYEAR=_min_year_in AND CODE_NO=_codes;
		SET _all_count_year=_int_nows+7;
		SET _tatol_month=12;
		SET _is=0;
		IF _min_year>=_min_year_in THEN
			SET _min_year_in=_min_year;
		END IF;
		SELECT count(*) INTO _ycounts FROM T_REPORT WHERE ORG_ID=orgId AND RYEAR>=_min_year_in AND CODE_NO=_codes;
		SET _min_month_in=1;
		#     资产减值损失,    公允价值变动收益,投资收益,对联营企业和合营企业的投资收益,资产处置收益,其他收益 ,      营业外收入,        营业外支出
		IF _codes='LR-S' OR _codes='LR-T' OR _codes='LR-U' OR _codes='LR-V' OR _codes='LR-W' OR _codes='LR-X' OR _codes='LR-Z' OR _codes='LR-AB' THEN
			IF _ycounts>0 THEN
			loop_label4: LOOP           #循环总月份		
				SELECT MIN(RYEAR) INTO _min_year_in2 FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO=_codes AND RMONTH=_min_month_in AND RYEAR>=_min_year_in;
				SELECT count(*) INTO _ecounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_min_year_in2 AND CODE_NO=_codes;
				SET _yi=0;
				SET _dq_year=_min_year_in2;
				SET _dq_year=_dq_year+1;
					loop_label5: LOOP  
						SET _pvalues=0.0000;
						SET _pjvalues=0.0000;
						SET _pjcount=0.0000;
						IF _min_month_in<10 THEN
							SET _year_months=concat(_dq_year,'-0',_min_month_in);
						ELSE
							SET _year_months=concat(_dq_year,'-',_min_month_in);
						END IF;
						IF _yi>=5 THEN
							SET _m_year=_dq_year-5;
						ELSE
							SET _m_year=_min_year_in2;
						END IF;
						SELECT COUNT(*) INTO _scounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
						IF _scounts=0 THEN
							SET _uuid=UUID();	
              SELECT SUM(DATA_VALUE) INTO _pvalues FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR<_dq_year AND RYEAR>=_m_year AND CODE_NO=_codes;
							SELECT COUNT(*) INTO _pjcount FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR<_dq_year AND RYEAR>=_m_year AND CODE_NO=_codes;
							IF _pjcount>0 THEN
								#IF _codes='LR-U' THEN
									#IF _dq_year=2023 THEN
										#SELECT _pvalues,_pjcount,_m_year,_dq_year,_codes;
									#END IF;
								#END IF;
								SET _pjvalues=_pvalues/_pjcount;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_pjvalues,orgId,1);
							END IF;
						END IF;
						SET _yi=_yi+1;
						SET _dq_year=_dq_year+1;
						IF _dq_year>_all_count_year THEN
							leave loop_label5;
						END IF;
					END LOOP;
				SET _min_month_in=_min_month_in+1;
				IF _min_month_in>12 THEN 
						leave loop_label4;
				END IF;
			END LOOP;
			END IF;
		ELSE
			IF _ycounts>0 THEN
			loop_label2: LOOP           #循环总月份		
				#SELECT count(*) INTO _ecounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_min_year_in AND CODE_NO=_codes;
				SELECT MIN(RYEAR) INTO _min_year_in2 FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO=_codes AND RMONTH=_min_month_in AND RYEAR>=_min_year_in;
				SELECT count(*) INTO _ecounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_min_year_in2 AND CODE_NO=_codes;
				IF _ecounts!=0 THEN
					#SET _dq_year=_min_year_in-5;
					SET _yi=0;
					SET _rate=0.0000;
					SET _rate1=0.0000;
					SET _rate2=0.0000;
					SET _rate3=0.0000;
					SET _rate4=0.0000;
					SET _rate5=0.0000;
					SET _rate6=0.0000;
					SET _rate7=0.0000;
					SET _rate8=0.0000;
					SET _rate9=0.0000;
					SET _rate10=0.0000;
					SET _rate11=0.0000;
					SET _rate12=0.0000;
					SET _rate13=0.0000;
					SET _rate14=0.0000;
					SET _rate15=0.0000;
					SET _rate16=0.0000;
					SET _rate17=0.0000;
					SET _rate18=0.0000;
					SET _rate19=0.0000;
					SET _values=0.0000;
					SET _values1=0.0000;
					SET _values2=0.0000;
					SET _values3=0.0000;
					SET _values4=0.0000;
					SET _values5=0.0000;
					SET _values6=0.0000;
					SET _values7=0.0000;
					SET _values8=0.0000;
					SET _values9=0.0000;
					SET _values10=0.0000;
					SET _values11=0.0000;
					SET _values12=0.0000;
					SET _values13=0.0000;
					SET _values14=0.0000;
					SET _values15=0.0000;
					SET _values16=0.0000;
					SET _values17=0.0000;
					SET _values18=0.0000;
					SET _values19=0.0000;
					SET _values20=0.0000;
					SET _bj=0;
					SET _dq_year=_min_year_in2;
					#SELECT _error,_i,_year_months,_min_month_in,_min_year_in,_dq_year;
					loop_label3: LOOP                #预测前几年相关数据
						IF _min_month_in<10 THEN
							SET _year_months=concat(_dq_year,'-0',_min_month_in);
						ELSE
							SET _year_months=concat(_dq_year,'-',_min_month_in);
						END IF;
						SET _yi=_yi+1;
						SELECT COUNT(*) INTO _scounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
						#SET _values2=_values;
						#IF _codes='LR-T' THEN
							#IF _min_month_in=12 THEN
								#SELECT _bj;
							#END IF;
						#END IF;
						IF _yi=1 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values1 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								#SET _bj=_bj+1;
								#IF _codes='LR-AE' THEN
								#IF _values1!=0.0000 THEN
										SET _bj=_bj+1;
										#SELECT _error,_i,_scounts,_dq_year,_min_month_in,_ecounts,_rate,_values1,_values2;
								#END IF;
								#SELECT _bj;
								#END IF;
							END IF;
						END IF;
						IF _yi=2 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values2 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values1!=0.0000 THEN
									SET _rate1=(_values2-_values1)/_values1;
									SET _rate=(_values2-_values1)/_values1;
									SET _bj=_bj+1;
								END IF;
							ELSE
								IF _bj>0 THEN
									SET _uuid=UUID();
									SET _values2=_values1;
									INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values2,orgId,1);
									SET _rate=0;
									SET _rate1=0;
									SET _bj=_bj+1;
								END IF;
							END IF;	
						END IF;
						IF _yi=3 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values3 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values2!=0.0000 THEN
									SET _rate2=(_values3-_values2)/_values2;
									SET _rate=(_rate1+_rate2)/_bj;
									SET _bj=_bj+1;
								END IF;			
							ELSE
								SET _uuid=UUID();
								SET _values3=_values2*_rate+_values2;
								#SELECT _error,_i,_rate,_values1,_yi,_scounts,_all_count_year,_dq_year,_year_months,_uuid,_dq_year,_min_month_in,_year_months,_codes,_values3,orgId;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values3,orgId,1);
								#SELECT _error,_i,_rate,_values1,_yi,_scounts,_all_count_year,_dq_year,_year_months;
								SET _rate2=(_values3-_values2)/_values2;
								SET _rate=(_rate1+_rate2)/_bj;
								SET _bj=_bj+1;
							END IF;	
						END IF;
						IF _yi=4 THEN
							IF _scounts>0 THEN
							SELECT SUM(DATA_VALUE) INTO _values4 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values3!=0.0000 THEN
									SET _rate3=(_values4-_values3)/_values3;
									SET _rate=(_rate1+_rate2+_rate3)/_bj;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values4=_values3*_rate+_values3;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values4,orgId,1);
								SET _rate3=(_values4-_values3)/_values3;
								SET _rate=(_rate1+_rate2+_rate3)/_bj;
								#SELECT _rate1,_rate2,_rate3,_values4,_values3,_values2,_values1,_rate,_bj;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=5 THEN
							IF _scounts>0 THEN
							SELECT SUM(DATA_VALUE) INTO _values5 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values4!=0.0000 THEN
									SET _rate4=(_values5-_values4)/_values4;
									SET _rate=(_rate1+_rate2+_rate3+_rate4)/_bj;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values5=_values4*_rate+_values4;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values5,orgId,1);
								SET _rate4=(_values5-_values4)/_values4;
								SET _rate=(_rate1+_rate2+_rate3+_rate4)/_bj;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=6 THEN
							IF _scounts>0 THEN
							SELECT SUM(DATA_VALUE) INTO _values6 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values5!=0.0000 THEN
									SET _rate5=(_values6-_values5)/_values5;
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5)/_bj;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values6=_values5*_rate+_values5;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values6,orgId,1);
								SET _rate5=(_values6-_values5)/_values5;
								SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5)/_bj;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=7 THEN
							IF _scounts>0 THEN
							SELECT SUM(DATA_VALUE) INTO _values7 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values6!=0.0000 THEN
									SET _rate6=(_values7-_values6)/_values6;									
									IF _bj>5 THEN
										SET _rate=(_rate2+_rate3+_rate4+_rate5+_rate6)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6)/_bj;
									END IF;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values7=_values6*_rate+_values6;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values7,orgId,1);
								SET _rate6=(_values7-_values6)/_values6;
								IF _bj>5 THEN
									SET _rate=(_rate2+_rate3+_rate4+_rate5+_rate6)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6)/_bj;
								END IF;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=8 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values8 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values7!=0.0000  THEN
									SET _rate7=(_values8-_values7)/_values7;
									IF _bj>5 THEN
										SET _rate=(_rate3+_rate4+_rate5+_rate6+_rate7)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7)/_bj;
									END IF;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values8=_values7*_rate+_values7;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values8,orgId,1);
								SET _rate7=(_values8-_values7)/_values7;
								IF _bj>5 THEN
									SET _rate=(_rate3+_rate4+_rate5+_rate6+_rate7)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7)/_bj;
								END IF;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=9 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values9 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values8!=0.0000 THEN
									SET _rate8=(_values9-_values8)/_values8;
									IF _bj>5 THEN
										SET _rate=(_rate4+_rate5+_rate6+_rate7+_rate8)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8)/_bj;
									END IF;
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values9=_values8*_rate+_values8;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values9,orgId,1);
								SET _rate8=(_values9-_values8)/_values8;
								IF _bj>5 THEN
									SET _rate=(_rate4+_rate5+_rate6+_rate7+_rate8)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8)/_bj;
								END IF;
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=10 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values10 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values10!=0.0000 THEN
									SET _rate9=(_values10-_values9)/_values9;
									IF _bj>5 THEN
										SET _rate=(_rate5+_rate6+_rate7+_rate8+_rate9)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values10=_values9*_rate+_values9;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values10,orgId,1);
								#INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values9,orgId,1);
								SET _rate9=(_values10-_values9)/_values9;
								IF _bj>5 THEN
										SET _rate=(_rate5+_rate6+_rate7+_rate8+_rate9)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9)/_bj;
									END IF;	
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=11 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values11 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values11!=0.0000 THEN
									SET _rate10=(_values11-_values10)/_values10;
									IF _bj>5 THEN
										SET _rate=(_rate6+_rate7+_rate8+_rate9+_rate10)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values11=_values10*_rate+_values10;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values11,orgId,1);
								SET _rate10=(_values11-_values10)/_values10;
								IF _bj>5 THEN
										SET _rate=(_rate6+_rate7+_rate8+_rate9+_rate10)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10)/_bj;
									END IF;		
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=12 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values12 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values12!=0.0000 THEN
									SET _rate11=(_values12-_values11)/_values11;
									IF _bj>5 THEN
										SET _rate=(_rate7+_rate8+_rate9+_rate10+_rate11)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values12=_values11*_rate+_values11;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values12,orgId,1);
								SET _rate11=(_values12-_values11)/_values11;
								IF _bj>5 THEN
									SET _rate=(_rate7+_rate8+_rate9+_rate10+_rate11)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11)/_bj;
								END IF;			
								SET _bj=_bj+1;
							END IF;		
						END IF;
						IF _yi=13 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values13 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values13!=0.0000 THEN
									SET _rate12=(_values13-_values12)/_values12;
									IF _bj>5 THEN
										SET _rate=(_rate8+_rate9+_rate10+_rate11+_rate12)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values13=_values12*_rate+_values12;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values13,orgId,1);
								SET _rate12=(_values13-_values12)/_values12;
								IF _bj>5 THEN
									SET _rate=(_rate8+_rate9+_rate10+_rate11+_rate12)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=14 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values14 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values14!=0.0000 THEN
									SET _rate13=(_values14-_values13)/_values13;
									IF _bj>5 THEN
										SET _rate=(_rate9+_rate10+_rate11+_rate12+_rate13)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values14=_values13*_rate+_values13;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values14,orgId,1);
								SET _rate13=(_values14-_values13)/_values13;
								IF _bj>5 THEN
									SET _rate=(_rate9+_rate10+_rate11+_rate12+_rate13)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13)/_bj;
								END IF;							
								
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=15 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values15 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values15!=0.0000 THEN
									SET _rate14=(_values15-_values14)/_values14;
									IF _bj>5 THEN
										SET _rate=(_rate10+_rate11+_rate12+_rate13+_rate14)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values15=_values14*_rate+_values14;	
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values15,orgId,1);
								SET _rate14=(_values15-_values14)/_values14;
								IF _bj>5 THEN
									SET _rate=(_rate10+_rate11+_rate12+_rate13+_rate14)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=16 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values16 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values16!=0.0000 THEN
									SET _rate15=(_values16-_values15)/_values15;
									IF _bj>5 THEN
										SET _rate=(_rate11+_rate12+_rate13+_rate14+_rate15)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values16=_values15*_rate+_values15;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values16,orgId,1);
								SET _rate15=(_values16-_values15)/_values15;
								IF _bj>5 THEN
									SET _rate=(_rate11+_rate12+_rate13+_rate14+_rate15)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=17 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values17 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values17!=0.0000 THEN
									SET _rate16=(_values17-_values16)/_values16;
									IF _bj>5 THEN
										SET _rate=(_rate12+_rate13+_rate14+_rate15+_rate16)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values17=_values16*_rate+_values16;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values17,orgId,1);
								SET _rate16=(_values17-_values16)/_values16;
								IF _bj>5 THEN
									SET _rate=(_rate12+_rate13+_rate14+_rate15+_rate16)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=18 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values18 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values18!=0.0000 THEN
									SET _rate17=(_values18-_values17)/_values17;
									IF _bj>5 THEN
										SET _rate=(_rate13+_rate14+_rate15+_rate16+_rate17)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16+_rate17)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values18=_values17*_rate+_values17;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values18,orgId,1);
								SET _rate17=(_values18-_values17)/_values17;
								IF _bj>5 THEN
									SET _rate=(_rate13+_rate14+_rate15+_rate16+_rate17)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16+_rate17)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						IF _yi=19 THEN
							IF _scounts>0 THEN
								SELECT SUM(DATA_VALUE) INTO _values19 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO=_codes;
								IF _values19!=0.0000 THEN
									SET _rate18=(_values19-_values18)/_values18;
									IF _bj>5 THEN
										SET _rate=(_rate14+_rate15+_rate16+_rate17+_rate18)/5;
									ELSE
										SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16+_rate17+_rate18)/_bj;
									END IF;							
									SET _bj=_bj+1;
								END IF;
							ELSE
								SET _uuid=UUID();
								SET _values19=_values18*_rate+_values18;
								INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,_codes,_values19,orgId,1);
								SET _rate18=(_values19-_values18)/_values18;
								IF _bj>5 THEN
									SET _rate=(_rate14+_rate15+_rate16+_rate17+_rate18)/5;
								ELSE
									SET _rate=(_rate1+_rate2+_rate3+_rate4+_rate5+_rate6+_rate7+_rate8+rate9+rate10+rate11+rate12+_rate13+_rate14+_rate15+_rate16+_rate17+_rate18)/_bj;
								END IF;							
								SET _bj=_bj+1;		
							END IF;		
						END IF;
						
						#SET _min_year_in2=_min_year_in2+1;
						SET _dq_year=_dq_year+1;
						IF _dq_year>_all_count_year THEN
							leave loop_label3;
						END IF;
					END LOOP;
				END IF;
				#SELECT _error,_i;
				#IF _count_year>=2 THEN
				SET _min_month_in=_min_month_in+1;
				#IF _min_month_in>12 THEN
					#SET _min_year_in=_min_year_in+1;              #加一年
					#SET _min_month_in=1;
				#END IF;		
				#END IF;
				#SET _is=_is+1;
				IF _min_month_in>12 THEN 
					leave loop_label2;
				END IF;
			END LOOP;
			END IF;
		END IF;
		SET _i=_i+1;
		IF _i>=_counts THEN 
				leave loop_label;
		END IF;
	END LOOP;
	#SELECT _error,_i,_rate,_min_month_in,_dq_year,_all_count_year;
  SET _min_month_in=1;
	loop_label20: LOOP           #循环总月份		
		#SELECT * FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO=_codes AND RMONTH=_min_month_in;
		SELECT MIN(RYEAR) INTO _min_year_in3 FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO='LR-A' AND RMONTH=_min_month_in;
		SELECT count(*) INTO _ecounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_min_year_in3 AND CODE_NO=_codes;
		SET _yi=0;
		#SET _min_month_in=1;
		SET _dq_year=_min_year_in3;
		SET _dq_year=_dq_year+1;
			loop_label21: LOOP  
				SET _pvalues=0.0000;
				SET _pjvalues=0.0000;
				SET _values=0.0000;
				SET _values2=0.0000;
				SET _values3=0.0000;
				SET _pjcount=0;
				SET _counts4=0;
				SET _counts5=0;
				IF _min_month_in<10 THEN
					SET _year_months=concat(_dq_year,'-0',_min_month_in);
				ELSE
					SET _year_months=concat(_dq_year,'-',_min_month_in);
				END IF;
				SET _yi=_yi+1;
				SELECT SUM(DATA_VALUE) INTO _v1 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-A';  #营业收入
				SELECT SUM(DATA_VALUE) INTO _v2 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-F';  #营业成本
				SELECT SUM(DATA_VALUE) INTO _v3 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-O';  #税金及附加
				SELECT SUM(DATA_VALUE) INTO _v4 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-P';  #销售费用
				SELECT SUM(DATA_VALUE) INTO _v5 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-Q';  #管理费用
				SELECT SUM(DATA_VALUE) INTO _v6 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-R';  #财务费用
				SELECT SUM(DATA_VALUE) INTO _v7 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-S'; 	#资产减值损失
				SELECT SUM(DATA_VALUE) INTO _v8 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-T'; 	#公允价值变动收益
				SELECT SUM(DATA_VALUE) INTO _v9 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-U';   #投资收益
				SELECT SUM(DATA_VALUE) INTO _v10 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-Z';		#营业外收入
				SELECT SUM(DATA_VALUE) INTO _v11 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-AB';   #营业外支出
				SELECT COUNT(*) INTO _counts4 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-Y';        #营业利润
				SELECT COUNT(*) INTO _counts5 FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_dq_year AND CODE_NO='LR-AD';        #利润总额
				SET _pjvalues=_v1-_v2-_v3-_v4-_v5-_v6-_v7+_v8+_v9;
				SET _values=_pjvalues+_v10-_v11;
				IF _counts4=0 THEN
					#SELECT _v1,_v2,_v3,_v4,_v5,_v6,_v7,_v8,_v9,_pjvalues,_year_months;
					SET _uuid=UUID();
					INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,'LR-Y',_pjvalues,orgId,1);
				END IF;
				IF _counts5=0 THEN
					SET _uuid=UUID();
					INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,'LR-AD',_values,orgId,1);
				END IF;
				SET _dq_year=_dq_year+1;
				IF _dq_year>_all_count_year THEN
					leave loop_label21;
				END IF;
			END LOOP;
		SET _min_month_in=_min_month_in+1;
		IF _min_month_in>12 THEN 
			leave loop_label20;
		END IF;
	END LOOP;
	SET _min_month_in=1;
	#loop_label8: LOOP           #循环总月份		
		#SELECT * FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO=_codes AND RMONTH=_min_month_in;
		SELECT MIN(RYEAR) INTO _min_year_in3 FROM T_REPORT WHERE ORG_ID=orgId AND CODE_NO='LR-AD' AND RMONTH=_min_month_in;
		SELECT count(*) INTO _ecounts FROM T_REPORT WHERE ORG_ID=orgId AND RMONTH=_min_month_in AND RYEAR=_min_year_in3 AND CODE_NO=_codes;
		SET _yi=0;
		#SET _min_month_in=1;
		SET _dq_year=_min_year_in3;
		SET _dq_year=_dq_year+1;
			loop_label9: LOOP  
				SET _pvalues=0.0000;
				SET _pjvalues=0.0000;
				SET _values=0.0000;
				SET _values2=0.0000;
				SET _values3=0.0000;
				SET _pjcount=0;
				SET _counts2=0;
				SET _counts3=0;
				#IF _min_month_in<10 THEN
					#SET _year_months=concat(_dq_year,'-0',_min_month_in);
				#ELSE
					#SET _year_months=concat(_dq_year,'-',_min_month_in);
				#END IF;
				SET _year_months=concat(_dq_year,'-','01');
				SET _yi=_yi+1;
				SELECT SUM(DATA_VALUE) INTO _pvalues FROM T_REPORT WHERE ORG_ID=orgId AND RYEAR=_dq_year AND CODE_NO='LR-AD'; 
				SELECT COUNT(*) INTO _counts2 FROM T_REPORT WHERE ORG_ID=orgId AND RYEAR=_dq_year AND CODE_NO='LR-AE'; 
				SELECT COUNT(*) INTO _counts3 FROM T_REPORT WHERE ORG_ID=orgId AND RYEAR=_dq_year AND CODE_NO='LR-AF'; 
				IF _pvalues<0 THEN
					SET _pjvalues=0;
				ELSE
					SET _pjvalues=_pvalues*0.25;
				END IF;
				SET _values=_pvalues-_pjvalues;
				IF _counts2=0 THEN
					SET _uuid=UUID();
					INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,'LR-AE',_pjvalues,orgId,1);
				END IF;
				IF _counts3=0 THEN
					SET _uuid=UUID();
					INSERT INTO T_REPORT(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) VALUES(_uuid,_dq_year,_min_month_in,_year_months,'LR-AF',_values,orgId,1);
				END IF;
				SET _dq_year=_dq_year+1;
				IF _dq_year>_all_count_year THEN
					leave loop_label9;
				END IF;
			END LOOP;
		#SET _min_month_in=_min_month_in+1;
		#IF _min_month_in>12 THEN 
			#leave loop_label8;
		#END IF;
	#END LOOP;
	
	IF _error=1 THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
	SELECT _error,_i,_rate,_min_month_in,_dq_year,_all_count_year;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
