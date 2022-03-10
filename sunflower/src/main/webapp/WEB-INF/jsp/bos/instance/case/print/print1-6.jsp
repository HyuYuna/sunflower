<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm">

    <h1>성폭력 사건 보고</h1>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="14%" />
            <col width="20%" />
            <col width="23%" />
            <col width="20%" />
            <col width="23%" />
        </colgroup>
        <tbody>
            <tr>
                <th rowspan="4">구분</th>
                <th>수신</th>
                <td>여성․아동폭력피해<br>한국여성인권진흥원장</td>
                <th>발신</th>
                <td>${result.centerName} 센터장</td>
            </tr>
            <tr>
                <th>작성자<br />(직위/직군)</th>
                <td><input type="text" style="width:100%;" id="formdiv1" /></td>
                <th>작성일시</th>
                <td><input type="text" style="width:100%;" id="formdiv2" /></td>
            </tr>
            <tr>
                <th>피해일</th>
                <td><input type="text" style="width:100%;" id="formdiv3" /></td>
                <th>센터접수일</th>
                <td><input type="text" style="width:100%;" id="formdiv4" value="${result.caseDate}" /></td>
            </tr>
            <tr>
                <th>피해자수</th>
                <td><input type="text" style="width:100%;" id="formdiv5" value='명' /></td>
                <th>연령</th>
                <td><input type="text" style="width:40px;" id="formdiv6" /> 세 (학생여부 <input type="checkbox" id="formcheck1" value="Y" />)</td>
            </tr>
            <tr class="border_top">
                <th>피해내용</th>
                <td colspan="4">
                    <textarea id='formdiva' style="width:100%;height:150px;">${resultMemo.sangdamMemo}</textarea>
                    <p class="txt">피해장소 등 육하원칙에 맞게 작성(구체적 장소는 ○○ 가능) 가해자 연령, 관계 등</p>
                </td>
            </tr>
            <tr class="border_top">
                <th rowspan="3">지원현황</th>
                <th>진술녹화<br />일시</th>
                <td><input type="text" style="width:100%;" id="formdiv7" /></td>
                <th>전문가<br>의견조회일시</th>
                <td><input type="text" style="width:100%;" id="formdiv8" /></td>
            </tr>
            <tr>
                <th>국선변호사<br />연계 일시</th>
                <td><input type="text" style="width:100%;" id="formdiv9" /></td>
                <th>진술조력인<br />연계 여부 및 일시</th>
                <td><input type="text" style="width:100%;" id="formdiv10" /></td>
            </tr>
            <tr>
                <th>지원내용기술<br />(상담,수사,법률 등)</th>
                <td colspan="3"><textarea id='formdivb' style="width:100%; height:30px;"></textarea></td>
            </tr>
            <tr class="border_top">
                <th rowspan="2">의료·임상 지원 현황</th>
                <th>지원 현황</th>
                <td colspan="3"><textarea id='formdivc' style="width:100%;" value="의료/임상 관련 지원 현황"></textarea></td>
            </tr>
            <tr>
                <th>소견 및<br />특이사항</th>
                <td colspan="3"><textarea id='formdivd' style="width:100%;" value="관련 소견 심리평가 결과 "></textarea></td>
            </tr>
            <tr class="border_top">
                <th>피해자지원<br />협조요청사항</th>
                <td colspan="4"><textarea id='formdive' style="width:100%; height:50px;" value="한국여성인권진흥원 및 거점기능 센터 협조사항"></textarea></td>
            </tr>
            <tr class="border_top">
                <th>향후계획</th>
                <td colspan="4"><textarea id='formdivf' style="width:100%; height:50px;"></textarea></td>
            </tr>
        </tbody>
    </table>

</div>

<div id="divPrintZone" style="display:none;">

     <h1>성폭력 사건 보고</h1>
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
                <th rowspan="3">구분</th>
                <th>수신</th>
                <td>여성․아동폭력피해<br>한국여성인권진흥원장</td>
                <th>발신</th>
                <td>${result.centerName} 센터장</td>
            </tr>
            <tr>
                <th>작성자<br />(직위/직군)</th>
                <td><div id="viewdiv1"></div></td>
                <th>작성일시</th>
                <td><div id="viewdiv2"></div></td>
            </tr>
            <tr>
                <td colspan="4" style="padding:0;">
                    <table class="tb">
                        <colgroup>
                            <col width="10%" />
                            <col width="13%" />
                            <col width="10%" />
                            <col width="13%" />
                            <col width="9%" />
                            <col width="13%" />
                            <col width="9%" />
                            <col width="10%" />
                            <col width="13%" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>피해일</th>
                                <td><div id="viewdiv3"></div></td>
                                <th>센터<br />접수일</th>
                                <td><div id="viewdiv4"></div></td>
                                <th>피해<br />자수</th>
                                <td><div id="viewdiv5"></div></td>
                                <th>연령</th>
                                <td><div id="viewdiv6"></div></td>
                                <td class="ac lasttd">학생여부<br />(<span id="viewcheck1" style="display:none;">V</span>)</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr class="border_top">
                <th>피해내용</th>
                <td colspan="4"><div id="viewdiva"></div></td>
            </tr>
            <tr class="border_top">
                <th rowspan="3">지원현황</th>
                <th>진술녹화 일시</th>
                <td><div id="viewdiv7"></div></td>
                <th>전문가<br />의견조회<br />일시</th>
                <td><div id="viewdiv8"></div></td>
            </tr>
            <tr>
                <th>국선변호사<br />연계 일시</th>
                <td><div id="viewdiv9"></div></td>
                <th>진술조력인<br />연계 여부 및 일시</th>
                <td><div id="viewdiv10"></div></td>
            </tr>
            <tr>
                <th>지원내용기술<br />(상담, 수사,<br />법률 등)</th>
                <td colspan="3"><div id="viewdivb"></div></td>
            </tr>
            <tr class="border_top">
                <th rowspan="2">의료·임상<br />지원 현황</th>
                <th>지원 현황</th>
                <td colspan="3"><div id="viewdivc"></div></td>
            </tr>
            <tr>
                <th>소견 및<br />특이사항</th>
                <td colspan="3"><div id="viewdivd"></div></td>
            </tr>
            <tr class="border_top">
                <th>피해자지원<br />협조요청사항</th>
                <td colspan="4"><div id="viewdive"></div></td>
            </tr>
            <tr class="border_top">
                <th>향후계획</th>
                <td colspan="4"><div id="viewdivf"></div></td>
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
        $('#viewdiv6').text( $('#formdiv6').val() +" 세" );
        $('#viewdiv7').text( $('#formdiv7').val() );
        $('#viewdiv8').text( $('#formdiv8').val() );
        $('#viewdiv9').text( $('#formdiv9').val() );
        $('#viewdiv10').text( $('#formdiv10').val() );
        $('#viewdiva').html( $('#formdiva').val().replace(/\n/g, "<br>") );
        $('#viewdivb').html( $('#formdivb').val().replace(/\n/g, "<br>") );
        $('#viewdivc').html( $('#formdivc').val().replace(/\n/g, "<br>") );
        $('#viewdivd').html( $('#formdivd').val().replace(/\n/g, "<br>") );
        $('#viewdive').html( $('#formdive').val().replace(/\n/g, "<br>") );
        $('#viewdivf').html( $('#formdivf').val().replace(/\n/g, "<br>") );

        if ( $('#formcheck1').is(":checked") ) { $('#viewcheck1').show(); }
    }

</script>