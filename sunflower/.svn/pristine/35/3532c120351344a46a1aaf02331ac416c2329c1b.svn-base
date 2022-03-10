<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<c:set var="siteId" value="${paramVO.siteId }"/>

<script src="/static/jslibrary/miya_validator.js"></script>
<script>
var title = document.title;
document.title = "휴면계정 해제";

function drmncyIdLogin(){
	var frm = document.pwdForm;
	if (frm.password.value=="" || frm.password.value.length<4){
		alert("비밀번호를 정확히 입력하여 주십시요.");
		frm.password.focus();
		return false;
	}
	frm.drmncyIdUseAt.value = "Y";
	frm.action="/${siteId}/member/user/toLogin.do";
	frm.submit();
}

</script>
<form name="pwdForm" id="pwdForm" action="#" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<input type="hidden" name="drmncyIdUseAt" value="N"/>

<div>
	<p class="infor">회원님은 계정이 휴면 상태 입니다.</p>
	1년간 로그인 이력이 없어 휴면 전환된 계정을 해제하여 다시 사용 하실 수 있습니다.<br/>
	휴면 상태를 해제 하시려면 아래 비밀번호를 입력 후 휴면상태 해제를 클릭하여 주시길 바랍니다.<br/>
</div>

<div class="ptbox pwchange">
	<label><span class="title">비밀번호</span><input  type="password" name="password"   id="passwordNew" autocomplete="off" title="변경비밀번호 확인"></label>
	<div class="tac">
		<button type="button" class="b-lg" onclick="return drmncyIdLogin()">휴면 상태 해제</button>
		<button type="button" class="b-list"><a href="/">취소</button>
	</div>
</div>
</form>


