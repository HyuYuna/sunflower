<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm">

    <h1>피해 상담사실 확인서</h1>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="18%" />
            <col width="15%" />
            <col width="25%" />
            <col width="15%" />
            <col width="25%" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="2">피해자 인적사항</th>
                <th>성명</th>
                <td>${result.victimName}</td>
                <th>생년월일</th>
                <td>${result.victimBirth}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr class="border_top">
                <th rowspan="2">가해자 인적사항</th>
                <th>성명</th>
                <td><input type="text" style="width:100%;" id="formdiv1" /></td>
                <th>생년월일</th>
                <td><input type="text" style="width:100%;" id="formdiv2" /></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3"><input type="text" style="width:100%;" id="formdiv3" /></td>
            </tr>
        </tbody>
    </table>

    <div>
        <div class='div_td_title'>피해내용</div>
        <div class='div_td_content'><textarea id='formdiva' rows="8" style="width:100%;">${resultMemo.caseMemo}</textarea></div>
    </div>
    <div>
        <div class='div_td_title'>입증방법</div>
        <div class='div_td_content'><textarea id='formdivb' style="width:100%;">붙임 1. 증거사진 2. 목격자 진술서 등</textarea> </div>
    </div>
    <div class='div_foot_content'>

        <p><input type="text" style="width:100%;" id="formdiv4" value="상기 ${result.victimName} 는(은) 성폭력·가정폭력 피해자로 상담하였음을 확인합니다." />
        <br /><br />
        <input type="text" style="width:50%;" id="formdiv5" value="20   년     월     일" />
        </p>
        <dl>
            <dd><span>확 인 기 관</span>${result.centerName}</dd>
            <dd><span class="tit">소 재 지</span><strong>${resultCenter.addr1}</strong></dd>
            <dd><span>전 화 번 호</span>${resultCenter.cntad}</dd>
        </dl>
    </div>
</div>

<div id="divPrintZone" style="display:none;">

    <h1>피해 상담사실 확인서</h1>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="18%" />
            <col width="15%" />
            <col width="25%" />
            <col width="15%" />
            <col width="25%" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="2">피해자 인적사항</th>
                <th>성명</th>
                <td>${result.victimName}</td>
                <th>생년월일</th>
                <td>${result.victimBirth}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr class="border_top">
                <th rowspan="2">가해자 인적사항</th>
                <th>성명</th>
                <td><div id="viewdiv1"></div></td>
                <th>생년월일</th>
                <td><div id="viewdiv2"></div></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3"><div id="viewdiv3"></div></td>
            </tr>
        </tbody>
    </table>

    <div>
        <div class='div_td_title'>피해내용</div>
        <div class='div_td_content' id="viewdiva"></div>
    </div>
    <div>
        <div class='div_td_title'>입증방법</div>
        <div class='div_td_content' id="viewdivb"></div>
    </div>
    <div class='div_foot_content'>

        <p>상기 ${result.victimName} 는(은) 성폭력·가정폭력 피해자로 상담하였음을 확인합니다.<br />
        <br />
        <span id="viewdiv5"></span>
        </p>
        <dl>
	        <dd><span>확 인 기 관</span>${result.centerName}</dd>
	        <dd><span class="tit">소 재 지</span><strong>${resultCenter.addr1}</strong></dd>
	        <dd><span>전 화 번 호</span>${resultCenter.cntad}</dd>
        </dl>
    </div>
</div>

<script>
function fn_print_page_action() {
    $('#viewdiv1').text( $('#formdiv1').val() );
    $('#viewdiv2').text( $('#formdiv2').val() );
    $('#viewdiv3').text( $('#formdiv3').val() );
    $('#viewdiv4').text( $('#formdiv4').val() );
    $('#viewdiv5').text( $('#formdiv5').val() );
    $('#viewdiva').html( $('#formdiva').val().replace(/\n/g, "<br>") );
    $('#viewdivb').html( $('#formdivb').val().replace(/\n/g, "<br>") );
}
</script>
