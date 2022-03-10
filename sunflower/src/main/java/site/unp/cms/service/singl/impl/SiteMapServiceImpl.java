package site.unp.cms.service.singl.impl;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.singl.SiteMapService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.cs.impl.CommonServiceImpl;

@CommonServiceDefinition(
		pageQueryData="menuNo"
	)
@CommonServiceLink(desc="사이트맵 프로그램", linkType=LinkType.USER)
@Service
public class SiteMapServiceImpl extends CommonServiceImpl implements SiteMapService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	public void list(ParameterContext paramCtx) throws Exception {
		// jsp 페이지
	}

	public void popupList(ParameterContext paramCtx) throws Exception {
		// jsp 페이지
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();


		model.addAttribute(UriModelAndViewResolver.RETURN_PAGE, "ucms/singl/siteMap/popupList");
	}

}
