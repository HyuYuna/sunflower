<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<c:set var="fileVO" value=""/>
<c:set var="fileVO2" value=""/>
<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldNm eq 'imgFile_1' }">
		<c:set var="fileVO" value="${fileList}"/>
	</c:if>
<%-- 	<c:if test="${fileList.fileFieldNm eq 'file2' }">
		<c:set var="fileVO2" value="${fileList}"/>
	</c:if> --%>
</c:forEach>
<script>
$(function() {
	$("#chkAll").on('click',function(){
		if(this.checked)
			$(":checkbox").attr("checked", true);
		else
			$(":checkbox").attr("checked", false);
	});
	//사이트선택 체크함수
	ceckSiteIdSe('${result.siteIdSe}');
});

	function checkAndSubmit() {

		var form = $("#fm")[0];
		var v = new MiyaValidator(form);
		var regFlag = "${empty result ? 'Y' : 'N'}";
		if(regFlag == "Y"){
			v.add("imgFile_1", {
				required: true
			},"웹 배너 이미지");
		}else if(regFlag == "N"){
			if ('${empty fileVO ? 0 : 1}' == 0){
				v.add("imgFile_1", {
					required: true
				},"웹 배너 이미지");
			}
		}
		  <%--  v.add("file2", {
				required: true
		    }); --%>
	    v.add("bannerNm", {
			required: true
	    });
	    v.add("bannerUrlad", {
	    	required: true,
	    	pattern: /(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi,
			message: "URL을 형식에 맞게 입력해주세요."



	    });
	    v.add("bgnde", {
	    	required: true
	    });
	    v.add("endde", {
	    	required: true
	    });
	    /* v.add("sortOrdr", {
	    	required: true
	    }); */
		result = v.validate();
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

		var $usrtAt= $("input[type=radio][name=useAt]:checked").val();
		$("#expsrAt").val($usrtAt);

		//사이트선택 필수값체크
		/* var cnt = $("INPUT[class='siteIdSe']:checked").length;
		if (cnt == 0) {
			alert("[사이트 선택] 반드시 입력하셔야 하는 사항입니다.");
			$(".siteIdSe:first").focus();
			return ;
		} */

		if (confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
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
<c:set var="action" value="${empty result ? '/bos/siteManage/banner/insert.do' : '/bos/siteManage/banner/update.do'}" />
<form id="fm" name="fm" method="post" action="${action}" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" id="expsrAt" name="expsrAt" value="" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${(empty fileList) ? '' : result.atchFileId}">
	<c:if test="${not empty result}">
		<input type="hidden" name="bannerNo" value="${param.bannerNo}" />
	</c:if>
	<input type="hidden" name="type" value="01" />
	<input type="hidden" name="pageIndex" value="${param.pageIndex}" />
	<input type="hidden" name="searchKwd" value="${param.searchKwd}" />
	<input type="hidden" name="searchCnd" value="${param.searchCnd}" />
	<input type="hidden" name="pSiteId" value="${param.pSiteId}" />
	<input type="hidden" name="updtId" value="${user.userId}" />
	<input type="hidden" name="gubun" value="01" />
	<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<!-- 	<input type="hidden" name="fileFieldNm" value="file1,file2" /> -->
<div class="bdView">
<table>
	<caption>배너관리 수정/등록</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>웹 배너 이미지</th>
			<td>
				<c:if test="${not empty fileVO }">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" width="150" height="40" alt="${fileVO.fileCn}"/>
					<input type="hidden" name="nowAtchFileId" value="${fileVO.atchFileId}"/>
					<input type="hidden" name="nowFileSn" value="${fileVO.fileSn}"/>
				</c:if>
				<div>
					<input type="file" name="imgFile_1" title="로고이미지 선택">
					<input type="hidden" name="width" value="${param.pSiteId eq 'bos' ? 196 : 150}"/>
					<input type="hidden" name="height" value="40"/>
					<input name="fileCn_imgFile_1" id="fileCn_imgFile_1" type="text" class="w50p" value="${not empty fileVO ? fileVO.fileCn : ''}" placeholder="대체 텍스트를 입력하세요.">
				</div>

				<c:if test="${param.pSiteId eq 'bos' }">
					이미지 권장사이즈 : 196*50
				</c:if>
				<c:if test="${param.pSiteId ne 'bos' }">
					이미지 권장사이즈 : 150*40
				</c:if>
			</td>
		</tr>

		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="bannerNm">제목 </label></th>
			<td>
				<input type="text" id="bannerNm" name="bannerNm" value="${result.bannerNm}" style="width:100%" />
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="bannerUrlad">링크 URL </label></th>
			<td><input type="text" id="bannerUrlad" name="bannerUrlad" value="${result.bannerUrlad}" style="width:100%" />
				<p class="help">
					외부링크의 경우 반드시 http://를 입력하셔야 합니다.
				</p>
			</td>
		</tr>
		<c:if test="${empty param.pSiteId and empty result.siteId}">
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="siteIdSe"> 사이트 선택 </label></th>
			<td>
				<input type="hidden" id = "siteIdSe" name="siteIdSe" value="${site.siteId}"/>
				<c:forEach var="site" items="${siteList}" varStatus="status">
				<label for="siteIdSe${status.index}"><input type="checkbox" id="siteIdSe${status.index}" name="siteIdSe_${site.siteId}" value="${site.siteId}" class="siteIdSe"  /> ${site.siteNm}</label>
				</c:forEach>
			</td>
		</tr>
		</c:if>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>사용 여부 </th>
			<td>
				<label for="useAt1"> <input type="radio" id="useAt1" name="useAt" value="Y" class="ra" <c:if test="${empty result or result.expsrAt eq 'Y'}">checked</c:if> /> 사용 </label>
				<label for="useAt2"> <input type="radio" id="useAt2" name="useAt" value="N" class="ra" <c:if test="${result.expsrAt eq 'N'}">checked</c:if> /> 미사용 </label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>링크 방식 </th>
			<td>
				<label for="popup_Y"> <input type="radio" id="popup_Y" name="popupAt" value="Y" class="ra" <c:if test="${empty result or result.popupAt eq 'Y'}">checked</c:if> /> 새창 </label>
				<label for="popup_N"> <input type="radio" id="popup_N" name="popupAt" value="N" class="ra" <c:if test="${result.popupAt eq 'N'}">checked</c:if> /> 현재페이지 </label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>노출기간</th>
			<td>
				<input type="text" id="bgnde" name="bgnde" title="노출시작일" style="width:120px!important" class="sdate" value="<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd"/>" readonly="readonly" />
				~
				<input type="text" id="endde" name="endde" title="노출종료일" style="width:120px!important" class="edate" value="<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd"/>" readonly="readonly"/>

			</td>
		</tr>

		<tr style="display: none">
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="sortOrdr">노출 순서 </label></th>
			<td>
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
		<a class="b-del"  href="/bos/siteManage/banner/delete.do?bannerNo=${result.bannerNo}&menuNo=${param.menuNo}&pSiteId=${param.pSiteId}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<a class="b-cancel" href="/bos/siteManage/banner/list.do?menuNo=${param.menuNo}&pSiteId=${param.pSiteId}"><span>취소</span></a>

</div>

