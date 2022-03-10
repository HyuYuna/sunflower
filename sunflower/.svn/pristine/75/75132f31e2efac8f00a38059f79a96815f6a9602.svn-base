<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>
function goSearch(frm) {
	if(frm.sdate.value != "" && frm.edate.value != ""){
		if(frm.sdate.value > frm.edate.value) {
			alert("기간을 올바르게 선택해주세요.");
			frm.sdate.value = "";
			frm.edate.value = "";
			return false;
		}
	}
}

//목록
$(function() {
	//센터 유형별 동적 option 출력
	fnCodeDepthSelect = function(targetDepth){
		var depthNm = ["Gbn","Cod"];
		var targetDepthIdx = 2;
		
		//targetDepthIdx 추출
		for(i=0;i<depthNm.length;i++){
			if(depthNm[i].indexOf(targetDepth) > -1) targetDepthIdx = i+1;
		}

		$("#srcCntr" + targetDepth).empty().append("<option value=''>선택하세요</option>");
		$.ajax({
			url : "/bos/survey/survey/searchCodeList.json",
			type : "post",
			data : {
				sCode : "CM05",
				gCode : $("#srcCntr" + depthNm[0]).val()
			},
			async : false,
			success : function(data) {
				for (i = 0; i < data.titleList.length; i++) {
					var optionAppend = $("<option value='" + data.titleList[i].cdNo + "' >" + data.titleList[i].cdNm + "</option>")
					$("#srcCntr" + targetDepth).append(optionAppend);
				}
			}
		});
		
	};
	
	var frm = $("#formSearch")[0];
	
	$("#pageSelect").change(function() {
		var pageUnit = $(this).val();
		
		$.ajax({
				url: "/bos/survey/survey/pageUnitChange.json",
				type: "get",
				data: {pageUnit : pageUnit},
				success: function(data) {
					$("#pageUnit").val(pageUnit);
					
					frm.submit();
				}
		});
	});
	
	$("#srcCntrGbn").change(function(){
		frm.submit();
	});
	
	$("#srcCntrCod").change(function(){
		frm.submit();
	});
	
	$("#srcSvItem03").change(function(){
		frm.submit();
	});
});

function reg(){
	location.href= "/bos/survey/survey/forInsert.do?${pageQueryString}";
}
</script>

<div class="board_top">
	<span>결과 : <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</span>
	<div>
		<form name="formSearch" id="formSearch" method="get" action="/bos/survey/survey/list.do" class="pure-form">
			<input type="hidden" name="pageUnit" id="pageUnit"/>
			<input type="hidden" name="menuNo" value="${param.menuNo}">
			<c:if test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}">
				<select id="srcCntrGbn" name="srcCntrGbn" onchange="fnCodeDepthSelect('Cod')">
					<option value=''>전체 선택</option>
					<c:forEach var="result" items="${codeList}" varStatus="status">
						<option value="${result.cdNo }" ${param.srcCntrGbn eq result.cdNo ? 'selected' : '' }>${result.cdNm }</option>
					</c:forEach>
				</select>
				<select id="srcCntrCod" name="srcCntrCod">
					<option value=''>전체 선택</option>
					<c:forEach var="result" items="${codeList2}" varStatus="status">
						<option value="${result.cdNo }" ${param.srcCntrCod eq result.cdNo ? 'selected' : '' }>${result.cdNm }</option>
					</c:forEach>
				</select>
			</c:if>
			<select name="srcSvItem03" id="srcSvItem03">
				<c:forEach begin="0" end="${yearToday - 2016 }" var="i" varStatus="status">
					<c:set var="yearOption" value="${yearToday - i }"/>
					<option value="${yearOption }" ${param.srcSvItem03 eq yearOption ? 'selected' : '' }>${yearOption }년</option>
				</c:forEach>
			</select>
			<select id="pageSelect" name="pageSelect">
				<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
				<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
				<option value="40" ${paramVO.pageUnit eq '40' ? 'selected' : '' }>40개</option>
			</select>
		</form>
	</div>
</div>

<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>게시물 목록</caption>
		<colgroup>
			<col width="4%" />
			<col width="5%" />
			<col width="10%" />
			<col width="13%" />
			<col width="7%" />
			<col width="7%" />
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"></th>
				<th scope="col">연도구분</th>
				<th scope="col">등록일시</th>
				<th scope="col">센터명</th>
				<th scope="col">등록자</th>
				<th scope="col">작성자</th>
				<th scope="col">방문횟수</th>
				<th scope="col">상담</th>
				<th scope="col">의료</th>
				<th scope="col">수사법률</th>
				<th scope="col">심리치료</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="pQueryStr">
				<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
			</c:set>
			 <c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
					<td>${result.svItem03}년</td>
					<td><fmt:formatDate value="${result.svCdate}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>
						<a href="/bos/survey/survey/forUpdate.do?svSeq=${result.svSeq}&${pQueryStr}">${result.centerCodeName}</a>
					</td>
					<td>${result.svCuser}</td>
					<td>${result.svItem01 eq '1' ? '본인' : '보호자'}</td>
					<td>${result.svItem02}</td>
					<td>${result.svItem06 eq 'Y' ? result.svItem06 : 'N'  }</td>
					<td>${result.svItem07 eq 'Y' ? result.svItem07 : 'N'  }</td>
					<td>${result.svItem08 eq 'Y' ? result.svItem08 : 'N'  }</td>
					<td>${result.svItem10 eq 'Y' ? result.svItem10 : 'N'  }</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="11" class="nodata"><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
 		</tbody>
	</table>
</div>

<div class="btnGroup">
	<button class="pure-button btnInsert" onclick="reg();"><span>새 설문지 등록</span></button>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>