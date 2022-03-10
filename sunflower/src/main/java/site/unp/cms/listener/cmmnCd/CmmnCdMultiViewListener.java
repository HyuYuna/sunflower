package site.unp.cms.listener.cmmnCd;

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
import site.unp.core.dao.ISqlDAO;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.util.CacheUtil;
import site.unp.core.util.StrUtils;

/**
 * @author jks
 *
 */
public class CmmnCdMultiViewListener extends CommonListenerSupport implements InitializingBean {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	@Resource(name="cmmnCdDetailDAO")
    protected CmmnCdDetailDAO cmmnCdDetailDAO;

	private String cdId = "";
	private String propertyName = "";
	private String targetPropertyName = "";
	private String progrmId = "";
	private String progrmSn = "";
	private String rootYn = "Y";

	public CmmnCdMultiViewListener() {

	}

    public CmmnCdMultiViewListener(String cdId, String propertyName, String targetPropertyName, String progrmId, String progrmSn) {
    	this.setCdId(cdId);
    	this.setPropertyName(propertyName);
    	this.setTargetPropertyName(targetPropertyName);
    	this.setProgrmId(progrmId);
    	this.setProgrmSn(progrmSn);
    }

    public CmmnCdMultiViewListener(String cdId, String propertyName, String targetPropertyName, String progrmId, String progrmSn, String rootYn) {
    	this(cdId, propertyName, targetPropertyName, progrmId,  progrmSn);
    	setRootYn(rootYn);
    }

	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();


		String resultKey = (String)model.get("resultOtherKey");
		if (resultKey == null || "".equals(resultKey)) {
			resultKey = "result";
		}

		ZValue result = (ZValue)model.get(resultKey);
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");

		String depth = "Y".equals(rootYn) ? "0" : "";
		List<ZValue> codeList = getCodeDepthList(cdId,depth);


		param.put("cdId",cdId);

		if( result != null ) {
			param.put("progrmSn", result.getString(this.progrmSn));
			param.put("progrmId", this.progrmId);
			List<ZValue> selectList  = sqlDao.findAll("findAllCmmnCdMultiByParams", param);

			String codeNames = "";
			String codes = "";
			//String depth2Tp = "";
			int n = 0;
			for (ZValue selectVO : selectList) {
				n++;

				codes += selectVO.getString("cd");
				codeNames += selectVO.getString("cdNm");

				if ("99".equals(selectVO.getString("cd"))) {
					codeNames += "("+selectVO.getString("memo")+")";
					result.put(propertyName + "Etc", selectVO.getString("memo"));
				}

				if (n < selectList.size()) {
					codes += ",";
					codeNames += ",";
				}

			}
			result.put(propertyName, codes);
			result.put(targetPropertyName, codeNames);

		}
		if (model.get("resultList") != null) {

			param.put("progrmId", this.progrmId);
			List<ZValue> selectList  = sqlDao.findAll("findAllCmmnCdMultiByParams", param);
			for(ZValue vo : resultList) {
				int n = 0;
				int listSize = 0;
				String codeNames = "";
				String codes = "";
				for (ZValue selectVO : selectList) {
					if (vo.getString(progrmSn).equals(selectVO.getString(progrmSn)) ) {
						listSize++;
					}
				}
				for (ZValue selectVO : selectList) {
					if (vo.getString(progrmSn).equals(selectVO.getString(progrmSn)) ) {
						n++;
						codes += selectVO.getString("cd");
						codeNames += selectVO.getString("cdNm");

						if ("99".equals(selectVO.getString("cd"))) {
							codeNames += "("+selectVO.getString("memo")+")";
						}

						if (n < listSize) {
							codes += ",";
							codeNames += ",";
						}
					}
				}
				PropertyUtils.setProperty(vo, propertyName, codes);
				PropertyUtils.setProperty(vo, targetPropertyName, codeNames);
			}
		}

		model.addAttribute(StrUtils.convert2CamelCase(cdId) + "CodeList", codeList);

	}

	public List<ZValue> getCodeDepthList(String cdId, String upperCd) throws Exception
	{
		Assert.hasText(cdId);
		ZValue param = new ZValue();
		param.put("cdId", cdId);
		param.put("upperCd", upperCd);
		List<ZValue> codeResult = cmmnCdDetailDAO.findAllCmmnCdDetail(param);
		return codeResult;
	}


	public String getCdId() {
		return cdId;
	}

	public void setCdId(String cdId) {
		this.cdId = cdId;
	}




	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public String getTargetPropertyName() {
		return targetPropertyName;
	}

	public void setTargetPropertyName(String targetPropertyName) {
		this.targetPropertyName = targetPropertyName;
	}

	public void setProgrmId(String progrmId) {
		this.progrmId = progrmId;
	}


	public void setProgrmSn(String progrmSn) {
		this.progrmSn = progrmSn;
	}

	public String getRootYn() {
		return rootYn;
	}

	public void setRootYn(String rootYn) {
		this.rootYn = rootYn;
	}

	@Override
	public void afterPropertiesSet() throws Exception {

	}


}
