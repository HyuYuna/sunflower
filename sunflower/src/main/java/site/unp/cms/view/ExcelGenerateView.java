package site.unp.cms.view;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import site.unp.core.domain.ExcelGenerateVO;

public class ExcelGenerateView extends AbstractView {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	public ExcelGenerateView(){
		super.setContentType("application/x-msexcel");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		ExcelGenerateVO excelVO = (ExcelGenerateVO)model.get("excel");
		String fileName = excelVO.getExcelFileName();

		SXSSFWorkbook objWorkBook = null;
		if (model.get("customTp") != null && "Y".equals((String)model.get("customTp"))) {
			objWorkBook = (SXSSFWorkbook)model.get("workBook");
		}
		else {
			objWorkBook = this.defaultRenderMergedOutputModel(model);
		}



		OutputStream out = null;
		try {
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-msexcel");
			//response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName + ".xls").getBytes("KSC5601"), "8859_1"));
			String header = request.getHeader("User-Agent");
			if(header.contains("MSIE") || header.contains("Trident")){ //ie일경우
				response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "utf-8") +".xls;");
			}else{
				response.setHeader("Content-Disposition", "attachment;filename=\""+ new String((fileName).getBytes("UTF-8"),"ISO-8859-1") +".xls\"");
			}

			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Cache-Control","max-age=0");
			//response.setHeader("pragma","no-cache");
			//response.setHeader("expires", "-1");

			out = response.getOutputStream();
			objWorkBook.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			log.error("엑셀 파일 생성 오류 [ 엑셀파일명 : " + fileName);
			e.printStackTrace();
		} finally {
			if ( out != null ) out.close();
			objWorkBook.dispose();
		}

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public SXSSFWorkbook defaultRenderMergedOutputModel(Map<String, Object> model) throws Exception {

		ExcelGenerateVO excelVO = (ExcelGenerateVO)model.get("excel");

		String[] excelTitle = excelVO.getTitle();
		List<?> dataList = excelVO.getDataList();

		// 워크북 생성
		SXSSFWorkbook objWorkBook = new SXSSFWorkbook();
		objWorkBook.setCompressTempFiles(true);
		// 워크시트 생성
		Sheet objSheet = objWorkBook.createSheet();

		// title 행생성
		Row titleRow = objSheet.createRow(0);

		CellStyle titleStyle = objWorkBook.createCellStyle();
		titleStyle.setFillForegroundColor(HSSFColor.LIME.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderLeft(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderRight(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderTop(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderBottom(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		//dataCell.setCellStyle(titleStyle);
		Font font = objWorkBook.createFont();
		font.setColor(HSSFColor.BLACK.index);
		titleStyle.setFont(font);


		// title 셀 생성
		for(int titleCnt = 0 ; titleCnt <  excelTitle.length; titleCnt++ ) {
			Cell objCell = titleRow.createCell(titleCnt);
			HSSFRichTextString richTextString = new HSSFRichTextString(excelTitle[titleCnt]);
			objCell.setCellValue(richTextString);
			objCell.setCellStyle(titleStyle);
			objSheet.setColumnWidth(titleCnt, 4000);
		}

		// row & cell 생성
		for ( int listCnt = 0 ; listCnt < dataList.size(); listCnt++  ) {
			Object obj = dataList.get(listCnt);
			Map<Object, Object> map = null;
			if (obj instanceof Map ){
				map = (Map)obj;
			}
			else{
				map = BeanUtils.describe(obj);
			}
			// 맵키추출
			Iterator<String> mapKeys = ((Set)map.keySet()).iterator();
			Row dataRow = objSheet.createRow(listCnt + 1);

			int cellCnt = 0;
			while (mapKeys.hasNext()) {
				String mapkey = mapKeys.next();
				String cellData = String.valueOf(map.get(mapkey));
				Cell dataCell = dataRow.createCell(cellCnt);
				HSSFRichTextString richTextString = new HSSFRichTextString("null".equals(cellData) ? "" : cellData);
				dataCell.setCellValue(richTextString);
				cellCnt++;
			}
			if (listCnt % 1000 == 0) {
                ((SXSSFSheet)objSheet).flushRows(1000); // retain 1000 last rows and flush all others

                // ((SXSSFSheet)sh).flushRows() is a shortcut for ((SXSSFSheet)sh).flushRows(0),
                // this method flushes all rows
           }
		}
		return objWorkBook;

	}
}
