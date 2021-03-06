<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/survey/survey/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/survey/survey/update.do" />
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script>

	$(function() {
		var Now = new Date(); // Tue Oct 20 2015 10:48:49 GMT+0900 (대한민국 표준시) 라고 표시된다.
		var thisYear = Now.getFullYear(); // 년도
		var thisMonth = Now.getMonth() + 1; // 월  // 월 단위의 경우 0부터 시작되기 때문에 +1 을 해줘야 한다
		var thisDay = Now.getDate(); // 일

		var toDay = thisYear + '' + thisMonth + '' + thisDay;

		var item03Selector = $("#board select[name='svItem03']");

		item03Selector.find('option').remove();

		if (toDay > 2020112) {
			for (var i = thisYear; i >= thisYear; i--) {
				item03Selector.append($('<option>', {
					value : i,
					text : i
				}));
			}
		} else {
			for (var i = thisYear; i >= thisYear; i--) {
				//if(i==thisYear || (i<=thisYear-1 && thisMonth==1 && thisDay >=25 && thisDay<=31)){
				item03Selector.append($('<option>', {
					value : i,
					text : i
				}));
				//}
			}
		}

		var numberPattern = /[^0-9]/gi;

		//숫자만 입력 가능
		$(".numberOnly").on("keyup", function() {
			if (numberPattern.test($(this).val())) {
				$(this).val($(this).val().replace(numberPattern, ""));
			}
		});

		$("input:checkbox[id=svItem06]").click(function() {
			if ($(this).is(":checked")) {
				$("#serveyQ2").show();
			} else {
				$("#serveyQ2").hide();
			}
		});

		$("input:checkbox[id=svItem07]").click(function() {
			if ($(this).is(":checked")) {
				$("#serveyQ3").show();
			} else {
				$("#serveyQ3").hide();
			}
		});

		$("input:checkbox[id=svItem08]").click(function() {
			if ($(this).is(":checked")) {
				$("#serveyQ4").show();
			} else {
				$("#serveyQ4").hide();
			}
		});

		$("input:checkbox[id=svItem10]").click(function() {
			if ($(this).is(":checked")) {
				$("#serveyQ5").show();
			} else {
				$("#serveyQ5").hide();
			}
		});
	})
	
	function fnFormValidationCheck() {
		var validator = $('#board').validate({
			rules:{
				svItem01: {required:true},
				svItem02: {required:true, number:true, range:[1,999]},
				svItem06: {require_from_group: [1, ".survey-service-group"]},
				
				svItem11: {required:true},
				svItem12: {required:true},
				svItem13: {required:true},
				svItem14: {required:true},
				svItem15: {required:true},
				
				svItem16: {required:"#svItem06:checked"},
				svItem17: {required:"#svItem06:checked"},
				
				svItem18: {required:"#svItem07:checked"},
				svItem19: {required:"#svItem07:checked"},
				
				svItem20: {required:"#svItem08:checked"},
				svItem21: {required:"#svItem08:checked"},
				
				svItem22: {required:"#svItem10:checked"},
				svItem23: {required:"#svItem10:checked"},

				svItem24: {required:true},
			},
			errorPlacement: function(error, element){
				if (element.is(".SV_ITEM01")) {
					error.appendTo(element.parents('.ctn'));
				} else if(element.is(".SV_ITEM02")){
					error.appendTo(element.parents('.ctn'));
				} else if (element.is(".SV_ITEM24")) {
					error.appendTo(element.parents('.ctn'));
				} else if (element.is(":radio")) {
					error.appendTo(element.parent().siblings('.al'));
				} else if (element.is(".survey-service-group")) {
					error.appendTo(element.parents('.ctn'));
				} else if (element.is(":checkbox")) {
					error.appendTo(element.parents('.ctn'));
				} else { // This is the default behavior
					error.insertAfter(element);
				}
			}
		});
					isValidation = validator.form();
					return isValidation;
				}
			
	function checkForm() {
		var v = fnFormValidationCheck();
		var form = $("#board")[0];
		
		if (v) {
			if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
				return;
			}

			form.submit();
		} else {
			alert("필수 항목을 입력해주세요.");
			return;
		}
	}

	function del() {
		if (confirm('설문지를 삭제하시겠습니까?\n\n삭제후에는 복구가 불가능합니다.')) {
			var form = $("#board")[0];
			form.action = "/bos/survey/survey/delete.do";
			form.submit();
		}
	}
	
	function list() {
		location.href="/bos/survey/survey/list.do?${pageQueryString}";
	}
</script>

<div id="contMain2">
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}" class="pure-form">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="svSeq" value="<fmt:parseNumber integerOnly='true' value='${empty result.svSeq ? 0 : result.svSeq }' />" />
	
		<p class="box01">* 본 이용도 만족도 조사는 「성폭력방지 및 피해자보호 등에 관한 법률」 시행규칙 제12조에 따라 매년 실시되는 조사입니다.<br />
	            &nbsp;&nbsp;&nbsp;해당 연도에 작성 완료된 이용자 만족도 내용을 입력해주십시오.<br />
	            * 입력시 주의사항<br />
	            &nbsp;&nbsp;&nbsp;- 이용자 만족도는 무기명 설문지입니다. 같은 설문지가 중복 입력되지 않도록 연번 등을 통해 관리바랍니다.<br />
	            &nbsp;&nbsp;&nbsp;- 본인과 보호자가 중복으로 작성한 경우는 본인으로 선택하여 입력하시기 바랍니다.<br />
	            &nbsp;&nbsp;&nbsp;- 응답자가 항목을 선택하지 않은 경우 ‘미선택’으로 입력하시기 바랍니다.<br />
				&nbsp;&nbsp;&nbsp;- 각 서비스별 만족도는 '받은서비스'란에 표기된 사항만 서비스 만족도를 입력할수 있습니다.<br />
				&nbsp;&nbsp;&nbsp;- 수사법률란은 통합하여 표기합니다. 둘중에 하나만 받은 경우 '받은 서비스'에는 '수사법률'을 선택하고, 답하지 않은 사항은 '미선택'으로 입력바랍니다.<br />
	            * 이용자 만족도 조사 결과는 여성가족부 고객만족도 평가, 해바라기센터 홍보 자료 등으로 활용됩니다.</p>
	
		<table id="serveyT1" class="table03">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="f_bold">연도구분</th>
					<td>
						<select name="svItem03" id="svItem03">
						</select>
						<!-- <select>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select> -->
					</td>
					<th scope="row" class="f_bold">등록자이름</th>
					<td>
						<c:out value="${userVO.userNm }"/>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table id="serveyT2" class="table03 mt10">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<thead>
				<th colspan="4">이용 만족 평가 설문지</th>
			</thead>
			<tbody>
				<tr>
					<th class="f_bold">작성자</th>
					<td>
						<span class='ctn'>
							<input type="radio" name="svItem01" id="svItem01-1" class="SV_ITEM01" value="1" ${result.svItem01 eq '1' ? 'checked' : '' }> <label for="svItem01-1">본인</label>
							<input type="radio" name="svItem01" id="svItem01-2" class="SV_ITEM01 ml10" value="2" ${result.svItem01 eq '2' ? 'checked' : '' }> <label for="svItem01-2">보호자</label>
						</span>
					</td>
					<th class="f_bold">센터방문횟수</th>
					<td>
						<span class='ctn'>
							<input type="text" name="svItem02" id="svItem02" class="SV_ITEM02 numberOnly w20p" value="${result.svItem02 }"> 회
						</span>
					</td>
				</tr>
				<tr>
					<th class="f_bold">받은 서비스 (중복체크)</th>
					<td colspan="3">
						<span class="ctn">
							<input type="checkbox" name="svItem06" id="svItem06" value="Y" class="survey-service-group" ${result.svItem06 eq 'Y' ? 'checked' : '' }> <label for="svItem06">상담</label>
							<input type="checkbox" name="svItem07" id="svItem07" value="Y" class="survey-service-group ml10" ${result.svItem07 eq 'Y' ? 'checked' : '' }> <label for="svItem07">의료</label>
							<input type="checkbox" name="svItem08" id="svItem08" value="Y" class="survey-service-group ml10" ${result.svItem08 eq 'Y' ? 'checked' : '' }> <label for="svItem08">수사&middot;법률</label>
							<input type="checkbox" name="svItem10" id="svItem10" value="Y" class="survey-service-group ml10" ${result.svItem10 eq 'Y' ? 'checked' : '' }> <label for="svItem10">심리치료</label>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table id="serveyQ1" class="table03">
			<colgroup>
				<col width="" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="7">1. 전체 서비스</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th class="f_bold">매우<br/>불만족</th>
					<th class="f_bold">불만족</th>
					<th class="f_bold">보통</th>
					<th class="f_bold">만족</th>
					<th class="f_bold">매우<br/>만족</th>
					<th class="f_bold">미선택</th>
				</tr>
				<tr>
					<td class="al">센터의 환경에 대해서 만족하십니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-1" value="1" ${result.svItem11 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-2" value="2" ${result.svItem11 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-3" value="3" ${result.svItem11 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-4" value="4" ${result.svItem11 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-5" value="5" ${result.svItem11 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem11" id="svItem11-6" value="6" ${result.svItem11 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">센터의 위치나 교통편에 대해서 만족하십니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-1" value="1" ${result.svItem12 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-2" value="2" ${result.svItem12 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-3" value="3" ${result.svItem12 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-4" value="4" ${result.svItem12 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-5" value="5" ${result.svItem12 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem12" id="svItem12-6" value="6" ${result.svItem12 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">직원들은 친절하고 존중받는 느낌이 들었습니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-1" value="1" ${result.svItem13 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-2" value="2" ${result.svItem13 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-3" value="3" ${result.svItem13 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-4" value="4" ${result.svItem13 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-5" value="5" ${result.svItem13 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem13" id="svItem13-6" value="6" ${result.svItem13 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">귀하에게 필요한 안내나 정보를 잘 제공받았습니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-1" value="1" ${result.svItem14 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-2" value="2" ${result.svItem14 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-3" value="3" ${result.svItem14 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-4" value="4" ${result.svItem14 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-5" value="5" ${result.svItem14 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem14" id="svItem14-6" value="6" ${result.svItem14 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">지원 받은 서비스 내용에 만족하십니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-1" value="1" ${result.svItem15 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-2" value="2" ${result.svItem15 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-3" value="3" ${result.svItem15 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-4" value="4" ${result.svItem15 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-5" value="5" ${result.svItem15 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem15" id="svItem15-6" value="6" ${result.svItem15 eq '6' ? 'checked' : '' }></td>
				</tr>
			</tbody>
		</table>
		<table id="serveyQ2" class="table03 mt10" ${result.svItem06 eq 'Y' ? '' : 'style="display:none;"' } >
			<colgroup>
				<col width="" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="7">2. 상담 서비스</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th class="f_bold">매우<br/>불만족</th>
					<th class="f_bold">불만족</th>
					<th class="f_bold">보통</th>
					<th class="f_bold">만족</th>
					<th class="f_bold">매우<br/>만족</th>
					<th class="f_bold">미선택</th>
				</tr>
				<tr>
					<td class="al">상담 서비스에 대해서 만족하십니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-1" value="1" ${result.svItem16 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-2" value="2" ${result.svItem16 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-3" value="3" ${result.svItem16 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-4" value="4" ${result.svItem16 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-5" value="5" ${result.svItem16 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem16" id="svItem16-6" value="6" ${result.svItem16 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">원하는 만큼 이야기를 충분히 나누셨습니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-1" value="1" ${result.svItem17 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-2" value="2" ${result.svItem17 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-3" value="3" ${result.svItem17 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-4" value="4" ${result.svItem17 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-5" value="5" ${result.svItem17 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem17" id="svItem17-6" value="6" ${result.svItem17 eq '6' ? 'checked' : '' }></td>
				</tr>
			</tbody>
		</table>
		<table id="serveyQ3" class="table03 mt10" ${result.svItem07 eq 'Y' ? '' : 'style="display:none;"' }>
			<colgroup>
				<col width="" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="7">3. 의료 서비스</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th class="f_bold">매우<br/>불만족</th>
					<th class="f_bold">불만족</th>
					<th class="f_bold">보통</th>
					<th class="f_bold">만족</th>
					<th class="f_bold">매우<br/>만족</th>
					<th class="f_bold">미선택</th>
				</tr>
				<tr>
					<td class="al">진료 서비스에 대해서 만족하십니까?<span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-1" value="1" ${result.svItem18 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-2" value="2" ${result.svItem18 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-3" value="3" ${result.svItem18 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-4" value="4" ${result.svItem18 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-5" value="5" ${result.svItem18 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem18" id="svItem18-6" value="6" ${result.svItem18 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">진료가 신속하게 이루어졌습니까?<span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-1" value="1" ${result.svItem19 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-2" value="2" ${result.svItem19 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-3" value="3" ${result.svItem19 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-4" value="4" ${result.svItem19 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-5" value="5" ${result.svItem19 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem19" id="svItem19-6" value="6" ${result.svItem19 eq '6' ? 'checked' : '' }></td>
				</tr>
			</tbody>
		</table>
		<table id="serveyQ4" class="table03 mt10" ${result.svItem08 eq 'Y' ? '' : 'style="display:none;"' }>
			<colgroup>
				<col width="" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="7">4. 수사&middot;법률 지원서비스</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th class="f_bold">매우<br/>불만족</th>
					<th class="f_bold">불만족</th>
					<th class="f_bold">보통</th>
					<th class="f_bold">만족</th>
					<th class="f_bold">매우<br/>만족</th>
					<th class="f_bold">미선택</th>
				</tr>
				<tr>
					<td class="al">센터 경찰의 수사 서비스에 대해서 만족하십니까? (진술녹화, 수사와 관련된 면담 등) <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-1" value="1" ${result.svItem20 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-2" value="2" ${result.svItem20 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-3" value="3" ${result.svItem20 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-4" value="4" ${result.svItem20 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-5" value="5" ${result.svItem20 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem20" id="svItem20-6" value="6" ${result.svItem20 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">법률 지원 서비스에 만족하십니까? (법률 정보제공 및 상담, 재판과정 지원 등) <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-1" value="1" ${result.svItem21 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-2" value="2" ${result.svItem21 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-3" value="3" ${result.svItem21 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-4" value="4" ${result.svItem21 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-5" value="5" ${result.svItem21 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem21" id="svItem21-6" value="6" ${result.svItem21 eq '6' ? 'checked' : '' }></td>
				</tr>
			</tbody>
		</table>
		<table id="serveyQ5" class="table03 mt10" ${result.svItem10 eq 'Y' ? '' : 'style="display:none;"' }>
			<colgroup>
				<col width="" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="7">5. 심리 평가 및 치료지원</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th></th>
					<th class="f_bold">매우<br/>불만족</th>
					<th class="f_bold">불만족</th>
					<th class="f_bold">보통</th>
					<th class="f_bold">만족</th>
					<th class="f_bold">매우<br/>만족</th>
					<th class="f_bold">미선택</th>
				</tr>
				<tr>
					<td class="al">심리지원 서비스(심리평가 및 심리치료)에 대해서 만족하십니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-1" value="1" ${result.svItem22 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-2" value="2" ${result.svItem22 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-3" value="3" ${result.svItem22 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-4" value="4" ${result.svItem22 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-5" value="5" ${result.svItem22 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem22" id="svItem22-6" value="6" ${result.svItem22 eq '6' ? 'checked' : '' }></td>
				</tr>
				<tr>
					<td class="al">사건과 관련한 후유증이 완하되었습니까? <span class="ctn"></span></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-1" value="1" ${result.svItem23 eq '1' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-2" value="2" ${result.svItem23 eq '2' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-3" value="3" ${result.svItem23 eq '3' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-4" value="4" ${result.svItem23 eq '4' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-5" value="5" ${result.svItem23 eq '5' ? 'checked' : '' }></td>
					<td class="ac"><input type="radio" name="svItem23" id="svItem23-6" value="6" ${result.svItem23 eq '6' ? 'checked' : '' }></td>
				</tr>
			</tbody>
		</table>
		<table id="serveyQ6" class="table03 mt10">
			<thead>
				<tr>
					<th>6. 다른 피해자나 보호자에게 본 센터의 이용을 권하고 싶으신가요?</th>
				</tr>
			</thead>
			<tbody>
				<td>
					<span class="ctn">
						<input type="radio" name="svItem24" id="svItem24-1" class="SV_ITEM24" value="1" ${result.svItem24 eq '1' ? 'checked' : '' }><label for="svItem24-1">전혀 그렇지 않다</label>
						<input type="radio" name="svItem24" id="svItem24-2" class="SV_ITEM24" value="2" ${result.svItem24 eq '2' ? 'checked' : '' }><label for="svItem24-2">그렇지 않다</label>
						<input type="radio" name="svItem24" id="svItem24-3" class="SV_ITEM24" value="3" ${result.svItem24 eq '3' ? 'checked' : '' }><label for="svItem24-3">보통이다</label>
						<input type="radio" name="svItem24" id="svItem24-4" class="SV_ITEM24" value="4" ${result.svItem24 eq '4' ? 'checked' : '' }><label for="svItem24-4">그렇다</label>
						<input type="radio" name="svItem24" id="svItem24-5" class="SV_ITEM24" value="5" ${result.svItem24 eq '5' ? 'checked' : '' }><label for="svItem24-5">매우 그렇다</label>
						<input type="radio" name="svItem24" id="svItem24-6" class="SV_ITEM24" value="6" ${result.svItem24 eq '6' ? 'checked' : '' }><label for="svItem24-6">미선택</label>
					</span>
				</td>
			</tbody>
		</table>
		<table id="serveyQ7" class="table03 mt10">
			<thead>
				<tr>
					<th>7. 센터의 서비스와 관련하여 전체적인 소감이나 의견(좋았던 점, 개선사항, 요구사항 등)이 있으면 적어주세요.</th>
				</tr>
			</thead>
			<tbody>
				<td>
					<textarea rows="20" cols="" name="svText01" id="svText01" style="width:100%; height:100px;"><c:out value="${result.svText01 }" escapeXml="false"/></textarea>
				</td>
			</tbody>
		</table>
		</div>
	</form>
	
	<div class="btnGroup">
		<div class="fr" >
			<c:choose>
			<c:when test="${empty result}" >
				<button type="button" onclick="checkForm();" class="pure-button btnSave">저장</button>
			</c:when>
			<c:when test="${(result.svCuser eq userVO.userId) || userVO.userGroup eq 'OP07' }">
				<button type="button" class="pure-button btnUpdate" onclick="checkForm();">수정저장</button>
				<button type="button" class="pure-button btnDelete" onclick="del();">삭제</button>
			</c:when>
			</c:choose>
				<button class="pure-button btnList" onclick="list();">리스트</button>
		</div>
	</div>
</div>