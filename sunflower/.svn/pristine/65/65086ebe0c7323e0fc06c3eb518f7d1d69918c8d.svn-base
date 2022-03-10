<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="siteId" value="${paramVO.siteId}"/>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />
<spring:eval expression="@prop['Globals.ucms.siteSeCd']" var="siteSeCd" scope="request" />

<script src="/static/jslibrary/miya_validator.js"></script>
<script>
var chldCrtfcAt = "${param.chldCrtfcAt}";
var userEmad = "";
var checkEmailCount = 0;
var emailVal = "";


/*	이메일 인증시 */
/*
function formChk() {
	var form = $("#frm")[0];
	var v = new MiyaValidator(form);

	v.add("userEmad1", {
        required: true,
		span: 2,
       	glue: "@",
       	option: "email"
    });

    var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}

	userEmad = $("#userEmad1").val()+"@"+$("#userEmad2").val();

	$.post(
		"/${siteId}/member/user/crtfcEmailRequest.json",
		{userEmad : userEmad},
		function(data) {
			if (data.resultCode == "success") {
				alert("이메일이 발송되었습니다.\n인증코드를 확인바랍니다.");
				emailVal = userEmad;
				$("#hideCrtfcCd").val(data.crtfcCd);
				//$("#crtfcCd").val(data.crtfcCd);
			}
			else {
				alert("이미 가입된 이메일입니다.");
			}
		},"json"
	);
	return false;
}

function crtfcChk(form) {
	var v = new MiyaValidator(form);

	if ($("#hideCrtfcCd").val() == "") {
		alert("인증코드를 발송해주세요.");
		return false;
	}

	v.add("crtfcCd", {
		required : true
	});

    var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}

	userEmad = $("#userEmad1").val()+"@"+$("#userEmad2").val();
	if (userEmad != emailVal) {
		alert("입력된 이메일과 인증된 이메일이 일치하지 않습니다.");
		return false;
	}

	if ($("#hideCrtfcCd").val() != $("#crtfcCd").val()) {
		alert("이메일 인증코드가 일치하지 않습니다.");
		return false;
	}

	$("#retUrl").val(returnUrl);
	$("#userEmad").val(userEmad);
	return true;
} */
</script>

<c:import url="/WEB-INF/jsp/${siteId}/member/user/joinStepNav.jsp"/>

<div class="plist">
	<p>
		2006년 9월 25일부터 개정된 '주민등록법'에 의해 타인의 주민등록번호를 도용하여 온라인 회원가입을 하는 등 다른 사람의 주민등록번호를
		부정사용하는자는 3년 이하의 징역 또는 1천만원 이하의 벌금이 부과될 수 있습니다.
		- 관련 법률 : 주민등록법 제21조(벌칙)제2항9호(시행일 2006. 9. 24) -
	</p>
</div>
<form action="/${siteId }/member/user/vnameOutput.do" name="frm" id="frm" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<input type="hidden" name="retUrl" id="retUrl" value="" />
	<input type="hidden" name="chldCrtfcAt" value="${empty param.chldCrtfcAt ? 'N' : 'Y' }" />
	<input type="hidden" name="chldBrthdy" id="chldBrthdy" />
	<input type="hidden" name="viewType" value="BODY" />
	<input type="hidden" id="hideCrtfcCd" />
	<input type="hidden" name="userEmad" id="userEmad" />
	<input type="hidden" name="authTp" id="authTp" value="A"/>
	<input type="hidden" name="siteId" id="siteId" value="${siteId }"/>

	<!-- 실명인증시 필요한 데이터 -->
	<!-- 핸드폰 인증 -->
	<input type="hidden" name="m" > <!-- 필수 데이타로, 누락하시면 안됩니다. -->
	<input type="hidden" name="EncodeData" value="${sEncPhoneData}">
	<!-- 핸드폰 인증 -->

	<!-- I-PIN 인증 -->
	<input type="hidden" name="enc_data" value="${sEncIpinData}">
	<input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
    <!-- I-PIN 인증 -->
	<!-- 실명인증시 필요한 데이터 -->

	<%-- 이메일 인증시 사용
	<h2 class="bu_t1">이메일 인증</h2>
	<div class="reqInfor"><span class="req"><span>필수입력</span></span>이메일 본인인증이 필요합니다.</div>
	<div class="view">
		<dl>
			<dt><label for="userEmad1"><span class="req"><span>필수입력</span></span> 이메일</label></dt>
			<dd>
				<input id="userEmad1" type="text" title="이메일 아이디" class="emailId">
				@
				<input id="userEmad2" type="text" title="이메일 주소" value="" readonly="readonly" class="emailAddr emailDomainForm">
				<select id="sr_email_more" name="" class="input_select select_email_js" title="직접입력 선택시 자동활성화&amp;포커스 이동">
					<option value="">메일주소선택</option>
					<c:forEach var="item" items="${emadCdCodeList }" varStatus="status">
	    				<option value="${item.cd }" <c:if test="${item.cd eq data[1]}">selected="selected"</c:if>>${item.cdNm }</option>
 					</c:forEach>
					<option value="emaildomain_false" selected="selected">직접입력</option>
				</select>
		    	<button type="button" onclick="formChk();" class="b-ok">인증코드 발송</button>
				<script>
				jQuery(function(){
					if ($('select.select_email_js').val() == 'emaildomain_false') jQuery('.emailDomainForm').attr('readonly',false);
					jQuery('select.select_email_js').on('change',function() {
						if (jQuery(this).val()=='emaildomain_false') {
							jQuery('.emailDomainForm:text[id=userEmad2]').val('');
							jQuery('.emailDomainForm').attr('readonly',false).focus();
						}
						else {
							jQuery('.emailDomainForm:text[id=userEmad2]').val('');
							jQuery('.emailDomainForm:text[id=userEmad2]').val(jQuery(this).val());
							jQuery('.emailDomainForm').attr('readonly',true);
						}
					});
				});
				</script>
			</dd>
		</dl>
		<dl>
			<dt><label for="crtfcCd"><span class="req"><span>필수입력</span></span> 이메일 인증코드</label></dt>
			<dd>
				<input type="text" name="crtfcCd" id="crtfcCd">
			</dd>
		</dl>
	</div> --%>

	<%-- <div class="tac mt20">
		<input type="submit" value="다음단계로 이동" class="b-ok btn-info" />
		<a href="/${siteId }/main/main.do" class="b-cancel btn btn-default">가입취소</a>
	</div> --%>

	<jsp:include page="/WEB-INF/jsp/ucms/member/user/certify.jsp" flush="true" >
		<jsp:param name="siteId" value="${siteId}"  />
		<jsp:param name="siteSeCd" value="${siteSeCd}"  />
		<jsp:param name="returnUrl" value="/${siteId}/member/user/joinInput.do?menuNo=${param.menuNo}" />
	</jsp:include>
</form>

<%--
	<!-- 어린이회원 등록폼 -->
	<c:if test="${param.chldCrtfcAt eq 'Y'}">
		<h2 class="bu_t1">가입자(아동) 기본정보</h2>
		<div class="reqInfor"><span class="req"><span>필수입력</span></span>이름과 생년월일을 정확히 입력하여 주십시오. 14세 미만 가입의 경우 법정대리인(부모)의 본인인증이 필요합니다.</div>
		<div class="view">
			<dl>
				<dt><label for="chldUserNm"><span class="req"><span>필수입력</span></span> 가입자 이름</label></dt>
				<dd>
					<input type="text" name="chldUserNm" id="chldUserNm">
				</dd>
			</dl>
			<dl>
				<dt><label for="joinMan"><span class="req"><span>필수입력</span></span> 가입자 성별</label></dt>
				<dd>
					<span class="radiobox"><input type="radio" name="chldSexCd" value="M" id="joinMan" ><label for="joinMan">남</label></span>
					<span class="radiobox"><input type="radio" name="chldSexCd" value="F" id="joinWoman" ><label for="joinWoman">여</label></span>
				</dd>
			</dl>
			<dl>
				<dt><label for="chldBrthdyYear"><span class="req"><span>필수입력</span></span> 가입자 생년월일</label></dt>
				<dd>
					<select name="chldBrthdyYear" id="chldBrthdyYear" title="생년월일 년도">
						<option value="">선택</option>
						<c:forEach begin="${yearToday - 14 }" end="${yearToday }" var="year"  varStatus="status" >
							<option value="${year }">${year }</option>
						</c:forEach>
					</select> 년
					<input type="text" name="chldBrthdyMt" id="chldBrthdyMt" maxlength="2" title="생년월일 월" style="width:60px" /> 월
					<input type="text" name="chldBrthdyDe" id="chldBrthdyDe" maxlength="2" title="생년월일 일" style="width:60px" /> 일
				</dd>
			</dl>
		</div>
	</c:if>
--%>

