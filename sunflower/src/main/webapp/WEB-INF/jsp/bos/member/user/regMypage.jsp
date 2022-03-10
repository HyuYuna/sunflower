<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- https-->
<!-- <script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> -->
<script>
//<![CDATA[
var idYN="";
var passwordYN="";

window.onload = function(){ 
	if(${empty result}){
		idYN="N";
	}else{
		idYN="Y";
	}
	
	passwordYN="N";
}

$(function() {
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
				$(this).val("2021-01-01");
			}
		}
	});
	
	$("#chkIdBtn").on('click',function() {
		var userId = $("#userId").val();
		if( !userId ) {
			alert("아이디를 입력해 주세요.");
			$("#userId")[0].focus();
			return;
		}
		$.getJSON(
			"/bos/member/user/checkId.json",
			{userId : userId},
			function(data) {
				if(data.cnt > 0){
					alert("사용하실 수 없는 아이디입니다.");
					$("#userId").val("");
					checkIdCount = 0;
					return;
				}else{
					alert("사용가능한 아이디입니다.");
					idYN="Y";
				}
			}
		);
	});
});

	var mode = "${empty result ? 'I' : 'M'}";
	var numberPattern = /[^0-9]/gi;
	var engPattern = /[^a-zA-Z]/gi;
	var numberEngPattern = /[^A-Za-z0-9.]/gi;
	var numberLowerEngPattern = /[^a-z0-9]/g;
	/*var passwordPattern = /^([a-zA-Z!@#$%^&*()_+=<>?0-9]{8,20})$/gi;*/

	$(function () {
		
		//숫자만 입력 가능
		$(".numberOnly").on("keyup", function() {
			if(numberPattern.test($(this).val())){
				alert("숫자만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberPattern,"") );
			}
		});
		//영문만 입력가능
		$(".engOnly").on("keyup", function() {
			if(engPattern.test($(this).val())){
				alert("영문만 입력가능합니다.");
				$(this).val( $(this).val().replace(engPattern,"") );
			}
		});

		//숫자와 영문(소문자)만입력 가능
		$(".numLowEngOnly").on("keyup", function() {
			if(numberLowerEngPattern.test($(this).val())){
				alert("숫자와 영문(소문자)만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberLowerEngPattern,"") );
			}
		});

		//숫자와 영문만입력 가능
		$(".numberEngOnly").on("keyup", function() {
			if(numberEngPattern.test($(this).val())){
				alert("숫자와 영문만 입력가능합니다.");
				$(this).val( $(this).val().replace(numberEngPattern,"") );
			}
		});
	});

    function checkPW(){
    	var reg1 = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/;
        var reg2 = /^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/;
        var reg3 = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,20}$/;
        var reg4 = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$/;
    	var pw = $("#userPassword").val();
    	var pw2 = $("#userPassword2").val();
    	var temp ="";
    	var count = 0;
    	
	    if(pw==pw2){
	    	if(('${result.userId}'!='' || '${result.userId}' != null) && (pw=='' || pw==null) && (pw2=='' || pw2==null)){
	    		//회원수정 and pw수정 안함
	    		passwordYN="Y";
	    	}else{
	    		//here
	    		if(true == reg1.test(pw)){count++;}
                if(true == reg2.test(pw)){count++;}
                if(true == reg3.test(pw)){count++;}
                if(true == reg4.test(pw)){count++;}
			   	if(count < 1) {
			   	    alert('비밀번호는 8글자 이상 20글자 이하, 영대문자, 영소문자, 숫자, 특수문자 중 3가지 이상 조합되어야 합니다.');
			   	    passwordYN="N";
			   	    count=0;
			   	    document.getElementById("userPassword").value ="";
                    document.getElementById("userPassword2").value ="";
			   	}else {
			   		passwordYN="Y";
			   		count=0;
			   	}
	    	}
	    }else{
	    	alert("비밀번호와 비밀번호확인란이 일치하지 않습니다.");
            document.getElementById("userPassword").value ="";
            document.getElementById("userPassword2").value ="";
            passwordYN="N";
    	}
	}
	
	function checkForm() {
		var form = document.regForm;
		var v = new MiyaValidator(form);
	    
		v.add("userName", {
		    required : true,
			trim : true
		},"이름");
		v.add("userId", {
			required: true,
			trim : true,
			minlength : 5
		},"아이디");
		if(!$("#userPassword").val() == '' || !$("#userPassword2").val() == ''){
		    v.add("userPassword", {
				required: true,
				trim : true
			},"비밀번호"); 
		    v.add("userPassword2", {
				required: true,
				trim : true
			},"비밀번호 확인");
		}
		var result = v.validate();
		
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
	    if(idYN=='N'){
            alert("아이디 중복확인을 해주세요.");
	    }
	    checkPW();
	    if(idYN=='Y' && passwordYN=='Y'){
			if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			    form.submit();
			}
        }
    }

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
//]]>
</script>
      
<form name="regForm" id="regForm" method="post" action="/bos/member/user/insertMypage.do" enctype="multipart/form-data" class="pure-form">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'/>
	<input type="hidden" id="atchFileId" name="atchFileId" value="${fn:trim(result.atchFileId)}">
	
    <table class="table03">
            <colgroup>
                <col width="15%" /> 
                <col width="35%" /> 
                <col width="15%" /> 
                <col width="35%" /> 
            </colgroup> 
            <thead>
                <tr>
                    <th colspan="4">사용자정보</th>
                </tr>
            </thead>
			<tbody> 
	            <tr> 
	                <th>이름</th>
	                <td class="align-left"><input type="text" id="userName" name="userName" value="${result.userName}" /></td>
	                <th>아이디</th>
	                <td class="align-left">
	                <c:if test="${empty result}">
	                    <input type="text" class="form-inline" id="userId" name="userId" value="${result.userId}" onchange="checkIdCount=0;"/>
	                    <button type="button" class="b-ok" id="chkIdBtn" name="chkIdBtn">중복확인</button>
	                </c:if>
	                <c:if test="${!empty result}">
	                    <input type="text" name="userId" id="userId" value="${result.userId }" readonly/>
	                </c:if>
	                </td>
	            </tr>
	            <tr>
	                <th rowspan="2"><span class="essentialInputField">비밀번호</span></th>
	                <td class="align-left"><input type="password" name="userPassword" id="userPassword" maxlength="20" value="" /></td>
	                <th><span class="essentialInputField">비밀번호확인</span></th>
	                <td class="align-left"><input type="password" name="userPassword2" id="userPassword2" maxlength="20" value="" /></td>
	            </tr>
	            <tr>
	                <td colspan="4"  class="align-left"><c:if test="${!empty result}">비밀번호란이 비어있으면 비밀번호가 변경되지 않습니다.</br></c:if>비밀번호는 8글자 이상 20글자 이하, 영대문자, 영소문자, 숫자, 특수문자 중 3가지 이상 조합되어야 합니다.</td>
	            </tr>
	            <tr>
	                <th>생일</th>
	                <td class="align-left"><input type="text" id="userBirth" name="userBirth" class="formatDate" title="생일" value="${result.userBirth}" readonly="readonly" /></td>
	                <th>연락처</th>
	                <td class="align-left"><input type="text" name="userPhone" id="userPhone" value="${result.userPhone }" /></td>
	            </tr>
	            <tr>
	                <th>센터구분</th>
	                <td class="align-left">
	                    <select name="centerGbn" id="centerGbn" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','centerCode',this.value , '', 'N')">
	            <script>
	                getCmmnCd.select('CM04', 'centerGbn', '${result.centerGbnCode}', 'N');
	            </script>
	        </select>
	                </td>
	                <th>센터</th>
	                <td class="align-left">
	                    <select name="centerCode" id="centerCode" title="센터 구분 서브" >
	                        <script>
	                            getCmmnCd.subSelect('CM05','centerCode','${result.centerGbnCode}', '${result.centerCode}', 'N')
	                        </script>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <th>입사일자</th>
	                <td class="align-left"><input id="userBdate" name="userBdate" class="formatDate" title="입사일자" placeholder="입사일자" value="${result.userBdate}" type="text" readonly="readonly"></td>
	                <th>퇴사일자</th>
	                <td class="align-left"><input id="userEdate" name="userEdate" class="formatDate" title="퇴사일자" placeholder="퇴사일자" value="${result.userEdate}" type="text" readonly="readonly"></td>
	            </tr>
	            <tr>
	                <th>부서</th>
	                <td class="align-left"><input type="text" name="userDepartment" id="userDepartment" value="${result.userDepartment}" /></td>
	                <th>직위</th>
	                <td class="align-left"><input type="text" name="userPosition"   id="userPosition" value="${result.userPosition}" /></td>
	            </tr>
	            <tr>
	                <th>성별</th>
	                <td class="align-left">
	                    <input type="radio" id="userSex1" name="userSex" value="F" <c:if test="${result.userSex eq 'F'}"> checked</c:if> /> 여자
	                    <input type="radio" id="userSex2" name="userSex" value="M" <c:if test="${result.userSex eq 'M'}"> checked</c:if> /> 남자
	                    <input type="radio" id="userSex3" name="userSex" value="E" <c:if test="${result.userSex eq 'E'}"> checked</c:if> /> 알수없음
	                </td> 
	                <th>이메일</th>
	                <td class="align-left"><input type="text" name="userEmail" id="userEmail" value="${result.userEmail }" style="width:95%;" /></td>
	            </tr>
			</tbody>
		</table>
    </form>
<div class="btnSet">
        <a class="pure-button btnUpdate" href="javascript:checkForm();">${empty result ? '등록' : '수정'}</a>
</div>
