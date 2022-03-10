<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<div id="footer">
	<div class="set">
		<c:set var="guideMenuList" value="${siteVO.guideMenuList02}"/>
		<c:if test="${fn:length(guideMenuList)>0}">
		<nav>
			<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
			<a href="${guideMenuList[x].menuLink}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${guideMenuList[x].menuNm}</a>
			</c:forEach>
		</nav>
		</c:if>
		<address>
			<p ><c:if test="${siteVO.zipUseAt eq 'Y'}">[${siteVO.zip}]</c:if><c:if test="${siteVO.adres1UseAt eq 'Y'}">${siteVO.adres1}</c:if><c:if test="${siteVO.adres2UseAt eq 'Y'}"> ${siteVO.adres2}</c:if> <c:if test="${siteVO.insttNmUseAt eq 'Y'}">${siteVO.insttNm}</c:if> <c:if test="${siteVO.telnoUseAt eq 'Y'}">, TEL : ${siteVO.telno}</c:if> <c:if test="${siteVO.faxnoUseAt eq 'Y'}">, FAX : ${siteVO.faxno}</c:if></p>
			<c:if test="${siteVO.cpyrhtCnUseAt eq 'Y'}"><em>${siteVO.cpyrhtCn}</em></c:if>
		</address>
		<p class="markset">
			<img src="/static/ucms/img/mark1.png" alt="1등급 Good Software / 인증기관 TTA 한국정보통신기술협회">
			<img src="/static/ucms/img/mark2.png" alt="Software & Solution Accessibility 인증 : 인증기관 웹와치(주)">
		</p>
	</div>
</div>

<!-- width="350" height="430" -->
<iframe class="chatFrame" title="유앤피플안내봇" allow="microphone;" src="https://console.dialogflow.com/api-client/demo/embedded/8d906433-94f0-4b70-90de-66e0d8656764">
</iframe>

<a href="javascript:void(0)" id="gotoTop" class="gotoTop"><span class="hidden">문서 맨 처음으로 이동</span></a>

<div class="chatSet" aria-label="UNPEOPLE 메신저 열기" role="button">
	<div> <img src="/static/commons/img/ico-sms.png" alt=""> </div>
</div>
<script>
	$('.chatSet').on('click',function(event) {
		event.preventDefault();
		$('.chatFrame').toggleClass('on');
		$('.chatSet').toggleClass('on');
	});
</script>
<style>
	.chatSet{
		cursor:pointer;
		position: fixed;
		right: 20px;
		bottom: 20px;
		width: 80px;
		background: #ffa900;
		background: #eee;
		border-radius: 100%;
		height: 80px;
		padding: 15px;
		-webkit-transition: all .25s ease-out;
		   -moz-transition: all .25s ease-out;
		    -ms-transition: all .25s ease-out;
		     -o-transition: all .25s ease-out;
		        transition: all .25s ease-out;
		z-index:999;

	}

	@media (max-width: 1023px){
		.chatSet{
			width: 50px;
			height: 50px;
			padding: 0;
		}
	}
	.chatSet>div{
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		height:50px;
	}
	.chatSet img{max-width:100%;}
	.chatSet.on{
		bottom:420px;
	}
	@media (max-width: 1023px){
		.chatSet.on{
			bottom:290px;
		}
	}
	.chatFrame{
		-webkit-transition: all .25s ease-out;
		   -moz-transition: all .25s ease-out;
		    -ms-transition: all .25s ease-out;
		     -o-transition: all .25s ease-out;
		        transition: all .25s ease-out;
		position:fixed;
		right:10px;
		bottom:-10px;
		max-width:calc(100% - 20px);
		height: 0;
		opacity:0;
		z-index: 200;
	}
	.chatFrame.on{
		bottom:20px;
		height: 430px;
		opacity:1;
		border:1px solid #ffa900;
	}
	@media (max-width: 1023px){
		.chatFrame.on{
			bottom:10px;
			height: 290px;
			opacity:1;
			border:1px solid #ffa900;
		}
	}
</style>

<c:if test="${siteVO.waValidUseAt eq 'Y'}">
<%@ include file="/WEB-INF/jsp/cmmn/validator.jsp" %>
</c:if>