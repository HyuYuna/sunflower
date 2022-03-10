package site.unp.cms.service.cmmn.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.unp.cms.service.cmmn.CmmnMenuService;
import site.unp.cms.service.singl.MenuService;
import site.unp.core.ParameterContext;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.CommonServiceImpl;

@CommonServiceDefinition(
)
@Service
public class CmmnMenuServiceImpl extends CommonServiceImpl implements CmmnMenuService {

	@Resource(name = "menuService")
	private MenuService menuService;

	public void listMenuPop(ParameterContext paramCtx) throws Exception {
		//menuListPop
	}

	/**
	 * 메뉴목록 조회 - (json type으로 조회)
 	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void listJson(ParameterContext paramCtx) throws Exception {
		menuService.listJson(paramCtx);
	}

}
