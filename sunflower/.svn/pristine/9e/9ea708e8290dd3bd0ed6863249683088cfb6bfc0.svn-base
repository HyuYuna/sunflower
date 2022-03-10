<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"  trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.util.CacheUtil"%>
<%@ page import="site.unp.cms.domain.*" %>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="site.unp.core.conf.GlobalsProperties"%>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper" %>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.BannerService"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="site.unp.core.exception.UnpBizException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<spring:eval expression="@prop['Globals.ucms.OsType']" var="osType" scope="request" />


<%
	String osType = (String)request.getAttribute("osType");

	MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

    //메뉴설정 SiteMngService.UCMS_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteInfoServiceImpl.UCMS_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);

	String menuNo = request.getParameter("menuNo");
	//if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!");

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<ZValue>> menuMap = (HashMap<String, List<ZValue>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	GlobalsProperties globalsProperties = (GlobalsProperties)context.getBean("globalsProperties");

	String realMode = globalsProperties.isReal() ? "Y" : "N";
	String realTp = realMode;


	ZValue currentVo = null;
	currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);

	if (currentVo != null) {
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

		//인증 리다이렉트페이지
		int port = osType.equals("WINDOWS") ? 80 : 8108;
		String protocol = "http";
		if ("Y".equals(realTp)) protocol = "https";
		String _targetUrl = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
		if("300009".equals(menuNo)) { //본인인증페이지
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
	}

	SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
	ZValue site = siteMngService.getSiteBySiteName(SiteInfoServiceImpl.UCMS_SITE_ID);
	pageContext.setAttribute("siteVO", site);
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

<c:set var="topCategories" value="${menuAll_ucms['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll_ucms[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll_ucms[curD03menuKey]}" />
<c:set var="curD04menuKey" value="menu_${curD03Categories[depth03].menuNo}" />
<c:set var="curD04Categories" value="${menuAll_ucms[curD04menuKey]}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="title" value="${title } 포털사이트" />
<title>${title}</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- <link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/font/NotoSans/notosans.css" />
<link rel="stylesheet" href="/static/commons/common.css">
<link rel="stylesheet" href="/static/ucms/css/ucmsdefault.css"> -->
<link rel="stylesheet" href="/static/ucms/css/default.css">
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
</head>
<body>

<div class="skip">
	<a href="#content">본문내용 바로가기</a>
	<a href="#gnb">주메뉴 바로가기</a>
</div>
<div id="wrap">
	<!-- header -->
	<%@ include file="/WEB-INF/jsp/ucms/main/header.jsp" %>
	<!-- //header -->

	<div id="visual" class="i${curD.menuNo}">
		${empty d01Category.menuNm ? '미사용메뉴' : d01Category.menuNm}
	</div>
	<c:set var="curD" value="${not empty curD02Categories[depth02] ? curD02Categories[depth02] : curD}" />
	<c:set var="curD" value="${not empty curD03Categories[depth03] ? curD03Categories[depth03] : curD}" />
	<c:set var="curD" value="${not empty curD04Categories[depth04] ? curD03Categories[depth04] : curD}" />

	<%--
	<div class="rocation">
			<div class="set">
				<nav>
					<a href="/" class="home"><span class="sr-only">home</span></a>
					<a href="#" class="depth1">${empty d01Category.menuNm ? '미사용메뉴' : d01Category.menuNm}</a>
					<ul class="depth1-more">
						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1 }">
							<c:set var="clss" value="" />
							<c:choose>
								<c:when test="${x eq depth01}">
									<c:set var="clss" value="on" /> <!-- 추후 추가 -->
								</c:when>
							</c:choose>

							<c:set var="viewFlag" value="Y" />
							<c:choose>
								<c:when test="${topCategories[x].menuExpsrSe eq 'LOGIN' }">
									<sec:authorize access="!hasRole('ROLE_USERKEY') or !hasRole('ROLE_VNAME')">
										<c:set var="viewFlag" value="N" />
									</sec:authorize>
								</c:when>
								<c:when test="${topCategories[x].menuExpsrSe eq 'NOLOGIN' }">
									<sec:authorize access="hasRole('ROLE_USERKEY') or hasRole('ROLE_VNAME')">
										<c:set var="viewFlag" value="N" />
									</sec:authorize>
								</c:when>
								<c:otherwise>
									<c:set var="viewFlag" value="Y" />
								</c:otherwise>
							</c:choose>

							<c:if test="${viewFlag eq 'Y' }">
							<li class="${clss }">
								<a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a>
							</li>
							</c:if>
						</c:forEach>
					</ul>




					<a href="#" class="depth2">${curD.menuNm}</a>
					<c:if test="${not empty curD02Categories }">
						<ul class="depth2-more">
						<c:forEach var="y" begin="0" end="${fn:length(curD02Categories)-1}">
							<c:set var="clss" value="" />
							<c:if test="${y eq depth02}">
								<c:set var="clss" value="on" />
							</c:if>
							<c:set var="viewFlag1" value="Y" />
							<c:choose>
								<c:when test="${curD02Categories[y].menuExpsrSe eq 'LOGIN' }">
									<sec:authorize access="!hasRole('ROLE_USERKEY')">
										<c:set var="viewFlag1" value="N" />
									</sec:authorize>
								</c:when>
								<c:when test="${curD02Categories[y].menuExpsrSe eq 'NOLOGIN' }">
									<sec:authorize access="hasRole('ROLE_USERKEY')">
										<c:set var="viewFlag1" value="N" />
									</sec:authorize>
								</c:when>
								<c:otherwise>
									<c:set var="viewFlag1" value="Y" />
								</c:otherwise>
							</c:choose>

							<c:if test="${viewFlag1 eq 'Y' }">
								<a class="${clss }" href="${curD02Categories[y].allMenuCours}" ${curD02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${fn:replace(curD02Categories[y].menuNm,"&amp;","&")}</a>
							</c:if>
						</c:forEach>
						</ul>
					</c:if>
					<c:if test="${empty curD02Categories }">
					미사용 메뉴
					</c:if>
					<script>
						$('.depth1,.depth2').on('click',function(event) {
							$(this).next().toggleClass('active')
							event.preventDefault();
						});
					</script>
				</nav>
				<div class="r">
					<a href="#"><span>담당자에게 메일보내기</span></a>
					<a href="#"><span>회사자료소개</span></a>
				</div>
			</div>
		</div>
	--%>

	<!-- Container -->
		<nav class="lnb size${fn:length(curD02Categories)}">
			<c:if test="${not empty curD02Categories }">
			<ul>
			<c:forEach var="y" begin="0" end="${fn:length(curD02Categories)-1}">
				<c:set var="clss" value="" />
				<c:if test="${y eq depth02}">
					<c:set var="clss" value="on" />
				</c:if>
				<c:set var="viewFlag1" value="Y" />
				<c:choose>
					<c:when test="${curD02Categories[y].menuExpsrSe eq 'LOGIN' }">
						<sec:authorize access="!hasRole('ROLE_USERKEY')">
							<c:set var="viewFlag1" value="N" />
						</sec:authorize>
					</c:when>
					<c:when test="${curD02Categories[y].menuExpsrSe eq 'NOLOGIN' }">
						<sec:authorize access="hasRole('ROLE_USERKEY')">
							<c:set var="viewFlag1" value="N" />
						</sec:authorize>
					</c:when>
					<c:otherwise>
						<c:set var="viewFlag1" value="Y" />
					</c:otherwise>
				</c:choose>

				<c:if test="${viewFlag1 eq 'Y' }">
				<li class="${clss }"> <a href="${curD02Categories[y].allMenuCours}" ${curD02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${fn:replace(curD02Categories[y].menuNm,"&amp;","&")}</a>
				<c:set var="d03MenuKey" value="menu_${curD02Categories[y].menuNo}" />
				<c:set var="d03Categories" value="${menuAll_ucms[d03MenuKey]}" />
				<c:if test="${fn:length(d03Categories)>0}">
					<ul>
	 				<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
	 					<c:set var="clss" value=""/>
			 			<c:if test="${z eq depth03}">
							<c:set var="clss" value="on" />
						</c:if>

						<c:set var="viewFlag2" value="Y" />
						<c:choose>
							<c:when test="${d03Categories[z].menuExpsrSe eq 'LOGIN' }">
								<sec:authorize access="!hasRole('ROLE_USERKEY')">
									<c:set var="viewFlag2" value="N" />
								</sec:authorize>
							</c:when>
							<c:when test="${d03Categories[z].menuExpsrSe eq 'NOLOGIN' }">
								<sec:authorize access="hasRole('ROLE_USERKEY')">
									<c:set var="viewFlag2" value="N" />
								</sec:authorize>
							</c:when>
							<c:otherwise>
								<c:set var="viewFlag2" value="Y" />
							</c:otherwise>
						</c:choose>

						<c:if test="${viewFlag2 eq 'Y' }">
						<li class="${clss }"> <a href="${d03Categories[z].allMenuCours}" ${d03Categories[z].popupAt eq 'Y' ? 'target="_blank"' : ''}>${fn:replace(d03Categories[z].menuNm,"&amp;","&")}</a></li>
						</c:if>
	 				</c:forEach>
	 				</ul>
				</c:if>
				</li>
				</c:if>
			</c:forEach>
			</ul>
			</c:if>

			<c:if test="${empty curD02Categories }">
			<ul><li><a href="#">미사용 메뉴</a></li></ul>
			</c:if>
		</nav>
	<div id="container">

		<main>
			<div class="hgroup">
				<h1>${empty param.menuNm ? curD.menuNm : param.menuNm}</h1>
				<p class="hidden">
				HOME >
				<c:forEach var="path" items="${pathData }" varStatus="status">
					${path}
					<c:if test="${not status.last }">
						>
					</c:if>
				</c:forEach>
				</p>
			</div>
			<div id="content">

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
				<c:if test="${not empty catchException.message}"><jsp:include page="/WEB-INF/jsp/cts/cmmn/ready.jsp" flush="true" /></c:if>


					<c:if test="${not empty curD.userId && siteVO.dtaMngrUseAt eq 'Y' }">
					<div class="adm view">
					<dl>
						<dt class="l">담당자<br class="visible-sm">부서</dt>
						<dd>${curD.deptKorNm }</dd>
						<dt>이름</dt>
						<dd>${curD.userNm }</dd>
					</dl>
					<dl>
						<dt class="l">연락처</dt>
						<dd>${curD.userCpno }</dd>
						<dt>이메일</dt>
						<dd>${curD.userEmad }</dd>
					</dl>
					</div>
					</c:if>


					<c:if test="${siteVO.stsfdgUseAt eq 'Y' }">
					<form name="stsfdgForm" id="stsfdgForm" method="post" >
					<input type="hidden" name="csrfToken" value="${csrfToken}"/>
					<input type="hidden" name="menuNo" value="${paramVO.menuNo }" >
					<div class="adm view viewType2">
					<dl>
						<dt class="l">페이지<br class="visible-sm">만족도</dt>
						<dd>
							<label for="sr-r1"><input id="sr-r1" type="radio" name="stsfdgIdex" value="5"> 매우만족</label>
							<label for="sr-r2"><input id="sr-r2" type="radio" name="stsfdgIdex" value="4"> 만족</label>
							<label for="sr-r3"><input id="sr-r3" type="radio" name="stsfdgIdex" value="3"> 보통</label>
							<label for="sr-r4"><input id="sr-r4" type="radio" name="stsfdgIdex" value="2"> 불만</label>
							<label for="sr-r5"><input id="sr-r5" type="radio" name="stsfdgIdex" value="1"> 매우불만</label>
						</dd>
					</dl>
					<dl>
						<dt class="l">한줄의견</dt>
						<dd>
							<div class="row">
								<div class="col-sm-10">
									<input type="text" name="opinionCn" title="한줄의견" maxlength="100">
									<sec:authorize access="!hasRole('ROLE_USERKEY')">
									<p>* 로그인 후 등록이 가능합니다</p>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_USERKEY')">
									<p>* 최대 100자까지 입력가능합니다.</p>
									</sec:authorize>
								</div>
								<div class="col-sm-2"><button class="b-submit">의견등록</button></div>
							</div>
						</dd>
					</dl>

					<script>

						$("input[name=stsfdgIdex]").on('click',function() {
							<sec:authorize access="!hasRole('ROLE_USERKEY')">
							alert("로그인 후 등록이 가능합니다");
							return false;
							</sec:authorize>
						});

						$("#stsfdgForm").on('submit',function() {
							<sec:authorize access="!hasRole('ROLE_USERKEY')">
							alert("로그인 후 등록이 가능합니다");
							return false;
							</sec:authorize>

							if ($(this).find("input[name=stsfdgIdex]:checked").length == 0) {
								$(this).find("input[name=stsfdgIdex]").eq(0).focus();
								alert("페이지만족도를 선택해 주세요.");
								return false;
							}
							else if ($(this).find("input[name=opinionCn]").val() == "") {
								$(this).find("input[name=opinionCn]").focus();
								alert("한줄의견을 입력해 주세요.");
								return false;
							}
							else if ($(this).find("input[name=opinionCn]").val().length > 100) {
								alert("최대 100자 까지 입력가능합니다.");
								var cn = $(this).find("input[name=opinionCn]").val();
								cn = cn.substring(0,100);
								$(this).find("input[name=opinionCn]").val(cn);
								return false;
							}

							var url = "/ucms/singl/stsfdg/insert.json";
							var params = $(this).serialize();
							$.post(url,params,function(data) {
								if (data.resultCode == "success") {
									alert("페이지만족도 의견이 등록되었습니다.");
									$("#stsfdgForm")[0].reset();
								}
								else if (data.resultCode == "duplicate") {
									alert("이미 등록하셨습니다.");
								}
								else {
									alert("페이지만족도 의견등록 오류입니다.");
								}
							},"json");

							return false;
						});
					</script>
					</div>
					</form>
					</c:if>
			</div>
		</main>
	</div>
	<!-- //Container -->
</div>

<!-- footer -->
<%@ include file="/WEB-INF/jsp/ucms/main/footer.jsp" %>
<%@ include file="/WEB-INF/jsp/cmmn/autoLogout.jsp" %>
<!-- //footer -->

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>

<!-- 로그기록  -->

<script>
document.writeln("<span class='sr-only'><img src='/${paramVO.siteId}/singl/siteConectStats/rcord.do?menuNo=${paramVO.menuNo}&amp;conectUrlad=${paramVO.requestURI}' alt=''></span>");
</script>
<!-- 로그기록 END  -->
<div class="loading" id="loadingDiv" style="display:none;">
<div class="spinner">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
</div>

<p> <br>게시물 저장 중입니다.</p> </div>

	<script src="/static/ucms/js/common.js"></script>
	<script src="/static/jslibrary/tablesummary.js"></script>
</body>
</html>