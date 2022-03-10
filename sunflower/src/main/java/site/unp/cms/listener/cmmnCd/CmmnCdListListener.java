package site.unp.cms.listener.cmmnCd;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import site.unp.cms.dao.cmmnCd.CmmnCdDetailDAO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.listener.CommonListenerSupport;

public class CmmnCdListListener extends CommonListenerSupport implements InitializingBean {

	Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource(name="cmmnCdDetailDAO")
    protected CmmnCdDetailDAO cmmnCdDetailDAO;
    protected List<String> codeIdData;
    protected List<String> propertyNames;
    protected List<String> targetPropertyNames;

    public CmmnCdListListener(){
    }

    public CmmnCdListListener(String codeId, String propertyName, String targetPropertyName){
    	codeIdData = new ArrayList<String>();
    	propertyNames = new ArrayList<String>();
    	targetPropertyNames = new ArrayList<String>();
    	codeIdData.add(codeId);
    	propertyNames.add(propertyName);
    	targetPropertyNames.add(targetPropertyName);
    }

	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		for(int i=0; i<codeIdData.size(); i++){
			List<ZValue> codeList = getCodeList(codeIdData.get(i));
			for(ZValue vo : resultList)
			{
				String codeName = cmmnCdDetailDAO.getCodeName(vo, codeList, propertyNames.get(i));
				PropertyUtils.setProperty(vo, targetPropertyNames.get(i), codeName);
			}
			model.addAttribute(codeIdData.get(i) + "CodeList", codeList);
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notEmpty(codeIdData);
		Assert.notEmpty(propertyNames);
		Assert.notEmpty(targetPropertyNames);

		int codeIdDataSize = codeIdData.size();
		int propertyNameSize = propertyNames.size();
		int targetPropertyNameSize = targetPropertyNames.size();
		if( !(codeIdDataSize == propertyNameSize && propertyNameSize == targetPropertyNameSize) )
			throw new IllegalArgumentException("codeIdData 크기와 property 크기와 targetProperty 크기가 같지않습니다.");
	}

	public List<ZValue> getCodeList(String codeId) throws Exception
	{
		Assert.hasText(codeId);
		ZValue param = new ZValue();
		param.put("cdId", codeId);
		List<ZValue> codeResult = cmmnCdDetailDAO.findAllCmmnCdDetail(param);
		return codeResult;
	}

	public List<ZValue> getCodeDepthList(String codeId, String upperCode) throws Exception
	{
		Assert.hasText(codeId);
		ZValue param = new ZValue();
		param.put("cdId", codeId);
		List<ZValue> codeResult = cmmnCdDetailDAO.findAllCmmnCdDetail(param);
		return codeResult;
	}

	public CmmnCdDetailDAO getCmmnCdDetailDAO() {
		return cmmnCdDetailDAO;
	}

	public void setCmmnCdDetailDAO(CmmnCdDetailDAO cmmnCdDetailDAO) {
		this.cmmnCdDetailDAO = cmmnCdDetailDAO;
	}

	public List<String> getCodeIdData() {
		return codeIdData;
	}

	public List<String> getPropertyNames() {
		return propertyNames;
	}

	public List<String> getTargetPropertyNames() {
		return targetPropertyNames;
	}

	public void setCodeIdData(List<String> codeIdData) {
		this.codeIdData = codeIdData;
	}

	public void setPropertyNames(List<String> propertyNames) {
		this.propertyNames = propertyNames;
	}

	public void setTargetPropertyNames(List<String> targetPropertyNames) {
		this.targetPropertyNames = targetPropertyNames;
	}
}
