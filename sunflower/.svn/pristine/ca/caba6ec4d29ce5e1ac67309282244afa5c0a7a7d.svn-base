package site.unp.cms.service.bbs.attrb;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.util.NamedMapBeansFactory;

public abstract class AbstractPageGenerator implements PageGenerator {

	protected final String REPLACE_COLGROUP_MARK = "<!-- colgroup contents -->";
	protected final String REPLACE_THEAD_MARK = "<!-- thead contents -->";
	protected final String REPLACE_TBODY_MARK = "<!-- tbody contents -->";
	protected final String REPLACE_NAME_MARK = "[fieldName]";
	protected final String REPLACE_TEXT_MARK = "[fieldText]";
	protected final String REPLACE_TYPE_MARK = "[fieldType]";
	protected final String REPLACE_PAGE_CODE_MARK = "[attrbCd]";
	protected final String CONFLICT_PROPERTY_MARK = "@{";
	protected final String REPLACE_CONFLICT_PROPERTY_MARK = "${";
	
	@Resource(name = "pgNamedMapBeansFactory")
	protected NamedMapBeansFactory fatory;

	@Resource(name = "SqlDAO")
	protected ISqlDAO<ZValue> pageGeneratorDAO;

	@Resource(name="siteInfoDAO")
	private SiteInfoDAO siteInfoDAO;

    @Resource(name = "ucmsPageCodeGnrService")
    protected EgovIdGnrService idgenService;

	public PageTemplate[] getPageTemplates(ZValue param){
		Object[] objs = fatory.getBeans(param.getString("attrbTyCd"));
		PageTemplate[] templates = Arrays.copyOf(objs, objs.length, PageTemplate[].class);
		return templates;
	}

	@Override
	public void getPageAttrList(ZValue param, ModelMap model) throws Exception {
		model.addAttribute("resultList", pageGeneratorDAO.findAll("findAllAttrbInfo"));
	}

	@Override
	public void addPageAttribute(ZValue param, ModelMap model) throws Exception {
		param.set("attrbCd", idgenService.getNextStringId());
		pageGeneratorDAO.save("saveAttrbInfo", param);
	}

	@Override
	public void updatePageAttribute(ZValue param, ModelMap model) throws Exception {
		pageGeneratorDAO.modify("modifyAttrbInfo", param);
	}

	@Override
	public void deletePageAttribute(ZValue param, ModelMap model) throws Exception {
		long cnt = pageGeneratorDAO.count("countFieldInfoByAttrbCd", param);
		if (cnt > 0) {
			throw new UnpBizException("필드리스트가 존재하여 삭제할 수 없습니다. 필드리스트를 먼저 삭제하세요.");
		}
		pageGeneratorDAO.deleteById("deleteAttrbInfoByAttrbCd", param.getString("attrbCd"));
	}

	@Override
	public void readPageInfo(ZValue param, ModelMap model) throws Exception {
		ZValue result = pageGeneratorDAO.findOneById("findOneAttrbInfoByAttrbCd", param.getString("attrbCd"));
		result.set("tableNm", result.getString("tableNm"));
		result.set("attrbTyCd", param.getString("attrbTyCd"));
		List<ZValue> fieldAttributes = pageGeneratorDAO.findAll("findAllFieldInfo", result);
		model.addAttribute("result", result);
		model.addAttribute("fieldAttributes", fieldAttributes);

		List<ZValue> siteList = siteInfoDAO.getSiteList();
		model.addAttribute("siteList", siteList);
		
		Map<String, String> attrbTyCdMap = fatory.getBeanNameMap();
		model.addAttribute("attrbTyCdMap", attrbTyCdMap);
	}

	@Override
	public void createPage(ZValue param, ModelMap model) throws Exception {
		PageTemplate[] templates = getPageTemplates(param);
		for (PageTemplate template : templates) {
			doCreatePage(template, param, model);
		}
	}
	
	public abstract void doCreatePage(PageTemplate template, ZValue param, ModelMap model) throws Exception;

	@Override
	public void selectAllFieldList(ZValue param, ModelMap model) throws Exception {
		PageTemplate[] templates = getPageTemplates(param);
		Assert.notEmpty(templates);

		PageTemplate template = templates[0];
		model.addAttribute("fieldAttributes", template.selectFieldAttributeList(param));
	}

	@Override
	public void addFieldAttribute(ZValue param, ModelMap model) throws Exception {
		String attrbCd = param.getString("attrbCd");
		String attrbTyCd = param.getString("attrbTyCd");
		Assert.hasText(attrbCd);
		Assert.hasText(attrbTyCd);
		pageGeneratorDAO.deleteOne("deleteFieldInfo", param);

		int fieldOrdr = 0;
		List<String> indexes = param.getList("fieldAttributeIdx");
		for(String index : indexes)
		{
			String fieldIemNm = param.getString("fieldIemNm_" + index);
			String fieldDc = param.getString("fieldDc_" + index);
			String fieldTyCd = param.getString("fieldTyCd_" + index);
			String listUseAt = param.getString("listUseAt_" + index);
			ZValue val = new ZValue();
			val.put("attrbCd", attrbCd);
			val.put("attrbTyCd", attrbTyCd);
			val.put("fieldIemNm", fieldIemNm);
			val.put("fieldDc", fieldDc);
			val.put("fieldTyCd", fieldTyCd);
			val.put("listUseAt", listUseAt);
			val.put("fieldOrdr", fieldOrdr++);
			pageGeneratorDAO.save("saveFieldInfo", val);
		}
	}

	@Override
	public void updateFieldAttributeOrdr(ZValue param, ModelMap model) throws Exception {
		addFieldAttribute(param, model);
	}
}
