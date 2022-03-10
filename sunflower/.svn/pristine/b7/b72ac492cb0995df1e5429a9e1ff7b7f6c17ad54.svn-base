<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p class="infor">홈페이지 회원으로 가입하시면 다양하고 유익한 정보를 확인하실 수 있습니다.</p>
<c:set var="targetMethod" value="${paramVO.targetMethod }"/>
<c:set var="actClass" value=""/>
<c:choose>
	<c:when test="${targetMethod eq 'joinAgre'}"><c:set   var ="actClass" value ="1"/></c:when>
	<c:when test="${targetMethod eq 'joinVerify'}"><c:set var ="actClass" value ="2"/></c:when>
	<c:when test="${targetMethod eq 'joinInput'}"><c:set  var ="actClass" value ="3"/></c:when>
	<c:when test="${targetMethod eq 'joinFinish'}"><c:set var ="actClass" value ="4"/></c:when>
</c:choose>

<div class="join2 ${targetMethod}">
	<ol class="sr-only">
		<li class="i1">
			<div class="set">
			<div class="s">STEP 01</div>
			<span class="t">약관동의</span>
			</div>
		</li>
		<%-- <li class="i2 ${targetMethod eq 'joinSelect' ? 'active' : ''}" title="${targetMethod eq 'joinSelect' ? '현재단계' : ''}">
			<div class="set">
			<div class="s">STEP 02</div>
			<span class="t">회원유형선택</span>
			</div>
		</li> --%>
		<li class="i2">
			<div class="set">
			<div class="s">STEP 02</div>
			<span class="t">본인인증</span>
			</div>
		</li>
		<li class="i3">
		<div class="set">
			<span class="chk"><span class="hidden">현재 페이지</span></span>
			<div class="s">STEP 03</div>
			<span class="t">회원정보 입력</span>
			</div>
		</li>
		<li class="i4">
		<div class="set">
			<div class="s">STEP 04</div>
			<span class="t">가입완료</span>
		</div>
		</li>
	</ol>
</div>
<script>
	"use strict";
	$('.join2 .i${actClass}').addClass('active').attr("title","현재단계");
	var title = document.title;
	var subtitle;
	subtitle = $('.join2 .i${actClass}').text()	
	document.title = subtitle + ' 단계 ' + title;
</script>