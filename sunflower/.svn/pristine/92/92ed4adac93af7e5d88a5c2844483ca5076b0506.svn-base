package site.unp.cms.web.bbs;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.web.DefaultCommonControllerBase;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.conf.CommonServiceFactory;
import site.unp.core.service.bbs.BoardServiceFactory;

@Controller
@RequestMapping("/{siteId}/bbs/{bbsId}")
public class BoardController extends DefaultCommonControllerBase {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@Resource(name="boardServiceFactory")
	public void setCommonServiceFactory(CommonServiceFactory commonServiceFactory) {
		super.setCommonServiceFactory(commonServiceFactory);
	}

	@Override
	protected ParameterContext setProperty(HttpServletRequest request, HttpServletResponse response, ZValue param, ModelMap model) throws Exception{
		ParameterContext paramCtx = super.setProperty(request, response, param, model);
		ZValue paramVO = paramCtx.getParam();
		paramVO.put("groupId", "bbs");
		setMasterVO(paramVO, model);
		return paramCtx;
	}

	@Override
	protected String getProgramId(ParameterContext paramCtx) {
		return paramCtx.getParam().getString("bbsId");
	}

	private void setMasterVO(ZValue paramVO, ModelMap model) throws Exception {
		String bbsId = paramVO.getString("bbsId");
		Assert.hasText(bbsId, "[bbsId] parameter must have text");

		ZValue masterVO = ((BoardServiceFactory)commonServiceFactory).getBoardMaster(bbsId);
		Assert.notNull(masterVO, "[masterVO] must not be null");
		log.debug("masterVO : " + masterVO);
		model.addAttribute("masterVO", masterVO);

		paramVO.put("tableNm", masterVO.getString("tableNm"));
	}
}
