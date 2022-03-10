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
        fn_cdChange();

        if ("${paramVO.termType}" != null && "${paramVO.termType}" != "") {
           $("input:radio[name=termType]:input[value=${paramVO.termType}]").attr("checked",true);
           setTerm_Type("${paramVO.termType}" );
        } else {
            $("input[name=termType]:input[value=N]").attr("checked", true);
            $('#condFrdate').val('${today}');
            $('#condTodate').val('${today}');
            setTerm_Type('N');
        }
        if ("${paramVO.dateType}" != null && "${paramVO.dateType}" != "") {
            $("input:radio[name=dateType]:input[value=${paramVO.dateType}]").attr("checked",true);
        }else{
            $("input[name=dateType]:input[value=PASS]").attr("checked", true);
        }
        
        $('#orderPassDateBtn').on('click',function(){
            var casePdate = document.getElementById("passPdate");
            var passUdate = document.getElementById("passUdate");

            if(casePdate.value == ""){
                casePdate.value ="ASC";
            }else if(casePdate.value == "ASC"){
                casePdate.value = "DESC";
            }else if(casePdate.value == "DESC"){
                casePdate.value = "ASC";
            }else{
                casePdate.value = "ASC";
            }
            passUdate.value = "";

            fn_search();
        });
        $('#orderPassUDateBtn').on('click',function(){
            var casePdate = document.getElementById("passPdate");
            var passUdate = document.getElementById("passUdate");
            
            if(passUdate.value == ""){
                passUdate.value ="ASC";
            }else if(passUdate.value == "ASC"){
                passUdate.value = "DESC";
            }else if(passUdate.value == "DESC"){
                passUdate.value = "ASC";
            }else{
                passUdate.value = "ASC";
            }
            casePdate.value = "";

            fn_search();
        });

        //기간 선택 초기화
        $('.btnDeleteSearchDateRage').click(function() {
            init_date();
            $('#condFrdate').css('border-color', '#333333');
            $('#condTodate').css('border-color', '#333333');

            $('#condFrdate').val("").show();
            $('#condTodate').val("").show();
            $('#cond_spdate').show();

            $("#frm input:radio[name='termType']").prop("checked", false);
            $("#frm input:radio[name='dateType']").prop("checked", false);
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
            $("#frm input:radio[name='dateType']").prop("checked", false);

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
                        
                        $("#frm").attr("action", "/bos/instance/case/listPass.do");
                        frm.submit();
                    }
            });
        });
	      
      //페이지 로딩시 기본 정보값 로드
      var $SUB1_DATA_OPTION = $('#shSub1Data>option').clone();
      var $SUB2_DATA_OPTION = $('#shSub2Data>option').clone();
       
      //지원구분1 변경시
      $('#shPassType').on('change', function() {
      	fnc_SUB_PASS_TYPE();
      });
       
      //지원구분2 변경시
      $('#shSub1Data').on('change', function() {
      	fnc_SUB_SUB1_DATA();
      });
       
      function fnc_SUB_PASS_TYPE() {
      	var selectOptionVal = $("#frm select[name='shPassType']").val();
      	var selectOptionSub = $("#frm select[name='shPassType']").find('option:selected').attr('data-subcode');
      	if (selectOptionSub == '' || selectOptionSub == null) {
      		$("#frm select[name='shSub1Data']").prop('disabled', true).hide();
      		$("#frm select[name='shSub2Data']").prop('disabled', true).hide();
      	} else {
      		$('#shSub1Data').html($SUB1_DATA_OPTION);

      		$("#frm select[name='shSub1Data']").prop('disabled', false).show().find("option").filter(function(index) {
      			var dataGrpcde = $(this).attr("data-grpcode")
      			if (typeof dataGrpcde != "undefined") {
      				if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
      			}
      		}).remove();

      		/* $("#frm select[name='shSub1Data']").prepend("<option value=''>그룹 선택</option>");
      		$("#frm select[name='shSub1Data'] option:eq(0)").attr("selected", "selected"); */

      		setTimeout(function(){
      			fnc_SUB_SUB1_DATA();
      		}, 500);
      	}
      }

      function fnc_SUB_SUB1_DATA() {
      	var selectOptionVal = $("#frm select[name='shSub1Data']").val();
      	var selectOptionSub = $("#frm select[name='shSub1Data']").find('option:selected').attr('data-subcode');
      	if (selectOptionSub == '' || selectOptionSub == null) {
      		$("#frm select[name='shSub2Data']").prop('disabled', true).hide();
      	} else {
      		$('#shSub2Data').html($SUB2_DATA_OPTION);

      		$("#frm select[name='shSub2Data']").prop('disabled', false).show().find("option").filter(function(index) {
      			var dataGrpcde = $(this).attr("data-grpcode")
      			if (typeof dataGrpcde != "undefined") {
      				if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
      			}
      		}).remove();

      		/* $("#frm select[name='shSub2Data']").prepend("<option value=''>그룹 선택</option>");
      		$("#frm select[name='shSub2Data'] option:eq(0)").attr("selected", "selected"); */
      	}
      }

      fnc_SUB_PASS_TYPE();
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
            default  : eDay = "30";
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
            default : sDay = "10-01";
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
            default : sDay = "07-01";
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
    
    
    function fn_DbClick(caseSeq, passSeq){
        $("#historyMemo").val("[자동입력] 사례를 조회했습니다");
        $("#pageUnit").val("");
        $("#srcCslId").val("");
        $("#shPassType").val("");
        $("#shSub1Data").val("");
        $("#shSub2Data").val("");
        document.frm.action = "/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq="+caseSeq+"&passSeq="+passSeq;
        document.frm.submit();
    }
    
    function fn_search(){
    	//이관기준일 전체또는 범위
    	//이관전센터코드
    	//이관후센터코드
    	
/*         var _chkPassWay = "";
        var _chkPassType = "";
        var _caseType = "";
		$("input[name=caseType]:checked").each(function() {	
			_caseType += $(this).val() + ", ";
		});
        $("input[name=chkPassWay]:checked").each(function() {   
            _chkPassWay += $(this).val() + ", ";
        });
        $("input[name=chkPassType]:checked").each(function() { 
            _chkPassType += $(this).val() + ", ";
        });

		$("#chkCsTypeArr").val(_caseType.substr(0,_caseType.length-2));
        $("#chkPassWayArr2").val(_chkPassWay.substr(0,_chkPassWay.length-2));
        $("#chkPassTypeArr2").val(_chkPassType.substr(0,_chkPassType.length-2)); */

        document.frm.action = "/bos/instance/case/listCaseTrans.do?menuNo=${param.menuNo}";
        document.frm.submit();
    }
    
    function fn_cdChange() {
    	fn_cdStateChange();
    }
    
    function fn_cdStateChange() {
        var srcState = $("#srcState").val();
        var centerCodeSub = $("#centerCodeSub").val();
        if(!centerCodeSub) {
            centerCodeSub = $("#userCenterCode").val();
        }
        
        var centerCode = $("#centerCode").val();
        
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

</script>

<!-- cont -->
<div class="cont">
    <div>
        <form id="frm" name="frm" class="pure-form" method="post">
            <input type="hidden" name="menuNo" value="${param.menuNo}"> 
            <input type="hidden" name="searchMasterText" value="">
            <input type="hidden" id="smonth1" name="smonth" value="${paramVO.smonth}" />
            <input type="hidden" id="emonth1" name="emonth" value="${paramVO.emonth}" />
            <input type="hidden" id="tody" name="tody" value="${today}" />
            <input type="hidden" name="chkPassWayArr2" id="chkPassWayArr2" value="${paramVO.chkPassWayArr2}"/>
            <input type="hidden" name="chkPassTypeArr2" id="chkPassTypeArr2" value="${paramVO.chkPassTypeArr2}"/>
            <input type="hidden" name="chkCsTypeArr" id="chkCsTypeArr" value="${paramVO.chkCsTypeArr}"/>
            <%-- <input type="hidden" name="centerCode" id="centerCode" value="${paramVO.centerCode}"/>
            <input type="hidden" name="centerCodeSub" id="centerCodeSub" value="${paramVO.centerCode}"/> --%>
            <input type="hidden" name="userId" value="${userVO.userId}" />
            <input type="hidden" name="userNm" value="${userVO.userNm}" />
            <input type="hidden" id="historyMemo" name="historyMemo" value="" />
            <input type="hidden" name="userCenterCode" id="userCenterCode" value="${userVO.centerCode }"/>
            <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
            <input type="hidden" name="passPdate" id="passPdate" value="${param.passPdate}">
            <input type="hidden" name="passUdate" id="passUdate" value="${param.passUdate}">
<span style="color:green;padding-left:20px;">※ 사례이관은 센터간 일괄 이관만 가능합니다.</span>            
            <table class="pure-table pure-table-bordered" style="width:100%;">
                <colgroup>
                    <col style="width:150px;" />
                    <col style="width:300px;" />
                    <col style="width:150px;" />
                    <col style="width:300px;" />
                </colgroup>
<!--                 <tr>
                    <td class="align-center">검색 조건</td>
                    <td colspan="3">
                        <input type="radio" class="check" name="dateType" value="PASS" />지원일자
                        <input type="radio" class="check" name="dateType" value="UPDATE" />등록(수정)일자
                    </td>
                </tr> -->
                <tr>
                    <td class="align-center">이관 기준일
                        <img class="btnDeleteSearchDateRage" src='/static/bos/image/cross-th.png'  alt="초기화">
                    </td>
                    <td colspan="3">
<!--                        <select id="searchYear" name="searchYear"> -->
                        <select name="smonthY" id="smonthY" title="검색 년도">
                            <c:forEach begin="0" end="${yearToday - 2000 }" var="year"  varStatus="status" >
                                <option value="${yearToday - year }" <c:if test="${(yearToday - year) eq paramVO.smonthY}">selected="selected"</c:if>>${yearToday - year } 년</option>
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
<!--                        <select id="searchMonth" name="searchMonth"> -->
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
<!--                         <input type="radio" class="check" name="termType" value="Y" /><label for="type6" class="pr10">년간</label>&nbsp;
                        <input type="radio" class="check" name="termType" value="H" /><label for="type5" class="pr10">반기</label>&nbsp;
                        <input type="radio" class="check" name="termType" value="Q" /><label for="type4" class="pr10">분기</label>&nbsp;
                        <input type="radio" class="check" name="termType" value="M" /><label for="type3" class="pr10">월간</label>&nbsp;
                        <input type="radio" class="check" name="termType" value="W" /><label for="type2" class="pr10">주간</label>&nbsp;
                        <input type="radio" class="check" name="termType" value="D" /><label for="type1" class="pr10">일간</label>&nbsp; -->
                        <input type="radio" class="check" name="termType" value="T" /><label for="type7" class="pr10">직접입력</label>
                        <div>
                            <div id="choiceDate"></div>
                            <div class="week-picker"></div>
                        </div>
                    </td>
                </tr>
            <%-- <c:if test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}"> --%>
            <tr>
                <td class="align-center">이관전 센터</td>
                <td>
                    <select name="centerCode" id="centerCode" title="센터 구분" onchange="getCmmnCd.subSelectAll('CM05','centerCodeSub',this.value , '', 'N')">
                        <script>
                            getCmmnCd.select('CM04', 'centerCode', '${paramVO.centerCode}', 'N');
                        </script>
                    </select>
                    <select name="centerCodeSub" id="centerCodeSub" title="센터 구분 서브">
                        <script>
                            //getCmmnCd.subSelect('CM05','centerCodeSub','${paramVO.centerCode}', '${paramVO.centerCodeSub}', 'N')
                            getCmmnCd.subSelectAll('CM05','centerCodeSub','${paramVO.centerCode}', '${paramVO.centerCodeSub}', 'N')
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
				<td class="align-center">이관후 센터</td>                
                <td>
                    <select name="centerCodeAfter" id="centerCodeAfter" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','centerCodeAfterSub',this.value , '', 'N')">
                        <script>
                            getCmmnCd.select('CM04', 'centerCodeAfter', '${paramVO.centerCodeAfter}', 'N');
                        </script>
                    </select>
                    <select name="centerCodeAfterSub" id="centerCodeAfterSub" title="센터 구분 서브">
                        <script>
                            getCmmnCd.subSelect('CM05','centerCodeAfterSub','${paramVO.centerCodeAfter}', '${paramVO.centerCodeAfterSub}', 'N')
                        </script>
                    </select>
                </td>
            </tr>
           <%--  </c:if> --%>
<%-- 				<tr>
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
				</tr> --%>
<script>
/*******************************************************
 * 체크박스 전체 선택
 */
/* $("#caseType_all").click(function(){
  setCheckBoxAllSelect9(this, "caseType");
});
$("input[name=caseType]").click(function(){
  setCheckBoxAllLease9("caseType_all");
}); */
/*******************************************************/

</script>
<%--                  <tr>
                     <td class="align-center">지원 방법</td>
                     <td>
                        <div id="div_chkPassWay">
                            <input type='checkbox' name='chkPassWay_all' value='Y' id='chkPassWay_all' ${paramVO.chkPassWayArr2 eq '1, 2, 4, 3, 8, 5' ? 'checked' : '' }/>  
                            <label for='chkPassWay_all' style="padding-right:20px;"><b style="color: orange;">전체선택</b></label>
                            <script>
                                getCmmnCd.checkBoxStats('CS21', 'div_chkPassWay', 'chkPassWay', '${paramVO.chkPassWayArr2}');
                            </script>
                        </div>
                     </td> --%>
<script>
/*******************************************************
 * 체크박스 전체 선택
 */
/*  $("#chkPassWay_all").click(function(){
   setCheckBoxAllSelect9(this, "chkPassWay");
 });
 $("input[name=chkPassWay]").click(function(){
   setCheckBoxAllLease9("chkPassWay_all");
 }); */
 /*******************************************************/
</script>
<%--                      <td class="align-center">지원 담당자</td>
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
                 <tr>
                    <td class="align-center">지원구분</td>
                    <td colspan="3">
                        <select name="shPassType" id="shPassType" title="지원구분">
                            <script>
                                getCmmnCd.select('PSA1', 'shPassType', '${paramVO.shPassType}', 'N');
                            </script>
                        </select>
                        <select name="shSub1Data" id="shSub1Data" title="지원세부구분1">
                            <script>
                                getCmmnCd.select('PSA2', 'shSub1Data', '${paramVO.shSub1Data}', 'N');
                            </script>
                        </select>&nbsp;
                        <select name="shSub2Data" id="shSub2Data" title="지원세부구분2" >
                            <script>
                                getCmmnCd.select('PSA3', 'shSub2Data', '${paramVO.shSub2Data}', 'N');
                            </script>
                        </select>&nbsp;
                    </td>
                </tr> --%>
<script>
/*******************************************************
 * 체크박스 전체 선택
 */
/* $("#chkPassType_all").click(function(){
	setCheckBoxAllSelect9(this, "chkPassType");
});
$("input[name=chkPassType]").click(function(){
	setCheckBoxAllLease9("chkPassType_all");
}); */
/*******************************************************/
</script>
                <tr>
                    <td colspan=4>
                        <input type="button" id="input2" name="input2" value="검색" class='pure-button btnSearch' style="height:30px;width:100%;" onclick="fn_search()"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

    <div class="board_top mt20">
        <div style="float:left;">결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</div>
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
        <caption>지원서비스 목록</caption>
            <thead>
                <tr>
                    <th style="width: 5%" scope="col">No</th>
                    <th style="width: 8%" scope="col">이관 기준일</th>
                    <th style="width: 25%" scope="col">이관전 센터</th>
                    <th style="width: 25%" scope="col">이관후 센터</th>
                    <th style="width: 10%" scope="col">이관건수(사례)</th>
                    <th style="width: 10%" scope="col">이관건수(서비스)</th>
                    <th style="width: 10%" scope="col">담당자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                	<fmt:parseNumber integerOnly="true" value="${result.rowNum }" var="passSeq"/>
                    <tr style="cursor: pointer;" id="trCase" ondblclick="fn_DbClick('${result.caseSeq}', '${passSeq}');">
                        <td>${result.rowNum}</td>
                        <td>${result.tranStdrDate}</td>
                        <td>${result.transBeforeCenterName}</td>
                        <td>${result.transAfterCenterName}</td>
                        <td>${result.countCase}</td>
                        <td>${result.countPass}</td>
                        <td>${result.transUserNm}</td>
                    </tr>
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
                    <tr>
                        <td colspan="10">데이터가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
		<div class="btnGroup">
			<c:choose>
				<c:when test="${empty result}">
					<!-- <a class="pure-button btnSave" href="javascript:regCaseTrans();" id="btnCaseSave"><span>이관등록</span></a> -->
					<a class="pure-button btnList" href="/bos/instance/case/caseTransReg.do?menuNo=${param.menuNo}"><span>이관등록</span></a>
				</c:when>
<%-- 				<c:otherwise>
					<a class="pure-button btnUpdate" href="javascript:checkForm();" id="btnCaseCancel"><span>수정</span></a>
					<a class="pure-button btnList" href="/bos/instance/case/view.do?${pageQueryString}"><span>취소</span></a>
				</c:otherwise> --%>
			</c:choose>
			<%-- <a class="pure-button btnList" href="/bos/instance/case/list.do?menuNo=${param.menuNo}"><span>리스트</span></a> --%>
		</div>        
    </div>
    <c:if test="${fn:length(resultList) > 0}">
        ${pageNav}
    </c:if>