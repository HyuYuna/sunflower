<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldNm eq 'file1' }">
		<c:set var="fileVO" value="${fileList}"/>
	</c:if>
</c:forEach>
<script>
$(document).ready(function(){
	//사이트선택 체크함수
	//ceckSiteIdSe('${result.siteIdSe}');

	$("#fm").find("input[name=linkSe]").on('click',function() {
		if ($(this).val() == "I") {
			$(this).closest("form").find("input[name=ntcnUrlad]").val("").attr("readonly",true);
			$(this).closest("form").find(".innerLinkPopup").show();
		}
		else if ($(this).val() == "E") {
			$(this).closest("form").find("input[name=ntcnUrlad]").val("").attr("readonly",false);
			$(this).closest("form").find(".innerLinkPopup").hide();
		}
	});

	$("#fm").on("click",".innerLinkPopup",function() {
		window.open('/bos/cmmn/cmmnMenu/listMenuPop.do?viewType=BODY&pSiteId=ucms','innerLinkPopup','resizable=1,scrollbars=1 ,width=800,height=600');
		return false;
	});
});

function fnSetMenuLink(menuNo, menuLink) {
	$("#fm").find("input[name=ntcnUrlad]").val(menuLink);
}

function checkAndSubmit() {

	var form = $("#fm")[0];
	var v = new MiyaValidator(form);
	var regFlag = "${empty result ? 'Y' : 'N'}";
	v.add("ntcnNm", {
		required: true
	});
	// v.add("ntcnCn", {
	// 	required: true
	// });
	v.add("ntcnUrlad", {
		required: true,
		pattern: /(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi,
		message: "URL을 형식에 맞게 입력해주세요."
	});

	if(regFlag == "Y"){
		v.add("imgFile_1", {
			required: true
		}, "웹 이미지");
	}else if(regFlag == "N"){
		if ('${empty fileVO ? 0 : 1}' == 0){
			v.add("imgFile_1", {
				required: true
			}, "웹 이미지");
		}
	}

	v.add("bgnde", {
		required: true
	});
	v.add("endde", {
		required: true
	});
	/* v.add("sortOrdr", {
		required: true
	}); */


	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if(form.bgnde.value > form.endde.value) {
		alert("기간을 올바르게 선택해주세요.");
		form.bgnde.value = "";
		form.endde.value = "";
		return;
	}

	/* var cnt = $("INPUT[class='siteIdSe']:checked").length;
	if (cnt == 0) {
		alert("[사이트 선택] 반드시 입력하셔야 하는 사항입니다.");
		$(".siteIdSe:first").focus();
		return ;
	} */

	<%--
	document.getElementById("ntcnCn").value = oEditors.getById["ntcnCn"].getIR();
	--%>
	if (confirm('등록하시겠습니까?')) {
		saveSiteIdSe();
		form.submit();
	}
}

// 숫자 체크
function check_txt(value) {
	if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
	else {
		return value;
	}
}

function delFile(atchFileId, fileSn){
	// alert("atchFileId : "+ atchFileId + " fileSn :" + fileSn);
	if (!confirm('삭제 하시겠습니까?')) {
		return false;
	}
	$.getJSON(
		"/bos/cmmn/file/deleteFileInfs.json",
		{atchFileId : atchFileId, fileSn : fileSn},
		function(data)
		{
			var jdata = data.resultCode;
            if( jdata == 'success' ) {
            	alert("성공적으로 삭제하였습니다.");
            	location.reload();
            }
            else alert("삭제에 실패하였습니다.");
		}
	);
}
</script>


<c:set var="action" value="${empty result ? '/bos/siteManage/ntcnRelm/insert.do' : '/bos/siteManage/ntcnRelm/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${(empty fileList) ? '' : result.atchFileId}">
	<input type="hidden" name="type" value="01" />
	<input type="hidden" name="pSiteId" value="${param.pSiteId}" />
	<c:if test="${not empty result}">
		<input type="hidden" name="ntcnNo" value="${result.ntcnNo}" />
		<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	</c:if>
	<div class="bdView">
		<table>
			<caption>알림영역관리 수정/등록</caption>
			<colgroup>
				<col width="15%"/>
				<col />
				<col width="15%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="ntcnNm"><span class="req"><span class="sr-only">필수입력</span></span>제목 </label></th>
					<td colspan="3">
						<input type="text" id="ntcnNm" name="ntcnNm" value="${result.ntcnNm}" style="width: 100%" />
						<!-- <p class="inputDeco">이미지와 동등한 텍스트를 제공해야 합니다. 텍스트 정보가 많은경우 대체텍스트란에 제공하여야 합니다.</p> -->
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="ntcnUrlad">링크 URL </label></th>
					<td colspan="3">
						<label><input type="radio" name="linkSe" value="I" ${result.linkSe eq 'I' ? 'checked="checked"' : ''}> 내부</label>
						<label><input type="radio" name="linkSe" value="E" ${empty result or result.linkSe eq 'E' ? 'checked="checked"' : ''}> 외부</label>
						<div class="ra">
							<button type="button" class="b-select innerLinkPopup" <c:if test="${result.linkSe eq 'E' or empty result }">style="display:none;"</c:if>>내부링크선택</button>
							<input type="text" id="ntcnUrlad" name="ntcnUrlad" value="${result.ntcnUrlad}" class="w70p" <c:if test="${result.linkSe eq 'I'}">readonly="readonly"</c:if> />
						</div>
						<p class="help">외부링크의 경우 반드시 <em>http://</em>를 입력하셔야 합니다</p>
					</td>
				</tr>

				<tr id="trImg">
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>웹 이미지 </th>
					<td colspan="3">
					<c:if test="${not empty fileVO }">
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" width="200" alt="${fileVO.fileCn}"/>
						<input type="hidden" name="nowAtchFileId" value="${fileVO.atchFileId}"/>
						<input type="hidden" name="nowFileSn" value="${fileVO.fileSn}"/>
					</c:if>
					<div>
						<input type="file" name="imgFile_1" title="로고이미지 선택">
						<input type="hidden" name="width" value="325"/>
						<input type="hidden" name="height" value="315"/>
						<input name="fileCn_imgFile_1" id="fileCn_imgFile_1" type="text" class="w50p" value="${not empty fileVO ? fileVO.fileCn : ''}" placeholder="대체 텍스트를 입력하세요.">
					</div>
						<p class="help">이미지 권장사이즈 : 325px * 315px</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>사용 여부</th>
					<td>
						<label for="useAtY">
							<input type="radio" id="useAtY" name="useAt" value="Y" class="ra" <c:if test="${empty result or result.useAt == 'Y'}">checked</c:if> /> 사용 (Y)
						</label>
						<label for="useAtN">
							<input type="radio" id="useAtN" name="useAt" value="N" class="ra" <c:if test="${result.useAt == 'N'}">checked</c:if> /> 미사용 (N)
						</label>
					</td>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>링크 방식 </th>
					<td>
						<label for="popupAtY">
							<input type="radio" id="popupAtY" name="popupAt" value="Y" class="ra" <c:if test="${empty result or result.popupAt == 'Y'}">checked</c:if> /> 새창 (Y)
						</label>
						<label for="popupAtN">
							<input type="radio" id="popupAtN" name="popupAt" value="N" class="ra" <c:if test="${result.popupAt == 'N'}">checked</c:if> /> 현재창 (N)
						</label>
					</td>
				</tr>

				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>노출 기간 </th>
					<td colspan="3">
						<input type="text" id="bgnde" name="bgnde" title="노출시작일" value="<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd"/>" class="sdate" readonly="readonly"/>
						~
						<input type="text" id="endde" name="endde" title="노출종료일" value="<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd"/>" class="edate" readonly="readonly"/>
					</td>
				</tr>
				<c:if test="${empty param.pSiteId and empty result.siteId}">
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>사이트 선택</th>
					<td colspan="3">
						<input type="hidden" id = "siteIdSe" name="siteIdSe" value="${result.siteIdSe}"/>
						<c:forEach var="site" items="${siteList}" varStatus="status">
						<label for="siteIdSe${status.index}"><input type="checkbox" id="siteIdSe${status.index}" name="siteIdSe_${site.siteId}" value="${site.siteId}" class="siteIdSe"  /> ${site.siteNm}</label>
						</c:forEach>
					</td>
				</tr>
				</c:if>

				<tr style="display: none">
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>노출 순서</th>
					<td colspan="3">
						<input type="text" id="sortOrdr" name="sortOrdr" style="width:120px" class="tac" value="${empty result ? sortOrdr : result.sortOrdr}" onkeyup="this.value=check_txt(this.value)"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<c:choose>
		<c:when test="${empty result}" >
			<a class="b-reg" href="javascript:checkAndSubmit();"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="b-edit" href="javascript:checkAndSubmit();"><span>수정</span></a>
			<a class="b-del"  href="/bos/siteManage/ntcnRelm/delete.do?ntcnNo=${result.ntcnNo}&${pageQueryString}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:otherwise>
	</c:choose>
	<a class="b-cancel" href="/bos/siteManage/ntcnRelm/list.do?menuNo=${param.menuNo}&pSiteId=${param.pSiteId}"><span>취소</span></a>
</div>

