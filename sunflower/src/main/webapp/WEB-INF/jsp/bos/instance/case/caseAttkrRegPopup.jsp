<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<script src="/static/bos/js/common.js"></script>

<c:if test="${empty result}">
    <c:set var="action" value="/bos/instance/case/insertAttkr.json" />
</c:if>
<c:if test="${not empty result}">
    <c:set var="action" value="/bos/instance/case/updateAttkr.json" />
</c:if>

<script language="javascript">
$(document).ready(function(){
	//페이지 로딩시 기본 정보값 로드
	var $ATTKR_REL_OPTION = $("#attkrRel>option").clone();
	
	fnc_SUB_ATTKR_REL();
	fnc_SUB_ATTKR_DISABLE();
	fnc_SUB_ATTKR_FRGER();
	fnc_SUB_ATTKR_STATE_YN();
	
	// 가해자정보 장애여부 선택시 옵션
    $("#attkrFrm select[name='attkrDisable']").change(function() {
        fnc_SUB_ATTKR_DISABLE();
    });
	
 	// 가해자 국적 선택시 옵션
    $("#attkrFrm select[name='attkrFrger']").change(function() {
        fnc_SUB_ATTKR_FRGER();
    });
 	
	//피해자와 관계(피해자기준) 하위 선택
	$("#attkrFrm select[name='attkrRelGrp']").change(function() {
		fnc_SUB_ATTKR_REL();
	});
 
 	// 가해시 특이사항 선택시 옵션
    $("#attkrFrm input[name='attkrStateYn']").click(function() {
        fnc_SUB_ATTKR_STATE_YN();
    });
	
	//피해자와 관계(피해자 기준) 선택시 옵션
	function fnc_SUB_ATTKR_REL() {
		var selectOptionVal = $("#attkrFrm select[name='attkrRelGrp']").val();
		var selectOptionSub = $("#attkrFrm select[name='attkrRelGrp']").find('option:selected').attr('data-subcode');
		
		if ( jQuery.type( selectOptionSub )=="undefined" || selectOptionSub=="") {
			$("#attkrFrm select[name='attkrRel']").prop('disabled', true).hide();
		} else {
			$('#attkrRel').html($ATTKR_REL_OPTION);
			
			$("#attkrFrm select[name='attkrRel']").prop('disabled', false).show().find("option").filter(function(index) {
				var dataGrpcde = $(this).attr("data-grpcode")
				if (typeof dataGrpcde != "undefined") {
					if ( $(this).attr("data-grpcode").search(selectOptionVal) == 0 ){ return false;} else { return true; }
				}
			}).remove();
		}
	}
});

	//가해자정보 장애여부 선택시 옵션
	function fnc_SUB_ATTKR_DISABLE() {
	    var thisVal = $("#attkrFrm select[name='attkrDisable']").val();
	    if (thisVal == "0") {
	        $('#attkrDisableMemoText').text('');
	        $("#attkrFrm input[name='attkrDisableMemo']").val("").hide();
	    } else if (thisVal == "1") {
	        $('#attkrDisableMemoText').text('장애급수:');
	        $("#attkrFrm input[name='attkrDisableMemo']").show();
	    } else if (thisVal == "2") {
	        $('#attkrDisableMemoText').text('장애명:');
	        $("#attkrFrm input[name='attkrDisableMemo']").show();
	    } else if (thisVal == "3") {
	        $('#attkrDisableMemoText').text('장애명:');
	        $("#attkrFrm input[name='attkrDisableMemo']").show();
	    }
	}
	
	//가해자 정보 등록 국적
	function fnc_SUB_ATTKR_FRGER() {
	    var thisVal = $("#attkrFrm select[name='attkrFrger']").val();
	    if (thisVal == "Y") {
	        $('#attkrFrgerMemoText').text('현재국적');
	        $("#attkrFrm input[name='attkrFrgerMemo']").show();
	    } else {
	        $('#attkrFrgerMemoText').text('');
	        $("#attkrFrm input[name='attkrFrgerMemo']").val("").hide();
	    }
	}
	
	//가해시 특이사항 선택
	function fnc_SUB_ATTKR_STATE_YN() {
	    var valChecked = $("#attkrFrm input[name='attkrStateYn']:checked").val();
	    if (valChecked=="Y") {
	        $("#divATTKR_STATE").show();
	    } else {
	        $("#divATTKR_STATE").hide();
	        $("#attkrFrm input:checkbox[name='attkrState']").prop("checked", false);
	    }
	}
	
	function fn_submit() {
		var form = $("#attkrFrm")[0];
        var v = new MiyaValidator(form);
        
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
		
		var attkrRelGrpSub = $("#attkrFrm select[name='attkrRelGrp']").find('option:selected').attr('data-subcode');
		if ( jQuery.type( attkrRelGrpSub )=="undefined" || attkrRelGrpSub=="") { } else {
			v.add("attkrRel", {
				required: true
			});
		}
		
		v.add("attkrStateYn", {
		    required: true
		});

		var result = v.validate();
        if (!result) {
            alert(v.getErrorMessage());
            v.getErrorElement().focus();
            return;
        }
        
        var attkrStateYn = $("#attkrFrm input:radio[name='attkrStateYn']:checked").val();
        if(attkrStateYn == 'Y'){
        	if($("input:checkbox[name='attkrState']").is(":checked") == false) {
        		alert("가해자 특이사항이 있을경우 항목을 선택해주세요.");
        		return;
        	}
        }
        
		var _attkrState = "";
		$("input[name=attkrState]:checked").each(function() {
			_attkrState += $(this).val() + ", ";
		});
		$("#attkrState2").val(_attkrState.substr(0, _attkrState.length - 2));
		
		$("#historyMemo").val("[자동입력] 가해자 정보를 수정했습니다.");
		
		if (confirm('${empty result ? "가해자 정보를 등록" : "가해자 정보를 수정"}하시겠습니까?')) {
			var params = $("#attkrFrm").serialize();
			$.ajax({
				url : "${action}",
				data : params,
				type : 'POST',
				success : function(x) {
					window.opener.parent.attkrList();
					//window.opener.top.location.reload();
					window.close();
				}
			});
	    }
	}
	
	function fn_del() {
		if (confirm('가해자 정보를 삭제하시겠습니까?')) {
			$("#historyMemo").val("[자동입력] 가해자 정보를 삭제했습니다.");
			var params = $("#attkrFrm").serialize();
			$.ajax({
				url : '/bos/instance/case/deleteAttkr.json',
				data : params,
				success : function(x) {
					window.opener.parent.attkrList();
					//window.opener.top.location.reload()
					window.close();
				}
			});
	    }
	}



</script>

<form id="attkrFrm" name="attkrFrm" action="${action}" method="post">
    <input type="hidden" name="menuNo" value="${param.menuNo }" />
    <input type="hidden" name="caseSeq" value="${param.caseSeq }" />
    <input type="hidden" name="attkrSeq" value="${param.attkrSeq }" />
    <input type="hidden" id="attkrState2" name="attkrState2" value="" /> <!-- 가해시 특이사항 -->
   	<input type="hidden" id="historyMemo" name="historyMemo" value="" />
	    	
    <h1>가해자정보 등록</h1>
    <div class="bdView" style="width: 850px; margin: 100px 0px;">

        <table class="table03">
            <caption>가해자정보 등록</caption>
            <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
		            <th scope="row"><label for="attkrSex"><span class="essentialInputField req"><span>필수입력</span></span>성별</label></th>
		            <td>
		            	<select name="attkrSex" id="attkrSex" title="성별" >
							<script>
								getCmmnCd.select('MF', 'attkrSex', '${result.attkrSex}','N');
							</script>
						</select>
		            </td>
		            <th scope="row"><label for="attkrAge"><span class="essentialInputField req"><span>필수입력</span></span>나이</label></th>
		            <td>
		            	<select name="attkrAge" id="attkrAge" title="나이" >
							<script>
								getCmmnCd.select('ATAG', 'attkrAge', '${result.attkrAge}');
							</script>
						</select>
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="attkrDisable"><span class="essentialInputField req"><span>필수입력</span></span>장애</label></th>
					<td>
						<select name="attkrDisable" id="attkrDisable" title="장애여부" >
							<script>
								getCmmnCd.select('CDDA', 'attkrDisable', '${result.attkrDisable}');
							</script>
						</select>
						<b id="attkrDisableMemoText"></b>
						<input type="text" name="attkrDisableMemo" value="${result.attkrDisableMemo}" style="width:70px;display: none;">
					</td>
					<th scope="row"><label for="attkrFrger"><span class="essentialInputField req"><span>필수입력</span></span>국적</label></th>
					<td>
						<select name="attkrFrger" id="attkrFrger" title="국적" >
							<script>
								getCmmnCd.select('CSA7', 'attkrFrger', '${result.attkrFrger}');
							</script>
						</select>
	                    <b id="attkrFrgerMemoText"></b>
						<input type="text" name="attkrFrgerMemo" value="${result.attkrFrgerMemo}" style="width:100px;display: none;">
					</td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="attkrRelGrp"><span class="essentialInputField req"><span>필수입력</span></span>피해자와의 관계<br>(피해자기준)</label></th>
		            <td>
		            	<select name="attkrRelGrp" id="attkrRelGrp" title="피해자와의 관계" style="width: 100px">
							<script>
								getCmmnCd.select('CZ01G', 'attkrRelGrp', '${result.attkrRelGrp}');
							</script>
						</select>
						<select name="attkrRel" id="attkrRel" title="피해자와의 관계 서브" style="width: 100px">
							<script>
								getCmmnCd.select('CZ01', 'attkrRel', '${result.attkrRel}', 'N');
							</script>
						</select>
		            </td>
		            <td colspan="2">기타선택시내용:<input type="text" name="attkrRelMemo" value="${result.attkrRelMemo}" style="width:150px;"></td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="attkrStateYn"><span class="essentialInputField req"><span>필수입력</span></span>가해시 특이사항</label></th>
		            <td colspan=3>
		                <label><input name="attkrStateYn" id="attkrStateYn" type="radio" value="N" <c:if test="${result.attkrStateYn eq 'N' }">checked="checked"</c:if> /> 없음 </label> 
		                <label><input name="attkrStateYn" type="radio" value="Y" <c:if test="${result.attkrStateYn eq 'Y' }">checked="checked"</c:if> />있음</label>
		                <div id="divATTKR_STATE" style="display:none;">
                           	<div id="divATTKR_STATE" style="display:none;">
			                	<script>
			                		getCmmnCd.checkBox('ATST', 'divATTKR_STATE', 'attkrState', '${result.attkrState}');
			                	</script>
			                </div>
		                </div>
		            </td>
		        </tr>
		        <tr>
		            <th>
		            	세부사항
		            	<div class="bytes-wrapper">
                            <span id="bytesAttkrMemo">0</span> / 3,500bytes
                        </div>
		            </th>
		            <td colspan=3><textarea name="attkrMemo" id="attkrMemo" style="height:100px; width:100%;">${result.attkrMemo}</textarea>
		            </td>
		        </tr>
            </tbody>
        </table>
    </div>

</form>

<div class="btnSet" style="padding: 0 300px 0 0;">
    <a class="btn btn-primary" href="javascript:fn_submit()">저장</a> 
    <c:if test="${not empty result}">
    	<a class="btn btn-primary" href="javascript:fn_del();"><span>삭제</span> </a>
    </c:if>
    <a class="btn btn-primary" href="javascript:close();" style="background-color: #8C8C8C; border-color: #8C8C8C;" id="closeBtn"><span>취소</span> </a>
</div>

<script>
$('#attkrMemo').keyup(function (e){
    var content = $(this).val();
    $('#bytesAttkrMemo').html(content.length);    //글자수 실시간 카운팅

    if (content.length > 3500){
        alert("최대 3,500bytes까지 입력 가능합니다.");
        $(this).val(content.substring(0, 3500));
    }
});

$("#closeBtn").click(function() {
	self.close();
});


</script>