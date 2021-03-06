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
			//?????? ????????? ??????
			ext = $(this).val().split(".").pop().toLowerCase();
			if ($.inArray(ext, ["gif","jpg","jpeg","png"]) == -1){
				alert("???????????? ?????? ????????? ?????????.");
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
			//?????? ?????? ??????
			if (this.files[0].size > maxSize){
				alert(num + "?????? ????????? " + maxMegaSize + "M??? ???????????? ????????? ??? ????????????.");
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
			alert('???????????? ???????????? ??????????????? ????????????.');
			return;
		}
	}
	*/

	if (oEditors.getById["nttCn"].getIR() == "<p><br></p>") {
		alert('????????? ????????? ?????????.');
		oEditors.getById["nttCn"].exec("FOCUS", []);
	    return;
	}

	document.getElementById("nttCn").value = oEditors.getById["nttCn"].getIR();
	if (!confirm('${empty result ? "??????" : "??????"}???????????????????')) {
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
						<span class="req"><span class="sr-only">????????????</span></span> <label for="nttTyCd1">????????????</label>
					</dt>
					<dd>
						<label> <input type="radio" id="nttTyCd1" name="nttTyCd" value="${SearchVO.NOTICE_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.NOTICE_NTT_TYPE}"> checked</c:if> /> ??????</label>
						<label> <input type="radio" id="nttTyCd2" name="nttTyCd" value="${SearchVO.BASIC_NTT_TYPE}" <c:if test="${result.nttTyCd eq SearchVO.BASIC_NTT_TYPE}"> checked</c:if> /> ?????? </label>
					</dd>
				</dl>
				<dl id="ntcrDeTr">
					<dt>
						<span class="req"><span class="sr-only">????????????</span></span><label for="ntceBgnde">????????????</label>
					</dt>
					<dd>
						<input id="ntceBgnde" name="ntceBgnde" value="${result.ntceBgnde}" readonly="readonly" type="text" class="board1 sdate" title="???????????????" /> ~ <input id="ntceEndde" name="ntceEndde" value="${result.ntceEndde}" readonly="readonly" type="text" class="board1 edate" title="???????????????" />
					</dd>
				</dl>
				 -->
				<dl>
					<dt><span class="req"><span class="sr-only">????????????</span></span><label for="nttSj">???????????????</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>
				<dl>
					<dt><span class="req"><span class="sr-only">????????????</span></span><label for="ntcrNm">?????????</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w30p" value="${empty result ? userVO.userNm : result.ntcrNm}" /></dd>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">????????????</span></span><label for="nttCn">??????</label></dt>
					<dd class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
				<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
					<c:if test="${not empty fileList}">
						<dl>
							<dt>????????? ????????????</dt>
							<dd>
								<jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" />
							</dd>
						</dl>
					</c:if>
					<dl class="fileFormArea">
						<dt>????????????</dt>
						<dd>
							<jsp:include page="/WEB-INF/jsp/bos/share/incFileSubmit.jsp" flush="true">
								<jsp:param value="5" name="fileCnt" />
							</jsp:include>
						</dd>
					</dl>
				</c:if>
				<c:if test="${not empty result}">
					<dl>
						<dt>?????????</dt>
						<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
					</dl>
					<dl>
						<dt>?????????</dt>
						<dd>${result.inqireCo}</dd>
					</dl>
				</c:if>

	</div>
</form>

<div class="btnSet">
	<c:if test="${not empty result}">
	<!--
		<div class="fl">
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('????????? ???????????????????????????????');"><span>????????????</span></a>
		</div>
	 -->
	</c:if>

	<div class="fr">
		<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:checkForm();" class="b-reg"><span>??????</span></a>
		</c:when>
		<c:otherwise>
			<a class="b-edit" href="javascript:checkForm();"><span>??????</span></a>
		<c:if test="${result.deleteCd eq '0' }" >
			<a class="b-del" href="javascript:del();" onclick="return confirm('????????? ?????????????????????????');"><span>??????</span></a>
		</c:if>
		<!--
		<c:if test="${result.deleteCd eq '1' }" >
			<a class="b-restore" href="javascript:restore();" onclick="return confirm('????????? ?????????????????????????');"><span>??????</span></a>
		</c:if>
		 -->
		</c:otherwise>
		</c:choose>
			<a class="b-cancel" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>??????</span></a>
	</div>
</div>

<div id="divUploadIng" style="display:none">
	<p class="tac">??????????????????.</p>
</div>
