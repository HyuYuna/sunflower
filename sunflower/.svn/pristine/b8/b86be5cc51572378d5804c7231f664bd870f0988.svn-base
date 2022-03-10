<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">
function linkPage(pageNo){
 $("#pageIndex").attr("value",pageNo);
}
$(document).ready(function() {
 
 $('.paging').find('a').click(function(event) {
  event.preventDefault(); // location.href 작동방지
     var pagingId = $(event.target).parent().attr('id');
     var exhId = pagingId.split("_")[1]+"_"+pagingId.split("_")[2];
     var param = "pageIndex="+$("#pageIndex").val()+"&exhId="+exhId+"&companyVO="+$("#companyVO_"+exhId).val();
     $.ajax({
     url:  "/exhibit/storyCompanyList.do",
     type: "POST",
     data:  param,
     dataType: "html",
     success: function(data) {
      $("#tab_content_"+exhId+"_2").empty();
      $("#tab_content_"+exhId+"_2").html(data);
    },
    error:function(request,status,error){
       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
  });
 });

});
</script>

<form id="listForm" name="listForm" method="get">
 <input type="hidden" id="pageIndex" name="pageIndex"/>
</form>

<table class="board">
 <c:choose>
  <c:when
   test="${pageContext.request.serverName eq 'exhibition.hellot.net'}">
   <c:set var="hostName" value="http://www.chomdanmarket.com" />
  </c:when>
  <c:otherwise>
   <c:set var="hostName" value="http://carttest.hellot.net" />
  </c:otherwise>
 </c:choose>


 <table class="board">
  <colgroup>
   <col width="10%" />
   <col width="*" />
   <col width="10%" />
  </colgroup>
  <thead>
   <tr>
    <th>NO</th>
    <th>업체명</th>
    <th>첨단마켓</th>
   </tr>
  </thead>

  <tbody id="tab_body_${storyEventList.exhId }">
   <c:if test="${ empty companyList }">
    <tr>
     <td colspan="3" class="none" style="padding: 10px;"><img
      src="/images/re_conference/icon_cancel.gif" alt=""
      style="padding-right: 10px;"> 등록된 업체정보가 없습니다.</td>
    </tr>
   </c:if>
   <c:set var="listNum"
    value="${paginationInfo.totalRecordCount - ((companyVO.pageIndex - 1) * companyVO.recordCountPerPage)}" />
   <input type="hidden" id="companyVO_${companyVO.exhId }"
    value="${ companyVO }" />
   <c:forEach var="companyList" items="${companyList }">
    <tr class="view">
     <td>${listNum}</td>
     <td class="left"><a
      href="javascript:fncGoCompanyDetail('${companyList.mcompanyId}');">${companyList.companyNm}</a></td>
     <td><c:forEach var="marketCom" items="${marketComList}"
       varStatus="marketComStatus">
       <c:if test="${companyList.mcompanyId eq  marketCom.mCompanyId}">
        <a
         href="${hostName}/index.php?route=product/seller/info&seller_id=${marketCom.sellerId}"
         target="_blank"> <img
         src="/images/re_conference/btn_market_re.gif" alt="">
        </a>
       </c:if>
      </c:forEach></td>
    </tr>
    <c:set var="listNum" value="${listNum - 1}" />
   </c:forEach>
  </tbody>

 </table>

 <div class="paging" id="paging_${companyVO.exhId }">
  <ui:pagination paginationInfo='${paginationInfo}' type='text' jsFunction='linkPage' />
 </div>