<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="todayY" pattern="yyyy" />
<fmt:formatDate value="${toDay}" var="todayM" pattern="MM" />
<script>
function filePopZip(caseSeq){
	var caseSeq = caseSeq;
	var url = "/bos/instance/case/caseFilePopup.do";
    var params = "?viewType=BODY&caseSeq=" + caseSeq +"&urlType=zip";
    window.open(url+params , 'caseFilePopup',"width=500, height=300");
}

function relCase(caseNumber){
	$.ajax({
		url: "/bos/instance/case/findRelCase.json",
		type: "post",
		data: {caseNumber : caseNumber},
		success: function(data) {
			if(!data.caseSeq){
				alert('해당 사례가 없습니다.');
				
				return false;
			}
			
			var openNewWindow = window.open("about:blank");
			
			openNewWindow.location.href="/bos/instance/case/view.do?menuNo=100189" + "&caseSeq=" + data.caseSeq;
		}
});
}
</script>

<div class="cont_tit">
    <p class="local">HOME &gt; 사례정보 &gt; 보기</p>
</div>

<form id="frm" name="frm" method="post" enctype="multipart/form-data" >
	<div class="cont">
		<input type="hidden" name="menuNo" value="${param.menuNo}"> 
		<input type="hidden" name="caseSeq" value="${empty result.caseSeq ? 0 : result.caseSeq }" /> 
		<input type="hidden" name="attkrSeq" id="attkrSeq"  value="${result.caseAttkrSeq}" />
		<input type="hidden" name="userId" id="userId" value="${userVO.userId}" />
	   	<input type="hidden" name="userNm" value="${userVO.userNm}" />
	   	<input type="hidden" id="rbool" name="rbool" value="${paramVO.rbool}" />
	   	<input type="hidden" id="historyMemo" name="historyMemo" value="" />
		
		<div id="cont_case_preview" style="width:100%; margin-bottom:15px;">
			<table class="pure-table pure-table-bordered" style="width:100%;">
			    <colgroup>
			        <col style="width:120px;">
			        <col style="width:200px;">
			        <col style="width:120px;">
			        <col style="width:200px;">
			        <col style="width:120px;">
			        <col style="width:200px;">
			    </colgroup>
			    <tbody>
			     <tr >
			         <td class="bg-gray">피해자 이름</td>
			         <td colspan="7" style="padding:0px;">
			             <table class="pure-table pure-table-bordered" style="width:100%; border:0px">
			                 <colgroup>
			                     <col style="width:100px;">
			                     <col style="width:100px;">
			                     <col style="width:100px;">
			                     <col style="width:100px;">
			                     <col style="width:170px;">
			                     <col style="width:100px;">
			                     <col style="width:170px;">
			                 </colgroup>
			                 <tbody>
			                  <tr>
			                      <td class="align-center" id="victimName">${result.victimName}</td>
			                      <td class="bg-gray">성별</td>
			                      <td class="align-center">
			                      	<c:choose>
										<c:when test="${result.victimSex == 'M'}" >남자</c:when>
										<c:when test="${result.victimSex == 'F'}" >여자</c:when>
										<c:otherwise>
											알수없음
										</c:otherwise>
									</c:choose>
			                      </td>
			                      <td class="bg-gray">장애여부</td>
			                      <td class="align-center">
			                      	${result.victimDisableNm}
						          	<c:choose>
										<c:when test="${result.victimDisable == '1'}" >장애정도 : ${result.victimDisableMemo}</c:when>
										<c:when test="${result.victimDisable == '2'}" >장애명 : ${result.victimDisableMemo}</c:when>
										<c:when test="${result.victimDisable == '3'}" >장애명 : ${result.victimDisableMemo}</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
			                      </td>
			                      <td class="bg-gray">국적</td>
			                      <td class="align-center">
			                      	<c:choose>
										<c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
										<c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
			                      </td>
			                  </tr>
			              </tbody>
			        	</table>
			         </td>
			     </tr>
			     <tr style="height:30px;">
			         <td class="bg-gray">가명</td>
			         <td class="align-center">${result.caseAlias}</td>
			         <td class="bg-gray">피해구분</td>
			         <td class="align-center">${result.caseTypeNm} ${result.caseTypeSubNm}</td>
			         <td class="bg-gray">최초접수일</td>
			         <td class="align-center">${result.caseDate} ${result.caseTime}</td>
			         <td class="bg-gray">센터</td>
			         <td class="align-center">${result.centerName}</td>
			     </tr>
			     <tr style="height:30px;">
			         <td class="bg-gray">전산관리번호</td>
			         <td class="align-center">${result.caseNumber}</td>
			         <td class="bg-gray">센터사례번호</td>
			         <td class="align-center">${result.centerNumber}</td>
			         <td class="bg-gray">참조번호</td>
			         <td class="align-center" colspan="3">
			         	<c:set var="data" value="${fn:split(result.caseRel,', ')}" />
						<c:forEach var="x" begin="0" end="${fn:length(data)-1}">
					   		<span id="sapn_caseRel"><a href="javascript:relCase('${data[x]}');">${data[x]}</a></span><br/>
						</c:forEach>
			         </td>
				</tr>
				</tbody>
			</table>
			<input type="hidden" id="state_case_info" value="N">
		</div>
	</div>
</form>