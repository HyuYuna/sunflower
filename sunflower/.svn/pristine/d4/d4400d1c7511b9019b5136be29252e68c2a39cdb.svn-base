<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>해바라기센터 정보시스템</title>
</head>
<body>

<%
	String ip = request.getLocalAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp or '192.168.0.10' eq myIp or '192.168.0.145' eq myIp or '0:0:0:0:0:0:0:1' eq myIp }">
<!-- 145 강태희 컴퓨터 -->
<ol>
	<li><a href="/bos/member/admin/forLogin.do">관리자페이지</a><br/> </li>
	<li><a href="/ucms/main/main.do">사용자  메인페이지</a></li>
	<!-- <li><a href="/ucms/main/main.do">GS인증 사용자  메인페이지</a></li> -->
	<!-- <li><a href="/static/guide/front/frontindex.html">사용자코딩</a> </li>
	<li><a href="/static/guide/bos/g.jsp">관리자 가이드</a></li>
	<li><a href="/static/guide/bos/bosindex.html">관리자 코딩</a></li> -->

</ol>
</c:if>
</body>
</html>
<%
	if (!"127.0.0.1".equals(ip) && !"192.168.0.10".equals(ip) && !"0:0:0:0:0:0:0:1".equals(ip)) {
		String requestUri = request.getRequestURL().toString();
		String host = request.getRemoteHost();

		response.sendRedirect("/ucms/main/main.do");
	}

%>
