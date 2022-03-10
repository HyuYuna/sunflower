<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.util.CacheUtil"%>
<%@ page import="site.unp.cms.domain.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper" %>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.BannerService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<div id="header">
	<p class="logo">
		<a href="/${paramVO.siteId }/main/main.do">
			<c:if test="${empty siteVO.atchFileId}"><img src="/static/bos/img/noimage.gif" alt="${siteVO.fileCn}"></c:if>
			<c:if test="${not empty siteVO.atchFileId}"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="${siteVO.fileCn}"></c:if>
		</a>
	</p>
	<div class="global">
		<ul>
		<sec:authorize access="!hasRole('ROLE_USERKEY') and !hasRole('ROLE_VNAME')">
			<c:forEach var="item" items="${menuTop_ucms }">
				<li><a href="${item.allMenuCours }">${item.menuNm }</a></li>
			</c:forEach>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_USERKEY') or hasRole('ROLE_VNAME')">
			<li><a href="/ucms/member/user/logout.do">로그아웃(${userVO.userNm }&nbsp;<span id="ViewTimer">10분 00초</span>)</a></li>
			<li><a href="/ucms/myPage/qna/list.do?bbsId=B0000005&menuNo=300083">마이페이지</a></li>
		</sec:authorize>
		<c:set var="guideMenuList" value="${siteVO.guideMenuList01}"/>
		<c:if test="${fn:length(guideMenuList)>0}">
		<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
			<li><a href="${guideMenuList[x].menuLink}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${guideMenuList[x].menuNm}</a></li>
		</c:forEach>
		</c:if>
		</ul>
	</div>

	<div class="gnbSet">
		<nav id="gnb">
			<ul>
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
				<li class="${clss }"> <!-- 선택 이벤트 없음 -->
					<a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll_ucms[d02MenuKey]}" />
					<%--
					<c:if test="${fn:length(d02Categories)>0}">
						<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li <c:if test="${d02Categories[y].menuNo eq '200034' }">class="partLine"</c:if>> <a href="${d02Categories[y].allMenuCours}" ${d02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
						</ul>
					</c:if>
					 --%>
				</li>
				</c:if>
			</c:forEach>
			</ul>
		</nav>
		<a href="javascript:void(0);" class="menuNavOpener"><span class="hidden">메뉴 열기</span><span class="bar"></span></a>
	</div>
</div>