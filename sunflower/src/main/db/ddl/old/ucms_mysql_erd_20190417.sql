SET SESSION FOREIGN_KEY_CHECKS=0;


/* Create Tables */

-- 속성정보
CREATE TABLE tb_attrb_info
(
	ATTRB_CD varchar(16) NOT NULL COMMENT '속성코드',
	ATTRB_DC text COMMENT '속성설명',
	ATTRB_NM varchar(256) COMMENT '속성명',
	REGIST_DT datetime COMMENT '등록일',
	TABLE_NM varchar(256) NOT NULL COMMENT '테이블명',
	PRIMARY KEY (ATTRB_CD)
) COMMENT = '속성정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 게시판코멘트
CREATE TABLE tb_bbs_cm
(
	CM_ID int NOT NULL COMMENT '코멘트ID',
	NTT_ID int NOT NULL COMMENT '게시물ID',
	NTT_SJ varchar(1024) COMMENT '게시물제목',
	NTT_CN text COMMENT '게시글내용',
	BBS_ID varchar(16) NOT NULL COMMENT '게시판ID',
	NTCR_ID varchar(64) COMMENT '게시자ID',
	NTCR_NM varchar(128) COMMENT '게시자명',
	PASSWORD varchar(256) NOT NULL COMMENT '비밀번호',
	NTCR_EMAD varchar(512) COMMENT '게시자이메일주소',
	RECOMMEND_CO int COMMENT '추천수',
	CM_SE varchar(64) NOT NULL COMMENT '코멘트구분',
	USER_SN int NOT NULL COMMENT '사용자일련번호',
	OPTN1 text COMMENT '옵션1',
	OPTN2 text COMMENT '옵션2',
	OPTN3 text COMMENT '옵션3',
	OPTN4 text COMMENT '옵션4',
	OPTN5 text COMMENT '옵션5',
	OPTN6 text COMMENT '옵션6',
	OPTN7 text COMMENT '옵션7',
	OPTN8 text COMMENT '옵션8',
	OPTN9 text COMMENT '옵션9',
	OPTN10 text COMMENT '옵션10',
	EXPSR_AT char NOT NULL COMMENT '노출여부',
	delete_cd char(1) COMMENT '삭제코드',
	use_at varchar(1) COMMENT '사용여부',
	regist_id varchar(64) COMMENT '등록ID',
	REGIST_DT datetime COMMENT '등록일',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (CM_ID)
) COMMENT = '게시판코멘트' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 게시판확장
CREATE TABLE tb_bbs_estn
(
	NTT_ID int NOT NULL COMMENT '게시물ID',
	BBS_ID varchar(16) NOT NULL COMMENT '게시판ID',
	SORT_ORDR int COMMENT '정렬순서',
	NTT_SJ varchar(1024) COMMENT '게시물제목',
	NTT_CN text COMMENT '게시글내용',
	NTCR_ID varchar(64) COMMENT '게시자ID',
	NTCR_NM varchar(128) COMMENT '게시자명',
	NTCR_EMAD varchar(512) COMMENT '게시자이메일주소',
	NTCR_ZIP varchar(7) COMMENT '게시자우편번호',
	NTCR_ADRES1 varchar(256) COMMENT '게시자주소1',
	NTCR_ADRES2 varchar(512) COMMENT '게시자주소2',
	NTCR_TELNO varchar(32) COMMENT '게시자전화번호',
	NTCR_CPNO varchar(32) COMMENT '게시자휴대전화번호',
	NTCR_PIN varchar(128) COMMENT '게시자개인식별번호',
	PASSWORD varchar(256) COMMENT '비밀번호',
	INQIRE_CO int COMMENT '조회횟수',
	NTCE_BGNDE varchar(10) COMMENT '게시시작일',
	NTCE_ENDDE varchar(10) COMMENT '게시종료일',
	ANSWER_AT char COMMENT '답글여부',
	PARNTS_NO int COMMENT '부모글번호',
	NTT_NO int COMMENT '게시물번호',
	ANSWER_LC int COMMENT '답글위치',
	SECRET_AT char COMMENT '비밀여부',
	NTT_TY_CD varchar(16) NOT NULL COMMENT '게시글유형코드',
	USER_SN int COMMENT '사용자일련번호',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	DEPT_ID varchar(16) COMMENT '부서ID',
	DEPT_NM varchar(256) COMMENT '부서명',
	HTML_AT char DEFAULT 'N' COMMENT 'HTML여부',
	BBS_SE_CD varchar(16) COMMENT '게시판구분코드',
	IMAGE_REPLC_TEXT_CN text COMMENT '이미지대체텍스트내용',
	SITE_ID varchar(32) COMMENT '사이트ID',
	OPTN1 text COMMENT '옵션1',
	OPTN2 text COMMENT '옵션2',
	OPTN3 text COMMENT '옵션3',
	OPTN4 text COMMENT '옵션4',
	OPTN5 text COMMENT '옵션5',
	OPTN6 text COMMENT '옵션6',
	OPTN7 text COMMENT '옵션7',
	OPTN8 text COMMENT '옵션8',
	OPTN9 text COMMENT '옵션9',
	OPTN10 text COMMENT '옵션10',
	OPTN11 text COMMENT '옵션11',
	OPTN12 text COMMENT '옵션12',
	OPTN13 text COMMENT '옵션13',
	OPTN14 text COMMENT '옵션14',
	OPTN15 text COMMENT '옵션15',
	OPTN16 text COMMENT '옵션16',
	OPTN17 text COMMENT '옵션17',
	OPTN18 text COMMENT '옵션18',
	OPTN19 text COMMENT '옵션19',
	OPTN20 text COMMENT '옵션20',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	use_at varchar(1) COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (NTT_ID)
) COMMENT = '게시판확장' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 게시판마스터
CREATE TABLE tb_bbs_mastr
(
	BBS_ID varchar(16) NOT NULL COMMENT '게시판ID',
	BBS_TY_CD varchar(16) NOT NULL COMMENT '게시판유형코드',
	BBS_ATTRB_CD varchar(16) NOT NULL COMMENT '게시판속성코드',
	BBS_NM varchar(512) NOT NULL COMMENT '게시판명',
	BBS_DC text COMMENT '게시판설명',
	REPLY_POSBL_AT char COMMENT '답글가능여부',
	FILE_ATCH_POSBL_AT char COMMENT '파일첨부가능여부',
	ATCH_POSBL_FILE_CO int COMMENT '첨부가능파일건수',
	ATCH_POSBL_FILE_SIZE varchar(32) COMMENT '첨부가능파일사이즈',
	NTCE_BGNDE varchar(10) COMMENT '게시시작일',
	NTCE_ENDDE varchar(10) COMMENT '게시종료일',
	TMPLAT_ID char(20) COMMENT '템플릿ID',
	CM_POSBL_AT char COMMENT '코멘트가능여부',
	ADIT_CNTNTS_CN text COMMENT '추가컨텐츠내용',
	PAGE_SIZE int COMMENT '페이지사이즈',
	PAGE_UNIT int COMMENT '페이지단위',
	PREV_NEXT_POSBL_AT char COMMENT '이전글다음글사용여부',
	TABLE_NM varchar(256) COMMENT '테이블명',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	USE_AT char COMMENT '사용여부(Y:사용,N:미사용)',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (BBS_ID)
) COMMENT = '게시판마스터' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 게시판 필드정보
CREATE TABLE tb_field_info
(
	FIELD_ID int NOT NULL COMMENT '필드ID',
	ATTRB_CD varchar(16) NOT NULL COMMENT '속성코드',
	ATTRB_TY_CD varchar(16) NOT NULL COMMENT '속성유형코드',
	FIELD_IEM_NM varchar(256) NOT NULL COMMENT '필드항목명',
	FIELD_TY_CD varchar(16) NOT NULL COMMENT '필드유형코드',
	FIELD_DC text NOT NULL COMMENT '필드설명',
	FIELD_ORDR int COMMENT '필드순서',
	LIST_USE_AT char DEFAULT 'N' COMMENT '리스트사용여부',
	PRIMARY KEY (FIELD_ID)
) COMMENT = '게시판 필드정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 접근히스토리 관리
CREATE TABLE tc_acces_hist
(
	HIST_SN int NOT NULL COMMENT '히스토리 일련번호',
	ETC_INFO varchar(256) COMMENT '기타정보(권한명 등)',
	ACCES_DT datetime COMMENT '접속일시',
	ACCES_IP varchar(16) COMMENT '접속IP',
	ACCES_CRUD varchar(1) COMMENT '접근구분',
	ACCES_ADMIN_ID varchar(64) COMMENT '접근관리자ID',
	ACCES_URL varchar(4000) COMMENT '접근URL',
	PRIMARY KEY (HIST_SN)
) COMMENT = '접근히스토리 관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 권한정보
CREATE TABLE tc_author_info
(
	AUTHOR_CD varchar(32) NOT NULL COMMENT '권한코드',
	AUTHOR_NM varchar(256) NOT NULL COMMENT '권한명',
	AUTHOR_DC text COMMENT '권한설명',
	regist_dt datetime COMMENT '등록일시',
	PRIMARY KEY (AUTHOR_CD)
) COMMENT = '권한정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 권한계층
CREATE TABLE tc_author_sclsrt
(
	PARNTS_AUTHOR_CD varchar(32) NOT NULL COMMENT '부모권한',
	CHLDRN_AUTHOR_CD varchar(32) NOT NULL COMMENT '자식권한',
	PRIMARY KEY (PARNTS_AUTHOR_CD, CHLDRN_AUTHOR_CD)
) COMMENT = '권한계층' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 배너
CREATE TABLE tc_banner
(
	BANNER_NO int NOT NULL COMMENT '배너번호',
	BANNER_NM varchar(256) NOT NULL COMMENT '배너명',
	BANNER_URLAD varchar(512) COMMENT '배너URL주소',
	BANNER_SE varchar(16) COMMENT '배너구분',
	DONG_CD varchar(16) COMMENT '동코드',
	SORT_ORDR int COMMENT '정렬순서',
	EXPSR_AT char COMMENT '노출여부',
	POPUP_AT char DEFAULT 'N' COMMENT '팝업여부',
	DEPT_ID varchar(16) COMMENT '부서ID',
	SITE_ID_SE varchar(512) COMMENT '사이트ID구분',
	SITE_ID varchar(32) COMMENT '사이트ID',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	BGNDE datetime COMMENT '시작일',
	ENDDE datetime COMMENT '종료일',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (BANNER_NO)
) COMMENT = '배너' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통코드분류
CREATE TABLE tc_cmmn_cd_cl
(
	CL_CD varchar(16) NOT NULL COMMENT '분류코드',
	CL_CD_NM varchar(256) COMMENT '분류코드명',
	CL_CD_DC text COMMENT '분류코드설명',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (CL_CD)
) COMMENT = '공통코드분류' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통코드카테고리
CREATE TABLE tc_cmmn_cd_ctgry
(
	CD_ID varchar(16) NOT NULL COMMENT '코드ID',
	CL_CD varchar(16) NOT NULL COMMENT '분류코드',
	CD_ID_NM varchar(256) COMMENT '코드ID명',
	CD_ID_ENG_NM varchar(256) COMMENT '코드ID영문명',
	CD_ID_DC text COMMENT '코드ID설명',
	CD_ID_ENG_DC text COMMENT '코드ID영문설명',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (CD_ID)
) COMMENT = '공통코드카테고리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통코드상세
CREATE TABLE tc_cmmn_cd_detail
(
	CD varchar(16) NOT NULL COMMENT '코드',
	CD_ID varchar(16) NOT NULL COMMENT '코드ID',
	CD_NM varchar(256) COMMENT '코드명',
	CD_ENG_NM varchar(256) COMMENT '코드영문명',
	CD_DC text COMMENT '코드설명',
	CD_ENG_DC text COMMENT '코드영문설명',
	UPPER_CD varchar(16) DEFAULT '0' COMMENT '상위코드',
	DP int DEFAULT 1 COMMENT '깊이',
	SORT_ORDR int DEFAULT 0 COMMENT '정렬순서',
	OPTN1 text COMMENT '옵션1',
	OPTN2 text COMMENT '옵션2',
	OPTN3 text COMMENT '옵션3',
	OPTN4 text COMMENT '옵션4',
	OPTN5 text COMMENT '옵션5',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (CD, CD_ID)
) COMMENT = '공통코드상세' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통코드다중
CREATE TABLE tc_cmmn_cd_multi
(
	CD_ID varchar(16) NOT NULL COMMENT '코드ID',
	PROGRM_ID varchar(32) NOT NULL COMMENT '프로그램ID',
	PROGRM_SN int NOT NULL COMMENT '프로그램일련번호',
	CD varchar(16) NOT NULL COMMENT '코드',
	regist_dt datetime COMMENT '등록일시',
	MEMO text COMMENT '메모',
	PRIMARY KEY (CD_ID, PROGRM_ID, PROGRM_SN, CD)
) COMMENT = '공통코드다중' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통파일
CREATE TABLE tc_cmmn_file
(
	ATCH_FILE_ID varchar(32) NOT NULL COMMENT '첨부파일ID',
	use_at varchar(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '사용여부',
	regist_dt datetime COMMENT '등록일시',
	REGIST_ID varchar(64) COMMENT '등록자ID',
	PROGRM_ID varchar(32) COMMENT '프로그램ID',
	OTHBC_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'Y' COMMENT '공개여부 ',
	PRIMARY KEY (ATCH_FILE_ID)
) COMMENT = '공통파일' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통파일상세
CREATE TABLE tc_cmmn_file_detail
(
	ATCH_FILE_ID varchar(32) NOT NULL COMMENT '첨부파일ID',
	FILE_SN int NOT NULL COMMENT '파일일련번호',
	FILE_STRE_COURS varchar(512) NOT NULL COMMENT '파일저장경로',
	STRE_FILE_NM varchar(256) NOT NULL COMMENT '저장파일명',
	ORIGNL_FILE_NM varchar(256) DEFAULT 'NULL          ' COMMENT '원파일명',
	FILE_EXTSN_NM varchar(128) DEFAULT 'NULL           ' COMMENT '파일확장자명',
	FILE_SIZE int COMMENT '파일사이즈',
	FILE_CN text COMMENT '파일내용',
	FILE_FIELD_NM varchar(256) DEFAULT 'NULL           ' COMMENT '파일필드명',
	PRIMARY KEY (ATCH_FILE_ID, FILE_SN)
) COMMENT = '공통파일상세' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통파일다운로드이력
CREATE TABLE tc_cmmn_file_dwld_hist
(
	MNNO int NOT NULL COMMENT '관리번',
	ATCH_FILE_ID varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '첨부파일ID',
	FILE_SN int NOT NULL COMMENT '파일일련번호',
	MENU_NO int COMMENT '메뉴번호',
	regist_id varchar(64) COMMENT '등록ID',
	regist_dt datetime NOT NULL COMMENT '등록일시',
	SITE_ID varchar(32) COMMENT '사이트ID'
) COMMENT = '공통파일다운로드이력' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 공통일련번호
CREATE TABLE tc_cmmn_sn
(
	TABLE_NM varchar(128) NOT NULL COMMENT '테이블명',
	NEXT_SN int NOT NULL COMMENT '다음일련번호',
	PRIMARY KEY (TABLE_NM)
) COMMENT = '공통일련번호' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 콘텐츠관리
CREATE TABLE tc_cntnts_manage
(
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	CNTNTS_MNNO int NOT NULL COMMENT '컨텐츠관리번호',
	CNTNTS_CN text COMMENT '콘텐츠내용',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	use_at varchar(1) DEFAULT 'Y' COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (MENU_NO, CNTNTS_MNNO)
) COMMENT = '콘텐츠관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 에러로그
CREATE TABLE tc_error_log
(
	LOG_NO int NOT NULL COMMENT '로그번호',
	ERROR_SJ varchar(1024) NOT NULL COMMENT '에러제목',
	USER_ID varchar(64) COMMENT '사용자ID',
	USER_IPAD varchar(128) NOT NULL COMMENT '사용자IP주소',
	ERROR_DT datetime NOT NULL COMMENT '에러일시',
	ERROR_URLAD varchar(512) COMMENT '에러URL',
	BEFORE_URLAD varchar(512) COMMENT '이전URL',
	ERROR_CN varchar(4000) COMMENT '에러메세지'
) COMMENT = '에러로그' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 글로벌환경변수 관리
CREATE TABLE tc_global
(
	ATTRB_SN int NOT NULL COMMENT '속성일련번호',
	ATTRB_NM varchar(256) NOT NULL COMMENT '속성명',
	ATTRB_VALUE varchar(128) COMMENT '속성값',
	ATTRB_DC text COMMENT '속성설명',
	use_at varchar(1) DEFAULT 'Y' COMMENT '사용여부',
	regist_id varchar(64) COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (ATTRB_SN)
) COMMENT = '글로벌환경변수 관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 메뉴권한
CREATE TABLE tc_menu_author
(
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	AUTHOR_CD varchar(32) NOT NULL COMMENT '권한코드',
	MAP_CREAT_ID varchar(16) COMMENT '맵생성ID',
	regist_dt datetime COMMENT '등록일시',
	PRIMARY KEY (MENU_NO, AUTHOR_CD)
) COMMENT = '메뉴권한' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 메뉴권한보호
CREATE TABLE tc_menu_author_prtc
(
	MNNO int NOT NULL COMMENT '관리번호',
	MENU_NO int COMMENT '메뉴번호',
	USER_ID varchar(64) COMMENT '사용자ID',
	AUTHOR_CD varchar(32) COMMENT '권한코드',
	AUTHOR_DT datetime COMMENT '권한일시',
	AUTHOR_IPAD varchar(128) COMMENT '권한IP주소',
	AUTHOR_PURPS_SE text COMMENT '권한목적구분',
	PRIMARY KEY (MNNO)
) COMMENT = '메뉴권한보호' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 메뉴정보
CREATE TABLE tc_menu_info
(
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	MENU_NM varchar(256) NOT NULL COMMENT '메뉴명',
	UPPER_MENU_NO int NOT NULL COMMENT '상위메뉴번호',
	MENU_ORDR int NOT NULL COMMENT '메뉴순서',
	MENU_DC text COMMENT '메뉴설명',
	MENU_CNTNTS_CD varchar(16) COMMENT '메뉴콘텐츠코드',
	MENU_LINK varchar(512) COMMENT '메뉴링크',
	POPUP_AT char COMMENT '팝업여부',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	DEPT_ID varchar(16) COMMENT '부서ID',
	USER_ID varchar(64) COMMENT '사용자ID',
	RELATE_MENU_NM_LIST text COMMENT '관련메뉴명목록',
	RELATE_MENU_LINK_LIST text COMMENT '관련메뉴링크목록',
	ALL_MENU_COURS text COMMENT '전체메뉴경로',
	CNTNTS_FILE_COURS varchar(512) COMMENT '콘텐츠파일경로',
	MENU_LC text COMMENT '메뉴위치',
	BBS_ID varchar(16) COMMENT '게시판ID',
	LEAF_NODE_AT char COMMENT '최종하위메뉴유무',
	KWRD_NM varchar(1024) COMMENT '키워드명',
	ADI_INFO text COMMENT '부가정보',
	MENU_EXPSR_SE varchar(10) COMMENT '메뉴노출구분',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	USER_INFO_SE char COMMENT '회원정보구분',
	PRIMARY KEY (MENU_NO)
) COMMENT = '메뉴정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 관리자메인설정
CREATE TABLE tc_mngr_main_estbs
(
	MNNO int NOT NULL COMMENT '관리번호',
	SE_CD varchar(16) NOT NULL COMMENT '설정구분코드',
	BASS_MG varchar(16) NOT NULL COMMENT '기본크기',
	ESTBS_CN text COMMENT '설정내용',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	USER_ID varchar(64) COMMENT '사용자ID',
	AR_MVL int COMMENT '넓이최대치',
	AR_MNVL int COMMENT '넓이최소치',
	HG_MVL int COMMENT '높이최대치',
	HG_MNVL int COMMENT '높이최소치',
	SIZE_UPDT_AT char DEFAULT 'Y' COMMENT '사이즈변경여부',
	PRIMARY KEY (MNNO)
) COMMENT = '관리자메인설정' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 관리자메인설정상세
CREATE TABLE tc_mngr_main_estbs_detail
(
	MNNO int NOT NULL COMMENT '관리번호',
	SN int NOT NULL COMMENT '일련번호',
	ESTBS_NM varchar(512) COMMENT '설정명',
	BBS_ID varchar(16) COMMENT '게시판ID',
	URLAD varchar(512) COMMENT 'URL주소',
	POPUP_AT char COMMENT '팝업여부',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	FILE_FIELD_NM varchar(256) COMMENT '파일필드명',
	FIELD_ORDR int NOT NULL COMMENT '필드순서',
	ICON_NM varchar(64) COMMENT '아이콘명',
	PRIMARY KEY (MNNO, SN)
) COMMENT = '관리자메인설정상세' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 관리자메인위치설정
CREATE TABLE tc_mngr_main_lc_estbs
(
	SN int NOT NULL COMMENT '일련번호',
	MNNO int NOT NULL COMMENT '관리번호',
	LFT_CRDNT int NOT NULL COMMENT '좌측좌표',
	UPEND_CRDNT int NOT NULL COMMENT '탑좌표',
	AR_VALUE int NOT NULL COMMENT '넓이값',
	HG_VALUE int NOT NULL COMMENT '높이값',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	USER_ID varchar(64) NOT NULL COMMENT '사용자ID',
	UPDT_DT datetime COMMENT '수정일',
	PRIMARY KEY (SN)
) COMMENT = '관리자메인위치설정' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 알림영역
CREATE TABLE tc_ntcn_relm
(
	NTCN_NO int NOT NULL COMMENT '알림번호',
	NTCN_NM varchar(256) NOT NULL COMMENT '알림명',
	NTCN_URLAD varchar(512) COMMENT '알림URL주소',
	NTCN_CN text COMMENT '알림내용',
	NTCN_TY_CD varchar(16) COMMENT '알림유형코드',
	SORT_ORDR int COMMENT '정렬순서',
	POPUP_AT char COMMENT '팝업여부',
	MAP_USE_AT char COMMENT '맵사용여부',
	DEPT_ID varchar(16) COMMENT '부서ID',
	SITE_ID_SE varchar(512) COMMENT '사이트ID구분',
	SITE_ID varchar(32) COMMENT '사이트ID',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	BGNDE datetime COMMENT '시작일',
	ENDDE datetime COMMENT '종료일',
	LINK_SE char COMMENT '링크구분',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (NTCN_NO)
) COMMENT = '알림영역' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 팝업관리
CREATE TABLE tc_popup_manage
(
	POPUP_NO int NOT NULL COMMENT '팝업번호',
	POPUP_SJ varchar(1024) NOT NULL COMMENT '팝업제목',
	POPUP_CN text COMMENT '팝업내용',
	BGNDE datetime COMMENT '시작일',
	ENDDE datetime COMMENT '종료일',
	AR_VALUE int COMMENT '넓이값',
	HG_VALUE int COMMENT '높이값',
	LFT_CRDNT int COMMENT '좌측좌표',
	UPEND_CRDNT int COMMENT '탑좌표',
	CLOSE_USE_AT char COMMENT '닫기사용여부',
	SITE_ID_SE varchar(512) COMMENT '사이트ID구분',
	SITE_ID varchar(32) COMMENT '사이트ID',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	URLAD varchar(512) COMMENT '링크주소',
	SCRL_USE_AT char COMMENT '스크롤사용여부',
	LINK_TY_CD varchar(16) COMMENT '링크타입코드',
	MAP_CN text COMMENT '맵내용',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (POPUP_NO)
) COMMENT = '팝업관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 금지단어사전
CREATE TABLE tc_prhibt_wrd_dicary
(
	WRD_SN int NOT NULL COMMENT '금지단어일련번호',
	WRD_NM varchar(256) COMMENT '금지단어명',
	use_at varchar(1) DEFAULT 'Y' COMMENT '사용여부',
	regist_id varchar(64) COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	WRD_SE char NOT NULL COMMENT '금지단어구분',
	PRIMARY KEY (WRD_SN)
) COMMENT = '금지단어사전' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 금지단어필터
CREATE TABLE tc_prhibt_wrd_flter
(
	WRD_SN int NOT NULL COMMENT '금지단어일련번호',
	WRD_NM varchar(256) COMMENT '금지단어명',
	use_at varchar(1) DEFAULT 'Y' COMMENT '사용여부',
	regist_id varchar(64) COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (WRD_SN)
) COMMENT = '금지단어필터' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 설문조사
CREATE TABLE tc_qustnr
(
	QUSTNR_SN int NOT NULL COMMENT '설문일련번호',
	QUSTNR_SJ varchar(1024) NOT NULL COMMENT '설문제목',
	BGNDE datetime COMMENT '시작일',
	ENDDE datetime COMMENT '종료일',
	STTUS_CD varchar(16) COMMENT '상태코드',
	QUSTNR_TRGET_CD varchar(16) COMMENT '설문대상코드 ',
	RESULT_OTHBC_AT char DEFAULT 'Y' NOT NULL COMMENT '결과보기공개여부',
	DEPT_ID varchar(16) COMMENT '부서ID',
	TELNO varchar(32) COMMENT '전화번호',
	QESTNAR_CN text COMMENT '설문조사내용',
	delete_cd char(1) DEFAULT '0' COMMENT '삭제코드',
	regist_dt datetime COMMENT '등록일시',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	updt_dt datetime COMMENT '수정일시',
	updt_id varchar(64) COMMENT '수정ID',
	PRIMARY KEY (QUSTNR_SN)
) COMMENT = '설문조사' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 설문답변
CREATE TABLE tc_qustnr_answer
(
	ANSWER_SN int NOT NULL COMMENT '답변일련번호',
	QESITM_SN int NOT NULL COMMENT '문항일련번호',
	ANSWER_CN text COMMENT '답변내용',
	SORT_ORDR int DEFAULT 0 NOT NULL COMMENT '정렬순서',
	PRIMARY KEY (ANSWER_SN)
) COMMENT = '설문답변' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 설문항목
CREATE TABLE tc_qustnr_qesitm
(
	QESITM_SN int NOT NULL COMMENT '문항일련번호',
	QUSTNR_SN int NOT NULL COMMENT '설문일련번호',
	QESITM_TY_CD char NOT NULL COMMENT '문항유형코드',
	QESITM_SJ varchar(1024) NOT NULL COMMENT '문항제목',
	ESSNTL_ANSWER_AT char DEFAULT 'N' NOT NULL COMMENT '필수답변여부',
	ESSNTL_CHOISE_QY int DEFAULT 0 COMMENT '필수선택건수',
	PRIMARY KEY (QESITM_SN)
) COMMENT = '설문항목' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 설문사용자답변
CREATE TABLE tc_qustnr_user_answer
(
	USER_ANSWER_SN int NOT NULL COMMENT '사용자답변일련번호',
	QESITM_SN int NOT NULL COMMENT '문항일련번호',
	ANSWER_SN int COMMENT '답변일련번호',
	USER_PIN varchar(128) COMMENT '사용자 개인식별번호',
	ANSWER_CN text COMMENT '답변내용'
) COMMENT = '설문사용자답변' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 설문사용자기타의견
CREATE TABLE tc_qustnr_user_etc_answer
(
	USER_ETC_ANSWER_SN int NOT NULL COMMENT '사용자기타의견일련번호',
	QESITM_SN int NOT NULL COMMENT '문항일련번호',
	ETC_ANSWER_CN text COMMENT '답변내용',
	ANSWER_SN int COMMENT '답변일련번호',
	USER_PIN varchar(128) COMMENT '사용자 개인식별번호'
) COMMENT = '설문사용자기타의견' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트접속통계
CREATE TABLE tc_site_conect_stats
(
	CONECT_SN int NOT NULL AUTO_INCREMENT COMMENT '접속일련번호',
	SESION_ID varchar(256) NOT NULL COMMENT '접속구분',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	CONECT_URLAD varchar(512) COMMENT '접속URL주소',
	MENU_NO int COMMENT '메뉴번호',
	CONECT_OPERSYSM_NM varchar(256) COMMENT '접속운영체제명',
	CONECT_WBSR_NM varchar(256) COMMENT '접속브라우저명',
	CONECT_PC_MOBILE_SE varchar(64) COMMENT '접속PC모바일구분',
	CONECT_YM char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '접속년월',
	CONECT_DE char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '접속일자',
	regist_dt datetime NOT NULL COMMENT '등록일시',
	BEFORE_MENU_NO int COMMENT '이전메뉴번호',
	PRIMARY KEY (CONECT_SN)
) COMMENT = '사이트접속통계' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트가이드메뉴
CREATE TABLE tc_site_guide_menu
(
	MNNO int NOT NULL COMMENT '관리번호',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	MENU_SE_CD varchar(16) NOT NULL COMMENT '메뉴구분코드',
	MENU_NO int COMMENT '메뉴번호',
	MENU_NM varchar(256) NOT NULL COMMENT '메뉴명',
	MENU_LINK varchar(512) COMMENT '메뉴링크',
	MENU_ORDR int NOT NULL COMMENT '메뉴순서',
	POPUP_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '팝업여부',
	use_at varchar(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime NOT NULL COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (MNNO)
) COMMENT = '사이트가이드메뉴' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트도움말
CREATE TABLE tc_site_hpcm
(
	HPCM_NO int NOT NULL COMMENT '도움말번호',
	HPCM_NM varchar(256) NOT NULL COMMENT '도움말명',
	UPPER_HPCM_NO int NOT NULL COMMENT '상위도움말번호',
	GROUP_ID varchar(256) COMMENT '그룹ID',
	SRVC_ID varchar(256) COMMENT '서비스ID',
	SRVC_NM varchar(256) COMMENT '서비스',
	METHOD_ID varchar(256) COMMENT '메소드ID',
	HPCM_ORDR int COMMENT '도움말순서',
	HPCM_CN text COMMENT '도움말내용',
	KWRD_NM varchar(1024) COMMENT '키워드명',
	ADI_INFO text COMMENT '추가정보',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime NOT NULL COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (HPCM_NO)
) COMMENT = '사이트도움말' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트도움말메뉴
CREATE TABLE tc_site_hpcm_menu
(
	HPCM_NO int NOT NULL COMMENT '도움말번호',
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	PRIMARY KEY (HPCM_NO, MENU_NO)
) COMMENT = '사이트도움말메뉴' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트정보
CREATE TABLE tc_site_info
(
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	site_nm varchar(256) NOT NULL COMMENT '사이트명',
	SITE_DC text COMMENT '사이트설명',
	SITE_URLAD varchar(512) COMMENT '사이트URL주소',
	SITE_IPAD varchar(64) COMMENT '사이트IP주소',
	SITE_PORT_NO varchar(32) COMMENT '사이트포트번호',
	SITE_ESTBS_CD varchar(16) COMMENT '사이트설정코드',
	STSFDG_USE_AT char DEFAULT 'N' COMMENT '만족도사용여부',
	DTA_MNGR_USE_AT char DEFAULT 'N' COMMENT '자료관리자사용여부',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	ACCES_IPAD varchar(2048) COMMENT '접근아이피주소',
	SITE_SN int COMMENT '사이트일련번호',
	INSTT_NM varchar(256) COMMENT '기관명',
	INSTT_NM_USE_AT char DEFAULT 'Y' COMMENT '기관명사용여부',
	CPYRHT_CN varchar(4000) COMMENT '저작권내용',
	CPYRHT_CN_USE_AT char DEFAULT 'Y' COMMENT '저작권내용사용여부',
	ZIP varchar(7) COMMENT '우편번호',
	ZIP_USE_AT char DEFAULT 'Y' COMMENT '우편번호사용여부',
	ADRES1 varchar(256) COMMENT '주소1',
	ADRES1_USE_AT char DEFAULT 'Y' COMMENT '주소1사용여부',
	ADRES2 varchar(512) COMMENT '주소2',
	ADRES2_USE_AT char DEFAULT 'Y' COMMENT '주소2사용여부',
	TELNO varchar(32) COMMENT '전화번',
	TELNO_USE_AT char DEFAULT 'Y' COMMENT '전화번호사용여부',
	FAXNO varchar(32) COMMENT '팩스번호',
	FAXNO_USE_AT char DEFAULT 'Y' COMMENT '팩스번호사용여부',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (SITE_ID)
) COMMENT = '사이트정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 만족도
CREATE TABLE tc_stsfdg
(
	STSFDG_NO int NOT NULL COMMENT '만족도번호',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	STSFDG_IDEX int NOT NULL COMMENT '만족도지수',
	OPINION_CN text COMMENT '의견내용',
	USER_ID varchar(64) COMMENT '사용자ID',
	USER_IPAD varchar(64) NOT NULL COMMENT '사용자IP주소',
	regist_dt datetime COMMENT '등록일시',
	PRIMARY KEY (STSFDG_NO)
) COMMENT = '만족도' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 템플릿정보
CREATE TABLE tc_tmplat_info
(
	TMPLAT_ID char(20) NOT NULL COMMENT '템플릿ID',
	TMPLAT_NM varchar(256) COMMENT '템플릿명',
	TMPLAT_SE_CD char(16) COMMENT '템플릿구분코드',
	TMPLAT_COURS varchar(512) COMMENT '템플릿경로',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (TMPLAT_ID)
) COMMENT = '템플릿정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자별권한
CREATE TABLE tc_user_author
(
	USER_ID varchar(64) NOT NULL COMMENT '사용자ID',
	USER_TY_CD varchar(16) NOT NULL COMMENT '사용자구분코드',
	AUTHOR_CD varchar(32) NOT NULL COMMENT '권한코드',
	PRIMARY KEY (USER_ID, USER_TY_CD, AUTHOR_CD)
) COMMENT = '사용자별권한' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자별 권한보호
CREATE TABLE tc_user_author_prtc
(
	MNNO int NOT NULL COMMENT '관리번호',
	USER_ID varchar(64) COMMENT '사용자ID',
	AUTHOR_USER_ID varchar(64) COMMENT '권한사용자ID',
	AUTHOR_CD varchar(32) COMMENT '권한코드',
	AUTHOR_DT datetime COMMENT '권한일시',
	AUTHOR_IPAD varchar(128) COMMENT '권한IP주소',
	AUTHOR_PURPS_SE text COMMENT '권한목적구분',
	PRIMARY KEY (MNNO)
) COMMENT = '사용자별 권한보호' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자메인콘텐츠관리
CREATE TABLE tc_user_main_cntnts
(
	RELM_SE_CD varchar(2) NOT NULL COMMENT '영역구분코드',
	MAIN_CNTNTS_CD varchar(16) COMMENT '메인콘텐츠코드',
	BBS_ID varchar(16) COMMENT '게시판ID',
	MENU_LINK varchar(512) COMMENT '메뉴링크',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	regist_dt datetime COMMENT '등록일시',
	regist_id varchar(64) COMMENT '등록ID',
	updt_dt datetime COMMENT '수정일시',
	updt_id varchar(64) COMMENT '수정ID',
	POPUP_AT char DEFAULT '1' COMMENT '팝업여부 ',
	MENU_NO int COMMENT '메뉴번',
	use_at varchar(1) COMMENT '사용여부',
	PRIMARY KEY (RELM_SE_CD)
) COMMENT = '사용자메인콘텐츠관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- uwam 관리사이트
CREATE TABLE tc_uwam_site
(
	site_sn int NOT NULL AUTO_INCREMENT COMMENT '사이트일련번호',
	user_sn int NOT NULL COMMENT '회원일련번호',
	site_se_cd varchar(32) COMMENT '사이트구분코드',
	site_nm varchar(256) DEFAULT '0' COMMENT '사이트명',
	site_alarm_cycle_cd varchar(64) DEFAULT '0' NOT NULL COMMENT '사이트경보주기코드',
	time_out_cycle varchar(10) DEFAULT '0' COMMENT '타임아웃주기',
	alarm_stop_dt datetime COMMENT '알람정지일시',
	site_title_tag_txt varchar(200) COMMENT '사이트 TITLE태그 텍스트',
	batch_execut_at char(1) DEFAULT 'N' COMMENT '배치실행여부',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	PRIMARY KEY (site_sn)
) COMMENT = 'uwam 관리사이트' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- uwam 사이트경보log
CREATE TABLE tc_uwam_site_alarm_log
(
	log_sn int NOT NULL AUTO_INCREMENT COMMENT '로그일련번호',
	url_sn int NOT NULL COMMENT 'URL 일련번호',
	http_rspns_code varchar(3) DEFAULT '''000''' COMMENT 'HTTP응답코드',
	rspns_error_mssage varchar(500) COMMENT '응답에러메세지',
	rspns_succes_at char(1) COMMENT '응답성공여부',
	regist_dt datetime COMMENT '등록일시',
	PRIMARY KEY (log_sn)
) COMMENT = 'uwam 사이트경보log' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- uwam 사이트URL
CREATE TABLE tc_uwam_site_url
(
	url_sn int NOT NULL COMMENT 'URL 일련번호',
	site_sn int NOT NULL COMMENT '사이트일련번호',
	detail_url_nm varchar(256) COMMENT '상세URL명',
	check_url varchar(256) COMMENT '체크URL',
	delete_cd char(1) COMMENT '삭제코드',
	PRIMARY KEY (url_sn)
) COMMENT = 'uwam 사이트URL';


-- uwam시이트URL최종상태
CREATE TABLE tc_uwam_site_url_last_state
(
	url_sn int NOT NULL COMMENT 'URL 일련번호',
	rspns_succes_at char(1) COMMENT '응답성공여부',
	last_updt_dt datetime COMMENT '최종수정일시',
	PRIMARY KEY (url_sn)
) COMMENT = 'uwam시이트URL최종상태';


-- 비주얼관리
CREATE TABLE tc_visual
(
	VISUAL_NO int NOT NULL COMMENT '비주얼번호',
	VISUAL_NM varchar(256) NOT NULL COMMENT '비주얼명',
	VISUAL_URLAD varchar(512) COMMENT '비주얼URL주소',
	VISUAL_SE varchar(16) COMMENT '비주얼구분',
	SORT_ORDR int COMMENT '정렬순서',
	EXPSR_AT char COMMENT '노출여부',
	DEPT_ID varchar(16) COMMENT '부서ID',
	SITE_ID_SE varchar(512) COMMENT '사이트ID구분',
	SITE_ID varchar(32) COMMENT '사이트ID',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	BGNDE datetime COMMENT '시작일',
	ENDDE datetime COMMENT '종료일',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (VISUAL_NO)
) COMMENT = '비주얼관리' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 용어사전
CREATE TABLE tc_word_dicary
(
	MNNO int NOT NULL COMMENT '관리번호',
	WORD_SE varchar(64) COMMENT '용어구분',
	WORD_NM varchar(256) COMMENT '용어명',
	WORD_ENG_NM varchar(1024) COMMENT '용어영문명',
	WORD_ENG_ABRV_NM varchar(1024) COMMENT '용어영문약어명',
	WORD_DFN text COMMENT '용어정의',
	THEMA_AREA_SE varchar(1024) COMMENT '주제영역구분',
	CREAT_DE varchar(10) COMMENT '생성일자',
	use_at varchar(1) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
	regist_id varchar(64) COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (MNNO)
) COMMENT = '용어사전' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 부서정보
CREATE TABLE tm_dept_info
(
	DEPT_ID varchar(16) NOT NULL COMMENT '부서ID',
	DEPT_CD varchar(32) COMMENT '부서코드',
	DEPT_KOR_NM varchar(512) NOT NULL COMMENT '부서한글명',
	DEPT_ENG_NM varchar(512) COMMENT '부서영문명',
	UPPER_DEPT_ID varchar(16) COMMENT '상위부서코드',
	DEPT_LEVEL int COMMENT '부서레벨',
	SORT_ORDR int NOT NULL COMMENT '정렬순서',
	DEPT_JOB_CN text COMMENT '부서업무내용',
	DEPT_INFO text COMMENT '부서정보',
	DEPT_TELNO varchar(128) COMMENT '부서전화번호',
	DEPT_FAXNO varchar(128) COMMENT '부서팩스번호',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	use_at varchar(1) DEFAULT 'Y' COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (DEPT_ID)
) COMMENT = '부서정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 로그인이력
CREATE TABLE tm_login_hist
(
	HIST_NO int NOT NULL COMMENT '이력번호',
	SITE_ID varchar(32) DEFAULT '''''bos''''' NOT NULL COMMENT '사이트ID',
	USER_ID varchar(64) NOT NULL COMMENT '사용자ID',
	USER_IPAD varchar(64) COMMENT '사용자IP주소',
	STTUS_CD varchar(16) COMMENT '상태코드',
	LOGIN_DT datetime COMMENT '로그인일시',
	PRIMARY KEY (HIST_NO)
) COMMENT = '로그인이력' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 관리자정보
CREATE TABLE tm_mngr_info
(
	USER_ID varchar(64) NOT NULL COMMENT '사용자ID',
	USER_SN int NOT NULL COMMENT '사용자일련번호',
	USER_NM varchar(256) COMMENT '사용자명',
	PASSWORD varchar(256) NOT NULL COMMENT '비밀번호',
	SEAT_NO int COMMENT '좌석번호',
	AUTHOR_CD varchar(32) COMMENT '권한코드',
	USER_CPNO varchar(32) COMMENT '사용자휴대전화번호',
	USER_IPAD varchar(64) COMMENT '사용자IP주소',
	USER_EMAD varchar(512) COMMENT '사용자이메일주소',
	STTUS_CD varchar(16) COMMENT '상태코드',
	delete_cd char(1) DEFAULT '0' NOT NULL COMMENT '삭제코드',
	use_at varchar(1) COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	DEPT_ID varchar(16) NOT NULL COMMENT '부서ID',
	PRIMARY KEY (USER_ID)
) COMMENT = '관리자정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자정보
CREATE TABLE tm_user_info
(
	USER_ID varchar(64) NOT NULL COMMENT '사용자ID',
	USER_SN int NOT NULL COMMENT '사용자일련번호',
	PASSWORD varchar(256) NOT NULL COMMENT '비밀번호',
	USER_TY_CD varchar(64) COMMENT '사용자타입코드',
	USER_NM varchar(256) COMMENT '사용자명',
	USER_EMAD varchar(512) COMMENT '사용자이메일주소',
	USER_CPNO varchar(32) COMMENT '사용자휴대전화번호',
	USER_TELNO varchar(32) COMMENT '사용자전화번호',
	USER_ZIP varchar(7) COMMENT '사용자우편번호',
	USER_ADRES1 varchar(256) COMMENT '사용자주소1',
	USER_ADRES2 varchar(512) COMMENT '사용자주소2',
	EMAIL_RECPTN_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '이메일수신여부',
	SMS_RECPTN_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT 'SMS수신여부',
	ENTRPRS_NO int COMMENT '기업체번호',
	STTUS_CD varchar(16) DEFAULT 'Y' COMMENT '상태코드',
	AUTHOR_CD varchar(32) COMMENT '권한코드',
	MNG_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'N' COMMENT '관리자여부',
	confm_at char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'N' COMMENT '승인여부',
	SEAT_NO int COMMENT '좌석번호',
	ATCH_FILE_ID varchar(32) COMMENT '첨부파일ID',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	DEPT_ID varchar(16) COMMENT '부서ID',
	last_login_dt datetime COMMENT '마지막로그인일시',
	PASSWORD_CHANGE_DT datetime COMMENT '비밀번호경일시',
	STPLAT_AGRE_DT datetime COMMENT '약관동의일',
	delete_cd char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '0' NOT NULL COMMENT '삭제코드',
	use_at varchar(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '사용여부',
	regist_id varchar(64) NOT NULL COMMENT '등록ID',
	regist_dt datetime COMMENT '등록일시',
	updt_id varchar(64) COMMENT '수정ID',
	updt_dt datetime COMMENT '수정일시',
	PRIMARY KEY (USER_ID)
) COMMENT = '사용자정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자정보보호
CREATE TABLE tm_user_info_prtc
(
	MNNO int NOT NULL COMMENT '관리번호',
	PAGE_NO int COMMENT '페이지번호',
	USER_ID varchar(64) COMMENT '사용자ID',
	READNG_USER_ID varchar(64) COMMENT '열람사용자ID',
	READNG_DT datetime COMMENT '열람일시',
	READNG_IPAD varchar(128) COMMENT '열람IP주소',
	READNG_URLAD varchar(512) COMMENT '열람URL주소',
	READNG_PURPS_SE text COMMENT '열람목적구분',
	PRIMARY KEY (MNNO)
) COMMENT = '사용자정보보호' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자개인식별번호
CREATE TABLE tm_user_pin
(
	USER_SN int NOT NULL COMMENT '사용자일련번호',
	USER_PIN varchar(128) DEFAULT '0' NOT NULL COMMENT '사죵자개인식별번호',
	USER_NM varchar(256) COMMENT '사용자명',
	CRTFC_SE_CD char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '인증구분코드',
	CHLD_CRTFC_AT char CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'N' NOT NULL COMMENT '미성년자인증여부',
	regist_dt datetime COMMENT '등록일시',
	updt_dt datetime COMMENT '수정일시',
	BRTHDY varchar(32) COMMENT '생년월일',
	SEX_CD char CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '성별코드',
	SITE_SE_CD char COMMENT '회원가입타입',
	PRIMARY KEY (USER_SN)
) COMMENT = '사용자개인식별번호' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 회원SALT정보
CREATE TABLE tm_user_salt
(
	USER_NO int NOT NULL COMMENT '일련번호',
	USER_SN int NOT NULL COMMENT '사용자일련번호',
	USER_ID varchar(64) COMMENT '사용자ID',
	USER_NM varchar(256) COMMENT '회원명',
	SALT varchar(256) NOT NULL COMMENT 'SALT',
	USER_SE char COMMENT '회원 구분',
	regist_dt datetime COMMENT '등록일시',
	PRIMARY KEY (USER_NO)
) COMMENT = '회원SALT정보' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사용자탈퇴
CREATE TABLE tm_user_secsn
(
	MNNO int NOT NULL COMMENT '관리번호',
	USER_ID varchar(64) COMMENT '사용자ID',
	USER_NM varchar(256) COMMENT '사용자명',
	USER_SECSN_DT datetime COMMENT '사용자탈퇴일시',
	USER_SECSN_MEMO text COMMENT '사용자탈퇴메모',
	PRIMARY KEY (MNNO)
) COMMENT = '사용자탈퇴' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- uwam 관리자
CREATE TABLE tm_uwam_admin
(
	user_sn int NOT NULL COMMENT '회원일련번호',
	user_nm varchar(64) COMMENT '사용자명',
	sns_id varchar(100) COMMENT 'sns ID',
	sns_se varchar(10) COMMENT 'sns 구분',
	user_emad varchar(200) COMMENT '사용자Email',
	use_at varchar(1) COMMENT '사용여부',
	app_token varchar(256) COMMENT '앱토큰',
	app_device_id varchar(50) COMMENT '앱디바이스ID',
	app_os varchar(50) COMMENT '앱 OS',
	app_ver varchar(20) COMMENT '앱버전',
	app_model varchar(50) COMMENT '앱모델',
	status_at char(1) COMMENT '상태여부',
	last_login_dt datetime COMMENT '마지막로그인일시',
	delete_cd char(1) COMMENT '삭제코드',
	regist_dt datetime COMMENT '등록일시',
	regist_id varchar(64) COMMENT '등록ID',
	updt_dt datetime COMMENT '수정일시',
	updt_id varchar(64) COMMENT '수정ID',
	confm_at char(1) COMMENT '승인여부',
	confm_dt datetime COMMENT '승일일시',
	confm_id varchar(64) COMMENT '승인ID',
	PRIMARY KEY (user_sn),
	CONSTRAINT unp_tm_uwam_admin_1 UNIQUE (sns_id, sns_se)
) COMMENT = 'uwam 관리자';


-- 공통파일다운로드집계
CREATE TABLE ts_cmmn_file_dwld_sm
(
	SM_NO int NOT NULL AUTO_INCREMENT COMMENT '집계번호',
	SM_DE char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '집계일자',
	ATCH_FILE_ID varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '첨부파일ID',
	FILE_SN int COMMENT '파일일련번호',
	MENU_NO int COMMENT '메뉴번호',
	DWLD_CO int DEFAULT 0 COMMENT '다운로드수',
	SITE_ID varchar(32) COMMENT '사이트ID',
	PRIMARY KEY (SM_NO)
) COMMENT = '공통파일다운로드집계' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 사이트접속통계집계
CREATE TABLE ts_site_conect_stats_sm
(
	SM_NO int NOT NULL AUTO_INCREMENT COMMENT '관리번호',
	SM_DE char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci COMMENT '접속일자',
	SM_SE varchar(16) COMMENT '집계구분',
	MENU_NO int COMMENT '메뉴번호',
	SM_SE_VALUE varchar(256) COMMENT '집계구분값',
	VISITR_CO int COMMENT '방문자수',
	PGE_VIEW_CO int COMMENT '페이지뷰수',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	PRIMARY KEY (SM_NO)
) COMMENT = '사이트접속통계집계' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


-- 만족도집계
CREATE TABLE ts_stsfdg_sm
(
	SM_NO int NOT NULL AUTO_INCREMENT COMMENT '집계번호',
	SM_DE char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '집계일자',
	SITE_ID varchar(32) NOT NULL COMMENT '사이트ID',
	MENU_NO int NOT NULL COMMENT '메뉴번호',
	PRTCPNT_CO int NOT NULL COMMENT '총참여자수',
	STSFDG_1_CO int DEFAULT 0 NOT NULL COMMENT '만족도1개수',
	STSFDG_2_CO int DEFAULT 0 NOT NULL COMMENT '만족도2개수',
	STSFDG_3_CO int DEFAULT 0 NOT NULL COMMENT '만족도3개수',
	STSFDG_4_CO int DEFAULT 0 NOT NULL COMMENT '만족도4개수',
	STSFDG_5_CO int DEFAULT 0 NOT NULL COMMENT '만족도5개수',
	PRIMARY KEY (SM_NO)
) COMMENT = '만족도집계' DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;



/* Create Foreign Keys */

ALTER TABLE tb_field_info
	ADD CONSTRAINT FK_TB_FIELD_INFO_ATTRB_INFO FOREIGN KEY (ATTRB_CD)
	REFERENCES tb_attrb_info (ATTRB_CD)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tb_bbs_estn
	ADD CONSTRAINT FK_TB_BBS_ESTN_BBS_MASTR FOREIGN KEY (BBS_ID)
	REFERENCES tb_bbs_mastr (BBS_ID)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_menu_author
	ADD CONSTRAINT FK_TC_MENU_AUTHOR_INFO FOREIGN KEY (AUTHOR_CD)
	REFERENCES tc_author_info (AUTHOR_CD)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_user_author
	ADD CONSTRAINT FK_TC_USER_AUTHOR_AUTHOR_INFO FOREIGN KEY (AUTHOR_CD)
	REFERENCES tc_author_info (AUTHOR_CD)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE tm_mngr_info
	ADD CONSTRAINT FK_TC_AUTHOR_INFO_MNGR_INFO FOREIGN KEY (AUTHOR_CD)
	REFERENCES tc_author_info (AUTHOR_CD)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_cmmn_cd_ctgry
	ADD CONSTRAINT FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL FOREIGN KEY (CL_CD)
	REFERENCES tc_cmmn_cd_cl (CL_CD)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_cmmn_cd_detail
	ADD CONSTRAINT FK_TC_CMMN_CD_DETAIL_CTGRY FOREIGN KEY (CD_ID)
	REFERENCES tc_cmmn_cd_ctgry (CD_ID)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_cmmn_cd_multi
	ADD CONSTRAINT FK_TC_CMMN_CD_MULTI_DETAIL FOREIGN KEY (CD_ID, CD)
	REFERENCES tc_cmmn_cd_detail (CD_ID, CD)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_cmmn_file_detail
	ADD CONSTRAINT FK_TC_CMMN_FILE_DETAIL_FILE FOREIGN KEY (ATCH_FILE_ID)
	REFERENCES tc_cmmn_file (ATCH_FILE_ID)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_mngr_main_estbs_detail
	ADD CONSTRAINT FK_TC_MNGR_MAIN_ESTBS_DETAIL FOREIGN KEY (MNNO)
	REFERENCES tc_mngr_main_estbs (MNNO)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_qustnr_answer
	ADD CONSTRAINT FK_QUSTNR_ANSWER_QESITM FOREIGN KEY (QESITM_SN)
	REFERENCES tc_qustnr_qesitm (QESITM_SN)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_uwam_site_url
	ADD FOREIGN KEY (site_sn)
	REFERENCES tc_uwam_site (site_sn)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tc_uwam_site_alarm_log
	ADD FOREIGN KEY (url_sn)
	REFERENCES tc_uwam_site_url (url_sn)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tc_uwam_site_url_last_state
	ADD FOREIGN KEY (url_sn)
	REFERENCES tc_uwam_site_url (url_sn)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE tb_bbs_cm
	ADD CONSTRAINT FK_TB_BBS_CM_USER_PIN FOREIGN KEY (USER_SN)
	REFERENCES tm_user_pin (USER_SN)
	ON UPDATE CASCADE
	ON DELETE NO ACTION
;


ALTER TABLE tc_uwam_site
	ADD FOREIGN KEY (user_sn)
	REFERENCES tm_uwam_admin (user_sn)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Create Indexes */

CREATE INDEX FK_TB_BBS_CM_USER_PIN USING BTREE ON tb_bbs_cm (USER_SN ASC);
CREATE INDEX FK_TB_BBS_ESTN_CMMN_FILE USING BTREE ON tb_bbs_estn (ATCH_FILE_ID ASC);
CREATE INDEX FK_TB_BBS_ESTN_USER_PIN USING BTREE ON tb_bbs_estn (USER_SN ASC);
CREATE INDEX I_TB_BBS_ESTN_01 USING BTREE ON tb_bbs_estn (BBS_ID ASC, delete_cd ASC, use_at ASC);
CREATE INDEX FK_TB_BBS_MASTR_TMPLAT_INFO USING BTREE ON tb_bbs_mastr (TMPLAT_ID ASC);
CREATE INDEX FK_TB_FIELD_INFO_ATTRB_INFO USING BTREE ON tb_field_info (ATTRB_CD ASC);
CREATE UNIQUE INDEX PK_TC_AUTHOR_SCLSRT USING BTREE ON tc_author_sclsrt (PARNTS_AUTHOR_CD ASC, CHLDRN_AUTHOR_CD ASC);
CREATE INDEX FK_TC_CMMN_CD_CTGRY_CMMN_CD_CL USING BTREE ON tc_cmmn_cd_ctgry (CL_CD ASC);
CREATE INDEX FK_TC_CMMN_CD_DETAIL_CTGRY USING BTREE ON tc_cmmn_cd_detail (CD_ID ASC);
CREATE UNIQUE INDEX PK_TC_CMMN_CD_MULTI USING BTREE ON tc_cmmn_cd_multi (CD_ID ASC, PROGRM_ID ASC, PROGRM_SN ASC, CD ASC);
CREATE INDEX FK_TC_CMMN_CD_MULTI_DETAIL USING BTREE ON tc_cmmn_cd_multi (CD_ID ASC, CD ASC);
CREATE UNIQUE INDEX PK_TC_CNTNTS_MANAGE USING BTREE ON tc_cntnts_manage (MENU_NO ASC, CNTNTS_MNNO ASC);
CREATE UNIQUE INDEX PK_TC_MENU_AUTHOR USING BTREE ON tc_menu_author (MENU_NO ASC, AUTHOR_CD ASC);
CREATE INDEX FK_TC_MENU_AUTHOR_INFO USING BTREE ON tc_menu_author (AUTHOR_CD ASC);
CREATE INDEX I_TC_MENU_INFO_01 USING BTREE ON tc_menu_info (SITE_ID ASC, BBS_ID ASC, MENU_NO ASC);
CREATE INDEX I_TC_MENU_INFO_02 USING BTREE ON tc_menu_info (SITE_ID ASC, UPPER_MENU_NO ASC, delete_cd ASC);
CREATE INDEX FK_QUSTNR_ANSWER_QESITM USING BTREE ON tc_qustnr_answer (QESITM_SN ASC);
CREATE INDEX SYS_C0025251 USING BTREE ON tc_site_info (ATCH_FILE_ID ASC);
CREATE INDEX FK_TC_USER_AUTHOR_AUTHOR_INFO USING BTREE ON tc_user_author (AUTHOR_CD ASC);
CREATE INDEX I_TC_WORD_DICARY_01 USING BTREE ON tc_word_dicary (WORD_SE ASC, WORD_ENG_ABRV_NM ASC);
CREATE INDEX FK_TC_AUTHOR_INFO_MNGR_INFO USING BTREE ON tm_mngr_info (AUTHOR_CD ASC);



