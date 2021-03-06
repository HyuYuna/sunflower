<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<% pageContext.setAttribute("crlf", "\n"); %>

<script type="text/javascript">
$(function() {
	$("#chkAll").click(function(){
		if (this.checked) {
			$(":checkbox").prop("checked", true);
		}
		else {
			$(":checkbox").prop("checked", false);
		}
	});
});

function updateRole(){
	if($(":checkbox[name^=role_]:checked").length == 0) {
		alert("적용할 권한을 선택하세요.");
		return;
	}
	if(!confirm("정말로 변경하시겠습니까?")) {
		return;
	}
	var inData = $("#frm").serialize();
	$.post(
		"/bos/bbs/authMaster/updateRole.json",
		inData,
		function(data){
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	);
}
</script>

<ul class="nav nav-tabs">
	<li role="presentation"><a href="/bos/bbs/master/forUpdate.do?bbsId=${paramVO.bbsId}&menuNo=${paramVO.menuNo}">기능및 표시 설정</a></li>
	<li role="presentation" class="active"><a href="/bos/bbs/authMaster/forUpdateRole.do?bbsId=${paramVO.bbsId}&menuNo=${paramVO.menuNo}">권한설정</a></li>
</ul>

<form id="frm" name="frm" method="post">
	<input type="hidden" name="bbsId" value="${paramVO.bbsId}" />
	<div>
		<table class="table table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col style="width:8%" />
				<col style="*" />
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<%-- <col style="width:8%" /> --%>
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<%-- <col style="width:8%" />
				<col style="width:8%" /> --%>
				<col />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">권한</th>
					<th scope="col">글목록</th>
					<th scope="col">상세보기</th>
					<th scope="col">글쓰기</th>
					<!-- <th scope="col">공지글작성</th> -->
					<th scope="col">글수정</th>
					<th scope="col">글삭제</th>
					<th scope="col">답글</th>
					<!-- <th scope="col">파일업로드</th>
					<th scope="col">파일다운로드</th> -->
				</tr>
			</thead>
			<tbody>
		 <c:forEach var="result" items="${resultList}" varStatus="status">
	 		<c:set var="checked" value="" />
		 	<c:set var="roles" value="${roleMap[result.authorCd]}" />
				<c:if test="${fn:length(roles) > 0}">
		 			<c:set var="checked" value="checked='checked'" />
		 		</c:if>
		 		<c:set var="lchecked" value="" />
		 		<c:set var="rchecked" value="" />
		 		<c:set var="wchecked" value="" />
		 		<c:set var="gchecked" value="" />
		 		<c:set var="uchecked" value="" />
		 		<c:set var="dchecked" value="" />
		 		<c:set var="achecked" value="" />
		 		<c:set var="xchecked" value="" />
		 		<c:set var="zchecked" value="" />
			 	<c:forEach var="r" items="${roles}" varStatus="s">
					<c:if test="${r.pm eq 'L'}">
			 			<c:set var="lchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'R'}">
			 			<c:set var="rchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'W'}">
			 			<c:set var="wchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'G'}">
			 			<c:set var="gchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'U'}">
			 			<c:set var="uchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'D'}">
			 			<c:set var="dchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'A'}">
			 			<c:set var="achecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'X'}">
			 			<c:set var="xchecked" value="checked='checked'" />
			 		</c:if>
					<c:if test="${r.pm eq 'Z'}">
			 			<c:set var="zchecked" value="checked='checked'" />
			 		</c:if>
		 		</c:forEach>
		 	  <c:if test="${result.authorCd ne 'ROLE_SUPER' }">
			  <tr>
			    <td><input type="checkbox" name="role_${result.authorCd}" value="${result.authorCd}" ${checked}/></td>
				<td class="tit">${result.authorNm}</td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_L" value="L" ${lchecked} /></td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_R" value="R" ${rchecked} /></td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_W" value="W" ${wchecked} /></td>
			   <%--  <td><input type="checkbox" name="pm_${result.authorCd}_G" value="G" ${gchecked} /></td> --%>
			    <td><input type="checkbox" name="pm_${result.authorCd}_U" value="U" ${uchecked} /></td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_D" value="D" ${dchecked} /></td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_A" value="A" ${achecked} /></td>
			    <%-- <td><input type="checkbox" name="pm_${result.authorCd}_X" value="X" ${xchecked} /></td>
			    <td><input type="checkbox" name="pm_${result.authorCd}_Z" value="Z" ${zchecked} /></td> --%>
			  </tr>
			  </c:if>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}">
			  <tr>
			    <td colspan="11"><spring:message code="common.nodata.msg" /></td>
			  </tr>
			 </c:if>
	 		</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-reg" href="javascript:void(0);" onclick="updateRole();"><span>확인</span></a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>
</form>