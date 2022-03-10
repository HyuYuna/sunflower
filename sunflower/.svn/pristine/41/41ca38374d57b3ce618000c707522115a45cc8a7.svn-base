package site.unp.cms.service.singl.impl;


import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import egovframework.rte.fdl.string.EgovDateUtil;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.singl.StsfdgService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
	//sqlDaoRef		= "StsfdgDAO",
	pageQueryData	= "menuNo,searchWrd,sMenuNo,pSiteId,stsfdgIdex,sdate,edate",
	listenerAndMethods={
		"userInitParamListener=insert,update,delete"
	}
)
@CommonServiceLink(desc="만족도 관리 통계", linkType=LinkType.BOS, paramString="pSiteId=ucms")
@Service
public class StsfdgServiceImpl extends DefaultCrudServiceImpl  implements StsfdgService{

	/**
	 * 만족도 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (!StringUtils.hasText(param.getString("sdate")) || !StringUtils.hasText(param.getString("edate"))) {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			cal.add(Calendar.DATE, -1);
			param.put("edate", sdf.format(cal.getTime()));
			cal.add(Calendar.MONTH, -1);
			param.put("sdate", sdf.format(cal.getTime()));

			model.addAttribute("date", param);
		}

		model.addAttribute("deptList", sqlDao.findAll("findAllDeptInfo"));
		model.addAttribute("menuList", sqlDao.findAll("findAllMenuByParam",param));

		model.addAttribute("resultList", sqlDao.findAll("findStsfdgResult",param));
	}

	/**
	 * 만족도 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		long cnt = sqlDao.count("countStsfdgDuplicate", param);

		if (cnt == 0) {
			sqlDao.save("saveStsfdg", param);
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		}
		else  {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, "duplicate");
		}

	}

	/**
	 * 만족도 상세
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		model.addAttribute("result", sqlDao.findOne("findStsfdgResult", param));
		super.doList(paramCtx, "findAllStsfdg", "countStsfdg");
	}

	/**
	 * 만족도 관리 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void excelDown(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		model.addAttribute("resultList", sqlDao.findAll("findStsfdgResult",param));

		HttpServletResponse response = paramCtx.getResponse();
		String filename = URLEncoder.encode("UCMS_만족도관리_"+ EgovDateUtil.getCurrentDateAsString(), "UTF-8");
    	response.setHeader("Content-Disposition", "attachment; filename="+ filename + ".xls;");
    	response.setHeader("Content-Description", filename);
    	response.setContentType("application/vnd.ms-excel");
	}
}
