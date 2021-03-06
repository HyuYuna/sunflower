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
    <h1 class="tit_line">지원서비스 경과 기록지</h1>

            <h4>사례정보</h4>

            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col style="width:180px;" />
                    <col style="width:150px;" />
                    <col style="width:150px;" />
                    <col style="width:170px;" />
                    <col style="width:100px;" />
                    <col style="width:180px;" />
                </colgroup>
                <tr style="height:30px;">
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">피해자 이름</td>
                    <td colspan='5' style="padding:0px;">
                        <table class="pure-table pure-table-bordered" style="width:100%; border:0px;margin:0;height:30px;">
                            <colgroup>
                                <col style="width:110px;" />
                                <col style="width:70px;" />
                                <col style="width:70px;" />
                                <col style="width:110px;" />
                                <col style="width:170px;" />
                                <col style="width:70px;" />
                                <col style="width:120px;" />
                            </colgroup>
                            <tr>
                                <td style="border-top:none;">${result.victimName}</td>
                                <td style="background-color:#f6f6f6; text-align:center;border-top:none;font-weight: bold;">성별</td>
                                <td class="align-center" style="border-top:none;">
                                    <c:choose>
                                        <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                        <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                        <c:otherwise>알수없음</c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="background-color:#f6f6f6; text-align:center;border-top:none;font-weight: bold;">장애</td>
                                <td class="align-center" style="border-top:none;">
                                    ${result.victimDisableNm}
                                    <c:choose>
                                        <c:when test="${result.victimDisable == '1'}" >장애정도 : ${result.victimDisableMemo}</c:when>
                                        <c:when test="${result.victimDisable == '2'}" >장애명 : ${result.victimDisableMemo}</c:when>
                                        <c:when test="${result.victimDisable == '3'}" >장애명 : ${result.victimDisableMemo}</c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                  </td>
                                <td style="background-color:#f6f6f6; text-align:center;border-top:none;font-weight: bold;">국적</td>
                                <td class="align-center" style="border-top:none;border-right:none;">
                                    <c:choose>
                                        <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                        <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                  </td>
                            </tr>
                        </table>

                    </td>
                </tr>
                <tr style="height:30px;">
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">피해구분</td>
                    <td>${result.caseTypeNm}&nbsp;${result.caseTypeSubNm}</td>
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">최초접수일</td>
                    <td>${result.caseDate}&nbsp;${result.caseTime}</td>
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">센터명</td>
                    <td>${result.centerName}</td>
                </tr>
                <tr style="height:30px;">
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;"><span id="bxtFinishCase">전산관리번호</span>
                        <span id="bxtFinishCaseLoading" style="display:none; color:red;">사례 관리중</span></td>
                    <td>${result.caseNumber}</td>
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">센터사례번호</td>
                    <td>${result.centerNumber}</td>
                    <td style="background-color:#f6f6f6; text-align:center; font-weight: bold;">참조번호</td>
                    <td class="align-center">
                        <c:set var="data" value="${fn:split(result.caseRel,', ')}" />
                        <c:forEach var="x" begin="0" end="${fn:length(data)-1}">
                            <span id="sapn_caseRel">${data[x]}</span><br/>
                        </c:forEach>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="state_case_info" value="N">
            
            <h4>지원서비스 경과기록</h4>
    <table cellpadding="0" cellspacing="0" border="0" class="table02">
        <colgroup>
            <col width="20%" />
            <col width="25%" />
            <col width="20%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>내담자이름</th>
                <td>${resultOnePassList.userName}
                </td>
                <th>피해자와의 관계</th>
                <td>
                    ${resultOnePassList.userRelGrpNm}  ${resultOnePassList.userRelNm}
                </td>
            </tr>
            <tr>
                <th>지원일자</th>
                <td>${resultOnePassList.passDate }
                </td>
                <th>지원시간</th>
                <td>
                ${resultOnePassList.passTime }
                ~
                ${resultOnePassList.passTimeE }
                </td>
            </tr>
            <tr>
                <th>지원방법</th>
                <td>    
                ${resultOnePassList.passWayNm }
                </td>
                <th>담당자</th>
                <td>${resultOnePassList.passManager }
                </td>
            </tr>
            <tr>
                <th>지원구분</th>
                <td>${resultOnePassList.passName }
                </td>
                <th>지원세부구분</th>
                <td>
                    ${resultOnePassList.sub1Name }
                </td>
            </tr>
            <tr>
                <th>지원대상 구분</th>
                <td colspan=3>${resultOnePassList.passRelTypeNm}
                </td>
            </tr>
            <tr>
                <th>지원요약</th>
                <td colspan=3 style="white-space: pre-wrap;">${resultOnePassList.passMemo}
                </td>
            </tr>
            <tr>
                <th>세부사항</th>
                <td colspan=3 style="white-space: pre-wrap;">${resultOnePassList.passText}
                </td>
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
