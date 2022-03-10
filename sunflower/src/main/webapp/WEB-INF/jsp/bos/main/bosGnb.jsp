<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />

<script>
	function openPopup()
	{
		url = "/bos/member/admin/forUpdateMy.do";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=700");
	}
</script>
		<div id="header_wrap">
			<div class="header">
				<h1><a href="/bos/main/main.do"><img src="/bos/images/common/logo.gif" alt="<spring:message code="site.slogan" text=""/>" /></a></h1>
				<p class="user bold"><span class="color1">[${adminUser.deptNm}]${adminUser.userNm}</span>님 로그인 접속IP:${userIp}</p>
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />

				<div class="util btn-group">
					<%-- <c:if test="${fn:length(topCategories)>0}">
						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
							<c:choose>
							<c:when test="${x==0}"><c:set var="iconClass" value="fa-cogs" /></c:when>
							<c:when test="${x==1}"><c:set var="iconClass" value="fa-search" /></c:when>
							</c:choose>
			 			<c:if test="${topCategories[x].menuPopupYn=='Y'}">
							<a href="${topCategories[x].allMenuCours}" target="_blank" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
			 			<c:if test="${topCategories[x].menuPopupYn!='Y'}">
							<a href="/bos/main/main.do?menuNo=${topCategories[x].menuNo}" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
						</c:forEach> --%>
						<a href="javascript:openPopup();"class="btn btn-success"><i class="fa fa-power-off"></i>내정보수정</a>
						<a href="/bos/member/admin/logout.do" class="btn btn-info"><i class="fa fa-power-off"></i> 로그아웃</a>
				<%-- 	</c:if> --%>
				</div>
			</div>

			<div id="gnb">
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />
			<c:if test="${fn:length(topCategories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth01}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(topCategories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${topCategories[y].menuPopupYn=='Y'}">
						<a href="${topCategories[y].allMenuCours}" target="_blank">${topCategories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${topCategories[y].menuPopupYn!='Y'}">
						<a href="/bos/main/main.do?menuNo=${topCategories[y].menuNo}" >${topCategories[y].menuNm}</a>
		 			</c:if>
		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>

		</div>