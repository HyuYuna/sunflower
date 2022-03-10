package site.unp.cms.service.auth.impl;


import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.auth.AuthService;
import site.unp.cms.service.singl.MenuService;
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
		pageQueryData="menuNo,searchCnd,searchKwd",
		sqlDaoRef="authDAO",
		listQueryId="findAllAuth",
		countQueryId="countAuth",
		viewQueryId="findOneAuth",
		insertQueryId="saveAuth",
		updateQueryId="modifyAuth",
		deleteQueryId="deleteAuth",
		listenerAndMethods={
				"accessLogListener=insert,update,delete"
			}
		)
@CommonServiceLink(desc="홈페이지 관리자 권한관리", linkType=LinkType.BOS)
@Service
public class AuthServiceImpl extends DefaultCrudServiceImpl implements AuthService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "menuService")
	private MenuService menuService;

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		List<String> authorities = UnpUserDetailsHelper.getAuthorities();
		if (!UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {
			param.put("authorities", authorities);
		}
		super.list(paramCtx);

	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String authorCd = param.getString("authorCd");

		ZValue upperAuthor = sqlDao.findOne("findOneAuthSclsrt", param);
		model.addAttribute("upperAuthor", upperAuthor);

		List<ZValue> authorList = sqlDao.findAll("findAllAuthList", param);
		model.addAttribute("authorList", authorList);

		List<String> authorities = UnpUserDetailsHelper.getAuthorities();
		if(authorities.contains(authorCd) || UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {
			super.forUpdate(paramCtx);
		}else {
			MVUtils.setResultProperty(model, ERROR, "접근할수 없는 권한입니다.");
			return;
		}
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> authorList = sqlDao.findAll("findAllAuthList", param);
		model.addAttribute("authorList", authorList);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		long cnt = sqlDao.count("countAuthDuplicate", param);
		if (cnt > 0) {
			MVUtils.setResultProperty(model, ERROR, "이미등록된 권한ID가 존재합니다.");
			return;
		}

		super.insert(paramCtx);
		sqlDao.save("saveAuthCode", param);
		sqlDao.save("saveAuthSclsrt", param);
		MVUtils.setResultProperty(model, SUCCESS, "등록 정상처리 하였습니다.");

	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		super.update(paramCtx);
		sqlDao.modify("modifyAuthSclsrt", param);
		MVUtils.setResultProperty(model, SUCCESS, "수정 정상처리 하였습니다.");

	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (("").equals(param.getString("authorCds")) && !("").equals(param.getString("authorCd"))) {
			param.put ("authorCds", param.getString("authorCd")+";");
		}

		String[] authorCds = param.getString("authorCds").split(";");
		for (int i = 0 ; i < authorCds.length; i++){
			sqlDao.deleteById("deleteMenuAuth", authorCds[i]);
			sqlDao.deleteById("deleteAuth", authorCds[i]);
		}
		MVUtils.setResultProperty(model, SUCCESS, "삭제 정상처리 하였습니다.");
	}


	public void forUpdateMenuAuth(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	ZValue result = sqlDao.findOne("findOneAuth", param);
    	ZValue sclsrt = sqlDao.findOne("findOneAuthSclsrt", param);

    	String chldrnAuthorCd = sclsrt.getString("chldrnAuthorCd");

    	param.put("upperAuthorCd", chldrnAuthorCd);
    	if(!chldrnAuthorCd.equals("ROLE_SUPER")) {
    		param.put("authorAt", "N");
    	}
    	List<ZValue> resultList = sqlDao.findAll("findAllMenuAuthView", param);
    	/*
    	List<ZValue> resultList = null;
    	if (!UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {
        	List<String> authorities = UnpUserDetailsHelper.getAuthorities();
        	param.put("authorities", authorities);
        	resultList = sqlDao.findAll("findAllMenuAuthByAuthorities", param);
    	}
    	else {
    		resultList = sqlDao.findAll("findAllMenuAuthView", param);
    	}
    	*/
    	HashMap<String, List<ZValue>> adminMenuCategoryMap = menuService.getMenuCategories(resultList);
    	HashMap<String, List<ZValue>> obj = menuService.setMenuCategory(adminMenuCategoryMap, "menu_0", 0, new String[6]);
        model.addAttribute("adminMenuCategoryMap", obj);
        model.addAttribute("resultVO", result);
	}

	public void insertMenuAuth(ParameterContext paramCtx) throws Exception {

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String authorCd = param.getString("authorCd");
    	String checkedMenuNoForInsert = "";
    	Set<String> menuNoSet = new HashSet<String>();
    	String[] checkFieldes = {param.getString("checkField")};
		if (param.get("checkField") != null) {
			if (param.get("checkField") instanceof String[]) {
				checkFieldes = (String[])param.get("checkField");
			}
		}

    	if (checkFieldes != null) {
    		String checkField = null;
    		String[] menuNoData = null;
    		for (int i=0; i<checkFieldes.length; i++) {
    			checkField = checkFieldes[i];
    			menuNoData = checkField.split("_");
    			for (int j=0; j<menuNoData.length; j++) {
    				menuNoSet.add(menuNoData[j]);
    			}
    		}

        	Object[] menuNoDataA = menuNoSet.toArray();
        	if (menuNoDataA != null) {
        		for (int i=0; i<menuNoDataA.length; i++) {
        			checkedMenuNoForInsert += menuNoDataA[i] + ",";
        		}
        	}
    	}

    	if (StringUtils.hasText("authorCd")){

    		long menuAuthCnt = sqlDao.count("countTcMenuAuth", param);
    		if(menuAuthCnt > 0){

    			sqlDao.deleteOne("deleteMenuAuth", param);
    		}
    	}

		if (StringUtils.hasText(checkedMenuNoForInsert)) {
			ZValue val = new ZValue();
			val.put("authorCd", authorCd);
			String [] insertMenuNo = checkedMenuNoForInsert.split(",");
			for (int i=0; i<insertMenuNo.length ; i++) {
				if (!"".equals(insertMenuNo[i])) {
					val.put("menuNo", Integer.parseInt(insertMenuNo[i]));
					val.put("userId", user.getUserId());
					sqlDao.save("saveMenuAuth", val);
				}
			}
		}

		/**
		 * 개인정보보호관련 - 메뉴권한이력 쌓기
		 */
		String[] menuAuthIDs = param.getString("menuAuthIDs").split("\\,");


		if (menuAuthIDs!=null && menuAuthIDs.length>0){
			// 권한 이력 메인 테이블 등록
			ZValue val = new ZValue();
			val.put("authorCd", authorCd);
			val.put("registId", user.getUserId());
			val.put("registNm", user.getUserNm());
			val.put("registIpad", paramCtx.getUserIp());
			val.put("authorDtls", "권한 등록 및 수정");
			sqlDao.save("saveMenuAuthHist", val);

			// 현재 권한에 속한 사용자 이력 쌓기
			sqlDao.save("saveMenuAuthUserHist", val);

			for (int i=0; i<menuAuthIDs.length;i++){
				// 권한 상세테이블 등록
				String[] menuNoAuthorSe = menuAuthIDs[i].split("\\|");
				if (menuNoAuthorSe[0]!=null && menuNoAuthorSe[0].length()>0){
					String[] menuNos = menuNoAuthorSe[0].split("\\_");
					String authorSe = menuNoAuthorSe[1];
					log.debug(menuNoAuthorSe[0]);
					log.debug(menuNoAuthorSe[1]);

					ZValue val2 = new ZValue();
					val2.put("histNo", val.getString("histNo"));
					val2.put("menuNo", menuNos[menuNos.length-1]);
					val2.put("authorSe", authorSe);
					val2.put("authorRm", authorSe.equals("I") ? "메뉴 권한 등록" : "메뉴 권한 제거");
					sqlDao.save("saveMenuAuthHistDetail", val2);
				}
			}
		}

		model.addAttribute(GO_URL_KEY, WebFactory.buildUrl("/bos/auth/auth/forUpdateMenuAuth.do", param, "authorCd", "menuNo"));
		model.addAttribute(MSG_KEY, "정상처리하였습니다.");
	}
}