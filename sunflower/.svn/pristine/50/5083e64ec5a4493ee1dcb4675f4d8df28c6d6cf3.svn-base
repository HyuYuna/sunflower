<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@page import="site.unp.core.util.CacheUtil"%>
<%@ page import="site.unp.cms.domain.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="site.unp.core.conf.GlobalsProperties"%>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper" %>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="site.unp.core.ZValue"%>
<%@page import="site.unp.cms.service.siteManage.BannerService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<spring:eval expression="@prop['Globals.ucms.OsType']" var="osType" scope="request" />

<%
	String osType = (String)request.getAttribute("osType");

	MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

    //메뉴설정 SiteMngService.PORTAL_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteInfoService.PORTAL_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);

	String menuNo = request.getParameter("menuNo");
	if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!");

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<ZValue>> menuMap = (HashMap<String, List<ZValue>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	GlobalsProperties globalsProperties = (GlobalsProperties)context.getBean("globalsProperties");

	String realMode = globalsProperties.isReal() ? "Y" : "N";
	String realTp = realMode;


	ZValue currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);

	String position = currentVo.getString("menuLc");
	int depth01 = Integer.parseInt(position.substring(0,2)) -1;
	int depth02 = Integer.parseInt(position.substring(2,4)) -1;
	int depth03 = Integer.parseInt(position.substring(4,6)) -1;
	int depth04 = Integer.parseInt(position.substring(6,8)) -1;
	int depth05 = Integer.parseInt(position.substring(8,10)) -1;
	int depth06 = Integer.parseInt(position.substring(10,12)) -1;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
	pageContext.setAttribute("depth06", depth06);


	CacheUtil cacheUtil = (CacheUtil)context.getBean("cacheUtil");
	List<ZValue> bannerList = (List<ZValue>)cacheUtil.load("storedMain", "bannerList");
	if( bannerList == null ){
		BannerService bannerService = context.getBean("bannerService", BannerService.class);
		bannerList = bannerService.getBanner("01"); //CKL 전체01 , EDU 전체 02, 교육 03, 창의동반 04, 채용정보 05
		cacheUtil.save("storedMain", "bannerList", bannerList);
	}
	application.setAttribute("bannerList", bannerList);

	SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
	ZValue site = siteMngService.getSiteBySiteName(SiteInfoService.PORTAL_SITE_ID);
	pageContext.setAttribute("siteVO", site);


	//인증 리다이렉트페이지
	int port = osType.equals("WINDOWS") ? 80 : 80;
	String protocol = "http";
	if ("Y".equals(realTp)) protocol = "https";
	String _targetUrl = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
	if("200053".equals(menuNo) || "200011".equals(menuNo)) { //본인인증페이지
		if (StringUtils.hasText(_targetUrl)) {
			session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
		}
	}
	else {
		String _targetUrl_ = org.springframework.security.web.util.UrlUtils.buildFullRequestUrl(protocol, request.getServerName(), port, currentVo.getString("allMenuCours"), null);
		_targetUrl_ = _targetUrl_.replaceAll(":80", "");
		session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, _targetUrl_);
	}

	String dataHref = "https://" + request.getServerName();
	if ( port != 80 ) {
		dataHref += ":" + port;
	}
%>

<c:set var="currMenu" value="${currMenu }" scope="session" />
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="${osType }" />
<c:set var="list" value="${fn:contains(fn:toLowerCase(includePage), 'list')}" />
<c:set var="read" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="reg" value="${fn:contains(fn:toLowerCase(includePage), 'reg')}" />
<c:set var="view" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
	<c:set var="title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(상세) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]} | ${title}"/></c:otherwise>
	</c:choose>
</c:forEach>

<c:set var="topCategories" value="${menuAll_portal['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll_portal[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll_portal[curD03menuKey]}" />
<c:set var="curD04menuKey" value="menu_${curD03Categories[depth03].menuNo}" />
<c:set var="curD04Categories" value="${menuAll_portal[curD04menuKey]}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${title } 포털사이트" />

<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<title>${title } 000000</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


</head>
<body>
<ul class="skip">
	<li><a href="#contents">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div id="bgW"></div>
<div id="bgW2"></div>
<div class="bg_Allmenu"></div>
<div class="wrapSet">
	<div class="wrap" id="wrap">
	<%@ include file="/WEB-INF/jsp/portal/main/header.jsp" %>
	<!-- 뎁스 메뉴 제목 -->
	<c:set var="curD" value="${not empty curD02Categories[depth02] ? curD02Categories[depth02] : curD}" />
	<c:set var="curD" value="${not empty curD03Categories[depth03] ? curD03Categories[depth03] : curD}" />




	<div id="container">

		<div id="contents">

			<c:if test="${not layoutChgAt and paramVO.menuNo ne '200070'}">

			<div class="titArea">
				<h1>${curD.menuNm }</h1>
				<div class="location">
					<span>Home</span>
					<c:forEach var="path" items="${pathData }" varStatus="status">
					  <c:if test="${not status.last }">
					  <span><util:out escapeXml='false'>${path}</util:out></span>
					  </c:if>
					  <c:if test="${status.last }">
					  <span class="ing"><a href="#" class="inglink"><util:out escapeXml='false'>${path}</util:out></a>  </span>
					  <c:set var="lastMenuKey" value="menu_${currMenu.upperMenuNo }" />
					  <c:set var="lastCategories" value="${menuAll_portal[lastMenuKey]}" />
						<c:if test="${fn:length(lastCategories) > 0 }">
						<c:if test="${lastCategories[0].upperMenuNo > 0 }">
						<ul class="ingsub">
						<c:forEach var="l" begin="0" end="${fn:length(lastCategories)-1}">
							<li> <a href="${lastCategories[l].allMenuCours}" ${lastCategories[l].popupAt eq 'Y' ? 'target="_blank"' : ''}>${lastCategories[l].menuNm}</a></li>
						</c:forEach>
						</ul>
						</c:if>
					   </c:if>
					   </c:if>

					</c:forEach>
				</div>
				<script>
					$(".location>.ing>a").on('click',function(){
						//$(this).parent().toggleClass('on');
						$(".ingsub").toggleClass('on');
						return false;
					});
					 $(window).resize(function(event) {
						 var spanWidth = 0;
						 $(".location").find("span").each(function(n) {
							 spanWidth = spanWidth + $(this).outerWidth();
						 });
					 	var ingRight = ($(".location").outerWidth() - (spanWidth )) /2 - 30
						$(".ingsub").css({'right':ingRight+'px'});
					}).trigger('resize');
					$(".ingsub").on('mouseleave blur', function () {
						$(this).removeClass('on');
						return false;
						});
				</script>

				<!-- Piwik -->
				<script>
				  var _paq = _paq || [];
				  _paq.push(["setDomains", ["*.gongu.copyright.or.kr","*.gongu.copyright.or.kr"]]);
				  _paq.push(['trackPageView']);
				  _paq.push(['enableLinkTracking']);
				  (function() {
				    var u="//piwik.copyright.or.kr/";
				    _paq.push(['setTrackerUrl', u+'piwik.php']);
				    _paq.push(['setSiteId', 5]);
				    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
				    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
				  })();
				</script>
				<noscript><p><img src="//piwik.copyright.or.kr/piwik.php?idsite=5" style="border:0;" alt="" /></p></noscript>
				<!-- End Piwik Code -->

	<c:if test="${not empty currMenu.preMenuLink }">
		<p class="prev"><a href="${currMenu.preMenuLink }"><span>${currMenu.preMenuNm }</span></a></p>
	</c:if>
	<c:if test="${not empty currMenu.nextMenuLink }">
		<p class="next"><a href="${currMenu.nextMenuLink }"><span>${currMenu.nextMenuNm }</span></a></p>
	</c:if>
			</div>

			<div class="lineCon">
				<c:if test="${curD.scrinExpsrAt eq 'Y' }">
					<c:if test="${fn:length(curD03Categories) > 0 }">
					<div class="tab">
					<ul>
					<c:forEach var="z" begin="0" end="${fn:length(curD03Categories)-1}">
						<c:set var="clss" value="" />
						<c:if test="${z eq depth03}">
							<c:set var="clss" value="on" /> <!-- 추후 추가 -->
						</c:if>
						<li class="${clss }"><a href="${curD03Categories[z].allMenuCours}" ${curD03Categories[z].popupAt eq 'Y' ? 'target="_blank"' : ''}>${curD03Categories[z].menuNm}</a></li>
					</c:forEach>
					</ul>
					</div>
					</c:if>

					<c:if test="${fn:length(curD04Categories) > 0 }">
					<div class="tab1">
						<ul>
						<c:forEach var="za" begin="0" end="${fn:length(curD04Categories)-1}">
							<c:set var="clss2" value="" />
							<c:if test="${za eq depth04}">
								<c:set var="clss2" value="on" /> <!-- 추후 추가 -->
							</c:if>
							<li class="${clss2 }"><a href="${curD04Categories[za].allMenuCours}" ${curD04Categories[za].popupAt eq 'Y' ? 'target="_blank"' : ''}>${curD04Categories[za].menuNm}</a></li>
						</c:forEach>
						</ul>
					</div>
					</c:if>
				</c:if>

		</c:if>

			<c:choose>

				<c:when test="${not empty cntntsCn}">
					${cntntsCn}
				</c:when>
				<c:otherwise>
					<c:set var="_includePage" value="" />
					<c:choose>
						<c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
						<c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
						<c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
					</c:choose>
					<c:catch var ="catchException">
						<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
					</c:catch>
				</c:otherwise>
			</c:choose>


		</div>

	</div>


<!-- Site footer -->
<%@ include file="/WEB-INF/jsp/portal/main/footer.jsp" %>

</div>


<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
<script src="/static/js/gongu/ms.bing.translate.js" charset="UTF-8"></script>
</body>
</html>