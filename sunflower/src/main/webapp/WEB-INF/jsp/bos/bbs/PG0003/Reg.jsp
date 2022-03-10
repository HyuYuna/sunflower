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
	if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
		return;
	}
	$("#loadingDiv").show();
	form.submit();
}
function del(){
	if (!confirm('정말로 삭제 하시겠습니까?')) {
		return;
	}
	var form = $("#board")[0];
	form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
	form.submit();
}

function restore(){
	if (!confirm('정말로 복구 하시겠습니까?')) {
		return;
	}
	var form = $("#board")[0];
	form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
	form.submit();
}

function delPermanently(){
	if (!confirm('정말로 삭제 하시겠습니까?')) {
		return;
	}
	var form = $("#board")[0];
	form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
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

	<div class="view">
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">게시물제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcrNm">작성자</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w30p" value="${empty result ? userVO.userNm : result.ntcrNm}" /></dd>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span>내용</dt>
					<dd class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea" title="내용"><util:out escapeXml="false" >${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
				<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
					<c:if test="${not empty fileList}">
						<dl>
							<dt>첨부된 첨부파일</dt>
							<dd><jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" /></dd>
						</dl>
					</c:if>
					<dl class="fileFormArea">
						<dt>첨부파일</dt>
						<dd><jsp:include page="/WEB-INF/jsp/bos/share/incFileSubmit.jsp" flush="true" /></dd>
					</dl>
				</c:if>
				<c:if test="${not empty result}">
					<dl>
						<dt>등록일</dt>
						<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
					</dl>
					<dl>
						<dt>조회수</dt>
						<dd>${result.inqireCo}</dd>
					</dl>
				</c:if>

	</div>
</form>

<div class="btnSet">
	<c:if test="${not empty result}">
	<!--
		<div class="fl">
			<button type="button" class="b-del" href="javascript:delPermanently();">영구삭제</button>
		</div>
	 -->
	</c:if>

	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<button type="button" onclick="checkForm();" class="b-reg">등록</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="b-edit" onclick="checkForm();">수정</button>
		<c:if test="${result.deleteCd eq '0' }" >
			<button type="button" class="b-del" onclick="del();">삭제</button>
		</c:if>
		<!--
		<c:if test="${result.deleteCd eq '1' }" >
			<button type="button" class="b-restore" onclick="restore();">복구</button>
		</c:if>
		 -->
		</c:otherwise>
		</c:choose>
			<a class="b-cancel" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}">취소</a>
	</div>
</div>