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
	//보드 공통
	$(".sdate").datepicker({showOn: 'button', buttonImage: '/static/img/commons/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$(".edate").datepicker({showOn: 'button', buttonImage: '/static/img/commons/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

// gnb
var menuover=false; //메뉴가 활성화 되고있는지 파악
var clearenter;
//공통 이미지 변경
function imgOn(item){
	var image = item.find("img");
	var imgsrc = $(image).attr("src");
	if ($(image).length)
	{
	var on = imgsrc.replace(/_off.gif/,"_on.gif");
	$(image).attr("src",on);
	}
}
function imgOff(item){
	var image = item.find("img");
	for(var i=0;i<image.length;i++){
		var imgsrc = $(image[i]).attr("src");
		var off = imgsrc.replace(/_on.gif/,"_off.gif");
		$(image[i]).attr("src",off);
	}
}
//메뉴
$(function(){
	//gnb 시작
	var gnb_link_depth1=$(".gnb>ul>li");	// 1depth
	var gnb_link_depth2=$(".gnb>ul>li>ul>li");	 // 2depth
	var d_time = 1000; // 마우스 아웃시 돌아가는 시간
	var current_menu;
	for (var i = 0; i < gnb_link_depth1.length ; i++ )
	{
		if (0<$(gnb_link_depth1[i]).find('img[src*=on]').length)
		{
			current_menu = i;
		}
	}
	gnb_link_depth1.each(function(){
		//add mouseOver
		$(this).on('mouseenter keyup' , function()    {
			imgOff(gnb_link_depth1);
			clearTimeout(clearenter);
			imgOn($(this).find('>a'));
			$(this).addClass("on").siblings().removeClass("on");
			menuover=true;
		});
		//add mouseOut
		$(this).on('mouseleave blur' , function()    {
			menuover=false;
			clearenter = setTimeout(menuclear,d_time);
		});
	});
	function menuclear(){
		if(!menuover){
			gnb_link_depth1.removeClass("on"); //지워야할 클래스위치
			imgOff(gnb_link_depth1);
			imgOn($(gnb_link_depth1[current_menu]).find('>a'));
			$(gnb_link_depth1[current_menu]).addClass('on');
		}
	}
	gnb_link_depth2.each(function(){
		//add mouseOver
		$(this).on('mouseover keyup' , function()    {
			clearTimeout(clearenter);
			imgOn($(this));
			$(this).addClass("on").siblings().removeClass("on");
			menuover=true;
		});
		//add mouseOut
		$(this).on('mouseout blur' , function()    {
			imgOff($(this));
			menuover=false;
			clearenter = setTimeout(menuclear,d_time);
		});
	});
// var nowpage = $("#gnb a")
//$(nowpage[0]).trigger("mouseover"); // 현재메뉴 활성화 페이지에 추가

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

function computeAge(birthdy)
{
	var birthday = birthdy.replace(/-/gi, '');
	var bday=parseInt(birthday.substring(6,8));
	var bmo=(parseInt(birthday.substring(4,6))-1);
	var byr=parseInt(birthday.substring(0,4));
	//alert(byr + "-" + bmo + "-" + bday);
	var byr;
	var age;
	var now = new Date();
	tday=now.getDate();
	tmo=(now.getMonth());
	tyr=(now.getFullYear());


	if((tmo > bmo)||(tmo==bmo & tday>bday)) {
	age=byr
	} else{
	age=byr+1;
	}

	return tyr-age;
}