<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<div id="topDesc" class="topDesc">
	<ul>
		<li>해당 프로그램은 사용자 메뉴에 대한 콘텐츠를 관리하는 곳입니다.</li>
		<li>새로운 메뉴에 대한 항목은 메뉴에서 먼저 생성 후 사용이 가능합니다.</li>
	</ul>
</div>

<form name="listForm" id="listForm" action="/bos/singl/contents/list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="sSiteId" value="${param.sSiteId}"/>

	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<label for="stributary" class="blind">검색조건</label>
				<select name="searchKey" id="searchKey"  class="select">
					<option value="path" ${paramVO.searchKey eq 'path' ? 'selected="selected"' : ''}>메뉴명</option>
					<option value="menuNo" ${paramVO.searchKey eq 'menuNo' ? 'selected="selected"' : ''}>메뉴번호</option>
					<option value="userNm" ${paramVO.searchKey eq 'userNm' ? 'selected="selected"' : ''}>담당자명</option>
				</select>
			<input type="text" title="검색어" name="searchStr" value="${paramVO.searchStr}" />
			<button class="b-sh">검색</button>
			<a href="/bos/singl/contents/list.do?menuNo=${param.menuNo}&sSiteId=${param.sSiteId}" class="b-reset">초기화</a>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

	<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>웹콘텐츠관리 목록</caption>
			<thead>
				<tr>
					<th scope="col" style="width:8%">NO</th>
					<th scope="col" style="width:10%">메뉴번호</th>
					<th scope="col">메뉴명</th>
					<th scope="col" style="width:10%">담당자 부서</th>
					<th scope="col" style="width:10%">담당자 명</th>
					<th scope="col" style="width:10%">최종수정일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
					<td>${result.menuNo}</td>
					<td class="output tal"><a href="/bos/singl/contents/forUpdate.do?sMenuNo=${result.menuNo}&sSiteId=${param.sSiteId}&menuNo=${param.menuNo}">${empty result.relateMenuNmList ? result.menuNm : fn:replace(result.relateMenuNmList,'|',' > ')}</a></td>
					<td>${result.deptKorNm}</td>
					<td>${result.userNm}</td>
					<td>${result.updtDt}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->
</form>

<c:if test="${fn:length(resultList) > 0}">
		${pageNav}
</c:if>

<div class="btnSet c">
	<%-- // 개발 초기에 한번 사용하고 주석처리하여 관리 권장함. --%>
	<%--
	<a class="b-reg btn-lg" href="/bos/singl/contents/insert.do?sSiteId=${param.sSiteId}&menuNo=${param.menuNo}" onclick="return confirm('파일의 내용이 DB에 일괄적으로 새로운 버전으로 insert 됩니다. 정말로 등록하시겠습니까?');"><span>파일의 콘텐츠 내용 DB 일괄 등록처리</span></a>
	--%>
</div>