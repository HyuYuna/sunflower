<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<form name="frm" method="post" action="/bos/qestnar/qustnr/userList.do">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<fieldset class="sh">
		<legend>목록 검색</legend>
		<div>
			<legend>게시물검색</legend>
			<label for="status">상태</label>
	   		<select id="status" name="status" class="select">
		   		<option value="">전체</option>
		   		<option value="W" <c:if test="${paramVO.status eq 'W'}">selected="selected"</c:if> >대기</option>
		   		<option value="P" <c:if test="${paramVO.status eq 'P'}">selected="selected"</c:if> >진행중</option>
		   		<option value="F" <c:if test="${paramVO.status eq 'F'}">selected="selected"</c:if> >종료</option>
		    </select>
			<label for="searchCnd">구분</label>
	   		<select id="searchCnd" name="searchCnd" class="select">
		   		<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >설문주제</option>
		    </select>
			<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}' />
			<button type="submit" class="b-sh">검색</button>
			<a href="./userList.do?menuNo=${param.menuNo}" class="b-total">전체보기</a>
		</div>
	</fieldset>
</form>

<div class="bdList">
	<table>
		<caption> 설문 목록 </caption>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">설문주제</th>
				<th scope="col">조사기간</th>
				<th scope="col">설문대상</th>
				<th scope="col">참여인원</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="pQueryStr">
			<util:replaceAll string="${pageQueryString}" pattern="&?qustnr=[0-9]*" replacement="" />
		</c:set>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
			    <td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
			    <td class="tit">
			    	<a href="/bos/qestnar/qustnr/userView.do?qustnrSn=${result.qustnrSn}&${pQueryStr}">${result.qustnrSj}</a>
			    </td>
				<td>
					<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~ <br/>
					<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<c:if test="${result.qustnrTrgetCd eq 'A'}">아무나</c:if>
					<c:if test="${result.qustnrTrgetCd eq 'M'}">회원</c:if>
				</td>
				<td>${result.appCnt}</td>
				<td>
				<c:choose>
					<c:when test="${result.status eq 'P'}">진행중</c:when>
					<c:when test="${result.status eq 'F'}">종료</c:when>
					<c:otherwise>대기</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}">
			<tr>
				<td colspan="7">표시할 행이 없습니다.</td>
			</tr>
		 </c:if>
		</tbody>
	</table>
</div>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>
