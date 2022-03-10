<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<%
		int year = site.unp.core.util.DateUtil.getYear();
		pageContext.setAttribute("year", year);
%>

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
	$(".sdate").datepicker({showOn: 'button', buttonImage: '/static/img/commons/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

	/*
	$(function() {
		if($("#nttType1").filter(":checked").length == 0)
		{
			$("#ntcrDeTr").hide();
		}

		$("input[name=nttType]").on('click',function(){
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
	*/

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		/*
	    v.add("nttType", {
	        required: true
	    });
	 	if($("#nttType1").attr("checked"))
		{
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

		if (oEditors.getById["nttCn"].getIR() == "<p><br></p>") {
			alert('내용을 입력해 주세요.');
			oEditors.getById["nttCn"].exec("FOCUS", []);
		    return;
		}

		document.getElementById("nttCn").value = oEditors.getById["nttCn"].getIR();
		if (!confirm('등록하시겠습니까?')) {
			return;
		}


		if($('#eduBBS').val() == 'B0000011'){
			$("#option1").val('02');
		}

		$("#loadingDiv").show();
		form.submit();
	}
	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}


</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlYn" value="${result.htmlAt}" />
	<input type="hidden" name="bbsType" value="" />
	<input type="hidden" name="menuNo" value="${param.menuNo }"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="view">
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>

				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcrNm">작성자</label></dt>
					<dd><input type="text" name="ntcrNm" id="ntcrNm" class="w30p" value="${empty result ? userVO.userNm : result.ntcrNm}" /></dd>
				</dl>

				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span><label for="nttCn">내용</label></dt>
					<dd class="outputEditor">
						<ul class="list" style="color: red;">
							<li>아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
							(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등) </li>
						</ul>
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display: none;" class="textarea"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
<%-- 임시주석  --%>
<%-- 				<dl>
					<dt class="con_tit">대체텍스트 입력방법</dt>
					<dd>
						<ul class="list">
							<li>첨부파일이 있는 경우 : 내용 필드에 에디터를 이용하여 이미지 삽입하고 그림 설명에 반드시 "글제목 - 자세한 내용은 첨부파일 참조" 이라고 명시하고, 첨부파일 필드에 해당 첨부파일 등록</li>
							<li>첨부파일이 없는 경우 : 내용 필드에 에디터를 이용하여 이미지 삽입하고 그림 설명에 반드시 "글제목 - 자세한 내용은 하단에 제공" 이라고 명시하고, 본문이미지 대체텍스트 필드에 내용 기입 함</li>
						</ul>
					</dd>
				</dl>

				<dl>
					<dt class="con_tit"><label for="imgDescCn"> 본문이미지<br/>대체텍스트</label></dt>
					<dd>
						<textarea name="imgDescCn" id="imgDescCn" cols="120" rows="10" class="col-md-12" title="본문이미지 대체텍스트을 입력해 주세요.">${result.imgDescCn}</textarea>
					</dd>
				</dl>  --%>


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
						<dd>${result.regDate}</dd>
					</dl>
				</c:if>

				<c:if test="${not empty result}">
					<dl>
						<dt>조회수</dt>
						<dd>${result.inqireCo}</dd>
					</dl>
				</c:if>

	</div>
</form>

<div class="btnSet">
	<c:if test="${not empty result}">
		<div class="fl">
			<%--	<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>  --%>
		</div>
	</c:if>

	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
		</c:otherwise>
		</c:choose>
			<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>