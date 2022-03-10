<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="divPrintForm">
	<div style="width: 250px; float: right;">
		<table cellpadding="0" cellspacing="0" border="0" class="table02">
			<colgroup>
				<col width="5%" />
				<col width="31.66%" />
				<col width="31.66%" />
				<col width="31.66%" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="2">결재</th>
					<th>담당자</th>
					<th><input type="text" style="width: 100%;" id="formdiv1" /></th>
					<th><input type="text" style="width: 100%;" id="formdiv2" /></th>
				</tr>
				<tr style="height: 50px;">
					<td><input type="text" style="width: 100%;" id="formdiv3" /></td>
					<td><input type="text" style="width: 100%;" id="formdiv4" /></td>
					<td><input type="text" style="width: 100%;" id="formdiv5" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


<div id="divPrintZone">

	<div id="divPrintView" style="display: none">
		<div style="width: 250px; float: right;">
			<table cellpadding="0" cellspacing="0" border="0" class="table02">
				<colgroup>
					<col width="5%" />
					<col width="31.66%" />
					<col width="31.66%" />
					<col width="31.66%" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="2">결재</th>
						<th>담당자</th>
						<th><span id="viewdiv1"></span></th>
						<th><span id="viewdiv2"></span></th>
					</tr>
					<tr style="height: 50px;">
						<td style="text-align: center;"><span id="viewdiv3"></span></td>
						<td style="text-align: center;"><span id="viewdiv4"></span></td>
						<td style="text-align: center;"><span id="viewdiv5"></span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="c_both"></div>
	<h1 class="tit_line">센터 이용자 만족도 통계</h1>





	<h4>작성자</h4>
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
				<td class="ac">${stats.svItem011 + stats.svItem012 }</td>
				<td class="ac">${stats.svItem011}</td>                   
				<td class="ac">${stats.svItem012}</td>                   
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
				<td class="ac">${stats.svItem021 + stats.svItem022 + stats.svItem023 + stats.svItem024 + stats.svItem025 + stats.svItem026 }</td>
				<td class="ac">${stats.svItem021 }</td>
				<td class="ac">${stats.svItem022 }</td>
				<td class="ac">${stats.svItem023 }</td>
				<td class="ac">${stats.svItem024 }</td>
				<td class="ac">${stats.svItem025 }</td>
				<td class="ac">${stats.svItem026 }</td>
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
				<td class="ac">${stats.svItem06 }</td>
				<td class="ac">${stats.svItem07 }</td>
				<td class="ac">${stats.svItem08 }</td>
				<td class="ac">${stats.svItem10 }</td>
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
				<td class="ac">${stats.svItem111 + stats.svItem112 + stats.svItem113 + stats.svItem114 + stats.svItem115 + stats.svItem116 }</td>
				<td class="ac">${stats.svItem111 }</td>
				<td class="ac">${stats.svItem112 }</td>
				<td class="ac">${stats.svItem113 }</td>
				<td class="ac">${stats.svItem114 }</td>
				<td class="ac">${stats.svItem115 }</td>
				<td class="ac">${stats.svItem116 }</td>
			</tr>
			<tr>
				<th class="f_red">위치 및 교통</th>
				<td class="ac">${stats.svItem121 + stats.svItem122 + stats.svItem123 + stats.svItem124 + stats.svItem125 + stats.svItem126 }</td>
				<td class="ac">${stats.svItem121 }</td>
				<td class="ac">${stats.svItem122 }</td>
				<td class="ac">${stats.svItem123 }</td>
				<td class="ac">${stats.svItem124 }</td>
				<td class="ac">${stats.svItem125 }</td>
				<td class="ac">${stats.svItem126 }</td>
			</tr>
			<tr>
				<th class="f_red">직원친절도</th>
				<td class="ac">${stats.svItem131 + stats.svItem132 + stats.svItem133 + stats.svItem134 + stats.svItem135 + stats.svItem136 }</td>
				<td class="ac">${stats.svItem131 }</td>
				<td class="ac">${stats.svItem132 }</td>
				<td class="ac">${stats.svItem133 }</td>
				<td class="ac">${stats.svItem134 }</td>
				<td class="ac">${stats.svItem135 }</td>
				<td class="ac">${stats.svItem136 }</td>
			</tr>
			<tr>
				<th class="f_red">정보제공</th>
				<td class="ac">${stats.svItem141 + stats.svItem142 + stats.svItem143 + stats.svItem144 + stats.svItem145 + stats.svItem146 }</td>
				<td class="ac">${stats.svItem141 }</td>
				<td class="ac">${stats.svItem142 }</td>
				<td class="ac">${stats.svItem143 }</td>
				<td class="ac">${stats.svItem144 }</td>
				<td class="ac">${stats.svItem145 }</td>
				<td class="ac">${stats.svItem146 }</td>
			</tr>
			<tr>
				<th class="f_red">서비스 내용</th>
				<td class="ac">${stats.svItem151 + stats.svItem152 + stats.svItem153 + stats.svItem154 + stats.svItem155 + stats.svItem156 }</td>
				<td class="ac">${stats.svItem151 }</td>
				<td class="ac">${stats.svItem152 }</td>
				<td class="ac">${stats.svItem153 }</td>
				<td class="ac">${stats.svItem154 }</td>
				<td class="ac">${stats.svItem155 }</td>
				<td class="ac">${stats.svItem156 }</td>
			</tr>
			<tr>
				<th rowspan="2">상담</th>
				<th>상담서비스 만족</th>
				<td class="ac">${stats.svItem161 + stats.svItem162 + stats.svItem163 + stats.svItem164 + stats.svItem165 + stats.svItem166 }</td>
				<td class="ac">${stats.svItem161 }</td>
				<td class="ac">${stats.svItem162 }</td>
				<td class="ac">${stats.svItem163 }</td>
				<td class="ac">${stats.svItem164 }</td>
				<td class="ac">${stats.svItem165 }</td>
				<td class="ac">${stats.svItem166 }</td>
			</tr>
			<tr>
				<th>충분한 대화</th>
				<td class="ac">${stats.svItem171 + stats.svItem172 + stats.svItem173 + stats.svItem174 + stats.svItem175 + stats.svItem176 }</td>
				<td class="ac">${stats.svItem171 }</td>
				<td class="ac">${stats.svItem172 }</td>
				<td class="ac">${stats.svItem173 }</td>
				<td class="ac">${stats.svItem174 }</td>
				<td class="ac">${stats.svItem175 }</td>
				<td class="ac">${stats.svItem176 }</td>
			</tr>
			<tr>
				<th rowspan="2">의료</th>
				<th>진료서비스 만족</th>
				<td class="ac">${stats.svItem181 + stats.svItem182 + stats.svItem183 + stats.svItem184 + stats.svItem185 + stats.svItem186 }</td>
				<td class="ac">${stats.svItem181 }</td>
				<td class="ac">${stats.svItem182 }</td>
				<td class="ac">${stats.svItem183 }</td>
				<td class="ac">${stats.svItem184 }</td>
				<td class="ac">${stats.svItem185 }</td>
				<td class="ac">${stats.svItem186 }</td>
			</tr>
			<tr>
				<th>신속한 진료</th>
				<td class="ac">${stats.svItem191 + stats.svItem192 + stats.svItem193 + stats.svItem194 + stats.svItem195 + stats.svItem196 }</td>
				<td class="ac">${stats.svItem191 }</td>
				<td class="ac">${stats.svItem192 }</td>
				<td class="ac">${stats.svItem193 }</td>
				<td class="ac">${stats.svItem194 }</td>
				<td class="ac">${stats.svItem195 }</td>
				<td class="ac">${stats.svItem196 }</td>
			</tr>
			<tr>
				<th rowspan="2">수사법률</th>
				<th>수사서비스 만족</th>
				<td class="ac">${stats.svItem201 + stats.svItem202 + stats.svItem203 + stats.svItem204 + stats.svItem205 + stats.svItem206 }</td>
				<td class="ac">${stats.svItem201 }</td>
				<td class="ac">${stats.svItem202 }</td>
				<td class="ac">${stats.svItem203 }</td>
				<td class="ac">${stats.svItem204 }</td>
				<td class="ac">${stats.svItem205 }</td>
				<td class="ac">${stats.svItem206 }</td>
			</tr>
			<tr>
				<th>법률서비스 만족</th>
				<td class="ac">${stats.svItem211 + stats.svItem212 + stats.svItem213 + stats.svItem214 + stats.svItem215 + stats.svItem216 }</td>
				<td class="ac">${stats.svItem211 }</td>
				<td class="ac">${stats.svItem212 }</td>
				<td class="ac">${stats.svItem213 }</td>
				<td class="ac">${stats.svItem214 }</td>
				<td class="ac">${stats.svItem215 }</td>
				<td class="ac">${stats.svItem216 }</td>
			</tr>
			<tr>
				<th rowspan="2">심리</th>
				<th>심리지원 서비스 만족</th>
				<td class="ac">${stats.svItem221 + stats.svItem222 + stats.svItem223 + stats.svItem224 + stats.svItem225 + stats.svItem226 }</td>
				<td class="ac">${stats.svItem221 }</td>
				<td class="ac">${stats.svItem222 }</td>
				<td class="ac">${stats.svItem223 }</td>
				<td class="ac">${stats.svItem224 }</td>
				<td class="ac">${stats.svItem225 }</td>
				<td class="ac">${stats.svItem226 }</td>
			</tr>
			<tr>
				<th>피해 후유증 완화</th>
				<td class="ac">${stats.svItem231 + stats.svItem232 + stats.svItem233 + stats.svItem234 + stats.svItem235 + stats.svItem236 }</td>
				<td class="ac">${stats.svItem231 }</td>
				<td class="ac">${stats.svItem232 }</td>
				<td class="ac">${stats.svItem233 }</td>
				<td class="ac">${stats.svItem234 }</td>
				<td class="ac">${stats.svItem235 }</td>
				<td class="ac">${stats.svItem236 }</td>
			</tr>
			<tr>
				<th colspan="2" class="f_red">이용권고</th>
				<td class="ac">${stats.svItem241 + stats.svItem242 + stats.svItem243 + stats.svItem244 + stats.svItem245 + stats.svItem246 }</td>
				<td class="ac">${stats.svItem241 }</td>
				<td class="ac">${stats.svItem242 }</td>
				<td class="ac">${stats.svItem243 }</td>
				<td class="ac">${stats.svItem244 }</td>
				<td class="ac">${stats.svItem245 }</td>
				<td class="ac">${stats.svItem246 }</td>
			</tr>
		</tbody>
	</table>

	<h4>기타의견</h4>
	<ul class="ul_list01">
 		<c:forEach var="stats" items="${text}" varStatus="status">
 			<li>${stats.svText01 }</li>
 		</c:forEach>
	</ul>
</div>

<script>
	function fn_print_page_action() {
		$('#viewdiv1').text( $('#formdiv1').val() );
		$('#viewdiv2').text( $('#formdiv2').val() );
		$('#viewdiv3').text( $('#formdiv3').val() );
		$('#viewdiv4').text( $('#formdiv4').val() );
		$('#viewdiv5').text( $('#formdiv5').val() );

	}
</script>