<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" %>
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
<title>설문조사결과</title>
<style type="text/css">
[class^=excel]{
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	font-style:normal;
	font-family:"맑은 고딕", monospace;
	font-weight:400;
	white-space:nowrap;
}
.excel1 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:general;
vertical-align:middle;
border:none;
}
.excel12 {
color:black;
font-size:18.0pt;
text-decoration:none;
text-align:general;
vertical-align:middle;
border:none;
}
.excel2 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:general;
vertical-align:middle;
border:.5pt solid windowtext;
background:yellow;
}
.excel10 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:left;
vertical-align:middle;
border:.5pt solid windowtext;
}
.excel4 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:center;
vertical-align:middle;
border:none;
border-top:.5pt solid windowtext;
border-right:none;
border-bottom:.5pt solid windowtext;
border-left:.5pt solid windowtext;
}
.excel13 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:left;
vertical-align:middle;
border:.5pt solid windowtext;
background:yellow;
}
.excel7 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:left;
vertical-align:middle;
border:none;
border-top:.5pt solid windowtext;
border-right:none;
border-bottom:.5pt solid windowtext;
border-left:.5pt solid windowtext;
}
.excel3 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:general;
vertical-align:middle;
border:.5pt solid windowtext;
}
.excel11 {
color:black;
font-size:11.0pt;
text-decoration:none;
text-align:general;
vertical-align:middle;
border:.5pt solid windowtext;
}
</style>
</head>
<body>
<table cellspacing="0" cellpadding="0" class="excel1">
	<tr style="height:26.25pt;">
		<td width="72" style="height:26.25pt;width:54pt;"></td>
		<td colspan="3" class="excel12" style="width:320pt;">설문조사 결과</td>
	</tr>
	<tr> <td colspan="4"></td> </tr>
	<tr>
		<td class="excel2">제목</td>
		<td colspan="3" class="excel10" style="border-left:none;">${result.qustnrSj}</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">설문대상</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">${result.qustnrTrgetCdNm}</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">참여인원</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">${result.appCnt}명</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">조사기간</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">
			<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~
			<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
		</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">담당부서</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">${result.deptKorNm}</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">전화번호</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">${result.telno}</td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">등록일</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;"><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></td>
	</tr>
	<tr>
		<td class="excel2" style="height:16.5pt;border-top:none;">내용</td>
		<td colspan="3" class="excel4" style="border-right:.5pt solid black;border-left:none;">
		<c:choose>
			<c:when test="${result.htmlAt=='Y'}">${result.qestnarCn}</c:when>
			<c:otherwise>
				<util:out escapeXml="false">${result.qestnarCn}</util:out>
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr>
		<td colspan="4"></td>
	</tr>
<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
	<tr>
		<td colspan="4" class="excel13">${status.count}. ${qesitm.qesitmSj }</td>
	</tr>
	<c:if test="${qesitm.qesitmTyCd eq 1 or qesitm.qesitmTyCd eq 2}">
		<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
		<c:set var="answerList" value="${answerMap[key]}" />
		<c:forEach var="answer" items="${answerList}" varStatus="s">
	<tr>
		<td colspan="2" class="excel7" style="border-right:.5pt solid black;height:16.5pt;">${s.count}. ${answer.answerCn}</td>
		<td width="72" class="excel3" style="border-top:none;border-left:none;">&nbsp;${answer.answerCnt} / ${qesitm.appCnt}</td>
		<td width="72" align="right" class="excel11" style="border-top:none;border-left:none;">
			<fmt:formatNumber var="answerPercent" type="number" minFractionDigits="0" maxFractionDigits="0" value="${qesitm.appCnt eq 0 ? 0 : answer.answerCnt*100/qesitm.appCnt}" />
			${answerPercent}%
		</td>
	</tr>
		</c:forEach>
	<tr>
		<td colspan="4"></td>
	</tr>
	</c:if>
	<c:if test="${qesitm.qesitmTyCd eq 3 or qesitm.qesitmTyCd eq 4}">
		<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
		<c:set var="userAnswerList" value="${userAnswerMap[key]}" />
		<c:forEach var="answer" items="${userAnswerList}" varStatus="s">
	<tr>
		<td colspan="4" class="excel7" style="border-right:.5pt solid black;height:16.5pt;">${s.count}. ${answer.answerCn}</td>
	</tr>
		</c:forEach>
	<tr>
		<td colspan="4"></td>
	</tr>
	</c:if>
</c:forEach>
</table>
</body>
</html>