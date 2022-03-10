<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="/static/ucms/css/default.css">
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<c:set var="title" value="" />
<title>${title}</title>
</head>
<body>
<div id="popWrap">
	<c:choose>
		<c:when test="${not empty cvCon}">
			${cvCon}
		</c:when>
		<c:otherwise>
			<c:set var="_includePage" value="" />
			<c:choose>
				<c:when test="${not empty param.incPage}">
					<c:set var="_includePage" value="${incPage}" />
				</c:when>
				<c:when test="${empty includePage}">
					<c:set var="_includePage" value="${currMenu.contentsPath}" />
				</c:when>
				<c:otherwise>
					<c:set var="_includePage" value="${includePage}" />
				</c:otherwise>
			</c:choose>
			<c:catch var="catchException">
				<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
			</c:catch>
		</c:otherwise>
	</c:choose>
	<!-- <button type="button" onclick="window.close();" class="closeWindow"><span class="hidden">창 닫기</span></button> -->
</div>

<%
	String ip = request.getRemoteAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp  }">
<span>*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</span>
</c:if>
</body>
</html>