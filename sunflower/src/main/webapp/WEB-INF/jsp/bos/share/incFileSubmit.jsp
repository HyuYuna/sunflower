<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<input type="hidden" name="bfuploadfolder" id="bfuploadfolder" value="board">

<div class="fileAddSet">
	<c:if test="${fileCnt  > 1}">
		<div class="row">
			<div class="col-sm-2">
			<button type="button" class="b-add btn-sm btnFileAdd">${fileTitle} 추가</button>
			</div>
			<div class="col-sm-10 fileList">
	</c:if>
			<div class="file_set">
				<div class="form-inline">
					<input name="${fileFieldNm}_1" type="file" id="${fileFieldNm}_1" class="input_file form-control" title="첨부파일 1" style="height:35px;" />
					<c:if test="${param.fileCnt gt 1}">
					<button type="button" id="btn_file_del_1" class="btn btn-sm btn-danger btn_file_del" title="첨부파일 1 삭제">
						<span class="sr-only">${fileTitle} 1 삭제</span>
						<i class="fa fa-trash-o" aria-hidden="true"></i>
					</button>
					</c:if>
				</div>
			</div>
	<c:if test="${fileCnt  > 1}">
			</div>
		</div>
	</c:if>
</div>

<script>
//<![CDATA[
    var fileCnt = parseInt('${fileCnt}"');
    var currFileCnt = $(".filelist").find("li").length;
    fileCnt = fileCnt - currFileCnt;
    if (fileCnt == 0) {
		$(".fileFormArea").hide();

    }
    var fileNum = 1;
	$(".btnFileAdd").on('click',function() {
		if (fileCnt == fileNum) {
			alert("첨부파일은 최대 ${fileCnt}개입니다.");
			return false;
		}
		fileNum++;
		var $parentDiv = $(".fileList");
		var $tmpDiv = $parentDiv.find(".file_set:first").clone();
		$tmpDiv.find("input[name^=${fileFieldNm}]").val("");
		$tmpDiv.find("input[name^=fileCn_${fileFieldNm}]").val("");
		$tmpDiv.appendTo($parentDiv);

		$parentDiv.find(".file_set").each(function(n) {
			var $this = $(this);
			var num = n+1;
			$this.find("input[name^=${fileFieldNm}_]:first").attr({title : "첨부파일 " + num , name : "${fileFieldNm}_"+num, id : "${fileFieldNm}_"+num});
			$this.find("input[name^=fileCn_]:first").attr({title : "첨부파일 " + num + "설명", name : "fileCn_${fileFieldNm}_"+num, id : "fileCn_${fileFieldNm}_"+num});
			$this.find(".btn_file_del").attr({title : "첨부파일 " + num+ " 삭제", id : "btn_file_del_"+num});
			$this.find(".sr-only").text("첨부파일 "+num+" 삭제");
		});
		return false;
	});

	$(".fileList").on("click",".btn_file_del",function() {
		if (fileNum == 1) {
			$(this).prev().val("");
			//alert("1개 일 경우 삭제 하실 수 없습니다.");
			return false;
		}

		fileNum--;
		$(this).closest(".file_set").remove();

		var $parentDiv = $(".fileList");
		$parentDiv.find(".file_set").each(function(n) {
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

//]]>
</script>