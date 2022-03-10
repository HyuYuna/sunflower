<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script>
	var mode = "${empty result ? 'I' : 'M'}";
	var checkIdCount = 0;

	$(function() {
		$("#chkIdBtn").on('click',function() {
			var userId = $("#userId").val();
			var pattern = /^[a-z0-9]{6,14}$/;

			if( !userId ) {
				alert("아이디를 입력해 주세요.");
				$("#userId")[0].focus();
				return;
			} else if (!pattern.test(userId)) {
				alert("6자~14자 이하 영문 소문자,숫자 조합으로 입력가능 합니다.");
				return;
			}
			$.getJSON(
				"/bos/singl/mngr/checkId.json",
				{userId : userId},
				function(data) {
					if(data.cnt > 0){
						alert("사용하실 수 없는 아이디입니다.");
						$("#userId").val("");
						checkIdCount = 0;
						return;
					} else {
						// 금지단어 체크
						$.getJSON(
							"/bos/singl/mngr/checkPrhibtWrd.json",
							{chkWord : userId, wrdSe : "1"},
							function(data) {
								if(data.chkWord == "Y"){
									alert("아이디에 ["+ data.word +"] 는(은) 사용하실 수 없는 단어입니다.");
									$("#userId").val("");
									checkIdCount = 0;
									return;
								} else {
									alert("사용가능한 아이디입니다.");
									checkIdCount++;
									return;
								}
							}
						);
					}
				}
			);
		});

		$("#pwdChange").on('click',function() {
			if (this.checked) {
				$("#pwdNew").prop("disabled", false);
				$("#pwdNew2").prop("disabled", false);
			} else {
				$("#pwdNew").val("");
				$("#pwdNew2").val("");
				$("#pwdNew").prop("disabled", true);
				$("#pwdNew2").prop("disabled", true);
			}
		});
	});

	function pwdCheck(pwdNew) {
	    var SamePass_0 = 0; //동일문자 카운트
	    var SamePass_1 = 0; //연속성(+) 카운트
	    var SamePass_2 = 0; //연속성(-) 카운트

	    var chr_pass_0;
	    var chr_pass_1;
	    var chr_pass_2;

	    for(var i=0; i < pwdNew.value.length; i++) {
	        chr_pass_0 = pwdNew.value.charAt(i);
	        chr_pass_1 = pwdNew.value.charAt(i+1);

	        //동일문자 카운트
	        if(chr_pass_0 == chr_pass_1) {
	            SamePass_0 = SamePass_0 + 1;
	        }
	        chr_pass_2 = pwdNew.value.charAt(i+2);

	        //연속성(+) 카운드
	        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
	            SamePass_1 = SamePass_1 + 1;
	        }

	        //연속성(-) 카운드
	        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
	            SamePass_2 = SamePass_2 + 1;
	        }
	    }
	    if(SamePass_0 > 1) {
	        alert("동일문자를 3번 이상 사용할 수 없습니다.");
	        return false;
	    }

	    if(SamePass_1 > 1 || SamePass_2 > 1 ) {
	        alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
	        return false;
	    }
	    return true;
	}

	function checkForm() {
		var form = document.f_regi;
		var pwdNew = form.pwdNew;
		var v = new MiyaValidator(form);

		if(mode == "I") {
		    v.add("userId", {
		        required: true
		    });
		}
		if( mode == "I" ) {
		    v.add("pwdNew", {
		        required: true
		    });
		}
		if (form.pwdNew.value) {
			/*
		    v.add("pwdNew", {
		    	pattern: /^.*(?=.{9,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[?!@#$%^&*]).*$/,
		    	message: "비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 \n3개 이상의 조합으로 입력해주세요.",
		        required: true
		    });
		     */
		    v.add("pwdNew2", {
		        required: true
		    });
		    v.add("pwdNew", {
		        match: "pwdNew2",
		        label: "비밀번호",
		        message: "비밀번호가 일치하지 않습니다."
		    });
		}
	    v.add("userNm", {
	        required: true
	    });
/* 	    v.add("deptKorNm", {
	        required: true
	    }); */
	    v.add("userCpno1", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "handphone"
	    });
	    v.add("userEmad1", {
	        required: true,
			span: 2,
			glue: "@",
			option: "email"
	    });
	   	/*
	   	v.add("sttusCd", {
	        required: true
	    });
	   	*/

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if ($("#authListDiv > input").length == 0) {
		    alert('1개이상의 권한을 추가해 주시기 바랍니다.');
		    return;
		}

		if(mode == "I" && checkIdCount == 0) {
			alert("아이디 중복체크를 하셔야 합니다.");
			return;
		}

		if (form.pwdNew.value) {
			if(!checkPrhibtWrd($("#pwdNew").val())){
				return;
			}
		}

		if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			form.submit();
		}
	}

	function checkPrhibtWrd(text){
		$.ajaxSetup({
			async: false
		});

		var flag = true;
		$.post(
			"/bos/singl/mngr/checkPrhibtWrd.json",
			{chkWord : text, wrdSe : "2"},
			function(data) {
				if(data.chkWord == "Y"){
					alert("비밀번호에 [" + data.word +"] 는(은) 사용하실 수 없는 단어입니다.");
					flag =  false;
				}else{
					flag = true;
				}
			},"json"
		);
		return flag;
	}


	function checkFormDel() {
		var form = document.f_regi;
		if (confirm('삭제 하시겠습니까?')) {
			form.action="/bos/singl/mngr/delete.do";
			form.submit();
		}
	}

	function initDept() {
		$("#deptKorNm").val("");
	}

	function selectDept() {
		window.open("/bos/cmmn/cmmnDeptInfo/listPop.do?viewType=BODY","deptPop","scrollbars=yes,width=800,height=600");
		return;
	}
</script>

<form name="f_regi" method="post" action="/bos/singl/mngr/${empty result ? 'insert' : 'update'}.do">
	<input type="hidden" name="userSn" value="${result.userSn }" />
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="bdView">
		<table>
			<caption>관리자 관리 정보입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th>
						<c:choose>
							<c:when test="${not empty result}">
								아이디
							</c:when>
							<c:otherwise>
				      			<label for="userId"><span class="req"><span>필수입력</span></span>아이디</label>
							</c:otherwise>
						</c:choose>

					</th>
					<td colspan="3">
						<c:choose>
							<c:when test="${not empty result}">
								${result.userId}<input type="hidden" name="userId" id="userId" value="${result.userId}" />
							</c:when>
							<c:otherwise>
				      			<input type="text" class="form-inline" name="userId" id="userId" title="아이디" value="${result.userId}" onchange="checkIdCount=0;">
				      			<button type="button" class="b-ok" id="chkIdBtn" name="chkIdBtn">중복확인</button>
							</c:otherwise>
						</c:choose>
					</td>

				</tr>
				<tr>
					<th><span class="req pwdReq" <c:if test="${not empty result }">style="display:none;"</c:if>><span>필수입력</span></span><label for="pwdNew">비밀번호</label></th>
					<td>
						<input type="password" name="pwdNew" id="pwdNew" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off" <c:if test="${not empty result}">disabled="disabled"</c:if>>
						<c:if test="${not empty result}">
							<label><input type="checkbox" name="pwdChange" id="pwdChange" value="1">비밀번호 변경</label>
						</c:if>
						<!--
						<span class="font_11px_orange_01"><br/>

						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합
						<br/>※ 최근 3개월 이내에 사용한 비밀번호는 사용할 수 없음
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)

						</span>
						 -->
						 <script>
						 	$("#pwdChange").on('click',function() {
						 		if ($(this).filter(":checked").length > 0) {
									$(".pwdReq").show();
						 		}
						 		else {
						 			$(".pwdReq").hide();
						 		}
						 	});
						 </script>
					</td>
					<th><span class="req pwdReq" <c:if test="${not empty result }">style="display:none;"</c:if>><span>필수입력</span></span><label for="pwdNew2">비밀번호확인</label></th>
					<td><input type="password" name="pwdNew2" id="pwdNew2" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호확인" autocomplete="off" <c:if test="${not empty result}">disabled="disabled"</c:if>></td>
				</tr>
				<tr>
					<th><label for="userNm"><span class="req"><span>필수입력</span></span>이름</label></th>
					<td>
						<input type="text" name="userNm" id="userNm" value="${result.userNm}" class="span12" />
					</td>

					<th><label for="deptKorNm">부서명</label></th>
					<td>
						<input type="text" name="deptKorNm" id="deptKorNm" value="${result.deptKorNm}" readonly="readonly" />
						<input type="hidden" name="deptId" id="deptId" value="${result.deptId }">
						<button type="button" class="b-select" onclick="selectDept()" title="새창열림">선택</button>
						<button type="button" class="b-reset" onclick="initDept()">초기화</button>
					</td>

				</tr>
				<tr>
					<th><label for="userCpno1"><span class="req"><span>필수입력</span></span>휴대전화</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.userCpno,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="userCpno1" id="userCpno1" title="휴대전화 앞3자리 선택" class="input_select">
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
									<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
									<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
									<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
									<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
									<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
								</select>
								-
								<input type="text" id="userCpno2" name="userCpno2" value="${data[1]}" class="tel" title="휴대전화 중간3~4자리" maxlength="4" />
								-
								<input type="text" id="userCpno3" name="userCpno3" value="${data[2]}" class="tel" title="휴대전화 끝4자리" maxlength="4" />
							</c:when>
							<c:otherwise>
								<select name="userCpno1" id="userCpno1" title="휴대전화 앞3자리 선택" class="input_select" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								-
								<input type="text" value="" id="userCpno2" name="userCpno2" class="tel" title="휴대전화 중간3~4자리" maxlength="4"/>
								-
								<input type="text" value="" id="userCpno3" name="userCpno3" class="tel" title="휴대전화 끝4자리" maxlength="4"/>
							</c:otherwise>
						</c:choose>
					</td>
					<th><label for="seatNo">내선번호</label></th>
					<td>
						<input type="text" name="seatNo" id="seatNo" value="${result.seatNo}" style="width:100px" maxlength="11"/>
					</td>
				</tr>
				<tr>
					<th><label for="userEmad1"><span class="req"><span>필수입력</span></span>이메일</label></th>
					<td colspan="3">
						<c:set var="data" value="${fn:split(result.userEmad,'@')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 2}">
								<input name="userEmad1" id="userEmad1" type="text" title="이메일 아이디" value="${data[0]}" class="email_id"/>
								@
								<input name="userEmad2" type="text" title="이메일 도메인" value="${data[1]}" class="email_addr"/>
							</c:when>
							<c:otherwise>
								<input name="userEmad1" id="userEmad1" type="text" title="이메일 아이디" value="" class="email_id"/>
								@
								<input name="userEmad2" type="text" title="이메일 도메인" value="" class="email_addr"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="addAuthorCd"><span class="req"><span>필수입력</span></span>권한</label></th>
					<td colspan="3">
						<% // ROLE_SUPER 권한을 주려면 파라미터 뒤에 flag=SUPER 추가 ex)/bos/singl/mngr/forUpdate.do?userId=admin011&menuNo=100064&flag=SUPER %>
						<select id="addAuthorCd" name="addAuthorCd">
						    <option value="">권한 선택</option>
							<c:forEach var="author" items="${authorList}" varStatus="status">
								<c:if test="${(param.flag eq 'SUPER') or (param.flag ne 'SUPER' and author.authorCd ne 'ROLE_SUPER')}"><option value="${author.authorCd}">${author.authorNm}</option></c:if>
							</c:forEach>
						</select>
						<button class="b-add" id="addAuthBtn">권한추가</button>
						<div id="authListDiv">
							<c:forEach var="myAuthVO" items="${myAuthList}" varStatus="status">
							<button type="button" class="b-default delAuthBtn"><span class="txt">${myAuthVO.authorNm } </span><span class="b-del btn-xs"><span class="sr-only">삭제</span></span></button>
							<input type="hidden" name="authorCd" value="${myAuthVO.authorCd }" />
							<input type="hidden" name="authorFlag" value="M" />
							</c:forEach>
						</div>

						<script>
							$("#addAuthBtn").on('click',function() {
								if ($("#addAuthorCd").val() == "") {
									alert("권한을 선택해 주세요.");
									return false;
								}

								var ingFlag = true;
								$("#authListDiv").find("input").each(function(n) {
									if($(this).val() == $("#addAuthorCd").val()) {
										if ($(this).next("input").val()=="D"){
											$(this).next("input").val("M");
											$(this).prev("button").show();
											ingFlag = false;
											return false;
										} else {
											alert("권한이 이미 추가되었습니다.");
											ingFlag = false;
											return false;
										}
									}
								});

								if (!ingFlag) return false;

								var $div = $("#authListDiv");
								var $button = $("<button>").addClass("b-default delAuthBtn");
								var $authNmSpan = $("<span>").addClass("txt").text($("#addAuthorCd").find("option:selected").text()+ " ");
								var $span = $("<span>").addClass("b-del btn-xs");
								var $innerSpan = $("<span>").text("삭제").addClass("sr-only");
								var $inputHidden = $("<input>").attr({"type" : "hidden", "name" : "authorCd", "value" : $("#addAuthorCd").val()});
								var $inputHidden2 = $("<input>").attr({"type" : "hidden", "name" : "authorFlag", "value" : "I"});
								$authNmSpan.appendTo($button);
								$innerSpan.appendTo($span);
								$span.appendTo($button);
								$button.appendTo($div);
								$inputHidden.appendTo($div);
								$inputHidden2.appendTo($div);

								$("#addAuthorCd").val("");
								btnclassSetting();
								return false;
							});


							$("#authListDiv").on("click",".delAuthBtn",function() {
								if ($(this).closest("button").next("input").next("input").val()=="I"){
									$(this).closest("button").next("input").next("input").remove();
									$(this).closest("button").next("input").remove();
									$(this).closest("button").remove();
								} else {
									$(this).closest("button").next("input").next("input").val('D');
									$(this).closest("button").hide();
									return false;
								}
							});
						</script>

						<p class="help">권한추가 버튼을 이용하여 셀레트박스에 선택된 권한을 추가 하실 수 있습니다.</p>
					</td>
				</tr>

				<tr>
					<th><label for="sttusCd"><span class="req"><span>필수입력</span></span>상태</label></th>
					<td colspan="3">
						<select id="sttusCd" name="sttusCd">
							<option value="">상태 선택</option>
							<c:forEach var="code" items="${sttusCdCodeList}" varStatus="status">
				  	 			<option value="${code.cd}" <c:if test="${result.sttusCd eq code.cd}">selected="selected"</c:if>>${code.cdNm}</option>
					 		</c:forEach>
				 		</select>
					</td>
				</tr>


			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<a class="b-edit" href="javascript:checkForm();"><span>${empty result ? '등록' : '수정'}</span></a>
	<c:if test="${not empty result}">
		<a class="b-del" href="javascript:checkFormDel();"><span>삭제</span></a>
	</c:if>
	<a class="b-cancel" href="/bos/singl/mngr/list.do?menuNo=${param.menuNo}"><span>취소</span></a>
	<!-- <a class="b-cancel" onclick="history.back(-2);"><span>취소</span></a> -->
</div>
