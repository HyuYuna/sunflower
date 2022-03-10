<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

	document.listForm.authorCds.value = returnValue;

	return returnBoolean;
}

function fncSelectAuthorList(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "/bos/auth/auth/list.do?menuNo=${param.menuNo}";
	document.listForm.submit();
}

/* function fncSelectAuthor(author) {
	document.listForm.authorCd.value = author;
	document.listForm.action = "/bos/auth/auth/" + author + ".do?menuNo=${param.menuNo}";
	document.listForm.submit();
} */

function fncAddAuthorInsert() {
	location.replace("/bos/auth/auth/forInsert.do?menuNo=${param.menuNo}");
}

function fncAuthorDeleteList() {

	if(fncManageChecked()) {
		if(confirm("삭제하시겠습니까?")) {
			document.listForm.action = "/bos/auth/auth/delete.do?menuNo=${param.menuNo}";
			document.listForm.submit();
		}
	}
}

function fncAddAuthorView(author) {
	document.listForm.authorCd.value = author;
	document.listForm.action = "/bos/auth/auth/forUpdate.do?menuNo=${param.menuNo}";
	document.listForm.submit();
}

function fncSelectAuthorRole(author) {
	document.listForm.searchKwd.value = author;
	document.listForm.action = "/bos/auth/auth/AuthorRoleList.do?menuNo=${param.menuNo}";
	document.listForm.submit();
}

function press() {

	if (event.keyCode==13) {
		fncSelectAuthorList('1');
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
	<form name="listForm" id="listForm" action="/bos/auth/auth/list.do" method="post" class="pure-form">
		<input type="hidden" name="menuNo" value="${param.menuNo}" />
		<input type="hidden" name="authorCd" />
		<input type="hidden" name="authorCds"/>
		<input type="hidden" name="pageIndex" value="${paramVO.pageIndex}"/>
		<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
			<%-- 	<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
				<input type="text" id="edate" name="edate" value="${param.edate}" size="10" /> --%>

				<select id="searchCnd" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >권한ID</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >권한명</option>
				</select>
				<input type="text" title="검색어" name="searchKwd" value="${paramVO.searchKwd}" onkeypress="press();" />
				<a href="javascript:fncSelectAuthorList('1');" class="pure-button btnSave">검색</a>
				<a href="/bos/auth/auth/list.do?menuNo=${param.menuNo}" class="pure-button b-reset">초기화</a>
			</fieldset>
		</div>

	<div>
		<table class="table table-striped table-hover">
			<caption>홈페이지 관리자 권한관리 목록</caption>
			<thead>
				<tr>
					<!--
					<th style="width:8%" scope="col"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체 선택"></th>
					 -->
					<th style="width:20%" scope="col">권한 ID</th>
					<th scope="col">권한명</th>
					<th style="width:20%" scope="col">등록일</th>
					<th style="width:15%" scope="col">메뉴권한 설정 여부</th>
					<th style="width:20%" scope="col" class="last">메뉴권한설정</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="result" items="${resultList}" varStatus="status">
			  <tr>
			  	<!--
				<td><input type="checkbox" name="delYn" class="check2" title="${result.authorCd} 선택"><input type="hidden" name="checkId" value="${result.authorCd}" /></td>
				 -->
				<td class="tit"><a href="javascript:fncAddAuthorView('${result.authorCd}')">${result.authorCd}</a></td>
				<td><a href="javascript:fncAddAuthorView('${result.authorCd}')">${result.authorNm}</a></td>
				<!-- <td>${result.authorDc}</td> -->
				<td>${result.registDt}</td>
				<td>${result.authorCd eq 'ROLE_SUPER' ? 'Y' : (result.chkYeoBu > 0 ? 'Y' : 'N')}</td>
				<td>
					<a href="/bos/auth/auth/forUpdateMenuAuth.do?authorCd=${result.authorCd}&${pageQueryString}" class="b-edit">메뉴권한설정</a>
					<%-- <sec:authorize access="hasRole('ROLE_SUPER')">
					<c:if test="${result.authorCd eq 'ROLE_SUPER'}"><a href="javascript:alert('${result.authorNm}는 최고 권한으로 전체메뉴에 대해 권한이 자동 설정됨으로 수정이 불가합니다.');" class="b-edit">메뉴권한설정</a></c:if>
					<c:if test="${result.authorCd ne 'ROLE_SUPER'}"><a href="/bos/auth/auth/forUpdateMenuAuth.do?authorCd=${result.authorCd}&${pageQueryString}" class="b-edit">메뉴권한설정</a></c:if>
					</sec:authorize>
					<sec:authorize access="!hasRole('ROLE_SUPER')">
					사용불가(SUPER 권한필요)
					</sec:authorize> --%>
				</td>
			  </tr>
			 </c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<div class="btnSet">
		<!--
		<div class="fl"><a class="b-del" href="javascript:fncAuthorDeleteList();"><span>삭제</span></a></div>
		 -->
		<a class="pure-button btnUpdate" href="javascript:fncAddAuthorInsert();">등록</a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
	</c:if>
	</form>