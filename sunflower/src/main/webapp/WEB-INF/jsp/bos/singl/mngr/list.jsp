<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
	$(function() {
		$("#chkAll").on('click',function(){
			if (this.checked) {
				$(":checkbox").prop("checked", true);
			}
			else {
				$(":checkbox").prop("checked", false);
			}
		});
	});

	function del(){
		if($(":checkbox:checked").length == 0) {
			alert("삭제할 관리자를 선택하세요.");
			return;
		}
		if(!confirm("정말로 삭제하시겠습니까?")) {
			return;
		}
		var inData = $("#frm2").serialize();
		$.post(
			"/bos/singl/mngr/delete.json",
			inData,
			function(data){
				var resultCode = data.resultCode;
				var resultMsg = data.msg;
				alert(resultMsg);
				if(resultCode == "success") location.reload();
			}
		);
	}

	function goSearch(frm2) {
		if(frm2.sdate.value > frm2.edate.value) {
			alert("기간을 올바르게 선택해주세요.");
			frm2.sdate.value = "";
			frm2.edate.value = "";
			return false;
		}
	}
</script>

<form id="frm2" name="frm2" method="get" action="/bos/singl/mngr/list.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="menuNo" value="${param.menuNo}">

	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<input type="text" id="sdate" class="sdate" name="sdate" value="${param.sdate}" size="10" readonly="readonly"/> ~
		    <input type="text" id="edate" class="edate" name="edate" value="${param.edate}" size="10" readonly="readonly"/>

			<label for="stributary" class="blind">검색조건</label>
			<select id="stributary" name="searchCnd" title="검색조건">
			   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
			   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >이름</option>
			   <%-- <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >부서명</option> --%>
			</select>
			<input type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" />
			<button class="b-sh">검색</button>
			<a href="/bos/singl/mngr/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

	<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>홈페이지 관리자 관리도움말 목록</caption>
			<colgroup>
				<!-- <col width="6%" /> -->
				<col width="8%" />
				<col width="12%" />
				<col width="18%" />
				<col width="*" />
				<col width="18%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<!-- <th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th> -->
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">권한</th>
					<!-- <th scope="col">부서명</th> -->
					<th scope="col">등록일</th>
					<!-- <th scope="col">상태</th>  -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<!-- <td><input type="checkbox" name="userId" value="${result.userId}" /></td> -->
					<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
					<td><a href="/bos/singl/mngr/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userId}</a></td>
					<td><a href="/bos/singl/mngr/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userNm}</a></td>
					<td class="tal">${result.authorNm}</td>
					<td>${result.registDt}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="5">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->
</form>

<div class="btnSet">
	<a class="b-reg" href="/bos/singl/mngr/forInsert.do?menuNo=${param.menuNo}"><span>등록</span></a>
</div>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>