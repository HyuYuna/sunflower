
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

		<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<thead>
				<tr>
					<th style="width:35%" scope="col">KEY</th>
					<th scope="col">VALUE</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${systemProperties}" varStatus="status">
				<tr>

					<td class="output tal">${result.key}</td>
					<td class="output tal">${result.value}</td>
				</tr>
			</c:forEach>
			<c:forEach var="result" items="${jvmInfo}" varStatus="status">
				<tr>

					<td class="output tal">${result.key}</td>
					<td class="output tal">${result.value}</td>
				</tr>
			</c:forEach>
			<c:forEach var="result" items="${systemInfo}" varStatus="status">
				<tr>

					<td class="output tal">${result.key}</td>
					<td class="output tal">${result.value}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
