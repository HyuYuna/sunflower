var ekrJs = {
    
    isMsie : function(){
        var agent = navigator.userAgent.toLowerCase();

        if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
            return true;
        }
        else {
            return false;
        }
    }
}

//****************************
// 파일단위 환산
//
function ekrFileSizeConvert(fileSize){

	var fsc = ekrRound((fileSize / 1024),2);	
	var txtFileSizeConvert="";
	
	if(fsc >= 1024){
		txtFileSizeConvert =" "+ ekrRound((fsc/1024),2)+"MB";
	}else{
		if(fsc == 0){
			fsc = 0.5;
		}
		txtFileSizeConvert = " "+ fsc+"KB";
	}	
	return txtFileSizeConvert;
} 

function ekrRound(num,ja){
	ja = Math.pow(10,ja);
	return Math.ceil(num*ja)/ja;
}


//*----------------------------------------------------------------*/
// 체크박스 전체 선택 : jQuery ~1.8
//*----------------------------------------------------------------*/
function setCheckBoxAllSelect(thisVal, thisAll) {
	if ($(thisVal).attr("checked") == "checked") {
		 $(thisVal).attr("checked", true);
		 $("input[name="+ thisAll +"]").attr("checked", true);
	}
	else {
		 $(thisVal).attr("checked", false);
		 $("input[name="+ thisAll +"]").attr("checked", false);
	}
}

function setCheckBoxAllLease(theVal) {
	// 세부를 별도로 선택하면 전체 체크가 풀림
	$("#"+ theVal ).attr("checked", false);
}
//*----------------------------------------------------------------*/

//*----------------------------------------------------------------*/
// 체크박스 전체 선택 : jQuery 1.9 ~
//*----------------------------------------------------------------*/
function setCheckBoxAllSelect9(thisVal, thisAll) {
	if ($(thisVal).is(":checked")) {
		 $(thisVal).prop("checked", true);
		 $("input[name="+ thisAll +"]").prop("checked", true);
	}
	else {
		 $(thisVal).prop("checked", false);
		 $("input[name="+ thisAll +"]").prop("checked", false);
	}
}

function setCheckBoxAllSelectByClass9(thisVal, thisAll, thisClass) {
	if ($(thisVal).is(":checked")) {
		 $(thisVal).prop("checked", true);
		 $("#"+ thisClass +" input[name="+ thisAll +"]").prop("checked", true);
	}
	else {
		 $(thisVal).prop("checked", false);
		 $("#"+ thisClass +" input[name="+ thisAll +"]").prop("checked", false);
	}
}

function setCheckBoxAllLease9(theVal) {
	// 세부를 별도로 선택하면 전체 체크가 풀림
	$("#"+ theVal ).prop("checked", false);
}
//*----------------------------------------------------------------*/