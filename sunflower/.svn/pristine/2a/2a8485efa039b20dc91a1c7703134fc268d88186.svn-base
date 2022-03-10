<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
function goSearch(frm) {
	if(frm.sdate.value > frm.edate.value) {
		alert("기간을 올바르게 선택해주세요.");
		frm.sdate.value = "";
		frm.edate.value = "";
		$('#sdate').focus();
		return false;
	}
}

</script>

<ul class="nav nav-tabs">
	<li role="presentation" class="active"><a href="/bos/singl/errorLog/list.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">에러로그</a></li>
	<li role="presentation"><a href="/bos/singl/errorLog/listDate.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">기간별 통계</a></li>
	<li role="presentation"><a href="/bos/singl/errorLog/listType.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">유형별 통계</a></li>
	<li role="presentation"><a href="/bos/singl/errorLog/listUrlAd.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">URL별 통계</a></li>
</ul>

<form name="frm" id="frm" method="get" action="/bos/singl/errorLog/list.do?" onsubmit="return goSearch(this);">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<span class="shDate">
			<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${param.sdate}" type="text" readonly="readonly">
			 ~
			<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${param.edate}" type="text" readonly="readonly">
			</span>
			<label for="searchCnd">구분</label> <select id="searchCnd" name="searchCnd" class="select">
				<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
				<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>경로</option>
				<option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if>>사용자ID</option>
				<option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if>>사용자IP</option>
			</select>
			<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}' />
			<button type="submit" class="b-sh">검색</button>
			<a href="/bos/singl/errorLog/list.do?menuNo=${param.menuNo}&viewType=${paramVO.viewType}" class="b-reset">초기화</a>
		</fieldset>
	</div>
</form>
<div class="totalCount"><em>총 <em>${resultCnt}</em>건</em> | <em>${paramVO.pageIndex}/${paginationInfo.totalPageCount}</em> Page</div>
<div class="bdList">
	<table class="table table-striped table-hover">
		<caption>게시물 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*%" />
				<col width="20%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
			</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">에러경로</th>
				<th scope="col">사용자ID</th>
				<th scope="col">사용자IP</th>
				<th scope="col">에러일자</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="pQueryStr">
				<util:replaceAll string="${pageQueryString}" pattern="&?logNo=[0-9]*" replacement="" />
			</c:set>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
					<td class="tit"><a href="/bos/singl/errorLog/view.do?logNo=${result.logNo}&${pQueryStr}">${result.errorSj}</a></td>
					<td>${result.errorUrlad}</td>
					<td>${result.userId}</td>
					<td>${result.userIpad}</td>
					<td><fmt:formatDate value="${result.errorDt}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="6" class="nodata"><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>