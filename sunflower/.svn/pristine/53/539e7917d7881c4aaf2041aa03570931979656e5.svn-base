-- MySQL dump 10.13  Distrib 5.1.72, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: db_ucms2017
-- ------------------------------------------------------
-- Server version	5.1.72

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `tb_attrb_info`
--

DROP TABLE IF EXISTS `tb_attrb_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_attrb_info` (
  `ATTRB_CD` varchar(16) NOT NULL COMMENT '속성코드',
  `ATTRB_DC` text COMMENT '속성설명',
  `ATTRB_NM` varchar(256) DEFAULT NULL COMMENT '속성명',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일',
  `TABLE_NM` varchar(256) NOT NULL COMMENT '테이블명',
  PRIMARY KEY (`ATTRB_CD`)
) DEFAULT CHARSET=utf8 COMMENT='속성정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_bbs_cm`
--

DROP TABLE IF EXISTS `tb_bbs_cm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_bbs_cm` (
  `CM_ID` int(11) NOT NULL COMMENT '코멘트ID',
  `NTT_ID` int(11) NOT NULL COMMENT '게시물ID',
  `NTT_SJ` varchar(1024) DEFAULT NULL COMMENT '게시물제목',
  `NTT_CN` text COMMENT '게시글내용',
  `BBS_ID` varchar(16) NOT NULL COMMENT '게시판ID',
  `NTCR_ID` varchar(64) DEFAULT NULL COMMENT '게시자ID',
  `NTCR_NM` varchar(128) DEFAULT NULL COMMENT '게시자명',
  `PASSWORD` varchar(256) NOT NULL COMMENT '비밀번호',
  `NTCR_EMAD` varchar(512) DEFAULT NULL COMMENT '게시자이메일주소',
  `RECOMMEND_CO` int(11) DEFAULT NULL COMMENT '추천수',
  `CM_SE` varchar(64) NOT NULL COMMENT '코멘트구분',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `OPTN1` text COMMENT '옵션1',
  `OPTN2` text COMMENT '옵션2',
  `OPTN3` text COMMENT '옵션3',
  `OPTN4` text COMMENT '옵션4',
  `OPTN5` text COMMENT '옵션5',
  `OPTN6` text COMMENT '옵션6',
  `OPTN7` text COMMENT '옵션7',
  `OPTN8` text COMMENT '옵션8',
  `OPTN9` text COMMENT '옵션9',
  `OPTN10` text COMMENT '옵션10',
  `EXPSR_AT` char(1) NOT NULL COMMENT '노출여부',
  `DELETE_CD` char(1) DEFAULT NULL COMMENT '삭제코드(0:보임,1:사용자삭제,2:관리자삭제)',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`CM_ID`),
  KEY `FK_TB_BBS_CM_USER_PIN` (`USER_SN`),
  CONSTRAINT `FK_TB_BBS_CM_USER_PIN` FOREIGN KEY (`USER_SN`) REFERENCES `tm_user_pin` (`USER_SN`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='게시판코멘트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_bbs_estn`
--

DROP TABLE IF EXISTS `tb_bbs_estn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_bbs_estn` (
  `NTT_ID` int(11) NOT NULL COMMENT '게시물ID',
  `BBS_ID` varchar(16) NOT NULL COMMENT '게시판ID',
  `SORT_ORDR` int(11) DEFAULT NULL COMMENT '정렬순서',
  `NTT_SJ` varchar(1024) DEFAULT NULL COMMENT '게시물제목',
  `NTT_CN` text COMMENT '게시글내용',
  `NTCR_ID` varchar(64) DEFAULT NULL COMMENT '게시자ID',
  `NTCR_NM` varchar(128) DEFAULT NULL COMMENT '게시자명',
  `NTCR_EMAD` varchar(512) DEFAULT NULL COMMENT '게시자이메일주소',
  `NTCR_ZIP` varchar(7) DEFAULT NULL COMMENT '게시자우편번호',
  `NTCR_ADRES1` varchar(256) DEFAULT NULL COMMENT '게시자주소1',
  `NTCR_ADRES2` varchar(512) DEFAULT NULL COMMENT '게시자주소2',
  `NTCR_TELNO` varchar(32) DEFAULT NULL COMMENT '게시자전화번호',
  `NTCR_CPNO` varchar(32) DEFAULT NULL COMMENT '게시자휴대전화번호',
  `NTCR_PIN` varchar(128) DEFAULT NULL COMMENT '게시자개인식별번호',
  `PASSWORD` varchar(256) DEFAULT NULL COMMENT '비밀번호',
  `INQIRE_CO` int(11) DEFAULT NULL COMMENT '조회횟수',
  `NTCE_BGNDE` varchar(10) DEFAULT NULL COMMENT '게시시작일',
  `NTCE_ENDDE` varchar(10) DEFAULT NULL COMMENT '게시종료일',
  `ANSWER_AT` char(1) DEFAULT NULL COMMENT '답글여부',
  `PARNTS_NO` int(11) DEFAULT NULL COMMENT '부모글번호',
  `NTT_NO` int(11) DEFAULT NULL COMMENT '게시물번호',
  `ANSWER_LC` int(11) DEFAULT NULL COMMENT '답글위치',
  `SECRET_AT` char(1) DEFAULT NULL COMMENT '비밀여부',
  `NTT_TY_CD` varchar(16) NOT NULL COMMENT '게시글유형코드',
  `USER_SN` int(11) DEFAULT NULL COMMENT '사용자일련번호',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `DEPT_NM` varchar(256) DEFAULT NULL COMMENT '부서명',
  `HTML_AT` char(1) DEFAULT 'N' COMMENT 'HTML여부',
  `BBS_SE_CD` varchar(16) DEFAULT NULL COMMENT '게시판구분코드',
  `IMAGE_REPLC_TEXT_CN` text COMMENT '이미지대체텍스트내용',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  `OPTN1` text COMMENT '옵션1',
  `OPTN2` text COMMENT '옵션2',
  `OPTN3` text COMMENT '옵션3',
  `OPTN4` text COMMENT '옵션4',
  `OPTN5` text COMMENT '옵션5',
  `OPTN6` text COMMENT '옵션6',
  `OPTN7` text COMMENT '옵션7',
  `OPTN8` text COMMENT '옵션8',
  `OPTN9` text COMMENT '옵션9',
  `OPTN10` text COMMENT '옵션10',
  `OPTN11` text COMMENT '옵션11',
  `OPTN12` text COMMENT '옵션12',
  `OPTN13` text COMMENT '옵션13',
  `OPTN14` text COMMENT '옵션14',
  `OPTN15` text COMMENT '옵션15',
  `OPTN16` text COMMENT '옵션16',
  `OPTN17` text COMMENT '옵션17',
  `OPTN18` text COMMENT '옵션18',
  `OPTN19` text COMMENT '옵션19',
  `OPTN20` text COMMENT '옵션20',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`NTT_ID`),
  KEY `I_TB_BBS_ESTN_01` (`BBS_ID`,`DELETE_CD`,`USE_AT`),
  KEY `FK_TB_BBS_ESTN_CMMN_FILE` (`ATCH_FILE_ID`),
  KEY `FK_TB_BBS_ESTN_USER_PIN` (`USER_SN`),
  CONSTRAINT `FK_TB_BBS_ESTN_BBS_MASTR` FOREIGN KEY (`BBS_ID`) REFERENCES `tb_bbs_mastr` (`BBS_ID`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='게시판확장';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_bbs_mastr`
--

DROP TABLE IF EXISTS `tb_bbs_mastr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_bbs_mastr` (
  `BBS_ID` varchar(16) NOT NULL COMMENT '게시판ID',
  `BBS_TY_CD` varchar(16) NOT NULL COMMENT '게시판유형코드',
  `BBS_ATTRB_CD` varchar(16) NOT NULL COMMENT '게시판속성코드',
  `BBS_NM` varchar(512) NOT NULL COMMENT '게시판명',
  `BBS_DC` text COMMENT '게시판설명',
  `REPLY_POSBL_AT` char(1) DEFAULT NULL COMMENT '답글가능여부',
  `FILE_ATCH_POSBL_AT` char(1) DEFAULT NULL COMMENT '파일첨부가능여부',
  `ATCH_POSBL_FILE_CO` int(11) DEFAULT NULL COMMENT '첨부가능파일건수',
  `ATCH_POSBL_FILE_SIZE` varchar(32) DEFAULT NULL COMMENT '첨부가능파일사이즈',
  `NTCE_BGNDE` varchar(10) DEFAULT NULL COMMENT '게시시작일',
  `NTCE_ENDDE` varchar(10) DEFAULT NULL COMMENT '게시종료일',
  `TMPLAT_ID` char(20) DEFAULT NULL COMMENT '템플릿ID',
  `CM_POSBL_AT` char(1) DEFAULT NULL COMMENT '코멘트가능여부',
  `ADIT_CNTNTS_CN` text COMMENT '추가컨텐츠내용',
  `PAGE_SIZE` int(11) DEFAULT NULL COMMENT '페이지사이즈',
  `PAGE_UNIT` int(11) DEFAULT NULL COMMENT '페이지단위',
  `PREV_NEXT_POSBL_AT` char(1) DEFAULT NULL COMMENT '이전글다음글사용여부',
  `TABLE_NM` varchar(256) DEFAULT NULL COMMENT '테이블명',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부(Y:사용,N:미사용)',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`BBS_ID`),
  KEY `FK_TB_BBS_MASTR_TMPLAT_INFO` (`TMPLAT_ID`)
) DEFAULT CHARSET=utf8 COMMENT='게시판마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_field_info`
--

DROP TABLE IF EXISTS `tb_field_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_field_info` (
  `FIELD_ID` int(11) NOT NULL COMMENT '필드ID',
  `ATTRB_CD` varchar(16) NOT NULL COMMENT '속성코드',
  `ATTRB_TY_CD` varchar(16) NOT NULL COMMENT '속성유형코드',
  `FIELD_IEM_NM` varchar(256) NOT NULL COMMENT '필드항목명',
  `FIELD_TY_CD` varchar(16) NOT NULL COMMENT '필드유형코드',
  `FIELD_DC` text NOT NULL COMMENT '필드설명',
  `FIELD_ORDR` int(11) DEFAULT NULL COMMENT '필드순서',
  `LIST_USE_AT` char(1) DEFAULT 'N' COMMENT '리스트사용여부',
  PRIMARY KEY (`FIELD_ID`),
  KEY `FK_TB_FIELD_INFO_ATTRB_INFO` (`ATTRB_CD`),
  CONSTRAINT `FK_TB_FIELD_INFO_ATTRB_INFO` FOREIGN KEY (`ATTRB_CD`) REFERENCES `tb_attrb_info` (`ATTRB_CD`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='게시판 필드정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_acces_hist`
--

DROP TABLE IF EXISTS `tc_acces_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_acces_hist` (
  `HIST_SN` int(11) NOT NULL COMMENT '히스토리 일련번호',
  `ETC_INFO` varchar(256) DEFAULT NULL COMMENT '기타정보(권한명 등)',
  `ACCES_DT` datetime DEFAULT NULL COMMENT '접속일시',
  `ACCES_IP` varchar(16) DEFAULT NULL COMMENT '접속IP',
  `ACCES_CRUD` varchar(1) DEFAULT NULL COMMENT '접근구분',
  `ACCES_ADMIN_ID` varchar(64) DEFAULT NULL COMMENT '접근관리자ID',
  `ACCES_URL` varchar(4000) DEFAULT NULL COMMENT '접근URL',
  PRIMARY KEY (`HIST_SN`)
) DEFAULT CHARSET=utf8 COMMENT='접근히스토리 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_author_info`
--

DROP TABLE IF EXISTS `tc_author_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_author_info` (
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `AUTHOR_NM` varchar(256) NOT NULL COMMENT '권한명',
  `AUTHOR_DC` text COMMENT '권한설명',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`AUTHOR_CD`)
) DEFAULT CHARSET=utf8 COMMENT='권한정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_author_sclsrt`
--

DROP TABLE IF EXISTS `tc_author_sclsrt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_author_sclsrt` (
  `PARNTS_AUTHOR_CD` varchar(32) NOT NULL COMMENT '부모권한',
  `CHLDRN_AUTHOR_CD` varchar(32) NOT NULL COMMENT '자식권한',
  PRIMARY KEY (`PARNTS_AUTHOR_CD`,`CHLDRN_AUTHOR_CD`),
  UNIQUE KEY `PK_TC_AUTHOR_SCLSRT` (`PARNTS_AUTHOR_CD`,`CHLDRN_AUTHOR_CD`)
) DEFAULT CHARSET=utf8 COMMENT='권한계층';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_banner`
--

DROP TABLE IF EXISTS `tc_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_banner` (
  `BANNER_NO` int(11) NOT NULL COMMENT '배너번호',
  `BANNER_NM` varchar(256) NOT NULL COMMENT '배너명',
  `BANNER_URLAD` varchar(512) DEFAULT NULL COMMENT '배너URL주소',
  `BANNER_SE` varchar(16) DEFAULT NULL COMMENT '배너구분',
  `DONG_CD` varchar(16) DEFAULT NULL COMMENT '동코드',
  `SORT_ORDR` int(11) DEFAULT NULL COMMENT '정렬순서',
  `EXPSR_AT` char(1) DEFAULT NULL COMMENT '노출여부',
  `POPUP_AT` char(1) DEFAULT 'N' COMMENT '팝업여부',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `SITE_ID_SE` varchar(512) DEFAULT NULL COMMENT '사이트ID구분',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`BANNER_NO`)
) DEFAULT CHARSET=utf8 COMMENT='배너';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_cd_cl`
--

DROP TABLE IF EXISTS `tc_cmmn_cd_cl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_cd_cl` (
  `CL_CD` varchar(16) NOT NULL COMMENT '분류코드',
  `CL_CD_NM` varchar(256) DEFAULT NULL COMMENT '분류코드명',
  `CL_CD_DC` text COMMENT '분류코드설명',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`CL_CD`)
) DEFAULT CHARSET=utf8 COMMENT='공통코드분류';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_cd_ctgry`
--

DROP TABLE IF EXISTS `tc_cmmn_cd_ctgry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_cd_ctgry` (
  `CD_ID` varchar(32) NOT NULL COMMENT '코드ID',
  `CL_CD` varchar(16) NOT NULL COMMENT '분류코드',
  `CD_ID_NM` varchar(256) DEFAULT NULL COMMENT '코드ID명',
  `CD_ID_ENG_NM` varchar(256) DEFAULT NULL COMMENT '코드ID영문명',
  `CD_ID_DC` text COMMENT '코드ID설명',
  `CD_ID_ENG_DC` text COMMENT '코드ID영문설명',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`CD_ID`),
  KEY `FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL` (`CL_CD`),
  CONSTRAINT `FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL` FOREIGN KEY (`CL_CD`) REFERENCES `tc_cmmn_cd_cl` (`CL_CD`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='공통코드카테고리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_cd_detail`
--

DROP TABLE IF EXISTS `tc_cmmn_cd_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_cd_detail` (
  `CD` varchar(16) NOT NULL COMMENT '코드',
  `CD_ID` varchar(32) NOT NULL COMMENT '코드ID',
  `CD_NM` varchar(256) DEFAULT NULL COMMENT '코드명',
  `CD_ENG_NM` varchar(256) DEFAULT NULL COMMENT '코드영문명',
  `CD_DC` text COMMENT '코드설명',
  `CD_ENG_DC` text COMMENT '코드영문설명',
  `UPPER_CD` varchar(16) DEFAULT '0' COMMENT '상위코드',
  `DP` int(11) DEFAULT '1' COMMENT '깊이',
  `SORT_ORDR` int(11) DEFAULT '0' COMMENT '정렬순서',
  `OPTN1` text COMMENT '옵션1',
  `OPTN2` text COMMENT '옵션2',
  `OPTN3` text COMMENT '옵션3',
  `OPTN4` text COMMENT '옵션4',
  `OPTN5` text COMMENT '옵션5',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`CD`,`CD_ID`),
  KEY `FK_TC_CMMN_CD_DETAIL_CTGRY` (`CD_ID`),
  CONSTRAINT `FK_TC_CMMN_CD_DETAIL_CTGRY` FOREIGN KEY (`CD_ID`) REFERENCES `tc_cmmn_cd_ctgry` (`CD_ID`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='공통코드상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_cd_multi`
--

DROP TABLE IF EXISTS `tc_cmmn_cd_multi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_cd_multi` (
  `CD_ID` varchar(16) NOT NULL COMMENT '코드ID',
  `PROGRM_ID` varchar(32) NOT NULL COMMENT '프로그램ID',
  `PROGRM_SN` int(11) NOT NULL COMMENT '프로그램일련번호',
  `CD` varchar(16) NOT NULL COMMENT '코드',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `MEMO` text COMMENT '메모',
  PRIMARY KEY (`CD_ID`,`PROGRM_ID`,`PROGRM_SN`,`CD`),
  UNIQUE KEY `PK_TC_CMMN_CD_MULTI` (`CD_ID`,`PROGRM_ID`,`PROGRM_SN`,`CD`),
  KEY `FK_TC_CMMN_CD_MULTI_DETAIL` (`CD_ID`,`CD`),
  CONSTRAINT `FK_TC_CMMN_CD_MULTI_DETAIL` FOREIGN KEY (`CD_ID`, `CD`) REFERENCES `tc_cmmn_cd_detail` (`CD_ID`, `CD`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='공통코드다중';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_file`
--

DROP TABLE IF EXISTS `tc_cmmn_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_file` (
  `ATCH_FILE_ID` varchar(32) NOT NULL COMMENT '첨부파일ID',
  `USE_AT` char(1) NOT NULL COMMENT '사용여부',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록자ID',
  `PROGRM_ID` varchar(32) DEFAULT NULL COMMENT '프로그램ID',
  `OTHBC_AT` char(1) DEFAULT 'Y' COMMENT '공개여부 ',
  PRIMARY KEY (`ATCH_FILE_ID`)
) DEFAULT CHARSET=utf8 COMMENT='공통파일';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_file_detail`
--

DROP TABLE IF EXISTS `tc_cmmn_file_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_file_detail` (
  `ATCH_FILE_ID` varchar(32) NOT NULL COMMENT '첨부파일ID',
  `FILE_SN` int(11) NOT NULL COMMENT '파일일련번호',
  `FILE_STRE_COURS` varchar(512) NOT NULL COMMENT '파일저장경로',
  `STRE_FILE_NM` varchar(256) NOT NULL COMMENT '저장파일명',
  `ORIGNL_FILE_NM` varchar(256) DEFAULT 'NULL          ' COMMENT '원파일명',
  `FILE_EXTSN_NM` varchar(128) DEFAULT 'NULL           ' COMMENT '파일확장자명',
  `FILE_SIZE` int(11) DEFAULT NULL COMMENT '파일사이즈',
  `FILE_CN` text COMMENT '파일내용',
  `FILE_FIELD_NM` varchar(256) DEFAULT 'NULL           ' COMMENT '파일필드명',
  PRIMARY KEY (`ATCH_FILE_ID`,`FILE_SN`),
  CONSTRAINT `FK_TC_CMMN_FILE_DETAIL_FILE` FOREIGN KEY (`ATCH_FILE_ID`) REFERENCES `tc_cmmn_file` (`ATCH_FILE_ID`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='공통파일상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_file_dwld_hist`
--

DROP TABLE IF EXISTS `tc_cmmn_file_dwld_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_file_dwld_hist` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `ATCH_FILE_ID` varchar(32) NOT NULL COMMENT '첨부파일ID',
  `FILE_SN` int(10) NOT NULL COMMENT '파일일련번호',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID'
) DEFAULT CHARSET=utf8 COMMENT='공통파일다운로드이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cmmn_sn`
--

DROP TABLE IF EXISTS `tc_cmmn_sn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cmmn_sn` (
  `TABLE_NM` varchar(128) NOT NULL COMMENT '테이블명',
  `NEXT_SN` int(11) NOT NULL COMMENT '다음일련번호',
  PRIMARY KEY (`TABLE_NM`)
) DEFAULT CHARSET=utf8 COMMENT='공통일련번호';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_cntnts_manage`
--

DROP TABLE IF EXISTS `tc_cntnts_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_cntnts_manage` (
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `CNTNTS_MNNO` int(11) NOT NULL COMMENT '컨텐츠관리번호',
  `CNTNTS_CN` text COMMENT '콘텐츠내용',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`MENU_NO`,`CNTNTS_MNNO`),
  UNIQUE KEY `PK_TC_CNTNTS_MANAGE` (`MENU_NO`,`CNTNTS_MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='콘텐츠관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_error_log`
--

DROP TABLE IF EXISTS `tc_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_error_log` (
  `LOG_NO` int(11) NOT NULL COMMENT '로그번호',
  `ERROR_SJ` varchar(1024) NOT NULL COMMENT '에러제목',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_IPAD` varchar(128) NOT NULL COMMENT '사용자IP주소',
  `ERROR_DT` datetime NOT NULL COMMENT '에러일시',
  `ERROR_URLAD` varchar(512) DEFAULT NULL COMMENT '에러URL',
  `BEFORE_URLAD` varchar(512) DEFAULT NULL COMMENT '이전URL',
  `ERROR_CN` varchar(4000) DEFAULT NULL COMMENT '에러메세지'
) DEFAULT CHARSET=utf8 COMMENT='에러로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_global`
--

DROP TABLE IF EXISTS `tc_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_global` (
  `ATTRB_SN` int(11) NOT NULL COMMENT '속성일련번호',
  `ATTRB_NM` varchar(256) NOT NULL COMMENT '속성명',
  `ATTRB_VALUE` varchar(128) DEFAULT NULL COMMENT '속성값',
  `ATTRB_DC` text COMMENT '속성설명',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`ATTRB_SN`)
) DEFAULT CHARSET=utf8 COMMENT='글로벌:글로벌 변수설정하고 관리한다.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_indvdlinfo_colct`
--

DROP TABLE IF EXISTS `tc_indvdlinfo_colct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_indvdlinfo_colct` (
  `COLCT_SE` varchar(64) NOT NULL DEFAULT '' COMMENT '수집구분',
  `COLCT_MNNO` int(11) NOT NULL COMMENT '수집관리번호',
  `COLCT_SJ` varchar(512) DEFAULT NULL COMMENT '수집제목',
  `COLCT_CN` text COMMENT '수집내용',
  `COLCT_MEMO` varchar(4000) DEFAULT NULL COMMENT '수집메모',
  `SITE_ID` varchar(64) DEFAULT NULL COMMENT '사이트ID',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) NOT NULL COMMENT '수정ID',
  `UPDT_DT` datetime NOT NULL COMMENT '수정일시',
  PRIMARY KEY (`COLCT_SE`,`COLCT_MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='개인정보수집';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_menu_author`
--

DROP TABLE IF EXISTS `tc_menu_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_menu_author` (
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `MAP_CREAT_ID` varchar(16) DEFAULT NULL COMMENT '맵생성ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`MENU_NO`,`AUTHOR_CD`),
  UNIQUE KEY `PK_TC_MENU_AUTHOR` (`MENU_NO`,`AUTHOR_CD`),
  KEY `FK_TC_MENU_AUTHOR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_MENU_AUTHOR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='메뉴권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_menu_author_hist`
--

DROP TABLE IF EXISTS `tc_menu_author_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_menu_author_hist` (
  `HIST_NO` int(11) NOT NULL COMMENT '이력번호',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `AUTHOR_NM` varchar(256) NOT NULL COMMENT '권하명',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_NM` varchar(64) NOT NULL COMMENT '등록자명',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `REGIST_IPAD` varchar(128) DEFAULT NULL COMMENT '등록IP주소',
  `AUTHOR_DTLS` varchar(4000) DEFAULT NULL COMMENT '권한내역',
  PRIMARY KEY (`HIST_NO`)
) DEFAULT CHARSET=utf8 COMMENT='메뉴권한이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_menu_author_hist_detail`
--

DROP TABLE IF EXISTS `tc_menu_author_hist_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_menu_author_hist_detail` (
  `DETAIL_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '상세번호',
  `HIST_NO` int(11) NOT NULL COMMENT '이력번호',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `MENU_NM` varchar(256) NOT NULL DEFAULT '' COMMENT '메뉴명',
  `AUTHOR_SE` varchar(4000) DEFAULT NULL COMMENT '권한구분',
  `AUTHOR_RM` varchar(4000) DEFAULT NULL COMMENT '권한비고',
  PRIMARY KEY (`DETAIL_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=449 DEFAULT CHARSET=utf8 COMMENT='메뉴권한이력상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_menu_author_user_hist`
--

DROP TABLE IF EXISTS `tc_menu_author_user_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_menu_author_user_hist` (
  `MNNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '관리번호',
  `HIST_NO` int(11) NOT NULL COMMENT '이력번호',
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_SN` int(11) DEFAULT NULL COMMENT '사용자순번',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  PRIMARY KEY (`MNNO`)
) AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_menu_info`
--

DROP TABLE IF EXISTS `tc_menu_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_menu_info` (
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `MENU_NM` varchar(256) NOT NULL COMMENT '메뉴명',
  `UPPER_MENU_NO` int(11) NOT NULL COMMENT '상위메뉴번호',
  `MENU_ORDR` int(11) NOT NULL COMMENT '메뉴순서',
  `MENU_DC` text COMMENT '메뉴설명',
  `MENU_CNTNTS_CD` varchar(16) DEFAULT NULL COMMENT '메뉴콘텐츠코드',
  `MENU_LINK` varchar(512) DEFAULT NULL COMMENT '메뉴링크',
  `POPUP_AT` char(1) DEFAULT NULL COMMENT '팝업여부',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `RELATE_MENU_NM_LIST` varchar(4000) DEFAULT NULL COMMENT '관련메뉴명목록',
  `RELATE_MENU_LINK_LIST` text COMMENT '관련메뉴링크목록',
  `ALL_MENU_COURS` text COMMENT '전체메뉴경로',
  `CNTNTS_FILE_COURS` varchar(512) DEFAULT NULL COMMENT '콘텐츠파일경로',
  `MENU_LC` text COMMENT '메뉴위치',
  `BBS_ID` varchar(16) DEFAULT NULL COMMENT '게시판ID',
  `LEAF_NODE_AT` char(1) DEFAULT NULL COMMENT '최종하위메뉴유무',
  `KWRD_NM` varchar(1024) DEFAULT NULL COMMENT '키워드명',
  `ADI_INFO` text COMMENT '부가정보',
  `MENU_EXPSR_SE` varchar(10) DEFAULT NULL COMMENT '메뉴노출구분',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `USER_INFO_SE` char(1) DEFAULT NULL COMMENT '회원정보구분',
  `SCRIN_EXPSR_AT` char(1) DEFAULT NULL COMMENT '화면노출여부',
  PRIMARY KEY (`MENU_NO`),
  KEY `I_TC_MENU_INFO_01` (`SITE_ID`,`BBS_ID`,`MENU_NO`),
  KEY `I_TC_MENU_INFO_02` (`SITE_ID`,`UPPER_MENU_NO`,`DELETE_CD`)
) DEFAULT CHARSET=utf8 COMMENT='메뉴정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_mngr_main_estbs`
--

DROP TABLE IF EXISTS `tc_mngr_main_estbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_mngr_main_estbs` (
  `MNNO` int(11) NOT NULL COMMENT '관리번호',
  `SE_CD` varchar(16) NOT NULL COMMENT '설정구분코드',
  `BASS_MG` varchar(16) NOT NULL COMMENT '기본크기',
  `ESTBS_CN` text COMMENT '설정내용',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `AR_MVL` int(11) DEFAULT NULL COMMENT '넓이최대치',
  `AR_MNVL` int(11) DEFAULT NULL COMMENT '넓이최소치',
  `HG_MVL` int(11) DEFAULT NULL COMMENT '높이최대치',
  `HG_MNVL` int(11) DEFAULT NULL COMMENT '높이최소치',
  `SIZE_UPDT_AT` char(1) DEFAULT 'Y' COMMENT '사이즈변경여부',
  PRIMARY KEY (`MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='관리자메인설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_mngr_main_estbs_detail`
--

DROP TABLE IF EXISTS `tc_mngr_main_estbs_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_mngr_main_estbs_detail` (
  `MNNO` int(11) NOT NULL COMMENT '관리번호',
  `SN` int(11) NOT NULL COMMENT '일련번호',
  `ESTBS_NM` varchar(512) DEFAULT NULL COMMENT '설정명',
  `BBS_ID` varchar(16) DEFAULT NULL COMMENT '게시판ID',
  `URLAD` varchar(512) DEFAULT NULL COMMENT 'URL주소',
  `POPUP_AT` char(1) DEFAULT NULL COMMENT '팝업여부',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `FILE_FIELD_NM` varchar(256) DEFAULT NULL COMMENT '파일필드명',
  `FIELD_ORDR` int(11) NOT NULL COMMENT '필드순서',
  `ICON_NM` varchar(64) DEFAULT NULL COMMENT '아이콘명',
  PRIMARY KEY (`MNNO`,`SN`),
  CONSTRAINT `FK_TC_MNGR_MAIN_ESTBS_DETAIL` FOREIGN KEY (`MNNO`) REFERENCES `tc_mngr_main_estbs` (`MNNO`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='관리자메인설정상세';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_mngr_main_lc_estbs`
--

DROP TABLE IF EXISTS `tc_mngr_main_lc_estbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_mngr_main_lc_estbs` (
  `SN` int(11) NOT NULL COMMENT '일련번호',
  `MNNO` int(11) NOT NULL COMMENT '관리번호',
  `LFT_CRDNT` int(11) NOT NULL COMMENT '좌측좌표',
  `UPEND_CRDNT` int(11) NOT NULL COMMENT '탑좌표',
  `AR_VALUE` int(11) NOT NULL COMMENT '넓이값',
  `HG_VALUE` int(11) NOT NULL COMMENT '높이값',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`SN`)
) DEFAULT CHARSET=utf8 COMMENT='관리자메인위치설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_ntcn_relm`
--

DROP TABLE IF EXISTS `tc_ntcn_relm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_ntcn_relm` (
  `NTCN_NO` int(11) NOT NULL COMMENT '알림번호',
  `NTCN_NM` varchar(256) NOT NULL COMMENT '알림명',
  `NTCN_URLAD` varchar(512) DEFAULT NULL COMMENT '알림URL주소',
  `NTCN_CN` text COMMENT '알림내용',
  `NTCN_TY_CD` varchar(16) DEFAULT NULL COMMENT '알림유형코드',
  `SORT_ORDR` int(11) DEFAULT NULL COMMENT '정렬순서',
  `POPUP_AT` char(1) DEFAULT NULL COMMENT '팝업여부',
  `MAP_USE_AT` char(1) DEFAULT NULL COMMENT '맵사용여부',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `SITE_ID_SE` varchar(512) DEFAULT NULL COMMENT '사이트ID구분',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `LINK_SE` char(1) DEFAULT NULL COMMENT '링크구분',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`NTCN_NO`)
) DEFAULT CHARSET=utf8 COMMENT='알림영역';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_popup_manage`
--

DROP TABLE IF EXISTS `tc_popup_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_popup_manage` (
  `POPUP_NO` int(11) NOT NULL COMMENT '팝업번호',
  `POPUP_SJ` varchar(1024) NOT NULL COMMENT '팝업제목',
  `POPUP_CN` text COMMENT '팝업내용',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `AR_VALUE` int(11) DEFAULT NULL COMMENT '넓이값',
  `HG_VALUE` int(11) DEFAULT NULL COMMENT '높이값',
  `LFT_CRDNT` int(11) DEFAULT NULL COMMENT '좌측좌표',
  `UPEND_CRDNT` int(11) DEFAULT NULL COMMENT '탑좌표',
  `CLOSE_USE_AT` char(1) DEFAULT NULL COMMENT '닫기사용여부',
  `SITE_ID_SE` varchar(512) DEFAULT NULL COMMENT '사이트ID구분',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `URLAD` varchar(512) DEFAULT NULL COMMENT '링크주소',
  `SCRL_USE_AT` char(1) DEFAULT NULL COMMENT '스크롤사용여부',
  `LINK_TY_CD` varchar(16) DEFAULT NULL COMMENT '링크타입코드',
  `MAP_CN` text COMMENT '맵내용',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`POPUP_NO`)
) DEFAULT CHARSET=utf8 COMMENT='팝업관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_prhibt_wrd_dicary`
--

DROP TABLE IF EXISTS `tc_prhibt_wrd_dicary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_prhibt_wrd_dicary` (
  `WRD_SN` int(11) NOT NULL COMMENT '금지단어일련번호',
  `WRD_NM` varchar(256) DEFAULT NULL COMMENT '금지단어명',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `WRD_SE` char(1) NOT NULL COMMENT '금지단어구분',
  PRIMARY KEY (`WRD_SN`)
) DEFAULT CHARSET=utf8 COMMENT='금지단어사전';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_prhibt_wrd_flter`
--

DROP TABLE IF EXISTS `tc_prhibt_wrd_flter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_prhibt_wrd_flter` (
  `WRD_SN` int(11) NOT NULL COMMENT '금지단어일련번호',
  `WRD_NM` varchar(256) DEFAULT NULL COMMENT '금지단어명',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`WRD_SN`)
) DEFAULT CHARSET=utf8 COMMENT='금지단어필터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_qustnr`
--

DROP TABLE IF EXISTS `tc_qustnr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_qustnr` (
  `QUSTNR_SN` int(11) NOT NULL COMMENT '설문일련번호',
  `QUSTNR_SJ` varchar(1024) NOT NULL COMMENT '설문제목',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `QUSTNR_TRGET_CD` varchar(16) DEFAULT NULL COMMENT '설문대상코드 ',
  `RESULT_OTHBC_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '결과보기공개여부',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `TELNO` varchar(32) DEFAULT NULL COMMENT '전화번호',
  `QESTNAR_CN` text COMMENT '설문조사내용',
  `DELETE_CD` char(1) DEFAULT '0' COMMENT '삭제코드',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  PRIMARY KEY (`QUSTNR_SN`)
) DEFAULT CHARSET=utf8 COMMENT='설문조사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_qustnr_answer`
--

DROP TABLE IF EXISTS `tc_qustnr_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_qustnr_answer` (
  `ANSWER_SN` int(11) NOT NULL COMMENT '답변일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ANSWER_CN` text COMMENT '답변내용',
  `SORT_ORDR` int(11) NOT NULL DEFAULT '0' COMMENT '정렬순서',
  PRIMARY KEY (`ANSWER_SN`),
  KEY `FK_QUSTNR_ANSWER_QESITM` (`QESITM_SN`),
  CONSTRAINT `FK_QUSTNR_ANSWER_QESITM` FOREIGN KEY (`QESITM_SN`) REFERENCES `tc_qustnr_qesitm` (`QESITM_SN`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='설문답변';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_qustnr_qesitm`
--

DROP TABLE IF EXISTS `tc_qustnr_qesitm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_qustnr_qesitm` (
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `QUSTNR_SN` int(11) NOT NULL COMMENT '설문일련번호',
  `QESITM_TY_CD` char(1) NOT NULL COMMENT '문항유형코드',
  `QESITM_SJ` varchar(1024) NOT NULL COMMENT '문항제목',
  `ESSNTL_ANSWER_AT` char(1) NOT NULL DEFAULT 'N' COMMENT '필수답변여부',
  `ESSNTL_CHOISE_QY` int(11) DEFAULT '0' COMMENT '필수선택건수',
  PRIMARY KEY (`QESITM_SN`)
) DEFAULT CHARSET=utf8 COMMENT='설문항목';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_qustnr_user_answer`
--

DROP TABLE IF EXISTS `tc_qustnr_user_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_qustnr_user_answer` (
  `USER_ANSWER_SN` int(11) NOT NULL COMMENT '사용자답변일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ANSWER_SN` int(11) DEFAULT NULL COMMENT '답변일련번호',
  `USER_PIN` varchar(128) DEFAULT NULL COMMENT '사용자 개인식별번호',
  `ANSWER_CN` text COMMENT '답변내용'
) DEFAULT CHARSET=utf8 COMMENT='설문사용자답';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_qustnr_user_etc_answer`
--

DROP TABLE IF EXISTS `tc_qustnr_user_etc_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_qustnr_user_etc_answer` (
  `USER_ETC_ANSWER_SN` int(11) NOT NULL COMMENT '사용자기타의견일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ETC_ANSWER_CN` text COMMENT '답변내용',
  `ANSWER_SN` int(11) DEFAULT NULL COMMENT '답변일련번호',
  `USER_PIN` varchar(128) DEFAULT NULL COMMENT '사용자 개인식별번호'
) DEFAULT CHARSET=utf8 COMMENT='설문사용자기타의견';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_site_conect_stats`
--

DROP TABLE IF EXISTS `tc_site_conect_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_site_conect_stats` (
  `CONECT_SN` int(22) NOT NULL AUTO_INCREMENT COMMENT '접속일련번호',
  `USER_ID` varchar(64) DEFAULT '' COMMENT '사용자ID',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `USER_IPAD` varchar(64) DEFAULT NULL COMMENT '사용자IP주소',
  `USER_LOGIN_DT` varchar(64) DEFAULT NULL COMMENT '사용자로그인일시',
  `SESION_ID` varchar(256) NOT NULL COMMENT '접속구분',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `CONECT_URLAD` varchar(512) DEFAULT NULL COMMENT '접속URL주소',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `CONECT_OPERSYSM_NM` varchar(256) DEFAULT NULL COMMENT '접속운영체제명',
  `CONECT_WBSR_NM` varchar(256) DEFAULT NULL COMMENT '접속브라우저명',
  `CONECT_PC_MOBILE_SE` varchar(64) DEFAULT NULL COMMENT '접속PC모바일구분',
  `CONECT_YM` char(6) CHARACTER SET latin1 NOT NULL COMMENT '접속년월',
  `CONECT_DE` char(8) CHARACTER SET latin1 NOT NULL COMMENT '접속일자',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `BEFORE_MENU_NO` int(10) DEFAULT NULL COMMENT '이전메뉴번호',
  `RELATE_MENU_NM_LIST` varchar(4000) DEFAULT NULL COMMENT '관련메뉴명목록',
  `GHVR_SUMRY` varchar(512) DEFAULT NULL COMMENT '행동요약',
  PRIMARY KEY (`CONECT_SN`),
  KEY `I_site_conect_stats_01` (`SITE_ID`,`CONECT_DE`,`CONECT_SN`)
) AUTO_INCREMENT=32445 DEFAULT CHARSET=utf8 COMMENT='사이트접속통계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_site_guide_menu`
--

DROP TABLE IF EXISTS `tc_site_guide_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_site_guide_menu` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `MENU_SE_CD` varchar(16) NOT NULL COMMENT '메뉴구분코드',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `MENU_NM` varchar(256) NOT NULL COMMENT '메뉴명',
  `MENU_LINK` varchar(512) DEFAULT NULL COMMENT '메뉴링크',
  `MENU_ORDR` int(10) NOT NULL COMMENT '메뉴순서',
  `POPUP_AT` char(1) CHARACTER SET latin1 NOT NULL COMMENT '팝업여부',
  `USE_AT` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='사이트가이드메뉴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_site_hpcm`
--

DROP TABLE IF EXISTS `tc_site_hpcm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_site_hpcm` (
  `HPCM_NO` int(11) NOT NULL COMMENT '도움말번호',
  `HPCM_NM` varchar(256) NOT NULL COMMENT '도움말명',
  `UPPER_HPCM_NO` int(11) NOT NULL COMMENT '상위도움말번호',
  `GROUP_ID` varchar(256) DEFAULT NULL COMMENT '그룹ID',
  `SRVC_ID` varchar(256) DEFAULT NULL COMMENT '서비스ID',
  `SRVC_NM` varchar(256) DEFAULT NULL COMMENT '서비스',
  `METHOD_ID` varchar(256) DEFAULT NULL COMMENT '메소드ID',
  `HPCM_ORDR` int(11) DEFAULT NULL COMMENT '도움말순서',
  `HPCM_CN` text COMMENT '도움말내용',
  `KWRD_NM` varchar(1024) DEFAULT NULL COMMENT '키워드명',
  `ADI_INFO` text COMMENT '추가정보',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`HPCM_NO`)
) DEFAULT CHARSET=utf8 COMMENT='사이트도움말';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_site_hpcm_menu`
--

DROP TABLE IF EXISTS `tc_site_hpcm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_site_hpcm_menu` (
  `HPCM_NO` int(11) NOT NULL COMMENT '도움말번호',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  PRIMARY KEY (`HPCM_NO`,`MENU_NO`)
) DEFAULT CHARSET=utf8 COMMENT='사이트도움말메뉴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_site_info`
--

DROP TABLE IF EXISTS `tc_site_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_site_info` (
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `SITE_NM` varchar(256) NOT NULL COMMENT '사이트명',
  `SITE_DC` text COMMENT '사이트설명',
  `SITE_URLAD` varchar(512) DEFAULT NULL COMMENT '사이트URL주소',
  `SITE_IPAD` varchar(64) DEFAULT NULL COMMENT '사이트IP주소',
  `SITE_PORT_NO` varchar(32) DEFAULT NULL COMMENT '사이트포트번호',
  `SITE_ESTBS_CD` varchar(16) DEFAULT NULL COMMENT '사이트설정코드',
  `STSFDG_USE_AT` char(1) DEFAULT 'N' COMMENT '만족도사용여부',
  `DTA_MNGR_USE_AT` char(1) DEFAULT 'N' COMMENT '자료관리자사용여부',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `ACCES_IPAD` varchar(2048) DEFAULT NULL COMMENT '접근아이피주소',
  `SITE_SN` int(11) DEFAULT NULL COMMENT '사이트일련번호',
  `INSTT_NM` varchar(256) DEFAULT NULL COMMENT '기관명',
  `INSTT_NM_USE_AT` char(1) DEFAULT 'Y' COMMENT '기관명사용여부',
  `CPYRHT_CN` varchar(4000) DEFAULT NULL COMMENT '저작권내용',
  `CPYRHT_CN_USE_AT` char(1) DEFAULT 'Y' COMMENT '저작권내용사용여부',
  `ZIP` varchar(7) DEFAULT NULL COMMENT '우편번호',
  `ZIP_USE_AT` char(1) DEFAULT 'Y' COMMENT '우편번호사용여부',
  `ADRES1` varchar(256) DEFAULT NULL COMMENT '주소1',
  `ADRES1_USE_AT` char(1) DEFAULT 'Y' COMMENT '주소1사용여부',
  `ADRES2` varchar(512) DEFAULT NULL COMMENT '주소2',
  `ADRES2_USE_AT` char(1) DEFAULT 'Y' COMMENT '주소2사용여부',
  `TELNO` varchar(32) DEFAULT NULL COMMENT '전화번',
  `TELNO_USE_AT` char(1) DEFAULT 'Y' COMMENT '전화번호사용여부',
  `FAXNO` varchar(32) DEFAULT NULL COMMENT '팩스번호',
  `FAXNO_USE_AT` char(1) DEFAULT 'Y' COMMENT '팩스번호사용여부',
  `SITE_SKIN_CD` varchar(16) DEFAULT '''''' COMMENT '사이트스킨코',
  `WA_VALID_USE_AT` char(1) CHARACTER SET latin1 DEFAULT 'N' COMMENT '웹접근유효성사용여',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `WORK_BGNTM` varchar(8) DEFAULT NULL COMMENT '업무시작시간',
  `WORK_ENDTM` varchar(8) DEFAULT NULL COMMENT '업무종료시간',
  `ADT_CRTFC_USE_AT` char(1) DEFAULT 'N' COMMENT '추가인증사용여부',
  PRIMARY KEY (`SITE_ID`),
  UNIQUE KEY `SITE_ID` (`SITE_ID`),
  KEY `SYS_C0025251` (`ATCH_FILE_ID`)
) DEFAULT CHARSET=utf8 COMMENT='사이트정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_stsfdg`
--

DROP TABLE IF EXISTS `tc_stsfdg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_stsfdg` (
  `STSFDG_NO` int(11) NOT NULL COMMENT '만족도번호',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `STSFDG_IDEX` int(11) NOT NULL COMMENT '만족도지수',
  `OPINION_CN` text COMMENT '의견내용',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_IPAD` varchar(64) NOT NULL COMMENT '사용자IP주소',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`STSFDG_NO`)
) DEFAULT CHARSET=utf8 COMMENT='만족도';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_tmplat_info`
--

DROP TABLE IF EXISTS `tc_tmplat_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_tmplat_info` (
  `TMPLAT_ID` char(20) NOT NULL COMMENT '템플릿ID',
  `TMPLAT_NM` varchar(256) DEFAULT NULL COMMENT '템플릿명',
  `TMPLAT_SE_CD` char(16) DEFAULT NULL COMMENT '템플릿구분코드',
  `TMPLAT_COURS` varchar(512) DEFAULT NULL COMMENT '템플릿경로',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`TMPLAT_ID`)
) DEFAULT CHARSET=utf8 COMMENT='템플릿정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_user_author`
--

DROP TABLE IF EXISTS `tc_user_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_user_author` (
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_TY_CD` varchar(16) NOT NULL COMMENT '사용자구분코드',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  PRIMARY KEY (`USER_ID`,`USER_TY_CD`,`AUTHOR_CD`),
  KEY `FK_TC_USER_AUTHOR_AUTHOR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_USER_AUTHOR_AUTHOR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='사용자별권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_user_main_cntnts`
--

DROP TABLE IF EXISTS `tc_user_main_cntnts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_user_main_cntnts` (
  `RELM_SE_CD` varchar(2) NOT NULL COMMENT '영역구분코드',
  `MAIN_CNTNTS_CD` varchar(16) DEFAULT NULL COMMENT '메인콘텐츠코드',
  `BBS_ID` varchar(16) DEFAULT NULL COMMENT '게시판ID',
  `MENU_LINK` varchar(512) DEFAULT NULL COMMENT '메뉴링크',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `POPUP_AT` char(1) DEFAULT '1' COMMENT '팝업여부 ',
  `MENU_NO` int(11) DEFAULT NULL COMMENT '메뉴번',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부',
  PRIMARY KEY (`RELM_SE_CD`)
) DEFAULT CHARSET=utf8 COMMENT='사용자메인콘텐츠관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_uwam_site`
--

DROP TABLE IF EXISTS `tc_uwam_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_uwam_site` (
  `SITE_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '사이트일련번호',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `SITE_SE_CD` varchar(32) DEFAULT NULL COMMENT '사이트구분코드',
  `SITE_NM` varchar(256) DEFAULT NULL COMMENT '사이트명',
  `SITE_ALARM_CYCLE_CD` varchar(64) NOT NULL DEFAULT '' COMMENT '사이트경보주기코드',
  `TIME_OUT_CYCLE` varchar(10) DEFAULT NULL COMMENT '타임아웃주기',
  `ALARM_STOP_DT` datetime DEFAULT NULL COMMENT '알람정지일시',
  `SITE_TITLE_TAG_VALUE` varchar(200) DEFAULT NULL COMMENT '사이트TITLE태그값',
  `BATCH_EXECUT_AT` char(1) DEFAULT 'N' COMMENT '배치실행여부',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  PRIMARY KEY (`SITE_SN`),
  KEY `USER_SN` (`USER_SN`),
  CONSTRAINT `tc_uwam_site_ibfk_1` FOREIGN KEY (`USER_SN`) REFERENCES `tm_uwam_admin` (`USER_SN`)
) AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='uwam 관리사이트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_uwam_site_alarm_log`
--

DROP TABLE IF EXISTS `tc_uwam_site_alarm_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_uwam_site_alarm_log` (
  `ALARM_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '경보일련번호',
  `ALARM_SJ` varchar(1024) DEFAULT NULL COMMENT '경보제목',
  `ALARM_CN` text COMMENT '경보내용',
  `ALARM_URLAD` text COMMENT '경보링크주소',
  `ALARM_INFO` varchar(4000) DEFAULT NULL COMMENT '경보정보',
  `USER_SN` int(11) DEFAULT NULL COMMENT '사용자일련번호',
  PRIMARY KEY (`ALARM_SN`),
  KEY `USER_SN` (`USER_SN`),
  CONSTRAINT `tc_uwam_site_alarm_log_ibfk_1` FOREIGN KEY (`USER_SN`) REFERENCES `tm_uwam_admin` (`USER_SN`)
) AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='uwam사이트경보log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_uwam_site_url`
--

DROP TABLE IF EXISTS `tc_uwam_site_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_uwam_site_url` (
  `URL_SN` int(11) NOT NULL COMMENT 'URL일련번호',
  `SITE_SN` int(11) NOT NULL COMMENT '사이트일련번호',
  `DETAIL_URL_NM` varchar(256) DEFAULT NULL COMMENT '상세URL명',
  `CHECK_URLAD` varchar(256) DEFAULT NULL COMMENT '체크URL주소',
  `DELETE_CD` char(1) DEFAULT NULL COMMENT '삭제코드',
  PRIMARY KEY (`URL_SN`),
  KEY `SITE_SN` (`SITE_SN`),
  CONSTRAINT `tc_uwam_site_url_ibfk_1` FOREIGN KEY (`SITE_SN`) REFERENCES `tc_uwam_site` (`SITE_SN`)
) DEFAULT CHARSET=utf8 COMMENT='uwam사이트URL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_uwam_site_url_error`
--

DROP TABLE IF EXISTS `tc_uwam_site_url_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_uwam_site_url_error` (
  `LOG_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '로그일련번호',
  `URL_SN` int(11) NOT NULL COMMENT 'URL일련번호',
  `ALARM_SN` int(11) NOT NULL COMMENT '경보일련번호',
  `HTTP_RSPNS_CD` varchar(3) DEFAULT '000' COMMENT 'HTTP응답코드',
  `RSPNS_ERROR_MSSAGE` varchar(500) DEFAULT NULL COMMENT '응답에러메세지',
  `RSPNS_SUCCES_AT` char(1) DEFAULT NULL COMMENT '응답성공여부',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`LOG_SN`),
  KEY `URL_SN` (`URL_SN`),
  KEY `tc_uwam_site_url_error_ibfk_2` (`ALARM_SN`),
  CONSTRAINT `tc_uwam_site_url_error_ibfk_1` FOREIGN KEY (`URL_SN`) REFERENCES `tc_uwam_site_url` (`URL_SN`),
  CONSTRAINT `tc_uwam_site_url_error_ibfk_2` FOREIGN KEY (`ALARM_SN`) REFERENCES `tc_uwam_site_alarm_log` (`ALARM_SN`)
) AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='uwam사이트 URL에러';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_uwam_site_url_last_state`
--

DROP TABLE IF EXISTS `tc_uwam_site_url_last_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_uwam_site_url_last_state` (
  `URL_SN` int(11) NOT NULL COMMENT 'URL 일련번호',
  `RSPNS_SUCCES_AT` char(1) DEFAULT NULL COMMENT '응답성공여부',
  `LAST_UPDT_DT` datetime DEFAULT NULL COMMENT '최종수정일시',
  PRIMARY KEY (`URL_SN`),
  CONSTRAINT `tc_uwam_site_url_last_state_ibfk_1` FOREIGN KEY (`URL_SN`) REFERENCES `tc_uwam_site_url` (`URL_SN`)
) DEFAULT CHARSET=utf8 COMMENT='uwam시이트URL최종상태';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_visual`
--

DROP TABLE IF EXISTS `tc_visual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_visual` (
  `VISUAL_NO` int(11) NOT NULL COMMENT '비주얼번호',
  `VISUAL_NM` varchar(256) NOT NULL COMMENT '비주얼명',
  `VISUAL_URLAD` varchar(512) DEFAULT NULL COMMENT '비주얼URL주소',
  `VISUAL_SE` varchar(16) DEFAULT NULL COMMENT '비주얼구분',
  `SORT_ORDR` int(11) DEFAULT NULL COMMENT '정렬순서',
  `EXPSR_AT` char(1) DEFAULT NULL COMMENT '노출여부',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `SITE_ID_SE` varchar(512) DEFAULT NULL COMMENT '사이트ID구분',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`VISUAL_NO`)
) DEFAULT CHARSET=utf8 COMMENT='비주얼';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_wa_dgnss`
--

DROP TABLE IF EXISTS `tc_wa_dgnss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_wa_dgnss` (
  `SITE_ID` varchar(16) NOT NULL COMMENT '사이트ID',
  `PRSEC_YM` char(6) NOT NULL COMMENT '검사년월',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `URLAD` varchar(255) NOT NULL COMMENT 'URL주소',
  `BRWSR_SE` varchar(256) NOT NULL COMMENT '브라우저구분',
  `OPERSYSM_SE` varchar(256) DEFAULT NULL COMMENT '운영체제구분',
  `PAGE_SJ` varchar(512) DEFAULT NULL COMMENT '페이지제목',
  `ERROR_CNT` int(11) DEFAULT NULL COMMENT '에러건수',
  `WARN_CNT` int(11) DEFAULT NULL COMMENT '경고건수',
  `NRMLTY_CNT` int(11) DEFAULT NULL COMMENT '보통건수',
  `RISK_CNT` int(11) DEFAULT NULL COMMENT '위험건수',
  `SERIUS_CNT` int(11) DEFAULT NULL COMMENT '심각건수',
  `LAST_PRSEC_DT` datetime DEFAULT NULL COMMENT '마지막검사일시',
  `HLPRT_VER` varchar(64) DEFAULT NULL COMMENT '리포트버전',
  `PRSEC_CN` longtext COMMENT '검사내용',
  `ERROR_CN` longtext COMMENT '에러내용',
  PRIMARY KEY (`SITE_ID`,`PRSEC_YM`,`MENU_NO`,`URLAD`)
) DEFAULT CHARSET=utf8 COMMENT='웹접근성진';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tc_word_dicary`
--

DROP TABLE IF EXISTS `tc_word_dicary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tc_word_dicary` (
  `MNNO` int(11) NOT NULL COMMENT '관리번호',
  `WORD_SE` varchar(64) DEFAULT NULL COMMENT '용어구분',
  `WORD_NM` varchar(256) DEFAULT NULL COMMENT '용어명',
  `WORD_ENG_NM` varchar(1024) DEFAULT NULL COMMENT '용어영문명',
  `WORD_ENG_ABRV_NM` varchar(1024) DEFAULT NULL COMMENT '용어영문약어명',
  `WORD_DFN` text COMMENT '용어정의',
  `THEMA_AREA_SE` varchar(1024) DEFAULT NULL COMMENT '주제영역구분',
  `CREAT_DE` varchar(10) DEFAULT NULL COMMENT '생성일자',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`MNNO`),
  KEY `I_TC_WORD_DICARY_01` (`WORD_SE`,`WORD_ENG_ABRV_NM`(255))
) DEFAULT CHARSET=utf8 COMMENT='용어사전';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_dept_info`
--

DROP TABLE IF EXISTS `tm_dept_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_dept_info` (
  `DEPT_ID` varchar(16) NOT NULL COMMENT '부서ID',
  `DEPT_CD` varchar(32) DEFAULT NULL COMMENT '부서코드',
  `DEPT_KOR_NM` varchar(512) NOT NULL COMMENT '부서한글명',
  `DEPT_ENG_NM` varchar(512) DEFAULT NULL COMMENT '부서영문명',
  `UPPER_DEPT_ID` varchar(16) DEFAULT NULL COMMENT '상위부서코드',
  `DEPT_LEVEL` int(11) DEFAULT NULL COMMENT '부서레벨',
  `SORT_ORDR` int(11) NOT NULL COMMENT '정렬순서',
  `DEPT_JOB_CN` text COMMENT '부서업무내용',
  `DEPT_INFO` text COMMENT '부서정보',
  `DEPT_TELNO` varchar(128) DEFAULT NULL COMMENT '부서전화번호',
  `DEPT_FAXNO` varchar(128) DEFAULT NULL COMMENT '부서팩스번호',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`DEPT_ID`)
) DEFAULT CHARSET=utf8 COMMENT='부서정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_login_hist`
--

DROP TABLE IF EXISTS `tm_login_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_login_hist` (
  `HIST_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '이력번호',
  `SITE_ID` varchar(32) NOT NULL DEFAULT 'bos' COMMENT '사이트ID',
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_NM` varchar(256) NOT NULL COMMENT '사용자명',
  `USER_IPAD` varchar(64) DEFAULT NULL COMMENT '사용자IP주소',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `LOGIN_DT` datetime DEFAULT NULL COMMENT '로그인일시',
  `OVSEA_IP_AT` char(1) DEFAULT 'N' COMMENT '해외IP여부',
  `MOBILE_AT` char(1) DEFAULT 'N' COMMENT '모바일여부',
  PRIMARY KEY (`HIST_NO`),
  KEY `I_LOGIN_HIST_01` (`SITE_ID`,`LOGIN_DT`,`HIST_NO`)
) AUTO_INCREMENT=1285 DEFAULT CHARSET=utf8 COMMENT='로그인이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_mngr_author_hist`
--

DROP TABLE IF EXISTS `tm_mngr_author_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_mngr_author_hist` (
  `HIST_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '이력번호',
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `USER_CPNO` varchar(32) DEFAULT NULL COMMENT '사용자휴대전화번호',
  `USER_TELNO` varchar(32) DEFAULT NULL COMMENT '사용자전화번호',
  `USER_EMAD` varchar(512) DEFAULT NULL COMMENT '사용자이메일주소',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `STTUS_SUMRY` varchar(512) DEFAULT NULL COMMENT '상태요약',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_IPAD` varchar(64) DEFAULT NULL COMMENT '등록IP주소',
  PRIMARY KEY (`HIST_NO`),
  KEY `I_MNGR_AUTHOR_HIST_01` (`REGIST_DT`,`HIST_NO`)
) AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='관리자권한이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_mngr_info`
--

DROP TABLE IF EXISTS `tm_mngr_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_mngr_info` (
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `PASSWORD` varchar(256) NOT NULL COMMENT '비밀번호',
  `SEAT_NO` int(11) DEFAULT NULL COMMENT '좌석번호',
  `AUTHOR_CD` varchar(32) DEFAULT NULL COMMENT '권한코드',
  `USER_CPNO` varchar(32) DEFAULT NULL COMMENT '사용자휴대전화번호',
  `USER_IPAD` varchar(64) DEFAULT NULL COMMENT '사용자IP주소',
  `USER_EMAD` varchar(512) DEFAULT NULL COMMENT '사용자이메일주소',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `DELETE_CD` char(1) NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  PRIMARY KEY (`USER_ID`),
  KEY `FK_TC_AUTHOR_INFO_MNGR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_AUTHOR_INFO_MNGR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COMMENT='관리자정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_drmncy`
--

DROP TABLE IF EXISTS `tm_user_drmncy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_drmncy` (
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `PASSWORD` varchar(256) NOT NULL COMMENT '비밀번호',
  `USER_TY_CD` varchar(64) DEFAULT NULL COMMENT '사용자타입코드',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `USER_EMAD` varchar(512) DEFAULT NULL COMMENT '사용자이메일주소',
  `USER_CPNO` varchar(32) DEFAULT NULL COMMENT '사용자휴대전화번호',
  `USER_TELNO` varchar(32) DEFAULT NULL COMMENT '사용자전화번호',
  `USER_ZIP` varchar(7) DEFAULT NULL COMMENT '사용자우편번호',
  `USER_ADRES1` varchar(256) DEFAULT NULL COMMENT '사용자주소1',
  `USER_ADRES2` varchar(512) DEFAULT NULL COMMENT '사용자주소2',
  `EMAIL_RECPTN_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '이메일수신여부',
  `SMS_RECPTN_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT 'SMS수신여부',
  `ENTRPRS_NO` int(11) DEFAULT NULL COMMENT '기업체번호',
  `STTUS_CD` varchar(16) DEFAULT 'Y' COMMENT '상태코드',
  `AUTHOR_CD` varchar(32) DEFAULT NULL COMMENT '권한코드',
  `MNG_AT` char(1) CHARACTER SET latin1 DEFAULT 'N' COMMENT '관리자여부',
  `ENT_AT` char(1) CHARACTER SET latin1 DEFAULT 'N' COMMENT '승인여부',
  `SEAT_NO` int(11) DEFAULT NULL COMMENT '좌석번호',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `LAST_LOGIN_DT` datetime DEFAULT NULL COMMENT '마지막로그인일',
  `PASSWORD_CHANGE_DT` datetime DEFAULT NULL COMMENT '비밀번호경일시',
  `PASSWORD_DERIVE_DT` datetime DEFAULT NULL COMMENT '비밀번호변경유도일시',
  `STPLAT_AGRE_DT` datetime DEFAULT NULL COMMENT '약관동의일',
  `DELETE_CD` char(1) CHARACTER SET latin1 NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `DRMNCY_DT` datetime DEFAULT NULL COMMENT '휴면일시',
  PRIMARY KEY (`USER_ID`),
  KEY `I_USER_DRMNCY_01` (`DRMNCY_DT`,`USER_ID`)
) DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='사용자휴면';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_info`
--

DROP TABLE IF EXISTS `tm_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_info` (
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `PASSWORD` varchar(256) NOT NULL COMMENT '비밀번호',
  `USER_TY_CD` varchar(64) DEFAULT NULL COMMENT '사용자타입코드',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `USER_EMAD` varchar(512) DEFAULT NULL COMMENT '사용자이메일주소',
  `USER_CPNO` varchar(32) DEFAULT NULL COMMENT '사용자휴대전화번호',
  `USER_TELNO` varchar(32) DEFAULT NULL COMMENT '사용자전화번호',
  `USER_ZIP` varchar(7) DEFAULT NULL COMMENT '사용자우편번호',
  `USER_ADRES1` varchar(256) DEFAULT NULL COMMENT '사용자주소1',
  `USER_ADRES2` varchar(512) DEFAULT NULL COMMENT '사용자주소2',
  `EMAIL_RECPTN_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '이메일수신여부',
  `SMS_RECPTN_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT 'SMS수신여부',
  `ENTRPRS_NO` int(11) DEFAULT NULL COMMENT '기업체번호',
  `STTUS_CD` varchar(16) DEFAULT 'Y' COMMENT '상태코드',
  `AUTHOR_CD` varchar(32) DEFAULT NULL COMMENT '권한코드',
  `MNG_AT` char(1) CHARACTER SET latin1 DEFAULT 'N' COMMENT '관리자여부',
  `ENT_AT` char(1) CHARACTER SET latin1 DEFAULT 'N' COMMENT '승인여부',
  `SEAT_NO` int(11) DEFAULT NULL COMMENT '좌석번호',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `LAST_LOGIN_DT` datetime DEFAULT NULL COMMENT '마지막로그인일',
  `PASSWORD_CHANGE_DT` datetime DEFAULT NULL COMMENT '비밀번호경일시',
  `PASSWORD_DERIVE_DT` datetime DEFAULT NULL COMMENT '비밀번호변경유도일시',
  `STPLAT_AGRE_DT` datetime DEFAULT NULL COMMENT '약관동의일시',
  `DELETE_CD` char(1) CHARACTER SET latin1 NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `DRMNCY_NTCN_AT` char(1) DEFAULT 'N' COMMENT '휴면알림여부',
  `DRMNCY_NTCN_DT` datetime DEFAULT NULL COMMENT '휴면알림일시',
  PRIMARY KEY (`USER_ID`)
) DEFAULT CHARSET=utf8 COMMENT='사용자정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_info_prtc`
--

DROP TABLE IF EXISTS `tm_user_info_prtc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_info_prtc` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `PAGE_NO` int(11) DEFAULT NULL COMMENT '페이지번호',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `READNG_USER_ID` varchar(64) DEFAULT NULL COMMENT '열람사용자ID',
  `READNG_USER_NM` varchar(64) DEFAULT NULL COMMENT '열람사용자명',
  `READNG_DT` datetime DEFAULT NULL COMMENT '열람일시',
  `READNG_IPAD` varchar(128) DEFAULT NULL COMMENT '열람IP주소',
  `READNG_URLAD` varchar(512) DEFAULT NULL COMMENT '열람URL주소',
  `READNG_SE` varchar(64) DEFAULT 'R' COMMENT '열람구분(R:열람,P:출력,D:다운로드)',
  `READNG_PURPS_SE` varchar(64) DEFAULT NULL COMMENT '열람목적구분',
  `READNG_PURPS_RM` varchar(4000) DEFAULT NULL COMMENT '열람목적비고',
  PRIMARY KEY (`MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='사용자정보보호';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_pin`
--

DROP TABLE IF EXISTS `tm_user_pin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_pin` (
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `USER_PIN` varchar(128) NOT NULL DEFAULT '0' COMMENT '사죵자개인식별번호',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `CRTFC_SE_CD` char(2) CHARACTER SET latin1 DEFAULT NULL COMMENT '인증구분코드',
  `CHLD_CRTFC_AT` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'N' COMMENT '미성년자인증여부',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `BRTHDY` varchar(32) DEFAULT NULL COMMENT '생년월일',
  `SEX_CD` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '성별코드',
  `SITE_SE_CD` char(1) DEFAULT NULL COMMENT '회원가입타입',
  PRIMARY KEY (`USER_SN`)
) DEFAULT CHARSET=utf8 COMMENT='사용자개인식별번호';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_salt`
--

DROP TABLE IF EXISTS `tm_user_salt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_salt` (
  `USER_NO` int(11) NOT NULL COMMENT '일련번호',
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '회원명',
  `SALT` varchar(256) NOT NULL COMMENT 'SALT',
  `USER_SE` char(1) DEFAULT NULL COMMENT '회원 구분',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`USER_NO`)
) DEFAULT CHARSET=utf8 COMMENT='회원SALT정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_user_secsn`
--

DROP TABLE IF EXISTS `tm_user_secsn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_user_secsn` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `USER_SECSN_DT` datetime DEFAULT NULL COMMENT '사용자탈퇴일시',
  `USER_SECSN_MEMO` text COMMENT '사용자탈퇴메모',
  PRIMARY KEY (`MNNO`)
) DEFAULT CHARSET=utf8 COMMENT='사용자탈퇴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tm_uwam_admin`
--

DROP TABLE IF EXISTS `tm_uwam_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tm_uwam_admin` (
  `USER_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '사용자일련번호',
  `USER_NM` varchar(64) DEFAULT NULL COMMENT '사용자명',
  `SNS_ID` varchar(100) DEFAULT NULL COMMENT 'SNSID',
  `SNS_SE` varchar(10) DEFAULT NULL COMMENT 'SNS구분',
  `USER_EMAD` varchar(200) DEFAULT NULL COMMENT '사용자EMAIL주소',
  `USE_AT` varchar(1) DEFAULT NULL COMMENT '사용여부',
  `APP_TOKEN_VALUE` varchar(256) DEFAULT NULL COMMENT '앱토큰값',
  `APP_DEVICE_ID` varchar(50) DEFAULT NULL COMMENT '앱디바이스ID',
  `APP_OS` varchar(50) DEFAULT NULL COMMENT '앱OS',
  `APP_VER` varchar(20) DEFAULT NULL COMMENT '앱버전',
  `APP_MODEL_SE` varchar(50) DEFAULT NULL COMMENT '앱모델구분',
  `STATUS_AT` char(1) DEFAULT NULL COMMENT '상태여부',
  `LAST_LOGIN_DT` datetime DEFAULT NULL COMMENT '마지막로그인일시',
  `DELETE_CD` char(1) DEFAULT NULL COMMENT '삭제코드',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `CONFM_AT` char(1) DEFAULT NULL COMMENT '승인여부',
  `CONFM_DT` datetime DEFAULT NULL COMMENT '승일일시',
  `CONFM_ID` varchar(64) DEFAULT NULL COMMENT '승인ID',
  PRIMARY KEY (`USER_SN`),
  UNIQUE KEY `unp_tm_uwam_admin_1` (`SNS_ID`)
) AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='uwam 관리자';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_cmmn_file_dwld_sm`
--

DROP TABLE IF EXISTS `ts_cmmn_file_dwld_sm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_cmmn_file_dwld_sm` (
  `SM_NO` int(22) NOT NULL AUTO_INCREMENT COMMENT '집계번호',
  `SM_DE` char(8) CHARACTER SET latin1 DEFAULT NULL COMMENT '집계일자',
  `ATCH_FILE_ID` varchar(32) DEFAULT NULL COMMENT '첨부파일ID',
  `FILE_SN` int(10) DEFAULT NULL COMMENT '파일일련번호',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `DWLD_CO` int(10) DEFAULT '0' COMMENT '다운로드수',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  PRIMARY KEY (`SM_NO`)
) AUTO_INCREMENT=856 DEFAULT CHARSET=utf8 COMMENT='공통파일다운로드집계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_site_conect_stats_sm`
--

DROP TABLE IF EXISTS `ts_site_conect_stats_sm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_site_conect_stats_sm` (
  `SM_NO` int(22) NOT NULL AUTO_INCREMENT COMMENT '관리번호',
  `SM_DE` char(8) CHARACTER SET latin1 DEFAULT NULL COMMENT '접속일자',
  `SM_SE` varchar(16) DEFAULT NULL COMMENT '집계구분',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `SM_SE_VALUE` varchar(256) DEFAULT NULL COMMENT '집계구분값',
  `VISITR_CO` int(10) DEFAULT NULL COMMENT '방문자수',
  `PGE_VIEW_CO` int(10) DEFAULT NULL COMMENT '페이지뷰수',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  PRIMARY KEY (`SM_NO`)
) AUTO_INCREMENT=46871 DEFAULT CHARSET=utf8 COMMENT='사이트접속통계집계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_stsfdg_sm`
--

DROP TABLE IF EXISTS `ts_stsfdg_sm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_stsfdg_sm` (
  `SM_NO` int(22) NOT NULL AUTO_INCREMENT COMMENT '집계번호',
  `SM_DE` char(8) CHARACTER SET latin1 NOT NULL COMMENT '집계일자',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `MENU_NO` int(10) NOT NULL COMMENT '메뉴번호',
  `PRTCPNT_CO` int(10) NOT NULL COMMENT '총참여자수',
  `STSFDG_1_CO` int(10) NOT NULL DEFAULT '0' COMMENT '만족도1개수',
  `STSFDG_2_CO` int(10) NOT NULL DEFAULT '0' COMMENT '만족도2개수',
  `STSFDG_3_CO` int(10) NOT NULL DEFAULT '0' COMMENT '만족도3개수',
  `STSFDG_4_CO` int(10) NOT NULL DEFAULT '0' COMMENT '만족도4개수',
  `STSFDG_5_CO` int(10) NOT NULL DEFAULT '0' COMMENT '만족도5개수',
  PRIMARY KEY (`SM_NO`)
) AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='만족도집';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-11 12:14:36
