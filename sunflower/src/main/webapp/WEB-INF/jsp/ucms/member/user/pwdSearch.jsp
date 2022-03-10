<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="siteId" value="${paramVO.siteId}"/>
<spring:eval expression="@prop['Globals.ucms.siteSeCd']" var="siteSeCd" scope="request" />

<p class="infor">접속정보를 잊어버리셨나요? 회원님의 접속정보를 알려드립니다</p>
<div class="plist">
	<p>비밀번호의 경우 회원가입 시 등록하셨던 메일주소로 임시비밀번호를 전송해 드리오니, 로그인 후 반드시 비밀번호를 변경하여 주시기 바랍니다.</p>
</div>
<form action="/${siteId }/member/user/vnameOutput.do" name="frm" id="frm" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<input type="hidden" name="retUrl" id="retUrl" value="" />
	<input type="hidden" name="authTp" id="authTp" value="P"/>
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

	<jsp:include page="/WEB-INF/jsp/ucms/member/user/certify.jsp" flush="true" >
		<jsp:param name="siteId" value="${siteId}"  />
		<jsp:param name="siteSeCd" value="${siteSeCd}"  />
		<jsp:param name="returnUrl" value="/${siteId}/member/user/pwdSearchInput.do?menuNo=${param.menuNo}" />
	</jsp:include>
</form>