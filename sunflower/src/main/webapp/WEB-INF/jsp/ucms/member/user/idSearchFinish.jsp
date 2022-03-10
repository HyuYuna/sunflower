<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@prop['Globals.ucms.siteSeCd']" var="siteSeCd" scope="request" />
<h2 class="bu_t1">ID찾기 완료</h2>
<div class="box">
	<div class="s">
		<p class="t">회원님의 아이디 찾기가 완료 되었습니다.</p>
		<p>로그인 후 홈페이지에서 제공하는 콘텐츠들을 이용하실 수 있습니다</p>
	</div>
	<div class="login_list">
		<dl>
			<dt>성명</dt>
			<dd>${result.userNm}</dd>
		</dl>
		<dl>
			<dt>아이디</dt>
			<dd><span class="point">${result.userId}</span></dd>
		</dl>
	</div>
	<div class="clear tac">
		<a href="/ucms/member/user/forLogin.do?menuNo=300019" class="b-">로그인하기</a>
		<a href="/ucms/member/user/pwdSearch.do?menuNo=300082" class="b-">비밀번호찾기</a>
	</div>
</div>