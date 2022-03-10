<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="subFileGroup" value="${param.subFileGroup }"/>
<c:set var="subFileCode" value="${param.subFileCode }"/>
<c:set var="subFilecodeSub" value="${param.subFilecodeSub }"/>
<c:set var="subFileFolder" value="${param.subFileFolder }"/>

<div>
	<table cellpadding="0" cellspacing="0" border="0" class="table01" id="idUpload_View">
		<colgroup>
			<col width="" />
			<col width="110px;" />
			<col width="90px;" />
			<col width="130px;" />
		</colgroup>
		<tbody>
			<tr style="background-color: #F6F6F6;">
				<td class="ac f_bold">파일명</td>
				<td class="ac f_bold">파일크기</td>
				<td class="ac f_bold">파일생성자</td>
				<td class="ac f_bold">파일생성일</td>
			</tr>
		</tbody>
	</table>
</div>

<script>
//첨부파일 처리 영역
jQuery(document).ready(function(){
	var fileSaveSuccessAfterUrl = "/bos/board/board/view.do?${pageQueryString}";

	var article_fileupload = {
		getIsVaildUpload : function(){
			if($('#cmUploadFile_file').val() == "" ){
				article_fileupload.setMessage("첨부파일을 선택해 주세요!");
				$('#cmUploadFile_file').focus();
				return false;
			}
			return true;
		},
		setFileList:function(txtType){
			var fileUploadGroup = $('#cmFileUploadGroup').val();
			var fileUploadCode = $('#cmFileUploadCode').val();
			var fileUploadCodeSub = $('#cmFileUploadCodeSub').val();
			var jsonfilename = '/bos/file/ekrFileMng/fileUploadList.json'; //
			var params = {"fileUploadCode":fileUploadCode, "fileUploadCodeSub":fileUploadCodeSub, "fileUploadGroup":fileUploadGroup};
			var txtTr="";
			var bfExtension = "";
			var fileCount = 0;
			
			$.ajax({
				url: jsonfilename,
				data : params,
				cache: false,
				dataType: "json",
				success: function(data) {
					var txtElement = $("#idUpload_Tr:last");
					$('#idUpload_Tr .clsUpload_Tr').remove();
					//data 를 탐색 : each() 메서드를 사용해서 데이터가 있는만큼 반복A
					$.each(data, function(index, entry) {
						txtTr = "";
						txtTr += "<tr class='clsUpload_Tr' style='background-color:#D4F4FA'>";
						txtTr += "<td style='text-align:center;'>"+ (index+1) +"</td>";
						txtTr += "<td style='text-align:left;'>" + "<a href='#' onclick='javascript:fnFileDownloadAfterAlert("+ entry["UFL_SEQ"] +", "+ entry["UFL_FILESIZE"] +");'>"+"<img src=/boardManagement/images/fileIcon/"+entry["UFL_FILENAME_EXTENSION"]+".gif border='0' align='absmiddle'> " + entry["UFL_FILENAME_ORIGINAL"]+"</a>"+"</td>";
						txtTr += "<td style='text-align:right;'>" + ekrFileSizeConvert(entry["UFL_FILESIZE"]) + "</td>";
						txtTr += "<td style='text-align:center;'>" + entry["UFL_CUSER_NM"] + "</td>";
						txtTr += "<td style='text-align:center;'>" + entry["UFL_DATE"] + "</td>";
						txtTr += "<td><img src='/boardManagement/images/btn_file_del.gif' class='btnFileDeleteOk' id='btnFileDeleteOk_"+entry["UFL_SEQ"]+"' style='cursor:pointer;'></td>";
						txtTr += "</tr>";

						fileCount++;

						txtElement.append(txtTr);
						$('#cmFileCount').val(fileCount);
					});
				},
				error: function (request, status, error) { alert(status + ", " + error); }
			});
		},
		getFileList:function(txtType){
			var fileUploadGroup = '${subFileGroup}';
			var fileUploadCode = '${subFileCode}';
			var fileUploadCodeSub = '';
			var jsonfilename = '/bos/cmmn/file/fileUploadList.json';
			var params = {"fileUploadGroup":fileUploadGroup,"fileUploadCode":fileUploadCode,"fileUploadCodeSub":fileUploadCodeSub};
			var txtTr="";
			var bfExtension = "";
			var fileCount = 0;
			
			$.ajax({
				url: jsonfilename,
				data : params,
				cache: false,
				dataType: "json",
				success: function(data) {
					var txtElement = $("#idUpload_View:last");
					$('#idUpload_View .clsUpload_Tr').remove();
					
					var fileList = data.fileList;
					
					if(fileList != ""){
						//data 를 탐색 : each() 메서드를 사용해서 데이터가 있는만큼 반복A
						$.each(fileList, function(index, entry) {
							txtTr = "";
							txtTr += "<tr class='clsUpload_Tr' style='background-color:#D4F4FA'>";
							txtTr += "<td>" + "<a href='#' onclick='javascript:fnFileDownloadAfterAlert("+ entry.uflSeq +", "+ entry.uflFilesize +", ${param.menuNo}, ${param.subFileCode});'>"
										+"<img src=/static/bos/image/boardManagement/images/fileIcon/"+entry.uflFilenameExtension.toLowerCase()+".gif border='0' align='absmiddle'> " + entry.uflFilenameOriginal+"</a>"+"</td>";
							txtTr += "<td style='text-align:right;'>" + ekrFileSizeConvert(entry.uflFilesize) + "</td>";
							txtTr += "<td style='text-align:center;'>" + entry.uflCuserNm + "</td>";
							txtTr += "<td style='text-align:center;'>" + entry.uflDate + "</td>";
							txtTr += "</tr>";
	
							fileCount++;
	
							txtElement.append(txtTr);
							$('#cmFileCount').val(fileCount);
						});
					}
					if (fileCount<1) {
						$('#idUpload_View').hide();
					}
				},
				error: function (request, status, error) { alert(status + ", " + error); }
			});
		},
		goFileDeletePate : function(UFL_SEQ){					// @ 일반 텍스트 정보 보내기
			msgjs = "첨부파일을 삭제 하시겠습니까?";
			if(confirm(msgjs)){
				var url = '/commonEkr/file/fileUpload_delete.asp';
				var param = { "UFL_SEQ":UFL_SEQ };
				$.post( url, param, function(data){
					if(data.resultCode=="success") {
						article_fileupload.setFileList();
					}
					alert(data.resultMessage);
				}, "json");
			}
		},
		setMessage:function(messageString){							//@ 에러 메세지 삽입
			alert(messageString);
		}
	};

var options = {
    beforeSubmit	: showRequest,  // pre-submit callback
    success			: showResponse,  // post-submit callback
    url				: '/commonEkr/file/fileUpload_run.asp?BDD_SEQ=${subFileCode}&SUB_CODE=${subFileCodeSub}&fileUpLoadFolder=${subFileFolder}',
    dataType		: 'json',
    type			: 'post'
};

function showRequest(formData, jqForm, options) {
    var queryString = jQuery.param(formData);
    if (article_fileupload.getIsVaildUpload() == true){	// 전송 전 유효성 체크
        msgjs = "선택하신 첨부파일을 추가 하시겠습니까?";
        if(confirm(msgjs)) {
            $('#btnUploadFileOk').hide(); //입력버튼 보여짐
            $('#loadingImage').show();
            return true;
        }
        else{
            $('#btnUploadFileOk').show(); //입력버튼 보여짐
            return false;
        }
    }
    else{
        return false;
    }
};

	function showResponse(data)  { 										// @ 전송 후 처리
	    if (data.srtIsSuccess == "true") {
	
	        if(fileSaveSuccessAfterUrl.length>1) {
	            location.href=fileSaveSuccessAfterUrl;
	        } else {
	
	            //article_fileupload.setMessage('성공적으로 처리되었습니다.');
	            article_fileupload.setFileList('new');
	            $('#cmUploadFile_file').replaceWith($('#cmUploadFile_file').clone(true) );
	            $('#cmUploadFile_file').val('');
	
	            /*
	            if(ekrJs.isMsie()) {
	                $('#cmUploadFile_file').replaceWith($('#cmUploadFile_file').clone(true) );
	            }
	            // other Browser..
	            else {
	                $('#cmUploadFile_file').val('');
	            }
	            */
	
	            $('#btnUploadFileOk').show(); //입력버튼 보여짐
	            $('#loadingImage').hide();
	
	            return true;
	
	        }
	
	    }else{
	        article_fileupload.setMessage('주의! 정상적으로 처리되지 않았습니다. \n 다시 시도해 주세요!');
	        $('#btnUploadFileOk').show(); //입력버튼 보여짐
	        $('#loadingImage').hide();
	        return false;
	    }
	}
	
	article_fileupload.getFileList('');
});
</script>