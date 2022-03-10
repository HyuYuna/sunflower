/**
 * textarea 글자 제한
 * ekrContentsMaxLen( this.value, limit )
 $(document).bind('keyup', function(event){if(document.getElementById('USP200_CONTENT').value.length>0)alert('안녕!');});
 */
function ekrContentsMaxLen(obj, maxlen) { 
	var st_len = 0;	// byte를 체크하기 위한 변수 
	var objlen = 0; // 글자수 자르기 위한 변수 세팅
	
	for(var i=0;i<obj.length;i++) {
		var es_len = escape(obj.charAt(i));
		//alert(es_len);
		if ( es_len.length == 1 ) {					// 영문/숫자/기호
			st_len ++;
		} else if ( es_len.indexOf("%u") != -1 ) {	// 한글
			st_len += 2;
		} else if ( es_len.indexOf("%20") != -1 ) {	// 공백
			st_len += 1;
		} else if ( es_len.indexOf("%0A") != -1 ) {	// Enter
			st_len += 2;
		}
		objlen++;
		
		if(st_len > maxlen) {
			alert("최대 한글" + (maxlen/2) + "자, 영문" + maxlen + "자 이내까지 입력 가능합니다.");
			$('#USP200_CONTENT').val($('#USP200_CONTENT').val().substring(0, (objlen-(st_len-maxlen))));
			st_len = maxlen;
			i = maxlen;
		} 
	}
	
	if ( $('#USP200_CONTENT').val() == null || $('#USP200_CONTENT').val() == '' ) st_len = 0;
	$('#limitContents').text(st_len);
}


/**
 * 첨부파일 업로드시 해당 확장자가 아닐시 alert 메세지와 함께 초기화<br />
 */
function ekrCheckUploadableFileExtention(objName){
	
	var array = ["doc","hwp","ppt","xls","pdf","jpg","jpeg","gif","bmp", "xlsx", "pptx", "docx"]; //"txt","zip"

	var cnt = 0;
			
	for(var i=0;i<array.length;i++) {
		if( document.getElementById(objName).value.toLowerCase().indexOf(array[i]) == -1 ){
			cnt++;
		}
	}

	if( cnt == array.length ) {
		alert("해당 파일[" + document.getElementById(objName).value.substring(document.getElementById(objName).value.lastIndexOf("\\")+1, document.getElementById(objName).value.length) + "]의 확장자는 지원하지 않습니다.");
		document.getElementById(objName).outerHTML = "<input type=\"file\" name=\"" + objName + "\" id=\"" + objName + "\" class=\"file\" onchange=\"existName(this.name)\" />";
		return;
	}
}