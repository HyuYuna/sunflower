<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/WEB-INF/jsp/bos/bbs/com/bbsHead.jsp" flush="true" />

<script src="/js/miya_validator.js"></script>
<script>

function pwdCheck(pwdNew)
{
    var SamePass_0 = 0; //동일문자 카운트
    var SamePass_1 = 0; //연속성(+) 카운트
    var SamePass_2 = 0; //연속성(-) 카운트

    var chr_pass_0;
    var chr_pass_1;
    var chr_pass_2;

    for(var i=0; i < pwdNew.length; i++)
    {
        chr_pass_0 = pwdNew.charAt(i);
        chr_pass_1 = pwdNew.charAt(i+1);

        //동일문자 카운트
        if(chr_pass_0 == chr_pass_1)
        {
            SamePass_0 = SamePass_0 + 1;
        }
        chr_pass_2 = pwdNew.charAt(i+2);

        //연속성(+) 카운드
        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1)
        {
            SamePass_1 = SamePass_1 + 1;
        }

        //연속성(-) 카운드
        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1)
        {
            SamePass_2 = SamePass_2 + 1;
        }
    }
    if(SamePass_0 > 1)
    {
        alert("동일문자를 3번 이상 사용할 수 없습니다.");
        return false;
    }

    if(SamePass_1 > 0 || SamePass_2 > 0 )
    {
        alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
        return false;
    }
    return true;

}

function qwertyCheck(pw) {
	var qwerty  = "90-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:ZXCVBNM<>?";
	var start   = 4 - 1; // 연속글자수 - 1
	var seq     = "_" + pw.slice(0, start);

	for (i = start; i < pw.length; i++) {
	seq = seq.slice(1) + pw.charAt(i);

		if (qwerty.indexOf(seq) > -1) {
			alert("키보드상에 나란히 있는 4개의 문자를 연속으로 비밀번호로 사용하실 수 없습니다.");
			return false;
		}

	}

	return true;

}

function checkForm() {
	var form = document.f_regi;
	var v = new MiyaValidator(form);
		var pwdNew = $('#password');
	    v.add("password", {
	    	pattern: /^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-z])(?!=.*[A-Z]).*$/,
	    	message: "비밀번호는 10~15자의 영문 소문자,숫자를 조합으로 입력해야 합니다.",
	        required: true
	    });

	    //연속성체크
	    if(!pwdCheck(pwdNew.val())) {
	    	pwdNew.focus();
	    	return;
	    }

	  	//키보드상 연속글자 체크
	    if(!qwertyCheck(pwdNew.val())){
	    	pwdNew.focus();
	    	return;
	    };

	    v.add("password", {
	        required: true
	    });
	    v.add("password", {
	        match: "password2",
	        message: "비밀번호가 일치하지 않습니다."
	    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (confirm('비밀번호를 변경하시겠습니까?')) {
		form.submit();
	}

}

</script>


<form name="f_regi" method="post" action="/bos/member/user/updatePwdReset.do">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type=hidden name="searchType" value="${param.searchType}">
	<input type=hidden name="searchTxt" value="${param.searchTxt}">
	<input type=hidden name="pageIndex" value="${empty param.pageIndex ? 1 : param.pageIndex}">
	<div class="bdView">
		<table>
			<caption>관리자 비밀번호 초기화</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" >아이디</th>
					<td width="555" >
						${userId}<input type="hidden" name="userId" id="userId" value="${userId}" />
					</td>
				</tr>
				<tr>
					<th ><label for="password">비밀번호</label></th>
					<td><input type="password" name="password" id="password" value="" maxLength="15" class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off">
						<span class="font_11px_orange_01"><br/>
						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합
						<br/>※ 최근 3개월 이내에 사용한 비밀번호는 사용할 수 없음
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)

						</span>
					</td>
				</tr>
				<tr>
					<th ><label for="password2">비밀번호확인</label></th>
					<td><input type="password" name="password2" id="password2" value="" maxLength="15" class="input_style02" style="width:160px; heigth:18px;" title="비밀번호확인" autocomplete="off"></td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btnSet">
		<a class="button btn_ok" href="javascript:checkForm();"><span>확인</span></a>
		<c:url var="url" value="/bos/member/user/list.do">
			<c:param name="mType" value="${param.mType}" ></c:param>
			<c:param name="searchType" value="${param.searchType}" ></c:param>
			<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
			<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
		</c:url>
		<a class="button btn_cancel" href="${url}"><span>취소</span></a>
	</div>
