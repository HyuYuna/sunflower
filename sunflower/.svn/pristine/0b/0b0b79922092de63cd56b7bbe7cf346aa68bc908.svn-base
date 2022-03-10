<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Basic Board List</title>
<link rel="stylesheet" href="/css/egovframework/sample.css"/>
<script defer="defer">
<!--
/* 글 수정 화면 function */
function fn_egov_select(id) {
	document.listForm.selectedId.value = id;
   	document.listForm.action = "/sample/updateSampleView.do";
   	document.listForm.submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.listForm.action = "/sample/addSampleView.do";
   	document.listForm.submit();
}

/* 글 목록 화면 function */
function fn_egov_selectList() {
	document.listForm.action = "/sample/egovSampleList.do";
   	document.listForm.submit();
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "/sample/egovSampleList.do";
   	document.listForm.submit();
}

-->
</script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<form:form commandName="searchVO" name="listForm" method="post">
<input type="hidden" name="selectedId" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="/images/egovframework/rte/title_dot.gif"> List Sample </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="search">
		<ul>
		<li>
			<form:select path="searchCondition" cssClass="use">
				<form:option value="1" label="Name" />
				<form:option value="0" label="ID" />
			</form:select>
		</li>
		<li><form:input path="searchKeyword" cssClass="txt"/></li>
		<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a><img src="/images/egovframework/rte/btn_bg_r.gif" style="margin-left:6px;"></span></li></ul>
	</div>
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="40" />
				<col width="100" />
				<col width="150" />
				<col width="80" />
				<col width="" />
				<col width="60" />
			</colgroup>
			<tr>
				<th>No</th>
				<th>카테고리ID</th>
				<th>카테고리명</th>
				<th>사용여부</th>
				<th>Description</th>
				<th>등록자</th>
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td><a href="javascript:fn_egov_select('${result.id}')">${result.id}</a></td>
				<td>${result.name}&nbsp;</td>
				<td>${result.useYn}&nbsp;</td>
				<td>${result.description}&nbsp;</td>
				<td>${result.regUser}&nbsp;</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div class="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="fn_egov_link_page"
				/>
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a></span></li>
		</ul>
		</div>
	</div>
</div>
</form:form>
</body>
</html>
