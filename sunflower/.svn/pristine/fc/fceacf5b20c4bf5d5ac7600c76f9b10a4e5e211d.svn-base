<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"  trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper"%>
<%@ page import="site.unp.cms.domain.MemberVO"%>
<%@ page import="site.unp.core.util.WebFactory"%>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>${result.title}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<style title="">
 * {padding:0; margin:0; font-family:dotum; font-size:11px; line-height:140%; text-decoration:none; vertical-align:top;}
 .box_close1day {width:100%; height:18px; background:#ddd; position:fixed; bottom:0; text-align:right; margin-right:10px;padding:8px 0}
 .box_close1day input {width:14px; height:14px; background:white;}
 .box_close1day p {padding:5px 10px 0 0;}
 .closeBtn{display:inline-block;padding:0 10px}
</style>
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/jquery.cookie.js"></script>
<script>
	function setCookie(name, value, expirehours) {
		var todayDate = new Date();
		todayDate.setHours(todayDate.getHours() + expirehours);
		document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	}

	function eventLayerClose() {
		$(":checkbox[name='checkbox']:checked").each(function(){
			//1일 안보는 쿠키셋
			setCookie("gnEventCookie"+this.id, "done", 24 * 1);
		});
		self.close();
	}
	
	

</script>
</head>
<body <c:if test="${result.scrlUseAt eq 'N' }">style="overflow-x:hidden; overflow-y:hidden"</c:if>>
<div style="position:relative;">
	<a href="${result.urlad}" target="_blank" title="새창열림">
		<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}'/>&streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="로고 이미지">
	</a>

<c:if test="${result.closeUseAt eq 'Y'}">
	<div class="box_close1day">
		<input type="checkbox" id="${result.popupNo }" name="checkbox"  /><label for="${result.popupNo }">오늘 창 그만보기</label>
		<a href="#" onclick="javascript:eventLayerClose();" class="closeBtn">[닫기]</a>
	</div>
</c:if>
</div>
</body>
</html>