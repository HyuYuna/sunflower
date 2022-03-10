<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>페이지인쇄하기 <spring:message code='site.korName' text=''/></title>
<meta name="robots" content="all" />
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/commons/common.css" />
<link rel="stylesheet" href="/static/font/NotoSans/notosans.css" />
<link rel="stylesheet" href="/static/bos/css/bossub.css" />
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<style type="text/css">
	body{background: #fff none 0 0 no-repeat;
	min-width:inherit;
	overflow-x:hidden;
	}
	body::before {
		display:none;

	}
	#wrap{width: auto ;margin: 0 0 0 0;background-image:none;}
	#wraper{background-image: url(none);width: auto;}
	#container,
	#content{float:none;margin: 0;padding: 0;background-image:none;}
	.print_btn_set{text-align: center;}
	.spot_visual{position: relative;top:0;}
	#content {width:100% !important;
		display:block !important;
		padding:0 5px;
	}
	.hgroup a,
	.hgroup .btn_print {display:none;}
	span.button {display:none;}
	#btn_print{text-align:center;}
.print{display:none}
@media print{
	#btn_print{display:none;}
	#content{padding:0;}

	.print{
		display:block;
		position: fixed;
	    left: 50%;
	    top: 5%;
	    font-size: 20px;
	    color: black;
	    opacity: 0.2;
	    text-align: center;
	    transform: rotate(-45deg) translate(-50%, -50%);
	    width: 50%;
	}
	.print:nth-child(2){top:60%}
}
.clickdisabled{
	position:absolute;
	top:56px;
	left:0;
	width:100%;
	height:100%;
	/*background-color:#ff0;*/
	z-index:999;
	opacity:0.5;
}

</style>

<script>
window.document.onkeydown=function() {return false; }
window.document.onclick=function() {return false; }
window.document.ondblclick=function() {return false; }
window.document.oncontextmenu=function() {return false; }
window.document.ondragstart=function() {return false; }
window.document.onselectstart=function() {return false; }
</script>
</head>
<body>

<!--
<div id="btn_print" style="display:none;width:680px;height:30px;text-align:center;padding-top:10px;"><a href="#btn_print" onclick="window.print();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/btn_print.gif" alt="인쇄하기" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#btn_print" onclick="window.close();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/close.gif" alt="창닫기" /></a></div>
-->
<div id="btn_print" style="display:none;text-align:center;padding-top:10px;">
	<div class="tac">
		<a class="btn btn-lg btn-warning" href="#btn_print" onclick="window.close();return false;">창닫기</a>
		<a class="btn btn-lg btn-success" href="#" onclick="return printSubmit();" id="print" title="새창" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i><span >인쇄하기</span></a>
	</div>
</div>
<script>
	//var openerHtml = opener.printBody.innerHTML ;
	var contentObj = opener.document.getElementById("content");
	if(contentObj)
	{
		// var openerHtml = contentObj.html();
		var openerHtml = $('#content',opener.document).html()
	//	var re1 = /<\s*a/gi
	//	var re2 = /<\/\s*a/gi
	//	openerHtml = openerHtml.replace(re1, "<span");
	//	openerHtml = openerHtml.replace(re2, "<\/span");
			var str = "<div id='content'>\n"
					+ openerHtml
					+ "<\/div>";
			document.write(str);
			console.log('z')
			// setTimeout(clickdisabled(),1000)
			setTimeout(function(){
				$('.clickdisabled').height($('#content').innerHeight())
				$('.clickdisabled').width($('#content').innerWidth())
			}, 500);
	}
	$(window).resize(function(event) {
		$('.clickdisabled').height($('#content').innerHeight());
		$('.clickdisabled').width($('#content').innerWidth());
	});
	setInterval(function(){
		$('.clickdisabled').height($('#content').innerHeight());
		$('.clickdisabled').width($('#content').innerWidth());
	},200)
</script>
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
<script>
	document.getElementById("btn_print").style.display = "";
</script>
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
<div class="clickdisabled"></div>

<c:if test="${param.userInfoPrtcAt eq 'T'}">
<div class="print-set">
<div class="print">
	<p><img src="/static/bos/img/watermark.png" alt=""></p>
<!-- 	<p class=code></p> -->
	<p>관리번호 : <span id="id_mnno"></span></p>
	<p>출력자ID : <span id="id_userId"></span></p>
	<p>출력일시 : <span id="id_printDt"></span></p>
</div>
</div>
<script>
function printSubmit(){

	$.post(
			"/bos/pips/userInfoPrtc/printRecord.json",
			{menuNo : "${param.menuNo}", userInfoPrtcAt : "${param.userInfoPrtcAt}", readngUserId : "${param.readngUserId}",
				readngPurpsSe : "개인정보(인쇄)", pageNo : "${param.pageNo}", readngIpad : "${param.readngIpad}",
				readngUrlad : "${param.readngUrlad}", readngInfo : "${param.readngInfo}"},

				function(data) {
	 				var resultCode = data.resultCode;
					if (resultCode == "success") {
						$("#id_mnno").text(data.mnno);
						$("#id_userId").text(data.userId);
						$("#id_printDt").text(data.printDt);

						$('.print .code').text(opener.location.href);
						var _html = $('.print-set').html();
						$('.print-set').html(_html+_html);
						window.print();
						return false;
					}
					else {
						alert("알수 없는 문제가 발생하여 출력하실 수 없습니다.");
						self.close();
						return;
					}
				},"json"
	)
}
</script>
</c:if>
<c:if test="${param.userInfoPrtcAt ne 'T'}">
<script>
function printSubmit(){
	window.print();
	return false;
}
</c:if>
</script>

</body>
</html>