package site.dongjak.service.freecheck;

import javax.annotation.Resource;

import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import jxl.Cell;
import jxl.Sheet;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.service.excel.ExcelMapping;
import site.unp.core.util.StrUtils;

@Component
public class xlsChckBsshMapping implements ExcelMapping<ZValue, Sheet> {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;

	@Override
	public ZValue mappingColumn(ZValue param, Sheet sheet, int row) throws Exception {
		Cell cell0 = sheet.getCell(0,row);
		Cell cell1 = sheet.getCell(1,row);
		Cell cell2 = sheet.getCell(2,row);
		Cell cell3 = sheet.getCell(3,row);
		Cell cell4 = sheet.getCell(4,row);
		Cell cell5 = sheet.getCell(5,row);
		Cell cell6 = sheet.getCell(6,row);
		Cell cell7 = sheet.getCell(7,row);
		Cell cell8 = sheet.getCell(8,row);
		Cell cell9 = sheet.getCell(9,row);
		Cell cell10 = sheet.getCell(10,row);
		Cell cell11 = sheet.getCell(11,row);

		/*
		 * 예외처리예제
		ZValue newParam = new ZValue();
		newParam.put("serialNo", serialNo);
		if ( sqlDao.selectCount("ReceiptMngDao_dupSerialNoBySerialNo", newParam) > 0) {
			throw new UnpBizException("중복된 일련번호가 있습니다.");
		}
		*/

		String bsshNm = cell0.getContents(); //업소명
		String indutySn = cell1.getContents(); //업종번호
		String ceoNm = cell2.getContents(); //대표자명
		String ceoBrthdy = cell3.getContents(); //대표자생년월일
		String prmisnNo = cell4.getContents(); //등록번호
		String bsshTelno = cell5.getContents(); //전화번호
		String bsshFaxno = cell6.getContents(); //팩스번호
		String ceoCpno = cell7.getContents(); //휴대폰
		String bsshEmad = cell8.getContents(); //이메일
		String bsshZip = cell9.getContents(); //우편번호
		String bsshAddr1 = cell10.getContents(); //주소1
		String bsshAddr2 = cell11.getContents(); //주소2


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
