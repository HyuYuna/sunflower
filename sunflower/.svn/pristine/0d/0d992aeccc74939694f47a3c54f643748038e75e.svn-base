<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<!DOCTYPE html>
<html lang="ko">
<head>

<title>공통팝업</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />

<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/jslibrary/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="/static/font/NotoSans/notosans.css" />
<link rel="stylesheet" href="/static/bos/css/bossub.css" />

<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script src="/static/jslibrary/jquery-ui/jquery-ui.js"></script>

<script src="/static/jslibrary/miya_validator.js"></script>
<script src="/static/bos/js/boscommon.js"></script>
<script Language="JavaScript" src="/static/bos/manager/js/common.js"></script>
<script>
$(document).ready(function() {
	$("title").text($("h1").text());
});
</script>

</head>
<body class="bodyindex">


<div id="wrap" class="popupWrap">

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
</div>

<%
	String ip = request.getLocalAddr();
	request.setAttribute("myIp", ip);
%>
<div class="clear">
<c:if test="${'127.0.0.1' eq myIp or '192.168.0.13' eq myIp or '0:0:0:0:0:0:0:1' eq myIp}">
<font color="red">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</font>
</div>
</c:if>
</body>
</html>