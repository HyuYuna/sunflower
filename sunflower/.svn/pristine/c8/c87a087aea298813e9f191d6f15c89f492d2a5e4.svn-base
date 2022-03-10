package site.unp.cms.dao.singl;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.aop.support.AopUtils;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.dao.SqlDAO;
import site.unp.core.service.cs.impl.CommonServiceImpl;

@Repository("menuDAO")
public class MenuDAO extends SqlDAO<ZValue> implements ApplicationContextAware {

	private ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}

	public ZValue findOneByIdMenu(String cMenuNo) throws Exception {
		return findOneById("findOneByIdMenu", cMenuNo);
	}

	public List<ZValue> findAllMenuByParam(String pSiteId, String upperMenuNo) throws Exception {
		ZValue param = new ZValue();
		param.put("pSiteId", pSiteId);
		param.put("upperMenuNo", upperMenuNo);
		return findAll("findAllMenuByParam", param);
	}

	//@Cacheable(value=SiteInfoDAO.SITE_INFO_CACHE_NAME)
	public List<ZValue> findAllAnnotatedMenu(String pSiteId) throws Exception {
		List<ZValue> resultList = new ArrayList<ZValue>();

		Map<String, CommonServiceImpl> m = applicationContext.getBeansOfType(CommonServiceImpl.class);
		Iterator<String> it = m.keySet().iterator();
		while (it.hasNext()) {
			String serviceName = it.next();
			if (!serviceName.endsWith("Impl")) {
				CommonServiceImpl cs = m.get(serviceName);
				Class<?> csClz = cs.getClass();
				if (AopUtils.isAopProxy(cs)) {
					csClz = AopUtils.getTargetClass(cs);
	            }

				ZValue linkInfo = null;
				CommonServiceLinks csls = AnnotationUtils.findAnnotation(csClz, CommonServiceLinks.class);
				if (csls != null) {
					CommonServiceLink[] links = csls.value();
					for (CommonServiceLink link : links) {
						linkInfo = getLinkInfo(serviceName, link, csClz, null);
						if (linkInfo != null) {
							if (menuFlag(linkInfo.getString("desc"))) resultList.add(linkInfo);
						}
					}
				}
				CommonServiceLink csl = AnnotationUtils.findAnnotation(csClz, CommonServiceLink.class);
				linkInfo = getLinkInfo(serviceName, csl, csClz, null);
				if (linkInfo != null) {
					if (menuFlag(linkInfo.getString("desc"))) resultList.add(linkInfo);
				}

	            for (Method method : csClz.getDeclaredMethods()) {
	    			csls = AnnotationUtils.findAnnotation(method, CommonServiceLinks.class);
	    			if (csls != null) {
	    				CommonServiceLink[] links = csls.value();
	    				for (CommonServiceLink link : links) {
	    					linkInfo = getLinkInfo(serviceName, link, csClz, null);
	    					if (linkInfo != null) {
	    						if (menuFlag(linkInfo.getString("desc"))) resultList.add(linkInfo);
	    					}
	    				}
	    			}
	            	csl = AnnotationUtils.findAnnotation(method, CommonServiceLink.class);
	    			linkInfo = getLinkInfo(serviceName, csl, csClz, method.getName());
	    			if (linkInfo != null) {
	    				if (menuFlag(linkInfo.getString("desc"))) resultList.add(linkInfo);
	    			}
	            }
			}
		}
		return resultList;
	}

	public boolean menuFlag(String menuNo) {
		boolean flag = true;
		String [] listMenu = {"관리자메인설정 프로그램", "권한별 메뉴관리 프로그램", "게시판 필드 속성 관리", "공통코드분류 관리 프로그램", "공통코드상세 관리 프로그램", "공통코드카테고리 관리 프로그램",
				"관리자 회원 관리", "설문조사 결과 통계 보기", "설문조사 관리", "사이트 도움말 관리 프로그램", "사이트 관리 프로그램", "용어사전(표준용어사전, 도메인사전, 항목사전)",
				"글로벌 환경변수 관리", "사용자콘텐츠관리", "시스템정보", "게시판 댓글 관리", "게시판 정보 관리"
				};

		for (String str : listMenu) {
			if (menuNo.equals(str)) flag = false;
		}
		return flag;
	}

	private ZValue getLinkInfo(String serviceName, CommonServiceLink csl, Class<?> csClz, String methodName) {
		if (csl == null) {
			return null;
		}

		String link = csl.link();
		String groupId = csl.groupId();
		String srvcId = StringUtils.replace(serviceName, "Service", "");
		if (!StringUtils.hasText(link)) {

			if (!StringUtils.hasText(groupId)) {
				groupId = getGroupId(csClz);
			}

			link = "/[siteId]/" + groupId + "/" + srvcId + "/";
			if (StringUtils.hasText(methodName)) {
				link += methodName + ".do";
			}
			else {
				methodName = "list";
				link += "list.do";
			}
		}
		String paramString = csl.paramString();
		if (StringUtils.hasText(paramString)) {
			link += "?" + paramString;
		}

		ZValue val = new ZValue();
		val.putObject("groupId", groupId);
		val.putObject("srvcId", srvcId);
		val.putObject("methodId", methodName);
		val.putObject("link", link);
		val.putObject("desc", csl.desc());
		val.putObject("linkType", csl.linkType());
		return val;
	}

	private String getGroupId(Class<?> clz) {
		String groupId = "";
		String className = clz.getName();
		String[] packageData = StringUtils.delimitedListToStringArray(className, ".");
		int groupIdIndex = 0;
		int index = 0;
		for (String p : packageData) {
			if ("service".equals(p)) {
				groupIdIndex = index + 1;
			}
			index++;
		}
		if (packageData.length-1 <= groupIdIndex) {
			groupId = "singl";
		}
		else {
			groupId = packageData[groupIdIndex];
		}
		return groupId;
	}
}
