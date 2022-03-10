<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<c:set var="siteId" value="${paramVO.siteId }"/>

<script src="/static/jslibrary/miya_validator.js"></script>
<script>
var title = document.title;
document.title = "비밀번호 수정 | 마이페이지";
$(function() {
	pwdChangeRequest = function() {
		var form = $("#pwdForm")[0];
		var v = new MiyaValidator(form);
		var pwd = $("#passwordNew1").val();
		var pwdOld = $("#passwordOld").val();
		v.add("passwordOld", {
			required: true
		});
		v.add("password", {
			required: true,
		});
	    v.add("password", {
			pattern : "(?=.*[0-9])(?=.*[a-z])(?=\\S+$).{8,14}$",
			message : "8자~14자 이하 영문 소문자, 숫자 조합으로 입력가능 합니다."
	    });
		if (!ctnuCheck(pwd)) { //연속성체크
			alert("3자리 연속 또는 같은 문자는 사용불가능한 비밀번호입니다.");
			$("#passwordNew1").focus();
			return false;
		}
		v.add("password2", {
			required: true,
		});
		v.add("password2", {
		  match: "password"
		});

		var result = v.validate();

		if (!result) {
			alert(v.getErrorMessage());
	    	v.getErrorElement().focus();
			return false;
		}
		if (pwdOld == pwd) {
			alert('기존 비밀번호와 동일합니다.');
			$("#passwordNew1").focus();
			return;
	    }
		if (!checkPwdOldFc()) {
			alert("기존 비밀번호가 일치하지 않습니다.");
			$("#passwordOld").focus();
			return;
		}
		if(!dplctIdPwdChk(pwd)) {
			alert("아이디와 동일한 비밀번호를 사용하실수 없습니다.");
			return false;
		}

		if(!checkPrhibtWrd($("#passwordNew1").val())){
			$("#passwordNew1").focus();
			return false;
		}

		if(!confirm("변경 하시겠습니까?")) {
			return;
		}

		$.post(
			"/${siteId}/member/user/pwdChangeRequest.json",
			{userId : "${member.userId}", password: pwd},
			function(data) {
				if (data.resultCode == "success") {
					alert("정상적으로 변경되었습니다. 다시 로그인해주세요.");
					location.href = "/${siteId}/member/user/logout.do?reLogin=Y";
				}
			},"json"
		);

	};
});

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

function checkPwdOldFc() {
	$.ajaxSetup({
		async: false
	});
	var flag = true;
	$.post(
		"/${siteId}/member/user/pwdCheck.json",
		{username : "${member.userId}", password : $("#passwordOld").val()},
		function(data) {
			if (data.resultCode == "success") flag = true;
			else flag = false;
		},"json"
		);
	return flag;
}

function dplctIdPwdChk(pwd) {
	var idChk = "${member.userId}";
	if (idChk.indexOf(pwd) >-1) {
		return false;
	}
	else {
		return true;
	}
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
</script>
<form name="pwdForm" id="pwdForm" action="#" method="post">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<input type="hidden" id="userId" value="${user.userId }">
<c:if test="${param.deriveAt eq 'Y'}">
<div>
	<p class="infor">"회원님의 비밀번호를 변경해 주세요"</p>
	회원님께서는 장기간 비밀번호를 변경하지 않고, 동일한 비밀번호를 사용중이십니다.<br/>
	정기적인 비밀번호 변경으로 회원님의 개인정보를 보호해 주세요.<br/>
</div>
</c:if>
<div class="ptbox pwchange">
	<label><span class="title">기존 비밀번호 입력</span><input type="password" name="passwordOld" id="passwordOld"  autocomplete="off" title="기존 비밀번호"></label>
	<label><span class="title">변경 비밀번호 입력</span><input  type="password" name="password"    id="passwordNew1" autocomplete="off" title="변경비밀번호"></label>
	<label><span class="title">변경 비밀번호 확인</span><input  type="password" name="password2"   id="passwordNew2" autocomplete="off" title="변경비밀번호 확인"></label>
	<div class="tac">
		<button type="button" class="b-lg" onclick="return pwdChangeRequest()">확인</button>
		<c:if test="${param.deriveAt eq 'Y'}">
		<button type="button" class="b-list"><a href="/">다음에 변경하기</button>
		</c:if>
	</div>
</div>
</form>


