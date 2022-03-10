<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm" >

    <h1>센터 이용 확인서</h1>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="18%" />
            <col width="15%" />
            <col width="26%" />
            <col width="15%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="2">이용자<br />인적사항</th>
                <th>성명</th>
                <td>${result.victimName}</td>
                <th>생년월일</th>
                <td>${result.victimBirth}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr>
                <th>확인사항</th>
                <td colspan="4"><textarea rows="6" id="formdiva" style="width:100%;"></textarea></td>
            </tr>
            <tr>
                <th>담당자</th>
                <td colspan="4">${result.centerName} (담당자 : <input type="text" style="width:30%;" id="formdiv1" />)</td>
            </tr>
        </tbody>
        <tfoot>
            <tr class="border_top">
                <td colspan="5">
                    <textarea rows="6" id="formdivb" style="width:100%; height:50px;"></textarea>
                    <p>본 센터는 위 내용이 사실임을 확인합니다.<br />
                    <input type="text" style="width:50%;" id="formdiv5" value="20   년     월     일" />
                    </p>
                    <textarea rows="6" id="formdivc" style="width:100%; height:50px;"></textarea>
                    <br />
                    <dl>
                        <dd><span>확 인 기 관</span>${result.centerName}</dd>
                        <dd><span class="tit">소 재 지</span><strong>${resultCenter.addr1}</strong></dd>
                        <dd><span>전 화 번 호</span>${resultCenter.cntad}</dd>
                    </dl>
                </td>
            </tr>
        </tfoot>
    </table>
</div>

<div id="divPrintZone" style="display:none">

    <h1>센터 이용 확인서</h1>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="18%" />
            <col width="15%" />
            <col width="26%" />
            <col width="15%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="2">이용자<br />인적사항</th>
                <th>성명</th>
                <td>${result.victimName}</td>
                <th>생년월일</th>
                <td>${result.victimBirth}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr>
                <th>확인사항</th>
                <td colspan="4"><div id="viewdiva"></div></td>
            </tr>
            <tr>
                <th>담당자</th>
                <td colspan="4">${result.centerName} (담당자 : <span id="viewdiv1"></span>)</td>
            </tr>
        </tbody>
        <tfoot>
            <tr class="border_top">
                <td colspan="5">
                    <div id="viewdivb"></div>
                    <p>본 센터는 위 내용이 사실임을 확인합니다.<br />
                    <span id="viewdiv5"></span>
                    </p>
                    <div id="viewdivc"></div>
                    <br />
                    <dl>
                        <dd><span>확 인 기 관</span>${result.centerName}</dd>
			            <dd><span class="tit">소 재 지</span><strong>${resultCenter.addr1}</strong></dd>
			            <dd><span>전 화 번 호</span>${resultCenter.cntad}</dd>
                    </dl>
                </td>
            </tr>
        </tfoot>
    </table>
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
        $('#viewdivc').html( $('#formdivc').val().replace(/\n/g, "<br>") );
    }

</script>
