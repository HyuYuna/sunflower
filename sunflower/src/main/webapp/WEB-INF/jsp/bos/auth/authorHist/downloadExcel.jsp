<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%
    String fileName ="USER_AUTHORHIST";
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
<title>사용자리스트</title>
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
text-align:middle;
vertical-align:middle;
border:none;
}
.excel12 {
color:black;
font-size:18.0pt;
text-decoration:none;
text-align:middle;
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
<table cellspacing="0" cellpadding="0">
    <tr style="height:26.25pt;">
        <td colspan="6" class="excel12" style="width:700pt;">권한 이력</td>
    </tr>
    <tr>
        <td class="excel2" style="height:16.5pt;border-top:none;">번호</td>
        <td class="excel2" style="height:16.5pt;border-top:none;">아이디</td>
        <td class="excel2" style="height:16.5pt;border-top:none;">사용자 </td>
        <td class="excel2" style="height:16.5pt;border-top:none;">등록일시</td>
        <td class="excel2" style="height:16.5pt;border-top:none;">상태내역</td>
        <td class="excel2" style="height:16.5pt;border-top:none;">등록자</td>
    </tr>                                                         
<c:forEach var="result" items="${resultList}" varStatus="status">
    <tr>
        <td class="excel3">${status.count}</td>
        <td class="excel3">${result.userId}</td>
        <td class="excel3">${result.userName2}</td>
        <td class="excel3"><fmt:formatDate value="${result.logPdate}" pattern="yyyy-MM-dd HH:mm"/></td>
        <td class="excel3">${result.logCate}</td>
        <td class="excel3">${result.regName}</td>
    </tr>
</c:forEach>
</table>
</body>
</html>
