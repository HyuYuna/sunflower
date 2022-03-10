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
            	<th>파일명</th>
                <td>메뉴경로</td>
                <td>글제목</td>
                <td>다운로드수</td>
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
				<tr><td colspan="4">데이터가 없습니다.</td></tr>
			</tbody>
		</c:if>
	</table>
</body>
</html>

