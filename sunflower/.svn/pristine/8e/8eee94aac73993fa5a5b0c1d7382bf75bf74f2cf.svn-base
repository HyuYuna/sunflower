<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<!-- <script language="javascript" runat="server" src="/WEB-INF/jsp/bos/system/sms/JSON_JS.js"></script> -->
<!DOCTYPE html>
<html lang="ko">

<head>
	<style>
	#header {display:none}
	#footer {display:none}
	#leftmenu {display:none}
	.hgroup.clearfix {display:none}
	#content {display:none; float:center;}
	@page { size: 90%;  margin: 2mm;}
	</style>
	
	<meta http-equiv="X-UA-Compatible" content="IE=11">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>해정시 문자발송시스템</title>
	
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/css/ui.jqgrid.css">
	<link href="/static/bos/css/sms.css" rel="stylesheet" type="text/css" />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	
	<script>
		var smsRCount = "${smsId}";
		if (smsRCount=="") {
			alert("등록되지 않은 기관입니다.");
			window.open("about:blank","_self").close();
		}
		
		$(function(){
			var pattern = /[^0-9,]/gi;
			
			$(".numberOnly").on("keyup", function() {
				if (pattern.test($(this).val())) {
					$(this).val($(this).val().replace(pattern, ""));
				}
			});
		});
	</script>
</head>

<body onload="remainingMoney();">
	<div id="wrap">
		<form method="post" id="smsForm" name="smsForm" action="/bos/system/sms/smsSend.do">
			<h2>${smsGroupTitle}</h2>
			<div id="sms_send">
				<ul>
					<li></li>
					<li>
						<strong class="send_title">발송 번호</strong>
						<select name='sphone' style='width:160px; height:28px;'>
							<c:forEach var="senderList" items="${senderList}" varStatus="status">
								<option value='${senderList.codeName }'>${senderList.codeName }</option>
							</c:forEach>
							<c:if test="${fn:length(senderList) eq 0}">
								<option value=''>등록된 발송번호가 없습니다.</option>
							</c:if>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<strong class="send_title">잔여 금액</strong>
						<b><span id="remainMoney"></span></b> 원
						<!-- <input type="button" id="btnMoney" calss="button" value="잔액확인"> -->
					</li>
					<li>
						<strong class="send_title">받는 번호</strong>
						<input type="text" name="rphone" value="${fn:replace(param.rphone,'-','') }" style="width: 300px;" placeholder="-없이 입력해주세요" class="numberOnly"> 
						<%-- <c:if test="${not empty param.caseSeq }">
							<select style='width:300px;'>
								<c:forEach var="smsList" items="${smsList}" varStatus="status">
									<option value='${smsList.ccPhone }'>${smsList.ccName }(${smsList.ccRel })${smsList.ccPhone }</option>
								</c:forEach>
								<c:if test="${fn:length(smsList) eq 0}">
									<option value=''>연락처에 등록된 정보가 없습니다.</option>
								</c:if>
							</select>
						</c:if> --%>
					</li>
					<li>
						<strong class="send_title"><input type="hidden" name="action" value="go"> 발송 타입</strong>
						<input type="radio" name="smsTypes" class="smsType" value="S" disabled checked>단문(SMS)
						<input type="radio" name="smsTypes" class="smsType" value="L" disabled>장문(LMS) , 글자수 : <span class="inputCnt">0</span> / 80 Byte
						<input type="hidden" id="smsType" name="smsType" value="Y">
					</li>
					<!--
	                   <li><strong class="send_title">제목</strong> <input type="text" name="subject" value="서울대학생활 문화원"> <span class="ex">장문(LMS)인 경우(한글30자이내)</span></li>
	                   -->
					<li>
						<strong class="send_title">전송메세지</strong>
						<input type="radio" name="rdoSendType" class="rdoSendType" value="S" checked>즉시전송
						<input type="radio" name="rdoSendType" class="rdoSendType" value="R">예약전송
					</li>
					<li>
						<textarea id="msg" name="msg" rows="5" style="width: 100%;" placeholder="이곳에 보내려는 문자내용을 넣어주세요."></textarea>
					</li>
					<li class="reserveSms" style="display: none;">
						<strong class="send_title">예약 날짜</strong>
						<input type="text" name="rdate" maxlength="8"> <span class="ex">예)20201010</span>
					</li>
					<li class="reserveSms" style="display: none;">
						<strong class="send_title">예약 시간</strong> <input type="text" name="rtime" maxlength="6">
						<span class="ex">예)173000 (오후 5시 30분 00초)</span></li>
				</ul>
	
				<dl style="margin-top: 0;">
					<dt>※ 참고사항</dt>
					<dd>여러명에게 전달시, 쉼표(,) 로 구분해서 번호 입력시 동시에 발송가능합니다.</dd>
					<dd>단문(SMS) : 최대 80byte까지 전송할 수 있으며, 잔여금액 9.5원이 차감됩니다.</dd>
					<dd>장문(LMS) : 한번에 최대 2,000byte까지 전송할 수 있으며 1회 발송단 잔여금액 27원이 차감됩니다.</dd>
					<dd>예약전송시, 예약시간은 최소 10분 이상으로 설정해 주세요.</dd>
				</dl>
			</div>
	           
			<!-- 제목 : 장문일경우에 사용됨 -->
			<input type="hidden" name="subject" value="해정시 문자발송시스템">
			<!-- return url -->
			<input type="hidden" name="returnurl" maxlength="64" value="${smsReturnUrl }">
			<input type="hidden" name="testflag" maxlength="1" value="Y">
			<!-- nointeractive 예) 사용할 경우 : 1, 성공시 대화상자(alert)를 생략.-->
			<input type="hidden" name="nointeractive" maxlength="1">
			<!-- 이름삽입번호 : 예) 010-000-0000|홍길동 -->
			<input type="hidden" name="destination" value="" size=80>
			<!--  보내는 번호
	           <input type="hidden" name="sphone" value="070-4060-1525">
	           -->
			<input type="hidden" name="repeatFlag" value="Y"> 
			<input type="hidden" name="repeatNum" value="N"> 
			<input type="hidden" name="repeatFlag" value="1"> 
			<input type="hidden" name="repeatTime" value="15"> 
			<input type="hidden" name="case_seq" value="${empty param.caseSeq ? '0' : param.caseSeq }"> 
			<input type="hidden" name="resultCode" value="0"> 
			<input type="hidden" name="sms_id" value="${smsId }"> 
			<input type="hidden" name="sms_key" value="${smsKey }">
	
			<!--
	           <br />반복설정
	           <input type="checkbox" name="repeatFlag" value="Y">
	           <br /> 반복횟수
	           <select name="repeatNum">
	               <option value="1">1</option>
	               <option value="2">2</option>
	               <option value="3">3</option>
	           </select> 예) 1~10회 가능.
	           <br />전송간격
	           <select name="repeatTime"> 예)15분 이상부터 가능.
	               <option value="15">15</option>
	               <option value="20">20</option>
	               <option value="25">25</option>
	           </select>분마다
	           -->
		</form>
	
		<div class="btn_group" style="margin-top: 20px;">
			<!--a href='#' id='btnSend' class="button">문자 전송</a>
	           <a href='#' id='btnClose' class="button">전송 취소</a-->
			<input type="button" id="btnSend" class="pure-button" value="문자 전송">
			<input type="button" id="btnClose" class="pure-button" value="전송 취소">
		</div>
	
	
		<script>
	
			// SMS 발송
			function sendDirectSms() {
				$.ajax({
					type:"post",
					url:"/bos/system/sms/smsDirectSend.json" ,
					data: $("#smsForm").serialize(),
					dataType: "json",
					success:function(entry){
						var status = entry.list.status;
						var resultMessage = "전송 메세지";
	
						if (status == "0") {
							resultMessage = "메세지가 발송되었습니다";
						} else if (status == "100") {
							resultMessage = "POST validation 실패";
						} else if (status == "101") {
							resultMessage = "sender 유효한 번호가 아님";
						} else if (status == "102") {
							resultMessage = "recipient 유효한 번호가 아님";
						} else if (status == "103") {
							resultMessage = "api key or user is invalid";
						} else if (status == "104") {
							resultMessage = "recipient count = 0";
						} else if (status == "105") {
							resultMessage = "message length = 0";
						} else if (status == "106") {
							resultMessage = "message validation 실패";
						} else if (status == "109") {
							resultMessage = "return_url이 없습니다.";
						} else if (status == "205") {
							resultMessage = "잔액부족";
						} else if (status == "999") {
							resultMessage = "Internal Error.";
						}
	
						if (status=="0") {
							saveDirectSms();
						} else {
							alert(status +" : "+ resultMessage);
						}
	
						//window.open("about:blank","_self").close();
	
					},
					fail:function(entry){
						alert("전송실패 : "+ entry);
					}
				});
			}
	
	           // SMS 발송후 성공시 결과저장
			function saveDirectSms() {
				$.ajax({
					type:"post",
					url:"/bos/system/sms/smsDirectSuccess.json" ,
					data: $("#smsForm").serialize(),
					dataType: "json",
					success:function(entry){
						//$(opener.location).attr("href","javascript:fn_smsjqgrid_reload();");
						opener.location.reload();
						alert("문자메세지를 발송했습니다.");
						window.open("about:blank", "_self").close();
	                   }
				});
	        	   
	               /* $('#smsForm').attr('action', '/bos/system/sms/smsDirectSuccess.do');
	               $('#smsForm').submit(); */
	           }
	
	           function checkByte() {
	
	               var limitByte = 2000;
	               var totalByte = 0;
	               var message = $("#msg").val();
	
	               for(var i =0; i < message.length; i++) {
	                   var currentByte = message.charCodeAt(i);
	                   if(currentByte > 128) {
	                       totalByte += 2;
	                   } else {
	                       totalByte++;
	                   }
	
	                   if(totalByte > 80) {
						$('#smsType').val("L");
	                       $('input:radio[name=smsTypes]:input[value=L]').attr("checked", true);
	                   } else {
						$('#smsType').val("S");
	                       $('input:radio[name=smsTypes]:input[value=S]').attr("checked", true);
	                   }
	
	                   if(totalByte > limitByte) {
	
	                   } else {
	
	                   }
	
	                   $('span.inputCnt').text(totalByte);
	               }
	           }
	
	           $(document).ready(function(){
	
	               $("input[type=submit], a, button").button()
	                 .click(function( e ) {
	                   e.preventDefault();
	               });
	
	               $("#btnSend").click(function( e ) {
	                   e.preventDefault();
	                   sendDirectSms();
	               });
	
	               $("#btnList").click(function( e ) {
	                   location.href = "sms_list.asp";
	               });
	
	               $("#btnClose").click(function( e ) {
	                   window.open("about:blank","_self").close();
	               });
	
	
	               $("#msg").keyup( function(e){
	                   checkByte();
	               });
	
	               $(".rdoSendType").change( function(e){
	                   if ($(this).val() == "S") {
	                       $(".reserveSms").hide();
	                   } else {
	                       $(".reserveSms").show();
	                   }
	               });
	               checkByte();
	
				$("#btnMoney").click(function( e ) {
	                   remainingMoney();
	               });
	           });
	
	
	           /*
	           function updateInputCount() {
	               var textLength = $("#msg").val().length;
	               var count = textLength;
	               $('span.inputCnt').text(count);
	               if (count >= 250) {
	                   $('span.inputCnt').addClass('disabled');
	               } else {
	                   $('span.inputCnt').removeClass('disabled');
	               }
	           }
	           */
	
			var selsphone = $("#smsForm select[name='sphone']").val();
			if(selsphone=='') {
				alert('발송번호가 등록되지 않아서 문자를 발송 할 수 없습니다');
				window.close();
		    }
	
			// SMS 잔액조회
			function remainingMoney() {
				$.ajax({
	                   type:"post",
	                   url:"/bos/system/sms/remainingMoney.json" ,
	                   data: $("#smsForm").serialize(),
	                   dataType: "json",
	                   success:function(entry){
	                	   
						//alert('잔여금액은 '+entry.point+'원입니다.');
						$("#remainMoney").append(entry.list.point);
	                   },
	                   fail:function(entry){
	                       alert("전송실패 : "+ entry);
	                   }
	               });
			}
	       </script>
	</div>
	<!--//  wrap -->
	</body>
</html>