<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

    <div class="c_both"></div>
    <h1 class="tit_line">연계의뢰서</h1>

            <h4>발신기관</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기관명</th>
                        <td>${result.centerName}</td>
                        <th>담당자</th>
                        <td><input type="text" style="width:100%;" id="formdiv6" /></td>
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
                        <td colspan="3">${resultCenter.ref}</td>
                    </tr>
                    <tr>
                        <th>발신일</th>
                        <td><input type="text" style="width:100%;" id="formdiv7" /></td>
                        <th>발신수단</th>
                        <td><input type="text" style="width:100%;" id="formdiv8" /></td>
                    </tr>
                </tbody>
            </table>

            <h4>수신기관</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기관명</th>
                        <td><input type="text" style="width:100%;" id="formdiv9" /></td>
                        <th>담당자</th>
                        <td><input type="text" style="width:100%;" id="formdiv10" /></td>
                    </tr>
                    <tr>
                        <th>전화</th>
                        <td><input type="text" style="width:100%;" id="formdiv11" /></td>
                        <th>팩스</th>
                        <td><input type="text" style="width:100%;" id="formdiv12" /></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td colspan="3"><input type="text" style="width:100%;" id="formdiv13" /></td>
                    </tr>
                </tbody>
            </table>

            <h4>의뢰 내용</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>            
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th colspan="4">사례정보</th>
                    </tr>
                    <tr>
                        <th>전산관리번호</th>
                        <td>${result.caseNumber}</td>
                        <th>센터사례번호</th>
                        <td>${result.centerNumber}</td>
                    </tr>
                    <tr>
                        <th>사례접수일</th>
                        <td>${result.caseDate} &nbsp;&nbsp; ${result.caseTime}</td>
                        <th>피해구분</th>
                        <td>${result.caseTypeNm}</td>
                    </tr>
                    <tr>
                        <th colspan="4">내담자 인적사항</th>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${result.victimName}</td>
                        <th>성별/국적</th>
                        <td>
                            <c:choose>
                                <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                <c:otherwise>알수없음</c:otherwise>
                            </c:choose>/<c:choose>
                                <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>생년월일(나이)</th>
                        <td>
                            <c:if test="${result.victimAge eq 199}">알수없음</c:if> 
                            <c:if test="${result.victimAge ne 199}">
                                ${result.victimBirth}(<fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>)
                            </c:if>
                        </td>
                        <th>장애</th>
                        <td>${result.victimDisableNm}</td>
                    </tr>
                </tbody>
            </table>
            <div>
                <div class='div_td_title' style='border-top:2px solid #000;'>세부내용</div>
                <div class='div_td_content'><textarea id='formdiva' style="width:100%; height:75px;">${resultMemo.victimMemo}</textarea></div>
            </div>
            <div>
                <div class='div_td_title'>피해정보</div>
                <div class='div_td_content'><textarea id='formdivb' style="width:100%; height:150px;">${resultMemo.caseMemo}</textarea></div>
            </div>
            <div>
                <div class='div_td_title'>특이사항</div>
                <div class='div_td_content'><textarea id='formdivc' style="width:100%; height:35px;"></textarea></div>
            </div>
            <div>
                <div class='div_td_title'>센터 지원 사항</div>
                <div class='div_td_content'><textarea id='formdivd' style="width:100%; height:35px;"></textarea></div>
            </div>
            <div>
                <div class='div_td_title'>연계 사유 및 요청사항</div>
                <div class='div_td_content'><textarea id='formdive' style="width:100%; height:35px;"></textarea></div>
            </div>
            
            <ul style="margin-top:20px;">
                <li>※ 본 의뢰서는 「개인정보보호법」에 따라 피해자(또는 보호자)에게 개인정보 수집 및 제3자 이용 동의를 받아 제출하였습니다. </li>
                <li>※ 본 의뢰서에 기록된 개인정보는 연계 목적 이외의 용도로 사용할 수 없습니다.</li>
                <li>※ 연계기관의 접수자는 지정된 담당자에게 연계의뢰서를 즉시 전달하고, 연계 사항에 대해 정해진 기간 내 회신해야 합니다.</li>
            </ul>

    <br>
    <div style="text-align:center;"><h1>${result.centerName}</h1></div>
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
    <div class="c_both"></div>
    <h1 class="tit_line">연계의뢰서</h1>

            <h4>발신기관</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기관명</th>
                        <td>${result.centerName}</td>
                        <th>담당자</th>
                        <td><span id="viewdiv6"></span></td>
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
                        <td colspan="3">${resultCenter.ref}</td>
                    </tr>
                    <tr>
                        <th>발신일</th>
                        <td><span id="viewdiv7"></span></td>
                        <th>발신수단</th>
                        <td><span id="viewdiv8"></span></td>
                    </tr>
                </tbody>
            </table>

            <h4>수신기관</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기관명</th>
                        <td><span id="viewdiv9"></span></td>
                        <th>담당자</th>
                        <td><span id="viewdiv10"></span></td>
                    </tr>
                    <tr>
                        <th>전화</th>
                        <td><span id="viewdiv11"></span></td>
                        <th>팩스</th>
                        <td><span id="viewdiv12"></span></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td colspan="3"><span id="viewdiv13"></span></td>
                    </tr>
                </tbody>
            </table>

            <h4>의뢰 내용</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>            
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th colspan="4">사례정보</th>
                    </tr>
                    <tr>
                        <th>전산관리번호</th>
                        <td>${result.caseNumber}</td>
                        <th>센터사례번호</th>
                        <td>${result.centerNumber}</td>
                    </tr>
                    <tr>
                        <th>사례접수일</th>
                        <td>${result.caseDate} &nbsp;&nbsp; ${result.caseTime}</td>
                        <th>피해구분</th>
                        <td>${result.caseTypeNm}</td>
                    </tr>
                    <tr>
                        <th colspan="4">내담자 인적사항</th>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${result.victimName}</td>
                        <th>성별/국적</th>
                        <td>
                            <c:choose>
                                <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                <c:otherwise>알수없음</c:otherwise>
                            </c:choose>/<c:choose>
                                <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>생년월일(나이)</th>
                        <td>
                            <c:if test="${result.victimAge eq 199}">알수없음</c:if> 
                            <c:if test="${result.victimAge ne 199}">
                                ${result.victimBirth}(<fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>)
                            </c:if>
                        </td>
                        <th>장애</th>
                        <td>${result.victimDisableNm}</td>
                    </tr>
                </tbody>
            </table>
            <div>
                <div class='div_td_title' style='border-top:2px solid #000;'>세부내용</div>
                <div class='div_td_content' id="viewdiva"></div>
            </div>
            <div>
                <div class='div_td_title'>피해정보</div>
                <div class='div_td_content' id="viewdivb"></div>
            </div>
            <div>
                <div class='div_td_title'>특이사항</div>
                <div class='div_td_content' id="viewdivc"></div>
            </div>
            <div>
                <div class='div_td_title'>센터 지원 사항</div>
                <div class='div_td_content' id="viewdivd"></div>
            </div>
            <div>
                <div class='div_td_title'>연계 사유 및 요청사항</div>
                <div class='div_td_content' id="viewdive"></div>
            </div>

            <ul style="margin-top:20px;">
                <li>※ 본 의뢰서는 「개인정보보호법」에 따라 피해자(또는 보호자)에게 개인정보 수집 및 제3자 이용 동의를 받아 제출하였습니다. </li>
                <li>※ 본 의뢰서에 기록된 개인정보는 연계 목적 이외의 용도로 사용할 수 없습니다.</li>
                <li>※ 연계기관의 접수자는 지정된 담당자에게 연계의뢰서를 즉시 전달하고, 연계 사항에 대해 정해진 기간 내 회신해야 합니다.</li>
            </ul>

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
        $('#viewdiv6').text( $('#formdiv6').val() );
        $('#viewdiv7').text( $('#formdiv7').val() );
        $('#viewdiv8').text( $('#formdiv8').val() );
        $('#viewdiv9').text( $('#formdiv9').val() );
        $('#viewdiv10').text( $('#formdiv10').val() );
        $('#viewdiv11').text( $('#formdiv11').val() );
        $('#viewdiv12').text( $('#formdiv12').val() );
        $('#viewdiv13').text( $('#formdiv13').val() );
        $('#viewdiva').html( $('#formdiva').val().replace(/\n/g, "<br>") );
        $('#viewdivb').html( $('#formdivb').val().replace(/\n/g, "<br>") );
        $('#viewdivc').html( $('#formdivc').val().replace(/\n/g, "<br>") );
        $('#viewdivd').html( $('#formdivd').val().replace(/\n/g, "<br>") );
        $('#viewdive').html( $('#formdive').val().replace(/\n/g, "<br>") );
    }

</script>