<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<c:if test="${not empty masterVO.aditCntntsCn }">
<div>
	<util:out escapeXml="false">${masterVO.aditCntntsCn}</util:out>
</div>
</c:if>

<div class="totalCount"><em>총 <em>${paginationInfo.totalRecordCount}</em>건</em> | <em>${empty param.pageIndex ? 1 : param.pageIndex}/${paginationInfo.totalPageCount}</em> Page</div>
<form name="frm" action="/ucms/bbs/${paramVO.bbsId}/list.do" method="get" class="shSet">
<input type="hidden" name="menuNo" value="${param.menuNo}">

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
				<th scope="col" style="width:65px;" class="no">번호</th>
				<th scope="col">제목</th>
				<th scope="col" style="width:85px;" class="name">작성자</th>
				<th scope="col" style="width:100px;" class="date">등록일</th>
				<th scope="col" style="width:65px;" class="count">조회</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="pQueryStr">
			<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
		</c:set>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td class="num">
					<c:if test="${result.nttType eq '1' }">공지</c:if>
					<c:if test="${result.nttType ne '1' }">
					${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}
					</c:if>
				</td>
				<td class="tit"><a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pQueryStr}">${result.nttSj}</a></td>
				<td>${result.ntcrNm}</td>
				<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd" /></td>
				<td>${result.inqireCo}</td>
			</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		</tbody>
	</table>
</div>
<c:if test="${fn:length(resultList) == 0}">
	<script>
		$('.bdList table tbody').append('<tr><td class="nodata">'+'게시글이 존재하지 않습니다.'+'</td></tr>');
		$('.bdList').each(function(index, el) {
			$(this).find('td.nodata').attr('colspan',$(this).find('th').length)
		});
	</script>
</c:if>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>