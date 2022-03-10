<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"  trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper"%>
<%@ page import="site.unp.cms.domain.MemberVO"%>
<%@ page import="site.unp.core.util.WebFactory"%>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) response.setHeader("Cache-Control", "no-cache"); 

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
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<c:set var="methodTitle" value="" />
<c:if test="${not empty siteVO.siteSkinCd}"><c:set var="skinCd" value="/${fn:toLowerCase(siteVO.siteSkinCd)}" /></c:if>
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:choose>
<c:when test="${fn:indexOf(fn:toLowerCase(paramVO.targetMethod),'list') gt -1}"><c:set var="methodTitle" value="목록" /></c:when>
<c:when test="${fn:indexOf(fn:toLowerCase(paramVO.targetMethod),'insert') gt -1}"><c:set var="methodTitle" value="등록" /></c:when>
<c:when test="${fn:indexOf(fn:toLowerCase(paramVO.targetMethod),'update') gt -1}"><c:set var="methodTitle" value="수정" /></c:when>
<c:when test="${fn:indexOf(fn:toLowerCase(paramVO.targetMethod),'view') gt -1}"><c:set var="methodTitle" value="상세보기" /></c:when>
<c:otherwise></c:otherwise>
</c:choose>
<!DOCTYPE html>
<html lang="ko">

<head>
<c:choose>
<c:when test="${path eq '/bos/instance/case/casePrint.do'}"><title>${paramVO.phName} 출력</title></c:when>
<c:otherwise><title>${currMenu.menuNm} ${methodTitle}</title></c:otherwise>
</c:choose>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="robots" content="all" />
<script src="/static/bos/commonEkr/js/jquery/jquery-1.12.2.min.js" type="text/javascript" charset="utf-8"></script>

<c:if test="${path ne '/bos/instance/case/casePrint.do' && path ne '/bos/survey/survey/statsPrint.do' && path ne '/bos/system/sms/form.do'}">
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/jslibrary/jquery-ui/jquery-ui.css">

<link rel="stylesheet" href="/static/font/NotoSans/notosans.css" />
<link rel="stylesheet" href="/static/font/nanumgothic/nanumgothic.css" />

<link rel="stylesheet" href="/static/bos/css/bossub.css" />

<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script src="/static/jslibrary/bootstrap/respond.min.js"></script>

<script src="/static/jslibrary/jquery.highlight-4.js"></script>
<script src="/static/jslibrary/jquery.maskedinput.min.js"></script>
<script src="/static/jslibrary/base64.js"></script>
<script src="/static/jslibrary/miya_validator.js"></script>
<script src="/static/bos/js/boscommon.js"></script>
<script src="/static/commons/commons.js"></script>
<script src="/static/jslibrary/ssl.js"></script>
</c:if>

<!-- 해바라기센터 -->
<link rel="stylesheet" href="/static/bos/css/pure-form.css">
<link rel="stylesheet" href="/static/bos/css/pure-button.css">
<link rel="stylesheet" href="/static/bos/css/pure-custom.css">
<link rel="stylesheet" href="/static/bos/css/tables-min.css">
<link href="/static/bos/commonEkr/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" type="text/css">
<link href="/static/bos/css/default.css" rel="stylesheet" type="text/css">
<c:if test="${path ne '/bos/instance/case/casePrint.do' && path ne '/bos/survey/survey/statsPrint.do' && path ne '/bos/system/sms/form.do'}">
<link href="/static/bos/css/style.css" rel="stylesheet" type="text/css">
</c:if>
<link href="/static/bos/css/sub.css" rel="stylesheet" type="text/css">

<!-- jqGrid 사용여부 : CSS -->   
        
<link href="/static/bos/commonEkr/js/jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="/static/bos/commonEkr/js/jqgrid/css/ui.jqgrid-custom.css" rel="stylesheet" type="text/css" media="screen"/>
   

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

<!-- c:if test="${userInfoPrtcAt eq 'T'}"-->
<c:if test="${userInfoPrtcAt eq 'TT'}">
<script type="text/javascript">
window.document.onkeydown=function() {return false; }
//window.document.onclick=function() {return false; }
window.document.ondblclick=function() {return false; }
window.document.oncontextmenu=function() {return false; }
window.document.ondragstart=function() {return false; }
window.document.onselectstart=function() {return false; }
</script>
</c:if>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="/static/jslibrary/selectivizr-min.js"></script>
<script src="/static/jslibrary/html5shiv.js"></script>
<![endif]-->

<c:if test="${path ne '/bos/instance/case/casePrint.do' && path ne '/bos/survey/survey/statsPrint.do' && path ne '/bos/system/sms/form.do'}">
<script>
	$(function(){
		$("#search").on('click',function(){
			search();
		});
		$("#searchTxt").on("keyup", function(event){
			search();
		});

		$(".gnbParentMenu").on('click',function() {
			if ($(this).closest("li").find("li").length > 0) {
				location.href = $(this).closest("li").find("li").children("a").attr("href");
				return false;
			}
		});

		$(".lnbParentMenu").on('click',function() {
			if ($(this).closest("li").find("li").length > 0) {
				location.href = $(this).closest("li").find("li").children("a").attr("href");
				return false;
			}
		});

		//caption 달기
		if ($("caption")) $("caption").text("${currMenu.menuNm} ${methodTitle}");
	});
	function search(){
		var searchTxt = $("#searchTxt").val();
		if(searchTxt)
		{
			$("#lnb ul li").each(function(){
				var text = $(this).text();
				var showMenu = (text.indexOf(searchTxt) != -1) || (cho_hangul(text).indexOf(searchTxt) != -1);
				if( showMenu ){
					$(this).show();
				} else {
					if($(this).parent())
						$(this).hide();
				}
			});
		} else {
			$("#lnb ul li").show();
		}
	}

	function cho_hangul(str) {
	  cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
	  result = "";
	  for(i=0;i<str.length;i++) {
	    code = str.charCodeAt(i)-44032;
	    if(code>-1 && code<11172) result += cho[Math.floor(code/588)];
	  }
	  return result;
	}

	function pagePrint(Obj) {
		alert(Obj);
	    var W = Obj.offsetWidth;        //screen.availWidth;
	    var H = Obj.offsetHeight;        //screen.availHeight;
	    var features
	= "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=" + W
	+ ",height=" + H + ",left=0,top=0";
	    var PrintPage = window.open("about:blank",Obj.id,features);
	    PrintPage.document.open();
	    PrintPage.document.write("\n\n" + Obj.innerHTML + "\n");
	    PrintPage.document.close();
	    PrintPage.document.title = document.domain;
	    PrintPage.print(PrintPage.location.reload());
	}

	//pagePrint(document.getElementById('content'));
	 function print_area()
	 {
		  var W=document.documentElement.clientWidth; if(!W){W=document.body.clientWidth;}
		  var H=document.documentElement.clientHeight; if(!H){H=document.body.clientHeight;}
		  var features = "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=" + W + ",height=" + H + ",left=0,top=0";
		  var PrintPage = window.open("about:blank","tmp_print",features);
		  PrintPage.document.open();
		  PrintPage.document.write("<html><head><title></title></head><body>" + document.getElementById('content').innerHTML + "</body></html>");
		  PrintPage.document.close();
		  PrintPage.print();
		  PrintPage.close();
	 }

	 function printf(){
		 document.frames['contentFrame'].focus();
		 document.frames['contentFrame'].print();
		 //document.frames['contentFrame'].contentWindow.location.href="/bos/forprint.jsp";
	 }

	 function println(){
		 window.open('/bos/forprint.jsp', 'popwin', 'left=20,top=20,width=616,height=700');
		 document.frames['contentFrame'].focus();
		 //document.frames['contentFrame'].print();
	 }

	function openPopup()
	{
		url = "/bos/cmmn/cmmnMngr/forUpdateMy.do?viewType=BODY&menuNo=100064";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1160, height=560");
	}
	function printSubmit(){
		window.open("", 'printPage', 'width=1024,height=640,scrollbars,toolbar,status=no,resizable=no');
		var printForm = document.printForm ;
		printForm.target="printPage";
		printForm.method="POST";
		printForm.action="/cmmn/bosForPrint.jsp";
		printForm.submit();

	}
</script>
</head>
<body>
	<div class="skip">
		<a href="#content">본문내용 바로가기</a>
		<a href="#gnb">주메뉴 바로가기</a>
	</div>
	<div id="wrap">
		<div id="header">

			<div class="gnb">
				<h1><a href="/bos/main/main.do">
					<c:if test="${not empty siteVO.atchFileId}"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="로고 이미지"></c:if>
					<c:if test="${empty siteVO.atchFileId}"><img src="/static/bos/img/noimage.gif" alt="${siteVO.fileCn}" /></c:if>
					</a></h1>
				
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />
				


				
				<script type="text/javascript">
				$(function(){
   					//전체메뉴
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
   					$(".view-btn-array li").click(function(){
   						$(this).addClass("active").siblings().removeClass("active");
   					});
   				})
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
			   
			   
			   // 기본 Zoom
			   var nowZoom = 100;
			   // 최대 Zoom
			   var maxZoom = 200;
			   // 최소 Zoom
			   var minZoom = 80;
			   
			   // 화면크기 확대
			   var jsBrowseSizeUp = function() {
			       
			       if( Browser.chrome ) {
			           if( nowZoom < maxZoom ) {
			               nowZoom += 5; 
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('최대 확대입니다.');
			           }
			       }
			       else if( Browser.opera ) {
			           alert('오페라는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else if( Browser.safari || Browser.safari3 || Browser.mac ) {
			           alert('사파리, 맥은 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else if( Browser.firefox ) {
			           alert('파이어폭스는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else {
			           if( nowZoom < maxZoom ) {
			               nowZoom += 5; 
			               document.body.style.position = "relative";
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('최대 확대입니다.');
			           }
			       }
			   };
			   
			   // 화면크기 축소
			   var jsBrowseSizeDown = function() {
			       
			       if( Browser.chrome ) {
			           if( nowZoom < maxZoom ) {
			               nowZoom -= 5; 
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('최대 확대입니다.');
			           }
			       }
			       else if( Browser.opera ) {
			           alert('오페라는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else if( Browser.safari || Browser.safari3 || Browser.mac  ) {
			           alert('사파리, 맥은 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else if( Browser.firefox ) {
			           alert('파이어폭스는 화면크기 기능을 지원하지 않습니다.\n브라우저 내의 확대/축소 기능을 이용하시기 바랍니다.');
			       }
			       else {
			           if( nowZoom < maxZoom ) {
			               nowZoom -= 5; 
			               document.body.style.position = "relative";
			               document.body.style.zoom = nowZoom + "%";
			           }
			           else{
			               alert('최대 확대입니다.');
			           }
			       }
			   };
			
			   // 화면크기 원래대로(100%)
			   var jsBrowseSizeDefault = function() {
			       
			       nowZoom = 100;
			       document.body.style.zoom = nowZoom + "%"; 
			   };
			
			</script>
			<div class="browser-control-wrap">
				<span>브라우져 확대/축소</span>
				<ul class="browser-control">
					<li><a href="#" onclick="jsBrowseSizeUp()">확대</a></li>
					<li><a href="#" onclick="jsBrowseSizeDown()">축소</a></li>
					<li><a href="#" onclick="jsBrowseSizeDefault()">기본</a></li>
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
				<p class="all-menu-btn"><a href="#"><img src="/static/bos/image/common/allmenu.png" alt="전체메뉴열기"/></a></p>
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
					<p class="all-menu-close"><a href="#"><img src="/static/bos/image/common/allmenu-close.png" alt="전체메뉴 닫기"/></a></p>
					</div>
				</div>
			</div>
			
			
				
			</div>	
			<%--
			<div id="gnb">
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />
			<c:if test="${fn:length(topCategories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth01}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(topCategories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${topCategories[y].popupAt eq 'Y'}">
						<a href="${topCategories[y].allMenuCours}" target="_blank">${topCategories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${topCategories[y].popupAt ne 'Y'}">
						<a href="${topCategories[y].fullMenuLink}" >${topCategories[y].menuNm}</a>
		 			</c:if>
		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>
			--%>
		</div>

		<div id="container">
			<div id="leftmenu">
			
				
				<div class="user_info">
					<!-- <p class="center-name">서울해바라기센터</p> -->
					<c:if test="${adminUser2.centerName != ''}"> <p class="center-name">${adminUser2.centerName}</p> </c:if>
					<p class="user-name">
					<em>
						${adminUser2.userNm}
					</em>
					님 안녕하세요
					</p>
 					<p class="etc"><a href="/bos/member/user/myPage.do?menuNo=100275"> 마이페이지</a></p>
					<p class="etc"><a href="/bos/member/admin/logout.do"> 로그아웃</a></p>
					
				<!-- 
				<c:set var="guideMenuList" value="${siteVO.guideMenuList01}"/>
				<c:if test="${fn:length(guideMenuList)>0}">
				<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
					<a href="${guideMenuList[x].allMenuCours}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="새창열림"' : ''} class="btn b-select btn-xs">${guideMenuList[x].menuNm}</a>
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
				<!-- <p><input type="text" name="searchTxt" id="searchTxt" value="" /> <label for="search"><a id="search" href="#search">조회</a></label></p> -->

		<c:set var="d02MenuKey" value="menu_${d02Category.menuNo}" />
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
						<a href="${d03Categories[x].allMenuCours}">${d03Categories[x].menuNm}</a>
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
								<a href="${d04Categories[y].allMenuCours}" data-question="${d04Categories[y].allMenuCours }">${d04Categories[y].menuNm}</a>
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
				<p>자동로그아웃 <span id="ViewTimer"></span>남음</p><!-- 로그인 접속IP:${userIp} -->
				<a href="javascript:;" class="btn-overtime vTimeResets">로그인 연장하기</a>
			</div>
			
			<div class="ac" style="margin-top:5px;"><a href="/bos/bbs/B0000005/list.do?menuNo=100059"><img src="/static/bos/image/btn_error.gif" alt="오류제보 게시판" /></a></div>
			<div class="ac" style="margin-top:5px;"><a href="/bos/bbs/B0000004/list.do?menuNo=100060"><img src="/static/bos/image/btn_faq.gif" alt="해·정·시 자주묻는 질문들" /></a></div>
<!-- 			<div class="ac" style="margin-top:5px;"><a href="#" onclick="window.open('/flash/index.html','','width=1000px, height=615px,scrollbars=yes');return false;"><img src="/static/bos/image/banner_left.jpg" alt="사용자교육 동영상보기" /></a></div>
 -->			<br><br>

		</div>

			</div>
			<div id="content">
				<div class="hgroup clearfix">
				<c:choose>
				<c:when test="${paramVO.currMenu ne null}"><h1>${paramVO.currMenu}</h1></c:when>
				<c:otherwise><h1>${currMenu.menuNm}</h1></c:otherwise>
				</c:choose>
					<div class="fr">
						<form name="printForm" action="/cmmn/bosForPrint.jsp" method="post">
							<input type="hidden" name="menuNo" value="${param.menuNo}"/>
							<input type="hidden" name="userInfoPrtcAt" value="${userInfoPrtcAt}"/>
							<input type="hidden" name="readngUserId" value="${paramVO.readngUserId}"/>
							<input type="hidden" name="readngPurpsSe" value="${paramVO.readngPurpsSe}"/>
							<input type="hidden" name="pageNo" value="${paramVO.pageNo}"/>
							<input type="hidden" name="readngIpad" value="${paramVO.readngIpad}"/>
							<input type="hidden" name="readngUrlad" value="${paramVO.readngUrlad}"/>
							<input type="hidden" name="readngInfo" value="${paramVO.readngInfo}"/>
						</form>
						<!-- a href="/bos/siteManage/siteHpcm/view.do?pGroupId=${paramVO.groupId}&amp;pSrvcId=${empty masterVO.bbsAttrbCd ? paramVO.programId : masterVO.bbsAttrbCd}&amp;pMethodId=${paramVO.targetMethod}&amp;pMenuNo=${paramVO.menuNo}&amp;viewType=BODY" class="b-help" title="도움말 새창열림" target="_blank" onclick="window.open(this.href, 'siteHpcm', 'resizable=1, scrollbars=1, width=1280,height=800'); return false;">도움말</a-->
						<!--a class="b-print" href="javascript:void(0);" id="print" title="새창" onclick="printSubmit();">
							<span >인쇄하기</span>
						</a-->
					</div>
				</div>
				</c:if>
					<c:choose>
					<c:when test="${not empty cntntsCn}">
						${cntntsCn}
					</c:when>
					<c:otherwise>
						<c:set var="_includePage" value="" />
						<c:choose>
							<c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
							<c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
							<c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
						</c:choose>
						<c:catch var ="catchException">
							<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
						</c:catch>
					</c:otherwise>
					</c:choose>
			</div>
		</div>
	</div>


<c:set var="guideMenuList" value="${siteVO.guideMenuList02}"/>
<c:if test="${fn:length(guideMenuList)>0}">
		<nav class="fnav">
			<ul>
			<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
				<li><a href="${guideMenuList[x].allMenuCours}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${guideMenuList[x].menuNm}</a></li>
			</c:forEach>
			</ul>
		</nav>
</c:if>



<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>
<%@ include file="/WEB-INF/jsp/bos/main/bosAutoLogout.jsp" %>

<c:catch var="catchException">
	${catchException }
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>

<div class="loading" id="loadingDiv" style="display:none;">
	<div class="spinner">
	  <div class="bounce1"></div>
	  <div class="bounce2"></div>
	  <div class="bounce3"></div>
	</div>
	<p><br><span id="loadingDivTxt">게시물 저장 중입니다.</span></p>
</div>
<!-- 로그기록  -->
<script>
document.writeln("<span class='sr-only'><img src='/${paramVO.siteId}/singl/siteConectStats/rcord.do?menuNo=${paramVO.menuNo}&amp;conectUrlad=${paramVO.requestURI}' alt=''></span>");
</script>
<!-- 로그기록 END  -->

<script>
function goServ(caseSeq){
    location.href="/bos/instance/case/view.do?menuNo=100189&caseSeq="+caseSeq+"&goServ=Y#caseInfo";
}
</script>
<!-- top이동 -->
<div class="topmove-area">
	<span class="move-top"><a href="javascript:;"><i>상단으로이동</i></a></span>
	<span class="move-bottom"><a href="javascript:;"><i>하단으로이동</i></a></span>
	<span class="move-link"><a href="javascript:goServ(${param.caseSeq});"><i>사례부가정보 확인</i></a></span>
</div>
<!--// top이동 -->
</body>
</html>

