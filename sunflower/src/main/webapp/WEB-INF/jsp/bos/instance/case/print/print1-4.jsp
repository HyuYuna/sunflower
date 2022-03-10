<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm">

    <h1>성폭력 피해자 무료법률구조 신청서</h1>
    <div class="add">
        ※ 신청번호 : <input type="text" style="width:160px;" id="formdiv20" />
        (상담/기록 검토 배당 : <input type="text" style="width:100px;"  id="formdiv21" /> 당사자는 기재하지 말 것)</div>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="16%" />
            <col width="16%" />
            <col width="25%" />
            <col width="15%" />
            <col width="25%" />
        </colgroup>
        <tbody>
            <tr class="border_top">
                <th rowspan="4">신 청 인</th>
                <th>성명(기관명)</th>
                <td>${result.centerName}</td>
                <th>담당자</th>
                <td><input type="text" style="width:100%;" id="formdiv1" /></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${resultCenter.addr1}</td>
            </tr>
            <tr>
                <th>전화</th>
                <td>${resultCenter.cntad}</td>
                <th>팩스</th>
                <td>${resultCenter.faxNum}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${resultCenter.ref}</td>
                <th>휴대용전화</th>
                <td><input type="text" style="width:100%;" id="formdiv2" /></td>
            </tr>
            <tr class="border_top">
                <th rowspan="4">피 해 자<br />(신청인과<br />다른 경우)</th>
                <th>성명</th>
                <td colspan="3">${result.victimName}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr>
                <th>전화</th>
                <td><input type="text" style="width:100%;" id="formdiv3" /></td>
                <th>팩스</th>
                <td><input type="text" style="width:100%;" id="formdiv4" /></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" style="width:100%;" id="formdiv5" /></td>
                <th>휴대용전화</th>
                <td><input type="text" style="width:100%;" id="formdiv6" /></td>
            </tr>
            <tr class="border_top">
                <th>사건의 종류</th>
                <td colspan="4">
                    <input type="checkbox" id="formcheck1" value="Y" />형사고소대리
                    <input type="checkbox" id="formcheck2" value="Y" />형사변호
                    <input type="checkbox" id="formcheck3" value="Y" />민사소송
                    <input type="checkbox" id="formcheck4" value="Y" />가사소송
                    <input type="checkbox" id="formcheck5" value="Y" />기타(예:통역 등) <input type="text" style="width:90px;" id="formdiv7" />
                    <br />
                    <strong class="txt ac">형사 변호는 피해자가 피소되어 변호사 변호가 필요할 때 체크합니다.</strong>
                </td>
            </tr>
            <tr>
                <th>사건의 개요</th>
                <td colspan="4">
                    <textarea id='formdiva' style="width:100%;height:120px;">
- 피해구분 : ${result.caseTypeNm}(${result.caseTypeSubNm})
- 피해일시 : ${result.dmgTime}&nbsp;${result.dmgTimeMemo}
- 피해세부사항 :
 ${resultMemo.caseMemo}
 <c:forEach var="result" items="${resultAttkrList}" varStatus="status">
- 가해자와 피해자와의 관계 : ${result.attkrRelNm} ${result.attkrRelMemo}
- 가해자 세부사항 : ${result.attkrMemo}
</c:forEach>
${result.attkrMemo}- 상담 정보 주 호소 내용 및 지원 사항 :
${resultMemo.sangdamMemo}
<c:forEach var="result" items="${resultPassList}" varStatus="status">    ${result.passName}
</c:forEach>

-------------------------------
사건경위를 육하원칙으로 서술
피해자, 가해자, 피해시기, 피해유형, 피해자의 고통, 사건 후 가해자의 반응

신청 시점의 법적 진행상황을 표시합니다.
고소 전, 경찰수사 중, 검찰수사 중, 기소여부, 항고 중, 재정신청 중, 1심 재판 중, 항소심 중, 상고심 중, 민사소송 중 등
지면이 모자라면 첨부하여도 됩니다.</textarea>
                </td>
            </tr>
            <tr>
                <th>피해자의<br />인적사항<br />(경제적사항)</th>
                <td colspan="4" class="ac">
<textarea id='formdivb' style="width:100%;height:150px;">* 최종 학력 :
${resultMemo.victimMemo}

* 직업 :
* 혼인 상태 : □ 미혼 □ 기혼 □ 기타 :
* 자녀 : □ 유 □ 무
* 경제적 상황 : □ 주택 보유, □ 기타
               월 소득       상·중·하      만원 정도
               부양가족 유무 :
* 기타 특이사항 :
* 이전에 법률구조를 받은 경험이 있는지 여부 : </textarea>

<strong>피해자가 아동이라면 보호자의 직업과 재정상태를 표시합니다</strong>
</td>

            </tr>
            <tr>
                <th>구조필요성에<br />관한 의견</th>
                <td colspan="4"><textarea id='formdivd' style="width:100%;height:80px;">여성인권과의 관련성 및 피해자의 경제 상황을 고려하여 자세히 기재 요망</textarea><br /></td>
            </tr>
            <tr>
                <th rowspan="2">담당변호사명</th>
                <td colspan="2"rowspan="2"><input type="text" style="width:100%" id="formdiv15" value="사건담당을 수락한 변호사 이름을 반드시 기재" /></td>
                <th>변호사 사무실 전화번호</th>
                <td><input type="text" style="width:100%;" id="formdiv16" /></td>
            </tr>
            <tr>
                <th>변호사 사무실 팩스번호</th>
                <td><input type="text" style="width:100%;" id="formdiv17" /></td>
            </tr>
            <tr class="border_top">
                <th>※ 첨부서류</th>
                <td colspan="4">성폭력 피해상담사실 확인서 (상담소․시설) / 진단서 / 고소장 사본․접수증 중 1</td>
            </tr>
        </tbody>
    </table>
</div>

<div id="divPrintZone" style="display:none;">

    <h1>성폭력 피해자 무료법률구조 신청서</h1>
    <div class="add">※ 신청번호 : <span id="viewdiv20"></span>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    (상담/기록 검토 배당 : <span id="viewdiv21"></span>  당사자는 기재하지 말 것)</div>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="16%" />
            <col width="16%" />
            <col width="25%" />
            <col width="15%" />
            <col width="25%" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="4">신 청 인</th>
                <th>성명(기관명)</th>
                <td>${result.centerName}</td>
                <th>당담자</th>
                <td><div id="viewdiv1"></div></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${resultCenter.addr1}</td>
            </tr>
            <tr>
                <th>전화</th>
                <td>${resultCenter.cntad}</td>
                <th>팩스</th>
                <td>${resultCenter.faxNum}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${resultCenter.ref}</td>
                <th>휴대용전화</th>
                <td><div id="viewdiv2"></div></td>
            </tr>
            <tr class="border_top">
                <th rowspan="4">피 해 자<br />(신청인과<br />다른 경우)</th>
                <th>성명</th>
                <td colspan="3">${result.victimName}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
            </tr>
            <tr>
                <th>전화</th>
                <td><div id="viewdiv3"></div></td>
                <th>팩스</th>
                <td><div id="viewdiv4"></div></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><div id="viewdiv5"></div></td>
                <th>휴대용전화</th>
                <td><div id="viewdiv6"></div></td>
            </tr>
            <tr class="border_top">
                <th>사건의 종류</th>
                <td colspan="4">
                    <span id="viewcheck1" style="display:none;">형사고소대리&nbsp;&nbsp;&nbsp;</span>
                    <span id="viewcheck2" style="display:none;">형사변호&nbsp;&nbsp;&nbsp;</span>
                    <span id="viewcheck3" style="display:none;">민사소송&nbsp;&nbsp;&nbsp;</span>
                    <span id="viewcheck4" style="display:none;">가사소송&nbsp;&nbsp;&nbsp;</span>
                    <span id="viewcheck5" style="display:none;">기타&nbsp;</span>
                    <span id="viewdiv7"></span>
                </td>
            </tr>
            <tr>
                <th>사건의 개요</th>
                <td colspan="4"><div id="viewdiva"></div></td>
            </tr>
          
            <tr>
                <th>피해자의<br />인적사항<br />(경제적사항)</th>
                <td colspan="4"><strong>피해자가 아동이라면 보호자의 직업과 재정상태를 표시합니다</strong>
                    <br><div id="viewdivb"></div>
                </td>
            </tr>
            <tr>
                <th>구조필요성에<br />관한 의견</th>
                <td colspan="4"><div id="viewdivd"></div></td>
            </tr>
            <tr>
                <th rowspan="2">담당변호사명</th>
                <td colspan="2"rowspan="2"><div id="viewdiv15"></div></td>
                <th>변호사 사무실 전화번호</th>
                <td><div id="viewdiv16"></div></td>
            </tr>
            <tr>
                <th>변호사 사무실 팩스번호</th>
                <td><div id="viewdiv17"></div></td>
            </tr>
            <tr class="border_top">
                <th>※ 첨부서류</th>
                <td colspan="4">성폭력 피해상담사실 확인서 (상담소․시설) / 진단서 / 고소장 사본(접수증) 중 1</td>
            </tr>
        </tbody>
    </table>
</div>

<script>

    function fn_print_page_action(){
        $('#viewdiv1').text( $('#formdiv1').val() );
        $('#viewdiv2').text( $('#formdiv2').val() );
        $('#viewdiv3').text( $('#formdiv3').val() );
        $('#viewdiv4').text( $('#formdiv4').val() );
        $('#viewdiv5').text( $('#formdiv5').val() );
        $('#viewdiv6').text( $('#formdiv6').val() );
        $('#viewdiv7').text( $('#formdiv7').val() );
        $('#viewdiv8').text( $('#formdiv8').val() );
        $('#viewdiv9').text( $('#formdiv9').val() );
        $('#viewdiv10').text( $('#formdiv10').val() );
        $('#viewdiv11').text( $('#formdiv11').val() );
        $('#viewdiv12').text( $('#formdiv12').val() );
        $('#viewdiv13').text( $('#formdiv13').val() );
        $('#viewdiv14').text( $('#formdiv14').val() );
        $('#viewdiv15').text( $('#formdiv15').val() );
        $('#viewdiv16').text( $('#formdiv16').val() );
        $('#viewdiv17').text( $('#formdiv17').val() );
        $('#viewdiv18').text( $('#formdiv18').val() );
        $('#viewdiv19').text( $('#formdiv19').val() );
        $('#viewdiv20').text( $('#formdiv20').val() );
        $('#viewdiv21').text( $('#formdiv21').val() );
        $('#viewdiva').html( $('#formdiva').val().replace(/\n/g, "<br>") );
        $('#viewdivb').html( $('#formdivb').val().replace(/\n/g, "<br>") );
        //$('#viewdivc').html( $('#formdivc').val().replace(/\n/g, "<br>") );
        $('#viewdivd').html( $('#formdivd').val().replace(/\n/g, "<br>") );


        if ( $('#formcheck1').is(":checked") ) { $('#viewcheck1').show(); }
        if ( $('#formcheck2').is(":checked") ) { $('#viewcheck2').show(); }
        if ( $('#formcheck3').is(":checked") ) { $('#viewcheck3').show(); }
        if ( $('#formcheck4').is(":checked") ) { $('#viewcheck4').show(); }
        if ( $('#formcheck5').is(":checked") ) { $('#viewcheck5').show(); }
    }

</script>
