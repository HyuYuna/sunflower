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

<style>
    #lblList table { border-collapse: collapse; width:100%;}
    #lblList table, th, td { border: 1px solid #cbcbcb; }
    #lblList th, td { padding: 5px; }
    #lblList th { text-align: center; }
    #lblList td { text-align: right; }
    #lblList .sellDisable { color: blue }

    .selHover { background-color: orange; }
</style>

<script src="/static/bos/commonEkr/js/excelexportjs/jquery.techbytarun.excelexportjs.min.js" type="text/javascript"></script>
<script>
	function filePopZip(){
	    var url = "/bos/stats/stats/excelDownPopup.do";
	    var params = "?shDataNm=통계(서비스:실인원)&viewType=BODY";
	    window.open(url+params , 'caseFilePopup',"width=500, height=300");
	}
	
	function fn_export(){
	    $("#tblExport").excelexportjs({
	        containerid : "tblExport"
	        , datatype : 'table'
	    });
	    $(this).attr('download', '통계_서비스:실인원.xls').attr('href', uri).attr("target", "_blank");
	}
	function numComma(n) {
		if(n!=null){
			var num = n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		}
		return num;
	}
	
	function incSearchRunAction() {

        $('#lblList').empty();

        $('#divLoadingImage').empty();
        $('#divLoadingImage').append("<center><img src='/static/bos/image/loading_long.gif'><br><br></center>");

        getResultData();

    }
	
	function getResultData() {
		var isFinish = "Y";
		
		var valChecked3 = new Array();
        
		if($("input:checkbox[value='01']").is(":checked")){
			valChecked3.push("01");
		}
		if($("input:checkbox[value='02']").is(":checked")){
			valChecked3.push("02");
		}
		if($("input:checkbox[value='03']").is(":checked")){
			valChecked3.push("03");
		}
		if($("input:checkbox[value='11']").is(":checked")){
			valChecked3.push("11");
		}
        
        $("#CHEK_CASE_TYPE_VALUE").val(valChecked3);
        
		//대상센터 추가
		var chkArray = new Array();
		$("input:checkbox[name=CHECK_CNTR_COD]:checked").each(function(){
			chkArray.push(this.value);
		});
		
		if(chkArray.length > 0){
			$("#arr_CNTR_COD").val(chkArray);
		}
		
		$.ajax({
            type:"post",
            url: "/bos/stats/stats/vPassStats.json",
            dataType: "json",
			data : $("#formSearch").serialize(),
			success : function(data){
            	var codeResult = data.codeResult;
            	var vPassStats = data.vPassStats;
            	var vPassStatd = data.vPassStatd;
				var table = "";
            	
            	var dsaYN = data.dsaYN;
            	var sexYN = data.sexYN;
            	
            	if(codeResult.length >= 0){
            		table += "<table id='tblExport' style='width:600px;'>";
            		
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
            			table += "<th colspan='" + colnum + "'>전체</th></tr>";
            			
						table += "<tr><th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "'>전체</th>";
						table += "<th style='padding:5px 0 5px 0;' colspan='" + sexColspan + "' class='sellDisable'>장애</th></tr>";
            			
            			if(sexYN == "Y"){
            				table += "<tr>";
                			for(var i=0; i<1; i++){
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
            			table += "<th style='width:100px;' colspan='" + colnum + "'>전체</th>";
            			table += "</tr>";
            			
            			if(sexYN == "Y"){
            				table += "<tr>";
                			for(var i=0; i<1; i++){
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
            		$.each(vPassStats, function(i, entry) {
            			if(i == 0){
            				if(sexYN == 'Y'){
            					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
            					
            					for(var t=6; t<=data.codeCount2; t++){
            						table += "<td>" + numComma(data.array0[t][1]) + "</td><td>" + numComma(data.array0[t][2]) + 
            								"</td><td>" + numComma(data.array0[t][3]) + "</td><td>" + numComma(data.array0[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data.drray0[t][1]) + "</td><td class='sellDisable'>" + numComma(data.drray0[t][2]) + 
        								"</td><td class='sellDisable'>" + numComma(data.drray0[t][3]) + "</td><td class='sellDisable'>" + numComma(data.drray0[t][0]) + "</td>";
            						}
            					}
            					
            					table += "</tr>";
            				} else {
            					table += "<tr style='background-color:#e3e3e3;'><th" + sexRowspan + "><b style='color:red;'>전체총계</b></th>";
            					
            					for(var t=6; t<=data.codeCount2; t++){
            						table += "<td>" + numComma(data.array0[t][0]) + "</td>";
            						
            						if(dsaYN == 'Y'){
                						table += "<td class='sellDisable'>" + numComma(data.drray0[t][0]) + "</td>";
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
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array1[t][1]) + "</td><td>" + numComma(data.array1[t][2]) + 
                								"</td><td>" + numComma(data.array1[t][3]) + "</td><td>" + numComma(data.array1[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray1[t][1]) + "</td><td class='sellDisable'>" + numComma(data.drray1[t][2]) + 
            								"</td><td class='sellDisable'>" + numComma(data.drray1[t][3]) + "</td><td class='sellDisable'>" + numComma(data.drray1[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
            					} else {
                					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>위기지원형 소계</b></th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array1[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray1[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
                				}
            				}
            				
            				//아동형 소계
            				if(entry["cgroupCode"] == "2"){
            					if(sexYN == 'Y'){
            						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array2[t][1]) + "</td><td>" + numComma(data.array2[t][2]) + 
                								"</td><td>" + numComma(data.array2[t][3]) + "</td><td>" + numComma(data.array2[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray2[t][1]) + "</td><td class='sellDisable'>" + numComma(data.drray2[t][2]) + 
            								"</td><td class='sellDisable'>" + numComma(data.drray2[t][3]) + "</td><td class='sellDisable'>" + numComma(data.drray2[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
            					} else {
                					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>아동형 소계</b></th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array2[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray2[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
                				}
            				}
            				
            				//통합형 소계
            				if(entry["cgroupCode"] == "3"){
            					if(sexYN == 'Y'){
            						table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array3[t][1]) + "</td><td>" + numComma(data.array3[t][2]) + 
                								"</td><td>" + numComma(data.array3[t][3]) + "</td><td>" + numComma(data.array3[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray3[t][1]) + "</td><td class='sellDisable'>" + numComma(data.drray3[t][2]) + 
            								"</td><td class='sellDisable'>" + numComma(data.drray3[t][3]) + "</td><td class='sellDisable'>" + numComma(data.drray3[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
            					} else {
                					table += "<tr style='background-color:#f3f3f3;'><th" + sexRowspan + "><b style='color:green;'>통합형 소계</b></th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						table += "<td>" + numComma(data.array3[t][0]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                    						table += "<td class='sellDisable'>" + numComma(data.drray3[t][0]) + "</td>";
                						}
                					}
                					
                					table += "</tr>";
                				}
            				}
            			}
            			preGroupCode = entry["cgroupCode"];
            			
            			
            			if(data.totYN != 'Y'){
            				if(sexYN == 'Y'){
                				if(cCode != entry["codeCode"]){
            					var tot = 0;
            					var row = "<tr>";
            					
            					if(entry["victimSex"] == "M"){
            						row = row + "<th" + sexRowspan + ">" + entry["centerName"] + "</th>";
            					}
            					
            					//전체 합계값 출력
            					for(var t=6; t<=data.codeCount2; t++){
            						$.each(vPassStats, function(index, stats) {
    									if(entry["codeCode"] == stats["codeCode"]){
        									row += "<td>" + stats["fieldname"+data.codename[t]] + "</td>";
        									
        									//남자인경우 남자값으로 초기화
        									if(stats["victimSex"] == "M"){
        										sumArray[t] = stats["fieldname"+data.codename[t]];
        									} else if(stats["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
        										sumArray[t] = sumArray[t] + stats["fieldname"+data.codename[t]];
        									} else if(stats["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
        										sumArray[t] = sumArray[t] + stats["fieldname"+data.codename[t]];
        									
        										if(t == 6){
        											tot = sumArray[t];
        										}
        										
        										row += "<td>" + numComma(sumArray[t]) + "</td>";
        									}
    									}
            						})
            						
            						if(dsaYN == "Y"){
            							$.each(vPassStatd, function(index, statd) {
        									if(entry["codeCode"] == statd["codeCode"]){
            									row += "<td class='sellDisable'>" + statd["fieldname" + data.codename[t]] + "</td>";
            									
            									//남자인경우 남자값으로 초기화
            									if(statd["victimSex"] == "M"){
            										sumDrray[t] = statd["fieldname"+data.codename[t]];
            									} else if(statd["victimSex"] == "F"){ //여자인 경우 남자값 + 여자값 후 전체값 출력
            										sumDrray[t] = sumDrray[t] + statd["fieldname"+data.codename[t]];
            									} else if(statd["victimSex"] == "E"){ //모름인 경우 남자값 + 여자값 후 전체값 출력
            										sumDrray[t] = sumDrray[t] + statd["fieldname"+data.codename[t]];
            										
            										row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
            									}
        									}
                						})
            						}
            					}
            					
                				row += "</tr>";
                				
                				if(data.termType == "Y" && tot == 0){
                					
                				} else {
                					table += row;
                				}
                				}
            				} else {
            					if(entry["victimSex"] == "M"){
            						for(var t=6; t<=data.codeCount2; t++){
            							sumArray[t] = entry["fieldname" + data.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = entry["fieldname" + data.codename[t]]; */
            								sumDrray[t] = vPassStatd[i]["fieldname" + data.codename[t]];
            							}
            						}
            					} else if (entry["victimSex"] == "F") {
            						for(var t=6; t<=data.codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldname" + data.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldname" + data.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + vPassStatd[i]["fieldname" + data.codename[t]];
            							}
            						}
            					} else if(entry["victimSex"] == "E"){
            						for(var t=6; t<=data.codeCount2; t++){
            							sumArray[t] = sumArray[t] + entry["fieldname" + data.codename[t]];
            							
            							if(dsaYN == "Y"){
            								/* sumDrray[t] = sumDrray[t] + entry["fieldname" + data.codename[t]]; */
            								sumDrray[t] = sumDrray[t] + vPassStatd[i]["fieldname" + data.codename[t]];
            							}
            						}
            						
                					tot = 0;
                					row = "<tr>";
                					
                					row += "<th>" + entry["centerName"] + "</th>";
                					
                					for(var t=6; t<=data.codeCount2; t++){
                						if(t == 6){
                							tot = sumArray[t];
                						}
                						
                						row += "<td>" + numComma(sumArray[t]) + "</td>";
                						
                						if(dsaYN == 'Y'){
                							row += "<td class='sellDisable'>" + numComma(sumDrray[t]) + "</td>";
                						}
                					}
                					
                					row += "</tr>";
                					
                					if(data.termType == 'Y' && tot == 0){
                						
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
            		if(data.isAdmin){
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
				
				$("#lblList").html(table);
        		
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
        		
        		if(data.isAdmin){
        			if(!ekrJs.isMsie()){
        				$("#divBtnExcelExport").show();
        			}
        			
        			var uri="";
        			$("#btnExcelExport").click(function(){
        				filePopZip();
        			});
                }
				
				if(isFinish == "Y"){
					$('#divLoadingImage').empty();
				}
			}, error : function(xhr, status, error){
				alert("데이터를 처리하지 못했습니다.\n이유 : " + error);
				$('#divLoadingImage').empty();
			}
		});
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

		$.getJSON("/user/json/get_center_user.asp", { center_code: CENTER_CODE , ADMSN_YN: src_CSL_IDState , "nocache": new Date().getTime() }, function(data1) {
			$.each(data1, function(index, entry) {
				$('#src_CSL_ID').append("<option value='"+ entry["USER_ID"] +"'>"+ entry["USER_NAME"] +"</option>") ;
				$('#src_CSL_IDJiwon').append("<option value='"+ entry["USER_ID"] +"'>"+ entry["USER_NAME"] +"</option>") ;
			});
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
				setUserSelectByCenterChoice('${userVO.centerCode}');
			}
	    } else {
			setUserSelectByCenterChoice('${userVO.centerCode}');
		}
	}

    function setUserStateSelectByCenterChoice2() {
        if( $('select[name=src_CNTR_COD]').length>0 ) {

            var val_CNTR_COD = $('select[name=src_CNTR_COD]').val();

            if(isDefined(val_CNTR_COD) && val_CNTR_COD.length>0) {
                setUserSelectByCenterChoice2(val_CNTR_COD);
            } else {
                setUserSelectByCenterChoice2('${userVO.centerCode}');
            }
        } else {
            setUserSelectByCenterChoice2('${userVO.centerCode}');
        }
    }
</script>

<div style="margin-top: -32px; margin-bottom: 15px;">

	<form id="formSearch" method="POST" class="pure-form">
		<input type="hidden" id="pageType" name="pageType" value="" /> 
		<input type="hidden" id="searchOption" name="searchOption" value="close" />
		<input type="hidden" name="targetType" value="" />
		<input type="hidden" name="arr_CNTR_COD" id="arr_CNTR_COD" value="" />
		<input type="hidden" name="CHEK_CASE_TYPE_VALUE" id="CHEK_CASE_TYPE_VALUE" value="" />

		<table class="pure-table pure-table-bordered" style="width: 100%;">
			<colgroup>
				<col style="width: 150px;" />
				<col style="width: 500px;" />
				<col style="width: 130px;" />
				<col style="width: 200px;" />
			</colgroup>
			<tr style="height: 40px;">
				<td style="text-align: center;">
					사례등록일 <img class="btnDeleteSearchDateRage" src='/static/bos/image/icons/cross-th.png' style="width: 10px; height: 10px;">
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
					
					<input type="text" name="cond_frdate" id="cond_frdate" class="formatDate" value="${nowDate }" />
					<span id="cond_spdate"> ~ </span>
					<input type="text" name="cond_todate" id="cond_todate" class="formatDate" value="${nowDate }" /> 
					
					&nbsp;&nbsp;&nbsp;
					<input type="radio" class="check" name="term_type" value="N" /><label for="type6" style="padding-right: 10px;">전체</label> 
					<input type="radio" class="check" name="term_type" value="Y" /><label for="type6" style="padding-right: 10px;">년간</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="H" /><label for="type5" style="padding-right: 10px;">반기</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="Q" /><label for="type4" style="padding-right: 10px;">분기</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="M" /><label for="type3" style="padding-right: 10px;">월간</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="W" /><label for="type2" style="padding-right: 10px;">주간</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="D" /><label for="type1" style="padding-right: 10px;">일간</label>&nbsp; 
					<input type="radio" class="check" name="term_type" value="T" /><label for="type7" style="padding-right: 10px;">직접입력</label>

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
			
			<tr class="" style="height: 38px;">
				<td style="text-align: center;">피해 구분</td>
				<td colspan=3>
					<div id="chekCaseTypeDiv">
						<input type='checkbox' name='CHEK_CASE_TYPE_all' value='Y' CHECKED="" id='CHEK_CASE_TYPE_all' />  
						<label for='CHEK_CASE_TYPE_all' style="padding-right:20px;"><b style="color: orange;">전체선택</b></label>
						<script>
							getCmmnCd.checkBoxStats('CSAB', 'chekCaseTypeDiv', 'CHEK_CASE_TYPE', '01, 02, 03, 11', '5');
						</script>
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
        if ( isDefined($.cookie('srcCookieGubun11')) && $.cookie('srcCookieGubun11')=='N' ) {
            $("input[name="+ checkAllSubName +"]:checkbox[value='11']").attr('checked', false);
        }

			</script>

			<tr class="trExtend" style="height: 40px;">
				<td style="text-align: center;">성폭력 하위 구분</td>
				<td colspan="3">
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="" checked>전체</span> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0101">강간</span> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0102">유사강간</span> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0103">강제추행</span> <br /> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0104">디지털 성폭력</span>
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0107">성적목적공공장소 침입</span> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0108">공중밀집장소에서의 추행</span> 
					<span style="display: inline-block; width: 210px; padding: 3px;"><input type="radio" name="CS_TYPE_01_SUB" class="CS_TYPE_01_SUB" value="0110">기타 성폭력</span>
				</td>
			</tr>

			<tr class="trExtend" style="height: 40px;">
				<td style="text-align: center;">피해자 특성</td>
				<td>
					<span style="display: inline-block; width: 140px;">
						<select id="VICTIM_FRGER" name="VICTIM_FRGER" style="width: 120px;">
							<option value="">내외국인 전체</option>
							<option value="N">내국인</option>
							<option value="Y">외국인</option>
						</select>
					</span>
					
					<span style="display: inline-block; width: 180px;">
						연령: 
						<input type="text" id="VICTIM_AGE_FROM" name="VICTIM_AGE_FROM" style="width: 40px;" class='onlyNumber'>
						~
						<input type="text" id="VICTIM_AGE_TO" name="VICTIM_AGE_TO" style="width: 40px;" class='onlyNumber'>
						<img id="btnDeleteVictimAges" src='/static/bos/image/icons/cross-th.png' style="width: 10px; height: 10px;">
					</span>
					<!-- <span style="display: inline-block; width: 120px;">
						장애여부 : <input type="checkbox" id="VICTIM_DISABLE" name="VICTIM_DISABLE" value="Y" />
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
				</td>
				<td>피해자 거주지역</td>
				<td>
					<select id='VICTIM_AREA' name='VICTIM_AREA' style='width: 98%;' ref='HM46'>
						<script>
							getCmmnCd.selectStats('HM46', 'VICTIM_AREA', '${paramVO.VICTIM_AREA}', 'N', '거주지역 전체');
						</script>
					</select>
				</td>
			</tr>

			<script>
        $('#btnDeleteVictimAges').click(function() {
            $('#VICTIM_AGE_FROM').val("");
            $('#VICTIM_AGE_TO').val("");
        });
			</script>


			<tr class="trExtend" style="height: 40px;">
				<td style="text-align: center;">가해자 특성</td>
				<td>
					<span style="display: inline-block; width: 140px;">
						<select id="ATTKR_FRGER" name="ATTKR_FRGER" style="width: 120px;">
							<option value="">내외국인:: 전체</option>
							<option value="N">내국인</option>
							<option value="Y">외국인</option>
					</select>
					</span>
					
					<span style="display: inline-block; width: 180px;">
						연령: 
						<select id='ATTKR_AGE' name='ATTKR_AGE' style='width: 120px;' ref='ATAG'>
							<script>
								getCmmnCd.selectStats('ATAG', 'ATTKR_AGE', '${paramVO.ATTKR_AGE}', 'N', '연령 전체')
							</script>
						</select> 
						
						<!--
						<input type="text" id="ATTKR_AGE_FROM" name="ATTKR_AGE_FROM" style="width:40px;" class='onlyNumber'>
						~
						<input type="text" id="ATTKR_AGE_TO" name="ATTKR_AGE_TO" style="width:40px;" class='onlyNumber'>
						<img id="btnDeleteAttkrAges" src='/common/icons/cross-th.png' style="width:10px; height:10px;">
						-->
					</span> 
					
					<!-- <span style="display: inline-block; width: 120px;"> 
						장애여부 : 
						<input type="checkbox" id="ATTKR_DISABLE" name="ATTKR_DISABLE" value="Y" />
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
				</td>
				<td>가해자 피해자 관계</td>
				<td>
					<select id='ATTKR_REL_GRP' name='ATTKR_REL_GRP' style='width: 98%;' ref='CZ01G'>
						<script>
							getCmmnCd.selectStats('CZ01G', 'ATTKR_REL_GRP', '${paramVO.ATTKR_REL_GRP}', 'N', '관계 전체')
						</script>
					</select>
				</td>
			</tr>

			<script>
        /*
        $('#btnDeleteAttkrAges').click(function() {
            $('#ATTKR_AGE_FROM').val("");
            $('#ATTKR_AGE_TO').val("");
        });
        */
			</script>

			<tr class="trExtend" style="height: 40px;">
				<td style="text-align: center;">지원 구분</td>
				<td colspan=3>
					<select id='PASS_TYPE' name='PASS_TYPE' style='width: 20%;' ref='PSA1'>
						<script>
							getCmmnCd.selectStats('PSA1', 'PASS_TYPE', '${paramVO.PASS_TYPE}', 'N', '구분선택')
						</script>
					</select>&nbsp;
					
					<select id='SUB1_DATA' name='SUB1_DATA' style='width: 40%;' ref='PSA2'>
						<script>
							getCmmnCd.selectStats('PSA2', 'SUB1_DATA', '${paramVO.SUB1_DATA}', '', '');
						</script>
					</select>&nbsp;
				</td>
			</tr>

			<script>

        //페이지 로딩시 기본 정보값 로드
        var $SUB1_DATA_OPTION = $('#SUB1_DATA>option').clone();
        var $SUB2_DATA_OPTION = $('#SUB2_DATA>option').clone();

        //지원구분1 변경시
        $('#PASS_TYPE').on('change', function() {
            fnc_SUB_PASS_TYPE();
            if($('#PASS_TYPE option:selected').val() == '4'){
            	$('#SUB1_DATA option[value="4A"]').removeAttr('disabled');
            }
            
        });
        //지원구분2 변경시
        $('#SUB1_DATA').on('change', function() {
            fnc_SUB_SUB1_DATA();
        });

        function fnc_SUB_PASS_TYPE() {
            var selectOptionVal = $("#formSearch select[name='PASS_TYPE']").val();
            var selectOptionSub = $("#formSearch select[name='PASS_TYPE']").find('option:selected').attr('data-subcode');
            if (selectOptionSub == '' || selectOptionSub == null) {
                $("#formSearch select[name='SUB1_DATA']").prop('disabled', true).hide();
                $("#formSearch select[name='SUB2_DATA']").prop('disabled', true).hide();
            } else {

                $('#SUB1_DATA').html($SUB1_DATA_OPTION);

                $("#formSearch select[name='SUB1_DATA']").prop('disabled', false).show().find("option").filter(function(index) {
                    var dataGrpcde = $(this).attr("data-grpcode")
                    if (typeof dataGrpcde != "undefined") {
                        if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
                    }
                }).remove();

                $("#formSearch select[name='SUB1_DATA']").prepend("<option value=''>그룹 선택</option>");
                $("#formSearch select[name='SUB1_DATA'] option:eq(0)").attr("selected", "selected");

                setTimeout(function(){
                    fnc_SUB_SUB1_DATA();
                }, 500);
            }
        }

        function fnc_SUB_SUB1_DATA() {
        
        }

        fnc_SUB_PASS_TYPE();

			</script>

			<tr style="height: 40px;">
				<td style="text-align: center;">산출 형태</td>
				<td colspan=3><span style="display: inline-block; width: 80px;"><input type="checkbox" name="dsaYN" id='dsaYN' value="Y">장애</span> 
					<span style="display: inline-block; width: 100px;"><input type="checkbox" name="sexYN" id='sexYN' value="Y">성별 구분
						<input type="hidden" id="src_SEX" name="src_SEX" value="Y" />
					</span>
					<c:if test="${(userVO.authorCd eq 'CA') || (userVO.authorCd eq 'CU') || (userVO.authorCd eq 'ROLE_SUPER') }">
						<span style="display:inline-block; width:130px;"><input type="checkbox" name="totYN" id='totYN' value="Y">센터별종합실적</span>
					</c:if>
				</td>
			</tr>

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
			
			<tr style="height: 40px;">
				<td colspan=4><button id="btnAction" class='pure-button btnSearch' style="height: 30px; width: 100%;">검색</button></td>
			</tr>
		</table>
	</form>
</div>

<form id="formAgeSetting">
	<input type='hidden' id='ageSetting' name='ageSetting' style="width:400px;" value=''>
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

<div class="cont2">
	<div id='divShowTotal'>
		<div id="lblList"></div>
		<div id='divLoadingImage'></div>
	</div>
</div>

<form id="formPage" method="post">
	<input type="hidden" name="case_seq" value="${paramVO.case_seq }"> 
	<input type="hidden" name="serv_seq">
</form>