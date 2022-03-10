<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<c:set var="siteId" value="${paramVO.siteId}"/>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script src="/static/jslibrary/miya_validator.js"></script>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
var title = document.title;
document.title = "정보입력 " + title;

var idChk = $("#userId").val();
var checkIdCount = 0;
var idVal = "";

function checkForm(form) {
	var v = new MiyaValidator(form);

	v.add("userId", {
		required : true
	});
	v.add("userId", {
		required : true,
		//pattern : "(?=.*[0-9])(?=.*[a-z])(?=\\S+$).{8,14}$",
		pattern : "^[a-z0-9]{8,14}$",
		message : "8자~14자 이하 영문 소문자, 숫자 조합으로 입력가능 합니다."
	});
	v.add("password", {
		required : true
	});
	v.add("password", {
		//pattern : "/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*+=-]).{8,14}$/",
		pattern : "(?=.*[0-9])(?=.*[a-z])(?=\\S+$).{8,14}$",
		message : "8자~14자 이하 영문 소문자, 숫자 조합으로 입력가능 합니다."
	});
	v.add("password2", {
		required : true
	});
	v.add("password2", {
		match : "password",
		message : "비밀번호가 일치하지 않습니다."
	});

	if (!ctnuCheck($('#password1').val())) { //연속성체크
		alert("3자리 연속 또는 같은 문자는 사용불가능한 비밀번호입니다.");
		$("#password1").focus();
		return false;
	}
	/* v.add("userNm", {
		required : true
	}); */

	v.add("sexCd", {
		required : true
	});

	v.add("brthdy1", {
		required : true,
     	span : 3,
       	glue : "-",
        option : "isdate"
	});

	v.add("userTelno1", {
     	span : 3,
       	glue : "-",
        option : "phone"
    });

    v.add("userCpno1", {
        required: true,
     	span : 3,
       	glue : "-",
        option : "handphone"
    });

	v.add("userZip", {
		required : true,
       	option: "number"
	});

	v.add("userAdres1", {
		required : true
	});

    /* v.add("userEmad1", {
        required: true,
		span: 2,
       	glue: "@",
       	option: "email"
    }); */

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}

	if (checkIdCount == 0 || $("#userId").val() != idVal) {
		alert("아이디 중복체크를 하셔야 합니다.");
		return false;
	}

	if (idChk == $('#password1').val()) {
		alert("아이디와 비밀번호를 같게 사용할 수 없습니다.");
		$('#password1').focus();
		return false;
	}

	if(!dplctIdPwdChk($('#password1').val())) {
		alert("아이디와 동일한 비밀번호를 사용하실수 없습니다.");
		return false;
	}

	if(!checkPrhibtWrd($('#password1').val())){
		$("#password1").focus();
		return false;
	}

	if (!confirm('가입 하시겠습니까?')) {
		return false;
	}
	return true;


}


function checkPrhibtWrd(text){
	$.ajaxSetup({
		async: false
	});

	var flag = true;
	$.post(
		"/${siteId}/member/user/checkPrhibtWrd.json",
		{chkWord : text, wrdSe : "2"},
		function(data) {
			if(data.chkWord == "Y"){
				alert("비밀번호에 ["+ data.word +"] 는(은) 사용하실 수 없는 단어입니다.");
				flag =  false;
			}else{
				flag = true;
			}
		},"json"
	);
	return flag;
}
function fnCheckId() {
	if (checkId()) {
		var userId = $("#userId").val();
		$.post("/${siteId}/member/user/checkId.json", {
			userId : userId
		}, function(data) {
			if (data.resultCode == "success") {
				if (data.posblAt == "N") {
					alert("사용하실 수 없는 아이디입니다.");
					$("#userId").val("");
					return false;
				}
				else {

					// 금지단어 체크
					$.getJSON(
						"/${siteId}/member/user/checkPrhibtWrd.json",
						{chkWord : userId, wrdSe : "1"},
						function(data) {
							if(data.chkWord == "Y"){
								alert("아이디에 ["+ data.word +"] 는(은) 사용하실 수 없는 단어입니다.");
								$("#userId").val("");
								return false;
							} else {
								alert("사용가능한 아이디입니다.");
								checkIdCount++;
								idVal = $("#userId").val();
								return false;
							}
						}
					);
				}
			}
		}, "json");
	}
}

function checkId() {
	var form = $("#frm")[0];
	var v = new MiyaValidator(form);
	v.add("userId", {
		required : true,
		//pattern : "(?=.*[0-9])(?=.*[a-z])(?=\\S+$).{8,14}$",
		pattern : "^[a-z0-9]{8,14}$",
		message : "8자~14자 이하 영문 소문자, 숫자 조합으로 입력가능 합니다."
	});

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}
	return true;
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

//패스워드 체크
function checkPwd(value) {
	checkPwdFc();
	return value;
}

//패스워드2 체크
function checkPwd2(value) {
	checkPwd2Fc();
	return value;
}

function ctnuCheck(pwdNew) {
	var SamePass_0 = 0; //동일문자 카운트
	var SamePass_1 = 0; //연속성(+) 카운트
	var SamePass_2 = 0; //연속성(-) 카운트

	var chr_pass_0;
	var chr_pass_1;
	var chr_pass_2;

	for (var i=0; i < pwdNew.length; i++) {
	    chr_pass_0 = pwdNew.charAt(i);
	    chr_pass_1 = pwdNew.charAt(i+1);
	    //동일문자 카운트
	    if (chr_pass_0 == chr_pass_1) {
	        SamePass_0 = SamePass_0 + 1;
	    }
	    chr_pass_2 = pwdNew.charAt(i+2);
	    //연속성(+) 카운드
	    if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
	        SamePass_1 = SamePass_1 + 1;
	    }
	    //연속성(-) 카운드
	    if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
	        SamePass_2 = SamePass_2 + 1;
	    }
	}
	if (SamePass_0 > 1) {
	    //alert("동일문자를 3번 이상 사용할 수 없습니다.");
	    return false;
	}
	if (SamePass_1 > 1 || SamePass_2 > 1) {
	    //alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
	    return false;
	}
	return true;
}

//동일여부체크
function dplctIdPwdChk(pwd){
	var idChk = $("#userId").val().substring(0,3);
	var pattern = new RegExp(idChk,"ig");
	if (pattern.test(pwd)) {
		return false;
	}
	else {
		return true;
	}
}

//비밀번호 체크
function checkPwdFc() {
	var flag = true;
	var pwd = $("#password1").val();

	if (!checkPwdVal(pwd)) {
		flag = false;
	}
	if (!ctnuCheck(pwd)) { //연속성체크
		flag = false;
	}
	if (!dplctIdPwdChk(pwd)) {
		flag = false;
	}
	if (flag == true) {
		$("#pwd-success").text("사용가능한 비밀번호입니다.");
		$("#pwd-danger").text("");
	    return flag;
	}
	else {
		$("#pwd-danger").text("사용 불가능한 비밀번호입니다.");
		$("#pwd-success").text("");
	    return flag;
	}

}

//새로운 비밀번호 확인 체크2
function checkPwd2Fc() {
	var flag = true;
	var pwd = $("#password1").val();
	var pwd2 = $("#password2").val();
	if (!checkPwdMtch(pwd,pwd2)) {
		flag = false;
	}
	if (flag == true) {
		$("#pwd2-success").text("비밀번호가 일치합니다.");
		$("#pwd2-danger").text("");
	    return flag;
	} else {
		$("#pwd2-danger").text("비밀번호가 일치하지않습니다.");
		$("#pwd2-success").text("");
	    return flag;
	}
}

//비밀번호 6자 및 영문 숫자 체크
function checkPwdVal(data) {
	var pattern = /^([a-zA-Z!@#$%^&*()_+=<>?0-9]{6,12})$/g;
	if(pattern.test(data)){
		return true;
	}
	else {
		return false;
	}
}

//비밀번호 일치 체크
function checkPwdMtch(pwd,pwd2) {
	if (pwd == pwd2) {
		return true;
	}
	else {
		return false;
	}
}

function check_txt(value) {
    if (isNaN(value)) {
  		alert("숫자만 입력가능합니다.");
    	return "";
	}
    else {
    	return value;
    }
}
</script>

<c:import url="/WEB-INF/jsp/${siteId }/member/user/joinStepNav.jsp"/>

<div class="plist">
	<p>본 사이트는 회원의 개인정보보호문제를 신중하게 취급합니다.</p>
	<p>가입하신 정보는 회원님의 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보호를 받습니다.</p>
</div>
<form action="/${siteId }/member/user/insert.do" enctype="multipart/form-data" name="frm" id="frm" method="post" onsubmit="return checkForm(this);">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<input type="hidden" name="menuNo" value="${param.menuNo }">
	<h2 class="bu_t1">아이디(ID)정보</h2>
	<div class="reqInfor"><span class="req"><span>필수입력</span></span>표시 항목은 필수 입력 항목입니다.</div>
	<div class="view">
		<dl>
			<dt><label for="userId"><span class="req"><span>필수입력</span></span> 아이디</label></dt>
			<dd>
				<input type="text" id="userId" name="userId" maxlength="64">
		    	<button type="button" onclick="fnCheckId();" class="b-ok btn-sm btn btn-default btn-info">중복확인</button>
				<span class="fs"><span class="ico_point">!</span>8자~14자 이하 영문 소문자, 숫자 조합</span>
			</dd>
		</dl>
		<dl>
			<dt><label for="password1"><span class="req"><span>필수입력</span></span> 비밀번호</label></dt>
			<dd>
				<input type="password" id="password1" name="password" autocomplete="off">
				<span class="fs"><span class="ico_point">!</span> 8자~14자 이하 영문 소문자, 숫자 조합</span>
			</dd>
		</dl>
		<dl>
			<dt><label for="password2"><span class="req"><span>필수입력</span></span> 비밀번호 확인</label></dt>
			<dd>
				<input type="password" id="password2" name="password2" autocomplete="off">
				<span class="fs"><span class="ico_point">!</span> 비밀번호를 한번 더 입력하세요</span>
			</dd>
		</dl>
	</div>
	<h2 class="bu_t1">개인정보</h2>
	<div class="view">
		<dl>
		<dt><label for="userNm"><span class="req"><span>필수입력</span></span>사용자 이름</label></dt>
		<dd>
			${member.userNm}
			<!-- <input type="text" id="userNm" name="userNm"  maxlength="128" value="" /> -->
		</dd>
		</dl>
		<dl>
		<dt><label for="sexCd1"><span class="req"><span>필수입력</span></span>성별</label></dt>
		<dd>
			<c:forEach var="item" items="${sexCdCodeList }" varStatus="status">
				<label for="sexCd${status.count }"><input type="radio" name="sexCd" id="sexCd${status.count }" value="${item.cd }" <c:if test="${item.cd eq member.sexCd}">checked='checked'</c:if>>${item.cdNm }</label>
			</c:forEach>
		</dd>
		</dl>
		<dl>
		<dt><label for="brthdy"><span class="req"><span>필수입력</span></span>생년월일</label></dt>
		<dd>
			<c:set var="data" value="${fn:split(member.brthdy,'-')}" />
			<select name="brthdy1" id="brthdy1" title="생년월일 년도">
				<option value="">선택</option>
				<c:forEach begin="${yearToday - 99 }" end="${yearToday }" var="year"  varStatus="status" >
					<option value="${year }" <c:if test="${data[0] eq year}">selected="selected"</c:if>>${year }</option>
				</c:forEach>
			</select> 년
			<input type="text" name="brthdy2" id="brthdy2" maxlength="2" title="생년월일 월" style="width:60px" value="${data[1]}" /> 월
			<input type="text" name="brthdy3" id="brthdy3" maxlength="2" title="생년월일 일" style="width:60px" value="${data[2]}" /> 일
		</dd>
		</dl>
		<dl>
		<dt>전화번호</dt>
		<dd>
			<select id="userTelno1" name="userTelno1" class="input_select" title="전화번호 지역번호">
				<option value="" >선택</option>
				<c:forEach var="item" items="${telno1CdCodeList }" varStatus="status">
    				<option value="${item.cd }" >${item.cdNm }</option>
				</c:forEach>
			</select>
			-
			<input type="text" id="userTelno2" name="userTelno2" value="" class="tel" title="전화번호 중간 4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)">
			-
			<input type="text" id="userTelno3" name="userTelno3" value="" class="tel" title="전화번호 끝 4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)">
		</dd>
		</dl>
		<dl>
		<dt><span class="req"><span>필수입력</span></span>휴대전화</dt>
		<dd>
			<select id="userCpno1" name="userCpno1" class="input_select" title="휴대전화 앞 세자리">
				<option value="" >선택</option>
				<c:forEach var="item" items="${cpno1CdCodeList }" varStatus="status">
    				<option value="${item.cd }" >${item.cdNm }</option>
				</c:forEach>
			</select>
			-
			<input type="text" id="userCpno2" name="userCpno2" value="" class="tel" maxlength="4" onkeyup="this.value=check_txt(this.value)">
			<label for="userCpno2" class="hidden">휴대전화 중간 4자리</label>
			-
			<input type="text" id="userCpno3" name="userCpno3" value="" class="tel" maxlength="4" onkeyup="this.value=check_txt(this.value)">
			<label for="userCpno3" class="hidden">휴대전화 끝 4자리</label>
		</dd>
		</dl>
		<dl>
		<dt><span class="l"><span class="req"><span>필수입력</span></span>주소</span></dt>
		<dd>
			<div class="postSet">
				<span>
				<input type="text" name="userZip" id="userZip" class="post" title="우편번호" readonly="readonly">
				<a href="javaScript:daumPostcodeSearch();" class="b-sh btn btn-default" title="새창열림">주소 찾기</a>
				</span>
				<span><input type="text" name="userAdres1" id="userAdres1" class="w100p" title="주소" readonly="readonly"></span>
				<span><input type="text" name="userAdres2" id="userAdres2" class="w100p" title="상세주소"></span>
			</div>
		</dd>

		</dl>
		<dl>
		<dt>이메일</dt>
		<dd>
			<c:set var="data" value="${fn:split(userInfo.userEmad,'@')}" />
			<input name="userEmad1" id="userEmad1" type="text" title="이메일 아이디" value="${data[0]}" class="emailId">
			@
			<input name="userEmad2" id="userEmad2" type="text" title="이메일 주소" value="${data[1]}" readonly="readonly" class="emailAddr emailDomainForm">
			<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
			<select id="sr_email_more" name="" class="input_select select_email_js" title="직접입력 선택시 자동활성화&amp;포커스 이동">
				<option value="">메일주소선택</option>
				<c:forEach var="item" items="${emadCdCodeList }" varStatus="status">
    				<option value="${item.cd }" <c:if test="${data[1] eq item.cd}">selected="selected"</c:if> >${item.cdNm }</option>
				</c:forEach>
				<option value="emaildomain_false">직접입력</option>
			</select>
			<script>
			jQuery(function(){
				jQuery('select.select_email_js').on('change',function() {
					if (jQuery(this).val()=='emaildomain_false') {
						jQuery('.emailDomainForm:text[name=userEmad2]').val('');
						jQuery('.emailDomainForm').attr('readonly',false).focus();
					}else{
						jQuery('.emailDomainForm:text[name=userEmad2]').val('');
						jQuery('.emailDomainForm:text[name=userEmad2]').val(jQuery(this).val());
						jQuery('.emailDomainForm').attr('readonly',true)
					}
				});
			});
			</script>
		</dd>
		</dl>
	</div>
	<div class="tac mt20">
		<input type="submit" value="가입하기" class="b-ok btn btn-default btn-info" />
		<a href="/${siteId }/main/main.do" class="b-cancel btn btn-default">가입취소</a>
	</div>
</form>
