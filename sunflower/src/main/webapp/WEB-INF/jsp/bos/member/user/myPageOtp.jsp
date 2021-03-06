<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>

<%
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());

SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
ZValue site = siteMngService.getSiteBySiteName(siteMngService.BOS_SITE_ID);
pageContext.setAttribute("siteVO", site);
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title> 해바라기 관리자페이지 로그인</title>
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/bos/css/bossub.css" />

<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script src="/static/jslibrary/bootstrap/respond.min.js"></script>
<script src="/static/jslibrary/jquery-ui/jquery-ui.js"></script>
<script src="/static/jslibrary/jquery.maskedinput.min.js"></script>
<script src="/static/jslibrary/jquery.cookie.js"></script>
<!-- <script src="/static/jslibrary/base64.js"></script> -->
<script src="/static/jslibrary/miya_validator.js"></script>
<script src="/static/bos/js/boscommon.js"></script>
<script src="/static/commons/commons.js"></script>
<script src="/static/jslibrary/ssl.js"></script>

<!-- 해바라기센터 -->
<link rel="stylesheet" href="/static/bos/css/pure-form.css">
<link rel="stylesheet" href="/static/bos/css/pure-button.css">
<link rel="stylesheet" href="/static/bos/css/pure-custom.css">
<link rel="stylesheet" href="/static/bos/css/tables-min.css">
<link href="/static/bos/commonEkr/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/default.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/style.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/sub.css" rel="stylesheet" type="text/css">

<!-- jqGrid 사용여부 : CSS -->   
        
<link href="/static/bos/commonEkr/js/jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="/static/bos/commonEkr/js/jqgrid/css/ui.jqgrid-custom.css" rel="stylesheet" type="text/css" media="screen"/>
   

<!-- <script src="/static/bos/commonEkr/js/jquery/jquery-1.12.2.min.js" type="text/javascript" charset="utf-8"></script> -->
<script src="/static/bos/commonEkr/js/jquery-ui/jquery-ui.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/static/bos/commonEkr/js/jquery/jquery-etc/jquery.maskedinput.min.js"></script>
<script src="/static/bos/commonEkr/js/jquery/jquery-etc/jquery.alphanumeric.js"></script>
<script src="/static/bos/commonEkr/js/jquery/jquery-cookie/jquery.cookie.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/additional-methods.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/localization/messages_ko.js" type="text/javascript"></script>

<script src="/static/bos/commonEkr/js/jquery/jquery.form.js"></script>

<script src="/static/bos/commonEkr/js/common.js"></script>
<script src="/static/bos/commonEkr/js/common_head.js"></script>

<script Language="JavaScript" src="/static/bos/manager/js/common.js"></script>

<!-- jqGrid 사용여부 : JS -->   
 
 <script src="/static/bos/commonEkr/js/jqgrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
 <script src="/static/bos/commonEkr/js/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>

 <script src="/static/bos/commonEkr/js/jqgrid/bbq/jquery.ba-bbq.js" type="text/javascript"></script>
 <script src="/static/bos/commonEkr/js/jqgrid/bbq/grid.history.js" type="text/javascript"></script>
<!--// 해바라기센터 -->

</head>
<body class="login">
<script>
$(function(){
	var numberPattern = /[^0-9]/gi;
	
	$(".otp-btn a").click(function(){
		$('#myModal').modal();
	})
	
	//숫자만 입력 가능
	$(".numberOnly").on("keyup", function() {
		if (numberPattern.test($(this).val())) {
			$(this).val($(this).val().replace(numberPattern, ""));
		}
	});
	
});

function actionLogin()
{
	var form = document.loginForm;
	var v = new MiyaValidator(form);

	v.add("userCode", {
		required: true
	});
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	else
	{
		form.submit();
	}
}

function actionOtpLogin()
{
	var form = document.listForm;
	var v = new MiyaValidator(form);

	v.add("userCode", {
		required: true
	});
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	else
	{
		form.submit();
	}
}

function copyToOtpKey()	{
	var copyText = document.getElementById('encodedKey');
	
	copyText.select();
	copyText.setSelectionRange(0, 99999);
	document.execCommand("Copy");
}
</script>
<div id="header_wrap">
	<div class="header">
		<c:if test="${not empty siteVO.atchFileId}"><h1><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="${siteVO.siteNm}"></h1></c:if>
		<c:if test="${empty siteVO.atchFileId}"><h1><img src="/static/bos/img/logo.png" alt="${siteVO.siteNm}"> </h1></c:if>
	</div>
</div>
<form name="loginForm" id="loginForm" action ="/bos/member/user/crtfcLogin.do" method="post">
	<input name="encodedKey" type="hidden" value="${encodedKey}">

	<div class="login_form otp-login">
		<div class="tab2_main on">
			<div>
				<label for="googleotp">OTP 인증번호</label>
				<input id="googleotp" name="userCode" type="text" value="" title="구글 OTP 인증번호(6자리)" class="poab01 numberOnly" placeholder="구글 OTP 인증번호(6자리)" autocomplete="off" maxlength="6">
			</div>
			
		</div>
		<p><a href="javascript:actionLogin();" class="pure-button pure-button-warning" >OTP 로그인</a></p>
		
		<p class="otp-btn"><a href="#" class="pure-button pure-button-list" >OTP 신규 등록</a></p>
<%-- 		<span class="damdang">시스템 관련 문의 ☞ 사용자 문의게시판 ☜<br>지식정보팀 손지미 02-6363-8337</span> --%>
		<span class="damdang">시스템 관련 문의 ☞ 사용자 문의게시판 ☜<br>헬프데스크 0505-362-8888</span>
	</div>
</form>

<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>

<!-- Modal -->
<div class="modal fade otp-modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">구글 OTP 등록</h4>
			</div>
			<div class="modal-body">
				<p class="text01">구글 OTP 관리 앱에 아래 QR코드 스캔 또는 제공된 키를 입력해주세요.</p>
				<p class="text01">* 구글 OTP 인증 전, 제공된 키를 안전한 곳에 보관하시기 바랍니다.<br />스마트폰 분실 혹은 재등록 시 필요합니다.</p>
				
				<div class="otp-con">
				<img alt="qrcode" src="${url}" style="display:block; margin:0px auto;" />
				<form name="listForm" id="listForm" action="/bos/member/user/crtfcLogin.do" method="post">
					<div>
					    <input name="encodedKey" id="encodedKey" type="text" value="${encodedKey}" readonly="readonly"><button type="button" class="btn btn-default dark" onclick="copyToOtpKey();">복사</button>
				    </div>
				    <p class="text">구글 OTP 입력</p>
					<p><input id="googleotp" name="userCode" type="text" value="" title="구글 OTP 인증번호(6자리)" class="poab01 numberOnly" placeholder="구글 OTP 인증번호(6자리)" autocomplete="off" maxlength="6"></p>
				</form>
				</div>
			</div>
			<div class="modal-footer">
				<button id="saveQesitmBtn" type="button" onclick="actionOtpLogin();" class="b-save">구글 OTP인증완료</button>
				<button type="button" class="btn btn-default dark" data-dismiss="modal">닫기</button>
			</div>
		</div> 
	</div>
</div>

</body>
</html>