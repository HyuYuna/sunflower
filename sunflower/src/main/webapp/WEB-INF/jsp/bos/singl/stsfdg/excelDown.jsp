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
				<th scope="col">�޴���</th>
				<th scope="col">�ſ츸��</th>
				<th scope="col">����</th>
				<th scope="col">����</th>
				<th scope="col">�Ҹ���</th>
				<th scope="col">�ſ�Ҹ���</th>
				<th scope="col">�Ѱ�</th>
			</tr>
		</thead>
	 	<c:forEach var="result" items="${resultList}">
	 		<tfoot>
				<c:if test="${empty result.menuNo }">
					<tr>
						<td>�Ѱ�</td>
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
				<tr><td colspan="7">�����Ͱ� �����ϴ�.</td></tr>
			</tbody>
		</c:if>
	</table>
</body>
</html>

