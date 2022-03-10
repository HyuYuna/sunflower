<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/main/userMainCntnts/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/main/userMainCntnts/update.do" />
</c:if>

<c:if test="${param.relmSeCd eq '01' }">
<h1>메인비주얼 변경</h1>
	<form name="mainPopupForm" id="mainPopupForm" method="post" action="${action }" enctype="multipart/form-data">
<div class="view">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="relmSeCd" id="relmSeCd" value="${paramVO.relmSeCd }" >
	<input type="hidden" name="viewType" value="${paramVO.viewType }" >
	<input type="hidden" name="width" value="" >
	<input type="hidden" name="height" value="" >
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId }" >
	<input type="hidden" name="mainCntntsCd" id="mainCntntsCd" value="99" >
	<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	<dl>
		<dt>메인비주얼</dt>
		<dd>
			<div class="fileSubmit">
			<input type="file" name="imgFile_1" id="imgFile_1" title="메인비주얼" style="display: inline">
			<div class="row">
				<div class="col-sm-2"><label for="fileCn_imgFile_1">메인비주얼 대체텍스트 :</label></div>
				<div class="col-sm-10"><input id="fileCn_imgFile_1" name="fileCn_imgFile_1" type="text" class="w100p" value="${fileVO.fileCn}" placeholder="이미지와 동등한 텍스트를 입력하세요. "></div>
			</div>
			<p class="help">메인비주얼 이미지 사이즈는 1200px 이상 × 315px 입니다.</p>
			</div>
			<c:if test="${not empty fileVO }">
			<div class="imgView">
				<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" alt="${fileVO.fileCn}" height="80" />
				<button type="button" class="btn btn-danger btn-sm imgDelBtn" title="이미지파일  삭제">
					<span class="sr-only">첨부파일  삭제</span>
					<i class="fa fa-trash-o" aria-hidden="true"></i>
				</button>
			</div>
			</c:if>
		</dd>
	</dl>
</div>
	</form>
<div class="btnSet c">
	<button class="b-save" id="saveBtn">저장</button>
	<button class="b-end">닫기</button>
</div>

<script>
$(".b-save").on('click',function() {
	if ($("#imgFile_1").val() == "") {
		alert("첨부파일을 선택해 주세요!");
		$("#imgFile_1").focus();
		return false;
	}
	else if ($("#fileCn_imgFile_1").val() == "") {
		alert("메인비주얼 대체텍스트 입력해 주세요!");
		$("#fileCn_imgFile_1").focus();
		return false;
	}

	if (!confirm("저장하시겠습니까?")) return false;
	$("#mainPopupForm").submit();
	return false;
});

$(".b-end").on('click',function() {
	self.close();
	return false;
});


$(".imgDelBtn").on('click',function() {
	if (!confirm('삭제 하시겠습니까?')) {
		return false;
	}
	$.getJSON(
		"/bos/cmmn/file/deleteFileInfs.json",
		{atchFileId : $("#atchFileId").val(), fileSn : 1},
		function(data)
		{
			var jdata = data.resultCode;
            if( jdata == 'success' ) {
            	alert("성공적으로 삭제하였습니다.");
            	$(".imgView").remove();
            	$(".fileSubmit").show();

            }
            else alert("삭제에 실패하였습니다.");
		}
	);
});


</script>
</c:if>

<c:if test="${param.relmSeCd ne '01' }">
<h1>콘텐츠 변경</h1>
	<form name="mainPopupForm" id="mainPopupForm" method="post" action="${action }" enctype="multipart/form-data">
<div class="view">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="relmSeCd" id="relmSeCd" value="${paramVO.relmSeCd }" >
	<input type="hidden" name="viewType" value="${paramVO.viewType }" >
	<input type="hidden" name="width" value="" >
	<input type="hidden" name="height" value="" >
	<input type="hidden" name="bbsId" id="bbsId" value="${result.bbsId }" >
	<input type="hidden" name="menuNo" id="menuNo" value="${result.menuNo }" >
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId }" >
	<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	<dl>
		<dt>콘텐츠 구분</dt>
		<dd class="contentSelect">
			<label><input type="radio" name="mainCntntsCd" value="01" <c:if test="${result.mainCntntsCd eq '01' }">checked="checked"</c:if>>일반형 게시판</label>
			<label><input type="radio" name="mainCntntsCd" value="02" <c:if test="${result.mainCntntsCd eq '02' }">checked="checked"</c:if>>포토형 게시판</label>
			<label><input type="radio" name="mainCntntsCd" value="03" <c:if test="${result.mainCntntsCd eq '03' }">checked="checked"</c:if>>내부콘텐츠 링크</label>
			<label><input type="radio" name="mainCntntsCd" value="04" <c:if test="${result.mainCntntsCd eq '04' }">checked="checked"</c:if>>알림영역</label>
		</dd>
	</dl>
	<dl class="contentsSelectArea">
		<dt> 콘텐츠 선택 </dt>
		<dd class="setarea1">
			<button type="button" class="b-open bbsSelectBtn">게시판 선택</button>
			<span id="selectedBbs">
				<c:if test="${not empty result.bbsId  }">
				<button type="button" class="b-default delBbsBtn">${result.menuNm }(${result.bbsNm }) <span class="b-del btn-xs"><span class="sr-only">삭제</span></span></button>
				</c:if>
			</span>
		</dd>
		<dd class="setarea2">

			<div class="row">
				<div class="col-sm-2"><label for="contenturl">콘텐츠 URL</label></div>
				<div class="col-sm-10">
					<input type="text" id="menuLink" name="menuLink" class="w100p" value="${result.menuLink }">
					<input type="file" name="imgFile_1" id="imgFile_1" title="콘텐츠 이미지" style="display: inline">
					<label><input type="checkbox" name="popupAt" id="popupAt" value="Y" <c:if test="${result.popupAt eq 'Y' }">checked="checked"</c:if>> 새창사용</label>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2"><label for="fileCn_imgFile_1">콘텐츠 이미지 대체텍스트 :</label></div>
				<div class="col-sm-10"><input id="fileCn_imgFile_1" name="fileCn_imgFile_1" type="text" class="w100p" value="${fileVO.fileCn }" placeholder="이미지와 동등한 텍스트를 입력하세요. "></div>
			</div>
			<p class="help">이미지 사이즈는 325px × 313px 입니다.</p>
			<c:if test="${not empty fileVO }">
			<div class="imgView">
				<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" alt="${fileVO.fileCn}" height="80" />
				<button type="button" class="btn btn-danger btn-sm imgDelBtn" title="이미지파일  삭제">
					<span class="sr-only">첨부파일  삭제</span>
					<i class="fa fa-trash-o" aria-hidden="true"></i>
				</button>
			</div>
			</c:if>
		</dd>
	</dl>
</div>
	</form>
<div class="btnSet c">
	<button class="b-save" id="saveBtn">저장</button>
	<button class="b-end">닫기</button>
</div>
<script>
	$('.contentsSelectArea').hide();
	$('.contentSelect input:radio').each(function(index, el) {
		$(this).focus(function(event) {
			$('.contentsSelectArea').show();
			switch(index){
				case 0:
					$('.setarea1').show().siblings('dd').hide();
					break;
				case 1:
					$('.setarea1').show().siblings('dd').hide();
					break;
				case 2:
					$('.setarea2').show().siblings('dd').hide();
					break;
				case 3:
					$('.contentsSelectArea').hide();
					break;
			}
			fnResetValue();
		});
	});

	$(".bbsSelectBtn").on('click',function() {
		var mainCntntsCd = $("input[name=mainCntntsCd]:checked").val();
		var url = "/bos/main/userMainCntnts/listPopup.do?viewType=BODY&pSiteId=ucms";
		var params = "";
		if (mainCntntsCd == "01") {
			 params = "&bbsAttrbCd=PG0001&opnerFnAt=Y";
		}
		else if (mainCntntsCd == "02") {
			params = "&bbsAttrbCd=PG0002&opnerFnAt=Y";
		}
		else if (mainCntntsCd == "03") {

		}
		else if (mainCntntsCd == "04") {

		}
		window.open(url+params,"bbsId","scrollbars=yes,width=800,height=600");
		return false;
	});

	$(".b-save").on('click',function() {
		var mainCntntsCd = $("input[name=mainCntntsCd]:checked").val();
		if ( mainCntntsCd == "01" || mainCntntsCd == "02") {
			if ($("#bbsId").val() == "") {
				alert("게시판을 선택해 주세요!");
				$("#imgFile_1").focus();
				return false;
			}
		}

		else if (mainCntntsCd == "03") {
			var regexp=/^(file|gopher|news|nntp|telnet|https?|ftps?|sftp):\/\/([a-z0-9-]+\.)+[a-z0-9]{2,4}.*$/;
			if(!regexp.test($('#menuLink').val())) {
				alert("콘텐츠URL을 URL을 형식에 맡게 입력해주세요.");
			  	$('#menuLink').focus();
			  	return false;
		 	}
			else if ($("#imgFile_1").val() == "") {
				alert("첨부파일을 선택해 주세요!");
				$("#imgFile_1").focus();
				return false;
			}
			else if ($("#fileCn_imgFile_1").val() == "") {
				alert("메인비주얼 대체텍스트 입력해 주세요!");
				$("#fileCn_imgFile_1").focus();
				return false;
			}
		}

		if (!confirm("저장하시겠습니까?")) return false;
		$("#mainPopupForm").submit();
		return false;
	});

	$(".b-end").on('click',function() {
		self.close();
		return false;
	});


	$(".imgDelBtn").on('click',function() {
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		}
		$.getJSON(
			"/bos/cmmn/file/deleteFileInfs.json",
			{atchFileId : $("#atchFileId").val(), fileSn : 1},
			function(data)
			{
				var jdata = data.resultCode;
	            if( jdata == 'success' ) {
	            	alert("성공적으로 삭제하였습니다.");
	            	$(".imgView").remove();
	            	$(".fileSubmit").show();

	            }
	            else alert("삭제에 실패하였습니다.");
			}
		);
	});

	$(".delBbsBtn").on('click',function() {
		$(this).remove();
		return false;
	});

	function fnSetBbsValue(bbsId, menuLink, bbsNm,menuNo,menuNm) {
		//<button type="button" class="b-default">공지사항 <span class="b-del btn-xs"><span class="sr-only">삭제</span></span></button>
		var $button = $("<button>").addClass("b-default").text(menuNm+"("+bbsNm + ") ").attr("data-value",bbsId);
		$button.on('click',function() {
			$(this).remove();
			return false;
		});
		var $spanOut = $("<span>").addClass("b-del btn-xs");
		var $spanIn = $("<span>").addClass("sr-only").text("삭제");
		$spanIn.appendTo($spanOut);
		$spanOut.appendTo($button);
		$button.appendTo($("#selectedBbs").empty());
		$("#bbsId").val(bbsId);
		$("#menuNo").val(menuNo);
	}

	function fnResetValue() {
		$("#selectedBbs").empty();
		$("#menuLink").val("");
		$("#imgFile_1").val("");
		$("#popupAt").attr("checked",false);
		$("#bbsId").val("");
		$("#menuNo").val("");
	}

	if ($('.contentSelect input:radio:checked').length > 0) {
		var index = $('.contentSelect input:radio:checked').val();
		if (index == "01" || index == "02") {
			$('.contentsSelectArea').show();
			$('.setarea1').show().siblings('dd').hide();
		}
		else if (index == "03") {
			$('.contentsSelectArea').show();
			$('.setarea2').show().siblings('dd').hide();
		}
		else {
			$('.contentsSelectArea').hide();
		}
	}
</script>
</c:if>


