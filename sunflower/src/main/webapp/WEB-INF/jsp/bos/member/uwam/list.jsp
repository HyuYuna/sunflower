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
<form id="frm2" name="frm2" method="get" action="/bos/member/uwam/list.do" onsubmit="return goSearch(this);" class="form-inline">
	<input type="hidden" name="menuNo" value="${param.menuNo}">

	<!-- 게시판 게시물검색 start -->
	<fieldset>
		<div class="sh">
			<label for="confmAt">승인여부</label>
			<select name="confmAt" id="confmAt" title="승인여부">
				<option value="">승인여부 선택</option>
				<option value="Y" <c:if test="${param.confmAt eq 'Y'}">selected="selected"</c:if>>승인완료</option>
				<option value="N" <c:if test="${param.confmAt eq 'N'}">selected="selected"</c:if>>승인대기</option>
			</select>
			<%-- <label for="userTyCd">회원구분</label>
			<select name="userTyCd" id="userTyCd" title="회원구분 선택해 주세요.">
				<option value="">회원구분 선택</option>
				<c:forEach var="code" items="${userTyCdCodeList }">
					<option value="${code.cd }" <c:if test="${param.userTyCd eq code.cd}">selected="selected"</c:if>>${code.cdNm }</option>
				</c:forEach>
			</select>
			 --%>
			 <%--
			<label for="searchCnd">검색조건</label>
			<select id="searchCnd" name="searchCnd">
				<option value="1" <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if>>이름</option>
				<option value="2" <c:if test="${paramVO.searchCnd eq '2'}">selected="selected"</c:if>>아이디</option>
			</select>
			 --%>
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
			<caption>PUSH회원관리 목록</caption>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">인증구분</th>
					<th scope="col">성명</th>
					<th scope="col">가입일</th>
					<th scope="col">승인상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
						<td>${result.snsSe}</td>
						<td class="tit"><a href="/${paramVO.siteId }/member/uwam/view.do?snsId=${result.snsId}&amp;${pageQueryString}">${result.userNm}</a></td>
						<!-- <td>${result.crtfcSeCdNm}</td> -->
						<td>${result.registDt}</td>
						<td>${result.confmAt eq 'Y' ? '승인완료' : '미승인'}</td>
						<%-- <td><fmt:formatDate value="${result.lastLoginDt}" pattern="yyyy-MM-dd HH:mm"/></td> --%>
s
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