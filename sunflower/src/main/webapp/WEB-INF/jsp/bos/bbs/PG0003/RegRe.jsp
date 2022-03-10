<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>


<script>

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);
	v.add("nttSj", {
        required: true
    });
	v.add("ntcrNm", {
        required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (oEditors.getById["nttCn"].getIR() == "<p><br></p>") {
		alert('내용을 입력해 주세요.');
		oEditors.getById["nttCn"].exec("FOCUS", []);
	    return;
	}

	document.getElementById("nttCn").value = oEditors.getById["nttCn"].getIR();
	if (!confirm('답변 ${empty result ? "등록" : "수정"}하시겠습니까?')) {
		return;
	}

	form.submit();
}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="parntsNo" value="${orgResult.nttId }" />
	<input type="hidden" name="nttId" value="${empty result ? 0 : result.nttId}" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlAt" value="${result.htmlAt}" />
	<input type="hidden" name="answerAt" value="Y" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="view">
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">답변 제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcrNm">작성자</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w50p" value="${empty result ? userInfo.userNm : result.ntcrNm}" /></dd>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span>답변 내용</dt>
					<dd class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea" title="내용"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
	</div>
</form>

<div class="btnSet">
	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<button type="button" onclick="checkForm();" class="b-reg">답변등록</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="b-reg" onclick="checkForm();">답변수정</button>
		</c:otherwise>
		</c:choose>
			<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}">목록</a>
	</div>
</div>