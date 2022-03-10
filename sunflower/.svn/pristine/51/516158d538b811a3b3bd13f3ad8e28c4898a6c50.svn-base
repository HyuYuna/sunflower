<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
$(function(){
	$("#pageUnit").on('change',function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});
});

function fn_goSearch(frm){

	if(frm.sdate.value > frm.edate.value){
		alert("기간을 올바르게 선택해주세요.");
		frm.sdate.value = "";
		frm.edate.value = "";
		return false;
	}
}

function fn_forView(wordSeCd, mnno){
	var url = "forUpdate.do?${pageQueryString}&mnno="+mnno;
	if (wordSeCd=='3'){
		alert("항목사전은 뷰화면은 제공하지 않습니다.");
	} else {
		location.href=url;
	}
}
</script>

<form id="frm" name="frm" action ="list.do" method="get" onsubmit="return fn_goSearch(this);">
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<label class="nobu"><input type="radio" name="wordSeCd" value="" id="wordSeCd_0" ${(empty param.wordSeCd ) ? 'checked="checked"' : ''} />전체</label>
			<label class="nobu"><input type="radio" name="wordSeCd" value="3" id="wordSeCd_3" ${(param.wordSeCd eq '3') ? 'checked="checked"' : ''} />항목사전</label>
			<label class="nobu"><input type="radio" name="wordSeCd" value="2" id="wordSeCd_2" ${(param.wordSeCd eq '2') ? 'checked="checked"' : ''} />도메인사전</label>
			<label class="nobu"><input type="radio" name="wordSeCd" value="1" id="wordSeCd_1" ${(param.wordSeCd eq '1') ? 'checked="checked"' : ''} />용어사전</label>
			<label class="nobu">
				<select id="searchCnd" name="searchCnd">
					<option value="">전체</option>
					<option value="1">용어명</option>
					<option value="2">용어영문명</option>
					<option value="3">용어약어명</option>
				</select>
			</label>
			<input type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" />
			<input type="hidden" name="pageUnit" id="pageUnit" value="${empty paramVO.pageUnit ? 30 : paramVO.pageUnit}" />
			<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo}" />
			<button class="b-sh">검색</button>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

	<!-- board list start -->
	<div class="totalCount"><em>총 <em>${resultCnt}</em>건</em> | <em>${paramVO.pageIndex}/${paginationInfo.totalPageCount}</em> Page</div>

	<div>
		<table class="table table-striped table-hover" cellpadding="0" cellspacing="0" summary="번호, 구분, 용어명, 도메인, 약어명, 정의, 등록일">
			<caption>용어사전의 번호, 구분, 용어명, 도메인, 약어명, 정의, 등록일 리스트</caption>
			<colgroup>
				<col width="5%" />
				<col width="7%" />
				<col width="10%" />
				<col width="10%" />
				<col width="12%" />
				<col width="8%" />
				<col width="8%" />
				<col width="*" />
				<col width="7%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">구분</th>
					<th scope="col">도메인</th>
					<th scope="col">용어명</th>
					<th scope="col">용어영문명</th>
					<th scope="col">용어약어명</th>
					<th scope="col">데이터타입</th>
					<th scope="col">정의</th>
					<th scope="col" class="last">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:set var="pageUnit" value="${empty paramVO.pageUnit ? 10 : paramVO.pageUnit}"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr >
					<td>
						${resultCnt - (pageUnit * (paramVO.pageIndex-1))}
					</td>
					<!-- 제목 -->
					<td>
						${result.wordSe}
					</td>
					<td class="tal">${result.wordDomn}</td>
			    	<td class="tal">
						<a href="javascript:fn_forView('${result.wordSeCd}','${result.mnno}')">${result.wordNm}</a>
					</td>
			    	<td class="tal">
			    		<a href="javascript:fn_forView('${result.wordSeCd}','${result.mnno}')">${result.wordEngNm}</a>
			    	</td>
			    	<td class="tal">
			    		<a href="javascript:fn_forView('${result.wordSeCd}','${result.mnno}')">${result.wordEngAbrvNm}</a>
			    	</td>
			    	<td class="tal">${fn:replace(result.dataTy,',','<br/>')}</td>
			    	<td class="tal">
			    		${result.wordDfn}
			    	</td>
					<td>
						<fmt:parseDate value="${result.creatDe}" var="regDate" pattern="yyyy-mm-dd"/>
						<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->

	<div class="btnSet">
		<a href="forInsert.do?${pageQueryString}" class="b-reg">등록</a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
	</c:if>
</form>
