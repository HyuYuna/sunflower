package site.unp.cms.service.singl.impl;


import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import egovframework.rte.fdl.string.EgovDateUtil;
import site.unp.cms.dao.singl.CmmnFileDwldStatsDAO;
import site.unp.cms.service.singl.CmmnFileDwldStatsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.DateUtil;
import site.unp.core.util.HttpUtil;

@CommonServiceDefinition(pageQueryData = "menuNo,searchCnd,sMenuNo,stsfdgIdex,sdate,edate,smonth,emonth",
		sqlDaoRef="cmmnFileDwldStatsDAO",
		listenerAndMethods = { "userInitParamListener=insert,update,delete,listDate" })
@CommonServiceLink(desc = "첨부파일 다운로드 통계", linkType = LinkType.BOS, paramString="pSiteId=ucms")
@Service
public class CmmnFileDwldStatsServiceImpl extends DefaultCrudServiceImpl implements CmmnFileDwldStatsService{

	public void initSetValue(ZValue param){

		/**
		 * D : 일간, M : 월간
		 * 일간 검색인 경우 중 달력 지정일이 없는 경우에는 일주일치 정보를 제공한다.
		 * 일간 검색인 경우 중 달력 지정일이 있는 경우에는 최대 한달간의 정보를 제공한다.
		 * 월간 검색인 경우 중 달력 지정일이 없는 경우에는 현재 월의 정보를 제공한다.
		 * 월간 검색인 경우 중 달력 지정일이 있는 경우에는 최대 12개월의 정보를 제공한다.
		 */
		if("D".equals(param.getString("searchCnd", "D"))){
			if (!StringUtils.hasText(param.getString("sdate")) || !StringUtils.hasText(param.getString("edate"))) {
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				cal.add(Calendar.DATE, -1);
				param.put("edate", sdf.format(cal.getTime()));
				cal.add(Calendar.MONTH, -1);
				param.put("sdate", sdf.format(cal.getTime()));
			}
			param.put("searchCnd","D");
		}else{
			if (!StringUtils.hasText(param.getString("smonth")) || !StringUtils.hasText(param.getString("emonth"))) {
				Calendar cal = Calendar.getInstance();
				param.put("emonth", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH)+1)));
				param.put("smonth", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH))));
			}
			param.put("searchCnd","M");
		}
		param.put("searchYn", "Y");
		param.put("pSiteId", param.getString("pSiteId", "ucms"));
	}

	/**
	 * 다운로드 통계
	 *
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		initSetValue(param);
		List<ZValue> resultList = getSqlDao(CmmnFileDwldStatsDAO.class).listDwld(param);
		model.addAttribute("resultList", resultList);
	}

	/**
	 * 다운로드 통계 엑셀다운로드
	 *
	 * @param paramCtx
	 * @throws Exception
	 */
	public void excelDown(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String excelTitle = "다운로드 통계";

		HttpServletResponse response = paramCtx.getResponse();

		StringBuilder sb = new StringBuilder();
		sb.append("UCMS_").append(excelTitle).append("_").append(EgovDateUtil.getCurrentDateAsString());
		String filename = URLEncoder.encode(sb.toString() ,"UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xls;");
		response.setHeader("Content-Description", filename);
		response.setContentType("application/vnd.ms-excel");

		List<ZValue> resultList = getSqlDao(CmmnFileDwldStatsDAO.class).listDwld(param);
		model.addAttribute("resultList", resultList);
	}

	/**
	 * 접속 통계 기록(화면단에서 script 호출)
	 *
	 * @param paramCtx
	 * @throws Exception
	 */
	public void rcord(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();

		// 접속로그 기록
		if (param.getString("siteId") != null && !"bos".equals(param.getString("siteId"))) {

			/**
			 * 메뉴번호가 없는 경우중 url이 메인인 경우는 1로.. 그렇지 않은경우는 0으로 데이터를 세팅하여 통계시 0인
			 * 데이터는 추출하지 않는다.
			 */
			if ("".equals(param.getString("menuNo", ""))) {
				if (request.getRequestURI().indexOf("main/main.do") > -1) {
					param.put("menuNo", "1");
				} else {
					param.put("menuNo", "0");
				}
			}
			param.put("sesionId", request.getSession().getId());
			param.put("conectUrlad", param.getString("conectUrlad", ""));
			param.put("conectOpersysmNm", HttpUtil.getClientOS(request));
			param.put("conectWbsrNm", HttpUtil.getClientBrowser(request));
			param.put("conectPcMobileSe", HttpUtil.getPcMobileSe(request));
			/*System.out.println("rcord-file");*/
			//sqlDao.save("saveSiteConectStats", param);
		}

		paramCtx.getModel().addAttribute(WINDOW_MODE, STREAM_WINDOW_MODE);
	}

}

