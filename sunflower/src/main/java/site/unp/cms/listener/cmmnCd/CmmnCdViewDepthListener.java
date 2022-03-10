package site.unp.cms.listener.cmmnCd;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.service.cs.CommonService;
import site.unp.core.util.StrUtils;

public class CmmnCdViewDepthListener extends CmmnCdListListener {

	Logger log = LoggerFactory.getLogger(this.getClass());

	public static final String TARGET_MODEL_NAMES = "TARGET_MODEL_NAMES";
	private String rootYn = "Y";

	public CmmnCdViewDepthListener() {
	}

    public CmmnCdViewDepthListener(String codeId, String propertyName, String targetPropertyName) {
    	super(codeId, propertyName, targetPropertyName);
    }

    public CmmnCdViewDepthListener(String codeId, String propertyName, String targetPropertyName, String rootYn) {
    	super(codeId, propertyName, targetPropertyName);
    	setRootYn(rootYn);
    }

	@SuppressWarnings("unchecked")
	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		List<String> targetModelNames = (List<String>)model.get(TARGET_MODEL_NAMES);
		if (targetModelNames == null) {
			targetModelNames = new ArrayList<String>();
		}
		if (!targetModelNames.contains(CommonService.RESULT)) {
			targetModelNames.add(CommonService.RESULT);
		}
		if (!targetModelNames.contains(CommonService.RESULT_LIST)) {
			targetModelNames.add(CommonService.RESULT_LIST);
		}
		String depth = "Y".equals(rootYn) ? "0" : "";
		for (int i=0; i<getCodeIdData().size(); i++) {
			List<ZValue> codeList = getCodeDepthList(getCodeIdData().get(i),depth);
			for (String nm : targetModelNames) {
				Object trget = model.get(nm);
				if (trget != null) {
					if (trget instanceof List) {
						List<ZValue> resultList = (List<ZValue>)trget;
						for(ZValue vo : resultList) {
							String codeName = cmmnCdDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
							PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
						}
						
					}
					else if (trget instanceof ZValue) {
						ZValue result = (ZValue)trget;
						String codeName = getCmmnCdDetailDAO().getCodeName(result, codeList, getPropertyNames().get(i));
						result.put(getTargetPropertyNames().get(i), codeName);
					}
				}
			}
			String codeListNm = StrUtils.convert2CamelCase(getCodeIdData().get(i)) + "CodeList"; 
			model.addAttribute(codeListNm, codeList);
			model.addAttribute(("codeId"+i), getCodeIdData().get(i));
		}
	}

	public String getRootYn() {
		return rootYn;
	}

	public void setRootYn(String rootYn) {
		this.rootYn = rootYn;
	}
}
