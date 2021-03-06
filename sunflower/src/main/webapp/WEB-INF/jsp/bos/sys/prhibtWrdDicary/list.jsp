<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script defer="defer">
function fncCheckAll() {
	var checkField = document.listForm.delYn;
		// alert(checkField);
		if(document.listForm.checkAll.checked) {
				if(checkField) {
						if(checkField.length > 1) {
								for(var i=0; i < checkField.length; i++) {
										checkField[i].checked = true;
								}
						} else {
								checkField.checked = true;
						}
				}
		} else {
				if(checkField) {
						if(checkField.length > 1) {
								for(var j=0; j < checkField.length; j++) {
										checkField[j].checked = false;
								}
						} else {
								checkField.checked = false;
						}
				}
		}
}

function fncManageChecked() {

		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;
		var returnValue = "";

		var returnBoolean = false;
		var checkCount = 0;
		if(checkField) {
				if(checkField.length > 1) {
						for(var i=0; i<checkField.length; i++) {
								if(checkField[i].checked) {
										checkField[i].value = checkId[i].value;
										if(returnValue == "")
												returnValue = checkField[i].value;
										else
											returnValue = returnValue + ";" + checkField[i].value;
										checkCount++;
								}
						}
						if(checkCount > 0)
								returnBoolean = true;
						else {
								alert("선택된 권한이 없습니다.");
								returnBoolean = false;
						}
				} else {
						if(document.listForm.delYn.checked == false) {
								alert("선택된 권한이 없습니다.");
								returnBoolean = false;
						}
						else {
								returnValue = checkId.value;
								returnBoolean = true;
						}
				}
		} else {
				alert("조회된 결과가 없습니다.");
		}

		document.listForm.wrdSns.value = returnValue;

		return returnBoolean;
}

// 금지단어 목록
function fncSelectPrhibtList(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "/bos/sys/prhibtWrdDicary/list.do?menuNo=${param.menuNo}";
		document.listForm.submit();
}

// 금지단어 등록버튼
function fncAddPrhibtInsert() {
		location.replace("/bos/sys/prhibtWrdDicary/forInsert.do?menuNo=${param.menuNo}");
}

// 금지단어 삭제버튼
function fncPrhibtDeleteList() {
		if(fncManageChecked()) {
				if(confirm("삭제하시겠습니까?")) {
						document.listForm.action = "/bos/sys/prhibtWrdDicary/delete.do?menuNo=${param.menuNo}";
						document.listForm.submit();
				}
		}
}

// 금지단어 수정페이지 접근
function fncAddPrhibtView(prhibt) {
	document.listForm.wrdSn.value = prhibt;
	document.listForm.action = "/bos/sys/prhibtWrdDicary/forUpdate.do?menuNo=${param.menuNo}";
		document.listForm.submit();
}

function press() {

		if (event.keyCode==13) {
			fncSelectPrhibtList('1');
		}
}

$(function() {
	var strKey = '${paramVO.searchKwd}'; // 하이라이트를 적용할 스트링

	 if(strKey != ''){

		$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

	 }

	$( '.check-all' ).on('click', function() {
					$( '.input_check' ).prop( 'checked', this.checked );
		} );
});

</script>
	<form name="listForm" id="listForm" action="/bos/sys/prhibtWrdDicary/list.do" method="get">
		<input type="hidden" name="menuNo" value="${param.menuNo}">
		<input type="hidden" name="wrdSn" />
		<input type="hidden" name="wrdSns" />
		<input type="hidden" name="pageIndex" value="${paramVO.pageIndex}"/>

		<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
			<%-- 	<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
					<input type="text" id="edate" name="edate" value="${param.edate}" size="10" /> --%>
				<select id="searchWrdSe" name="searchWrdSe" title="적용범위">
					<option value=''>적용범위</option>
					<option value='A' <c:if test="${paramVO.searchWrdSe == 'A'}">selected="selected"</c:if>>공통</option>
					<option value='L' <c:if test="${paramVO.searchWrdSe == 'L'}">selected="selected"</c:if>>로그인</option>
					<option value='P' <c:if test="${paramVO.searchWrdSe == 'P'}">selected="selected"</c:if>>비밀번호</option>
				</select>
				<select id="searchUseAt" name="searchUseAt" title="사용여부">
					<option value=''>사용여부</option>
					<option value='Y' <c:if test="${paramVO.searchUseAt == 'Y'}">selected="selected"</c:if>>사용</option>
					<option value='N' <c:if test="${paramVO.searchUseAt == 'N'}">selected="selected"</c:if>>미사용</option>
				</select>
				<select id="stributary" name="searchCnd" title="검색조건" class="select">
					<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >금지단어명</option>
				</select>
				<input type="text" title="검색어" name="searchKwd" value="${paramVO.searchKwd}" onkeypress="press();"/>
				<button type="button" class="b-sh" onclick="fncSelectPrhibtList('1')">검색</button>
				<a href="/bos/sys/prhibtWrdDicary/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
			</fieldset>
		</div>

	<div>
		<table class="table table-striped table-hover">
			<caption>금지단어관리 목록</caption>
			<thead>
				<tr>
					<th scope="col" style="width:3%"	><input type="checkbox" name="checkAll" class="check2" onclick="fncCheckAll()" title="전체선택"></th>
					<th scope="col" style="width:5%"	>번호</th>
					<th scope="col" style="width:35%"	>금지단어명</th>
					<th scope="col"						>등록ID</th>
					<th scope="col" style="width:10%"	>적용범위</th>
					<th scope="col" style="width:7%"	>사용여부</th>
					<th scope="col" style="width:20%"	>등록일자</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" name="delYn" class="check2" title="${result.wrdNm}">
						<input type="hidden" name="checkId" value="${result.wrdSn}" />
					</td>
					<td>${(resultCnt) - (paramVO.recordCountPerPage * (paramVO.pageIndex-1))}</td>
					<td class="tit">
						<a href="javascript:fncAddPrhibtView('${result.wrdSn}')">${result.wrdNm}</a>
					</td>
					<td>${result.registId}</td>
					<td>
						<span><c:if test="${result.wrdSe == 'A' }">공통</c:if></span>
						<span><c:if test="${result.wrdSe == 'L' }">로그인</c:if></span>
						<span><c:if test="${result.wrdSe == 'P' }">비밀번호</c:if></span>
					</td>
					<td>
						<span class="colblue"><c:if test="${result.useAt == 'Y' }">사용</c:if></span>
						<span class="colred"><c:if test="${result.useAt == 'N' }">미사용</c:if></span>
					</td>
					<td>${result.registDt}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<div class="fl"><a class="b-del" href="javascript:void(0)" onclick="fncPrhibtDeleteList()"><span>삭제</span></a></div>
		<a class="b-reg" href="javascript:void(0)" onclick="fncAddPrhibtInsert()"><span>등록</span></a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
${pageNav}
</c:if>
</form>