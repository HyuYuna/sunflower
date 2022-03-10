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
            	<th>���ϸ�</th>
                <td>�޴����</td>
                <td>������</td>
                <td>�ٿ�ε��</td>
            </tr>
        </thead>
 		<tbody>
        	<c:forEach var="result" items="${resultList}" varStatus="status">
            <tr>
            	<th scope="row">${result.orignlFileNm}</th>
                <td>${fn:replace(result.relateMenuNmList,'|',' > ' )}</td>
                <td>${result.nttSj}</td>
                <td>${result.dwldCo}</td>
            </tr>
            </c:forEach>
        </tbody>
		<c:if test="${fn:length(resultList) eq 0}" >
			<tbody>
				<tr><td colspan="4">�����Ͱ� �����ϴ�.</td></tr>
			</tbody>
		</c:if>
	</table>
</body>
</html>

