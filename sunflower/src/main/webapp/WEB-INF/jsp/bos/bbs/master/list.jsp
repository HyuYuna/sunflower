<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
	function press(event) {
		if (event.keyCode==13) {
			list('1');
		}
	}

	function save(){
		document.frm.action = "/bos/bbs/master/forInsert.do";
		document.frm.submit();
	}

	function list(pageNo){
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "/bos/bbs/master/list.do";
		document.frm.submit();
	}

	function modify(bbsId){
		document.frm.bbsId.value = bbsId;
		document.frm.action = "/bos/bbs/master/forUpdate.do";
		document.frm.submit();
	}
</script>
<form name="frm" id="frm" method="get" action="/bos/bbs/master/list.do">
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="bbsId" value="${result.bbsId}" />
	<input type="hidden" name="pageIndex" value="${param.pageIndex}" />
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<select name="bbsAttrbCd" id="bbsAttrbCd" class="select" title="게시판유형">
				<option value=''>유형선택</option>
				<option value="PG0001" <c:if test="${'PG0001' eq param.bbsAttrbCd}">selected</c:if> >공지형게시판</option>
				<option value="PG0007" <c:if test="${'PG0007' eq param.bbsAttrbCd}">selected</c:if> >일반형게시판</option>
				<option value="PG0002" <c:if test="${'PG0002' eq param.bbsAttrbCd}">selected</c:if> >포토형게시판</option>
				<option value="PG0003" <c:if test="${'PG0003' eq param.bbsAttrbCd}">selected</c:if> >답변형게시판</option>
				<option value="PG0004" <c:if test="${'PG0004' eq param.bbsAttrbCd}">selected</c:if> >FAQ형게시판</option>
			</select>
			<span class="title">게시판명</span>
			<!--
			<select id="searchCnd" name="searchCnd" class="select">
				<option value="0" <c:if test="${paramVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
				<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>
			</select>
			 -->
			<input type="hidden" name="searchCnd" value="0" />
			<input type="text" name="searchWrd" value='${paramVO.searchWrd}' onkeypress="press(event);" />
			<a href="javascript:void(0);" onclick="list('1')" class="b-sh">검색</a>
			<a href="/bos/bbs/master/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</fieldset>
	</div>
</form>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>통합게시판관리 목록</caption>
			<thead>
				<tr>
					<th scope="col" style="width:8%">번호</th>
					<th scope="col" >게시판명</th>
					<!-- <th scope="col" style="width:12%">게시판유형</th>  -->
					<th scope="col" style="width:20%">게시판유형</th>
					<th scope="col" style="width:10%" class="last">생성일</th>
					<!--
					<th scope="col" style="width:8%" >사용여부</th>
					-->
				</tr>
			</thead>
			<tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
				<td>
				${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}
				</td>
				<td class="tit">
					<a href="javascript:void(0)" onclick="modify('${result.bbsId}')">
						${result.bbsNm}<!-- (${result.bbsId})  -->
					</a>
				</td>
				<!-- <td>${result.bbsTyNm}</td>  -->
				<td>${result.bbsAttrbNm}(${result.bbsAttrbCd})</td>
				<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></td>
				<!--
				<td>
					<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
					<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
				</td>
				 -->
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}">
				<tr>
				<td colspan="4" class="nodata"><spring:message code="common.nodata.msg" /></td>
				</tr>
			 </c:if>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-reg" href="javascript:void(0);" onclick="save();">등록</a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>