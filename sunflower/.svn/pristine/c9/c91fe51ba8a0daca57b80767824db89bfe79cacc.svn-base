package site.dongjak.service.freecheck;

import javax.annotation.Resource;

import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.service.excel.ExcelMapping;
import site.unp.core.service.excel.ExcelMappingUtils;

@Component
public class xlsxChckBsshMapping implements ExcelMapping<ZValue, XSSFSheet> {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;

	@Override
	public ZValue mappingColumn(ZValue param, XSSFSheet sheet, int row) throws Exception {
		XSSFRow xssfRow = sheet.getRow(row);

		/*
		 * 예외처리 예제
		String serialNo = ExcelMappingUtils.getCellValue(xssfRow.getCell(2)); //일련번호
		if ( !StringUtils.hasText(serialNo) ) {
			throw new UnpBizException(row + "번째열 일련번호는 필수사항입니다");
		}
		*/

		String bsshNm = ExcelMappingUtils.getCellValue(xssfRow.getCell(0), true); //업소명
		String indutySn = ExcelMappingUtils.getCellValue(xssfRow.getCell(1), true); //업종번호
		String ceoNm = ExcelMappingUtils.getCellValue(xssfRow.getCell(2), true); //대표자명
		String ceoBrthdy = ExcelMappingUtils.getCellValue(xssfRow.getCell(3), true); //대표자생년월일
		String prmisnNo = ExcelMappingUtils.getCellValue(xssfRow.getCell(4), true); //등록번호
		String bsshTelno = ExcelMappingUtils.getCellValue(xssfRow.getCell(5), true); //전화번호
		String bsshFaxno = ExcelMappingUtils.getCellValue(xssfRow.getCell(6), true); //팩스번호
		String ceoCpno = ExcelMappingUtils.getCellValue(xssfRow.getCell(7), true); //휴대폰
		String bsshEmad = ExcelMappingUtils.getCellValue(xssfRow.getCell(8), true); //이메일
		String bsshZip = ExcelMappingUtils.getCellValue(xssfRow.getCell(9), true); //우편번호
		String bsshAddr1 = ExcelMappingUtils.getCellValue(xssfRow.getCell(10), true); //주소1
		String bsshAddr2 = ExcelMappingUtils.getCellValue(xssfRow.getCell(11), true); //주소2


		ZValue dataVal = new ZValue();
		dataVal.putAll(param);
		dataVal.put("bsshNm", bsshNm);
		dataVal.put("indutySn", indutySn);
		dataVal.put("ceoNm", ceoNm);
		dataVal.put("ceoBrthdy", ceoBrthdy);
		dataVal.put("prmisnNo", prmisnNo);
		dataVal.put("bsshTelno", bsshTelno);
		dataVal.put("bsshFaxno", bsshFaxno);
		dataVal.put("ceoCpno", ceoCpno);
		dataVal.put("bsshEmad", bsshEmad);
		dataVal.put("bsshZip", bsshZip);
		dataVal.put("bsshAddr1", bsshAddr1);
		dataVal.put("bsshAddr2", bsshAddr2);

		return dataVal;
	}

}
