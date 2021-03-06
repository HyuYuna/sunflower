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
   

<script src="/static/bos/commonEkr/js/jquery/jquery-1.12.2.min.js" type="text/javascript" charset="utf-8"></script>
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
		var linkgo=$(".bg_mng_main li a");
		linkgo.each(function(){
		$(this).on('click' , function(){
			var imgo = $('.bg_mng_main li').find('a');
			var imgo2 = $('.bg_mng_main').find('div');
			imgOff(imgo);
			imgOn($(this));
			var linkgo2 = $(this).parent().index();
			$(imgo2).removeClass("on");
			$(imgo2[linkgo2]).addClass("on");
			return false;
			});
		});
		var val = $.cookie('username');
		if( val ) {
			$("#username").val(val);
			$("#_spring_security_remember_me").attr("checked",true);
		}
		
		if( navigator.platform && location.host == "sunflower-center.kr" ){
			if( "win16|win32|win64|mac".indexOf(navigator.platform.toLowerCase())<0 ){
				if(location.protocol=="https:") document.location.href = document.location.href.replace('https:', 'http:');    //mobile
			}else{
				if(location.protocol=="http:") document.location.href = document.location.href.replace('http:', 'https:');    //web
			}
		}
	});
	function saveid(form) {
		if ($("#username").val() == "") {
			alert("아이디를 입력 하신 후 체크해주세요.");
			$("#username").focus();
			return;
		}
		if ($("#_spring_security_remember_me").is(":checked")){
			$.cookie('username', form.username.value, { expires: 300 });
		} else {
			$.cookie('username', "", { expires: 300 });
		}

	}

	//해외접속 체크
	$(function(){
		$.get("http://ip-api.com/json",function(data){
			var countryCode = data.countryCode
			var ovseaIpAt = "";
			if(countryCode == "KR"){
				ovseaIpAt = "N";
			}else{
				ovseaIpAt = "Y";
			}
			document.loginForm.ovseaIpAt.value = ovseaIpAt;
		},"jsonp");
	});

	function actionLogin2()
	{
		var form = document.loginForm;
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
			return;
		}
		else
		{
			saveid(form);
			form.submit();
		}
	}

	setTimeout("location.reload()", 1000*60*14);
</script>
<div id="header_wrap">
	<div class="header">
		<c:if test="${not empty siteVO.atchFileId}"><h1><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="${siteVO.siteNm}"></h1></c:if>
		<c:if test="${empty siteVO.atchFileId}"><h1><img src="/static/bos/img/logo.png" alt="${siteVO.siteNm}"> </h1></c:if>
	</div>
</div>
<form name="loginForm" id="loginForm" action ="/bos/member/admin/toLogin.do" method="post">
<input type="hidden" name="siteName" value="bos" />
<input type="hidden" name="loginFlag" value="${param.loginFlag}" />
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<input type="hidden" name="ovseaIpAt" id="ovseaIpAt"/>
<input type="hidden" name="adtCrtfcUseAt" id="adtCrtfcUseAt" value="${adtCrtfcUseAt}"/>
	<div class="login_form">
		<!-- <p class="logo"><img src="/static/bos/img/logo.png" alt="<spring:message code="site.slogan" text=""/>" /></p> -->
		<div class="tab2_main on">
			<div>
				<label for="username">아이디</label>
				<input id="username" name="username" type="text" value="" title="아이디" class="poab01" autofocus="autofocus">
			</div>
			<div>
				<label for="password">비밀번호</label>
				<input autocomplete="off" name="password" type="password"  value="" title="비밀번호" onkeydown="javascript:if (event.keyCode == 13) { actionLogin2(); }" class="poab02">
			</div>
			<div class="idsave">
				<label for="_spring_security_remember_me"><input type="checkbox" name="_spring_security_remember_me" id="_spring_security_remember_me" value="true"> ID저장</label>
			</div>
			
			<!--가상키보드 실행 버튼 생성태그 -->
			<span id="usafeon_passwd" class="poab05"></span>
			<!--//가상키보드 실행 버튼 생성태그 -->
		</div>
		<p><a href="javascript:actionLogin2();" class="pure-button pure-button-warning" style="width:265px; height:35px;">로그인</a></p>
		<span class="damdang">시스템 관련 문의 ☞ 사용자 문의게시판 ☜<br>지식정보팀 손지미 02-6363-8337<!--정보관리팀 박희원 02-6363-8333--></span>
	</div>
<p>${SPRING_SECURITY_LAST_EXCEPTION.message}</p>
</form>




<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>

</body>
</html>