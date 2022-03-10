<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/attrb/insert.do?menuNo=${param.menuNo}" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/attrb/update.do?menuNo=${param.menuNo}" />
</c:if>

<script>
	$(function(){
		$(".up,.down").on('click',function(){
			var row = $(this).parents("tr:first");
			if ($(this).is(".up")) {
				row.insertBefore(row.prev());
			} else {
				row.insertAfter(row.next());
			}
			return false;
		});
	});

	function dataChk(attrbDc, maxLen, remLen){
		var maxLen = 800;
	  if (attrbDc.value.length > 800) {
	   alert(800 + "자까지만 입력해 주세요");
	   attrbDc.value = attrbDc.value.substring(maxLen);
	   attrbDc.focus();
	   return;
	  }
	  remLen.value = maxLen - parseInt(attrbDc.value.length);
	 }

	function checkForm()
	{
		var form = document.board;
		var v = new MiyaValidator(form);
	    v.add("tableNm", {
	        required: true
	    });
	    v.add("attrbNm", {
	        required: true
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		form.submit();
	}

	function pop()
	{
		var form = document.board2;
		if(form.pageType.value == ''){
			alert('페이지타입을 선택하세요.');
			form.pageType.focus();
			return;
		}
		var PopWindow = "pop_win";
		var win = window.open( "",
		     PopWindow,
		     "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=920,height=900,left=50,top=50"
		);
		form.target = PopWindow;
		form.method = "get";
		form.action = "/bos/bbs/attrb/selectAllFieldList.do";
		form.submit();

	}

	function sort(){
		var form = document.board3;
		if(document.board2.pageType.value == ''){
			alert('페이지타입을 선택하세요.');
			document.board2.pageType.focus();
			return;
		}
		form.pageType.value = document.board2.pageType.value;
		form.action = "/bos/bbs/attrb/sortFieldAttr.do?menuNo=${param.menuNo}";
		form.submit();
	}

	function createPage(){
		var form = document.board2;
		if(getCheckedCount(document.board2.siteNames)==0){
			alert('사이트를 선택하세요.');
			document.board2.siteNames[0].focus();
			return;
		}

		if(document.board2.pageType.value == ''){
			alert('페이지 타입을 선택하세요.');
			document.board2.pageType.focus();
			return;
		}


		if( confirm("기존파일이 생성된경우 덮어씌웁니다. 생성하시겠습니까?") ){
			form.action = "/bos/bbs/attrb/createPage.do?menuNo=${param.menuNo}";
			form.submit();
		}
	}

    function getCheckedCount( aElem ) {
        var cnt = 0;
        for ( var i=0; i<aElem.length; i++ ) {
         if ( aElem[i].checked==true ) cnt = cnt + 1;
        }
        return cnt;
       }


	function search(){
		var form = document.board2;
		form.action = "/bos/bbs/attrb/view.do?menuNo=${param.menuNo}";
		form.submit();javascript:checkForm();
	}
</script>
<form id="board" name="board" method="post" action="${action}">
	<input type="hidden" name="attrbCd" value="${result.attrbCd}"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="bdView">
	<table>
		<caption>게시판 쓰기</caption>
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
		<c:if test="${not empty result}">
			<tr>
				<th scope="row"><label for="attrbCd">게시판속성코드</label></th>
				<td>
					${result.attrbCd}
				</td>
			</tr>
		</c:if>
			<tr>
				<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="tableNm">테이블명</label></th>
				<td>
					<select id="tableNm" name="tableNm" class="select">
						<option value='' label="테이블선택" />
						<c:forEach var="item" items="${tableList}" varStatus="status">
							<option value="${item}" ${item eq result.tableNm ? 'selected="selected"' : ''}>${item}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span><label for="attrbNm">게시판속성명</label></th>
				<td>
					<input type="text" name="attrbNm" id="attrbNm" class="w100p" value="${result.attrbNm}" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="attrbDc">게시판속성상세</label></th>
				<td>
			      	<textarea rows="5" cols="50" id="attrbDc" name="attrbDc" style="height:150px" onkeyup="javascript:dataChk(this,800,this.form.remLen);">${result.attrbDc}</textarea>
			      	<div class="mt5">
			      		<input type="text" name="remLen" id="remLen" value="800" class="tac" style="width:50px;" readonly="readonly" /> 자 남음
			      	</div>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</form>

<div class="btnSet">
<c:choose>
<c:when test="${empty result}" >
	<a href="javascript:checkForm();" class="b-reg">등록</a>
</c:when>
<c:otherwise>
	<a href="javascript:checkForm();" class="b-edit">수정</a>
	<a href="/bos/bbs/attrb/deletePageAttr.do?attrbCd=${result.attrbCd}&menuNo=${param.menuNo}"  class="b-del" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
</c:otherwise>
</c:choose>
	<a href="/bos/bbs/attrb/list.do?attrbCd=${result.attrbCd}&menuNo=${param.menuNo}" class="b-list">목록</a>
</div>



<%--
<c:if test="${not empty result}">


	<div class="hgroup">
		<h3 >필드속성</h3>
	</div>

	<!-- 게시판 게시물검색 start -->
<form id="board2" name="board2" method="post" action="/bos/pg/sortFieldAttr.do">
	<legend>게시물검색</legend>
	<input type="hidden" name="pageCode" value="${result.pageCode}"/>
	<input type="hidden" name="bbsId" value="${param.bbsId}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<div class="sh">
		<fieldset>
			<label for="pageType" class="blind">페이지타입</label>
			<c:if test="${not empty fieldAttributes and not empty fieldAttributes[0]}"><c:set var="pageType" value="${fieldAttributes[0].pageType}"/></c:if>
			<select id="pageType" name="pageType" title="검색조건">
			   <option value="">페이지타입선택</option>
			   <option value="bbsNews" <c:if test="${pageType == 'bbsNews'}">selected="selected"</c:if> >공지형(목록,뷰,등록)</option>
			   <option value="bbsPhoto" <c:if test="${pageType == 'bbsPhoto'}">selected="selected"</c:if> >포토형(목록,뷰,등록)</option>
			   <option value="bbsList" <c:if test="${pageType == 'bbsList'}">selected="selected"</c:if> >리스트형(목록)</option>
			   <option value="bbsRead" <c:if test="${pageType == 'bbsRead'}">selected="selected"</c:if> >일반등록형(목록,뷰,등록)</option>
			   <option value="bbsPhotoList" <c:if test="${pageType == 'bbsPhotoList'}">selected="selected"</c:if> >포토리스트형(목록,뷰,등록)</option>
			   <option value="bbsReRead" <c:if test="${pageType == 'bbsReRead'}">selected="selected"</c:if> >답변등록형(목록,뷰,등록,답변)</option>
			</select>
			<label for="input2">
				<a href="javascript:search();" class="b-sh">검색</a>
			</label>
		</fieldset>
		<div>
				사이트명
				<c:forEach var="site" items="${siteList}" varStatus="status">
					<label>
						<input type="checkbox" id="siteNmes${status.count}" name="siteNames" value="${site.siteName}" />
						${site.siteDesc}
					</label>
					<c:if test="${status.count % 5 == 0}"><br/></c:if>
				</c:forEach>
		</div>
	</div>

</form>
	<!-- 게시판 게시물검색 end -->

		<!-- board list start -->

<form id="board3" name="board3" method="post" action="/bos/pg/readPage.do">
	<input type="hidden" name="pageCode" value="${result.pageCode}"/>
	<input type="hidden" name="pageType" value=""/>
	<input type="hidden" name="bbsId" value="${param.bbsId}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="10%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="12%" />
				<col width="14%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">페이지타입</th>
					<th scope="col">필드명</th>
					<th scope="col">필드텍스트</th>
					<th scope="col">필드타입</th>
					<th scope="col">리스트노출</th>
					<th scope="col">정렬</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="field" items="${fieldAttributes}" varStatus="status">
				<tr>
					<td>${fn:length(fieldAttributes) - status.count + 1}</td>
					<td>${field.pageType}</td>
					<td>${field.fieldName}<input type="hidden" name="fieldName" value="${field.fieldName}"/></td>
					<td>${field.fieldText}<input type="hidden" name="fieldText" value="${field.fieldText}"/></td>
					<td>${field.fieldType}<input type="hidden" name="fieldType" value="${field.fieldType}"/></td>
					<td>${field.fieldList eq 'Y' ? 'Y' :'' }<input type="hidden" name="fieldList" value="${field.fieldList}"/></td>
					<td>
						<input type="button" value="위로" class="up btn btn-xs" />
						<input type="button" value="아래로" class="down btn btn-xs" />
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(fieldAttributes) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
</form>

		<!-- board list end //-->
	<div class="btnSet">
		<a href="javascript:checkForm();" class="btn btn-primary">수정</a>
		<a href="/bos/pg/deletePageAttr.do?pageCode=${result.pageCode}"  class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
		<a href="/bos/pg/pageAttrList.do?menuNo=${param.menuNo }" class="btn btn-primary">목록</a>
		<a href="javascript:pop();"  class="btn btn-primary">필드속성팝업</a>
		<!--
		<a href="javascript:sort();"  class="btn btn-primary">정렬</a>
		-->
		<!--
		<a href="javascript:createPage();"  class="btn btn-info">페이지생성</a>
		 -->
	</div>
</c:if>
<!--
	<div class="dbList">
		<ul>
			<li>* 게시판 속성관리는 개발기간을 단축하기 위해 일반적인 게시판을 프로그램(jsp)을 생성해 주는 것이다.</li>
			<li>* 실재 운영하려는 게시판의 유형에 따라 변경해 사용하도록 한다.</li>
			<li>* 페이지 생성할 경우 이미 소스가 있다면 날짜 백업 후 생성한다.</li>
			<li>* 같은 유형의 게시판은 "게시판정보관리"에서 게시판을 생성해 주면 된다.</li>
		</ul>
	</div>
 -->
 --%>
