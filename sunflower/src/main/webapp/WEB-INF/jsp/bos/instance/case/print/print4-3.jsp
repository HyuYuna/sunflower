<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm" >
    <div style="width:250px; float:right;">
        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col width="5%" />
                <col width="31.66%" />
                <col width="31.66%" />
                <col width="31.66%" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="2">결재</th>
                    <th>담당자</th>
                    <th><input type="text" style="width:100%;" id="formdiv1" /></th>
                    <th><input type="text" style="width:100%;" id="formdiv2" /></th>
                </tr>
                <tr style="height:50px;">
                    <td><input type="text" style="width:100%;" id="formdiv3" /></td>
                    <td><input type="text" style="width:100%;" id="formdiv4" /></td>
                    <td><input type="text" style="width:100%;" id="formdiv5" /></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>








    <div id="divPrintZone" style="display:none">
        <div style="width:250px; float:right;">
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="5%" />
                    <col width="31.66%" />
                    <col width="31.66%" />
                    <col width="31.66%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th rowspan="2">결재</th>
                        <th>담당자</th>
                        <th><span id="viewdiv1"></th>
                        <th><span id="viewdiv2"></span></th>
                    </tr>
                    <tr style="height:50px;">
                        <td style="text-align:center;"><span id="viewdiv3"></span></td>
                        <td style="text-align:center;"><span id="viewdiv4"></span></td>
                        <td style="text-align:center;"><span id="viewdiv5"></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="c_both"></div>
    <h1 class="tit_line">사례부가정보 기록지</h1>

        <h4>사례정보</h4>

        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col style="width:160px;" />
                <col style="width:160px;" />
                <col style="width:150px;" />
                <col style="width:180px;" />
                <col style="width:100px;" />
                <col style="width:190px;" />
            </colgroup>
        <tbody>
            <tr style="height:30px;">
                <td style="background-color:#e9e9e9; text-align:center;">피해자 이름</td>
                <td colspan='5' style="padding:0px;">
                    <table style="width:100%; height:100%; border:0px; padding:0px; margin:0px">
                        <colgroup>
                            <col style="width:110px;" />
                            <col style="width:70px;" />
                            <col style="width:70px;" />
                            <col style="width:70px;" />
                            <col style="width:170px;" />
                            <col style="width:70px;" />
                            <col style="width:160px;" />
                        </colgroup>
                    <tbody>
                        <tr>
                            <td style="padding:5px; border:0px; border-right:1px solid #bbb;">${result.victimName}</td>
                            <td style="background-color:#e9e9e9; text-align:center;border-bottom:0;">성별</td>
                            <td style="border-bottom:0;">
                                    <c:choose>
                                        <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                        <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                        <c:otherwise>알수없음</c:otherwise>
                                    </c:choose></td>
                            <td style="background-color:#e9e9e9; text-align:center;border-bottom:0;">장애</td>
                            <td style="border-bottom:0;">${result.victimDisableNm}</td>
                            <td style="background-color:#e9e9e9; text-align:center;border-bottom:0;">국적</td>
                            <td style="border-bottom:0;">
                                    <c:choose>
                                        <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                        <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose></td>
                        </tr>
                    </tbody>
                    </table>

                </td>
            </tr>
            <tr style="height:30px;">
                <td style="background-color:#e9e9e9; text-align:center;">피해구분</td>
                <td>${result.caseTypeNm}(${result.caseTypeSubNm})</td>
                <td style="background-color:#e9e9e9; text-align:center;">최초접수일</td>
                <td>${result.caseDate}&nbsp; ${result.caseTime}</td>
                <td style="background-color:#e9e9e9; text-align:center;">센터명</td>
                <td>${result.centerName}</td>
            </tr>
            <tr style="height:30px;">
                    <td style="background-color:#e9e9e9; text-align:center;">전산관리번호</span>
                        <span id="bxtFinishCaseLoading" style="display:none; color:red;">사례 관리중</span></td>
                    <td>${result.caseNumber}</td>
                    <td style="background-color:#e9e9e9; text-align:center;">센터사례번호</td>
                    <td>${result.centerNumber}</td>
                    <td style="background-color:#e9e9e9`; text-align:center;">참조번호</td>
                    <td>${result.caseRel}</td>
            </tr>
        </tbody>
    </table>
    <input type="hidden" id="state_case_info" value="N">


    <h4>피해구분 추가 : 피해구분 추가하기</h4>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="25%;" />
            <col width="25%;" />
            <col width="" />
        </colgroup>
        <tbody>
                <c:if test="${resultServ.csType == 'C'}">
                    <tr>
                        <th rowspan="2">아동학대범죄</th>
                        <th>가해자구분</th>
                        <td>
                            ${resultServ.csTypeGroupNm}
                        </td>
                    </tr>
                    <tr>
                        <th>학대행위구분</th>
                        <td>
                            <c:if test="${resultServ.csTypeAct01 == 'Y'}">신체학대, </c:if>
                            <c:if test="${resultServ.csTypeAct02 == 'Y'}">정서학대, </c:if>
                            <c:if test="${resultServ.csTypeAct03 == 'Y'}">성학대, </c:if>
                            <c:if test="${resultServ.csTypeAct04 == 'Y'}">방임, </c:if>
                            <c:if test="${resultServ.csTypeAct05 == 'Y'}">알 수 없음</c:if>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${resultServ.csType == 'M'}">
                    <tr>
                        <th>군대내성폭력</th>
                        <td colspan="2">
                            군대내성폭력
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <br>

        <h4>지원경과 : 성폭력 피해자 지원제도 활용 여부</h4>
        <table class="table02">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="25%;" />
                <col width="45%;" />
            </colgroup>
            <tbody>
                <tr>
                    <th>수사법률지원</th>
                    <td colspan="3">
                        <c:if test="${resultServ.csGroupA04 == 'Y'}">진술녹화 시행, </c:if>
                        <c:if test="${resultServ.csGroupA05 == 'Y'}">피해자 국선변호사 연계, </c:if>
                        <c:if test="${resultServ.csGroupA01 == 'Y'}">전문가 의견조회 제도 활용, </c:if>
                        <c:if test="${resultServ.csGroupA02 == 'Y'}">진술조력인 활용, </c:if>
                        <c:if test="${resultServ.csGroupA03 == 'Y'}">신뢰관계인 동석(${resultServ.csGroupA10Nm}), </c:if>
                        <c:if test="${resultServ.csGroupA06 == 'Y'}">무료법률구조사업 연계, </c:if>
                        <c:if test="${resultServ.csGroupA07 == 'Y'}">통역지원, </c:if>
                        <c:if test="${resultServ.csGroupA08 == 'Y'}">속기사</c:if>
                    </td>
                </tr>
                
                <tr>
                    <th rowspan='5'>의료지원</th>
                    <th>의료비지원대상</th>
                    <td colspan='2'>
                        ${resultServ.csGroupB20Nm}
                    </td>
                </tr>
                <tr>
                    <th>간병비지원 사유</th>
                    <td colspan='2'>
                        ${resultServ.csGroupB40Nm}
                    </td>
                </tr>
                <tr>
                    <th>응급키트 실시</th>
                    <td colspan='2'>
                        ${resultServ.csGroupB51}
                    </td>
                </tr>

                <tr>
                    <th rowspan='2'>인공임신중절 지원</th>
                    <td>센터가 임신을 확인한 시점
                    </td>
                    <td>
                        ${resultServ.csGroupB61Nm}
                    </td>
                </tr>
                <tr>
                    <td>인공임신중절 수술시행 병원
                    </td>
                    <td>
                        ${resultServ.csGroupB62Nm}
                    </td>
                </tr>
            </tbody>
        </table>

        <br/>
        <h4>사례 경과 및 종결 : 수사재판 경과</h4>
        <table class="table02">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="15%;" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="6">수사재판 경과</th>
                    <th>신고</th>
                    <td colspan='2'>
                        ${resultServ.csGroupC10Nm}
                    </td>
                </tr>
                <tr>
                    <th rowspan=2>검찰</th>
                    <th>불기소
                    </th>
                    <td>
                        <c:if test="${resultServ.csGroupC20 == '11'}">무혐의</c:if>
                        <c:if test="${resultServ.csGroupC20 == '12'}">기소유예</c:if>
                        <c:if test="${resultServ.csGroupC20 == '14'}">기타</c:if>
                    </td>
                </tr>
                <tr>
                    <th>기소
                    </th>
                    <td>
                        <c:if test="${resultServ.csGroupC20 == '13'}">기소</c:if>
                    </td>
                </tr>
                <tr>
                    <th>재판</th>
                    <td colspan="2">
                        1심 재판결과 ${resultServ.csGroupC22Nm} ${resultServ.csGroupC22Memo}
                        <br>
                        2심 재판결과 ${resultServ.csGroupC23Nm} ${resultServ.csGroupC23Memo}
                        <br>
                        3심 재판결과 ${resultServ.csGroupC24Nm} ${resultServ.csGroupC24Memo}
                    </td>
                </tr>
            </tbody>
        </table>
        <br/>
        <h4>사례관련 추가 기재 필요 사항</h4>
        <table class="table02">
            <tbody>
                <tr>
                    <td style="white-space: pre-wrap;">${resultServ.csMemo}</td>
                </tr>
            </tbody>
    </table>

    <br>
    
    <div style="text-align:center;"><h1>${result.centerName}</h1></div>
</div>

<script>
    function fn_print_page_action() {
        $('#viewdiv1').text( $('#formdiv1').val() );
        $('#viewdiv2').text( $('#formdiv2').val() );
        $('#viewdiv3').text( $('#formdiv3').val() );
        $('#viewdiv4').text( $('#formdiv4').val() );
        $('#viewdiv5').text( $('#formdiv5').val() );
    }
</script>

