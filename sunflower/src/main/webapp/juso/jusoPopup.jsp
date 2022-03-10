<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ page import="site.unp.core.util.StrUtils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 찾기</title>
<%
	request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	String inputYn = StrUtils.strTohtml(request.getParameter("inputYn"));
	String roadFullAddr = StrUtils.strTohtml(request.getParameter("roadFullAddr"));
	String roadAddrPart1 = StrUtils.strTohtml(request.getParameter("roadAddrPart1"));
	String roadAddrPart2 = StrUtils.strTohtml(request.getParameter("roadAddrPart2"));
	String engAddr = StrUtils.strTohtml(request.getParameter("engAddr"));
	String jibunAddr = StrUtils.strTohtml(request.getParameter("jibunAddr"));
	String zipNo = StrUtils.strTohtml(request.getParameter("zipNo"));
	String addrDetail = StrUtils.strTohtml(request.getParameter("addrDetail"));
	String bdMgtSn = StrUtils.strTohtml(request.getParameter("bdMgtSn"));
	String zipSe = StrUtils.strTohtml(request.getParameter("zipSe"));

	//bos는 아래 3개조건 제거
	/*
	if(roadAddrPart1 != null){
		roadAddrPart1 = new String(roadAddrPart1.getBytes("8859_1"),"UTF-8");
	}
	if(roadAddrPart2 != null){
		roadAddrPart2 = new String(roadAddrPart2.getBytes("8859_1"),"UTF-8");
	}
	if(addrDetail != null){
		addrDetail = new String(addrDetail.getBytes("8859_1"),"UTF-8");
	}
	*/

%>
</head>
<script language="javascript">
function init(){
	var url = location.href;
 	var confmKey = "<spring:eval expression="@prop['Global.juso.ApiKey']" />";
 	var inputYn = "<%=inputYn%>";
 	var zipSe = "<%=zipSe%>";
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
		//document.form.action="http://10.182.60.22/addrlink/addrLinkUrl.do"; //내부행망
		document.form.submit();
	}else{
		if (zipSe == "1") {
			opener.jusoCallBack2("<%=roadAddrPart1%>","<%=addrDetail%>"+"<%=roadAddrPart2%>","<%=zipNo%>");
		} else {
			opener.jusoCallBack("<%=roadAddrPart1%>","<%=addrDetail%>"+"<%=roadAddrPart2%>","<%=zipNo%>");
		}

		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
	</form>
</body>
</html>