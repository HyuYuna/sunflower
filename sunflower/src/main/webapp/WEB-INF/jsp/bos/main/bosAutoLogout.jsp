<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<script type="text/javascript">

var base_time_min = '${loginPolicy.baseTime}';

var alertTime = '${loginPolicy.atmcLogoutTimeAlert}'

if( !(base_time_min != '' && base_time_min != null) ){
	base_time_min = 60;
}
var sec_per_min = 60;
var base_hour;
var base_min;


//시간단위 분단위
if(Math.floor(base_time_min / 60)>=1){
	base_hour = Math.floor(base_time_min / 60);
	base_min = (base_time_min % 60);
	base_min = base_min < 10 ? "0" + base_min : base_min;
	
	$('#ViewTimer').html("(" + base_hour + "시간" + base_min + "분 00초)");
}else if(Math.floor(base_time_min / 60) < 1) {
	base_min = (base_time_min % 60);
	base_min = base_min < 10 ? "0" + base_min : base_min;
	
	$('#ViewTimer').html("("+ base_min + "분 00초)");
}

var base_time = base_time_min * sec_per_min;

var setTime = base_time; // 최초 설정 시간(기본 : 초)
var hourTs1; //시간단위
var minTs1; //분단위
var minTs2; //분단위2
var secTs1; //초단위

$(function() {
	$('.vTimeResets').on('click',function() {
		setTime = base_time + 1;
	});
	oTime = setInterval('out_time()', 1000);
	
	//패스워드 체크
	var changePassYn = '${changePasswordYn}';
	if(changePassYn== 'Y'){
		fnChangePasswordDayOver();
	}
	
	$("#passwordChange").click(function(){
		if($("#pwd").val()==''){
			alert('현재 비밀번호를 입력하세요.');
			$("#pwd").focus();
			return;
		}else if($("#pwd1").val()==''){
			alert('새 비밀번호를 입력하세요.');
			$("#pwd1").focus();
			return;
		}else if($("#pwd").val() == $("#pwd1").val()){
			alert('새 비밀번호가 현재 비밀번호와 같으면 안됩니다. 다시 입력하세요.');
			$("#pwd1").focus();
			return;
		}else if($("#pwd1").val() != $("#pwd2").val()){
			alert('새 비밀번호를 다시 입력하세요.');
			$("#pwd2").focus();
			return;
		}else{
			var pwReg = /^[a-zA-Z0-9]{8,12}$/;
			var pw = $("#pwd1").val();
			//if(!pwReg.test(pw))
			if(pw.length<8 && pw.length>12)
			{
				alert('비밀번호는 영문/숫자/특수문자를 조합하여 8~12자로 설정 해야 합니다.');
				$("#pwd1").focus();
				return;
			}

			var chk_num = pw.search(/[0-9]/g);
			var chk_eng = pw.search(/[a-z]/ig);
			var chk_spe = pw.search(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi);

			if(chk_num < 0 || chk_eng < 0 || chk_spe < 0)
			{
				alert('비밀번호는 영문/숫자/특수문자를 조합하여 8~12자로 설정 해야 합니다.');
				$("#pwd1").focus();
				return;
			}

			if(confirm('비밀번호를 변경하시겠습니까?')){
				$.ajax({
					type:"post",
					url:"/bos/member/user/changeUserPassword.json" ,
					data: $("#changePassForm").serialize(),
					dataType: "json",
					success:function(entry){
						if(entry.modCnt >= 1){
							alert("변경되었습니다.");
							$('#changePassForm').attr('action', '/bos/main/main.do');
							$('#changePassForm').submit();	
						}else{
							alert("현재 비밀번호가 틀렸습니다.");
						}
					},
					fail:function(entry){
						alert("저장실패 : "+ entry);
					}
				});
			}
		}

	});
	
});

function out_time() { // 1초씩 카운트
	--setTime;
	
	if(setTime == alertTime*60){
		if(confirm(alertTime+"분 남았습니다 연장하시겠습니까?")){
			setTime=base_time;
		}
	}
	
	
	if (setTime < 0) {
		clearInterval(oTime); // 타이머 해제
		//alert("자동로그아웃이 되었습니다.");
		document.location.href = "/bos/member/admin/logout.do";
	} else {
		//1시간 = 3600초 보다 크면
		if(Math.floor(setTime / 3600) >= 1){
			
			hourTs1 = Math.floor(setTime / 3600)
			minTs2 = (setTime % 3600);
			minTs1 =  Math.floor(minTs2 / 60)
			secTs1 = (minTs2 % 60);
			
			secTs1 = secTs1 < 10 ? "0" + secTs1 : secTs1;
			minTs1 = minTs1 < 10 ? "0" + minTs1 : minTs1;
			
			m = "(" + hourTs1 +"시간"+ minTs1 + "분 " + secTs1 + "초)";
		}else{
			minTs1 = Math.floor(setTime / 60);
			secTs1 = (setTime % 60);
			
			secTs1 = secTs1 < 10 ? "0" + secTs1 : secTs1;
			minTs1 = minTs1 < 10 ? "0" + minTs1 : minTs1;
			
			m = "(" + minTs1 + "분 " + secTs1 + "초)";
		}

		$('#ViewTimer').html(m);
	}
}


function fnChangePasswordDayOver() {
	
	$("body").append('<div id="dialogpasswordTop" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front password-change ui-draggable ui-resizable" style="position: absolute;	height: auto;	width: 600px;	top: 132px;	left: 351px;	display: block;	z-index: 101;"></div>');
	
	$("#dialogpasswordTop").append('<div id="dialogpassword" class="password-layer ui-dialog-content ui-widget-content" style="display: block;width: auto;min-height: 0px;max-height: none;height: 379px; overflow: hidden;"></div>');		
	$("#dialogpassword").append('<form name="changePassForm" id="changePassForm" method="post" action=""></form>');		
	$("#changePassForm").append('<input type="hidden" name="userId" value="${adminUser2.userId}"/>');
	
	$("#changePassForm").append('<p class="text01">비밀번호 변경 요청</p>')
	$("#changePassForm").append('<p class="text02">비밀번호를 변경해 주세요.</p>')
	$("#changePassForm").append('<p class="text03"><span>' 
				+ '${adminUser2.userNm}' 
				+ '회원님<br>비밀번호를 변경한지 ' 
				+'${loginPolicy.passwordDeriveDaycnt}'
				+'일이 지났습니다.<br>소중한 개인정보를 안전하게 지키기 위해서 비밀번호를<br>변경 후 이용하실 수 있습니다.</p>'
			);
	$("#changePassForm").append('<dl>'
					+'<dt><label for="pwd">현재 비밀번호</label></dt>'
					+'<dd><input type="password" id="pwd" name="oldPassword"></dd>'
				+'</dl>'
				+'<dl>'
					+'<dt><label for="pwd1">새 비밀번호</label></dt>'
					+'<dd><input type="password" id="pwd1" name="newPassword1"> <span>※  8~12자리 영문, 숫자, 특수문자 포함</span></dd>'
				+'</dl>'
				+'<dl>'
					+'<dt><label for="pwd2">새 비밀번호 확인</label></dt>'
					+'<dd><input type="password" id="pwd2" name="newPassword2"></dd>'
				+'</dl>'
			);
			
	$("#changePassForm").append('<div class="btn-area">'
				+'<a href="#" id="passwordChange"  >변경완료</a>'
				+'</div>'
			);
	$("body").append('<div class="ui-widget-overlay ui-front" style="z-index: 99; background-color:#000"></div>')
	
	}


</script>