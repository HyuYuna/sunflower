package site.unp.cms.service.bbs.attrb;

import java.util.ArrayList;
import java.util.List;

import site.unp.core.ZValue;

public class BbsPageTemplate extends PageTemplateImpl {

	@Override
	public List<ZValue> selectAllFieldList(ZValue param) throws Exception {
		
		List<ZValue> resultList = new ArrayList<ZValue>();
		ZValue val = new ZValue();
		val.put("fieldNm", "BBS_SE_CD");
		val.put("fieldDc", "구분");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "SECRET_AT");
		val.put("fieldDc", "공개여부");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTT_SJ");
		val.put("fieldDc", "제목");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_NM");
		val.put("fieldDc", "작성자");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_TELNO");
		val.put("fieldDc", "전화번호");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_CPNO");
		val.put("fieldDc", "핸드폰번호");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_EMAD");
		val.put("fieldDc", "이메일");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_ZIP");
		val.put("fieldDc", "우편번호");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_ADRES1");
		val.put("fieldDc", "기본주소");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTCR_ADRES2");
		val.put("fieldDc", "상세주소");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "NTT_CN");
		val.put("fieldDc", "내용");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "ATCH_FILE_ID");
		val.put("fieldDc", "첨부");
		val.put("fieldTyCd", "");
		resultList.add(val);

		for(int i=1; i<=15; i++){
			val = new ZValue();
			val.put("fieldNm", "OPTION"+i);
			val.put("fieldTyCd", "");
			resultList.add(val);
		}

		val = new ZValue();
		val.put("fieldNm", "REGIST_DT");
		val.put("fieldDc", "등록일");
		val.put("fieldTyCd", "");
		resultList.add(val);

		val = new ZValue();
		val.put("fieldNm", "INQIRE_CO");
		val.put("fieldDc", "조회수");
		val.put("fieldTyCd", "");
		resultList.add(val);
		
		List<ZValue> fieldAttributes = pageGeneratorDAO.findAll("findAllFieldInfoDesc");
		for (ZValue fvo : resultList) {
			for (ZValue _fvo : fieldAttributes) {
				if (fvo.getString("fieldNm").equals(_fvo.getString("fieldNm"))) {
					fvo.set("checkedYn", "Y");
					fvo.set("fieldTyCd", _fvo.getString("fieldTyCd"));
					fvo.set("fieldDc", _fvo.getString("fieldDc"));
					fvo.set("listUseAt", _fvo.getString("listUseAt"));
				}
			}
		}
		return resultList;
	}

}
