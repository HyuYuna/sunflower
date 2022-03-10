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

SiteInfoService siteMngService = context.getBean("siteInfoService" ,SiteInfoService.class);
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
	<script>

	</script>
<div id="header_wrap">
	<div class="header">
		<c:if test="${not empty siteVO.atchFileId}"><h1><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="${siteVO.siteNm}"></h1></c:if>
		<c:if test="${empty siteVO.atchFileId}"><h1><img src="/static/bos/img/logo.png" alt="${siteVO.siteNm}"> </h1></c:if>
	</div>
</div>
<form name="loginForm" action ="/bos/member/admin/toLogin.do" method="post">

</form>


<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>

</body>
</html>