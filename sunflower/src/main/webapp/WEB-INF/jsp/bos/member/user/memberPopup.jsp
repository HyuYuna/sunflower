<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script>
//<![CDATA[

var objUserSn = "${param.objUserSn}";
var objUserNm = "${param.objUserNm}";
var objMbtlnum = "${param.objMbtlnum}";
var objEmail = "${param.objEmail}";

$(function() {

	$("#mbtlnum").mask("999-999?9-9999").on("change", function() {
	    var last = $(this).val().substr( $(this).val().lastIndexOf("-") + 1 );

	    if( last.length == 3 ) {
	        var move = $(this).val().substr( $(this).val().lastIndexOf("-") - 1, 1 );
	        var lastfour = move + last;
	        var first = $(this).val().substr( 0, 7 ); // Change 9 to 8 if you prefer mask without space: (99)9999?9-9999

	        $(this).val( first + '-' + lastfour );
	    }
	});

	$("#confirmBtn").on('click',function() {
		if ($("#memList").find("input[name=userSn]:checked").length == 0) {
			alert("회원을 선택해 주세요.");
			return false;
		}

		var $userSn = $("#memList").find("input[name=userSn]:checked");
		var userSn = $userSn.val();
		var userNm = $userSn.closest("tr").find("td.userNm").text();
		var mbtlnum = $userSn.closest("tr").find("td.mbtlnum").text();
		var email = $userSn.closest("tr").find("td.email").text();

		$("#"+objUserSn, opener.document).val(userSn);
		$("#"+objUserNm, opener.document).val(userNm);
		$("#"+objMbtlnum, opener.document).val(mbtlnum);
		$("#"+objEmail, opener.document).val(email);


		window.close();
		return false;
	});
});
//]]>
</script>

<div class="row">
	<div class="col-md-12">
    	<h1>회원 찾기</h1>
        <div class="panel panel-default">
			<div class="panel-body">
			<form action="/bos/member/user/memberPopup.do" name="memPopForm" id="memPopForm" method="get">
				<input type="hidden" name="csrfToken" value="${csrfToken}"/>
				<input type="hidden" name="viewType" value="${param.viewType }" />

				<input type="hidden" name="objUserSn" value="${param.objUserSn }" />
				<input type="hidden" name="objUserNm" value="${param.objUserNm }" />
				<input type="hidden" name="objMbtlnum" value="${param.objMbtlnum }" />
				<input type="hidden" name="objEmail" value="${param.objEmail }" />
				<fieldset>
					<legend>회원 찾기</legend>
						<div class="bdView mb0">
							<table class="table table-bordered">
								<caption>회원 찾기</caption>
								<colgroup>
								<col />
								<col />
								<col />
								<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="userId">아이디</label></th>
										<td><input type="text" name="userId" id="userId" value="${param.userId }" /></td>
										<th scope="row"><label for="USEN">회원명</label></th>
										<td><input type="text" name="userNm" id="userNm" value="${param.userNm }" /></td>
									</tr>
									<tr>
										<th scope="row" ><label for="mbtlnum">휴대전화</label></th>
										<td><input type="text" name="mbtlnum" id="mbtlnum" value="${param.mbtlnum }" /></td>
										<th scope="row" ><label for="email">이메일</label></th>
										<td><input type="text" name="email" id="email" value="${param.email }" /></td>
									</tr>
								</tbody>
							</table>
						</div>
				</fieldset>

				<div class="btnSet tar"><input type="submit" class="btn btn-primary" value="검색" /></div>
			</form>
			</div>
		</div>
	    <div class="panel panel-default">
			<div class="panel-body">
				<div class="bdList">
				<table class="table table-bordered">
					<caption>

					</caption>
					<colgroup>
					<col />
					<col />
					<col />
					<col />
					<col />
					</colgroup>
					<thead>
						<tr>
							<th scope="row" >선택</th>
							<th scope="row" >아이디</th>
							<th scope="row" >회원명</th>
							<th scope="row" >휴대전화</th>
							<th scope="row" >이메일</th>
						</tr>
					</thead>
					<tbody id="memList">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="tac userSn"><input type="radio" name="userSn" value="${result.userSn}" /></td>
							<td class="userId">${result.userId}</td>
							<td class="tac userNm">${result.userNm}</td>
							<td class="mbtlnum">${result.mbtlnum}</td>
							<td class="email">${result.email}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}" >
						<tr><td colspan="5">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				</div>


				<c:if test="${fn:length(resultList) > 0}">
				<div class="paging">
					${pageNav}
				</div>
				</c:if>



				<div class="btnSet"><a href="#self" class="btn btn-primary" id="confirmBtn">확인</a></div>


	        </div>
	    </div>
	</div>
</div>


