<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate var="now" value="${toDay }" pattern="yyyy-MM-dd HH:mm"/>
<fmt:parseDate var="nowTime" value="${now }" pattern="yyyy-MM-dd HH:mm"/>
<fmt:parseNumber var="nowTimeN" value="${nowTime.time }" integerOnly="true"/>

<c:if test="${empty param.titlei && empty param.namei && empty param.contenti }">
	<c:set var="searchi" value="emptyi"/>
</c:if>

<script type="text/javascript">
	$(function() {
		$("#pageSelect").change(function() {
			var pageUnit = $(this).val();
			var frm = $("#frm")[0];
			
			$.ajax({
					url: "/bos/bbs/${paramVO.bbsId}/pageUnitChange.json",
					type: "get",
					data: {pageUnit : pageUnit},
					success: function(data) {
						$("#pageUnit").val(pageUnit);
						
						frm.submit();
					}
			});
		});
		
		$(".pure-button").click(function(event) {
			event.preventDefault();
		});

		$('.txtDateFormat').numeric({allow : "-"}).mask("9999-99-99");

		//########################## Method ##########################
		var article = {
			setMessage : function(messageString) { //@ 에러 메세지 삽입
				alert(messageString);
			},
			goWritePate : function() {
				var params = "${pageQueryString}";
				var reqUrl = "/bos/bbs/${paramVO.bbsId}/forInsert.do?" + params;
				
				location.href= reqUrl;
			},
			goViewPate : function(boIdx) {
				$('#txtIsNormalcy').val('true');
				var params = "${pageQueryString}";
				var reqUrl = '/bos/bbs/${paramVO.bbsId}/view.do?' + params + '&boidx=' + boIdx ;
				
				location.href= reqUrl;
			},
			searchList : function(boIdx) {
				$("#frm").submit();
			},
			setPassworldSend : function() { // @ 일반 텍스트 정보 보내기
				var strPassworldCheck = $("#strPassworldCheck").val();
			
				if (strPassworldCheck == "") {
					article.setMessage("비밀번호를 적어주세요!");
					$('#strPassworldCheck').focus();
					return false;
				}
				
				var boidx = $("#boidx").val();
				
				$.ajax({
					url : "/bos/bbs/${paramVO.bbsId}/pwCheck.json",
					type : "post",
					data : { "boidx" : boIdx, "strPassworldCheck" : strPassworldCheck },
					async : false,
					success : function(data) {
						if (data.srtIsSuccess == "true") {
							article.goViewPate(boIdx);
						} else {
							article.setMessage("비밀번호가 일치하지 않습니다!");
							return false;
						}
					}
				});
			}

		}

		//########################## Click Event ##########################

		$('#btnInsert').click(function() {
			article.goWritePate();
		});

		$('.btnView').click(function() {
			var boIdx = $(this).attr('id').replace('btnView_', '');
			var boIsSecret = $(this).attr('title');

			if (boIsSecret == "secret") {
				$('#boidx').val(boIdx);
				$('#viwPasswordCheck').show();
				$('#strPassworldCheck').focus();
			} else {
				article.goViewPate(boIdx);
			}
		});

		$('#btnPassworldCheck').click(function() {
			article.setPassworldSend();
		});

		$('#strPassworldCheck').keyup(function(e) {
			if (e.keyCode == 13) {
				article.setPassworldSend();
			}
		});

		$('#btnPassworldCheckCancel').click(function() {
			$("#viwPasswordCheck").hide();
			$("#strPassworldCheck").val('');
		});

		$('#boSoIdxi').change(function() {
			article.searchList();
		});

		$('#listNum').change(function() {
			article.searchList();
		});

		$('#btnBoardSearch').click(function() {

			var startDatei = $('#startDatei').val();
			var endDatei = $('#endDatei').val();
			if (startDatei != '' || endDatei != '') {
				if (startDatei == '') {
					alert('등록 시작일은 필수 입력사항 입니다!');
					$('#startDatei').focus();
					return false;
				}
				if (endDatei == '') {
					alert('등록 마지막일은 필수 입력사항 입니다!');
					$('#endDatei').focus();
					return false;
				}
			}

			if ((startDatei == '' && endDatei == '')
					&& $('#findstr').val() == "") {
				article.setMessage("검색할 단어를 입력해 주세요!");
				$('#findstr').focus();
				return false;
			}
			
			if($("#titlei").is(":checked") == false
					&& $("#contenti").is(":checked") == false
					&& $("#namei").is(":checked") == false){
				article.setMessage("최소 한개 이상의 검색 조건을 지정해주세요!")
				$("#findstr").focus();
				return false;
			}
			article.searchList();
		});

		$('#findstr').keyup(
			function(e) {
				if (e.keyCode == 13) {
					var startDatei = $('#startDatei').val();
					var endDatei = $('#endDatei').val();
					if (startDatei != '' || endDatei != '') {
						if (startDatei == '') {
							alert('등록 시작일은 필수 입력사항 입니다!');
							$('#startDatei').focus();
							return false;
						}
						if (endDatei == '') {
							alert('등록 마지막일은 필수 입력사항 입니다!');
							$('#endDatei').focus();
							return false;
						}
					}

					if ((startDatei == '' && endDatei == '')
							&& $('#findstr').val() == "") {
						article
								.setMessage("검색할 단어를 입력해 주세요!");
						$('#findstr').focus();
						return false;
					}
					article.searchList();
				}
			});

		jQuery(".txtDate").datepicker({
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			defaultDate : "+1w",
			dateFormat : 'yy-mm-dd',
			prevText : '이전달',
			nextText : '다음달',
			changeMonth : true,
			changeYear : true
		});

		var dates = $("#startDatei, #endDatei").datepicker({
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			dateFormat : 'yy-mm-dd',
			prevText : '이전달',
			nextText : '다음달',
			//defaultDate: "+1w",
			changeMonth : true,
			changeYear : true,
			ampm : true,
			numberOfMonths : 1,
			onSelect : function(selectedDate) {
				var option = this.id == "startDatei" ? "minDate" : "maxDate", 
					instance = $(this).data("datepicker"), 
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
				dates.not(this).datepicker("option", option, date);
			}
		});
		
		$('.btnDeleteSearchDateRage').click(function() {
			$('#startDatei').val("");
			$('#endDatei').val("");
		});
	});
</script>

<form name = "normalcyFrm" id="normalcyFrm">
	<input type="hidden" name="txtIsNormalcy" id="txtIsNormalcy" > <!-- 비밀번호를 입력해서 view로 가지고 감 -->
</form>

<form name="frm" id="frm" method="post" class="pure-form">
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<input type="hidden" name="bbsId" value="${param.bbsId }"/>
	<input type="hidden" name="pageUnit" id="pageUnit"/>
	<input type="hidden" name="bid" id="bid" value="${param.bid }"/>
	<input type="hidden" name="userGroup" value="${userVO.userGroup}"/>
	<input type="hidden" name="task" value="ins">
	<input type="hidden" name="boidx" id="boidx" />
	<table class="table03" style="margin-top:-20px;">
		<colgroup>
			<col style="width:100px;" />
			<col style="" />
			<col style="width:100px;" />
			<col style="" />
			<col style="width:100px;" />
		</colgroup>
		<tr style="height:40px;">
			<th>기간</th>
			<td>
				<input type="text" name="startDatei" id="startDatei" class="txtDateFormat ac" value="${param.startDatei }" style="width:110px;" autocomplete="off"/>
				<span id="cond_spdate"> ~ </span>
				<input type="text" name="endDatei" id="endDatei" class="txtDateFormat ac" value="${param.endDatei }" style="width:110px;" autocomplete="off"/>
				<img class="btnDeleteSearchDateRage" src='/static/bos/image/icons/cross-th.png' alt="X" style="width:10px; height:10px;">
			</td>
			<c:if test="${(category.abcsubdivisionoptionisuse eq '1') && (1 eq 2)  }">
				<th>분류옵션</th>
				<td>
					<select name="bosoidxi" id="bosoidxi">
						<option value="">분류옵션 선택</option>
					</select>
			</c:if>
			<th>검색어</th>
			<td>
				<input type="checkbox" name="titlei" id="titlei" value="boTitle" ${searchi eq 'emptyi' || param.titlei eq 'boTitle' ? 'checked' : '' }><span id="txtTitleS">제목</span>
				<input type="checkbox" name="contenti" id="contenti" value="boContents" class="clear" ${param.contenti eq 'boContents' ? 'checked' : '' }><span id="txtContentS">내용</span>
				<input type="checkbox" name="namei" id="namei" value="boName" class="clear" ${param.namei eq 'boName' ? 'checked' : '' }><span id="txtNameS">이름</span>
				<input type="text" name="findstr" id="findstr"  value="${paramVO.findstr }" style="width:50%;"/>
			</td>
			<td>
				<button id="btnBoardSearch" class="pure-button btnSearch" style="height:30px;witdh:100%;">검색</button>
			</td>
		</tr>
	</table>
	<div class="board_top mt20">
		<span>결과: <strong class="f_blue">${resultCnt }</strong>건</span>
		<p>
			<select id="pageSelect" name="pageSelect">
				<option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
				<option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
				<option value="40" ${paramVO.pageUnit eq '40' ? 'selected' : '' }>40개</option>
			</select>
		</p>
	</div>
</form>
	<table cellpadding="0" cellspacing="0" border="0" class="boardList mt20">
		<colgroup>
			<col width="50px">
			<col width="">
			<col width="50px">
			<col width="100px">
			<col width="100px">
			<col width="60px">
		</colgroup>
		<thead>
			<tr>
				<th id="txtNo" scope="col" class="front">번호</th>
				<th id="txtTitle" scope="col">제 목</th>
				<th id="txtFile" scope="col">파일</th>
				<th id="txtName" scope="col">작성자</th>
				<th id="txtDate" scope="col">등록일</th>
				<th id="txtHit" scope="col" class="back">조회</th>
			</tr>
		</thead>
		<tbody>
				<c:set var="pQueryStr">
					<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
				</c:set>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:choose>
						<c:when test="${paramVO.goViewChk eq 'Y' }">
							<c:choose>
								<c:when test="${paramVO.goViewChkAuth eq '본인' }">
									<c:if test="${userVO.userId eq result.boid }">
										<c:set var="isAlert" value="Y"/>
									</c:if>
									<c:if test="${userVO.userId ne result.boid }">
										<c:set var="isAlert" value="N"/>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${result.boissecret eq '1' }">
										<c:if test="${userVO.userId eq result.boid }">
											<c:set var="isAlert" value="N"/>
										</c:if>
										<c:if test="${userVO.userId ne result.boid }">
											<c:set var="isAlert" value="S"/>
										</c:if>
									</c:if>
									<c:if test="${result.boissecret ne '1' }">
										<c:set var="isAlert" value="N"/>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:if test="${userVO.userId eq result.boid }">
								<c:set var="isAlert" value="N"/>
							</c:if>
							<c:if test="${userVO.userId ne result.boid }">
								<c:set var="isAlert" value="Y"/>
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${isAlert eq 'Y' }">
						<tr class="<c:if test='${result.nttType eq "1" }'>notice </c:if>btnView" style="cursor:pointer" onclick="javascript:alert('${paramVO.alertMsg}');" >
					</c:if>
					<c:if test="${isAlert ne 'Y' }">
						<tr class="<c:if test='${result.nttType eq "1" }'>notice </c:if>btnView" style="cursor:pointer" id="btnView_<fmt:parseNumber integerOnly='true' value='${result.boidx }'/>" >
					</c:if>
						<td>
							<c:if test="${result.nttType eq '1' }"><img src='/static/bos/image/ico_notice.gif' ></c:if>
							<c:if test="${result.nttType ne '1' }">
								<c:out value="${(resultCnt) - (paramVO.pageUnit * (paramVO.pageIndex-1))}" />
							</c:if>
						</td>
						<c:if test="${result.boissecret eq '1' }">
							<c:set var="boIsSecret" value="<img src='/static/bos/image/ico_lock.gif' align='middle'>&nbsp;"/>
						</c:if>
						<fmt:formatDate var="bdDate" value="${result.bocreatedate }" pattern="yyyy-MM-dd HH:mm"/>
						<fmt:parseDate var="bdDateTime" value="${bdDate }" pattern="yyyy-MM-dd HH:mm"/>
						<fmt:parseNumber var="bdDateN" value="${bdDateTime.time }" integerOnly="true" />
						<c:if test="${((nowTimeN - bdDateN) / (60 * 60 * 1000)) < 72}">
							<c:set var="newImg" value="<img src='/static/bos/image/ico_new.gif' align='absmiddle'>"/>
						</c:if>
						<c:if test="${category.abcmemoisuse eq '1' && result.nttType ne '1' }">
							<c:set var="cmCnt" value="<span style='color:#22AD36'>(<strong style='margin-right:0px;'>${result.cmcount}</strong>)</span>"/>
						</c:if>
						<td class="al" style="padding-left:10px;">
							${boIsSecret}${result.botitle}&nbsp;${cmCnt }&nbsp;${newImg }
						</td>
						<td>
							<c:if test="${not empty result.bfextention }">
								<img src="/static/bos/image/fileIcon/${fn:toLowerCase(result.bfextention) }.gif" border='0' align='absmiddle'>
							</c:if>
						</td>
						<td>${result.boname}</td>
						<td><fmt:formatDate value="${result.bocreatedate}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:parseNumber integerOnly="true" value="${result.boreadnumber}"/></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
					<c:set var="boIsSecret" value=""/>
					<c:set var="cmCnt" value=""/>
					<c:set var="newImg" value=""/>
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="6">등록된 게시물이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	
<div class="mt20 ar">
	<c:if test="${paramVO.goWriteChk eq 'Y' }">
		<button id="btnInsert" class="pure-button pure-button-list" style="height:36px;"><span class="f-bold">글쓰기</span></a></button>
	</c:if>
</div>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

<!-- layer pop -->
<div class="layer_pop" id="viwPasswordCheck" style="display:none;">
	<div>
		<strong>비밀번호 확인</strong>
		<p><span>비밀번호</span><input type="password" name="strPassworldCheck" id="strPassworldCheck" /></p>
		<span><img style="cursor:pointer;" src="/bbs/images/btn_layerpop_ok.gif" alt="확인" id="btnPassworldCheck" /></span>
		<span><img style="cursor:pointer;" src="/bbs/images/btn_layerpop_cancel.gif" id="btnPassworldCheckCancel" alt="취소" /></span>
	</div>
</div>
<!-- //layer pop -->