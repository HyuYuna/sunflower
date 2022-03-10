<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
	<style type="text/css">
		table td {text-align:center}
		.tit {text-align:left}
	</style>
</head>
<body>
	<table class="table table-hover" border="1">
		<thead>
			<tr>
				<th scope="col">메뉴명</th>
				<th scope="col">매우만족</th>
				<th scope="col">만족</th>
				<th scope="col">보통</th>
				<th scope="col">불만족</th>
				<th scope="col">매우불만족</th>
				<th scope="col">총계</th>
			</tr>
		</thead>
	 	<c:forEach var="result" items="${resultList}">
	 		<tfoot>
				<c:if test="${empty result.menuNo }">
					<tr>
						<td>총계</td>
						<td>${result.stsfdg5Co}</td>
						<td>${result.stsfdg4Co}</td>
						<td>${result.stsfdg3Co}</td>
						<td>${result.stsfdg2Co}</td>
						<td>${result.stsfdg1Co}</td>
						<td>${result.prtcpntCo}</td>
					</tr>
				</c:if>
			</tfoot>
			<tbody>
				<c:if test="${not empty result.menuNo }">
					<tr>
						<td class="tit">${result.menuNm }</td>
						<td>${result.stsfdg5Co}</td>
						<td>${result.stsfdg4Co}</td>
						<td>${result.stsfdg3Co}</td>
						<td>${result.stsfdg2Co}</td>
						<td>${result.stsfdg1Co}</td>
						<td>${result.prtcpntCo}</td>
					</tr>
				</c:if>
			</tbody> 
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}" >
			<tbody>
				<tr><td colspan="7">데이터가 없습니다.</td></tr>
			</tbody>
		</c:if>
	</table>
</body>
</html>

