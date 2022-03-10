<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<div class="board_top">
	<div>
		<form name="formSearch" id="formSearch" method="get" class="pure-form">
			<input type="hidden" name="menuNo" value="${param.menuNo}">
			
			<select name="srcSvItem03" id="srcSvItem03">
				<c:forEach begin="0" end="${yearToday - 2016 }" var="i" varStatus="status">
					<c:set var="yearOption" value="${yearToday - i }"/>
					<option value="${yearOption }" ${param.srcSvItem03 eq yearOption ? 'selected' : '' }>${yearOption }년</option>
				</c:forEach>
			</select>
			<button type="submit" id="btnStatsSearch" class='pure-button btnSave'>확인</button>
		</form>
	</div>
</div>

<h4>센터별 작성자 (명)</h4>
<table cellpadding="0" cellspacing="0" border="0" class="table02">
	<colgroup>
		<col width="30%" />
		<col width="" />
		<col width="" />
		<col width="" />
	</colgroup>
	<thead>
		<tr>
			<th>센터명</th>
			<th>합 계</th>
			<th>본 인</th>
			<th>보호자</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>합계</td>
			<td>${sum.svItem011 + sum.svItem012}</td>
			<td>${sum.svItem011}</td>
			<td>${sum.svItem012}</td>
		</tr>
		<c:forEach var="ctr" items="${center }" varStatus="status">
			<tr>
				<th>${ctr.centerCode}</td>
				<td>${ctr.svItem011 + ctr.svItem012}</td>
				<td>${ctr.svItem011}</td>
				<td>${ctr.svItem012}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

</div>