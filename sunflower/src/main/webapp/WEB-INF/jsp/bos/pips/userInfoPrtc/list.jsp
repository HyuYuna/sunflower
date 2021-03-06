<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>


function clickExcel() {
	$('#myModal').modal();
}

function excelDown() {
	var readngPurpsRm = $("#readngPurpsRm").val();
	var userId = "${userVO.userId}";

	if(!readngPurpsRm){
		alert("열람목적을 입력해주세요.");
		$("#readngPurpsRm").focus();
		return;
	}

	$.post(
			"/bos/member/user/setCallUserId.json",
			{userId : userId},
			function(data) {
				var resultCode = data.resultCode;
				if (resultCode == "success") {
					$('input[name=viewType]').val("CONTBODY");
					$('#frm').attr("action","./downloadExcel.uxls");
					$('#frm').submit();

					$('input[name=viewType]').val("");
					$('#frm').attr("action","./list.do?menuNo=${param.menuNo}");
					$('#clickClose').on('click',);
					$('#readngPurpsRm').val("");
				}
				else {
					alert("잠시후 다시 시도하세요.");
				}
			},"json"
		)
}
</script>

<form name="frm" id="frm" action="list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">
	<input type="hidden" name="userId" value="${userVO.userId}">
	<input type="hidden" name="viewType">
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
			<span class="shDate" ${calDate}>
			<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text" readonly="readonly">
			~
			<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
			</span>
			<span class="select">
				<select name="searchCnd" id="searchCnd" title="검색어 구분">
					<option value="1" <c:if test="${empty paramVO.searchCnd or paramVO.searchCnd == '1'}">selected="selected"</c:if>>아이디</option>
					<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>이름</option>
				</select>
			</span>
			<input type="text" title="검색어" name="searchKwd" value='${paramVO.searchKwd}' />
			<button class="b-sh">검색</button>
			<a href="list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
			<button type="button" onclick="clickExcel()" class="b-down">개인정보 열람이력 엑셀다운</button>
	</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">개인정보 열람 이력 엑셀다운로드</h4>
				</div>
				<div class="modal-body">
					<div class="bdView">
						<table>
							<tr>
								<th scope="row">열람목적</th>
								<td><input type="text" class="w100p" id="readngPurpsRm" name="readngPurpsRm"></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" onclick="excelDown();" class="b-save">저장</button>
					<button type="button" id="clickClose" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</form>
<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>팝업관리 목록</caption>
		<thead>
			<tr>
				<th style="width:4%"		scope="col">번호</th>
				<th style="width:11%"		scope="col">화면명</th>
				<th style="width:9%"		scope="col">성명</th>
				<th							scope="col">URL</th>
				<th	style="width:8%"		scope="col">열람형태</th>
				<th	style="width:18%"		scope="col">열람목적구분</th>
				<th style="width:9%"		scope="col">열람자</th>
				<th style="width:12%"		scope="col">열람일시</th>
				<th style="width:8%"		scope="col">열람IP</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
			<tr>
				<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
				<td class="tal">${result.pageNm}</td>
				<td>${result.readngUserNm}<br>${result.readngUserId}</td>
				<td class="tal">${result.readngUrlad}</td>
				<td>
					<c:choose>
					<c:when test="${result.readngSe eq 'R'}">열람</c:when>
					<c:when test="${result.readngSe eq 'P'}">출력</c:when>
					<c:when test="${result.readngSe eq 'D'}">다운로드</c:when>
					<c:otherwise></c:otherwise>
					</c:choose>
				</td>
				<td>
					${result.readngPurpsSe}
					<c:if test="${not empty result.readngPurpsRm}">${result.readngPurpsRm}</c:if>
				</td>
				<td>${result.userNm}<br>${result.userId}</td>
				<td>${fn:substring(result.readngDt,0,19)}</td>
				<td>${result.readngIpad}</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>
<!-- board list end //-->


<div class="btnSet">
	&nbsp;<%-- <a class="b-reg" href="forInsert.do?menuNo=${param.menuNo}&${pageQueryString}"><span>등록</span></a> --%>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>