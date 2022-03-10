<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO" />
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />
<fmt:formatDate value="${toDay}" var="today" pattern="yyyy-MM-dd" />
<script>
    /* Korean initialisation for the jQuery calendar extension. */
    /* Written by DaeKwon Kang (ncrash.dk@gmail.com), Edited by Genie. */
    jQuery(function($){
        $.datepicker.regional['ko'] = {
            closeText: '닫기',
            prevText: '이전달',
            nextText: '다음달',
            currentText: '오늘',
            monthNames: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            weekHeader: 'Wk',
            dateFormat: 'yy-mm-dd',
            firstDay: 0,
            isRTL: false,
            showMonthAfterYear: true,
            yearSuffix: '년'};
        $.datepicker.setDefaults($.datepicker.regional['ko']);
    });
</script>

<script>
    $(function() {
    	$("#pageSelect").change(function() {
			var pageUnit = $(this).val();
			var frm = $("#frm")[0];
			
			$.ajax({
					url: "/bos/instance/case/pageUnitChange.json",
					type: "get",
					data: {pageUnit : pageUnit},
					success: function(data) {
						$("#pageUnit").val(data.pageUnit);
						
						$("#frm").attr("action", "/bos/instance/case/listOther.do");
						$("#frm").submit();
					}
			});
		});
    	
    	$('#orderCaseDateBtn').on('click',function(){
            var casePdate = document.getElementById("casePdate");
            
            if(casePdate.value == ""){
            	casePdate.value ="ASC";
            }else if(casePdate.value == "ASC"){
            	casePdate.value = "DESC";
            }else if(casePdate.value == "DESC"){
            	casePdate.value = "ASC";
            }else{
            	casePdate.value = "ASC";
            }
            fn_search();
        });
    })
    
    function fn_search(){
    	document.frm.action = "/bos/instance/case/listOther.do?menuNo=${param.menuNo}";
		document.frm.submit();
    }
    $(document).keyup(function(event) {
        if (event.keyCode == '13') {
        	fn_search();
        }
  });
</script>

<!-- cont -->
<div class="cont">
	<form id="frm" name="frm" class="pure-form" method="post">
		<input type="hidden" name="menuNo" value="${param.menuNo}"> 
		<input type="hidden" name="userId" value="${userVO.userId}" />
    	<input type="hidden" name="userNm" value="${userVO.userNm}" />
    	<input type="hidden" id="historyMemo" name="historyMemo" value="" />
    	<input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
    	<input type="hidden" name="casePdate" id="casePdate" value="${param.casePdate}">
    	
    	<table class="pure-table pure-table-bordered" style="width:100%;">
    		<colgroup>
                   <col style="width:150px;" />
                   <col style="width:500px;" />
                   <col style="width:130px;" />
                   <col style="width:200px;" />
               </colgroup>
		    <tr>
		        <td class="align-center">피해자명</td>
		        <td colspan="3">
		        	<input type="text" name="scVictimName" id="scVictimName" value="${paramVO.scVictimName}">
		        	<input type="button" id="input2" name="input2" value="검색" class='pure-button btnSearch' style="height:30px;width:100px;" onclick="fn_search()"/>
		        </td>
		    </tr>
           </table>
       </form>
</div>

	<br/>
	<div style="float:left;">결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</div>
	<div style="float:right;">
		<p>
			<select id="pageSelect" name="pageSelect">
				<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
				<option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
				<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
				<option value="0" ${paramVO.pageUnit eq '999999' ? 'selected' : '' }>전체</option>
			</select>
		</p>
	</div>
	<div style="clear:both; width:100%;">
		<table class="table table-striped table-hover" id="tbCase">
		<caption>사례 목록</caption>
			<thead>
				<tr>
					<th style="width:" scope="col">센터명</th>
					<th style="width:15%" scope="col">사례구분</th>
					<th style="width:15%" scope="col">접수일 <button type="button" name="orderCaseDateBtn" id="orderCaseDateBtn">▼▲</button></th>
					<th style="width:15%" scope="col">피해자이름</th>
					<th style="width:10%" scope="col">피해자성별</th>
					<th style="width:10%" scope="col">피해자나이</th>
					<th style="width:15%" scope="col">접수담당자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${result.centerName}</td>
						<td>${result.caseTypeNm}</td>
						<td>${result.caseDate}</td>
						<td>${result.victimName}</td>
						<td>
							<c:choose>
								<c:when test="${result.victimSex == 'M'}" >남자</c:when>
								<c:when test="${result.victimSex == 'F'}" >여자</c:when>
								<c:otherwise>
									알수없음
								</c:otherwise>
							</c:choose>
						</td>
						<td><c:if test="${result.victimAge eq 199}">알수없음</c:if> 
                            <c:if test="${result.victimAge ne 199}">
                                <fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>
                            </c:if>
                        </td>
						<td>${result.memberName}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
					    <td colspan="7">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<c:if test="${fn:length(resultList) > 0}">
		${pageNav}
	</c:if>

