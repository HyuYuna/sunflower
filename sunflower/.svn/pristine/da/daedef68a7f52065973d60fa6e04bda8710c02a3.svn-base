<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script>
setTimeout("location.reload()", 1000*60*14);
</script>
<!-- <script src="/static/jslibrary/lang.js"></script> -->

<c:set var="siteId" value="${paramVO.siteId}"/>
<spring:eval expression="@prop['Globals.ucms.siteSeCd']" var="siteSeCd" scope="request" />
<c:if test="${param.authFlag eq 'Y' }">
	<div class="infor">
		<p>인증이 완료되었습니다.</p>
		<p><strong>아이디 잠금 해제</strong>를 위한 인증이 완료되었습니다.	다시 로그인해 주시기 바랍니다.</p>
	</div>
</c:if>
<p class="infor">유앤피플의 다양한 서비스를 이용하실 수 있습니다.</p>
<div class="loginSet">
	<form name="memberLoginForm" id="memberLoginForm" action="/${siteId }/member/user/toLogin.do"  method="post" onsubmit="return actionLogin(this);">
		<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}">
		<input type="hidden" name="menuNo" value="${paramVO.menuNo}">
		<input type="hidden" name="siteId" value="${siteId }">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<span>
			<label for="userId">아이디</label>
			<input type="text" id="userId" name="username">
		</span>
		<span>
			<label for="password">비밀번호</label>
			<input type="password" id="password" name="password" autocomplete="off"  onkeypress="return loginEnter(event);">
		</span>
		<input type="submit" value="로그인" />
	</form>
</div>
<form name="frm" id="frm" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}" />
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<input type="hidden" name="retUrl" id="retUrl" value="" />
	<input type="hidden" name="viewType" value="BODY" />
	<input type="hidden" name="authTp" id="authTp" value="L"/>
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

	<jsp:include page="/WEB-INF/jsp/ucms/member/user/certify.jsp" flush="true" >
		<jsp:param name="siteId" value="${siteId}"  />
		<jsp:param name="siteSeCd" value="${siteSeCd}"  />
		<jsp:param name="returnUrl" value="/${siteId}/member/user/forLogin.do?menuNo=${param.menuNo}" />
	</jsp:include>
</form>

<div class="moreLink">
	<div>
		<p>아직 회원가입을 안하셨나요?</p>
		<div class="r">
			<a href="/ucms/member/user/joinAgre.do?menuNo=300020">회원가입</a>
		</div>
	</div>
	<div>
		<p>아이디 혹은 비밀번호를 잊으셨나요?</p>
		<div class="r">
			<a href="/ucms/member/user/idSearch.do?menuNo=300021">ID찾기</a>
			<a href="/ucms/member/user/pwdSearch.do?menuNo=300082">PW찾기</a>
		</div>
	</div>
</div>
<script src="/static/jslibrary/miya_validator.js"></script>
<script>
	<c:if test="${siteSeCd eq '0'}">
		$("#username").focus();
	</c:if>

	function actionLogin()
	{
		var form = document.memberLoginForm;
		var v = new MiyaValidator(form);
		v.add("username", {
			required: true
		});
		v.add("password", {
			required: true
		});
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}
		return true;
		//document.frm.submit();
	}
	function loginEnter(e){
		if(e.keyCode == 13){  /* IE기준으로 설명 */
			actionLogin();
		}
	}
</script>