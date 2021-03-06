<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty result.wrdSn ? 'INSERT' : 'UPDATE'}"/>
<script language="javascript">

/* function fncSelectPrhibtList() {
	var varFrom = document.getElementById("prhibtManage");
	varFrom.action = "/bos/sys/prhibtWrdFlter/list.do?menuNo=${param.menuNo}";
	varFrom.submit();
} */

// 금지단어 등록
function fncPrhibtInsert() {
    var varFrom = document.getElementById("prhibtManage");
    var str = document.getElementById("wrdNm");
    varFrom.action = "/bos/sys/prhibtWrdFlter/insert.do?menuNo=${param.menuNo}";

    if(str.value == '' || str.value == null){
		alert('금지단어명을 입력해주세요.');
		return;
	}
    if(confirm("저장 하시겠습니까?")){
        varFrom.submit();
    }
}

// 금지단어 수정
function fncPrhibtUpdate() {
	var varFrom = document.getElementById("prhibtManage");
	var str = document.getElementById("wrdNm");
	varFrom.action = "/bos/sys/prhibtWrdFlter/update.do?menuNo=${param.menuNo}";

	if(str.value == '' || str.value == null){
		alert('금지단어명을 입력해주세요.');
		return false;
	}
    if(confirm("수정 하시겠습니까?")){
    	varFrom.submit();
    }
}

// 금지단어 삭제
function fncPrhibtDelete() {
	var varFrom = document.getElementById("prhibtManage");
	varFrom.action = "/bos/sys/prhibtWrdFlter/delete.do?menuNo=${param.menuNo}";
	if(confirm("삭제 하시겠습니까?")){
	    varFrom.submit();
	}
}



</script>
<form:form commandName="prhibtManage" method="post" >
<c:if test="${registerFlag == 'UPDATE'}">
	<input type="hidden" name="searchCnd" value="${resultVO.searchCnd}"/>
	<input type="hidden" name="searchKwd" value="${resultVO.searchKwd}"/>
	<input type="hidden" name="pageIndex" value="${resultVO.pageIndex}"/>
	<input type="hidden" name="wrdSn" value="${result.wrdSn}"/>
</c:if>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<div class="bdView">
<table>
	<caption>금지단어관리</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrdNm">금지단어명</label></th>
			<td>
				<input class="w100p" name="wrdNm" id="wrdNm" type="text" value="${result.wrdNm}" required="true" fieldTitle="금지단어명" maxLength="50" char="s" size="30" />
				<form:errors path="wrdNm" />
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>사용여부</th>
			<td>
				<input type="radio" name="useAt" id="useAt1" class="input_radio" value="Y" <c:if test="${empty result or result.useAt == 'Y'}"> checked</c:if> /> <label for="useAt1">사용</label>
				<input type="radio" name="useAt" id="useAt2" class="input_radio" value="N" <c:if test="${result.useAt == 'N'}"> checked</c:if> /> <label for="useAt2">미사용</label>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form:form>

	<div class="btnSet">
      <c:if test="${registerFlag == 'INSERT'}">
		<a class="b-reg" href="javascript:fncPrhibtInsert()"><span>등록</span></a>
	  </c:if>
      <c:if test="${registerFlag == 'UPDATE'}">
		<a class="b-edit" href="javascript:fncPrhibtUpdate()"><span>수정</span></a>
		<a class="b-del"  href="javascript:fncPrhibtDelete()"><span>삭제</span></a>
	  </c:if>
		<a class="b-cancel" href="/bos/sys/prhibtWrdFlter/list.do?${pageQueryString}"><span>취소</span></a>
	</div>