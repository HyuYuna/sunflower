<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<script src="/static/bos/js/common.js"></script>

<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="today" pattern="yyyy-MM-dd" />

<c:if test="${empty result}">
	<c:set var="action" value="/bos/instance/case/insert.do" />
	<c:set var="actionTmpr" value="/bos/instance/case/insertTmpr.do" />
	<c:set var="act" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/instance/case/update.do" />
	<c:set var="actionTmpr" value="/bos/instance/case/updateTmpr.do" />
	<c:set var="act" value="update" />
</c:if>

<style type="text/css">
</style>

<script>
$(function() {
	//페이지 로딩시 기본 정보값 로드
	var $CLIENT_REL_OPTION		= $('#clientRel>option').clone();
	var $CASE_ROUTE_OPTION		= $('#caseRoute>option').clone();
	var $CASE_TYPE_GRP_OPTION	= $('#caseTypeGrp>option').clone();
	var $VICTIM_AREA_OPTION		= $('#victimAreaSub>option').clone();
	var $ATTKR_REL_OPTION		= $('#attkrRel>option').clone();
    
	fnc_SUB_CASE_TYPE();		//피해구분 1 하위 선택
	fnc_SUB_CLIENT_REL();		//의뢰인과 피해자와의 관계 하위 선택
	fnc_SUB_CASE_ROUTE();		//피해자의 센터인지경로 하위 선택
	fnc_SUB_VICTIM_AREA();		//거주지 하위 선택
	
	fnc_SUB_VICTIM_DISABLE();	//피해자 장애여부 선택시 옵션
	fnc_SUB_VICTIM_FRGER();		//피해자 국적 선택시 옵션

	fnc_SUB_DMG_STATE_YN();		//피해시 특이사항 선택시 옵션
	fnc_SUB_CASE_MANAGER_YN();	//사례관리자 설정 선택시 옵션
	
	fnc_VICTIM_AREA_TOGGLE();	//피해자 거주지가 알수없음으로 선택되어져 있으면 해당 선택영역 가려지도록
	
	fnc_SUB_ATTKR_REL();		//가해자 관계(피해자 기준) 선택시 옵션
	fnc_SUB_ATTKR_DISABLE();	//가해자 장애여부 선택시 옵션
	fnc_SUB_ATTKR_FRGER();		//가해자 국적 선택시 옵션
	fnc_SUB_ATTKR_STATE_YN();	//가해자 특이사항 선택시 옵션
	
	if($("#act").val() == 'update'){
		attkrList();
	}
	
	//의뢰인과 피해자와의 관계 하위 선택
	$("#formCase select[name='clientRelGrp']").change(function() {
		fnc_SUB_CLIENT_REL();
	});
	
	//피해자의 센터인지 경로 하위 선택
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
	
	//피해자 장애여부 선택시 옵션
	$("#formCase select[name='victimDisable']").change(function() {
		fnc_SUB_VICTIM_DISABLE();
	});
	
	//피해자 국적 선택시 옵션
	$("#formCase select[name='victimFrger']").change(function() {
		fnc_SUB_VICTIM_FRGER();
	});
	
	//현재나이 알수없음 누르면 현재나이 지우기
	$("input[name=victimAgeNo]").on('click',function() {
		var isChecked = $(this).is(":checked");
		if (isChecked) {
			$("#victimAge").val("");
			$("#victimAgeBirth").val("");
			$("#victimBirth").val("");
		}
	});
 
	//거주지 알수없음 누르면 거주지정보 지우기
	$("#formCase input[name='victimAreaNo']").click(function() {
		fnc_VICTIM_AREA_TOGGLE();
	});
 	
	// 가해자2인 이상 선택시 옵션
	$("#formCase input[name='attkrState'][value='10']").click(function() {
		var isChecked = $(this).is(":checked");
		if(isChecked) {
			$("#attkrButton").show();
		} else {
			$("#attkrButton").hide();
		}
	});
	
	$("#formCase input[name='attkrStateYn'][value='N']").click(function() {
		var isChecked = $(this).is(":checked");
		
		if(isChecked) {
			$("#attkrButton").hide();
		} else {
			$("#attkrButton").show();
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
	
	//생년월일 박스에서 벗어나면, 만나이 보여주기
	$("#formcase input[name='victimBirth']").blur( function() {
        var VICTIM_AGE = computeAge($('#victimBirth').val());
        
        if(isNaN(VICTIM_AGE) == true) {
			$("#victimAgeBirth").val("");
		} else {
		    $("#victimAge").val("");
		    $("#victimAgeBirth").val(VICTIM_AGE);
			$("#victimAgeNo").prop("checked", false);
		}
	});
	
	// 생년월일 선택시 현재나이 입력하기
	function fnc_SUB_BIRTHDAY_AGE() {
	    var VICTIM_AGE = computeAge( $("#formCase input[name='victimBirth']").val() );
	    $("#formCase input[name='victimAge']").val("");
	    $("#formCase input[name='victimAgeBirth']").val(VICTIM_AGE);
	    $("#formCase input:checkbox[name='victimAgeNo']").prop("checked", false);
	}
	
	//나이입력에서 벗어나면, 나이입력여부확인해서 알수없음 제거하기
	$("#formCase input[name='victimAge']").blur( function() {
        if ($(this).val()!="") {
            $("#formCase input:checkbox[name='victimAgeNo']").prop("checked", false);
        }
	});

	//피해자 장애여부 선택시 옵션
	function fnc_SUB_VICTIM_DISABLE() {
	    var thisVal = $("#formCase select[name='victimDisable']").val();
	    if (thisVal == "0") {
	        $('#victimDisableMemoText').text('');
	        $("#formCase input[name='victimDisableMemo']").val("").hide();
	    } else if (thisVal == "1") {
	        $('#victimDisableMemoText').text('장애정도:');
	        $("#formCase input[name='victimDisableMemo']").show();
	    } else if (thisVal == "2") {
	        $('#victimDisableMemoText').text('장애명:');
	        $("#formCase input[name='victimDisableMemo']").show();
	    } else if (thisVal == "3") {
	        $('#victimDisableMemoText').text('장애명:');
	        $("#formCase input[name='victimDisableMemo']").show();
	    }
	}
	
	// 피해자정보 국적 선택시 옵션
	function fnc_SUB_VICTIM_FRGER() {
	    var thisVal = $("#formCase select[name='victimFrger']").val();
	    if (thisVal == "Y") {
	        $('#victimFrgerMemoText').text('현재국적');
	        $("#formCase input[name='victimFrgerMemo']").show();
	    } else {
	        $('#victimFrgerMemoText').text('');
	        $("#formCase input[name='victimFrgerMemo']").val("").hide();
	    }
	}
	
	//의뢰인과 피해자의 관계 하위 선택시 옵션
	function fnc_SUB_CLIENT_REL(){
		var selectOptionVal = $("#formCase select[name='clientRelGrp']").val();
		var selectOptionSub = $("#formCase select[name='clientRelGrp']").find('option:selected').attr('data-subcode');
		
		if($("#clientRelGrp").val() == '10'){
			$("input[name=victimName]").val($("input[name=client]").val());
		}
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='clientRel']").prop('disabled', true).hide();
        } else {
        	$('#clientRel').html($CLIENT_REL_OPTION);
            $("#formCase select[name='clientRel']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
        }
	}
	
	//피해자의 센터인지 경로 하위 선택시 옵션
	function fnc_SUB_CASE_ROUTE() {
		var selectOptionVal = $("#formCase select[name='caseRouteGrp']").val();
		var selectOptionSub = $("#formCase select[name='caseRouteGrp']").find('option:selected').attr('data-subcode');
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
			$("#formCase select[name='caseRoute']").prop('disabled', true).hide();
		} else {
			$('#caseRoute').html($CASE_ROUTE_OPTION);
			$("#formCase select[name='caseRoute']").prop('disabled', false).show().find("option").filter(function(index) {
				var dataGrpcde = $(this).attr("data-grpcode");
				if (typeof dataGrpcde != "undefined") {
					if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
				}
			}).remove();
		}
	}
	
	//피해구분1 하위 선택시 옵션
	function fnc_SUB_CASE_TYPE() {
		var selectOptionVal = $("#formCase select[name='caseType']").val();
		var selectOptionSub = $("#formCase select[name='caseType']").find('option:selected').attr('data-subcode');
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
			$("#formCase select[name='caseTypeGrp']").prop('disabled', true).hide();
		} else {
			$('#caseTypeGrp').html($CASE_TYPE_GRP_OPTION);
            $("#formCase select[name='caseTypeGrp']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();

            $("#formCase select[name='caseTypeSub']").prop('disabled', true).hide();

            setTimeout(function(){
                fnc_SUB_CASE_TYPE_GRP();
            }, 500);
        }
	}
	
	//피해구분2 하위 선택시 옵션
	function fnc_SUB_CASE_TYPE_GRP() {
        var selectOptionVal = $("#formCase select[name='caseTypeGrp']").val();
        var selectOptionSub = $("#formCase select[name='caseTypeGrp']").find('option:selected').attr('data-subcode');

        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='caseTypeSub']").prop('disabled', true).hide();
        } else {
            $("#formCase select[name='caseTypeSub']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){
                        return true;
                    } else {
                        return false;
                    }
                }
            }).prop('disabled', false).show();
        }
    }
	
	//거주지 하위 선택시 옵션
	function fnc_SUB_VICTIM_AREA() {
        var selectOptionVal = $("#formCase select[name='victimArea']").val();
        var selectOptionSub = $("#formCase select[name='victimArea']").find('option:selected').attr('data-subcode');
        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formCase select[name='victimAreaSub']").prop('disabled', true).hide();
        } else {
        	$('#victimAreaSub').html($VICTIM_AREA_OPTION);
            $("#formCase select[name='victimAreaSub']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode")
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
        }
    }
	
	//피해시 특이사항
	function fnc_SUB_DMG_STATE_YN() {
	    var valChecked = $("#formCase input[name='dmgStateYn']:checked").val();
	    if (valChecked=="Y") {
	        $("#divDMG_STATE").show();
	    } else {
	        $("#divDMG_STATE").hide();
	        $("#formCase input:checkbox[name='dmgState']").prop("checked", false);
	    }
	}
	
	// 사례관리자 설정
	function fnc_SUB_CASE_MANAGER_YN() {
	    var valChecked = $("#formCase input[name='caseManagerYn']:checked").val();
	    if (valChecked=="Y") {
	        $("#divCASE_MANAGER").show();
	    } else {
	        $("#divCASE_MANAGER").hide();
	        $("#caseManager").val("");
	    }
	}
	
	//거주지 알수없음
	function fnc_VICTIM_AREA_TOGGLE() {
	    var isChecked = $("#formCase input[name='victimAreaNo']").is(":checked");
	    if (isChecked) {
	        $("#divVictimArea").hide();
	        $("#victimArea").val("");
	        $("#victimAreaSub").val("");
	        $("#victimAreaMemo").val("");
	    } else {
	        $("#divVictimArea").show();
	    }
	}
	
	// 가해자정보 장애여부 선택시 옵션
    $("#formCase select[name='attkrDisable']").change(function() {
        fnc_SUB_ATTKR_DISABLE();
    });
	
 	// 가해자 국적 선택시 옵션
    $("#formCase select[name='attkrFrger']").change(function() {
        fnc_SUB_ATTKR_FRGER();
    });

    //피해자와 관계(피해자기준) 하위 선택
    $("#formCase select[name='attkrRelGrp']").change(function() {
        fnc_SUB_ATTKR_REL();
    });
 
 	// 가해시 특이사항 선택시 옵션
    $("#formCase input[name='attkrStateYn']").click(function() {
        fnc_SUB_ATTKR_STATE_YN();
    });
 	
    $('.formatTime').numeric({allow:":"}).mask("99:99")
    .css("width", "60px").css("ime-mode", "disabled").css("text-align", "center")
    .blur(function() {
      if ( RegularTime24Format( $(this).val() ) ) {
      } else {
        if($(this).val().length>0) {
          alert("시간은 21:33 형식으로 입력해야 합니다.\r\n[ 00:00부터 23:59까지 입력 가능 ]");
        }
        $(this).val("00:00");
      }
    });
    
    $('.formatDateBirthday')
	    .numeric({allow:"-"})
	    .css("ime-mode", "disabled").css("width", "100px").css("text-align", "center").css("color", "#0000FF").css("font-weight", "bold")
	    .mask("9999-99-99")
	    .datepicker({
	        changeMonth: true,
	        changeYear: true,
	        maxDate: "+0D",
	        yearRange:'c-100:c+10',
	        numberOfMonths: 1,
	        showButtonPanel: true,
	        onSelect: function (dateText, inst) {
	            fnc_SUB_BIRTHDAY_AGE();
	        }
	    })
	    .blur(function() { 
	        if ( RegularDateFormat( $(this).val() ) ) {      
	        } else {
	        if($(this).val().length>0) {
	            alert("날짜는 2016-02-15 형식으로 입력해야 합니다.");
	            $(this).val("");
	        }
	    }
	});
    
    $('.formatNumber').numeric()
    .css("ime-mode", "disabled").css("text-align", "center");
    $('.formatNumber').css('ime-mode','disabled');
// 영어 + 숫자만 입력   $('.englishNumber input').alphanumeric();
// 영어만 입력          $('.onlyEnglish input').alpha();
// 한글 입력 제한       $('.noKorean input').css('ime-mode','disabled');
	    
	$('.formatDateMagam').attr("readonly", true)
        .numeric({allow:"-"})
        .css("ime-mode", "disabled").css("width", "100px").css("text-align", "center").css("color", "#0000FF").css("font-weight", "bold")
        .mask("9999-99-99")
        .datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: "${dimMagamDate}",
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
	
	$('.formatDate')
	    .numeric({allow:"-"})
	    .css("ime-mode", "disabled").css("width", "100px").css("text-align", "center").css("color", "#0000FF").css("font-weight", "bold")
	    .mask("9999-99-99")
	    .datepicker({
	        changeMonth: true,
	        changeYear: true,
//	        maxDate: "+0D",
	        //yearRange:'c-100:c+20',
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
	
	$('#jupsooMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#textJupsooMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});
	
	$('#victimMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#textVictimMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});

	$('#caseMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#textCaseMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});

	$('#sangdamMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#textSangdamMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});

	$('#sangdamMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#textSangdamMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});

	$('#attkrMemo').keyup(function (e){
	    var content = $(this).val();
	    $('#bytesAttkrMemo').html(content.length);    //글자수 실시간 카운팅

	    if (content.length > 3500){
	        alert("최대 3,500bytes까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 3500));
	    }
	});
	
	// 가해자정보 장애여부 선택시 옵션
	function fnc_SUB_ATTKR_DISABLE() {
	    var thisVal = $("#formCase select[name='attkrDisable']").val();
	    if (thisVal == "0") {
	        $('#attkrDisableMemoText').text('');
	        $("#formCase input[name='attkrDisableMemo']").val("").hide();
	    } else if (thisVal == "1") {
	        $('#attkrDisableMemoText').text('장애정도:');
	        $("#formCase input[name='attkrDisableMemo']").show();
	    } else if (thisVal == "2") {
	        $('#attkrDisableMemoText').text('장애명:');
	        $("#formCase input[name='attkrDisableMemo']").show();
	    } else if (thisVal == "3") {
	        $('#attkrDisableMemoText').text('장애명:');
	        $("#formCase input[name='attkrDisableMemo']").show();
	    }
	}
	
	//가해시 특이사항 선택
	function fnc_SUB_ATTKR_STATE_YN() {
	    var valChecked = $("#formCase input[name='attkrStateYn']:checked").val();
	    if (valChecked=="Y") {
	        $("#divATTKR_STATE").show();
	    } else {
	        $("#divATTKR_STATE").hide();
	        $("#formCase input:checkbox[name='attkrState']").prop("checked", false);
	    }
	}
	
	//가해자 정보 등록 국적
	function fnc_SUB_ATTKR_FRGER() {
        var thisVal = $("#formCase select[name='attkrFrger']").val();
        if (thisVal == "Y") {
            $('#attkrFrgerMemoText').text('현재국적');
            $("#formCase input[name='attkrFrgerMemo']").show();
        } else {
            $('#attkrFrgerMemoText').text('');
            $("#formCase input[name='attkrFrgerMemo']").val("").hide();
        }
    }
	
	//피해자와 관계(피해자기준) 하위 선택시 옵션
	function fnc_SUB_ATTKR_REL(){
		var selectOptionVal = $("#formCase select[name='attkrRelGrp']").val();
		var selectOptionSub = $("#formCase select[name='attkrRelGrp']").find('option:selected').attr('data-subcode');
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
			$("#formCase select[name='attkrRel']").prop('disabled', true).hide();
		} else {
			$('#attkrRel').html($ATTKR_REL_OPTION);
			$("#formCase select[name='attkrRel']").prop('disabled', false).show().find("option").filter(function(index) {
				var dataGrpcde = $(this).attr("data-grpcode")
				if (typeof dataGrpcde != "undefined") {
					if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
				}
			}).remove();
		}
	}
});

    function caseTransRegExec() {
    	/* if($("input:checkbox[name=victimAgeNo]").is(":checked") == true) {
			$("#victimAge").val('199');
    	}
		if($("#victimAge").val() == ""){
			$("#victimAge").val($("#victimAgeBirth").val());
		} */
		
        var form = $("#formCase")[0];
        var v = new MiyaValidator(form);
        
             v.add("centerCode", {
            	 required: true
             });
             v.add("transBeforeCenterCode", {
            	 required: true
             });
             v.add("centerCodeAfter", {
            	 required: true
             });
             
             v.add("transAfterCenterCode", {
                 required: true
             });
             
             
             v.add("transStdrDate", {
                 required: true
             });
             
        var result = v.validate();
        if (!result) {
            alert(v.getErrorMessage());
            v.getErrorElement().focus();
            return;
        }
        
        
		//현재시간과 기준일시간비교
		//현재일시
		var currentDate = new Date();
		var currentTime = currentDate.getTime();
		//이관기준일시
		var transDay = $("#transStdrDate").val().split('-');
		var transHour = $("#transHour option:selected").val(); 
		var transMin = $("#transMin option:selected").val();
		var transSec = $("#transSec option:selected").val();
 	    var transTime = new Date(transDay[0], transDay[1]-1, transDay[2],transHour,transMin,transSec);

 		if(currentTime > transTime){
 			alert("이관기준일자는 현재시간보다 작을수 없습니다.");
 			return;
 		}
 		
 		var beforeCenterNm = $("#transBeforeCenterCode option:checked").text();
 		var afterCenterNm = $("#transAfterCenterCode option:checked").text();
 		var transDateText = transDay[0]+"년" + transDay[1]+"월" + transDay[2]+"일" + transHour+"시" + transMin +"분"+ transSec+"초";
 		var confirmText = "";
 		confirmText +=  transDateText +" 부로 " +beforeCenterNm+ "의";
 		confirmText +=  "\n사례 및 서비스테이타가 " +afterCenterNm +"로 이관됩니다";
 		confirmText +=  "\n이관된 사례 및 서비스는 되돌릴수 없습니다";
 		confirmText +=  "\n이관을 실행하시겠습니까?";
 		if(confirm(confirmText)){
 			$("#formCase").attr("action", "/bos/instance/case/insertCaseTrans.do");
 	        form.submit();
 		}

    }
    
    function checkForm2() {
    	/* if($("input:checkbox[name=victimAgeNo]").is(":checked") == true) {
			$("#victimAge").val('199');
    	}
		if($("#victimAge").val() == ""){
			$("#victimAge").val($("#victimAgeBirth").val());
		} */
		
		var form = $("#formCase")[0];
        var v = new MiyaValidator(form);
        
             v.add("caseDate", {
                 required: true
             });
             
             v.add("caseTime", {
            	 required: true
             });
             
             v.add("caseJupsoo", {
                 required: true
             });
             
             v.add("clientRelGrp", {
                 required: true
             });

 			var clientRelGrpSub = $("#formCase select[name='clientRelGrp']").find('option:selected').attr('data-subcode');
 			if ( jQuery.type( clientRelGrpSub )=="undefined" || clientRelGrpSub=="") { } else {
 				v.add("clientRel", {
 					required: true
 				});
 			}
             
             v.add("victimSex", {
                 required: true
             });
             
             v.add("victimDisable", {
                 required: true
             });
             
             v.add("victimFrger", {
                 required: true
             });
             
			var isChecked = $("#formCase input[name='victimAreaNo']").is(":checked");
     	    if (!isChecked) {
     	    	v.add("victimArea", {
                    required: true
                });
                v.add("victimAreaSub", {
                    required: true
                });
			}
     	    
			v.add("caseRouteGrp", {
			    required: true
			});
			
			var caseRouteGrpSub = $("#formCase select[name='caseRouteGrp']").find('option:selected').attr('data-subcode');
			if ( jQuery.type( caseRouteGrpSub )=="undefined" || caseRouteGrpSub=="") { } else {
				v.add("caseRoute", {
					required: true
				});
			}
			
			v.add("caseType", {
			    required: true
			});
			
			v.add("caseTypeGrp", {
			    required: true
			});
			
			v.add("dmgStateYn", {
			    required: true
			});
			
			if($("#attkr").val() == "Y"){
				v.add("attkrSex", {
				    required: true
				});
				
				v.add("attkrAge", {
				    required: true
				});
				
				v.add("attkrDisable", {
				    required: true
				});
				
				v.add("attkrFrger", {
				    required: true
				});
				
				v.add("attkrRelGrp", {
				    required: true
				});
				
				var attkrRelGrpSub = $("#formCase select[name='attkrRelGrp']").find('option:selected').attr('data-subcode');
				if ( jQuery.type( attkrRelGrpSub )!="undefined" || attkrRelGrpSub!="") { } else {
					v.add("attkrRel", {
						required: true
					});
				}
				
				v.add("attkrStateYn", {
				    required: true
				});
			}
			
			v.add("caseManagerYn", {
			    required: true
			});
             
        var result = v.validate();
        if (!result) {
            alert(v.getErrorMessage());
            v.getErrorElement().focus();
            return;
        }
        
		if($("input:checkbox[name=caseHelp]").is(":checked") == false) {
			alert("[도움 요청 내용]은 반드시 체크하셔야 하는 사항입니다.");
			return;
		}
		
		if(!fnSaveCaseForm()){
			return;
		}
        
        var _caseHelp = "";
		$("input[name=caseHelp]:checked").each(function() {
			_caseHelp += $(this).val() + ", ";
		});
		$("#caseHelp2").val(_caseHelp.substr(0, _caseHelp.length - 2));
		
		var _attkrState = "";
		$("input[name=attkrState]:checked").each(function() {
			_attkrState += $(this).val() + ", ";
		});
		$("#attkrState2").val(_attkrState.substr(0, _attkrState.length - 2));
		
		var _dmgState = "";
		$("input[name=dmgState]:checked").each(function() {
			_dmgState += $(this).val() + ", ";
		});
		$("#dmgState2").val(_dmgState.substr(0, _dmgState.length - 2));

		var _caseRel = "";
		$("input[name=caseRel]").each(function() {
			if($(this).val() != ""){
				_caseRel += $(this).val() + ", ";
			}
		});
		$("#caseRel2").val(_caseRel.substr(0, _caseRel.length - 2));
		
        $("#loadingDiv").show();
        /* form.action="${actionTmpr}";
		form.submit(); */
		
		$.ajax({
			url : "/bos/instance/case/tmprCase.json", 
			type : "post",
			data : $("#formCase").serialize(),
			success : function(data) {
				if(data.resultCode=="success") {
					if($("#caseSeq").val() == '0'){
						$("#caseSeq").val(data.caseSeq);
						$("#caseAttkrSeq").val(data.caseAttkrSeq);
						$("#caseNumber").val(data.caseNumber);

						$("#tmpr").val("Y");
					}
					
					alert("임시저장이 완료되었습니다.");
				} else {
					alert("임시저장에 실패하였습니다.");
				}
			}
		});
		
		$("#loadingDiv").hide();
    }
    
    // 가해자정보 추가
    function attkrAdd(attkrSeq){
    	if($("#caseSeq").val() == "0"){
    		alert("가해자 추가는 임시저장 후 가능합니다.");
    		
    		return false;
    	}
    	
    	var caseSeq = $("#caseSeq").val();
    	var url = "/bos/instance/case/caseAttkrRegPopup.do";
        var params = "?viewType=BODY&caseSeq=" + caseSeq + "&attkrSeq="+ attkrSeq;
        window.open(url+params , 'caseAttkrRegPopup',"width=900, height=800");
    }
    
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
					tr.find("#caseRel").val(info["caseNumber"]);
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
	
	function clientRelGrpChange() {
		
		var thisVal = $("#formCase select[name='clientRelGrp']").val()
		
		getCmmnCd.subSelect('CS24','clientRel',thisVal , '', 'N')
		if($("#clientRelGrp").val() == '10'){
			$("input[name=victimName]").val($("input[name=client]").val())
		}
	}
	
	function attkrList() {
		$.ajax({
			url: "/bos/instance/case/attkrList.json",
			data : {"caseSeq":$("#caseSeq").val()},
			cache: false,
			dataType: "json",
			success: function(data) {
				var txtElement = $("#attkrListDiv:last");
				$('#attkrListDiv .attkrListTable').remove();
				
				var attkrList = data.attkrList;
				
				if(attkrList != ""){
					$("#attkr").val("");
					$("#divAttkrInsertedInfo").hide();
					$("#attkrButton").show();
					
					$.each(attkrList, function(index, entry) {
						var attkrSex = "";
						if(entry.attkrSex == 'M'){
							attkrSex = "남자";
						} else if(entry.attkrSex == 'F'){
							attkrSex = "여자";
						} else {
							attkrSex = "알수없음";
						}
						
						var attkrDisable = "";
						if(entry.attkrDisable == '1'){
							attkrDisable = "장애정도 : " + entry.attkrDisableMemo;
						} else if(entry.attkrDisable == '2'){
							attkrDisable = "장애명 : " + entry.attkrDisableMemo;
						} else if(entry.attkrDisable == '3'){
							attkrDisable = "장애명 : " + entry.attkrDisableMemo;
						}
						
						var attkrFrger = "";
						if(entry.attkrFrger == 'N'){
							attkrFrger = "내국인";
						} else if(entry.attkrFrger == 'Y'){
							attkrFrger = "외국인 / 현재국적 : " + entry.attkrFrgerMemo;
						}
						
						var attkrStateYn = "";
						if(entry.attkrStateYn == 'N'){
							attkrStateYn = "없음";
						} else if(entry.attkrStateYn = 'Y'){
							var attkrStateArr = entry.attkrState.split(', ');
							
							attkrStateYn = "<label><input type='checkbox' name='attkrState' id='attkrState10' value='10' disabled='disabled'>가해자2인 이상</label> ";
							attkrStateYn += "<label><input type='checkbox' name='attkrState' id='attkrState11' value='11' disabled='disabled'>흉기소지</label> ";
							attkrStateYn += "<label><input type='checkbox' name='attkrState' id='attkrState12' value='12' disabled='disabled'>주거침입</label> ";
							attkrStateYn += "<label><input type='checkbox' name='attkrState' id='attkrState13' value='13' disabled='disabled'>야간</label> ";
							attkrStateYn += "<label><input type='checkbox' name='attkrState' id='attkrState14' value='14' disabled='disabled'>음주</label> ";
							attkrStateYn += "<label><input type='checkbox' name='attkrState' id='attkrState15' value='15' disabled='disabled'>약물</label>";
						}
						
						txtTr = "";
						
						txtTr += "<table class='table03 attkrListTable' id=''>";
						txtTr += "<caption>가해자정보</caption>";
						txtTr += "<colgroup><col width='20%' /><col width='30%' /><col width='20%' /><col width='30%' /></colgroup>";
						txtTr += "<tbody><tr>";
						txtTr += "<th>성별</th>";
						txtTr += "<td>" + attkrSex + "</td>"
						txtTr += "<th>나이</th>";
						txtTr += "<td>" + entry.attkrAgeNm + "</td>";
						txtTr += "</tr><tr>";
						txtTr += "<th>장애</th>";
						txtTr += "<td>" + entry.attkrDisableNm + " " + attkrDisable + "</td>";
						txtTr += "<th>국적</th>";
						txtTr += "<td>" + entry.attkrFrgerNm + " " + attkrFrger + "</td>";
						txtTr += "</tr><tr>";
						txtTr += "<th>피해자와의 관계<br>(피해자기준)</th>";
						txtTr += "<td colspan='3'>" + entry.attkrRelNm + " " + entry.attkrRelMemo + "</td>"
						txtTr += "</tr><tr>";
						txtTr += "<th>가해시 특이사항</th>";
						txtTr += "<td colspan='3'>" + attkrStateYn + "</td>";
						txtTr += "</tr><tr>";
						txtTr += "<th>세부사항</td>";
						txtTr += "<td colspan='3' style='white-space:pre-wrap;'>" + entry.attkrMemo + "</td>";
						txtTr += "</tr><tr>";
						txtTr += "<th>가해자정보수정</td>";
						txtTr += "<td colspan='3'><a href='javascript:attkrAdd(" + entry.attkrSeq + ");' class='pure-button btnUpdate' >수정</a></td>";
						txtTr += "</tr></tbody>";
						txtTr += "</table>";

						txtElement.append(txtTr);
						
						if(entry.attkrStateYn = 'Y'){
							$.each(attkrStateArr, function(index, entry) {
								$('input:checkbox[id="attkrState' + attkrStateArr[index] + '"]').attr("checked", true);
							});
						}
					});
				} else {
					$("#attkr").val("Y");
					$("#divAttkrInsertedInfo").show();
					$("#attkrButton").hide();
				}
			},
			error: function (request, status, error) { alert(status + ", " + error); }
		});
	}
	
	function fnSaveCaseForm() {
		var caseTime = $("#formCase input[name='caseTime']").val();
		if(caseTime == '' || caseTime == '__:__') {
			alert("접수 시간을 입력하세요!");
			$("#formCase input[name='caseTime']").focus();
			return false;
		} else if(caseTime == '00:00'){
			alert("접수 시간에 00:00을 입력할 수 없습니다.");
			$("#formCase input[name='caseTime']").focus();
			return false;
		}
		
		var dmgStateYn = $("#formCase input:radio[name='dmgStateYn']:checked").val();
		if(dmgStateYn == 'Y'){
			if($("input:checkbox[name='dmgState']").is(":checked") == false) {
				alert("피해시 특이사항이 있을 경우 항목을 선택해주세요.");
				$("#formCase input[name='dmgStateYn']").focus();
				return false;
			}
		}
		
		var attkrStateYn = $("#formCase input:radio[name='attkrStateYn']:checked").val();
		if(attkrStateYn == 'Y'){
			if($("input:checkbox[name='attkrState']").is(":checked") == false){
				alert("가해자 특이사항이 있을경우 항목을 선택해주세요.");
				$("#formCase input[name='attkrStateYn']").focus();
				return false;
			}
		}
		
		var victimAge1 = $("#victimAgeBirth").val();
		var victimAge2 = $("#victimAge").val();
		if(victimAge1 != "" && victimAge2 != ""){
			alert("피해자의 생년월일 또는 나이 중 하나만 입력해주세요.");
            $('#victimAge').focus();
			return false;
		}
		
		return true;
	}
</script>

<form id="formCase" name="formCase" method="post" enctype="multipart/form-data" action="${action}">
<!-- 	<input type="text" id="transAfterCenterCode" name="transAfterCenterCode" value="" /> DECODE 사용해서 넣는 값
	<input type="text" id="transBeforeCenterCode" name="transBeforeCenterCode" value="" /> DECODE 사용해서 넣는 값
	<input type="text" id="nowTransChkVal" name="nowTransChkVal" value="" /> DECODE 사용해서 넣는 값 -->

	<div class="hide">
		<table id="template_form">
			<tr>
				<td id="caseNumber" style="width: 100%; height: 30px">
					<span id="sapn_caseRel"></span>
					<span id="sapn_del"></span>
					<input type="hidden" name="caseRel" id="caseRel" value=""/>
				</td>
			</tr>
		</table>
	</div>
	<div class="view">
<%-- 		<h2>전산정보</h2>
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
					<td>${userVO.centerName}</td>
					<th>전산관리번호</th>
					<td>${empty result.caseNumber ? '저장 후 자동생성' : result.caseNumber}</td>
				</tr>
				<tr>
					<th>센터사례관리번호</th>
					<td><input type="text" name="centerNumber"
						value="${result.centerNumber}"></td>
					<th>참조사례번호</th>
					<td>
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
												<input type="hidden" name="caseRel" id="caseRel" value="${data[x]}">
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table> --%>

<%-- 		<div id="tabs-1">
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
						<th scope="row"><label for="caseDate"><span class="essentialInputField req"><span>필수입력</span></span>접수일자 / 시간</label></th>
						<td>
							<!-- 디폴트 오늘날짜(달력) -->
							<c:if test="${empty result}">
								<input type="text" name="caseDate" id="caseDate" value="${today}" class="formatDateMagam">
							</c:if>
							<c:if test="${not empty result}">
								<input type="text" name="caseDate" id="caseDate" value="${result.caseDate}" class="formatDateMagam">
							</c:if> &nbsp;
							<input type="text" name="caseTime" value="${result.caseTime}" class="formatTime" title="접수 시간">
						</td>
						<th scope="row"><label for="caseJupsoo"><span class="essentialInputField req"><span>필수입력</span></span>접수방법</label></th>
						<td>
							<select name="caseJupsoo" id="caseJupsoo" title="접수방법" style="width: 150px;">
								<script>
									getCmmnCd.select('CS20', 'caseJupsoo', '${result.caseJupsoo}', 'N');
								</script>
							</select>
						</td>
					</tr>
					<tr>
						<th>의뢰인 이름</th>
						<td><input type="text" name="client" value="${result.client}"></td>
						<th>접수담당자</th>
						<td>${empty result ? userVO.userNm : result.memberName }</td>
					</tr>
					<tr>
						<th>초기 상담자</th>
						<td colspan="3"><input type="text" name="eryyCnsltnt" value="${result.eryyCnsltnt}"></td>
					</tr>
					<tr>

						<th scope="row"><label for="clientRelGrp"><span class="essentialInputField req"><span>필수입력</span></span>의뢰인과 피해자와의 관계</label></th>
						<td>
							<select name="clientRelGrp" id="clientRelGrp" title="의뢰인과 피해자와의 관계" style="width: 45%">
								<script>
									getCmmnCd.select('CS24G', 'clientRelGrp', '${result.clientRelGrp}','N');
								</script>
							</select>
							<select name="clientRel" id="clientRel" title="의뢰인과 피해자와의 관계 서브" style="width: 50%">
								<script>
									getCmmnCd.select('CS24', 'clientRel', '${result.clientRel}','N');
								</script>
							</select>&nbsp;
						</td>
						<th>기타선택시내용기재</th>
						<td><input type="text" name="clientRelMemo" value="${result.clientRelMemo}" style="width: 90%;"></td>
					</tr>
					<tr>
						<th>세부내용
							<div class="bytes-wrapper">
								<span id="textJupsooMemo">0</span> / 3,500bytes
							</div>
						</th>
						<td colspan="3"><textarea name="jupsooMemo" id="jupsooMemo" style="height: 100px; width: 100%;">${resultMemo.jupsooMemo}</textarea></td>
					</tr>
				</tbody>
			</table>
		</div> --%>


<%-- 		<div id="tabs-2">
			<h2>피해자정보</h2>
			<table class="table03">
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tbody>
					<tr>
						<th>이름</th>
						<td><input type="text" name="victimName" value="${result.victimName}"></td>
						<th scope="row"><label for="victimSex"><span class="essentialInputField req"><span>필수입력</span></span>성별</label></th>
						<td>
							<select name="victimSex" title="성별" style="width: 150px;">
								<option value="" <c:if test="${result.victimSex eq ''}">selected="selected"</c:if>>선택</option>
								<option value="F" <c:if test="${result.victimSex eq 'F'}">selected="selected"</c:if>>여자</option>
								<option value="M" <c:if test="${result.victimSex eq 'M'}">selected="selected"</c:if>>남자</option>
								<option value="E" <c:if test="${result.victimSex eq 'E'}">selected="selected"</c:if>>알수없음</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>가명</th>
						<td colspan="3"><input type="text" name="caseAlias" value="${result.caseAlias}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="victimAge"><span class="essentialInputField req"><span>필수입력</span></span>나이</label></th>
						<td colspan="3">
							생년월일 : <input type="text" name="victimBirth" id="victimBirth" value="${result.victimBirth}" autocomplete="off" class="formatDateBirthday">
							(만 <input type="text" id="victimAgeBirth" name="victimAgeBirth" value="${result.victimAgeBirth}" style="width: 40px;" readonly class="formatNumber victim-age-group">세)
							<fmt:parseNumber integerOnly="true" value="${result.victimAge }" var="victimAge" />
							나이입력 : <input type="text" id="victimAge" name="victimAge" value="${result.victimAge == '199' ? '' : victimAge }" class="formatNumber victim-age-group" style="width: 40px;">
							<span> 
								<input type="checkbox" name="victimAgeNo" id="victimAgeNo" value="Y" <c:if test="${result.victimAge eq '199' }">checked="checked"</c:if>>알수없음
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="victimDisable"><span class="essentialInputField req"><span>필수입력</span></span>장애여부</label></th>
						<td>
							<select name="victimDisable" id="victimDisable" title="장애여부" style="width: 100px;">
								<script>
									getCmmnCd.select('CDDA', 'victimDisable', '${result.victimDisable}');
								</script>
							</select> &nbsp;
							<b id="victimDisableMemoText"></b>
							<input type="text" name="victimDisableMemo" value="${result.victimDisableMemo}" style="width: 70px;">
						</td>
						<th scope="row"><label for="victimFrger"><span class="essentialInputField req"><span>필수입력</span></span>국적</label></th>
						<td>
							<select name="victimFrger" id="victimFrger" title="국적" style="width: 100px;">
								<script>
									getCmmnCd.select('CSA7', 'victimFrger', '${result.victimFrger}');
								</script>
							</select> &nbsp;
							<b id="victimFrgerMemoText"></b> 
							<input type="text" name="victimFrgerMemo" value="${result.victimFrgerMemo}" style="width: 100px;">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="victimArea"><span class="essentialInputField req"><span>필수입력</span></span>거주지</label>
							<label for="victimAreaSub" style="display: none;"><span class="essentialInputField req"><span>필수입력</span></span>거주지</label>
						</th>
						<td colspan=3>
							<span id="divVictimArea">
								<select name="victimArea" id="victimArea" title="거주지" style="width: 100px;">
									<script>
										getCmmnCd.select('HM46', 'victimArea', '${result.victimArea}', 'N');
									</script>
								</select>
								<select name="victimAreaSub" id="victimAreaSub" title="거주지 서브" style="width: 100px;">
									<script>
										getCmmnCd.select('HM47', 'victimAreaSub', '${result.victimAreaSub}', 'N');
									</script>
								</select> &nbsp;&nbsp;
								상세주소: <input type="text" name="victimAreaMemo" id="victimAreaMemo" value="${result.victimAreaMemo}" style="width: 250px;">
							</span>
							<span>
								<c:if test="${empty result}">
									<input type="checkbox" name="victimAreaNo" value="Y" class="victim-area-group">알수없음
								 </c:if>
								<c:if test="${not empty result}">
									<input type="checkbox" name="victimAreaNo" value="Y" class="victim-area-group" <c:if test="${result.victimArea eq '17'}">checked="checked"</c:if>>알수없음
								</c:if>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="caseRouteGrp"><span class="essentialInputField req"><span>필수입력</span></span>피해자의 센터인지경로</label></th>
						<td colspan=3>
							<select name="caseRouteGrp" id="caseRouteGrp" title="피해자의 센터인지경로" style="width: 45%">
								<script>
									getCmmnCd.select('CSRTG', 'caseRouteGrp', '${result.caseRouteGrp}', 'N');
								</script>
							</select>
							<select name="caseRoute" id="caseRoute" title="피해자의 센터인지경로 서브" style="width: 50%">
								<script>
									getCmmnCd.select('CSRT', 'caseRoute', '${result.caseRoute}', 'N');
								</script>
							</select>
						</td>
					</tr>
					<tr>
						<th>세부내용
							<div class="bytes-wrapper">
								<span id="textVictimMemo">0</span> / 3,500bytes
							</div>
						</th>
						<td colspan="3">
							<textarea name="victimMemo" id="victimMemo" style="height: 100px; width: 100%;">${resultMemo.victimMemo}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
 --%>

		<div id="tabs-3">
			<h2>이관정보</h2>
			<table class="table03">
				<colgroup>
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
				</colgroup>
				<tbody>
           <tr>
                <th><label for="caseType"><span class="essentialInputField req"><span>필수입력</span></span>이관전 센터</label></th>
                <td>
                    <select name="centerCode" id="centerCode" title="이관전 센터구분" onchange="getCmmnCd.subSelect('CM05','transBeforeCenterCode',this.value , '', 'N')">
                        <script>
                            getCmmnCd.select('CM04', 'centerCode', '${paramVO.centerCode}', 'N');
                        </script>
                    </select>
                    <select name="transBeforeCenterCode" id="transBeforeCenterCode" title="이관전 센터" >
                        <script>
                            getCmmnCd.subSelect('CM05','transBeforeCenterCode','${paramVO.centerCode}', '${paramVO.transBeforeCenterCode}', 'N')
                        </script>
                    </select>
                    <!-- <span style="color:green;padding-left:20px;">(참고:한국여성인권진흥원 권한에서만 나타나는 메뉴입니다)</span> -->
                    <!-- <br/> -->
 <%--                   <div id="selectCenterCodeDiv" style="display: none;">
                    <%=strCntrCodeCheckBox%> 
                        <script>
                            getCmmnCd.checkBox('CM05', 'selectCenterCodeDiv', 'selectCenterCode', '${paramVO.selectCenterCode}', '4');
                        </script>
                    </div>
                    --%>
                </td>
				<th><label for="caseType"><span class="essentialInputField req"><span>필수입력</span></span>이관후 센터</label></th>              
                <td>
                    <select name="centerCodeAfter" id="centerCodeAfter" title="이관후 센터구분" onchange="getCmmnCd.subSelect('CM05','transAfterCenterCode',this.value , '', 'N')">
                        <script>
                            getCmmnCd.select('CM04', 'centerCodeAfter', '${paramVO.centerCodeAfter}', 'N');
                        </script>
                    </select>
                    <select name="transAfterCenterCode" id="transAfterCenterCode" title="이관후 센터">
                        <script>
                            getCmmnCd.subSelect('CM05','transAfterCenterCode','${paramVO.centerCodeAfter}', '${paramVO.transAfterCenterCode}', 'N')
                        </script>
                    </select>
                </td>
            </tr>
					<tr>
						<th><label for="caseType"><span class="essentialInputField req"><span>필수입력</span></span>이관 기준일</label></th>
						<td colspan="4">
<%--						<input type="text" name="dmgTime" id="dmgTime" value="<fmt:formatDate value="${result.dmgTime}" pattern="yyyy-MM-dd"/>"  class="date"> --%>
							<input type="text" name="transStdrDate" id="transStdrDate" title="이관 기준일" value="" class="formatDate">
<!-- 							<span> 
								<input type="checkbox" name="nowTransChk" id="nowTransChk" value="Y">즉시 이관
							</span> -->
							<select  id="transHour" name="transHour">
							    <c:forEach var="i"  begin="0" end="23">
							        <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
							    </c:forEach>
							</select>시
							<select  id="transMin" name="transMin">
							    <c:forEach var="i"  begin="0" end="59">
							        <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
							    </c:forEach>
							</select>분
							<select  id="transSec" name="transSec">
							    <c:forEach var="i"  begin="0" end="59">
							        <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
							    </c:forEach>
							</select>초
							
						</td>
					</tr>
					<tr>
						<th>메모
							<div class="bytes-wrapper">
								<span id="textCaseMemo">0</span> / 3,500bytes
							</div>
						</th>
						<td colspan="4">
							<textarea name="transComment" id="transComment" style="height: 100px; width: 100%;">${resultMemo.caseMemo}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>


<%-- 		<div id="tabs-4">
			<h2>
				가해자정보 <a class="pure-button btnList" id="attkrButton" href="javascript:attkrAdd();" ${act eq 'insert' ? 'style="display:none;"': '' }><span>추가</span></a>
			</h2>
			<div id="divAttkrInsertedInfo">
				<table class="table03" id="attkrInsertTable">
					<caption>가해자정보</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="attkrSex"><span class="essentialInputField req"><span>필수입력</span></span>가해자 성별</label></th>
							<td>
								<select name="attkrSex" id="attkrSex" title="성별" style="width: 150px">
									<script>
										getCmmnCd.select('MF', 'attkrSex', '${result.attkrSex}','N');
									</script>
								</select>
							</td>
							<th scope="row"><label for="attkrAge"><span class="essentialInputField req"><span>필수입력</span></span>가해자 나이</label></th>
							<td>
								<select name="attkrAge" id="attkrAge" title="나이" style="width: 150px">
									<script>
										getCmmnCd.select('ATAG', 'attkrAge', '${result.attkrAge}');
									</script>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="attkrDisable"><span class="essentialInputField req"><span>필수입력</span></span>가해자 장애여부</label></th>
							<td>
								<select name="attkrDisable" id="attkrDisable" title="장애여부" style="width: 100px">
									<script>
										getCmmnCd.select('CDDA', 'attkrDisable', '${result.attkrDisable}');
									</script>
								</select> &nbsp;
								<b id="attkrDisableMemoText"></b>
								<input type="text" name="attkrDisableMemo" value="${result.attkrDisableMemo}" style="width: 70px; display: none;">
							</td>
							<th scope="row"><label for="attkrFrger"><span class="essentialInputField req"><span>필수입력</span></span>가해자 국적</label></th>
							<td>
								<select name="attkrFrger" id="attkrFrger" title="국적" style="width: 100px">
									<script>
										getCmmnCd.select('CSA7', 'attkrFrger', '${result.attkrFrger}');
									</script>
								</select>
								<b id="attkrFrgerMemoText"></b>
								<input type="text" name="attkrFrgerMemo" value="${result.attkrFrgerMemo}" style="width: 100px; display: none;">
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="attkrRelGrp"><span class="essentialInputField req"><span>필수입력</span></span>가해자 피해자와의 관계<br>(피해자기준)</label></th>
							<td>
								<select name="attkrRelGrp" id="attkrRelGrp" title="피해자와의 관계" style="width: 150px">
									<script>
										getCmmnCd.select('CZ01G', 'attkrRelGrp', '${result.attkrRelGrp}','N');
									</script>
								</select> 
								<select name="attkrRel" id="attkrRel" title="피해자와의 관계 서브" style="width: 150px">
									<script>
										getCmmnCd.select('CZ01', 'attkrRel', '${result.attkrRel}','N');
									</script>
								</select>
							</td>
							<td colspan="2">기타선택시내용:<input type="text" name="attkrRelMemo" value="${result.attkrRelMemo}" style="width: 150px;"></td>
						</tr>
						<tr>
							<th scope="row"><label for="attkrStateYn"><span class="essentialInputField req"><span>필수입력</span></span>가해시 특이사항</label></th>
							<td colspan=3>
								<label>
									<input name="attkrStateYn" id="attkrStateYn" type="radio" value="N" <c:if test="${result.attkrStateYn eq 'N' }">checked="checked"</c:if> /> 없음
								</label>
								<label>
									<input name="attkrStateYn" type="radio" value="Y" <c:if test="${result.attkrStateYn eq 'Y' }">checked="checked"</c:if> />있음
								</label>
								<div id="divATTKR_STATE" style="display: none;">
									<script>
										getCmmnCd.checkBox('ATST', 'divATTKR_STATE', 'attkrState', '${result.attkrState}');
									</script>
								</div>
							</td>
						</tr>
						<tr>
							<th>세부사항
								<div class="bytes-wrapper">
									<span id="bytesAttkrMemo">0</span> / 3,500bytes
								</div>
							</th>
							<td colspan=3><textarea name="attkrMemo" id="attkrMemo" style="height: 100px; width: 100%;">${result.attkrMemo}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="attkrListDiv"></div>
		</div> --%>

<%-- 		<div id="tabs-5">
			<h2>상담정보</h2>
			<table class="table03">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="caseHelp"><span class="essentialInputField req"><span>필수입력</span></span>도움 요청 내용(중복)</label></th>
						<td>
							<div id="div_caseHelp">
								<script>
									getCmmnCd.checkBox('CDHP', 'div_caseHelp', 'caseHelp', '${result.caseHelp}','4');
								</script>
								<input type="text" name="caseHelpMemo" value="${result.caseHelpMemo}" style="width: 200px;">
							</div>
						</td>
					</tr>
					<tr>
						<th>
							주호소 및 상담내용
							<div class="bytes-wrapper">
								<span id="textSangdamMemo">0</span> / 3,500bytes
							</div>
						</th>
						<td>
							<textarea name="sangdamMemo" id="sangdamMemo" style="height: 100px; width: 100%;">${resultMemo.sangdamMemo}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="caseManagerYn"><span class="essentialInputField req"><span>필수입력</span></span>사례관리자 설정</label></th>
						<td>
							<span>
								<input type='radio' name='caseManagerYn' value='N' <c:if test="${empty result.caseManager}"> checked </c:if> />설정안함
							</span>
							<span>
								<input type='radio' name='caseManagerYn' value='Y' <c:if test="${not empty result.caseManager}"> checked </c:if> />설정함
							</span>
							<span id="divCASE_MANAGER" style="display: none;"> 
								<select id="caseManager" name="caseManager" title="사례관리자 설정">
									<option value="" selected="">선택</option>
									<c:forEach var="resultManager" items="${resultCaseManager}" varStatus="status">
										<option value="${resultManager.userId}" <c:if test="${resultManager.userId == result.caseManager}">selected="selected"</c:if>>
											${resultManager.userName}
										</option>
									</c:forEach>
								</select>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div> --%>

<%-- 		<c:if test="${not empty result}">
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
							<td><input type="text" id="historyMemo" name="historyMemo" style="width: 100%;" value=""></td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if> --%>

<%--		<h2>타기관 연계의뢰서 첨부</h2>
		<!-- 파일 업로드 -->
 		<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
			<jsp:param value="case" name="subFileGroup" />
			<jsp:param value="${result.caseSeqC }" name="subFileCode" />
			<jsp:param value="" name="subFilecodeSub" />
			<jsp:param value="" name="afterUrl" />
			<jsp:param value="10" name="fileCnt" />
		</jsp:include> --%>

		<div class="btnGroup">
			<c:choose>
				<c:when test="${empty result}">
					<a class="pure-button btnSave" href="javascript:caseTransRegExec();" id="btnCaseSave"><span>이관실행</span></a>
				</c:when>
<%-- 				<c:otherwise>
					<a class="pure-button btnUpdate" href="javascript:checkForm();" id="btnCaseCancel"><span>수정</span></a>
					<a class="pure-button btnList" href="/bos/instance/case/view.do?${pageQueryString}"><span>취소</span></a>
				</c:otherwise> --%>
			</c:choose>
			<a class="pure-button btnList" href="/bos/instance/case/caseTransList.do?menuNo=${param.menuNo}"><span>리스트</span></a>
		</div>
	</div>
</form>

<!-- 임시저장 -->
<!-- <div class="btn-temporary">
	<a href="javascript:checkForm2();" class="btn btn-default btn-primary">임시<br />저장</a>
</div> -->
<!--// 임시저장 -->