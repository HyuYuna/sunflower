<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<div class="board-top">
	<div class="sh">
		<form name="formSearch" id="formSearch" method="post" action="/bos/board/board/list.do" class="pure-form pure-form-aligned">
		    <input type="hidden" name="orderTitle" id="orderTitle" value="${param.orderTitle}">
		    <input type="hidden" name="orderWriter" id="orderWriter" value="${param.orderWriter}">
		    <input type="hidden" name="orderCdate" id="orderCdate" value="${param.orderCdate}">
			<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo}"/>
			<input type="hidden" name="userId" id="userId" value="${userVO.userId }"/>
			<input type="hidden" name="bdsSeq" id="bdsSeq" value="demand"/>
			작성센터 : 
			<select id="srcCntrGbn" name="srcCntrGbn" onchange="fnCodeDepthSelect('Cod')" style="width:100px;">
				<option value=''>센터 유형</option>
				<c:forEach var="result" items="${codeList}" varStatus="status">
					<option value="${result.cdNo }" ${param.srcCntrGbn eq result.cdNo ? 'selected' : '' }>${result.cdNm }</option>
				</c:forEach>
			</select>
			<select id="srcCntrCod" name="srcCntrCod" style="width:200px;">
				<option value=''>센터</option>
				<c:forEach var="result" items="${codeList2}" varStatus="status">
					<option value="${result.cdNo }" ${param.srcCntrCod eq result.cdNo ? 'selected' : '' }>${result.cdNm }</option>
				</c:forEach>
			</select>
			검색어 : 
			<select id="searchCnd" name="searchCnd">
				<option value="1" ${param.searchCnd eq '1' ? 'selected' : '' }>제목</option>
				<option value="2" ${param.searchCnd eq '2' ? 'selected' : '' }>작성자</option>
			</select>
			<input type="text" name="searchText" value="${param.searchText }" placeholder="검색어.."/>
			
			<select id="pageUnit" name="pageUnit">
				<option value="10" ${paramVO.pageUnit eq '10' ? 'selected' : '' }>10개</option>
				<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
				<option value="30" ${paramVO.pageUnit eq '30' ? 'selected' : '' }>30개</option>
				<option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
				<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
				<option value="200" ${paramVO.pageUnit eq '200' ? 'selected' : '' }>200개</option>
			</select>
			
			<button type="submit" id="btnSearch" class="pure-button btnSave" >검색</button>
		</form>
	</div>
	
	<span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</span>
</div>

<div style="width: 100%;">
	<form name="frm" id="frm" class="pure-form">
		<div style="width: 100%; padding-top: 0px;">
			<c:if test="${paramVO.menuNo eq '100184' }">
				<table id="GET" class="table table-hover">
					<colgroup>
						<col width="3%">
						<col width="">
						<col width="14%">
						<col width="10%">
						<col width="15%">
						<col width="13%">
						<col width="7%">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th><b><a href="javascript:orderTitle();">제목</a></b></th>
							<th>발신센터</th>
							<th><b><a href="javascript:orderCdate();">발신일</a></b></th>
							<th>접수자</th>
							<th>회신구분</th>
							<th>회신여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr ${result.bddNotice ne 0 ? 'style="color:#ff7800; font-weight:bold; background:#fdefd0"' : ''}>
								<td>
									<c:if test="${result.bddNotice ne '1' }"><c:out value="${(resultCnt) - (paramVO.pageUnit * (paramVO.pageIndex-1))}" /></c:if>
									<c:if test="${result.bddNotice eq '1' }"><img src="/static/bos/image/ico_notice.png"></c:if>
								</td>
								<td style="text-align:left;">
									<a href="javascript:bddView('<fmt:parseNumber integerOnly="true" value="${result.bddSeq}"/>', '${result.bddReadCount }', '${result.bddDataType }', '${result.bddCenter }');">
										${result.bddTitle }
									</a>
								</td>
								<td>${result.bddCenterName }</td>
								<td><fmt:formatDate value="${result.bddCdate }" pattern="MM-dd HH:mm"/></td>
								<td>
									<c:if test="${not empty result.bddrGetInfo }">${result.bddrGetInfo }</c:if>
									<c:if test="${empty result.bddrGetInfo }">미접수</c:if>
								</td>
								<td>
									<c:if test="${result.bddDataType eq 'A' }">회신요청(첨부파일)</c:if>
									<c:if test="${result.bddDataType eq 'B' }">회신필요없음</c:if>
									<c:if test="${result.bddDataType eq 'C' }">회신요청(댓글)</c:if>
								</td>
								<td>${result.bddReplyYn }</td>
							</tr>
							<c:set var="resultCnt" value="${resultCnt-1}" />
						</c:forEach>
					</tbody>
				</table>
			</c:if>

			<c:if test="${paramVO.menuNo eq '100185' }">
				<table id="SEND" class="table table-hover">
					<colgroup>
						<col width="3%">
						<col width="">
						<col width="7%">
						<col width="10%">
						<col width="13%">
						<col width="4%">
						<col width="7%">
						<col width="7%">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th><b><a href="javascript:orderTitle();">제목</a></b></th>
							<th><b><a href="javascript:orderWriter();">발신자</a></b></th>
							<th><b><a href="javascript:orderCdate();">발신일</a></b></th>
							<th>회신구분</th>
							<th>대상</th>
							<th>수신완료</th>
							<th>회신완료</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr ${result.bddNotice ne 0 ? 'style="color:#ff7800; font-weight:bold; background:#fdefd0"' : ''}>
								<td>
									<c:if test="${result.bddNotice ne '1' }"><c:out value="${(resultCnt) - (paramVO.pageUnit * (paramVO.pageIndex-1))}" /></c:if>
									<c:if test="${result.bddNotice eq '1' }"><img src="/static/bos/image/ico_notice.png"></c:if>
								</td>
								<td style="text-align:left;">
									<a href="/bos/board/board/view.do?bddSeq=<fmt:parseNumber integerOnly="true" value="${result.bddSeq}"/>&${pageQueryString}">
										${result.bddTitle }
									</a>
								</td>
								<td>${result.bddWriter }</td>
								<td><fmt:formatDate value="${result.bddCdate }" pattern="MM-dd HH:mm"/></td>
								<td>
									<c:if test="${result.bddDataType eq 'A' }">회신요청(첨부파일)</c:if>
									<c:if test="${result.bddDataType eq 'B' }">회신필요없음</c:if>
									<c:if test="${result.bddDataType eq 'C' }">회신요청(댓글)</c:if>
								</td>
								<td>${result.bddCenterTotal }</td>
								<td>${result.bddCenterRead }</td>
								<td>
									${result.bddDataType eq 'B' ? '-' : result.bddCenterDone }
								</td>
							</tr>
							<c:set var="resultCnt" value="${resultCnt-1}" />
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</form>
</div>

<div class="btnGroup">
	<c:if test="${paramVO.menuNo eq '100185' }">
		<img id="btnCreate" style="cursor: pointer" src="/static/bos/image/common/btn_write.png" alt="글쓰기" />
	</c:if>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

<script>
//목록
$(function() {
	//글쓰기 버튼작성시 기존문서 확인 및 신규번호 생성
	$('#btnCreate').click(function(){
		$.ajax({
			url : "/bos/board/board/documentState.json",
			type : "post",
			data : { userId : $("#userId").val() },
			async : false,
			success : function(data) {
				if(data.state == "A") {
					if(!confirm("기존 작성글이 있습니다. 계속해서 작성하시겠습니까?\n\n취소를 누르면 기존 작성중인 글은 삭제하고 새로운 글을 작성합니다.")) {
						$.get('/bos/board/board/documentDelete.json?bddSeq='+data.bddSeq + '&userId=' + $("#userId").val());
						location.href="/bos/board/board/forInsert.do?${pageQueryString}";
					} else {
						location.href="/bos/board/board/forUpdate.do?${pageQueryString}&bddSeq="+Math.floor(data.bddSeq);
					}
				} else {
					location.href="/bos/board/board/forInsert.do?${pageQueryString}";
				}
			}
		});
	});
	
	bddView = function(bddSeq, bddReadCount, bddDataType, bddCenter) {
		var chk = true;
		
		if(bddReadCount == 0 && bddDataType == 'B'){
			var ansConfirm = confirm("문서발송글에 대해서 처음으로 읽는 것으로 체크하시겠습니까?");
			if (!ansConfirm){
				chk = false;
			}
		}
		
		if(chk){
			location.href = "/bos/board/board/view.do?bddSeq="+bddSeq+"&${pageQueryString}";
		}
	};

	//센터 유형별 동적 option 출력
	fnCodeDepthSelect = function(targetDepth) {
		var depthNm = [ "Gbn", "Cod" ];
		var targetDepthIdx = 2;

		//targetDepthIdx 추출
		for (i = 0; i < depthNm.length; i++) {
			if (depthNm[i].indexOf(targetDepth) > -1)
				targetDepthIdx = i + 1;
		}

		
		$("#srcCntr" + targetDepth).empty().append("<option value=''>선택하세요</option>");
		$.ajax({
			url : "/bos/board/board/searchCodeList.json",
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

function orderTitle(){
    var orderTitle = document.getElementById("orderTitle");
    
    if(orderTitle.value == ""){
        orderTitle.value ="DESC";
    }else if(orderTitle.value == "ASC"){
        orderTitle.value = "DESC";
    }else if(orderTitle.value == "DESC"){
        orderTitle.value = "ASC";
    }else{
        orderTitle.value = "ASC";
    }
    document.getElementById("orderWriter").value="";
    document.getElementById("orderCdate").value="";
    
    var form = document.formSearch;
    form.submit();
}

function orderWriter(){
    var orderWriter = document.getElementById("orderWriter");
    
    if(orderWriter.value == ""){
        orderWriter.value ="ASC";
    }else if(orderWriter.value == "ASC"){
        orderWriter.value = "DESC";
    }else if(orderWriter.value == "DESC"){
        orderWriter.value = "ASC";
    }else{
        orderWriter.value = "ASC";
    }
    document.getElementById("orderTitle").value="";
    document.getElementById("orderCdate").value="";

    var form = document.formSearch;
    form.submit();
}

function orderCdate(){
    var orderCdate = document.getElementById("orderCdate");
    
    if(orderCdate.value == ""){
        orderCdate.value ="ASC";
    }else if(orderCdate.value == "ASC"){
        orderCdate.value = "DESC";
    }else if(orderCdate.value == "DESC"){
        orderCdate.value = "ASC";
    }else{
        orderCdate.value = "ASC";
    }
    document.getElementById("orderWriter").value="";
    document.getElementById("orderTitle").value="";

    var form = document.formSearch;
    form.submit();
}
</script>