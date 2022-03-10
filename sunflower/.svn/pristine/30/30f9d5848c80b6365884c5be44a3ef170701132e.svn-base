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

	if ($("#nttTyCd1").filter(":checked").length > 0) {
		v.add("ntceBgnde", {
			required: true
		});
		v.add("ntceEndde", {
			required: true
		});
	}
	*/

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

	/*
	var maxMegaSize = 10;
	var maxSize = 1024 * 1024 * maxMegaSize;
	var num = 1;
	var ext = "";
	var flag = true;
	$("#board input[type=file]").each(function(){
		if ($(this).val()!=""){
			//파일 확장자 체크
			ext = $(this).val().split(".").pop().toLowerCase();
			if ($.inArray(ext, ["gif","jpg","jpeg","png"]) == -1){
				alert("지원하지 않는 확장자 입니다.");
				$(this).val("");
				flag = false;
				return;
			}
		}
		num++;
	});
	if (flag==false) return;

	var flag = true;
	var num = 1;
	$("#board input[type=file]").each(function(){
		if ($(this).val()!=""){
			//파일 용량 체크
			if (this.files[0].size > maxSize){
				alert(num + "번째 파일이 " + maxMegaSize + "M를 초과하여 등록할 수 없습니다.");
				flag=false;
				return;
			}
		}
		num++;
	});
	if (flag==false) return;
	*/

	/*
	if ($("#nttTyCd1").filter(":checked").length > 0) {
		var b = $('#ntceBgnde').val();
		var e = $('#ntceEndde').val();
		if (b > e) {
			alert('공지기간 종료일이 시작일보다 작습니다.');
			return;
		}
	}
	*/

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
	<input type="hidden" name="nttType" value="2" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="reg">
				<!--
				<dl>
					<dt>
						<span class="req"><span class="sr-only">필수입력</span></span> <label for="nttTyCd1">공지구분</label>
					</dt>
					<dd>
						<label> <input type="radio" id="nttTyCd1" name="nttTyCd" value="${SearchVO.NOTICE_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.NOTICE_NTT_TYPE}"> checked</c:if> /> 공지</label>
						<label> <input type="radio" id="nttTyCd2" name="nttTyCd" value="${SearchVO.BASIC_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.BASIC_NTT_TYPE}"> checked</c:if> /> 일반 </label>
					</dd>
				</dl>
				<dl id="ntcrDeTr">
					<dt>
						<span class="req"><span class="sr-only">필수입력</span></span><label for="ntceBgnde">공지기간</label>
					</dt>
					<dd>
						<input id="ntceBgnde" name="ntceBgnde" value="${result.ntceBgnde}" readonly="readonly" type="text" class="board1 sdate" title="게시시작일" /> ~ <input id="ntceEndde" name="ntceEndde" value="${result.ntceEndde}" readonly="readonly" type="text" class="board1 edate" title="게시종료일" />
					</dd>
				</dl>
				 -->
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">게시물제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcrNm">작성자</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w30p" value="${empty result ? userVO.userNm : result.ntcrNm}" /></dd>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span><label for="nttCn">내용</label></dt>
					<dd class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
				<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
					<c:if test="${not empty fileList}">
						<dl>
							<dt>첨부된 첨부파일</dt>
							<dd>
								<jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" />
							</dd>
						</dl>
					</c:if>
					<dl class="fileFormArea">
						<dt>첨부파일</dt>
						<dd>
							<jsp:include page="/WEB-INF/jsp/bos/share/incFileSubmit.jsp" flush="true">
								<jsp:param value="5" name="fileCnt" />
							</jsp:include>
						</dd>
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
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</div>
	 -->
	</c:if>

	<div class="fr">
		<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:checkForm();" class="b-reg"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
		<c:if test="${result.deleteCd eq '0' }" >
			<a class="b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:if>
		<!--
		<c:if test="${result.deleteCd eq '1' }" >
			<a class="b-restore" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
		</c:if>
		 -->
		</c:otherwise>
		</c:choose>
			<a class="b-cancel" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>취소</span></a>
	</div>
</div>

<div id="divUploadIng" style="display:none">
	<p class="tac">저장중입니다.</p>
</div>
