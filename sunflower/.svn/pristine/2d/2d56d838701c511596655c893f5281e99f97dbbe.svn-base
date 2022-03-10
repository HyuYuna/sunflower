<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<c:if test="${empty result}">
	<c:set var="action" value="/${paramVO.siteName}/main/manager/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/${paramVO.siteName}/main/manager/update.do" />
</c:if>

<script>

function checkForm() {
	var form = $("#frm")[0];
	var v = new MiyaValidator(form);
	var contSn = $("#contSn").val();

	if (contSn == '1' || contSn == '2') {
		for (var i = 1; i < 8; i++) {
			var name = "contNm" + i;
			v.add(name, {
				required: true
		    }, "콘텐츠 명");

			name = "file" + i;
			if($("input[name=" + name + "]").length > 0){
			    v.add(name, {
			        required: true
			    }, "롤오버 이미지");
			}

			name = "linkUrl" + i;
			v.add(name, {
				required: true
			}, "페이지 URL");

			name = "contNm" + contSn + "" + i;
			v.add(name, {
				required: true
		    }, "작품명");

			name = "fileBg" + i;
			if($("input[name=" + name + "]").length > 0){
			    v.add(name, {
			        required: true
			    }, "배경 이미지");
			}
		}
	} else if (contSn == '3') {
		for (var i = 1; i < 3; i++) {
			var name = "contNm" + i;
			v.add(name, {
				required: true
		    }, "이벤트 명");

			name = "file" + i;
			if($("input[name=" + name + "]").length > 0){
			    v.add(name, {
			        required: true
			    }, "이벤트 이미지");
			}

			name = "linkUrl" + i;
			v.add(name, {
				required: true
			}, "페이지 URL")
		}
	} else if (contSn == '4') {
		for (var i = 1; i < 5; i++) {
			var name = "contNm" + i;
			v.add(name, {
				required: true
		    }, "테마전 명");

			name = "file" + i;
			if($("input[name=" + name + "]").length > 0){
			    v.add(name, {
			        required: true
			    }, "테마전 이미지");
			}

			name = "linkUrl" + i;
			v.add(name, {
				required: true
			}, "페이지 URL")
		}
	} else if (contSn == '5') {
		v.add("contNm1", {
			required: true
	    }, "콘텐츠 명");

		if($("input[name=file1]").length > 0){
		    v.add("file1", {
		        required: true
		    }, "콘텐츠 이미지");
		}

		v.add("linkUrl1", {
			required: true
	    }, "페이지 URL");
	}

	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (confirm('등록하시겠습니까?')) {
		form.submit();
	}
}

function reset() {
	var form = $("#frm")[0];
	form.reset();
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
            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/>");
            }
            else alert("삭제에 실패하였습니다.");
		}
	);
}

</script>

<form id="frm" name="frm" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}" />
	<input type="hidden" id="contSn" name="contSn" value="${paramVO.contSn}" />

<c:if test="${param.contSn == '1' or param.contSn == '2' }">
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm1">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm1" name="contNm1" value="${result.contNm1 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license1">라이선스 이미지</label></th>
					<td id="license1">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license1'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license1" name="license1" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file1">롤오버 이미지</label></th>
					<td id="file1">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file1' or fileList[x].fileCn eq 'file1'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file1" name="file1" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl1">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl1" name="linkUrl1" value="${result.linkUrl1}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt1">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt1" name="wrtCnt1" value="${result.wrtCnt1}" class="w100p" /></td>
				</tr>
				<c:set var="contNm1" value="${(param.contSn eq 1 ) ? resultList7[0].contNm1 : resultList8[0].contNm1 }"/>
				<c:set var="wrtCnt1" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt1 : resultList8[0].wrtCnt1 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}1">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}1" name="contNm${param.contSn}1" value="${contNm1}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}1">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}1' id='wrtCnt${param.contSn}1'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt1) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg1">배경 이미지</label></th>
					<td id="fileBg1" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg1' or fileList[x].fileCn eq 'fileBg1'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg1" name="fileBg1" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>

			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm2">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm2" name="contNm2" value="${result.contNm2 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license2">라이선스 이미지</label></th>
					<td id="license2">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license2'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license2');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license2" name="license2" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file2">롤오버 이미지</label></th>
					<td id="file2">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file2'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file2');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file2" name="file2" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl2">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl2" name="linkUrl2" value="${result.linkUrl2}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt2">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt2" name="wrtCnt2" value="${result.wrtCnt2}" class="w100p" /></td>
				</tr>
				<c:set var="contNm2" value="${(param.contSn eq 1 ) ? resultList7[0].contNm2 : resultList8[0].contNm2 }"/>
				<c:set var="wrtCnt2" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt2 : resultList8[0].wrtCnt2 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}2">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}2" name="contNm${param.contSn}" value="${contNm2}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}2">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}2' id='wrtCnt${param.contSn}2'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt2) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg2">배경 이미지</label></th>
					<td id="fileBg2" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg2' or fileList[x].fileCn eq 'fileBg2'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg2');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg2" name="fileBg2" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm3">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm3" name="contNm3" value="${result.contNm3 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license3">라이선스 이미지</label></th>
					<td id="license3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license3'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license3');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license3" name="license3" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file3">롤오버 이미지</label></th>
					<td id="file3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file3'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file3');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file3" name="file3" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl3">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl3" name="linkUrl3" value="${result.linkUrl3}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt3">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt3" name="wrtCnt3" value="${result.wrtCnt3}" class="w100p" /></td>
				</tr>
				<c:set var="contNm3" value="${(param.contSn eq 1 ) ? resultList7[0].contNm3 : resultList8[0].contNm3 }"/>
				<c:set var="wrtCnt3" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt3 : resultList8[0].wrtCnt3 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}3">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}3" name="contNm${param.contSn}3" value="${contNm3}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}3">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}3' id='wrtCnt${param.contSn}3'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt3) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg3">배경 이미지</label></th>
					<td id="fileBg3" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg3' or fileList[x].fileCn eq 'fileBg3'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg3');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg3" name="fileBg3" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm4">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm4" name="contNm4" value="${result.contNm4 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license4">라이선스 이미지</label></th>
					<td id="license4">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license4'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license4');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license4" name="license4" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file4">롤오버 이미지</label></th>
					<td id="file4">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file4'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file4');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file4" name="file4" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl4">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl4" name="linkUrl4" value="${result.linkUrl4}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt4">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt4" name="wrtCnt4" value="${result.wrtCnt4}" class="w100p" /></td>
				</tr>
				<c:set var="contNm4" value="${(param.contSn eq 1 ) ? resultList7[0].contNm1 : resultList8[0].contNm4 }"/>
				<c:set var="wrtCnt4" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt1 : resultList8[0].wrtCnt4 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}4">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}4" name="contNm${param.contSn}4" value="${contNm4}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}4">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}4' id='wrtCnt${param.contSn}4'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt4) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg4">배경 이미지</label></th>
					<td id="fileBg4" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg4' or fileList[x].fileCn eq 'fileBg4'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg4');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg4" name="fileBg4" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm5">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm5" name="contNm5" value="${result.contNm5 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license5">라이선스 이미지</label></th>
					<td id="license5">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license5'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license5');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license5" name="license5" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file5">롤오버 이미지</label></th>
					<td id="file5">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file5'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file5');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file5" name="file5" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl5">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl5" name="linkUrl5" value="${result.linkUrl5}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt5">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt5" name="wrtCnt5" value="${result.wrtCnt5}" class="w100p" /></td>
				</tr>
				<c:set var="contNm5" value="${(param.contSn eq 1 ) ? resultList7[0].contNm5 : resultList8[0].contNm5 }"/>
				<c:set var="wrtCnt5" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt5 : resultList8[0].wrtCnt5 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}5">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}5" name="contNm${param.contSn}5" value="${contNm5}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}5">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}5' id='wrtCnt${param.contSn}5'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt5) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg5">배경 이미지</label></th>
					<td id="fileBg5" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg5' or fileList[x].fileCn eq 'fileBg5'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg5');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg5" name="fileBg5" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm6">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm6" name="contNm6" value="${result.contNm6 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license6">라이선스 이미지</label></th>
					<td id="license6">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license6'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license6');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license6" name="license6" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file6">롤오버 이미지</label></th>
					<td id="file6">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file6'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file6');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file6" name="file6" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl6">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl6" name="linkUrl6" value="${result.linkUrl6}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt6">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt6" name="wrtCnt6" value="${result.wrtCnt6}" class="w100p" /></td>
				</tr>
				<c:set var="contNm6" value="${(param.contSn eq 1 ) ? resultList7[0].contNm6 : resultList8[0].contNm6 }"/>
				<c:set var="wrtCnt6" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt6 : resultList8[0].wrtCnt6 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}6">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}6" name="contNm${param.contSn}6" value="${contNm6}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}6">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}6' id='wrtCnt${param.contSn}6'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt6) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg6">배경 이미지</label></th>
					<td id="fileBg6" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg6' or fileList[x].fileCn eq 'fileBg6'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg6');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg6" name="fileBg6" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<caption>이용저작물 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm7">콘텐츠 명</label></th>
					<td colspan="3"><input type="text" id="contNm7" name="contNm7" value="${result.contNm7 }" class="w100p"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="license7">라이선스 이미지</label></th>
					<td id="license7">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'license7'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','license7');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="license7" name="license7" class="input_file form-control" title="라이선스 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file7">롤오버 이미지</label></th>
					<td id="file7">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'file7'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file7');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file7" name="file7" class="input_file form-control" title="롤오버 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl7">페이지 URL</label></th>
					<td colspan="3"><input type="text" id="linkUrl7" name="linkUrl7" value="${result.linkUrl7}" class="w100p" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt7">저작물 수</label></th>
					<td colspan="3"><input type="text" id="wrtCnt7" name="wrtCnt7" value="${result.wrtCnt7}" class="w100p" /></td>
				</tr>
				<c:set var="contNm7" value="${(param.contSn eq 1 ) ? resultList7[0].contNm7 : resultList8[0].contNm7 }"/>
				<c:set var="wrtCnt7" value="${(param.contSn eq 1 ) ? resultList7[0].wrtCnt7 : resultList8[0].wrtCnt7 }"/>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm${param.contSn}7">작품명</label></th>
					<td >
						<input type="text" id="contNm${param.contSn}7" name="contNm${param.contSn}7" value="${contNm7}" class="w100p" />
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="wrtCnt${param.contSn}7">라이센스</label></th>
					<td >
						<select name='wrtCnt${param.contSn}7' id='wrtCnt${param.contSn}7'>
						<c:forEach var="code" items="${COM088CodeList}" varStatus="status">
						 	<option value="${code.code}" ${(code.code eq wrtCnt7) ? "selected" : "" }>
						 		${code.codeNm}
						 	</option>
				 		</c:forEach>
				 		</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="fileBg7">배경 이미지</label></th>
					<td id="fileBg7" colspan="3">
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldName eq 'fileBg7' or fileList[x].fileCn eq 'fileBg7'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','fileBg7');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="fileBg7" name="fileBg7" class="input_file form-control" title="배경 이미지" /></c:if>
						<c:set var="fileVO" value=""/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${param.contSn == '3' }">
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file1'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>참여공간 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm1">이벤트 명</label></th>
					<td><input type="text" id="contNm1" name="contNm1" value="${result.contNm1 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file1">이벤트 이미지</label></th>
					<td id="file1">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file31" name="file1" class="input_file form-control" title="이벤트 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl1">페이지 URL</label></th>
					<td><input type="text" id="linkUrl1" name="linkUrl1" value="${result.linkUrl1}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file2'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>참여공간 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm2">이벤트 명</label></th>
					<td><input type="text" id="contNm2" name="contNm2" value="${result.contNm2 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="file2">이벤트 이미지</label></th>
					<td id="file2">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file2');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file2" name="file2" class="input_file form-control" title="이벤트 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl2">페이지 URL</label></th>
					<td><input type="text" id="linkUrl2" name="linkUrl2" value="${result.linkUrl2}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${param.contSn == '4' }">
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file1'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>테마전 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm1">테마전 명</label></th>
					<td><input type="text" id="contNm1" name="contNm1" value="${result.contNm1 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file1">테마전 이미지</label></th>
					<td id="file1">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file1" name="file1" class="input_file form-control" title="테마전 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl1">페이지 URL</label></th>
					<td><input type="text" id="linkUrl1" name="linkUrl1" value="${result.linkUrl1}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file2'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>테마전 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm2">테마전 명</label></th>
					<td><input type="text" id="contNm2" name="contNm2" value="${result.contNm2 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file2">테마전 이미지</label></th>
					<td id="file2">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file2');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file2" name="file2" class="input_file form-control" title="테마전 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl2">페이지 URL</label></th>
					<td><input type="text" id="linkUrl2" name="linkUrl2" value="${result.linkUrl2}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file3'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>테마전 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm3">테마전 명</label></th>
					<td><input type="text" id="contNm3" name="contNm3" value="${result.contNm3 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file3">테마전 이미지</label></th>
					<td id="file3">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file3');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file3" name="file3" class="input_file form-control" title="테마전 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl3">페이지 URL</label></th>
					<td><input type="text" id="linkUrl3" name="linkUrl3" value="${result.linkUrl3}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file4'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>테마전 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm4">테마전 명</label></th>
					<td><input type="text" id="contNm4" name="contNm4" value="${result.contNm4 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file4">테마전 이미지</label></th>
					<td id="file4">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file4');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file4" name="file4" class="input_file form-control" title="테마전 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl4">페이지 URL</label></th>
					<td><input type="text" id="linkUrl4" name="linkUrl4" value="${result.linkUrl4}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file5'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>테마전 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm5">테마전 명</label></th>
					<td><input type="text" id="contNm5" name="contNm5" value="${result.contNm5 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file5">테마전 이미지</label></th>
					<td id="file5">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file5');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file5" name="file5" class="input_file form-control" title="테마전 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl5">페이지 URL</label></th>
					<td><input type="text" id="linkUrl5" name="linkUrl5" value="${result.linkUrl5}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${param.contSn == '5' }">
	<div class="bdView">
		<table>
			<c:if test="${fn:length(fileList) gt 0}">
				<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
					<c:if test="${fileList[x].fileFieldName eq 'file1'}">
						<c:set var="fileVO" value="${fileList[x]}"/>
					</c:if>
				</c:forEach>
			</c:if>
			<caption>유로피아나 콘텐츠 관리 등록/수정</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="contNm1">콘텐츠 명</label></th>
					<td><input type="text" id="contNm1" name="contNm1" value="${result.contNm1 }" class="w100p"/></td>
					<td rowspan="3">
						<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 170px;height: 110px;" alt="${fileVO.fileCn}" />
			    		</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="file1">콘텐츠 이미지</label></th>
					<td id="file1">
						<c:if test="${not empty fileVO}">
							<a href="/bos/cmmn/file/fileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
								${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
							</a>
							<a href="#" onclick="delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}', 'file1');" class="btn btn-danger btn-sm">
								<span class="sr-only">${fileVO.orignlFileNm} 삭제</span>
								<i class="fa fa-trash-o" aria-hidden="true"></i>
							</a>
						</c:if>
						<c:if test="${empty fileVO}"><input type="file" id="file1" name="file1" class="input_file form-control" title="콘텐츠 이미지" /></c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="linkUrl1">페이지 URL</label></th>
					<td><input type="text" id="linkUrl1" name="linkUrl1" value="${result.linkUrl1}" class="w100p" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>
</form>
<div class="btnSet">
	<div class="fr" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
		<a href="javascript:reset();" class="btn btn-primary"><span>취소</span></a>
	</div>
</div>

