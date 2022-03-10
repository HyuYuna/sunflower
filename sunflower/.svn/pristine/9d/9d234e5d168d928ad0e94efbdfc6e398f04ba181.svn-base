package site.unp.cms.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.cs.CommonService;

@Component
public class BosAccessListener extends CommonListenerSupport {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void before(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		if (!SiteInfoService.BOS_SITE_ID.equals(param.getString(CommonService.SITE_ID))) {
			throw new UnsupportedOperationException("잘못된 접근입니다.");
		}
	}
}
