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
	<c:set var="task" value="ins"/>
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
	<c:set var="task" value="upd"/>
</c:if>

<c:if test="${paramVO.sAdminAuth eq 'Y' }">
	<c:set var="boname" value="${paramVO.sUserAdminName }"/>
</c:if>
<c:if test="${paramVO.sAdminAuth ne 'Y' }">
	<c:set var="boname" value="${userVO.userNm }"/>
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>


<script>
$(function() {
	$(".pure-button").click(function(event){
		event.preventDefault();
	});
	
	//########################## Method ##########################
	var article = {
		setContentSend : function() { // @ 일반 텍스트 정보 보내기
			if (article.getIsVaild() == true) {
				msgjs = "작성한 글을 저장 하시겠습니까?";
				if (confirm(msgjs)) {
					//공지사항 체크 여부 확인 (미체크시 날짜 등록X), 날짜 미지정시 null
					if ($('input[name=bonoticeisuse]:checked').val() != "1") {
						$("#bonoticestartdate").attr("disabled", true);
						$("#bonoticeenddate").attr("disabled", true);
					} else {
						if($("#bonoticestartdate").val() == ''){
							$("#bonoticestartdate").attr("disabled", true);
						}
						if($("#bonoticeenddate").val() == ''){
							$("#bonoticeenddate").attr("disabled", true);
						}
					}
						
					$("#frm").submit();
				} else {
					return false;
				}
			}
		},
		getIsVaild : function() { //@ 유효성 검사
			// 이름 체크
			if ($('#boname').val() == "") {
				article.setMessage("이름은 입력 필수사항입니다.");
				$('#boname').focus();
				return false;
			}

			// 필독기능 사용시
			if ($('input[name=bonoticeisuse]:checked').val() == "1") {
				if ($('#bonoticestartdate').val() != "" && $('#bonoticeenddate').val() == "") {
					article.setMessage("기간 마지막일을 입력해 주세요!");
					return false;
				} else if ($('#bonoticestartdate').val() == "" && $('#bonoticeenddate').val() != "") {
					article.setMessage("기간 시작일을 입력해 주세요!");
					return false;
				}
			}

			if ($('#abcsubdivisionoptionisuse').val() == "1") { //하위분류옵션 체크
				if ($('#bosoidx').val() == "") {
					article.setMessage("하위분류옵션은 입력 필수사항입니다.");
					$('#bosoidx').focus();
					return false;
				}
			}

			// 제목 체크
			if ($('#botitle').val() == "") {
				article.setMessage("제목은 입력 필수사항입니다.");
				$('#botitle').focus();
				return false;
			}
			
			// 내용
			if (oEditors.getById["bocontents"].getIR() == "<p><br></p>") {
				article.setMessage("내용은 입력 필수사항입니다.");
				oEditors.getById["bocontents"].exec("FOCUS", []);
				return false;
			}

			document.getElementById("bocontents").value = oEditors.getById["bocontents"].getIR();

			if ($('#abcpasswordisuse').val() == "1") {
				// 암호 체크
				if ($('#bopassword').val() == "") {
					article.setMessage("암호는 입력 필수사항입니다.");
					$('#bopassword').focus();
					return false;
				}
			}

			return true;
		},
		setMessage : function(messageString) { //@ 에러 메세지 삽입
			alert(messageString);
		},
		goListPate : function() {
			var reqUrl = '/bos/bbs/${paramVO.bbsId}/list.do?';
			var params = '${pageQueryString}';
			
			location.href = reqUrl + params;
		},
		goViewPate : function() {
			var reqUrl = '/bos/bbs/${paramVO.bbsId}/view.do?boidx=' + $("#boidx").val();
			var params = '&${pageQueryString}';
			
			location.href = reqUrl + params;
		},
		getIsVaildUpload : function() {
			if ($('#uploadFile').val() == "") {
				article.setMessage("첨부파일을 선택해 주세요!");
				$('#uploadFile').focus();
				return false;
			}
			return true;
		},
		setFileList : function() {
			var bfboidx = $('#boidx').val();
			var bffilecode = $('#bid').val();
			var jsonfilename = '/bos/bbs/${paramVO.bbsId}/getFileList.json'; //
			var params = {
				"bfboidx" : bfboidx,
				"bffilecode" : bffilecode
			};
			var txtTr = "";
			var task = $('#task').val();
			var bfExtension = "";
			
			$.ajax({
				url: "/bos/bbs/${paramVO.bbsId}/getFileList.json",
				type: "get",
				data: {
					"bfboidx" : bfboidx,
					"bffilecode" : bffilecode
				},
				success: function(data) {
					var txtElement = $("#idUpload_Tr:last");
					$('#idUpload_Tr .clsUpload_Tr').remove();
					
					var fileList = data.fileList;
					
					if(fileList != ""){
						$.each(fileList, function(index, entry) {
							txtTr = "";
							txtTr += "<tr class='clsUpload_Tr' style='background-color:#D4F4FA'>";
							txtTr += "<td>" + "<a href='/bbs/userSite/downloadFileSaved.asp?bfIdx=" + entry.bfidx + "'>"
									+ "<img src='/static/bos/image/fileIcon/"+entry.bfextension+".gif' border='0' align='absmiddle'> "
									+ entry.bforiginalfilename + fileSizeConvert(entry.bffilesize) + "</a>" + "</td>";
							if (entry.bfisinsertview == "Y") {
								txtTr += "<td class='ac'><img src='/static/bos/image/SealOk.png'></td>";
							} else {
								txtTr += "<td class='ac'><img src='/static/bos/image/SealNo.png'></td>";
							} 
							if (entry.bfisdownload == "Y") {
								txtTr += "<td class='ac'><img src='/static/bos/image/SealOk.png'></td>";
							} else {
								txtTr += "<td class='ac'><img src='/static/bos/image/SealNo.png'></td>";
							}
							txtTr += "<td><img src='/static/bos/image/btn_file_del.gif' class='btnDeleteOk' id='btnDeleteOk_"+ entry.bfidx +"' style='cursor:pointer;'></td>";
							txtTr += "<tr>";

							txtElement.append(txtTr);
						})
					}
				}
			});
		},
		goDeletePate : function(bfIdx) { // @ 일반 텍스트 정보 보내기
			msgjs = "첨부파일을 삭제 하시겠습니까?";
			if (confirm(msgjs)) {
				var params = {"bfIdx" : bfIdx};
				var reqUrl = '/bbs/userSite/setFileDelete.asp';
				var returnMsg = jQuery.parseJSON(jQuery.ajax({
					url : reqUrl,
					type : 'post',
					data : params,
					async : false
				}).responseText);
				if (returnMsg.srtIsSuccess == "true") {
					//article.setMessage('성공적으로 처리되었습니다.');
					$('#uploadFile').val('');
					$('#btnUploadFileOk').show(); //입력버튼 보여짐
					article.setFileList();
					return true;
				} else {
					article.setMessage('주의! 정상적으로 처리되지 않았습니다. \n 다시 시도해 주세요!');
					return false;
				}
			}
		}
	}

	var options = {
		beforeSubmit : showRequest, // pre-submit callback
		success : showResponse, // post-submit callback
		url : '/bbs/userSite/fileUpload_exec.asp',
		dataType : 'json',
		type : 'post'
	};

	function showRequest(formData, jqForm, options) {
		var queryString = jQuery.param(formData);
		if (article.getIsVaildUpload() == true) { // 전송 전 유효성 체크
			msgjs = "선택하신 첨부파일을 추가 하시겠습니까?";
			if (confirm(msgjs)) {
				$('#btnUploadFileOk').hide(); //입력버튼 보여짐
				$('#loadingImage').show();
				return true;
			} else {
				$('#btnUploadFileOk').show(); //입력버튼 보여짐
				return false;
			}
		} else {
			return false;
		}
	};
		
	function showResponse(data) { // @ 전송 후 처리
		if (data.srtIsSuccess == "true") {
			//article.setMessage('성공적으로 처리되었습니다.');
			var bfExtension = data.bfExtension;
			var bfIsInsertView = data.bfIsInsertView;
			if (bfIsInsertView == "Y" 
				&& (bfExtension.toLowerCase() == "jpg" 
				|| bfExtension.toLowerCase() == "gif" 
				|| bfExtension.toLowerCase() == "bmp" 
				|| bfExtension.toLowerCase() == "png")) {
				setImageValue(data.bfFileName, data.bfImageWidth);
			}
			article.setFileList();
			$('#uploadFile').val('');
			//$("#bfIsInsertView").attr('checked', true)
			//$("#bfUploadFolder").attr('checked', false)
			$('#btnUploadFileOk').show(); //입력버튼 보여짐
			$('#loadingImage').hide();
			return true;
		} else {
			article.setMessage('주의! 정상적으로 처리되지 않았습니다. \n 다시 시도해 주세요!');
			$('#btnUploadFileOk').show(); //입력버튼 보여짐
			return false;
		}
	};

	//########################## Click Event ##########################

	article.setFileList();

	$('#btnCreateOk').click(function() {
		article.setContentSend();
	});

	$('#btnUploadFileOk').click(function() { // @ 일반 게시판 저장시
		jQuery("#uploadFrm").ajaxSubmit(options);
	});

	$('#btnList').click(function() {
		article.goListPate();
	});

	$('#btnView').click(function() {
		article.goViewPate();
	});

	$("input[name=bonoticeisuse]:checkbox").click(function() {
		if ($(this).is(':checked')) {
			$('#noticeShowHide').show();
		} else {
			$('#noticeShowHide').hide();
			$('#boNoticeStartDate').val('');
			$('#boNoticeEndDate').val('');
		}
	});

	$(document).on("click", ".btnDeleteOk", function() {
		var bfIdx = $(this).attr('id').replace('btnDeleteOk_', '');
		article.goDeletePate(bfIdx);
	});

	var aData1 = $("#bonoticestartdate, #bonoticeenddate").datepicker({ //
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		//defaultDate: "+1w",
		dateFormat : 'yy-mm-dd',
		prevText : '이전달',
		nextText : '다음달',
		changeMonth : true,
		changeYear : true,
		showMonthAfterYear : true,
		yearRange : "1950:",
		onSelect : function(selectedDate) {
			var option = this.id == "bonoticestartdate" ? "minDate" : "maxDate",
				instance = $(this).data("datepicker"),
				date = $.datepicker.parseDate(instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings);
			aData1.not(this).datepicker("option", option, date);
		}
	});

	var aData2 = $("#bostartreservedate, #bolastreservedate").datepicker({ //
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월',
				'6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		//defaultDate: "+1w",
		dateFormat : 'yy-mm-dd',
		prevText : '이전달',
		nextText : '다음달',
		changeMonth : true,
		changeYear : true,
		showMonthAfterYear : true,
		onSelect : function(selectedDate) {
			var option = this.id == "bostartreservedate" ? "minDate" : "maxDate",
				instance = $(this).data("datepicker"),
				date = $.datepicker.parseDate(instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			aData2.not(this).datepicker("option", option, date);
		}
	});
});
</script>

<!-- 암호 사용 여부 -->
<input type="hidden" name="abcpasswordisuse" id="abcpasswordisuse" value="${category.abcpasswordisuse}">
<input type="hidden" name="abcsubdivisionoptionisuse" id="abcsubdivisionoptionisuse" value="${category.abcsubdivisionoptionisuse }">

<form id="frm" name="frm" method="post" enctype="multipart/form-data" action="${action}" class="pure-form">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="boidx" id="boidx" value="<fmt:parseNumber integerOnly='true' value='${empty result.boidx ? 0 : result.boidx }' />" />
	<input type="hidden" name="bid" id="bid" value="${paramVO.bid }" />
	<input type="hidden" name="atchFileId"id="atchFileId"  value="${result.atchFileId}">
	<input type="hidden" name="htmlAt" value="${result.htmlAt}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="task" value="${task}"/>

	<table cellpadding="0" cellspacing="0" border="0" class="boardWrite" style="width:100%">
		<colgroup>
			<col width="13%">
			<col width="37%">
			<col width="13%">
			<col width="37%">
		</colgroup>
		<thead>
		</thead>
		<tbody>
			<tr>
				<th><label for="boname">이름</label></th>
				<td style="padding-left:12px;" colspan="3">
					<input type="text" name="boname" id="boname" value="${empty result ? boname : result.boname}" ${paramVO.sAdminAuth eq 'Y' ? '' : 'readonly="readonly"' } style="width:160px"/>
				</td>
			</tr>
			<c:if test="${category.abcabkdidx eq '1' && paramVO.sAdminAuth eq 'Y' }">
				<tr>
					<th>필독여부</th>
					<td style="padding-left:12px;" colspan="3">
						<input type="checkbox" id="bonoticeisuse" name="bonoticeisuse" value="1" <c:if test="${result.nttType eq '1'}"> checked</c:if> /><label for="bonoticeisuse"> 필독사용</label>
						<span id="noticeShowHide" ${result.nttType eq '1' ? '' : 'style="display:none;"'}>
							[<strong>기간</strong> : 
							<input id="bonoticestartdate" name="bonoticestartdate" value="<fmt:formatDate value='${result.bonoticestartdate}' pattern='yyyy-MM-dd'/>" 
							readonly="readonly" type="text" class="inactive" title="게시시작일" readonly />
							~
							<input id="bonoticeenddate" name="bonoticeenddate" value="<fmt:formatDate value='${result.bonoticeenddate}' pattern='yyyy-MM-dd'/>" 
							readonly="readonly" type="text" class="inactive" title="게시종료일" readonly />
							] 기간설정시 이 기간 후에는 일반글로 됨
						</span>
					</td>
				</tr>
			</c:if>
			<c:if test="${category.abcsubdivisionoptionisuse eq '1'}">
				<input type="hidden" name="abcsubdivisionoptionisuse" id="abcsubdivisionoptionisuse" value="${category.abcsubdivisionoptionisuse }"/>
				<tr>
					<th>하위분류</th>
					<td style="padding-left:12px" colspan="3">
						<select name="bosoidx" id="bosoidx" style="width:162px" >
								<option value="">선택</option>
								<c:forEach var="code" items="${codeList}" varStatus="status">
									<option value="${code.cmname }">${code.cmtitle }</option>
								</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			<c:if test="${category.abcsecretisuse eq '1'}">
				<tr>
					<th>옵션</th>
					<td style="padding-left:12px" colspan="3">
						<input type="checkbox" class="c_border" name="boissecret" id="boissecret" value="1" ${result.boissecret eq '1' ? 'checked' : ''}> 비밀글
					</td>
				</tr>
			</c:if>
			<tr>
				<th><label for="botitle">게시물제목</label></th>
				<td colspan="3" style="padding-left:12px;">
					<input type="text" name="botitle" id="botitle" class="input_03" value="${result.botitle}" style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="" style="padding-left:0;padding-top:2px;padding-right:0;border-left-style:none;border-right-style:none;border-bottom-style:none;">
					<textarea id="bocontents" name="bocontents" rows="30" hidden style="display:none;" class="textarea">
						<c:if test="${empty result && paramVO.bbsId eq 'B0000005'}"><util:out escapeXml="false"><strong><span style='color: rgb(255, 0, 0);'>※ 문의글 작성 시 피해자 개인정보가 노출되지 않도록 유의하여 주시기 바랍니다.</span></strong><p><br/></p><p><br/></p></util:out></c:if>
						<c:if test="${not empty result }"><util:out escapeXml="false">${result.bocontents}</util:out></c:if>
					</textarea>
					<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
				</td>
			</tr>
			<c:if test="${category.abcabkidx eq '3' }">
				<tr>
					<th>일정기간</th>
					<td colspan="3"  style="padding-left:12px" >
						<input type="text" name = "bostartreservedate"  id="bostartreservedate" style="width:80px;text-align:center" ReadOnly  class="inactive" value="${result.bostartreservedate }" onClick="javascript:return false;">
						~
						<input type="text" name = "bolastreservedate"  id="bolastreservedate" style="width:80px;text-align:center" ReadOnly class="inactive" value="${result.bolastreservedate}" onClick="javascript:return false;">
						이 기간동안 아래 같은 시간이 모두 표시됩니다.
					</td>
				</tr>
				<tr>
					<th>시간</th>
					<td colspan="3"  style="padding-left:12px" >
						<input type="text" name = "bostartreservetime"  id="bostartreservetime" style="width:80px;text-align:center" class="" value="${result.bostartreservetime}" >
						~
						<input type="text" name = "bolastreservetime"  id="bolastreservetime" style="width:80px;text-align:center" class="" value="${result.bolastreservetime}" >
					</td>
				</tr>
			</c:if>
			<c:if test="${category.abcpasswordisuse eq '1' }">
				<tr class="abcReplyIsUse">
					<th>비밀번호</th>
					<td colspan="3" style="padding-left:12px">
						<input type="password" class="input_file" name="bopassword"  id="bopassword"  value="${result.bopassword }"> 글수정 및 삭제시 필요
					</td>
				</tr>
			</c:if>
			<tr>
				<th>첨부파일</th>
				<td colspan="3" style="padding-left:12px">
					<c:if test="${not empty fileList}">
						<dl>
							<dd>
								<jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" />
							</dd>
						</dl>
					</c:if>
					<dl class="fileFormArea">
						<dd>
							<jsp:include page="/WEB-INF/jsp/bos/share/incFileSubmit.jsp" flush="true">
								<jsp:param value="5" name="fileCnt" />
							</jsp:include>
						</dd>
					</dl>
				</td>
			</tr>
		</tbody>
	</table>
	
	<%-- <input type="hidden" name="bfuploadfolder" id="bfuploadfolder" value="board">
	<input type="hidden" name="abcmaxfilelen" id="abcmaxfilelen" value="${category.abcmaxfilelen }"/>
	
	<table cellpadding="0" cellspacing="0" border="0" class="table01 ${category.abcpasswordisuse eq '1' ? 'mt10' : ''}" id="idUpload_Tr">
		<colgroup>
			<col width="" />
			<col width="84px;" />
			<col width="84px;" />
			<col width="60px;" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="4">첨부파일을 첨부하시려면 아래 [<span class="f_red">첨부</span>]버튼을 클릭해 주세요!</th>
			</tr>
			<tr style="background-color: #F6F6F6;">
				<td class="ac f_bold">파일</td>
				<td class="ac f_bold">이미지등<br />본문삽입</td>
				<td class="ac f_bold">다운로드<br />가능</td>
				<td class="ac f_bold">메뉴</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<img id="loadingImage" src="/static/bos/image/loading_small.gif" style="display: none;">
					<input type="file" name="uploadFile" id="uploadFile" style="width: 90%; height: 26px">
				</td>
				<td class="ac"><input type="checkbox" name="bfIsInsertView" class="clear" value="Y" checked /></td>
				<td class="ac"><input type="checkbox" name="bfIsDownload" class="clear" value="Y" checked /></td>
				<td><img id="btnUploadFileOk" style="cursor: pointer;" src="/static/bos/image/btn_add.gif"></td>
			</tr>
		</tbody>
	</table> --%>
</form>

<%-- <form name="uploadFrm" id="uploadFrm" enctype="multipart/form-data" method="post" class="pure-form">

	
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
</form> --%>

<div class="mt10 ac">
	<button id="btnCreateOk" class="showHide_write pure-button pure-button-save" style="height:36px;"><span class="f_bold">저장</span></button>
	<c:if test="${not empty result }">
		<button id="btnView" class="showHide_write pure-button pure-button-print" style="height:36px;"><span class="f_bold">상세페이지</span></button>
	</c:if>
	<button id="btnList" class="pure-button pure-button-list" style="height:36px;"><span class="f_bold">목록</span></button>
</div>