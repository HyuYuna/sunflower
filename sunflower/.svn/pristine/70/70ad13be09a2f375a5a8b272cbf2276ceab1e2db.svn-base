package site.unp.cms.service.singl.impl;


import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import egovframework.rte.fdl.string.EgovDateUtil;
import site.unp.cms.dao.singl.SiteConectStatsDAO;
import site.unp.cms.service.singl.SiteConectStatsService;
import site.unp.cms.util.UriUtil;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.CommonServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.DateUtil;
import site.unp.core.util.HttpUtil;

@CommonServiceDefinition(
	//sqlDaoRef		= "StsfdgDAO",
	pageQueryData	= "menuNo,searchCnd,sMenuNo,stsfdgIdex,sdate,edate,smonth,emonth",
	sqlDaoRef="siteConectStatsDAO",
	listenerAndMethods={
		"userInitParamListener=insert,update,delete,listDate"
	}
)
@Service
public class SiteConectStatsServiceImpl extends CommonServiceImpl implements SiteConectStatsService{

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
				//cal.add(Calendar.DATE, -6);
				cal.add(Calendar.DATE, +1);
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

		param.put("pSiteId", param.getString("pSiteId", "ucms"));
	}

	/**
	 * 일자별 페이지뷰 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="홈페이지 접속통계", linkType=LinkType.BOS, paramString="pSiteId=ucms")
	public void listDate(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "PD");
		initSetValue(param);
		List<ZValue> resultList = getSqlDao(SiteConectStatsDAO.class).listDate(param);

		model.addAttribute("resultList", resultList);
	}

	/**
	 * 일자별 페이지뷰 JSON
	 * @param paramCtx
	 * @throws Exception
	 */
	public void findAllBySiteConectCount(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "PD");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listDate(param);

		model.addAttribute("resultList", resultList);

	}

	/**
	 * 메뉴별 페이지뷰 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listMenu(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		// 목록 조회시 top 20 기능 없음
		param.put("smSe", "MENU");
		param.put("searchGb",param.getString("searchGb", "Y"));

		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listMenu(param);
		model.addAttribute("resultList", resultList);

		param.put("pSiteId", "ucms");
		model.addAttribute("menuList", sqlDao.findAll("findAllMenuByParam",param));
	}


	/**
	 * 메뉴별 페이지뷰 JSON
	 * @param paramCtx
	 * @throws Exception
	 */
	public void findAllBySiteMenuConectCount(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		// 차트 조회시 top 20 기능
		param.put("smSe", "MENU");
		param.put("searchGb",param.getString("searchGb", "N"));

		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listMenu(param);
		model.addAttribute("resultList", resultList);

	}

	/**
	 * 운영체제별 페이지뷰 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listOs(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "OS");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listOs(param);
		model.addAttribute("resultList", resultList);
	}


	/**
	 * 운영체제별 페이지뷰 JSON
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void findAllBySiteOsConectCount(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "OS");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listOs(param);
		model.addAttribute("resultList", resultList);

	}

	/**
	 * 브라우저별 페이지뷰 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listBrowser(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "BROWSER");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listBrowser(param);
		model.addAttribute("resultList", resultList);
	}

	/**
	 * 브라우저별 페이지뷰 JSON
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void findAllBySiteBrowserConectCount(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "BROWSER");
		initSetValue(param);

		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listBrowser(param);
		model.addAttribute("resultList", resultList);

	}

	/**
	 * PC/MOBILE별 페이지뷰 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listPcMobile(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "PM");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listPcMobile(param);
		model.addAttribute("resultList", resultList);
	}

	/**
	 * 유입경로 시각화(Sankey) 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listSankey(ParameterContext paramCtx) throws Exception {

	}

	/**
	 * 유입경로 시각화(Sankey) 통계 data
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void findSankeyConectData(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("pSiteId", (param.getString("pSiteId").equals("") ? "ucms" : param.getString("pSiteId")));

		List<ZValue> nodes =  getSqlDao(SiteConectStatsDAO.class).listSankeyNodes(param);
		ZValue noMap = new ZValue();
		for (ZValue node : nodes){
			noMap.put(node.getString("menuNo"), node.getInt("mno"));
		}

		List<ZValue> links =  getSqlDao(SiteConectStatsDAO.class).listSankeyLinks(param);
		HashMap<String, List<ZValue>> resultMap = new HashMap<String, List<ZValue>>();
		for (ZValue link : links){
			link.put("source", noMap.get(link.getString("beforeMenuNo")));
			link.put("target", noMap.get(link.getString("menuNo")));
		}
		resultMap.put("nodes", nodes);
		resultMap.put("links", links);

		model.addAttribute("result", resultMap);
	}

	/**
	 * PC/MOBILE별 페이지뷰 JSON
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void findAllBySitePcMobileConectCount(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("smSe", "PM");
		initSetValue(param);
		List<ZValue> resultList =  getSqlDao(SiteConectStatsDAO.class).listPcMobile(param);
		model.addAttribute("resultList", resultList);

	}




	/**
	 * 홈페이지 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void excelDown(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		String excelTitle = "";
		if("date".equals(param.getString("excelTp"))){
			listDate(paramCtx);
			//excelTitle = "사이트 기간별 통계";
			excelTitle = "DATE";
		}else if("menu".equals(param.getString("excelTp"))){
			listMenu(paramCtx);
			//excelTitle = "메뉴별 통계";
			excelTitle = "MENU";
		}else if("os".equals(param.getString("excelTp"))){
			listOs(paramCtx);
			//excelTitle = "운영체제별 통계";
			excelTitle = "OS";
		}else if("browser".equals(param.getString("excelTp"))){
			listBrowser(paramCtx);
			//excelTitle = "브라우져별 통계";
			excelTitle = "BROWSER";
		}else if("pcMobile".equals(param.getString("excelTp"))){
			listPcMobile(paramCtx);
			//excelTitle = "PC/MOBILE 통계";
			excelTitle = "DEVICE";
		}



		HttpServletResponse response = paramCtx.getResponse();
		String filename = URLEncoder.encode("UCMS_"+ excelTitle + "_" + EgovDateUtil.getCurrentDateAsString(), "UTF-8");
    	response.setHeader("Content-Disposition", "attachment; filename="+ filename + ".xls;");
    	response.setHeader("Content-Description", filename);
    	response.setContentType("application/vnd.ms-excel");
	}


	/**
	 * 접속 통계 기록(화면단에서 script 호출)
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void rcord(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		ModelMap map = paramCtx.getModel();

		//접속로그 기록
		if (param.getString("siteId")!=null){
			String beforeMenuNo = session.getAttribute("beforeMenuNo")==null ? null : session.getAttribute("beforeMenuNo").toString();
			UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String loginDt = formatter.format(session.getCreationTime());

			if (user != null) {
				param.put("userId", user.getUserId());
				param.put("userNm", user.getUserNm());
				param.put("loginDt", loginDt);
			} else {
				param.put("userId", "-");
				param.put("userNm", "비로그인");
				param.put("loginDt", loginDt);
			}
			String conectUrlad = param.getString("conectUrlad", "");
			/**
			 * 메뉴번호가 없는 경우중 url이 메인인 경우는 1로.. 그렇지 않은경우는 0으로 데이터를 세팅하여 통계시 0인 데이터는 추출하지 않는다.
			 */

			if("".equals(param.getString("menuNo",""))){
				if(conectUrlad.indexOf("main/main.do") > -1 || conectUrlad.indexOf("bos/loginProcess.do")>-1){
					param.remove("menuNo");
					param.put("menuNo", "1");
					beforeMenuNo = "1";
				}else{
					param.remove("menuNo");
					param.put("menuNo", "0");
					beforeMenuNo = null;
				}
			}
			
			/*else {
				param.put("menuNo", request.getParameter("menuNo")==null ? 0 : param.get("menuNo"));
			}*/
/*			
			if ("".equals(param.getString("menuNo", ""))) {
				if (request.getRequestURI().indexOf("main/main.do") > -1) {
					param.put("menuNo", "1");
				} else {
					param.put("menuNo", "0");
				}
			}
			
*//*
			if (param.getStringArr("menuNo").length>1){
				param.put("menuNo", param.getStringArr("menuNo")[0]);
			}else {
				System.out.println(request.getParameter("menuNo"));
			}*/
			
			
			/*param.put("menuNo", request.getParameter("menuNo"));*/
		
			
			
			
			String methodId = conectUrlad.substring(conectUrlad.lastIndexOf("/"),conectUrlad.length());
			String ghvrSumry = UriUtil.getGhvrSumry(conectUrlad);

			param.put("sesionId", request.getSession().getId());
			param.put("conectUrlad", conectUrlad);
			param.put("conectOpersysmNm", HttpUtil.getClientOS(request));
			param.put("conectWbsrNm", HttpUtil.getClientBrowser(request));
			param.put("conectPcMobileSe", HttpUtil.getPcMobileSe(request));
			param.put("beforeMenuNo", beforeMenuNo);
			param.put("ghvrSumry", ghvrSumry);
			param.put("userIpad", request.getRemoteAddr());
			/*System.out.println("connn");*/

			//sqlDao.save("saveSiteConectStats", param);

			session.setAttribute("beforeMenuNo", param.getString("menuNo")); //이전화면의 메뉴번호를 저장하기 위해 세션 사용
		}

		paramCtx.getModel().addAttribute(WINDOW_MODE, STREAM_WINDOW_MODE);
	}

}

