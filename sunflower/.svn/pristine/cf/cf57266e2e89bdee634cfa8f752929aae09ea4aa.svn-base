<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

		<!-- footer -->
		<div class="bannerZone">
			<div class="bannerArea">
				<div class="area">
				<c:if test="${fn:length(bannerList) > 0 }">
				<ul>${bannerList}
					<c:forEach var="banner" items="${bannerList }" varStatus="status">
					<li>
						<a href="${banner.bnrUrl }" target="_blank" title="${banner.bnrNm } 새창열림">
							<img src="/cmm/fms/imageSrc.do?fileStreCours=<util:seedEncrypt str='${banner.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${banner.streFileNm}'/>" alt="${banner.bnrNm }" />
						</a>
					</li>
					</c:forEach>

				</ul>
				</c:if>
				</div>
				<div class="ctrl">
					<button type="button" class="BZleft"><span>배너존 이전보기</span></button>
					<button type="button" class="BZright"><span>배너존 다음보기</span></button>
					<button type="button" class="BZstop"><span>배너존 정지</span></button>
					<button type="button" class="BZplay"><span>배너존 재생</span></button>
				</div>
			</div>
		</div>
			<script>
			jQuery(function($){
				var banRolling = $(".bannerZone .area ul");
				var stopBtn = $('.BZstop');
                var playBtn = $('.BZplay');
                playBtn.hide();
				$(banRolling).carouFredSel({
				    responsive  : true,
				    scroll: 1,
				    items   : {
				      width   : 160,
				      height   : 60,
				      visible   : {
				        min     : 1,
				        max     : 5
				      }
				    },
					prev:{
						button : '.BZleft',
						wipe : true, //로테이션 허용(리스트 처음에서 클릭시 마지막요소로 이동)
						pauseOnHover:false
					},
					next: {
						button :'.BZright',
						wipe : true,
						pauseOnHover:false
					},
					direction	: "left"
				  });
					stopBtn.on('click',function() {
						$(banRolling).trigger("pause", true);
						$(this).hide();
						$(playBtn).show();
						return false;
					})
					playBtn.on('click',function() {
						$(banRolling).trigger("play");
						$(this).hide();
						$(stopBtn).show();
						return false;
					});
			})

		</script>


		<div class="footerSet" >
			<div class="footer" id="footer">
			<span class="mobile_top"><a href="#container"><img src="/static/img/gongu/common/mobileTop.png" alt="위로 이동" /></a></span>
				<div class="footerCon">
					<ul>
						<!-- <li><a href="">온라인도움말</a></li> -->
						<li><a href="/gongu/main/contents.do?menuNo=200058">이용약관</a></li>
						<li><a href="http://www.copyright.or.kr/customer-center/user-guide/privacy-policy/index.do" target="_blank" title="새창열림">개인정보처리방침</a></li>
						<!-- <li><a href="/gongu/bbs/B0000002/list.do?menuNo=200042">FAQ</a></li> -->
						<li><a href="/gongu/main/contents.do?menuNo=200043">Q&amp;A</a></li>
						<li><a href="/gongu/main/contents.do?menuNo=200044">고객의소리</a></li>
						<li><a href="/gongu/newsletter/newsletter/forInsertNewsletter.do?menuNo=200152">뉴스레터 신청하기</a></li>
					</ul>
					<p>본 웹사이트는 이메일 주소가 무단 수집되는 것을 거부하며, 위반 시 정보통신망 법에 의해<br />처벌됨을 유념하시기 바랍니다.</p>
					<div class="mobile tac">
						<sec:authorize access="!hasRole('ROLE_USERKEY')">
							<a href="/gongu/member/user/forLogin.do?menuNo=200053"><strong>로그인</strong>  </a> |
							<a href="/gongu/member/user/join01.do?menuNo=200052"><strong>회원가입</strong>  </a>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_USERKEY')">
							<a href="/gongu/member/user/logout.do"><strong>로그아웃(${userVO.userNm })</strong> </a>
							<!--  | <a href="/gongu/member/user/forUpdate.do?menuNo=200120"><strong>마이페이지</strong> </a>  -->
						</sec:authorize>

						<!-- | <a href=""><strong> PC버전</strong></a> -->
					</div>
					<address>
						<p>(52852) 경상남도 진주시 충의로 19 1/5층 한국저작권위원회 / 저작권상담센터 : 1800-5455</p>
						<span>Copyrightⓒ Korea Copyright Commission </span>Some rights reserved.
					</address>
					<div class="footerBanner">
						<a href="http://www.copyright.or.kr/" target="_blank" title="새창열림" ><img src="/static/img/gongu/common/foot_img1.png" alt="한국저작권위원회"></a>
						<a href="/static/img/gongu/common/img_gsc_crtfct.jpg" onclick="window.open(this.href,'name','width=430,height=603,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false;" target="_blank"><img src="/static/img/gongu/common/foot_img2.png"  alt="우수컨텐츠서비스"></a>
						<a href="/static/img/gongu/common/img_waqc_mark.jpg" onclick="window.open(this.href,'name','width=450,height=620,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no');return false;" target="_blank"><img src="/static/img/gongu/common/foot_img3.png" alt="미래창조과학부 WEB ACCESSIBILITY 마크(웹 접근성 품질인증 마크)"></a>

						<!-- <a href=""><img src="/static/img/gongu/common/foot_img3.png" alt=""></a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- //footer -->

