<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<c:forEach var="fileList" items="${fileList}" varStatus="status">
	<c:if test="${fileList.fileFieldNm eq 'file1' }">
		<c:set var="fileVO" value="${fileList}"/>
	</c:if>
</c:forEach>
<c:if test="${empty result}">
	<c:set var="action" value="/bos/siteManage/popup/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/siteManage/popup/update.do" />
</c:if>

<script>

	$(function() {
		/* if($("#linkTyCd1")[0].checked)
	    {
			$("#urladTr").hide();
			//$("#mapCn").hide();
	    }
		else if($("#linkTyCd2")[0].checked)
	    {
			//$("#urladTr").hide();
			$("#map").hide();

	    }

		$("input[name=linkTyCd]").on('click',function(){
			if(this.value == "I") {
				$("#urladTr").show();
				$("#map").hide();
			} else {
				$("#urladTr").hide();
				$("#map").show();
			}

		}); */

		//사이트선택 체크함수
		ceckSiteIdSe('${result.siteIdSe}');

		$("#board").find("input[name=linkTyCd]").on('click',function() {
			if ($(this).val() == "I") {
				$(this).closest("form").find("input[name=urlad]").val("").attr("readonly",true);
				$(this).closest("form").find(".innerLinkPopup").show();
			}
			else if ($(this).val() == "E") {
				$(this).closest("form").find("input[name=urlad]").val("").attr("readonly",false);
				$(this).closest("form").find(".innerLinkPopup").hide();
			}
		});

		$("#board").on("click",".innerLinkPopup",function() {
			window.open('/bos/cmmn/cmmnMenu/listMenuPop.do?viewType=BODY&pSiteId=ucms','innerLinkPopup','resizable=1,scrollbars=1 ,width=800,height=600');
			return false;
		});

	});

	function fnSetMenuLink(menuNo, menuLink) {
		$("#board").find("input[name=urlad]").val(menuLink);
	}

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		var regFlag = "${empty result ? 'Y' : 'N'}";

	    v.add("popupSj", {
	        required: true
	    });
	    if(regFlag == "Y"){
			v.add("imgFile_1", {
				required: true
			}, "이미지");
		}else if(regFlag == "N"){
			if ('${empty fileVO ? 0 : 1}' == 0){
				v.add("imgFile_1", {
					required: true
				}, "이미지");
			}
		}
	    /* v.add("linkTyCd", {
	        required: true
	    });
	    // 이미지 링크 확인 (단 , 링크타입이 이미지링크일때)
		// 링크타입 값  linkTyCd
	    var linkType = $("INPUT[name='linkTyCd']:checked").val();
		if (linkType =="I") {
			v.add("urlad", {
				required: true
			});
		} */
		v.add("urlad", {
			required: true
		});
	    v.add("useAt", {
	        required: true
	    });
	    v.add("scrlUseAt", {
	        required: true
	    });
	    v.add("closeUseAt", {
	        required: true
	    });
	    v.add("bgnde", {
	        required: true
	    });
	    v.add("endde", {
	        required: true
	    });
	    v.add("arValue", {
	        required: true
	    });
	    v.add("hgValue", {
	        required: true
	    });
	    v.add("upendCrdnt", {
	        required: true
	    });
	    v.add("lftCrdnt", {
	        required: true
	    });

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

/* 		var cnt = $("INPUT[class='siteIdSe']:checked").length;
		if (cnt == 0) {
			alert("[사이트 선택] 반드시 입력하셔야 하는 사항입니다.");
			$(".siteIdSe:first").focus();
			return ;
		} */





		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		saveSiteIdSe();
		form.submit();
	}

	// 체크함수 (N : 숫자만 , NP : 숫자 + . , NA : 숫자 + 영어)
	function check_txt(value, type) {
		if (value.length == 0 ) return "";
		if (type == "N"){ // N :숫자만
			var pattern = /^[0-9]+$/;
			if (!pattern.test(value)) {
				alert("숫자로만 입력하셔야 합니다.");
				return "";
			}
		}else if (type == "NP"){ // NP :숫자 + .
			var pattern = /^[0-9|.]+$/;
			if (!pattern.test(value)) {
				alert("숫자와 .만 입력하셔야 합니다.");
				return "";
			}
		}else if (type == "NA"){ // NA :숫자 + 영어
			var pattern = /[^a-zA-Z0-9|.|/|&|?|:]/;
			if (pattern.test(value)) {
				alert("숫자와 영어만 입력하셔야 합니다.");
				return "";
			}
		}
		return value;
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


<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<c:if test="${not empty result}">
		<input type="hidden" name="popupNo" value="${paramVO.popupNo}" />
		<input type="hidden" name="fileFieldNm" value="imgFile_1" />
	</c:if>
	<input type="hidden" name="pSiteId" value="${param.pSiteId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${(empty fileList) ? '' : result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<div class="bdView">
<table>
	<caption>팝업관리 수정 및 등록</caption>
	<tbody>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="popupSj">팝업제목 </label></th>
			<td colspan="3">
				<input type="text" name="popupSj" id="popupSj"  class="w100p" value="${result.popupSj}" />
			</td>
		</tr>
		<%-- <tr>
			<th scope="row"><label for="siteId">대상사이트</label></th>
			<td colspan="3">
 				<c:forEach var="site" items="${siteList}" varStatus="status">
					<c:set var="siteId"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
					<input type="checkbox" id="siteNmes${status.count}" name="siteId" value="${siteId}" <c:if test="${fn:indexOf(result.siteId, siteId) ne -1}">checked</c:if> />
				 	${site.siteDesc}
					<c:if test="${status.count % 3 == 0}"><br/></c:if>
				</c:forEach>
				<br/>
			</td>
		</tr> --%>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>이미지</th>
			<td colspan="3" >
				<c:if test="${not empty fileVO }">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" width="200" alt="${fileVO.fileCn}"/>
					<input type="hidden" name="nowAtchFileId" value="${fileVO.atchFileId}"/>
					<input type="hidden" name="nowFileSn" value="${fileVO.fileSn}"/>
				</c:if>
				<div>
					<input type="file" name="imgFile_1" title="로고이미지 선택">
					<input type="hidden" name="width" value="150"/>
					<input type="hidden" name="height" value="140"/>
					<input name="fileCn_imgFile_1" id="fileCn_imgFile_1" type="text" class="w80p" value="${not empty fileVO ? fileVO.fileCn : ''}" placeholder="대체 텍스트를 입력하세요.">
				</div>
			</td>
		</tr>
		<%-- <tr>
			<th class="row"><span class="req"><span class="sr-only">필수입력</span></span>링크타입</th>
			<td colspan="3">
				<label><input type="radio" id="linkTyCd1" name="linkTyCd" value="N" <c:if test="${result.linkTyCd eq 'N'}"> checked</c:if> checked/> 이미지맵</label>
				<label><input type="radio" id="linkTyCd2" name="linkTyCd" value="I" <c:if test="${result.linkTyCd eq 'I'}"> checked</c:if> /> 이미지링크</label>
				<label><input type="radio" id="link3" name="link" value="M" <c:if test="${result.link eq 'M'}"> checked</c:if> /> MAP링크</label>
			</td>
		</tr> --%>
		<tr id="urladTr">
			<th class="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="urlad">이미지링크 </label></th>
			<td colspan="3">
				<label><input type="radio" name="linkTyCd" value="I" ${result.linkTyCd eq 'I' ? 'checked="checked"' : ''}> 내부</label>
				<label><input type="radio" name="linkTyCd" value="E" ${empty result or result.linkTyCd eq 'E' ? 'checked="checked"' : ''}> 외부</label>
				<div class="ra">
					<button type="button" class="b-select innerLinkPopup" <c:if test="${empty result or result.linkTyCd eq 'E'}">style="display:none;"</c:if> title="새창열림">내부링크선택</button>
					<input type="text" title="경로" id="urlad" name="urlad" value="${result.urlad}" class="w70p" <c:if test="${result.linkTyCd eq 'I'}">readonly="readonly"</c:if> />
					<div class="inputDeco"><p id="urladDesc"></p></div>
				</div>
				<script>
				$("input[name=urlad]").blur(function() {
					if ($('#urlad').val()!='') {
						var regexp=/(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi;
						if(!regexp.test($('#urlad').val())){
							$('#urlad').focus();
							$("#urladDesc").text("URL을 형식에 맡게 입력해주세요.");
							return false;
						}
						else {
							$("#urladDesc").text("");
						}
					}
				});
				</script>
				<p class="help">외부링크의 경우 반드시 <em>http://</em>를 입력하셔야 합니다</p>
			</td>
		</tr>
		<%-- <tr id="map">
			<th class="row"><label for="popupCn"><span class="req"><span>필수입력</span></span>맵정보</label></th>
			<td colspan="3">
				&lt;map name=&quot;popMap&quot;&gt;
				<textarea rows="5" cols="60" name="popupCn" id="popupCn" style="height:80px">${result.map}</textarea>
				&lt;/map&gt;
          		<p class="mt5">
          		<b>입력예제 :</b> &lt;area shape=&quot;rect&quot; coords=&quot;좌표값&quot; href=&quot;링크&quot; target=&quot;_blank&quot; &gt;
          		</p>
			</td>
		</tr> --%>

		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>팝업사용여부</th>
			<td colspan="3">
				<input type="radio" name="useAt" id="useAt1" class="input_radio" value="Y" <c:if test="${empty result or result.useAt == 'Y'}"> checked</c:if> /> <label for="useAt1">사용</label>
				<input type="radio" name="useAt" id="useAt2" class="input_radio" value="N" <c:if test="${result.useAt == 'N'}"> checked</c:if> /> <label for="useAt2">사용하지않음</label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>스크롤사용여부</th>
			<td colspan="3">
				<input type="radio" name="scrlUseAt" id="scrlUseAt1" class="input_radio" value="Y" <c:if test="${empty result or result.scrlUseAt == 'Y'}"> checked</c:if> /> <label for="scrlUseAt1">사용</label>
				<input type="radio" name="scrlUseAt" id="scrlUseAt2" class="input_radio" value="N" <c:if test="${result.scrlUseAt == 'N'}"> checked</c:if> /> <label for="scrlUseAt2">사용하지않음</label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>하루창닫기</th>
			<td colspan="3">
				<input type="radio" name="closeUseAt" id="closeUseAt1" class="input_radio" value="Y" <c:if test="${empty result or result.closeUseAt == 'Y'}"> checked</c:if> /> <label for="closeUseAt1">사용</label>
				<input type="radio" name="closeUseAt" id="closeUseAt2" class="input_radio" value="N" <c:if test="${result.closeUseAt == 'N'}"> checked</c:if> /> <label for="closeUseAt2">사용하지않음</label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span>노출기간</th>
			<td>
				<input type="text" name="bgnde" id="bgnde" class="sdate" value="<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd"/>" title="노출 시작일" readonly="readonly">
				~
				<input type="text" name="endde" id="endde" class="edate" value="<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd"/>" title="노출 종료일" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="arValue">넓이(WIDTH) </label></th>
			<td>
				<input type="text" name="arValue" id="arValue" style="width:100px" value="${result.arValue}" onkeyup="this.value=check_txt(this.value, 'N')"/> px
			</td>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="hgValue">높이(HEIGHT) </label></th>
			<td>
				<input type="text" name="hgValue" id="hgValue" style="width:100px" value="${result.hgValue}" onkeyup="this.value=check_txt(this.value, 'N')"/> px
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="upendCrdnt1">팝업위치(TOP) </label></th>
			<td>
				<input type="text" name="upendCrdnt" id="upendCrdnt1" style="width:100px" value="${result.upendCrdnt}" onkeyup="this.value=check_txt(this.value, 'N')"/> px
			</td>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="lftCrdnt">팝업위치(LEFT) </label></th>
			<td>
				<input type="text" name="lftCrdnt" id="lftCrdnt" style="width:100px" value="${result.lftCrdnt}" onkeyup="this.value=check_txt(this.value, 'N')"/> px
			</td>
		</tr>

		<c:if test="${empty param.pSiteId and empty result.siteId}">
		<tr>
			<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> 사이트 선택 </th>
			<td colspan="3" >
				<input type="hidden" id = "siteIdSe" name="siteIdSe" value="${result.siteIdSe}"/>
				<c:forEach var="site" items="${siteList}" varStatus="status">
				<label for="siteIdSe${status.index}"><input type="checkbox" id="siteIdSe${status.index}" name="siteIdSe_${site.siteId}" value="${site.siteId}" class="siteIdSe"  /> ${site.siteNm}</label>
				</c:forEach>
			</td>
		</tr>
		</c:if>

	<c:if test="${not empty result}">
		<tr>
			<th scope="row">등록일시</th>
			<td colspan="3" ><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></td>
		</tr>
	</c:if>

	</tbody>
</table>
</div>
</form>

<div class="btnSet">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="b-reg" href="javascript:checkForm();"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
		<a class="b-del"  href="/bos/siteManage/popup/delete.do?popupNo=${result.popupNo}&${pageQueryString}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:otherwise>
	</c:choose>
		<a class="b-cancel" href="/bos/siteManage/popup/list.do?menuNo=${param.menuNo}&pSiteId=${param.pSiteId}"><span>취소</span></a>
</div>