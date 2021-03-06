<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>

</script>

<form name="frm" id="frm" action="list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
			<span class="shDate" ${calDate}>
			<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text" readonly="readonly">
			~
			<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
			</span>
			<span class="select">
				<select name="searchCnd" id="searchCnd" title="검색어 구분">
					<option value="1" <c:if test="${empty paramVO.searchCnd or paramVO.searchCnd == '1'}">selected="selected"</c:if>>아이디</option>
					<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>이름</option>
				</select>
			</span>
			<input type="hidden" name="searchFlag" value='${paramVO.searchFlag}' />
			<input type="text" title="검색어" name="searchKwd" value='${paramVO.searchKwd}' />
			<button class="b-sh">검색</button>
			<a href="list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
	</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->
</form>
<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>팝업관리 목록</caption>
		<thead>
			<tr>
				<th style="width:10%"		scope="col">번호</th>
				<th style="width:15%"		scope="col">이름</th>
				<th style="width:15%"		scope="col">아이디</th>
				<th style="width:15%"		scope="col">IP</th>
				<th	style="width:10%"		scope="col">로그인 성공여부</th>
				<th style="width:10%"		scope="col">해외여부</th>
				<th style="width:10%"		scope="col">모바일여부</th>
				<th style="width:15%"		scope="col">일시</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
			<tr>
				<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
				<td>${result.userNm}</td>
				<td>${result.userId}</td>
				<td>${result.userIpad}</td>
				<td>${result.sttusCd eq 'Y' ? '성공' : '실패'}</td>
				<td>${result.ovseaIpAt}</td>
				<td>${result.mobileAt}</td>
				<td>${fn:substring(result.loginDt,0,19)}</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>
<!-- board list end //-->

<div class="btnSet">
	&nbsp;<%-- <a class="b-reg" href="forInsert.do?menuNo=${param.menuNo}&${pageQueryString}"><span>등록</span></a> --%>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>