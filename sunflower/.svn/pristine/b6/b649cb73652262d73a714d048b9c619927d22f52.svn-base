<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<script>

</script>

<form name="cmmnCdClForm" id="cmmnCdClForm" action="/bos/cmmnCd/cmmnCdCl/list.do" method="get">
	<input name="pageIndex" id="pageIndex" type="hidden" value="${paramVO.pageIndex}">
	<input name="menuNo" id="menuNo" type="hidden" value="${paramVO.menuNo}">
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<label for="searchCnd" class="blind">구분</label>
	   		<select name="searchCnd" class="select" id="searchCnd">
			   <option value='1' <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if>>분류코드</option>
			   <option value='2' <c:if test="${paramVO.searchCnd eq '2'}">selected="selected"</c:if>>분류코드명</option>
		    </select>
			<input id="searchKwd" type="text" title="검색어" name="searchKwd" value="${paramVO.searchKwd}" />
			<button class="b-sh">검색</button>
		</fieldset>
	</div>
</form>
<!-- 게시판 게시물검색 end -->

<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>공통분류코드 목록</caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:20%" />
			<col style="width:50%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">순번</th>
				<th scope="col">분류코드</th>
				<th scope="col">분류코드명</th>
				<th scope="col" class="last">사용여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<tr>
		    	<td>${(resultCnt) - (paginationInfo.pageSize * (paginationInfo.currentPageNo-1))}</td>
				<td><a href="/bos/cmmnCd/cmmnCdCl/view.do?clCd=${result.clCd}&amp;${pageQueryString}">${result.clCd }</a></td>
				<td class="tit"><a href="/bos/cmmnCd/cmmnCdCl/view.do?clCd=${result.clCd}&amp;${pageQueryString}">${result.clCdNm}</a></td>
				<td><c:if test="${result.useAt == 'Y'}">사용</c:if><c:if test="${result.useAt == 'N'}"><font color='red'>미사용</font></c:if></td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td colspan="4">
					<spring:message code="common.nodata.msg" />
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet">
	<a class="b-reg" href="/bos/cmmnCd/cmmnCdCl/forInsert.do?menuNo?${param.menuNo }" id="registBtn"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
${pageNav}
</c:if>

<script>
	$("#registBtn").on('click',function() {
		$("#cmmnCdClForm").attr("action","/bos/cmmnCd/cmmnCdCl/forInsert.do");
		$("#cmmnCdClForm").submit();
		return false;
	});
</script>
