-- --------------------------------------------------------
-- 호스트:                          192.168.0.22
-- 서버 버전:                        5.1.72 - MySQL Community Server (GPL)
-- 서버 OS:                        unknown-linux-gnu
-- HeidiSQL 버전:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- ucms22 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `ucms22` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ucms22`;

-- 테이블 ucms22.tb_attrb_info 구조 내보내기
DROP TABLE IF EXISTS `tb_attrb_info`;
CREATE TABLE IF NOT EXISTS `tb_attrb_info` (
  `ATTRB_CD` varchar(16) NOT NULL COMMENT '속성코드',
  `ATTRB_DC` text COMMENT '속성설명',
  `ATTRB_NM` varchar(256) DEFAULT NULL COMMENT '속성명',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일',
  `TABLE_NM` varchar(256) NOT NULL COMMENT '테이블명',
  PRIMARY KEY (`ATTRB_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='속성정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tb_bbs_cm 구조 내보내기
DROP TABLE IF EXISTS `tb_bbs_cm`;
CREATE TABLE IF NOT EXISTS `tb_bbs_cm` (
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
  PRIMARY KEY (`CM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판코멘트';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tb_bbs_estn 구조 내보내기
DROP TABLE IF EXISTS `tb_bbs_estn`;
CREATE TABLE IF NOT EXISTS `tb_bbs_estn` (
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
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
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
  CONSTRAINT `FK_TB_BBS_ESTN_BBS_MASTR` FOREIGN KEY (`BBS_ID`) REFERENCES `tb_bbs_mastr` (`BBS_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판확장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tb_bbs_mastr 구조 내보내기
DROP TABLE IF EXISTS `tb_bbs_mastr`;
CREATE TABLE IF NOT EXISTS `tb_bbs_mastr` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판마스터';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tb_field_info 구조 내보내기
DROP TABLE IF EXISTS `tb_field_info`;
CREATE TABLE IF NOT EXISTS `tb_field_info` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 필드정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_author_info 구조 내보내기
DROP TABLE IF EXISTS `tc_author_info`;
CREATE TABLE IF NOT EXISTS `tc_author_info` (
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `AUTHOR_NM` varchar(256) NOT NULL COMMENT '권한명',
  `AUTHOR_DC` text COMMENT '권한설명',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`AUTHOR_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='권한정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_author_sclsrt 구조 내보내기
DROP TABLE IF EXISTS `tc_author_sclsrt`;
CREATE TABLE IF NOT EXISTS `tc_author_sclsrt` (
  `PARNTS_AUTHOR_CD` varchar(32) NOT NULL COMMENT '부모권한',
  `CHLDRN_AUTHOR_CD` varchar(32) NOT NULL COMMENT '자식권한',
  PRIMARY KEY (`PARNTS_AUTHOR_CD`,`CHLDRN_AUTHOR_CD`),
  UNIQUE KEY `PK_TC_AUTHOR_SCLSRT` (`PARNTS_AUTHOR_CD`,`CHLDRN_AUTHOR_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='권한계층';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_banner 구조 내보내기
DROP TABLE IF EXISTS `tc_banner`;
CREATE TABLE IF NOT EXISTS `tc_banner` (
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
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`BANNER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='배너';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_cd_cl 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_cd_cl`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_cd_cl` (
  `CL_CD` varchar(16) NOT NULL COMMENT '분류코드',
  `CL_CD_NM` varchar(256) DEFAULT NULL COMMENT '분류코드명',
  `CL_CD_DC` text COMMENT '분류코드설명',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`CL_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통코드분류';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_cd_ctgry 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_cd_ctgry`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_cd_ctgry` (
  `CD_ID` varchar(16) NOT NULL COMMENT '코드ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통코드카테고리';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_cd_detail 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_cd_detail`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_cd_detail` (
  `CD` varchar(16) NOT NULL COMMENT '코드',
  `CD_ID` varchar(16) NOT NULL COMMENT '코드ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통코드상세';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_cd_multi 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_cd_multi`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_cd_multi` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통코드다중';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_file 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_file`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_file` (
  `ATCH_FILE_ID` char(20) NOT NULL COMMENT '첨부파일ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `USE_AT` char(1) NOT NULL COMMENT '사용여부',
  PRIMARY KEY (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통파일';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_file_detail 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_file_detail`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_file_detail` (
  `ATCH_FILE_ID` char(20) NOT NULL COMMENT '첨부파일ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통파일상세';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_file_dwld_hist 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_file_dwld_hist`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_file_dwld_hist` (
  `MNNO` int(22) NOT NULL COMMENT '관리번',
  `ATCH_FILE_ID` char(20) CHARACTER SET latin1 NOT NULL COMMENT '첨부파일ID',
  `FILE_SN` int(10) NOT NULL COMMENT '파일일련번호',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime NOT NULL COMMENT '등록일시',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통파일다운로드이';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cmmn_sn 구조 내보내기
DROP TABLE IF EXISTS `tc_cmmn_sn`;
CREATE TABLE IF NOT EXISTS `tc_cmmn_sn` (
  `TABLE_NM` varchar(128) NOT NULL COMMENT '테이블명',
  `NEXT_SN` int(11) NOT NULL COMMENT '다음일련번호',
  PRIMARY KEY (`TABLE_NM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통일련번호';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_cntnts_manage 구조 내보내기
DROP TABLE IF EXISTS `tc_cntnts_manage`;
CREATE TABLE IF NOT EXISTS `tc_cntnts_manage` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='콘텐츠관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_global 구조 내보내기
DROP TABLE IF EXISTS `tc_global`;
CREATE TABLE IF NOT EXISTS `tc_global` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='글로벌:글로벌 변수설정하고 관리한다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_menu_author 구조 내보내기
DROP TABLE IF EXISTS `tc_menu_author`;
CREATE TABLE IF NOT EXISTS `tc_menu_author` (
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  `MAP_CREAT_ID` varchar(16) DEFAULT NULL COMMENT '맵생성ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`MENU_NO`,`AUTHOR_CD`),
  UNIQUE KEY `PK_TC_MENU_AUTHOR` (`MENU_NO`,`AUTHOR_CD`),
  KEY `FK_TC_MENU_AUTHOR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_MENU_AUTHOR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴권한';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_menu_info 구조 내보내기
DROP TABLE IF EXISTS `tc_menu_info`;
CREATE TABLE IF NOT EXISTS `tc_menu_info` (
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
  `RELATE_MENU_NM_LIST` text COMMENT '관련메뉴명목록',
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
  PRIMARY KEY (`MENU_NO`),
  KEY `IDX_TC_MENU_INFO_01` (`SITE_ID`,`DELETE_CD`,`UPPER_MENU_NO`,`MENU_ORDR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_mngr_main_estbs 구조 내보내기
DROP TABLE IF EXISTS `tc_mngr_main_estbs`;
CREATE TABLE IF NOT EXISTS `tc_mngr_main_estbs` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자메인설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_mngr_main_estbs_detail 구조 내보내기
DROP TABLE IF EXISTS `tc_mngr_main_estbs_detail`;
CREATE TABLE IF NOT EXISTS `tc_mngr_main_estbs_detail` (
  `MNNO` int(11) NOT NULL COMMENT '관리번호',
  `SN` int(11) NOT NULL COMMENT '일련번호',
  `ESTBS_NM` varchar(512) DEFAULT NULL COMMENT '설정명',
  `BBS_ID` varchar(16) DEFAULT NULL COMMENT '게시판ID',
  `URLAD` varchar(512) DEFAULT NULL COMMENT 'URL주소',
  `POPUP_AT` char(1) DEFAULT NULL COMMENT '팝업여부',
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `FILE_FIELD_NM` varchar(256) DEFAULT NULL COMMENT '파일필드명',
  `FIELD_ORDR` int(11) NOT NULL COMMENT '필드순서',
  `ICON_NM` varchar(64) DEFAULT NULL COMMENT '아이콘명',
  PRIMARY KEY (`MNNO`,`SN`),
  CONSTRAINT `FK_TC_MNGR_MAIN_ESTBS_DETAIL` FOREIGN KEY (`MNNO`) REFERENCES `tc_mngr_main_estbs` (`MNNO`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자메인설정상세';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_mngr_main_lc_estbs 구조 내보내기
DROP TABLE IF EXISTS `tc_mngr_main_lc_estbs`;
CREATE TABLE IF NOT EXISTS `tc_mngr_main_lc_estbs` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자메인위치설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_ntcn_relm 구조 내보내기
DROP TABLE IF EXISTS `tc_ntcn_relm`;
CREATE TABLE IF NOT EXISTS `tc_ntcn_relm` (
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
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `LINK_SE` char(1) DEFAULT NULL COMMENT '링크구분',
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`NTCN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='알림영역';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_popup_manage 구조 내보내기
DROP TABLE IF EXISTS `tc_popup_manage`;
CREATE TABLE IF NOT EXISTS `tc_popup_manage` (
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
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='팝업관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_prhibt_wrd_flter 구조 내보내기
DROP TABLE IF EXISTS `tc_prhibt_wrd_flter`;
CREATE TABLE IF NOT EXISTS `tc_prhibt_wrd_flter` (
  `WRD_SN` int(11) NOT NULL COMMENT '금지단어일련번호',
  `WRD_NM` varchar(256) DEFAULT NULL COMMENT '금지단어명',
  `USE_AT` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`WRD_SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='금지단어필터';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_qustnr 구조 내보내기
DROP TABLE IF EXISTS `tc_qustnr`;
CREATE TABLE IF NOT EXISTS `tc_qustnr` (
  `QUSTNR_SN` int(11) NOT NULL COMMENT '설문일련번호',
  `QUSTNR_SJ` varchar(1024) NOT NULL COMMENT '설문제목',
  `BGNDE` datetime DEFAULT NULL COMMENT '시작일',
  `ENDDE` datetime DEFAULT NULL COMMENT '종료일',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `QUSTNR_TRGET_CD` varchar(16) DEFAULT NULL COMMENT '대상코드',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문조사';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_qustnr_answer 구조 내보내기
DROP TABLE IF EXISTS `tc_qustnr_answer`;
CREATE TABLE IF NOT EXISTS `tc_qustnr_answer` (
  `ANSWER_SN` int(11) NOT NULL COMMENT '답변일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ANSWER_CN` text COMMENT '답변내용',
  `SORT_ORDR` int(11) NOT NULL DEFAULT '0' COMMENT '정렬순서',
  PRIMARY KEY (`ANSWER_SN`),
  KEY `FK_QUSTNR_ANSWER_QESITM` (`QESITM_SN`),
  CONSTRAINT `FK_QUSTNR_ANSWER_QESITM` FOREIGN KEY (`QESITM_SN`) REFERENCES `tc_qustnr_qesitm` (`QESITM_SN`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문답변';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_qustnr_qesitm 구조 내보내기
DROP TABLE IF EXISTS `tc_qustnr_qesitm`;
CREATE TABLE IF NOT EXISTS `tc_qustnr_qesitm` (
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `QUSTNR_SN` int(11) NOT NULL COMMENT '설문일련번호',
  `QESITM_TY_CD` char(1) NOT NULL COMMENT '문항유형코드',
  `QESITM_SJ` varchar(1024) NOT NULL COMMENT '문항제목',
  `ESSNTL_ANSWER_AT` char(1) NOT NULL DEFAULT 'N' COMMENT '필수답변여부',
  `ESSNTL_CHOISE_QY` int(11) DEFAULT '0' COMMENT '필수선택건수',
  PRIMARY KEY (`QESITM_SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문항목';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_qustnr_user_answer 구조 내보내기
DROP TABLE IF EXISTS `tc_qustnr_user_answer`;
CREATE TABLE IF NOT EXISTS `tc_qustnr_user_answer` (
  `USER_ANSWER_SN` int(11) NOT NULL COMMENT '사용자답변일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ANSWER_SN` int(11) DEFAULT NULL COMMENT '답변일련번호',
  `USER_PIN` varchar(128) DEFAULT NULL COMMENT '사용자 개인식별번호',
  `ANSWER_CN` text COMMENT '답변내용'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문사용자답';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_qustnr_user_etc_answer 구조 내보내기
DROP TABLE IF EXISTS `tc_qustnr_user_etc_answer`;
CREATE TABLE IF NOT EXISTS `tc_qustnr_user_etc_answer` (
  `USER_ETC_ANSWER_SN` int(11) NOT NULL COMMENT '사용자기타의견일련번호',
  `QESITM_SN` int(11) NOT NULL COMMENT '문항일련번호',
  `ETC_ANSWER_CN` text COMMENT '답변내용',
  `ANSWER_SN` int(11) DEFAULT NULL COMMENT '답변일련번호',
  `USER_PIN` varchar(128) DEFAULT NULL COMMENT '사용자 개인식별번호'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문사용자기타의견';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_site_conect_stats 구조 내보내기
DROP TABLE IF EXISTS `tc_site_conect_stats`;
CREATE TABLE IF NOT EXISTS `tc_site_conect_stats` (
  `CONECT_SN` int(22) NOT NULL AUTO_INCREMENT COMMENT '접속일련번호',
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
  PRIMARY KEY (`CONECT_SN`)
) ENGINE=InnoDB AUTO_INCREMENT=14038 DEFAULT CHARSET=utf8 COMMENT='사이트접속통계';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_site_guide_menu 구조 내보내기
DROP TABLE IF EXISTS `tc_site_guide_menu`;
CREATE TABLE IF NOT EXISTS `tc_site_guide_menu` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사이트가이드메뉴';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_site_hpcm 구조 내보내기
DROP TABLE IF EXISTS `tc_site_hpcm`;
CREATE TABLE IF NOT EXISTS `tc_site_hpcm` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사이트도움말';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_site_hpcm_menu 구조 내보내기
DROP TABLE IF EXISTS `tc_site_hpcm_menu`;
CREATE TABLE IF NOT EXISTS `tc_site_hpcm_menu` (
  `HPCM_NO` int(11) NOT NULL COMMENT '도움말번호',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  PRIMARY KEY (`HPCM_NO`,`MENU_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사이트도움말메뉴';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_site_info 구조 내보내기
DROP TABLE IF EXISTS `tc_site_info`;
CREATE TABLE IF NOT EXISTS `tc_site_info` (
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `SITE_NM` varchar(256) NOT NULL COMMENT '사이트명',
  `SITE_DC` text COMMENT '사이트설명',
  `SITE_URLAD` varchar(512) DEFAULT NULL COMMENT '사이트URL주소',
  `SITE_IPAD` varchar(64) DEFAULT NULL COMMENT '사이트IP주소',
  `SITE_PORT_NO` varchar(32) DEFAULT NULL COMMENT '사이트포트번호',
  `SITE_ESTBS_CD` varchar(16) DEFAULT NULL COMMENT '사이트설정코드',
  `STSFDG_USE_AT` char(1) DEFAULT 'N' COMMENT '만족도사용여부',
  `DTA_MNGR_USE_AT` char(1) DEFAULT 'N' COMMENT '자료관리자사용여부',
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
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
  `USE_AT` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`SITE_ID`),
  UNIQUE KEY `SITE_ID` (`SITE_ID`),
  KEY `SYS_C0025251` (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사이트정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_stsfdg 구조 내보내기
DROP TABLE IF EXISTS `tc_stsfdg`;
CREATE TABLE IF NOT EXISTS `tc_stsfdg` (
  `STSFDG_NO` int(11) NOT NULL COMMENT '만족도번호',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴번호',
  `STSFDG_IDEX` int(11) NOT NULL COMMENT '만족도지수',
  `OPINION_CN` text COMMENT '의견내용',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_IPAD` varchar(64) NOT NULL COMMENT '사용자IP주소',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`STSFDG_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='만족도';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_tmplat_info 구조 내보내기
DROP TABLE IF EXISTS `tc_tmplat_info`;
CREATE TABLE IF NOT EXISTS `tc_tmplat_info` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_user_author 구조 내보내기
DROP TABLE IF EXISTS `tc_user_author`;
CREATE TABLE IF NOT EXISTS `tc_user_author` (
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_TY_CD` varchar(16) NOT NULL COMMENT '사용자구분코드',
  `AUTHOR_CD` varchar(32) NOT NULL COMMENT '권한코드',
  PRIMARY KEY (`USER_ID`,`USER_TY_CD`,`AUTHOR_CD`),
  KEY `FK_TC_USER_AUTHOR_AUTHOR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_USER_AUTHOR_AUTHOR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자별권한';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_user_main_cntnts 구조 내보내기
DROP TABLE IF EXISTS `tc_user_main_cntnts`;
CREATE TABLE IF NOT EXISTS `tc_user_main_cntnts` (
  `RELM_SE_CD` varchar(2) NOT NULL COMMENT '영역구분코드',
  `MAIN_CNTNTS_CD` varchar(16) DEFAULT NULL COMMENT '메인콘텐츠코드',
  `BBS_ID` varchar(16) DEFAULT NULL COMMENT '게시판ID',
  `MENU_LINK` varchar(512) DEFAULT NULL COMMENT '메뉴링크',
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `REGIST_ID` varchar(64) DEFAULT NULL COMMENT '등록ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `POPUP_AT` char(1) DEFAULT '1' COMMENT '팝업여부 ',
  `MENU_NO` int(11) DEFAULT NULL COMMENT '메뉴번',
  `USE_AT` char(1) DEFAULT NULL COMMENT '사용여부',
  PRIMARY KEY (`RELM_SE_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자메인콘텐츠관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tc_word_dicary 구조 내보내기
DROP TABLE IF EXISTS `tc_word_dicary`;
CREATE TABLE IF NOT EXISTS `tc_word_dicary` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='용어사전';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_dept_info 구조 내보내기
DROP TABLE IF EXISTS `tm_dept_info`;
CREATE TABLE IF NOT EXISTS `tm_dept_info` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='부서정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_login_hist 구조 내보내기
DROP TABLE IF EXISTS `tm_login_hist`;
CREATE TABLE IF NOT EXISTS `tm_login_hist` (
  `HIST_NO` int(11) NOT NULL COMMENT '이력번호',
  `SITE_ID` varchar(32) NOT NULL DEFAULT '''''bos''''' COMMENT '사이트ID',
  `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
  `USER_IPAD` varchar(64) DEFAULT NULL COMMENT '사용자IP주소',
  `STTUS_CD` varchar(16) DEFAULT NULL COMMENT '상태코드',
  `LOGIN_DT` datetime DEFAULT NULL COMMENT '로그인일시',
  PRIMARY KEY (`HIST_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='로그인이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_mngr_info 구조 내보내기
DROP TABLE IF EXISTS `tm_mngr_info`;
CREATE TABLE IF NOT EXISTS `tm_mngr_info` (
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
  `DEPT_ID` varchar(16) NOT NULL COMMENT '부서ID',
  PRIMARY KEY (`USER_ID`),
  KEY `FK_TC_AUTHOR_INFO_MNGR_INFO` (`AUTHOR_CD`),
  CONSTRAINT `FK_TC_AUTHOR_INFO_MNGR_INFO` FOREIGN KEY (`AUTHOR_CD`) REFERENCES `tc_author_info` (`AUTHOR_CD`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_user_info 구조 내보내기
DROP TABLE IF EXISTS `tm_user_info`;
CREATE TABLE IF NOT EXISTS `tm_user_info` (
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
  `ATCH_FILE_ID` char(20) DEFAULT NULL COMMENT '첨부파일ID',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  `DEPT_ID` varchar(16) DEFAULT NULL COMMENT '부서ID',
  `LAST_LOGIN_DT` datetime DEFAULT NULL COMMENT '마지막로그인일',
  `PASSWORD_CHANGE_DT` datetime DEFAULT NULL COMMENT '비밀번호경일시',
  `STPLAT_AGRE_DT` datetime DEFAULT NULL COMMENT '약관동의일',
  `DELETE_CD` char(1) CHARACTER SET latin1 NOT NULL DEFAULT '0' COMMENT '삭제코드',
  `USE_AT` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '사용여부',
  `REGIST_ID` varchar(64) NOT NULL COMMENT '등록ID',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_ID` varchar(64) DEFAULT NULL COMMENT '수정ID',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_user_info_prtc 구조 내보내기
DROP TABLE IF EXISTS `tm_user_info_prtc`;
CREATE TABLE IF NOT EXISTS `tm_user_info_prtc` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `PAGE_NO` int(11) DEFAULT NULL COMMENT '페이지번호',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `READNG_USER_ID` varchar(64) DEFAULT NULL COMMENT '열람사용자ID',
  `READNG_DT` datetime DEFAULT NULL COMMENT '열람일시',
  `READNG_IPAD` varchar(128) DEFAULT NULL COMMENT '열람IP주소',
  `READNG_URLAD` varchar(512) DEFAULT NULL COMMENT '열람URL주소',
  `READNG_PURPS_SE` text COMMENT '열람목적구분',
  PRIMARY KEY (`MNNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자정보보호';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_user_pin 구조 내보내기
DROP TABLE IF EXISTS `tm_user_pin`;
CREATE TABLE IF NOT EXISTS `tm_user_pin` (
  `USER_SN` int(11) NOT NULL COMMENT '사용자일련번호',
  `USER_PIN` varchar(128) NOT NULL DEFAULT '0' COMMENT '사죵자개인식별번호',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `CRTFC_SE_CD` char(2) CHARACTER SET latin1 DEFAULT NULL COMMENT '인증구분코드',
  `CHLD_CRTFC_AT` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'N' COMMENT '미성년자인증여부',
  `REGIST_DT` datetime DEFAULT NULL COMMENT '등록일시',
  `UPDT_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `BRTHDY` varchar(32) DEFAULT NULL COMMENT '생년월일',
  `SEX_CD` char(1) CHARACTER SET latin1 DEFAULT NULL COMMENT '성별코드',
  PRIMARY KEY (`USER_SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자개인식별번호';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.tm_user_secsn 구조 내보내기
DROP TABLE IF EXISTS `tm_user_secsn`;
CREATE TABLE IF NOT EXISTS `tm_user_secsn` (
  `MNNO` int(22) NOT NULL COMMENT '관리번호',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '사용자ID',
  `USER_NM` varchar(256) DEFAULT NULL COMMENT '사용자명',
  `USER_SECSN_DT` datetime DEFAULT NULL COMMENT '사용자탈퇴일시',
  `USER_SECSN_MEMO` text COMMENT '사용자탈퇴메모',
  PRIMARY KEY (`MNNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자탈퇴';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.ts_cmmn_file_dwld_sm 구조 내보내기
DROP TABLE IF EXISTS `ts_cmmn_file_dwld_sm`;
CREATE TABLE IF NOT EXISTS `ts_cmmn_file_dwld_sm` (
  `SM_NO` int(22) NOT NULL AUTO_INCREMENT COMMENT '집계번호',
  `SM_DE` char(8) CHARACTER SET latin1 DEFAULT NULL COMMENT '집계일자',
  `ATCH_FILE_ID` char(20) CHARACTER SET latin1 DEFAULT NULL COMMENT '첨부파일ID',
  `FILE_SN` int(10) DEFAULT NULL COMMENT '파일일련번호',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `DWLD_CO` int(10) DEFAULT '0' COMMENT '다운로드수',
  `SITE_ID` varchar(32) DEFAULT NULL COMMENT '사이트ID',
  PRIMARY KEY (`SM_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=705 DEFAULT CHARSET=utf8 COMMENT='공통파일다운로드집계';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.ts_site_conect_stats_sm 구조 내보내기
DROP TABLE IF EXISTS `ts_site_conect_stats_sm`;
CREATE TABLE IF NOT EXISTS `ts_site_conect_stats_sm` (
  `SM_NO` int(22) NOT NULL AUTO_INCREMENT COMMENT '관리번호',
  `SM_DE` char(8) CHARACTER SET latin1 DEFAULT NULL COMMENT '접속일자',
  `SM_SE` varchar(16) DEFAULT NULL COMMENT '집계구분',
  `MENU_NO` int(10) DEFAULT NULL COMMENT '메뉴번호',
  `SM_SE_VALUE` varchar(256) DEFAULT NULL COMMENT '집계구분값',
  `VISITR_CO` int(10) DEFAULT NULL COMMENT '방문자수',
  `PGE_VIEW_CO` int(10) DEFAULT NULL COMMENT '페이지뷰수',
  `SITE_ID` varchar(32) NOT NULL COMMENT '사이트ID',
  PRIMARY KEY (`SM_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=38883 DEFAULT CHARSET=utf8 COMMENT='사이트접속통계집계';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 ucms22.ts_stsfdg_sm 구조 내보내기
DROP TABLE IF EXISTS `ts_stsfdg_sm`;
CREATE TABLE IF NOT EXISTS `ts_stsfdg_sm` (
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
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 COMMENT='만족도집';

-- 내보낼 데이터가 선택되어 있지 않습니다.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
