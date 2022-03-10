package site.unp.cms.service.singl.impl;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.singl.ErrorLogService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;


@CommonServiceDefinition(
		pageQueryData="sdate,edate,viewType,searchCnd,searchWrd,menuNo"
		)
@CommonServiceLink(desc="에러 로그 관리", linkType=LinkType.BOS)
@Service
public class ErrorLogServiceImpl extends DefaultCrudServiceImpl implements ErrorLogService{

	public void initSetValue(ZValue param){

		/**
		 * 지정일이 없는 경우에는 한달치 정보를 제공한다.
		 * 달력 지정일이 있는 경우에는 최대 한달간의 정보를 제공한다.
		 */
			if (!StringUtils.hasText(param.getString("sdate")) || !StringUtils.hasText(param.getString("edate"))) {
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				//cal.add(Calendar.DATE, -1);
				param.put("edate", sdf.format(cal.getTime()));
				//cal.add(Calendar.DATE, -6);
				cal.add(Calendar.DATE, +1);
				cal.add(Calendar.MONTH, -1);
				param.put("sdate", sdf.format(cal.getTime()));
			}
	}

	public void ErrorLog(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.findOne("findOneErrorLog", param);
		model.addAttribute("result", result);
	}

	/*	기간별 에러 통계	*/
	public void listDate(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		initSetValue(param);
		List<ZValue>result = sqlDao.findAll("findAllErrorDateLogCount", param);
		model.addAttribute("result", result);
	}

	/*	유형별 에러 통계	*/
	public void listType(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		initSetValue(param);
		List<ZValue>result = sqlDao.findAll("findAllErrorTypeLogCount", param);
		model.addAttribute("result", result);
	}

	/*	URL별 에러 통계	*/
	public void listUrlAd(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		initSetValue(param);
		List<ZValue>result = sqlDao.findAll("findAllErrorUrlAdLogCount", param);
		model.addAttribute("result", result);
	}

}