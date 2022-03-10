<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper"%>
<%@ page import="site.unp.cms.domain.MemberVO"%>
<%@ page import="site.unp.core.util.WebFactory"%>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%
ZValue zvl = WebFactory.getAttributes(request);
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

HashMap<String, List<ZValue>> adminMenuMap = (HashMap<String, List<ZValue>>)session.getAttribute("adminMenuMap");

MemberVO adminUser = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
pageContext.setAttribute("adminUser", adminUser);

SiteInfoService siteMngService = (SiteInfoService)context.getBean("siteInfoService");
ZValue site = siteMngService.getSiteBySiteName(SiteInfoService.BOS_SITE_ID);
pageContext.setAttribute("siteVO", site);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자(#번서버)</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="robots" content="all" />
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/static/jslibrary/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="/static/font/NotoSans/notosans.css" />
<link rel="stylesheet" href="/static/font/nanumgothic/nanumgothic.css" />
<link rel="stylesheet" href="/static/bos/css/bossub.css" />
<link rel="stylesheet" href="/static/bos/css/bosmain.css" />
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script src="/static/jslibrary/bootstrap/respond.min.js"></script>
<script src="/static/jslibrary/jquery-ui/jquery-ui.js"></script>
<script src="/static/bos/js/boscommon.js"></script>
<script src="/static/commons/commons.js"></script>
<script src="/static/jslibrary/base64.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="/static/jslibrary/selectivizr-min.js"></script>
<script src="/static/jslibrary/html5shiv.js"></script>
<![endif]-->
	<link rel="stylesheet" href="/static/jslibrary/gridstack.js-master/dist/gridstack.css"/>
	<link rel="stylesheet" href="/static/jslibrary/gridstack.js-master/dist/gridstack-extra.css"/>
	<!--[if lt IE 9]>
	<link rel="stylesheet" href="/static/jslibrary/gridstack.js-master/dist/gridstack-ie8.css"/>
	<![endif]-->
	<script src="/static/jslibrary/lodash.min.js"></script>
	<script src="/static/jslibrary/gridstack.js-master/dist/gridstack.js"></script>
	<script src="/static/jslibrary/gridstack.js-master/dist/gridstack.jQueryUI.js"></script>
	<script>
		function openPopup()
		{
			url = "/bos/singl/mngr/forUpdateMy.do?viewType=BODY";
			window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=700");
		}
	</script>
</head>
<body>
<!--
개발 남은 상황

회원수 카운트 하기<br/>
시스템정보에 새로고침 버튼<br/>
각게시판들 불러오는 쿼리<br/>
쿼리맵형태로 바꾸기 -->
<c:catch var="err">
<c:import var="weather" url="http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1111061500"></c:import>
	<x:parse var="wrss" xml="${weather}"></x:parse>
	<%-- <x:out select="$wrss/rss/channel/title"/><br/> --%>
	<c:set var="wfKor"><x:out select="$wrss/rss/channel/item/description/body/data[1]/wfKor" /></c:set>
	<c:set var="temp"><x:out select="$wrss/rss/channel/item/description/body/data[1]/temp" /></c:set>
	<c:set var="wfKor"><util:replaceAll string="${wfKor}" pattern=" " replacement="" /></c:set>
</c:catch>
<c:if test="${err!=null}">
   ${err}
</c:if>
	<div id="header_wrap">

			<div class="header">
				<h1><a href="/bos/main/main.do"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${siteVO.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${siteVO.streFileNm}'/>" alt="${siteVO.fileCn}"  width="110" height="40"/></a></h1>
				<div class="user">
					<em>
						<c:if test="${not empty adminUser.deptNm}">[${adminUser.deptNm}]</c:if>${adminUser.userNm}(${adminUser.userId})
					</em>
					님으로 로그인 하셨습니다.<!-- 로그인 접속IP:${userIp} -->
					<a href="javascript:openPopup();" class="btn btn-xs btn-success"><i class="fa fa-wrench"></i> 내정보수정</a>
					<a href="/bos/member/admin/logout.do" class="btn btn-xs btn-info"><i class="fa fa-power-off"></i> 로그아웃</a>
					<button id="save-grid" type="button" class="btn btn-xs btn-default"><i class="fa fa-gear"></i>위치저장</button>
				</div>
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />

				<div class="util ">
					<c:if test="${fn:length(topCategories)>0}">
					<div class="btn-group">

						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
							<c:choose>
							<c:when test="${x==0}"><c:set var="iconClass" value="fa-cogs" /></c:when>
							<c:when test="${x!=0}"><c:set var="iconClass" value="fa-home" /></c:when>
							</c:choose>
							<c:set var="clss" value=""/>
			 			<c:if test="${topCategories[x].popupAt eq 'Y'}">
							<a href="${topCategories[x].allMenuCours}" target="_blank" ${clss}><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
			 			<c:if test="${topCategories[x].popupAt ne 'Y'}">
							<a href="${topCategories[x].allMenuCours}" ${clss}><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
						</c:forEach>
					</div>
					</c:if>
				</div>
			</div>


		<div id="gnb">
		</div>

	</div>
	<main>
		<div id="maincontent">
<!--
회원수( 01 )
접속통계( 02 )
최근게시물표시( 03 )
바로가기( 04 )
오늘날씨( 05 )
캘린더( 06 )
관리자공지( 07 )
게시판현황( 08 )
시스템정보( 09 )
개별게시판( 10 )

태그 설명
grid-stack-item-content db10
db10 개별게시판 번호
-->

			<div class="device-xs visible-xs"></div>
			<div class="device-sm visible-sm"></div>
			<div class="device-md visible-md"></div>
			<div class="device-lg visible-lg"></div>
			<div class="device-xl visible-xl"></div>
			<div class="container-fluid">
				<!-- <div class="grid-stack"> -->
				<div class="grid-stack" data-gs-width="12" data-gs-animate="yes">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:set var="basicWidth" value="4"/>
		        		<c:set var="basicHeight" value="4"/>
		        		<c:if test="${result.bassMg eq '1'}">
		        			<c:set var="basicWidth" value="4"/>
		        			<c:set var="basicHeight" value="4"/>
		        		</c:if>
		        		<c:if test="${result.bassMg eq '2'}">
		        			<c:set var="basicWidth" value="2"/>
		        			<c:set var="basicHeight" value="2"/>
		        		</c:if>
		        		<c:if test="${result.bassMg eq '3'}">
		        			<c:set var="basicWidth" value="4"/>
		        			<c:set var="basicHeight" value="2"/>
		        		</c:if>
		        		<c:choose>
        					<c:when test="${result.bassMg eq '1'}"><c:set var="gridSize" value=""/></c:when>
        					<c:when test="${result.bassMg eq '2'}"><c:set var="gridSize" value="sm"/></c:when>
        					<c:when test="${result.bassMg eq '3'}"><c:set var="gridSize" value="md"/></c:when>
        					<c:otherwise><c:set var="gridSize" value=""/></c:otherwise>
        				</c:choose>
        				<c:choose>
        					<c:when test="${result.seCd eq '01'}">
										<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
											<div class="grid-stack-item-content db${result.seCd } ${gridSize }">
												<div class="d-t">
													<div class="d-c">
														<h1>${result.cdNm }</h1>
														<p>전체 : ${mainMberCntList[0].cnt} 명</p>
														<p class="s">어제 가입자 : ${mainMberCntList[1].cnt}명</p>
													</div>
												</div>
											</div>
										</div>
        					</c:when>
        					<c:when test="${result.seCd eq '03'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd } ${gridSize }">
										<h1>${result.cdNm }</h1>
										<!-- <p>TOTAL : 200건</p> -->
										<ul>
											<c:forEach var="_result" items="${recentNttList}" varStatus="status">
												<li>
													<a href="/bos/bbs/${_result.bbsId}/view.do?nttId=${_result.nttId}&amp;menuNo=${_result.menuNo}"><span class="cate">
														${_result.bbsNm}</span><span class="txt">${_result.nttSj}</span>
													</a>
												</li>
											</c:forEach>
											<c:if test="${fn:length(recentNttList) eq 0}"><li>등록된 게시물이 없습니다.</li></c:if>
										</ul>
									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '04'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? '3' : result.arValue}" data-gs-height="${empty result.hgValue ? '3' : result.hgValue}" data-gs-mnno="${result.mnno}" data-gs-max-height="4" data-gs-min-height="2">
									<div class="grid-stack-item-content db04 <c:if test="${not empty glanList[4].urlad}">first</c:if>">
									<!-- first는 5개일때 노출 -->
										<ul>
											<c:forEach var="_result" items="${glanList}" varStatus="status">
												<li><a href="${_result.urlad}" <c:if test="${_result.popupAt eq 'Y'}">target="_blank"</c:if> ><span class="t">${_result.estbsNm}</span><span class="${_result.iconNm } fa-2x vm"></span></a></li>
											</c:forEach>
											<c:if test="${fn:length(glanList) eq 0}"><li>등록된 게시물이 없습니다.</li></c:if>
										</ul>
									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '05'}">
        						<!-- 	weather1i.png 구름많음
										weather2i.png 구름조금
										weather3i.png 눈
										weather4i.png 눈비
										weather5i.png 맑음
										weather6i.png 비
										weather7i.png 흐림 -->
								<c:choose>
									<c:when test="${wfKor eq '구름많음'}"><c:set var="weatherIcon" value="weather1i.png"/></c:when>
									<c:when test="${wfKor eq '구름조금'}"><c:set var="weatherIcon" value="weather2i.png"/></c:when>
									<c:when test="${wfKor eq '눈'}"><c:set var="weatherIcon" value="weather3i.png"/></c:when>
									<c:when test="${wfKor eq '눈/비'}"><c:set var="weatherIcon" value="weather4i.png"/></c:when>
									<c:when test="${wfKor eq '맑음'}"><c:set var="weatherIcon" value="weather5i.png"/></c:when>
									<c:when test="${wfKor eq '비'}"><c:set var="weatherIcon" value="weather6i.png"/></c:when>
									<c:when test="${wfKor eq '흐림'}"><c:set var="weatherIcon" value="weather7i.png"/></c:when>
								</c:choose>
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd } ${gridSize }">
										<div class="d-t">
											<div class="d-c" style="background-image: url(/static/bos/img/weather1.png)">
											<i><img src="/static/bos/img/${weatherIcon}" alt=""></i>
											<p><span class="lg">${temp}°C</span>${wfKor}</p>
											</div>
										</div>
									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '06'}">
        						<jsp:useBean id="toDay" class="java.util.Date" />
								<fmt:formatDate value="${toDay}" var="day" pattern="dd"/>
								<fmt:formatDate value="${toDay}" var="korDay" pattern="E요일"/>
								<fmt:formatDate value="${toDay}" var="yearMonth" pattern="yyyy년MM월"/>
								<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" data-gs-min-height="2" data-gs-min-width="2">
									<div class="grid-stack-item-content db${result.seCd}"><!-- ${gridSize} -->
										<span class="day">${korDay }</span>
										<span class="year1">${yearMonth}</span>
										<span class="day2">${day}
											<span class="year">${yearMonth}</span>
										</span>
									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '07'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd} ${gridSize}">
										<h1>${result.cdNm }</h1>
										<c:if test="${fn:length(mngBbsList) gt 0}"><p><a href="/bos/bbs/${mngBbsList[0].bbsId}/list.do?menuNo=${mngBbsList[0].menuNo}" >more</a></p></c:if>
										<ul>
											<c:forEach var="_result" items="${mngBbsList}" varStatus="status">
												<li>
													<a href="/bos/bbs/${_result.bbsId}/view.do?nttId=${_result.nttId}&amp;menuNo=${_result.menuNo}"><span class="txt">${_result.nttSj}</span>
													<span class="date"><fmt:formatDate value="${_result.registDt}" pattern="yyyy-MM-dd"/></span></a>
												</li>
											</c:forEach>
											<c:if test="${fn:length(mngBbsList) eq 0}"><li>등록된 게시물이 없습니다.</li></c:if>
										</ul>

									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '08'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd} ${gridSize}">
										<h1>${result.cdNm }</h1>
										<!-- <p><a href="/bos/bbs/master/list.do?menuNo=100015">more</a></p> -->
										<ul>
											<c:forEach var="_result" items="${bbsMasterList}" varStatus="status">
												<li>
													<a href="/bos/bbs/${_result.bbsId}/list.do?menuNo=${_result.menuNo}"><span class="txt">${_result.bbsNm}</span>
													<span class="date"><fmt:formatDate value="${_result.registDt}" pattern="yyyy-MM-dd"/></span></a>
												</li>
											</c:forEach>
											<c:if test="${fn:length(bbsMasterList) eq 0}"><li>등록된 게시판 현황이 없습니다.</li></c:if>
										</ul>

									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '09'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd} ${gridSize}">
										<div class="systemInfor">
											<h1>시스템 정보
												<button id="systemInfoBtn" type="button" class="btn btn-xs btn-success vm">
												<i class="fa fa-refresh" aria-hidden="true"> </i> 새로고침
												</button>
											</h1>
											<h2>Physical Memory (<span id="totalPhysicalMemorySizeHR" class="total"></span>)</h2>
											<div class="clearfix">
												<div class="g"><div class="progress"><div id="usedPhysicalMemorySizeHRDiv" class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" ></div></div></div>
												<div class="p"><span id="percentPhysicalMemorySize"></span></div>
											</div>
											<h2>Swap Space (<span class="total" id="totalSwapSpaceSizeHR"></span>)</h2>
											<div class="clearfix">
												<div class="g"> <div class="progress"> <div id="usedSwapSpaceSizeHRDiv" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100"></div> </div> </div>
												<div class="p"><span id="percentSwapSpaceSize"></span></div>
											</div>

											<h2>JVM-Memory (<span id="memTotal" class="total"></span>)</h2>
											<div class="clearfix">
												<div class="g"><div class="progress"> <div id="memUsedDiv" class="progress-bar progress-bar-danger progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div> </div></div>
												<div class="p"><span id="memUsedPercent"></span></div>
											</div>
										</div>
									</div>
								</div>
        					</c:when>
        					<c:when test="${result.seCd eq '10'}">
        						<div class="grid-stack-item" data-gs-x="${empty result.lftCrdnt ? 0 : result.lftCrdnt}" data-gs-y="${empty result.upendCrdnt ? status.index*4 : result.upendCrdnt}" data-gs-width="${empty result.arValue ? basicWidth : result.arValue}" data-gs-height="${empty result.hgValue ? basicHeight : result.hgValue}" data-gs-mnno="${result.mnno}" >
									<div class="grid-stack-item-content db${result.seCd} ${gridSize}">
										<h1>${result.cdNm }</h1>
										<c:if test="${fn:length(indvdlzList) gt 0}"><p><a href="/bos/bbs/${indvdlzList[0].bbsId}/list.do?menuNo=${mngBbsList[0].menuNo}">more</a></p></c:if>
										<ul>
											<c:forEach var="_result" items="${indvdlzList}" varStatus="status">
												<li>
													<a href="/bos/bbs/${_result.bbsId}/view.do?nttId=${_result.nttId}&amp;menuNo=${_result.menuNo}" ><span class="txt">${_result.nttSj}</span>
													<span class="date"><fmt:formatDate value="${_result.registDt}" pattern="yyyy-MM-dd"/></span></a>
												</li>

											</c:forEach>
											<c:if test="${fn:length(indvdlzList) eq 0}"><li>등록된 게시물이 없습니다.</li></c:if>
										</ul>
									</div>
								</div>
        					</c:when>
        				</c:choose>
					</c:forEach>
				</div>
			</div>
			<script>
				$('.grid-stack-item').attr({
					'data-gs-max-width': '4',
					'data-gs-max-height': '4',
					'data-gs-min-width': '2',
					'data-gs-min-height': '2'
				});
				$('.db03, .db07, .db08, .db10').each(function(index, el) {
					$(this).parent().attr({
					// 'data-gs-max-width': '4',
					// 'data-gs-max-height': '4',
					'data-gs-min-width': '3',
					'data-gs-min-height': '3'
					});
				});

				$('.db09').parent().attr({
					'data-gs-max-width': '8',
					'data-gs-max-height': '4',
					'data-gs-min-width': '4',
					'data-gs-min-height': '2'
				});
				$(function () {
					systemInfo();
					$('#systemInfoBtn').on('click',function(){
						systemInfo();
					});

					function systemInfo() {
						$.post(
							"/bos/sys/sysInfo/list.json",
							{},
							function(data){
								var percentPhysicalMemorySize = data.systemInfo.percentPhysicalMemorySize;
								var totalPhysicalMemorySizeHR = data.systemInfo.totalPhysicalMemorySizeHR;
								var usedPhysicalMemorySizeHR = data.systemInfo.usedPhysicalMemorySizeHR;
								var freeSwapSpaceSizeHR = data.systemInfo.freeSwapSpaceSizeHR;
								var usedSwapSpaceSizeHR = data.systemInfo.usedSwapSpaceSizeHR;
								var percentSwapSpaceSize = data.systemInfo.percentSwapSpaceSize;
								var totalSwapSpaceSizeHR = data.systemInfo.totalSwapSpaceSizeHR;
								// console.log('percentPhysicalMemorySize : ' + percentPhysicalMemorySize);
								// console.log('totalPhysicalMemorySizeHR : ' + totalPhysicalMemorySizeHR);
								// console.log('usedPhysicalMemorySizeHR : ' + usedPhysicalMemorySizeHR);
								$('#percentPhysicalMemorySize').html(percentPhysicalMemorySize + '%');
								$('#totalPhysicalMemorySizeHR').html(totalPhysicalMemorySizeHR);
								$('#usedPhysicalMemorySizeHRDiv').html(usedPhysicalMemorySizeHR);
								$('#usedPhysicalMemorySizeHRDiv').css('width', percentPhysicalMemorySize + '%');

								$('#percentSwapSpaceSize').html(percentSwapSpaceSize + '%');
								$('#totalSwapSpaceSizeHR').html(totalSwapSpaceSizeHR);
								$('#usedSwapSpaceSizeHRDiv').html(usedSwapSpaceSizeHR);
								$('#usedSwapSpaceSizeHRDiv').css('width', percentSwapSpaceSize + '%');

								var memTotal = data.jvmInfo.memTotal;
								var memUsed = data.jvmInfo.memUsed;
								var memUsedPercent = data.jvmInfo.memUsedPercent;
								// console.log('memTotal : ' + memTotal);
								// console.log('memUsed : ' + memUsed);
								// console.log('memUsedPercent : ' + memUsedPercent);
								$('#memUsedPercent').html(memUsedPercent + '%');
								$('#memTotal').html(memTotal);
								$('#memUsedDiv').html(memUsed);
								$('#memUsedDiv').css('width', memUsedPercent + '%');
							}
						);
					}


					var options = {
						//float: true
						resizable: {
							handles: 'e, se, s, sw, w'
						}
					};
					$('.grid-stack').gridstack(options);

					this.saveGrid = function () {

                       this.serializedData = _.map($('.grid-stack > .grid-stack-item:visible'), function (el) {
                           el = $(el);
                           var node = el.data('_gridstack_node');

                           return {
                           	lftCrdnt: node.x,
                           	upendCrdnt: node.y,
                           	arValue: node.width,
                           	hgValue: node.height,
                           	mnno : el.data().gsMnno
                           };
                       }, this);
                       var inData = JSON.stringify(this.serializedData);
                       inData = Base64.encode(inData);
                       inData = {inData : inData};

                       //저장 시작
                       $.post(
   						"/bos/main/mngrMainEstbs/saveMngrMainLcEstbs.json",
   						inData,
   						function(data) {
   							if (data.resultCode == "success"){
   								alert("관리자 대쉬보드 설정이 수정되었습니다.")
   							}else{
   								alert("관리자 대쉬보드 설정이 실패하였습니다.")
   							}
   						},
   					"json");


                       $('#saved-data').val(JSON.stringify(this.serializedData, null, '    '));
                       return false;
                   }.on(this);

                   $('#save-grid').on('click',this.saveGrid);
				});
			</script>
		</div>
	</main>

<c:set var="guideMenuList" value="${siteVO.guideMenuList02}"/>
<c:if test="${fn:length(guideMenuList)>0}">
		<nav class="fnav">
			<ul>
			<c:forEach var="x" begin="0" end="${fn:length(guideMenuList)-1}" step="1">
				<li><a href="${guideMenuList[x].menuLink}" ${guideMenuList[x].popupAt eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${guideMenuList[x].menuNm}</a></li>
			</c:forEach>
			</ul>
		</nav>
</c:if>

	<%@ include file="/WEB-INF/jsp/bos/main/bosBottom.jsp" %>
</body>
</html>