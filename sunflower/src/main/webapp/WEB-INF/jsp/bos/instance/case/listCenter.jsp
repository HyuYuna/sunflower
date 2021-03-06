<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO" />
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />
<fmt:formatDate value="${toDay}" var="today" pattern="yyyy-MM-dd" />
<script>
    /* Korean initialisation for the jQuery calendar extension. */
    /* Written by DaeKwon Kang (ncrash.dk@gmail.com), Edited by Genie. */
    jQuery(function($){
        $.datepicker.regional['ko'] = {
            closeText: '닫기',
            prevText: '이전달',
            nextText: '다음달',
            currentText: '오늘',
            monthNames: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            weekHeader: 'Wk',
            dateFormat: 'yy-mm-dd',
            firstDay: 0,
            isRTL: false,
            showMonthAfterYear: true,
            yearSuffix: '년'};
        $.datepicker.setDefaults($.datepicker.regional['ko']);
    });
</script>

<script>
	$(function() {
		var $ATTKR_REL_OPTION = $('#attkrRel>option').clone();
		
		//피해자와 관계(피해자기준) 하위 선택
	    $("#frm select[name='attkrRelGrp']").change(function() {
	        fnc_SUB_ATTKR_REL();
	    });
		
		fnc_SUB_ATTKR_REL();		//가해자 관계(피해자 기준) 선택시 옵션
		
		//피해자와 관계(피해자기준) 하위 선택시 옵션
		function fnc_SUB_ATTKR_REL(){
			var selectOptionVal = $("#frm select[name='attkrRelGrp']").val();
			var selectOptionSub = $("#frm select[name='attkrRelGrp']").find('option:selected').attr('data-subcode');
			
			if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
				$("#frm select[name='attkrRel']").prop('disabled', true).hide();
			} else {
				$('#attkrRel').html($ATTKR_REL_OPTION);
				$("#frm select[name='attkrRel']").prop('disabled', false).show().find("option").filter(function(index) {
					var dataGrpcde = $(this).attr("data-grpcode")
					if (typeof dataGrpcde != "undefined") {
						if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
					}
				}).remove();
			}
		}
		
		fn_cdChange();

		if("${paramVO.searchOption}" == "open"){
			$('.trExtend').show();
			$('#btnOption').text("검색옵션 축소");
		}
		
		$('#btnDeleteVictimAges').click(function() {
            $('#VICTIM_AGE_FROM').val("");
            $('#VICTIM_AGE_TO').val("");
        });
		
		if ("${paramVO.termType}" != null && "${paramVO.termType}" != "") {
	       $("input:radio[name=termType]:input[value=${paramVO.termType}]").attr("checked",true);
	       setTerm_Type("${paramVO.termType}" );
	    } else {
	    	$("input[name=termType]:input[value=D]").attr("checked", true);
	    	$('#condFrdate').val('${today}');
	        $('#condTodate').val('${today}');
	    	setTerm_Type('D');
	    }

		//사례등록일 초기화
		$('.btnDeleteSearchDateRage').click(function() {
	        init_date();
	        $('#condFrdate').css('border-color', '#333333');
	        $('#condTodate').css('border-color', '#333333');

	        $('#condFrdate').val("").show();
	        $('#condTodate').val("").show();
	        $('#cond_spdate').show();

	        $("#frm input:radio[name='termType']").prop("checked", false);

	    });
		
		$("input[name=termType]").change(function(){
	      setTerm_Type($(this).val());
	    });
		
		$('#smonthM').change( function() {
			setDateByMonth();
	    });
	    $('#searchQuater').change( function() {
	      setDateByQuater();
	    });
	    $('#searchHalf').change( function() {
	      setDateByHalf();
	    });
	    $('#smonthY').change( function() {
			var term_type = $("input[name=termType]:radio:checked").val();
			if (term_type=='M') {
			  setDateByMonth();
			} else if (term_type=='Q') {
			  setDateByQuater();
			} else if (term_type=='H') {
			  setDateByHalf();
			} else if (term_type=='Y') {
			  setDateByYear();
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
		
		$('.week-picker').datepicker( {
	        changeYear:true , changeMonth:true , showWeek: true , firstDay: 1 ,
	      showOtherMonths: true,
	      selectOtherMonths: true,
	      onSelect: function(dateText, inst) {
	        var date = $(this).datepicker('getDate');
	        startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+1);
	        endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()  +7);
	        var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	        $('#condFrdate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
	        $('#condTodate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

	        selectCurrentWeek();
	      },
	      beforeShowDay: function(date) {
	        var cssClass = '';
	        if(date >= startDate && date <= endDate)
	           cssClass = 'ui-datepicker-current-day';
	        return [true, cssClass];
	      },
	      onChangeMonthYear: function(year, month, inst) {
	        selectCurrentWeek();
	      }
	    });
		
		var startDate;
	    var endDate;

	    var selectCurrentWeek = function() {
	      window.setTimeout(function () {
	        $('.week-picker').find('.ui-datepicker-current-day a').addClass('ui-state-active')
	      }, 1);
	    }
	    
	    $('#choiceDate').datepicker( {
	        changeYear:true , changeMonth:true , showWeek: true , firstDay: 1 ,
	        onSelect: function(dateText, inst) {
	          var date = $(this).datepicker('getDate');
	          startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
	          endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
	          var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	          $('#condFrdate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
	          $('#condTodate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

	          selectCurrentWeek();
	        }
	      })
	      .attr("maxlength", "10")
	      .mask('9999-99-99')
	      .css("width", "80px").css("ime-mode", "disabled").css("text-align", "center")
	      .blur(function() {
	        regExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
	        if($(this).val().length==10 && !regExp.test($(this).val())){
	            alert("날짜를 2013-05-18 형식으로 정확히 입력하세요");
	            $(this).val("").focus();
	       }
	    });

	    $('.week-picker').datepicker( {
	        changeYear:true , changeMonth:true , showWeek: true , firstDay: 1 ,
	      showOtherMonths: true,
	      selectOtherMonths: true,
	      onSelect: function(dateText, inst) {
	        var date = $(this).datepicker('getDate');
	        startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+1);
	        endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()  +7);
	        var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
	        $('#condFrdate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
	        $('#condTodate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

	        selectCurrentWeek();
	      },
	      beforeShowDay: function(date) {
	        var cssClass = '';
	        if(date >= startDate && date <= endDate)
	           cssClass = 'ui-datepicker-current-day';
	        return [true, cssClass];
	      },
	      onChangeMonthYear: function(year, month, inst) {
	        selectCurrentWeek();
	      }
	    });

	    $('.btnDeleteSearchDateRage').click(function() {

	        init_date();

	        $('#areaTermSelect').hide();
	        $('#condFrdate').css('border-color', '#333333');
	        $('#condTodate').css('border-color', '#333333');

	        $('#condFrdate').val("").show();
	        $('#condTodate').val("").show();
	        $('#cond_spdate').show();

	        $("#frm input:radio[name='termType']").prop("checked", false);

	    });
	    
	    $('#btnOption').click( function() {
	        $(this).text(function(i, text){
	            return text === "검색옵션 확장" ? doSearchFormOpen() : doSearchFormClose();
	        })
	    });
	    
	    $("#src_CNTR_GBN").on("change", function() {
            setCenterGbnChange();
        });
	    
	    $("#pageSelect").change(function() {
			var pageUnit = $(this).val();
			var frm = $("#frm")[0];
			
			$.ajax({
					url: "/bos/instance/case/pageUnitChange.json",
					type: "get",
					data: {pageUnit : pageUnit},
					success: function(data) {
						$("#pageUnit").val(data.pageUnit);
						
						$("#frm").attr("action", "/bos/instance/case/listCenter.do");
						$("#frm").submit();
					}
			});
		});
		
	    $('#orderCaseDateBtn').on('click',function(){
            var casePdate = document.getElementById("casePdate");
            
            if(casePdate.value == ""){
            	casePdate.value ="ASC";
            }else if(casePdate.value == "ASC"){
            	casePdate.value = "DESC";
            }else if(casePdate.value == "DESC"){
            	casePdate.value = "ASC";
            }else{
            	casePdate.value = "ASC";
            }
            fn_search();
        });
        
        $('#orderCaseUDateBtn').on('click',function(){
            var casePdate = document.getElementById("casePdate");
            
            if(casePdate.value == ""){
            	casePdate.value ="UASC";
            }else if(casePdate.value == "UASC"){
            	casePdate.value = "UDESC";
            }else if(casePdate.value == "UDESC"){
            	casePdate.value = "UASC";
            }else{
            	casePdate.value = "UASC";
            }
            fn_search();
        });
        
        //한영변환-ie
		$('#searchCaseType').change(function(){
			var val = $(this).val();
			
			if(val == "caseNumber"){
				//기본 영어
				$("#searchMasterText").css("ime-mode","inactive")
			}else{
				//기본 한글
				$("#searchMasterText").css("ime-mode","active")
			}
		});
	});
	
	
	
	function init_date() {
        $('#choiceDate').hide();
        $('.week-picker').hide();
        $('#smonthM').hide();
        $('#searchQuater').hide();
        $('#searchHalf').hide();
        $('#smonthY').hide();

        $('#condFrdate').css('border-color', '#FFFFFF');
        $('#condTodate').css('border-color', '#FFFFFF');
    }
	
	function setTerm_Type(term_type) {
        init_date();

        if(term_type=='D') {
            $('#choiceDate').show();
            setDateByDay();

            $('#condFrdate').show();
            $('#condTodate').show();
            $('#cond_spdate').show();

        } else if (term_type=='W') {
            $('.week-picker').show();
            setDateByWeek(); 

            $('#condFrdate').show();
            $('#condTodate').show();
            $('#cond_spdate').show();

        } else if (term_type=='M') {
            $('#smonthY').show();
            $('#smonthM').show();
            setDateByMonth();

            $('#condFrdate').hide();
            $('#condTodate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='Q') {
            $('#smonthY').show();
            $('#searchQuater').show();
            setDateByQuater();

            $('#condFrdate').hide();
            $('#condTodate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='H') {
            $('#smonthY').show();
            $('#searchHalf').show();
            setDateByHalf();

            $('#condFrdate').hide();
            $('#condTodate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='Y') {
            $('#smonthY').show();
            setDateByYear();

            $('#condFrdate').hide();
            $('#condTodate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='T') {
            $('#areaTermSelect').hide();
            $('#condFrdate').css('border-color', '#333333');
            $('#condTodate').css('border-color', '#333333');

            $('#condFrdate').show();
            $('#condTodate').show();
            $('#cond_spdate').show();

        } else if (term_type=='N') {
            $('#condFrdate').val("");
            $('#condTodate').val("");

            $('#condFrdate').hide();
            $('#condTodate').hide();
            $('#cond_spdate').hide();
        }
    }
	
	// 기간구분 선택시 설정
    function setDateByDay() {
    }
	
    function setDateByWeek() {
    }

    function setDateByMonth() {
        var s2Month = ",1896,1904,1908,1912,1916,1920,1924,1928,1932,1936,1940,1944,1948,1952,1956,1960,1964,1968,1972,1976,1980,1984,1988,1992,1996,";
           s2Month+= "2000,2004,2008,2012,2016,2020,2024,2028,2032,2036,2040,2044,2048,2052,2056,2060,2064,2068,2072,2076,2080,2084,2088,2092,2096";
        var eYear = $('#smonthY').val();
        var eMonth = $('#smonthM').val();

        var n=s2Month.indexOf(eYear);
        if (eMonth.length==2) {
          switch (eMonth) {
            case "01" :
            case "03" :
            case "05" :
            case "07" :
            case "08" :
            case "10" :
            case "12" : eDay = "31";
                    break;
            case "02" : if (n>0) {
                      eDay = "29";
                    } else {
                      eDay = "28";
                    }
                    break;
            default	 : eDay = "30";
                    break;
          }

          var sdate = $('#smonthY').val() +"-"+ $('#smonthM').val() +"-01";
          var edate = $('#smonthY').val() +"-"+ $('#smonthM').val() +"-"+ eDay;
          $('#condFrdate').val(sdate);
          $('#condTodate').val(edate);
        }
    }

    function setDateByQuater() {
        var eQuater = $('#searchQuater').val();

        if (eQuater.length==1) {
          switch (eQuater) {
            case "1" : sDay = "01-01";
                    eDay = "03-31";
                    break;
            case "2" : sDay = "04-01";
                    eDay = "06-30";
                    break;
            case "3" : sDay = "07-01";
                    eDay = "09-30";
                    break;
            default	: sDay = "10-01";
                    eDay = "12-31";
                    break;
          }

          var sdate = $('#smonthY').val() +"-"+ sDay;
          var edate = $('#smonthY').val() +"-"+ eDay;
          
          $('#condFrdate').val(sdate);
          $('#condTodate').val(edate);
        }
    }

    function setDateByHalf() {
        var eHalf = $('#searchHalf').val();

        if (eHalf.length==1) {
          switch (eHalf) {
            case "1" : sDay = "01-01";
                    eDay = "06-30";
                    break;
            default	: sDay = "07-01";
                    eDay = "12-31";
                    break;
          }

          var sdate = $('#smonthY').val() +"-"+ sDay;
          var edate = $('#smonthY').val() +"-"+ eDay;
          $('#condFrdate').val(sdate);
          $('#condTodate').val(edate);
        }
    }

    function setDateByYear() {
        var sdate = $('#smonthY').val() +"-01-01";
        var edate = $('#smonthY').val() +"-12-31";
        $('#condFrdate').val(sdate);
        $('#condTodate').val(edate);
    }
	
    function doSearchFormOpen() {
        $('#btnOption').text("검색옵션 축소");
        $('.trExtend').show();
        $('#searchOption').val("open");
//         $.cookie('srcCookieExtende',  'open', { expires: 7, path: '/' });
    }

    function doSearchFormClose() {
        $('#btnOption').text("검색옵션 확장");
        $('.trExtend').hide();
        $('#searchOption').val("close");
//         $.cookie('srcCookieExtende',  'close', { expires: 7, path: '/' });
    }
    
    function fn_DbClick(caseSeq){
    	$("#historyMemo").val("[자동입력] 사례를 조회했습니다");
    	document.frm.action = "/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq="+caseSeq;
		document.frm.submit();
    }
    
    function fn_search(){
    	var _caseType = "";
		$("input[name=caseType]:checked").each(function() {	
			_caseType += $(this).val() + ", ";
		});
		$("#chkCsTypeArr").val(_caseType.substr(0,_caseType.length-2));
    	
		var _chkCaseJupsoo = "";
		$("input[name=chkCaseJupsoo]:checked").each(function() {	
			_chkCaseJupsoo += $(this).val() + ", ";
		});
		$("#chkCsJupsooArr").val(_chkCaseJupsoo.substr(0,_chkCaseJupsoo.length-2));
		
		$("#searchType").val("");
    	document.frm.action = "/bos/instance/case/listCenter.do?menuNo=${param.menuNo}";
		document.frm.submit();
    }
    
    function fn_search2(){
    	if($('#searchMasterText').val()=='') {
            alert('검색어를 입력해주세요');
        } else {
			$("#searchType").val("C");
			document.frm.action = "/bos/instance/case/listCenter.do?menuNo=${param.menuNo}";
			document.frm.submit();
        }
    }
    
    function fn_cdChange() {
    	fn_cdStateChange();
    	fn_cdManagerChange();
	}
    
    function fn_cdStateChange() {
    	var srcState = $("#srcState").val();
    	
    	var centerCodeSub = $("#centerCodeSub").val();
    	if(!centerCodeSub) {
        	centerCodeSub = $("#userCenterCode").val();
    	}
    	
		$.ajax({
			url : "/bos/instance/case/findCaseCenterList.json?srcState=" + srcState +"&centerCodeSub="+centerCodeSub, 
			dataType : "json", 
			async : false
		}).done(
			function(retVal) {
				values = retVal.resultList ;
				$("#srcCslId").empty();
				if(values.length > 0){
					$("#srcCslId").append('<option value="">선택</option>');
					$.each(values, function( index, value ) {
						var selected = "";
						if("${paramVO.srcCslId}" == value.userId ){
							selected = "selected";
						}
						$("#srcCslId").append('<option value="' + value.userId + '" ' +selected+ ' >' + value.userName + '</option>');
					});
				}else{
					$("#srcCslId").append('<option value="">없음</option>');
				}
		});
	}

    function fn_cdManagerChange() {
    	var srcState = $("#caseManagerState").val();
    	
    	var centerCodeSub = $("#centerCodeSub").val();
    	if(!centerCodeSub) {
        	centerCodeSub = $("#userCenterCode").val();
    	}
    	
		$.ajax({
			url : "/bos/instance/case/findCaseCenterList.json?srcState=" + srcState +"&centerCodeSub="+centerCodeSub, 
			dataType : "json", 
			async : false
		}).done(
			function(retVal) {
				values = retVal.resultList ;
				$("#caseManager").empty();
				if(values.length > 0){
					$("#caseManager").append('<option value="">선택</option>');
					$.each(values, function( index, value ) {
						var selected = "";
						if("${paramVO.caseManager}" == value.userId ){
							selected = "selected";
						}
						$("#caseManager").append('<option value="' + value.userId + '" ' +selected+ ' >' + value.userName + '</option>');
					});
				}else{
					$("#caseManager").append('<option value="">없음</option>');
				}
		});
	}
    $(document).keyup(function(event) {
    	  if (event.keyCode == '13') {
    		  fn_search();
    	  }
    });
</script>

<!-- cont -->
<div class="cont">
    <div>
    	<form id="frm" name="frm" class="pure-form" method="post">
    		<input type="hidden" name="menuNo" value="${param.menuNo}"> 
            <input type="hidden" id="smonth1" name="smonth" value="${paramVO.smonth}" />
			<input type="hidden" id="emonth1" name="emonth" value="${paramVO.emonth}" />
			<input type="hidden" id="tody" name="tody" value="${today}" />
			<input type="hidden" id="searchOption" name="searchOption" value="close" />
			<input type="hidden" name="chkCsTypeArr" id="chkCsTypeArr" value="${paramVO.chkCsTypeArr}"/>
			<input type="hidden" name="chkCsJupsooArr" id="chkCsJupsooArr" value="${paramVO.chkCsJupsooArr}"/>
			<input type="hidden" name="userId" value="${userVO.userId}" />
	    	<input type="hidden" name="userNm" value="${userVO.userNm}" />
	    	<input type="hidden" id="historyMemo" name="historyMemo" value="" />
	    	<input type="hidden" id="searchType" name="searchType" value="${param.searchType}" />
			<input type="hidden" name="userCenterCode" id="userCenterCode" value="${userVO.centerCode }"/>
			<input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
			<input type="hidden" name="casePdate" id="casePdate" value="${param.casePdate}">
	    	
	    	<table class="pure-table pure-table-bordered" style="width:100%;">
	    		<colgroup>
                    <col style="width:150px;" />
                    <col style="width:500px;" />
                    <col style="width:130px;" />
                    <col style="width:200px;" />
                </colgroup>
                <tr>
			        <td class="align-center">
			        	<a id="btnOption" class='btn pure-button' style="height:28px;width:95%;">검색옵션 확장</a>
			        </td>
			        <td colspan=3>
		                사례 검색 : <select name="searchCaseType" id="searchCaseType" style="width: 200px;">
					                    <option value="victimName" <c:if test="${paramVO.searchCaseType == 'victimName'}">selected="selected"</c:if>>피해자 이름</option>
                                        <option value="clientName" <c:if test="${paramVO.searchCaseType == 'clientName'}">selected="selected"</c:if>>의뢰인 이름</option>
					                    <option value="caseAlias" <c:if test="${paramVO.searchCaseType == 'caseAlias'}">selected="selected"</c:if>>가명</option>
					                    <option value="victimBirth" <c:if test="${paramVO.searchCaseType == 'victimBirth'}">selected="selected"</c:if>>피해자 생년월일</option>
					                    <option value="victimMemo" <c:if test="${paramVO.searchCaseType == 'victimMemo'}">selected="selected"</c:if>>피해자 세부사항</option>
					                    <option value="attkrMemo" <c:if test="${paramVO.searchCaseType == 'attkrMemo'}">selected="selected"</c:if>>가해자 세부사항</option>
					                    <option value="ccName" <c:if test="${paramVO.searchCaseType == 'ccName'}">selected="selected"</c:if>>연락처 이름 및 번호</option>
					                    <option value="userName" <c:if test="${paramVO.searchCaseType == 'userName'}">selected="selected"</c:if>>내담자 이름</option>
										<c:if test="${userVO.authorCd == 'CA'}">
					                    <option value="caseNumber" <c:if test="${paramVO.searchCaseType == 'caseNumber'}">selected="selected"</c:if>>전산관리번호</option>
										</c:if>
										<c:if test="${userVO.authorCd != 'CA'}">
					                    <option value="caseNumber" <c:if test="${paramVO.searchCaseType == 'caseNumber'}">selected="selected"</c:if>>사례번호</option>
										</c:if>
					                </select>
		                <input type="text" name="searchMasterText" id="searchMasterText" value="${paramVO.searchMasterText}" style="ime-mode:active;">
						<input type="button" id="btnSearchCase" name="btnSearchCase" value="검색" class='btn pure-button' style="height:30px;width:60px;" onclick="fn_search()"/>
		                <!-- <span style="color:orange;">검색시 아래의 조건은 무시합니다 </span>
		                <a href="/static/bos/image/help.png" onclick="window.open(this.href, '팝업창', 'width=752, height=631, resizable=no'); return false;"><b style="color:orange;">(상세내용보기)</b></a> -->
			        </td>
			    </tr>
                <tr>
                	<td class="align-center">날짜 검색 기준</td>
                	<td colspan="3">
                	    <input type="radio" name="searchDateType" id="searchDateTypeCD" value="caseDate" ${paramVO.searchDateType eq 'caseDate' ? 'checked' : '' }/>
                        <label for="searchDateTypeCD" class="pr10">접수일</label>
                		<input type="radio" name="searchDateType" id="searchDateTypeCU" value="caseUdate" ${paramVO.searchDateType eq 'caseUdate' ? 'checked' : '' }/>
                		<label for="searchDateTypeCU" class="pr10">등록(수정)일 </label>
                	</td>
                </tr>
			    <tr>
					<td class="align-center">사례등록일
					    <img class="btnDeleteSearchDateRage" src='/static/bos/image/cross-th.png'  alt="초기화">
					</td>
					<td colspan="3">
<!-- 				        <select id="searchYear" name="searchYear"> -->
						<select name="smonthY" id="smonthY" title="검색 년도">
							<c:forEach begin="0" end="${yearToday - 99 }" var="year"  varStatus="status" >
								<option value="${yearToday - year }" <c:if test="${(yearToday - year) eq paramVO.smonthY}">selected="selected"</c:if>>${yearToday - year }년</option>
							</c:forEach>
						</select>
				        <select id="searchHalf" name="searchHalf">
				            <!--
				            <option>반기선택</option>
				            -->
				            <option value='1' <c:if test="${paramVO.searchHalf eq '1'}">selected="selected"</c:if>>전반기</option>
				            <option value='2' <c:if test="${paramVO.searchHalf eq '2'}">selected="selected"</c:if>>후반기</option>
				        </select>
				        <select id="searchQuater" name="searchQuater">
				            <!--
				            <option>분기선택</option>
				            -->
				            <option value='1' <c:if test="${paramVO.searchQuater eq '1'}">selected="selected"</c:if>>1 분기</option>
				            <option value='2' <c:if test="${paramVO.searchQuater eq '2'}">selected="selected"</c:if>>2 분기</option>
				            <option value='3' <c:if test="${paramVO.searchQuater eq '3'}">selected="selected"</c:if>>3 분기</option>
				            <option value='4' <c:if test="${paramVO.searchQuater eq '4'}">selected="selected"</c:if>>4 분기</option>
				        </select>
<!-- 				        <select id="searchMonth" name="searchMonth"> -->
				        <select name="smonthM" id="smonthM" title="검색 월">
							<c:forEach begin="1" end="12" var="month"  varStatus="status" >
								<option value="<util:fz source='${month}' resultLen='2' isFront='true' />" <c:if test="${month eq paramVO.smonthM}">selected="selected"</c:if>>${month}월</option>
							</c:forEach>
						</select>
				
				        <input type="text" name="condFrdate" id="condFrdate" class="formatDate" value="${paramVO.condFrdate}" />
				        <span id="cond_spdate"> ~ </span>
				        <input type="text" name="condTodate" id="condTodate" class="formatDate" value="${paramVO.condTodate}" />
				
				        &nbsp;&nbsp;&nbsp;
				        <input type="radio" class="check" name="termType" value="N" /><label for="type6" class="pr10">전체</label>
				        <input type="radio" class="check" name="termType" value="Y" /><label for="type6" class="pr10">년간</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="H" /><label for="type5" class="pr10">반기</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="Q" /><label for="type4" class="pr10">분기</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="M" /><label for="type3" class="pr10">월간</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="W" /><label for="type2" class="pr10">주간</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="D" /><label for="type1" class="pr10">일간</label>&nbsp;
				        <input type="radio" class="check" name="termType" value="T" /><label for="type7" class="pr10">직접입력</label>
				
				        <div>
				            <div id="choiceDate"></div>
				            <div class="week-picker"></div>
				        </div>
					</td>
				</tr>
				<c:if test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}">
				<tr>
				    <td class="align-center">센터 구분</td>
				    <td colspan=3>
				    	<select name="centerCode" id="centerCode" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','centerCodeSub',this.value , '', 'N')">
							<script>
								getCmmnCd.select('CM04', 'centerCode', '${paramVO.centerCode}', 'N');
							</script>
						</select>
						<select name="centerCodeSub" id="centerCodeSub" title="센터 구분 서브" onchange="fn_cdChange();" >
							<script>
								getCmmnCd.subSelect('CM05','centerCodeSub','${paramVO.centerCode}', '${paramVO.centerCodeSub}', 'N')
							</script>
						</select>
		                <span style="color:green;padding-left:20px;">(참고:한국여성인권진흥원 권한에서만 나타나는 메뉴입니다)</span>
		                <br/>
		                <div id="selectCenterCodeDiv" style="display: none;">
	<%-- 	                <%=strCntrCodeCheckBox%> --%>
							<script>
								getCmmnCd.checkBox('CM05', 'selectCenterCodeDiv', 'selectCenterCode', '${paramVO.selectCenterCode}', '4');
							</script>
		                </div>
				    </td>
				</tr>
				</c:if>
                <c:if test="${userVO.authorCd != 'CA' && userVO.authorCd != 'CU' && userVO.authorCd != 'ROLE_SUPER'}">
                    <tr>
                        <td class="align-center">센터 구분</td>
                        <td colspan=4>
                            <select name="centerCodeSub" id="centerCodeSub" title="센터 구분 서브" onchange="fn_cdChange();">
					<c:if test="${not empty userInfo.centerCode}">
						<option value="${userInfo.centerCode}" <c:if test="${paramVO.centerCodeSub == userInfo.centerCode}">selected="selected"</c:if>>${userInfo.centerName}</option>
					</c:if>                                
					<c:if test="${not empty userInfo.centerCode2}">
						<option value="${userInfo.centerCode2}" <c:if test="${paramVO.centerCodeSub == userInfo.centerCode2}">selected="selected"</c:if> >${userInfo.centerName2}</option>
					</c:if>                                
					<c:if test="${not empty userInfo.centerCode3}">
						<option value="${userInfo.centerCode3}" <c:if test="${paramVO.centerCodeSub == userInfo.centerCode3}">selected="selected"</c:if> >${userInfo.centerName3}</option>
					</c:if>                                
                            </select>
                        </td>
                    </tr>                        
                </c:if>				
				<tr>
				    <td class="align-center">피해 구분</td>
				    <td colspan=3>
			            <div id="div_caseType">
			            	<input type='checkbox' name='caseType_all' value='Y' id='caseType_all' ${paramVO.chkCsTypeArr eq '01, 02, 03, 11' ? 'checked' : '' }/>  
							<label for='caseType_all' style="padding-right:20px;"><b style="color: orange;">전체선택</b></label>
							<script>
								getCmmnCd.checkBoxStats('CSAB', 'div_caseType', 'caseType', '${paramVO.chkCsTypeArr}');
							</script>
						</div>
				    </td>
				</tr>
<script>
/*******************************************************
 * 체크박스 전체 선택
 */
$("#caseType_all").click(function(){
  setCheckBoxAllSelect9(this, "caseType");
});
$("input[name=caseType]").click(function(){
  setCheckBoxAllLease9("caseType_all");
});
/*******************************************************/

</script>
				 <tr>
				     <td class="align-center">사례접수 방법</td>
				     <td>
				     	<div id="div_chkCaseJupsoo">
				    	 	<input type='checkbox' name='chkCaseJupsoo_all' value='Y' id='chkCaseJupsoo_all' ${paramVO.chkCsJupsooArr eq '1, 2, 4, 3, 5' ? 'checked' : '' }/>  
							<label for='chkCaseJupsoo_all' style="padding-right:20px;"><b style="color: orange;">전체선택</b></label>
							<script>
								getCmmnCd.checkBoxStats('CS20', 'div_chkCaseJupsoo', 'chkCaseJupsoo', '${paramVO.chkCsJupsooArr}');
							</script>
						</div>
				     </td>
<script>
/*******************************************************
 * 체크박스 전체 선택
 */
 $("#chkCaseJupsoo_all").click(function(){
   setCheckBoxAllSelect9(this, "chkCaseJupsoo");
 });
 $("input[name=chkCaseJupsoo]").click(function(){
   setCheckBoxAllLease9("chkCaseJupsoo_all");
 });
 /*******************************************************/
</script>
				     <td class="align-center">접수 담당자</td>
				     <td>
						<select id="srcState" name="srcState" onchange="fn_cdStateChange();" >
					        <option value="Y" <c:if test="${paramVO.srcState == 'Y'}">selected="selected"</c:if>>재직자</option>
					        <option value="S" <c:if test="${paramVO.srcState == 'S'}">selected="selected"</c:if>>휴직자</option>
					        <option value="N" <c:if test="${paramVO.srcState == 'N'}">selected="selected"</c:if>>퇴직자</option>
					    </select>
				        <select id='srcCslId' name='srcCslId' >
					        <option value=''>선택</option>
				        </select>
				     </td>
				 </tr>
			    <tr class="trExtend" style="display: none;">
			        <td  class="align-center">피해자 특성</td>
			        <td>
			            <span style="display:inline-block; width:140px;">
			                <select id="victimFrger" name="victimFrger" style="width:120px;">
			                    <option value="">내외국인 전체</option>
			                    <option value="N" <c:if test="${paramVO.victimFrger == 'N'}">selected="selected"</c:if>>내국인</option>
			                    <option value="Y" <c:if test="${paramVO.victimFrger	 == 'Y'}">selected="selected"</c:if>>외국인</option>
			                </select>
			            </span>
			
			            <span style="display:inline-block; width:180px;">
			                연령:
			                <input type="text" id="victimAgeFrom" name="victimAgeFrom" style="width:40px;" class='onlyNumber' value='${paramVO.victimAgeFrom}'>
			                ~
			                <input type="text" id="victimAgeTo" name="victimAgeTo" style="width:40px;" class='onlyNumber' value='${paramVO.victimAgeTo}'>
			                <img id="btnDeleteVictimAges" src='/static/bos/image/cross-th.png' style="width:10px; height:10px;">
			            </span>
			
			            <span style="display:inline-block; width:120px;">
			                장애여부 : <input type="checkbox" id="victimDisable" name="victimDisable" value="Y" <c:if test="${paramVO.victimDisable == 'Y'}">checked</c:if> />
			            </span>
			        </td>
			        <td class="align-center">피해자 거주지역</td>
			        <td>
			        	<select name="victimArea" id="victimArea" title="거주지" onchange="getCmmnCd.subSelect('HM47','victimAreaSub',this.value , '', 'N')">
							<script>
								getCmmnCd.select('HM46', 'victimArea', '${paramVO.victimArea}', 'N');
							</script>
						</select>
			        </td>
			    </tr>
			    <tr class="trExtend" style="display: none;">
			        <td  class="align-center">가해자 특성</td>
			        <td>
			            <span style="display:inline-block; width:140px;">
			                <select id="attkrFrger" name="attkrFrger" style="width:120px;">
			                  <option value="">내외국인:: 전체</option>
			                  <option value="N" <c:if test="${paramVO.attkrFrger == 'N'}">selected="selected"</c:if>>내국인</option>
			                  <option value="Y" <c:if test="${paramVO.attkrFrger == 'Y'}">selected="selected"</c:if>>외국인</option>
			                </select>
			            </span>
			
			            <span style="display:inline-block; width:180px;">
			                연령: 
			                <select name="attkrAge" id="attkrAge" title="연령" >
								<script>
									getCmmnCd.select('ATAG', 'attkrAge', '${paramVO.attkrAge}', 'N');
								</script>
							</select>
			            </span>
			
			            <span style="display:inline-block; width:120px;">
			                장애여부 :
			                <input type="checkbox" id="attkrDisable" name="attkrDisable" value="Y" <c:if test="${paramVO.attkrDisable == 'Y'}">checked</c:if>  />
			            </span>
			        </td>
			        <td class="align-center">가해자 피해자 관계</td>
			        <td>
			        	<select name="attkrRelGrp" id="attkrRelGrp" title="피해자와의 관계" style="width: 100px">
							<script>
								getCmmnCd.select('CZ01G', 'attkrRelGrp', '${paramVO.attkrRelGrp}', 'N');
							</script>
						</select>
						<select name="attkrRel" id="attkrRel" title="피해자와의 관계 서브" style="width: 100px">
							<script>
								getCmmnCd.select('CZ01', 'attkrRel', '${paramVO.attkrRel}','N');
							</script>
						</select>
			        </td>
			    </tr>
                <tr>
                    <td colspan=4>
                    	<input type="button" id="input2" name="input2" value="검색" class='pure-button btnSearch' style="height:30px;width:100%;" onclick="fn_search()"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

	<br/>
	<div style="float:left;">결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</div>
	<div style="float:right;">
	<!--
	<input type="submit" id="btnInsertCase" class="pure-button btnSave" value="사례 신규입력">
	-->
	<div style="float:right;">
		<p>
			<select id="pageSelect" name="pageSelect">
				<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
				<option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
				<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
				<option value="0" ${paramVO.pageUnit eq '999999' ? 'selected' : '' }>전체</option>
			</select>
		</p>
	</div>
	</div>
	
	
	<div style="clear:both; width:100%;">
		<table class="table table-striped table-hover" id="tbCase">
		<caption>사례 목록</caption>
			<thead>
				<tr>
					<th style="width:" scope="col">전산관리번호</th>
					<th style="width:11%" scope="col">사례접수일 <button type="button" name="orderCaseDateBtn" id="orderCaseDateBtn">▼▲</button></th>
					<th style="width:8%" scope="col">사례구분</th>
					<th style="width:5%" scope="col">사례접수</th>
					<th style="width:8%" scope="col">피해자명</th>
					<th style="width:5%" scope="col">피해자<br/>성별</th>
					<th style="width:8%" scope="col">생년월일</th>
					<th style="width:5%" scope="col">피해자<br/>나이</th>
					<th style="width:12%" scope="col">피해자주소</th>
					<th style="width:7%" scope="col">접수담당자</th>
					<th style="width:7%" scope="col">사례담당자</th>
					<th style="width:11%" scope="col">사례수정일 <button type="button" name="orderCaseUDateBtn" id="orderCaseUDateBtn">▼▲</button></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr style="cursor: pointer;" id="trCase" ondblclick="fn_DbClick('${result.caseSeq}');">
						<td class="tit">
							${result.caseNumber}
						</td>
						<td>${result.caseDate}</td>
						<td>${result.caseTypeNm}</td>
						<td>${result.caseJupsooNm}</td>
						<td>${result.victimName}</td>
						<td>
							<c:choose>
								<c:when test="${result.victimSex == 'M'}" >남자</c:when>
								<c:when test="${result.victimSex == 'F'}" >여자</c:when>
								<c:otherwise>
									알수없음
								</c:otherwise>
							</c:choose>
						</td>
						<td>${result.victimBirth}</td>
						<td>
							<c:if test="${result.victimAge eq 199}">알수없음</c:if> 
							<c:if test="${result.victimAge ne 199}">
								<fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>
							</c:if>
						</td>
						<td>${result.victimAreaNm} ${result.victimAreaSubNm }</td>
						<td>${result.memberName}</td>
						<td>${result.caseManagerNm}</td>
						<td><fmt:formatDate value="${result.caseUdate}" pattern="yyyy-MM-dd"/></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
					    <td colspan="11">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<c:if test="${fn:length(resultList) > 0}">
		${pageNav}
	</c:if>

