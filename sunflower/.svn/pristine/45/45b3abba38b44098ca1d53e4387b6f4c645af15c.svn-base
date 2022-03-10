<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<div class="divViewSms" style="width:100%">
	<div class="btnGroup">
		<input type="submit" id="btnInsertSms" class="pure-button btnInsert" value="문자발송">
	</div>
	
	<div class="board_top" style="margin-top: 20px;">
		<span style="margin-top: 7px;">결과: <strong class="f_blue" id="txtTotalRecordSmsCount">${resultCnt }</strong>건
		</span>
	
		
			<div>
				<form name="formSearch" id="formSearch" class="pure-form">
					<input type="hidden" name="menuNo" value="${param.menuNo }"/>
					<input type="hidden" name="orderSmsType" id="orderSmsType" value="${param.orderSmsType}">
					<c:if test="${(userVO.authorCd eq 'ROLE_SUPER') || (userVO.authorCd eq 'CA') }">
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
						<button type="submit" id="btnJqgridSearch" class='pure-button btnSave'>검색</button>
					</c:if>
				</form>
			</div>
	</div>

	<c:choose>
	<c:when test="${(userVO.authorCd eq 'ROLE_SUPER') || (userVO.authorCd eq 'CA') }">
		<table class="table table-striped table-hover" style="width:100%;">
			<colgroup>
				<col style="width:30px;"/>
				<col style="width:150px;"/>
				<col style="width:110px;"/>
				<col style="width:55px;"/>
				<col style="width:95px;"/>
				<col style="width:400px;"/>
				<col style="width:40px;"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>센터명</th>
					<th>발송일</th>
					<th>발송자</th>
					<th>수신번호</th>
					<th>발신내용</th>
					<th><b><a href="javascript:orderSmsType();">형태</a></b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="rPhone" value="${fn:replace(result.rPhone, '-', '') }"/>
					<tr>
						<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
						<td>${result.groupName }</td>
						<td>
							<fmt:parseDate var="sendDate" value="${result.sendDate }" pattern="yyyy-MM-dd HH:mm"/>
							<fmt:formatDate value="${sendDate}" pattern="yyyy-MM-dd HH:mm" />
						</td>
						<td>${result.userName }</td>
						<td>${fn:replace(rPhone, fn:substring(rPhone, 3, 7), '****')}</td>
						<td style="text-align:left;">${result.msg }</td>
						<td>${result.smsType }MS</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="7">표시할 행이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</c:when>
	
	<c:otherwise>
	<table class="table table-striped table-hover" style="width:100%;">
		<colgroup>
			<col style="width:30px;"/>
			<col style="width:150px;"/>
			<col style="width:110px;"/>
			<col style="width:55px;"/>
			<col style="width:95px;"/>
			<col style="width:400px;"/>
			<col style="width:40px;"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>센터명</th>
				<th>발송일</th>
				<th>발송자</th>
				<th>수신번호</th>
				<th>발신내용</th>
				<th><b><a href="javascript:orderSmsType();">발송<br/>형태</a></b></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:set var="rPhone" value="${fn:replace(result.rPhone, '-', '') }"/>
				<tr>
					<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
					<td>${result.groupName }</td>
					<td>
						<fmt:parseDate var="sendDate" value="${result.sendDate }" pattern="yyyy-MM-dd HH:mm"/>
						<fmt:formatDate value="${sendDate}" pattern="yyyy-MM-dd HH:mm" />
					</td>
					<td>${result.userName }</td>
					<td>${fn:replace(rPhone, fn:substring(rPhone, 3, 7), '****')}</td>
					<td style="text-align:left;">${result.msg }</td>
					<td>${result.smsType }MS</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="7">표시할 행이 없습니다.</td>
					</tr>
			</c:if>
		</tbody>
	</table>
	</c:otherwise>
	</c:choose>
</div>

<form id="formPage" method="post">
	<input type="hidden" name="CNTR_COD"> 
	<input type="hidden" name="orderSmsType" id="orderSmsType" value="${param.orderSmsType}">
	<%-- <input type="hidden" name="searchCaseType" value="<%=searchCaseType%>"> 
	<input type="hidden" name="searchCaseText" value="<%=searchCaseText%>"> --%>
</form>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

<script>
	$('#btnInsertSms').click(function() {
		popupOpenSms('');
	});
	
	function popupOpenSms(telNumber){
		var popUrl = "/bos/system/sms/form.do?viewType=CONTBODY&menuNo=${param.menuNo}&caseSeq=${param.caseSeq}&rphone=" + telNumber;
		var popOption = "width=720, height=700, resizable=yes, scrollbars=yes, status=no";
		window.open(popUrl, "", popOption);
	}
	
	$(function(){
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
				url : "/bos/system/sms/searchCodeList.json",
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
	});

	function orderSmsType(){
	    var orderSmsType = document.getElementById("orderSmsType");
	    
	    if(orderSmsType.value == ""){
	        orderSmsType.value ="DESC";
	    }else if(orderSmsType.value == "ASC"){
	        orderSmsType.value = "DESC";
	    }else if(orderSmsType.value == "DESC"){
	        orderSmsType.value = "ASC";
	    }else{
	        orderSmsType.value = "ASC";
	    }
	    
	    var form = document.formSearch;
	    form.submit();
	}
</script>