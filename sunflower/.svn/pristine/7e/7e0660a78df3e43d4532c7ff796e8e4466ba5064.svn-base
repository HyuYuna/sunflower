package site.unp.cms.service.siteManage.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import com.nhncorp.lucy.security.xss.XssPreventer;

import site.unp.cms.service.singl.MenuService;
import site.unp.cms.service.siteManage.SiteHpcmService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
		pageQueryData="menuNo,viewType"
)
@CommonServiceLink(desc="사이트 도움말 관리 프로그램")
@Service
public class SiteHpcmServiceImpl extends DefaultCrudServiceImpl implements SiteHpcmService{

	@Resource(name = "menuService")
	private MenuService menuService;

	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.insert(paramCtx);

		paramCtx.getModel().addAttribute("cHpcmNo", param.getString("hpcmNo"));
	}

	/**
	 * 도움말목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext paramCtx) throws Exception {

	}

	/**
	 * 도움말 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void listJson(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (StringUtils.hasText(param.getString("cHpcmNo"))) {
			ZValue result = sqlDao.findOneById("findOneByIdSiteHpcm", param);
			String hpcmCn = XssPreventer.unescape(result!=null ? result.getString("hpcmCn") : "");
			result.put("hpcmCn",hpcmCn);
			// 세부 도움말 항목
			List<ZValue> subList = sqlDao.findAll("findAllSiteHpcmByHpcmNo", param);
			if (result==null) result= new ZValue();
			result.putObject("subList", subList);
			model.addAttribute("singleJsonData", result);
		}
		else {
			List<ZValue> listMenu = sqlDao.findAll("findAllSiteHpcm", param);
			model.addAttribute("singleJsonData", listMenu);
		}
	}

	/**
	 * 도움말 맵핑 메뉴정보 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void menuListJson(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (StringUtils.hasText(param.getString("cHpcmNo"))) {

			List<ZValue> menuList = sqlDao.findAll("findAllMenuByHpcmNo", param);
			model.addAttribute("menuList", menuList);
		}
	}

	@UnpJsonView
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.update(paramCtx);

		// 메뉴 선택 정보 삭제 후 insert
		ZValue tempMap = new ZValue();
		tempMap.put("hpcmNo", param.get("hpcmNo"));
		//delete
		sqlDao.deleteOne("deleteSiteHpcmMenu", tempMap);

		// insert
		List<String> menuNos = param.getList("menuNos");
		for (int i=0; i<menuNos.size();i++){
			tempMap.put("menuNo", menuNos.get(i));
			sqlDao.save("saveSiteHpcmMenu", tempMap);
		}
	}

	/**
	 * 도움말 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSiteHpcmNm(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

		sqlDao.modify("updateSiteHpcmNm", param);
		model.addAttribute("cDeptId", param.getString("cDeptId"));
		model.addAttribute("useAt", param.getString("useAt"));

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 도움말을 마우스 드래그로 이동 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateUpperHpcmNo(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	sqlDao.modify("updateForUpperHpcmNo", param);
    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	public void view(ParameterContext paramCtx) throws Exception {
		super.view(paramCtx);
	}

	/**
	 * 도움말 최상위/상위/하위/최하위 이동
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateMoveHpcmNo(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String[] listHpcm = param.getString("hpcmData").split(",");
		int ordr = 0;
		for (String hpcmNo : listHpcm) {
			param.put("hpcmOrdr", ordr += 10);
			param.put("cHpcmNo", hpcmNo);
			sqlDao.modify("updateMoveHpcmNo", param);
		}

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
		super.delete(paramCtx);
	}

	@SuppressWarnings("unchecked")
	public void menuLinkPop(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		menuService.menuLinkPop(paramCtx);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/singl/menu/menuLinkPop.jsp");
	}

}
