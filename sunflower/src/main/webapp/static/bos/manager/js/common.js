//-------------------------------------------------------------------//
// 상단메뉴 이벤트
//-------------------------------------------------------------------//

	var disappeardelay=250  //menu disappear speed onMouseout (in miliseconds)
	var enableanchorlink=0 //Enable or disable the anchor link when clicked on? (1=e, 0=d)
	var hidemenu_onclick=1 //hide menu when user clicks within menu? (1=yes, 0=no)


	var ie5=document.all
	var ns6=document.getElementById&&!document.all

	function getposOffset(what, offsettype){
		var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
		var parentEl=what.offsetParent;
		while (parentEl!=null){
			totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
			parentEl=parentEl.offsetParent;
		}
		return totaloffset;
	}

	function showhide(obj, e, visible, hidden){
		if (ie5||ns6)
			dropmenuobj.style.left=dropmenuobj.style.top=-500
		if (e.type=="click" && obj.visibility==hidden || e.type=="mouseover")
			obj.visibility=visible
		else if (e.type=="click")
			obj.visibility=hidden
	}

	function iecompattest(){
		return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
	}

	function clearbrowseredge(obj, whichedge){
		var edgeoffset=0
		if (whichedge=="rightedge"){
		var windowedge=ie5 && !window.opera? iecompattest().scrollLeft+iecompattest().clientWidth-15 : window.pageXOffset+window.innerWidth-15
			dropmenuobj.contentmeasure=dropmenuobj.offsetWidth
		if (windowedge-dropmenuobj.x < dropmenuobj.contentmeasure)
			edgeoffset=dropmenuobj.contentmeasure-obj.offsetWidth
		}
		else{
		var windowedge=ie5 && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset+window.innerHeight-18
			dropmenuobj.contentmeasure=dropmenuobj.offsetHeight
		if (windowedge-dropmenuobj.y < dropmenuobj.contentmeasure)
			edgeoffset=dropmenuobj.contentmeasure+obj.offsetHeight
		}
		return edgeoffset
	}

	function dropdownmenu(obj, e, dropmenuID){
		if (window.event) event.cancelBubble=true
		else if (e.stopPropagation) e.stopPropagation()
		if (typeof dropmenuobj!="undefined") //hide previous menu
			dropmenuobj.style.visibility="hidden"
			clearhidemenu()
		if (ie5||ns6){
			obj.onmouseout=delayhidemenu
			dropmenuobj=document.getElementById(dropmenuID)
		if (hidemenu_onclick) dropmenuobj.onclick=function(){dropmenuobj.style.visibility='hidden'}
			dropmenuobj.onmouseover=clearhidemenu
			dropmenuobj.onmouseout=ie5? function(){ dynamichide(event)} : function(event){ dynamichide(event)}
			showhide(dropmenuobj.style, e, "visible", "hidden")
			dropmenuobj.x=getposOffset(obj, "left")
			dropmenuobj.y=getposOffset(obj, "top")
			dropmenuobj.style.left=dropmenuobj.x-clearbrowseredge(obj, "rightedge")+"px"
			dropmenuobj.style.top=dropmenuobj.y-clearbrowseredge(obj, "bottomedge")+obj.offsetHeight+"px"
		}
		return clickreturnvalue()
	}

	function clickreturnvalue(){
		if ((ie5||ns6) && !enableanchorlink) return false
		else return true
	}

	function contains_ns6(a, b) {
		while (b.parentNode)
		if ((b = b.parentNode) == a)
		return true;
		return false;
	}

	function dynamichide(e){
		if (ie5&&!dropmenuobj.contains(e.toElement))
			delayhidemenu()
		else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
		delayhidemenu()
	}

	function delayhidemenu(){
		delayhide=setTimeout("dropmenuobj.style.visibility='hidden'",disappeardelay)
	}

	function clearhidemenu(){
		if (typeof delayhide!="undefined")
			clearTimeout(delayhide)
	}
//-------------------------------------------------------------------//
// 상태표시줄 주소 숨김
//-------------------------------------------------------------------//
/*
	function hidestatus(){
	    window.top.status='::EPIC::'
	    return true
	}
	if (document.layers)
	document.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT)
	document.onmouseover=hidestatus
	document.onmouseout=hidestatus
*/


/*****************************************************************************
 * 페이지 이동                                   *
 *****************************************************************************/


	function goPage(goLink,qMark,alertBoolen){

		var params = $('#frm').serialize();

		if (alertBoolen=="secret"){
				$("#secretBoIdx").val(goLink);
				$("#secretType").val('1'); // 보기용 비밀번호 입력
				$(".layer_pop").show();	
				$("#strPassworldCheck").focus();
		}else if (alertBoolen=="delsecret"){
				$("#secretBoIdx").val(goLink);
				$("#secretType").val('2'); // 삭제용 비밀번호 입력
				$(".layer_pop").show();	
				$("#strPassworldCheck").focus();
		}else if (alertBoolen=="modsecret"){
				$("#secretBoIdx").val(goLink);
				$("#secretType").val('3'); // 수정용 비밀번호 입력
				$(".layer_pop").show();	
				$("#strPassworldCheck").focus();
		}else{
			if (qMark.length == ""){
				qMark = "&" ;
			}
			if (alertBoolen == "true"){
					alert(goLink);
					return;
			}else{
					goLink = goLink + qMark + params ;
					document.location.href = goLink ;
			}
		}
	}

/*****************************************************************************
 * 페이지 이동 2                                   *
 *****************************************************************************/


	function goPageOther(goLink,qMark,alertBoolen){

		var params = $('#otherFrm').serialize();

		if (qMark.length == "")
		{
			qMark = "&" ;
		}

		if (alertBoolen == "true")
		{
				alert(goLink);
				return;
		}
		else {
				goLink = goLink + qMark + params ;
				document.location.href = goLink ;
		}
	}


/*****************************************************************************
 * 삭제 메뉴 사용                                   *
 *****************************************************************************/

		function btnDEL_OnClick(goLink,qMark,alertBoolen) 
		{
			if (alertBoolen == "true" ) // 삭제할 수 없는 경우
			{
				alert(goLink);
				return ;
			}
			else if(alertBoolen == "delsecret")
			{
				goPage(goLink,qMark,alertBoolen)
			}else{
				delete_ok=confirm("정말로 삭제를 하시겠습니까?")

				if(delete_ok){ 
					goPage(goLink,qMark,alertBoolen);
				}
				else {
					return ;
				}
			}
		}



/*****************************************************************************
 * 쓰기 폼 히든                                   *
 *****************************************************************************/


	function btnCancel(){

		var objdiv=document.getElementById("write_modify");           //
 		var objdiv2=document.getElementById("write_modify_title");           //
		
		    objdiv.style.display = "none"; 
		    objdiv2.style.display = "none"; 
		    frm.task.value="";
	}


	function btnCancel_remark(){

		var objdiv=document.getElementById("write_modify");           //
 		var objdiv2=document.getElementById("write_modify_title");           //
		var objdiv3=document.getElementById("write_modify_remark");
		
		    //objdiv.style.display = "none"; 
		    objdiv2.style.display = "none"; 
		    objdiv3.style.display = "none"; 

			$('#write_modify').slideUp();

		    frm.task.value="";
	}


/*****************************************************************************
 * 입력 폼 유효성 체크                                     *
 *****************************************************************************/

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/gi, "");
}

function checkForm(f) {
	var fLen = f.elements.length;
	var fObj;   // 폼 요소
	var fTyp;   // 폼 요소 Type
	var fVal;   // 폼 요소 Value
	var fMsg;   // 경고 메시지 속성
	var fNum;   // 숫자만 입력 속성
	var fMax;   // 최대 길이 지정
	var fMin;   // 최소 길이 지정
	var fMxN;   // 최대값 지정
	var fMnN;   // 최소값 지정
	var fMal;   // 메일 FORMAT

	for(var fi = 0 ; fi < fLen ; fi++) {
		fObj = f.elements[fi];
		fTyp = toUpperCase(fObj.getAttribute("type"));
		fVal = fObj.value;
		fCnd = toUpperCase(fObj.getAttribute("cndt"));        // 필수입력
		fExY = toUpperCase(fObj.getAttribute("exe_y")); // 허용되는 파일형식
		fExN = toUpperCase(fObj.getAttribute("exe_n")); // 허용되지 않는 파일형식
		fMsg = fObj.getAttribute("title");        // 경고 메시지
		fNum = fObj.getAttribute("chknum");     // 숫자만 기입 가능하도록
		fPho = fObj.getAttribute("chkphone");     // 전화번호 체크
		fMax = fObj.getAttribute("maxlength");     // 최대 입력글자수 제한
		fMin = fObj.getAttribute("minlength");     // 최소 입력글자수 제한
		fMxN = fObj.getAttribute("maxnum");     // 최대 숫자 제한
		fMnN = fObj.getAttribute("minnum");     // 최소 숫자 제한
		fMal = fObj.getAttribute("chkmail");    // 이메일 체크		
		fChr = fObj.getAttribute("chkChr");    // 특수문자 체크		
		fChk = fObj.getAttribute("chkKor");    // 한글 체크
		fChE = fObj.getAttribute("chkENG");    // 영대문자 체크
		fID  = fObj.getAttribute("chkid");    // 아이디 영문소문자, 숫자
		fPW  = fObj.getAttribute("chkpw");    // 비밀번호 영문자,숫자,특수문자
		fJu2 = fObj.getAttribute("jumin2");    // 주민번호 체크	
		fpd2 = fObj.getAttribute("pd2");    // 비밀번호확인 체크	
		fLi2 = fObj.getAttribute("license2");    // 사업자번호체크

		if (fCnd =="Y" && (fTyp == "TEXT" || fTyp == "HIDDEN" || fTyp == "TEXTAREA" || fTyp == "PASSWORD" || fTyp == "FILE") && fVal.trim() == "") {
			alert(fMsg + get_ending(fMsg,'을') + " 입력해 주세요");
			if (fTyp != "HIDDEN") {fObj.focus();}
			return false;
		}

		if (fTyp == "FILE" && fExY) {
			str = fExY.replace(/ /g,"")
			array_exe = str.split(",")
			if(CheckFileExtY(fObj, array_exe) == false){
				alert(fObj.title+"에 첨부할 수 없는 파일 형식 입니다.\n\n"+get_exe_array(array_exe)+" 파일만 첨부할 수 있습니다.");
				fObj.focus();
				return false;
			}
		}
		if (fTyp == "FILE" && fExN) {
			str = fExN.replace(/ /g,"")
			array_exe = str.split(",")
			if(CheckFileExtN(fObj, array_exe) == false){
				alert(fObj.title+"에 첨부할 수 없는 파일 형식 입니다.\n\n"+get_exe_array(array_exe)+" 파일은 첨부할 수 없습니다.");
				fObj.focus();
				return false;
			}
		}
		if (fCnd =="Y" && (fTyp == "SELECT-ONE" || fTyp == "SELECT-MULTIPLE") && fVal =="") {
			alert(fMsg + get_ending(fMsg,'을') + " 선택해 주세요");
			fObj.focus(); return false;
		}
		if (fCnd =="Y" && (fTyp == "RADIO" || fTyp == "CHECKBOX") && checkChecked(fObj) == false) {
			alert(fMsg + get_ending(fMsg,'을') + " 선택해 주세요");
			fObj.focus(); return false;
		}
		if (fNum != null && isNaN(fVal)) {
			alert(fMsg + get_ending(fMsg,'을')  + " 숫자로만 입력해 주세요");
			fObj.focus(); return false;
		}
		if (fMax != null && fMax < getLen(fVal)) {
			alert(fMsg + "의 입력된 글자수가 "+fMax+"자 이하여야 합니다.\n(영문 "+fMax+"자, 한글 "+Math.floor(fMax/2)+"자 까지 가능합니다.)");
			fObj.focus(); return false;
		}
		if (fMin != null && fMin > getLen(fVal)) {
			alert(fMsg + "의 입력된 글자수가 "+fMin+"자 이상이어야 합니다.");
			fObj.focus(); return false;
		}
		if (fMxN != null && parseInt(fMxN) < parseInt(fVal)) {
			alert(fMsg + "의 입력된 숫자는 "+fMxN+"보다 작아야합니다.");
			fObj.focus(); return false;
		}
		if (fMnN != null && parseInt(fMnN) > parseInt(fVal)) {
			alert(fMsg + "의 입력된 숫자는 "+fMnN+"보다 커야합니다.");
			fObj.focus(); return false;
		}
		if (fPho != null && checkPho(fVal) == false && fVal != "") {
			alert(fMsg + get_ending(fMsg,'은')  + " 숫자와 '-' 만 입력하실수 있습니다");
			fObj.focus(); return false;
		}
		if (fChr != null && checkChr(fVal) == false && fVal != "") {
			alert(fMsg + get_ending(fMsg,'은')  + " 특수문자는 입력하실수 없습니다");
			fObj.focus(); return false;
		}
		if (fChk != null && checkChk(fVal) == false && fVal != "") {
			alert(fMsg + get_ending(fMsg,'은')  + " 한글은 입력하실수 없습니다");
			fObj.focus(); return false;
		}
		if (fChE != null && checkChE(fVal) == false && fVal != "") {
			alert(fMsg + get_ending(fMsg,'은')  + " 영문대문자는 입력하실수 없습니다");
			fObj.focus(); return false;
		}

		if (fMal != null && checkEmail(fVal) == false && fVal != "") {
			alert("이메일 주소가 올바르지 않습니다");
			fObj.focus(); return false;
		}
		if (fJu2 != null  && fVal != "" && checkjumin(f.sap_stcd1.value)==false) {
			if(f.sap_stcd1.value.length == 13){
				alert ("주민등록번호가 틀렸습니다.");
				f.sap_stcd1.focus(); return false;
			}
			else if(f.sap_stcd1.value.length != 10){
				alert ("법인번호가 틀렸습니다.");
				f.sap_stcd1.focus(); return false;
			}
		}
		if (fpd2 != null  && fVal != "" && (f.an_pwd.value!=f.an_pwd_ok.value)) {
			alert ("비밀번호가 일치하지 않습니다");
			f.an_pwd_ok.focus(); return false;
		}
		if (fLi2 != null  && fVal != "" && checkbusino(f.M011_LICENSE1.value+"-"+f.M011_LICENSE2.value+"-"+f.M011_LICENSE3.value)==false) {
			alert ("사업자 등록 번호가 틀렸습니다");
			f.M011_LICENSE1.focus(); return false;
		}
	}
	return true;
}

//-------------------------------------------------------------------//
	//어미 구하기
//------------------------------------------------------------------//
	function get_ending(str,opt){
		var last_ch = str.substr(str.length-1, 1)
		var hex_ch  = escape(last_ch).replace("%u","")
		var int_ch  = parseInt(hex_ch, 16)
		var third   = ( ( int_ch - 44032 ) % ( 21 * 28 ) ) % 28;
		if(opt == "은"){
			if(third == 0){
				var ending = "는"
			}
			else{
				var ending = "은"
			}
		}
		if(opt == "을"){
			if(third == 0){
				var ending = "를"
			}
			else{
				var ending = "을"
			}
		}
			return ending
	}

function initForm(f)    {
	var nLen;   // form 요소의 갯수
	var ival;   // 각 요소의 default value 값 즉! 초기화하고자 하는값
	var fTyp;   // form 요소의 타입(select, radio, checkbox...)

	for(var i = 0; i < f.elements.length; i++) {
		fTyp = toUpperCase(f.elements[i].type);
		ival = f.elements[i].ival;

		if (ival && fTyp == "SELECT-ONE") {
			nLen = f.elements[i].options.length;
			for(var j = 0; j < nLen; j++) {
				if (f.elements[i].options[j].value == ival)
					f.elements[i].options[j].selected = true;
			}
		}
		if (fTyp == "SELECT-MULTIPLE") {
			nLen = f.elements[i].options.length;
			for(var j = 0; j < nLen; j++) {
				if (f.elements[i].options[j].value == f.elements[i].options[j].ival)
					f.elements[i].options[j].selected = true;
			}
		}
		if (ival && (fTyp == "RADIO" || fTyp == "CHECKBOX")) {
			if (f.elements[i].value == ival)
				f.elements[i].checked = true;
		}
	}
	return true;
}

// 배열 요소일 경우 checked 된것이 있는지 확인
function checkChecked(obj) {
	//var fname = obj.form.name;
	//var objnm = obj.name;
	//var oElem = eval(fname+"."+objnm);
	var ret = false;

	if (typeof(obj.length) == "undefined") {
		if (obj.checked) {
			ret = true;
		}
	} else {
		for(var i = 0 ; i < obj.length ; i++) {
			if (obj[i].checked) {
				ret = true;
			}
		}
	}
	return ret;
}


function btnReset_OnClick(obj)
{

	obj.reset();

}


function checkbusino(obj){
	var sum = 0;
	var getlist =new Array(10);
	var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
	//calwin = window.open("","","resize=yes");
	for(var i = 0 ; i < 10 ; i++){
		getlist[i] = vencod.substring(i,i+1);
	// calwin.document.write("getlist["+i+"]="+getlist[i]+"<br>");
	}
	for(var i = 0 ; i < 9 ; i++){
		sum += getlist[i]*chkvalue[i];
	// calwin.document.write("sum +="+"getlist["+i+"]*chkvalue["+i+"]="+getlist[i]+"*"+chkvalue[i]+"="+sum+"<br>");
	}
	sum = sum +parseInt((getlist[8]*5)/10) ;
	// calwin.document.write("sum="+sum+"<br>");
	sidliy = sum%10;
	// calwin.document.write("sidliy="+sidliy+"<br>");
	sidchk = 0;
	if ( sidliy != 0 ) {
		sidchk = 10 - sidliy;
	 } else {
		 sidchk = 0;
	 }// calwin.document.write("sidchk="+sidchk+"<br>");
	// calwin.document.write("getlist[9]="+getlist[9]+"<br>");
	 if ( sidchk != getlist[9] ) {
		 return false;
	}
	return true;
} 
// 주민번호체크
function checkjumin(str){
	if((str.length != 13)){
		if(str.length == 10){
			return true;
		}
		else{
			return false;
		}
	}
	else{
		idtot = 0;
		idadd = "234567892345"
		for(var i = 0 ; i < 12 ; i++){
			idtot = idtot + parseInt(str.substring(i,i+1))*parseInt(idadd.substring(i,i+1));
		}

		idtot = 11-(idtot%11);

		if(parseInt(str.substring(12,13) != idtot)){
			return false;
		}
	}
	return true;
}

//DELETE키만 사용

function delOnly(){
	var keyCodeStr=window.event.keyCode;
	if (keyCodeStr==8)
	{return false;}
	else
	{return true;}
}



// 전화번호체크
function checkPho(str){
	var m_Sp = /[0-9]|[\-]/;
	var m_val = str;
	var strLen = m_val.length;
	var m_char = m_val.charAt((strLen) - 1);
	if(m_char.search(m_Sp) != -1) {
		return true;
	}
	return false;
}

// 특수문자체크
function checkChr(str){
	var m_Sp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|]/;
	var m_val = str;
	var strLen = m_val.length;
	var m_char = m_val.charAt((strLen) - 1);
	if(m_char.search(m_Sp) == -1) {
		return true;
	}
	return false;
}

// 한글체크
function checkChk(str){
	var m_Sp = /[ㄱ-힣]/;
	var m_val = str;
	var strLen = m_val.length;
	var m_char = m_val.charAt((strLen) - 1);
	if(m_char.search(m_Sp) == -1) {
		return true;
	}
	return false;
}

// 영문체크
function checkChe(str){
	var m_Sp = /[a-z]|[A-Z]/;
	var m_val = str;
	var strLen = m_val.length;
	var m_char = m_val.charAt((strLen) - 1);
	if(m_char.search(m_Sp) != -1) {
		return true;
	}
	return false;
}

// 영문체크
function checkChE(str){
	var m_Sp = /[A-Z]/;
	var m_val = str;
	var strLen = m_val.length;
	var m_char = m_val.charAt((strLen) - 1);
	if(m_char.search(m_Sp) == -1) {
		return true;
	}
	return false;
}

// 숫자체크
function checkChn(str){
	if(!isNaN(str)) {
		return false;
	}
	return true;
}

// 이메일 유효성 체크
function checkEmail(str){
	var reg = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	if (str.search(reg) != -1) {
		return true;
	}
	return false;
}
// 문자 길이 반환 (영문 1byte, 한글 2byte 계산)
function getLen(str) {
	var len;
	var temp;

	len = str.length;
	var tot_cnt = 0;

	for(var k = 0 ; k < len ; k++){
		temp = str.charAt(k);
		if(escape(temp).length > 4)
			tot_cnt += 2;
		else
			tot_cnt++;
	}
	return tot_cnt;
}
// 대문자 변환 ex) toUpperCase(문자)
function toUpperCase(str) {
	var ret;
	str != null ? ret = str.toUpperCase() : ret = "";
	return ret;
}


function zeroMake(obj)
{
	if(obj.value==0)
	{
        obj.value="";
	}
   return
}

function emptMake(obj)
{
	if(obj.value=="")
	{
        obj.value=0;
	}
   return
}


function number_comma(num) {
	num = num.replace(/,/g, "")
	var num_str = num.toString()
	var result = ''

	for(var i=0; i<num_str.length; i++) {
	var tmp = num_str.length-(i+1)
	if(i%3==0 && i!=0) result = ',' + result
	result = num_str.charAt(tmp) + result
	}
return result
}


function number_hyphen(obj) {
	var tmp = obj.length
    var strCuCngIdx = document.frm.cuCngIdx.value
	if (strCuCngIdx == 1)
	{   
		$("#cuBusinessNumber").attr('maxlength','12');  
		if (tmp==3){ obj+="-" }	else if (tmp==6){obj+="-"} 
	}
	else
	{    
		$("#cuBusinessNumber").attr('maxlength','14');
		if (tmp==6){ obj+="-" } 
	}
return obj
}

//-------------------------------------------------------------------//
// 날짜 차이 구하기(일)
//-------------------------------------------------------------------//


	function calDateRange(val1, val2)
	    {
		var FORMAT = "-";

		// FORMAT을 포함한 길이 체크
		if (val1.length != 10 || val2.length != 10)
		    return null;

		// FORMAT이 있는지 체크
		if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
		    return null;
		// 년도, 월, 일로 분리
		var start_dt = val1.split(FORMAT);
		var end_dt = val2.split(FORMAT);

		// 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
		// Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
		start_dt[1] = (Number(start_dt[1]) - 1) + "";
		end_dt[1] = (Number(end_dt[1]) - 1) + "";

		var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
		var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

		return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
	    }





//-------------------------------------------------------------------//
// 숫자만
//-------------------------------------------------------------------//

function onlyNumberInput() 
{ 
 var code = window.event.keyCode; 

 if ((code > 34 && code < 41) || (code > 47 && code < 58) || (code > 95 && code < 106) || code == 8 || code == 9 || code == 13 || code == 46) 
 { 
  window.event.returnValue = true; 
  return; 
 } 
 window.event.returnValue = false; 
} 




//-------------------------------------------------------------------//
// 숫자만
//-------------------------------------------------------------------//
	function checkNum(obj){
		if (isNaN(obj.value)){
			alert("숫자만 입력하세요.");
			obj.value = "";
			return
		}
	}

//-------------------------------------------------------------------//
// trim,따옴표제거
//-------------------------------------------------------------------//
	String.prototype.trim = function() {
//		return this.replace(/(^ *)|( *$)|(\')/g, "");
		return this.replace(/(^ *)|( *$)/g, "");
	}

//-------------------------------------------------------------------//
// 문자열길이 구하기
//-------------------------------------------------------------------//
	function get_length(str){
		return(str.length+(escape(str)+"%u").match(/%u/g).length-1);
	}

//-------------------------------------------------------------------//
	//첨부파일 키입력 금지
//-------------------------------------------------------------------//

	function textFileKeydown(seq, e){
		var code = document.all ? event.keyCode : e.which;

		if (code==9){
			if(seq == 0){
				return true;
			}else{
				return true;
			}
		}else{
			return false;
		}
	}


//-------------------------------------------------------------------//
// E-Mail 주소 체크
//-------------------------------------------------------------------//
function emailCheck(xObj){
	obj = xObj
	if (obj.value != "" ) {
		if ( obj.value.indexOf("@") == "-1" || obj.value.indexOf(".") == "-1" || obj.value.length < 9) {
			alert("E-Mail form is not accurate...")
			obj.focus(); return false
		}
	}
}


//-------------------------------------------------------------------//
	//콤보박스 만들기
//------------------------------------------------------------------//

	function showResponse(idname)
	{
		var d = $(idname);
		d.disabled  = false;
	}

	function reportError(request)
	{
		alert('Sorry. There was an error.');
	}	

	function chg_groupcd(){
        groupcd  = document.frm.groupcd
        pattern  = document.frm.pattern
        material = document.frm.material
        
	    if(groupcd.value == ""){
            if(pattern)
            make_combo('rtrim(pattern)','rtrim(pattern) pattern2','','material_master','group by pattern order by pattern','','pattern','---select---')
            if(material)
            make_combo('rtrim(material)','rtrim(material) material2','','material_master','group by material order by material','','material','---select---')
            //setTimeout(function(){make_combo('rtrim(material)','rtrim(material) material2','','material_master','group by material order by material','','material','---select---')}, 100)
        }
        else{
            if(pattern)
            make_combo('rtrim(pattern)','rtrim(pattern) pattern2','','material_master','where groupcd=\''+groupcd.value+'\' group by pattern order by pattern','','pattern','---select---')
            if(material)
            make_combo('rtrim(material)','rtrim(material) material2','','material_master','where groupcd=\''+groupcd.value+'\' group by material order by material','','material','---select---')
            //setTimeout(function(){make_combo('rtrim(material)','rtrim(material) material2','','material_master','where groupcd=\''+groupcd+'\' group by material order by material','','material','---select---')}, 100)
        }
	}

	function chg_pattern(){
        groupcd  = document.frm.groupcd
        pattern  = document.frm.pattern
        material = document.frm.material
        
	    if(pattern.value == ""){
            if(groupcd.value == ""){
                if(material)
                make_combo('rtrim(material)','rtrim(material) material2','','material_master','group by material order by material','','material','---select---')
            }
            else{
                if(material)
                make_combo('rtrim(material)','rtrim(material) material2','','material_master','where groupcd=\''+groupcd.value+'\' group by material order by material','','material','---select---')
            }
        }
        else{
            if(material)
            make_combo('rtrim(material)','rtrim(material) material2','','material_master','where pattern=\''+pattern.value+'\' group by material order by material','','material','---select---')
        }
	}

	function make_combo(field1,field2,opt,table,refstr,sovalue,tagname,dfidx){
		refstr = escape(refstr);
		field1 = escape(field1);
		field2 = escape(field2);
		dfidx = escape(dfidx);
//ajax
//			var d = $(tagname);
//			d.options.clear;
//			d.disabled  = true;
//		
//			var url  = "http://165.141.100.108/epic_inc/make_combo.asp";
//			var pars = "field1="+field1+"&field2="+field2+"&opt="+opt+"&table="+table+"&refstr="+refstr+"&sovalue="+sovalue+"&tagname="+tagname+"&dfidx="+dfidx;
//			var myAjax = new Ajax.Updater(
//				{success: tagname}, 
//				url, 
//				{
//					method: 'post', 
//					asynchronous:true,parameters: pars,onComplete:showResponse(tagname)
//				});
//	    return	

		if(document.frames["exec_"+tagname]){
		document.frames["exec_"+tagname].location = "/epic_inc/make_combo.asp?field1="+field1+"&field2="+field2+"&opt="+opt+"&table="+table+"&refstr="+refstr+"&sovalue="+sovalue+"&tagname="+tagname+"&dfidx="+dfidx;
		}
		else{
		document.frames["execFrame"].location = "/epic_inc/make_combo.asp?field1="+field1+"&field2="+field2+"&opt="+opt+"&table="+table+"&refstr="+refstr+"&sovalue="+sovalue+"&tagname="+tagname+"&dfidx="+dfidx;
		}
	}
	function customer_combo(field1,field2,opt,table,refstr,sovalue,tagname,dfidx){
		refstr = escape(refstr);
		field1 = escape(field1);
		field2 = escape(field2);
		dfidx = escape(dfidx);
		document.frames["execFrame"].location = "/epic_inc/customer_combo.asp?field1="+field1+"&field2="+field2+"&opt="+opt+"&table="+table+"&refstr="+refstr+"&sovalue="+sovalue+"&tagname="+tagname+"&dfidx="+dfidx;
	}
	function schedule_combo(field1,field2,opt,table,refstr,sovalue,tagname,dfidx){
		refstr = escape(refstr);
		field1 = escape(field1);
		field2 = escape(field2);
		dfidx = escape(dfidx);
		document.frames["execFrame"].location = "/epic_inc/schedule_combo.asp?field1="+field1+"&field2="+field2+"&opt="+opt+"&table="+table+"&refstr="+refstr+"&sovalue="+sovalue+"&tagname="+tagname+"&dfidx="+dfidx;
	}


	var body;var tbody;var all;
	function input_soldto(obj){
		var word = obj.value
		if(window.event.keyCode == 40){
			if(frm.soldto_name_combo){
				frm.soldto_name_combo.focus();
				frm.soldto_name_combo.options[0].selected = true;
			}
		}
		else if(word.length >= 3){
			customer_combo("rtrim(custID)","rtrim(cust_name)","","customer_master","where cust_name like '"+word+"%' and soldto = custID order by cust_name","","soldto","---select---");
		}
	}
	function input_shipto(obj){
		var word = obj.value
		if(window.event.keyCode == 40){
			if(frm.shipto_name_combo){
				frm.shipto_name_combo.focus();
				frm.shipto_name_combo.options[0].selected = true;
			}
		}
		else if(word.length >= 3){
			if(document.frm.soldto_name.value == ""){
				customer_combo("rtrim(custID)","rtrim(cust_name)","","customer_master","where cust_name like '"+word+"%' and soldto != custID order by cust_name","","shipto","---select---");
			}
			if(document.frm.soldto_name.value != ""){
				customer_combo("rtrim(custID)","rtrim(cust_name)","","customer_master","where cust_name like '"+word+"%' and soldto in (select soldto from customer_master where soldto = custID and cust_name like '"+document.frm.soldto_name.value+"%') order by cust_name","","shipto","---select---");
			}
		}
	}
	function input_size(obj){
		var word = obj.value
		if(window.event.keyCode == 40){
			if(frm.size_name_combo){
				frm.size_name_combo.focus();
				frm.size_name_combo.options[0].selected = true;
			}
		}
		else if(word.length >= 4){
			if(document.frm.material){
			    if(document.frm.material.value == ""){
				    customer_combo("rtrim(size)","rtrim(size) size2","","material_master","where size like '%"+word+"%' order by size","","size","---select---");
			    }
			    if(document.frm.material.value != ""){
				    customer_combo("rtrim(size)","rtrim(size) size2","","material_master","where size like '%"+word+"%' and material = '"+document.frm.material.value+"') order by size","","size","---select---");
			    }
			}
			else{
			    customer_combo("rtrim(size)","rtrim(size) size2","","material_master","where size like '%"+word+"%' order by size","","size","---select---");
    		}
		}
	}

	function valchange(tag,wordvalue,wordname){
		obj      = eval("document.frm."+tag)
		obj_name = eval("document.frm."+tag+"_name")
		div = document.all(tag+"_name_div")

		if(obj) obj.value = wordvalue;
		if(obj_name) obj_name.value    = wordname;

		if (window.event.keyCode == 13){
			div.style.visibility = 'hidden'; 
		}
		else{
		}
	}

//-------------------------------------------------------------------//
	//리스트 상세정보
//------------------------------------------------------------------//
	function syncHeight(el){
		if(!el)
			return;
		el = typeof el == 'string' ? document.getElementById(el) : el;
		if(!el)
			return;

		el.setExpression('height','contentWindow.document.body.scrollHeight');
	}


//-------------------------------------------------------------------//
	//하위콤보 만들기
//------------------------------------------------------------------//
	function changeCombo(tagObj, tagValue, sqlName, parName1, parValue1, parName2, parValue2, parName3, parValue3) {
		var xmlDom = new ActiveXObject("Microsoft.XMLDOM");
		xmlDom.async = false;
		var url = "/include/combo_xml.asp?sqlName="+sqlName+"&parName1="+parName1+"&parValue1="+parValue1+"&parName2="+parName2+"&parValue2="+parValue2+"&parName3="+parName3+"&parValue3="+parValue3;
		xmlDom.load(url);

		tree = xmlDom.getElementsByTagName("sltContent") //선택된 컨텐츠 노드

		MaxOptCnt = tree.length; //등록할 수있는 컨텐츠의 최대수량 변경
//alert(MaxOptCnt);
		for(i = 1 ; i < MaxOptCnt ; i++) {
			sValue = tree.item(i).selectSingleNode("@sValue").value;
			sName  = tree.item(i).selectSingleNode("@sName").value;

			//alert(sValue + ' / ' + sName);

			tagObj.length = i + 1;
			tagObj.options[i].value = sValue;
			tagObj.options[i].text  = sName;
			if(tagValue==sValue) {
				tagObj.selectedIndex = i
		}
		}
	}

function dispCal(cID){
	document.write ('<OBJECT classid="clsid:140B5386-059C-11D3-8998-002074156B00"    codebase="/lib/CalCtrl.cab#version=1,0,0,3" id=' + cID + ' style="border:1px solid #FFFFFF;height:20px;width:15px;" align=absmiddle></OBJECT>');
}

//ajax 사용시
function getDispCal(cID){
	return '<OBJECT classid="clsid:140B5386-059C-11D3-8998-002074156B00"    codebase="/lib/CalCtrl.cab#version=1,0,0,3" id=' + cID + ' style="border:1px solid #FFFFFF;height:20px;width:15px;" align=absmiddle></OBJECT>';
}

function initCal(obj1){
	obj1.value = "";
}

function initCal1(obj1){
	obj1.value = "";
}

function initCal(obj1, obj2){
	obj1.value = "";
	obj2.value = "";
}

function downCal() {
	document.write ('<object classid="clsid:140B5386-059C-11D3-8998-002074156B00"    codebase="/lib/CalCtrl.cab#version=1,0,0,3" height=0 id=CTa1 style="LEFT: 0px; TOP: 0px" width=0 VIEWASTEXT align=top></object>');	
} 	

function printMade() {
	document.write('<object id="Printmade" codebase="http://www.counselingsystem.or.kr/lib/Printmade.cab#version=1,0,0,0" classid="clsid:53EED863-B547-40F8-B24A-2D6DE807CFE8" width=0 height=0>');
}


function checkValue(theObj, expr, min, max, reg){
	//값 입력 확인 입력된 값이 아무것도 없을 경우에 객체.value값이 ""인지 확인
	//1. 최소 최대값이 정의되지 않은 경우는 문자입력여부만 확인
	if ((min == "") && (max == "")){
		if (theObj.value.replace(/ /g, '') == ""){
			alert(expr);
			theObj.focus();
			return true;
		}
	}else if ((min != "") && (max == "")){
	//최소값만 정의된 경우는 최소값 확인
		if (theObj.value.length < min){
			alert(expr);
			theObj.focus();
			return true;
		}
	}else if ((min != "") && (max != "")){
	//범위값 확인
		if ((theObj.value.length < min) || (theObj.value.length > max)){
			alert(expr);
			theObj.focus();
			return true;
		}
	}
	//패턴 처리
	if (reg != ""){
		if (theObj.value.search(reg) == -1){
			alert(expr);
			theObj.focus();
			return true;
		}
	}
}

function OpenWin(URL){		
	var win = launchCenter(URL, 'HelpWindow', 400, 300, 'scrollbars=yes, toolbar=no');
	win.focus();		
}

function launchCenter(url, name, width, height, att) {
	var str = "height=" + height + ",innerHeight=" + height;
	str += ",width=" + width + ",innerWidth=" + width;
	if (window.screen) {
		var ah = screen.availHeight - 30;
		var aw = screen.availWidth - 10;
	
		var xc = (aw - width) / 2;
		var yc = (ah - height) / 2;
		
		str += ",left=" + xc + ",screenX=" + xc;
		str += ",top=" + yc + ",screenY=" + yc;
		str += "," + att
	}
	return window.open(url, name, str);
}

function openPrint(URL){		
	var win = launchCenter(URL, 'PrintWindow', 700, 600, 'scrollbars=yes, toolbar=no');
	win.focus();		
}

function alertMsg(msg, obj) {
	alert(msg);
	obj.focus();
	return;	
}

//입력 테스트 길이 확인 후 제한된 입력문자 길이로 잘라서 리턴(오버된 경우)
function cal_pre(length, Obj){
	var vLength = parseInt(length);
	
	if(getLength(Obj.value) > vLength){
		alert("텍스트 입력은 "+length+" Byte로 제한되어 있습니다.");

		if(length > 1000)
			length = length - 20;
		Obj.value = input_cut_text(Obj, length);
	}
}

function getMidText(startNo, endNo, obj) {
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msgstr = new String(obj.value);
	var msglen = msgstr.length;
	
	for(i=startNo; i<endNo; i++){
		var ch = msgstr.charAt(i);
		msg += ch;
	}
	
	return msg;
}

//문자열을 바이트 단위로 계산하여 제한된 바이트로 잘라서 리턴
function input_cut_text(message, maximum){
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msgstr = new String(message.value);
	var msglen = msgstr.length;

	for(i=0; i<msglen; i++){
		var ch = msgstr.charAt(i);

		if(escape(ch).length > 4){
			inc = 2;
		}else if(ch == '\n'){
			if(msgstr.charAt(i-1) != '\r'){
				inc = 1;
			}
		}else{
			inc = 1;
		}
		if((nbytes + inc) > maximum){
			break;
		}
		nbytes += inc;
		msg += ch;
	}

	return msg;
}

//입력 문자의 바이트 계산 함수
function getLength(str){
	return(str.length+(escape(str)+"%u").match(/%u/g).length-1);
}

//문자 치환
function replace(str,s,d){
	var i=0;
	
	while(i > -1){
		i = str.indexOf(s);
		str = str.substr(0,i) + d + str.substr(i+1,str.length);
	}
	return str;
}

//Selectbox 에서 하위코드가 있을 경우 상위 코드 선택을 막음.
function chkCode(obj, len) {
	var i = obj.selectedIndex;
	
	if (obj.selectedIndex < len-1) {
		if (obj[i].value.split('_')[1] == '00' && obj[i].value.split('_')[0] == obj[i+1].value.split('_')[0]) {
			alert('하위코드를 선택해 주세요');
			obj[0].selected = true;
			return;
		}
	}
}

//Selectbox 에서 하위코드가 있을 경우 상위 코드 선택을 막음.
function chkCode2(obj, len) {
	var i = obj.selectedIndex;
	
	if (obj.selectedIndex < len-1) {
		if (obj[i].value.length < 4 && obj[i].value == obj[i+1].value.substring(0, 2)) {
			alert('하위코드를 선택해 주세요');
			obj[0].selected = true;
			return;
		}
	}
}



function validFillNum(frmNM, objStr, objNum, altMsg){
	var objValue = "";
	var retBool = false;
	var Msg = "";
	var focusStr = "";
	
	for(var i = 1; i <= parseInt(objNum); i++){
		objValue = eval("document." + frmNM + "." + objStr + i.toString() + ".value");

		if(objValue.replace(/ /g, "") != "" && !isNaN(objValue)){
			retBool = true;
		}
		
		if(isNaN(objValue)){
			Msg = "숫자만 입력이 가능합니다. 입력값을 확인해 주십시오.";
			retBool = false;
			focusStr = "document." + frmNM + "." + objStr + i.toString() + ".focus();";
			break;
		}
	}
	
	if(focusStr == "")
		focusStr = "document." + frmNM + "." + objStr +"1.focus();";
	
	if(!retBool && Msg == "")
		Msg = altMsg;
	
	if(Msg != ""){
		alert(Msg);
		eval(focusStr);
	}
	return retBool;
}

//입력 필드의 값이 채워져 있는지 확인한다.
//동일한 패텅의 obj명일 경우 loop돌면서 확인한다.
//frmNM:form이름,objStr:동일한 패턴의 obj명 앞부분,objNum:동일 패턴의 obj수
function chkFillVal(frmNM, objStr, objNum){
	var objValue = "";
	var retBool = false;
	
	for(var i = 1; i <= parseInt(objNum); i++){
		objValue = eval("document." + frmNM + "." + objStr + i.toString() + ".value");
		objValue = objValue.replace(/0/g, "");
		if(objValue.replace(/ /g, "") != "" && !isNaN(objValue)){
			retBool = true;
		}
	}

	return retBool;
}

//입력 필드의 값이 숫자인지 확인한다.
//동일한 패턴의 obj명일 경우 loop돌면서 확인한다.
//frmNM:form이름,objStr:동일한 패턴의 obj명 앞부분,objNum:동일 패턴의 obj수
function chkNaN(frmNM, objStr, objNum){
	var objValue = "";
	var retBool = true;
	var Msg = "";
	var focusStr = "";

	for(var i = 1; i <= parseInt(objNum); i++){
		objValue = eval("document." + frmNM + "." + objStr + i.toString() + ".value");
		if(isNaN(objValue)){
			Msg = "숫자만 입력이 가능합니다. 입력값을 확인해 주십시오.";
			focusStr = "document." + frmNM + "." + objStr + i.toString() + ".focus();";
			retBool = false;
			break;
		}
	}

	if(Msg != ""){
		alert(Msg);
		eval(focusStr);
	}
	return retBool;
}


//지원사업 상세정보 팝업
function goDetail() {
	
	var v_biznm, v_areaid, v_sid, v_bizseq, is2009;
	
	var args = goDetail.arguments;
	
	if (args.length > 0) v_biznm	= args[0];
	if (args.length > 1) v_areaid	= args[1];
	if (args.length > 2) v_sid		= args[2];
	if (args.length > 3) v_bizseq	= args[3];
	if (args.length > 4) is2009		= args[4];
	
	
	//alert('checkValue.ja : is2009_value : ' + is2009);
	
		
	if (v_sid != '0') {
		
		var winurl = '';
		
		if(is2009 == 'NEW') {								// 2010년 부터의 자료라면
			is2009 = '/include/sur_view.asp?biznm=';			
		} else {											// 2010년 01월 01일 이전자료이면(2009년 12월 31일 까지의 자료이면)
			is2009 = '/include/sur_view_2009.asp?biznm=';
		}		
		winurl = is2009 + v_biznm + '&areaid=' + v_areaid + '&sid=' + v_sid + '&bizseq=' + v_bizseq;					
		window.open (winurl, 'detail', 'width=745, height=500, top=10, left=10, scrollbars=yes, scrolling=auto');	
		
	} else {
		alert('등록된 상세정보가 없습니다');
	}
}	

function goDisabled() {
	var obj = goDisabled.arguments;
	
	for (var i=0; i<obj.length; i++) {
		obj[i].disabled = true;
	}
}

function goSearchForm(){
	document.location.href="/manage/search/search.asp";
}


/////////////////////////////////////////////////////////////////////////////////////	
// 입력 체크
// 사용방법 : isBlank(폼 요소);
function isBlank(obj) {
	if (obj.value.replace(/ /g, '') == '') 
		return true;
	else 
		return false;
}
/////////////////////////////////////////////////////////////////////////////////////


// 숫자만 입력 가능하도록
// 사용방법 : onlyNum();
// 사용 예 : <input type="text" name="txt_number" onKeyPress="onlyNum();">

function onlyNum() {	
	if(event.keyCode<26||event.keyCode<45||event.keyCode>57) event.returnValue=false;
}



//엔터키로 이동
function handleEnter (field, event) {
                var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
                if (keyCode == 13) {
                        var i;
                        for (i = 0; i < field.form.elements.length; i++)
                                if (field == field.form.elements[i])
                                        break;
                        i = (i + 1) % field.form.elements.length;
                        field.form.elements[i].focus();
                        return false;
                } 
                else
                return true;
      }      


//엔터키로 submit
function moveEnter (obj, event) {
                var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
                if (keyCode == 13) {
                   obj.submit();
                } 
                else
                return true;
      }  
	  
function formCheck(var1, var2, formobj){
       try {
		// 폼에서 채워야할 필수항목의 name 을 입력하세요
        var fieldRequired = var1;
        // 필수항목의 이름을 입력 하세요 (예, Name 필드의 항목명은 '이름', Address 필드의 항목명은 '주소')
        var fieldDescription = var2;
        // 경고 메세지
        var alertMsg = "다음 항목을 채워주세요 :\n\n";
        flag=false;
        var l_Msg = alertMsg.length;
        for (var i = 0; i < fieldRequired.length; i++){
                var obj = formobj.elements[fieldRequired[i]];
                if (obj){       
					switch(obj.type){
				  
						case "select-one":
								if (obj.selectedIndex == -1 || obj.options[obj.selectedIndex].value == ""){
										alertMsg += " ▒ " + fieldDescription[i] + "\n";
								flag=true;
								}
							   break;
						case "select-multiple":
								if (obj.selectedIndex == -1){
										alertMsg += " ▒ " + fieldDescription[i] + "\n";
									flag=true;
								}
								break;
						case "text":
						case "textarea":
								if (obj.value == "" || obj.value == null){
										alertMsg += " ▒ " + fieldDescription[i] + "\n";
															   flag=true;
								}
								break;
						default:
						}
						if (obj.type == undefined){
								var blnchecked = false;
								for (var j = 0; j < obj.length; j++){
										if (obj[j].checked){
												blnchecked = true;
										}
					   }
						if (!blnchecked){
								alertMsg += " ▒ " + fieldDescription[i] + "\n";
													   flag=true;
						}
					}
			   if(flag) break;
		        }
	   }


        if (alertMsg.length == l_Msg){
                return true;
        }else{
                alert(alertMsg);
                if(obj.type != undefined) obj.focus();
				flag = false;
				return false;
		}       
	}catch(e){ 
     alert(e);
	 return false;
	}
}

function checkBoxValidate(cb) {
	for (j = 0; j < 2; j++) {
		if (eval("document.frmFind.idtype[" + j + "].checked") == true) {
			document.frmFind.idtype[j].checked = false;
			if (j == cb) {
				document.frmFind.idtype[j].checked = true;
		 	}
	  	}
	}
}

function getRadioValue(o) {
	var len = o.length;
	
	if (len == undefined) {
		if (o.checked) return o.value;
		else return '';
	} else {
		for (var oi = 0; oi < len ; oi++) {
			if (o[oi].checked) return o[oi].value;
		}
		return '';
	}
}

/////////////////////////////////////////////////////////////////////////////////////
//주민번호체크폼 시작
function check_ResidentNO(jumin1, jumin2){
if (jumin1.length != 6){
return false;   
}
else if (jumin2.length != 7){
return false;   
}
else {
var str_serial1 = jumin1;
var str_serial2 = jumin2;
var digit=0
for (var i=0;i<str_serial1.length;i++){
var str_dig=str_serial1.substring(i,i+1);
if (str_dig<'0' || str_dig>'9'){ 
digit=digit+1 
}
}
if ((str_serial1 == '') || ( digit != 0 )){
return false;   
}
var digit1=0
for (var i=0;i<str_serial2.length;i++){
var str_dig1=str_serial2.substring(i,i+1);
if (str_dig1<'0' || str_dig1>'9'){ 
digit1=digit1+1 
}
}
if ((str_serial2 == '') || ( digit1 != 0 )){
return false;   
}
if (str_serial1.substring(2,3) > 1){
return false;   
}
if (str_serial1.substring(4,5) > 3){
return false;   
} 
if (str_serial2.substring(0,1) > 4 || str_serial2.substring(0,1) == 0){
return false;   
}
var a1=str_serial1.substring(0,1)
var a2=str_serial1.substring(1,2)
var a3=str_serial1.substring(2,3)
var a4=str_serial1.substring(3,4)
var a5=str_serial1.substring(4,5)
var a6=str_serial1.substring(5,6)
var check_digit=a1*2+a2*3+a3*4+a4*5+a5*6+a6*7
var b1=str_serial2.substring(0,1)
var b2=str_serial2.substring(1,2)
var b3=str_serial2.substring(2,3)
var b4=str_serial2.substring(3,4)
var b5=str_serial2.substring(4,5)
var b6=str_serial2.substring(5,6)
var b7=str_serial2.substring(6,7)
var check_digit=check_digit+b1*8+b2*9+b3*2+b4*3+b5*4+b6*5 
check_digit = check_digit%11
check_digit = 11 - check_digit
check_digit = check_digit%10
if (check_digit != b7){
return false;   
}
else{
return true; 
}
}
}
///주민번호  체크폼 끝


/*****************************************************************************
 * 주민번호 자포커스 이동				                                     *
 *****************************************************************************/

function juminFocus(ResidentNumberOne,theForm){

	if (ResidentNumberOne.length == 6){
		theForm.focus();
	}

}



/*****************************************************************************
 * iframe 높이 자동 조정                                     *
 *****************************************************************************/
	function syncHeight(el){
		el = typeof el == 'string' ? document.getElementById(el) : el;
		el.setExpression('height','contentWindow.document.body.scrollHeight+5','JavaScript');
	}
	function resizeFrame(iframeObj){
		var innerBody   = iframeObj.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + 5;
		iframeObj.style.height = innerHeight;
	}


/*****************************************************************************
 * 우편번호 찾기                                    *
 *****************************************************************************/
	function btnAddr_OnClick(obj1,obj2){
	 var win=window.open("/accounting/STANDARD/ZipCodeSearch.asp?zip_form="+obj1+"&addre_form="+obj2,"showreceipt","width=630,height=630, resizable=no");
	     if(win.focus)
			win.focus();
	}

/*****************************************************************************
 * 통장 조회                                     *
 *****************************************************************************/

	function btnOpen_bank_OnClick(obj1,obj2){
		var win_form = window.open("/accounting/STANDARD/Bankbook_Open.asp?obj1="+obj1+"&obj2="+obj2,"bank_open","width=480,height=500, scrollbars=no,resizable=no");
		win_form.focus();
	}
/*****************************************************************************
 * 카드 조회                                     *
 *****************************************************************************/

	function btnOpen_card_OnClick(obj1,obj2){
		var win_form = window.open("/accounting/STANDARD/Card_Open.asp?obj1="+obj1+"&obj2="+obj2,"card_open","width=480,height=500, scrollbars=no,resizable=no");
		win_form.focus();
	}

/*****************************************************************************
 * 거래처 조회                                     *
 *****************************************************************************/

	function btnOpen_customer_OnClick(obj1,obj2){
		var win_form = window.open("/accounting/STANDARD/Customer_Open.asp?obj1="+obj1+"&obj2="+obj2,"bank_open","width=480,height=550, scrollbars=no,resizable=no");
		win_form.focus();
	}

/*****************************************************************************
 * 계정과목 조회                                     *
 *****************************************************************************/

	function btnOpen_Subject_OnClick(obj1,obj2,obj3,hidjoGubun){
		var win_form = window.open("/accounting/STATEMENT/L_Statement_Subject_Open.asp?obj1="+obj1+"&obj2="+obj2+"&obj3="+obj3+"&hidjoGubun="+hidjoGubun,"subject_open","width=580,height=700, scrollbars=no,resizable=no");
		win_form.focus();
	}


/*****************************************************************************
 * 예산과목 조회                                     *
 *****************************************************************************/

	function btnOpen_Budget_OnClick(obj1,obj2,obj3,ResolutionGubun,obj4,obj5){
		var win_form = window.open("/accounting/STATEMENT/L_Statement_Expense_Open.asp?obj1="+obj1+"&obj2="+obj2+"&obj3="+obj3+"&ResolutionGubun="+ResolutionGubun+"&obj4="+obj4+"&obj5="+obj5,"budget_open","width=860,height=670, scrollbars=no,resizable=no");
		win_form.focus();
	}

/*****************************************************************************
 * 결재할자 조회                                     *
 *****************************************************************************/

	function btnOpen_Approval_Memper_OnClick(obj1,obj2,obj3,obj4){
		var win_form = window.open("/groupWareApproval/approvalLine/approvalLineMember.asp?obj1="+obj1+"&obj2="+obj2+"&obj3="+obj3+"&obj4="+obj4,"approval_open","width=480,height=540, scrollbars=no,resizable=no");
		win_form.focus();
	}

/*****************************************************************************
 * 결재선 조회                                     *
 *****************************************************************************/

	function btnOpen_Approval_Line_OnClick(){
		var win_form = window.open("/groupWareApproval/approvalLine/approvalLineOpen.asp","approval_line_open","width=700,height=800, scrollbars=yes,resizable=no");
		win_form.focus();
	}

/*****************************************************************************
 * 결재문서 미리보기                                     *
 *****************************************************************************/

	function btnOpen_Approval_Preview_OnClick(adIdx){
		var win_form = window.open("/groupWareApproval/print/print_set.asp?adIdx="+adIdx,"approval_preview_open","width=760,height=900, scrollbars=no,resizable=no");
		win_form.focus();
	}


/*****************************************************************************
 * 자산코드 조회                                     *
 *****************************************************************************/

	function btnOpen_Asset_Code_OnClick(obj1,obj2){
		var win_form = window.open("/asset/Asset_Code_Open.asp?obj1="+obj1+"&obj2="+obj2,"asset_code_open","width=560,height=700, scrollbars=no,resizable=no");
		win_form.focus();
	}



/***********************
* 체크 확인 (비활성)
************************/
function cReadOnly(frm1, frm2) {
	frm2.value = "";
	if(frm1.checked == true) {
		readOnlyFalse(frm2);
	}
	else {
		readOnlyTrue(frm2);
	}
}
function cReadOnly2(frm1, frm2, frm3) {
	frm2.value = "";
	frm3.value = "";
	if(frm1.checked == true) {
		readOnlyFalse(frm2);
		readOnlyFalse(frm3);
	}
	else {
		readOnlyTrue(frm2);
		readOnlyTrue(frm3);
	}
}

function threeReadOnly(frm, frm1, frm2, frm3) {
	cReadOnly(frm, frm1);
	cReadOnly(frm, frm2);
	cReadOnly(frm, frm3);
}


/**************************
* 활성/비활성 
***************************/
function readOnlyTrue(frm) {
	frm.style.backgroundColor = "#FFFFFF";
	frm.readOnly = false;
}

function readOnlyFalse(frm) {
	frm.style.backgroundColor = "#e9e9e9";
	frm.readOnly = true;
}


/*

*/
function toNumber(value) {
	return parseInt(value);
}

/*

*/
function fShowMessage(msg, type) {

	if(type == "COnFIRM")
		return confirm(msg);
	else 
		alert(msg);
}

function substr(value, index, length ) {
	return value.substr(index,length);
}

function btnList_OnClick() {
	location.href = 'CSC010N.asp?menu_num=1';
}

function inputNo2(frm, frm1,frm2) {
	if(frm.checked == true) {
		readOnlyFalse(frm1);
		readOnlyFalse(frm2);
	}
	else {
		readOnlyTrue(frm1);
		readOnlyTrue(frm2);
	}
}

function inputNo1(frm, frm1) {
	if(frm.checked == true) {
		readOnlyFalse(frm1);
	}
	else {
		readOnlyTrue(frm1);
	}
}




/**************************
* 숫자만 입력받는다. 특수문자('-','.',...)도 허용한다.
***************************/
function onlyNumber1() {
	if((event.keyCode > 31) && (event.keyCode < 45) || (event.keyCode > 57)) {
	event.returnValue = false;
	}
}

/**************************
* 숫자만 입력받는다. "-"도 받지않는다.
***************************/
function onlyNumber2(loc) {
	if(/[^0123456789]/g.test(loc.value)) {
//		alert("숫자가 아닙니다.\n\n0-9의 정수만 허용합니다.");
		loc.value = loc.value.substring(0, loc.value.length-1);
		loc.focus();
	}
}

/**************************
* 몇달더하기
***************************/
function AddMonth(idate, mth) {
	idate = idate.replace("-", "").replace("-", "");
	var sYear = idate.substring(0, 4);
	var sMonth = idate.substring(4, 6);
	var sDay = idate.substring(6, 8);
	var iYear = parseInt(sYear);
	var iMonth = parseInt(sMonth);
	
	if(mth < 1) {
		for(i=0;i>mth;i--) {
			iMonth = iMonth - 1;
			if (iMonth==0)
			{
				iMonth=12;
				iYear = iYear-1;
			}
		}
	} 
	else {
		iMonth = iMonth + parseInt(mth);
		iYear = iYear + parseInt(iMonth/12);
		iMonth = iMonth%12;
	}

	sYear = '' + iYear;
	if(iMonth <10) sMonth = '' + '0' + iMonth;
	else sMonth = '' + iMonth;
	var rtnValue = sYear +''+ sMonth +'' + sDay;
	return rtnValue;
}

/**************************
* 앞에 0 붙혀서 두자리수 만들기
***************************/
function addZero(n) {
  return n < 10 ? "0" + n : n;
}

/**************************
* 만나이 개월수 구해서 배열로 가져오기
***************************/
function HowOldAreYou(idate) {
	//태어난날
	idate = idate.replace("-", "").replace("-", "");
	var iYear = idate.substring(0, 4);
	var iMonth = idate.substring(4, 6);
	var iDay = idate.substring(6, 8);
	//오늘날짜
	var now = new Date()
	var sYear = now.getFullYear();
	var sMonth = now.getMonth()+1;
	var sDay =  now.getDate();
	//나이차이
	gYear = sYear - iYear;
	gMonth = sMonth - iMonth;
	if(gMonth<0) {
		gYear = gYear - 1;
		gMonth = 12 + gMonth;
	}
	if(gYear<0) {
		gYear = 0;
		gMonth = 0;
	}
	return gYear +'-'+ gMonth;
}

/**************************
* 만나이 개월수 구해서 배열로 가져오기
***************************/
function inputOkCheckNo(obj1, obj2) {
//	readOnlyTrue(obj1);
//	obj2.checked = false;
}


/**************************
//option값으로 index 알아오는 함수
***************************/
function getSelectIndex(target, keyValue) { 
	for(var i=0; i<target.length; i++) { 
		if(target.options[i].value==keyValue) 
		return i; 
	} 
} 

/**************************
//SelectBox Text 값 알아내기
***************************/
function getSelectText(target) { 
	target.options[target.selectedIndex].text
}
/**************************
//SelectBox Option 값 알아내기
***************************/
function getSelectValue(target) { 
	target.options[target.selectedIndex].value
} 


/**************************
//RadioButton 값 알아내기
***************************/
function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

/**************************
//RadioButton 값 설정하기
//setCheckedValue(radioObj, '') => 이렇게 값을 해제시켜준다
***************************/
function setCheckedValue(radioObj, newValue) {
	if(!radioObj)
		return;
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
		if(radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}

/**************************
//Trim() : 독립적으로 사용
***************************/
function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
function ltrim(stringToTrim) {
	return stringToTrim.replace(/^\s+/,"");
}
function rtrim(stringToTrim) {
	return stringToTrim.replace(/\s+$/,"");
}

/**************************
//라디오버튼에 따른 텍스트박스 활성화
***************************/
function radiobt_YN_OnClick(radioObj, textObj) {
	if (radioObj[0].checked)
	{
		readOnlyTrue(textObj);
	}
	else {
		readOnlyFalse(textObj);
	}
}

//////////////////////////////////////////////////////////
//스크립트 추가 : 추가자 : 미래정보소프트 :: 김영찬
//////////////////////////////////////////////////////////

//한국식 날짜표기로 해주기
//받는값 : d - 데이타형, t - String
function MUTgetTimeStamp(d, t) {
	var s;
	switch(t)	
	{
		case "d":
			s = MUTleadingZeros(d.getFullYear(), 4) + '-' + MUTleadingZeros(d.getMonth() + 1, 2) + '-' + MUTleadingZeros(d.getDate(), 2);
			break;
		case "t":
			s = MUTleadingZeros(d.getHours(), 2) + ':' + MUTleadingZeros(d.getMinutes(), 2) + ':' + MUTleadingZeros(d.getSeconds(), 2);
			break;
		default:
			s = MUTleadingZeros(d.getFullYear(), 4) + '-' + MUTleadingZeros(d.getMonth() + 1, 2) + '-' + MUTleadingZeros(d.getDate(), 2) + ' ' + 
				MUTleadingZeros(d.getHours(), 2) + ':' + MUTleadingZeros(d.getMinutes(), 2) + ':' + MUTleadingZeros(d.getSeconds(), 2);
	}
	return s;
}

//////////////////////////////////////
//한국식 날짜표기로 해주기
//받는값 : d - 데이타형, t - String
function MUTleadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

//////////////////////////////////////
//숫자를 받아서 3글자로 변경
function MUTnumber3Digit(a) {
	var i = a.value.replace(/,/gi, '');
	if(/[^0123456789]/g.test(i)) {
		a.value = a.value.substring(0, a.value.length-1);
	} else {
		a.value = Number(i).toLocaleString().split('.')[0];
	}
	a.focus();
}

//////////////////////////////////////
//정해진 기간을 초이스하기
//받는값 : dayChoice - 선택된값, frmSdate - 시작날짜, frmEdate - 끝날짜
function MUTdayChoice(dayChoice, frmSdate, frmEdate) {
	var today = new Date();
	var dateS = new Date();
	var dateE = new Date();
	var todayS = MUTgetTimeStamp(today, 'd');
	var yy = todayS.substring(0,4);
	var mm = todayS.substring(5,7);
	var dd = todayS.substring(8,10);

	switch(dayChoice)
	{
	case "TD":
		frmSdate.value = MUTgetTimeStamp(today, 'd');
		frmEdate.value = MUTgetTimeStamp(today, 'd');
		break;
	case "YD":
		today.setDate(today.getDate() - 1);
		frmSdate.value = MUTgetTimeStamp(today, 'd');
		frmEdate.value = MUTgetTimeStamp(today, 'd');
		break;
	case "TW":
		dateS.setDate(dateS.getDate()+1-dateE.getDay());
		dateE.setDate(dateE.getDate()+7-dateE.getDay());
		frmSdate.value = MUTgetTimeStamp(dateS, 'd');
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	case "LW":
		dateS.setDate(dateS.getDate()-6-dateE.getDay());
		dateE.setDate(dateE.getDate()+0-dateE.getDay());
		frmSdate.value = MUTgetTimeStamp(dateS, 'd');
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	case "TM":
		dateB  = new Date(yy,mm-1+0,1);
		dateE  = new Date(yy,mm-1+1,0);
		frmSdate.value = MUTgetTimeStamp(dateB, 'd');
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	case "LM":
		dateB  = new Date(yy,mm-1-1,1);
		dateE  = new Date(yy,mm-1+0,0);
		frmSdate.value = MUTgetTimeStamp(dateB, 'd');
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	case "A":
		dateB  = new Date(yy,mm-1-1,1);
		dateE  = new Date(yy,mm-1+1,0);
		frmSdate.value = '2000-01-01';
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	default:
		selvalue = Number(dayChoice);
		dateB  = new Date(yy,mm-1- selvalue,	1);
		dateE  = new Date(yy,mm-1- selvalue +1,	0);
		frmSdate.value = MUTgetTimeStamp(dateB, 'd');
		frmEdate.value = MUTgetTimeStamp(dateE, 'd');
		break;
	}
}

/*
* 숫자금액을 한글로
*/


function chang_money(num){
/*
* 숫자2한글 스크립트
*/
        var i, j=0, k=0;
        var han1 = new Array("","일","이","삼","사","오","육","칠","팔","구");
        var han2 = new Array("","만","억","조","경","해","시","양","구","간");
        var han3 = new Array("","십","백","천");
        var result="", hangul = num + "", pm = "";
        var str = new Array(), str2="";
        var strTmp = new Array();

        if(parseInt(num)==0) return "영"; //입력된 숫자가 0일 경우 처리
        if(hangul.substring(0,1) == "-"){ //음수 처리
                pm = "마이너스 ";
                hangul = hangul.substring(1, hangul.length);
        }
        if(hangul.length > han2.length*4) return "too much number"; //범위를 넘는 숫자 처리 자리수 배열 han2에 자리수 단위만 추가하면 범위가 늘어남.

        for(i=hangul.length; i > 0; i=i-4){
                str[j] = hangul.substring(i-4,i); //4자리씩 끊는다.
                for(k=str[j].length;k>0;k--){
                        strTmp[k] = (str[j].substring(k-1,k))?str[j].substring(k-1,k):"";
                        strTmp[k] = han1[parseInt(strTmp[k])];
                        if(strTmp[k]) strTmp[k] += han3[str[j].length-k];
                        str2 = strTmp[k] + str2;
                }
                str[j] = str2;
                if(str[j]) result = str[j]+han2[j]+result;
                //4자리마다 한칸씩 띄워서 보여주는 부분. 우선은 주석처리
                //result = (str[j])? " "+str[j]+han2[j]+result : " " + result;

                j++; str2 = "";
        }

        return pm + result; //부호 + 숫자값
}


/**
*	공통코드 가져오기
*	사용하는것만 들고온다 codeUseYn=Y
*	getCmmnCd.select(상위코드, 붙일곳(selectId), selected데이터)
*	getCmmnCd.checkBox(상위코드, 붙일곳(checkBox parentId), 체크박스네임, 데이터(','로 스플릿), 한줄에 몃개나 나오게 할건지(br태그 추가), disable코드(D))
*
*	getCmmnCd.subSelect(상위코드, 붙일곳(selectId), 코드그룹값, selected데이터)
*
*	<select name="victimArea" id="victimArea" title="거주지" onchange="getCmmnCd.subSelect('HM47', 'victimAreaSub', this.value,'')">
		<script>
			getCmmnCd.select('HM46', 'victimArea');
		</script> 
        <option value="" selected="">선택</option>
    </select>
	<select name="victimAreaSub" id="victimAreaSub" title="거주지 서브">
        <option value="" selected="">선택</option>
    </select>
*	
*/
var getCmmnCd = { 
	select : function(upperCode, elementId, selectedData, emptyYn){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			//엘리먼트 초기화
			$("#"+elementId).empty();
			/*$("#"+elementId).append("<c:set value=''>")*/

			if(emptyYn == 'N' || emptyYn == 'n'){
				$("#"+elementId).append("<option value=''>선택</option>");
			}

			
			for (var i = 0; i < resdata.length; i++) {
				if(selectedData == resdata[i].codeCode){
					$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' selected='selected'>" +resdata[i].codeName+ "</option>");
				}else{
					$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "'>" +resdata[i].codeName+ "</option>");
				}
			}
		});
	}

	,
	checkBox : function(upperCode, elementId, checkboxName ,selectedData, brCount, disableCd){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			//엘리먼트 초기화
			$("#"+elementId).empty();
			var data = selectedData.split(', ');
			
			var disable = "";
			if(disableCd == 'D' || disableCd == 'd'){
				disable = "disabled";
			}
			
			for (var i = 0; i < resdata.length; i++) {
				var checkHave = data.indexOf(resdata[i].codeCode);
				
				if(checkHave >= 0 ){
					$("#"+elementId).append("<input type='checkbox'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "' checked='checked'><label style='padding-right: 20px'>" +resdata[i].codeName+ "</label></input>")
				}else{
					$("#"+elementId).append("<input type='checkbox'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "'><label style='padding-right: 20px'>" +resdata[i].codeName+ "</label></input>")
				}
				
				if((i+1)%brCount == 0){
					$("#"+elementId).append("<br/>");
				}
			}
			
		});
	},
	subSelect : function(upperCode, elementId, codeGroup, selectedData, emptyYn){
			$.ajax({ url : "/bos/cmmnCd/cmmnCdDetail/listJson.json?codeUseYn=Y&codeGroup="+codeGroup+"&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(
					function (resdata) {
						//엘리먼트 초기화
						$("#"+elementId).empty();

						
						if(emptyYn == 'N' || emptyYn == 'n'){
							$("#"+elementId).append("<option value=''>선택</option>");
						}

						
						for (var i = 0; i < resdata.length; i++) {
							if(selectedData == resdata[i].codeCode){
								$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' selected='selected'>" +resdata[i].codeName+ "</option>");
							}else{
								$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "'>" +resdata[i].codeName+ "</option>");
							}
						}
				});
		},
	radio : function(upperCode, elementId, checkboxName ,selectedData, brCount, disableCd){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			//엘리먼트 초기화
			$("#"+elementId).empty();
			var data = selectedData.split(', ');
			var disable = "";
			if(disableCd == 'D' || disableCd == 'd'){
				disable = "disabled";
			}
			
			for (var i = 0; i < resdata.length; i++) {
				var checkHave = data.indexOf(resdata[i].codeCode);
				
				if(checkHave >= 0 ){
					$("#"+elementId).append("<input type='radio'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "' checked='checked'>" +resdata[i].codeName+ "</input>")
				}else{
					$("#"+elementId).append("<input type='radio'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "'>" +resdata[i].codeName+ "</input>")
				}
				
				if((i+1)%brCount == 0){
					$("#"+elementId).append("<br/>");
				}
			}
			
		});
	},
	radioUser : function(upperCode, elementId, checkboxName ,selectedData, brCount, disableCd){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			//엘리먼트 초기화
			$("#"+elementId).empty();
			var data = selectedData.split(', ');
			var disable = "";
			if(disableCd == 'D' || disableCd == 'd'){
				disable = "disabled";
			}
			
			for (var i = 0; i < resdata.length; i++) {
				var checkHave = data.indexOf(resdata[i].codeCode);
				
				if(checkHave >= 0 ){
					$("#"+elementId).append("<span style='display:inline-block; width:200px;'><input type='radio'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "' checked='checked'>" +resdata[i].codeName+ "</input></span>")
				}else{
					$("#"+elementId).append("<span style='display:inline-block; width:200px;'><input type='radio'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "'>" +resdata[i].codeName+ "</input></span>")
				}
				
				if((i+1)%brCount == 0){
					$("#"+elementId).append("<br/>");
				}
			}
			
		});
	},
	selectStats : function(upperCode, elementId, selectedData, emptyYn, defaultData, subCodeNullChk){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode + "&subCodeNullChk=" + subCodeNullChk, dataType : "json", async: false, cache:false }).done(function (resdata) {
			//엘리먼트 초기화
			$("#"+elementId).empty();
			/*$("#"+elementId).append("<c:set value=''>")*/

			if(emptyYn == 'N' || emptyYn == 'n'){
				if(defaultData == '' || defaultData == null){
					defaultData = '선택';
				}
				$("#"+elementId).append("<option value=''>"+defaultData+"</option>");
			}

			for (var i = 0; i < resdata.length; i++) {
				var disabled = "";
				if(resdata[i].codeName3 == "disabled"){
					disabled = " disabled";
				}
				
				if(selectedData == resdata[i].codeCode){
					$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' selected='selected' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' "+ disabled + ">" +resdata[i].codeName+ "</option>");
				}else{
					$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' "+ disabled + ">" +resdata[i].codeName+ "</option>");
				}
			}
		});
	},
	subSelectStats : function(upperCode, elementId, codeGroup, selectedData, emptyYn){
		
		$.ajax({ url : "/bos/cmmnCd/cmmnCdDetail/listJson.json?codeUseYn=Y&codeGroup="+codeGroup+"&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(
				function (resdata) {
					//엘리먼트 초기화
					$("#"+elementId).empty();
					
					if(emptyYn == 'N' || emptyYn == 'n'){
						$("#"+elementId).append("<option value=''>선택</option>");
					}
					
					for (var i = 0; i < resdata.length; i++) {
						var disabled = "";
						if(resdata[i].codeName3 == "disabled"){
							disabled = " disabled";
						}
						
						if(selectedData == resdata[i].codeCode){
							$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' selected='selected' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' "+ disabled + ">" +resdata[i].codeName+ "</option>");
						}else{
							$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' data-grpcode='" + resdata[i].codeGroup + "' data-subcode='" + resdata[i].codeSubcode + "' "+ disabled + ">" +resdata[i].codeName+ "</option>");
						}
					}
			});
	},
	checkBoxStats : function(upperCode, elementId, checkboxName ,selectedData, brCount, disableCd){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			var data = selectedData.split(', ');
			
			var disable = "";
			if(disableCd == 'D' || disableCd == 'd'){
				disable = "disabled";
			}
			
			for (var i = 0; i < resdata.length; i++) {
				var checkHave = data.indexOf(resdata[i].codeCode);
				
				if(checkHave >= 0 ){
					$("#"+elementId).append("<input type='checkbox'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "' checked='checked'><label style='padding-right: 20px'>" +resdata[i].codeName+ "</label></input>")
				}else{
					$("#"+elementId).append("<input type='checkbox'"+ disable +" name='"+checkboxName+"' value='" +resdata[i].codeCode+ "'><label style='padding-right: 20px'>" +resdata[i].codeName+ "</label></input>")
				}
				
				if((i+1)%brCount == 0){
					$("#"+elementId).append("<br/>");
				}
			}
			
		});
	},
	checkBoxPrint : function(upperCode, elementId, checkboxName ,selectedData, brCount, disableCd){
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false, cache:false }).done(function (resdata) {
			var data = selectedData.split(', ');
			
			var disable = "";
			if(disableCd == 'D' || disableCd == 'd'){
				disable = "disabled";
			}
			
			for (var i = 0; i < resdata.length; i++) {
				var checkHave = data.indexOf(resdata[i].codeCode);
				
				if(checkHave == 0 ){
					$("#"+elementId).append("<span>" +resdata[i].codeName+ "</span>")
				}
				else if(checkHave > 0 ){
					$("#"+elementId).append("<span>, " +resdata[i].codeName+ "</span>")
				}else{
				}
			}
			
		});
	}
}