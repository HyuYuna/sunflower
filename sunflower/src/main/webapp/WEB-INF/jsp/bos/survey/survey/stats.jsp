<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>
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

	/* getCmmnCd.select("CM04", "srcCntrGbn", "");
	getCmmnCd.select("CM05", "srcCntrCod", ""); */
	
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
});
</script>

	<div class="board_top">
		<div>
			<form name="formSearch" id="formSearch" method="get" class="pure-form">
				<input type="hidden" name="pageUnit" id="pageUnit"/>
				<input type="hidden" name="menuNo" value="${param.menuNo}">
			
				<c:choose>
					<c:when test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}">
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
					</c:when>
					<c:when test="${userVO.authorCd == 'BU' || userVO.authorCd == 'BA' || userVO.authorCd == 'BM' }">
						<input type="hidden" name="srcCntrGbn" id="srcCntrGbn" value="${fn:substring(userVO.centerCode, 0, 1)}" />
						<input type="hidden" name="srcCntrCod" id="srcCntrCod" value="${userVO.centerCode}" />
					</c:when>
				</c:choose>
				
				<select name="srcSvItem03" id="srcSvItem03">
					<c:forEach begin="0" end="${yearToday - 2016 }" var="i" varStatus="status">
						<c:set var="yearOption" value="${yearToday - i }"/>
						<option value="${yearOption }" ${param.srcSvItem03 eq yearOption ? 'selected' : '' }>${yearOption }년</option>
					</c:forEach>
				</select>
				<button type="submit" id="btnStatsSearch" class='pure-button btnSave'>확인</button>
			</form>
		</div>
	</div>

	<h4>작성자 
		<c:if test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}">
			[<a href="/bos/survey/survey/statsCenter.do?${pageQueryString }">센터별로 보기</a>]
		</c:if>
	</h4>
	<table cellpadding="0" cellspacing="0" border="0" class="table02">
		<colgroup>
			<col width="15%" />
			<col width="" />
			<col width="" />
			<col width="" />
		</colgroup>
		<thead>
			<tr>
				<th>구 분</th>
				<th>합 계</th>
				<th>본 인</th>
				<th>보호자</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>빈도(명)</th>
				<td>${stats.svItem011 + stats.svItem012 }</td>
				<td>${stats.svItem011}</td>
				<td>${stats.svItem012}</td>
			</tr>
		</tbody>
	</table>

	<h4>센터방문횟수</h4>
	<table cellpadding="0" cellspacing="0" border="0" class="table02">
		<colgroup>
			<col width="15%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
		</colgroup>
		<thead>
			<tr>
				<th>구 분</th>
				<th>합계</th>
				<th>10회 이하</th>
				<th>20회 이하</th>
				<th>30회 이하</th>
				<th>40회 이하</th>
				<th>50회 이하</th>
				<th>51회 이상</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>빈도(명)</th>
				<td>${stats.svItem021 + stats.svItem022 + stats.svItem023 + stats.svItem024 + stats.svItem025 + stats.svItem026 }</td>
				<td>${stats.svItem021 }</td>
				<td>${stats.svItem022 }</td>
				<td>${stats.svItem023 }</td>
				<td>${stats.svItem024 }</td>
				<td>${stats.svItem025 }</td>
				<td>${stats.svItem026 }</td>
			</tr>
		</tbody>
	</table>

	<h4>받은 서비스 (중복응답가능)</h4>
	<table cellpadding="0" cellspacing="0" border="0" class="table02">
		<colgroup>
			<col width="15%" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>상담지원 서비스</th>
				<th>의료지원 서비스</th>
				<th>수사지원 서비스</th>
				<th>심리치료 서비스</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>빈도(수)</th>
				<td>${stats.svItem06 }</td>
				<td>${stats.svItem07 }</td>
				<td>${stats.svItem08 }</td>
				<td>${stats.svItem10 }</td>
			</tr>
		</tbody>
	</table>

	<h4>서비스 만족도 및 권고 의사</h4>
	<table cellpadding="0" cellspacing="0" border="0" class="table02">
		<colgroup>
			<col width="15%" />
			<col width="" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="2">구 분</th>
				<th>합계</th>
				<th>매우<br />불만족
				</th>
				<th>불만족</th>
				<th>보통</th>
				<th>만족</th>
				<th>매우 만족</th>
				<th>무응답</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th rowspan="5" class="f_red">전체</th>
				<th class="f_red">센터환경</th>
				<td>${stats.svItem111 + stats.svItem112 + stats.svItem113 + stats.svItem114 + stats.svItem115 + stats.svItem116 }</td>
				<td>${stats.svItem111 }</td>
				<td>${stats.svItem112 }</td>
				<td>${stats.svItem113 }</td>
				<td>${stats.svItem114 }</td>
				<td>${stats.svItem115 }</td>
				<td>${stats.svItem116 }</td>

			</tr>
			<tr>
				<th class="f_red">위치 및 교통</th>
				<td>${stats.svItem121 + stats.svItem122 + stats.svItem123 + stats.svItem124 + stats.svItem125 + stats.svItem126 }</td>
				<td>${stats.svItem121 }</td>
				<td>${stats.svItem122 }</td>
				<td>${stats.svItem123 }</td>
				<td>${stats.svItem124 }</td>
				<td>${stats.svItem125 }</td>
				<td>${stats.svItem126 }</td>
			</tr>
			<tr>
				<th class="f_red">직원친절도</th>
				<td>${stats.svItem131 + stats.svItem132 + stats.svItem133 + stats.svItem134 + stats.svItem135 + stats.svItem136 }</td>
				<td>${stats.svItem131 }</td>
				<td>${stats.svItem132 }</td>
				<td>${stats.svItem133 }</td>
				<td>${stats.svItem134 }</td>
				<td>${stats.svItem135 }</td>
				<td>${stats.svItem136 }</td>
			</tr>
			<tr>
				<th class="f_red">정보제공</th>
				<td>${stats.svItem141 + stats.svItem142 + stats.svItem143 + stats.svItem144 + stats.svItem145 + stats.svItem146 }</td>
				<td>${stats.svItem141 }</td>
				<td>${stats.svItem142 }</td>
				<td>${stats.svItem143 }</td>
				<td>${stats.svItem144 }</td>
				<td>${stats.svItem145 }</td>
				<td>${stats.svItem146 }</td>
			</tr>
			<tr>
				<th class="f_red">서비스 내용</th>
				<td>${stats.svItem151 + stats.svItem152 + stats.svItem153 + stats.svItem154 + stats.svItem155 + stats.svItem156 }</td>
				<td>${stats.svItem151 }</td>
				<td>${stats.svItem152 }</td>
				<td>${stats.svItem153 }</td>
				<td>${stats.svItem154 }</td>
				<td>${stats.svItem155 }</td>
				<td>${stats.svItem156 }</td>
			</tr>
			<tr>
				<th rowspan="2">상담</th>
				<th>상담서비스 만족</th>
				<td>${stats.svItem161 + stats.svItem162 + stats.svItem163 + stats.svItem164 + stats.svItem165 + stats.svItem166 }</td>
				<td>${stats.svItem161 }</td>
				<td>${stats.svItem162 }</td>
				<td>${stats.svItem163 }</td>
				<td>${stats.svItem164 }</td>
				<td>${stats.svItem165 }</td>
				<td>${stats.svItem166 }</td>
			</tr>
			<tr>
				<th>충분한 대화</th>
				<td>${stats.svItem171 + stats.svItem172 + stats.svItem173 + stats.svItem174 + stats.svItem175 + stats.svItem176 }</td>
				<td>${stats.svItem171 }</td>
				<td>${stats.svItem172 }</td>
				<td>${stats.svItem173 }</td>
				<td>${stats.svItem174 }</td>
				<td>${stats.svItem175 }</td>
				<td>${stats.svItem176 }</td>
			</tr>
			<tr>
				<th rowspan="2">의료</th>
				<th>진료서비스 만족</th>
				<td>${stats.svItem181 + stats.svItem182 + stats.svItem183 + stats.svItem184 + stats.svItem185 + stats.svItem186 }</td>
				<td>${stats.svItem181 }</td>
				<td>${stats.svItem182 }</td>
				<td>${stats.svItem183 }</td>
				<td>${stats.svItem184 }</td>
				<td>${stats.svItem185 }</td>
				<td>${stats.svItem186 }</td>
			</tr>
			<tr>
				<th>신속한 진료</th>
				<td>${stats.svItem191 + stats.svItem192 + stats.svItem193 + stats.svItem194 + stats.svItem195 + stats.svItem196 }</td>
				<td>${stats.svItem191 }</td>
				<td>${stats.svItem192 }</td>
				<td>${stats.svItem193 }</td>
				<td>${stats.svItem194 }</td>
				<td>${stats.svItem195 }</td>
				<td>${stats.svItem196 }</td>
			</tr>
			<tr>
				<th rowspan="2">수사법률</th>
				<th>수사서비스 만족</th>
				<td>${stats.svItem201 + stats.svItem202 + stats.svItem203 + stats.svItem204 + stats.svItem205 + stats.svItem206 }</td>
				<td>${stats.svItem201 }</td>
				<td>${stats.svItem202 }</td>
				<td>${stats.svItem203 }</td>
				<td>${stats.svItem204 }</td>
				<td>${stats.svItem205 }</td>
				<td>${stats.svItem206 }</td>
			</tr>
			<tr>
				<th>법률서비스 만족</th>
				<td>${stats.svItem211 + stats.svItem212 + stats.svItem213 + stats.svItem214 + stats.svItem215 + stats.svItem216 }</td>
				<td>${stats.svItem211 }</td>
				<td>${stats.svItem212 }</td>
				<td>${stats.svItem213 }</td>
				<td>${stats.svItem214 }</td>
				<td>${stats.svItem215 }</td>
				<td>${stats.svItem216 }</td>
			</tr>
			<tr>
				<th rowspan="2">심리</th>
				<th>심리지원 서비스 만족</th>
				<td>${stats.svItem221 + stats.svItem222 + stats.svItem223 + stats.svItem224 + stats.svItem225 + stats.svItem226 }</td>
				<td>${stats.svItem221 }</td>
				<td>${stats.svItem222 }</td>
				<td>${stats.svItem223 }</td>
				<td>${stats.svItem224 }</td>
				<td>${stats.svItem225 }</td>
				<td>${stats.svItem226 }</td>
			</tr>
			<tr>
				<th>피해 후유증 완화</th>
				<td>${stats.svItem231 + stats.svItem232 + stats.svItem233 + stats.svItem234 + stats.svItem235 + stats.svItem236 }</td>
				<td>${stats.svItem231 }</td>
				<td>${stats.svItem232 }</td>
				<td>${stats.svItem233 }</td>
				<td>${stats.svItem234 }</td>
				<td>${stats.svItem235 }</td>
				<td>${stats.svItem236 }</td>
			</tr>
			<tr>
				<th colspan="2" class="f_red">이용권고</th>
				<td>${stats.svItem241 + stats.svItem242 + stats.svItem243 + stats.svItem244 + stats.svItem245 + stats.svItem246 }</td>
				<td>${stats.svItem241 }</td>
				<td>${stats.svItem242 }</td>
				<td>${stats.svItem243 }</td>
				<td>${stats.svItem244 }</td>
				<td>${stats.svItem245 }</td>
				<td>${stats.svItem246 }</td>
			</tr>
		</tbody>
	</table>

	<h4>기타의견</h4>
	<ul class="ul_list01">
 		<c:forEach var="stats" items="${text}" varStatus="status">
 			<li>${stats.svText01 }</li>
 		</c:forEach>
	</ul>

	<div class="btnGroup">
		<button id="btnStatsPrintBasic" title="printS-1" class="pure-button btnInsert">센터 이용자 만족도 출력</button>
	</div>

<script>
	$('#btnStatsPrintBasic').click(function(e) {
	    e.preventDefault();
	    var thisSeq = $(this).attr("title");
	    var thisGbn = $("#srcCntrGbn").val();
	    var thisCtr = $("#srcCntrCod").val();
	    var thisYear = $("#srcSvItem03").val();
	    //var myWindow = window.open("/bos/survey/survey/statsPrint.do?${pageQueryString}&searchCod="+ thisCtr +"&searchGbn="+ thisGbn +"&searchYear="+ thisYear, "stats_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
	    var myWindow = window.open("statsPrint.do?menuNo=${param.menuNo}&thisSeq="+thisSeq + "&thisCtr="+ thisCtr +"&thisGbn="+ thisGbn +"&thisYear="+ thisYear, "stats_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
	});
</script>