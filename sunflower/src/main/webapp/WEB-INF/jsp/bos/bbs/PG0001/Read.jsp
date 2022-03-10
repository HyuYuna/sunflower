<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<script type="text/javascript">
	jQuery(document).ready(function() {

		$(".pure-button").click(function(event) {
			event.preventDefault();
		});

	//########################## Method ##########################
	var article = {

		setMessage : function(messageString) { //@ 에러 메세지 삽입
			alert(messageString);
		},
		goListPate : function() {
			var reqUrl = '/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}';
			
			location.href = reqUrl;
		},
		goUpdatePate : function() {
			var reqUrl = '/bos/bbs/${paramVO.bbsId}/forUpdate.do?';
			var boidx = $("#boidx").val();
			var bid = $("#bid").val();
			var params = "${pageQueryString}&boidx=" + boidx + "&bid=" + bid;

			location.href = reqUrl + params;
		},
		goDeletePate : function(boIdx) { // @ 일반 텍스트 정보 보내기
			msgjs = "정말로 삭제 하시겠습니까?";
			if (confirm(msgjs)) {
				var form = $("#frm")[0];
				form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
				form.submit();
			}
		},
		setPassworldSendUpdate : function() { // @ 일반 텍스트 정보 보내기		
			var strPassworldCheckUpdate = $("#strPassworldCheckUpdate").val();
			if (strPassworldCheckUpdate == "") {
				article.setMessage("비밀번호를 적어주세요!");
				$('#strPassworldCheckUpdate').focus();
				return false;
			}
			var boIdx = $('#boIdx').val();
			var params = {
				"boIdx" : boIdx,
				"strPassworldCheck" : strPassworldCheckUpdate
			}
			var reqUrl = '/bbs/userSite/passwordCheck.asp';
			var returnMsg = jQuery.parseJSON(jQuery.ajax({
				url : reqUrl,
				type : 'post',
				data : params,
				async : false
			}).responseText);
			if (returnMsg.srtIsSuccess == "true") {
				article.goUpdatePate();
			} else {
				article.setMessage("비밀번호가 일치하지 않습니다!");
				return false;
			}
		},
		setPassworldSendDel : function() { // @ 일반 텍스트 정보 보내기		
			var strPassworldCheckDel = $("#strPassworldCheckDel").val();
			if (strPassworldCheckDel == "") {
				article.setMessage("비밀번호를 적어주세요!");
				$('#strPassworldCheckDel').focus();
				return false;
			}
			var boIdx = $('#boIdx').val();
			var params = {
				"boIdx" : boIdx,
				"strPassworldCheck" : strPassworldCheckDel
			}
			var reqUrl = '/bbs/userSite/passwordCheck.asp';
			var returnMsg = jQuery.parseJSON(jQuery.ajax({
				url : reqUrl,
				type : 'post',
				data : params,
				async : false
			}).responseText);
			if (returnMsg.srtIsSuccess == "true") {
				article.goDeletePate(boIdx);
			} else {
				article.setMessage("비밀번호가 일치하지 않습니다!");
				return false;
			}
		}
	}

		//########################## Click Event ##########################

		$('#btnUpdate').click(
				function() {
					var abcPasswordIsUse = $(
							'#abcPasswordIsUse').val();
					if (abcPasswordIsUse == "1") { // 비밀번호가 있을 경우
						$('#updatePasswordCheck').show();
						$('#strPassworldCheckUpdate').focus();
					} else {
						article.goUpdatePate();
					}
				});

		$('#btnDelete').click(
				function() {
					var abcPasswordIsUse = $('#abcPasswordIsUse').val();
					if (abcPasswordIsUse == "1") { // 비밀번호가 있을 경우
						$('#delPasswordCheck').show();
						$('#strPassworldCheckDel').focus();
					} else {
						var boIdx = $('#boidx').val();
						article.goDeletePate(boIdx);
					}
				});

		$('.btnDownLoad').click(function() {
			msgjs = "파일을 다운로드 받으시겠습니까?";
			if (confirm(msgjs)) {
				var txtUrl = $(this).attr('id');
				document.location.href = txtUrl;
				return false;
			}
		});
		
		$('.btnZip').click(function() {
			msgjs = "압축파일을 다운로드 받으시겠습니까?";
			
			if(confirm(msgjs)){
				var txtUrl = $(this).attr('id');
				document.location.href = txtUrl;
				return false;
			}
		});

		$('#btnList').click(function() {
			article.goListPate();
		});

		$('#btnPassworldCheckUpdate').click(function() {
			article.setPassworldSendUpdate();
		});

		$('#strPassworldCheckUpdate').keyup(function(e) {
			if (e.keyCode == 13) {
				article.setPassworldSendUpdate();
			}
		});

		$('#btnPassworldCheckCancelUpdate').click(function() {
			$("#updatePasswordCheck").hide();
			$("#strPassworldCheckUpdate").val('');
		});

		$('#btnPassworldCheckDel').click(function() {
			article.setPassworldSendDel();
		});

		$('#strPassworldCheckDel').keyup(function(e) {
			if (e.keyCode == 13) {
				article.setPassworldSendDel();
			}
		});

		$('#btnPassworldCheckCancelDel').click(function() {
			$("#delPasswordCheck").hide();
			$("#strPassworldCheckDel").val('');
		});
	});
</script>

<input type="hidden" id="abcpasswordisuse" value="${category.abcpasswordisuse }"/>

<form id="frm" name="frm" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="boidx" id="boidx" value="<fmt:parseNumber integerOnly='true' value='${empty result.boidx ? 0 : result.boidx }' />" />
	<input type="hidden" name="bid" id="bid" value="${paramVO.bid}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	
	<table cellpadding="0" cellspacing="0" border=0 class="boardView">
		<caption>게시물 조회</caption>
		<colgroup>
			<col width="1%"/>
			<col width="11%"/>
			<col width="44%"/>
			<col width="12%"/>
			<col width="31%"/>
			<col width="1%"/>
		</colgroup>
		<thead>
			<tr>
				<th class="front"> </th>
				<th>제목</th>
				<th colspan="3" class="al">${result.botitle }</th>
				<th class="back"> </th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th></th>
				<th>글쓴이</th>
				<td class="al">${result.boname }</td>
				<th>글번호</th>
				<td class="al"><fmt:parseNumber integerOnly="true" value="${result.boidx }"/></td>
				<td></td>
			</tr>
			<tr>
				<th></th>
				<th>등록일</th>
				<td class="al"><fmt:formatDate value="${result.bocreatedate }" pattern="yyyy-MM-dd HH:mm"/></td>
				<th>조회수</th>
				<td class="al"><fmt:parseNumber integerOnly="true" value="${result.boreadnumber }"/></td>
			</tr>
			<tr>
				<td colspan="6" class="txt"><util:out escapeXml="false" >${result.bocontents}</util:out></td>
			</tr>
			<c:if test="${fn:length(files) > 0 }">
				<tr>
					<td style="padding:8px;text-align:left" colspan="6">
						<b>첨부파일</b>
						<span id="txtCount">${fn:length(files) }개</span>
						<a href="" class="pure-button btnDownload btnZip" id="/bos/cmmn/file/zipBbsFileDown.do?bfboidx=${result.boidx}&bid=${paramVO.bid}"><span>다운로드</span></a>
					</td>
				</tr>
				<tr>
					<td style="padding-left:30px;padding-top:8px;padding-bottom:8px;line-height:180%;text-align:left" colspan="6">
						<c:forEach var="files" items="${files}" varStatus="status">
							<a href='#' class='btnDownLoad' id='/bos/cmmn/file/bfFileDown.do?menuNo=${param.menuNo}&bfidx=${files.bfidx }&bffilecode=${paramVO.bid }'>
								<img src="/static/bos/image/fileIcon/${fn:toLowerCase(files.bfextension) }.gif" border=0 align=absmiddle> ${files.bforiginalfilename } (${files.bffilesize }KB)
							</a>
							<br/>
						</c:forEach>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form>

<div class="btnGroup">
	<c:choose>
		<c:when test="${(paramVO.bid ne 'bid_7' && paramVO.goModifyChk eq 'Y') || (fn:length(result.boid) ne 0 && userVO.userId eq result.boid) || (userVO.authorCd eq 'ROLE_SUPER' || userVO.authorCd eq 'CA')}">
			<button id="btnUpdate" class="showHide_write pure-button pure-button-insert" style="height:33px;"><span class="f_bold">수정</span></button>
			<button id="btnDelete" class="pure-button pure-button-delete" style="height:33px;"><span class="f_bold">삭제</span></button>
		</c:when>
		<c:when test="${category.abcpasswordisuse eq '1' }">
			<button id="btnUpdate" class="showHide_write pure-button pure-button-insert" style="height:33px;"><span class="f_bold">수정</span></button>
			<button id="btnDelete" class="pure-button pure-button-delete" style="height:33px;"><span class="f_bold">삭제</span></button>
		</c:when>
	</c:choose>
	<button id="btnList" class="pure-button pure-button-list" style="height:33px;"><span class="f_bold">목록</span></button>
</div>

<c:if test="${masterVO.cmPosblAt eq 'Y' || categorey.abcmemoisuse eq '1'}">
	<c:import url="/${paramVO.siteId }/bbs/bbsCm/list.do?viewType=CONTBODY">
		<c:param name="abcmemoauthorityname" value="${category.abcmemoauthorityname }"/>
		<c:param name="bid" value="${result.boabcboardcode }" />
		<c:param name="bcboidx" value="${result.boidx }"/>
		<c:param name="goCommentChk" value="${paramVO.goCommentChk }"/>
		<c:param name="alertCommentMsg" value="${paramVO.alertCommentMsg }"/>
	</c:import>
</c:if>