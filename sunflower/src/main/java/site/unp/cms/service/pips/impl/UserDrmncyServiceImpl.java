package site.unp.cms.service.pips.impl;


import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.pips.UserDrmncyService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
		pageQueryData	= "menuNo,searchCnd,searchKwd,searchFlag,sdate,edate,pageUnit,pSiteId"
)
@Service
public class UserDrmncyServiceImpl extends DefaultCrudServiceImpl implements UserDrmncyService{

	@CommonServiceLinks({
		@CommonServiceLink(desc="휴면 사용자", linkType=LinkType.BOS, paramString="pSiteId=ucms")
	})
	public void list(ParameterContext paramCtx) throws Exception {
		ModelMap map = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		String sdate, edate ="";

		if (param.getString("sdate").equals("") || param.getString("edate").equals("")){
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -7); //1일 더하기
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			sdate = fmt.format(new java.util.Date(cal.getTime().getTime()));
			edate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} else {
			sdate = param.getString("sdate");
			edate = param.getString("edate");
		}
		param.put("sdate", sdate);
		param.put("edate", edate);

		super.list(paramCtx);
	}
}
