<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper"%>
<%@ page import="site.unp.cms.domain.MemberVO"%>
<%@ page import="site.unp.core.util.WebFactory"%>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%
	//ZValue zvl = WebFactory.getAttributes(request);
	//org.springframework.context.ApplicationContext context =
	//org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	//MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

	/*HashMap<String, List<ZValue>> adminMenuMap = (HashMap<String, List<ZValue>>)session.getAttribute("adminMenuMap");*/

	//MemberVO adminUser = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	//pageContext.setAttribute("adminUser", adminUser);

	//SiteInfoService siteMngService = (SiteInfoService)context.getBean("siteInfoService");
	//ZValue site = siteMngService.getSiteBySiteName(SiteInfoService.BOS_SITE_ID);
	//pageContext.setAttribute("siteVO", site);
	
	
	
	
	
	
	MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
	
	ZValue zvl = WebFactory.getAttributes(request);
	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	
	HashMap<String, List<ZValue>> adminMenuMap = (HashMap<String, List<ZValue>>)session.getAttribute("adminMenuMap");
	pageContext.setAttribute("adminMenuMap",adminMenuMap);
	ZValue currentVo = masterMenuManagerService.getCurrentMenu(adminMenuMap, zvl.getInt("menuNo", 0));
	if (currentVo == null) currentVo = new ZValue();
	//currentVo = masterMenuManagerService.getCurrentMenuCategory(adminMenuMap, currentVo.getString("menuLc"));
	pageContext.setAttribute("currMenu", currentVo);
	
	String menuLc = currentVo.getString("menuLc");
	int depth01 = Integer.parseInt(menuLc.substring(0,2)) -1;
	int depth02 = Integer.parseInt(menuLc.substring(2,4)) -1;
	int depth03 = Integer.parseInt(menuLc.substring(4,6)) -1;
	int depth04 = Integer.parseInt(menuLc.substring(6,8)) -1;
	int depth05 = Integer.parseInt(menuLc.substring(8,10)) -1;
	int depth06 = Integer.parseInt(menuLc.substring(10,12)) -1;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
	pageContext.setAttribute("depth06", depth06);
	
	MemberVO adminUser = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("adminUser", adminUser);
	
	SiteInfoService siteMngService = (SiteInfoService)context.getBean("siteInfoService");
	ZValue site = siteMngService.getSiteBySiteName(SiteInfoService.BOS_SITE_ID);
	pageContext.setAttribute("siteVO", site);
	
%> 


<!DOCTYPE html>
<html lang="ko" data-livestyle-extension="available"><head>
	<title>?????????????????? ???????????????</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
	<meta name="robots" content="all" />
	<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="/static/bos/css/bossub.css">
	<link rel="stylesheet" href="/static/bos/css/bosmain.css">

	<jsp:useBean id="toDay" class="java.util.Date" />
	<fmt:formatDate var="now" value="${toDay }" pattern="yyyy-MM-dd HH:mm"/>
	<fmt:formatDate var="now2" value="${toDay }" pattern="yyyy-MM-dd" type="date"/>
	<fmt:parseDate var="nowTime" value="${now }" pattern="yyyy-MM-dd HH:mm"/>
	<fmt:parseNumber var="nowTimeN" value="${nowTime.time }" integerOnly="true"/>
	
	<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
	<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
	<script src="/static/bos/js/boscommon.js"></script>
	<script src="/static/commons/commons.js"></script>
	<!-- <link rel="stylesheet" href="/static/jslibrary/gridstack.js-master/dist/gridstack.css"> -->

	<!-- ?????????????????? -->
<link rel="stylesheet" href="/static/bos/css/pure-form.css">
<link rel="stylesheet" href="/static/bos/css/pure-button.css">
<link rel="stylesheet" href="/static/bos/css/pure-custom.css">
<link rel="stylesheet" href="/static/bos/css/tables-min.css">
<link href="/static/bos/commonEkr/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/default.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/style.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/sub.css" rel="stylesheet" type="text/css">

<!-- jqGrid ???????????? : CSS -->   
        
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

<!-- jqGrid ???????????? : JS -->   
 
 <script src="/static/bos/commonEkr/js/jqgrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
 <script src="/static/bos/commonEkr/js/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>

 <script src="/static/bos/commonEkr/js/jqgrid/bbq/jquery.ba-bbq.js" type="text/javascript"></script>
 <script src="/static/bos/commonEkr/js/jqgrid/bbq/grid.history.js" type="text/javascript"></script>
<!--// ?????????????????? -->

<script type="text/javascript">
jQuery(document).ready(function(){

		// #######################		Main PopUp Zone			  #################################

		 var popupSelectedIdx = 0;
		 var popupLastIdx = 2;                                                    // ?????? ?????? ??????
		 var timerSecond = 5000;                                                  // ?????? ??? ?????? (???)

		 // ######################## Method                                ########################
		 var popupManagement = {
					setChagePopup: function(){
								popupSelectedIdx = popupSelectedIdx + 1;
								 if (parseInt(popupSelectedIdx,10) == parseInt(popupLastIdx,10)) {
											popupSelectedIdx = 0;
								}
								popupManagement.setPopupListView(popupSelectedIdx);
								//popupManagement.setPopupTabView(popupSelectedIdx);
					},
					setPopupListView: function(idx){
								jQuery( '.popupList').css('display' ,'none').eq(idx).fadeIn('slow');
					},
					setPopupTabView: function(idx){
								jQuery( '.popupTab').removeClass('on').eq(idx).addClass('on');
					}
		}
		 // ######################## Event                                   ########################
		jQuery( '.popupTab').click(function (){
					 var idx = jQuery(this ).attr('id').replace( 'popuppTab_id_','' );
					popupManagement.setPopupListView(idx);
					popupManagement.setPopupTabView(idx);
					clearInterval(timer);
		});
		 // ######################## Init                           ########################
		popupManagement.setPopupListView(0);
		//popupManagement.setPopupTabView(0);
		var timer = setInterval(function () { popupManagement.setChagePopup();}, timerSecond);

	$("#passwordChange").click(function(){
		if($("#pwd").val()==''){
			alert('?????? ??????????????? ???????????????.');
			$("#pwd").focus();
			return;
		}else if($("#pwd1").val()==''){
			alert('??? ??????????????? ???????????????.');
			$("#pwd1").focus();
			return;
		}else if($("#pwd").val()==$("#pwd1").val()){
			alert('??? ??????????????? ?????? ??????????????? ????????? ????????????. ?????? ???????????????.');
			$("#pwd1").focus();
			return;
		}else if($("#pwd1").val()!=$("#pwd2").val()){
			alert('??? ??????????????? ?????? ???????????????.');
			$("#pwd2").focus();
			return;
		}else{
			var pwReg = /^[a-zA-Z0-9]{8,12}$/;
			var pw = $("#pwd1").val();
			//if(!pwReg.test(pw))
			if(pw.length<8 && pw.length>12)
			{
				alert('??????????????? ??????/??????/??????????????? ???????????? 8~12?????? ?????? ?????? ?????????.');
				$("#pwd1").focus();
				return;
			}

			var chk_num = pw.search(/[0-9]/g);
			var chk_eng = pw.search(/[a-z]/ig);
			var chk_spe = pw.search(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi);

			if(chk_num < 0 || chk_eng < 0 || chk_spe < 0)
			{
				alert('??????????????? ??????/??????/??????????????? ???????????? 8~12?????? ?????? ?????? ?????????.');
				$("#pwd1").focus();
				return;
			}

			if(confirm('??????????????? ?????????????????????????')){
				$.ajax({
					type:"post",
					url:"/user/mypage/passwordChange.do" ,
					data: $("#changePassForm").serialize(),
					dataType: "json",
					success:function(entry){
						alert(entry.resultMessage);
						$('#changePassForm').attr('action', '/index.asp');
						$('#changePassForm').submit();
					},
					fail:function(entry){
						alert("???????????? : "+ entry);
					}
				});
			}
		}

	});
});

</script>

	<script>
	function getCookie(cookieName) {
	  	var cookie = document.cookie;

	  	if(cookie.length > 0) {
	   		startIndex = cookie.indexOf(cookieName);

	   		if(startIndex != -1) {
	    		startIndex += cookieName.length;
	    		endIndex = cookie.indexOf(";", startIndex);

	    		if(endIndex == -1) endIndex = cookie.length;

	    		return unescape(cookie.substring(startIndex + 1, endIndex));
	   		} else {
	    		return false;
	   		}
	  	} else {
	   		return false;
	  	}
	}

	$(function() {
		
		if("${adminUser2.passwordDeriveYn}" == "Y"){
			fnChangePasswordDayOver();
		}
		
		<c:forEach var="result" items="${popupList}" varStatus="status">
			if (getCookie("gnEventCookie${result.popupNo}") != "done") {
				var url = "/bos/siteManage/popup/bosPopup.do?";
				var params = "viewType=CONTBODY&pop";
				var height;
				if (navigator.userAgent.indexOf('Chrome')>-1) {
					height = parseInt('${result.hgValue}');
		        } else {
		        	height = parseInt('${result.hgValue}')+34;
		        }

				window.open(url + params + "&popupNo=${result.popupNo}", "", "width=${result.arValue}, height="+height+", left=${result.lftCrdnt}, top=${result.upendCrdnt}, scrollbars=${result.scrlUseAt eq 'Y' ? 'yes' : 'no'}");
			}
		</c:forEach>
		
	});
	</script>

	<script>
		var tableHtml = "";
		var graphicAreaCls = "area1";
		var graphicCaption = "??????????????? ??????";
		var graphicTh = "???????????? ??????";

		function openPopup() {
			url = "/bos/cmmn/cmmnMngr/forUpdateMy.do?viewType=BODY&menuNo=100064";
			window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=700");
		}
	</script>
</head>
<body>
	<div class="skip">
		<a href="#maincontent">???????????? ????????????</a>
		<a href="#gnb">????????? ????????????</a>
	</div>
	<div id="wrap">
		<div id="header">
			
			
		
		<div class="gnb">
				<h1><a href="/bos/main/main.do">
					<c:if test="${not empty siteVO.atchFileId}"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="?????? ?????????"></c:if>
					<c:if test="${empty siteVO.atchFileId}"><img src="/static/bos/img/noimage.gif" alt="${siteVO.fileCn}" /></c:if>
					</a></h1>
				
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />

				
				<script type="text/javascript">
   				$(function(){
   					//????????????
   					$(".all-menu-btn").click(function(){
   						$(".all-menu-con").show();
   					});
   					$(".all-menu-close").click(function(){
   						$(".all-menu-con").hide();
   					});
   					$("#header .navi > li").mouseenter(function(){
   						$(this).children().next().show().parent().siblings().children().next().hide();	
   						$("#header").addClass("bg");
   					});
   					$("#header").mouseleave(function(){
   						$(".depth02").hide(); 		
   						$(this).removeClass("bg");
   					});
   				});
			   var Browser = { a : navigator.userAgent.toLowerCase() }
			   
			   Browser = {
			           ie : /*@cc_on true || @*/ false,
			           ie6 : Browser.a.indexOf('msie 6') != -1,
			           ie7 : Browser.a.indexOf('msie 7') != -1,
			           ie8 : Browser.a.indexOf('msie 8') != -1,
			           opera : !!window.opera,
			           safari : Browser.a.indexOf('safari') != -1,
			           safari3 : Browser.a.indexOf('applewebkit/5') != -1,
			           mac : Browser.a.indexOf('mac') != -1,
			           chrome : Browser.a.indexOf('chrome') != -1,
			           firefox : Browser.a.indexOf('firefox') != -1
			       }
			   
			   
			   // ?????? Zoom
			   var nowZoom = 100;
			   // ?????? Zoom
			   var maxZoom = 200;
			   // ?????? Zoom
			   var minZoom = 80;
			   
			   // ???????????? ??????
			   var jsBrowseSizeUp = function() {
			       
			       if( Browser.chrome ) {
			           if( nowZoom < maxZoom ) {
			               nowZoom += 5; 
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('?????? ???????????????.');
			           }
			       }
			       else if( Browser.opera ) {
			           alert('???????????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else if( Browser.safari || Browser.safari3 || Browser.mac ) {
			           alert('?????????, ?????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else if( Browser.firefox ) {
			           alert('?????????????????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else {
			           if( nowZoom < maxZoom ) {
			               nowZoom += 5; 
			               document.body.style.position = "relative";
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('?????? ???????????????.');
			           }
			       }
			   };
			   
			   // ???????????? ??????
			   var jsBrowseSizeDown = function() {
			       
			       if( Browser.chrome ) {
			           if( nowZoom < maxZoom ) {
			               nowZoom -= 5; 
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('?????? ???????????????.');
			           }
			       }
			       else if( Browser.opera ) {
			           alert('???????????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else if( Browser.safari || Browser.safari3 || Browser.mac  ) {
			           alert('?????????, ?????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else if( Browser.firefox ) {
			           alert('?????????????????? ???????????? ????????? ???????????? ????????????.\n???????????? ?????? ??????/?????? ????????? ??????????????? ????????????.');
			       }
			       else {
			           if( nowZoom < maxZoom ) {
			               nowZoom -= 5; 
			               document.body.style.position = "relative";
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('?????? ???????????????.');
			           }
			       }
			   };
			
			   // ???????????? ????????????(100%)
			   var jsBrowseSizeDefault = function() {
			       
			       nowZoom = 100;
			       document.body.style.zoom = nowZoom + "%"; 
			   };
			
			</script>
			<div class="browser-control-wrap">
				<span>???????????? ??????/??????</span>
				<ul class="browser-control">
					<li><a href="#" onclick="jsBrowseSizeUp()">??????</a></li>
					<li><a href="#" onclick="jsBrowseSizeDown()">??????</a></li>
					<li><a href="#" onclick="jsBrowseSizeDefault()">??????</a></li>
				</ul>
			</div>
			<c:if test="${fn:length(d02Categories)>0}">
				<ul class="navi">
		 	<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth02}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(d02Categories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${d02Categories[y].popupAt eq 'Y'}">
						<a href="${d02Categories[y].allMenuCours}" target="_blank">${d02Categories[y].menuNm}
							<c:if test="${d02Categories[y].menuNo eq '100223' && boardNewYn.cnt  gt '0' }">
								<img src="/static/bos/image/ico_new.gif" align="absmiddle"/>
							</c:if>
							<c:if test="${d02Categories[y].menuNo eq '100222' && boardNewYn2.cnt  gt '0' }">
								<img src="/static/bos/image/ico_new.gif" align="absmiddle"/>
							</c:if>
						</a>
		 			</c:if>
		 			<c:if test="${d02Categories[y].popupAt ne 'Y'}">
						<a href="${d02Categories[y].allMenuCours}" >${d02Categories[y].menuNm}
							<c:if test="${d02Categories[y].menuNo eq '100223' && boardNewYn.cnt  gt '0' }">
								<img src="/static/bos/image/ico_new.gif" align="absmiddle"/>
							</c:if>
							<c:if test="${d02Categories[y].menuNo eq '100222' && boardNewYn2.cnt  gt '0' }">
								<img src="/static/bos/image/ico_new.gif" align="absmiddle"/>
							</c:if>
						</a>
		 			</c:if>

		 			<c:set var="d02MenuKey" value="menu_${d02Categories[y].menuNo}" />
					<c:set var="d03Categories" value="${adminMenuMap[d02MenuKey]}" />
		 			<ul class="depth02">
						 	<c:forEach var="x" begin="0" end="${fn:length(d03Categories)-1}">
								<c:set var="popupAt" value="${d03Categories[x].popupAt}"/>
								<c:set var="clss" value=""/>
					 			<c:choose>
					 			<c:when test="${x==depth03}"><c:set var="clss" value="class='on'" /></c:when>
					 			</c:choose>
								<li ${clss}>
									<div>
									<span>
						 			<c:if test="${popupAt eq 'Y'}">
										<a href="${d03Categories[x].allMenuCours}" target="_blank">${d03Categories[x].menuNm}</a>
						 			</c:if>
						 			<c:if test="${popupAt ne'Y'}">
										<a href="${d03Categories[x].menuLink}">${d03Categories[x].menuNm}</a>
						 			</c:if>
						 			</span>
								<c:set var="d03MenuKey" value="menu_${d03Categories[x].menuNo}" />
								<c:set var="d04Categories" value="${adminMenuMap[d03MenuKey]}" />
								<c:if test="${fn:length(d04Categories)>0}">
										<ol>
						 		<c:forEach var="y" begin="0" end="${fn:length(d04Categories)-1}">
								<c:set var="popupAt" value="${d04Categories[y].popupAt}"/>
										<c:set var="clss2" value=""/>
							 			<c:choose>
							 			<c:when test="${x==depth03&&y==depth04}"><c:set var="clss2" value="class='on'" /></c:when>
							 			</c:choose>
											<li ${clss2}>
								 			<c:if test="${popupAt eq 'Y'}">
												<a href="${d04Categories[y].allMenuCours}" target="_blank">${d04Categories[y].menuNm}</a>
								 			</c:if>
								 			<c:if test="${popupAt ne 'Y'}">
												<a href="${d04Categories[y].menuLink}" data-question="${d04Categories[y].allMenuCours }">${d04Categories[y].menuNm}</a>
								 			</c:if>
											<c:set var="d04MenuKey" value="menu_${d04Categories[y].menuNo}" />
											<c:set var="d05Categories" value="${adminMenuMap[d04MenuKey]}" />
											<c:if test="${fn:length(d05Categories)>0}">
												<ol>
								 			<c:forEach var="z" begin="0" end="${fn:length(d05Categories)-1}">
												<c:set var="popupAt" value="${d05Categories[z].popupAt}"/>
												<c:set var="clss3" value=""/>
									 			<c:choose>
									 			<c:when test="${x==depth03&&y==depth04&&z==depth05}"><c:set var="clss3" value="class='on'" /></c:when>
									 			</c:choose>
													<li ${clss3}><a href="${d05Categories[z].allMenuCours}" >${d05Categories[z].menuNm}</a></li>
											</c:forEach>
												</ol>
											</c:if>
											</li>
									</c:forEach>
										</ol>
								</c:if>
							</div>
						</li>
					</c:forEach>
					</ul>

		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			
			<div class="all-menu-wrap">
				<p class="all-menu-btn"><a href="#"><img src="/static/bos/image/common/allmenu.png" alt="??????????????????"/></a></p>
				<div class="all-menu-con">
					<div>
						<c:if test="${fn:length(d02Categories)>0}">
							<ul>
					 	<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<c:set var="clss" value=""/>
				 			<c:choose>
				 			<c:when test="${y==depth02}"><c:set var="clss" value="class='on'" /></c:when>
				 			<c:when test="${y==fn:length(d02Categories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
				 			</c:choose>
				 			<li ${clss}>
					 			<c:if test="${d02Categories[y].popupAt eq 'Y'}">
									<a href="${d02Categories[y].allMenuCours}" target="_blank">${d02Categories[y].menuNm}</a>
					 			</c:if>
					 			<c:if test="${d02Categories[y].popupAt ne 'Y'}">
									<a href="${d02Categories[y].allMenuCours}" >${d02Categories[y].menuNm}</a>
					 			</c:if>
			
					 			<c:set var="d02MenuKey" value="menu_${d02Categories[y].menuNo}" />
								<c:set var="d03Categories" value="${adminMenuMap[d02MenuKey]}" />
					 			<ul>
									 	<c:forEach var="x" begin="0" end="${fn:length(d03Categories)-1}">
											<c:set var="popupAt" value="${d03Categories[x].popupAt}"/>
											<c:set var="clss" value=""/>
								 			<c:choose>
								 			<c:when test="${x==depth03}"><c:set var="clss" value="class='on'" /></c:when>
								 			</c:choose>
											<li ${clss}>
												<div>
												<span>
									 			<c:if test="${popupAt eq 'Y'}">
													<a href="${d03Categories[x].allMenuCours}" target="_blank">${d03Categories[x].menuNm}</a>
									 			</c:if>
									 			<c:if test="${popupAt ne'Y'}">
													<a href="${d03Categories[x].menuLink}">${d03Categories[x].menuNm}</a>
									 			</c:if>
									 			</span>
											<c:set var="d03MenuKey" value="menu_${d03Categories[x].menuNo}" />
											<c:set var="d04Categories" value="${adminMenuMap[d03MenuKey]}" />
											<c:if test="${fn:length(d04Categories)>0}">
													<ol>
									 		<c:forEach var="y" begin="0" end="${fn:length(d04Categories)-1}">
											<c:set var="popupAt" value="${d04Categories[y].popupAt}"/>
													<c:set var="clss2" value=""/>
										 			<c:choose>
										 			<c:when test="${x==depth03&&y==depth04}"><c:set var="clss2" value="class='on'" /></c:when>
										 			</c:choose>
														<li ${clss2}>
											 			<c:if test="${popupAt eq 'Y'}">
															<a href="${d04Categories[y].allMenuCours}" target="_blank">${d04Categories[y].menuNm}</a>
											 			</c:if>
											 			<c:if test="${popupAt ne 'Y'}">
															<a href="${d04Categories[y].menuLink}" data-question="${d04Categories[y].allMenuCours }">${d04Categories[y].menuNm}</a>
											 			</c:if>
														<c:set var="d04MenuKey" value="menu_${d04Categories[y].menuNo}" />
														<c:set var="d05Categories" value="${adminMenuMap[d04MenuKey]}" />
														<c:if test="${fn:length(d05Categories)>0}">
															<ol>
											 			<c:forEach var="z" begin="0" end="${fn:length(d05Categories)-1}">
															<c:set var="popupAt" value="${d05Categories[z].popupAt}"/>
															<c:set var="clss3" value=""/>
												 			<c:choose>
												 			<c:when test="${x==depth03&&y==depth04&&z==depth05}"><c:set var="clss3" value="class='on'" /></c:when>
												 			</c:choose>
																<li ${clss3}><a href="${d05Categories[z].allMenuCours}" >${d05Categories[z].menuNm}</a></li>
														</c:forEach>
															</ol>
														</c:if>
														</li>
												</c:forEach>
													</ol>
											</c:if>
										</div>
									</li>
								</c:forEach>
								</ul>
			
					 		</li>
						</c:forEach>
							</ul>
						</c:if>
					<p class="all-menu-close"><a href="#"><img src="/static/bos/image/common/allmenu-close.png" alt="???????????? ??????"/></a></p>
					</div>
				</div>
			</div>
			
				
			</div>	
		</div>

	<div id="container">
	
		<div id="leftmenu">
				<div class="user_info">
					<!-- <p class="center-name">????????????????????????</p> -->
					<c:if test="${adminUser2.centerName != ''}"> <p class="center-name">${adminUser2.centerName}</p> </c:if>
					<p class="user-name">
					<em>
						${adminUser2.userNm}
					</em>
					??? ???????????????
					</p>
 					<p class="etc"><a href="/bos/member/user/myPage.do?menuNo=100275"> ???????????????</a></p>
					<p class="etc"><a href="/bos/member/admin/logout.do"> ????????????</a></p>
					
				<!-- 
				<c:set var="guideMenuList" value="${siteVO.guideMenuList01}"/>
				<c:if test="${fn:length(guideMenuList)>0}">
				<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
					<a href="${guideMenuList[x].allMenuCours}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="????????????"' : ''} class="btn b-select btn-xs">${guideMenuList[x].menuNm}</a>
				</c:forEach>
				</c:if>
				 -->
				</div>
				
				<!-- div class="util">
					<c:if test="${fn:length(topCategories)>0}">
					<div class="btn-group">
						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
							<c:choose>
							<c:when test="${x==0}"><c:set var="iconClass" value="fa-cogs" /></c:when>
							<c:when test="${x!=0}"><c:set var="iconClass" value="fa-home" /></c:when>
							</c:choose>
							<c:set var="clss" value=""/>
				 			<c:choose>
				 			<c:when test="${x==depth01}"><c:set var="clss" value="class='on'" /></c:when>
				 			</c:choose>
			 			<c:if test="${topCategories[x].popupAt eq 'Y'}">
							<a href="${topCategories[x].allMenuCours}" target="_blank" ${clss}><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
			 			<c:if test="${topCategories[x].popupAt ne 'Y'}">
							<a href="${topCategories[x].allMenuCours}" ${clss}><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
						</c:forEach>
					</div>

					</c:if>

				</div> -->
				
				<!-- h2>${d02Category.menuNm}</h2> -->
				<!-- <p><input type="text" name="searchTxt" id="searchTxt" value="" /> <label for="search"><a id="search" href="#search">??????</a></label></p> -->

		<c:set var="d02MenuKey" value="menu_100229" />
		<c:set var="d03Categories" value="${adminMenuMap[d02MenuKey]}" />
		
		<div class="menu">
		<c:if test="${fn:length(d03Categories)>0}">
		
				<ul class="lnbNav-sun">
		 	<c:forEach var="x" begin="0" end="${fn:length(d03Categories)-1}">
				<c:set var="popupAt" value="${d03Categories[x].popupAt}"/>
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${x==depth03}"><c:set var="clss" value="class='on'" /></c:when>
	 			</c:choose>
				<li ${clss}>
					<div>
					<span>
		 			<c:if test="${popupAt eq 'Y'}">
						<a href="${d03Categories[x].allMenuCours}" target="_blank">${d03Categories[x].menuNm}</a>
		 			</c:if>
		 			<c:if test="${popupAt ne'Y'}">
						<a href="${d03Categories[x].menuLink}">${d03Categories[x].menuNm}</a>
		 			</c:if>
		 			</span>
				<c:set var="d03MenuKey" value="menu_${d03Categories[x].menuNo}" />
				<c:set var="d04Categories" value="${adminMenuMap[d03MenuKey]}" />
				<c:if test="${fn:length(d04Categories)>0}">
						<ol>
		 		<c:forEach var="y" begin="0" end="${fn:length(d04Categories)-1}">
				<c:set var="popupAt" value="${d04Categories[y].popupAt}"/>
						<c:set var="clss2" value=""/>
			 			<c:choose>
			 			<c:when test="${x==depth03&&y==depth04}"><c:set var="clss2" value="class='on'" /></c:when>
			 			</c:choose>
							<li ${clss2}>
				 			<c:if test="${popupAt eq 'Y'}">
								<a href="${d04Categories[y].allMenuCours}" target="_blank">${d04Categories[y].menuNm}</a>
				 			</c:if>
				 			<c:if test="${popupAt ne 'Y'}">
								<a href="${d04Categories[y].menuLink}" data-question="${d04Categories[y].allMenuCours }">${d04Categories[y].menuNm}</a>
				 			</c:if>
							<c:set var="d04MenuKey" value="menu_${d04Categories[y].menuNo}" />
							<c:set var="d05Categories" value="${adminMenuMap[d04MenuKey]}" />
							<c:if test="${fn:length(d05Categories)>0}">
								<ol>
				 			<c:forEach var="z" begin="0" end="${fn:length(d05Categories)-1}">
								<c:set var="popupAt" value="${d05Categories[z].popupAt}"/>
								<c:set var="clss3" value=""/>
					 			<c:choose>
					 			<c:when test="${x==depth03&&y==depth04&&z==depth05}"><c:set var="clss3" value="class='on'" /></c:when>
					 			</c:choose>
									<li ${clss3}><a href="${d05Categories[z].allMenuCours}" >${d05Categories[z].menuNm}</a></li>
							</c:forEach>
								</ol>
							</c:if>
							</li>
					</c:forEach>
						</ol>
				</c:if>
						</div>
					</li>
				</c:forEach>
				</ul>
		</c:if>
		
			<div class="left-timer">
				<p>?????????????????? <span id="ViewTimer">10??? 00??? </span>??????</p><!-- ????????? ??????IP:${userIp} -->
				<a href="javascript:;" class="btn-overtime vTimeResets">????????? ????????????</a>
			</div>
			
			<div class="ac" style="margin-top:5px;"><a href="/bos/bbs/B0000005/list.do?menuNo=100059"><img src="/static/bos/image/btn_error.gif" alt="???????????? ?????????" /></a></div>
			<div class="ac" style="margin-top:5px;"><a href="/bos/bbs/B0000004/list.do?menuNo=100060"><img src="/static/bos/image/btn_faq.gif" alt="????????????? ???????????? ?????????" /></a></div>
<!-- 			<div class="ac" style="margin-top:5px;"><a href="#" onclick="window.open('/flash/index.html','','width=1000px, height=615px,scrollbars=yes');return false;"><img src="/static/bos/image/banner_left.jpg" alt="??????????????? ???????????????" /></a></div>
 -->			<br><br>

		</div>

		</div>
			
		<div id="main">
			<!-- visual -->
			<div class="popupList"><img src="/static/bos/image/20210326_img01.png" alt="" /></div>
			<div class="popupList" style="display:none;"><img src="/static/bos/image/20220326_img02.png" alt="" /></div>
			
			<div class="main_cont">
				<!-- ??????????????? ?????? ??? ?????? ?????? -->
				<c:if test="${empty resultMypage.menuChoise}">
					<div class="cont01">
				        <h2>????????????<span><a href="/bos/bbs/B0000001/list.do?menuNo=100057"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid7List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000001/view.do?menuNo=100057&bid=bid7&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid7List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    
				    <div class="cont01" >
						<h2>?????????<span><a href="/bos/bbs/B0000003/list.do?menuNo=100058"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
						<table>
				        	<c:forEach var="result" items="${bid11List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000003/view.do?menuNo=100058&bid=bid11&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid11List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    
				    <div class="cont01" >
				        <h2>?????? ?????????<span><a href="/bos/board/board/list.do?menuNo=100184"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${boardList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/board/board/view.do?menuNo=100184&bddSeq=${result.bddSeq }">
						        			${result.bddTitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bddCdate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(boardList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    
				    <div class="cont01" >
				        <h2>?????? ?????????<span><a href="/bos/message/message/list.do?menuNo=100240"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${messageList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/message/message/view.do?menuNo=100240&seq=${result.seq }">
						        			${result.title }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.wdate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(messageList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				</c:if>
				
				<!-- ??????????????? ?????? ?????? ?????? -->
				<c:if test="${not empty resultMypage.menuChoise}">
					<div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b1') == -1 }">none;</c:if>">
				        <h2>????????????<span><a href="/bos/bbs/B0000001/list.do?menuNo=100057"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid7List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000001/view.do?menuNo=100057&bid=bid7&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid7List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b2') == -1 }">none;</c:if>">
				        <h2>???????????? ?????????<span><a href="/bos/bbs/B0000022/list.do?menuNo=100194"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid1List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000022/view.do?menuNo=100194&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid1List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b3') == -1 }">none;</c:if>">
						<h2>?????????<span><a href="/bos/bbs/B0000003/list.do?menuNo=100058"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
						<table>
				        	<c:forEach var="result" items="${bid11List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000003/view.do?menuNo=100058&bid=bid11&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid11List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b4') == -1 }">none;</c:if>">
				        <h2>???????????? ?????????<span><a href="/bos/bbs/B0000023/list.do?menuNo=100195"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid2List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000023/view.do?menuNo=100195&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid2List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b5') == -1 }">none;</c:if>">
				        <h2>?????? ?????????<span><a href="/bos/board/board/list.do?menuNo=100184"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${boardList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/board/board/view.do?menuNo=100184&bddSeq=${result.bddSeq }">
						        			${result.bddTitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bddCdate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(boardList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b6') == -1 }">none;</c:if>">
				        <h2>???????????? ?????????<span><a href="/bos/bbs/B0000025/list.do?menuNo=100197"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid4List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000025/view.do?menuNo=100197&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid4List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b7') == -1 }">none;</c:if>">
				        <h2>?????? ?????????<span><a href="/bos/message/message/list.do?menuNo=100240"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${messageList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/message/message/view.do?menuNo=100240&seq=${result.seq }">
						        			${result.title }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.wdate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(messageList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b8') == -1 }">none;</c:if>">
				        <h2>???????????? ?????????<span><a href="/bos/bbs/B0000026/list.do?menuNo=100198"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid5List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000026/view.do?menuNo=100198&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid5List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'b9') == -1 }">none;</c:if>">
				        <h2>?????? ????????????<span><a href="/bos/instance/case/list.do?menuNo=100188"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${caseList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/instance/case/view.do?menuNo=100188&caseSeq=${result.caseSeq }">
						        			${result.caseNumber }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.caseDate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(caseList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'c1') == -1 }">none;</c:if>">
				        <h2>??????????????? ????????????<span><a href="/bos/bbs/B0000027/list.do?menuNo=100199"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${bid6List}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/bbs/B0000027/view.do?menuNo=100199&boidx=${result.boidx }">
						        			${result.botitle }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.bocreatedate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(bid6List) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				    <div class="cont01" style="display: <c:if test="${fn:indexOf(resultMypage.menuChoise, 'c2') == -1 }">none;</c:if>">
				        <h2>?????? ???????????????<span><a href="/bos/instance/case/listPass.do?menuNo=100219"><img src="/static/bos/image/btn_more.png" alt="?????????" /></a></span></h2>
				        <table>
				        	<c:forEach var="result" items="${passList}" varStatus="status">
					        	<tr>
					        		<td style="display: block; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width:290px; padding-bottom: 5px">
						        		<a href="/bos/instance/case/passView.do?menuNo=100219&caseSeq=${result.caseSeq }">
						        			${result.userName }
						        		</a>
					        		</td>
					        		<td style="text-align: left; padding-right: 80px">
					        		 	<c:if test="${result.dayDiff <= 3 }">
					        		 		<img src='/static/bos/image/ico_new.gif' align='absmiddle' style='top:-3px; display:block; position:relative;'>
					        		 	</c:if>
					        		</td>
					        		<td style="padding-bottom: 5px;">&nbsp;&nbsp;[${result.passDate }]</td>
					        	</tr>
					        </c:forEach>
					        <c:if test="${fn:length(passList) == 0}">
			                    ???????????? ????????????.
			                </c:if>
				        </table>
				    </div>
				</c:if>
			    
			    
			</div>
		
		</div>

</div>
<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>
<%@ include file="/WEB-INF/jsp/bos/main/bosAutoLogout.jsp" %>
<!-- ????????????  -->
<script>
document.writeln("<img src='/bos/singl/siteConectStats/rcord.do?menuNo=&amp;conectUrlad=/bos/main/main.do' border='0' width='0' height='0' alt='' />");
</script>
<!-- ???????????? END  -->


</body>
</html>