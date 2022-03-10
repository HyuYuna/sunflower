<%@page import="site.unp.core.service.sec.UnpUserDetailsHelper"%>
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
	<c:set var="action" value="/ucms/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/ucms/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>
<script src="/static/jslibrary/miya_validator.js"></script>
<script>

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);

	v.add("nttSj", {
        required: true
    });
	v.add("nttCn", {
        required: true
    });
	if (form.catpchaAnswer){
	v.add("catpchaAnswer", {
        required: true
    });
	}


	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
		return;
	}
	$("#loadingDiv").show();
	form.submit();
}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlAt" value="${result.htmlAt}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>

<c:if test="${not empty masterVO.aditCntntsCn }">
<div>
	<util:out escapeXml="false">${masterVO.aditCntntsCn}</util:out>
</div>
</c:if>
<div class="reg">
	<dl>
		<dt>작성자</dt>
		<dd>${userInfo.userNm}</dd>
	</dl>
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">제목</label></dt>
		<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}"></dd>
	</dl>
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttCn">내용</label></dt>
		<dd>
		<textarea name="nttCn" id="nttCn" cols="30" rows="10" class="w100p"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
		</dd>
	</dl>
<c:if test="${empty result}">
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="catpchaAnswer">자동등록 방지</label></dt>
		<dd>
			<%@ include file="/WEB-INF/jsp/cmmn/captcha/captcha_inc.jsp" %>
		</dd>
	</dl>
</c:if>
<c:if test="${not empty result}">
	<dl>
		<dt>등록일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
	</dl>
</c:if>
</div>
<div class="btnSet">
<c:choose>
	<c:when test="${empty result}" >
		<button type="button" onclick="checkForm()" class="b-save">등록</button>
	</c:when>
	<c:otherwise>
		<button type="button" onclick="checkForm()" class="b-edit">수정</button>
	</c:otherwise>
</c:choose>
	<a href="/ucms/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" class="b-cancel">취소</a>
</div>
</form>
