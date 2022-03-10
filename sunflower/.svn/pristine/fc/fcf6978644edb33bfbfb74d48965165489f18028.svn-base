<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@ page import="site.unp.cms.service.captcha.ImageCaptCha, nl.captcha.Captcha"%>
<%try{
	out.clear();
	pageContext.pushBody();
	new ImageCaptCha().getCaptCha(request, response);
} catch(Exception e){
	e.printStackTrace();
}%>