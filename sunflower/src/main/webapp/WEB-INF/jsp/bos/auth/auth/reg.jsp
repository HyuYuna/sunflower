<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty result.authorCd ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty result.authorCd ? '권한 등록' : '권한 수정'}"/>

<script language="javascript">

function fncSelectAuthorList() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "/bos/auth/auth/list.do?menuNo=${param.menuNo}";
	varFrom.submit();
}

function fncAuthorInsert() {

	var varFrom = document.getElementById("authorManage");
	var authorCd = document.getElementById("authorCd");
	var authorNm = document.getElementById("authorNm");
	var authorDc = document.getElementById("authorDc");
	var chldrnAuthorCd = document.getElementById("chldrnAuthorCd");
	varFrom.action = "/bos/auth/auth/insert.do?menuNo=${param.menuNo}";

	var authorCdVal = authorCd.value;
	/* authorCdVal = authorCdVal.replace("ROLE_",""); */

	if (authorCd.value == '' || authorCd.value == null || authorCd.value == "ROLE_"){
		alert('권한ID를 입력해주세요.');
		authorCd.focus();
		/* authorCd.value = "ROLE_"; */
		return;
	}

	var chkRegType = /^[A-Z0-9+]*$/;
	if (!chkRegType.test(authorCdVal)) {
		alert("영문대문자와 숫자조합만 입력이 가능합니다.");
		authorCd.focus();
		/* authorCd.value = "ROLE_"; */
		return;
	}

	/* if (!fnCheckAuthorCd()){
		alert("권한ID는 'ROLE_'로 시작해야 합니다.");
		$("#authorCd").focus();
		authorCd.value = "ROLE_";
		return ;
	} */

	if (authorNm.value == '' || authorNm.value == null){
		alert('권한 명을 입력해주세요.');
		$("#authorNm").focus();
		return;
	}

	if (authorDc.value == '' || authorDc.value == null){
		alert('설명을 입력해주세요.');
		$("#authorDc").focus();
		return;
	}

	if (chldrnAuthorCd.value == '' || chldrnAuthorCd.value == null){
		alert('상위권한을 선택해주세요.');
		$("#chldrnAuthorCd").focus();
		return;
	}

	if(confirm("저장 하시겠습니까?")){
		varFrom.submit();
	}
}

function fncAuthorUpdate() {
	var varFrom = document.getElementById("authorManage");
	var str1 = document.getElementById("authorNm");
	var str2 = document.getElementById("authorDc");
	varFrom.action = "/bos/auth/auth/update.do?menuNo=${param.menuNo}";

	if (str1.value == '' || str1.value == null){
		alert('권한 명을 입력해주세요.');
		return;
	}

	if (str2.value == '' || str2.value == null){
		alert('설명을 입력해주세요.');
		return;
	}

	if(confirm("수정 하시겠습니까?")){
		varFrom.submit();
	}
}

function fncAuthorDelete() {
	var varFrom = document.getElementById("authorManage");
	varFrom.action = "/bos/auth/auth/delete.do?menuNo=${param.menuNo}";
	if(confirm("삭제 하시겠습니까?  (권한별 메뉴관리 설정값이 일괄삭제됩니다. )")){
		varFrom.submit();
	}
}
/* 
function fnCheckAuthorCd(){
	var sAuthorCd = $("#authorCd").val();
	var bChk = false;
	if (sAuthorCd.substring(0,5) == "ROLE_" ) bChk = true;
	return bChk;
}
 */
</script>

<form:form commandName="authorManage" method="post" >
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<c:if test="${registerFlag == 'UPDATE'}">
	<input type="hidden" name="searchCnd" value="${resultVO.searchCnd}"/>
	<input type="hidden" name="searchKwd" value="${resultVO.searchKwd}"/>
	<input type="hidden" name="pageIndex" value="${resultVO.pageIndex}"/>
</c:if>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<div class="bdView">
<table>
	<caption>홈페이지 관리자 권한관리도움말 등록</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">
				<c:if test="${registerFlag != 'UPDATE'}"><label for="authorCd"><span class="req"><span>필수입력</span></span> 권한 ID </label></c:if>
				<c:if test="${registerFlag == 'UPDATE'}">권한 ID</c:if>
			</th>
			<td>
				<input name="authorCd" id="authorCd" class="w100p" type="text"<c:if test="${registerFlag == 'UPDATE'}">readonly </c:if>
					value="" size="40" title="권한 코드"/>
					<form:errors path="authorCd" />
				<!-- <p class="help">
					권한ID는 대문자영문 혹은 숫자로만 입력가능하며, 반드시 “ROLE_” 로 시작해야 합니다.
				</p> -->

			</td>
		</tr>
		<tr>
			<th scope="row"><label for="authorNm"><span class="req"><span>필수입력</span></span> 권한 명 </label></th>
			<td>
				<input name="authorNm" id="authorNm" class="w100p" type="text" value="${result.authorNm}" required="true" fieldTitle="권한 명" maxLength="50" char="s" size="40" /> <form:errors path="authorNm" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="authorDc"><span class="req"><span>필수입력</span></span> 설명 </label></th>
			<td>
				<input name="authorDc" id="authorDc" class="w100p" type="text" value="${result.authorDc}" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="authorNm"><span class="req"><span>필수입력</span></span> 상위권한 </label></th>
			<td>
				<select id="chldrnAuthorCd" name="chldrnAuthorCd" title="상위권한">
			   		<option value="">상위 권한명</option>
				   	<c:forEach var="item" items="${authorList}" varStatus="status">
				   		<c:if test="${result.authorCd ne item.authorCd}">
			  				<option value="${item.authorCd}" <c:if test="${upperAuthor.chldrnAuthorCd == item.authorCd}">selected="selected"</c:if>>${item.authorCd} (${item.authorNm})</option>
				   		</c:if>
				   	</c:forEach>
				</select>
			</td>
		</tr>
		<!--
		<tr>
			<th scope="row">등록일자</th>
			<td>
				${result.registDt}
				<input name="registDt" id="registDt" class="w100p" type="hidden" value="${result.registDt}" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="50" readonly/>
			</td>
		</tr>
		 -->
	</tbody>
</table>
</div>

</form:form>

<div class="btnSet">
  <c:if test="${registerFlag == 'INSERT'}">
	<a class="b-reg" href="javascript:fncAuthorInsert()">등록</a>
  </c:if>
  <c:if test="${registerFlag == 'UPDATE'}">
	<c:if test="${result.authorCd eq 'ROLE_CPO' or result.authorCd eq 'ROLE_CPM' or result.authorCd eq 'ROLE_CPP' or result.authorCd eq 'ROLE_ADMIN'}"><p class="help">개인정보 보호 책임자, 관리자, 처리자 권한 및 최고 관리자 권한은 삭제할 수 없습니다.</p></c:if>
	<a class="b-edit" href="javascript:fncAuthorUpdate()">수정</a>
	<c:if test="${result.authorCd ne 'ROLE_CPO' and result.authorCd ne 'ROLE_CPM' and result.authorCd ne 'ROLE_CPP' and result.authorCd ne 'ROLE_ADMIN'}">
	<a class="b-del"  href="javascript:fncAuthorDelete()">삭제</a>
	</c:if>
  </c:if>
	<a class="b-cancel" href="javascript:fncSelectAuthorList()">취소</a>
</div>