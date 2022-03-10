<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- https-->
<!-- <script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> -->
<script>
//<![CDATA[
	var mode = "${empty result ? 'I' : 'M'}";
	var numberPattern = /[^0-9]/gi;
	var engPattern = /[^a-zA-Z]/gi;
	var numberEngPattern = /[^A-Za-z0-9.]/gi;
	var numberLowerEngPattern = /[^a-z0-9]/g;
	var passwordPattern = /^([a-zA-Z!@#$%^&*()_+=<>?0-9]{6,20})$/g;

	$(function () {
		//숫자만 입력 가능
		$(".numberOnly").on("keyup", function() {
			if(numberPattern.test($(this).val())){
				alert("숫자만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberPattern,"") );
			}
		});
		//영문만 입력가능
		$(".engOnly").on("keyup", function() {
			if(engPattern.test($(this).val())){
				alert("영문만 입력가능합니다.");
				$(this).val( $(this).val().replace(engPattern,"") );
			}
		});

		//숫자와 영문(소문자)만입력 가능
		$(".numLowEngOnly").on("keyup", function() {
			if(numberLowerEngPattern.test($(this).val())){
				alert("숫자와 영문(소문자)만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberLowerEngPattern,"") );
			}
		});

		//숫자와 영문만입력 가능
		$(".numberEngOnly").on("keyup", function() {
			if(numberEngPattern.test($(this).val())){
				alert("숫자와 영문만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberEngPattern,"") );
			}
		});

	});

	function checkForm() {
		var form = document.regForm;
		var v = new MiyaValidator(form);

		 /*
		 v.add("userTyCd", {
			required : true,
			trim : true
		 });
		 v.add("userNm", {
			required : true,
			trim : true
		 });
		 v.add("sexCd", {
			required: true,
			trim : true
		 },"성별");
		 v.add("brthdy", {
			required: true,
			trim : true
		 }); */
		v.add("userCpno1", {
			required: true,
			trim : true
		});
		v.add("userCpno2", {
			required: true,
			trim : true
		});
		v.add("userCpno3", {
			required: true,
			trim : true
		});

		if ($("[name='userTelno1']").val() != "" || $("[name='userTelno2']").val() != "" || $("[name='userTelno3']").val() != "") {
			v.add("userTelno1", {
				required: true,
				trim : true
			});
			v.add("userTelno2", {
				required: true,
				trim : true
			});
			v.add("userTelno3", {
				required: true,
				trim : true
			});
		}

		v.add("userZip", {
			required : true
		});
		v.add("userAdres1", {
			required : true
		});
		/* v.add("userEmad1", {
			required : true
		});
		v.add("userEmad2", {
			required : true
		}); */

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			form.submit();
		}

	}

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
			document.getElementById('userZip').value = data.zonecode; //5자리 새우편번호 사용
			document.getElementById('userAdres1').value = fullRoadAddr;
		}
	}).open();
}

function delFile2(atchFileId, fileSn, bbsId, fileId) {
	$.getJSON(
		"/bos/cmmn/file/deleteFileInfs.json",
		{
			atchFileId : atchFileId,
			fileSn : fileSn,
			bbsId : bbsId
		},
		function(data) {
			var jdata = data.resultCode;
			if (jdata == 'success') {
				alert("성공적으로 삭제하였습니다.");
				$("#" + fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/>");
			} else
				alert("삭제에 실패하였습니다.");
		});
}

//]]>
</script>
<form name="regForm" id="regForm" method="post" action="/bos/member/user/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="userId" value="${result.userId}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'/>
	<input type="hidden" id="atchFileId" name="atchFileId" value="${fn:trim(result.atchFileId)}">
	<h4 class="bu_t1">기본정보</h4>
	<div class="view">
		<%-- <dl>
			<dt>회원구분</dt>
			<dd>
				<select name="userTyCd" id="userTyCd" title="회원구분을 선택해 주세요.">
					<option value="">회원구분 선택</option>
					<c:forEach var="code" items="${userTyCdCodeList }">
						<option value="${code.cd }" <c:if test="${result.userTyCd == code.cd}">selected="selected"</c:if> >${code.cdNm }</option>
					</c:forEach>
				</select>
			</dd>
		</dl> --%>
		<dl>
			<dt>아이디</dt>
			<dd>
				${result.userId}
			</dd>
		</dl>
		<dl>
			<dt>이름</dt>
			<dd>
				${result.userNm}
			</dd>
		</dl>
		<dl>
			<dt>성별</dt>
			<dd>
				${result.sexCdNm }
			</dd>
		</dl>
		<dl>
			<dt>생년월일</dt>
			<dd>
				${result.brthdy }
			</dd>
		</dl>
		<dl>
		<c:if test="${not empty result.userTelno }">
			<c:set var="data" value="${fn:split(result.userTelno,'-')}" />
		</c:if>
			<dt>전화번호</dt>
			<dd>
				<select name="userTelno1" id="userTelno1" title="전화번호 앞자리" >
					<option value="" >선택</option>
					<c:forEach var="item" items="${telno1CdCodeList }" varStatus="status">
					<option value="${item.cd }" <c:if test="${item.cd eq data[0]}">selected="selected"</c:if>>${item.cdNm }</option>
					</c:forEach>
				</select>
				-
				<input type="text" value="${data[1]}" id="userTelno2" name="userTelno2" class="tel numberOnly" title="전화번호 중간자리를 입력하세요." maxlength="4" />
				-
				<input type="text" value="${data[2]}" id="userTelno3" name="userTelno3" class="tel numberOnly" title="전화번호 끝자리를 입력하세요." maxlength="4" />
				<c:remove var="data"/>
			</dd>
		</dl>
		<dl>
			<dt>휴대전화</dt>
			<dd>
			<c:if test="${not empty result.userCpno }">
				<c:set var="data" value="${fn:split(result.userCpno,'-')}" />
			</c:if>
					<select name="userCpno1" id="userCpno1" title="휴대전화 앞자리를 선택해 주세요." >
						<option value="">선택</option>
						<c:forEach var="item" items="${cpno1CdCodeList }" varStatus="status">
							<option value="${item.cd }" <c:if test="${item.cd eq data[0]}">selected="selected"</c:if>>${item.cdNm }</option>
						</c:forEach>
					</select>
					-
					<input type="text" id="userCpno2" name="userCpno2" class="tel numberOnly" value="${data[1]}" title="휴대전화 중간자리를 입력하세요." maxlength="4" />
					-
					<input type="text" id="userCpno3" name="userCpno3" class="tel numberOnly" value="${data[2]}" title="휴대전화 끝자리를 입력하세요." maxlength="4" />
					<c:remove var="data"/>
			</dd>
		</dl>
		<dl>
			<dt>주소</dt>
			<dd>
				<div class="postSet">
					<span>
					<input type="text" readonly="readonly" name="userZip" id="userZip" value="${result.userZip }" title="우편번호" >
					<a href="javaScript:daumPostcodeSearch();" class="b-sh btn btn-default" title="새창열림">주소 찾기</a>
					</span>
					<span><input type="text" class="w100p" name="userAdres1" title="주소" id="userAdres1" value="${result.userAdres1 }"  ></span>
					<span><input type="text" class="w100p" name="userAdres2" title="상세주소" id="userAdres2" value="${result.userAdres2 }" ></span>
				</div>
			</dd>
		</dl>
		<dl>
			<dt>이메일</dt>
			<dd>${result.userEmad }
			<%-- <c:if test="${not empty result.userEmad }">
				<c:set var="data" value="${fn:split(result.userEmad,'@')}" />
			</c:if>
				<input name="userEmad1" id="userEmad1" type="text" title="이메일 아이디" class="emailId numberEngOnly" value="${data[0]}" />
				@
				<input name="userEmad2" id="userEmad2" type="text" title="이메일 도메인" value="${data[1]}" class="emailAddr emaildomain_form numberEngOnly" />
				<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
				<select id="sr_email_more" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
					<option selected="selected">메일주소선택</option>
					<c:forEach var="item" items="${emadCdCodeList }" varStatus="status">
						<option value="${item.cd }" <c:if test="${item.cd eq data[1]}">selected="selected"</c:if>>${item.cdNm }</option>
					</c:forEach>
					<option value="emaildomain_false">직접입력</option>
				</select>
				<script>
				//<![CDATA[
				jQuery(function(){
					$('select.select_email_js').on('change',function() {
						if ($(this).val()=='emaildomain_false') {
							$('.emaildomain_form:text[name=userEmad2]').val('');
							$('.emaildomain_form').attr('readonly',false).focus();
						}else{
							$('.emaildomain_form:text[name=userEmad2]').val('');
							$('.emaildomain_form:text[name=userEmad2]').val($(this).val());
							$('.emaildomain_form').attr('readonly',true);
						}
					});
				});
				//]]>
				</script>
				<c:remove var="data"/> --%>
			</dd>
		</dl>
	</div>
</form>

<div class="btnSet">
	<a class="b-reg" href="javascript:checkForm();">${empty result ? '등록' : '수정'}</a>
	<a class="b-cancel" href="/bos/member/user/list.do?${pageQueryString}">취소</a>
</div>