package site.unp.cms.service.wa.impl;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import site.unp.cms.service.wa.DgnssService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.CommonServiceImpl;

@CommonServiceDefinition(
		pageQueryData	= "menuNo,searchCnd,sMenuNo,prsecYm,pSiteId"
	)
@Service
public class DgnssServiceImpl extends CommonServiceImpl implements DgnssService {

	@CommonServiceLink(desc="웹접근성 자동점검", linkType=LinkType.USER)
	@SuppressWarnings("deprecation")
	public void rcord(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		Assert.hasText(param.getString("siteId"));
		
		sqlDao.save("saveDgnssRecord", param);
		
		model.addAttribute(WINDOW_MODE, STREAM_WINDOW_MODE);
	}
}
