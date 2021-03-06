<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO" />
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />
<fmt:formatDate value="${toDay}" var="today" pattern="yyyy-MM-dd" />
<script src="/static/jslibrary/twbs-pagination-1.4.1/jquery.twbsPagination.js"></script>
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
        
        passList(); 
//      if("${resultPassCnt}" < 1) {
//          $('#txtPassName').text('');
//          $('#txtPassNo').text('');
//          $("#txtTotalRecordCountSub").text(''); 
//      }
        
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
        
//      $("#centerCode").on("change", function() {
//          setCenterGbnChange();
//      });
        
//      $('#centerCode').append("<option value='XXX'>특정센터선택</option>");
    
        $("#pageSelect").change(function() {
            var pageUnit = $(this).val();
            var frm = $("#frm")[0];
            
            $.ajax({
                url: "/bos/instance/case/pageUnitChange.json",
                type: "get",
                data: {pageUnit : pageUnit},
                success: function(data) {
                    $("#pageUnit").val(data.pageUnit);
                    
                    $("#frm").attr("action", "/bos/instance/case/list.do");
                    $("#frm").submit();
                }
            });
        });
        
        $("#pageSelect2").change(function() {
            var pageUnit = $(this).val();
            $("#pageUnit2").val(pageUnit);
            
            $('.paginationSet a').attr("href", function(index, old) {
                if(old.indexOf()){
                    return old.replace("pageUnit2=${paramVO.pageUnit2}", "pageUnit2=" + pageUnit);
                }
            })
            
            fn_createTable($('#caseSeqH').val(), $('#passPdate').val(), $('#passUdate').val(), $('#caseNumberH').val(), $('#victimNameH').val());
        });
        
        //사례접수일 정렬
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
        
        //사례등록일 정렬
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
        
        //지원일시 정렬
        $('#orderPassDateBtn').on('click',function(){
            var passPdate = document.getElementById("passPdate");
            var passUdate = document.getElementById("passUdate");
            
            if(passPdate.value == ""){
                passPdate.value ="ASC";
            }else if(passPdate.value == "ASC"){
                passPdate.value = "DESC";
            }else if(passPdate.value == "DESC"){
                passPdate.value = "ASC";
            }else{
                passPdate.value = "ASC";
            }
            
            passUdate.value ="";
            fn_createTable($('#caseSeqH').val(), passPdate.value, passUdate.value, $('#caseNumberH').val(), $('#victimNameH').val() );
        });
        
        //지원등록일 정렬
        $('#orderPassUDateBtn').on('click',function(){
            var passUdate = document.getElementById("passUdate");
            var passPdate = document.getElementById("passPdate");
            
            if(passUdate.value == ""){
                passUdate.value ="ASC";
            }else if(passUdate.value == "ASC"){
                passUdate.value = "DESC";
            }else if(passUdate.value == "DESC"){
                passUdate.value = "ASC";
            }else{
                passUdate.value = "ASC";
            }
            
            passPdate.value ="";
            fn_createTable($('#caseSeqH').val(), passPdate.value, passUdate.value, $('#caseNumberH').val(), $('#victimNameH').val() );
        });
    });
    
//  $("#centerCode").on("change", function() {
//      setCenterGbnChange();
//  });

//  function setCenterGbnChange(centerCode) {
//      var gNum = $("#centerCode").val();
//      if (gNum=='') {
//          $("#loginCenterCode").hide();
//      } else {
//          if (gNum!='XXX') {
//              $("#loginCenterCode").show();
//          }
//      }

//      if (gNum!='XXX') {
//          $("#selectCenterCodeDiv").hide();
//      } else {
//          $("#loginCenterCode").hide();
//          $("#selectCenterCodeDiv").show();
//      }

//      fnSelectChangeSelect('loginCenterCode', $("#centerCode > option:selected").attr("ref"), 'CODE_GROUP',gNum,centerCode);
//      $('#totYN').attr("checked", false);
//  }
    
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
        s2Month += "2000,2004,2008,2012,2016,2020,2024,2028,2032,2036,2040,2044,2048,2052,2056,2060,2064,2068,2072,2076,2080,2084,2088,2092,2096";
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
                case "12" : 
                    eDay = "31";
                    break;
                case "02" : 
                    if (n>0) {
                        eDay = "29";
                    } else {
                        eDay = "28";
                    }
                    break;
                default  : 
                    eDay = "30";
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
                case "1" : 
                    sDay = "01-01";
                    eDay = "03-31";
                    break;
                case "2" : 
                    sDay = "04-01";
                    eDay = "06-30";
                    break;
                case "3" : 
                    sDay = "07-01";
                    eDay = "09-30";
                    break;
                default : 
                    sDay = "10-01";
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
                case "1" : 
                    sDay = "01-01";
                    eDay = "06-30";
                    break;
                default : 
                    sDay = "07-01";
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
    
    function linkPage(page){
        var victimName = "";
        if($("#victimNameH").val() != null){
            victimName = $("#victimNameH").val();
        }
        
        $("#pageNo").val(page);
        
        var params = $("#frm").serialize();  
        var cnt = 0;
        var caseNumber = $("#caseNumberH").val();
        
        params += "&pageNo="+page
        
        $.ajax({
            type: 'GET',
            url: '/bos/instance/case/findCasePassList.json',
            data : params,
            async : false,
            success: function(data) {
                var results = data.resultList;
                totpage = data.totpage;
                
                $("#tbPass tbody tr").remove();
                
                var str = ''; 
                if(results.length > 0 ){
                    $.each(results , function(i){
                        var timestamp = results[i].passUdate;
                        var passUdate = new Date(timestamp);
                        var passMonth = passUdate.getMonth() + 1;
                    
                        if(passMonth < 10) {
                            passMonth = "0" + passMonth;
                        }
                    
                        var passDate = passUdate.getDate();
                    
                        if(passDate < 10) {
                            passDate = "0" + passDate;
                        }
                    
                        str += '<tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('+ results[i].caseSeq + ', ' + results[i].passSeq + ')">';
                        str += '<td>' + results[i].passDate + ' ' + results[i].passTime + '</td>';
                        str += '<td>' + results[i].userName + '</td>';
                        var passName = results[i].passTypeNm;
                        if(results[i].sub1DataNm) {
                            passName += ' > ' + results[i].sub1DataNm;
                        }
                        if(results[i].sub2DataNm) {
                            passName += ' > ' + results[i].sub2DataNm;
                        }
                        str +=  '<td style="text-align:left;">' + passName + '</td>';
                        str +=  '<td>' + results[i].passManager + '</td>';
                        str +=  '<td>' + passUdate.getFullYear() + "-" + passMonth + "-" + passDate + '</td>';
                        str += '</tr>';
                    });
                }else{
                    str += '<tr><td colspan="5">데이터가 없습니다.</td></tr>';
                }
                $("#tbPass #passTbody").append(str); 
            }
        });
        
//      var pageNumber1 = page;
        
//      var $pagination = $('selector');
//      var defaultOpts = {
//          totalPages: 20;
//      };
        
//      $("#tbPass").parent().parent().twbsPagination({
//          totalPages: 35,
//          visiblePages: 7,
//          prev: "이전",
//          next: "다음",
//          first: '«',
//          last: '»',
//          onPageClick: function (event, page) {
//              $('#page-content').text('Page ' + page);
//          }
        
//          $.ajax({
//              type: 'GET',
//              url: '/bos/instance/case/findCasePassList.json',
//              data : params,
//              async : false,
//              success: function(data) {
//                  console.log(data);
//                  var results = data.resultList;
//                  $("#tbPass tbody tr").remove();
//                  var str = ''; 
//                  if(results.length > 0 ){
//                      $.each(results , function(i){
//                          var timestamp = results[i].passUdate;
//                          var passUdate = new Date(timestamp);
//                          var passMonth = passUdate.getMonth() + 1;
//                          if(passMonth < 10) {
//                              passMonth = "0" + passMonth;
//                          }
//                          var passDate = passUdate.getDate();
//                          if(passDate < 10) {
//                              passDate = "0" + passDate;
//                          }
                        
//                      str += '<tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('+ results[i].caseSeq + ')"><td>' + results[i].passDate + ' ' + results[i].passTime + '</td>';
//                      str +=  '<td>' + results[i].userName + '</td>';
//                      str +=  '<td>' + results[i].passName + '</td>';
//                      str +=  '<td>' + results[i].passManager + '</td>';
//                      str +=  '<td>' + passUdate.getFullYear() + "-" + passMonth + "-" + passDate + '</td>';
//                      str += '</tr>';
                        
//                  })
//              }
//                  $("#tbPass").append(str); 
//              }
                        
//          });
         
//             }
//         })
 
//         $pagination.twbsPagination(defaultOpts);
//         $.ajax({
//          type: 'GET',
//              url: '/bos/instance/case/findCasePassList.json,
//              data : params,
//              async : false,
//              success: function(response) {
                    
//              }
//         });
        
//      $("#tbPass").parent().parent().pagination({
//          totalNumberLocator:
//              function(done) {
//               $.ajax({
//                  type: 'GET',
//                  url: '/bos/instance/case/countPassList.json',
//                  data : params,
//                  async : false,
//                  success: function(response) {
//                      console.log(response.totcnt);
//                      done(response.totcnt);
//                  }
//              }); 
                
//           },
//          prevText :"이전",
//          nextText :"다음",
            
//         pageSize: 10,
//         pageNumber: pageNumber1,
//         className: 'paginationjs-theme-blue',
//         dataSource:
//              function(done) {
//                   $.ajax({
//                      type: 'GET',
//                      url: '/bos/instance/case/findCasePassList.json?pageNumber='+pageNumber1,
//                      data : params,
//                      async : false,
//                      success: function(response) {
//                          cnt = response.totcnt;
//                          done(response.resultList);
//                      }
//                  }); 
                    
//               },
//             callback: function(results, pagination) {
//                  cnt = pagination.totalNumber;
                
//                  $("#tbPass tbody tr").remove();
                
//              var str = ''; 
//              if(results.length > 0 ){
//                  $.each(results , function(i){
//                      var timestamp = results[i].passUdate;
//                      var passUdate = new Date(timestamp);
//                      var passMonth = passUdate.getMonth() + 1;
                    
//                      if(passMonth < 10) {
//                          passMonth = "0" + passMonth;
//                      }
                    
//                      var passDate = passUdate.getDate();
                    
//                      if(passDate < 10) {
//                          passDate = "0" + passDate;
//                      }
                    
//                        str += '<tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('+ results[i].caseSeq + ')"><td>' + results[i].passDate + ' ' + results[i].passTime + '</td>';
//                        str +=  '<td>' + results[i].userName + '</td>';
//                        str +=  '<td>' + results[i].passName + '</td>';
//                        str +=  '<td>' + results[i].passManager + '</td>';
//                        str +=  '<td>' + passUdate.getFullYear() + "-" + passMonth + "-" + passDate + '</td>';
//                        str += '</tr>';
//                    });
                    
                    
//                }else{
//                  str += '<td colspan="5">데이터가 없습니다.</td>';
//                }
//              $("#tbPass").append(str); 
//          }
//      })
    }
    
    function passList() {
        var page = 1;
        var victimName = "";
        if($("#victimNameH").val() != null){
            victimName = $("#victimNameH").val();
        }
        
        $("#pageNo").val(page);
        
        var params = $("#frm").serialize();
        
        var cnt = 0;
        var caseNumber = $("#caseNumberH").val();
        
        params += "&pageNo="+page;
        
        var totpage = 0;
        
        var $pagination = $("#tbPass");
        var defaultOpts = {
            totalPages: 10
        };
        
        $.ajax({
            type: 'GET',
            url: '/bos/instance/case/findCasePassList.json',
            data : params,
            async : false,
            success: function(data) {
                var results = data.resultList;
                var cnt = data.cnt;
                $("#txtTotalRecordCountSub").text(cnt);
                
                totpage = data.totpage;
                
                $("#tbPass tbody tr").remove();
                
                var str = ''; 
                if(results.length > 0 ){
                    $.each(results , function(i){
                        var timestamp = results[i].passUdate;
                        var passUdate = new Date(timestamp);
                        var passMonth = passUdate.getMonth() + 1;
                    
                        if(passMonth < 10) {
                            passMonth = "0" + passMonth;
                        }
                    
                        var passDate = passUdate.getDate();
                    
                        if(passDate < 10) {
                            passDate = "0" + passDate;
                        }
                    
                        str += '<tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('+ results[i].caseSeq + ', ' + results[i].passSeq + ')">';
                        str += '<td>' + results[i].passDate + ' ' + results[i].passTime + '</td>';
                        str += '<td>' + results[i].userName + '</td>';
                        var passName = results[i].passTypeNm;
                        if(results[i].sub1DataNm) {
                            passName += ' > ' + results[i].sub1DataNm;
                        }
                        if(results[i].sub2DataNm) {
                            passName += ' > ' + results[i].sub2DataNm;
                        }
                        str +=  '<td style="text-align:left;">' + passName + '</td>';
                        str +=  '<td>' + results[i].passManager + '</td>';
                        str +=  '<td>' + passUdate.getFullYear() + "-" + passMonth + "-" + passDate + '</td>';
                        str += '</tr>';
                    });
                }else{
                    str += '<tr><td colspan="5">데이터가 없습니다.</td></tr>';
                }
                
                $("#tbPass #passTbody").append(str); 
                $('#passDiv .paginationSet').twbsPagination('destroy');
            }
        });

        if(totpage > 0){
            $("#passDiv .paginationSet").twbsPagination({
                totalPages:totpage,
                visiblePages: 10,
                prev: "이전",
                next: "다음",
                first: '처음',
                last: '끝',
                onPageClick: function (event, page) {
                    linkPage(page);
                    $('#page-content').text('Page ' + page);
                }
            });
        }
    }
    
    
    function fn_createTable(caseSeq, passPdate, passUdate, caseNumber, victimName){
        $("#caseSeq").val(caseSeq);
        $("#caseSeqH").val(caseSeq);
        $("#caseNumberH").val(caseNumber);
        $("#victimNameH").val(victimName);
        $("#passPdate").val(passPdate);  
        $("#passUdate").val(passUdate);    
        $("#btnInsertPass").val(caseSeq);
        
        if(caseNumber != ''){
            $("#btnInsertPass").show();
            $("#passNoDiv").show();
        }
        
        $('#txtPassName').text(victimName);
        $('#txtPassNo').text(caseNumber);
        
        if(caseSeq){
            $("#checkTable").val("Y");
            if("${param.menuNo}" == '100214'){
                $("#checkTable").val("C");
            }
        }
        
        $("#tbPass tbody tr").remove();
        
        var params = $("#frm").serialize();
        var cnt = 0;
        
        passList();
        /* $("#tbPass").pagination({
            dataSource: function(done) {
                $.ajax({
                    type: 'POST',
                    url: '/bos/instance/case/findCasePassList.json',
                    data : params,
                    success: function(response) {
                        done(response.resultList);
                    }
                });
            },
            pageSize: 20,
            callback: function(results, pagination) {
                console.log("aaaaaaaaaaaaaaa");
                console.log(results);
                
                cnt = pagination.totalNumber
                $("#tbPass tbody tr").remove();
                               
                var str = ''; 
                if(results.length > 0 ){
                $.each(results , function(i){
                                    
                    var timestamp = results[i].passUdate;
                    var passUdate = new Date(timestamp);
                    var passMonth = passUdate.getMonth() + 1;
                            
                    if(passMonth < 10) {
                        passMonth = "0" + passMonth;
                    }
                            
                    var passDate = passUdate.getDate();
                            
                    if(passDate < 10) {
                        passDate = "0" + passDate;
                    }
                            
                    str += '<tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('+ results[i].caseSeq + ', ' + results[i].passSeq +')"><td>' + results[i].passDate + ' ' + results[i].passTime + '</td>';
                    str +=  '<td>' + results[i].userName + '</td>';
                    var passName = results[i].passTypeNm;
                    if(results[i].sub1DataNm) {
                        passName += ' > ' + results[i].sub1DataNm;
                    }
                    if(results[i].sub2DataNm) {
                        passName += ' > ' + results[i].sub2DataNm;
                    }
                    str +=  '<td>' + passName + '</td>';
                    str +=  '<td>' + results[i].passManager + '</td>';
                    str +=  '<td>' + passUdate.getFullYear() + "-" + passMonth + "-" + passDate + '</td>';
                    str += '</tr>';
                    });
                }else{
                    str += '<td colspan="4">데이터가 없습니다.</td>';
                }
                $("#tbPass").append(str); 
            }
        }) */
        
        $("#tbPass tbody tr").click(function(){
            $(this).addClass("highlight").siblings().removeClass("highlight")
        });
          
    }
    
    function goPassView() {
        location.href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq="+$("#caseSeq").val()+"&redirect=Y";
    }
    
    function fn_DbClick(caseSeq){
        $("#historyMemo").val("[자동입력] 사례를 조회했습니다");
        $("#caseSeq").val(caseSeq);
        $("#pageUnit").val("");
        document.frm.action = "/bos/instance/case/view.do?menuNo=${param.menuNo}";
        document.frm.submit();
    }
    
    function fn_passDbClick(caseSeq, passSeq){
        /* $("#caseSeq").val(caseSeq);
        $("#pageUnit").val("");
        $("#srcCslId").val("");
        $("#casePdate").val("");
        $("#passPdate").val("");
        $("#passUdate").val("");
        document.frm.action = "/bos/instance/case/passView.do?menuNo=${param.menuNo}";
        document.frm.submit(); */
        
        location.href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq="+caseSeq+"&passSeq="+passSeq;
    }
    
    function fn_search(){
        $("#caseSeqH").val("");
        $("#caseNumberH").val("");
        $("#victimNameH").val("");
        
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
        
        if($("#menuNo").val() == '100214'){
            document.frm.action = "/bos/instance/case/list.do?menuNo=${param.menuNo}&searchAll=N";
        }else{
            document.frm.action = "/bos/instance/case/list.do?menuNo=${param.menuNo}";
        }
        document.frm.submit();
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
        }).done(function(retVal) {
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
        }).done(function(retVal) {
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
    
    $(function(){
        $("#tbCase tbody tr").click(function(){
            $(this).addClass("highlight").siblings().removeClass("highlight")
        });
    });
    
    $(function(){
        $("#tbPass tbody tr").click(function(){
            $(this).addClass("highlight").siblings().removeClass("highlight")
        });
    });
</script>

<!-- cont -->
<div class="cont">
    <div>
        <form id="frm" name="frm" class="pure-form" method="post">
            <input type="hidden" name="menuNo" value="${param.menuNo}">
            <input type="hidden" name="searchCaseType" value="">
            <input type="hidden" name="searchMasterText" value="">
            <input type="hidden" id="tody" name="tody" value="${today}" />
            <input type="hidden" id="searchOption" name="searchOption" value="close" />
            <input type="hidden" name="chkCsTypeArr" id="chkCsTypeArr" value="${paramVO.chkCsTypeArr}" />
            <input type="hidden" name="chkCsJupsooArr" id="chkCsJupsooArr" value="${paramVO.chkCsJupsooArr}" />
            <input type="hidden" name="userId" value="${userVO.userId}" />
            <input type="hidden" name="loginUserId" value="${userVO.userId}" />
            <input type="hidden" name="userNm" value="${userVO.userNm}" />
            <input type="hidden" id="historyMemo" name="historyMemo" value="" />
            <input type="hidden" id="loginCenterCode" name="loginCenterCode" value="${userVO.centerCode}" />
            <input type="hidden" name="casePdate" id="casePdate" value="${param.casePdate}">
            <input type="hidden" name="passPdate" id="passPdate" value="${param.passPdate}">
            <input type="hidden" name="passUdate" id="passUdate" value="${param.passUdate}">
            <input type="hidden" name="caseSeqH" id="caseSeqH" value="${param.caseSeqH}">
            <input type="hidden" name="caseNumberH" id="caseNumberH" value="${param.caseNumberH}">
            <input type="hidden" name="victimNameH" id="victimNameH" value="${param.victimNameH}">
            <input type="hidden" name="caseSeq" id="caseSeq" value="">
            <input type="hidden" name="userCenterCode" id="userCenterCode" value="${userVO.centerCode }" />
            <input type="hidden" name="checkTable" id="checkTable" value="N" />
            <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
            <input type="hidden" name="pageUnit2" id="pageUnit2" value="${param.pageUnit2 }" />

            <table class="pure-table pure-table-bordered" style="width: 100%;">
                <colgroup>
                    <col style="width: 150px;" />
                    <col style="width: 500px;" />
                    <col style="width: 130px;" />
                    <col style="width: 200px;" />
                </colgroup>
                <tr>
                    <td class="align-center">날짜 검색 기준</td>
                    <td colspan="3">
                        <input type="radio" name="searchDateType" id="searchDateTypeCD" value="caseDate" ${paramVO.searchDateType eq 'caseDate' ? 'checked' : '' } />
                        <label for="searchDateTypeCD" class="pr10">접수일</label>
                        <input type="radio" name="searchDateType" id="searchDateTypeCU" value="caseUdate" ${paramVO.searchDateType eq 'caseUdate' ? 'checked' : '' } />
                        <label for="searchDateTypeCU" class="pr10">등록(수정)일</label>
                    </td>
                </tr>
                <tr>
                    <td class="align-center">사례등록일 <img class="btnDeleteSearchDateRage" src='/static/bos/image/cross-th.png' alt="초기화">
                    </td>
                    <td colspan="3">
                        <!-- <select id="searchYear" name="searchYear"> -->
                        <select name="smonthY" id="smonthY" title="검색 년도">
                            <c:forEach begin="0" end="${yearToday - 2000 }" var="year" varStatus="status">
                                <option value="${yearToday - year }"
                                    <c:if test="${(yearToday - year) eq paramVO.smonthY}">selected="selected"</c:if>>${yearToday - year } 년</option>
                            </c:forEach>
                        </select>
                        <select id="searchHalf" name="searchHalf">
                            <!-- <option>반기선택</option> -->
                            <option value='1' <c:if test="${paramVO.searchHalf eq '1'}">selected="selected"</c:if>>전반기</option>
                            <option value='2' <c:if test="${paramVO.searchHalf eq '2'}">selected="selected"</c:if>>후반기</option>
                        </select>
                        <select id="searchQuater" name="searchQuater">
                            <!-- <option>분기선택</option> -->
                            <option value='1' <c:if test="${paramVO.searchQuater eq '1'}">selected="selected"</c:if>>1 분기</option>
                            <option value='2' <c:if test="${paramVO.searchQuater eq '2'}">selected="selected"</c:if>>2 분기</option>
                            <option value='3' <c:if test="${paramVO.searchQuater eq '3'}">selected="selected"</c:if>>3 분기</option>
                            <option value='4' <c:if test="${paramVO.searchQuater eq '4'}">selected="selected"</c:if>>4 분기</option>
                        </select>
                        <!-- <select id="searchMonth" name="searchMonth"> -->
                        <select name="smonthM" id="smonthM" title="검색 월">
                            <c:forEach begin="1" end="12" var="month" varStatus="status">
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
                <c:choose>
                    <c:when test="${userVO.authorCd == 'CA' || userVO.authorCd == 'CU' || userVO.authorCd == 'ROLE_SUPER'}">
                        <tr>
                            <td class="align-center">센터 구분</td>
                            <td colspan=3>
                                <select name="centerCode" id="centerCode" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','centerCodeSub',this.value , '', 'N')">
                                    <script>
                                        getCmmnCd.select('CM04', 'centerCode', '${paramVO.centerCode}', 'N');
                                    </script>
                                </select>
                                <select name="centerCodeSub" id="centerCodeSub" title="센터 구분 서브" onchange="fn_cdChange();">
                                    <script>
                                        getCmmnCd.subSelect('CM05', 'centerCodeSub', '${paramVO.centerCode}', '${paramVO.centerCodeSub}', 'N')
                                    </script>
                                </select>
                                <span style="color: green; padding-left: 20px;">(참고:한국여성인권진흥원 권한에서만 나타나는 메뉴입니다)</span> <br />
                                <div id="selectCenterCodeDiv" style="display: none;">
                                    <%-- <%=strCntrCodeCheckBox%> --%>
                                    <script>
                                        getCmmnCd.checkBox('CM05', 'selectCenterCodeDiv', 'selectCenterCode', '${paramVO.selectCenterCode}', '4');
                                    </script>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%-- <input type="text" id="scCenterCodeSub" name="scCenterCodeSub" value="${userVO.centerCode}" /> --%>
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
                    </c:otherwise>
                </c:choose>
                <tr>
                    <td class="align-center">피해 구분</td>
                    <td colspan=3>
                        <div id="div_caseType">
                            <input type='checkbox' name='caseType_all' value='Y' id='caseType_all' ${paramVO.chkCsTypeArr eq '01, 02, 03, 11' ? 'checked' : '' } />
                            <label for='caseType_all' style="padding-right: 20px;"><b style="color: orange;">전체선택</b></label>
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
                            <input type='checkbox' name='chkCaseJupsoo_all' value='Y' id='chkCaseJupsoo_all' ${paramVO.chkCsJupsooArr eq '1, 2, 4, 3, 5' ? 'checked' : '' } />
                            <label for='chkCaseJupsoo_all' style="padding-right: 20px;"><b style="color: orange;">전체선택</b></label>
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
                    <select id="srcState" name="srcState" onchange="fn_cdStateChange();">
                            <option value="Y" <c:if test="${paramVO.srcState == 'Y'}">selected="selected"</c:if>>재직자</option>
                            <option value="S" <c:if test="${paramVO.srcState == 'S'}">selected="selected"</c:if>>휴직자</option>
                            <option value="N" <c:if test="${paramVO.srcState == 'N'}">selected="selected"</c:if>>퇴직자</option>
                    </select>
                    <select id='srcCslId' name='srcCslId'>
                            <option value=''>선택</option>
                    </select>
                    </td>
                </tr>
                <c:if test="${paramVO.menuNo != '100215'}">
                    <tr>
                        <td class="align-center">보관함 사례 제외</td>
                        <td>
                            <span style="display: inline-block; width: 80px;">
                                <input type="checkbox" name="finishCaseCheck" value="N" <c:if test="${paramVO.finishCaseCheck == 'N'}">checked</c:if>>
                            </span>
                        </td>
                        <td class="align-center">내방 사례 여부</td>
                        <td>
                            <span style="display: inline-block; width: 80px;">
                                <input type="checkbox" name="visitCaseCheck" value="N" <c:if test="${paramVO.visitCaseCheck == 'N'}">checked</c:if>>
                            </span>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <td class="align-center">사례관리자</td>
                    <td colspan=3>
                        <select id="caseManagerState" name="caseManagerState" onchange="fn_cdManagerChange();">
                            <option value="Y" <c:if test="${paramVO.caseManagerState == 'Y'}">selected="selected"</c:if>>재직자</option>
                            <option value="S" <c:if test="${paramVO.caseManagerState == 'S'}">selected="selected"</c:if>>휴직자</option>
                            <option value="N" <c:if test="${paramVO.caseManagerState == 'N'}">selected="selected"</c:if>>퇴직자</option>
                        </select>
                        <select id='caseManager' name='caseManager'>
                                <option value=''>선택</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan=4>
                        <input type="button" id="input2" name="input2" value="검색" class='pure-button btnSearch' style="height: 30px; width: 100%;" onclick="fn_search()" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="jqlblList" style="width: 100%;">
        <tr>
            <td style="width: 55%;" valign="top">
                <div style="width: 100%; height: 32px;">
                    <div style="float: left;">
                        결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건
                    </div>
                    <div></div>
                    <div style="float: right;">
                        <!-- <input type="submit" id="btnInsertCase" class="pure-button btnSave" value="사례 신규입력"> -->
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

                <div style="clear: both; width: 100%;">
                    <table class="table table-striped table-hover" id="tbCase">
                        <caption>사례 목록</caption>
                        <thead>
                            <tr style="height: 60px;">
                                <c:choose>
                                    <c:when test="${param.menuNo == '100190'}">
                                        <th style="width: 24%" scope="col">센터사례번호</th>
                                    </c:when>
                                    <c:otherwise>
                                        <th style="width: 24%" scope="col">전산관리번호</th>
                                    </c:otherwise>
                                </c:choose>
                                <th style="width: 15%" scope="col">피해구분</th>
                                <th style="width: 22%" scope="col">사례접수일 <button type="button" name="orderCaseDateBtn" id="orderCaseDateBtn">▼▲</button></th>
                                <th style="width: 17%" scope="col">피해자명</th>
                                <th style="width: 22%" scope="col">사례등록일 <button type="button" name="orderCaseUDateBtn" id="orderCaseUDateBtn">▼▲</button></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="result" items="${resultList}" varStatus="status">
                                <tr onclick="fn_createTable('${result.caseSeq}', '', '','${result.caseNumber}', '${result.victimName}');" style="cursor: pointer;" id="trCase" ondblclick="fn_DbClick('${result.caseSeq}');">
                                <c:if test="${not empty result.afterCenterName }">
                                    <td class="tit" title="${result.beforeCenterName}로부터 ${result.afterCenterName}센터로 이관된 사례입니다.&#10;이관기준일 : ${result.transDate}">
                                </c:if>                                    
                                <c:if test="${empty result.afterCenterName }">
                                    <td class="tit">
                                </c:if>                                    
                                        <c:choose>
                                            <c:when test="${param.menuNo == '100190'}">
                                               ${result.centerNumber}
                                            </c:when>
                                            <c:otherwise>
                                               ${result.caseNumber}
                                            </c:otherwise>
                                        </c:choose>
                                	<c:if test="${not empty result.afterCenterName }">
                                    	<img src='/static/bos/image/trans.png'  alt="초기화">
                                	</c:if>                                           
                                    </td>
                                    <td>${result.caseTypeNm}</td>
                                    <td>${result.caseDate}</td>
                                    <td><c:out value="${result.victimName}" escapeXml="false"/></td>
                                    <td><fmt:formatDate value="${result.caseUdate}" pattern="yyyy-MM-dd" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(resultList) == 0}">
                                <tr>
                                    <td colspan="5">데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <c:if test="${fn:length(resultList) > 0}">
                    ${pageNav}
                </c:if>
            </td>
            <td style="width: 1%;"></td>
            <td style="width: 44%;" valign="top">
                <div>
                    <p style="float: right;">
                        <select id="pageSelect2" name="pageSelect2">
                            <option value="20" ${paramVO.pageUnit2 eq '20' ? 'selected' : '' }>20개</option>
                            <option value="50" ${paramVO.pageUnit2 eq '50' ? 'selected' : '' }>50개</option>
                            <option value="100" ${paramVO.pageUnit2 eq '100' ? 'selected' : '' }>100개</option>
                            <option value="0" ${paramVO.pageUnit2 eq '999999' ? 'selected' : '' }>전체</option>
                        </select>
                    </p>
                    <a href="javascript:goPassView();" style="float: right; display: none; margin-right: 5px;" id="btnInsertPass" class="pure-button btnSave">서비스 신규입력</a>
                </div>
                <div style="width: 100%; height: 32px;">
                    <%-- <div style="float:left;">결과: <strong class="f_blue" id="txtTotalRecordCountSub">${resultPassCnt}</strong>건</div><br/> --%>
                    <%-- <div><strong class="f_blue" id="txtPassName">${resultCaseView.victimName }</strong>[<strong class="f_blue" id="txtPassNo">${resultCaseView.caseNumber}</strong>]님의 서비스</div> --%>
                    <div style="float: left;">
                        결과: <strong class="f_blue" id="txtTotalRecordCountSub"></strong>건
                    </div>
                    <br />
                    <div id="passNoDiv" style="display: none;">
                        <strong class="f_blue" id="txtPassName"></strong>[<strong class="f_blue" id="txtPassNo"></strong>]님의 서비스
                    </div>
                    <!-- 
                    <div style="float:right;">
                        <input type="submit" id="btnInsertPass" class="pure-button btnSave" style="display:none;" value="서비스 신규입력">
                    </div>
                     -->
                </div>
                <div style="clear: both; width: 100%;" id="passDiv">
                    <table class="table table-striped table-hover" id="tbPass">
                        <thead>
                            <tr style="height: 60px;">
                                <th style="width: 25%" scope="col">지원일시 <button type="button" name="orderPassDateBtn" id="orderPassDateBtn">▼▲</button></th>
                                <!-- <th style="width:30% " scope="col">지원일시</th> -->
                                <th style="width: 20%" scope="col">내담자</th>
                                <th style="width: 20%" scope="col">지원서비스</th>
                                <th style="width: 15%" scope="col">지원<br />담당자</th>
                                <th style="width: 20%" scope="col">등록일 <button type="button" name="orderPassDateBtn" id="orderPassUDateBtn">▼▲</button></th>
                            </tr>
                        </thead>
                        <tbody id="passTbody">
<%--                        <c:forEach var="result" items="${resultPassList}" varStatus="status">
                                <tr style="cursor: pointer;" id="trCase" ondblclick="fn_passDbClick('${result.caseSeq}', '${result.passSeq }');">
                                    <td>${result.passDate} ${result.passTime }</td>
                                    <td>${result.userName}</td>
                                    <td>
                                        ${result.passTypeNm }
                                        <c:if test="${not empty result.sub1DataNm }"> > ${result.sub1DataNm }</c:if>
                                        <c:if test="${not empty result.sub2DataNm }"> > ${result.sub2DataNm }</c:if>
                                    </td>
                                    <td>${result.passManager}</td>
                                    <td><fmt:formatDate value="${result.passUdate}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:forEach> --%>
                            <c:if test="${fn:length(resultPassList) == 0}">
                                <tr>
                                    <td colspan="5">데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
<%--                    <tfoot> 
                            <tr>
                                <td colspan="5">
                                    <div class="paging">
                                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
                                    </div>
                                </td>
                            </tr> 
                        </tfoot> --%>
                    </table>
                    <div class="paginationSet"></div>
                </div>
            </td>
        </tr>
    </table>
</div>