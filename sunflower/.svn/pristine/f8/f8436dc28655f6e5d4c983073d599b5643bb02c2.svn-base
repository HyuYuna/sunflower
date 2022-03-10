package site.unp.cms.service.scheduler;

import java.awt.Color;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.collections.map.ListOrderedMap;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.util.DateUtil;

@Component
public class LogDataHistoryScheduleService {

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Value("#{prop['Globals.ucms.logFileStorePath']}") private String logFileStorePath;

	public void initSetValue(ZValue zvl){

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		cal.add(Calendar.DATE, -1);
		zvl.put("saveYear", cal.get(Calendar.YEAR));
		zvl.put("searchDate", sdf.format(cal.getTime()));

	}

	public void saveExcelFile(String gubun) throws Exception {

		ZValue zvl = new ZValue();
		initSetValue(zvl);

		String fileName = "";
		String queryId = "";
		String logFilePath = logFileStorePath + "/" + zvl.getString("saveYear") + "/" + gubun;
		String [] title = null;

		if("userInfoPrtc".equals(gubun)){													// 사용자정보조회
			fileName = "사용자 정보";
			queryId = "findAllUserInfoPrtcExcel";
			title = new String[]{"일련번호", "메뉴번호", "메뉴명", "로그인ID", "열람사용자ID", "열람일시", "열람IP주소", "열람URL주소", "열람목적구분"};
		}else if("menuAuthPrtc".equals(gubun)){													// 메뉴권한조회
			fileName = "메뉴권한";
			queryId = "findAllMenuAuthPrtcExcel";
			title = new String[]{"일련번호", "권한코드", "권한명", "사용자명(사용자ID)", "메뉴명(접근내용)", "변경자ID", "변경자명", "변경자IP주소", "권한비고"};
		}else if("mngrAuthPrtc".equals(gubun)){													// 사용자별 권한조회
			fileName = "사용자별 권한";
			queryId = "findAllMngrAuthPrtcExcel";
			title = new String[]{"이력번호",  "사용자ID", "사용자일련번호", "사용자명", "권한코드", "권한명", "사용자휴대전화번호", "사용자전화번호","사용자이메일주소","상태코드","상태요약","등록ID","등록일시","등록IP주소"};
		}

		List<ZValue> resultList = sqlDAO.findAll(queryId, zvl);

		String excelFile = fileName + "_" + zvl.getString("searchDate") + ".xls";
		String fullPath = logFilePath + "/" + excelFile;

		File saveFolder = new File(logFilePath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		// Header Format
		WritableFont wf1 = new WritableFont(WritableFont.ARIAL, 13, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
		WritableCellFormat cf1 = new WritableCellFormat(wf1);
		cf1.setBorder(Border.ALL, BorderLineStyle.THIN);
		cf1.setBackground(Colour.YELLOW);
		cf1.setAlignment(Alignment.CENTRE);

		// Header & Data Format
		WritableFont wf2 = new WritableFont(WritableFont.ARIAL, 11, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.BLACK, ScriptStyle.NORMAL_SCRIPT);
		WritableCellFormat cf2 = new WritableCellFormat(wf2);
		cf2.setShrinkToFit(true);
		cf2.setBorder(Border.ALL, BorderLineStyle.THIN);
		cf2.setAlignment(Alignment.CENTRE);

		WritableWorkbook workBook = Workbook.createWorkbook(new File(fullPath));
		WritableSheet sheet = workBook.createSheet(fileName, 0);

		for(int i = 0; i < title.length; i++){
			sheet.addCell(new Label (i, 1, title[i], cf1));

			if("userInfoPrtc".equals(gubun) && i == 7){
				sheet.setColumnView(i, 70);
			}else{
				sheet.setColumnView(i, 20);
			}
		}

		ListOrderedMap lom = null;
		int colCnt = 0;

		if(resultList != null && resultList.size() > 0){
			for(int i = 0; i < resultList.size(); i++){

				lom = (ListOrderedMap)resultList.get(i);
				colCnt = 0;

				if("userInfoPrtc".equals(gubun)){

					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(i+1), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("pageNo")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("pageNm")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("userId")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("readngUserId")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("readngDt")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("readngIpad")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("readngUrlad")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("readngPurpsSe")), cf2));

				}else if("menuAuthPrtc".equals(gubun)){

					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(i+1), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorCd")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorNm")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("userNms")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("menuNms")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("registId")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("registDt")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("registIpad")), cf2));//
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorDtls")), cf2));

				}else if("mngrAuthPrtc".equals(gubun)){

					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(i+1), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("userId")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorUserId")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorCd")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorNm")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorDt")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorIpad")), cf2));
					sheet.addCell(new Label(colCnt++, i+2, String.valueOf(lom.get("authorPurpsSe")), cf2));
				}
			}
		}
		workBook.write();
		workBook.close();

	}

	/**
	 * 사용자정보조회를 일별로 집계하여 엑셀파일로 저장한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "10 * * * * *")
	@Scheduled(cron = "0 00 1 * * *")
	public void saveUserInfoPrtcExcelFile() throws Exception {
		saveExcelFile("userInfoPrtc");
	}

	/**
	 * 메뉴권한조회 내역을 일별로 집계하여 엑셀파일로 저장한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "20 * * * * *")
	@Scheduled(cron = "0 30 1 * * *")
	public void saveMenuAuthPrtcExcelFile() throws Exception {
		saveExcelFile("menuAuthPrtc");
	}

	/**
	 * 사용자별 권한 내역을 일별로 집계하여 엑셀파일로 저장한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "30 * * * * *")
	@Scheduled(cron = "0 00 2 * * *")
	public void saveMngrAuthPrtcExcelFile() throws Exception {
		saveExcelFile("mngrAuthPrtc");
	}

}
