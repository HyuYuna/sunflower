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
	<c:choose>
		<c:when test="${paramVO.excelTp eq 'date'}">
			 <table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td>날짜</td>
		                <td>페이지뷰(건)</td>
		                <td>방문자수(명)</td>
		            </tr>
		        </thead>
		        <c:if test="${fn:length(resultList) gt 0}" >
		 		<tbody>
		        	<c:set var="pcntTot" value="0"/>
		        	<c:set var="vcntTot" value="0"/>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.conectDe}</th>
		                <td>${result.pcnt}</td>
		                <td>${result.vcnt}</td>
		            </tr>
		            <c:set var="pcntTot" value="${pcntTot+result.pcnt}"/>
		            <c:set var="vcntTot" value="${vcntTot+result.vcnt}"/>
		            </c:forEach>
		            <tr>
		                <th scope="row">계</th>
		                <td>${pcntTot}</td>
		                <td>${vcntTot}</td>
		            </tr>
		        </tbody>
		        </c:if>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:when>
		<c:when test="${paramVO.excelTp eq 'menu'}">
			<table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td>메뉴명</td>
		                <td>페이지뷰(건)</td>
		            </tr>
		        </thead>
		        <c:if test="${fn:length(resultList) gt 0}" >
		 		<tbody>
		        	<c:set var="pcntTot" value="0"/>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.menuPath}</th>
		                <td>${result.pcnt}</td>
		            </tr>
		            <c:set var="pcntTot" value="${pcntTot+result.pcnt}"/>
		            </c:forEach>
		            <tr>
		                <th scope="row">계</th>
		                <td>${pcntTot}</td>
		            </tr>
		        </tbody>
		        </c:if>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="2">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:when>
		<c:otherwise>
			<table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td>
		                <c:choose>
		                	<c:when test="${paramVO.excelTp eq 'os'}">운영체제</c:when>
		                	<c:when test="${paramVO.excelTp eq 'browser'}">브라우저</c:when>
		                	<c:when test="${paramVO.excelTp eq 'pcMobile'}">PC/모바일</c:when>
		                	<c:otherwise></c:otherwise>
		                </c:choose>

		                </td>
		                <td>페이지뷰(건)</td>
		                <td>방문자수(명)</td>
		            </tr>
		        </thead>
		        <c:if test="${fn:length(resultList) gt 0}" >
		 		<tbody>
		        	<c:set var="pcntTot" value="0"/>
		        	<c:set var="vcntTot" value="0"/>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.smSeValue}</th>
		                <td>${result.pcnt}</td>
		                <td>${result.vcnt}</td>
		            </tr>
		            <c:set var="pcntTot" value="${pcntTot+result.pcnt}"/>
		            <c:set var="vcntTot" value="${vcntTot+result.vcnt}"/>
		            </c:forEach>
		            <tr>
		                <th scope="row">계</th>
		                <td>${pcntTot}</td>
		                <td>${vcntTot}</td>
		            </tr>
		        </tbody>
		        </c:if>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:otherwise>
		<%-- <c:when test="${paramVO.excelTp eq 'os'}">
			<table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td></td>
		                <td>페이지뷰</td>
		                <td>방문자수</td>
		            </tr>
		        </thead>
		 		<tbody>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.smSeValue}</th>
		                <td>${result.pcnt}</td>
		                <td>${result.vcnt}</td>
		            </tr>
		            </c:forEach>
		        </tbody>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:when>
		<c:when test="${paramVO.excelTp eq 'browser'}">
			<table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td></td>
		                <td>페이지뷰</td>
		                <td>방문자수</td>
		            </tr>
		        </thead>
		 		<tbody>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.smSeValue}</th>
		                <td>${result.pcnt}</td>
		                <td>${result.vcnt}</td>
		            </tr>
		            </c:forEach>
		        </tbody>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:when>
		<c:when test="${paramVO.excelTp eq 'pcMobile'}">
			<table class="table table-hover" border="1">
		        <thead>
		            <tr>
		                <td></td>
		                <td>페이지뷰</td>
		                <td>방문자수</td>
		            </tr>
		        </thead>
		 		<tbody>
		        	<c:forEach var="result" items="${resultList}" varStatus="status">
		            <tr>
		                <th scope="row">${result.smSeValue}</th>
		                <td>${result.pcnt}</td>
		                <td>${result.vcnt}</td>
		            </tr>
		            </c:forEach>
		        </tbody>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tbody>
						<tr><td colspan="3">데이터가 없습니다.</td></tr>
					</tbody>
				</c:if>
			</table>
		</c:when> --%>
	</c:choose>

</body>
</html>

