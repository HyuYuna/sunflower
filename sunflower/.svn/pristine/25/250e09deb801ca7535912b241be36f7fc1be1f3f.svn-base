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
$(function() {

	if($("#nttTyCd1").filter(":checked").length == 0)
	{
		$("#ntcrDeTr").hide();
	}

	$("input[name=nttTyCd]").on('click',function(){
		if(this.value == "${SearchVO.NOTICE_NTT_TYPE}")
		{
			$("#ntcrDeTr").show();
		}
		else
		{
			$("#ntcrBgnde").val("");
			$("#ntcrEndde").val("");
			$("#ntcrDeTr").hide();
		}
	});
});

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);

	/*
	v.add("nttTyCd", {
        required: true
    });
	*/

	if($("#nttTyCd1").filter(":checked").length > 0)
	{
		v.add("ntceBgnde", {
			required: true
		});
		v.add("ntceEndde", {
			required: true
		});
	}

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

	var mode = "${empty result ? 'I' : 'U'}";
	if (mode == 'I') {
		var c = false;
		$('input[type=file]').each(function(){
			if (this.value) {
				c = true;
				return false;
			}
		});
		if (!c) {
			alert('이미지파일은 필수입니다.');
			$('input[type=file]').eq(0).focus();
			return;
		}
	}

	if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
		return;
	}

	$("#loadingDiv").show();
	form.submit();
}
function del(){
	var form = $("#board")[0];
	form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
	form.submit();
}

function restore(){
	var form = $("#board")[0];
	form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
	form.submit();
}

function delPermanently(){
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

	<div class="reg">
				<!--
				<dl>
					<dt style="width:15%">
						<span class="req"><span class="sr-only">필수입력</span></span> 공지구분
					</dt>
					<dd>
						<label for="nttTyCd1"> <input type="radio" id="nttTyCd1" name="nttTyCd" value="${SearchVO.NOTICE_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.NOTICE_NTT_TYPE}"> checked</c:if> /> 공지</label>
						<label for="nttTyCd2"> <input type="radio" id="nttTyCd2" name="nttTyCd" value="${SearchVO.BASIC_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.BASIC_NTT_TYPE}"> checked</c:if> /> 일반 </label>
					</td>
				</dl>
				<dl id="ntcrDeTr">
					<dt>
						<span class="req"><span class="sr-only">필수입력</span></span>공지기간
					</dt>
					<dd>
						<input id="ntceBgnde" name="ntceBgnde" value="${result.ntceBgnde}" readonly="readonly" type="text" class="sdate" title="게시시작일" />
						 ~
						<input id="ntceEndde" name="ntceEndde" value="${result.ntceEndde}" readonly="readonly" type="text" class="edate" title="게시종료일" />
					</td>
				</dl>
				 -->
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">게시물제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></td>
				</dl>
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcrNm">작성자</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w30p" value="${empty result ? userVO.userNm : result.ntcrNm}" /></td>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span>내용</dt>
					<td class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea" title="내용"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</td>
				</dl>
				<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
					<c:if test="${not empty fileList}">
						<dl>
							<dt>첨부된 이미지파일</dt>
							<dd><jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" /></td>
						</dl>
					</c:if>
					<dl class="fileFormArea">
						<dt class="con_tit"><span class="req"><span class="sr-only"></span></span>이미지파일</dt>
						<dd>
							<jsp:include page="/WEB-INF/jsp/bos/share/incFileSubmit.jsp" flush="true">
								<jsp:param value="5" name="fileCnt" />
								<jsp:param value="Y" name="imgAt" />
								<jsp:param value="270" name="width" />
								<jsp:param value="210" name="height" />
							</jsp:include>
						</td>
					</dl>
				</c:if>
				<c:if test="${not empty result}">
					<dl>
						<dt>등록일</dt>
						<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></td>
					</dl>
					<dl>
						<dt>조회수</dt>
						<dd>${result.inqireCo}</td>
					</dl>
				</c:if>

	</div>
</form>

<div class="btnSet">
	<c:if test="${not empty result}">
	<!--
		<div class="fl">
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');">영구삭제</a>
		</div>
	 -->
	</c:if>

	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:checkForm();" class="b-reg">등록</a>
		</c:when>
		<c:otherwise>
			<a class="b-reg" href="javascript:checkForm();">수정</a>
		<c:if test="${result.deleteCd eq '0' }" >
			<a class="b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
		</c:if>
		<!--
		<c:if test="${result.deleteCd eq '1' }" >
			<a class="b-restore" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');">복구</a>
		</c:if>
		 -->
		</c:otherwise>
		</c:choose>
			<a class="b-cancel" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}">취소</a>
	</div>
</div>