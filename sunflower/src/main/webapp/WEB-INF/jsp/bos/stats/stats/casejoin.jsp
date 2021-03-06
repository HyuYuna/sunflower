<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear"/> 
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate"/> 

<script src="/static/bos/commonEkr/js/excelexportjs/jquery.techbytarun.excelexportjs.min.js" type="text/javascript"></script>

<style>
#lblList table {
	border-collapse: collapse;
	min-width: 960px;
	width:100%;
}

#lblList table, th, td {
	border: 1px solid #cbcbcb;
}

#lblList th, td {
	padding: 5px;
}

#lblList th {
	text-align: center;
}

#lblList td {
	text-align: right;
}

#lblList .sellDisable {
	color: blue
}

.selHover {
	background-color: orange;
}
</style>

<script>
function filePopZip(){
    var url = "/bos/stats/stats/excelDownPopup.do";
    var params = "?shDataNm=통계(특수통계)&viewType=BODY";
    window.open(url+params , 'caseFilePopup',"width=500, height=300");
}

function fn_export(){
    $("#tblExport").excelexportjs({
        containerid : "tblExport"
        , datatype : 'table'
    });
    $(this).attr('download', '통계_특수통계.xls').attr('href', uri).attr("target", "_blank");
}

function numComma(n) {
    if(n!=null){
    	var num = n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }
	return num;
}

function getResultData() {
	
	var valChecked = $("#formSearch input[name='CHEK_CASE_TYPE']:checked").val();
	//대상센터 추가
	var chkArray = new Array();
	$("input:checkbox[name=CHECK_CNTR_COD]:checked").each(function(){
		chkArray.push(this.value);
	});
	
	if(chkArray.length > 0){
		$("#arr_CNTR_COD").val(chkArray);
	}
	
	var valChecked2 = "";
	
	console.log($("input[name='ATTKR_DISABLE']").is(":checked"));
	
	/* var valChecked2 = $("input[name='CASE_TYPE']:checked").val(); */
	/* if (valChecked2=="ATTKR_STATE_YN" || valChecked2=="ATTKR_STATE" || valChecked2=="ATTKR_AGE") { */
	if($("select[name='ATTKR_FRGER']").val() != '' 
			|| $("select[name='ATTKR_SEX']").val() != ''
			|| $("select[name='ATTKR_REL_GRP']").val() != '' 
			|| $("select[name='ATTKR_AGE']").val() != ''
			|| $("input[name='ATTKR_DISABLE']").is(":checked")
		) {
		getResultData1();
	}else{
		getResultData2();
	}
}

function getResultData1() {

	var isFinish = "Y";

	var valChecked = $("#formSearch input[name='CHEK_CASE_TYPE']:checked").val();
	
	var valChecked2 = $("input[name='CASE_TYPE']:checked").val();

	if($("select[name='ATTKR_FRGER']").val() != '' 
			|| $("select[name='ATTKR_SEX']").val() != ''
			|| $("select[name='ATTKR_REL_GRP']").val() != '' 
			|| $("select[name='ATTKR_AGE']").val() != '' 
			|| $("input[name='ATTKR_DISABLE']").is(":checked")
		) {
        sqlUrl = "/bos/stats/stats/caseAttkrStats.json";
    }

    $.ajax({
        type:"post",
        url: sqlUrl,
        dataType: "json",
        data: $("#formSearch").serialize(),
        success:function(data1){
        	
        	console.log(data1);
        	
        	
        	var codeResult = data1.codeResult;
        	var attkrStats = data1.attkrStats;
        	var attkrStatd = data1.attkrStatd;
        	
        	
        	var table = "";
        	
        	var dsaYN = data1.dsaYN;
        	var sexYN = data1.sexYN; 
        	
        	if(codeResult.length >= 0){
        		table += "<table id='tblExport'>";
        		
        		if(dsaYN == 'Y'){
        			if(sexYN == 'Y'){
        				var gubunRowspan = 3;
        				var subRowspan = 2;
        				var colnum = 8;
        				var sexColspan = 4;
        			} else {
        				var gubunRowspan = 2;
        				var subRowspan = 1;
        				var colnum = 2;
        				var sexColspan = 1;
        			}
        			
        			table += "<tr><th style='min-width:150px; background-color:#ffffff;' rowspan='" + gubunRowspan + "'>구분</th>";
        			table += "<th colspan='" + colnum + "'>전체</th>";
        			
        			$.each(codeResult, function(index, entry) {
        				table += "<th colspan='" + colnum + "'>" + entry["cdNm"] + "</th>";
        			})
        			
        			if(data1.chkNonSelect){
        				table += "<th colspan='" + colnum + "'>미선택</th>"
        			}
        			
        			table += "</tr><tr>";
        			
        			for(var i=0; i<codeResult.length + 1; i++){
        				table += "<th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "'>전체</th>";
                        table += "<th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "' class='sellDisable'>장애</th>";
        			}
        			
        			if(sexYN == "Y"){
        				table += "<tr>";
            			for(var i=0; i<codeResult.length + 1; i++){
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>합계</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>합계</th>";
            			}
            			table += "</tr>";
        			}
        		} else {
        			if(sexYN == 'Y'){
        				gubunRowspan = 2;
        				colnum = 4;
        			} else {
        				gubunRowspan = 1;
        				colnum = 1;
        			}
        			
        			table += "<tr style='height:30px;'>";
        			table += "<th style='min-width:150px; background-color:#ffffff;' rowspan='" + gubunRowspan + "'>구분</th>";
        			table += "<th style='width:50px;' colspan='" + colnum + "'>전체</th>";
        			
        			$.each(codeResult, function(index, entry) {
        				table += "<th style='width:50px;' colspan='" + colnum + "'>" + entry["cdNm"] + "</th>";
        			})
        			
        			if(data1.chkNonSelect){
        				table += "<th style='width:50px;' colspan='" + colnum + "'>미선택</th>"
        			}
        			
        			table += "</tr>";
        			
        			if(sexYN == "Y"){
        				table += "<tr>";
            			for(var i=0; i<codeResult.length + 1; i++){
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; min-width:60px; padding:5px 0 5px 0;'>합계</th>";
            			}
            			table += "</tr>";
        			}
        		}
        		
        		var sumArray = new Array();
        		var sumDrray = new Array();
        		
        		if(sexYN == 'Y'){
        			var sexRowspan = " rowspan=1";
        		} else {
        			var sexRowspan = "";
        		}
        		
        		var preGroupCode = "0";
        		var cCode = "";
        		$.each(attkrStats, function(i, entry) {
        			if(i == 0){
        				if(sexYN == 'Y'){
        					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
        					
        					for(var t=6; t<data1.codeCount2; t++){
        						table += "<td>" + numComma(data1.array0[t][1]) + "</td><td>" + numComma(data1.array0[t][2]) + 
        								"</td><td>" + numComma(data1.array0[t][3]) + "</td><td>" + numComma(data1.array0[t][0]) + "</td>";
        						
        						if(dsaYN == 'Y'){
            						table += "<td class='sellDisable'>" + numComma(data1.drray0[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray0[t][2]) + 
    								"</td><td class='sellDisable'>" + numComma(data1.drray0[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
        						}
        					}
        					
        					table += "</tr>";
        				} else {
        					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
        					
        					for(var t=6; t<data1.codeCount2; t++){
        						table += "<td>" + numComma(data1.array0[t][0]) + "</td>";
        						
        						if(dsaYN == 'Y'){
            						table += "<td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
        						}
        					}
        					
        					table += "</tr>";
        				}
        			}
        			
        			if(entry["cgroupCode"] != preGroupCode) {
        				//위기지원형 소계
        				if(entry["cgroupCode"] == "1"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>위기지원형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array1[t][1]) + "</td><td>" + numComma(data1.array1[t][2]) + 
            								"</td><td>" + numComma(data1.array1[t][3]) + "</td><td>" + numComma(data1.array1[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray1[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray1[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray1[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray1[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>위기지원형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array1[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray1[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        				
        				//아동형 소계
        				if(entry["cgroupCode"] == "2"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array2[t][1]) + "</td><td>" + numComma(data1.array2[t][2]) + 
            								"</td><td>" + numComma(data1.array2[t][3]) + "</td><td>" + numComma(data1.array2[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray2[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray2[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray2[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray2[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array2[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray2[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        				
        				//통합형 소계
        				if(entry["cgroupCode"] == "3"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array3[t][1]) + "</td><td>" + numComma(data1.array3[t][2]) + 
            								"</td><td>" + numComma(data1.array3[t][3]) + "</td><td>" + numComma(data1.array3[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray3[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray3[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray3[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray3[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						table += "<td>" + numComma(data1.array3[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray3[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        			}
        			preGroupCode = entry["cgroupCode"];
        			
        			
        			if(data1.totYN != 'Y'){
        				if(sexYN == 'Y'){
            				if(cCode != entry["codeCode"]){
        					var tot = 0;
        					var row = "<tr>";
        					
        					if(entry["victimSex"] == "M"){
        						row = row + "<th" + sexRowspan + ">" + entry["centerName"] + "</th>";
        					}
        					
        					//전체 합계값 출력
        					for(var t=6; t<data1.codeCount2; t++){
        						$.each(attkrStats, function(index, stats) {
									if(entry["codeCode"] == stats["codeCode"]){
    									
    									row += "<td>" + stats["fieldName"+data1.codename[t]] + "</td>";
    									
    									//남자인경우 남자값으로 초기화
    									if(stats["victimSex"] == "M"){
    										sumArray[t] = stats["fieldName"+data1.codename[t]];
    									} else if(stats["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
    										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
    									} else if(stats["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
    										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
    									
    										if(t == 6){
    											tot = sumArray[t];
    										}
    										
    										row += "<td>" + numComma(sumArray[t]) + "</td>";
    									}
									}
        						})
        						
        						if(dsaYN == "Y"){
        							$.each(attkrStatd, function(index, statd) {
    									if(entry["codeCode"] == statd["codeCode"]){
        									row += "<td class='sellDisable'>" + statd["fieldName" + data1.codename[t]] + "</td>";
        									
        									//남자인경우 남자값으로 초기화
        									if(statd["victimSex"] == "M"){
        										sumDrray[t] = statd["fieldName"+data1.codename[t]];
        									} else if(statd["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
        										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
        									} else if(statd["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
        										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
        										
        										row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
        									}
    									}
            						})
        						}
        					}
        					
            				row += "</tr>";
            				
            				if(data1.termType == "Y" && tot == 0){
            					
            				} else {
            					table += row;
            				}
            				}
        				} else {
        					if(entry["victimSex"] == "M"){
        						for(var t=6; t<data1.codeCount2; t++){
        							sumArray[t] = entry["fieldName" + data1.codename[t]];
        							
        							if(dsaYN == "Y"){
        								/* sumDrray[t] = entry["fieldName" + data1.codename[t]]; */
        								sumDrray[t] = caseStatd[i]["fieldName" + data1.codename[t]];
        							}
        						}
        					} else if (entry["victimSex"] == "F") {
        						for(var t=6; t<data1.codeCount2; t++){
        							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
        							
        							if(dsaYN == "Y"){
        								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
        								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
        							}
        						}
        					} else if(entry["victimSex"] == "E"){
        						for(var t=6; t<data1.codeCount2; t++){
        							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
        							
        							if(dsaYN == "Y"){
        								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
        								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
        							}
        						}
        						
            					tot = 0;
            					row = "<tr>";
            					
            					row += "<th>" + entry["centerName"] + "</th>";
            					
            					for(var t=6; t<data1.codeCount2; t++){
            						if(t == 6){
            							tot = sumArray[t];
            						}
            						
            						row += "<td>" + numComma(sumArray[t]) + "</td>";
            						
            						if(dsaYN == 'Y'){
            							row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
            						}
            					}
            					
            					row += "</tr>";
            					
            					if(data1.termType == 'Y' && tot == 0){
            						
            					} else {
            						table += row;
            					}
            				}
            			}
    					
        			}
        			
        			cCode = entry["codeCode"];
        			/* if(sexYN == "Y"){
        				i += 2;
        			} */
        		})
        		
        		table += "</table>";
        		
        		if(data1.isAdmin){
        			table += "<div id='divBtnExcelExport' class='btnGroup'>";
        			table += "<a id='btnExcelExport' class='pure-button btnSave'>엑셀저장</a>";
        			table += "</div>";
        		}
        	} else {
        		table += "<table>";
        		table += "<tr style='height:50px;'>";
        		table += "<th style='background-color:#ffffff;' rowspan='100'>결과값이 없습니다.</th>";
        		table += "</tr>";
        		table += "</table>";
        	}
        	
            $('#lblList').html(table);

            if (isFinish=='Y') {
                $('#divLoadingImage').empty();
            }
            
            $("#lblList td").hover(function() {
    			$el = $(this);
    			
    			$el.parent().addClass("selHover");
    			
    			if($el.parent().has('th[rowspan]').length == 0){
    				$el
    				.parent()
    				.prevAll('tr:has(th[rowspan]):first')
    				.find('th[rowspan]')
    				.removeClass("sellDisable")
    				.addClass("selHover");
    			}
    		}, function() {
    			$el
    			.parent()
    			.removeClass("selHover")
    			.prevAll("tr:has(th[rowspan]):first")
    			.find('th[rowspan]')
    			.removeClass("selHover");
    		});
            
            if(data1.isAdmin){
    			if(!ekrJs.isMsie()){
    				$("#divBtnExcelExport").show();
    			}
    			
    			var uri="";
    			$("#btnExcelExport").click(function(){
    				filePopZip();
    			});
            }

        }, error: function(xhr,status,error){
            alert('데이터를 처리하지 못했습니다.\n이유 : '+ error);
            $('#divLoadingImage').empty();
        }
    });

    //setCookies4Search();
}

function getResultData2() {
    var isFinish = "Y";
    
    var sqlUrl;
    var valChecked = $("#formSearch input[name='CASE_TYPE']:checked").val();
    
    if (valChecked=="ATTKR_STATE_YN" || valChecked=="ATTKR_STATE" || valChecked=="ATTKR_AGE") {
        sqlUrl = "/bos/stats/stats/caseAttkrStats.json";
    } else {
        sqlUrl = "/bos/stats/stats/casestatsSearch.json";
    }
    
  
    var valChecked3 = new Array();
    
    if($("input:checkbox[id='CHEK_CASE_TYPE01']").is(":checked")){
    	valChecked3.push("01");
    }
    if($("input:checkbox[id='CHEK_CASE_TYPE02']").is(":checked")){
    	valChecked3.push("02");
    }
    if($("input:checkbox[id='CHEK_CASE_TYPE03']").is(":checked")){
    	valChecked3.push("03");
    }
    if($("input:checkbox[id='CHEK_CASE_TYPE05']").is(":checked")){
    	valChecked3.push("05");
    }
    if($("input:checkbox[id='CHEK_CASE_TYPE06']").is(":checked")){
    	valChecked3.push("06");
    }
    if($("input:checkbox[id='CHEK_CASE_TYPE11']").is(":checked")){
    	valChecked3.push("11");
    }
    
    $("#CHEK_CASE_TYPE_VALUE").val(valChecked3);
    
    console.log("===============")
    console.log(valChecked3);
    console.log($("#CHEK_CASE_TYPE_VALUE").val());
    console.log("===============")
    
    var dsayn = $("input:checkbox[name='dsaYN']").is(":checked");
	var sexYN = $("input:checkbox[name='sexYN']").is(":checked");
   
    
    $.ajax({
        type:"post",
        url: sqlUrl,
        dataType: "json",
        data: $("#formSearch").serialize() ,
        success:function(data1){	
        	var codeResult = data1.codeResult;
        	var caseStats = data1.caseStats;
        	var caseStatd = data1.caseStatd;
        	var codeCount = data1.codeResult.length;
        	var timeSum = 0;
        	
        	if(data1.caseType == "CASE_TIME_INTVL"){
        		codeCount = 23;
        		codeCount2 = codeCount+8;
        	/* }else if(data1.caseType=="CS_TYPE_01_AGE" || data1.caseType=="CS_TYPE_02_AGE" || data1.caseType=="CS_TYPE_03_AGE" || data1.caseType=="CS_TYPE_11_AGE" || data1.caseType=="CASE_ROUTE_GRP_AGE"){
        		codeCount = 6;
        		codeCount2 = 6+8; */
        	}else{
        		codeCount2 = data1.codeCount2;
        	}
        		
        	console.log("data1.codeResult" + data1.codeResult);
        	console.log("data1.codeResult2" + data1.codeResult.length);
        	
        	
        	var table = "";
        	
        	var dsaYN = data1.dsaYN;
        	var sexYN = data1.sexYN;
        	var totYN = data1.totYN;
        	
        	console.log(dsaYN)
        	console.log(sexYN)
        	console.log(totYN)
        	
        	if(codeCount >= 0){
        		table += "<table id='tblExport'>";
        		if(dsaYN == 'Y'){
        			if(sexYN == 'Y'){
        				var gubunRowspan = 3;
        				var subRowspan = 2;
        				var colnum = 8;
        				var sexColspan = 4;
        			} else {
        				var gubunRowspan = 2;
        				var subRowspan = 1;
        				var colnum = 2;
        				var sexColspan = 1;
        			}
        			
        			table += "<tr><th style='min-width:150px; background-color:#ffffff;' rowspan='" + gubunRowspan + "'>구분</th>";
        			table += "<th colspan='" + colnum + "'>전체</th>";
        			
        			if(data1.caseType == "CASE_TIME_INTVL"){
        				for(var k2=0; k2 < 24; k2++) {
                			var i2=numberPad(k2, 2); 
                			table += "<th colspan='" + colnum + "'>"+i2+":00~</th>";	
    					}
					}else{
            			$.each(codeResult, function(index, entry) {
            				table += "<th colspan='" + colnum + "'>" + entry["cdNm"] + "</th>";
            			})
						
					}
        			
        			if(data1.chkNonSelect){
        				table += "<th colspan='" + colnum + "'>미선택</th>"
        			}
        			
        			table += "</tr><tr>";
        			
        			for(var i=0; i<codeCount + 1; i++){
        				table += "<th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "'>전체</th>";
                        table += "<th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "' class='sellDisable'>장애</th>";
        			}
        			
        			if(sexYN == "Y"){
        				table += "<tr>";
            			for(var i=0; i<codeCount + 1; i++){
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>합계</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>합계</th>";
            			}
            			table += "</tr>";
        			}
        		} else {
        			if(sexYN == 'Y'){
        				gubunRowspan = 2;
        				colnum = 4;
        			} else {
        				gubunRowspan = 1;
        				colnum = 1;
        			}
        			
        			table += "<tr style='height:30px;'>";
        			table += "<th style='min-width:150px; background-color:#ffffff;' rowspan='" + gubunRowspan + "'>구분</th>";
        			table += "<th style='width:80px;' colspan='" + colnum + "'>전체</th>";
        			
        			
					if(data1.caseType == "CASE_TIME_INTVL"){
        				
        				for(var k2=0; k2 < 24; k2++) {
                			var i2=numberPad(k2, 2); 
                			table += "<th colspan='" + colnum + "'>"+i2+":00~</th>";	
    					}
					}else{
						$.each(codeResult, function(index, entry) {
            				table += "<th style='width:80px;' colspan='" + colnum + "'>" + entry["cdNm"] + "</th>";
            			})
						
					}
        			
        			if(data1.chkNonSelect){
        				table += "<th style='width:80px;' colspan='" + colnum + "'>미선택</th>"
        			}
        			
        			table += "</tr>";
        			
        			if(sexYN == "Y"){
        				table += "<tr>";
            			for(var i=0; i<codeCount + 1; i++){
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>남자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>여자</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>모름</th>";
            				table += "<th style='width:60px; padding:5px 0 5px 0;'>합계</th>";
            			}
            			table += "</tr>";
        			}
        		}
        		
        		var sumArray = new Array();
        		var sumDrray = new Array();
        		
        		if(sexYN == 'Y'){
        			var sexRowspan = " rowspan=1";
        		} else {
        			var sexRowspan = "";
        		}
        		
        		var preGroupCode = "0";
        		var cCode = "";
        		$.each(caseStats, function(i, entry) {
        			if(i == 0){
        				if(sexYN == 'Y'){
        					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
        					
        					for(var t=6; t<codeCount2; t++){
        						table += "<td>" + numComma(data1.array0[t][1]) + "</td><td>" + numComma(data1.array0[t][2]) + 
        								"</td><td>" + numComma(data1.array0[t][3]) + "</td><td>" + numComma(data1.array0[t][0]) + "</td>";
        						
        						if(dsaYN == 'Y'){
            						table += "<td class='sellDisable'>" + numComma(data1.drray0[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray0[t][2]) + 
    								"</td><td class='sellDisable'>" + numComma(data1.drray0[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
        						}
        					}
        					
        					table += "</tr>";
        						
        					
        				} else {
        					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
        					
        					if(data1.caseType == "CASE_TIME_INTVL"){
        						for(var j=0; j< 24; j++){
        							var i2=numberPad(j, 2); 
        								timeSum += eval("data1.caseStats[j].fieldName" + i2);
        							
        							if(dsaYN == 'Y'){
            							table += "<td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
            						}
								}
        						table += "<td>" + timeSum + "</td>";
        						
        						for(var j=0; j< 24; j++){
        							var i2=numberPad(j, 2); 
            						table += "<td>" + eval("data1.caseStats[j].fieldName" + i2) + "</td>";
            						
            						if(dsaYN == 'Y'){
            							table += "<td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        						
        					}else{
            					for(var t=6; t<codeCount2; t++){
            						console.log(data1.array0[t][0]);
            						
            						table += "<td>" + numComma(data1.array0[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray0[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					}
        				}
        			}
        			
        			if(entry["cgroupCode"] != preGroupCode) {
        				//위기지원형 소계
        				if(entry["cgroupCode"] == "1"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>위기지원형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
            						table += "<td>" + numComma(data1.array1[t][1]) + "</td><td>" + numComma(data1.array1[t][2]) + 
            								"</td><td>" + numComma(data1.array1[t][3]) + "</td><td>" + numComma(data1.array1[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray1[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray1[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray1[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray1[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
        						timeSum = 0;
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>위기지원형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
                					console.log()
            						table += "<td>" + numComma(data1.array1[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray1[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        				
        				//아동형 소계
        				if(entry["cgroupCode"] == "2"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
            						table += "<td>" + numComma(data1.array2[t][1]) + "</td><td>" + numComma(data1.array2[t][2]) + 
            								"</td><td>" + numComma(data1.array2[t][3]) + "</td><td>" + numComma(data1.array2[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray2[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray2[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray2[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray2[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
            						table += "<td>" + numComma(data1.array2[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray2[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        				
        				//통합형 소계
        				if(entry["cgroupCode"] == "3"){
        					if(sexYN == 'Y'){
        						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
            						table += "<td>" + numComma(data1.array3[t][1]) + "</td><td>" + numComma(data1.array3[t][2]) + 
            								"</td><td>" + numComma(data1.array3[t][3]) + "</td><td>" + numComma(data1.array3[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray3[t][1]) + "</td><td class='sellDisable'>" + numComma(data1.drray3[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data1.drray3[t][3]) + "</td><td class='sellDisable'>" + numComma(data1.drray3[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
        					} else {
            					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
            					
            					for(var t=6; t<codeCount2; t++){
            						table += "<td>" + numComma(data1.array3[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data1.drray3[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				}
        				}
        			}
        			preGroupCode = entry["cgroupCode"];
        			
        			if(data1.caseType == "CS_TYPE_01_AGE" || data1.caseType == "CS_TYPE_02_AGE" || data1.caseType == "CS_TYPE_03_AGE" || data1.caseType == "CS_TYPE_11_AGE"){
        				if(data1.totYN != 'Y'){
            				if(sexYN == 'Y'){
            					console.log(entry["codeCode"]);
            					console.log(entry["centerName"]);
            					
                				if(cCode != entry["codeCode"]){
	            					var tot = 0;
	            					var row = "<tr>";
	            					
	            					if(entry["victimSex"] == "M"){
	            						row = row + "<th" + sexRowspan + ">" + entry["centerName"] + "</th>";
	            					}
	            					
	            					//전체 합계값 출력
	            					for(var t=6; t<codeCount2; t++){
	            						$.each(caseStats, function(index, stats) {
	    									if(entry["codeCode"] == stats["codeCode"]){
	        									
	        									row += "<td>" + stats["fieldName"+data1.codename[t]] + "</td>";
	        									
	        									//남자인경우 남자값으로 초기화
	        									if(stats["victimSex"] == "M"){
	        										sumArray[t] = stats["fieldName"+data1.codename[t]];
	        									} else if(stats["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
	        										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
	        									} else if(stats["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
	        										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
	        									
	        										if(t == 6){
	        											tot = sumArray[t];
	        										}
	        										
	        										row += "<td>" + numComma(sumArray[t]) + "</td>";
	        									}
	    									}
	            						})
	            						
	            						if(dsaYN == "Y"){
	            							$.each(caseStatd, function(index, statd) {
	        									if(entry["codeCode"] == statd["codeCode"]){
	            									row += "<td class='sellDisable'>" + statd["fieldName" + data1.codename[t]] + "</td>";
	            									
	            									//남자인경우 남자값으로 초기화
	            									if(statd["victimSex"] == "M"){
	            										sumDrray[t] = statd["fieldName"+data1.codename[t]];
	            									} else if(statd["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
	            										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
	            									} else if(statd["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
	            										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
	            										
	            										row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
	            									}
	        									}
	                						})
	            						}
	            					}
	            					
	                				row += "</tr>";
	                				
	                				if(data1.termType == "Y" && tot == 0){
	                					
	                				} else {
	                					table += row;
	                				}
                				}
            				} else {
            					
            					if(entry["victimSex"] == "M"){
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            					} else if (entry["victimSex"] == "F") {
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            					} else if(entry["victimSex"] == "E"){
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            						
                					tot = 0;
                					row = "<tr>";
                					
                					row += "<th>" + entry["centerName"] + "</th>";
                					
                					for(var t=6; t<codeCount2; t++){
                						if(t == 6){
                							tot = sumArray[t];
                						}
                						
                						row += "<td>" + numComma(sumArray[t]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                							row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
                						}
                					}
                					
                					row += "</tr>";
                					
                					if(data1.termType == 'Y' && tot == 0){
                						
                					} else {
                						table += row;
                					}
                				}
                			}
        					
            			}
        			}else{
        				if(data1.totYN != 'Y'){
            				if(sexYN == 'Y'){
                				if(cCode != entry["codeCode"]){
	            					var tot = 0;
	            					var row = "<tr>";
	            					
	            					if(entry["victimSex"] == "M"){
	            						row = row + "<th" + sexRowspan + ">" + entry["centerName"] + "</th>";
	            					}
	            					
	            					//전체 합계값 출력
	            					for(var t=6; t<codeCount2; t++){
	            						$.each(caseStats, function(index, stats) {
	    									if(entry["codeCode"] == stats["codeCode"]){
	        									
	        									row += "<td>" + stats["fieldName"+data1.codename[t]] + "</td>";
	        									
	        									//남자인경우 남자값으로 초기화
	        									if(stats["victimSex"] == "M"){
	        										sumArray[t] = stats["fieldName"+data1.codename[t]];
	        									} else if(stats["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
	        										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
	        									} else if(stats["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
	        										sumArray[t] = sumArray[t] + stats["fieldName"+data1.codename[t]];
	        									
	        										if(t == 6){
	        											tot = sumArray[t];
	        										}
	        										
	        										row += "<td>" + numComma(sumArray[t]) + "</td>";
	        									}
	    									}
	            						})
	            						
	            						if(dsaYN == "Y"){
	            							$.each(caseStatd, function(index, statd) {
	        									if(entry["codeCode"] == statd["codeCode"]){
	            									row += "<td class='sellDisable'>" + statd["fieldName" + data1.codename[t]] + "</td>";
	            									
	            									//남자인경우 남자값으로 초기화
	            									if(statd["victimSex"] == "M"){
	            										sumDrray[t] = statd["fieldName"+data1.codename[t]];
	            									} else if(statd["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
	            										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
	            									} else if(statd["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
	            										sumDrray[t] = sumDrray[t] + statd["fieldName"+data1.codename[t]];
	            										
	            										row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
	            									}
	        									}
	                						})
	            						}
	            					}
	            					
	                				row += "</tr>";
	                				
	                				if(data1.termType == "Y" && tot == 0){
	                					
	                				} else {
	                					table += row;
	                				}
                				}
            				} else {
            					if(entry["victimSex"] == "M"){
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            					} else if (entry["victimSex"] == "F") {
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            					} else if(entry["victimSex"] == "E"){
            						for(var t=6; t<codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldName" + data1.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldName" + data1.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + caseStatd[i]["fieldName" + data1.codename[t]];
            							}
            						}
            						
                					tot = 0;
                					row = "<tr>";
                					
                					row += "<th>" + entry["centerName"] + "</th>";
                					
                					for(var t=6; t<codeCount2; t++){
                						if(t == 6){
                							tot = sumArray[t];
                						}
                						
                						row += "<td>" + numComma(sumArray[t]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                							row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
                						}
                					}
                					
                					row += "</tr>";
                					
                					if(data1.termType == 'Y' && tot == 0){
                						
                					} else {
                						table += row;
                					}
                				}
                			}
        					
            			}
        			}
        			
        			cCode = entry["codeCode"];
        			/* if(sexYN == "Y"){
        				i += 2;
        			} */
        		})
        		
        		table += "</table>";
        		
        		if(data1.isAdmin){
        			table += "<div id='divBtnExcelExport' class='btnGroup' style='display:none;'>";
        			table += "<input type='button' id='btnExcelExport' class='pure-button btnSave' value='엑셀저장'>";
        			table += "</div>";
        		}
        	} else {
        		table += "<table>";
        		table += "<tr style='height:50px;'>";
        		table += "<th style='background-color:#ffffff;' rowspan='100'>결과값이 없습니다.</th>";
        		table += "</tr>";
        		table += "</table>";
        	}
        	
            $('#lblList').html(table);

            if (isFinish=='Y') {
                $('#divLoadingImage').empty();
            }
            
            $("#lblList td").hover(function() {
    			$el = $(this);
    			
    			$el.parent().addClass("selHover");
    			
    			if($el.parent().has('th[rowspan]').length == 0){
    				$el
    				.parent()
    				.prevAll('tr:has(th[rowspan]):first')
    				.find('th[rowspan]')
    				.removeClass("sellDisable")
    				.addClass("selHover");
    			}
    		}, function() {
    			$el
    			.parent()
    			.removeClass("selHover")
    			.prevAll("tr:has(th[rowspan]):first")
    			.find('th[rowspan]')
    			.removeClass("selHover");
    		});
            
            if(data1.isAdmin){
    			if(!ekrJs.isMsie()){
    				$("#divBtnExcelExport").show();
    			}
    			
    			$("#btnExcelExport").click(function(){
    				filePopZip();
    			});
            }

        }, error: function(xhr,status,error){
            alert('데이터를 처리하지 못했습니다.\n이유 : '+ error);
            $('#divLoadingImage').empty();
        }
    });		

    //setCookies4Search();

}



	function incSearchRunAction() {

        $('#lblList').empty();

        $('#divLoadingImage').empty();
        $('#divLoadingImage').append("<center><img src='/static/bos/image/loading_long.gif'><br><br></center>");

        getResultData();

    }

    function doSearchFormOpen() {
        $('#btnOption').text("검색옵션 축소");
        $('.trExtend').show();
        $('#searchOption').val("open");
        $.cookie('srcCookieExtende',  'open', { expires: 7, path: '/' });
    }

    function doSearchFormClose() {
        $('#btnOption').text("검색옵션 확장");
        $('.trExtend').hide();
        $('#searchOption').val("close");
        $.cookie('srcCookieExtende',  'close', { expires: 7, path: '/' });
    }

	function setUserSelectByCenterChoice(CENTER_CODE) {
		$('#src_CSL_ID').find('option').each( function() { $(this).remove(); } ).end().append("<option value=''>전체선택</option>") ;
		$('#src_CSL_IDJiwon').find('option').each( function() { $(this).remove(); } ).end().append("<option value=''>전체선택</option>") ;
		var src_CSL_IDState = $("select[name=src_CSL_IDState] option:selected").val();

		$.ajax({
			url : "/bos/instance/case/findCaseCenterList.json?srcState=" + src_CSL_IDState +"&centerCodeSub="+CENTER_CODE, 
			dataType : "json", 
			async : false
		}).done(
			function(retVal) {
				values = retVal.resultList ;
				$("#src_CSL_ID").empty();
				if(values.length > 0){
					$("#src_CSL_ID").append('<option value="">선택</option>');
					$.each(values, function( index, value ) {
						var selected = "";
						if("${paramVO.srcCslId}" == value.userId ){
							selected = "selected";
						}
						$("#src_CSL_ID").append('<option value="' + value.userId + '" ' +selected+ ' >' + value.userName + '</option>');
					});
				}else{
					$("#src_CSL_ID").append('<option value="">없음</option>');
				}
		});
	}
	
	
	
	function fn_cdStateChange() {
    	var srcState = $("#srcState").val();
    	
    	var centerCodeSub = $("#src_CNTR_COD").val();
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
				$("#src_CSL_ID").empty();
				if(values.length > 0){
					$("#src_CSL_ID").append('<option value="">선택</option>');
					$.each(values, function( index, value ) {
						var selected = "";
						if("${paramVO.srcCslId}" == value.userId ){
							selected = "selected";
						}
						$("#src_CSL_ID").append('<option value="' + value.userId + '" ' +selected+ ' >' + value.userName + '</option>');
					});
				}else{
					$("#src_CSL_ID").append('<option value="">없음</option>');
				}
		});
	}

    function setUserSelectByCenterChoice2(CENTER_CODE) {
        $('#CASE_MANAGER').find('option').each( function() { $(this).remove(); } ).end().append("<option value=''>전체선택</option>") ;
        var CASE_MANAGERState = $("select[name=CASE_MANAGERState] option:selected").val();

        $.getJSON("/user/json/get_center_user.asp", { center_code: CENTER_CODE , ADMSN_YN: CASE_MANAGERState , "nocache": new Date().getTime() }, function(data1) {
            $.each(data1, function(index, entry) {
                $('#CASE_MANAGER').append("<option value='"+ entry["USER_ID"] +"'>"+ entry["USER_NAME"] +"</option>") ;
            });
        });
    }

	function setUserStateSelectByCenterChoice() {
	    if( $('select[name=src_CNTR_COD]').length>0 ) {

		    var val_CNTR_COD = $('select[name=src_CNTR_COD]').val();

		    if(isDefined(val_CNTR_COD) && val_CNTR_COD.length>0) {
		    	setUserSelectByCenterChoice(val_CNTR_COD);
		    } else {
				setUserSelectByCenterChoice('304');
			}
	    } else {
			setUserSelectByCenterChoice('304');
		}
	}

    function setUserStateSelectByCenterChoice2() {
        if( $('select[name=src_CNTR_COD]').length>0 ) {

            var val_CNTR_COD = $('select[name=src_CNTR_COD]').val();

            if(isDefined(val_CNTR_COD) && val_CNTR_COD.length>0) {
                setUserSelectByCenterChoice2(val_CNTR_COD);
            } else {
                setUserSelectByCenterChoice2('304');
            }
        } else {
            setUserSelectByCenterChoice2('304');
        }
    }
    
    $(function() {
   		fn_cdStateChange('');
   	});
</script>



    <div style="margin-top:-32px; margin-bottom:15px;">

        <form id="formSearch" method="POST" class="pure-form">

            <input type="hidden" id="pageType" name="pageType" value="" />
            <input type="hidden" id="searchOption" name="searchOption" value="close" />
            <input type="hidden" name="targetType" value="" />
            <input type="hidden" name="CHEK_CASE_TYPE_VALUE" id="CHEK_CASE_TYPE_VALUE" value="" />
            <input type="hidden" name="userCenterCode" id="userCenterCode" value="${userVO.centerCode }"/>

            <table class="pure-table pure-table-bordered" style="width:100%;">
                <colgroup>
                    <col style="width:150px;" />
                    <col style="width:500px;" />
                    <col style="width:130px;" />
                    <col style="width:200px;" />
                </colgroup>

                

    <tr style="height:40px;">
      <td style="text-align: center;">사례등록일
          <img class="btnDeleteSearchDateRage" src='/static/bos/image/cross-th.png' style="width:10px; height:10px;">
      </td>
      <td colspan=3>
        <select id="searchYear" name="searchYear">
			<c:forEach begin="0" end='${nowYear - 2000 }' var="y" step="1">
				<option value='${nowYear - y }' ${paramVO.searchYear eq (nowYear-y) ? "selected" : "" }>${nowYear - y } 년</option>
			</c:forEach>
		</select>
		<select id="searchHalf" name="searchHalf">
			<!-- <option>반기선택</option> -->
			<option value='1'>전반기</option>
			<option value='2'>후반기</option>
		</select>
		<select id="searchQuater" name="searchQuater">
			<!-- <option>분기선택</option> -->
			<c:forEach begin="1" end="4" var="q" step="1">
				<option value='${q }' ${paramVO.searchQuater eq q ? "selected" : ""}>${q } 분기</option>
			</c:forEach>
		</select>
		<select id="searchMonth" name="searchMonth">
			<!-- <option>월 선택</option> -->
				<c:forEach begin="1" end="12" var="m"  varStatus="status" >
					<option value="<util:fz source='${m}' resultLen='2' isFront='true' />" ${paramVO.searchMonth eq m ? "selected" : ""}>
						<util:fz source='${m}' resultLen='2' isFront='true' />월
					</option>
				</c:forEach>
		</select>

        <input type="text" name="cond_frdate" id="cond_frdate" class="formatDate" value="2020-12-22" />
        <span id="cond_spdate"> ~ </span>
        <input type="text" name="cond_todate" id="cond_todate" class="formatDate" value="2020-12-22" />

        &nbsp;&nbsp;&nbsp;
        <input type="radio" class="check" name="term_type" value="N" /><label for="type6" style="padding-right:10px;">전체</label>
        <input type="radio" class="check" name="term_type" value="Y" /><label for="type6" style="padding-right:10px;">년간</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="H" /><label for="type5" style="padding-right:10px;">반기</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="Q" /><label for="type4" style="padding-right:10px;">분기</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="M" /><label for="type3" style="padding-right:10px;">월간</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="W" /><label for="type2" style="padding-right:10px;">주간</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="D" /><label for="type1" style="padding-right:10px;">일간</label>&nbsp;
        <input type="radio" class="check" name="term_type" value="T" /><label for="type7" style="padding-right:10px;">직접입력</label>

        <div>

            <div id="choiceDate"></div>
            <div class="week-picker"></div>

        </div>
      </td>
    </tr>
  

  <script>

  var now = "${nowDate}";
	var nowSplit = now.split("-");
	
	var q = Math.ceil(parseInt(nowSplit[1])/3);
	
	if(q == 1 || q == 2) var h=1;
	if(q == 3 || q == 4) var h=2;

	var thisSearchYear = nowSplit[0];
	var thisSearchHalf = h;
	var thisSearchQuater = q;
	var thisSearchMonth = parseInt(nowSplit[1]);

  if ( isDefined($.cookie('srcCookieYear')) ) {
    thisSearchYear = $.cookie('srcCookieYear');
  }
  if ( isDefined($.cookie('srcCookieHalf')) ) {
    thisSearchHalf = $.cookie('srcCookieHalf');
  }
  if ( isDefined($.cookie('srcCookieQuater')) ) {
    thisSearchQuater = $.cookie('srcCookieQuater');
  }
  if ( isDefined($.cookie('srcCookieMonth')) ) {
    thisSearchMonth = $.cookie('srcCookieMonth');
  }


  if ( isDefined($.cookie('srcCookieBdate')) ) {
      $("#cond_frdate").val($.cookie('srcCookieBdate'));
  } else {
  	$("#cond_frdate").val("${nowDate}");
  }
  if ( isDefined($.cookie('srcCookieEdate')) ) {
      $("#cond_todate").val($.cookie('srcCookieEdate'));
  } else {
  	$("#cond_todate").val("${nowDate}");
  }

  if ( isDefined($.cookie('srcCookieTtype')) ) {
     $("input:radio[name=term_type]:input[value="+ $.cookie('srcCookieTtype') +"]").attr("checked",true);
     $("#searchYear > option[value='"+ $.cookie('srcCookieYear') +"']").attr("selected", true );
     $("#searchHalf > option[value='"+ $.cookie('srcCookieHalf') +"']").attr("selected", true );
     $("#searchQuater > option[value='"+ $.cookie('srcCookieQuater') +"']").attr("selected", true );
     $("#searchMonth > option[value='"+ $.cookie('srcCookieMonth') +"']").attr("selected", true );
     setTerm_Type( $.cookie('srcCookieTtype') );
  } else {

  $("input[name=term_type]:input[value=D]").attr("checked", true);
  	setTerm_Type('D');
  }

    function init_date() {
        $('#choiceDate').hide();
        $('.week-picker').hide();
        $('#searchMonth').hide();
        $('#searchQuater').hide();
        $('#searchHalf').hide();
        $('#searchYear').hide();

        /*
        $('#searchYear').val( thisSearchYear );
        $('#searchHalf').val( thisSearchHalf );
        $('#searchQuater').val( thisSearchQuater );
        $('#searchMonth').val( thisSearchMonth );
        */

        $('#areaTermSelect').show();

        $('#cond_frdate').css('border-color', '#FFFFFF');
        $('#cond_todate').css('border-color', '#FFFFFF');
    }

    function setTerm_Type(term_type) {
        init_date();

        if(term_type=='D') {
            $('#choiceDate').show();
            setDateByDay();

            $('#cond_frdate').show();
            $('#cond_todate').show();
            $('#cond_spdate').show();

        } else if (term_type=='W') {
            $('.week-picker').show();
            setDateByWeek();

            $('#cond_frdate').show();
            $('#cond_todate').show();
            $('#cond_spdate').show();

        } else if (term_type=='M') {
            $('#searchYear').show();
            $('#searchMonth').show();
            setDateByMonth();

            $('#cond_frdate').hide();
            $('#cond_todate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='Q') {
            $('#searchYear').show();
            $('#searchQuater').show();
            setDateByQuater();

            $('#cond_frdate').hide();
            $('#cond_todate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='H') {
            $('#searchYear').show();
            $('#searchHalf').show();
            setDateByHalf();

            $('#cond_frdate').hide();
            $('#cond_todate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='Y') {
            $('#searchYear').show();
            setDateByYear();

            $('#cond_frdate').hide();
            $('#cond_todate').hide();
            $('#cond_spdate').hide();

        } else if (term_type=='T') {
            $('#areaTermSelect').hide();
            $('#cond_frdate').css('border-color', '#333333');
            $('#cond_todate').css('border-color', '#333333');

            $('#cond_frdate').show();
            $('#cond_todate').show();
            $('#cond_spdate').show();

        } else if (term_type=='N') {
            $('#cond_frdate').val("");
            $('#cond_todate').val("");

            $('#cond_frdate').hide();
            $('#cond_todate').hide();
            $('#cond_spdate').hide();
        }
    }

    //기간구분 선택시 액션
    $("input[name=term_type]").change(function(){
      //setTerm_Type($("input[name=term_type]:radio:checked").val());
      setTerm_Type($(this).val());
    });

    $('#searchMonth').change( function() {
      setDateByMonth();
    });
    $('#searchQuater').change( function() {
      setDateByQuater();
    });
    $('#searchHalf').change( function() {
      setDateByHalf();
    });
    $('#searchYear').change( function() {
      var term_type = $("input[name=term_type]:radio:checked").val();

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

    // 기간구분 선택시 설정
    function setDateByDay() {
    	$('#cond_frdate').val('${nowDate}');
        $('#cond_todate').val('${nowDate}');
    }

    function setDateByWeek() {
    }

    function setDateByMonth() {
        var s2Month = ",1896,1904,1908,1912,1916,1920,1924,1928,1932,1936,1940,1944,1948,1952,1956,1960,1964,1968,1972,1976,1980,1984,1988,1992,1996,";
           s2Month+= "2000,2004,2008,2012,2016,2020,2024,2028,2032,2036,2040,2044,2048,2052,2056,2060,2064,2068,2072,2076,2080,2084,2088,2092,2096";
        var eYear = $('#searchYear').val();
        var eMonth = $('#searchMonth').val();

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

          var sdate = $('#searchYear').val() +"-"+ $('#searchMonth').val() +"-01";
          var edate = $('#searchYear').val() +"-"+ $('#searchMonth').val() +"-"+ eDay;
          $('#cond_frdate').val(sdate);
          $('#cond_todate').val(edate);
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

          var sdate = $('#searchYear').val() +"-"+ sDay;
          var edate = $('#searchYear').val() +"-"+ eDay;
          $('#cond_frdate').val(sdate);
          $('#cond_todate').val(edate);
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

          var sdate = $('#searchYear').val() +"-"+ sDay;
          var edate = $('#searchYear').val() +"-"+ eDay;
          $('#cond_frdate').val(sdate);
          $('#cond_todate').val(edate);
        }
    }

    function setDateByYear() {
        var sdate = $('#searchYear').val() +"-01-01";
        var edate = $('#searchYear').val() +"-12-31";
        $('#cond_frdate').val(sdate);
        $('#cond_todate').val(edate);
    }

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
          $('#cond_frdate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
          $('#cond_todate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

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
        $('#cond_frdate').val($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
        $('#cond_todate').val($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

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
        $('#cond_frdate').css('border-color', '#333333');
        $('#cond_todate').css('border-color', '#333333');

        $('#cond_frdate').val("").show();
        $('#cond_todate').val("").show();
        $('#cond_spdate').show();

        $("#formSearch input:radio[name='term_type']").prop("checked", false);

    });

    //$('.week-picker .ui-datepicker-calendar tr').live('mousemove', function() { $(this).find('td a').addClass('ui-state-hover'); });
    //$('.week-picker .ui-datepicker-calendar tr').live('mouseleave', function() { $(this).find('td a').removeClass('ui-state-hover'); });


    /*
    // A click on a week number cell in the weeks column of the start datepicker
    $("td.ui-datepicker-week-col").live("click", function() {
          // Simulate a click on the first day of the week
          $(this).next().click();

          // Grab the date, and set the end of the week in the end datepicker
          var frDate = $("#choiceDateEnd").datepicker("getDate");
          var strDateBegin = frDate.getFullYear() +'-'+ getAddZeros(frDate.getMonth()+1, 2) +'-'+ getAddZeros(frDate.getDate(), 2);
          var toDate = frDate;
          toDate.setDate(frDate.getDate() + 6);
          //$("#inputEndDate").datepicker("setDate", toDate);

          //$("#inputStartDate").val(frDate);
          var strDateEnded = toDate.getFullYear() +'-'+ getAddZeros(toDate.getMonth()+1, 2) +'-'+ getAddZeros(toDate.getDate(), 2);
        $("#inputEndDate").val(strDateEnd);
    });
    */


    function setCookies4SearchDate() {
/*
        $.cookie('srcCookieTtype',  $("input[name=term_type]:radio:checked").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieBdate',  $("#cond_frdate").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieEdate',  $("#cond_todate").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieYear',   $("#searchYear option:selected").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieHalf',   $("#searchHalf option:selected").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieQuater', $("#searchQuater option:selected").val(), { expires: 7, path: '/' });
        $.cookie('srcCookieMonth',  $("#searchMonth option:selected").val(), { expires: 7, path: '/' });*/
    }

  </script>

        <c:choose>
				<c:when test="${(userVO.authorCd eq 'CA') || (userVO.authorCd eq 'CU') || (userVO.authorCd eq 'ROLE_SUPER') }">
					<tr>
						<td style="text-align: center;">센터 구분</td>
						<td colspan=3>
							<select name="src_CNTR_GBN" id="src_CNTR_GBN" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','src_CNTR_COD',this.value , '', 'N')">
								<script>
									getCmmnCd.select('CM04', 'src_CNTR_GBN', '${paramVO.src_CNTR_GBN}', 'N');
								</script>
							</select>
							&nbsp;
							<select name="src_CNTR_COD" id="src_CNTR_COD" title="센터 구분 서브">
								<script>
									getCmmnCd.subSelect('CM05', 'src_CNTR_COD', '${paramVO.src_CNTR_GBN}', '${paramVO.src_CNTR_COD}', 'N')
								</script>
							</select> 
							
							<!--
							<input type="hidden" id="src_CGB" name="src_CGB" value="${fn:substring(userVO.centerCode,0,1) }" />
							<input type="hidden" id="src_CCD" name="src_CCD" value="${userVO.centerCode }" />
							-->
							
							<span style="color:green;padding-left:20px;">(참고:한국여성인권진흥원에서만 나타나는 메뉴입니다)</span>
							<br/>
							
							<div id="selectCenterCodeDiv" style="display: none;">
								<script>
									getCmmnCd.checkBox('CM05', 'selectCenterCodeDiv', 'CHECK_CNTR_COD', '${paramVO.CHECK_CNTR_COD}', '4');
								</script>
							</div>
						</td>
					</tr>

					<script>
            $('#src_CNTR_GBN').append("<option value='XXX'>특정센터선택</option>");

            $("#src_CNTR_GBN").on("change", function() {
                setCenterGbnChange();
            });

            function setCenterGbnChange(centerCode) {
                var gNum = $("#src_CNTR_GBN").val();
                if (gNum=='') {
                  $("#src_CNTR_COD").hide();
                } else {
                  if (gNum!='XXX') {
                    $("#src_CNTR_COD").show();
                  }
                }

                if (gNum!='XXX') {
                  $("#selectCenterCodeDiv").hide();
                } else {
                  $("#src_CNTR_COD").hide();
                  $("#selectCenterCodeDiv").show();
                }

                //fnSelectChangeSelectWhere('src_CNTR_COD', 'CM05', 'TXT1', $("#src_CNTR_GBN").val(), centerCode, 'TXT4', 'Y', '전체 선택');
                //fnSelectChangeSelectWhere('src_CNTR_COD', 'CM05', 'TXT1', $("#src_CNTR_GBN").val(), centerCode, '', '', '전체 선택');
                //fnSelectChangeSelect('src_CNTR_COD', $("#src_CNTR_GBN > option:selected").attr("ref"), 'CODE_GROUP',gNum,centerCode);
                $('#totYN').attr("checked", false);
            }

            function setCenterGubunCode2Real() {

                $('#src_CGB').val($('#src_CNTR_GBN').val());
                $('#src_CCD').val($('#src_CNTR_COD').val());
            }

            function setCookies4SearchCenter() {
                $.cookie('srcCookieCGB',    $("select[name=src_CNTR_GBN] option:selected").val(), { expires: 7, path: '/' });
                $.cookie('srcCookieCCD',    $("select[name=src_CNTR_COD] option:selected").val(), { expires: 7, path: '/' });
            }

            /* 쿠키로 검색기록 기능 제거 */
            if ( isDefined($.cookie('srcCookieCGB')) ) {
                $("#src_CNTR_GBN>option[value="+ $.cookie('srcCookieCGB') +"]").attr("selected", true);

                var centerCode = "";
                if ( isDefined($.cookie('srcCookieCCD')) ) {
                  centerCode = $.cookie('srcCookieCCD');
                }

                setCenterGbnChange(centerCode);
            }

            if ( $.cookie('srcCookieCGB')==null || $.cookie('srcCookieCGB')=="" ) {
                $("#src_CNTR_COD").hide();
            }

					</script>
				</c:when>
				<c:otherwise>
					<input type="hidden" id="src_CNTR_GBN" name="src_CNTR_GBN" value="${fn:substring(userVO.centerCode,0,1) }" />
			        <input type="hidden" id="src_CNTR_COD" name="src_CNTR_COD" value="${userVO.centerCode }" />
			
			        <!--
			        <input type="hidden" id="src_CGB" name="src_CGB" value="${fn:substring(userVO.centerCode,0,1) }" />
			        <input type="hidden" id="src_CCD" name="src_CCD" value="${userVO.centerCode }" />
			        -->
				</c:otherwise>
			</c:choose>

    
    <tr class="" style="height:38px;">
        <td style="text-align: center;">피해 구분</td>
        <td colspan=3>
            <div>
                <input type='checkbox' name='CHEK_CASE_TYPE_all' value='Y' CHECKED="" id='CHEK_CASE_TYPE_all' />
                <label for='CHEK_CASE_TYPE_all'><b style="color:orange;">전체선택</b></label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE01' name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='01' checked  />성폭력</span>
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE02'  name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='02' checked   />가정폭력</span>
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE03' name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='03' checked  />성매매</span>
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE05' name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='05' checked  />스토커</span>
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE06' name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='06' checked  />데이트폭력</span>
                <span style='display:inline-block; width:120px;'><input type='checkbox' id='CHEK_CASE_TYPE11' name='CHEK_CASE_TYPE' class='CHEK_CASE_TYPE' value='11' checked  />기타</span><br>
            </div>
        </td>
    </tr>
    <script>
        /*******************************************************
         * 체크박스 전체 선택
         */
        var checkAllSubName= "CHEK_CASE_TYPE";	//여기만 수정해요

        $("#"+ checkAllSubName +"_all").click(function(){
          setCheckBoxAllSelect9(this, checkAllSubName);
        });
        $("input[name="+ checkAllSubName +"]").click(function(){
          setCheckBoxAllLease9(checkAllSubName +"_all");
        });
        /*******************************************************/

        function setCookies4CaseGubun() {

            var varCheckAll= $("input[name="+ checkAllSubName +"_all]:checkbox:checked").val();
            var varCheck01 = $("input[name="+ checkAllSubName +"]:checkbox[value='01']:checked").val();
            var varCheck02 = $("input[name="+ checkAllSubName +"]:checkbox[value='02']:checked").val();
            var varCheck03 = $("input[name="+ checkAllSubName +"]:checkbox[value='03']:checked").val();
            var varCheck03 = $("input[name="+ checkAllSubName +"]:checkbox[value='05']:checked").val();
            var varCheck03 = $("input[name="+ checkAllSubName +"]:checkbox[value='06']:checked").val();
            var varCheck11 = $("input[name="+ checkAllSubName +"]:checkbox[value='11']:checked").val();

            var setCheckAll= 'Y';
            var setCheck01 = 'Y';
            var setCheck02 = 'Y';
            var setCheck03 = 'Y';
            var setCheck11 = 'Y';

            if ( varCheckAll==null || varCheckAll=="" ) setCheckAll= 'N';
            if ( varCheck01 ==null || varCheck01 =="" ) setCheck01 = 'N';
            if ( varCheck02 ==null || varCheck02 =="" ) setCheck02 = 'N';
            if ( varCheck03 ==null || varCheck03 =="" ) setCheck03 = 'N';
            if ( varCheck11 ==null || varCheck11 =="" ) setCheck11 = 'N';

            $.cookie('srcCookieGubunAll', setCheckAll, { expires: 7, path: '/' });
            $.cookie('srcCookieGubun01',  setCheck01,  { expires: 7, path: '/' });
            $.cookie('srcCookieGubun02',  setCheck02,  { expires: 7, path: '/' });
            $.cookie('srcCookieGubun03',  setCheck03,  { expires: 7, path: '/' });
            $.cookie('srcCookieGubun05',  setCheck05,  { expires: 7, path: '/' });
            $.cookie('srcCookieGubun06',  setCheck06,  { expires: 7, path: '/' });
            $.cookie('srcCookieGubun11',  setCheck11,  { expires: 7, path: '/' });
        }

        /* 쿠키로 검색기록 기능 제거 */
        if ( isDefined($.cookie('srcCookieGubunAll')) && $.cookie('srcCookieGubunAll')=='N' ) {
            $("input[name="+ checkAllSubName +"_all]:checkbox").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun01')) && $.cookie('srcCookieGubun01')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='01']").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun02')) && $.cookie('srcCookieGubun02')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='02']").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun03')) && $.cookie('srcCookieGubun03')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='03']").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun05')) && $.cookie('srcCookieGubun05')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='05']").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun06')) && $.cookie('srcCookieGubun06')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='06']").attr('checked', false);
        }
        if ( isDefined($.cookie('srcCookieGubun11')) && $.cookie('srcCookieGubun11')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='11']").attr('checked', false);
        }

    </script>

	<tr class="trExtend" style="height:40px;">
        <td style="width:150px; text-align:center;">사례통계기준</td>
        <td colspan="3" style="width:830px; padding:0;">

            <table class="pure-table pure-table-bordered" style="width:100%;border:0px;margin:0;" border="0 none">
                <colgroup>
                    <col style="width:130px;">
                    <col style="width:520px;">
                    <col style="width:110px;">
                    <col style="width:120px;">
                </colgroup>

                <tbody><tr style="height:40px;">
                    <td style="text-align: center;">[피해구분]</td>
                    <td>
                        <span style="display:inline-block; width:60px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE" checked="">전체</span>
                        <span style="display:inline-block; width:70px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_01">성폭력</span>
                        <span style="display:inline-block; width:80px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_02">가정폭력</span>
                        <span style="display:inline-block; width:70px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_03">성매매</span>
                        <span style="display:inline-block; width:70px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_05">스토커</span>
                        <span style="display:inline-block; width:100px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_06">데이트폭력</span>
                        <span style="display:inline-block; width:60px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_11">기타</span>
                    </td>
                    <td style="text-align: center;">접수 담당자</td>
                    <td>
                    	<select id="srcState" name="srcState" onchange="fn_cdStateChange();" >
					        <option value="Y" <c:if test="${paramVO.srcState == 'Y'}">selected="selected"</c:if>>재직자</option>
					        <option value="S" <c:if test="${paramVO.srcState == 'S'}">selected="selected"</c:if>>휴직자</option>
					        <option value="N" <c:if test="${paramVO.srcState == 'N'}">selected="selected"</c:if>>퇴직자</option>
					    </select>
                        <select id="src_CSL_ID" name="src_CSL_ID">
                        	<option value="">선택</option>
                       	</select>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">접수정보</td>
                    <td colspan="3" style="padding:2px;">
                        &nbsp;&nbsp;&nbsp;
                        접수방법 : <select id="joinCASE_JUPSOO" name="joinCASE_JUPSOO" style="width:80px;" ref="CS20"> <option value="">선택</option><option value="1" data-grpcode="" data-subcode="S" alt="">전화</option><option value="2" data-grpcode="" data-subcode="S" alt="">내방</option><option value="4" data-grpcode="" data-subcode="S" alt="">방문</option><option value="3" data-grpcode="" data-subcode="S" alt="">사이버</option><option value="5" data-grpcode="" data-subcode="S" alt="">기타</option></select>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        의뢰인과 피해자와의 관계 : &nbsp;<select id="CLIENT_REL_GRP" name="CLIENT_REL_GRP" style="width: 160px; " ref="CS24G">
                        	<script>
								getCmmnCd.selectStats('CS24G', 'CLIENT_REL_GRP', '${paramVO.CLIENT_REL_GRP}', 'N', '전체');
							</script> 
	                        <!-- <option value="">전체</option>
	                        <option value="11" data-grpcode="20" data-subcode="" alt="">가족</option>
	                        <option value="03" data-grpcode="20" data-subcode="" alt="">친인척</option>
	                        <option value="07" data-grpcode="20" data-subcode="" alt="">지인(친구)</option>
	                        <option value="13" data-grpcode="20" data-subcode="" alt="etc">기타 주변인</option>
	                        <option value="04" data-grpcode="30" data-subcode="" alt="">수사기관</option>
	                        <option value="06" data-grpcode="30" data-subcode="" alt="">여성폭력피해자지원기관</option>
	                        <option value="21" data-grpcode="30" data-subcode="" alt="">타해바라기센터</option>
	                        <option value="22" data-grpcode="30" data-subcode="" alt="">사회복지기관</option>
	                        <option value="05" data-grpcode="30" data-subcode="" alt="">교육기관</option><option value="09" data-grpcode="30" data-subcode="" alt="">관공서</option><option value="15" data-grpcode="30" data-subcode="" alt="">긴급전화</option><option value="14" data-grpcode="30" data-subcode="" alt="etc">기타 기관관계자</option> -->
                        </select>
                    </td>
                </tr>
                <tr style="height:40px;">
                    <td style="text-align: center;">피해자정보</td>
                    <td colspan="3" style="padding:2px;">
                        &nbsp;&nbsp;&nbsp;
                        거주지 :<select id='VICTIM_AREA_GRP' name='VICTIM_AREA_GRP' style='width: 120px;' ref='HM46'>
										<script>
											getCmmnCd.selectStats('HM46', 'VICTIM_AREA_GRP', '${paramVO.VICTIM_AREA}', 'N', '거주지역 전체');
										</script>
									</select>
                        &nbsp;&nbsp;&nbsp;
                        피해자의 센터인지경로 : <select id='CASE_ROUTE_GRP' name='CASE_ROUTE_GRP' style='width: 120px;' ref='CSRTG'>
										<script>
											getCmmnCd.selectStats('CSRTG', 'CASE_ROUTE_GRP', '${paramVO.CASE_ROUTE_GRP}', 'N', '전체');
										</script>
									</select>
                        &nbsp;&nbsp;&nbsp;
                        
                    </td>
                </tr>


                <tr style="height:40px;">
                    <td style="text-align: center;">피해자 특성</td>
                    <td colspan="3" style="padding:2px; padding-left:15px;">
                        <div>
                            <span style="display:inline-block; width:200px;">
                                내외국인여부 :
                                <select id="VICTIM_FRGER" name="VICTIM_FRGER" style="width:100px;">
                                    <script>
											getCmmnCd.selectStats('CSA7', 'VICTIM_FRGER', '${paramVO.VICTIM_FRGER}', 'N', '전체');
										</script>
                                </select>
                            </span>

                            <!-- <span style="display:inline-block; width:90px;">
                                장애여부 : <input type="checkbox" id="VICTIM_DISABLE" name="VICTIM_DISABLE" value="Y">
                                
                            </span> -->
							
							<span style="display: inline-block; width: 160px;"> 
								장애여부:<select id="VICTIM_DISABLE" name="VICTIM_DISABLE" style="width: 100px;">
									<option value="">전체</option>
									<option value="00">장애 없음</option>
									<option value="01">지적 장애</option>
									<option value="03">신체 장애</option>
									<option value="02">기타 장애</option>
									<option value="99">모든 장애</option>
								</select>
							</span>
							
                            <span style="display:inline-block; width:130px; padding-left:15px;">
                                성별:<select id='VICTIM_SEX' name='VICTIM_SEX' style='width: 60px;' ref='MF'>
										<script>
											getCmmnCd.selectStats('MF', 'VICTIM_SEX', '${paramVO.VICTIM_SEX}', 'N', '전체');
										</script>
									</select>
                            </span>

                            <span style="display:inline-block; width:180px; padding-left:15px;">
                                연령:
                                <input type="text" id="VICTIM_AGE_FROM2" name="VICTIM_AGE_FROM" style="width:40px;" class="onlyNumber">
                                ~
                                <input type="text" id="VICTIM_AGE_TO2" name="VICTIM_AGE_TO" style="width:40px;" class="onlyNumber">
                                <img id="btnDeleteVictimAges2" src="/static/bos/image/cross-th.png" style="width:10px; height:10px;">
                            </span>
                        </div>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">피해정보</td>
                    <td colspan="3" style="padding:2px; padding-left:15px;">
                        피해시 특이사항 여부
                        <select id="DMG_STATE_YN" name="DMG_STATE_YN" style="width:80px;">
                            <option value="">전체</option>
                            <option value="N">없음</option>
                            <option value="Y">있음</option>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        피해시 특이사항-있음 : <select id='DMG_STATE' name='DMG_STATE' style='width: 60px;' ref='CSDG'>
										<script>
											getCmmnCd.selectStats('CSDG', 'DMG_STATE', '${paramVO.DMG_STATE}', 'N', '전체');
										</script>
									</select>
                    </td>
                </tr>



                <tr style="height:40px;">
                    <td style="text-align: center;">가해자정보</td>
                    <td colspan="3" style="padding:2px; padding-left:15px;">
                        가해시 특이사항 여부
                        <select id="ATTKR_STATE_YN" name="ATTKR_STATE_YN" style="width:80px;">
                            <option value="">전체</option>
                            <option value="N">없음</option>
                            <option value="Y">있음</option>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        가해시 특이사항-있음 : <select id='ATTKER_STATE' name='ATTKER_STATE' style='width: 120px;' ref='ATST'>
										<script>
											getCmmnCd.selectStats('ATST', 'ATTKER_STATE', '${paramVO.ATTKER_STATE}', 'N', '전체');
										</script>
									</select>
                    </td>
                </tr>

                <tr class="trExtend" style="height:40px;">
                    <td style="text-align: center;">가해자 특성</td>
                    <td colspan="3">
                        <div>
                            <span style="display:inline-block; width:200px;">
                                내외국인여부 :
                                <select id="ATTKR_FRGER" name="ATTKR_FRGER" style="width:100px;">
                                  <option value="">전체</option>
                                  <option value="N">내국인</option>
                                  <option value="Y">외국인</option>
                                </select>
                            </span>

                            <!-- <span style="display:inline-block; width:90px;">
                                장애여부:<input type="checkbox" id="ATTKR_DISABLE" name="ATTKR_DISABLE" value="Y">
                            </span> -->
                            
                            <span style="display: inline-block; width: 160px;"> 
								장애여부:<select id="ATTKR_DISABLE" name="ATTKR_DISABLE" style="width: 100px;">
									<option value="">전체</option>
									<option value="00">장애 없음</option>
									<option value="01">지적 장애</option>
									<option value="03">신체 장애</option>
									<option value="02">기타 장애</option>
									<option value="99">모든 장애</option>
								</select>
							</span>

                            <span style="display:inline-block; width:110px; padding-left:20px;">
                                성별:<select id="ATTKR_SEX" name="ATTKR_SEX" style="width:60px;" ref="MF"> <option value="">전체</option><option value="F" data-grpcode="" data-subcode="" alt="">여자</option><option value="M" data-grpcode="" data-subcode="" alt="">남자</option><option value="E" data-grpcode="" data-subcode="" alt="">알수없음</option></select>
                            </span>
                        </div>

                        <div style="padding-top:5px;">
                            <span style="display:inline-block; width:300px;">
                                피해자와의 관계 : <select id="ATTKR_REL_GRP" name="ATTKR_REL_GRP" style="width:150px;" ref="CZ01G">
		                         <script>
									getCmmnCd.selectStats('CZ01G', 'ATTKR_REL_GRP', '${paramVO.ATTKR_REL_GRP}', 'N', '전체');
								</script>    
							</select>
                            </span>

                            <span style="display:inline-block; width:300px;">
                                연령별 : <select id="ATTKR_AGE" name="ATTKR_AGE" style="width:150px;" ref="ATAG">
                         <script>
							getCmmnCd.selectStats('ATAG', 'ATTKR_AGE', '${paramVO.ATTKR_AGE}', 'N', '가해자연령');
						</script>       
                                
                                <!-- <select id="ATTKR_AGE" name="ATTKR_AGE" style="width:150px;" ref="ATAG"> <option value="">전체</option><option value="11" data-grpcode="" data-subcode="" alt="">10세미만</option><option value="12" data-grpcode="" data-subcode="" alt="">10~13세 미만</option><option value="13" data-grpcode="" data-subcode="" alt="">13~19세 미만</option><option value="14" data-grpcode="" data-subcode="" alt="">19세 이상</option><option value="15" data-grpcode="" data-subcode="" alt="">60세 이상</option><option value="19" data-grpcode="" data-subcode="" alt="">알수없음</option></select> -->
                            </span>
                        </div>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">상담정보</td>
                    <td colspan="3" style="padding:2px; padding-left:15px;">
                        지원요청내용 : <select id="CASE_HELP" name="CASE_HELP" style="width:150px;" ref="CDHP">
                         <script>
							getCmmnCd.selectStats('CDHP', 'CASE_HELP', '${paramVO.CASE_HELP}', 'N', '전체');
						</script>  
					</select>
                    </td>
                </tr>
            </tbody></table>

        <script>

            var $CLIENT_REL_OPTION      = $('#CLIENT_REL>option').clone();

            //의뢰인과 피해자와의 관계 하위 선택
            $("#formSearch select[name='CLIENT_REL_GRP']").change(function() {
                fnc_SUB_CLIENT_REL();
            });

            $('#btnDeleteVictimAges2').click(function() {
                $('#VICTIM_AGE_FROM2').val("");
                $('#VICTIM_AGE_TO2').val("");
            });



            function fnc_SUB_CLIENT_REL() {

                var selectOptionVal = $("#formSearch select[name='CLIENT_REL_GRP']").val();
                var selectOptionSub = $("#formSearch select[name='CLIENT_REL_GRP']").find('option:selected').attr('data-subcode');

                if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
                   /*  $("#formSearch select[name='CLIENT_REL']").prop('disabled', true).hide(); */
                } else {

                    $('#CLIENT_REL').html($CLIENT_REL_OPTION);

                    $("#formSearch select[name='CLIENT_REL']").prop('disabled', false).show().find("option").filter(function(index) {
                        var dataGrpcde = $(this).attr("data-grpcode")
                        if (typeof dataGrpcde != "undefined") {
                            if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                        }
                    }).remove();
                }
            }

            fnc_SUB_CLIENT_REL();       //의뢰인과 피해자와의 관계 하위 선택

        </script>

        </td>
    </tr>


    <tr style="height:35px;">
        <td style="text-align: center;">내방 사례 여부</td>
        <td colspan="3">
            <span style="display:inline-block; width:80px;"><input type="checkbox" name="VISIT_CASE_CHECK" value="N" checked=""></span>
        </td>
    </tr>


    <tr style="height:40px;">
        <td style="text-align: center;">산출 형태</td>
        <td colspan="3">
            <span style="display:inline-block; width:80px;"><input type="checkbox" name="dsaYN" id="dsaYN" value="Y" >장애</span>
            <span style="display:inline-block; width:100px;"><input type="checkbox" name="sexYN" id="sexYN" value="Y" >성별 구분
            <input type="hidden" id="src_SEX" name="src_SEX" value="Y">
            </span>
            
            <c:if test="${(userVO.authorCd eq 'CA') || (userVO.authorCd eq 'CU') || (userVO.authorCd eq 'ROLE_SUPER') }">
				<span style="display:inline-block; width:130px;"><input type="checkbox" name="totYN" id='totYN' value="Y">센터별종합실적</span>
			</c:if>
            
        </td>
    </tr>


<%-- 
    <tr class="trExtend" style="height:40px;">
        <td style="width:150px; text-align:center;">사례통계기준</td>
        <td colspan=3 style="width:830px; padding:0;">

            <table class="pure-table pure-table-bordered" style="width:100%;border:0px;margin:0;" border="0 none">
                <colgroup>
                    <col style="width:130px;" />
                    <col style="width:500px;" />
                    <col style="width:110px;" />
                    <col style="width:120px;" />
                </colgroup>
                <tr style="height:40px;">
                    <td style="text-align: center;">접수 시간</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:200px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CASE_TIME_INTVL">1시간 간격</span>
                    </td>
                </tr>
                <tr style="height:40px;">
                    <td style="text-align: center;">피해구분</td>
                    <td>
                        <!--span style="display:inline-block; width:75px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE" checked>전체</span>
                        <span style="display:inline-block; width:75px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_01">성폭력</span>
                        <span style="display:inline-block; width:75px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_02">가정폭력</span>
                        <span style="display:inline-block; width:75px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_03">성매매</span>
                        <span style="display:inline-block; width:75px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_11">기타</span-->
												<span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE" checked>전체</span>
                        <span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_01">성폭력</span>
                        <span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_02">가정폭력</span>
                        <span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_03">성매매</span>
                        <span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_11">기타</span>
												
												<span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_01_AGE">성폭력(연령별)</span>
												<span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_02_AGE">가정폭력(연령별)</span>
												<span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_03_AGE">성매매(연령별)</span>
												<span style="display:inline-block;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CS_TYPE_11_AGE">기타(연령별)</span>
												
                    </td>
                    <td style="text-align: center;">피해구분하위분류</td>
                    <td>
                        <div id="divCsType01Sub">
                            <select name="CS_TYPE_01_SUB">
                                <option value="CS_TYPE" checked>전체</option>
                                <option value="CS_TYPE_01_04">디지털 성범죄</option>
                            </select>
                        </div>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">접수 담당자</td>
                    <td colspan=3 style="padding:2px;">
                        <select id='src_CSL_ID' name='src_CSL_ID' ><option value=''>선택</option><option value='ar0705'>고애리</option><option value='soominkwak'>곽수민</option><option value='kikim'>김구임</option><option value='igrace415'>김미성</option><option value='adore412'>김재원</option><option value='k7j6s626'>김정숙</option><option value='coolsub'>김희덕</option><option value='rhj9165'>류희정</option><option value='logee1'>박은지</option><option value='suhachi82'>박현정</option><option value='teeheehee'>박혜영</option><option value='rubira'>변필순</option><option value='shs8922'>신혜숙</option><option value='july0605'>이미란</option><option value='1004'>이지영</option><option value='pepsi458'>임은혜</option><option value='SJTech_1'>임재휴</option><option value='ms114'>정명신</option><option value='wollala67'>정지숙</option><option value='wlstjgml'>진서희</option><option value='najsm0904'>진수민</option><option value='crpc85'>진정운</option><option value='cyh9708'>최용현</option><option value='u9811078'>최윤화</option><option value='shoonisen'>홍승희</option></select>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">[접수정보]</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:170px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CASE_JUPSOO">접수방법</span>
                        <span style="display:inline-block; width:400px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CLIENT_REL_GRP">의뢰인과 피해자와의 관계
                        &nbsp;&nbsp;&nbsp;<select id='CLIENT_REL_GRP' name='CLIENT_REL_GRP'  style='width:100px;'   ref='CS24G'  > <option value=''>세부구분</option><option value='10' data-grpcode='' data-subcode='' alt='' >본인</option><option value='20' data-grpcode='' data-subcode='CS24' alt='' >주변인</option><option value='30' data-grpcode='' data-subcode='CS24' alt='' >기관관계자</option><option value='50' data-grpcode='' data-subcode='' alt='' >기타</option><option value='40' data-grpcode='' data-subcode='' alt='' >알수없음</option></select>
                        </span>
                    </td>
                </tr>
                <tr style="height:40px;">
                    <td style="text-align: center;">[피해자정보]</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:170px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="VICTIM_AREA">거주지
                        &nbsp;<select id='VICTIM_AREA_GRP' name='VICTIM_AREA_GRP'  style='width:100px;'   ref='HM46'  > <option value=''>세부구분</option><option value='01' data-grpcode='' data-subcode='HM47' alt='' >서울특별시</option><option value='02' data-grpcode='' data-subcode='HM47' alt='' >부산광역시</option><option value='03' data-grpcode='' data-subcode='HM47' alt='' >대구광역시</option><option value='04' data-grpcode='' data-subcode='HM47' alt='' >인천광역시</option><option value='05' data-grpcode='' data-subcode='HM47' alt='' >광주광역시</option><option value='06' data-grpcode='' data-subcode='HM47' alt='' >대전광역시</option><option value='07' data-grpcode='' data-subcode='HM47' alt='' >울산광역시</option><option value='19' data-grpcode='' data-subcode='HM47' alt='' >세종특별자치시</option><option value='08' data-grpcode='' data-subcode='HM47' alt='' >경기</option><option value='09' data-grpcode='' data-subcode='HM47' alt='' >강원</option><option value='10' data-grpcode='' data-subcode='HM47' alt='' >충북</option><option value='11' data-grpcode='' data-subcode='HM47' alt='' >충남</option><option value='12' data-grpcode='' data-subcode='HM47' alt='' >전북</option><option value='13' data-grpcode='' data-subcode='HM47' alt='' >전남</option><option value='14' data-grpcode='' data-subcode='HM47' alt='' >경북</option><option value='15' data-grpcode='' data-subcode='HM47' alt='' >경남</option><option value='16' data-grpcode='' data-subcode='HM47' alt='' >제주</option><option value='18' data-grpcode='' data-subcode='HM47' alt='' >해외</option></select>
                        </span>
                        <span style="display:inline-block; width:280px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CASE_ROUTE_GRP">피해자의 센터인지경로
                        &nbsp;&nbsp;&nbsp;<select id='CASE_ROUTE_GRP' name='CASE_ROUTE_GRP'  style='width:100px;'   ref='CSRTG'  > <option value=''>세부구분</option><option value='10' data-grpcode='' data-subcode='CSRT' alt='' >기관을통해</option><option value='20' data-grpcode='' data-subcode='CSRT' alt='' >주변인통해</option><option value='30' data-grpcode='' data-subcode='CSRT' alt='' >매체를통해</option><option value='40' data-grpcode='' data-subcode='' alt='' >기타</option><option value='50' data-grpcode='' data-subcode='' alt='' >알수없음</option></select>
                        </span>
												
												<input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CASE_ROUTE_GRP_AGE">센터인지경로(연령별)
												
                    </td>
                </tr>


                <tr style="height:40px;">
                    <td style="text-align: center;">피해자 특성</td>
                    <td colspan='3'>
                        <span style="display:inline-block; width:140px;">
                            <select id="VICTIM_FRGER" name="VICTIM_FRGER" style="width:120px;">
                                <option value="">내외국인 전체</option>
                                <option value="N">내국인</option>
                                <option value="Y">외국인</option>
                            </select>
                        </span>

                        <span style="display:inline-block; width:120px;">
                            <input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="VICTIM_AGE">
                            연령별통계
                        </span>

                        <span style="display:inline-block; width:90px;">
                            장애여부:<input type="checkbox" id="VICTIM_DISABLE" name="VICTIM_DISABLE" value="Y" />
                            
                        </span>

                        <span style="display:inline-block; width:110px;">
                            성별:<select id='VICTIM_SEX' name='VICTIM_SEX'  style='width:60px;'   ref='MF'  > <option value=''>전체</option><option value='F' data-grpcode='' data-subcode='' alt='' >여자</option><option value='M' data-grpcode='' data-subcode='' alt='' >남자</option><option value='E' data-grpcode='' data-subcode='' alt='' >알수없음</option></select>
                        </span>

                        <span style="display:inline-block; width:160px;">
                            <select id='VICTIM_AREA' name='VICTIM_AREA'  style='width:140px;'   ref='HM46'  > <option value=''>피해자거주지역</option><option value='01' data-grpcode='' data-subcode='HM47' alt='' >서울특별시</option><option value='02' data-grpcode='' data-subcode='HM47' alt='' >부산광역시</option><option value='03' data-grpcode='' data-subcode='HM47' alt='' >대구광역시</option><option value='04' data-grpcode='' data-subcode='HM47' alt='' >인천광역시</option><option value='05' data-grpcode='' data-subcode='HM47' alt='' >광주광역시</option><option value='06' data-grpcode='' data-subcode='HM47' alt='' >대전광역시</option><option value='07' data-grpcode='' data-subcode='HM47' alt='' >울산광역시</option><option value='19' data-grpcode='' data-subcode='HM47' alt='' >세종특별자치시</option><option value='08' data-grpcode='' data-subcode='HM47' alt='' >경기</option><option value='09' data-grpcode='' data-subcode='HM47' alt='' >강원</option><option value='10' data-grpcode='' data-subcode='HM47' alt='' >충북</option><option value='11' data-grpcode='' data-subcode='HM47' alt='' >충남</option><option value='12' data-grpcode='' data-subcode='HM47' alt='' >전북</option><option value='13' data-grpcode='' data-subcode='HM47' alt='' >전남</option><option value='14' data-grpcode='' data-subcode='HM47' alt='' >경북</option><option value='15' data-grpcode='' data-subcode='HM47' alt='' >경남</option><option value='16' data-grpcode='' data-subcode='HM47' alt='' >제주</option><option value='18' data-grpcode='' data-subcode='HM47' alt='' >해외</option></select>
                        </span>

                        

    <div id='divAgeDateArea'>
        <span style="display:inline-block; width:95%; margin-top:5px;">
            <div id="showAgeDateView">
                나이 구분 : <span id='showAgeDate' style='color:blue;font-weight:bold; padding-right:10px;'>
                    10,13,19
                </span>
                <button id="btnStatAgeAdd" CLASS="btn">수정</button>
            </div>
            <div id="showAgeDateModi">
                나이 구분 :
                <input type='text' id='ageSetting1' name='ageSetting' style="width:200px;" value='10,13,19'>
                <input type='hidden' id='param_user_id1' name='param_user_id' value=''>
                <button id="btnStatAgeUpd" CLASS="j_button">적용</button>
                <br>
                <span style="color:orange;">
                    분류하고자하는 구간의 시작나이들을 ,(쉼표)로 구분하여 입력하여주세요.<br />
                    9세미만, 10~12세, 13~18세, 19세이상 인경우 입력방법 :
                    <b>10,13,19</b> 으로 입력후, 반드시 '적용' 버튼 클릭!
                </span>
            </div>
        </span>
    </div>


    <script>

        $("#formAgeSetting").validate({
          rules: {
              ageSetting:		{ required: true, minlength: 5 }
          },
          messages: {
              ageSetting: {
                required: "나이구분을 입력해 주세요",
                minlength: "나이구분을 최소한 3단계이상으로 나누어 주세요."
              }
            }
        });

        $('#showAgeDateModi').hide();

        $('#btnStatAgeAdd').click(function(){
            $('#showAgeDateView').hide();
            $('#showAgeDateModi').show();
        });
        $('#btnStatAgeUpd').click(function(){

            $('#ageSetting').val($('#ageSetting1').val());
            $('#param_user_id1').val($('#param_user_id1').val());

            if ($("#formAgeSetting").valid()) {
                $.ajax({
                  type:"post",
                  url:"json/ajax_AgeSetting.asp" ,
                  data: $("#formAgeSetting").serialize() ,
                  success:function(entry){

                              var v2 = getShowAgeSplit($('#ageSetting').val());

                              $('#showAgeDateView').show();
                              $('#showAgeDateModi').hide();

                              $('#showAgeDate').empty().prepend(v2);

                  }, error: function(xhr,status,error){
                    alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
                  }
                });
            }

        });

        function getShowAgeSplit(v) {
            var v1 = v.replace(/ /gi, "").split(",");
            var v2 = "";
            for (i=0; i < v1.length ;i++ ) {
                if (i==0 && v1.length>0) {
                    v2 += (v1[0]) +'세미만, ';
                    v2 += (v1[0]) +'~'+ (v1[1]) +'세미만, ';
                } else if (i == (v1.length-1)) {
                    v2 += (v1[i]) +'세이상';
                } else {
                    v2 += (v1[i]) +'~'+ (v1[i+1]) +'세미만, ';
                }
            }
            return v2;
        }

        //init()
        $('#showAgeDate').empty().prepend(getShowAgeSplit('10,13,19'));

    </script>










                        
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">[피해정보]</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:250px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="DMG_STATE_YN">피해시 특이사항 여부</span>
                        <span style="display:inline-block; width:200px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="DMG_STATE">피해시 특이사항-있음</span>
                    </td>
                </tr>



                <tr style="height:40px;">
                    <td style="text-align: center;">[가해자정보]</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:250px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="ATTKR_STATE_YN">가해시 특이사항 여부</span>
                        <span style="display:inline-block; width:200px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="ATTKR_STATE">가해시 특이사항-있음</span>
                        <!--
                        2017.1.23 가해자 1명으로 처리
                        <span style="color:green;padding-left:0px;">(가해자수 기준으로 산출됩니다)</span>
                        -->
                    </td>
                </tr>

                <tr class="trExtend" style="height:40px;">
                    <td style="text-align: center;">가해자 특성</td>
                    <td colspan=3>
                        <span style="display:inline-block; width:140px;">
                            <select id="ATTKR_FRGER" name="ATTKR_FRGER" style="width:120px;">
                              <option value="">내외국인 전체</option>
                              <option value="N">내국인</option>
                              <option value="Y">외국인</option>
                            </select>
                        </span>

                        <span style="display:inline-block; width:120px;">
                            <input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="ATTKR_AGE">
                            연령별통계
                        </span>

                        <span style="display:inline-block; width:90px;">
                            장애여부:<input type="checkbox" id="ATTKR_DISABLE" name="ATTKR_DISABLE" value="Y" />
                        </span>

                        <span style="display:inline-block; width:110px;">
                            성별:<select id='ATTKR_SEX' name='ATTKR_SEX'  style='width:60px;'   ref='MF'  > <option value=''>전체</option><option value='F' data-grpcode='' data-subcode='' alt='' >여자</option><option value='M' data-grpcode='' data-subcode='' alt='' >남자</option><option value='E' data-grpcode='' data-subcode='' alt='' >알수없음</option></select>
                        </span>

                        <span style="display:inline-block; width:160px;">
                            <select id='ATTKR_REL_GRP' name='ATTKR_REL_GRP'  style='width:140px;'   ref='CZ01G'  > <option value=''>가해자피해자관계</option><option value='10' data-grpcode='' data-subcode='CZ01' alt='' >가족</option><option value='20' data-grpcode='' data-subcode='CZ01' alt='' >친인척</option><option value='25' data-grpcode='' data-subcode='' alt='' >기타 친인척</option><option value='30' data-grpcode='' data-subcode='' alt='' >가족(친인척)의 동거인</option><option value='40' data-grpcode='' data-subcode='' alt='' >연애상대</option><option value='50' data-grpcode='' data-subcode='CZ01' alt='' >사회적관계</option><option value='60' data-grpcode='' data-subcode='CZ01' alt='' >일시적관계</option><option value='70' data-grpcode='' data-subcode='' alt='' >모르는 사람</option><option value='80' data-grpcode='' data-subcode='' alt='' >기타관계</option><option value='90' data-grpcode='' data-subcode='' alt='' >알수없음</option></select>
                        </span>
                    </td>
                </tr>

                <tr style="height:40px;">
                    <td style="text-align: center;">[상담정보]</td>
                    <td colspan=3 style="padding:2px;">
                        <span style="display:inline-block; width:120px;padding:3px;"><input type="radio" name="CASE_TYPE" class="CASE_TYPE" value="CASE_HELP">지원요청내용</span>
                    </td>
                </tr>
            </table>

            <script>
                $('#CLIENT_REL_GRP').hide();
                $('#CASE_ROUTE_GRP').hide();
                $('#VICTIM_AREA_GRP').hide();
                $('#divAgeDateArea').hide();
                $('#divCsType01Sub').hide();

                $("#formSearch select[name='CLIENT_REL_GRP']").find("option").filter(function(index) {
                    var dataGrpcde = $(this).attr("data-subcode")
                    if (typeof dataGrpcde != "undefined") {
                        if ( dataGrpcde == '' ){ return true;} else { return false; }
                    }
                }).remove();

                $("#formSearch select[name='CASE_ROUTE_GRP']").find("option").filter(function(index) {
                    var dataGrpcde = $(this).attr("data-subcode")
                    if (typeof dataGrpcde != "undefined") {
                        if ( dataGrpcde == '' ){ return true;} else { return false; }
                    }
                }).remove();

                $("#formSearch select[name='VICTIM_AREA_GRP']").find("option").filter(function(index) {
                    var dataGrpcde = $(this).attr("data-subcode")
                    if (typeof dataGrpcde != "undefined") {
                        if ( dataGrpcde == '' ){ return true;} else { return false; }
                    }
                }).remove();



                $("#formSearch input[name='CASE_TYPE']").click(function() {

                    $('#CLIENT_REL_GRP').hide();
                    $('#CASE_ROUTE_GRP').hide();
                    $('#VICTIM_AREA_GRP').hide();
                    $('#divAgeDateArea').hide();
                    $('#divCsType01Sub').hide();

                    var valChecked = $("#formSearch input[name='CASE_TYPE']:checked").val();
                    if (valChecked=="CLIENT_REL_GRP") {
                        $('#CLIENT_REL_GRP').show();
                    }
                    if (valChecked=="CASE_ROUTE_GRP") {
                        $('#CASE_ROUTE_GRP').show();
                    }
                    if (valChecked=="VICTIM_AREA") {
                        $('#VICTIM_AREA_GRP').show();
                    }
                    if (valChecked=="VICTIM_AGE") {
                        $('#divAgeDateArea').show();
                    }
                    if (valChecked=="CS_TYPE_01") {
                        $('#divCsType01Sub').show();
                    }
                });

                $('#btnDeleteVictimAges2').click(function() {
                    $('#VICTIM_AGE_FROM2').val("");
                    $('#VICTIM_AGE_TO2').val("");
                });
            </script>

        </td>
    </tr>


    <tr style="height:35px;">
        <td style="text-align: center;">내방 사례 여부</td>
        <td colspan=3>
            <span style="display:inline-block; width:80px;"><input type="checkbox" name="VISIT_CASE_CHECK" value="N"></span>
        </td>
    </tr>


    <tr style="height:40px;">
        <td style="text-align: center;">산출 형태</td>
        <td colspan=3>
            <span style="display:inline-block; width:80px;"><input type="checkbox" name="dsaYN" id='dsaYN' value="Y">장애</span>
            <span style="display:inline-block; width:100px;"><input type="checkbox" name="sexYN" id='sexYN' value="Y">성별 구분
            <input type="hidden" id="src_SEX" name="src_SEX" value="Y" />
            </span>
            
        </td>
    </tr> --%>

    <script>

        $('#totYN').click(function() {
            if ( $('#totYN').is(":checked") == true ) {
                $('#src_CNTR_GBN option:eq(0)').attr('selected', 'selected');
                $('#src_CNTR_COD option:eq(0)').attr('selected', 'selected');
                $('#src_CNTR_COD').hide();
            }
        });

        function setCookies4SearchOutput() {
            $.cookie('srcCookieDSA',    $("input[name=dsaYN]:checkbox:checked").val(), { expires: 7, path: '/' });
            $.cookie('srcCookieSEX',    $("input[name=sexYN]:checkbox:checked").val(), { expires: 7, path: '/' });
            $.cookie('srcCookieTOT',    $("input[name=totYN]:checkbox:checked").val(), { expires: 7, path: '/' });
        }

        /* 쿠키로 검색기록 기능 제거
        if ( $.cookie('srcCookieDSA')=='Y' ) {
            $("input[name=dsaYN]:checkbox").attr('checked', true);
        }
        if ( $.cookie('srcCookieSEX')=='Y' ) {
            $("input[name=sexYN]:checkbox").attr('checked', true);
        }
        if ( $.cookie('srcCookieTOT')=='Y' ) {
            $("input[name=totYN]:checkbox").attr('checked', true);
            $('#src_CNTR_GBN option:eq(0)').attr('selected', 'selected');
            $('#src_CNTR_COD option:eq(0)').attr('selected', 'selected');
            $('#src_CNTR_COD').hide();
        }
        */
    </script>
    

                <tr style="height:40px;">
                    <td colspan=4><button id="btnAction" class='pure-button btnSearch' style="height:30px;width:100%;">검색</button></td>
                </tr>

            </table>
        </form>
    </div>

    <form id="formAgeSetting">
        <input type='hidden' id='ageSetting' name='ageSetting' style="width:400px;" value='10,13,19'>
        <input type='hidden' id='param_user_id' name='param_user_id' value=''>
    </form>



<script>

    $('#btnAction').click( function(e) {
        e.preventDefault();

        $('#searchMasterTextType').val("");
        incSearchRunAction();
    });

    $('#btnSearchCase').click( function(e) {

        e.preventDefault();

        $('#searchMasterTextType').val("");
        incSearchRunAction();

        /*
        if($('#searchMasterText').val()=='') {
            alert('검색어를 입력해주세요');
        } else {
            jqGridPage.setJqGrideSearch();
        }
        */

    });

    $('#btnSearchCasePlus').click( function(e) {

        e.preventDefault();

        $('#searchMasterTextType').val("Y");
        incSearchRunAction();

        /*
        if($('#searchMasterText').val()=='') {
            alert('검색어를 입력해주세요');
        } else {
            jqGridPage.setJqGrideSearch();
        }
        */

    });

    $('#searchMasterText').keydown(function(e) {

        if (e.keyCode == 13) {
            e.preventDefault();
            incSearchRunAction();
        }
    });

    $('#btnOption').click( function() {

        $(this).text(function(i, text){
            return text === "검색옵션 확장" ? doSearchFormOpen() : doSearchFormClose();
        })

    });

    /*
    if ( isDefined($.cookie('srcCookieExtende')) && $.cookie('srcCookieExtende')=='close' ) {
        $('.trExtend').hide();
        $('#searchOption').val("close");
    } else {
        $('#btnOption').text("검색옵션 축소");
        $('#searchOption').val("open");
    }
    */

    
        $('.trExtend').show();
        $('#searchOption').val("open");
    


    // 재직,퇴직여부 선택에 따른 변경
    $('#src_CSL_IDState').change(function(){
	    setUserStateSelectByCenterChoice();
	});

    // 사례 관리자 선택에 따른 변경
    $('#CASE_MANAGERState').change(function(){
        setUserStateSelectByCenterChoice2();
    });

</script>



<!--// cont -->


<div class="cont2">

    <div id='divShowTotal'>
        <div id="lblList">
        </div>

        <div id='divLoadingImage'></div>

    </div>

</div>
</div>
<form id="formPage" method="post">
    <input type="hidden" name="case_seq" value="">
    <input type="hidden" name="serv_seq">
</form>

