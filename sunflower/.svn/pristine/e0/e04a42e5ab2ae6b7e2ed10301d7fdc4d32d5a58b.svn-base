<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

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

<%--<script src="/crosseditor/js/namo_scripteditor.js"></script>--%>

<script>

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		v.add("nttSj", {
	        required: true
	    });

		v.add("bbsSe", {
	        required: true
	    });

		if($("input[name='main_image']").length > 0){
	    v.add("main_image", {
	        required: true
	    },"메인이미지");
		}

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

	function delFile2(atchFileId, fileSn, bbsId, fileId){
		$.getJSON(
				"/bos/cmmn/file/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, bbsId : bbsId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/> 이미지 권장사이즈 : 335*245");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}


</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlYn" value="${result.htmlAt}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="view">
				<dl>
					<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="nttSj">제목</label></dt>
					<dd><input type="text" name="nttSj" id="nttSj" class="w100p" value="${result.nttSj}" /></dd>
				</dl>
				<dl>
					<dt>
						<span class="req"><span class="sr-only">필수입력</span></span><label for="bbsSe">분류구분</label>
					</dt>
					<dd>
						<select id="bbsSe" name="bbsSe" title="공지사항구분">
							<option value="">전체</option>
							<c:forEach var="code" items="${COM094CodeList}" varStatus="status">
			  	 			<option value="${code.code}" <c:if test="${result.bbsSe eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
				 			</c:forEach>
						</select>
					</dd>
				</dl>
				<dl>
					<dt class="con_tit"><span class="req"><span class="sr-only">필수입력</span></span><label for="nttCn">내용</label></dt>
					<dd class="outputEditor">
						<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display:none;" class="textarea"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</dd>
				</dl>
		<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
		<%--########################### MAIN_IMAGE 시작 --%>
			<%--이미지 탐색 main_image 처리 --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldNm eq 'main_image'}">
								<c:set var="fileVO" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if>
			<%--이미지 탐색 main_image 끝 --%>
			<dl>
				<dt><span class="req"><span class="sr-only">필수입력</span></span><label for="main_image">메인 이미지</label></dt>
				<dd id="main_image">
			<c:if test="${not empty fileVO}">
				<a href="/bos/cmmn/file/fileDown.do?menuNo=${param.menuNo}&amp;atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
					${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
				</a>
				<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','main_image');" class="btn btn-danger btn-sm">
					<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
					<i class="fa fa-trash-o" aria-hidden="true"></i>
				</a>
			</c:if>

			<%-- #main_image 파일이 없을시  처리  --%>
			<c:if test="${empty fileVO}">
						<input name="main_image" id="main_image" type="file" class="input_file form-control" title="메인이미지" />
						이미지 권장사이즈 : 335*245
			</c:if>
			<c:set var="fileVO" value=""/>
				</dd>
			</dl>
<%--########################### MAIN_IMAGE 끝 --%>
<%--########################### SUB_IMG1 시작 --%>
			<%--이미지 탐색 sub_image1 처리 --%>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldNm eq 'sub_image1' or fileList[x].fileCn eq 'sub_image1'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<dl>
				<dt><label for="sub_image1">첨부파일</label></dt>
				<dd id="sub_image1">
					<%-- #sub_image1 파일이 있을시 처리  --%>
					<c:if test="${not empty fileVO}">
						<a href="/bos/cmmn/file/fileDown.do?menuNo=${param.menuNo}&amp;atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
							${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
						</a>
						<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','sub_image1');" class="btn btn-danger btn-sm">
							<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
							<i class="fa fa-trash-o" aria-hidden="true"></i>
						</a>
					</c:if>

					<%-- #sub_image1 파일이 없을시  처리  --%>
					<c:if test="${empty fileVO}">
							<input name="sub_image1" type="file" id="sub_image1" class="input_file form-control" title="서브이미지1" />
					</c:if>
					<c:set var="fileVO" value=""/>
				</dd>
			</dl>
<%--########################### SUB_IMG1 끝 --%>

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

<div class="btnSet" >

	<c:if test="${not empty result}">
		<div class="fl">
				<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</div>
	</c:if>

	<div class="fr">
		<c:choose>
			<c:when test="${empty result}" >
				<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
			</c:when>
			<c:otherwise>
				<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
			<c:if test="${result.delcode eq '0' }" >
				<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
			</c:if>
		 	<c:if test="${result.delcode eq '1' }" >
				<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
			</c:if>
			</c:otherwise>
		</c:choose>

		<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>