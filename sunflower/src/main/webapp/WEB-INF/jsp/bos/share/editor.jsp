<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="target" value="${empty param.target ? 'bocontents' : param.target  }" /><%-- 에디터 대상 --%>
<script src="/smarteditor/js/HuskyEZCreator.js"></script>
<script>
/* 네이버 스마트 에디터  */
// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "${target}",
	sSkinURI: "/smarteditor/SmartEditor2Skin.html",
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		SE2M_FontName: {
		    htMainFont: {'id': '맑은 고딕','name': '맑은 고딕','size': '11','url': '','cssUrl': ''} // 기본 글꼴 설정
		},
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["nttCn"].exec("PASTE_HTML", "");
	},
	fCreator: "createSEditor2"
});
</script> 