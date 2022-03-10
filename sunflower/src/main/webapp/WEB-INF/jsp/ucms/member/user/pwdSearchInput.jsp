<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<script src="/static/jslibrary/miya_validator.js"></script>
<script>
$(function() {
	$("#pwdSearchBtn").on('click',function(){

		var passwordVal = $("#password1").val();
		var v = new MiyaValidator(frm);
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

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}

		if (!ctnuCheck($('#password1').val())) { //연속성체크
			alert("3자리 연속 또는 같은 문자는 사용불가능한 비밀번호입니다.");
			$("#password1").focus();
			return false;
		}

		if(!checkPrhibtWrd($('#password1').val())){
			$("#password1").focus();
			return false;
		}

		if (!confirm("비밀번호를 변경 하시겠습니까?")) return false;

		$.post("/${paramVO.siteId}/member/user/pwdChangeByUserSn.json",
				{password : passwordVal},
				function(data) {
				alert(data.msg);
				location.href = "/ucms/member/user/forLogin.do?menuNo=300019";
			},"json");
		return false;

	});
});

function checkPrhibtWrd(text){
	$.ajaxSetup({
		async: false
	});

	var flag = true;
	$.post(
		"/${paramVO.siteId}/member/user/checkPrhibtWrd.json",
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
</script><h2 class="bu_t1">비밀번호 변경</h2>
<div class="box">
	<div class="s">
		<p class="t">안전한 비밀번호로 내정보를 보호하세요.</p>

		<p>다른 아이디/사이트에서 사용한 적 없는 비밀번호, 이전에 사용한 적 없는 비밀번호가 안전합니다.</p>
	</div>
	<form name="frm" id="frm" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="login_list login_list2">
		<dl>
			<dt>새 비밀번호</dt>
			<dd><input type="password" id="password1" name="password" autocomplete="off"></dd>

		</dl>
		<dl>
			<dt>새 비밀번호 확인</dt>
			<dd><input type="password" id="password2" name="password2" autocomplete="off"></dd>
		</dl>
	</div>
	</form>
	<div class="clear tac">
		<input type="submit" id="pwdSearchBtn" value="변경하기" class="b-ok btn btn-default btn-info" />
		<a href="/${siteId }/main/main.do" class="b-">취소</a>
	</div>
</div>