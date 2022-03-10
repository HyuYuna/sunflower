<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>${result.title}</title>
<style>
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
	<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="${result.fileCn }">
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