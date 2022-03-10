<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
		<li class="" ><a href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li class="" ><a href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li class="active"><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li class="" ><a href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li class="" ><a href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li class="" ><a href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
	</ul>
</div>

<form id="formFile" name="formFile" method="post" enctype="multipart/form-data" action="/bos/instance/case/insertFile.do">
	<input type="hidden" name="caseSeq" id="caseSeq" value="${result.caseSeqC}" /> 
	<!-- 파일 없로드 -->
	<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
		<jsp:param value="case" name="subFileGroup" />
		<jsp:param value="${result.caseSeqC }" name="subFileCode" />
		<jsp:param value="" name="subFilecodeSub" /> 
		<jsp:param value="" name="afterUrl" />
		<jsp:param value="10" name="fileCnt" />
	</jsp:include>
</form>

<div class="btnGroup">
	<a class="pure-button btnSave" href="javascript:checkForm();" id="btnCaseSave"><span>등록</span></a>
	<button id="btnCaseFilePrint" title="print4-4" class="pure-button btnInsert btnCasePrintView">출력</button>
</div>



<script>
function checkForm() {
    if (!confirm('등록 하시겠습니까?')) {
        return;
    }
	var form = $("#formFile")[0];
    $("#loadingDiv").show();
    form.submit();
}

$('#btnCaseFilePrint').click(function(e) {
    e.preventDefault();
    var thisSeq = $(this).attr("title");
    var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
});
</script>
