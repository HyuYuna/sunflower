<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<script src="/static/bos/js/common.js"></script>

<c:if test="${empty resultServ}">
	<c:set var="insert" value="Y" />
    <c:set var="action" value="/bos/instance/case/insertServ.do" />
</c:if>
<c:if test="${not empty resultServ}">
    <c:set var="action" value="/bos/instance/case/updateServ.do" />
</c:if>

<script>
$(function() {
	if("${insert}" == "Y"){
		$("#formServ select[name='csGroupA10']").attr("disabled","disabled");
		$("#formServ input[name='csGroupB51']").attr("disabled","disabled");
	}
	
	if("${resultServ.csType}" == "M"){
        $("#formServ input[name='csType_GROUP']").attr("disabled","disabled");     
        $("#formServ .csTypeAct0x").attr("disabled","disabled");    
        
        $("#formServ .csType_GROUPtd div").addClass("isUnselectText");  
        $("#formServ .csType_GROUPtd input").attr("disabled","disabled");    
        $("#formServ .csTypeAct0Span").addClass("isUnselectText");
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
    });

    // 신뢰관계인 동석 선택시 옵션
    $("#formServ input[name='csGroupA03']").click(function() {
        var isChecked = $(this).is(":checked");
        if (isChecked) {
            $("#formServ select[name='csGroupA10']").removeAttr("disabled");
        } else {
            $("#formServ select[name='csGroupA10']").attr("disabled","disabled");
        }
    });

    // 응급키트지원 선택시 옵션
    $("#formServ input[name='csGroupB50']").click(function() {
        var isChecked = $(this).is(":checked");
        if (isChecked) {
            $("#formServ input[name='csGroupB51']").removeAttr("disabled");
        } else {
            $("#formServ input[name='csGroupB51']").attr("disabled","disabled");
        }
    });

    // 군대내성폭력 선택시 옵션
    $("#formServ input[name='chkCsType']").click(function() {
        var isChecked = $(this).is(":checked");
        if (isChecked) {
            $("#formServ input[name='csType_GROUP']").attr("disabled","disabled");     
            $("#formServ .csTypeAct0x").attr("disabled","disabled");    
            
            $("#formServ .csType_GROUPtd div").addClass("isUnselectText");  
            $("#formServ .csType_GROUPtd input").attr("disabled","disabled");    
            $("#formServ .csTypeAct0Span").addClass("isUnselectText");
            
            $("#csType").val("M");
        } else {
            $("#formServ input[name='csType_GROUP']").removeAttr("disabled");   
            $("#formServ .csTypeAct0x").removeAttr("disabled");     

            $("#formServ .csType_GROUPtd div").removeClass("isUnselectText"); 
            $("#formServ .csType_GROUPtd input").removeAttr("disabled");    
            $("#formServ .csTypeAct0Span").removeClass("isUnselectText"); 
        }
    });

    // 라디오 박스 해제하기
    $('.unselectcsType_GROUP').click(function() {
        $("input:radio[name='csTypeGroup']").removeAttr("checked");
    });
    $('.unselectcsGroupB10').click(function() {
        $("input:radio[name='csGroupB10']").removeAttr("checked");
    });
    $('.unselectcsGroupB20').click(function() {
        $("input:radio[name='csGroupB20']").removeAttr("checked");
    });
    $('.unselectcsGroupB30').click(function() {
        $("input:radio[name='csGroupB30']").removeAttr("checked");
    });
    $('.unselectcsGroupB40').click(function() {
        $("input:radio[name='csGroupB40']").removeAttr("checked");
    });
    $('.unselectcsGroupB61').click(function() {
        $("input:radio[name='csGroupB61']").removeAttr("checked");
    });
    $('.unselectcsGroupB62').click(function() {
        $("input:radio[name='csGroupB62']").removeAttr("checked");
    });

    $('.unselectcsGroupC10').click(function() {
        $("input:radio[name='csGroupC10']").removeAttr("checked");
    });
    $('.unselectcsGroupC20').click(function() {
        $("input:radio[name='csGroupC20']").removeAttr("checked");
    });
    $('.unselectcsGroupC21').click(function() {
        $("input:radio[name='csGroupC21']").removeAttr("checked");
    });
    $('.unselectcsGroupC22').click(function() {
        $("input:radio[name='csGroupC22']").removeAttr("checked");
    });
    $('.unselectcsGroupC23').click(function() {
        $("input:radio[name='csGroupC23']").removeAttr("checked");
    });
    $('.unselectcsGroupC24').click(function() {
        $("input:radio[name='csGroupC24']").removeAttr("checked");
    });
    $('.unselectcsGroupD10').click(function() {
        $("input:radio[name='csGroupD10']").removeAttr("checked");
    });
    
});

function checkForm() {
	if($("input:checkbox[name=chkCsType]").is(":checked") == false) {
		$("#csType").val("C");
	}

	var form = $("#formServ")[0];
    $("#loadingDiv").show();
    form.submit();
}

</script>


<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />

<div class="cont">
    
    <form id="formServ" method="post" method="post" action="${action}">
    	<input type="hidden" name="caseSeq" value="${result.caseSeq}" /> 
    	<input type="hidden" name="menuNo" value="${param.menuNo }" />
    	<input type="hidden" id="csType" name="csType" value="${resultServ.csType }" /> 
    	
        <h4>피해구분 추가 : 피해구분 추가하기</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="2">아동학대범죄</th>
                    <th class="unselectcsType_GROUP unselectText">가해자구분</th>
                    <td class='csType_GROUPtd'>
						<div id="divCsTypeGroup" > 
                        	<script>
                          		getCmmnCd.radio('JA01', 'divCsTypeGroup', 'csTypeGroup', '${resultServ.csTypeGroup}', 1	);
                          	</script>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>학대행위구분</th>
                    <td>
                        <span style='display:inline-block; width:200px;' class="csTypeAct0Span"><input type='checkbox' name='csTypeAct01' value='Y' class='csTypeAct0x' <c:if test="${resultServ.csTypeAct01 == 'Y'}">checked</c:if>/>신체학대</span>
                        <span style='display:inline-block; width:200px;' class="csTypeAct0Span"><input type='checkbox' name='csTypeAct02' value='Y' class='csTypeAct0x' <c:if test="${resultServ.csTypeAct02 == 'Y'}">checked</c:if> />정서학대</span>
                        <span style='display:inline-block; width:200px;' class="csTypeAct0Span"><input type='checkbox' name='csTypeAct03' value='Y' class='csTypeAct0x' <c:if test="${resultServ.csTypeAct03 == 'Y'}">checked</c:if> />성학대</span>
                        <br>
                        <span style='display:inline-block; width:200px;' class="csTypeAct0Span"><input type='checkbox' name='csTypeAct04' value='Y' class='csTypeAct0x' <c:if test="${resultServ.csTypeAct04 == 'Y'}">checked</c:if> />방임</span>
                        <span style='display:inline-block; width:200px;' class="csTypeAct0Span"><input type='checkbox' name='csTypeAct05' value='Y' class='csTypeAct0x' <c:if test="${resultServ.csTypeAct05 == 'Y'}">checked</c:if> />알 수 없음</span>

                    </td>
                </tr>
                <tr>
                    <th>군대내성폭력</th>
                    <td colspan='2'>
                        <input type="checkbox" id="chkCsType" name="chkCsType" value="M" <c:if test="${resultServ.csType == 'M'}">checked</c:if> />
                    </td>
                </tr>
            </tbody>
        </table>



        <h4>지원경과 : 성폭력 피해자 지원제도 활용 여부</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="25%;" />
                <col width="45%;" />
            </colgroup>
            <tbody>
                <tr>
                    <th>수사법률지원</th>
                    <td colspan='3'>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA04' value='Y' <c:if test="${resultServ.csGroupA04 == 'Y'}">checked</c:if>  />진술녹화 시행</span>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA05' value='Y' <c:if test="${resultServ.csGroupA05 == 'Y'}">checked</c:if>  />피해자 국선변호사 연계</span>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA01' value='Y' <c:if test="${resultServ.csGroupA01 == 'Y'}">checked</c:if>  />전문가 의견조회 제도 활용</span>
                        <br>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA02' value='Y' <c:if test="${resultServ.csGroupA02 == 'Y'}">checked</c:if>  />진술조력인 활용</span>
                        <span style='display:inline-block; width:400px;'><input type='checkbox' name='csGroupA03' value='Y' <c:if test="${resultServ.csGroupA03 == 'Y'}">checked</c:if>  />
                        신뢰관계인 동석 &nbsp;
                        <select name="csGroupA10" id="csGroupA10" >
                           	<script>
								getCmmnCd.select('JAA1', 'csGroupA10', '${resultServ.csGroupA10}')
							</script>
		                </select>
                        </span>
                        <br>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA06' value='Y' <c:if test="${resultServ.csGroupA06 == 'Y'}">checked</c:if>  />무료법률구조사업 연계</span>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA07' value='Y' <c:if test="${resultServ.csGroupA07 == 'Y'}">checked</c:if>  />통역지원</span>
                        <span style='display:inline-block; width:200px;'><input type='checkbox' name='csGroupA08' value='Y' <c:if test="${resultServ.csGroupA08 == 'Y'}">checked</c:if>  />속기사</span>
                    </td>
                </tr>
                <tr>
                    <th rowspan='5'>의료지원</th>
                    <th class="unselectcsGroupB20 unselectText">의료비지원대상</th>
                    <td colspan='2'>
                    	<div id="divCsGroupB20" > 
                        	<script>
                          		getCmmnCd.radio('JA15', 'divCsGroupB20', 'csGroupB20', '${resultServ.csGroupB20}');
                          	</script>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th class="unselectcsGroupB40 unselectText">간병비지원 사유</th>
                    <td colspan='2'>
                    	<div id="divCsGroupB40" > 
                        	<script>
                          		getCmmnCd.radio('JA13', 'divCsGroupB40', 'csGroupB40', '${resultServ.csGroupB40}');
                          	</script>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>응급키트 실시</th>
                    <td colspan='2'>
                    	<input type="checkbox" name="csGroupB50" value="Y" <c:if test="${resultServ.csGroupB50 == 'Y'}">checked</c:if> /> 시행일 : <input type="text" name="csGroupB51" value='${resultServ.csGroupB51}' class="formatDate">
                    </td>
                </tr>
                <tr>
                    <th rowspan='2'>인공임신중절 지원</th>
                    <td class="unselectcsGroupB61 unselectText">센터가 임신을 확인한 시점
                    </td>
                    <td>
                    	<div id="divCsGroupB61" > 
                        	<script>
                          		getCmmnCd.radio('JA17', 'divCsGroupB61', 'csGroupB61', '${resultServ.csGroupB61}', 2);
                          	</script>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="unselectcsGroupB62 unselectText">인공임신중절 수술시행 병원
                    </td>
                    <td>
                    	<div id="divCsGroupB62" > 
                        	<script>
                          		getCmmnCd.radio('JA18', 'divCsGroupB62', 'csGroupB62', '${resultServ.csGroupB62}', 2);
                          	</script>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <h4>사례 경과 및 종결 : 수사재판 경과</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="15%;" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="5">수사재판 경과</th>
                    <th class="unselectcsGroupC10 unselectText">신고</th>
                    <td colspan='2'>
						<div id="divCsGroupC10" > 
                        	<script>
                          		getCmmnCd.radio('JA21', 'divCsGroupC10', 'csGroupC10', '${resultServ.csGroupC10}');
                          	</script>
                        </div>
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <th rowspan="2" class="unselectcsGroupC20 unselectText">검찰</th>
                    <th>불기소</th>
                    <td>
                    	<span style="display:inline-block; width:150px;"><input type="radio" name="csGroupC20" class="csGroupC20" value="11" <c:if test="${resultServ.csGroupC20 == '11'}">checked</c:if> >무혐의</span>
                        <span style="display:inline-block; width:150px;"><input type="radio" name="csGroupC20" class="csGroupC20" value="12" <c:if test="${resultServ.csGroupC20 == '12'}">checked</c:if> >기소유예</span>
                        <span style="display:inline-block; width:150px;"><input type="radio" name="csGroupC20" class="csGroupC20" value="14" <c:if test="${resultServ.csGroupC20 == '14'}">checked</c:if> >기타</span>
                    </td>
                </tr>
                <tr>
                    <th>기소</th>
                    <td>
                        <span style="display:inline-block; width:150px;"><input type="radio" name="csGroupC20" class="csGroupC20" value="13" <c:if test="${resultServ.csGroupC20 == '13'}">checked</c:if>>기소</span>
                    </td>
                </tr>
                <tr>
                    <th>재판</th>
                    <td colspan="2">
                        <span class="unselectcsGroupC22 unselectText">1심 결과</span>
                        &nbsp;
                        <div id="divCsGroupC22" style="display:inline-block;"> 
                        	<script>
                          		getCmmnCd.radio('JA23', 'divCsGroupC22', 'csGroupC22', '${resultServ.csGroupC22}');
                          	</script>
                        	&nbsp;<input type="text" name="csGroupC22Memo" value='${resultServ.csGroupC22Memo}'><br>
                        </div>
                        <br/>
                        <span class="unselectcsGroupC23 unselectText">2심 결과</span> 
                        &nbsp;
                        <div id="divCsGroupC23" style="display:inline-block;"> 
                        	<script>
                          		getCmmnCd.radio('JA23', 'divCsGroupC23', 'csGroupC23', '${resultServ.csGroupC23}');
                          	</script>
	                        &nbsp;<input type="text" name="csGroupC23Memo" value='${resultServ.csGroupC23Memo}'><br>
                        </div>
                        <br/>
                        <span class="unselectcsGroupC24 unselectText">3심 결과</span> 
                        &nbsp;
						<div id="divCsGroupC24" style="display:inline-block;"> 
                        	<script>
                          		getCmmnCd.radio('JA23', 'divCsGroupC24', 'csGroupC24', '${resultServ.csGroupC24}');
                          	</script>
	                        &nbsp;<input type="text" name="csGroupC24Memo" value='${resultServ.csGroupC24Memo}'>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <h4>사례관련 추가 기재 필요 사항</h4>
        <table class="table03">
            <tbody>
                <tr>
                    <td>
                        <textarea name="csMemo" style="height:100px; width:100%;">${resultServ.csMemo}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>

    </form>

    <div class="btnGroup">
        <a class="pure-button btnSave" href="javascript:checkForm();" id="btnCaseSave"><span>저장</span></a>
        <a class="pure-button btnCancel" href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"><span>취소</span></a>
    </div>

<!--     <b style='color:blue;'>* 줄쳐진 글자를 클릭하면 해당항목의 라디오버튼 선택항목을 초기화할 수 있습니다.</b> -->

</div>