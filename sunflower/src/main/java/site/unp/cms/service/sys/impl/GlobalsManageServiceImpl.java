package site.unp.cms.service.sys.impl;


import java.util.List;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.sys.GlobalsManageService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
	pageQueryData="menuNo,searchWrd,searchCnd"
)
@CommonServiceLink(desc="글로벌 환경변수 관리", linkType=LinkType.BOS)
@Service
public class GlobalsManageServiceImpl extends DefaultCrudServiceImpl implements GlobalsManageService{

	@SuppressWarnings("unchecked")
	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<ZValue> resultList = (List<ZValue>)model.get(RESULT_LIST);
		if (CollectionUtils.isNotEmpty(resultList)) {
			Properties p = globalsProperties.getFileProperties();
			for (ZValue val : resultList) {
				String key = val.getString("attrbNm");
				String value = p.getProperty(key);
				if (StringUtils.hasText(value)) {
					val.putObject("attrbValue", value);
				}
			}
		}
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (sqlDao.count("countGlobalsManageAttrbNmCnt", param) > 0) {
			MVUtils.goUrl("javascript:history.back();", "중복된 속성명입니다.", model);
			return;
		}
		super.insert(paramCtx);

		globalsProperties.reload();
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (sqlDao.count("countGlobalsManageAttrbNmCnt", param) > 0) {
			MVUtils.goUrl("javascript:history.back();", "중복된 속성명입니다.", model);
			return;
		}
		super.update(paramCtx);

		globalsProperties.reload();
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		super.delete(paramCtx);

		globalsProperties.reload();
	}

}
