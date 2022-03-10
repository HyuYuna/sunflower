<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

	<form name="frm" method="post" action="/bos/qestnar/qustnr/list.do" class="pure-form">
		<input type="hidden" name="menuNo" value="${param.menuNo}">

		<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
			<label for="status">상태</label>
	   		<select id="status" name="status" class="select">
		   		<option value="">전체</option>
		   		<option value="P" <c:if test="${paramVO.status eq 'P'}">selected="selected"</c:if> >진행중</option>
		   		<option value="F" <c:if test="${paramVO.status eq 'F'}">selected="selected"</c:if> >종료</option>
		    </select>
			<label for="searchCnd">구분</label>
	   		<select id="searchCnd" name="searchCnd" class="select">
		   		<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >설문주제</option>
		    </select>
			<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}' />
			<button type="submit" class="pure-button btnSave">검색</button>
			</fieldset>
		</div>
	</form>
<!-- 게시판 게시물검색 end -->

<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col style="width:8%" />
				<col style="width:30%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">설문주제</th>
					<th scope="col">조사기간</th>
					<th scope="col">참여인원</th>
					<th scope="col">문제수<br/>(문제추가)</th>
					<th scope="col">설문결과<br/>(통계)</th>
					<th scope="col">등록일</th>
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
			    	<a href="/bos/qestnar/qustnr/view.do?qustnrSn=${result.qustnrSn}&${pQueryStr}">${result.qustnrSj}</a>
			    </td>
				<td>
					<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~ <br/>
					<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>${result.appCnt}</td>
				<td><a href="/bos/qestnar/qesitm/forUpdate.do?qustnrSn=${result.qustnrSn}&${pQueryStr}" class="b-add">${result.qesitmCnt}문제</a></td>
				<td><a href="/bos/qestnar/answer/view.do?qustnrSn=${result.qustnrSn}&${pQueryStr}" class="b-view">결과보기</a></td>
				<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></td>
			  </tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}">
			  <tr>
			    <td colspan="8" class="nodata"><spring:message code="common.nodata.msg" /></td>
			  </tr>
			 </c:if>
	 		</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="pure-button btnSave" href="/bos/qestnar/qustnr/forInsert.do?${pageQueryString}"><span>등록</span></a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>