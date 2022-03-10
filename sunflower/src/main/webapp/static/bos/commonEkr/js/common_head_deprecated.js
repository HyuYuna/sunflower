


/*
GetNowDate()							: 현재 일자를 가져온다.
GetNowTime()							: 현재 시간을 가져온다.
GetNowDateTime()						: 현재 일시를 가져온다.
AddFrontZero(inValue, digits)			: 입력값 앞에 '0'을 붙여서 입력받는 자리수의 문자열을 반환한다.

RegularDateFormat(checkValue)			: 날짜형식체크 2012-01-01
RegularTimeFormat(checkValue)			: 시간형식체크 13:21
RegularEmailFormat(checkValue)			: 이메일형식체크 abc@naver.com
RegularCurrencyFormat(n)				: 입력한 자료를 한글로 바꾸어줌

commonGetLastDayOfMonth(year, month)	: 지정한 달의 마지막날을 구해온다
DisplayFormatDate(dateStr, dateSep)		: 날짜 형식으로 변경하기

isDefined(str)							: undefined , null, 빈값 체크

// ajax 를 이용한 파일 업로드
function ajaxFileUploadAction(casnum, subFolderName)
*/
var ROOTDIRECTORY = "";
var cFileViewPath = "https://www.on-wnc.kr/file_uploaded";

function AlertGo(msg, gourl) {
	alert(msg);
	if(gourl.length>5) {
		location.href = gourl;
	}
}
function AlertReplace(msg, gourl) {
	alert(msg);
	if(gourl.length>5) {
		location.replace(gourl);
	}
}
function ConfirmGo(msg, gourl1, gourl2) {
	if ( confirm( msg ) ) {
		if(gourl1.length>5) {
		  location.href= gourl1;
		}
	}
	else {
		if(gourl2.length>5) {
		  location.href= gourl2;
		}
	}
}

function GetNowDate() {
 var dateTime = new Date();
 var result =
  AddFrontZero(dateTime.getFullYear(), 4) + '-' +
  AddFrontZero(dateTime.getMonth() + 1, 2) + '-' +
  AddFrontZero(dateTime.getDate(), 2) ;
 return result;
}

function GetNowTime() {
  var dateTime = new Date();
  var result =
    AddFrontZero(dateTime.getHours(), 2) + ':' +
    AddFrontZero(dateTime.getMinutes(), 2) ;
  return result;
}

function GetNowDateTime() {
  var dateTime = new Date();
  var result =
    AddFrontZero(dateTime.getFullYear(), 4) + '-' +
    AddFrontZero(dateTime.getMonth() + 1, 2) + '-' +
    AddFrontZero(dateTime.getDate(), 2) + ' ' +
    AddFrontZero(dateTime.getHours(), 2) + ':' +
    AddFrontZero(dateTime.getMinutes(), 2) + ':' +
    AddFrontZero(dateTime.getSeconds(), 2);
  return result;
}

function AddFrontZero(inValue, digits) {
  var result = '';
  inValue = inValue.toString();
  if (inValue.length < digits) {
   for (i = 0; i < digits - inValue.length; i++)
      result += '0';
    }
    result += inValue
  return result;
}

function RegularDateFormat(checkValue) {
  var regExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
  var result = true;

  if(!regExp.test(checkValue)) {
    //alert("날짜는 2013-02-15 형식으로 입력해야 합니다.\r\n[ 1900-01-01부터 2099-12-31까지 입력 가능 ]");
    result = false;
  } else {
    var ary = regExp.exec(checkValue);

    if(ary != null && ary.length == 4) {
      var yyyy = ary[1];
      var mm = ary[2];
      var dd = ary[3];
        
      if(parseInt(dd, 10) > commonGetLastDayOfMonth(yyyy, parseInt(mm, 10))) {
        result = false;
      }
      
    } else {
      result = false;		
    }		
  }
  
  return result;
}

function RegularTimeFormat(checkValue) {
  var regExp = /^(20|21|22|23|[0-1]?\d):[0-5]?\d$/;
  if(!regExp.test(checkValue)) {
    return false;
  } else {
    return true;
  }
}

function RegularDateTimeFormat(checkValue) {
  var regExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (20|21|22|23|[0-1]?\d):[0-5]?\d$/;
  if(!regExp.test(checkValue)) {
    //alert("날짜는 2013-02-15 형식으로 입력해야 합니다.\r\n[ 1900-01-01부터 2099-12-31까지 입력 가능 ]");
    return false;
  } else {
    return true;
  }
}

function RegularEmailFormat(checkValue) {
  var regExp = /^[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*@[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*$/;
  if(!regExp.test(checkValue)) {
    return false;
  } else {
    return true;
  }
}

function RegularCurrencyFormat(n) {
	n = n.replace(/,/gi,""); 
	var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	n += '';                          // 숫자를 문자열로 변환

	while (reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2');
	}
	return n;
}

function commonGetLastDayOfMonth(year, month)
{
	if(month > 12) {
		return -1;
	}
	var MonthTable = new Array(-1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
		MonthTable[2] = 29;
	else
		MonthTable[2] = 28;

	return MonthTable[month];
}

function DisplayFormatDate(dateStr, dateSep) {
	var yy, mm, dd, yymmdd; 
	yy = dateStr.substr(0,4);
	mm = dateStr.substr(4,2);
	dd = dateStr.substr(6,2);

    yymmdd = yy+ dateSep +mm+ dateSep +dd; 

	return yymmdd;
}


//--------------------------------------
$( ".pure-button" ).click(function( event ) {
	event.preventDefault();
});

	
function btnZipSearchAction() {
	if ($("#zipSearchPart3").val().length>1) {
		$.getJSON(ROOTDIRECTORY + "/common2/get_zipcode3dong.asp", { dongSido: $("#zipSearchPart1").val(), dongType: $("#zipSearchPart2").val(), dongName: $("#zipSearchPart3").val(), "nocache": new Date().getTime()}, function(data1) {
			$("#zipSearchPart4").empty().append("<option>주소를 선택해주세요</option>");
			$.each(data1, function(index, entry) {
				var zipArray = entry["ADDR"].split(' ');
				$("#zipSearchPart4").append("<option value='"+ entry["ZIP_NO"] +"' title='"+ entry["ADDR"] +"' ref='"+ zipArray[1] +"'>["+ entry["ZIP_NO"] +'] '+ entry["ADDR"] +"</option>");
				
			});
		});
		$('#divZipSearchPart4').show();
	} else {
		alert("검색어를 2글자 이상 넣어주세요");
		return false;
	}
}

$("#zipSearchPart4").on("change", function() {
	$("#ZIP_NUM").val($("#zipSearchPart4 > option:selected").val());
	$("#ADDR1").val($("#zipSearchPart4 > option:selected").attr("title"));
	
	$('#divZipSearchPart4').hide();
	//$('#area_dtl_cod').html($("#zipSearchPart4 > option:selected").attr("ref")).attr("selected", "selected");	
	//fnSelectChangeSelectTEXT('area_dtl_cod', 'HM47', 'TXT1', $("#area_cod").val(), $("#zipSearchPart4 > option:selected").attr("ref"));
});

// 이메일선택자
$("#ekrCommonEmailSelect").change(function() {
  var thisInputEmailSel   = $("#ekrCommonEmailSelect option:selected").val();
  var thisInputEmail      = $(".commonEmailInputBox").val();
  var thisInputEmailLen   = thisInputEmail.length;
  var thisInputEmailFlag  = thisInputEmail.indexOf("@");
  var thisInputEmail1     = thisInputEmail
  if( thisInputEmail.indexOf("@")>0 ) {
	thisInputEmail1     = thisInputEmail.substring(0, thisInputEmailFlag);
  }
  var thisInputEmailFull  = thisInputEmail1 + thisInputEmailSel;
  
  if( thisInputEmailSel.length>0 ) {
	$('.commonEmailInputBox').val( thisInputEmailFull );
  } else {
	$('.commonEmailInputBox').val( thisInputEmail1 + '@' );
  }
});

// 학교선택에 따른 학년선택값 변경
  function ekrScoolYearCheckByType() {
    var commonScoolYearVal = $("#commonScoolYearAction option:selected").val();
    var commonScoolTypeVal = $("#commonScoolTypeAction option:selected").val();
    var commonScoolYearHtml= "";
    if ( isDefined(commonScoolTypeVal)) {
      if ( ekrSame(commonScoolTypeVal, "1") ) {
      commonScoolYearHtml = "<option value=''>학년선택</option><option value='1'>1학년</option><option value='2'>2학년</option><option value='3'>3학년</option><option value='4'>4학년</option><option value='5'>5학년</option><option value='6'>6학년</option>";
      } else if (ekrSame(commonScoolTypeVal, "2") || ekrSame(commonScoolTypeVal, "3")) {
      commonScoolYearHtml = "<option value=''>학년선택</option><option value='1'>1학년</option><option value='2'>2학년</option><option value='3'>3학년</option>";
      } else {
      commonScoolYearHtml = "";
      }
    } else {
      commonScoolYearHtml = "<option value=''>학교는??</option>";
    }
    $("#commonScoolYearAction").html(commonScoolYearHtml);
    $("#commonScoolYearAction").val(commonScoolYearVal);
  }

//ajax 를 이용한 파일 업로드 : 일반
  function ajaxFileUploadAction(subFolderName, BDD_SEQ, SUB_CODE ) {

    //starting setting some animation when the ajax starts and completes
    $("#fileUploading")
    .ajaxStart(function(){
      $(this).show();
    })
    .ajaxComplete(function(){
      $(this).hide();	  
		$('.divUploadZone').hide();
		alert('자료를 성공적으로 업로드했습니다..');
      ajaxFileUploadSuccessAction();
    });

    $.ajaxFileUpload
    (
      {
        url:ROOTDIRECTORY+'/common2/file/file_upload.asp?BDD_SEQ='+ BDD_SEQ +'&SUB_CODE='+ SUB_CODE +'&fileUpLoadFolder='+ subFolderName, 
        secureuri:false,
        fileElementId:'fileToUpload',
        dataType: 'json',
        success: function (data, status)
        {

		  /* Type I */
          var showFileName =	"<div class='divUploadedFileName' alt='"+ data.savedseq +"'>첨부된 파일 : "+ 
                    data.filename +" ("+ data.filesize +"byte)" +
                    " <img class='imgUploadedFileDelete' "+
			        " alt='"+ data.savedseq +"' "+
			        " ref='"+ data.filesize +"' "+
                    " src='"+ ROOTDIRECTORY +"/common2/icon/Delete-icon1.png' style='padding-left:10px;'></div>";
          $('#divUploadedFilenames').append(showFileName);
		  
          
		  //var inputFileSeq = $('#uploadedFiles').val();
          //inputFileSeq = inputFileSeq + data.savedseq +",";
          //$('#uploadedFiles').val(inputFileSeq);

		  /* Type II
		  $('#centerFileUploadList tbody tr').remove();
		  $('#centerFileUploadList tbody').append("<tr>"+
			  "<td>"+ data.filecenter +"</td>"+
			  "<td>"+ data.filedate +"</td>"+
			  "<td>"+ data.filewriter +"</td>"+
			  "<td><img class='imgUploadedFileDownload' src='/common2/image/btn_download.png' style='cursor:pointer' alt='"+ data.savedseq +"' ref='"+ data.filesize +"' /></td>"+ 
              "<td>-</td>"+
			  "<td><img class='imgUploadedFileDelete' src='/common2/image/btn_delete.gif' style='cursor:pointer' alt='"+ data.savedseq +"' ref='"+ data.filesize +"' /></td></tr>");
		  $('.divUploadZone').hide();
		  */

        },
        error: function (data, status, e)
        {
			ajaxFileUploadFailAction(e);
        },
        complete: function()
        {
			ajaxFileUploadSuccessAction();
        }
      }
    );
    
    return false;

  } 

//ajax 를 이용한 파일 업로드 : 센터에서 자료 업로드
  function ajaxFileUploadActionInCenter(subFolderName, BDD_SEQ, SUB_CODE, BDS_SEQ ) {

    //starting setting some animation when the ajax starts and completes
    $("#fileUploadingCenter")
    .ajaxStart(function(){
      $(this).show();
    })
    .ajaxComplete(function(){
      $(this).hide();	  
		$('.divUploadZone').hide();
		alert('자료를 성공적으로 업로드했습니다..');
      ajaxFileUploadSuccessAction();
    });

    $.ajaxFileUpload
    (
      {
        url:ROOTDIRECTORY+'/common2/file/file_uploadInCenter.asp?BDD_SEQ='+ BDD_SEQ +'&SUB_CODE='+ SUB_CODE +'&fileUpLoadFolder='+ subFolderName, 
        secureuri:false,
        fileElementId:'fileToUploadInCenter',
        dataType: 'json',
        success: function (data, status)
        {

		  /* Type I
          var showFileName =	"<div class='divUploadedFileName' alt='"+ data.savedseq +"'>첨부된 파일 : "+ 
                    data.filename +" ("+ data.filesize +"byte)" +
                    " <img class='imgUploadedFileDelete' alt='"+ data.savedseq +"' "+
                    " src='"+ ROOTDIRECTORY +"/common2/icon/Delete-icon1.png' style='padding-left:10px;'></div>";
          $('#divUploadedFilenames').append(showFileName);
		  */
          
		  //var inputFileSeq = $('#uploadedFiles').val();
          //inputFileSeq = inputFileSeq + data.savedseq +",";
          //$('#uploadedFiles').val(inputFileSeq);

		  /* Type II
		  $('#centerFileUploadList tbody tr').remove();
		  $('#centerFileUploadList tbody').append("<tr>"+
			  "<td>"+ data.filecenter +"</td>"+
			  "<td>"+ data.filedate +"</td>"+
			  "<td>"+ data.filewriter +"</td>"+
			  "<td><img class='imgUploadedFileDownload' src='/common2/image/btn_download.png' style='cursor:pointer' alt='"+ data.savedseq +"' ref='"+ data.filesize +"' /></td>"+ 
              "<td>-</td>"+
			  "<td><img class='imgUploadedFileDelete' src='/common2/image/btn_delete.gif' style='cursor:pointer' alt='"+ data.savedseq +"' ref='"+ data.filesize +"' /></td></tr>");
		  $('.divUploadZone').hide();
		  */

		  location.href = "/board/board_view.asp?BDS_SEQ="+ BDS_SEQ +"&BDD_SEQ="+ BDD_SEQ;

        },
        error: function (data, status, e)
        {
			ajaxFileUploadFailAction(e);
        },
        complete: function()
        {
			//ajaxFileUploadSuccessAction();
        }
      }
    );
    
    return false;

  } 

  function ajaxFileUploadNumberAction(BDD_SEQ, SUB_CODE, seq, act) {
    $.ajax({
      type: "GET",
      url:ROOTDIRECTORY+'/common2/file/file_dbsave.asp?act='+ act +'&BDD_SEQ='+ BDD_SEQ +'&SUB_CODE='+ SUB_CODE +'&seqnum='+ seq
    });
  }

  function actionUploadFileListDelete(BDD_SEQ, SUB_CODE, seq){
    
    if (BDD_SEQ!='') {
      ajaxFileUploadNumberAction(BDD_SEQ, SUB_CODE, seq, 'D');
    } else {
      //hidden값에서 항목 삭제
      var inputFileSeq = $('#uploadedFiles').val();
      inputFileSeq = inputFileSeq.replace(seq+",", "");
      $('#uploadedFiles').val(inputFileSeq);
    }
      
    //속한 이미지 삭제
    $('.divUploadedFileName[alt='+seq+']').hide();
  }

  function actionUploadFileListDeleteWithFile(seq, BDD_SEQ){
	
	$.ajax({
	  type:"get",
	  url:"board_reply_run.asp?act=AD&ATC_SEQ="+ seq +"&BDD_SEQ="+ BDD_SEQ,
	  success:function(entry){
		//hidden값에서 항목 삭제
		var inputFileSeq = $('#uploadedFiles').val();
		inputFileSeq = inputFileSeq.replace(seq+",", "");
		$('#uploadedFiles').val(inputFileSeq);
		
		//속한 이미지 삭제
		$('.divUploadedFileName[alt='+seq+']').hide();

	  }, error: function(xhr,status,error){
		alert('데이터를 처리하지 못했습니다.\n이유 : '+ error);
	  }
	});
  }


function actionUploadFileListInsertCenterJaryo(seqnum, chknum, BDS_SEQ, BDD_SEQ){	
	var codnum = "boardDemand";
	location.href = "/common2/file/download.asp?UFL_SEQ="+ seqnum +"&URL_FILE="+ chknum +"&UFL_REL_CODE="+ codnum +"&BDS_SEQ="+ BDS_SEQ +"&BDD_SEQ="+ BDD_SEQ;
}

function actionUploadFileListDeleteCenterJaryo(seqnum, chknum, BDS_SEQ, BDD_SEQ){
	
	if (seqnum!='' && chknum!='') {
		$("#fileUploading").hide();
		$.ajax({
		  url:ROOTDIRECTORY+'/board/board_run.asp?act=fileDelete&seqnum='+ seqnum +'&chknum='+ chknum,
		  type: "GET",
		  dataType: "json" ,
			success:function(entry){
				alert(entry.resultMessage);
				if( entry.resultCode=="true" ) {					
					//2016.04.19 김영찬 수정
					//location.href='board_view.asp?BDS_SEQ='+ BDS_SEQ +'&BDD_SEQ='+ BDD_SEQ;
					$('#formPage').attr('action', 'board_view.asp');
					$('#formPage').submit();
				}
			}, 
			error: function(xhr,status,error){
				alert('데이터를 삭제하지 못했습니다.\n이유 : '+ error);
			},
			complete: function()
			{
			  $("#fileUploading").hide();
			}	  
		});
	}
}


  function ekrSame(val1, val2) {
    var rval = false;
    if ( isDefined(val1) && isDefined(val2) ) {
      sval1 = String(val1);
      sval2 = String(val2);

      if (sval1==sval2){
        rval = true;
      }
    }

    return rval;
  }

  //undefined , null, 빈값 체크
  function isDefined(str)
  {
      var isResult = false;
      str_temp = str + "";
      str_temp = str_temp.replace(" ", "");
      if(str_temp != "undefined" && str_temp != "" && str_temp != "null")
      {
          isResult = true;
      }
       
      return isResult;
  }

  function setNull2Blank(str)
  {
    var sResult = "";
    if ( isDefined(str) )
    {
      sResult = str;
    }
    return sResult;
  }

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
    //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
    var CSV = '';    
    //Set Report title in first row or line
    
    CSV += ReportTitle + '\r\n\n';

    //This condition will generate the Label/Header
    if (ShowLabel) {
        var row = "";
        
        //This loop will extract the label from 1st index of on array
        for (var index in arrData[0]) {
            
            //Now convert each value to string and comma-seprated
            row += index + ',';
        }

        row = row.slice(0, -1);
        
        //append Label row with line break
        CSV += row + '\r\n';
    }
    
    //1st loop is to extract each row
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        
        //2nd loop will extract each column and convert it in string comma-seprated
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }

        row.slice(0, row.length - 1);
        
        //add a line break after each row
        CSV += row + '\r\n';
    }

    if (CSV == '') {        
        alert("Invalid data");
        return;
    }   
    
    //Generate a file name
    var fileName = "MyReport_";
    //this will remove the blank-spaces from the title and replace it with an underscore
    fileName += ReportTitle.replace(/ /g,"_");   
    
    //Initialize file format you want csv or xls
    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
    
    // Now the little tricky part.
    // you can use either>> window.open(uri);
    // but this will not work in some browsers
    // or you will not get the correct file extension    
    
    //this trick will generate a temp <a /> tag
    var link = document.createElement("a");    
    link.href = uri;
    
    //set the visibility hidden so it will not effect on your web-layout
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    
    //this part will append the anchor tag and remove it after automatic click
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}


function validationCheckPassword( pw, lsoo, jsoo ) {
  return validationCheckPassword2( pw, pw, lsoo, jsoo );
}


function validationCheckPassword2( pw, pw2, lsoo, jsoo ) {
  //var pw = $("#PASSWORD").val();
  var num = pw.search(/[0-9]/g);
  var eng = pw.search(/[a-z]/ig);	//영어 대소문자 구분없이
  var enl = pw.search(/[a-z]/g);	//영어 소문자
  var enu = pw.search(/[A-Z]/g);	//영어 대문자
  //var spe = pw.search(/[`~!@@#$%^&*+|\\\'\";:\/?]/gi);  
  var spe = pw.search(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi);
  var spa = checkSpace(pw);

  var numCount = 1;
  var engCount = 1;
  var enlCount = 1;
  var enuCount = 1;
  var speCount = 1;

  if (num<0) { numCount = 0 }
  if (eng<0) { engCount = 0 }
  if (enl<0) { enlCount = 0 }
  if (enu<0) { enuCount = 0 }
  if (spe<0) { speCount = 0 }

  if (pw != pw2) {
	  alert("입력된 비밀번호가 서로 다릅니다. 확인해주세요.");
	  return false;
  }

  //if (pw.length < lsoo || pw.length > 20) {
  if (pw.length < lsoo) {
	  alert("비밀번호는 "+ lsoo +"자리 이상으로 입력해주세요.");
	  return false;
  }
  if ((numCount + enlCount + enuCount + speCount) < jsoo) {
	  alert("비밀번호는 영대문자, 영소문자, 숫자 및 특수문자를 최소 "+ jsoo +"가지 이상 조합해주세요.");
	  return false;
  }
  /*
  if (num < 0 || eng < 0 || spe < 0) {
	  alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
	  return false;
  }
  */
  if (spa) {
	  alert("비밀번호는 공백없이 입력해주세요.");
	  return false;
  }
  return true;
}

function validationCheckLength( pw, lsoo, llength, blank, jname ) {
  if (pw.length < lsoo) {
	  alert( jname+ "는(은) "+ lsoo +"자리 이상으로 입력해주세요.");
	  return false;
  }
  if (pw.length > llength) {
	  alert( jname+ "는(은) "+ lsoo +"자리 이내로 입력해주세요.");
	  return false;
  }
  if ( blank=='N' && checkSpace(pw)) {
	  alert( jname+ "는(은) 공백없이 입력해주세요.");
	  return false;
  }
  return true;
}

//공백 체크
function checkSpace(str) {
  if (str.search(/\s/) != -1) {
	return true;
  } else {
	return false;
  }
}

// @화면 출력 - 오픈창
function thisPagePrint(printUrl, titleCode){								
  var url=printUrl;
  var arg="?title_code="+ titleCode;
  var winRequestInputPrint=window.open(url+arg,"setRequestInputPrint","width=820,height=500,left=500,top=30, resizable=no, scrollbars=yes");
  if(winRequestInputPrint.focus) {
	winRequestInputPrint.focus();
  }
}

// @화면 출력 - 오픈창 : 공통
function thisPagePrintBasic(){
  var url="/ver2014/common2/print/print_basic.asp";
  var winRequestInputPrint=window.open(url,"setRequestInputPrint","width=820,height=500,left=500,top=30, resizable=no, scrollbars=yes");
  if(winRequestInputPrint.focus) {
	winRequestInputPrint.focus();
  }
}

// 페이지 이동
function GOTO_PAGE(actValue, goValue) {    
	$('#formPage input[name=act]').val( actValue );
	$('#formPage').attr('action', goValue);
	$('#formPage').submit();
}

// 페이지 AJAX 처리
function ekrAjaxPostData( valFormName, valPostUrl, valAct, valNextUrl, valType) {
	$('#'+ valFormName +' input[name=act]').val( valAct );
	$.ajax({
		type: "post", dataType: 'json', cache: false,
		url: valPostUrl,
		data: $('#'+ valFormName).serialize(),
		success:function(data){          
		  $.each(data, function(index, entry) {
			SearchFormRunAjax(valNextUrl, valType);
		  });
		},        
		error: function (xhr, ajaxOptions, thrownError) {
		  alert(thrownError);
		}
	});
}

//****************************
// 파일단위 환산
//
function fileSizeConvert(fileSize){

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