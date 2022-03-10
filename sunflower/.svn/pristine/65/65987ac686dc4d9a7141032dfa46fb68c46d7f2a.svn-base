<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="topCategories" value="${menuAll_ucms['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />

<p class="infor">홈페이지 전체 메뉴를 한 눈에 확인하실 수 있습니다.</p>
<script>
$(function() {
	var maxH=0
	$('.sm>ul>li').each(function(index, el) {
		maxH=maxH<$(this).height()?$(this).height():maxH
		console.log($(this).height())
	}).find('.set').height(maxH);
});
</script>

<div class="sm">
<ul>
<c:set var="num" value="1"/>
<c:set var="sNum" value=""/>

<c:if test="${not empty topCategories}">
	<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}" step="1">
	<c:set var="sNum" value="${num}"/>
	<c:if test="${num lt 10}"><c:set var="sNum" value="0${num}"/></c:if>
	<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
	<c:set var="d02Categories" value="${menuAll_ucms[d02MenuKey]}" />


	<c:set var="viewFlag1" value="Y" />
	<c:choose>
		<c:when test="${topCategories[x].menuExpsrSe eq 'LOGIN' }">
			<sec:authorize access="!hasRole('ROLE_USERKEY')">
				<c:set var="viewFlag1" value="N" />
			</sec:authorize>
		</c:when>
		<c:when test="${topCategories[x].menuExpsrSe eq 'NOLOGIN' }">
			<sec:authorize access="hasRole('ROLE_USERKEY')">
				<c:set var="viewFlag1" value="N" />
			</sec:authorize>
		</c:when>
		<c:otherwise>
			<c:set var="viewFlag1" value="Y" />
		</c:otherwise>
	</c:choose>
	<c:if test="${viewFlag1 eq 'Y' }">
	<li>
		<div class="set i${sNum}">
			<span class="num">${sNum}</span>
			<span class="title"><a href="${topCategories[x].allMenuCours}" ${topCategories[x].popupAt eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a></span>
			<c:if test="${not empty d02Categories}">
			<ul>
				<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
					<c:set var="viewFlag2" value="Y" />
					<c:choose>
						<c:when test="${d02Categories[y].menuExpsrSe eq 'LOGIN' }">
							<sec:authorize access="!hasRole('ROLE_USERKEY')">
								<c:set var="viewFlag2" value="N" />
							</sec:authorize>
						</c:when>
						<c:when test="${d02Categories[y].menuExpsrSe eq 'NOLOGIN' }">
							<sec:authorize access="hasRole('ROLE_USERKEY')">
								<c:set var="viewFlag2" value="N" />
							</sec:authorize>
						</c:when>
						<c:otherwise>
							<c:set var="viewFlag2" value="Y" />
						</c:otherwise>
					</c:choose>
					<c:if test="${viewFlag2 eq 'Y' }">

					<li><a href="${d02Categories[y].allMenuCours}" ${d02Categories[y].popupAt eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>

					</c:if>
				</c:forEach>
			</ul>
			</c:if>
		</div>
	</li>
	</c:if>
	<c:set var="num" value="${num+1}"/>
	</c:forEach>
</c:if>
</ul>
</div>