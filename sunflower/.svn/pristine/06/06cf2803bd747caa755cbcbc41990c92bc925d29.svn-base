<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- https-->
<!-- <script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> -->
<script>
//<![CDATA[

//]]>
</script>

	<h4 class="bu_t1">사이트 URL정보</h4>
	<div class="view">
		<dl>
			<dt>사이트구분</dt>
			<dd>${result.siteSeCdNm }</dd>
		</dl>
		<dl>
			<dt>사이트명</dt>
			<dd>${result.siteNm }</dd>
		</dl>
		<dl>
			<dt>사이트URL</dt>
			<dd><c:forEach var="url" items="${urlList }" varStatus="status"><dl>${url.checkUrlad }</dl></c:forEach></dd>
		</dl>
		<dl>
			<dt>알람주기</dt>
			<dd>${result.siteAlarmCycleCdNm }</dd>
		</dl>
		<dl>
			<dt>타임아웃시간</dt>
			<dd>${result.timeOutCycle } ms</dd>
		</dl>
		<dl>
			<dt>알람정지일시</dt>
			<dd>${result.alarmStopDt }</dd>
		</dl>
	</div>



