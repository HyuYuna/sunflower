<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ page import="java.util.*" %>
<%@page import="site.unp.core.util.CacheUtil"%>
<%@ page import="site.unp.cms.domain.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
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

<div id="header" class="header">
	<div class="global">
		<ul>
			<li class="${paramVO.menuNo ne '200147' and paramVO.menuNo ne '200070' ? 'on' : '' }"><a href="/gongu/main/main.do">공유마당</a></li>
			<li class="${paramVO.menuNo eq '200147' ? 'on' : '' }"><a href="/gongu/authr/chronicle/list.do?menuNo=200147">작가연대기</a></li>
			<li class="last ${paramVO.menuNo eq '200070' ? 'on' : '' }"><a href="/gongu/search/search/listMain.do?menuNo=200070"><span>통합검색</span></a></li>
		</ul>
	</div>


	<div class="topmenu">
		<h1 class="pcweb"><a href="/gongu/main/main.do"><img src="/static/img/gongu/common/logo.gif" alt="공유마당" /></a></h1>
		<h1 class="mobile"><a href="/gongu/main/main.do"><img src="/static/img/gongu/common/logoM.gif" alt="공유마당" /></a></h1>

		<ul class="util">
		<sec:authorize access="!hasRole('ROLE_USERKEY')">
			<li><a href="/gongu/member/user/forLogin.do?menuNo=200053">로그인</a></li>
			<li><a href="/gongu/member/user/join01.do?menuNo=200052">회원가입</a></li>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_USERKEY')">
			<li><a href="/gongu/member/user/logout.do">로그아웃(${userVO.userNm })</a></li>
		</sec:authorize>

			<li class="lang_list">
			</li>
		</ul>


		<div class="gnb" id="gnb">
			<ul class="pcweb">
			<c:forEach var="x" begin="0" end="8">
				<c:set var="clss" value="" />
				<c:choose>
					<c:when test="${x eq depth01}">
						<c:set var="clss" value="on" /> <!-- 추후 추가 -->
					</c:when>
				</c:choose>
				<li class="${clss }"> <!-- 선택 이벤트 없음 -->
					<a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll_portal[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
						<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li <c:if test="${d02Categories[y].menuNo eq '200034' }">class="partLine"</c:if>> <a href="${d02Categories[y].allMenuCours}" ${d02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:forEach>
			<sec:authorize access="hasRole('ROLE_USERKEY')">
				<li class="mypage"><a href="/gongu/member/user/forUpdate.do?menuNo=200120"><img src="/static/img/gongu/common/gnb_mypage.png" alt="마이페이지" /></a>
				<c:set var="mypageCategories" value="${menuAll_portal['menu_200060']}" />
					<c:if test="${fn:length(mypageCategories)>0}">
					<ul>
					<c:forEach var="m" begin="0" end="${fn:length(mypageCategories)-1}">
						<li> <a href="${mypageCategories[m].allMenuCours}" ${mypageCategories[m].popupAt eq 'Y' ? 'target="_blank"' : ''}>${mypageCategories[m].menuNm}</a></li>
					</c:forEach>
					</ul>
					</c:if>
				</li>
			</sec:authorize>

			</ul>
		</div>
		<div class="gnb_etc pcweb">
			<a href="" class="AllmenuBtn" id="AllmenuBtn"><img src="/static/img/gongu/common/gnb_all.gif" alt="전체메뉴" /></a>
		</div>
		<div class="gnb_etc mobile">
			<a href="" class="schOpener"><img src="/static/img/gongu/common/gnb_sch.gif" alt="검색" /></a>
			<a href="" class="AllmenuBtn"><img src="/static/img/gongu/common/gnb_all.gif" alt="전체메뉴" /></a>
		</div>

	</div>

</div>
</div>

<!-- 전체메뉴 -->
<div id="Allmenu">

	<div class="Allmw">
	<div class="writerYear"><a href="/gongu/authr/chronicle/list.do?menuNo=200147">작가 연대기</a></div>
	<ul>
	<c:forEach var="x" begin="0" end="8">
		<c:choose>
			<c:when test="${topCategories[x].menuNo eq '200060' }">
				<sec:authorize access="hasRole('ROLE_USERKEY')">
				<li class="mobile">
					<a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll_portal[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
						<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li> <a href="${d02Categories[y].allMenuCours}" ${d02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
						</ul>
					</c:if>
				</li>
				</sec:authorize>
			</c:when>
			<c:otherwise>
				<li>
					<a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll_portal[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
						<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li> <a href="${d02Categories[y].allMenuCours}" ${d02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	</ul>
	</div>
	<span class="AllmenuBtnClose"><a href="#AllmenuBtn" ><img src="/static/img/gongu/common/AllmenuBtnClose.png" alt="전체메뉴 닫기" /></a></span>
</div>


