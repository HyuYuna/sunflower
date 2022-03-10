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
<script>
var idx = 0;
var etcIdx = 0;

$(function() {
	var redirect = "${param.redirect}";
	if(redirect == 'Y'){
		fnc_NEW_PASS_FORM();
		redirect = '';
	}else{
		if('${param.passSeq}' != ''){
			fnc_GET_PASS_VIEW('${param.caseSeq}','${param.passSeq}');
			
			var passSeq = document.getElementById("${param.passSeq}");
			if(passSeq){
				document.getElementById("${param.passSeq}").className = "highlight";
			}
		}
	}
	
	//지원일자가 사례시작일보다 빠르지 않도록
	//var DIM_MAGAM_DATE = "${result.caseDate}";	//수정 해야 할 부분
	var DIM_MAGAM_DATE = "${dimMagamDate}";
	var CASE_DATE   = "${result.caseDate}";
	if ( CASE_DATE > DIM_MAGAM_DATE ) {
		DIM_MAGAM_DATE = CASE_DATE;
	}

	//페이지 로딩시 기본 정보값 로드
	var $USER_REL_OPTION  = $('#userRel>option').clone();
	var $SUB1_DATA_OPTION = $('#sub1Data>option').clone();
	var $SUB2_DATA_OPTION = $('#sub2Data>option').clone();
    
  	//지원서비스 신규작성
	$('#btnInsertPass').click(function(e) {
	    fnc_NEW_PASS_FORM();
	});
  	
	//피해자와의 관계 하위 선택
    $("#formPass select[name='userRelGrp']").change(function() {
        fnc_SUB_USER_REL();
    });
	
	//지원구분1 변경시
	$("#passType"). on('change', function() {
		fnc_SUB_PASS_TYPE();
	});
	
    //지원구분2 변경시
    $('#sub1Data').on('change', function() {
        fnc_SUB_SUB1_DATA();
    });
    
    //지원구분3 변경시
    $('#sub2Data').on('change', function() {
        fnc_SUB_SUB2_DATA();
    });
	
	$('#btnClosePass').click(function() {
        $('#divListPass').show();
        $('#divFormPass').hide();

        var passSeq = $('#passSeq').val();
        if(passSeq != "") {
            $('#divViewPass').show();
        }
    });
	
	$('#btnSavePass').click(function(e) {
		e.preventDefault();
        fnPassFormSave("save");
    });
	
// 	$('#btnSavePassType').click(function(e) {
//         fnPassFormSave("insert");
//     });
	
	$('#btnUpdatePass').click(function(e) {
        fnc_GET_PASS_FORM();
    });

	function fnc_SUB_USER_REL() {
		var selectOptionVal = $("#formPass select[name='userRelGrp']").val();
		var selectOptionSub = $("#formPass select[name='userRelGrp']").find('option:selected').attr('data-subcode');
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
	         $("#formPass select[name='userRel']").prop('disabled', true).hide();
		} else {
			$('#userRel').html($USER_REL_OPTION);
	
			$("#formPass select[name='userRel']").prop('disabled', false).show().find("option").filter(function(index) {
				var dataGrpcde = $(this).attr("data-grpcode");
				if (typeof dataGrpcde != "undefined") {
					if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
				}
			}).remove();
		}
		
		if(selectOptionVal == '10' && $("#formPass input[name='userName']").val()=="") {
			$('#formPass input[name=userName]').val($('#victimName').text());
		}
	}
	
    function fnc_SUB_PASS_TYPE() {
        var selectOptionVal = $("#formPass select[name='passType']").val();
        var selectOptionSub = $("#formPass select[name='passType']").find('option:selected').attr('data-subcode');
        if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
            $("#formPass select[name='sub1Data']").prop('disabled', true).hide();
            $("#formPass select[name='sub2Data']").prop('disabled', true).hide();
        } else {

            $('#sub1Data').html($SUB1_DATA_OPTION);

            $("#formPass select[name='sub1Data']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode");
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();

            //상담지원의 경우 접수상담은 선택할 수 없도록
            if(selectOptionVal == "4") {
                $("#formPass select[name='sub1Data']").find("option").filter(function(index) {
                    if ( $(this).val() == "4A" ){ return true;} else { return false; }
                }).prop('disabled', true);
                /*
                $("#formPass select[name='SUB1_DATA']").find("option").filter(function(index) {
                    if ( $(this).val() == "4C" ){ return true;} else { return false; }
                }).prop("selected", true);
                */
            }

            $("#formPass select[name='sub1Data']").find('option:first').prop('selected', 'selected');
            $('#btnSavePassType').hide();
            $('#btnSavePassType2').hide();

            setTimeout(function(){
                fnc_SUB_SUB1_DATA();
            }, 500);
        }
    }
    
    function fnc_SUB_SUB1_DATA() {

        var selectOptionVal = $("#formPass select[name='sub1Data']").val();
        var selectOptionSub = $("#formPass select[name='sub1Data']").find('option:selected').attr('data-subcode');

        if ( selectOptionVal=="1H" || selectOptionVal=="1I" ) {
            selectOptionVal="1B";
        }

        if ( jQuery.type( selectOptionSub )=="undefined") {
            $("#formPass select[name='sub2Data']").prop('disabled', true).hide();
        } else if ( selectOptionSub=="") {
            $("#formPass select[name='sub2Data']").prop('disabled', true).hide();
        } else {

            $('#sub2Data').html($SUB2_DATA_OPTION);

            $("#formPass select[name='sub2Data']").prop('disabled', false).show().find("option").filter(function(index) {
                var dataGrpcde = $(this).attr("data-grpcode");
                if (typeof dataGrpcde != "undefined") {
                    if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                }
            }).remove();
        }

        isServiceItemSavable();
    }
    
    function fnc_SUB_SUB2_DATA() {
        isServiceItemSavable();
    }

	//지원서비스 불러오기 : 수정
	function fnc_GET_PASS_FORM() {
		$("#formPass input[name='act']").val("update");
		
		var caseSeq = $("#caseSeq").val();
		var passSeq = $("#passSeq").val();
		$('#div_historyMemo').val("");
		$('#div_historyMemo').show();
	    $.ajax({
	        type:"post",
	        url:"/bos/instance/case/viewPass.json?caseSeq="+caseSeq+"&passSeq="+ passSeq ,
	        dataType: "json",
	        success:function(entry){
	        	$('#divViewPass').hide();
	            $('#divFormPass').show();
	        	$('#fieldList').css("display", "none");   
	            	$.each(entry, function(index,items){
		            	if(index == "resultList"){
		//                     var disabledVal = items["rulePassUpdatableDate"].toLowerCase()=="true" ? false:true;
		                    var disabledVal = items["rbool"] == true ? false : true;
		                    var userNameStr = items["userName"].replace(/&apos;/g, "'")
										                       .replace(/&quot;/g, '"')
										                       .replace(/&gt;/g, '>')
										                       .replace(/&lt;/g, '<')
										                       .replace(/&amp;/g, '&')
										                       .replace(/&#39;/g, "'");
		                    
		                    $("#formPass input[name='rbool']").val(disabledVal);
		                    $("#userName").val(userNameStr).prop('disabled', disabledVal);
		                    $("#passDate").val(items["passDate"]).prop('disabled', disabledVal);
		                    $("#userRelGrp").val(items["userRelGrp"]).prop('disabled', disabledVal);
		                    $("#userRel").val(items["userRel"]).prop('disabled', disabledVal);
		                    $("#passTime").val(items["passTime"]).prop('disabled', disabledVal);
		                    $("#passTimeE").val(items["passTimeE"]).prop('disabled', disabledVal);
		                    $("#passWay").val(items["passWay"]).prop('disabled', disabledVal);
		                    $("#sub1Data").val(items["sub1Data"]).prop('disabled', disabledVal);
		                    $("#sub2Data").val(items["sub2Data"]).prop('disabled', disabledVal);
		                    $("#passManager").val(items["passManager"]).prop('disabled', disabledVal);
		                    $("#passType").val(items["passType"]).prop('disabled', disabledVal);
		                    $("#passMemo").html(items["passMemo"]).prop('disabled', disabledVal);
		                    $("#passText").html(items["passText"]);
		                    
		                    if(items["passRelType"].length != 0){
			                    $("#formPass input:radio[name='passRelType']:radio[value="+ items["passRelType"] +"]").prop("checked", true);
		                    }
		                    $("#formPass input:radio[name='passRelType']").prop('disabled', disabledVal);
		
		//                     ekrCutStringInTextarea($('#passText'), 3500, "bytesTEXT_PASS_TEXT");
							
							//페이지 로딩시 기본 정보값 로드
							fnc_SUB_USER_REL();
							fnc_SUB_PASS_TYPE();
							
							setTimeout(function() {
								$("#formPass select[name='sub1Data']").val(items["sub1Data"]).prop('disabled', disabledVal);
								$("#formPass select[name='userRel']").val(items["userRel"]).prop('disabled', disabledVal);
								fnc_SUB_SUB1_DATA();
							}, 500);
							setTimeout(function() {
								$("#formPass select[name='sub2Data']").val(items["sub2Data"]).prop('disabled', disabledVal);
							}, 800);
			            }
	                    
	                });
	            $('#btnSavePassType').hide();
	            $('#btnSavePassType2').hide();
	        }
	    }).done(function( data ) {
	        $('.divLoadingImage').hide();
	    });
	}

	function fnc_NEW_PASS_FORM() {
		
		//페이지 로딩시 기본 정보값 로드
		fnc_SUB_USER_REL();
		
		$("#formPass select[name='passType']").prop('disabled', false).find('option:first').prop('selected', 'selected');
		$("#formPass select[name='sub1Data']").prop('disabled', true).hide();
		$("#formPass select[name='sub2Data']").prop('disabled', true).hide();
		$('#btnSavePassType').hide();
		$('#btnSavePassType2').hide();
	    
		$('#div_historyMemo').hide();
		
	    $('#divListPass').hide();
	    $('#divFormPass').show();
	    $('#divViewPass').hide();
	    $('#fieldList').css("display", "");
		$("#formPass input[name='act']").val("insert");

	    //추가된 지원정보행 삭제하기
//	     $('#tablePASS_TYPE > tbody > tr').remove();

	    //기본정보 초기화
	    $('#formPass input[name=passSeq]').val("");
		$('#formPass input[name=userName]').val("").prop('disabled', false);
	    $('#formPass input[name=div_historyMemo]').val("").prop('disabled', false);
	    $('#formPass input[name=userName]').val("").prop('disabled', false);
	    $('#formPass input[name=passDate]').val("").prop('disabled', false);
	    $('#formPass input[name=passTime]').val("00:00").prop('disabled', false);
	    $('#formPass input[name=passTimeE]').val("00:00").prop('disabled', false);
	    $("#formPass input:radio[name='passRelType']:radio[value='1']").prop("checked", true).prop('disabled', false);
	    $("#formPass select[name='userRelGrp']").prop('disabled', false).find('option:first').prop('selected', 'selected');
	    $("#formPass select[name='userRel']").prop('disabled', false).find('option:first').prop('selected', 'selected');
	    $("#formPass select[name='passType']").prop('disabled', false).find('option:first').prop('selected', 'selected');
	    $("#formPass select[name='sub1Data']").prop('disabled', false).find('option:first').prop('selected', 'selected');
	    $("#formPass select[name='sub2Data']").prop('disabled', false).find('option:first').prop('selected', 'selected');
		$("#formPass select[name='userRel']").prop('disabled', true).hide();
	    $("#formPass select[name='passWay']").prop('disabled', false).find('option:first').prop('selected', 'selected');
	    $("#formPass textarea[name='passMemo']").val("").prop('disabled', false);
	    $("#formPass textarea[name='passText']").val("");
//	    $('#btnSavePassType').show();
	}
	
	$('#btnDeletePass').click(function(e) {
        if( confirm( "삭제후에는 복구가 불가능합니다.\n\n지원서비스를 삭제하시겠습니까?") ) {
        	var txtUserName = $("#spanPass_USER_NAME").text();
    		var txtPassDate = $("#spanPass_PASS_DATE").text();
    		var txtPassName = $("#spanPass_PASS_NAME").text();
    		var historyMemo = '삭제전자료 : ' + txtUserName + '(' + txtPassDate + ')' + txtPassName
    		
    		$("#formPass input[name='historyMemo']").val(historyMemo);
            $("#formPass input[name='act']").val("delete");
            $.ajax({
                type:"post",
                url:"/bos/instance/case/deletePass.json" ,
                data: $("#formPass").serialize(),
                dataType: "json",
                success:function(entry){
                    alert("삭제되었습니다.");
                    window.location.reload();
                    $('#divListPass').show();
                    $('#divViewPass').hide();
                },
                fail:function(entry){
                    alert("저장실패 : "+ entry);
                }
            });
        }
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
            yearRange:"${yearRange}",
            numberOfMonths: 1,
            showButtonPanel: true
        })
        .blur(function() { 
            if ( RegularDateFormat( $(this).val() ) ) {      
            } else {
            if($(this).val().length>0) {
                alert("날짜는 2016-02-15 형식으로 입력해야 합니다.");
                $(this).val("2018-01-01");
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

	$("#pageSelect").change(function() {
		var pageUnit = $(this).val();
		var caseSeq = $("#schCaseSeq").val();
		var shPassType = $("#formSearch select[name='shPassType']").val();
		var shSub1Data= $("#formSearch select[name='shSub1Data']").val();
		var frm = $("#formSearch")[0];
		
		$.ajax({
				url: "/bos/instance/case/pageUnitChange.json",
				type: "get",
				data: {pageUnit : pageUnit, caseSeq : caseSeq, shPassType : shPassType, shSub1Data : shSub1Data},
				success: function(data) {
					$("#pageUnit").val(data.pageUnit);
					
					$("#formSearch").attr("action", "/bos/instance/case/passView.do");
					$("#formSearch").submit();
				}
		});
	});
	
	$('#orderPassDateBtn').on('click',function(){
        var casePdate = document.getElementById("passPdate");
        
        if(casePdate.value == ""){
        	casePdate.value ="ASC";
        }else if(casePdate.value == "ASC"){
        	casePdate.value = "DESC";
        }else if(casePdate.value == "DESC"){
        	casePdate.value = "ASC";
        }else{
        	casePdate.value = "ASC";
        }
        fn_passSearch();
    });
	
    //페이지 로딩시 기본 정보값 로드
    var $SUB1_DATA_OPTION_SRC = $('#shSub1Data>option').clone();
    var $SUB2_DATA_OPTION_SRC = $('#shSub2Data>option').clone();
     
    //지원구분1 변경시
    $('#shPassType').on('change', function() {
    	fnc_SUB_PASS_TYPE_SRC();
    });
     
    //지원구분2 변경시
    $('#shSub1Data').on('change', function() {
    	fnc_SUB_SUB1_DATA_SRC();
    });
     
    function fnc_SUB_PASS_TYPE_SRC() {
    	var selectOptionVal = $("#formSearch select[name='shPassType']").val();
    	var selectOptionSub = $("#formSearch select[name='shPassType']").find('option:selected').attr('data-subcode');
    	if (selectOptionSub == '' || selectOptionSub == null) {
    		$("#formSearch select[name='shSub1Data']").prop('disabled', true).hide();
    		$("#formSearch select[name='shSub2Data']").prop('disabled', true).hide();
    	} else {
    		$('#shSub1Data').html($SUB1_DATA_OPTION_SRC);

    		$("#formSearch select[name='shSub1Data']").prop('disabled', false).show().find("option").filter(function(index) {
    			var dataGrpcde = $(this).attr("data-grpcode")
    			if (typeof dataGrpcde != "undefined") {
    				if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
    			}
    		}).remove();

    		/* $("#formSearch select[name='shSub1Data']").prepend("<option value=''>그룹 선택</option>");
      		$("#formSearch select[name='shSub1Data'] option:eq(0)").attr("selected", "selected"); */

    		setTimeout(function(){
    			fnc_SUB_SUB1_DATA_SRC();
    		}, 500);
    	}
    }

    function fnc_SUB_SUB1_DATA_SRC() {
    	var selectOptionVal = $("#formSearch select[name='shSub1Data']").val();
    	var selectOptionSub = $("#formSearch select[name='shSub1Data']").find('option:selected').attr('data-subcode');
    	if (selectOptionSub == '' || selectOptionSub == null) {
    		$("#formSearch select[name='shSub2Data']").prop('disabled', true).hide();
    	} else {
    		$('#shSub2Data').html($SUB2_DATA_OPTION_SRC);

    		$("#formSearch select[name='shSub2Data']").prop('disabled', false).show().find("option").filter(function(index) {
    			var dataGrpcde = $(this).attr("data-grpcode")
    			if (typeof dataGrpcde != "undefined") {
    				if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
    			}
    		}).remove();

    		/* $("#formSearch select[name='shSub2Data']").prepend("<option value=''>그룹 선택</option>");
      		$("#formSearch select[name='shSub2Data'] option:eq(0)").attr("selected", "selected"); */
    	}
    }

    fnc_SUB_PASS_TYPE_SRC();
});

//지원서비스 불러오기 : 보기
function fnc_GET_PASS_VIEW(caseSeq, passSeq) {
	$("#caseSeq").val(caseSeq);
	$("#passSeq").val(passSeq);
	$("#btnCasePrintDetail").val(passSeq);
	$.ajax({
		type:"post",
		url:"/bos/instance/case/viewPass.json?caseSeq="+caseSeq+"&passSeq="+ passSeq ,
		dataType: "json",
		success:function(entry){
			$('#divViewPass').show();
			$('#divFormPass').hide();
			$('#passSeq').val(passSeq);

			$.each(entry, function(index,items){
        	  if(items["passSeq"] != null) {
					$("#spanPass_USER_NAME").html(items["userName"]);
					$("#spanPass_USER_REL_GRP").html(items["userRelGrpNm"]);
                  $("#spanPass_USER_REL").html(items["userRelNm"]);
                  $("#spanPass_PASS_DATE").text(items["passDate"]);
                  $("#spanPass_PASS_TIME").text(items["passTime"]);
                  $("#spanPass_PASS_TIME_E").text(items["passTimeE"]);
                  $("#spanPass_PASS_WAY").html(items["passWayNm"]);
                  $("#spanPass_PASS_MANAGER").html(items["passManager"]);
                  $("#spanPass_PASS_NAME").html(items["passTypeNm"]);
                  $("#spanPass_SUB1_NAME").html(items["sub1DataNm"]);
                  $("#spanPass_SUB2_NAME").html(items["sub2DataNm"]);
                  $("#spanPass_PASS_REL_TYPE").text(items["passRelTypeNm"]);
                  
                  //지원요약 있는 경우에만 출력
                  if(items["passMemo"]){
                      $("#spanPass_PASS_MEMO").html(items["passMemo"].replace(/\n/g, "<br>"));
                  } else {
                	  $("#spanPass_PASS_MEMO").html("");
                  }
                  
                  //세부사항 있는 경우에만 출력
                  if(items["passText"]){
                	  $("#spanPass_PASS_TEXT").html(items["passText"].replace(/\n/g, "<br>"));
                  } else {
                	  $("#spanPass_PASS_TEXT").html("");
                  }
                  
                  $("#viewPassSeq").val(items["passSeq"]);

                  //접수상담정보는 수정및 삭제가 불가능
                   if ( items["sub1Data"] == "4A" ) {
                       $("#btnUpdatePass").hide();
                       $("#btnDeletePass").hide();
                   } else {
                      if ((items["passManagerCd"] == "-" || items["passManagerCd"] == "${userVO.userId}")) {
                      	$("#btnUpdatePass").show();
                          $("#btnDeletePass").show();
                      } else {
                          $("#btnUpdatePass").hide();
                          $("#btnDeletePass").hide();
                      }
                      
						if(!items["rbool"]){
							$("#btnDeletePass").hide();
						}
                   }
        	  }
              
			});
		}
	}).done(function( data ) {
		$('.divLoadingImage').hide();
	});
}

function deletePassBtn(data) {
	
	if( confirm( "삭제후에는 복구가 불가능합니다.\n\n지원서비스를 삭제하시겠습니까?") ) {
    	var txtUserName =$(data).parent().children('.userName').val();
		var txtPassDate = $(data).parent().children('.passDate').val();
		var txtPassName = $(data).parent().children('.passType').val();;
		var historyMemo = '삭제전자료 : ' + txtUserName + '(' + txtPassDate + ')' + txtPassName ;
		
		var caseSeq = $(data).parent().children('.caseSeq').val()
		var passSeq = $(data).parent().children('.passSeq').val()
		
		
		/* $("#formPass input[name='historyMemo']").val(historyMemo);
        $("#formPass input[name='act']").val("delete"); */
        $.ajax({
            type:"post",
            url:"/bos/instance/case/deletePass.json" ,
            data:{"caseSeq":caseSeq, "passSeq":passSeq, "historyMemo":historyMemo, "userNm":txtUserName, "userId":'${userVO.userId}' },
            dataType: "json",
            success:function(entry){
                $(data).parent().parent().remove();
                alert("삭제되었습니다.");
            },
            fail:function(entry){
                alert("저장실패 : "+ entry);
            }
        }); 
    }
}
	
function fnPassFormSave(saveType) {
//	var rowCount = $('#tablePASS_TYPE >tbody >tr').size();
    //서비스 지원 추가 버튼이 있거나 지원을 추가한게 하나도 없을경우 저장을 원한다고 간주
//	if( $('#btnSavePassType').css( "display" )!="none" || rowCount<1) {}
	
	var disabledVal = $("#formPass input[name='rbool']").val() == "true" ? false : "";

	$("#userName").prop('disabled', disabledVal);
	$("#passDate").prop('disabled', disabledVal);
	$("#userRelGrp").prop('disabled', disabledVal);
	$("#userRel").prop('disabled', disabledVal);
	$("#passTime").prop('disabled', disabledVal);
	$("#passTimeE").prop('disabled', disabledVal);
	$("#passWay").prop('disabled', disabledVal);
	$("#sub1Data").prop('disabled', disabledVal);
	$("#sub2Data").prop('disabled', disabledVal);
	$("#passManager").prop('disabled', disabledVal);
	$("#passType").prop('disabled', disabledVal);
	$("#passMemo").prop('disabled', disabledVal);
	$("#formPass input:radio[name='passRelType']").prop('disabled', disabledVal);
	$("#formPass select[name='sub1Data']").prop('disabled', disabledVal);
	$("#formPass select[name='userRel']").prop('disabled', disabledVal);
	$("#formPass select[name='sub2Data']").prop('disabled', disabledVal);
    
	var form = $("#formPass")[0];
	var v = new MiyaValidator(form);
	      
	v.add("userName", {
	    required: true
	});
	v.add("userRelGrp", {
	    required: true
	});
	v.add("passDate", {
	    required: true
	});
	v.add("passWay", {
	    required: true
	});
	v.add("passManager", {
	    required: true
	});
	
	v.add("passType", {
	    required: true
	});
	v.add("sub1Data", {
	    required: true
	});
	
	var result = v.validate();
	if (!result) {
	    alert(v.getErrorMessage());
	    v.getErrorElement().focus();
	    return;
	}
	
	if(!isServiceItemSavable()){
		alert("지원서비스를 모두 입력해주세요.");
		
		var disabledVal = $("#formPass input[name='rbool']").val() == "true" ? true : false;

		$("#userName").prop('disabled', disabledVal);
		$("#passDate").prop('disabled', disabledVal);
		$("#userRelGrp").prop('disabled', disabledVal);
		$("#userRel").prop('disabled', disabledVal);
		$("#passTime").prop('disabled', disabledVal);
		$("#passTimeE").prop('disabled', disabledVal);
		$("#passWay").prop('disabled', disabledVal);
		$("#sub1Data").prop('disabled', disabledVal);
		$("#sub2Data").prop('disabled', disabledVal);
		$("#passManager").prop('disabled', disabledVal);
		$("#passType").prop('disabled', disabledVal);
		$("#passMemo").prop('disabled', disabledVal);
		$("#formPass input:radio[name='passRelType']").prop('disabled', disabledVal);
		$("#formPass select[name='sub1Data']").prop('disabled', disabledVal);
		$("#formPass select[name='userRel']").prop('disabled', disabledVal);
		$("#formPass select[name='sub2Data']").prop('disabled', disabledVal);
		return;
	}

	var passSeq = $("#passSeq").val();
	if(saveType=="save") {
		var txtPassDateB = $("#spanPass_PASS_DATE").text();
		var txtPassTimeB = $("#spanPass_PASS_TIME").text();
		var txtPassTypeNmB = $("#spanPass_PASS_NAME").text();
		var txtSub1DataNmB = $("#spanPass_SUB1_NAME").text();
		var txtSub2DataNmB = $("#spanPass_SUB2_NAME").text();
		var txtPassTypeNmA = $("#formPass select[name='passType']").find('option:selected').text();
		var txtSub1DataNmA = $("#formPass select[name='sub1Data']").find('option:selected').text();
		var txtSub2DataNmA = $("#formPass select[name='sub2Data']").find('option:selected').text();
// 		var historyMemo = txtPassDateB + ' ' + txtPassTimeB + ' ' + txtPassTypeNmB + '-' + txtSub1DataNmB + ' '+txtSub2DataNmB + ' 항목을 (' + txtPassTypeNmA + '-' + txtSub1DataNmA + ' ' + txtSub2DataNmA + ') 으로 수정하였습니다.';
// 		$("#formPass input[name='historyMemo']").val(historyMemo);
		
		//저장로직
		var url;
		var msg;
		
		if(passSeq == ""){
			url = "/bos/instance/case/insertPass.do";
			msg = "등록";
		}else{
			if( $("#formPass input[name='historyMemo']").val().length < 3){
				var disabledVal = $("#formPass input[name='rbool']").val() == "true" ? true : false;
				
				$("#userName").prop('disabled', disabledVal);
				$("#passDate").prop('disabled', disabledVal);
				$("#userRelGrp").prop('disabled', disabledVal);
				$("#userRel").prop('disabled', disabledVal);
				$("#passTime").prop('disabled', disabledVal);
				$("#passTimeE").prop('disabled', disabledVal);
				$("#passWay").prop('disabled', disabledVal);
				$("#sub1Data").prop('disabled', disabledVal);
				$("#sub2Data").prop('disabled', disabledVal);
				$("#passManager").prop('disabled', disabledVal);
				$("#passType").prop('disabled', disabledVal);
				$("#passMemo").prop('disabled', disabledVal);
				$("#formPass input:radio[name='passRelType']").prop('disabled', disabledVal);
				$("#formPass select[name='sub1Data']").prop('disabled', disabledVal);
				$("#formPass select[name='userRel']").prop('disabled', disabledVal);
				$("#formPass select[name='sub2Data']").prop('disabled', disabledVal);
				
	        	alert("수정내용을 3자 이상 입력해주세요.");
	        	$("#formPass input[name='historyMemo']").focus();
	        	return;
	        }
			url = "/bos/instance/case/updatePass.do";
			msg = "수정";
		}
		
		if (confirm(msg + " 하시겠습니까?")) {
			var selectOptionVal = $("#formPass select[name='sub1Data']").val();
	        var selectOptionSub = $("#formPass select[name='sub1Data']").find('option:selected').attr('data-subcode');

	        if ( jQuery.type( selectOptionSub )=="undefined") {
	            $("#formPass select[name='sub2Data']").prop('disabled', true).hide();
	        } else if ( selectOptionSub=="") {
	            $("#formPass select[name='sub2Data']").prop('disabled', true).hide();
	        }
			
			$("#loadingDiv").show();
	        form.action=url;
			form.submit();
		} else {
			var disabledVal = $("#formPass input[name='rbool']").val() == "true" ? true : false;

			$("#userName").prop('disabled', disabledVal);
			$("#passDate").prop('disabled', disabledVal);
			$("#userRelGrp").prop('disabled', disabledVal);
			$("#userRel").prop('disabled', disabledVal);
			$("#passTime").prop('disabled', disabledVal);
			$("#passTimeE").prop('disabled', disabledVal);
			$("#passWay").prop('disabled', disabledVal);
			$("#sub1Data").prop('disabled', disabledVal);
			$("#sub2Data").prop('disabled', disabledVal);
			$("#passManager").prop('disabled', disabledVal);
			$("#passType").prop('disabled', disabledVal);
			$("#passMemo").prop('disabled', disabledVal);
			$("#formPass input:radio[name='passRelType']").prop('disabled', disabledVal);
			$("#formPass select[name='sub1Data']").prop('disabled', disabledVal);
			$("#formPass select[name='userRel']").prop('disabled', disabledVal);
			$("#formPass select[name='sub2Data']").prop('disabled', disabledVal);
		}
	} else if(saveType=="insert") {
		var msg;
		if (confirm("등록 하시겠습니까?")) {
		var params = $("#formPass").serialize();
		
		$.ajax(
			{
				url : "/bos/instance/case/insertPass.json",
				data : params,
				contentType: "application/x-www-form-urlencoded; charset=euc-kr",
				success : function(x)
				{
					createTableTest();
				}
			});
	    }
	}else if(saveType=="append") {
		var msg;
		
		var passTypeNm = $("#tablePASS_TYPE #passType option:selected").text();
		var sub1DataNm = $("#tablePASS_TYPE #sub1Data option:selected").text();
		var sub2DataNm = $("#tablePASS_TYPE #sub2Data option:selected").text();
		
		if (confirm("등록 하시겠습니까?")) {
		var params = $("#formPass").serialize();
		
		/* url : "/bos/instance/case/insertPass.json",
		$("#loadingDiv").show();
        form.action=url;
		form.submit(); */
		
		
		 $.ajax(
			{
				url : "/bos/instance/case/insertPass.json",
				data : params,
				contentType: "application/x-www-form-urlencoded; charset=euc-kr",
				success : function(data)
				{	
					
					$("#passType").val("");
					$("#sub1Data").val("");
					$("#sub2Data").val("");
					$("#passType").val("");
					$("#passMemo").val("");
					$("#passText").val("");
					/* $("input[name=passRelType]").removeProp("selected"); */
					
					$("#formPass select[name='sub1Data']").prop('disabled', true).hide();
					$("#formPass select[name='sub2Data']").prop('disabled', true).hide();
					$("#btnSavePassType").hide();
					$("#btnSavePassType2").hide();
					
					/* $("#tablePASS_TYPE").prepend("<tr><td>" + passTypeNm + "</td><td>" + sub1DataNm + " " + sub2DataNm + "</td></tr>"); */
					
					$("#tablePASS_TYPE_Temp").append(
							"<tr><th scope='row'><label>지원구분</label></th><td>"
		                    	+"<select disabled style='color: #000;' class='passTypeNm'><option>" + passTypeNm + "</option></select>" 
		                    +"</td><th scope='row'><label>지원세부구분</label></th><td>"
		                    
		                    	+"<input type='hidden' class='caseSeq' value='"+ data.caseSeq +"'></input>"
		                    	+"<input type='hidden' class='passSeq' value='"+ data.passSeq +"'></input>"
		                    	+"<input type='hidden' class='passDate' value='"+ data.passDate +"'></input>"
		                    	+"<input type='hidden' class='userName' value='"+ data.userName +"'></input>"
		                    	+"<input type='hidden' class='passType' value='"+ passTypeNm +"'></input>"
		                    	
		                    	+"<select disabled style='color: #000;'><option>"+ sub1DataNm + "</option></select> " 
		                    	+"<select disabled style='color: #000;'><option>" + sub2DataNm + "</option></select> "
		                    	+"<button type='button' onclick='javascript:deletePassBtn(this)' class='b-cancel btn-xs btn btn-default btnDeletePassType' style='background: red;color: #fff;'>삭제</button>"
		                    	
		                    +"</td></tr>"
					)
					
					
					/* createTableTest(); */
				}
			});
		
	    } 
	}else if(saveType=="append2") {
		var msg;
		
		var passTypeNm = $("#tablePASS_TYPE #passType option:selected").text();
		var sub1DataNm = $("#tablePASS_TYPE #sub1Data option:selected").text();
		var sub2DataNm = $("#tablePASS_TYPE #sub2Data option:selected").text();
		
		if (confirm("등록 하시겠습니까?")) {
		var params = $("#formPass").serialize();
		
		/* url : "/bos/instance/case/insertPass.json",
		$("#loadingDiv").show();
        form.action=url;
		form.submit(); */
		
		
		 $.ajax(
			{
				url : "/bos/instance/case/insertPass.json",
				data : params,
				contentType: "application/x-www-form-urlencoded; charset=euc-kr",
				success : function(data)
				{
					$("#passType").val("");
					$("#sub1Data").val("");
					$("#sub2Data").val("");
					$("#passType").val("");
					
					
					$("#formPass select[name='sub1Data']").prop('disabled', true).hide();
					$("#formPass select[name='sub2Data']").prop('disabled', true).hide();
					$("#btnSavePassType").hide();
					$("#btnSavePassType2").hide();
					/* $("input[name=passRelType]").removeProp("selected"); */
					
					/* $("#tablePASS_TYPE").prepend("<tr><td>" + passTypeNm + "</td><td>" + sub1DataNm + " " + sub2DataNm + "</td></tr>"); */
					
					$("#tablePASS_TYPE_Temp").append(
							"<tr><th scope='row'><label>지원구분</label></th><td>"
		                    	+"<select disabled style='color: #000;' class='passTypeNm'><option>" + passTypeNm + "</option></select>" 
		                    +"</td><th scope='row'><label>지원세부구분</label></th><td>"
		                    
		                    	+"<input type='hidden' class='caseSeq' value='"+ data.caseSeq +"'></input>"
		                    	+"<input type='hidden' class='passSeq' value='"+ data.passSeq +"'></input>"
		                    	+"<input type='hidden' class='passDate' value='"+ data.passDate +"'></input>"
		                    	+"<input type='hidden' class='userName' value='"+ data.userName +"'></input>"
		                    	+"<input type='hidden' class='passType' value='"+ passTypeNm +"'></input>"
		                    	
		                    	+"<select disabled style='color: #000;'><option>"+ sub1DataNm + "</option></select> " 
		                    	+"<select disabled style='color: #000;'><option>" + sub2DataNm + "</option></select> "
		                    	+"<button type='button' onclick='javascript:deletePassBtn(this)' class='b-cancel btn-xs btn btn-default btnDeletePassType' style='background: red;color: #fff;'>삭제</button>"
		                    	
		                    +"</td></tr>"
					)
					
					
					/* createTableTest(); */
				}
			})
	    } 
	}

}

function isServiceItemSavable() {
    var sVal = false;
    $('#btnSavePassType').hide();
    $('#btnSavePassType2').hide();

    var valPASS_TYPE = $("#formPass select[name='passType']").val();
    var valSUB1_DATA = $("#formPass select[name='sub1Data']").val();
    var optSUB1_DATA = $("#formPass select[name='sub1Data']").find('option:selected').attr('data-subcode');
    var valSUB2_DATA = $("#formPass select[name='sub2Data']").val();

    if ( valPASS_TYPE!="" && valSUB1_DATA!="" ) {
        if ( jQuery.type( optSUB1_DATA )!="undefined" ) {
            if ( (optSUB1_DATA=="") || (optSUB1_DATA!="" && valSUB2_DATA!="") ) {
                sVal = true;

                if( $("#formPass input[name='act']").val() == "insert") {
                    $('#btnSavePassType').show();
                    $('#btnSavePassType2').show();
                }
            }
        }
    }

    return sVal;
}

function createTableTest(){
    var param = {};
    param = JSON.stringify(param);

    $.ajax({
        url : "/bos/instance/case/ajaxFindPassTypeList.json",
        data : param,
        type : 'post',
        success : function(data){
//             var results = data.resultList;
//             var str = '<TR>';
//             $.each(results , function(i){
//                 str += '<TD>' + results[i].bdTitl + '</TD><TD>' + results[i].bdWriter + '</TD><TD>' + results[i].bdRgDt + '</TD>';
//                 str += '</TR>';
//            });
           $("#tablePASS_TYPE").append(str); 
        },
        error : function(){
            alert("error");
        }
    });
}



/* function fn_passSearch(){
	var caseSeq = $("#schCaseSeq").val();
	var shPassType = $("#formSearch select[name='shPassType']").val();
	var shSub1Data= $("#formSearch select[name='shSub1Data']").val();
	var pageUnit = $("#pageUnit").val();
    $.ajax({
        url : "/bos/instance/case/passView.json?caseSeq="+ caseSeq +"&shPassType=" + shPassType + "&shSub1Data=" + shSub1Data,
        type : 'post',
        success : function(data){
           $("#passTbody").empty(); 
            var results = data.resultPassList;
            var str;
            if(results.length > 0 ){
                $.each(results , function(i){
	                str += '<tr onclick="fnc_GET_PASS_VIEW(' + results[i].caseSeq + ', ' + results[i].passSeq +');" style="cursor: pointer;"  >';
                    str += '<td>' + results[i].passDate + '</td>';
                    str +=  '<td>' + results[i].userName + '</td>';
                    str +=  '<td>' + results[i].sub1DataNm + '</td>';
                    str +=  '<td>' + results[i].passWayNm + '</td>';
                    str +=  '<td>' + results[i].passName + '</td>';
                    str +=  '<td>' + results[i].passMemo + '</td>';
                    str +=  '<td>' + results[i].passManager + '</td>';
	               str += '</tr>';
                });
            }else{
            	str += '<tr><td colspan="7">데이터가 없습니다.</td></tr>';
            }
            $("#tbPass").append(str); 
            $("#txtTotalRecordPassCount").text(results.length); 
        },
        error : function(){
            alert("error");
        }
    });
} */

function fn_passSearch(){
	$("#formSearch").submit();
}

function getRandomId(prefix) {
	var num;
	var returnId = ""; 
	while(true) {
		// 1~1000까지 난수 발생(반올림)
		num = Math.ceil(Math.random() * 1000); 
		// 접두사 + 난수 
		returnId = prefix+num; 
		// ID존재여부 검사 없는 경우 리턴해줌
		if(document.getElementById(returnId) == null){	 
			break;
		}
	}  
	return returnId;
}

function addAnswer() {
	fnPassFormSave("append");
}
function addAnswer2() {
	fnPassFormSave("append2");
}

function removeAnswer(obj) {
// 	if ($("#fieldList").children().length > 1 ) {
// 		if (($("#fieldList").children().length > 1 && etcIdx == 0 ) || ($("#fieldList").children().length > 2 && etcIdx > 0)) {
			$(obj).parent().parent().remove();
// 		}
// 	}
}

function replaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}



$(function(){
	 $("#tbPass tbody tr").click(function(){
	    	$(this).addClass("highlight").siblings().removeClass("highlight")
	    });
});
</script>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
	    <li><a class="" href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
	    <li class="active"><a class="" href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li><a class="" href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li><a class="" href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li><a class="" href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
	</ul>
</div>

<div id="divViewPass" style="width:100%; padding-top:10px; display:none;">
	<!-- <p class="divViewPass-prev"><a href="javascript:;"><img src="/static/ucms/img/btn-left.png" alt="이전정보보기" /></a></p> -->
	<table class="table03">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<tbody>
			<tr>
				<th>내담자이름</th>
				<td><span id="spanPass_USER_NAME"></span></td>
				<th>피해자와의 관계</th>
				<td><span id="spanPass_USER_REL_GRP"></span>&nbsp; <span id="spanPass_USER_REL"></span></td>
			</tr>
			<tr>
				<th>지원일자</th>
				<td><span id="spanPass_PASS_DATE"></span></td>
				<th>지원시간</th>
				<td><span id="spanPass_PASS_TIME"></span> ~ <span id="spanPass_PASS_TIME_E"></span></td>
			</tr>
			<tr>
				<th>지원방법</th>
				<td><span id="spanPass_PASS_WAY"></span></td>
				<th>담당자</th>
				<td><span id="spanPass_PASS_MANAGER"></span></td>
			</tr>
			<tr>
				<th>지원구분</th>
				<td><span id="spanPass_PASS_NAME"></span></td>
				<th>지원세부구분</th>
				<td><span id="spanPass_SUB1_NAME"></span>&nbsp; <span id="spanPass_SUB2_NAME"></span></td>
			</tr>
			<tr>
				<th>지원대상 구분</th>
				<td colspan=3><span id="spanPass_PASS_REL_TYPE"></span></td>
			</tr>
			<tr>
				<th>지원요약</th>
				<td colspan=3><span id="spanPass_PASS_MEMO"></span></td>
			</tr>
			<tr>
				<th>세부사항</th>
				<td colspan=3><span id="spanPass_PASS_TEXT"></span></td>
			</tr>
		</tbody>
	</table>

	<div class="btnGroup">
		<input type="hidden" id="viewPassSeq">
		<button id="btnCasePrintDetail" title="print3-3" value="" class="pure-button btnInsert btnCasePrint">지원서비스출력</button>
		<%--
        <%
        NowDate = Date()
        startDate = "2019-01-01"
        endDate = "2019-06-30"
        If Cdate(CASE_DATE) < Cdate(startDate) or Cdate(CASE_DATE) > Cdate(endDate) Then
        %>
        --%>
		<a id="btnUpdatePass" class="pure-button btnUpdate">수정</a>
		<a id="btnDeletePass" class="pure-button btnDelete">삭제</a>
		<%--  <%end if%>--%>
	</div>

	<!-- <p class="divViewPass-next"><a href="javascript:;"><img src="/static/ucms/img/btn-right.png" alt="다음정보보기" /></a></p>-->
</div>

<div id="divFormPass" style="width:100%; padding-top:10px; display:none;">
	<form id="formPass" class="pure-form" method="post" enctype="multipart/form-data" />
		<input type="hidden" id="passSeq" name="passSeq" value="" />
		<input type="hidden" id="caseSeq" name="caseSeq" value="${result.caseSeq}" />
		<input type="hidden" id="centerCode" name="centerCode" value="${userVO.centerCode}" />
		<input type="hidden" name="userId" value="${userVO.userId}" />
		<input type="hidden" name="userNm" value="${userVO.userNm}" />
		<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
<!--	<input type="hidden" id="historyMemo" name="historyMemo" value="" /> -->
		<input type="hidden" name="act" value="" />
		<input type="hidden" name="rbool" value="" />

		<table class="table03">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="userName"><span class="essentialInputField req"><span>필수입력</span></span>내담자이름</label></th>
					<td>
						<input type="text" name="userName" id="userName" value="">
					</td>
					<th scope="row"><label for="userRelGrp"><span class="essentialInputField req"><span>필수입력</span></span>피해자와의 관계</label></th>
					<td>
						<select name="userRelGrp" id="userRelGrp" title="피해자와의 관계" style="width: 45%">
							<script>
								getCmmnCd.select('CS25G', 'userRelGrp', '${result.userRelGrp}', 'N');
							</script>
						</select>
						<select name="userRel" id="userRel" title="피해자와의 관계2" style="width: 50%">
							<script>
								getCmmnCd.subSelect('CS25', 'userRel', '${result.userRelGrp}', '${result.userRel}', 'N')
							</script>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="passDate"><span class="essentialInputField req"><span>필수입력</span></span>지원일자</label></th>
					<td>
						<input type="text" name="passDate" id="passDate" value="" class="formatDateMagam">
					</td>
					<th scope="row"><label for="passTime"><span class="essentialInputField req"><span>필수입력</span></span>지원시간</label></th>
					<td>
						<input type="text" name="passTime" id="passTime" value="" class="formatTime"> ~ <input type="text" name="passTimeE" id="passTimeE" value="" class="formatTime">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="passWay"><span class="essentialInputField req"><span>필수입력</span></span>지원방법</label></th>
					<td>
						<select name="passWay" id="passWay" title="지원방법" style="width: 150px">
							<script>
								getCmmnCd.select('CS21', 'passWay', '', 'N');
							</script>
						</select>
					</td>
					<th scope="row"><label for="passManager"><span class="essentialInputField req"><span>필수입력</span></span>담당자</label></th>
					<td>
						<input type="hidden" name="passManager" id="passManager" value="${userVO.userId}" readonly="readonly" />
						<input type="text" value="${userVO.userNm}" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td colspan=4 style="padding: 0px; border-collapse: collapse;">
						<table id="tablePASS_TYPE_Temp" class="pure-table pure-table-bordered" style="width: 100%; border: 0px">
							<colgroup>
								<col width="15%" />
								<col width="20%" />
								<col width="15%" />
								<col width="50%" />
							</colgroup>
							<tbody></tbody>
						</table>
						<table id="tablePASS_TYPE" class="pure-table pure-table-bordered" style="width: 100%; border: 0px">
							<colgroup>
								<col width="15%" />
								<col width="20%" />
								<col width="15%" />
								<col width="50%" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="passType"><span class="essentialInputField req"><span>필수입력</span></span>지원구분</label></th>
									<td>
										<select name="passType" id="passType" title="지원구분" style="width: 150px">
											<script>
												getCmmnCd.select('PSA1', 'passType', '', 'N');
											</script>
										</select>
									</td>
									<th scope="row"><label for="sub1Data"><span class="essentialInputField req"><span>필수입력</span></span>지원세부구분</label></th>
									<td>
										<select name="sub1Data" id="sub1Data" title="지원세부구분1" style="width: 38%">
											<script>
												getCmmnCd.subSelect('PSA2', 'sub1Data', '', '', 'N')
											</script>
										</select>&nbsp;
										<select name="sub2Data" id="sub2Data" title="지원세부구분2" style="width: 38%">
											<script>
												getCmmnCd.subSelect('PSA3', 'sub2Data', '', '', 'N')
											</script>
										</select>&nbsp;
										<button id="btnSavePassType" type="button" onclick="addAnswer(this)" class="b-add btn-xs">추가</button>
										<button id="btnSavePassType2" type="button" onclick="addAnswer2(this)" class="b-add btn-xs">복사+추가</button>
									</td>
								</tr>
							</tbody>
							<tfoot id="fieldList">
							</tfoot>
							<!-- <tfoot id="dummy" style="display:none">
	                            <tr>
	                                <th scope="row">지원구분</label></th>
	                                <td>
	                                	<select name="passType" id="passType_id" title="지원구분" onchange="getCmmnCd.subSelect('PSA2','sub1Data_id',this.value , '', 'N')">
				                           	<script>
				                           		getCmmnCd.select('PSA1', 'passType_id', '', 'N');
				                           	</script>
						                </select>
	                                </td>
	                                <th scope="row">지원세부구분</label></th>
	                                <td>
	                                    <select name="sub1Data" id="sub1Data_id" title="지원세부구분1" onchange="getCmmnCd.subSelect('PSA3','sub2Data_id',this.value , '', 'N')">
				                           	<script>
												getCmmnCd.subSelect('PSA2', 'sub1Data_id', '', '', 'N')
											</script>
						                </select>&nbsp;
						                <select name="sub2Data" id="sub2Data_id" title="지원세부구분2" >
				                           	<script>
				                           		getCmmnCd.subSelect('PSA3', 'sub2Data_id', '', '', 'N')
				                           	</script>
						                </select>&nbsp;
										<button type="button" onclick="addAnswer(this)" class="b-add btn-xs">추가</button>
										<button type="button" onclick="removeAnswer(this)" class="b-del btn-xs">삭제</button>
	                                </td>
	                            </tr>
                            </tfoot> -->
						</table>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="passRelType"><span class="essentialInputField req"><span>필수입력</span></span>지원대상 구분</label></th>
					<td colspan=3>
						<div id="divPASS_REL_TYPE">
							<script>
								getCmmnCd.radio('PSRY', 'divPASS_REL_TYPE', 'passRelType', '');
							</script>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="passMemo">지원요약</label></th>
					<td colspan=3><textarea name="passMemo" id="passMemo" value="" style="width: 100%;"></textarea></td>
				</tr>
				<tr>
					<th>세부사항
						<div class="bytes-wrapper">
							<span id="bytespassText">0</span> / 3,500bytes
						</div>
					</th>
					<td colspan=3><textarea id="passText" name="passText" style="height: 250px; width: 100%;"></textarea></td>
				</tr>
			</tbody>
		</table>

		<div id="div_historyMemo" style="display: none;">
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
	</form>

	<div class="btnGroup">
		<a id="btnSavePass" class="pure-button btnSave">저장</a>
		<a id="btnClosePass" class="pure-button btnCancel">닫기</a>
	</div>
</div>


<div id="divListPass">
	<div class="board_top" style="width:100%; margin-top:15px; margin-bottom:5px;">
		<span>서비스 : <strong class="f_blue" id="txtTotalRecordPassCount">${resultCnt}</strong>건</span>
		<div>
			<div>
				<form name="formSearch" id="formSearch" class="pure-form">
					<%-- <input type="hidden" id="schCaseSeq" name="schCaseSeq" value="${paramVO.caseSeq}" > --%>
					<input type="hidden" name="caseSeq" value="${paramVO.caseSeq}">
					<input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
					<input type="hidden" name="menuNo" value="${param.menuNo}" />
					<input type="hidden" name="passPdate" id="passPdate" value="${param.passPdate}">
					
					<select name="shPassType" id="shPassType" title="지원구분 검색">
						<script>
							getCmmnCd.select('PSA1', 'shPassType', '${paramVO.shPassType}', 'N');
						</script>
					</select> <select name="shSub1Data" id="shSub1Data" title="지원구분 서브 검색">
						<script>
							getCmmnCd.select('PSA2', 'shSub1Data', '${paramVO.shSub1Data}', 'N')
						</script>
					</select>
					<a id="btnPassSearch" class="pure-button btnSearch" onclick="fn_passSearch()">검색</a>
					<a id="btnInsertPass" class="pure-button btnSave">서비스 신규입력</a>
					<a id="btnCasePrint" title="print3-2" class="pure-button btnPrint btnCasePrint">지원요약지출력</a>
					<select id="pageSelect" name="pageSelect">
						<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
						<option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
						<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
						<option value="0" ${paramVO.pageUnit eq '999999' ? 'selected' : '' }>전체</option>
					</select>
				</form>
			</div>
		</div>
	</div>

	<div style="width: 99.5%;">
		<table class="table table-striped table-hover" id="tbPass">
			<thead>
				<tr>
					<th style="width: 12%" scope="col">지원일자 <button type="button" name="orderPassDateBtn" id="orderPassDateBtn">▼▲</button></th>
					<th style="width: 10%" scope="col">내담자이름</th>
					<th style="width: 10%" scope="col">생년월일</th>
					<th style="width: 10%" scope="col">관계</th>
					<th style="width: 10%" scope="col">방법</th>
					<th style="width: 17%" scope="col">지원구분</th>
					<th style="width:" scope="col">지원요약</th>
					<th style="width: 8%" scope="col">지원담당자</th>
				</tr>
			</thead>
			<tbody id="passTbody">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<fmt:parseNumber integerOnly="true" value="${result.passSeq }" var="passSeq" />
					<tr onclick="fnc_GET_PASS_VIEW('${result.caseSeq}', '${result.passSeq}');" style="cursor: pointer;" id="${passSeq}">
						<td class="tit">${result.passDate} ${result.passTime}</td>
						<td>${result.userName}</td>
						<td>${result.victimBirth }</td>
						<td>${result.userRelGrpNm}</td>
						<td>${result.passWayNm}</td>
						<td style="text-align:left;">
							<c:if test="${not empty result.passTypeNm }">
								${result.passTypeNm}
							</c:if>
							<c:if test="${not empty result.sub1DataNm }">
								> ${result.sub1DataNm}
							</c:if>
							<c:if test="${not empty result.sub2DataNm }">
								> ${result.sub2DataNm}
							</c:if>
						</td>
						<td style="text-align:left;">${result.passMemo}</td>
						<td>${result.passManager}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="8">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<c:if test="${fn:length(resultList) > 0}">
			${pageNav}
		</c:if>
	</div>
</div>
    
<script>
	$('#passText').keyup(function(e) {
		var content = $(this).val();
		$('#bytespassText').html(content.length); //글자수 실시간 카운팅

		if (content.length > 3500) {
			alert("최대 3,500bytes까지 입력 가능합니다.");
			$(this).val(content.substring(0, 3500));
		}
	});

	$('#btnCasePrintDetail').click(function(e) {
		e.preventDefault();
		var thisSeq = $(this).attr("title");
		var passSeq = $(this).attr("value");
		var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq=" + thisSeq + "&passSeq=" + passSeq, "case_print_window", 
			"width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
		});

	$('#btnCasePrint').click(function(e) {
		e.preventDefault();
		var thisSeq = $(this).attr("title");
		var myWindow = window.open("casePrint.do?passPdate=DESC&caseSeq=${result.caseSeq}&thisSeq=" + thisSeq, "case_print_window",
			"width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
	});
</script>