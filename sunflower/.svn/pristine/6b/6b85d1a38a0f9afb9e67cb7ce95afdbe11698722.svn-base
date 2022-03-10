<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:if test="${param.siteSeCd eq '1' || param.siteSeCd eq '3'}"><!-- 실명인증 인증 -->
	<div class="row certify">
		<div class="col-xs-6">
			<div class="set">
				<h3>휴대전화인증</h3>
				<div class="s">
					<p>
						휴대전화인증이란 주민등록번호 <br class="visible-lg">대체수단으로 회원님의 휴대전화를<br class="visible-lg">
						통해 본인확인을 하는 서비스입니다
					</p>
					<a href="#hpBtn" id="hpBtn" class="b-lg">휴대전화인증</a>
				</div>
			</div>
		</div>
		<div class="col-xs-6 ipin">
			<div class="set">
				<h3>아이핀 인증</h3>
				<div class="s">
					<p>
						아이핀(I-PIN)은 인터넷상의 개인식별번호를 의미하며,  
						대면확인이 어려운 인터넷에서 주민등록번호를  사용하지 않고도
						본인임을 확인할 수 있는 수단입니다
					</p>
					<a href="#ipinBtn" id="ipinBtn" class="b-lg">아이핀인증</a>
				</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${param.siteSeCd eq '2' || param.siteSeCd eq '3'}"><!-- SNS 인증 -->
	<div class="snsLogin">
		<h3>SNS 본인인증</h3>
		<ul>
			<li><a href="#google"	id="google"><span>구글</span></a></li>
			<li><a href="#facebook"	id="facebook"><span>페이스북</span></a></li>
			<li><a href="#naver"	id="naver"><span>네이버</span></a></li>
			<li><a href="#kakao"	id="kakao"><span>카카오록</span></a></li>
			<li><a href="#twitter"	id="twitter"><span>트위터</span></a></li>
		</ul>
	</div>
</c:if>
<c:if test="${param.siteSeCd eq '3'}"><!-- 실명인증 + SNS 인증 -->
	<div class="certifyInfor">
		<h3>인증 안내</h3>
		<ul>
			<li>휴대전화인증, IPIN 인증과 SNS 인증은 서로 정보가 연동되지 않습니다.<br />
				(※ 즉 휴대전화인증과 SNS 인증을 하시면 2개의 회원인증을 가지게 됩니다.)</li>
			<li>휴대전화인증, 아이핀 인증 후에는 아이디, 비밀번호, 개인정보를 입력할 수 있습니다.</li>
		</ul>
	</div>
</c:if>
<script>
$("#hpBtn").on('click',function() {
	var popupWindow = window.open('', 'hpPop', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	$("#retUrl").val(encodeURIComponent('${param.returnUrl}'));
	$("input[name=m]").val("checkplusSerivce");
	$("#frm").attr("action", "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb");
	$("#frm").attr("target", "hpPop");
	$("#frm").trigger( "submit" );
	popupWindow.focus();
	return false;
});
$("#ipinBtn").on('click',function() {
	$("input[name=m]").val("pubmain");
	$("#retUrl").val(encodeURIComponent('${param.returnUrl}'));
	$("#frm").attr("action", "https://cert.vno.co.kr/ipin.cb");
	var popupWindow = window.open('', 'ipinPop', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	$("#frm").attr("target", "ipinPop");
	$("#frm").trigger( "submit" );
	popupWindow.focus();
	return false;
});
$(".snsLogin li a").on("click", function(){
	$("#retUrl").val(encodeURIComponent('${param.returnUrl}'));
	$("#frm").attr("action","/${param.siteId}/oauth/sns/"+$(this).attr("id")+"Login.do");
	$("#viewType").val("");
	$("#frm").trigger( "submit" );
});
</script>