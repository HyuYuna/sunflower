package site.unp.cms.listener.cmmnCd;

import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

public class CmmnCdViewListener extends CmmnCdListListener {

	Logger log = LoggerFactory.getLogger(this.getClass());

	public CmmnCdViewListener() {
	}

    public CmmnCdViewListener(String codeId, String propertyName, String targetPropertyName) {
    	super(codeId, propertyName, targetPropertyName);
    }

	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue)model.get("result");
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		for(int i=0; i<getCodeIdData().size(); i++){
			List<ZValue> codeList = getCodeList(getCodeIdData().get(i));
			if( result != null ) {
				String codeName = getCmmnCdDetailDAO().getCodeName(result, codeList, getPropertyNames().get(i));
				result.put(getTargetPropertyNames().get(i), codeName);
			}
			if (model.get("resultList") != null) {
				for(ZValue vo : resultList)
				{
					String codeName = cmmnCdDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
					PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
				}
			}

			model.addAttribute(getCodeIdData().get(i) + "CodeList", codeList);
		}
	}
}
