package site.unp.cms.service.singl.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.singl.PrsnlInorcService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
	pageQueryData="menuNo,sdate,edate,searchCnd,searchWrd,viewType"
)

@CommonServiceLink(desc="개인정보 조직도", linkType=LinkType.BOS)
@Service
public class PrsnlInorcServiceImpl extends DefaultCrudServiceImpl implements PrsnlInorcService {

	public void orgCht(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        List<ZValue> resultList = sqlDao.findAll("findAllOrgChtList");
        model.addAttribute("resultList", resultList);


	}
}