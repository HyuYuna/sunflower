<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<div class="totalCount"><em>총 <em>${paginationInfo.totalRecordCount}</em>건</em> | <em>${empty param.pageIndex ? 1 : param.pageIndex}/${paginationInfo.totalPageCount}</em> Page</div>
<form name="frm" action="/${paramVO.siteId}/myPage/qna/list.do" method="get" enctype="multipart/form-data" class="shSet">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="bbsId" value="${param.bbsId}">

	<div class="sh">
		<select id="stributary" name="searchCnd" title="검색조건">
			<option value="1" <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if> >제목</option>
			<option value="3" <c:if test="${paramVO.searchCnd eq '3'}">selected="selected"</c:if> >제목+내용</option>
		</select>
		<input title="검색어" name="searchWrd" value="${paramVO.searchWrd}" type="text">
		<button class="b-sh">검색</button>
	</div>
</form>
<div class="bdList">
	<table>
		<caption>${masterVO.bbsNm} 목록</caption>
		<thead>
			<tr>
				<th style="width:65px"  scope ="col" class="no">번호</th>
				<th 		            scope ="col">제목</th>
				<th style="width:85px"  scope ="col">진행상태</th>
				<th style="width:85px"  scope ="col" class="name">작성자</th>
				<th style="width:100px" scope ="col" class="date">등록일</th>
				<th style="width:65px"  scope ="col" class="count">조회</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="pQueryStr">
			<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
		</c:set>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><a href="/${paramVO.siteId}/myPage/qna/view.do?bbsId=${result.bbsId}&nttId=${result.nttId}&${pQueryStr}">${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</a></td>
				<td class="tit"><a href="/${paramVO.siteId}/myPage/qna/view.do?bbsId=${result.bbsId}&nttId=${result.nttId}&${pQueryStr}">${result.nttSj}</a></td>
				<td>
					<c:choose>
						<c:when test="${result.answerAt eq 'Y'}"><span class="ico-reply-end">답변완료</span></c:when>
						<c:otherwise><span class="ico-reply-ing">답변대기</span></c:otherwise>
					</c:choose>
				</td>
				<td>${result.ntcrNm}</td>
				<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd" /></td>
				<td>${result.inqireCo}</td>
			</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="6">게시글이 존재하지 않습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>
<%-- <div class="btnSet">
	<a href="/ucms/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="b-reg">글쓰기</a>
</div> --%>