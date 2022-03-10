<%@page import="site.unp.core.dao.SqlDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isErrorPage="true" %>
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
//response.setStatus(200); /* 2019.02.20 보안이슈 처리 : 응답코드 200으로 처리 */
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());

SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
SqlDAO sqlDAO = (SqlDAO)context.getBean("SqlDAO");
ZValue site = siteMngService.getSiteBySiteName("ucms");
pageContext.setAttribute("siteVO", site);
%>

<c:if test="${pageContext.request.requestURI eq '/cmmn/error.jsp'}">
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>해바라기센터정보시스템 - 에러페이지</title>
	<style>

	*{padding: 0;margin: 0;}
	body{font-family: '맑은 고딕';font-size: 16px;padding-top: 180px;}
	h1{padding: 10px 0;font-size: 26px;margin: 0;font-weight: normal;}
	h1 em{color: #ff4e00;font-style: normal;}
	.errBox{width: 470px;padding-left: 303px;height: 200px;margin: 0 auto;
		background: url(/static/guide/comingsoon/warming.jpg) 0 0 no-repeat;
		border: 1px solid #e5e4e1;}
	.s{padding-top: 20px;}
	.footer{text-align: center;margin: 20px 0;font-size: 14px;}
	.beforePage {margin-top:10px;font-size : 13px;}
	</style>
	
	<script>
		function pageBack(){
			history.go(-1);
		}
		
		setInterval(function() {
			pageBack();
		}, 5000);
	</script>
</head>
</c:if>
<body>


<div class="errBoxSet">
	<div class="errBox">
		<div class="s">
			<%-- <p>${siteVO.siteNm}</p> --%>
			<p>해바라기센터정보시스템</p>
			<h1>페이지가 <em>없거나 잘못된 경로</em>입니다.</h1>
			<p>경로를 다시 확인하시고 이용해 주시기 바랍니다. 이용에 불편을 드려 대단히 죄송합니다.</p>
			<p class="beforePage">5초 후 이전 페이지로 자동으로 이동합니다.</p>
			<button type="button" onclick="pageBack();" class="back">이전 페이지로 돌아가기</button>
		</div>
	</div>
</div>
<%
String ip = request.getLocalAddr();
request.setAttribute("myIp", ip);

if (exception!=null){

	System.out.println("========================== jsp Error Log Start !! ================================");
	System.out.println("Error Type : " + exception.getClass().getName());
	System.out.println("Error Message : " + exception.getMessage());
	System.out.println("========================== jsp Error Log End !! ================================");


	ZValue param = new ZValue();
	param.putObject("userId", request.getRemoteUser());
	param.putObject("userIpad", request.getRemoteAddr());
	param.putObject("errorUrlad", request.getAttribute("javax.servlet.forward.request_uri")==null ? request.getRequestURI() : request.getAttribute("javax.servlet.forward.request_uri").toString());
	param.putObject("beforeUrlad", request.getHeader("Referer")==null ? "" : request.getHeader("Referer").toString());
	param.putObject("errorSj", exception != null ? exception.getClass().getName() : null);
	param.putObject("msg", exception != null ? exception.getMessage() : null);

	try {
		sqlDAO.save("saveErrorLog", param);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

}
%>
<c:if test="${pageContext.request.requestURI eq '/cmmn/error.jsp'}">
<footer class="footer">
	<%-- <address>
		<p ><c:if test="${siteVO.zipUseAt eq 'Y'}">[${siteVO.zip}]</c:if><c:if test="${siteVO.adres1UseAt eq 'Y'}">${siteVO.adres1}</c:if><c:if test="${siteVO.adres2UseAt eq 'Y'}"> ${siteVO.adres2}</c:if> <c:if test="${siteVO.insttNmUseAt eq 'Y'}">${siteVO.insttNm}</c:if> <c:if test="${siteVO.telnoUseAt eq 'Y'}">, TEL : ${siteVO.telno}</c:if> <c:if test="${siteVO.faxnoUseAt eq 'Y'}">, FAX : ${siteVO.faxno}</c:if></p>
		<c:if test="${siteVO.cpyrhtCnUseAt eq 'Y'}"><em>${siteVO.cpyrhtCn}</em></c:if>
	</address> 
	 --%>
	<address>
		<p >Copyright (c) 2021 해바라기센터 정보시스템 All rights reserved.</p>
	</address>
	
</footer>
</body>
</html>
</c:if>