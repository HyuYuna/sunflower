package site.unp.cms.dao.singl;

import java.util.List;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("siteConectStatsDAO")
public class SiteConectStatsDAO extends SqlDAO<ZValue> {

	public static final String SITE_CONECT_STATS_CACHE_NAME = "storedSiteConectStats";
	public static final String SITE_CONECT_MENU_CACHE_NAME = "storedSiteConectMenu";
	public static final String SITE_CONECT_OS_CACHE_NAME = "storedSiteConectOs";
	public static final String SITE_CONECT_BROWSER_CACHE_NAME = "storedSiteConectBrowser";
	public static final String SITE_CONECT_PCMOBILE_CACHE_NAME = "storedSiteConectPcMobile";

	//@Cacheable(value=SITE_CONECT_STATS_CACHE_NAME)
	public List<ZValue> listDate(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllBySiteConectCount", param);
		return resultList;
	}

	//@Cacheable(value=SITE_CONECT_MENU_CACHE_NAME)
	public List<ZValue> listMenu(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllBySiteMenuConectCount", param);

		return resultList;
	}

	//@Cacheable(value=SITE_CONECT_OS_CACHE_NAME)
	public List<ZValue> listOs(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllBySiteGubunConectCount", param);
		return resultList;
	}

	//@Cacheable(value=SITE_CONECT_BROWSER_CACHE_NAME)
	public List<ZValue> listBrowser(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllBySiteGubunConectCount", param);
		return resultList;
	}

	//@Cacheable(value=SITE_CONECT_PCMOBILE_CACHE_NAME)
	public List<ZValue> listPcMobile(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllBySiteGubunConectCount", param);
		return resultList;
	}
	
	public List<ZValue> listSankeyNodes(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllSankeyNodes", param);
		return resultList;
	}
	
	public List<ZValue> listSankeyLinks(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findAllSankeyLinks", param);
		return resultList;
	}
}
