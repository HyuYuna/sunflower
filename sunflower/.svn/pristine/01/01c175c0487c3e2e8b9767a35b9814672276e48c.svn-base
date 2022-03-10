// var console = window.console || {log:function(){}};
function btnclassSetting(){
	$('[class^=b-]').addClass('btn btn-default');//쓰기,등록
	$('.b-reg').addClass('btn-primary');//쓰기,등록
	$('.b-del').addClass('btn-danger');//삭제
	$('.b-cancel').addClass('btn-default');//취소
	$('.b-end').addClass('btn-warning');//취소
	$('.b-edit').addClass('btn-success');//수정
	$('.b-list').addClass('btn-default');//목록
	$('.b-move').addClass('btn-warning');//이동
	$('.b-reply').addClass('btn-primary');//답글
	$('.b-sh').addClass('btn-default');//검색
	$('.b-sh2').addClass('btn-default');//검색
	$('.b-ok').addClass('btn-info');//확인
	$('.b-down').addClass('btn-success');//확인
	$('.b-reset').addClass('btn-warning');//확인
	$('.b-add').addClass('btn-success');//확인
	$('.b-apply2').addClass('btn-success btn-lg');//확인
	$('.b-view').addClass('btn-info');//보기,미리보기
	$('.b-hide').addClass('btn-info');//숨김
	$('.b-back').addClass('btn-default');//보기,미리보기
	$('.b-save').addClass('btn-success');//보기,미리보기
	$('.b-end').addClass('btn-danger');//종료
	$('.b-set').addClass('btn-info');//종료
	$('.b-open').addClass('btn-success');//종료
	$('.b-select').addClass('btn-success');//종료
	$('.b-pop').addClass('btn-success');//종료
	$('.b-login').addClass('btn-success');//로그인
	$('.b-disabled').addClass('btn-warning');//비활성
	$('.b-unlock').addClass('btn-success');//잠금해제
}

//$(document).on('DOMNodeInserted', function(event) {
//	//btnclassSetting();
//});

$(function() {
	$('.bdList>table').addClass('table')
	btnclassSetting();

	// btnclassSetting();
	// $(window).trigger('DOMNodeInserted')
});
/*
 * Function Name : popupW
 * Description   : 팝업창 띄운다
 * Parameters    : u - 주소, n - 이름, w - 넓이, h - 높이, s - 스크롤여부(yes, no), r - 창크기조절여부(yes, no), m - (1:일반, 2:위쪽모서리, 3:정중앙)
 */
function popupW(u, n, w, h, s, r, m) {
	var o;
	var lP = screen.availWidth;
	var tP = screen.availHeight;
	var p  = "";

	if(s==undefined) s = "no";
	if(m==undefined) m = 1;

	if(m==2) //- 위쪽모서리
		p = ",left=0,top=0";
	else if(m==3) //- 정중앙
		p = ",left=" + ((lP - w) / 2) + ",top=" + ((tP - h) / 2);

	o = window.open(u,n,"status=yes,toolbar=no,location=no,scrollbars=" + s + ",resizable="+r+",width="+w+",height="+h + p);
	o.focus();

}

/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com). */
jQuery(function($){
	if ($.datepicker!=undefined){
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
		monthNamesShort: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: '년'};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$(".sdate").datepicker({
		showOn: 'button', buttonImage: '/static/commons/img/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false,

	});
	$(".edate").datepicker({
		showOn: 'button', buttonImage: '/static/commons/img/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false
	});
	$(".date").datepicker({showOn: 'button', buttonImage: '/static/commons/img/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$(".month").datepicker( {
		showOn: 'button',
		buttonImage: '/static/commons/img/calendar.gif',
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		showMonthAfterYear:false,
		dateFormat: 'yy-mm',
		onClose: function(dateText, inst) {
				$(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
			}
		})
		.on('focus', function () {
			$(".ui-datepicker-calendar").hide();			
		})
	}
});

$(function() {
	//ttogle
	var toggle  = $('.toggle');
	toggle.find('dd').hide();
	toggle.find('dd:first').show();
	toggle.find('dt').on('click ' , function()    {
		toggle.find('dd').hide();
		toggle.find('a').removeClass('on');
		$(this).next().toggle();
		$(this).find('a').addClass('on');
		return false;
	});
	//roll over
	$(".rv a").on('mouseover keyup' , function()    { imgOn($(this))});
	$(".rv a").on('mouseout blur' , function()    { imgOff($(this))});

	/**
	 * 같은 값이 있는 열을 병합함
	 * 사용법 : $('#테이블 ID').rowspan(0);
	 */
	$.fn.rowspan = function(colIdx, sumTxt , isStats) {
		var $this = $(this);
		return this.each(function(){
			var that;
			$('tr', this).each(function(row) {
				$('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
					if ($(this).html() == $(that).html()&& ((!isStats || isStats && $(this).prev().html() == $(that).prev().html()) && $(this).html() !=sumTxt )) { // 값이 '소계' 이면 rowspan 안함.
						rowspan = $(that).attr("rowspan") || 1;
						rowspan = Number(rowspan)+1;

						$(that).attr("rowspan",rowspan);
						// do your action for the colspan cell here
						$(this).hide();
						//$(this).remove();
						// do your action for the old cell here

					} else {
						that = this;
					}

					if($(this).html() == sumTxt) $this.colspan(row,sumTxt); // row 돌때 마다 colspan

					// set the that if not already set
					that = (that == null) ? this : that;
				});


			});
		});
	};

	/**
	 * 같은 값이 있는 행을 병합함
	 * 사용법 : $('#테이블 ID').colspan(0);
	 */
	$.fn.colspan = function(rowIdx,sumTxt) {

   //   alert("col  :  "+rowIdx);

		return this.each(function(){

			var that;
			$('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
				$(this).find('td').filter(':visible').each(function(col) {
					if ($(this).html() == $(that).html() && $(that).html() == sumTxt) {
						colspan = $(that).attr("colSpan") || 1;
						colspan = Number(colspan)+1;

						$(that).attr("colSpan",colspan).css({"text-align" :"center","font-weight": "bold"});
						$(this).hide(); // .remove();
					} else {
						that = this;
					}

					// set the that if not already set
					that = (that == null) ? this : that;

				});
			});
		});
	};
});//ready


//배너관리 , 알림영역관리 , 팝업관리 SITE_ID_SE 값에 따라 체크하기
function ceckSiteIdSe(str){
	var arrStr = str.split(",");
	for (var i=0;i<arrStr.length;i++){
		$("INPUT[name='siteIdSe_"+arrStr[i]+"']").prop("checked",true);
	}
}

//배너관리 , 알림영역관리 , 팝업관리 체크한SITE_ID를 str로 만들기
function saveSiteIdSe(){
	var str = "";
	var len = $(".siteIdSe").length;
	for (var i = 0;i< len;i++){
		var bChk =$("#siteIdSe"+i).prop("checked");
		if (bChk){
			str += $("#siteIdSe"+i).val() + ",";
		}
	}
	$("#siteIdSe").val(str);
}