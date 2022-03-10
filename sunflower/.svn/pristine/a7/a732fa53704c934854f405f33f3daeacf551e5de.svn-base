<%@page import="java.io.FileNotFoundException"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.lang.reflect.UndeclaredThrowableException"%>
<%@ page import="org.springframework.web.multipart.MultipartException"%>
<%@page import="org.springframework.dao.DataAccessException"%>
<%@ page import="jxl.read.biff.BiffException"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver"%>
<%@ page import="site.unp.core.exception.UnpBizException"%>
<%@ page import="site.unp.core.exception.UnSupportedFileException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	boolean isAlert = false;
	String msg = null;
	String returnUrl = null;
	Exception e = request.getAttribute(SimpleMappingExceptionResolver.DEFAULT_EXCEPTION_ATTRIBUTE)!=null ? (Exception)request.getAttribute(SimpleMappingExceptionResolver.DEFAULT_EXCEPTION_ATTRIBUTE): null;
	if ( e instanceof UndeclaredThrowableException ) {
		UndeclaredThrowableException ute = (UndeclaredThrowableException)e;
		Throwable _e = ute.getUndeclaredThrowable();
		if ( _e instanceof UnpBizException ) {
	    	UnpBizException ube = (UnpBizException)_e;
	    	//msg = ube.getMessage();
	    	msg = "에러가 발생하였습 니다. 관리자에게 문의하여 주십시오.";
	    	returnUrl = ube.getReturnUrl();
	    	isAlert = true;
	    }
		else if ( _e instanceof UnSupportedFileException ) {
			UnSupportedFileException ube = (UnSupportedFileException)_e;
	    	//msg = ube.getMessage();
	    	msg = "알수 없는 에러가 발생하였습 니다.";
	    	returnUrl = "back";
	    	isAlert = true;
	    }
		else {
			//msg = ute.getUndeclaredThrowable().getMessage();
			msg = "알수 없는 에러가 발생하였습 니다.";
		}

    }
	else if ( e instanceof DataAccessException ) {
		//throw new FileNotFoundException();
		// 데이터 베이스 에러...
    	msg = "잘못된 접근입니다.";
    	isAlert = true;
    }
	else if ( e instanceof BiffException ) {
    	msg = "엑셀 97-2003통합문서로 저장해서 업로해 주십시요.";
    	isAlert = true;
    }
	else if ( e instanceof MultipartException) {
    	msg = "파일용량이 100Mb 이상 업로드 하였거나, 같은파일을 두번이상 올렸습니다.";
    	isAlert = true;
	}
	else if ( e instanceof UnpBizException ) {
    	UnpBizException ube = (UnpBizException)e;
    	//msg = ube.getMessage();
    	msg = "접근권한이 없거나 에러가 발생하였습니다.";
    	returnUrl = ube.getReturnUrl();
    	isAlert = true;
    }
	else {
		msg = "알수 없는 에러가 발생하였습 니다.";//e.getMessage();

	}
    if ( !StringUtils.hasText(msg) ) {
    	msg = "작업에 실패하였습니다.";
    }
    if ( !StringUtils.hasText(returnUrl) ) {
    	returnUrl = "/cmmn/error.jsp";
    }
    pageContext.setAttribute("isAlert", isAlert);
    pageContext.setAttribute("msg", msg);
    pageContext.setAttribute("returnUrl", returnUrl);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>에러안내</title>
	<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
	<script>
	$(function(){
		var isAlert = '${isAlert}';
		var msg = '${msg}';
		var returnUrl = '${returnUrl}';
		if (isAlert == 'true') {
			alert(msg);
		}
		if (returnUrl == "back") {
			history.back();
		}
		else {
			location.href = returnUrl;
		}

	});
	</script>
</head>
<body>
<noscript>에러안내 : ${msg} <a href="${returnUrl}">되돌아가기</a></noscript>
</body>
</html>s