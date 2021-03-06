<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<script src="/static/bos/js/common.js"></script>
<c:set var="noEdit" value="onClick='alertMsg();blur();' onFocus='alertMsg();blur();'"/>
<c:set var="act" value="update2" />

<script>
function alertMsg(){
  alert('수정 불가능한 항목입니다. ');
  return false;
}
</script>

<form id="formCase" method="post" class="pure-form">
	<input type="hidden" name="act" value="${act }" />
	<input type="hidden" name="caseSeq" value="${result.caseSeq }">
	<input type="hidden" id="CASE_REL_SEQ" name="caseRelSeq" value="0" /> <!-- 없음 -->
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
    <input type="hidden" name="userId" value="${userVO.userId}" />
    <input type="hidden" name="userNm" value="${userVO.userNm}" />
    <input type="hidden" id="caseRel" name="caseRel" value="" /> <!-- 참조사례번호 -->

	<div class="hide">
		<table id="template_form">
			<tr>
				<td id="caseNumber" style="width: 100%; height: 30px">
					<span id="sapn_caseRel"></span>
					<span id="sapn_del"></span>
					<input type="hidden" name="caseRelArr" id="caseRelArr" value=""/>
				</td>
			</tr>
		</table>
	</div>
	<h2>전산정보</h2>
	<table class="table03">
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th>센터명</th>
				<td>${userVO.centerName }</td>
				<th>전산관리번호</th>
				<td>${result.caseNumber }</td>
			</tr>
			<tr>
				<th>센터사례관리번호</th>
				<td><input type="text" name="centerNumber" value="${result.centerNumber }"></td>
				<th>참조사례번호</th>
				<td><%-- <input type="text" name="caseRel" value="${result.caseRel}" ${noEdit }> --%>
					<button type="button" class="b-select" onclick="selectCaseRel()">참조사례번호찾기</button>
					<table class="table2">
						<colgroup>
							<col width="20%">
							<col>
						</colgroup>
						<tbody id="tbodyForm">
							<c:if test="${not empty result.caseRel}">
								<c:set var="data" value="${fn:split(result.caseRel,', ')}" />
								<c:forEach var="x" begin="0" end="${fn:length(data)-1}">
									<tr id="trForm_${data[x]}">
										<td id="caseNumber" style="width: 100%; height: 30px">
											<span id="sapn_caseRel">${data[x]}</span> 
											<span id="sapn_del"><a href="javascript:fn_delRow('trForm_${data[x]}');" class="b-del"></a></span> 
											<input type="hidden" name="caseRelArr" id="caseRelArr" value="${data[x]}">
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>

	<div id="tabs-1">
		<h2>접수정보</h2>
		<table class="table03">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="essentialInputField">접수일자 / 시간</span></th>
					<td>${result.caseDate } &nbsp; ${result.caseTime } ~ ${result.caseTimeE }</td>
					<th><span class="essentialInputField">접수방법</span></th>
					<td>${result.caseJupsoo }</td>
				</tr>
				<tr>
					<th>의뢰인 이름</th>
					<td><input type="text" name="client" value="${result.client}">
					</td>
					<th>접수담당자</th>
					<td>${result.memberName }</td>
					<!--
                   <th>기타선택시내용</th>
                   <td><input type="text" name="caseTypeMemo" value="${result.caseTypeMemo}" style="width:90%;">
                   </td>
                   -->
				</tr>
				<tr>
					<th><span class="essentialInputField">의뢰인과 피해자와의 관계</span></th>
					<td>${result.clientRel }</td>
					<th>기타선택시내용기재</th>
					<td><input type="text" name="clientRelMemo" value="${result.clientRelMemo}" style="width: 90%;" ${noEdit }>
					</td>
				</tr>
				<tr>
					<th>세부내용
						<div class="bytes-wrapper">
							<span id="bytesTextJupsooMemo">0</span> / 3,500bytes
						</div>
					</th>
					<td colspan="3"><textarea name="jupsooMemo" id="textJupsooMemo" style="height: 100px; width: 100%;">${resultMemo.jupsooMemo }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<div id="tabs-2">
		<h2>피해자정보</h2>
		<table class="table03">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td><input type="text" name="victimName" value="${result.victimName}"></td>
					<th><span class="essentialInputField">성별</span></th>
					<td>${result.victimSexNm }</td>
				</tr>
				<tr>
					<th><span class="essentialInputField">생년월일</th>
					<td>${result.victimBirth }</td>
					<th><span class="essentialInputField">현재나이</th>
					<td>
						<c:if test="${result.victimAge eq '199' }">알수없음</c:if>
						<c:if test="${result.victimAge ne '199' }"><fmt:parseNumber integerOnly="true" value="${result.victimAge }"/></c:if>
					</td>
					<!--
                   <th>생년월일</th>
                   <td><input type="text" name="victimBirth" value="${result.victimBirth}" class="formatDateBirthday">
                   </td>
                   <th><span class="essentialInputField">현재나이</span></th>
                   <td>
                       <input type="text" name="victimAge" value="${result.victimAge}" class="formatNumber victim-age-group" style="width:100px;">
                       &nbsp;&nbsp;&nbsp;
                       <span class='container'><input type="checkbox" name="VICTIM_AGE_NO" value="Y" class="victim-age-group" ${result.victimAge eq '199' ? "checked" : ''}>알수없음</span>
                   </td>
                   -->
				</tr>
				<tr>
					<th><span class="essentialInputField">장애여부</span></th>
					<td>${result.victimDisableNm }</td>
					<th><span class="essentialInputField">국적</span></th>
					<td>${result.victimFrgerNm }</td>
				</tr>
				<tr>
					<th><span class="essentialInputField">거주지</span></th>
					<td colspan=3>${result.victimAreaNm }&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}
					</td>
				</tr>
				<tr>
					<th><span class="essentialInputField">피해자의 센터인지경로</span></th>
					<td colspan=3>${result.caseRouteNm }</td>
				</tr>
				<tr>
					<th>세부내용
						<div class="bytes-wrapper">
							<span id="bytesTextVictimMemo">0</span> / 3,500bytes
						</div>
					</th>
					<td colspan="3"><textarea name="victimMemo" id="textVictimMemo" style="height: 100px; width: 100%;">${resultMemo.victimMemo }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<div id="tabs-3">
		<h2>피해정보</h2>
		<table class="table03">
			<colgroup>
				<col width="20%" />
				<col width="12%" />
				<col width="12%" />
				<col width="33%" />
				<col width="23%" />
			</colgroup>
			<tbody>
				<!--
               <tr>
                   <th><span class="essentialInputField">피해구분1</span></th>
                   <td>
                   </td>
                   <th><span class="essentialInputField">피해구분2</span></th>
                   <td>&nbsp;
                   </td>
               </tr>
               -->

				<tr>
					<th><span class="essentialInputField">피해구분1</span></th>
					<td>${result.caseTypeNm }</td>
					<th><span class="essentialInputField" style="padding-left: 10px;">피해구분2</span></th>
					<td>${result.caseTypeSubNm }</td>
					<td>기타선택시내용 :${result.caseTypeMemo }
					</td>
				</tr>
				<tr>
					<th><span class="essentialInputField">피해시 특이사항</span></th>
					<td colspan="5">
						<c:if test="${not empty result.dmgState }">
							<div id="divdmgState"> ${result.dmgStateYnNm } - 
								<script>
		                            getCmmnCd.checkBoxPrint('CSDG', 'divdmgState', 'dmgState', '${result.dmgState}');
		                        </script>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>피해일시</th>
					<td colspan="5">
						<input type="text" name="dmgTime" value="${result.dmgTime}" class="formatDate">
						<input type="text" name="dmgTimeMemo" value="${result.dmgTimeMemo}" style="width: 500px;">
					</td>
				</tr>
				<tr>
					<th>세부내용
						<div class="bytes-wrapper">
							<span id="bytesTextCaseMemo">0</span> / 3,500bytes
						</div>
					</th>
					<td colspan="5"><textarea name="caseMemo" id="textCaseMemo" style="height: 100px; width: 100%;">${resultMemo.caseMemo }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<div id="tabs-5">
		<h2>상담정보</h2>
		<table class="table03">
			<colgroup>
				<col width="20%" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="essentialInputField">도움 요청 내용(중복)</span></th>
					<td>
						<div id="divCaseHelp">
							<script>
	                            getCmmnCd.checkBoxPrint('CDHP', 'divCaseHelp', 'caseHelp', '${result.caseHelp}');
	                        </script>
						</div>
						<c:if test="${not empty result.caseHelpMemo}">(${result.caseHelpMemo})</c:if>
					</td>
				</tr>
				<tr>
					<th>주호소 및 상담내용
						<div class="bytes-wrapper">
							<span id="bytesTextSangdamMemo">0</span> / 3,500bytes
						</div>
					</th>
					<td><textarea name="sangdamMemo" id="textSangdamMemo" style="height: 70px; width: 100%;">${resultMemo.sangdamMemo }</textarea></td>
				</tr>
				<tr>
					<th><span class="essentialInputField">사례관리자 설정</span></th>
					<td>
						<span style='display: inline-block; width: 150px;'>
							<input type='radio' name='caseManagerYn' value='N' ${empty result.caseManager ? ' checked' : '' } />설정안함
						</span>
						<span style='display: inline-block; width: 150px;'>
							<input type='radio' name='caseManagerYn' value='Y' ${not empty result.caseManager ? ' checked' : '' }/>설정함
						</span> 
						<span id="divCaseManager" style="display: none;"> 
							<select id="caseManager" name="caseManager" title="사례관리자 설정">
								<option value="" selected="">선택</option>
								<c:forEach var="resultManager" items="${resultCaseManager}" varStatus="status">
									<option value="${resultManager.userId}" <c:if test="${resultManager.userId == result.caseManager}">selected="selected"</c:if>>${resultManager.userName}</option>
								</c:forEach>
							</select>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<c:if test="${act eq 'update2' }">
		<div>
			<h2>사례수정이력기록</h2>
			<table class="table03">
				<colgroup>
					<col width="20%" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<th><span class="essentialInputField">수정내용 : </span>
						</td>
						<td><input type="text" name="historyMemo" id="historyMemo" style="width: 100%;" value=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</c:if>
</form>

<div class="btnGroup">
	<input type="submit" id="btnCaseSave" class="pure-button btnSave" value="저장">
	<c:choose>
		<c:when test="${act eq 'update' }">
			<!-- <input type="submit" id="btnCaseCancel" class="pure-button btnCancel" value="취소"> -->
			<a class="pure-button btnCancel" href="/bos/instance/case/view.do?${pageQueryString}"><span>취소</span></a>
		</c:when>
		<c:otherwise>
			<!-- <input type="submit" id="btnCaseList" class="pure-button btnList" value="리스트"> -->
			<a class="pure-button btnList" href="/bos/instance/case/list.do?menuNo=${param.menuNo}"><span>리스트</span></a>
		</c:otherwise>
	</c:choose>
</div>

<form id="formPage" method="post">
	<input type="hidden" name="act" value="${act }" />
	<input type="hidden" name="caseSeq" value="${result.caseSeq}">
</form>

<script>
	$(function() {
		fnc_SUB_VICTIM_DISABLE();
		fnc_SUB_DMG_STATE_YN();
		fnc_SUB_CASE_MANAGER_YN();

	    $('#btnCaseSave').click(function() {
	        fnSaveCaseForm();
	    });

	    $('#btnCaseCancel').click(function() {
	        $('#formPage').attr('action', 'case_view.asp');
	        $('#formPage').submit();
	    });

	    $('#btnCaseList').click(function() {
	        $('#formPage').attr('action', 'case_list.asp');
	        $('#formPage input[name=case_seq]').val("");
	        $('#formPage').submit();
	    });

	    $('#btnUpdateLink').click(function() {
	        $('#formPage').attr('action', 'case_list_link.asp');
	        $('#formPage input[name=caseSeq]').val($("#caseSeq").val());
	        $('#formPage').submit();
	    });

	    //의뢰인과 피해자와의 관계 하위 선택
	    $("#formCase select[name='clientRelGrp']").change(function() {
	        fnc_SUB_CLIENT_REL();
	    });

	    //피해자의 센터인지경로 하위 선택
	    $("#formCase select[name='caseRouteGrp']").change(function() {
	        fnc_SUB_CASE_ROUTE();
	    });

	    //피해구분1 하위 선택
	    $("#formCase select[name='caseType']").change(function() {
	        fnc_SUB_CASE_TYPE();
	    });

	    //피해구분2 하위 선택
	    $("#formCase select[name='caseTypeGrp']").change(function() {
	        fnc_SUB_CASE_TYPE_GRP();
	    });

	    //거주지 하위 선택
	    $("#formCase select[name='victimArea']").change(function() {
	        fnc_SUB_VICTIM_AREA();
	    });

	    // 피해자 장애여부 선택시 옵션
	    $("#formCase select[name='victimDisable']").change(function() {
	        fnc_SUB_VICTIM_DISABLE();
	    });

	    // 피해자 국적 선택시 옵션
	    $("#formCase select[name='victimFrger']").change(function() {
	        fnc_SUB_VICTIM_FRGER();
	    });

	    // 현재나이 알수없음 누르면 현재나이 지우기
	    $("#formCase input[name='victimAgeNo']").click(function() {
	        var isChecked = $(this).is(":checked");
	        if (isChecked) {
	            $("#formCase input[name='victimAge']").val("");
	            $("#formCase input[name='victimAgeBirth']").val("");
	            $("#formCase input[name='victimBirth']").val("");
	        }
	    });

	    // 거주지 알수없음 누르면 거주지정보 지우기
	    $("#formCase input[name='victimAreaNo']").click(function() {
	        var isChecked = $(this).is(":checked");
	        if (isChecked) {
	            $("#divVictimArea").hide();
	        } else {
	            $("#divVictimArea").show();
	        }
	    });

	    // 가해자 추가
	    $('.btnAttkrInsert').click(function() {
	        var myWindow = window.open("/case/attkr/attkr_form_popup.asp?case_seq=${case_seq}&attkr_seq=&attkr_act=insert", "case_attkr_window", "width=950,height=400");
	    });
	    // 가해자2인 이상 선택시 옵션
	    $("#formCase input[name='checkAttkrState'][value='10']").click(function() {
	        var isChecked = $(this).is(":checked");
	        if (isChecked) {
	            $('.btnAttkrInsert').show();
	            var myWindow = window.open("/case/attkr/attkr_form_popup.asp?case_seq=${case_seq}&attkr_seq=&attkr_act=insert", "case_attkr_window", "width=950,height=400");
	        } else {
	            $('.btnAttkrInsert').hide();
	        }
	    });

	    // 피해시 특이사항 선택시 옵션
	    $("#formCase input[name='dmgStateYn']").click(function() {
	        fnc_SUB_DMG_STATE_YN();
	    });

	    // 사례관리자 설정 선택시 옵션
	    $("#formCase input[name='caseManagerYn']").click(function() {
	        fnc_SUB_CASE_MANAGER_YN();
	    });

	    // 사례관리자설정 선택시 옵션
	    /*
	    $("#formCase input[name='CASE_MANAGER_YN']").click(function() {
	        var isChecked = $(this).is(":checked");
	        if (isChecked) {
	            $("#formCase select[name='CASE_MANAGER']").removeAttr("disabled");
	        } else {
	            $("#formCase select[name='CASE_MANAGER']").attr("disabled","disabled");
	        }
	    });
	    */

		//생년월일 박스에서 벗어나면, 만나이 보여주기
		$("#formCase input[name='victimBirth']").blur( function() {
	        var VICTIM_AGE = computeAge($(this).val());

	        if(isNaN(VICTIM_AGE) == true) {
	            $("#formCase input[name='victimAgeBirth']").val("");
	        } else {
	            $("#formCase input[name='victimAge']").val("");
	            $("#formCase input[name='victimAageBirth']").val(VICTIM_AGE);
	        $("#formCase input:checkbox[name='victimAgeNo']").prop("checked", false);
	        }
		});
		
	    $('.formatDate')
	    .numeric({allow:"-"})
	    .css("ime-mode", "disabled").css("width", "100px").css("text-align", "center").css("color", "#0000FF").css("font-weight", "bold")
	    .mask("9999-99-99")
	    .datepicker({
	        changeMonth: true,
	        changeYear: true,
	        maxDate: "+0D",
	        yearRange:'c-100:c+10',
	        numberOfMonths: 1,
	        showButtonPanel: true
	    })
	    .blur(function() {
	        if ( RegularDateFormat( $(this).val() ) ) {
	        } else {
		        if($(this).val().length>0) {
		            alert("날짜는 2016-02-15 형식으로 입력해야 합니다.");
		            $(this).val("2016-01-01");
		        }
	        }
	    });
	    
	    $('#textJupsooMemo').keyup(function (e){
		    var content = $(this).val();
		    $('#bytesTextJupsooMemo').html(content.length);    //글자수 실시간 카운팅

		    if (content.length > 3500){
		        alert("최대 3,500bytes까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 3500));
		    }
		});
	    
	    $('#textVictimMemo').keyup(function (e){
		    var content = $(this).val();
		    $('#bytesTextVictimMemo').html(content.length);    //글자수 실시간 카운팅

		    if (content.length > 3500){
		        alert("최대 3,500bytes까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 3500));
		    }
		});
	    
	    $('#textCaseMemo').keyup(function (e){
		    var content = $(this).val();
		    $('#bytesTextCaseMemo').html(content.length);    //글자수 실시간 카운팅

		    if (content.length > 3500){
		        alert("최대 3,500bytes까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 3500));
		    }
		});
	    
	    $('#textSangdamMemo').keyup(function (e){
		    var content = $(this).val();
		    $('#bytesTextSangdamMemo').html(content.length);    //글자수 실시간 카운팅

		    if (content.length > 3500){
		        alert("최대 3,500bytes까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 3500));
		    }
		});
	});

    function fnFormValidationCheck() {
        var validator = $('#formCase').validate({
            rules:{

                caseDate:{ required:true, rangelength:[10,10]},
                caseTime:{ required:true, rangelength:[5,5]},
                caseTimeE:{ required:true, rangelength:[5,5]},
                victimArea:{ required:true},
                victimAreaSub:{ required:true},
                caseType:{ required:true},
                caseTypeGrp:{ required:true},
                dmgStateYn:{ required:true},
                checkAttkrState:{ required:true},
                checkCaseHelp:{ required:true},
                caseManagerYn:{ required:true},

                caseJupsoo:{ required:true},
                clientRelGrp:{ required:true},
                victimSex:{ required:true},
                caseRouteGrp:{ required:true},
                caseRoute:{ required:true},

                victimAge:{ digits: true, range: [0, 150], require_from_group: [1, ".victim-age-group"] },
                victimAgeNo:{ require_from_group: [1, ".victim-age-group"] },

                /* if($("#act").val() == 'update'){
                	caseHistoryMemo:{ required:true},
                } */

                attkrStateYn:{ required:true},
                attkrSex:{ required:true},
                attkrAge:{ required:true},
                attkrRelGrp:{ required:true},
                attkrRel:{ required:true}
            },
            errorPlacement: function(error, element)
            {
                if ( element.is(":radio") ) {
                    error.appendTo( element.parents('.container') );
                } else  if ( element.is(".victim-age-group") ) {
                    error.appendTo( element.parents('.container') );
                } else  if ( element.is(":checkbox") ) {
                    error.appendTo( element.parents('.container') );
                } else  { // This is the default behavior
                    error.insertAfter( element );
                }
             }
        });
        isValidation = validator.form();
        return isValidation;
    }

    // 내용저장
	function fnSaveCaseForm() {
    	var _caseRel = "";
		$("input[name=caseRelArr]").each(function() {
			if($(this).val() != ""){
				_caseRel += $(this).val() + ", ";
			}
		});
		$("#caseRel").val(_caseRel.substr(0, _caseRel.length - 2));
		
		if($('#historyMemo').val().length < 3){
        	alert("수정내용을 3자 이상 입력해주세요.");
        	$('#historyMemo').focus();
        	return;
        }
    	
		if (!confirm('수정 하시겠습니까?')) {
            return;
        }
		
		var form = $("#formCase")[0];
		
		$("#formCase").attr("action", "/bos/instance/case/caseUpdate2.do");
		form.submit();
    }

    // 생년월일 선택시 현재나이 입력하기
    function fnc_SUB_BIRTHDAY_AGE() {
        var VICTIM_AGE = computeAge( $("#formCase input[name='victim_birth']").val() );
        $("#formCase input[name='victim_age']").val("");
        $("#formCase input[name='victim_age_birth']").val(VICTIM_AGE);
        $("#formCase input:checkbox[name='victim_age_no']").prop("checked", false);
    }

	//나이입력에서 벗어나면, 나이입력여부확인해서 알수없음 제거하기
	$("#formCase input[name='victim_age']").blur( function() {
        if ($(this).val()!="") {
            $("#formCase input:checkbox[name='victim_age_no']").prop("checked", false);
        }
	});

    function fnc_SUB_VICTIM_DISABLE() {
        var thisVal = $("#formCase select[name='victim_disable']").val();
        if (thisVal == "0") {
            $('#victim_disable_memo_text').text('');
            $("#formCase input[name='victim_disable_memo']").val("").hide();
        } else if (thisVal == "1") {
            $('#victim_disable_memo_text').text('장애급수:');
            $("#formCase input[name='victim_disable_memo']").show();
        } else if (thisVal == "2") {
            $('#victim_disable_memo_text').text('장애명:');
            $("#formCase input[name='victim_disable_memo']").show();
        } else if (thisVal == "3") {
            $('#victim_disable_memo_text').text('장애명:');
            $("#formCase input[name='victim_disable_memo']").show();
        }
    }

    function fnc_SUB_VICTIM_FRGER() {
        var thisVal = $("#formCase select[name='victim_frger']").val();
        if (thisVal == "Y") {
            $('#victim_frger_memo_text').text('현재국적');
            $("#formCase input[name='victim_frger_memo']").show();
        } else {
            $('#victim_frger_memo_text').text('');
            $("#formCase input[name='victim_frger_memo']").val("").hide();
        }
    }

    function fnc_SUB_CLIENT_REL() {

        var selectOptionVal = $("#formCase select[name='client_rel_grp']").val();
        var selectOptionSub = $("#formCase select[name='client_rel_grp']").find('option:selected').attr('data-subcode');

        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='client_rel']").prop('disabled', true).hide();
        } else {

            $('#client_rel').html($CLIENT_REL_OPTION);

            $("#formCase select[name='client_rel']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
            /*
            $("#formCase select[name='CLIENT_REL']").prop('disabled', false).show().find("option").prop('disabled', true).prop('selected', false).hide().filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){
                        return true;
                    } else {
                        return false;
                    }
                }
            }).prop('disabled', false).show().prop("selected", true);
            */
        }
    }

    function fnc_SUB_CASE_ROUTE() {
        var selectOptionVal = $("#formCase select[name='case_route_grp']").val();
        var selectOptionSub = $("#formCase select[name='case_route_grp']").find('option:selected').attr('data-subcode');
        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='case_route']").prop('disabled', true).hide();
        } else {

            $('#case_route').html($CASE_ROUTE_OPTION);

            $("#formCase select[name='case_route']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
        }
    }

    function fnc_SUB_CASE_TYPE() {
        var selectOptionVal = $("#formCase select[name='case_type']").val();
        var selectOptionSub = $("#formCase select[name='case_type']").find('option:selected').attr('data-subcode');
        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='case_type_grp']").prop('disabled', true).hide();
        } else {

            $('#case_type_grp').html($CASE_TYPE_GRP_OPTION);

            $("#formCase select[name='case_type_grp']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();

            $("#formCase select[name='case_type_sub']").prop('disabled', true).hide();

            setTimeout(function(){
                fnc_SUB_CASE_TYPE_GRP();
            }, 500);
        }
    }

    function fnc_SUB_CASE_TYPE_GRP() {
        var selectOptionVal = $("#formCase select[name='case_type_grp']").val();
        var selectOptionSub = $("#formCase select[name='case_type_grp']").find('option:selected').attr('data-subcode');

        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='case_type_sub']").prop('disabled', true).hide();
        } else {
            $("#formCase select[name='case_type_sub']").prop('disabled', false).show().find("option").prop('disabled', true).prop('selected', false).hide().filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){
                        return true;
                    } else {
                        return false;
                    }
                }
            }).prop('disabled', false).show().prop("selected", true);
        }
    }

    function fnc_SUB_VICTIM_AREA() {
        var selectOptionVal = $("#formCase select[name='victim_area']").val();
        var selectOptionSub = $("#formCase select[name='victim_area']").find('option:selected').attr('data-subcode');
        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='VICTIM_AREA_SUB']").prop('disabled', true).hide();
        } else {

            $('#victim_area_sub').html($VICTIM_AREA_OPTION);

            $("#formCase select[name='victim_area_sub']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
        }
    }

    function fnc_SUB_DMG_STATE_YN() {
        var valChecked = $("#formCase input[name='dmgStateYn']:checked").val();
        if (valChecked=="Y") {
            $("#divDmgState").show();
        } else {
            $("#divDmgState").hide();
        }
    }

    function fnc_SUB_CASE_MANAGER_YN() {
        var valChecked = $("#formCase input[name='caseManagerYn']:checked").val();
        if (valChecked=="Y") {
            $("#divCaseManager").show();
        } else {
            $("#divCaseManager").hide();
        }
    }

    function fnc_ATTKR_SAVE_INFO(gVal) {
        <%-- $( "#divAttkrInsertedInfo" ).load( "/case/attkr/attkr_view_load.asp?case_seq=<%=case_seq%>" ); --%>
    }


    <%-- /*
    //page Init.
    //피해자 장애 여부
    <% If ekrSame(VICTIM_DISABLE, "1") Then %>
        $('#VICTIM_DISABLE_MEMO_TEXT').text('장애급수:');
        $("#formCase input[name='VICTIM_DISABLE_MEMO']").show();
    <% ElseIf ekrSame(VICTIM_DISABLE, "2") Then %>
        $('#VICTIM_DISABLE_MEMO_TEXT').text('장애명:');
        $("#formCase input[name='VICTIM_DISABLE_MEMO']").show();
    <% Else %>
        $('#VICTIM_DISABLE_MEMO_TEXT').text('');
        $("#formCase input[name='VICTIM_DISABLE_MEMO']").val("").hide();
    <% End If %>

    //피해자 외국인 여부
    <% If ekrSame(VICTIM_FRGER, "Y") Then %>
        $('#VICTIM_FRGER_MEMO_TEXT').text('현재국적');
        $("#formCase input[name='VICTIM_FRGER_MEMO']").show();
    <% Else %>
        $('#VICTIM_FRGER_MEMO_TEXT').text('');
        $("#formCase input[name='VICTIM_FRGER_MEMO']").val("").hide();
    <% End If %>

    //사례관리자 여부
    <%=ekrIfHas(CASE_MANAGER, "$('#divCaseManager').show();")%>
    //피해자 특이사항 여부
    <% If DMG_STATE_YN = "Y" Then %>
        $("#divDmgState").show();
    <% End If %>
    */ --%>

    //페이지 로딩시 기본 정보값 로드
    var $CLIENT_REL_OPTION      = $('#clientRel>option').clone();
    var $CASE_ROUTE_OPTION      = $('#caseRoute>option').clone();
    var $CASE_TYPE_GRP_OPTION   = $('#caseTypeGrp>option').clone();
    var $VICTIM_AREA_OPTION     = $('#victimAreaSub>option').clone();

    fnc_SUB_CASE_TYPE();        //피해구분1 하위 선택
    fnc_SUB_CLIENT_REL();       //의뢰인과 피해자와의 관계 하위 선택
    fnc_SUB_CASE_ROUTE();       //피해자의 센터인지경로 하위 선택
    fnc_SUB_VICTIM_AREA();      //거주지 하위 선택

    fnc_SUB_VICTIM_DISABLE();   //피해자 장애여부 선택시 옵션
    fnc_SUB_VICTIM_FRGER();     //피해자 국적 선택시 옵션

    fnc_SUB_DMG_STATE_YN();     //피해시 특이사항 선택시 옵션
    fnc_SUB_CASE_MANAGER_YN();  //사례관리자 설정 선택시 옵션

    //피해자 기본정보 불러오기
    fnc_ATTKR_SAVE_INFO("");

    //참조사례찾기
    function selectCaseRel(){
    	deleteCookie('case');
		window.open("/bos/instance/case/caseRelPopup.do?viewType=BODY&${pageQueryString}","caseRelPopup","scrollbars=no,width=700,height=700");
	}
    
    function deleteCookie(cookieName){
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }
    
	//참조사례 선택
	function fn_setFormInfo(paramValues){
		if(paramValues.length > 0){
 			//$("#tbodyForm").empty();
			for(var i = 0 ; i < paramValues.length ; i++){
				var info = paramValues[i];
				
					var delBtn = "<a href=\"javascript:fn_delRow('trForm_"+info["caseNumber"]+"');\" class=\"b-del\"></a>";
					var tr = $("#template_form tr").clone();	
					tr.attr("id", "trForm_"+info["caseNumber"]);
					tr.find("#sapn_caseRel").html(info["caseNumber"]);
					tr.find("#sapn_del").html(delBtn);
					tr.find("#caseRelArr").val(info["caseNumber"]);
// 					tr.find("#td_del").append(delBtn);
	
					$("#tbodyForm").append(tr);	
			}
		}
	}
 
	function fn_delRow(delId){
		var delRow = $('#'+delId);	
		if( delRow.get(0) != null ){ 
			delRow.remove();
		}
	}

   <%-- if($("#act").val() == "update"){
	    setTimeout(function(){
	        $("#formCase select[name='clientRel']").val("<%=CLIENT_REL%>");
	        $("#formCase select[name='caseRoute']").val("<%=CASE_ROUTE%>");
	        $("#formCase select[name='caseTypeGrp']").val("<%=CASE_TYPE_GRP%>");
	        $("#formCase select[name='victimAreaSub']").val("<%=VICTIM_AREA_SUB%>");
	
	    }, 500);
	
	    setTimeout(function(){
	        fnc_SUB_CASE_TYPE_GRP();    //피해구분2 하위 선택
	    }, 800);
	
	    setTimeout(function(){
	        $("#formCase select[name='caseTypeSub']").val("<%=CASE_TYPE_SUB%>");
	    }, 1000);
    } --%>
</script>