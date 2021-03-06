<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<script>
//<![CDATA[
	function search(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.submit();
	}
//]]>
</script>
<form id="frm" name="frm" method="get" action="/bos/sys/globalsManage/list.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<select id="stributary" name="searchCnd" title="검색조건">
			   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>속성명</option>
			   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>속성값</option>
			   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if>>속성설명</option>
			</select>
			<input type="text" title="권한 명" name="searchWrd" value="${paramVO.searchWrd}" />
			<button class="b-sh">검색</button>
		</fieldset>
	</div>

	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="20%" />
				<col width="20%" />
				<col width="" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">속성명</th>
					<th scope="col">속성값</th>
					<th scope="col">속성설명</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
		 	<c:forEach var="result" items="${resultList}" varStatus="status">
			  <tr>
			    <td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
			    <td class="tit">
			    	<a href="/bos/sys/globalsManage/forUpdate.do?attrbSn=${result.attrbSn }&${pageQueryString}" >
			    		${result.attrbNm}
			    	</a>
			    </td>
			    <td class="left">${result.attrbValue}</td>
			    <td class="left">${result.attrbDc}</td>
			    <td>${result.useAt eq 'N' ? '미사용' : '사용'}</td>
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
</form>

<div class="btnSet">
	<a class="b-reg" href="/bos/sys/globalsManage/forInsert.do?${pageQueryString}" ><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>