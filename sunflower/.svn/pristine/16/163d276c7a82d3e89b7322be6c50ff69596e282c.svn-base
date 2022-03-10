<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>
<script src="/static/bos/js/common.js"></script>
<script>
$(function (){ 
	$("#pageSelect").change(function() {
	    var pageUnit = $(this).val();
	    var frm = $("#frm2")[0];
	    $.ajax({
	        url: "/bos/member/user/pageUnitChange.json",
	        type: "get",
	        data: {pageUnit : pageUnit},
	        success: function(data) {
	            $("#pageUnit").val(data.pageUnit);
	            
	            $("#frm2").attr("action", "/bos/member/user/list_lock.do");
	            $("#frm2").submit();
	        }
	    });
	});
});

function unlockUserFun(userId,userName){
	    $.ajax({
	        type:"post",
	        url:"/bos/member/user/unlockUser.json" ,
	        data: {
	            userId : userId,
	            userName : userName
	        },
	        dataType: "json",
	        success:function(entry){
	            alert("계정 잠금이 해제되었습니다.");
	            window.location.reload();
	        }, error: function(xhr,status,error){
	            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
	        }
	    });
}
  
</script>
<form id="frm2" name="frm2" method="post" action="/bos/member/user/list_lock.do" class="pure-form">
    <input type="hidden" name="menuNo" value="${param.menuNo}">
    <input type="hidden" name="orderName" id="orderName" value="${param.orderName}">
    <input type="hidden" name="orderBdate" id="orderBdate" value="${param.orderBdate}">
    <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit}" />

    <!-- 게시판 게시물검색 start -->
    <fieldset>
        <div class="sh">
            <select name="searchCnd1" id="searchCnd1" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','searchCnd2',this.value , '', 'N')">
                <script>
                    getCmmnCd.select('CM04', 'searchCnd1', '${paramVO.searchCnd1}', 'N');
                </script>
            </select>
            <select name="searchCnd2" id="searchCnd2" title="센터 구분 서브" >
                <script>
                    getCmmnCd.subSelect('CM05','searchCnd2','${paramVO.searchCnd1}', '${paramVO.searchCnd2}', 'N')
                </script>
            </select>
            <input type="text" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" class="" placeholder="사용자이름" title="사용자이름" />
            <button type="submit" id="btnJqgridSearch" class='pure-button btnSave'>검색</button>
            <a href="/bos/member/user/list_lock.do?menuNo=${param.menuNo}" class="pure-button b-reset">초기화</a>
        </div>
    </fieldset>
    <!-- 게시판 게시물검색 end -->

    <div class="cont">
        <div class="board_top">
            <span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt}</strong>건</span>
            <div style="float: right;">
                <p>
                    <select id="pageSelect" name="pageSelect">
                        <option value="10" ${paramVO.pageUnit eq '10' ? 'selected' : '' }>10개</option>
                        <option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
                        <option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
                        <option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
                        <option value="0" ${paramVO.pageUnit eq '999999' ? 'selected' : '' }>전체</option>
                    </select>
                </p>
            </div>
        </div>
    </div>

    <!-- board list start -->
    <div style="clear:both; width:100%;">
        <table id="jqlblList" style="width:100%;" class="table table-striped table-hover">
            <caption>사용자 입사정보</caption>
            <thead>
                <tr>
                    <th scope="col">센터이름</th>
                    <th scope="col">사용자</th>
                    <th scope="col">아이디 </th>
                    <th scope="col">연락처</th>
                    <th scope="col">잠김날짜</th>
                    <th>LOCK</th>
                    <th>잠금 해제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td>${result.centerCodeName}</td>  
                        <td>${result.userName}</td>
                        <td>${result.userId}</td>
                        <td>${result.userPhone}</td>
                        <td><fmt:formatDate var="lockDate" value="${result.lockDate}" pattern="YYYY-MM-dd"/>${lockDate}</td>  
                        <td><fmt:formatNumber type="number" value="${result.loginFailCount}"/>회</td>
                        <td><button type="button" id="unlockUser" onclick="javascript:unlockUserFun('${result.userId}','${result.userName }');">잠금 해제</button></td>
                    </tr>
                    <c:set var="totalLockCnt" value="${totalLockCnt-1}" />
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
                    <tr>
                        <td colspan="7">데이터가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <!-- board list end //-->
</form>

<c:if test="${fn:length(resultList) > 0}">
    ${pageNav}
</c:if>