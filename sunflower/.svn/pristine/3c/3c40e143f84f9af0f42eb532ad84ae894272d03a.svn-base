<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<link rel="stylesheet" type="text/css" href="/static/jslibrary/jsdifflib-master/diffview.css"/>
<link rel="stylesheet" type="text/css" href="/static/jslibrary/jsdifflib-master/diffout.css"/>
<script type="text/javascript" src="/static/jslibrary/jsdifflib-master/diffview.js"></script>
<script type="text/javascript" src="/static/jslibrary/jsdifflib-master/difflib.js"></script>
<script type="text/javascript" src="/static/jslibrary/jsdifflib-master/diffout.js"></script>

<form id="compareForm" name="compareForm" enctype="multipart/form-data" action="/bos/singl/contents/update.do" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="sMenuNo" id="sMenuNo" value="${paramVO.sMenuNo}"/>
<div class="fr">
<button type="button" class="b- btn-success" id="opener"><i class="fa fa-code" aria-hidden="true"></i>콘텐츠 버젼 선택</button>
</div>
<div id="dialog" title="버젼선택">
  <div style="padding: 15px;">
  	<div class="row">
  		<div class="col-xs-8">
  			<div>
  				원본콘텐츠
  				<select name="orgCntntsMnno" id="orgCntntsMnno">
					<c:forEach var="item" items="${resultList}" varStatus="status">
  					<option value="${item.cntntsMnno}">Ver.${item.cntntsMnno}</option>
  					</c:forEach>
  				</select>
  			</div>
  			<div class="mt5">
  				수정콘텐츠
  				<select name="modCntntsMnno" id="modCntntsMnno">
					<c:forEach var="item" items="${resultList}" varStatus="status">
  					<option value="${item.cntntsMnno}">Ver.${item.cntntsMnno}</option>
  					</c:forEach>
  				</select>
  			</div>
  		</div>
  		<div class="col-xs-4">
  			<div><button type="button" class="b- btn-success" id="compareBtn"><i class="fa fa-code" aria-hidden="true"></i> 적용</button></div>
  			<div class="mt5"><button type="button" class="b-cancel" id="cancelBtn">닫기</button></div>
  		</div>
  	</div>
  </div>
</div>
<script>
$( function() {
  $( "#dialog" ).dialog({
    autoOpen: false
  });
  $( "#opener" ).on( "click", function() {
    $( "#dialog" ).dialog( "open" );
  });
  $( "#cancelBtn" ).on( "click", function() {
    $( "#dialog" ).dialog( "close" );
  });
  $('#orgDownBtn').hide();
  $('#modDownBtn').hide();

  $('#compareBtn').on( "click", function() {
		$.post(
			"/bos/singl/contents/compare.json",
			{sMenuNo:$('#sMenuNo').val(), orgCntntsMnno:$('#orgCntntsMnno').val(), modCntntsMnno:$('#modCntntsMnno').val()},
			function(data) {
				var orgUptDt = '';
				var orgUptId = '';
				if (!data.orgVal.updtDt) {
					orgUptDt = data.orgVal.registDt;
				}
				else {
					orgUptDt = data.orgVal.updtDt;
				}
				if (!data.orgVal.updtId) {
					orgUptId = data.orgVal.registId;
				}
				else {
					orgUptId = data.orgVal.updtId;
				}
				var orgDt = new Date(orgUptDt);
				var modUptDt = '';
				var modUptId = '';
				if (!data.modVal.updtDt) {
					modUptDt = data.modVal.registDt;
				}
				else {
					modUptDt = data.modVal.updtDt;
				}
				if (!data.modVal.updtId) {
					modUptId = data.modVal.registId;
				}
				else {
					modUptId = data.modVal.updtId;
				}
				var modDt = new Date(modUptDt);
				$('#orgVer').html('Ver.' + data.orgVal.cntntsMnno);
				$('#orgUpt').html(formatDate(orgDt) + '(' + orgUptId + ')');
				$('#modVer').html('Ver.' + data.modVal.cntntsMnno);
				$('#modUpt').html(formatDate(modDt) + '(' + modUptId + ')');
				$('#orgCntntsCn').val(data.orgVal.cntntsCn);
				$('#modCntntsCn').val(data.modVal.cntntsCn);

				$('#orgDownBtn').on('click',function(){
					location.href = '/bos/singl/contents/downloadContents.do?cntntsMnno=' + data.orgVal.cntntsMnno + '&sMenuNo=' + $('#sMenuNo').val();
				});
				$('#orgDownBtn').show();
				$('#modDownBtn').on('click',function(){
					location.href = '/bos/singl/contents/downloadContents.do?cntntsMnno=' + data.modVal.cntntsMnno + '&sMenuNo=' + $('#sMenuNo').val();
				});
				$('#modDownBtn').show();
			},"json"
		);
// 		$( "#dialog" ).dialog( "close" );
  });

} );

function formatDate(d) {
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}
</script>


<table class="table table-bordered">
	<tr>
		<th colspan="8" style="font-size: 18px"> 콘텐츠 제목 </th>
	</tr>
	<tr>
		<td colspan="4" width="400">원본    콘텐츠</td>
		<td colspan="4" width="405">수정콘텐츠</td>
	</tr>
	<tr>
		<td width="64">버전</td>
		<td width="81"><span id="orgVer"/></td>
		<td width="103">최종수정일(작성자)</td>
		<td width="152"><span id="orgUpt"/></td>
		<td width="79">버전</td>
		<td width="73"><span id="modVer"/></td>
		<td width="107">최종수정일(작성자)</td>
		<td width="147"><span id="modUpt"/></td>
	</tr>
	<tr>
		<td colspan="4">
				<textarea id="orgCntntsCn" name="orgCntntsCn" style="height: 450px" id="orgCntntsCn" cols="30" rows="10" class="w100p"></textarea>
		</td>
		<td colspan="4">
				<textarea id="modCntntsCn" name="modCntntsCn" style="height: 450px" id="modCntntsCn" cols="30" rows="10" class="w100p"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4"><button id="orgDownBtn" type="button" class="w100p b-view">다운로드</button></td>
		<td colspan="4"><button id="modDownBtn" type="button" class="w100p b-view">다운로드</button></td>
	</tr>
</table>

<h1 class="top">콘텐츠 버전 비교결과</h1>
<div class="viewType">
	<button type="button" class="b-view" onclick="diffUsingJS(0);">비교결과보기 (분리 페이지)</button>
	&nbsp; &nbsp;
	<button type="button" class="b-view" onclick="diffUsingJS(1);">비교결과보기 (한페이지)</button>
</div>
<div id="diffoutput"> </div>
<input type="hidden" id="contextSize" value="" />

<div class="btnSet">
	<a href="javascript:self.close();" class="b-reg">닫기</a>
</div>
</form>