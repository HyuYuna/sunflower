<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>


<div class="catpchaSet">
	<p class="help">아래 이미지의 숫자를 보이는 대로 입력하여 주세요.</p>
	<div class="set">
		<div class="l">
			<div id="catpcha"></div>
			<div id="audiocatpch" style="display: none;"></div>
			<div class="b">
				<button id="reLoad" type="button"><i class="fa fa-refresh" aria-hidden="true"></i><span class="sr-only">새로고침</span></button>
				<button id="soundOnKor" type="button"><i class="fa fa-volume-up" aria-hidden="true"></i><span class="sr-only">한글음성</span></button>
			</div>
		</div>
		<input type="text" id="catpchaAnswer" name="catpchaAnswer" value="" maxlength="5"/>
	</div>
</div>

<script>
var rand;

//캡차 오디오 요청
function audioCaptcha(type) {
	var kor = (type > 0) ? "lan=kor&":"";
	$.ajax({
		url: '/cmmn/captcha/sound.do',
		type: 'POST',
		dataType: 'text',
		data: 'rand=' + rand + '&ans=y',
		async: false,
		success: function(resp) {
			//alert(resp);
			var uAgent = navigator.userAgent;
			var soundUrl = '/cmmn/captcha/sound.do?' + kor + 'rand=' + rand;
			//console.log(soundUrl);
			if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
				winPlayer(soundUrl+'&agent=msie');
			} else if (!!document.createElement('audio').canPlayType) {
				try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
			} else window.open(soundUrl, '', 'width=1,height=1');
		}
	});
}
function winPlayer(objUrl) {
	$('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
}

//캡차 이미지 요청 (캐쉬문제로 인해 이미지가 변경되지 않을수있으므로 요청시마다 랜덤숫자를 생성하여 요청)
function changeCaptcha() {
	rand = Math.random();
	$('#catpcha').html('<img src="/cmmn/captcha/image.do?rand=' + rand + '" alt/>');
}

changeCaptcha(); //캡차 이미지 요청

$('#reLoad').on('click',function(){ changeCaptcha(); }); //새로고침버튼에 클릭이벤트 등록
/* $('#soundOn').on('click',function(){ audioCaptcha(0); });	*/ //음성듣기버튼에 클릭이벤트 등록
$('#soundOnKor').on('click',function(){ audioCaptcha(1); }); //한글음성듣기 버튼에 클릭이벤트 등록
</script>