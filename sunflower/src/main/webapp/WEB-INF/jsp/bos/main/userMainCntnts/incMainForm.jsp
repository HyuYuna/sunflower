<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<%
	String relmSeCd = request.getParameter("relmSeCd");
	Object obj = request.getAttribute("relmSeCd" + relmSeCd);
	request.setAttribute("relmSeVO", obj);
%>




<c:set var="relmSeCd" value= "${param.relmSeCd }" />
<c:set var="result" value= "${relmSeVO }" />
<c:set var="fileList" value= "${fileMap[relmSeVO.atchFileId] }" />
<c:if test="${fn:length(fileList) > 0 }">
	<c:set var="fileVO" value= "${fileMap[relmSeVO.atchFileId][0] }" />
</c:if>



<c:if test="${empty result}">
	<c:set var="action" value="/bos/main/userMainCntnts/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/main/userMainCntnts/update.do" />
</c:if>


<c:if test="${relmSeCd eq '01' }">
	<form name="mainForm${relmSeCd}" id="mainForm${relmSeCd}" method="post" action="${action }" enctype="multipart/form-data">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="relmSeCd" id="relmSeCd" value="${relmSeCd}" >
		<input type="hidden" name="pSiteId" value="${param.pSiteId }" >
		<input type="hidden" name="width" value="" >
		<input type="hidden" name="height" value="" >
		<input type="hidden" name="menuNo" value="${param.menuNo}" />
		<input type="hidden" name="atchFileId" value="${result.atchFileId }" >
		<input type="hidden" name="mainCntntsCd" id="mainCntntsCd" value="99" >
		<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	<div class="view" id="mainvisual${param.seqNum }">
		<dl>
			<dt><span class="req"><span>????????????</span></span>????????????</dt>
			<dd>
				<label for="useAt${relmSeCd}1"><input type="radio" name="useAt" id="useAt${relmSeCd}1" value="Y" <c:if test="${not empty result  or result.useAt eq 'Y' }">checked="checked"</c:if>> ??????</label>
				<label for="useAt${relmSeCd}2"><input type="radio" name="useAt" id="useAt${relmSeCd}2" value="N" <c:if test="${empty result or result.useAt eq 'N'  }">checked="checked"</c:if>> ?????????</label>
			</dd>
		</dl>

		<dl class="viewSe${relmSeCd}">
			<dt><span class="req"><span>????????????</span></span>????????? ??????</dt>
			<dd>
				<c:if test="${not empty fileVO }">
				<div class="imguploadset clearfix">
					<div class="fl">
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" alt="${fileVO.fileCn}" height="80" />
					</div>
					<div class="fl">
						<div>${fileVO.fileNm }</div>
						<!--
						<button type="button" class="b-del imgDelBtn${relmSeCd}">??????</button>
						 -->
					</div>
				</div>
				</c:if>
				<div>
					<input type="file" name="imgFile_1" title="????????? ??????">
				</div>
				<p class="help">
					???????????????????????? ??????????????? : <em>1200px ?????? * 315px</em>
				</p>
			</dd>
		</dl>
		<dl class="viewSe${relmSeCd}">
			<dt><span class="req"><span>????????????</span></span>????????? ???????????????</dt>
			<dd>
				<input name="fileCn_imgFile_1" type="text" class="w100p" value="${fileVO.fileCn }" placeholder="???????????? ????????? ???????????? ???????????????." title="????????? ???????????????">
				<input type="hidden" name="fileSn_1" value="${fileVO.fileSn }" />
			</dd>
		</dl>
	</div>
	<div class="btnSet">
		<button type="button" class="b-edit saveBtn${relmSeCd}">??????</button>
	</div>
	</form>

	<script>
	$(".saveBtn${relmSeCd}").on('click',function() {
		var $form = $("#mainForm${relmSeCd}");

		if ($form.find("input[name=useAt]:checked").val() == "Y") {
			if ($(this).closest("form").find("img").length == 0) {
				if ($form.find("input[name=imgFile_1]").val() == "") {
					alert("??????????????? ????????? ?????????!");
					$form.find("input[name=imgFile_1]").focus();
					return false;
				}
			}


			if ($form.find("input[name=fileCn_imgFile_1]").val() == "") {
				alert("??????????????? ??????????????? ????????? ?????????!");
				$form.find("input[name=fileCn_imgFile_1]").focus();
				return false;
			}
		}


		if (!confirm("?????????????????????????")) return false;
		$("#mainForm${relmSeCd}").submit();
		return false;
	});


	$(".imgDelBtn${relmSeCd}").on('click',function() {
		var $this = $(this);
		var $form = $("#mainForm${relmSeCd}");
		if (!confirm('?????? ???????????????????')) {
			return false;
		}
		$.getJSON(
			"/bos/cmmn/file/deleteFileInfs.json",
			{atchFileId : $form.find("input[name=atchFileId]").val(), fileSn : 1},
			function(data)
			{
				var jdata = data.resultCode;
	            if( jdata == 'success' ) {
	            	alert("??????????????? ?????????????????????.");
	            	$this.closest(".imguploadset").remove();


	            }
	            else alert("????????? ?????????????????????.");
			}
		);
	});

	$("#mainForm${relmSeCd}").find("input[name=useAt]").on('click',function() {
		if ($(this).val() == "Y") {
			$(".viewSe${relmSeCd}").show();
		}
		else {
			$(".viewSe${relmSeCd}").hide();
		}
	});

	if ($("#mainForm${relmSeCd}").find("input[name=useAt]:checked").val() == "Y") {
		$(".viewSe${relmSeCd}").show();
	}
	else {
		$(".viewSe${relmSeCd}").hide();
	}
	</script>
</c:if>


<c:if test="${param.relmSeCd ne '01' }">

<form name="mainForm${relmSeCd}" id="mainForm${relmSeCd}" method="post" action="${action }" enctype="multipart/form-data">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="relmSeCd" id="relmSeCd" value="${relmSeCd}" >
	<input type="hidden" name="pSiteId" value="${param.pSiteId }" >
	<input type="hidden" name="width" value="" >
	<input type="hidden" name="height" value="" >
	<input type="hidden" name="bbsId" value="${result.bbsId }" >
	<input type="hidden" name="menuNo" value="${param.menuNo }" >
	<input type="hidden" name="ctntsMenuNo" value="${result.menuNo }" >
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId }" >
	<input type="hidden" name="fileFieldNm" value="imgFile_1" />
<div class="view">
	<dl>
		<dt><span class="req"><span>????????????</span></span>????????????</dt>
		<dd>
			<label for="useAt${relmSeCd}1"><input type="radio" name="useAt" id="useAt${relmSeCd}1" value="Y" <c:if test="${not empty result  or result.useAt eq 'Y' }">checked="checked"</c:if>> ??????</label>
			<label for="useAt${relmSeCd}2"><input type="radio" name="useAt" id="useAt${relmSeCd}2" value="N" <c:if test="${empty result or result.useAt eq 'N'  }">checked="checked"</c:if>> ?????????</label>
		</dd>
	</dl>

	<dl class="viewSe${relmSeCd}">
		<dt><span class="req"><span>????????????</span></span>????????? ??????</dt>
		<dd class="contentSelect">
			<label><input type="radio" name="mainCntntsCd" value="01" <c:if test="${empty result or result.mainCntntsCd eq '01' }">checked="checked"</c:if>>??????????????????</label>
			<label><input type="radio" name="mainCntntsCd" value="03" <c:if test="${result.mainCntntsCd eq '03' }">checked="checked"</c:if>>??????????????? ??????</label>
			<label><input type="radio" name="mainCntntsCd" value="04" <c:if test="${result.mainCntntsCd eq '04' }">checked="checked"</c:if>>????????????</label>
		</dd>
	</dl>
	<dl class="boardSet viewSe${relmSeCd}">
		<dt><span class="req"><span>????????????</span></span>???????????????</dt>
		<dd>
			<button type="button" class="b-open bbsSelectBtn" title="????????????">????????? ??????</button>
			<span id="selectedBbs${relmSeCd}">
				<c:if test="${not empty relmSeVO.bbsId  }">
				<button type="button" class="b-default delBbsBtn">${result.menuNm }(${result.bbsNm }) <span class="b-del btn-xs"><span class="sr-only">??????</span></span></button>
				</c:if>
			</span>
		</dd>
	</dl>
	<div class="imageSet viewSe${relmSeCd}">

		<dl>
			<dt><span class="req"><span>????????????</span></span>???????????????</dt>
			<dd>
				<c:if test="${not empty fileVO }">
				<div class="imguploadset clearfix">
					<div class="fl">
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" alt="${fileVO.fileCn}" height="80" />
					</div>
					<div class="fl">
						<div>${fileVO.fileNm }</div>
						<!--
						<button type="button" class="b-del imgDelBtn${relmSeCd}">??????</button>
						 -->
					</div>
				</div>
				</c:if>
				<div>
					<input type="file" name="imgFile_1" id="imgFile_1" title="????????? ??????">
				</div>
				<p class="help">
					???????????????????????? ??????????????? : <em>325px * 315px</em>
				</p>
			</dd>
		</dl>
		<dl>
			<dt><span class="req"><span>????????????</span></span>????????? ???????????????</dt>
			<dd>
				<input name="fileCn_imgFile_1" type="text" class="w100p" value="${fileVO.fileCn }" placeholder="???????????? ????????? ???????????? ???????????????." title="????????? ???????????????">
				<input type="hidden" name="fileSn_1" value="${fileVO.fileSn }" />
			</dd>
		</dl>
		<dl>
			<dt><span class="req"><span>????????????</span></span>??????URL</dt>
			<dd>
				<label><input type="radio" name="linkSe" value="I" ${empty result.mainCntntsCd eq '03' and not empty result.menuNo ? 'checked="checked"' : ''}> ??????</label>
				<label><input type="radio" name="linkSe" value="E" ${empty result or empty result.menuNo ? 'checked="checked"' : ''}> ??????</label>
				<div class="ra">
					<button type="button" class="b-select innerLinkPopup" <c:if test="${empty result or empty result.menuNo }">style="display:none;"</c:if>>??????????????????</button>
					<input type="text"  name="menuLink" class="w70p" placeholder="???????????? ????????? ???????????? ???????????????." title="????????? ???????????????" value="${result.menuLink }"  <c:if test="${not empty result.menuNo and result.mainCntntsCd eq '03' }">readonly="readonly"</c:if>>
					<label><input type="checkbox" name="popupAt" value="Y" <c:if test="${result.popupAt eq 'Y' }">checked="checked"</c:if>> ????????????</label>
				</div>
				<p class="help">??????????????? ?????? ????????? <em>http://</em>??? ??????????????? ?????????</p>
			</dd>
		</dl>

	</div>
	<!--  -->
</div>
<div class="btnSet">
	<button type="button" class="b-edit saveBtn${relmSeCd}">??????</button>
</div>
</form>

<script>
	$("#mainForm${relmSeCd}").find('.contentSelect').each(function(index, el) {
		$(this).find('label>input[type=radio]').each(function(i, el) {
			$(this).on("click",function(event) {
				console.log(i)
				if (i=='0') {
					$(this).parents('dl').nextAll('.boardSet:first').show().next().hide();
				}else if(i=='1'){
					$(this).parents('dl').nextAll('.imageSet:first').show().prev().hide();
				}else{
					var cnt = $("input[name=mainCntntsCd][value='04']:checked").length;
					if (cnt > 1) {
						alert("?????? ??????????????? ???????????? ?????????????????? ???????????????.\n?????? ?????????????????? ??????????????????.");
						return false;
					}

					$(this).parents('dl').nextAll('.boardSet:first').hide().next().hide();
				}
				fnResetValue($("#mainForm${relmSeCd}"));
			});
		});
		//$(this).find('label input:checked').trigger('click');
	});


	$("#mainForm${relmSeCd}").find(".bbsSelectBtn").on('click',function() {
		var $form = $("#mainForm${relmSeCd}");
		var mainCntntsCd = $form.find("input[name=mainCntntsCd]:checked").val();
		var url = "/bos/main/userMainCntnts/listPopup.do?viewType=BODY&pSiteId=ucms";
		var params = "";
		if (mainCntntsCd == "01") {
			 params = "&opnerFnAt=Y&relmSeCd=${relmSeCd}";
		}
		else if (mainCntntsCd == "03") {

		}
		else if (mainCntntsCd == "04") {

		}
		window.open(url+params,"bbsId","scrollbars=yes,width=800,height=600");
		return false;
	});

	$(".saveBtn${relmSeCd}").on('click',function() {
		var $form = $("#mainForm${relmSeCd}");

		if ($form.find("input[name=useAt]:checked").val() == "Y") {
			var mainCntntsCd = $form.find("input[name=mainCntntsCd]:checked").val();
			if ( mainCntntsCd == "01" || mainCntntsCd == "02") {
				if ($form.find("input[name=bbsId]").val() == "") {
					alert("???????????? ????????? ?????????!");
					$form.find("input[name=imgFile_1]").focus();
					return false;
				}
			}

			else if (mainCntntsCd == "03") {
				var regexp=/(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi;
				if ($(this).closest("form").find("img").length == 0) {
					if ($form.find("input[name=imgFile_1]").val() == "") {
						alert("??????????????? ????????? ?????????!");
						$("#imgFile_1").focus();
						return false;
					}
				}
				if ($form.find("input[name=fileCn_imgFile_1]").val() == "") {
					alert("??????????????? ??????????????? ????????? ?????????!");
					$form.find("input[name=fileCn_imgFile_1]").focus();
					return false;
				}
				if(!regexp.test($form.find("input[name=menuLink]").val())) {
					alert("?????????URL??? URL??? ????????? ?????? ??????????????????.");
					$form.find("input[name=menuLink]").focus();
				  	return false;
			 	}
			}
		}


		if (!confirm("?????????????????????????")) return false;
		$form.submit();
		return false;
	});

	$(".imgDelBtn${relmSeCd}").on('click',function() {
		var $this = $(this);
		var $form = $("#mainForm${relmSeCd}");
		if (!confirm('?????? ???????????????????')) {
			return false;
		}
		$.getJSON(
			"/bos/cmmn/file/deleteFileInfs.json",
			{atchFileId : $form.find("input[name=atchFileId]").val(), fileSn : 1},
			function(data)
			{
				var jdata = data.resultCode;
	            if( jdata == 'success' ) {
	            	alert("??????????????? ?????????????????????.");
	            	$this.closest(".imguploadset").remove();


	            }
	            else alert("????????? ?????????????????????.");
			}
		);
	});


	$("#mainForm${relmSeCd}").on("click",".delBbsBtn",function() {
		if (!confirm("???????????? ???????????? ?????????????????????????")) return false;
		var $form = $("#mainForm${relmSeCd}");
		$(this).remove();
		$form.find("input[name=bbsId]").val("");
		$form.find("input[name=ctntsMenuNo]").val("");
		return false;
	});


	$("#mainForm${relmSeCd}").find("input[name=useAt]").on('click',function() {

		var $mainCntntsCd = $("#mainForm${relmSeCd}").find("input[name=mainCntntsCd]:checked");
		if ($(this).val() == "Y") {
			$(".viewSe${relmSeCd}").show();

			if ($mainCntntsCd.val() == "01") {
				$mainCntntsCd.closest('dl').nextAll('.boardSet:first').show().next().hide();
			}
			else if ($mainCntntsCd.val() == "03") {
				$mainCntntsCd.closest('dl').nextAll('.imageSet:first').show().prev().hide();
			}
			else {
				$mainCntntsCd.closest('dl').nextAll('.boardSet:first').hide().next().hide();
			}

		}
		else {
			$(".viewSe${relmSeCd}").hide();
		}
	});


	$("#mainForm${relmSeCd}").find("input[name=linkSe]").on('click',function() {
		if ($(this).val() == "I") {
			$(this).closest("form").find("input[name=menuLink]").val("").attr("readonly",true);
			$(this).closest("form").find(".innerLinkPopup").show();
		}
		else if ($(this).val() == "E") {
			$(this).closest("form").find("input[name=menuLink]").val("").attr("readonly",false);
			$(this).closest("form").find("input[name=ctntsMenuNo]").val("").attr("readonly",false);
			$(this).closest("form").find(".innerLinkPopup").hide();
		}
	});


	if ($("#mainForm${relmSeCd}").find("input[name=useAt]:checked").val() == "Y") {
		var $mainCntntsCd = $("#mainForm${relmSeCd}").find("input[name=mainCntntsCd]:checked");
		$(".viewSe${relmSeCd}").show();


		if ($mainCntntsCd.val() == "01") {
			$mainCntntsCd.closest('dl').nextAll('.boardSet:first').show().next().hide();
		}
		else if ($mainCntntsCd.val() == "03") {
			$mainCntntsCd.closest('dl').nextAll('.imageSet:first').show().prev().hide();
		}
		else if ($mainCntntsCd.val() == "04") {
			$mainCntntsCd.closest('dl').nextAll('.boardSet:first').hide().next().hide();
		}
		else {
		}
	}
	else {
		$(".viewSe${relmSeCd}").hide();
	}


	function fnSetBbsValue${relmSeCd}(bbsId, menuLink, bbsNm,ctntsMenuNo,menuNm) {
		var $form = $("#mainForm${relmSeCd}");
		//<button type="button" class="b-default">???????????? <span class="b-del btn-xs"><span class="sr-only">??????</span></span></button>
		var $button = $("<button>").addClass("b-default").addClass("delBbsBtn").text(menuNm+"("+bbsNm + ") ").attr("data-value",bbsId);
		var $spanOut = $("<span>").addClass("b-del btn-xs");
		var $spanIn = $("<span>").addClass("sr-only").text("??????");
		$spanIn.appendTo($spanOut);
		$spanOut.appendTo($button);
		$button.appendTo($("#selectedBbs${relmSeCd}").empty());
		$form.find("input[name=bbsId]").val(bbsId);
		$form.find("input[name=ctntsMenuNo]").val(ctntsMenuNo);
		btnclassSetting()
	}

	function fnResetValue($form) {
		$form.find("[id^=selectedBbs]").empty();
		$form.find("input[name=menuLink]").val("").attr("readonly",false);
		$form.find(".innerLinkPopup").hide();
		$form.find("input[name=linkSe][value=E]").attr("checked",true);
		$form.find(".imguploadset").remove();
		$form.find("input[name=imgFile_1]").val("");
		$form.find("input[name=fileCn_imgFile_1]").val("");
		$form.find("input[name=popupAt]").attr("checked",false);
		$form.find("input[name=bbsId]").val("");


		$form.find("input[name=ctntsMenuNo]").val("");
	}

	$("#mainForm${relmSeCd}").on("click",".innerLinkPopup",function() {
		var linkNo = "${relmSeCd}";
		window.open('/bos/cmmn/cmmnMenu/listMenuPop.do?viewType=BODY&pSiteId=${param.pSiteId}&linkNo='+linkNo,'innerLinkPopup','resizable=1,scrollbars=1 ,width=800,height=600');
		return false;
	});

	function fnSetMenuLink(menuNo, menuNm, menuLink, relmSeCd) {
		var $form = $("#mainForm"+ relmSeCd);
		$form.find("input[name=menuLink]").val(menuLink);
		$form.find("input[name=ctntsMenuNo]").val(menuNo);
	}
</script>
</c:if>
