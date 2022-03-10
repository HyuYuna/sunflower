package site.unp.cms.listener.cmmnCd;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import site.unp.cms.dao.cmmnCd.CmmnCdDetailDAO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.listener.CommonListenerSupport;

public class CmmnCdMultiAddListener extends CommonListenerSupport {

	Logger log = LoggerFactory.getLogger(this.getClass());

	public static final String ETC_CODE = "99";

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;

	@Resource(name="cmmnCdDetailDAO")
    protected CmmnCdDetailDAO cmmnCdDetailDAO;

	private String cdId = "";
	private String propertyName = "";
	private String progrmId = "";
	private String progrmSn = "";


	public CmmnCdMultiAddListener() {
	}

    public CmmnCdMultiAddListener(String cdId, String propertyName, String progrmId, String progrmSn) {
    	this.setCodeId(cdId);
    	this.setPropertyName(propertyName);
    	this.setProgrmId(progrmId);
    	this.setProgrmSn(progrmSn);
    }

	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		List<String> data = param.getList(propertyName);
		if ( CollectionUtils.isNotEmpty(data) && !"".equals(param.getString(progrmSn,""))) {
			Assert.hasText(param.getString(progrmSn));

			param.put("cdId", cdId);
			param.put("progrmId", progrmId);
			param.put("progrmSn", param.getString(progrmSn));
			sqlDao.deleteOne("deleteCmmnCdMulti", param);
			for (String d : data) {
				param.put("cd", d);
				if ( ETC_CODE.equals(d) ) {
					String etc = param.getString(propertyName+"Etc");
					param.put("memo", etc);
				}
				sqlDao.save("saveCmmnCdMulti", param);
				param.remove("memo");
			}
		}

	}

	public String getCodeId() {
		return cdId;
	}

	public void setCodeId(String cdId) {
		this.cdId = cdId;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public String getProgrmId() {
		return progrmId;
	}

	public void setProgrmId(String progrmId) {
		this.progrmId = progrmId;
	}

	public String getProgrmSn() {
		return progrmSn;
	}

	public void setProgrmSn(String progrmSn) {
		this.progrmSn = progrmSn;
	}

}
