<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<script>
function goSearch(form) {
	return true;
}
</script>

<form id="form" name="form" method="get" action="/bos/singl/uwamAlarmLog/list.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<div class="sh">
		<fieldset>
			<label for="searchCnd">검색조건</label>
			<select id="searchCnd" name="searchCnd" class="select">
				<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
				<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>사이트명</option>
			</select>
			<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}' />
			<button type="submit" class="b-sh">검색</button>
			<a href="/bos/singl/uwamAlarmLog/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</fieldset>
	</div>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12">
		총 : <strong class="text-danger">${resultCnt }</strong>건 |
		<strong class="text-danger">${paramVO.pageIndex } / ${paginationInfo.totalPageCount }</strong> Page
	</div>
</div>

<div class="bdList">
	<table class="table table-striped table-hover">
		<caption>게시물 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*%" />
				<col width="15%" />
				<col width="12%" />
				<col width="15%" />
			</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">사이트명</th>
				<th scope="col">HTTP응답코드</th>
				<th scope="col">등록일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
					<td class="tit"><a href="/bos/singl/uwamAlarmLog/view.do?menuNo=${param.menuNo }&alarmSn=${result.alarmSn}">${result.alarmSj}</a></td>
					<td>${result.siteNm}</td>
					<td>${result.httpRspnsCd}</td>
					<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="5">데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>
