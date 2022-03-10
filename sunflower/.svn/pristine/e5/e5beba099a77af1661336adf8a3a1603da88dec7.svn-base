package site.unp.cms.service.main.impl;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.main.MainMypageService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		pageQueryData="",
		sqlDaoRef="mainMypageDAO",
		listenerAndMethods={
			"accessLogListener=insert,update,delete"
		}
	)

@CommonServiceLink(desc="마이페이지 메인관리", linkType=LinkType.BOS)
@Service
public class MainMypageServiceImpl extends DefaultCrudServiceImpl implements MainMypageService {

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginId", user.getUserId());
		super.view(paramCtx);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginId", user.getUserId());

/*System.out.println("::::::::insert");*/
        sqlDao.save("saveMainMypage", param);

        String goUrl = WebFactory.buildUrl("/bos/main/mainMypage/view.do", param, "mypageSn", "menuNo");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginId", user.getUserId());

        sqlDao.save("updateMainMypage", param);

        /*System.out.println("::::::::update");*/

        String goUrl = WebFactory.buildUrl("/bos/main/mainMypage/view.do", param, "mypageSn", "menuNo");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
	}
}
