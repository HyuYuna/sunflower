<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%
	String fileName ="data";
	String ExcelName  = new String(fileName.getBytes(),"UTF-8")+".xls";
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Pragma", "no-cache");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<style type="text/css">
<!--
.excel1 {
padding-top:1px;
padding-right:1px;
padding-left:1px;
color:black;
font-size:11.0pt;
font-weight:400;
font-style:normal;
text-decoration:none;
font-family:"맑은 고딕", monospace;
text-align:general;
vertical-align:middle;
border:none;
white-space:nowrap;
}
.excel2 {
padding-top:1px;
padding-right:1px;
padding-left:1px;
color:black;
font-size:11.0pt;
font-weight:400;
font-style:normal;
text-decoration:none;
font-family:"맑은 고딕", monospace;
text-align:general;
vertical-align:middle;
border:.5pt solid windowtext;
white-space:nowrap;
background:yellow;
}
.excel4 {
padding-top:1px;
padding-right:1px;
padding-left:1px;
color:black;
font-size:11.0pt;
font-weight:400;
font-style:normal;
text-decoration:none;
font-family:"맑은 고딕", monospace;
text-align:left;
vertical-align:middle;
border:.5pt solid windowtext;
white-space:nowrap;
}
.excel5 {
padding-top:1px;
padding-right:1px;
padding-left:1px;
color:black;
font-size:11.0pt;
font-weight:400;
font-style:normal;
text-decoration:none;
font-family:"맑은 고딕", monospace;
text-align:center;
vertical-align:middle;
border:.5pt solid windowtext;
white-space:nowrap;
background:yellow;
}
.excel3 {
padding-top:1px;
padding-right:1px;
padding-left:1px;
color:black;
font-size:11.0pt;
font-weight:400;
font-style:normal;
text-decoration:none;
font-family:"맑은 고딕", monospace;
text-align:center;
vertical-align:middle;
border:.5pt solid windowtext;
white-space:nowrap;
}
-->
</style>
</head>

<body>
<h1>설문조사 참여현황</h1>
<table cellspacing="0" cellpadding="0" class="excel1">
	<tr style="height:16.5pt;">
		<td class="excel2" width="72" style="height:16.5pt;width:54pt;">제목</td>
		<td colspan="7" class="excel4" width="517" style="border-left:none;width:388pt;">${result.qustnrSj}</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">설문대상</td>
		<td colspan="7" class="excel4" style="border-left:none;">${result.qustnrTrgetCdNm}</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">참여인원</td>
		<td colspan="7" class="excel4" style="border-left:none;">${result.appCnt}명</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">조사기간</td>
		<td colspan="7" class="excel4" style="border-left:none;">
			<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~
			<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
		</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">담당부서</td>
		<td colspan="7" class="excel4" style="border-left:none;">${result.deptKorNm}</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">전화번호</td>
		<td colspan="7" class="excel4" style="border-left:none;">${result.telno}</td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">등록일</td>
		<td colspan="7" class="excel4" style="border-left:none;"><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel2" style="height:16.5pt;border-top:none;">내용</td>
		<td colspan="7" class="excel4" style="border-left:none;">
		<c:choose>
			<c:when test="${result.htmlAt=='Y'}">${result.qestnarCn}</c:when>
			<c:otherwise>
				<util:out escapeXml="false">${result.qestnarCn}</util:out>
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr style="height:16.5pt;">
		<td style="height:16.5pt;"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr style="height:16.5pt;">
		<td class="excel5" style="height:16.5pt;">순번</td>
		<td class="excel5" style="border-left:none;">이름</td>
	<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
		<td class="excel5" style="border-left:none;">문제${status.count}</td>
	</c:forEach>
	</tr>
	<c:forEach var="item" items="${resultList}" varStatus="status">
	<tr style="height:16.5pt;">
		<td class="excel3">${status.count}</td>
		<td class="excel3">${empty item.userNm ? '-' : item.userNm}</td>
		<c:forEach var="qesitm" items="${qesitmList}" varStatus="s">
			<c:set var="key" value="Q${s.count}" />
			<c:set var="ua" value="${item[key]}" />
		<td class="excel3">${ua}</td>
		</c:forEach>
	</tr>
	</c:forEach>
</table>
</body>
</html>
