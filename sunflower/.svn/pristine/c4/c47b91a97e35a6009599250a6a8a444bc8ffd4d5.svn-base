--
-- Table structure for table tb_attrb_info
--

DROP TABLE IF EXISTS tb_attrb_info;
CREATE TABLE tb_attrb_info (
  ATTRB_CD varchar(16) NOT NULL,
  ATTRB_DC text,
  ATTRB_NM varchar(256) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  TABLE_NM varchar(256) NOT NULL,
  PRIMARY KEY (ATTRB_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '속성코드', 'USER', DBO, 'TABLE', tb_attrb_info, 'COLUMN', ATTRB_CD;
EXEC sp_addextendedproperty 'MS_Description', '속성설명', 'USER', DBO, 'TABLE', tb_attrb_info, 'COLUMN', ATTRB_DC;
EXEC sp_addextendedproperty 'MS_Description', '속성명', 'USER', DBO, 'TABLE', tb_attrb_info, 'COLUMN', ATTRB_NM;
EXEC sp_addextendedproperty 'MS_Description', '등록일', 'USER', DBO, 'TABLE', tb_attrb_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '테이블명', 'USER', DBO, 'TABLE', tb_attrb_info, 'COLUMN', TABLE_NM;
EXEC sp_addextendedproperty 'MS_Description', '속성정보', 'USER', DBO, 'TABLE', tb_attrb_info;


--
-- Table structure for table tb_bbs_cm
--

DROP TABLE IF EXISTS tb_bbs_cm;
CREATE TABLE tb_bbs_cm (
  CM_ID int NOT NULL,
  NTT_ID int NOT NULL,
  NTT_SJ varchar(1024) DEFAULT NULL,
  NTT_CN text,
  BBS_ID varchar(16) NOT NULL,
  NTCR_ID varchar(64) DEFAULT NULL,
  NTCR_NM varchar(128) DEFAULT NULL,
  PASSWORD varchar(256) NOT NULL,
  NTCR_EMAD varchar(512) DEFAULT NULL,
  RECOMMEND_CO int DEFAULT NULL,
  CM_SE varchar(64) NOT NULL,
  USER_SN int NOT NULL,
  OPTN1 text,
  OPTN2 text,
  OPTN3 text,
  OPTN4 text,
  OPTN5 text,
  OPTN6 text,
  OPTN7 text,
  OPTN8 text,
  OPTN9 text,
  OPTN10 text,
  EXPSR_AT char(1) NOT NULL,
  DELETE_CD char(1) DEFAULT NULL,
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (CM_ID)
);
EXEC sp_addextendedproperty 'MS_Description', '코멘트ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', CM_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시물ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTT_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시물제목', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTT_SJ;
EXEC sp_addextendedproperty 'MS_Description', '게시글내용', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTT_CN;
EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', BBS_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시자ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTCR_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시자명', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTCR_NM;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', PASSWORD;
EXEC sp_addextendedproperty 'MS_Description', '게시자이메일주소', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', NTCR_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '추천수', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', RECOMMEND_CO;
EXEC sp_addextendedproperty 'MS_Description', '코멘트구분', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', CM_SE;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '옵션1', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN1;
EXEC sp_addextendedproperty 'MS_Description', '옵션2', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN2;
EXEC sp_addextendedproperty 'MS_Description', '옵션3', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN3;
EXEC sp_addextendedproperty 'MS_Description', '옵션4', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN4;
EXEC sp_addextendedproperty 'MS_Description', '옵션5', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN5;
EXEC sp_addextendedproperty 'MS_Description', '옵션6', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN6;
EXEC sp_addextendedproperty 'MS_Description', '옵션7', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN7;
EXEC sp_addextendedproperty 'MS_Description', '옵션8', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN8;
EXEC sp_addextendedproperty 'MS_Description', '옵션9', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN9;
EXEC sp_addextendedproperty 'MS_Description', '옵션10', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', OPTN10;
EXEC sp_addextendedproperty 'MS_Description', '노출여부', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', EXPSR_AT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드(0:보임,1:사용자삭제,2:관리자삭제)', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tb_bbs_cm, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '게시판코멘트', 'USER', DBO, 'TABLE', tb_bbs_cm;

--
-- Table structure for table tb_bbs_estn
--

DROP TABLE IF EXISTS tb_bbs_estn;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE tb_bbs_estn (
  NTT_ID int NOT NULL,
  BBS_ID varchar(16) NOT NULL,
  SORT_ORDR int DEFAULT NULL,
  NTT_SJ varchar(1024) DEFAULT NULL,
  NTT_CN text,
  NTCR_ID varchar(64) DEFAULT NULL,
  NTCR_NM varchar(128) DEFAULT NULL,
  NTCR_EMAD varchar(512) DEFAULT NULL,
  NTCR_ZIP varchar(7) DEFAULT NULL,
  NTCR_ADRES1 varchar(256) DEFAULT NULL,
  NTCR_ADRES2 varchar(512) DEFAULT NULL,
  NTCR_TELNO varchar(32) DEFAULT NULL,
  NTCR_CPNO varchar(32) DEFAULT NULL,
  NTCR_PIN varchar(128) DEFAULT NULL,
  PASSWORD varchar(256) DEFAULT NULL,
  INQIRE_CO int DEFAULT NULL,
  NTCE_BGNDE varchar(10) DEFAULT NULL,
  NTCE_ENDDE varchar(10) DEFAULT NULL,
  ANSWER_AT char(1) DEFAULT NULL,
  PARNTS_NO int DEFAULT NULL,
  NTT_NO int DEFAULT NULL,
  ANSWER_LC int DEFAULT NULL,
  SECRET_AT char(1) DEFAULT NULL,
  NTT_TY_CD varchar(16) NOT NULL,
  USER_SN int DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  DEPT_NM varchar(256) DEFAULT NULL,
  HTML_AT char(1) DEFAULT 'N',
  BBS_SE_CD varchar(16) DEFAULT NULL,
  IMAGE_REPLC_TEXT_CN text,
  SITE_ID varchar(32) DEFAULT NULL,
  OPTN1 text,
  OPTN2 text,
  OPTN3 text,
  OPTN4 text,
  OPTN5 text,
  OPTN6 text,
  OPTN7 text,
  OPTN8 text,
  OPTN9 text,
  OPTN10 text,
  OPTN11 text,
  OPTN12 text,
  OPTN13 text,
  OPTN14 text,
  OPTN15 text,
  OPTN16 text,
  OPTN17 text,
  OPTN18 text,
  OPTN19 text,
  OPTN20 text,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (NTT_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '게시물ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTT_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', BBS_ID;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '게시물제목', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTT_SJ;
EXEC sp_addextendedproperty 'MS_Description', '게시글내용', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTT_CN;
EXEC sp_addextendedproperty 'MS_Description', '게시자ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시자명', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_NM;
EXEC sp_addextendedproperty 'MS_Description', '게시자이메일주소', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '게시자우편번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_ZIP;
EXEC sp_addextendedproperty 'MS_Description', '게시자주소1', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_ADRES1;
EXEC sp_addextendedproperty 'MS_Description', '게시자주소2', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_ADRES2;
EXEC sp_addextendedproperty 'MS_Description', '게시자전화번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_TELNO;
EXEC sp_addextendedproperty 'MS_Description', '게시자휴대전화번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_CPNO;
EXEC sp_addextendedproperty 'MS_Description', '게시자개인식별번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCR_PIN;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', PASSWORD;
EXEC sp_addextendedproperty 'MS_Description', '조회횟수', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', INQIRE_CO;
EXEC sp_addextendedproperty 'MS_Description', '게시시작일', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCE_BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '게시종료일', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTCE_ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '답글여부', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', ANSWER_AT;
EXEC sp_addextendedproperty 'MS_Description', '부모글번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', PARNTS_NO;
EXEC sp_addextendedproperty 'MS_Description', '게시물번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTT_NO;
EXEC sp_addextendedproperty 'MS_Description', '답글위치', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', ANSWER_LC;
EXEC sp_addextendedproperty 'MS_Description', '비밀여부', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', SECRET_AT;
EXEC sp_addextendedproperty 'MS_Description', '게시글유형코드', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', NTT_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서명', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', DEPT_NM;
EXEC sp_addextendedproperty 'MS_Description', 'HTML여부', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', HTML_AT;
EXEC sp_addextendedproperty 'MS_Description', '게시판구분코드', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', BBS_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '이미지대체텍스트내용', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', IMAGE_REPLC_TEXT_CN;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '옵션1', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN1;
EXEC sp_addextendedproperty 'MS_Description', '옵션2', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN2;
EXEC sp_addextendedproperty 'MS_Description', '옵션3', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN3;
EXEC sp_addextendedproperty 'MS_Description', '옵션4', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN4;
EXEC sp_addextendedproperty 'MS_Description', '옵션5', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN5;
EXEC sp_addextendedproperty 'MS_Description', '옵션6', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN6;
EXEC sp_addextendedproperty 'MS_Description', '옵션7', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN7;
EXEC sp_addextendedproperty 'MS_Description', '옵션8', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN8;
EXEC sp_addextendedproperty 'MS_Description', '옵션9', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN9;
EXEC sp_addextendedproperty 'MS_Description', '옵션10', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN10;
EXEC sp_addextendedproperty 'MS_Description', '옵션11', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN11;
EXEC sp_addextendedproperty 'MS_Description', '옵션12', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN12;
EXEC sp_addextendedproperty 'MS_Description', '옵션13', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN13;
EXEC sp_addextendedproperty 'MS_Description', '옵션14', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN14;
EXEC sp_addextendedproperty 'MS_Description', '옵션15', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN15;
EXEC sp_addextendedproperty 'MS_Description', '옵션16', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN16;
EXEC sp_addextendedproperty 'MS_Description', '옵션17', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN17;
EXEC sp_addextendedproperty 'MS_Description', '옵션18', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN18;
EXEC sp_addextendedproperty 'MS_Description', '옵션19', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN19;
EXEC sp_addextendedproperty 'MS_Description', '옵션20', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', OPTN20;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tb_bbs_estn, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '게시판확장', 'USER', DBO, 'TABLE', tb_bbs_estn;



--
-- Table structure for table tb_bbs_mastr
--

DROP TABLE IF EXISTS tb_bbs_mastr;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE tb_bbs_mastr (
  BBS_ID varchar(16) NOT NULL,
  BBS_TY_CD varchar(16) NOT NULL,
  BBS_ATTRB_CD varchar(16) NOT NULL,
  BBS_NM varchar(512) NOT NULL,
  BBS_DC text,
  REPLY_POSBL_AT char(1) DEFAULT NULL,
  FILE_ATCH_POSBL_AT char(1) DEFAULT NULL,
  ATCH_POSBL_FILE_CO int DEFAULT NULL,
  ATCH_POSBL_FILE_SIZE varchar(32) DEFAULT NULL,
  NTCE_BGNDE varchar(10) DEFAULT NULL,
  NTCE_ENDDE varchar(10) DEFAULT NULL,
  TMPLAT_ID char(20) DEFAULT NULL,
  CM_POSBL_AT char(1) DEFAULT NULL,
  ADIT_CNTNTS_CN text,
  PAGE_SIZE int DEFAULT NULL,
  PAGE_UNIT int DEFAULT NULL,
  PREV_NEXT_POSBL_AT char(1) DEFAULT NULL,
  TABLE_NM varchar(256) DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (BBS_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', BBS_ID;
EXEC sp_addextendedproperty 'MS_Description', '게시판유형코드', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', BBS_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '게시판속성코드', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', BBS_ATTRB_CD;
EXEC sp_addextendedproperty 'MS_Description', '게시판명', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', BBS_NM;
EXEC sp_addextendedproperty 'MS_Description', '게시판설명', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', BBS_DC;
EXEC sp_addextendedproperty 'MS_Description', '답글가능여부', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', REPLY_POSBL_AT;
EXEC sp_addextendedproperty 'MS_Description', '파일첨부가능여부', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', FILE_ATCH_POSBL_AT;
EXEC sp_addextendedproperty 'MS_Description', '첨부가능파일건수', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', ATCH_POSBL_FILE_CO;
EXEC sp_addextendedproperty 'MS_Description', '첨부가능파일사이즈', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', ATCH_POSBL_FILE_SIZE;
EXEC sp_addextendedproperty 'MS_Description', '게시시작일', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', NTCE_BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '게시종료일', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', NTCE_ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '템플릿ID', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', TMPLAT_ID;
EXEC sp_addextendedproperty 'MS_Description', '코멘트가능여부', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', CM_POSBL_AT;
EXEC sp_addextendedproperty 'MS_Description', '추가컨텐츠내용', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', ADIT_CNTNTS_CN;
EXEC sp_addextendedproperty 'MS_Description', '페이지사이즈', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', PAGE_SIZE;
EXEC sp_addextendedproperty 'MS_Description', '페이지단위', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', PAGE_UNIT;
EXEC sp_addextendedproperty 'MS_Description', '이전글다음글사용여부', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', PREV_NEXT_POSBL_AT;
EXEC sp_addextendedproperty 'MS_Description', '테이블명', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', TABLE_NM;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부(Y:사용,N:미사용)', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tb_bbs_mastr, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '게시판마스터', 'USER', DBO, 'TABLE', tb_bbs_mastr;


--
-- Table structure for table tb_field_info
--

DROP TABLE IF EXISTS tb_field_info;
CREATE TABLE tb_field_info (
  FIELD_ID int NOT NULL,
  ATTRB_CD varchar(16) NOT NULL,
  ATTRB_TY_CD varchar(16) NOT NULL,
  FIELD_IEM_NM varchar(256) NOT NULL,
  FIELD_TY_CD varchar(16) NOT NULL,
  FIELD_DC text NOT NULL,
  FIELD_ORDR int DEFAULT NULL,
  LIST_USE_AT char(1) DEFAULT 'N',
  PRIMARY KEY (FIELD_ID)
);


EXEC sp_addextendedproperty 'MS_Description', '필드ID', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', FIELD_ID;
EXEC sp_addextendedproperty 'MS_Description', '속성코드', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', ATTRB_CD;
EXEC sp_addextendedproperty 'MS_Description', '속성유형코드', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', ATTRB_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '필드항목명', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', FIELD_IEM_NM;
EXEC sp_addextendedproperty 'MS_Description', '필드유형코드', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', FIELD_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '필드설명', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', FIELD_DC;
EXEC sp_addextendedproperty 'MS_Description', '필드순서', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', FIELD_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '리스트사용여부', 'USER', DBO, 'TABLE', tb_field_info, 'COLUMN', LIST_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '게시판 필드정보', 'USER', DBO, 'TABLE', tb_field_info;


--
-- Table structure for table tc_acces_hist
--

DROP TABLE IF EXISTS tc_acces_hist;
CREATE TABLE tc_acces_hist (
  HIST_SN int NOT NULL,
  ETC_INFO varchar(256) DEFAULT NULL,
  ACCES_DT datetime DEFAULT NULL,
  ACCES_IP varchar(16) DEFAULT NULL,
  ACCES_CRUD varchar(1) DEFAULT NULL,
  ACCES_ADMIN_ID varchar(64) DEFAULT NULL,
  ACCES_URL varchar(4000) DEFAULT NULL,
  PRIMARY KEY (HIST_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '히스토리 일련번호', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', HIST_SN;
EXEC sp_addextendedproperty 'MS_Description', '기타정보(권한명 등)', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ETC_INFO;
EXEC sp_addextendedproperty 'MS_Description', '접속일시', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ACCES_DT;
EXEC sp_addextendedproperty 'MS_Description', '접속IP', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ACCES_IP;
EXEC sp_addextendedproperty 'MS_Description', '접근구분', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ACCES_CRUD;
EXEC sp_addextendedproperty 'MS_Description', '접근관리자ID', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ACCES_ADMIN_ID;
EXEC sp_addextendedproperty 'MS_Description', '접근URL', 'USER', DBO, 'TABLE', tc_acces_hist, 'COLUMN', ACCES_URL;
EXEC sp_addextendedproperty 'MS_Description', '접근히스토리 관리', 'USER', DBO, 'TABLE', tc_acces_hist;


--
-- Table structure for table tc_author_info
--

DROP TABLE IF EXISTS tc_author_info;
CREATE TABLE tc_author_info (
  AUTHOR_CD varchar(32),
  AUTHOR_NM varchar(256),
  AUTHOR_DC text,
  REGIST_DT datetime DEFAULT NULL,
  PRIMARY KEY (AUTHOR_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tc_author_info, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한명', 'USER', DBO, 'TABLE', tc_author_info, 'COLUMN', AUTHOR_NM;
EXEC sp_addextendedproperty 'MS_Description', '권한설명', 'USER', DBO, 'TABLE', tc_author_info, 'COLUMN', AUTHOR_DC;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_author_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '권한정보', 'USER', DBO, 'TABLE', tc_author_info;


--
-- Table structure for table tc_author_sclsrt
--
DROP TABLE IF EXISTS tc_author_sclsrt;
CREATE TABLE tc_author_sclsrt (
  PARNTS_AUTHOR_CD varchar(32) NOT NULL,
  CHLDRN_AUTHOR_CD varchar(32) NOT NULL,
  PRIMARY KEY (PARNTS_AUTHOR_CD,CHLDRN_AUTHOR_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '부모권한', 'USER', DBO, 'TABLE', tc_author_sclsrt, 'COLUMN', PARNTS_AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '자식권한', 'USER', DBO, 'TABLE', tc_author_sclsrt, 'COLUMN', CHLDRN_AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한계층', 'USER', DBO, 'TABLE', tc_author_sclsrt

--
-- Table structure for table tc_banner
--

DROP TABLE IF EXISTS tc_banner;
CREATE TABLE tc_banner (
  BANNER_NO int NOT NULL,
  BANNER_NM varchar(256) NOT NULL,
  BANNER_URLAD varchar(512) DEFAULT NULL,
  BANNER_SE varchar(16) DEFAULT NULL,
  DONG_CD varchar(16) DEFAULT NULL,
  SORT_ORDR int DEFAULT NULL,
  EXPSR_AT char(1) DEFAULT NULL,
  POPUP_AT char(1) DEFAULT 'N',
  DEPT_ID varchar(16) DEFAULT NULL,
  SITE_ID_SE varchar(512) DEFAULT NULL,
  SITE_ID varchar(32) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  BGNDE datetime DEFAULT NULL,
  ENDDE datetime DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (BANNER_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '배너번호', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', BANNER_NO;
EXEC sp_addextendedproperty 'MS_Description', '배너명', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', BANNER_NM ;
EXEC sp_addextendedproperty 'MS_Description', '배너URL주소', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', BANNER_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '배너구분', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', BANNER_SE;
EXEC sp_addextendedproperty 'MS_Description', '동코드', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', DONG_CD;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '노출여부', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', EXPSR_AT;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID구분', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', SITE_ID_SE;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '시작일', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '종료일', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_banner, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '배너', 'USER', DBO, 'TABLE', tc_banner;


--
-- Table structure for table tc_cmmn_cd_cl
--

DROP TABLE IF EXISTS tc_cmmn_cd_cl;
CREATE TABLE tc_cmmn_cd_cl (
  CL_CD varchar(16) NOT NULL,
  CL_CD_NM varchar(256) DEFAULT NULL,
  CL_CD_DC text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (CL_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '분류코드', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', CL_CD;
EXEC sp_addextendedproperty 'MS_Description', '분류코드명', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', CL_CD_NM;
EXEC sp_addextendedproperty 'MS_Description', '분류코드설명', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', CL_CD_DC;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '공통코드분류', 'USER', DBO, 'TABLE', tc_cmmn_cd_cl;

--
-- Table structure for table tc_cmmn_cd_ctgry
--

DROP TABLE IF EXISTS tc_cmmn_cd_ctgry;
CREATE TABLE tc_cmmn_cd_ctgry (
  CD_ID varchar(32) NOT NULL,
  CL_CD varchar(16) NOT NULL,
  CD_ID_NM varchar(256) DEFAULT NULL,
  CD_ID_ENG_NM varchar(256) DEFAULT NULL,
  CD_ID_DC text,
  CD_ID_ENG_DC text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (CD_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '코드ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CD_ID;
EXEC sp_addextendedproperty 'MS_Description', '분류코드', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CL_CD;
EXEC sp_addextendedproperty 'MS_Description', '코드ID명', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CD_ID_NM;
EXEC sp_addextendedproperty 'MS_Description', '코드ID영문명', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CD_ID_ENG_NM;
EXEC sp_addextendedproperty 'MS_Description', '코드ID설명', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CD_ID_DC;
EXEC sp_addextendedproperty 'MS_Description', '코드ID영문설명', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', CD_ID_ENG_DC;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '공통코드카테고리', 'USER', DBO, 'TABLE', tc_cmmn_cd_ctgry;


--
-- Table structure for table tc_cmmn_cd_detail
--

DROP TABLE IF EXISTS tc_cmmn_cd_detail;
CREATE TABLE tc_cmmn_cd_detail (
  CD varchar(16) NOT NULL,
  CD_ID varchar(32) NOT NULL,
  CD_NM varchar(256) DEFAULT NULL,
  CD_ENG_NM varchar(256) DEFAULT NULL,
  CD_DC text,
  CD_ENG_DC text,
  UPPER_CD varchar(16) DEFAULT '0',
  DP int DEFAULT '1',
  SORT_ORDR int DEFAULT '0',
  OPTN1 text,
  OPTN2 text,
  OPTN3 text,
  OPTN4 text,
  OPTN5 text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (CD,CD_ID)
)

EXEC sp_addextendedproperty 'MS_Description', '코드', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD;
EXEC sp_addextendedproperty 'MS_Description', '코드ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD_ID;
EXEC sp_addextendedproperty 'MS_Description', '코드명', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD_NM;
EXEC sp_addextendedproperty 'MS_Description', '코드영문명', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD_ENG_NM;
EXEC sp_addextendedproperty 'MS_Description', '코드설명', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD_DC;
EXEC sp_addextendedproperty 'MS_Description', '코드영문설명', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', CD_ENG_DC;
EXEC sp_addextendedproperty 'MS_Description', '상위코드', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', UPPER_CD;
EXEC sp_addextendedproperty 'MS_Description', '깊이', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', DP;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '옵션1', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', OPTN1;
EXEC sp_addextendedproperty 'MS_Description', '옵션2', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', OPTN2;
EXEC sp_addextendedproperty 'MS_Description', '옵션3', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', OPTN3;
EXEC sp_addextendedproperty 'MS_Description', '옵션4', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', OPTN4;
EXEC sp_addextendedproperty 'MS_Description', '옵션5', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', OPTN5;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '공통코드상세', 'USER', DBO, 'TABLE', tc_cmmn_cd_detail;


--
-- Table structure for table tc_cmmn_cd_multi
--

DROP TABLE IF EXISTS tc_cmmn_cd_multi;
CREATE TABLE tc_cmmn_cd_multi (
  CD_ID varchar(16) NOT NULL,
  PROGRM_ID varchar(32) NOT NULL,
  PROGRM_SN int NOT NULL,
  CD varchar(16) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  MEMO text,
  PRIMARY KEY (CD_ID,PROGRM_ID,PROGRM_SN,CD)
);

EXEC sp_addextendedproperty 'MS_Description', '코드ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', CD_ID;
EXEC sp_addextendedproperty 'MS_Description', '프로그램ID', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', PROGRM_ID;
EXEC sp_addextendedproperty 'MS_Description', '프로그램일련번호', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', PROGRM_SN;
EXEC sp_addextendedproperty 'MS_Description', '코드', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', CD;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '메모', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi, 'COLUMN', MEMO;
EXEC sp_addextendedproperty 'MS_Description', '공통코드다중', 'USER', DBO, 'TABLE', tc_cmmn_cd_multi;


--
-- Table structure for table tc_cmmn_file
--

DROP TABLE IF EXISTS tc_cmmn_file;
CREATE TABLE tc_cmmn_file (
  ATCH_FILE_ID varchar(32) NOT NULL,
  USE_AT char(1) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  PROGRM_ID varchar(32) DEFAULT NULL,
  OTHBC_AT char(1) DEFAULT 'Y',
  PRIMARY KEY (ATCH_FILE_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록자ID', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '프로그램ID', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', PROGRM_ID;
EXEC sp_addextendedproperty 'MS_Description', '공개여부', 'USER', DBO, 'TABLE', tc_cmmn_file, 'COLUMN', OTHBC_AT;
EXEC sp_addextendedproperty 'MS_Description', '공통파일', 'USER', DBO, 'TABLE', tc_cmmn_file;


--
-- Table structure for table tc_cmmn_file_detail
--

DROP TABLE IF EXISTS tc_cmmn_file_detail;
CREATE TABLE tc_cmmn_file_detail (
  ATCH_FILE_ID varchar(32) NOT NULL,
  FILE_SN int NOT NULL,
  FILE_STRE_COURS varchar(512) NOT NULL,
  STRE_FILE_NM varchar(256) NOT NULL,
  ORIGNL_FILE_NM varchar(256),
  FILE_EXTSN_NM varchar(128),
  FILE_SIZE int DEFAULT NULL,
  FILE_CN text,
  FILE_FIELD_NM varchar(256),
  PRIMARY KEY (ATCH_FILE_ID,FILE_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '파일일련번호', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_SN;
EXEC sp_addextendedproperty 'MS_Description', '파일저장경로', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_STRE_COURS;
EXEC sp_addextendedproperty 'MS_Description', '저장파일명', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', STRE_FILE_NM;
EXEC sp_addextendedproperty 'MS_Description', '원파일명', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', ORIGNL_FILE_NM;
EXEC sp_addextendedproperty 'MS_Description', '파일확장자명', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_EXTSN_NM;
EXEC sp_addextendedproperty 'MS_Description', '파일사이즈', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_SIZE;
EXEC sp_addextendedproperty 'MS_Description', '파일내용', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_CN;
EXEC sp_addextendedproperty 'MS_Description', '파일필드명', 'USER', DBO, 'TABLE', tc_cmmn_file_detail, 'COLUMN', FILE_FIELD_NM;
EXEC sp_addextendedproperty 'MS_Description', '공통파일상세', 'USER', DBO, 'TABLE', tc_cmmn_file_detail;


--
-- Table structure for table tc_cmmn_file_dwld_hist
--

DROP TABLE IF EXISTS tc_cmmn_file_dwld_hist;
CREATE TABLE tc_cmmn_file_dwld_hist (
  MNNO int NOT NULL,
  ATCH_FILE_ID varchar(32) NOT NULL,
  FILE_SN int NOT NULL,
  MENU_NO int DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime NOT NULL,
  SITE_ID varchar(32) DEFAULT NULL
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '파일일련번호', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', FILE_SN;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '공통파일다운로드이력', 'USER', DBO, 'TABLE', tc_cmmn_file_dwld_hist;


--
-- Table structure for table tc_cmmn_sn
--

DROP TABLE IF EXISTS tc_cmmn_sn;
CREATE TABLE tc_cmmn_sn (
  TABLE_NM varchar(128) NOT NULL,
  NEXT_SN int NOT NULL,
  PRIMARY KEY (TABLE_NM)
);

EXEC sp_addextendedproperty 'MS_Description', '테이블명', 'USER', DBO, 'TABLE', tc_cmmn_sn, 'COLUMN', TABLE_NM;
EXEC sp_addextendedproperty 'MS_Description', '다음일련번호', 'USER', DBO, 'TABLE', tc_cmmn_sn, 'COLUMN', NEXT_SN;
EXEC sp_addextendedproperty 'MS_Description', '공통일련번호', 'USER', DBO, 'TABLE', tc_cmmn_sn;

--
-- Table structure for table tc_cntnts_manage
--

DROP TABLE IF EXISTS tc_cntnts_manage;
CREATE TABLE tc_cntnts_manage (
  MENU_NO int NOT NULL,
  CNTNTS_MNNO int NOT NULL,
  CNTNTS_CN text,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (MENU_NO,CNTNTS_MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '컨텐츠관리번호', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', CNTNTS_MNNO;
EXEC sp_addextendedproperty 'MS_Description', '콘텐츠내용', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', CNTNTS_CN;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_cntnts_manage, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '콘텐츠관리', 'USER', DBO, 'TABLE', tc_cntnts_manage;

--
-- Table structure for table tc_error_log
--

DROP TABLE IF EXISTS tc_error_log;
CREATE TABLE tc_error_log (
  LOG_NO int NOT NULL,
  ERROR_SJ varchar(1024) NOT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  USER_IPAD varchar(128) NOT NULL,
  ERROR_DT datetime NOT NULL,
  ERROR_URLAD varchar(512) DEFAULT NULL,
  BEFORE_URLAD varchar(512) DEFAULT NULL,
  ERROR_CN varchar(4000) DEFAULT NULL
);

EXEC sp_addextendedproperty 'MS_Description', '로그번호', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', LOG_NO;
EXEC sp_addextendedproperty 'MS_Description', '에러제목', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', ERROR_SJ;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자IP주소', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', USER_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '에러일시', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', ERROR_DT;
EXEC sp_addextendedproperty 'MS_Description', '에러URL', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', ERROR_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '이전URL', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', BEFORE_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '에러메세지', 'USER', DBO, 'TABLE', tc_error_log, 'COLUMN', ERROR_CN;
EXEC sp_addextendedproperty 'MS_Description', '에러로그', 'USER', DBO, 'TABLE', tc_error_log;


--
-- Table structure for table tc_global
--

DROP TABLE IF EXISTS tc_global;
CREATE TABLE tc_global (
  ATTRB_SN int NOT NULL,
  ATTRB_NM varchar(256) NOT NULL,
  ATTRB_VALUE varchar(128) DEFAULT NULL,
  ATTRB_DC text,
  USE_AT char(1) DEFAULT 'Y',
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (ATTRB_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '속성일련번호', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', ATTRB_SN;
EXEC sp_addextendedproperty 'MS_Description', '속성명', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', ATTRB_NM;
EXEC sp_addextendedproperty 'MS_Description', '속성값', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', ATTRB_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '속성설명', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', ATTRB_DC;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_global, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '글로벌', 'USER', DBO, 'TABLE', tc_global;

--
-- Table structure for table tc_indvdlinfo_colct
--

DROP TABLE IF EXISTS tc_indvdlinfo_colct;
CREATE TABLE tc_indvdlinfo_colct (
  COLCT_SE varchar(64) NOT NULL,
  COLCT_MNNO int NOT NULL,
  COLCT_SJ varchar(512) DEFAULT NULL,
  COLCT_CN text,
  COLCT_MEMO varchar(4000) DEFAULT NULL,
  SITE_ID varchar(64) DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime NOT NULL,
  UPDT_ID varchar(64) NOT NULL,
  UPDT_DT datetime NOT NULL,
  PRIMARY KEY (COLCT_SE,COLCT_MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '수집구분', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', COLCT_SE;
EXEC sp_addextendedproperty 'MS_Description', '수집관리번호', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', COLCT_MNNO;
EXEC sp_addextendedproperty 'MS_Description', '수집제목', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', COLCT_SJ;
EXEC sp_addextendedproperty 'MS_Description', '수집내용', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', COLCT_CN;
EXEC sp_addextendedproperty 'MS_Description', '수집메모', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', COLCT_MEMO;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '개인정보수집', 'USER', DBO, 'TABLE', tc_indvdlinfo_colct;


--
-- Table structure for table tc_menu_author
--

DROP TABLE IF EXISTS tc_menu_author;
CREATE TABLE tc_menu_author (
  MENU_NO int NOT NULL,
  AUTHOR_CD varchar(32) NOT NULL,
  MAP_CREAT_ID varchar(16) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  PRIMARY KEY (MENU_NO,AUTHOR_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_menu_author, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tc_menu_author, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '맵생성ID', 'USER', DBO, 'TABLE', tc_menu_author, 'COLUMN', MAP_CREAT_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_menu_author, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '메뉴권한', 'USER', DBO, 'TABLE', tc_menu_author;


--
-- Table structure for table tc_menu_author_hist
--

DROP TABLE IF EXISTS tc_menu_author_hist;
CREATE TABLE tc_menu_author_hist (
  HIST_NO int NOT NULL,
  AUTHOR_CD varchar(32) NOT NULL,
  AUTHOR_NM varchar(256) NOT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_NM varchar(64) NOT NULL,
  REGIST_DT datetime NOT NULL,
  REGIST_IPAD varchar(128) DEFAULT NULL,
  AUTHOR_DTLS varchar(4000) DEFAULT NULL,
  PRIMARY KEY (HIST_NO)
)

EXEC sp_addextendedproperty 'MS_Description', '이력번호', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', HIST_NO;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한명', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', AUTHOR_NM;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록자명', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', REGIST_NM;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록IP주소', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', REGIST_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '권한내역', 'USER', DBO, 'TABLE', tc_menu_author_hist, 'COLUMN', AUTHOR_DTLS;
EXEC sp_addextendedproperty 'MS_Description', '메뉴권한이력', 'USER', DBO, 'TABLE', tc_menu_author_hist;


--
-- Table structure for table tc_menu_author_hist_detail
--

DROP TABLE IF EXISTS tc_menu_author_hist_detail;
CREATE TABLE tc_menu_author_hist_detail (
  DETAIL_NO int IDENTITY(1,1) NOT NULL,
  HIST_NO int NOT NULL,
  MENU_NO int NOT NULL,
  MENU_NM varchar(256) NOT NULL DEFAULT '',
  AUTHOR_SE varchar(4000) DEFAULT NULL,
  AUTHOR_RM varchar(4000) DEFAULT NULL,
  PRIMARY KEY (DETAIL_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '상세번호', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', DETAIL_NO;
EXEC sp_addextendedproperty 'MS_Description', '이력번호', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', HIST_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴명', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', MENU_NM;
EXEC sp_addextendedproperty 'MS_Description', '권한구분', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', AUTHOR_SE;
EXEC sp_addextendedproperty 'MS_Description', '권한비고', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail, 'COLUMN', AUTHOR_RM;
EXEC sp_addextendedproperty 'MS_Description', '메뉴권한이력상세', 'USER', DBO, 'TABLE', tc_menu_author_hist_detail;


--
-- Table structure for table tc_menu_author_user_hist
--

DROP TABLE IF EXISTS tc_menu_author_user_hist;
CREATE TABLE tc_menu_author_user_hist (
  MNNO int IDENTITY(1,1) NOT NULL,
  HIST_NO int NOT NULL,
  USER_ID varchar(64) NOT NULL,
  USER_SN int DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  PRIMARY KEY (MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_menu_author_user_hist, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '이력번호', 'USER', DBO, 'TABLE', tc_menu_author_user_hist, 'COLUMN', HIST_NO;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_menu_author_user_hist, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자순번', 'USER', DBO, 'TABLE', tc_menu_author_user_hist, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tc_menu_author_user_hist, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '메뉴권한사용자이력', 'USER', DBO, 'TABLE', tc_menu_author_user_hist;


--
-- Table structure for table tc_menu_info
--

DROP TABLE IF EXISTS tc_menu_info;
CREATE TABLE tc_menu_info (
  MENU_NO int NOT NULL,
  MENU_NM varchar(256),
  UPPER_MENU_NO int NOT NULL,
  MENU_ORDR int NOT NULL,
  MENU_DC text,
  MENU_CNTNTS_CD varchar(16) DEFAULT NULL,
  MENU_LINK varchar(512) DEFAULT NULL,
  POPUP_AT char(1) DEFAULT NULL,
  SITE_ID varchar(32) NOT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  RELATE_MENU_NM_LIST varchar(4000) DEFAULT NULL,
  RELATE_MENU_LINK_LIST text,
  ALL_MENU_COURS text,
  CNTNTS_FILE_COURS varchar(512) DEFAULT NULL,
  MENU_LC text,
  BBS_ID varchar(16) DEFAULT NULL,
  LEAF_NODE_AT char(1) DEFAULT NULL,
  KWRD_NM varchar(1024) DEFAULT NULL,
  ADI_INFO text,
  MENU_EXPSR_SE varchar(10) DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  USER_INFO_SE char(1) DEFAULT NULL,
  SCRIN_EXPSR_AT char(1) DEFAULT NULL,
  PRIMARY KEY (MENU_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴명', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_NM;
EXEC sp_addextendedproperty 'MS_Description', '상위메뉴번호', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', UPPER_MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴순서', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '메뉴설명', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_DC;
EXEC sp_addextendedproperty 'MS_Description', '메뉴콘텐츠코드', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_CNTNTS_CD;
EXEC sp_addextendedproperty 'MS_Description', '메뉴링크', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_LINK;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '관련메뉴명목록', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', RELATE_MENU_NM_LIST;
EXEC sp_addextendedproperty 'MS_Description', '관련메뉴링크목록', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', RELATE_MENU_LINK_LIST;
EXEC sp_addextendedproperty 'MS_Description', '전체메뉴경로', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', ALL_MENU_COURS;
EXEC sp_addextendedproperty 'MS_Description', '콘텐츠파일경로', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', CNTNTS_FILE_COURS;
EXEC sp_addextendedproperty 'MS_Description', '메뉴위치', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_LC;
EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', BBS_ID ;
EXEC sp_addextendedproperty 'MS_Description', '최종하위메뉴유무', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', LEAF_NODE_AT;
EXEC sp_addextendedproperty 'MS_Description', '키워드명', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', KWRD_NM;
EXEC sp_addextendedproperty 'MS_Description', '부가정보', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', ADI_INFO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴노출구분', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', MENU_EXPSR_SE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '회원정보구분', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', USER_INFO_SE;
EXEC sp_addextendedproperty 'MS_Description', '화면노출여부', 'USER', DBO, 'TABLE', tc_menu_info, 'COLUMN', SCRIN_EXPSR_AT;
EXEC sp_addextendedproperty 'MS_Description', '메뉴정보', 'USER', DBO, 'TABLE', tc_menu_info;


--
-- Table structure for table tc_mngr_main_estbs
--

DROP TABLE IF EXISTS tc_mngr_main_estbs;
CREATE TABLE tc_mngr_main_estbs (
  MNNO int NOT NULL,
  SE_CD varchar(16) NOT NULL,
  BASS_MG varchar(16) NOT NULL,
  ESTBS_CN text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  AR_MVL int DEFAULT NULL,
  AR_MNVL int DEFAULT NULL,
  HG_MVL int DEFAULT NULL,
  HG_MNVL int DEFAULT NULL,
  SIZE_UPDT_AT char(1) DEFAULT 'Y',
  PRIMARY KEY (MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '설정구분코드', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '기본크기', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', BASS_MG;
EXEC sp_addextendedproperty 'MS_Description', '설정내용', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', ESTBS_CN;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '넓이최대치', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', AR_MVL;
EXEC sp_addextendedproperty 'MS_Description', '넓이최소치', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', AR_MNVL;
EXEC sp_addextendedproperty 'MS_Description', '높이최대치', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', HG_MVL;
EXEC sp_addextendedproperty 'MS_Description', '높이최소치', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', HG_MNVL;
EXEC sp_addextendedproperty 'MS_Description', '사이즈변경여부', 'USER', DBO, 'TABLE', tc_mngr_main_estbs, 'COLUMN', SIZE_UPDT_AT;
EXEC sp_addextendedproperty 'MS_Description', '관리자메인설정', 'USER', DBO, 'TABLE', tc_mngr_main_estbs;

--
-- Table structure for table tc_mngr_main_estbs_detail
--

DROP TABLE IF EXISTS tc_mngr_main_estbs_detail;
CREATE TABLE tc_mngr_main_estbs_detail (
  MNNO int NOT NULL,
  SN int NOT NULL,
  ESTBS_NM varchar(512) DEFAULT NULL,
  BBS_ID varchar(16) DEFAULT NULL,
  URLAD varchar(512) DEFAULT NULL,
  POPUP_AT char(1) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  FILE_FIELD_NM varchar(256) DEFAULT NULL,
  FIELD_ORDR int NOT NULL,
  ICON_NM varchar(64) DEFAULT NULL,
  PRIMARY KEY (MNNO,SN)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '일련번호', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', SN;
EXEC sp_addextendedproperty 'MS_Description', '설정명', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', ESTBS_NM;
EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', BBS_ID;
EXEC sp_addextendedproperty 'MS_Description', 'URL주소', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', URLAD;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '파일필드명', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', FILE_FIELD_NM;
EXEC sp_addextendedproperty 'MS_Description', '필드순서', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', FIELD_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '아이콘명', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail, 'COLUMN', ICON_NM;
EXEC sp_addextendedproperty 'MS_Description', '관리자메인설정상세', 'USER', DBO, 'TABLE', tc_mngr_main_estbs_detail;


--
-- Table structure for table tc_mngr_main_lc_estbs
--

DROP TABLE IF EXISTS tc_mngr_main_lc_estbs;
CREATE TABLE tc_mngr_main_lc_estbs (
  SN int NOT NULL,
  MNNO int NOT NULL,
  LFT_CRDNT int NOT NULL,
  UPEND_CRDNT int NOT NULL,
  AR_VALUE int NOT NULL,
  HG_VALUE int NOT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  USER_ID varchar(64) NOT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (SN)
);

EXEC sp_addextendedproperty 'MS_Description', '일련번호', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', SN;
EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '좌측좌표', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', LFT_CRDNT;
EXEC sp_addextendedproperty 'MS_Description', '탑좌표', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', UPEND_CRDNT;
EXEC sp_addextendedproperty 'MS_Description', '넓이값', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', AR_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '높이값', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', HG_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '관리자메인위치설정', 'USER', DBO, 'TABLE', tc_mngr_main_lc_estbs;


--
-- Table structure for table tc_ntcn_relm
--

DROP TABLE IF EXISTS tc_ntcn_relm;
CREATE TABLE tc_ntcn_relm (
  NTCN_NO int NOT NULL,
  NTCN_NM varchar(256) NOT NULL,
  NTCN_URLAD varchar(512) DEFAULT NULL,
  NTCN_CN text,
  NTCN_TY_CD varchar(16) DEFAULT NULL,
  SORT_ORDR int DEFAULT NULL,
  POPUP_AT char(1) DEFAULT NULL,
  MAP_USE_AT char(1) DEFAULT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  SITE_ID_SE varchar(512) DEFAULT NULL,
  SITE_ID varchar(32) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  BGNDE datetime DEFAULT NULL,
  ENDDE datetime DEFAULT NULL,
  LINK_SE char(1) DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (NTCN_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '알림번호', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', NTCN_NO
EXEC sp_addextendedproperty 'MS_Description', '알림명', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', NTCN_NM;
EXEC sp_addextendedproperty 'MS_Description', '알림URL주소', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', NTCN_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '알림내용', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', NTCN_CN;
EXEC sp_addextendedproperty 'MS_Description', '알림유형코드', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', NTCN_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '맵사용여부', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', MAP_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID구분', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', SITE_ID_SE;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '시작일', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '종료일', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '링크구분', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', LINK_SE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_ntcn_relm, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '알림영역', 'USER', DBO, 'TABLE', tc_ntcn_relm;


--
-- Table structure for table tc_popup_manage
--

DROP TABLE IF EXISTS tc_popup_manage;
CREATE TABLE tc_popup_manage (
  POPUP_NO int NOT NULL,
  POPUP_SJ varchar(1024) NOT NULL,
  POPUP_CN text,
  BGNDE datetime DEFAULT NULL,
  ENDDE datetime DEFAULT NULL,
  AR_VALUE int DEFAULT NULL,
  HG_VALUE int DEFAULT NULL,
  LFT_CRDNT int DEFAULT NULL,
  UPEND_CRDNT int DEFAULT NULL,
  CLOSE_USE_AT char(1) DEFAULT NULL,
  SITE_ID_SE varchar(512) DEFAULT NULL,
  SITE_ID varchar(32) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  URLAD varchar(512) DEFAULT NULL,
  SCRL_USE_AT char(1) DEFAULT NULL,
  LINK_TY_CD varchar(16) DEFAULT NULL,
  MAP_CN text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (POPUP_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '팝업번호', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', POPUP_NO;
EXEC sp_addextendedproperty 'MS_Description', '팝업제목', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', POPUP_SJ;
EXEC sp_addextendedproperty 'MS_Description', '팝업내용', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', POPUP_CN;
EXEC sp_addextendedproperty 'MS_Description', '시작일', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '종료일', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '넓이값', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', AR_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '높이값', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', HG_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '좌측좌표', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', LFT_CRDNT;
EXEC sp_addextendedproperty 'MS_Description', '탑좌표', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', UPEND_CRDNT;
EXEC sp_addextendedproperty 'MS_Description', '닫기사용여부', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', CLOSE_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID구분', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', SITE_ID_SE;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '링크주소', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', URLAD;
EXEC sp_addextendedproperty 'MS_Description', '스크롤사용여부', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', SCRL_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '링크타입코드', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', LINK_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '맵내용', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', MAP_CN;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_popup_manage, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '팝업관리', 'USER', DBO, 'TABLE', tc_popup_manage;


--
-- Table structure for table tc_prhibt_wrd_dicary
--

DROP TABLE IF EXISTS tc_prhibt_wrd_dicary;
CREATE TABLE tc_prhibt_wrd_dicary (
  WRD_SN int NOT NULL,
  WRD_NM varchar(256) DEFAULT NULL,
  USE_AT char(1) DEFAULT 'Y',
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  WRD_SE char(1) NOT NULL ,
  PRIMARY KEY (WRD_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '금지단어일련번호', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', WRD_SN;
EXEC sp_addextendedproperty 'MS_Description', '금지단어명', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', WRD_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '금지단어구분', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary, 'COLUMN', WRD_SE;
EXEC sp_addextendedproperty 'MS_Description', '금지단어사전', 'USER', DBO, 'TABLE', tc_prhibt_wrd_dicary;


--
-- Table structure for table tc_prhibt_wrd_flter
--

DROP TABLE IF EXISTS tc_prhibt_wrd_flter;
CREATE TABLE tc_prhibt_wrd_flter (
  WRD_SN int NOT NULL,
  WRD_NM varchar(256) DEFAULT NULL ,
  USE_AT char(1) DEFAULT 'Y' ,
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (WRD_SN)
);


EXEC sp_addextendedproperty 'MS_Description', '금지단어일련번호', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', WRD_SN;
EXEC sp_addextendedproperty 'MS_Description', '금지단어명', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', WRD_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '금지단어필터', 'USER', DBO, 'TABLE', tc_prhibt_wrd_flter;


--
-- Table structure for table tc_qustnr
--

DROP TABLE IF EXISTS tc_qustnr;
CREATE TABLE tc_qustnr (
  QUSTNR_SN int NOT NULL,
  QUSTNR_SJ varchar(1024) NOT NULL,
  BGNDE datetime DEFAULT NULL,
  ENDDE datetime DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT NULL,
  QUSTNR_TRGET_CD varchar(16) DEFAULT NULL,
  RESULT_OTHBC_AT char(1) NOT NULL DEFAULT 'Y',
  DEPT_ID varchar(16) DEFAULT NULL,
  TELNO varchar(32) DEFAULT NULL,
  QESTNAR_CN text,
  DELETE_CD char(1) DEFAULT '0',
  REGIST_DT datetime DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  UPDT_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  PRIMARY KEY (QUSTNR_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '설문일련번호', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', QUSTNR_SN;
EXEC sp_addextendedproperty 'MS_Description', '설문제목', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', QUSTNR_SJ;
EXEC sp_addextendedproperty 'MS_Description', '시작일', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '종료일', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '설문대상코드', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', QUSTNR_TRGET_CD;
EXEC sp_addextendedproperty 'MS_Description', '결과보기공개여부', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', RESULT_OTHBC_AT;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '전화번호', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', TELNO;
EXEC sp_addextendedproperty 'MS_Description', '설문조사내용', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', QESTNAR_CN;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_qustnr, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '설문조사', 'USER', DBO, 'TABLE', tc_qustnr;



--
-- Table structure for table tc_qustnr_answer
--

DROP TABLE IF EXISTS tc_qustnr_answer;
CREATE TABLE tc_qustnr_answer (
  ANSWER_SN int NOT NULL,
  QESITM_SN int NOT NULL,
  ANSWER_CN text,
  SORT_ORDR int NOT NULL DEFAULT '0',
  PRIMARY KEY (ANSWER_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '답변일련번호', 'USER', DBO, 'TABLE', tc_qustnr_answer, 'COLUMN', ANSWER_SN;
EXEC sp_addextendedproperty 'MS_Description', '문항일련번호', 'USER', DBO, 'TABLE', tc_qustnr_answer, 'COLUMN', QESITM_SN;
EXEC sp_addextendedproperty 'MS_Description', '답변내용', 'USER', DBO, 'TABLE', tc_qustnr_answer, 'COLUMN', ANSWER_CN;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tc_qustnr_answer, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '설문답변', 'USER', DBO, 'TABLE', tc_qustnr_answer;


--
-- Table structure for table tc_qustnr_qesitm
--

DROP TABLE IF EXISTS tc_qustnr_qesitm;
CREATE TABLE tc_qustnr_qesitm (
  QESITM_SN int NOT NULL,
  QUSTNR_SN int NOT NULL,
  QESITM_TY_CD char(1) NOT NULL,
  QESITM_SJ varchar(1024) NOT NULL,
  ESSNTL_ANSWER_AT char(1) NOT NULL DEFAULT 'N',
  ESSNTL_CHOISE_QY int DEFAULT '0',
  PRIMARY KEY (QESITM_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '문항일련번호', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', QESITM_SN;
EXEC sp_addextendedproperty 'MS_Description', '설문일련번호', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', QUSTNR_SN;
EXEC sp_addextendedproperty 'MS_Description', '문항유형코드', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', QESITM_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '문항제목', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', QESITM_SJ;
EXEC sp_addextendedproperty 'MS_Description', '필수답변여부', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', ESSNTL_ANSWER_AT;
EXEC sp_addextendedproperty 'MS_Description', '필수선택건수', 'USER', DBO, 'TABLE', tc_qustnr_qesitm, 'COLUMN', ESSNTL_CHOISE_QY;
EXEC sp_addextendedproperty 'MS_Description', '설문항목', 'USER', DBO, 'TABLE', tc_qustnr_qesitm;


--
-- Table structure for table tc_qustnr_user_answer
--

DROP TABLE IF EXISTS tc_qustnr_user_answer;
CREATE TABLE tc_qustnr_user_answer (
  USER_ANSWER_SN int NOT NULL,
  QESITM_SN int NOT NULL,
  ANSWER_SN int DEFAULT NULL,
  USER_PIN varchar(128) DEFAULT NULL,
  ANSWER_CN text
);

EXEC sp_addextendedproperty 'MS_Description', '사용자답변일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_answer, 'COLUMN', USER_ANSWER_SN;
EXEC sp_addextendedproperty 'MS_Description', '문항일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_answer, 'COLUMN', QESITM_SN;
EXEC sp_addextendedproperty 'MS_Description', '답변일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_answer, 'COLUMN', ANSWER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자 개인식별번호', 'USER', DBO, 'TABLE', tc_qustnr_user_answer, 'COLUMN', USER_PIN;
EXEC sp_addextendedproperty 'MS_Description', '답변내용', 'USER', DBO, 'TABLE', tc_qustnr_user_answer, 'COLUMN', ANSWER_CN;
EXEC sp_addextendedproperty 'MS_Description', '설문사용자답', 'USER', DBO, 'TABLE', tc_qustnr_user_answer;


--
-- Table structure for table tc_qustnr_user_etc_answer
--

DROP TABLE IF EXISTS tc_qustnr_user_etc_answer;
CREATE TABLE tc_qustnr_user_etc_answer (
  USER_ETC_ANSWER_SN int NOT NULL,
  QESITM_SN int NOT NULL,
  ETC_ANSWER_CN text,
  ANSWER_SN int DEFAULT NULL,
  USER_PIN varchar(128) DEFAULT NULL
);

EXEC sp_addextendedproperty 'MS_Description', '사용자기타의견일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer, 'COLUMN', USER_ETC_ANSWER_SN;
EXEC sp_addextendedproperty 'MS_Description', '문항일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer, 'COLUMN', QESITM_SN;
EXEC sp_addextendedproperty 'MS_Description', '답변내용', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer, 'COLUMN', ETC_ANSWER_CN;
EXEC sp_addextendedproperty 'MS_Description', '답변일련번호', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer, 'COLUMN', ANSWER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자 개인식별번호', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer, 'COLUMN', USER_PIN;
EXEC sp_addextendedproperty 'MS_Description', '설문사용자기타의견', 'USER', DBO, 'TABLE', tc_qustnr_user_etc_answer;


--
-- Table structure for table tc_site_conect_stats
--

DROP TABLE IF EXISTS tc_site_conect_stats;
CREATE TABLE tc_site_conect_stats (
  CONECT_SN int IDENTITY(1,1) NOT NULL,
  USER_ID varchar(64) DEFAULT '',
  USER_NM varchar(256) DEFAULT NULL,
  USER_IPAD varchar(64) DEFAULT NULL,
  USER_LOGIN_DT varchar(64) DEFAULT NULL,
  SESION_ID varchar(256) NOT NULL,
  SITE_ID varchar(32) NOT NULL,
  CONECT_URLAD varchar(512) DEFAULT NULL,
  MENU_NO int DEFAULT NULL,
  CONECT_OPERSYSM_NM varchar(256) DEFAULT NULL,
  CONECT_WBSR_NM varchar(256) DEFAULT NULL,
  CONECT_PC_MOBILE_SE varchar(64) DEFAULT NULL,
  CONECT_YM char(6) NOT NULL,
  CONECT_DE char(8) NOT NULL,
  REGIST_DT datetime NOT NULL,
  BEFORE_MENU_NO int DEFAULT NULL,
  RELATE_MENU_NM_LIST varchar(4000) DEFAULT NULL,
  GHVR_SUMRY varchar(512) DEFAULT NULL,
  PRIMARY KEY (CONECT_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '접속일련번호', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_SN
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용자IP주소', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', USER_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '사용자로그인일시', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', USER_LOGIN_DT;
EXEC sp_addextendedproperty 'MS_Description', '접속구분', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', SESION_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '접속URL주소', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '접속운영체제명', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_OPERSYSM_NM;
EXEC sp_addextendedproperty 'MS_Description', '접속브라우저명', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_WBSR_NM;
EXEC sp_addextendedproperty 'MS_Description', '접속PC모바일구분', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_PC_MOBILE_SE;
EXEC sp_addextendedproperty 'MS_Description', '접속년월', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_YM;
EXEC sp_addextendedproperty 'MS_Description', '접속일자', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', CONECT_DE;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '이전메뉴번호', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', BEFORE_MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '관련메뉴명목록', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', RELATE_MENU_NM_LIST;
EXEC sp_addextendedproperty 'MS_Description', '행동요약', 'USER', DBO, 'TABLE', tc_site_conect_stats, 'COLUMN', GHVR_SUMRY;
EXEC sp_addextendedproperty 'MS_Description', '사이트접속통계', 'USER', DBO, 'TABLE', tc_site_conect_stats;


--
-- Table structure for table tc_site_guide_menu
--

DROP TABLE IF EXISTS tc_site_guide_menu;
CREATE TABLE tc_site_guide_menu (
  MNNO int NOT NULL,
  SITE_ID varchar(32) NOT NULL,
  MENU_SE_CD varchar(16) NOT NULL,
  MENU_NO int DEFAULT NULL,
  MENU_NM varchar(256) NOT NULL,
  MENU_LINK varchar(512) DEFAULT NULL,
  MENU_ORDR int NOT NULL,
  POPUP_AT char(1) NOT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime NOT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '메뉴구분코드', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MENU_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴명', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MENU_NM;
EXEC sp_addextendedproperty 'MS_Description', '메뉴링크', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MENU_LINK;
EXEC sp_addextendedproperty 'MS_Description', '메뉴순서', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', MENU_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_site_guide_menu, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '사이트가이드메뉴', 'USER', DBO, 'TABLE', tc_site_guide_menu;


--
-- Table structure for table tc_site_hpcm
--

DROP TABLE IF EXISTS tc_site_hpcm;
CREATE TABLE tc_site_hpcm (
  HPCM_NO int NOT NULL,
  HPCM_NM varchar(256) NOT NULL,
  UPPER_HPCM_NO int NOT NULL,
  GROUP_ID varchar(256) DEFAULT NULL,
  SRVC_ID varchar(256) DEFAULT NULL,
  SRVC_NM varchar(256) DEFAULT NULL,
  METHOD_ID varchar(256) DEFAULT NULL,
  HPCM_ORDR int DEFAULT NULL,
  HPCM_CN text,
  KWRD_NM varchar(1024) DEFAULT NULL,
  ADI_INFO text,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime NOT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (HPCM_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '도움말번호', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', HPCM_NO;
EXEC sp_addextendedproperty 'MS_Description', '도움말명', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', HPCM_NM;
EXEC sp_addextendedproperty 'MS_Description', '상위도움말번호', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', UPPER_HPCM_NO;
EXEC sp_addextendedproperty 'MS_Description', '그룹ID', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', GROUP_ID;
EXEC sp_addextendedproperty 'MS_Description', '서비스ID', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', SRVC_ID;
EXEC sp_addextendedproperty 'MS_Description', '서비스', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', SRVC_NM;
EXEC sp_addextendedproperty 'MS_Description', '메소드ID', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', METHOD_ID;
EXEC sp_addextendedproperty 'MS_Description', '도움말순서', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', HPCM_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '도움말내용', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', HPCM_CN;
EXEC sp_addextendedproperty 'MS_Description', '키워드명', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', KWRD_NM;
EXEC sp_addextendedproperty 'MS_Description', '추가정보', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', ADI_INFO;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_site_hpcm, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '사이트도움말', 'USER', DBO, 'TABLE', tc_site_hpcm;


--
-- Table structure for table tc_site_hpcm_menu
--

DROP TABLE IF EXISTS tc_site_hpcm_menu;
CREATE TABLE tc_site_hpcm_menu (
  HPCM_NO int NOT NULL,
  MENU_NO int NOT NULL,
  PRIMARY KEY (HPCM_NO,MENU_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '도움말번호', 'USER', DBO, 'TABLE', tc_site_hpcm_menu, 'COLUMN', HPCM_NO;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_site_hpcm_menu, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '사이트도움말메뉴', 'USER', DBO, 'TABLE', tc_site_hpcm_menu;


--
-- Table structure for table tc_site_info
--

DROP TABLE IF EXISTS tc_site_info;
CREATE TABLE tc_site_info (
  SITE_ID varchar(32) UNIQUE NOT NULL,
  SITE_NM varchar(256) NOT NULL,
  SITE_DC text,
  SITE_URLAD varchar(512) DEFAULT NULL,
  SITE_IPAD varchar(64) DEFAULT NULL,
  SITE_PORT_NO varchar(32) DEFAULT NULL,
  SITE_ESTBS_CD varchar(16) DEFAULT NULL,
  STSFDG_USE_AT char(1) DEFAULT 'N',
  DTA_MNGR_USE_AT char(1) DEFAULT 'N',
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  ACCES_IPAD varchar(2048) DEFAULT NULL,
  SITE_SN int DEFAULT NULL,
  INSTT_NM varchar(256) DEFAULT NULL,
  INSTT_NM_USE_AT char(1) DEFAULT 'Y',
  CPYRHT_CN varchar(4000) DEFAULT NULL,
  CPYRHT_CN_USE_AT char(1) DEFAULT 'Y',
  ZIP varchar(7) DEFAULT NULL,
  ZIP_USE_AT char(1) DEFAULT 'Y',
  ADRES1 varchar(256) DEFAULT NULL,
  ADRES1_USE_AT char(1) DEFAULT 'Y',
  ADRES2 varchar(512) DEFAULT NULL,
  ADRES2_USE_AT char(1) DEFAULT 'Y',
  TELNO varchar(32) DEFAULT NULL,
  TELNO_USE_AT char(1) DEFAULT 'Y',
  FAXNO varchar(32) DEFAULT NULL,
  FAXNO_USE_AT char(1) DEFAULT 'Y',
  SITE_SKIN_CD varchar(16) DEFAULT '''''',
  WA_VALID_USE_AT char(1),
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  WORK_BGNTM varchar(8) DEFAULT NULL,
  WORK_ENDTM varchar(8) DEFAULT NULL,
  ADT_CRTFC_USE_AT char(1) DEFAULT 'N',
  PRIMARY KEY (SITE_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트명', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_NM;
EXEC sp_addextendedproperty 'MS_Description', '사이트설명', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_DC;
EXEC sp_addextendedproperty 'MS_Description', '사이트URL주소', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '사이트IP주소', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '사이트포트번호', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_PORT_NO;
EXEC sp_addextendedproperty 'MS_Description', '사이트설정코드', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_ESTBS_CD;
EXEC sp_addextendedproperty 'MS_Description', '만족도사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', STSFDG_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '자료관리자사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', DTA_MNGR_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '접근아이피주소', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ACCES_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '사이트일련번호', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_SN;
EXEC sp_addextendedproperty 'MS_Description', '기관명', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', INSTT_NM;
EXEC sp_addextendedproperty 'MS_Description', '기관명사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', INSTT_NM_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '저작권내용', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', CPYRHT_CN;
EXEC sp_addextendedproperty 'MS_Description', '저작권내용사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', CPYRHT_CN_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '우편번호', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ZIP;
EXEC sp_addextendedproperty 'MS_Description', '우편번호사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ZIP_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '주소1', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ADRES1;
EXEC sp_addextendedproperty 'MS_Description', '주소1사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ADRES1_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '주소2', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ADRES2;
EXEC sp_addextendedproperty 'MS_Description', '주소2사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ADRES2_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '전화번호', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', TELNO;
EXEC sp_addextendedproperty 'MS_Description', '전화번호사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', TELNO_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '팩스번호', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', FAXNO;
EXEC sp_addextendedproperty 'MS_Description', '팩스번호사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', FAXNO_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사이트스킨코드', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', SITE_SKIN_CD;
EXEC sp_addextendedproperty 'MS_Description', '웹접근유효성사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', WA_VALID_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '업무시작시간', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', WORK_BGNTM;
EXEC sp_addextendedproperty 'MS_Description', '업무종료시간', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', WORK_ENDTM;
EXEC sp_addextendedproperty 'MS_Description', '추가인증사용여부', 'USER', DBO, 'TABLE', tc_site_info, 'COLUMN', ADT_CRTFC_USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사이트정보', 'USER', DBO, 'TABLE', tc_site_info;


--
-- Table structure for table tc_stsfdg
--

DROP TABLE IF EXISTS tc_stsfdg;
CREATE TABLE tc_stsfdg (
  STSFDG_NO int NOT NULL,
  SITE_ID varchar(32) NOT NULL,
  MENU_NO int NOT NULL,
  STSFDG_IDEX int NOT NULL,
  OPINION_CN text,
  USER_ID varchar(64) DEFAULT NULL,
  USER_IPAD varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  PRIMARY KEY (STSFDG_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '만족도번호', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', STSFDG_NO;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '만족도지수', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', STSFDG_IDEX;
EXEC sp_addextendedproperty 'MS_Description', '의견내용', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', OPINION_CN;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자IP주소', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', USER_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_stsfdg, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '만족도', 'USER', DBO, 'TABLE', tc_stsfdg;



--
-- Table structure for table tc_tmplat_info
--

DROP TABLE IF EXISTS tc_tmplat_info;
CREATE TABLE tc_tmplat_info (
  TMPLAT_ID char(20) NOT NULL,
  TMPLAT_NM varchar(256) DEFAULT NULL,
  TMPLAT_SE_CD char(16) DEFAULT NULL,
  TMPLAT_COURS varchar(512) DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (TMPLAT_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '템플릿ID', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', TMPLAT_ID;
EXEC sp_addextendedproperty 'MS_Description', '템플릿명', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', TMPLAT_NM;
EXEC sp_addextendedproperty 'MS_Description', '템플릿구분코드', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', TMPLAT_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '템플릿경로', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', TMPLAT_COURS;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_tmplat_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '템플릿정보', 'USER', DBO, 'TABLE', tc_tmplat_info;


--
-- Table structure for table tc_user_author
--

DROP TABLE IF EXISTS tc_user_author;
CREATE TABLE tc_user_author (
  USER_ID varchar(64) NOT NULL,
  USER_TY_CD varchar(16) NOT NULL,
  AUTHOR_CD varchar(32) NOT NULL,
  PRIMARY KEY (USER_ID,USER_TY_CD,AUTHOR_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tc_user_author, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자구분코드', 'USER', DBO, 'TABLE', tc_user_author, 'COLUMN', USER_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tc_user_author, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자별권한', 'USER', DBO, 'TABLE', tc_user_author;


--
-- Table structure for table tc_user_main_cntnts
--

DROP TABLE IF EXISTS tc_user_main_cntnts;
CREATE TABLE tc_user_main_cntnts (
  RELM_SE_CD varchar(2) NOT NULL,
  MAIN_CNTNTS_CD varchar(16) DEFAULT NULL,
  BBS_ID varchar(16) DEFAULT NULL,
  MENU_LINK varchar(512) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  POPUP_AT char(1) DEFAULT '1',
  MENU_NO int DEFAULT NULL,
  USE_AT char(1) DEFAULT NULL,
  PRIMARY KEY (RELM_SE_CD)
);

EXEC sp_addextendedproperty 'MS_Description', '영역구분코드', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', RELM_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '메인콘텐츠코드', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', MAIN_CNTNTS_CD;
EXEC sp_addextendedproperty 'MS_Description', '게시판ID', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', BBS_ID;
EXEC sp_addextendedproperty 'MS_Description', '메뉴링크', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', MENU_LINK;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '팝업여부', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', POPUP_AT;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_user_main_cntnts, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '사용자메인콘텐츠관리', 'USER', DBO, 'TABLE', tc_user_main_cntnts;


--
-- Table structure for table tc_uwam_site
--

DROP TABLE IF EXISTS tc_uwam_site;
CREATE TABLE tc_uwam_site (
  SITE_SN int IDENTITY(3,1) NOT NULL,
  USER_SN int NOT NULL,
  SITE_SE_CD varchar(32) DEFAULT NULL,
  SITE_NM varchar(256) DEFAULT NULL,
  SITE_ALARM_CYCLE_CD varchar(64) NOT NULL DEFAULT '',
  TIME_OUT_CYCLE varchar(10) DEFAULT NULL,
  ALARM_STOP_DT datetime DEFAULT NULL,
  SITE_TITLE_TAG_VALUE varchar(200) DEFAULT NULL,
  BATCH_EXECUT_AT char(1) DEFAULT 'N',
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (SITE_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '사이트일련번호', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', SITE_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사이트구분코드', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', SITE_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사이트명', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', SITE_NM;
EXEC sp_addextendedproperty 'MS_Description', '사이트경보주기코드', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', SITE_ALARM_CYCLE_CD;
EXEC sp_addextendedproperty 'MS_Description', '타임아웃주기', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', TIME_OUT_CYCLE;
EXEC sp_addextendedproperty 'MS_Description', '알람정지일시', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', ALARM_STOP_DT;
EXEC sp_addextendedproperty 'MS_Description', '사이트TITLE태그값', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', SITE_TITLE_TAG_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '배치실행여부', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', BATCH_EXECUT_AT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_uwam_site, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', 'uwam 관리사이트', 'USER', DBO, 'TABLE', tc_uwam_site;

--
-- Table structure for table tc_uwam_site_alarm_log
--

DROP TABLE IF EXISTS tc_uwam_site_alarm_log;
CREATE TABLE tc_uwam_site_alarm_log (
  ALARM_SN int IDENTITY(1,1) NOT NULL,
  ALARM_SJ varchar(1024) DEFAULT NULL,
  ALARM_CN text,
  ALARM_URLAD text,
  ALARM_INFO varchar(4000) DEFAULT NULL,
  USER_SN int DEFAULT NULL,
  PRIMARY KEY (ALARM_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '경보일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', ALARM_SN;
EXEC sp_addextendedproperty 'MS_Description', '경보제목', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', ALARM_SJ;
EXEC sp_addextendedproperty 'MS_Description', '경보내용', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', ALARM_CN;
EXEC sp_addextendedproperty 'MS_Description', '경보링크주소', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', ALARM_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '경보정보', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', ALARM_INFO;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', 'uwam사이트경보log', 'USER', DBO, 'TABLE', tc_uwam_site_alarm_log;


--
-- Table structure for table tc_uwam_site_url
--

DROP TABLE IF EXISTS tc_uwam_site_url;
CREATE TABLE tc_uwam_site_url (
  URL_SN int NOT NULL,
  SITE_SN int NOT NULL,
  DETAIL_URL_NM varchar(256) DEFAULT NULL,
  CHECK_URLAD varchar(256) DEFAULT NULL,
  DELETE_CD char(1) DEFAULT NULL,
  PRIMARY KEY (URL_SN)
);

EXEC sp_addextendedproperty 'MS_Description', 'URL일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url, 'COLUMN', URL_SN;
EXEC sp_addextendedproperty 'MS_Description', '사이트일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url, 'COLUMN', SITE_SN;
EXEC sp_addextendedproperty 'MS_Description', '상세URL명', 'USER', DBO, 'TABLE', tc_uwam_site_url, 'COLUMN', DETAIL_URL_NM;
EXEC sp_addextendedproperty 'MS_Description', '체크URL주소', 'USER', DBO, 'TABLE', tc_uwam_site_url, 'COLUMN', CHECK_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tc_uwam_site_url, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', 'uwam사이트URL', 'USER', DBO, 'TABLE', tc_uwam_site_url;


--
-- Table structure for table tc_uwam_site_url_error
--

DROP TABLE IF EXISTS tc_uwam_site_url_error;
CREATE TABLE tc_uwam_site_url_error (
  LOG_SN int IDENTITY(1,1) NOT NULL,
  URL_SN int NOT NULL,
  ALARM_SN int NOT NULL,
  HTTP_RSPNS_CD varchar(3) DEFAULT '000',
  RSPNS_ERROR_MSSAGE varchar(500) DEFAULT NULL,
  RSPNS_SUCCES_AT char(1) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  PRIMARY KEY (LOG_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '로그일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', LOG_SN;
EXEC sp_addextendedproperty 'MS_Description', 'URL일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', URL_SN;
EXEC sp_addextendedproperty 'MS_Description', '경보일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', ALARM_SN;
EXEC sp_addextendedproperty 'MS_Description', 'HTTP응답코드', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', HTTP_RSPNS_CD;
EXEC sp_addextendedproperty 'MS_Description', '응답에러메세지', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', RSPNS_ERROR_MSSAGE;
EXEC sp_addextendedproperty 'MS_Description', '응답성공여부', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', RSPNS_SUCCES_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_uwam_site_url_error, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', 'uwam사이트 URL에러', 'USER', DBO, 'TABLE', tc_uwam_site_url_error;


--
-- Table structure for table tc_uwam_site_url_last_state
--

DROP TABLE IF EXISTS tc_uwam_site_url_last_state;
CREATE TABLE tc_uwam_site_url_last_state (
  URL_SN int NOT NULL,
  RSPNS_SUCCES_AT char(1) DEFAULT NULL,
  LAST_UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (URL_SN)
);

EXEC sp_addextendedproperty 'MS_Description', 'URL 일련번호', 'USER', DBO, 'TABLE', tc_uwam_site_url_last_state, 'COLUMN', URL_SN;
EXEC sp_addextendedproperty 'MS_Description', '응답성공여부', 'USER', DBO, 'TABLE', tc_uwam_site_url_last_state, 'COLUMN', RSPNS_SUCCES_AT;
EXEC sp_addextendedproperty 'MS_Description', '최종수정일시', 'USER', DBO, 'TABLE', tc_uwam_site_url_last_state, 'COLUMN', LAST_UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', 'uwam시이트URL최종상태', 'USER', DBO, 'TABLE', tc_uwam_site_url_last_state;

--
-- Table structure for table tc_visual
--

DROP TABLE IF EXISTS tc_visual;
CREATE TABLE tc_visual (
  VISUAL_NO int NOT NULL,
  VISUAL_NM varchar(256) NOT NULL,
  VISUAL_URLAD varchar(512) DEFAULT NULL,
  VISUAL_SE varchar(16) DEFAULT NULL,
  SORT_ORDR int DEFAULT NULL,
  EXPSR_AT char(1) DEFAULT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  SITE_ID_SE varchar(512) DEFAULT NULL,
  SITE_ID varchar(32) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  BGNDE datetime DEFAULT NULL,
  ENDDE datetime DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (VISUAL_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '비주얼번호', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', VISUAL_NO;
EXEC sp_addextendedproperty 'MS_Description', '비주얼명', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', VISUAL_NM;
EXEC sp_addextendedproperty 'MS_Description', '비주얼URL주소', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', VISUAL_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '비주얼구분', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', VISUAL_SE;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '노출여부', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', EXPSR_AT;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', DEPT_ID ;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID구분', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', SITE_ID_SE;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '시작일', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', BGNDE;
EXEC sp_addextendedproperty 'MS_Description', '종료일', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', ENDDE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_visual, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '비주얼', 'USER', DBO, 'TABLE', tc_visual;



--
-- Table structure for table tc_wa_dgnss
--

DROP TABLE IF EXISTS tc_wa_dgnss;
CREATE TABLE tc_wa_dgnss (
  SITE_ID varchar(16) NOT NULL,
  PRSEC_YM char(6) NOT NULL,
  MENU_NO int NOT NULL,
  URLAD varchar(255) NOT NULL,
  BRWSR_SE varchar(256) NOT NULL,
  OPERSYSM_SE varchar(256) DEFAULT NULL,
  PAGE_SJ varchar(512) DEFAULT NULL,
  ERROR_CNT int DEFAULT NULL,
  WARN_CNT int DEFAULT NULL,
  NRMLTY_CNT int DEFAULT NULL,
  RISK_CNT int DEFAULT NULL,
  SERIUS_CNT int DEFAULT NULL,
  LAST_PRSEC_DT datetime DEFAULT NULL,
  HLPRT_VER varchar(64) DEFAULT NULL,
  PRSEC_CN text,
  ERROR_CN text,
  PRIMARY KEY (SITE_ID,PRSEC_YM,MENU_NO,URLAD)
);

EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '검사년월', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', PRSEC_YM;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', 'URL주소', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', URLAD;
EXEC sp_addextendedproperty 'MS_Description', '브라우저구분', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', BRWSR_SE;
EXEC sp_addextendedproperty 'MS_Description', '운영체제구분', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', OPERSYSM_SE;
EXEC sp_addextendedproperty 'MS_Description', '페이지제목', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', PAGE_SJ;
EXEC sp_addextendedproperty 'MS_Description', '에러건수', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', ERROR_CNT;
EXEC sp_addextendedproperty 'MS_Description', '경고건수', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', WARN_CNT;
EXEC sp_addextendedproperty 'MS_Description', '보통건수', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', NRMLTY_CNT;
EXEC sp_addextendedproperty 'MS_Description', '위험건수', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', RISK_CNT;
EXEC sp_addextendedproperty 'MS_Description', '심각건수', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', SERIUS_CNT;
EXEC sp_addextendedproperty 'MS_Description', '마지막검사일시', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', LAST_PRSEC_DT;
EXEC sp_addextendedproperty 'MS_Description', '리포트버전', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', HLPRT_VER;
EXEC sp_addextendedproperty 'MS_Description', '검사내용', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', PRSEC_CN;
EXEC sp_addextendedproperty 'MS_Description', '에러내용', 'USER', DBO, 'TABLE', tc_wa_dgnss, 'COLUMN', ERROR_CN;
EXEC sp_addextendedproperty 'MS_Description', '웹접근성진단', 'USER', DBO, 'TABLE', tc_wa_dgnss;



--
-- Table structure for table tc_word_dicary
--

DROP TABLE IF EXISTS tc_word_dicary;
CREATE TABLE tc_word_dicary (
  MNNO int NOT NULL,
  WORD_SE varchar(64) DEFAULT NULL,
  WORD_NM varchar(256) DEFAULT NULL,
  WORD_ENG_NM varchar(1024) DEFAULT NULL,
  WORD_ENG_ABRV_NM varchar(1024) DEFAULT NULL,
  WORD_DFN text,
  THEMA_AREA_SE varchar(1024) DEFAULT NULL,
  CREAT_DE varchar(10) DEFAULT NULL,
  USE_AT char(1) NOT NULL DEFAULT 'Y',
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '용어구분', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', WORD_SE;
EXEC sp_addextendedproperty 'MS_Description', '용어명', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', WORD_NM;
EXEC sp_addextendedproperty 'MS_Description', '용어영문명', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', WORD_ENG_NM;
EXEC sp_addextendedproperty 'MS_Description', '용어영문약어명', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', WORD_ENG_ABRV_NM;
EXEC sp_addextendedproperty 'MS_Description', '용어정의', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', WORD_DFN;
EXEC sp_addextendedproperty 'MS_Description', '주제영역구분', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', THEMA_AREA_SE;
EXEC sp_addextendedproperty 'MS_Description', '생성일자', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', CREAT_DE;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tc_word_dicary, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '용어사전', 'USER', DBO, 'TABLE', tc_word_dicary;


--
-- Table structure for table tm_dept_info
--

DROP TABLE IF EXISTS tm_dept_info;
CREATE TABLE tm_dept_info (
  DEPT_ID varchar(16) NOT NULL,
  DEPT_CD varchar(32) DEFAULT NULL,
  DEPT_KOR_NM varchar(512) NOT NULL,
  DEPT_ENG_NM varchar(512) DEFAULT NULL,
  UPPER_DEPT_ID varchar(16) DEFAULT NULL,
  DEPT_LEVEL int DEFAULT NULL,
  SORT_ORDR int NOT NULL,
  DEPT_JOB_CN text,
  DEPT_INFO text,
  DEPT_TELNO varchar(128) DEFAULT NULL,
  DEPT_FAXNO varchar(128) DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT 'Y',
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  PRIMARY KEY (DEPT_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서코드', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_CD;
EXEC sp_addextendedproperty 'MS_Description', '부서한글명', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_KOR_NM;
EXEC sp_addextendedproperty 'MS_Description', '부서영문명', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_ENG_NM;
EXEC sp_addextendedproperty 'MS_Description', '상위부서코드', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', UPPER_DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서레벨', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_LEVEL;
EXEC sp_addextendedproperty 'MS_Description', '정렬순서', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', SORT_ORDR;
EXEC sp_addextendedproperty 'MS_Description', '부서업무내용', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_JOB_CN;
EXEC sp_addextendedproperty 'MS_Description', '부서정보', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_INFO;
EXEC sp_addextendedproperty 'MS_Description', '부서전화번호', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_TELNO;
EXEC sp_addextendedproperty 'MS_Description', '부서팩스번호', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DEPT_FAXNO;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_dept_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '부서정보', 'USER', DBO, 'TABLE', tm_dept_info;


--
-- Table structure for table tm_login_hist
--

DROP TABLE IF EXISTS tm_login_hist;
CREATE TABLE tm_login_hist (
  HIST_NO int IDENTITY(1,1) NOT NULL,
  SITE_ID varchar(32) NOT NULL DEFAULT 'bos',
  USER_ID varchar(64) NOT NULL,
  USER_NM varchar(256) NOT NULL,
  USER_IPAD varchar(64) DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT NULL,
  LOGIN_DT datetime DEFAULT NULL,
  OVSEA_IP_AT char(1) DEFAULT 'N',
  MOBILE_AT char(1) DEFAULT 'N',
  PRIMARY KEY (HIST_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '이력번호', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', HIST_NO
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용자IP주소', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', USER_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '로그인일시', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', LOGIN_DT;
EXEC sp_addextendedproperty 'MS_Description', '해외IP여부', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', OVSEA_IP_AT;
EXEC sp_addextendedproperty 'MS_Description', '모바일여부', 'USER', DBO, 'TABLE', tm_login_hist, 'COLUMN', MOBILE_AT;
EXEC sp_addextendedproperty 'MS_Description', '로그인이력', 'USER', DBO, 'TABLE', tm_login_hist;

--
-- Table structure for table tm_mngr_author_hist
--

DROP TABLE IF EXISTS tm_mngr_author_hist;
CREATE TABLE tm_mngr_author_hist (
  HIST_NO int IDENTITY(1,1) NOT NULL,
  USER_ID varchar(64) NOT NULL,
  USER_SN int NOT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  AUTHOR_CD varchar(32) NOT NULL,
  USER_CPNO varchar(32) DEFAULT NULL,
  USER_TELNO varchar(32) DEFAULT NULL,
  USER_EMAD varchar(512) DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT NULL,
  STTUS_SUMRY varchar(512) DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  REGIST_IPAD varchar(64) DEFAULT NULL,
  PRIMARY KEY (HIST_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '이력번호', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', HIST_NO;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자휴대전화번호', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_CPNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자전화번호', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_TELNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자이메일주소', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', USER_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '상태요약', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', STTUS_SUMRY;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록IP주소', 'USER', DBO, 'TABLE', tm_mngr_author_hist, 'COLUMN', REGIST_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '관리자권한이력', 'USER', DBO, 'TABLE', tm_mngr_author_hist;

--
-- Table structure for table tm_mngr_info
--

DROP TABLE IF EXISTS tm_mngr_info;
CREATE TABLE tm_mngr_info (
  USER_ID varchar(64) NOT NULL,
  USER_SN int NOT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  PASSWORD varchar(256) NOT NULL,
  SEAT_NO int DEFAULT NULL,
  AUTHOR_CD varchar(32) DEFAULT NULL,
  USER_CPNO varchar(32) DEFAULT NULL,
  USER_IPAD varchar(64) DEFAULT NULL,
  USER_EMAD varchar(512) DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  PRIMARY KEY (USER_ID)
);


EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', PASSWORD;
EXEC sp_addextendedproperty 'MS_Description', '좌석번호', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', SEAT_NO;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자휴대전화번호', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_CPNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자IP주소', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '사용자이메일주소', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USER_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tm_mngr_info, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '관리자정보', 'USER', DBO, 'TABLE', tm_mngr_info;

--
-- Table structure for table tm_user_drmncy
--

DROP TABLE IF EXISTS tm_user_drmncy;
CREATE TABLE tm_user_drmncy (
  USER_ID varchar(64) NOT NULL,
  USER_SN int NOT NULL,
  PASSWORD varchar(256) NOT NULL,
  USER_TY_CD varchar(64) DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  USER_EMAD varchar(512) DEFAULT NULL,
  USER_CPNO varchar(32) DEFAULT NULL,
  USER_TELNO varchar(32) DEFAULT NULL,
  USER_ZIP varchar(7) DEFAULT NULL,
  USER_ADRES1 varchar(256) DEFAULT NULL,
  USER_ADRES2 varchar(512) DEFAULT NULL,
  EMAIL_RECPTN_AT char(1) DEFAULT NULL,
  SMS_RECPTN_AT char(1) DEFAULT NULL,
  ENTRPRS_NO int DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT 'Y',
  AUTHOR_CD varchar(32) DEFAULT NULL,
  MNG_AT char(1) DEFAULT 'N',
  ENT_AT char(1) DEFAULT 'N',
  SEAT_NO int DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  SITE_ID varchar(32) NOT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  LAST_LOGIN_DT datetime DEFAULT NULL,
  PASSWORD_CHANGE_DT datetime DEFAULT NULL,
  PASSWORD_DERIVE_DT datetime DEFAULT NULL,
  STPLAT_AGRE_DT datetime DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  DRMNCY_DT datetime DEFAULT NULL,
  PRIMARY KEY (USER_ID)
);


EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', PASSWORD;
EXEC sp_addextendedproperty 'MS_Description', '사용자타입코드', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용자이메일주소', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '사용자휴대전화번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_CPNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자전화번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_TELNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자우편번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_ZIP;
EXEC sp_addextendedproperty 'MS_Description', '사용자주소1', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_ADRES1;
EXEC sp_addextendedproperty 'MS_Description', '사용자주소2', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USER_ADRES2;
EXEC sp_addextendedproperty 'MS_Description', '이메일수신여부', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', EMAIL_RECPTN_AT;
EXEC sp_addextendedproperty 'MS_Description', 'SMS수신여부', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', SMS_RECPTN_AT;
EXEC sp_addextendedproperty 'MS_Description', '기업체번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', ENTRPRS_NO;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '관리자여부', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', MNG_AT;
EXEC sp_addextendedproperty 'MS_Description', '승인여부', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', ENT_AT;
EXEC sp_addextendedproperty 'MS_Description', '좌석번호', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', SEAT_NO;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '마지막로그인일', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', LAST_LOGIN_DT;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호경일시', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', PASSWORD_CHANGE_DT;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호변경유도일시', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', PASSWORD_DERIVE_DT;
EXEC sp_addextendedproperty 'MS_Description', '약관동의일', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', STPLAT_AGRE_DT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '휴면일시', 'USER', DBO, 'TABLE', tm_user_drmncy, 'COLUMN', DRMNCY_DT;
EXEC sp_addextendedproperty 'MS_Description', '사용자휴면', 'USER', DBO, 'TABLE', tm_user_drmncy;

--
-- Table structure for table tm_user_info
--

DROP TABLE IF EXISTS tm_user_info;
CREATE TABLE tm_user_info (
  USER_ID varchar(64) NOT NULL,
  USER_SN int NOT NULL,
  PASSWORD varchar(256) NOT NULL,
  USER_TY_CD varchar(64) DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  USER_EMAD varchar(512) DEFAULT NULL,
  USER_CPNO varchar(32) DEFAULT NULL,
  USER_TELNO varchar(32) DEFAULT NULL,
  USER_ZIP varchar(7) DEFAULT NULL,
  USER_ADRES1 varchar(256) DEFAULT NULL,
  USER_ADRES2 varchar(512) DEFAULT NULL,
  EMAIL_RECPTN_AT char(1) DEFAULT NULL,
  SMS_RECPTN_AT char(1) DEFAULT NULL,
  ENTRPRS_NO int DEFAULT NULL,
  STTUS_CD varchar(16) DEFAULT 'Y',
  AUTHOR_CD varchar(32) DEFAULT NULL,
  MNG_AT char(1) DEFAULT 'N',
  ENT_AT char(1) DEFAULT 'N',
  SEAT_NO int DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  SITE_ID varchar(32) NOT NULL,
  DEPT_ID varchar(16) DEFAULT NULL,
  LAST_LOGIN_DT datetime DEFAULT NULL,
  PASSWORD_CHANGE_DT datetime DEFAULT NULL,
  PASSWORD_DERIVE_DT datetime DEFAULT NULL,
  STPLAT_AGRE_DT datetime DEFAULT NULL,
  DELETE_CD char(1) NOT NULL DEFAULT '0',
  USE_AT char(1) DEFAULT NULL,
  REGIST_ID varchar(64) NOT NULL,
  REGIST_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  DRMNCY_NTCN_AT char(1) DEFAULT 'N',
  DRMNCY_NTCN_DT datetime DEFAULT NULL,
  PRIMARY KEY (USER_ID)
);

EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', PASSWORD;
EXEC sp_addextendedproperty 'MS_Description', '사용자타입코드', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_TY_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용자이메일주소', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '사용자휴대전화번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_CPNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자전화번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_TELNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자우편번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_ZIP;
EXEC sp_addextendedproperty 'MS_Description', '사용자주소1', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_ADRES1;
EXEC sp_addextendedproperty 'MS_Description', '사용자주소2', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USER_ADRES2;
EXEC sp_addextendedproperty 'MS_Description', '이메일수신여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', EMAIL_RECPTN_AT;
EXEC sp_addextendedproperty 'MS_Description', 'SMS수신여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', SMS_RECPTN_AT;
EXEC sp_addextendedproperty 'MS_Description', '기업체번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', ENTRPRS_NO;
EXEC sp_addextendedproperty 'MS_Description', '상태코드', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', STTUS_CD;
EXEC sp_addextendedproperty 'MS_Description', '권한코드', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', AUTHOR_CD;
EXEC sp_addextendedproperty 'MS_Description', '관리자여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', MNG_AT;
EXEC sp_addextendedproperty 'MS_Description', '승인여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', ENT_AT;
EXEC sp_addextendedproperty 'MS_Description', '좌석번호', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', SEAT_NO;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '부서ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', DEPT_ID;
EXEC sp_addextendedproperty 'MS_Description', '마지막로그인일', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', LAST_LOGIN_DT;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호경일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', PASSWORD_CHANGE_DT;
EXEC sp_addextendedproperty 'MS_Description', '비밀번호변경유도일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', PASSWORD_DERIVE_DT;
EXEC sp_addextendedproperty 'MS_Description', '약관동의일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', STPLAT_AGRE_DT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', UPDT_ID ;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '휴면알림여부', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', DRMNCY_NTCN_AT;
EXEC sp_addextendedproperty 'MS_Description', '휴면알림일시', 'USER', DBO, 'TABLE', tm_user_info, 'COLUMN', DRMNCY_NTCN_DT;
EXEC sp_addextendedproperty 'MS_Description', '사용자정보', 'USER', DBO, 'TABLE', tm_user_info;

--
-- Table structure for table tm_user_info_prtc
--

DROP TABLE IF EXISTS tm_user_info_prtc;
CREATE TABLE tm_user_info_prtc (
  MNNO int NOT NULL,
  PAGE_NO int DEFAULT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  READNG_USER_ID varchar(64) DEFAULT NULL,
  READNG_USER_NM varchar(64) DEFAULT NULL,
  READNG_DT datetime DEFAULT NULL,
  READNG_IPAD varchar(128) DEFAULT NULL,
  READNG_URLAD varchar(512) DEFAULT NULL,
  READNG_SE varchar(64) DEFAULT 'R',
  READNG_PURPS_SE varchar(64) DEFAULT NULL,
  READNG_PURPS_RM varchar(4000) DEFAULT NULL,
  PRIMARY KEY (MNNO)
)

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '페이지번호', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', PAGE_NO;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '열람사용자ID', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '열람사용자명', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '열람일시', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_DT;
EXEC sp_addextendedproperty 'MS_Description', '열람IP주소', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_IPAD;
EXEC sp_addextendedproperty 'MS_Description', '열람URL주소', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_URLAD;
EXEC sp_addextendedproperty 'MS_Description', '열람구분(R:열람,P:출력,D:다운로드)', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_SE;
EXEC sp_addextendedproperty 'MS_Description', '열람목적구분', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_PURPS_SE;
EXEC sp_addextendedproperty 'MS_Description', '열람목적비고', 'USER', DBO, 'TABLE', tm_user_info_prtc, 'COLUMN', READNG_PURPS_RM;
EXEC sp_addextendedproperty 'MS_Description', '사용자정보보호', 'USER', DBO, 'TABLE', tm_user_info_prtc;

--
-- Table structure for table tm_user_pin
--

DROP TABLE IF EXISTS tm_user_pin;
CREATE TABLE tm_user_pin (
  USER_SN int NOT NULL,
  USER_PIN varchar(128) NOT NULL DEFAULT '0',
  USER_NM varchar(256) DEFAULT NULL,
  CRTFC_SE_CD char(2) DEFAULT NULL,
  CHLD_CRTFC_AT char(1) NOT NULL DEFAULT 'N',
  REGIST_DT datetime DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  BRTHDY varchar(32) DEFAULT NULL,
  SEX_CD char(1) DEFAULT NULL,
  SITE_SE_CD char(1) DEFAULT NULL,
  PRIMARY KEY (USER_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자개인식별번호', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', USER_PIN;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '인증구분코드', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', CRTFC_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '미성년자인증여부', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', CHLD_CRTFC_AT;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '생년월일', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', BRTHDY;
EXEC sp_addextendedproperty 'MS_Description', '성별코드', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', SEX_CD;
EXEC sp_addextendedproperty 'MS_Description', '회원가입타입', 'USER', DBO, 'TABLE', tm_user_pin, 'COLUMN', SITE_SE_CD;
EXEC sp_addextendedproperty 'MS_Description', '사용자개인식별번호', 'USER', DBO, 'TABLE', tm_user_pin;

--
-- Table structure for table tm_user_salt
--

DROP TABLE IF EXISTS tm_user_salt;
CREATE TABLE tm_user_salt (
  USER_NO int NOT NULL,
  USER_SN int NOT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  SALT varchar(256) NOT NULL,
  USER_SE char(1) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  PRIMARY KEY (USER_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '일련번호', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', USER_NO;
EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '회원명', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', 'SALT', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', SALT;
EXEC sp_addextendedproperty 'MS_Description', '회원구분', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', USER_SE;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_user_salt, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '회원SALT정보', 'USER', DBO, 'TABLE', tm_user_salt;

--
-- Table structure for table tm_user_secsn
--

DROP TABLE IF EXISTS tm_user_secsn;
CREATE TABLE tm_user_secsn (
  MNNO int NOT NULL,
  USER_ID varchar(64) DEFAULT NULL,
  USER_NM varchar(256) DEFAULT NULL,
  USER_SECSN_DT datetime DEFAULT NULL,
  USER_SECSN_MEMO text,
  PRIMARY KEY (MNNO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', tm_user_secsn, 'COLUMN', MNNO;
EXEC sp_addextendedproperty 'MS_Description', '사용자ID', 'USER', DBO, 'TABLE', tm_user_secsn, 'COLUMN', USER_ID;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_user_secsn, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', '사용자탈퇴일시', 'USER', DBO, 'TABLE', tm_user_secsn, 'COLUMN', USER_SECSN_DT;
EXEC sp_addextendedproperty 'MS_Description', '사용자탈퇴메모', 'USER', DBO, 'TABLE', tm_user_secsn, 'COLUMN', USER_SECSN_MEMO;
EXEC sp_addextendedproperty 'MS_Description', '사용자탈퇴', 'USER', DBO, 'TABLE', tm_user_secsn;

--
-- Table structure for table tm_uwam_admin
--

DROP TABLE IF EXISTS tm_uwam_admin;
CREATE TABLE tm_uwam_admin (
  USER_SN int IDENTITY(2,1) NOT NULL,
  USER_NM varchar(64) DEFAULT NULL,
  SNS_ID varchar(100) UNIQUE DEFAULT NULL,
  SNS_SE varchar(10) DEFAULT NULL,
  USER_EMAD varchar(200) DEFAULT NULL,
  USE_AT varchar(1) DEFAULT NULL,
  APP_TOKEN_VALUE varchar(256) DEFAULT NULL,
  APP_DEVICE_ID varchar(50) DEFAULT NULL,
  APP_OS varchar(50) DEFAULT NULL,
  APP_VER varchar(20) DEFAULT NULL,
  APP_MODEL_SE varchar(50) DEFAULT NULL,
  STATUS_AT char(1) DEFAULT NULL,
  LAST_LOGIN_DT datetime DEFAULT NULL,
  DELETE_CD char(1) DEFAULT NULL,
  REGIST_DT datetime DEFAULT NULL,
  REGIST_ID varchar(64) DEFAULT NULL,
  UPDT_DT datetime DEFAULT NULL,
  UPDT_ID varchar(64) DEFAULT NULL,
  CONFM_AT char(1) DEFAULT NULL,
  CONFM_DT datetime DEFAULT NULL,
  CONFM_ID varchar(64) DEFAULT NULL,
  PRIMARY KEY (USER_SN)
);

EXEC sp_addextendedproperty 'MS_Description', '사용자일련번호', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', USER_SN;
EXEC sp_addextendedproperty 'MS_Description', '사용자명', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', USER_NM;
EXEC sp_addextendedproperty 'MS_Description', 'SNSID', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', SNS_ID;
EXEC sp_addextendedproperty 'MS_Description', 'SNS구분', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', SNS_SE;
EXEC sp_addextendedproperty 'MS_Description', '사용자EMAIL주소', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', USER_EMAD;
EXEC sp_addextendedproperty 'MS_Description', '사용여부', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', USE_AT;
EXEC sp_addextendedproperty 'MS_Description', '앱토큰값', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', APP_TOKEN_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '앱디바이스ID', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', APP_DEVICE_ID;
EXEC sp_addextendedproperty 'MS_Description', '앱OS', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', APP_OS;
EXEC sp_addextendedproperty 'MS_Description', '앱버전', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', APP_VER;
EXEC sp_addextendedproperty 'MS_Description', '앱모델구분', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', APP_MODEL_SE;
EXEC sp_addextendedproperty 'MS_Description', '상태여부', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', STATUS_AT;
EXEC sp_addextendedproperty 'MS_Description', '마지막로그인일시', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', LAST_LOGIN_DT;
EXEC sp_addextendedproperty 'MS_Description', '삭제코드', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', DELETE_CD;
EXEC sp_addextendedproperty 'MS_Description', '등록일시', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', REGIST_DT;
EXEC sp_addextendedproperty 'MS_Description', '등록ID', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', REGIST_ID;
EXEC sp_addextendedproperty 'MS_Description', '수정일시', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', UPDT_DT;
EXEC sp_addextendedproperty 'MS_Description', '수정ID', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', UPDT_ID;
EXEC sp_addextendedproperty 'MS_Description', '승인여부', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', CONFM_AT;
EXEC sp_addextendedproperty 'MS_Description', '승일일시', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', CONFM_DT;
EXEC sp_addextendedproperty 'MS_Description', '승인ID', 'USER', DBO, 'TABLE', tm_uwam_admin, 'COLUMN', CONFM_ID;
EXEC sp_addextendedproperty 'MS_Description', 'uwam관리자', 'USER', DBO, 'TABLE', tm_uwam_admin;


--
-- Table structure for table ts_cmmn_file_dwld_sm
--

DROP TABLE IF EXISTS ts_cmmn_file_dwld_sm;
CREATE TABLE ts_cmmn_file_dwld_sm (
  SM_NO int IDENTITY(1,1) NOT NULL,
  SM_DE char(8) DEFAULT NULL,
  ATCH_FILE_ID varchar(32) DEFAULT NULL,
  FILE_SN int DEFAULT NULL,
  MENU_NO int DEFAULT NULL,
  DWLD_CO int DEFAULT '0',
  SITE_ID varchar(32) DEFAULT NULL,
  PRIMARY KEY (SM_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '집계번호', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', SM_NO;
EXEC sp_addextendedproperty 'MS_Description', '집계일자', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', SM_DE;
EXEC sp_addextendedproperty 'MS_Description', '첨부파일ID', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', ATCH_FILE_ID;
EXEC sp_addextendedproperty 'MS_Description', '파일일련번호', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', FILE_SN;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '다운로드수', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', DWLD_CO;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '공통파일다운로드집계', 'USER', DBO, 'TABLE', ts_cmmn_file_dwld_sm;


--
-- Table structure for table ts_site_conect_stats_sm
--

DROP TABLE IF EXISTS ts_site_conect_stats_sm;
CREATE TABLE ts_site_conect_stats_sm (
  SM_NO int IDENTITY(1,1) NOT NULL,
  SM_DE char(8) DEFAULT NULL,
  SM_SE varchar(16) DEFAULT NULL,
  MENU_NO int DEFAULT NULL,
  SM_SE_VALUE varchar(256) DEFAULT NULL,
  VISITR_CO int DEFAULT NULL,
  PGE_VIEW_CO int DEFAULT NULL,
  SITE_ID varchar(32) NOT NULL,
  PRIMARY KEY (SM_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '관리번호', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', SM_NO;
EXEC sp_addextendedproperty 'MS_Description', '접속일자', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', SM_DE;
EXEC sp_addextendedproperty 'MS_Description', '집계구분', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', SM_SE;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '집계구분값', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', SM_SE_VALUE;
EXEC sp_addextendedproperty 'MS_Description', '방문자수', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', VISITR_CO;
EXEC sp_addextendedproperty 'MS_Description', '페이지뷰수', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', PGE_VIEW_CO;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '사이트접속통계집계', 'USER', DBO, 'TABLE', ts_site_conect_stats_sm;
--
-- Table structure for table ts_stsfdg_sm
--

DROP TABLE IF EXISTS ts_stsfdg_sm;
CREATE TABLE ts_stsfdg_sm (
  SM_NO int IDENTITY(1,1) NOT NULL,
  SM_DE char(8) NOT NULL,
  SITE_ID varchar(32) NOT NULL,
  MENU_NO int NOT NULL,
  PRTCPNT_CO int NOT NULL,
  STSFDG_1_CO int NOT NULL DEFAULT '0',
  STSFDG_2_CO int NOT NULL DEFAULT '0',
  STSFDG_3_CO int NOT NULL DEFAULT '0',
  STSFDG_4_CO int NOT NULL DEFAULT '0',
  STSFDG_5_CO int NOT NULL DEFAULT '0',
  PRIMARY KEY (SM_NO)
);

EXEC sp_addextendedproperty 'MS_Description', '집계번호', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', SM_NO;
EXEC sp_addextendedproperty 'MS_Description', '집계일자', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', SM_DE;
EXEC sp_addextendedproperty 'MS_Description', '사이트ID', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', SITE_ID;
EXEC sp_addextendedproperty 'MS_Description', '메뉴번호', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', MENU_NO;
EXEC sp_addextendedproperty 'MS_Description', '총참여자수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', PRTCPNT_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도1개수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', STSFDG_1_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도2개수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', STSFDG_2_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도3개수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', STSFDG_3_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도4개수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', STSFDG_4_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도5개수', 'USER', DBO, 'TABLE', ts_stsfdg_sm, 'COLUMN', STSFDG_5_CO;
EXEC sp_addextendedproperty 'MS_Description', '만족도집계', 'USER', DBO, 'TABLE', ts_stsfdg_sm;
















CREATE NONCLUSTERED INDEX I_TB_BBS_ESTN_01 ON tb_bbs_estn (BBS_ID,DELETE_CD,USE_AT);
CREATE NONCLUSTERED INDEX FK_TB_BBS_ESTN_CMMN_FILE ON tb_bbs_estn (ATCH_FILE_ID);
CREATE NONCLUSTERED INDEX FK_TB_BBS_ESTN_USER_PIN ON tb_bbs_estn (USER_SN);

CREATE NONCLUSTERED INDEX FK_TB_BBS_MASTR_TMPLAT_INFO ON tb_bbs_mastr (TMPLAT_ID);

-- CREATE NONCLUSTERED INDEX FK_TB_FIELD_INFO_ATTRB_INFO ON tb_field_info (ATTRB_CD);

-- CREATE NONCLUSTERED INDEX FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL ON tc_cmmn_cd_ctgry (CL_CD);


CREATE NONCLUSTERED INDEX I_TC_MENU_INFO_01 ON tc_menu_info (SITE_ID,BBS_ID,MENU_NO);
CREATE NONCLUSTERED INDEX I_TC_MENU_INFO_02 ON tc_menu_info (SITE_ID,UPPER_MENU_NO,DELETE_CD);

CREATE NONCLUSTERED INDEX I_SITE_CONECT_STATS_01 ON TC_SITE_CONECT_STATS (SITE_ID,CONECT_DE,CONECT_SN)

CREATE NONCLUSTERED INDEX I_TC_WORD_DICARY_01 ON tc_word_dicary (WORD_SE,WORD_ENG_ABRV_NM);


CREATE NONCLUSTERED INDEX I_LOGIN_HIST_01 ON tm_login_hist (SITE_ID,LOGIN_DT,HIST_NO);


CREATE NONCLUSTERED INDEX I_MNGR_AUTHOR_HIST_01 ON tm_mngr_author_hist (REGIST_DT,HIST_NO);

CREATE NONCLUSTERED INDEX I_USER_DRMNCY_01 ON tm_user_drmncy (DRMNCY_DT,USER_ID);


/************************************************************************************/

ALTER TABLE tb_bbs_cm
   ADD CONSTRAINT FK_TB_BBS_CM_USER_PIN FOREIGN KEY (USER_SN)
      REFERENCES tm_user_pin (USER_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tb_bbs_estn
   ADD CONSTRAINT FK_TB_BBS_ESTN_BBS_MASTR FOREIGN KEY (BBS_ID)
      REFERENCES tb_bbs_mastr (BBS_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tb_field_info
   ADD CONSTRAINT FK_TB_FIELD_INFO_ATTRB_INFO FOREIGN KEY (ATTRB_CD)
      REFERENCES tb_attrb_info (ATTRB_CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_author_sclsrt
  ADD CONSTRAINT PK_TC_AUTHOR_SCLSRT UNIQUE (PARNTS_AUTHOR_CD,CHLDRN_AUTHOR_CD);


ALTER TABLE tc_cmmn_cd_ctgry
   ADD CONSTRAINT FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL FOREIGN KEY (CL_CD)
      REFERENCES tc_cmmn_cd_cl (CL_CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_cmmn_cd_detail
   ADD CONSTRAINT FK_TC_CMMN_CD_DETAIL_CTGRY FOREIGN KEY (CD_ID)
      REFERENCES tc_cmmn_cd_ctgry (CD_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_cmmn_cd_multi
   ADD CONSTRAINT FK_TC_CMMN_CD_MULTI_DETAIL FOREIGN KEY (CD_ID, CD)
      REFERENCES tc_cmmn_cd_detail (CD_ID, CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_cmmn_file_detail
   ADD CONSTRAINT FK_TC_CMMN_FILE_DETAIL_FILE FOREIGN KEY (ATCH_FILE_ID)
      REFERENCES tc_cmmn_file (ATCH_FILE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_cntnts_manage 
  ADD CONSTRAINT PK_TC_CNTNTS_MANAGE UNIQUE (MENU_NO,CNTNTS_MNNO)
;


ALTER TABLE tc_menu_author 
  ADD CONSTRAINT PK_TC_MENU_AUTHOR UNIQUE (MENU_NO,AUTHOR_CD)
;


ALTER TABLE tc_menu_author
   ADD CONSTRAINT FK_TC_MENU_AUTHOR_INFO FOREIGN KEY (AUTHOR_CD)
      REFERENCES tc_author_info (AUTHOR_CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_mngr_main_estbs_detail
   ADD CONSTRAINT FK_TC_MNGR_MAIN_ESTBS_DETAIL FOREIGN KEY (MNNO)
      REFERENCES tc_mngr_main_estbs (MNNO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_qustnr_answer
   ADD CONSTRAINT FK_QUSTNR_ANSWER_QESITM FOREIGN KEY (QESITM_SN)
      REFERENCES tc_qustnr_qesitm (QESITM_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE tc_user_author
   ADD CONSTRAINT FK_TC_USER_AUTHOR_AUTHOR_INFO FOREIGN KEY (AUTHOR_CD)
      REFERENCES tc_author_info (AUTHOR_CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE TC_UWAM_SITE
   ADD CONSTRAINT FK_TC_UWAM_SITE_UWAM_ADMIN FOREIGN KEY (USER_SN)
      REFERENCES TM_UWAM_ADMIN (USER_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;



ALTER TABLE TC_UWAM_SITE_URL
   ADD CONSTRAINT FK_TC_UWAM_SITE_URL_UWAM_SITE FOREIGN KEY (SITE_SN)
      REFERENCES TC_UWAM_SITE (SITE_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE TC_UWAM_SITE_URL_ERROR
   ADD CONSTRAINT FK_TC_UWAM_SITE_URL_ERROR_UWAM_SITE_URL FOREIGN KEY (URL_SN)
      REFERENCES TC_UWAM_SITE_URL (URL_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE tc_uwam_site_url_error
   ADD CONSTRAINT FK_TC_UWAM_SITE_URL_ERROR_UWAM_SITE_ALARM_LOG FOREIGN KEY (ALARM_SN)
      REFERENCES TC_UWAM_SITE_ALARM_LOG (ALARM_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE TC_UWAM_SITE_URL_LAST_STATE
   ADD CONSTRAINT FK_TC_UWAM_SITE_URL_LAST_STATE_TC_UWAM_SITE_URL FOREIGN KEY (URL_SN)
      REFERENCES TC_UWAM_SITE_URL (URL_SN)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE TM_MNGR_INFO
   ADD CONSTRAINT FK_TM_MNGR_INFO_AUTHOR_INFO FOREIGN KEY (AUTHOR_CD)
      REFERENCES TC_AUTHOR_INFO (AUTHOR_CD)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;
