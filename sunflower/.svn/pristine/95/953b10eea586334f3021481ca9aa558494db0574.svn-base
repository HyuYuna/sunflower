package site.unp.cms.service.bbs.attrb.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import site.unp.cms.service.bbs.attrb.AttrbService;
import site.unp.cms.service.bbs.attrb.PageGenerator;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
	pageQueryData="tableName,menuNo"
)
@CommonServiceLink(desc="게시판 필드 속성 관리", groupId="bbs", link="/bos/bbs/attrb/list.do")
@Service
public class AttrbServiceImpl extends DefaultCrudServiceImpl implements AttrbService{

	@Resource(name = "xmlPageGenerator")
	private PageGenerator pageGenerator;

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.getPageAttrList(param, model);

		List<ZValue> tableList = sqlDao.findAll("findAllTable");
		model.addAttribute("tableList", tableList);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		List<ZValue> tableList = sqlDao.findAll("findAllTable");
		ModelMap model = paramCtx.getModel();
		model.addAttribute("tableList", tableList);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.addPageAttribute(param, model);
		MVUtils.setResultProperty(paramCtx.getModel(), SUCCESS, "정상처리하였습니다.");
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.readPageInfo(param, model);

		List<ZValue> tableList = sqlDao.findAll("findAllTable");
		model.addAttribute("tableList", tableList);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.updatePageAttribute(param, model);
		MVUtils.setResultProperty(paramCtx.getModel(), SUCCESS, "정상처리하였습니다.");
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.deletePageAttribute(param, model);
		MVUtils.setResultProperty(paramCtx.getModel(), SUCCESS, "정상처리하였습니다.");
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.readPageInfo(param, model);
	}

	public void selectAllFieldList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.selectAllFieldList(param, model);
	}

	public void addFieldAttr(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.addFieldAttribute(param, model);
		MVUtils.winCloseReload("정상처리하였습니다.", model);
	}

	@UnpJsonView
	public void createPage(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("attrbTyCd"));
		ModelMap model = paramCtx.getModel();
		pageGenerator.createPage(param, model);
		MVUtils.setResultProperty(paramCtx.getModel(), SUCCESS, "정상처리하였습니다.");
	}

	public void sortFieldAttr(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		pageGenerator.updateFieldAttributeOrdr(param, model);

		String link = WebFactory.buildUrl("/bos/bbs/attrb/view.do", param, "menuNo", "attrbCd", "attrbTyCd", "bbsId");
		MVUtils.goUrl(link.toString(), null, model);
	}
}
