<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/siteManage/siteInfo/insert.do" />
	<c:set var="actionNm" value="등록" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/siteManage/siteInfo/update.do" />
	<c:set var="actionNm" value="수정" />
</c:if>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		v.add("pSiteId", {
	        required: true
	    });
		v.add("siteNm", {
	        required: true
	    });

<c:if test="${empty fileVO }">
		if (form.imgFile_1){
			v.add("imgFile_1", {
		        required: true
		    });
		}
</c:if>

		if (form.fileCn_imgFile_1){
		v.add("fileCn_imgFile_1", {
	        required: true
	    });
		}
		if (form.siteUrlad.value!="") {
		    v.add("siteUrlad", {
		    	required: true,
		    	pattern: /(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi,
				message: "URL을 형식에 맞게 입력해주세요."
		    });
		}

		if (form.insttNmUseAt.value=='Y'){
			v.add("insttNm", {
		        required: true
		    });
		}
		if (form.zipUseAt.value=='Y'){
			v.add("zip", {
		        required: true
		    });
		}
		if (form.adres1UseAt.value=='Y'){
			v.add("adres1", {
		        required: true
		    });
		}
		if (form.telnoUseAt.value=='Y'){
			v.add("telno", {
		        required: true
		    });
		}
		if (form.faxnoUseAt.value=='Y'){
			v.add("faxno", {
		        required: true
		    });
		}
		if (form.cpyrhtCnUseAt.value=='Y'){
			v.add("cpyrhtCn", {
		        required: true
		    });
		}

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

/* 		if (form.siteUrlad.value.indexOf("http://") && form.siteUrlad.value.indexOf("https://")) {
			alert("홈페이지 URL은 'http://' 부터 입력하셔야 합니다.");
			form.siteUrlad.focus();
			return;
		} */

		//siteId 가 있는지 ajax 체크
		var siteId = $("#pSiteId").val();
		$.post(
			"/bos/siteManage/siteInfo/cnfirmSiteId.json",
			{pSiteId : siteId},
			function(data) {
				var resultCnt = data.resultCnt;
				if (resultCnt == 0 || '${actionNm}' =="수정"){
					if (!confirm('${actionNm}하시겠습니까?')) {
						return;
					}

					form.submit();
				}else{
					alert("사이트ID가 중복입니다.");
					return;
				}
			}
		);


		return ;

	}

	// 체크함수 (N : 숫자만 , NP : 숫자 + . , NA : 숫자 + 영어)
	function check_txt(value, type) {
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
				alert("한글은 사용할 수 없습니다.");
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

	//푸터영역 필드 사용 토글 처리
	$(document).ready(function() {
		$(".b-use, .b-notuse").on('click',function() {
			var sFieldNm = $(this).attr("name");
			var sVal = $(this).val();
			var sStyle = sVal=="Y" ? "b-notuse" : "b-use";
			//alert($(this).attr("class"));

			$.getJSON(
				"/bos/siteManage/siteInfo/useYnChange.json",
				{fieldNm : sFieldNm, val : sVal, pSiteId:"${paramVO.pSiteId}"},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {

		            	//$("#"+sFieldNm).toggleClass("b-use btn btn-default", "b-notuse btn btn-default");
		            	//$("#"+sFieldNm).text(sVal=="Y" ? "미사용중" : "사용중");
		            	//$("#"+sFieldNm).val(sVal=="Y" ? "N" : "Y")
		            	//alert($(this).name());
		            	location.reload();
		            }
		            else alert("반영에 실패하였습니다.");
				}
			);
		});
	});


	//다음 우편번호 찾기
	function daumPostcodeSearch() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('adres1').value = fullRoadAddr;
			}
		}).open();
	}
</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
<input type="hidden" name="menuNo" value="${param.menuNo}" />
<input type="hidden" name="viewType" value="${param.viewType}" />
<input type="hidden" name="csrfToken" value="${csrfToken}"/>

<h2>홈페이지 기본정보</h2>
<div class="view">
	<c:if test="${empty paramVO.pSiteId}">
	<dl>
		<dt><label for="pSiteId"><span class="req"><span class="sr-only">필수입력</span></span>홈페이지ID</label></dt>
		<dd><input type="text" name="pSiteId" id="pSiteId"  class="w30p" value="${result.siteId}" ${not empty result ? "readonly" : "" } onkeyup = "this.value=check_txt(this.value, 'NA')" /></dd>
	</dl>
	</c:if>
	<dl>
		<dt><label for="siteNm"><span class="req"><span class="sr-only">필수입력</span></span>홈페이지명</label></dt>
		<dd>
			<c:if test="${not empty paramVO.pSiteId}">
			<input type="hidden" name="pSiteId" id="pSiteId"  class="w30p" value="${result.siteId}" />
			</c:if>
			<input type="text" name="siteNm" id="siteNm"  class="w30p" value="${result.siteNm}" />
		</dd>
	</dl>
	<dl>
		<dt><label for="siteUrlad">홈페이지 URL</label></dt>
		<dd>
			<input type="text" name="siteUrlad" id="siteUrlad"  class="w100p" value="${result.siteUrlad}" />
			<p class="help">http://부터 입력하셔야 합니다.</p>
		</dd>
	</dl>
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span>만족도</dt>
		<dd>
			<label for="stsfdgUseAtY"><input type="radio" name="stsfdgUseAt" id="stsfdgUseAtY" value="Y" ${result.stsfdgUseAt eq 'Y' ? 'checked="true"' : ''}/> 사용</label>
			<label for="stsfdgUseAtN"><input type="radio" name="stsfdgUseAt" id="stsfdgUseAtN" value="N" ${result.stsfdgUseAt ne 'Y' ? 'checked="true"' : ''}/> 미 사용</label>
		</dd>
	</dl>
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span>자료관리자</dt>
		<dd>
			<label for="dtaMngrUseAtY"><input type="radio" name="dtaMngrUseAt" id="dtaMngrUseAtY" value="Y" ${result.dtaMngrUseAt eq 'Y' ? 'checked="true"' : ''}/> 사용</label>
			<label for="dtaMngrUseAtN"><input type="radio" name="dtaMngrUseAt" id="dtaMngrUseAtN" value="N" ${result.dtaMngrUseAt ne 'Y' ? 'checked="true"' : ''}/> 미 사용</label>
		</dd>
	</dl>
	<c:if test="${param.pSiteId eq 'bos'}">
	<dl>
		<dt><label for="siteSkinCd">스킨 설정</label></dt>
		<dd>
		<c:set var="skinList" value="${siteSkinCdCodeList}"/>
		<select name="siteSkinCd" id="siteSkinCd">
			<option value="">기본 스킨</option>
			
			<%-- <c:out value="${fn:length(skinList)-1}"></c:out> --%>
			
			<%-- <c:forEach var="i" begin="0" end="${fn:length(skinList)-1}"> --%>
			<%-- <option value="${skinList[i].cd}" ${skinList[i].cd eq result.siteSkinCd ? ' selected="selected"' : ''}>${skinList[i].cdNm}</option> --%>
			<%-- </c:forEach> --%> 
		</select>
		</dd>
	</dl>
	<dl>
		<dt><label for="accesIpad"><span class="req"><span class="sr-only">필수입력</span></span> 접근IP</label></dt>
		<dd><textarea name="accesIpad" id="accesIpad" cols="70" rows="2" class="w100p">${result.accesIpad}</textarea></dd>
	</dl>
	<dl>
		<dt><label for="workBgntm1">업무시간 설정</label></dt>
		<dd>
			<select name="workBgntm1" id="workBgntm1">
				<c:set var="data1" value="${fn:split(result.workBgntm,':')}" />
				<option value="">업무시작 시간</option>
				<c:forEach var="i" begin="1" end="24" step="1">
					<c:set var="str" value=""/>
					<c:if test="${i < 10}">
						<c:set var="str" value="0"/>
					</c:if>
					<option value="${str}${i}" ${i eq data1[0] ? ' selected="selected"' : ''}>${str}${i}</option>
				</c:forEach>
			</select>
			:
			<select name="workBgntm2" id="workBgntm2">
				<option value="">업무시작 분${data1[1]}</option>
				<c:forEach var="i" begin="0" end="55" step="5">
					<c:set var="str" value=""/>
					<c:if test="${i < 10}">
						<c:set var="str" value="0"/>
					</c:if>
					<option value="${str}${i}" ${i eq data1[1] ? ' selected="selected"' : ''}>${str}${i}</option>
				</c:forEach>
			</select>
			~
			<select name="workEndtm1" id="workEndtm1">
				<c:set var="data2" value="${fn:split(result.workEndtm,':')}" />
				<option value="">업무종료 시간</option>
				<c:forEach var="i" begin="1" end="24" step="1">
					<c:set var="str" value=""/>
					<c:if test="${i < 10}">
						<c:set var="str" value="0"/>
					</c:if>
					<option value="${str}${i}" ${i eq data2[0] ? ' selected="selected"' : ''}>${str}${i}</option>
				</c:forEach>
			</select>
			:
			<select name="workEndtm2" id="workEndtm2">
				<option value="">업무종료 분</option>
				<c:forEach var="i" begin="0" end="55" step="5">
					<c:set var="str" value=""/>
					<c:if test="${i < 10}">
						<c:set var="str" value="0"/>
					</c:if>
					<option value="${str}${i}" ${i eq data2[1] ? ' selected="selected"' : ''}>${str}${i}</option>
				</c:forEach>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span>추가인증 사용여부</dt>
		<dd>
			<label for="adtCrtfcUseAtY"><input type="radio" name="adtCrtfcUseAt" id="adtCrtfcUseAtY" value="Y" ${result.adtCrtfcUseAt eq 'Y' ? 'checked="true"' : ''}/> 사용</label>
			<label for="adtCrtfcUseAtN"><input type="radio" name="adtCrtfcUseAt" id="adtCrtfcUseAtN" value="N" ${result.adtCrtfcUseAt ne 'Y' ? 'checked="true"' : ''}/> 미 사용</label>
		</dd>
	</dl>
	</c:if>
	<c:if test="${param.pSiteId ne 'bos'}">
	<dl>
		<dt><label for="waValidUseAt"><span class="req"><span class="sr-only">필수입력</span></span>웹접근성 유효성 사용여부</label></dt>
		<dd>
			<label for="waValidUseAtY"><input type="radio" name="waValidUseAt" id="waValidUseAtY" value="Y" ${result.waValidUseAt eq 'Y' ? 'checked="true"' : ''}/> 사용</label>
			<label for="waValidUseAtN"><input type="radio" name="waValidUseAt" id="waValidUseAtN" value="N" ${result.waValidUseAt ne 'Y' ? 'checked="true"' : ''}/> 미 사용</label>
		</dd>
	</dl>
	</c:if>



	<!--
	<dl>
		<dt>사이트설명</dt>
		<dd>
			<input type="text" name="siteDc" id="siteDc"  class="w100p" value="${result.siteDc}" />
		</dd>
	</dl>
	 -->
</div>

<h2>홈페이지 로고 변경</h2>
<div class="view">
	<dl>
		<dt><span class="req"><span class="sr-only">필수입력</span></span>로고이미지</dt>
		<dd>
			<c:if test="${not empty fileVO }">
				<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" width="110" height="40" alt="${fileVO.fileCn}"/>
				<input type="hidden" name="nowAtchFileId" value="${fileVO.atchFileId}"/>
				<input type="hidden" name="nowFileSn" value="${fileVO.fileSn}"/>
				<input type="hidden" name="width" value="110"/>
				<input type="hidden" name="height" value="40"/>
			</c:if>

			<div>
				<input type="file" name="imgFile_1" title="로고이미지 선택">
			</div>
			<p class="help">
				권장사이즈 : <em>110px * 40px</em>
			</p>
		</dd>
	</dl>
	<dl>
		<dt><label for="fileCn_imgFile_1"><span class="req"><span>필수입력</span></span>로고이미지 대체텍스트</label></dt>
		<dd><input name="fileCn_imgFile_1" id="fileCn_imgFile_1" type="text" class="w100p" value="${fileVO.fileCn}" placeholder="이미지와 동등한 텍스트를 입력하세요."></dd>
	</dl>
</div>

<h2>Footer 영역 관리</h2>
<div class="view view-type2">
	<dl>
		<dt><label for="insttNm">기관명</label></dt>
		<dd><input type="text" name="insttNm" id="insttNm" value="${result.insttNm}" class="w100p" title="기관명"></dd>
		<dd>
			<label for="insttNmUseAtY"><input type="radio" name="insttNmUseAt" id="insttNmUseAtY" value="Y" ${result.insttNmUseAt eq 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">기관명 </span>사용중</label>
			<label for="insttNmUseAtN"><input type="radio" name="insttNmUseAt" id="insttNmUseAtN" value="N" ${result.insttNmUseAt ne 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">기관명 </span>미사용중</label>
		</dd>
	</dl>
	<dl>
		<dt>주소</dt>
		<dd class="tal">
			<div class="postSet">
				<span>
				<input type="text" name="zip" id="zip" value="${result.zip}" class="post" title="우편번호" readonly="true"/>
				<a href="javaScript:daumPostcodeSearch();" class="b-sh" title="새창열림">주소 찾기</a>
				</span>
				<span><input type="text" name="adres1" id="adres1" value="${result.adres1}" class="w100p" title="기본주소" readonly="true"/></span>
				<span><input type="text" name="adres2" id="adres2" value="${result.adres2}" class="w100p" title="상세주소" /></span>
			</div>
		</dd>
		<dd>
			<label for="zipUseAtY"><input type="radio" name="zipUseAt" id="zipUseAtY" value="Y" ${result.zipUseAt eq 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">우편번호 </span>사용중</label>
			<label for="zipUseAtN"><input type="radio" name="zipUseAt" id="zipUseAtN" value="N" ${result.zipUseAt ne 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">우편번호 </span>미사용중</label>
			<label for="adres1UseAtY"><input type="radio" name="adres1UseAt" id="adres1UseAtY" value="Y" ${result.adres1UseAt eq 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">기본주소 </span>사용중</label>
			<label for="adres1UseAtN"><input type="radio" name="adres1UseAt" id="adres1UseAtN" value="N" ${result.adres1UseAt ne 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">기본주소 </span>미사용중</label>
			<label for="adres2UseAtY"><input type="radio" name="adres2UseAt" id="adres2UseAtY" value="Y" ${result.adres2UseAt eq 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">상세주소 </span>사용중</label>
			<label for="adres2UseAtN"><input type="radio" name="adres2UseAt" id="adres2UseAtN" value="N" ${result.adres2UseAt ne 'Y' ? 'checked="checked"' : ''}/><span class="sr-only">상세주소 </span>미사용중</label>
		</dd>
	</dl>
	<dl>
		<dt><label for="telno">전화번호</label></dt>
		<dd><input type="text" name="telno" id="telno" value="${result.telno}" class="w100p" title="전화번호"></dd>
		<dd>
			<label for="telnoUseAtY"><input type="radio" name="telnoUseAt" id="telnoUseAtY" value="Y" ${result.telnoUseAt eq 'Y' ? 'checked="checked"' : ''}/>사용중</label>
			<label for="telnoUseAtN"><input type="radio" name="telnoUseAt" id="telnoUseAtN" value="N" ${result.telnoUseAt ne 'Y' ? 'checked="checked"' : ''}/>미사용중</label>
		</dd>
	</dl>
	<dl>
		<dt><label for="faxno">팩스번호</label></dt>
		<dd><input type="text" name="faxno" id="faxno" value="${result.faxno}" class="w100p" title="팩스번호"></dd>
		<dd>
			<label for="faxnoUseAtY"><input type="radio" name="faxnoUseAt" id="faxnoUseAtY" value="Y" ${result.faxnoUseAt eq 'Y' ? 'checked="checked"' : ''}/>사용중</label>
			<label for="faxnoUseAtN"><input type="radio" name="faxnoUseAt" id="faxnoUseAtN" value="N" ${result.faxnoUseAt ne 'Y' ? 'checked="checked"' : ''}/>미사용중</label>
		</dd>
	</dl>
	<dl>
		<dt><label for="cpyrhtCn">Copyright</label></dt>
		<dd><input type="text" name="cpyrhtCn" id="cpyrhtCn" value="${result.cpyrhtCn}" class="w100p" title="Copyright"></dd>
		<dd>
			<label for="cpyrhtCnUseAtY"><input type="radio" name="cpyrhtCnUseAt" id="cpyrhtCnUseAtY" value="Y" ${result.cpyrhtCnUseAt eq 'Y' ? 'checked="checked"' : ''}/>사용중</label>
			<label for="cpyrhtCnUseAtN"><input type="radio" name="cpyrhtCnUseAt" id="cpyrhtCnUseAtN" value="N" ${result.cpyrhtCnUseAt ne 'Y' ? 'checked="checked"' : ''}/>미사용중</label>
		</dd>
	</dl>
</div>



</form>


	<div class="btnSet">
	<c:choose>
	<c:when test="${empty result}" >
		<a class="b-reg" href="javascript:checkForm();"><span>${actionNm}</span></a>
	</c:when>
	<c:otherwise>
		<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
		<c:if test="${paramVO.viewType ne 'VIEW'}"><a class="b-del"  href="/bos/siteManage/siteInfo/delete.do?pSiteId=${result.siteId}&menuNo=${param.menuNo}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a></c:if>
	</c:otherwise>
	</c:choose>
		<c:if test="${paramVO.viewType ne 'VIEW'}">
		<a class="b-cancel" href="/bos/siteManage/siteInfo/list.do?menuNo=${param.menuNo}"><span>취소</span></a>
		</c:if>
	</div>
