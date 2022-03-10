<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>

<%
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());

SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
ZValue site = siteMngService.getSiteBySiteName(siteMngService.BOS_SITE_ID);
pageContext.setAttribute("siteVO", site);
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title> <spring:message code="site.korName" text=""/> 관리자페이지 로그인</title>
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/bos/css/bossub.css" />

<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script src="/static/jslibrary/bootstrap/respond.min.js"></script>
<script src="/static/jslibrary/jquery-ui/jquery-ui.js"></script>
<script src="/static/jslibrary/jquery.maskedinput.min.js"></script>
<script src="/static/jslibrary/jquery.cookie.js"></script>
<!-- <script src="/static/jslibrary/base64.js"></script> -->
<script src="/static/jslibrary/miya_validator.js"></script>
<script src="/static/bos/js/boscommon.js"></script>
<script src="/static/commons/commons.js"></script>
<script src="/static/jslibrary/ssl.js"></script>
</head>
<body class="login">
<div id="header_wrap">
	<div class="header">
		<h1><img src="/static/bos/img/logo.png" alt="${siteVO.siteNm}"> </h1>
	</div>
</div>
<form name="loginForm" id="loginForm" action ="" method="post">
<input type="hidden" name="mode" value="PUSH">
<input type="hidden" name="retUrl" id="retUrl" value="">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>



	<div class="snsLogin">
		<h3>SNS 로그인</h3>
		<ul>
			<li><a href="#google" id="google"><span>구글</span></a></li>
			<li><a href="#naver" id="naver"><span>네이버</span></a></li>
			<li><a href="#kakao" id="kakao"><span>카카오록</span></a></li>
		</ul>
	</div>

	<script>
	$(".snsLogin li a").on('click',function(){
		$("#retUrl").val(encodeURIComponent('/push/main/main.do'));
		$("#loginForm").attr("action","/ucms/oauth/sns/"+$(this).attr("id")+"Login.do");
		$("#loginForm").submit();
		return false;
	});
	</script>

</form>


<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>

</body>
</html>