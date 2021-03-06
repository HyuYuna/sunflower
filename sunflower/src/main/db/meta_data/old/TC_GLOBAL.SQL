INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (1, 'Globals.webRootPath', 'D:/newProject/ucms/workspace/ucms22/src/main/webapp', '웹루트경로', 'Y', '', '2017-01-24 17:04:26', '', '2017-01-24 17:50:33');

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (2, 'Globals.logPath', 'D:/newProject/ucms/logs', '로그경로', 'Y', '', '2017-01-24 17:16:25', '', NULL);

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (3, 'Globals.fileStorePath', 'D:/newProject/ucms/workspace/ucms22/upload', '업로드경로', 'Y', '', '2017-01-24 17:16:49', 'admin', '2017-02-06 17:08:12');

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (4, 'Globals.progrmApplcnt.zipDir', 'D:/newProject/ucms/workspace/ucms22/upload/zip', '첨부파일 zip압축 파일경로', 'Y', '', '2017-01-24 17:17:03', '', NULL);

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (5, 'Globals.atchFile.limitSize', '20MB', '파일 용량 제한', 'Y', '', '2017-01-24 17:17:16', '', NULL);

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (6, 'Globals.imgFile.limitSize', '2MB', '이미지 용량 제한', 'Y', '', '2017-01-24 17:17:28', 'admin', '2017-02-09 16:42:52');

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (7, 'Service.siteMng.allowExt', 'doc,txt', '첨부가능 파일확장자(테스트용)', 'Y', '', '2017-01-24 17:17:41', 'admin', '2017-02-06 13:53:27');

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (8, 'Globals.allowExt', '', '첨부가능 파일확장자(디폴트 비어있을경우 모두허용)', 'Y', '', '2017-01-24 17:18:44', '', NULL);

INSERT INTO TC_GLOBAL
  (ATTRB_SN, ATTRB_NM, ATTRB_VALUE, ATTRB_DC, USE_AT, REGIST_ID, REGIST_DT, UPDT_ID, UPDT_DT)
VALUES
  (9, 'Globals.testMode', 'N', '테스트모드(메뉴,게시판마스터정보 미리불러오기 유무 - 테스트모드일경우 불러오지않음)', 'Y', '', '2017-01-24 17:19:00', 'admin', '2017-02-06 18:26:09');

