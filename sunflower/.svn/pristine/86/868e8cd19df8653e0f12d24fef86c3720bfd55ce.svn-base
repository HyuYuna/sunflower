<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
	function goSearch(frm2) {
		if(frm2.sdate.value > frm2.edate.value) {
			alert("기간을 올바르게 선택해주세요.");
			frm2.sdate.value = "";
			frm2.edate.value = "";
			return false;
		}
	}

	function setValue(deptId, deptKorNm, userId, userNm, userCpno, userEmad){
		$("#deptId",opener.document).val(deptId);
		$("#deptKorNm",opener.document).val(deptKorNm);
		$("#userId",opener.document).val(userId);
		$("#userNm",opener.document).val(userNm);
		$("#userCpno",opener.document).val(userCpno);
		$("#userEmad",opener.document).val(userEmad);
		window.opener.document.getElementById(window.name).value = userId;
		self.close();
	}
</script>
<h1>담당자지정</h1>
<form id="frm2" name="frm2" method="get" action="/bos/cmmn/cmmnMngr/listPop.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="viewType" value="BODY">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<input type="text" id="sdate" class="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
		    <input type="text" id="edate" class="edate" name="edate" value="${param.edate}" size="10" />

			<label for="stributary" class="blind">검색조건</label>
			<select id="stributary" name="searchCnd" title="검색조건">
			   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
			   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >관리자명</option>
			   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >부서명</option>
			</select>
			<input type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" />
			<button class="b-sh">검색</button>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

	<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>관리자 관리 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="12%" />
				<col width="*" />
				<col width="18%" />
				<col width="20%" />
				<col width="12%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">관리자명</th>
					<th scope="col">부서명</th>
					<th scope="col">권한명</th>
					<th scope="col">등록일</th>
					<!-- <th scope="col">상태</th> -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="tit">
						<a href="javascript:void(0)" onclick="setValue('${result.deptId}','${result.deptKorNm}','${result.userId}','${result.userNm}','${result.userCpno}','${result.userEmad}');">${result.userId}</a>
					</td>
					<td>
						<a href="javascript:void(0)" onclick="setValue('${result.deptId}','${result.deptKorNm}','${result.userId}','${result.userNm}','${result.userCpno}','${result.userEmad}');">${result.userNm}</a>
					</td>
					<td>${result.deptKorNm}</td>
					<td>${result.authorNm}</td>
					<td>${result.registDt}</td>
					<%-- <td>
						<c:forEach var="code" items="${sttusCdCodeList}" varStatus="status">
			  	 			<c:if test="${result.sttusCd eq code.cd}">${code.cdNm}</c:if>
				 		</c:forEach>
					</td> --%>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="6">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->
	<div class="btnSet">
		<a class="b-end" href="javascript:void()" onclick="self.close()"><span>닫기</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
		${pageNav}
	</c:if>
</form>

