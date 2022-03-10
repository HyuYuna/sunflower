<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	function delFile(bfidx){
		if (!confirm('파일을 삭제하시겠습니까?')) {
			return;
		}
		$.getJSON(
			"/bos/cmmn/file/deleteFileInfs.json",
			{bfidx : bfidx},
			function(data)
			{
				var jdata = data.resultCode;
	            if( jdata == 'success' ) {
	            	alert("성공적으로 삭제하였습니다.");
	            	$(".fileFormArea").show();
	            	$("#realfile_"+parseInt(bfidx)).html("");
	            	fileNum--;
	            }
	            else alert("삭제에 실패하였습니다.");
			}
		);
	}
	function convert(_atchFileId, _fileSn)
	{
		$("#loading").show();
		$.getJSON(
				"/cmm/dozen/convert.json",
				{atchFileId : _atchFileId, fileSn : _fileSn},
				function(data){
					var _result = data.result;
					var _status = data.status;
					var msg;
					if( _result && _status == '0' ){
						msg = "성공적으로 이미지 변경되었습니다.";
						$("#span"+_fileSn).html(
								"<a href='/cmm/dozen/view.do?atchFileId="+_atchFileId+"&fileSn="+_fileSn+"' target='_blank'>" +
								"빠른보기" +
								"</a>");
					}
					else{
						if( _status == '1' )
							msg = "원본파일 경로가 잘못되었습니다.";
						else if( _status == '2' )
							msg = "파일에 암호가 있어 변환에 실패하였습니다.";
						else if( _status == '3' )
							msg = "파일이 존재하지 않습니다.";
						else if( _status == '4' )
							msg = "적합한 변환기를 찾지 못하였습니다.";
						else if( _status == '5' )
							msg = "잘못된 요청입니다. 연동규격 위반입니다.";
						else if( _status == '6' )
							msg = "PDF 생성에 실패하였습니다. 요청하신 경로에 동일한이름의 PDF가 존재합니다";
						else if( _status == '7' )
							msg = "변환 요청 제한시간이 만료되었습니다. (기본값 : 120초)";
						else if( _status == '8' )
							msg = "라이선스 파일이 존재하지 않거나 만료되었습니다.";
						else if( _status == '9' )
							msg = "알수없는 오류입니다.";
						else if( _status == '99' )
							msg = "저장경로 네트워크 설정이 잘못되었습니다.";
						else
							msg = "이미지 변환에 실패하였습니다.";
						$("#span"+_fileSn).html(
								"<a href=\"javascript:convert('"+_atchFileId+"','"+_fileSn+"');\">" +
								"이미지변환하기" +
								"</a>");
					}
					$("#loading").hide();
					alert(msg);
				}
			);
	}
</script>

<c:if test="${not empty fileList}">
<ul style="list-style-type:none;" class="filelist">
	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<c:set var="ext" value="${fn:toLowerCase(fileVO.bfextension)}" />
		<c:choose>
			<c:when test="${ext eq 'xls' or ext eq 'xlsx'}">
				<c:set var="icn" value="ico_xls" />
			</c:when>
			<c:when test="${ext eq 'hwp'}">
				<c:set var="icn" value="ico_hwp" />
			</c:when>
			<c:when test="${ext eq 'zip' or ext eq 'alz' }">
				<c:set var="icn" value="ico_zip" />
			</c:when>
			<c:when test="${ext eq 'mp4' or ext eq 'mp3' or ext eq 'wmv' } }">
				<c:set var="icn" value="ico_midea" />
			</c:when>
			<c:when test="${ext eq 'pdf'}">
				<c:set var="icn" value="ico_pdf" />
			</c:when>
			<c:when test="${ext eq 'doc' or ext eq 'docx' }">
				<c:set var="icn" value="ico_word" />
			</c:when>
			<c:when test="${ext eq 'ppt' or ext eq 'pptx' }">
				<c:set var="icn" value="ico_ppt" />
			</c:when>
			<c:when test="${ext eq 'jpg' or ext eq 'jpeg' or ext eq 'png' }">
				<c:set var="icn" value="ico_img" />
			</c:when>
			<c:otherwise>
				<c:set var="icn" value="ico_file" />
			</c:otherwise>
		</c:choose>
		<li>
			<%-- <c:if test="${ext == 'jpg' || ext == 'bmp' || ext == 'png' || ext == 'gif'}">
				<img src="${fileVO.imgUrl}" alt="${result.nttSj}"/><br/>
			</c:if> --%>
			<c:choose>
				<c:when test="${updateFlag=='Y' or not empty result.boidx}">
					<div id="realfile_<fmt:parseNumber integerOnly='true' value='${fileVO.bfidx}' />">
					<a href="/bos/cmmn/file/bfFileDown.do?menuNo=${param.menuNo}&bfidx=${fileVO.bfidx }&bffilecode=${param.bid }"  class="${icn}">
						${fileVO.bforiginalfilename} [<fmt:formatNumber value="${fileVO.bffilesize}"/>byte]
					</a>
					<c:if test="${(paramVO.siteName ne 'portal' and fileVO.fileFieldName ne 'thumbImage') or param.updateFlag=='Y'}">
						<button type="button" onclick="delFile('${fileVO.bfidx}');" class="btn btn-danger btn-sm" title="${fileVO.bforiginalfilename} 삭제"> <!-- //LJM -->
							<span class="sr-only">${fileVO.bforiginalfilename} 삭제</span>
							<i class="fa fa-trash-o" aria-hidden="true"></i>
						</button>
					</c:if>
					<c:set var="lFileExtsn" value="${fn:toLowerCase(fileVO.bfextension)}" />
					<c:if test="${lFileExtsn == 'doc' || lFileExtsn == 'docx' || lFileExtsn == 'hwp' || lFileExtsn == 'xls' || lFileExtsn == 'xlsx' || lFileExtsn == 'pdf' || lFileExtsn == 'ppt' || lFileExtsn == 'pptx'}">
					</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<a href="/bos/cmmn/file/bfFileDown.do?menuNo=${param.menuNo}&bfidx=${fileVO.bfidx }&bffilecode=${param.bid }" class="${icn}">
						${fileVO.bforiginalfilename} [<fmt:formatNumber value="${fileVO.fileMg}"/>byte]
					</a>
				</c:otherwise>
			</c:choose>
			<c:if test="${paramVO.bbsId eq 'B0000051'}">[/bos/cmmn/file/fileDown.do?menuNo=${param.menuNo}&atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}]</c:if>
			<c:if test="${paramVO.targetMethod ne 'view' }">
			</c:if>
		</li>
	</c:forEach>
</ul>
</c:if>
<div id="loading" style="display: none"><p><img src="/static/commons/img/ajax-loader.gif" alt="">이미지변환중입니다.</p></div>