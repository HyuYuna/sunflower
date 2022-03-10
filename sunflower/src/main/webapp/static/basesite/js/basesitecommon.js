//달력 컨트롤 활성
function showCalendar(ele, eleText, target){
	var sText = eleText;
	var sobjId = ele.slice(0, -4);//-lry 문자열 지움
	var eleIfr = "<div id=\""+ele+"\" class=\"calendarSLayer\"><iframe id=\""+sobjId+"-ifrm\" name=\""+sobjId+"-ifrm\" class=\"calendar-frame\" src=\"/kfoodjob/view/layerCalendar.jsp\" title=\""+sText+" 날짜입력 프레임\" frameborder=\"0\" scrolling=\"no\"><\/iframe></div>";
	if (!$('#'+ele).length) {$("#calendarID_"+sobjId).append(eleIfr);}//레이어 생성
	var $this = $(target);
	if(($("#content").width()/2) < $this.parent().prev().position().left){	//중간에서 오른쪽에 있을 경우
		$this.next().find(".calendar-frame").css("right", "0");
	}else{
		$this.next().find(".calendar-frame").css("left", "0");
	}
	var ele = document.getElementById(ele);
	if(ele.style.display != 'block'){
		$(".calendarSLayer").css("display", "none");
		$(".calendarzone").css("z-index", "0");
		ele.style.display ="block";
		ele.parentNode.style.zIndex = "100";
	}else{
		$(".calendarSLayer").remove();//레이어 제거
	}
	return false;
}
function fnSetDynamicCalendar() {
	// console.time("concatenation");
	$(':text.sdate,:text.edate,:text.date').each(function(i) {
		$this = $(this);
		if ($this.attr("data-dateControl")==undefined) {
			$this.attr("data-dateControl",true);
			switch ($this[0].className){
				case "sdate":
				  sText = "시작";break;
				case "edate":
				  sText = "종료";break;
				case "date":
				  sText = "";break;
				default:
				  sText = "";
			}
			var sobjId = $this.attr("id");
			if (!sobjId) {
				$this.attr("id",$this.attr("name"));
				sobjId = $this.attr("name");
			}
			var innerhtml	="<div class='calendarzone' id='calendarID_"+sobjId+"'>"
							+"<input type='button' value='"+sText+"날짜 달력에서 선택'"
							+"onclick=\"return showCalendar('" + sobjId + "-lry','" + sText + "',this)\"/>"
							+"</div>";
			$this.after( innerhtml );
		}
	});
	// console.timeEnd("concatenation")
}
$(function() {
	fnSetDynamicCalendar();//초기 달력 세팅
});
// $(document).on("click",".calendarzone input", function() {  // 추가선택자를 넣고 동적이벤트 바인딩을 할경우 선택자는 document로 지정한다.
// 	// console.log('추가 이벤트 내역')
// });

function checkSearchForm(form){
	if (!form.q.value) {
		alert("검색어를 입력하세요.");
		form.q.focus();
		return false;
	}
	return true;
}