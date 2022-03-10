<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<script>
function goSearch(frm2){
	return true;
}
</script>


<h4 class="bu_t1">사이트 장애로그</h4>
<form id="frm2" name="frm2" method="get" action="/bos/member/uwam/listErrLog.do" onsubmit="return goSearch(this);" class="form-inline">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="viewType" value="${paramVO.viewType}">
	<input type="hidden" name="siteSn" value="${paramVO.siteSn}">

	<!-- 게시판 게시물검색 start -->
	<fieldset>
		<div class="sh">
			<input type="text" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" placeholder="검색어" title="검색어" />
			<button class="b-sh">검색</button>
			<a href="/bos/member/user/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</div>
	</fieldset>
	<!-- 게시판 게시물검색 end -->

	<div class="row mt10 mb5">
		<div class="col-md-12">
			총 : <strong class="text-danger">${resultCnt }</strong>건 |
			<strong class="text-danger">${paramVO.pageIndex } / ${paginationInfo.totalPageCount }</strong> Page
		</div>
	</div>

	<!-- board list start -->
	<div class="bdList">
		<table class="table">
			<caption>사이트 장애 로그 목록</caption>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">응답성공여부</th>
					<th scope="col">HTTP응답코드</th>
					<th scope="col">장애 에러메세지</th>
					<th scope="col">등록일시</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
						<td>
						<c:choose>
							<c:when test="${result.rspnsSuccesAt eq 'Y'}">정상</c:when>
							<c:otherwise>장애</c:otherwise>
						</c:choose>
						</td>
						<td>${result.httpRspnsCode }</td>
						<td>${result.rspnsErrorMssage}</td>
						<td>${result.registDt}</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="5">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->
</form>

<%--
<div class="btnSet">
	<a class="btn btn-primary" href="/bos/member/user/forInsert.do?${pageQueryString}" id="regBtn"><span>등록</span></a>
	<a class="btn btn-inverse" href="#self"><span>비밀번호 초기화</span></a>
	<a class="btn btn-danger" href="javascript:del();"><span>삭제</span></a>
	<a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a>
</div>
--%>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>