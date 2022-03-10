<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>
	<form name="cmUploadFrm" id="cmUploadFrm" enctype="multipart/form-data" method="post" class="pure-form">
		<c:set var="limitFileSize" value="${paramVO.limitFileSize }" />
		<c:set var="limitFileSizeFormat" value="${paramVO.limitFileSizeFormat }" />
		<c:set var="allowFileExt" value="${paramVO.allowFileExt }" />
		<c:set var="fileCnt" value="${empty param.fileCnt ? 5 : param.fileCnt  }" /> <%-- 첨부파일 갯수 --%>
		<c:set var="fileFieldNm" value="${empty param.fileFieldNm ? 'normalFile' : param.fileFieldNm  }" /> <%-- 일반첨부파일 : normalFile , 이미지 첨부파일 : imgFile --%>
		<c:set var="imgAt" value="${empty param.imgAt ? 'N' : param.imgAt  }" /> <%-- 이미지첨부여부 :  Y , N --%>
		<c:if test="${imgAt eq 'Y' }">
			<c:set var="fileFieldNm" value="imgFile" />
		</c:if>
		<c:set var="fileTitle" value="${param.imgAt eq 'Y' ? '이미지' : '첨부파일'  }" />
		
		<input type="hidden" name="width" value="${param.width }" />
		<input type="hidden" name="height" value="${param.height }" />
		
		<input type="hidden" id="cmFileCount" value="0">
		<input type="hidden" name="task" value="ins" />
		<input type="hidden" name="cmFileUploadGroup" id="cmFileUploadGroup" value="${param.subFileGroup }" />
		<input type="hidden" name="cmFileUploadCode" id="cmFileUploadCode" value="${param.subFileCode }" />
		<input type="hidden" name="cmFileUploadCodeSub" id="cmFileUploadCodeSub" value="${userVO.centerCode }" /> <!-- 센터명 -->
		<input type="hidden" name="subFileFolder" id="subFileFolder" value="${param.subFileGroup }"/>
		
		<div class="fileAddSet">
			<table cellpadding="0" cellspacing="0" border="0" class="table01 fileListTable">
				<colgroup>
					<col width="50px;" />
					<col width="" />
					<col width="100px;" />
					<col width="90px;" />
					<col width="130px;" />
					<col width="60px;" />
				</colgroup>
				<tbody>
					<tr style="background-color: #F6F6F6;">
						<td colspan="5" class="ac f_bold">
							파일
							<c:if test="${fileCnt  > 1}">
								<button type="button" class="b-add btn-sm btnFileAdd" style="float:left;">${fileTitle} 추가</button>
							</c:if>
						</td>
						<td class="ac f_bold">메뉴</td>
					</tr>
					<tr class="file_set">
						<td colspan="5" >
							<input name="${fileFieldNm}_1" type="file" id="${fileFieldNm}_1" class="input_file form-control" title="첨부파일 1" />
						</td>
						<td style="text-align: center;">
							<c:if test="${param.fileCnt eq 1 && param.boardFile eq 'Y' }">
								<img id="btnUploadFileOk" style="cursor: pointer;" src="/static/bos/image/btn_add.gif">
							</c:if>
							<c:if test="${param.fileCnt gt 1}">
								<button type="button" id="btn_file_del_1" class="btn btn-sm btn-danger btn_file_del" title="첨부파일 1 삭제">
									<span class="sr-only">${fileTitle} 1 삭제</span>
									<i class="fa fa-trash-o" aria-hidden="true"></i>
								</button>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<table cellpadding="0" cellspacing="0" border="0" class="table01 fileList" id="idUpload_Tr">
			<tr style="background-color: #F6F6F6;">
				<td class="ac f_bold">연번</td>
				<td class="ac f_bold">파일명</td>
				<td class="ac f_bold">파일크기</td>
				<td class="ac f_bold">등록자</td>
				<td class="ac f_bold">파일생성일</td>
				<td class="ac f_bold">메뉴</td>
			</tr>
		</table>
	</form>
</div>

<script>
//<![CDATA[
	//첨부파일 처리 영역
	$(function() {
		var fileSaveSuccessAfterUrl = "${param.afterUrl}";

		var article_fileupload = {
			getIsVaildUpload : function(){
				if($('#normalFile_1').val() == "" ){
					article_fileupload.setMessage("첨부파일을 선택해 주세요!");
					$('#normalFile_1').focus();
					return false;
				}
				return true;
			},
			setFileList:function(txtType){
				var fileUploadGroup = $('#cmFileUploadGroup').val();
				var fileUploadCode = $('#cmFileUploadCode').val();
				var fileUploadCodeSub = $('#cmFileUploadCodeSub').val();
				var jsonfilename = '/bos/cmmn/file/fileUploadList.json'; //
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
						
						var fileList = data.fileList;
						
						if(fileList != ""){
							//data 를 탐색 : each() 메서드를 사용해서 데이터가 있는만큼 반복A
							$.each(fileList, function(index, entry) {
								txtTr = "";
								txtTr += "<tr class='clsUpload_Tr' style='background-color:#D4F4FA'>";
								txtTr += "<td style='text-align:center;'>"+ (index+1) +"</td>";
								txtTr += "<td style='text-align:left;'>" + "<a href='#' onclick='javascript:fnFileDownloadAfterAlert("+ entry.uflSeq +", "+ entry.uflFilesize +", ${param.menuNo}, ${param.subFileCode});'>"
									+"<img src=/static/bos/image/boardManagement/images/fileIcon/"+entry.uflFilenameExtension.toLowerCase()+".gif border='0' align='absmiddle'> " + entry.uflFilenameOriginal +"</a>"+"</td>";
								txtTr += "<td style='text-align:right;'>" + ekrFileSizeConvert(entry.uflFilesize) + "</td>";
								txtTr += "<td style='text-align:center;'>" + entry.uflCuserNm + "</td>";
								txtTr += "<td style='text-align:center;'>" + entry.uflDate + "</td>";
								txtTr += "<td style='text-align:center;'><img src='/static/bos/image/boardManagement/images/btn_file_del.gif' class='btnFileDeleteOk' id='btnFileDeleteOk_"+entry.uflSeq+"' style='cursor:pointer;'></td>";
								txtTr += "</tr>";
	
								fileCount++;
	
								txtElement.append(txtTr);
								$('#cmFileCount').val(fileCount);
							});
						}
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
								txtTr += "<td>" + "<a href='#' onclick='javascript:fnFileDownloadAfterAlert("+ entry.uflSeq +", "+ entry.uflFilesize +", ${param.menuNo});'>"
											+"<img src=/static/bos/image/boardManagement/images/fileIcon/"+entry.uflFilenameExtension+".gif border='0' align='absmiddle'> " + entry.uflFilenameOriginal+"</a>"+"</td>";
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
			goFileDeletePate : function(uflSeq){					// @ 일반 텍스트 정보 보내기
				msgjs = "첨부파일을 삭제 하시겠습니까?";
				if(confirm(msgjs)){
					$.getJSON(
						"/bos/cmmn/file/fileUploadDelete.json",
						{uflSeq:uflSeq},
						function(data) {
							//alert(data.resultCode);
							var jdata = data.resultCode;
							if( jdata == 'true' ) {
								alert("성공적으로 삭제하였습니다.");
								article_fileupload.setFileList();
								$(".btnFileAdd").show();
							}
							else alert("삭제에 실패하였습니다.");
						}
					);
				}
			},
			setMessage:function(messageString){							//@ 에러 메세지 삽입
				alert(messageString);
			}
		};
		
		var options = {
			beforeSubmit	: showRequest,  // pre-submit callback
			success			: showResponse,  // post-submit callback
			url				: '/bos/board/board/fileUpload.json',
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
					} else{
						$('#btnUploadFileOk').show(); //입력버튼 보여짐
						return false;
					}
			} else{
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
		
		article_fileupload.setFileList('');

		$( document ).on( "click", ".btnFileDeleteOk", function() {
			var bfIdx = $(this).attr('id').replace('btnFileDeleteOk_','');
			article_fileupload.goFileDeletePate(bfIdx);
		});
		
		$('#btnUploadFileOk').click(function(){							// @ 첨부파일 저장
            jQuery("#cmUploadFrm").ajaxSubmit(options);
        });
		
		var fileCnt = parseInt('${fileCnt}"');
		var currFileCnt = $(".fileList").find("tr").length - 1;
	    //var currFileCnt = fileCount;
	    fileCnt = fileCnt - currFileCnt;
	    
	    if (fileCnt == 0) {
			$(".btnFileAdd").hide();
			
	    }
	    var fileNum = 1;
	    console.log(fileNum);
	    
		$(".btnFileAdd").on('click',function() {
			if (fileCnt == fileNum) {
				alert("첨부파일은 최대 ${fileCnt}개입니다.");
				return false;
			}
			fileNum++;
		    console.log(fileNum);
			
			var $parentTable = $(".fileListTable");
			var $tmpTr = $parentTable.find(".file_set:first").clone();
			$tmpTr.find("input[name^=${fileFieldNm}]").val("");
			$tmpTr.appendTo($parentTable);
			
			$parentTable.find(".file_set").each(function(n) {
				var $this = $(this);
				var num = n+1;
				$this.find("input[name^=${fileFieldNm}_]:first").attr({title : "첨부파일 " + num , name : "${fileFieldNm}_"+num, id : "${fileFieldNm}_"+num});
				$this.find(".btn_file_del").attr({title : "첨부파일 " + num+ " 삭제", id : "btn_file_del_"+num});
				$this.find(".sr-only").text("첨부파일 "+num+" 삭제");
			});
			return false;
		});

		$(".fileListTable").on("click",".btn_file_del",function() {
			if (fileNum == 1) {
				$(this).prev().val("");
				//alert("1개 일 경우 삭제 하실 수 없습니다.");
				return false;
			}

			fileNum--;
		    console.log(fileNum);
			$(this).closest(".file_set").remove();

			var $parentTable = $(".fileListTable");
			$parentTable.find(".file_set").each(function(n) {
				var $this = $(this);
				var num = n+1;
				$this.find("input[name^=${fileFieldNm}]:first").attr({title : "첨부파일 " + num , name : "${fileFieldNm}_"+num, id : "${fileFieldNm}_"+num});
				$this.find(".btn_file_del").attr({title : "첨부파일 " + num+ " 삭제", id : "btn_file_del_"+num});
				$this.find(".sr-only").text("첨부파일 "+num+" 삭제");
			});
		});

		$(".fileAddSet").on("input[type=file]","change",function() {
			var input = $(this)[0];
			var $this = $(this);
			var fileNm = $this.val();
			if (fileNm == "") return false;

			var fileExt = fileNm.substring(fileNm.lastIndexOf(".")+1,fileNm.length).toLowerCase();
			var limitFileSize = "${limitFileSize}";
			var allowFileExts = "${allowFileExt}";
			var limitFileSizeFormat = "${limitFileSizeFormat}";
			allowExtArr = allowFileExts.split(",");
			//var allowExtArr = ["gif","jpg","jpeg","png"];

			if ($.inArray(fileExt, allowExtArr) == -1) {
				alert("허용된 파일만 첨부가 가능합니다. (" + allowFileExts + ")");
				$this.val("");
				$this.focus();
				return false;
			}

			else if (input.files && input.files[0]) {
				if (input.files[0].size > Number(limitFileSize)){
					alert( limitFileSizeFormat + "를 초과하여 등록할 수 없습니다.");
					$this.val("");
					$this.focus();
					return false;
				}
			}
			return false;
		});
	});
//]]>
</script>