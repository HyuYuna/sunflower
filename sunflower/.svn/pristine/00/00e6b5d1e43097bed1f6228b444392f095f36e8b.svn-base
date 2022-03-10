<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
	function search(pageNo) {
		if(frm.sdate.value > frm.edate.value) {
			alert("기간을 올바르게 선택해주세요.");
			frm.sdate.value = "";
			frm.edate.value = "";
			return false;
		}

		document.frm.pageIndex.value = pageNo;
		document.frm.submit();
	}
</script>
<form name="frm" method="get" action="/bos/bbs/${paramVO.bbsId}/list.do">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="bbsId"> <input name="pageIndex" type="hidden" value="${paramVO.pageIndex}" />
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<span class="shDate">
				<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${param.sdate}" type="text" readonly="readonly"> ~
				<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${param.edate}" type="text" readonly="readonly">
			</span>
			<label for="searchCnd">구분</label>
			<select id="searchCnd" name="searchCnd" class="select">
				<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
				<option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if>>작성자</option>
				<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
				<option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if>>제목+내용</option>
			</select>
			<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}' />
			<button type="button" onclick="search('1')" class="b-sh">검색</button>
			<a href="/bos/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</fieldset>
	</div>
</form>
<!-- 게시판 게시물검색 end -->

<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>게시물 목록</caption>
		<colgroup>
			<col width="8%" />
			<col width="*" />
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">게시물제목</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일시</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>

			<c:set var="pQueryStr">
				<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
			</c:set>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
					<td class="tit"><a href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pQueryStr}">${result.nttSj}</a></td>
					<td>${result.ntcrNm}</td>
					<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm" /></td>
					<td>${result.inqireCo}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="5" class="nodata"><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet">
	<a class="b-reg" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

