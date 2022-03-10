package site.unp.cms.listener.bbs;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;

/**
 * 관리자만 접근할 수 있는 게시판 체크
 * @author khd
 *
 */
@Component
public class CheckBbsListener extends CommonListenerSupport {
	
	@Resource(name="SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Override
	public void before(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String bbsId = param.getString("bbsId");
		String siteId = param.getString("siteId");
		
		MemberVO memberVO = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if(memberVO != null) {
			param.put("userId", memberVO.getUserId());
			param.put("authorCd", memberVO.getAuthorCd());
			param.put("userGroup", memberVO.getUserGroup());
		}
		
		String sUserMemberTypeName = "";
		switch (memberVO.getUserGroup()) {
		case "OP01":
			sUserMemberTypeName = "관리자";
			break;
		case "OP04":
			sUserMemberTypeName = "중앙지원단"; //한국여성인권진흥원
			break;
		case "OP05":
			sUserMemberTypeName = "소장";
			break;
		case "OP07":
			sUserMemberTypeName = "부소장";
			break;
		case "OP06":
			sUserMemberTypeName = "행정직군";
			break;
		case "OP08":
			sUserMemberTypeName = "간호직군";
			break;
		case "OP09":
			sUserMemberTypeName = "상담직군";
			break;
		case "OP10":
			sUserMemberTypeName = "심리직군";
			break;
		case "OP12":
			sUserMemberTypeName = "심리직군";
			break;
		case "OP14":
			sUserMemberTypeName = "심리직군";
			break;
		case "OP22":
			sUserMemberTypeName = "동행직군";
			break;
		case "OP11":
			sUserMemberTypeName = "경찰직군";
			break;
		}
		
		param.put("sUserMemberTypeName", sUserMemberTypeName);
		
		//메뉴 다 볼 수 있음
		boolean txtReadAuth = false;
		if(memberVO.getUserGroup().equals("OP05") || memberVO.getUserGroup().equals("OP07")){
			txtReadAuth = true;
		}
		
		//게시판 최고 권한
		boolean sAdminAuth = false;
		if(memberVO.getUserGroup().equals("OP01") || memberVO.getUserGroup().equals("OP04") || memberVO.getAuthorCd().equals("ROLE_SUPER") || memberVO.getUserGroup().equals("OP21")){ //★OP21 삭제★
			sAdminAuth = true;
			
			String sUserAdminName;
			if(memberVO.getUserGroup().equals("OP01")){
				sUserAdminName = "관리자";
			} else {
				sUserAdminName = "한국여성인권진흥원";
			}
			
			param.put("sAdminAuth", "Y");
			param.put("sUserAdminName", sUserAdminName);
		}
		
		if(bbsId.equals("B0000001")){
			param.put("bid", "bid_7");
		} else if(bbsId.equals("B0000003")){
			param.put("bid", "bid_11");
		} else if(bbsId.equals("B0000004")){
			param.put("bid", "bid_12");
		} else if(bbsId.equals("B0000005")){
			param.put("bid", "bid_8");
		} else if(bbsId.equals("B0000022")){
			param.put("bid", "bid_1");
		} else if(bbsId.equals("B0000023")){
			param.put("bid", "bid_2");
		} else if(bbsId.equals("B0000024")){
			param.put("bid", "bid_3");
		} else if(bbsId.equals("B0000025")){
			param.put("bid", "bid_4");
		} else if(bbsId.equals("B0000026")){
			param.put("bid", "bid_5");
		} else if(bbsId.equals("B0000027")){
			param.put("bid", "bid_6");
		}
		
		/* 게시판 접근 */
		if (SiteInfoService.BOS_SITE_ID.equals(siteId)) {
			if(!sAdminAuth && !txtReadAuth){
				switch (param.getString("bid")) {
				case "bid_1":
					if(!"OP09".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "상담직군이 아니군요! 잘못된 접근입니다!");
					}
					break;
				case "bid_2":
					if(!"OP08".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "잘못된 접근입니다!");
					}
					break;
				case "bid_3":
					if(!"OP10".equals(param.getString("userGroup")) && !"OP12".equals(param.getString("userGroup")) && !"OP14".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "잘못된 접근입니다!");
					}
					break;
				case "bid_4":
					if(!"OP06".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "잘못된 접근입니다!");
					}
					break;
				case "bid_5":
					if(!"OP22".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "잘못된 접근입니다!");
					}
					break;
				case "bid_6":
					if(!"OP07".equals(param.getString("userGroup"))){
						HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "잘못된 접근입니다!");
					}
					break;
				}
			}
		}
		
		ZValue category = sqlDAO.findOne("bidCategory", param);
		
		String txtMyAuthorityKindTxt = "/관리자, 한국여성인권진흥원/중간관리자/직군/센터관리자, 센터당담자";
		
		if(sUserMemberTypeName.length() == 0){
			sUserMemberTypeName = "소장";
		}
		
		List<ZValue> authIndex = sqlDAO.findAll("authIndex", param);
		
		int intAuthIndex = 0;
		String authorityKind = "";
		for(int i=0; i<authIndex.size(); i++){
			authorityKind = authorityKind + "/" + authIndex.get(i).getString("cmname2");
			intAuthIndex++;
		}
		
		String myAuthorityKind = txtMyAuthorityKindTxt + "/비회원/본인";
		authorityKind = authorityKind + "/" + (intAuthIndex+1) + "/" + (intAuthIndex+2);
		
		String[] var_authorityKind = authorityKind.split("/");
		String[] authorityKindTxt = myAuthorityKind.split("/");

		String sUserAuthority = "";
		String msgName = "";
		
		if(param.getString("sUserMemberTypeName").length() != 0){
			ZValue userAuthority = sqlDAO.findOne("userAuthority", param);
			sUserAuthority = userAuthority.getString("cmname2");
			msgName = userAuthority.getString("cmtitle");
		} else if(memberVO.getAuthorCd().equals("ROLE_SUPER") || memberVO.getUserGroup().equals("OP21")){ //★OP21 삭제★
			sUserAuthority = "1";
			msgName = "관리자";
		} else {
			if(param.getString("bid").equals("bid_7") || param.getString("bid").equals("bid_11")){
				sUserAuthority = "10";
				msgName = "경찰직군";
			}
		}
		
		String txtAlertMsg = "";
		////////////////// 보기권한 //////////////////
		int var_authorityKind_Me_Index = intAuthIndex+2;
		
		String goViewChk = "N";
		String goViewChkAuth = "";
		String alertMsg = "";
		
		if(category.getString("abcviewauthority").equals(var_authorityKind_Me_Index)){
			goViewChk = "Y";
			alertMsg = "본인만 접근할 수 있습니다.";
			goViewChkAuth = "본인";
			
		} else {
			for(int i=1; i<=intAuthIndex; i++){
				if(category.getString("abcviewauthority").equals(var_authorityKind[i])){
					if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
						goViewChk = "Y";
					} else {
						goViewChk = "N";
						if(i == 1){
							txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
						} else if (i == intAuthIndex){
							txtAlertMsg = "로그인 후 접근해주세요!";
						} else {
							txtAlertMsg = authorityKindTxt[i] + "이상 접근할 수 있습니다!";
						}
						txtAlertMsg = "접근 권한이 없습니다!";
						alertMsg = txtAlertMsg;
					}
				}
			}
			
			if(category.getString("abcviewauthority").equals(var_authorityKind[intAuthIndex+1])){
				goViewChk = "Y";
			}
		}
		
		param.put("goViewChk", goViewChk);
		param.put("goViewChkAuth",goViewChkAuth);
		param.put("alertMsg",alertMsg);
		
		////////////////// 쓰기권한 //////////////////
		
		String goWriteChk = "N";
		String alertWriteMsg = "";
		
		for(int i=1; i<=intAuthIndex; i++){
			if(category.getString("abccreateauthority").equals(var_authorityKind[i])){
				if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
					goWriteChk = "Y";
				} else {
					goWriteChk = "N";
					if(i == 1){
						txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
					} else if (i == intAuthIndex){
						txtAlertMsg = "로그인 후 접근해주세요!";
					} else {
					}
					txtAlertMsg = "접근 권한이 없습니다!";
					alertWriteMsg = txtAlertMsg;
				}
			}
		}
		if(category.getString("abccreateauthority").equals(var_authorityKind[intAuthIndex+1])){
			goWriteChk = "Y";
		}
		
		param.put("goWriteChk", goWriteChk);
		param.put("alertWriteMsg",alertWriteMsg);
		
		////////////////// 삭제권한 //////////////////
		var_authorityKind_Me_Index = intAuthIndex + 2;
		
		String goDeleteChk = "N";
		String goDeleteChkAuth = "";
		String alertDeleteMsg = "";
		String isPassword = "N";
		
		if(category.getString("abcdeleteauthoryty").equals(var_authorityKind[var_authorityKind_Me_Index])){
			if(sAdminAuth){
				goDeleteChk = "Y";
			} else {
				goDeleteChk = "Y";
				alertDeleteMsg = "본인 및 관리자만 접근할 수 있습니다.";
			}
			
			goDeleteChkAuth = "본인";
		} else {
			for(int i=1; i<=intAuthIndex; i++){
				if(category.getString("abcdeleteauthoryty").equals(var_authorityKind[i])){
					if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
						goDeleteChk = "Y";
					} else {
						goDeleteChk = "N";
						if(i == 1){
							txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
						} else if(i == intAuthIndex){
							txtAlertMsg = "로그인 후 접근해주세요!";
						} else {
							txtAlertMsg = authorityKindTxt[i] + "이상 접근할 수 있습니다!";
						}
						
						txtAlertMsg = "접근 권한이 없습니다!";
						alertDeleteMsg = txtAlertMsg;
					}
				}
			}
			if(category.getString("abcdeleteauthoryty").equals(var_authorityKind[intAuthIndex+1])){
				goDeleteChk = "Y";
				isPassword = "Y";
			}
		}
		
		param.put("goDeleteChk", goDeleteChk);
		param.put("goDeleteChkAuth", goDeleteChkAuth);
		param.put("alertDeleteMsg", alertDeleteMsg);
		param.put("isPassword", isPassword);
		
		////////////////// 다운로드 권한 //////////////////
		
		String goDownloadChk = "N";
		String alertDownloadMsg = "";
		for(int i=1; i<=intAuthIndex; i++){
			if(category.getString("abcdownloadauthoryty").equals(var_authorityKind[i])){
				if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
					goDownloadChk = "Y";
				} else {
					goDownloadChk = "N";
					if(i == 1){
						txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
					} else if(i == intAuthIndex) {
						txtAlertMsg = "로그인 후 접근해주세요!";
					} else {
						txtAlertMsg = "접근 권한이 없습니다!";
						alertDownloadMsg = txtAlertMsg;
					}
				}
			}
		}
		if(category.getString("abcdownloadauthoryty").equals(var_authorityKind[intAuthIndex+1])){
			goDownloadChk = "Y";
		}
		
		param.put("goDownloadChk", goDownloadChk);
		param.put("alertDownloadMsg", alertDownloadMsg);
		
		////////////////// 답변권한 //////////////////
		
		String goReplyChk = "N";
		String alertReplyMsg = "";
		
		for(int i=1; i<=intAuthIndex; i++){
			if(category.getString("abcreplyauthority").equals(var_authorityKind[i])){
				if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
					goReplyChk = "Y";
				} else {
					goReplyChk = "N";
					if(i == 1){
						txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
					} else if(i == intAuthIndex) {
						txtAlertMsg = "로그인 후 접근해주세요!";
					} else {
						txtAlertMsg = "접근 권한이 없습니다!";
					}
				}
			}
		}
		if(category.getString("abcreplyauthority").equals(var_authorityKind[intAuthIndex+1])){
			goReplyChk = "Y";
		}
		
		param.put("goReplyChk", goReplyChk);
		param.put("alertReplyMsg", alertReplyMsg);
		
		////////////////// 수정권한 //////////////////
		
		String goModifyChk = "N";
		
		if(sAdminAuth) {
			goModifyChk = "Y";
		} else {
			goModifyChk = "N";
		}
		
		param.put("goModifyChk", goModifyChk);
		
		////////////////// 댓글권한 //////////////////
		
		String goCommentChk = "N";
		String alertCommentMsg = "";
		
		for(int i=1; i<=intAuthIndex; i++){
			if(category.getString("abcmemoauthority").equals(var_authorityKind[i])){
				if(Integer.parseInt(sUserAuthority) <= Integer.parseInt(var_authorityKind[i])){
					goCommentChk = "Y";
				} else {
					goCommentChk = "N";
					if(i == 1){
						txtAlertMsg = authorityKindTxt[i] + "만 접근할 수 있습니다!";
					} else if(i == intAuthIndex) {
						txtAlertMsg = "로그인 후 접근해주세요!";
					} else {
						txtAlertMsg = "접근 권한이 없습니다!";
					}
				}
			}
		}
		if(category.getString("abcmemoauthority").equals(var_authorityKind[intAuthIndex+1])){
			goCommentChk = "Y";
		}
		
		param.put("goCommentChk", goCommentChk);		
		param.put("alertCommentMsg", alertCommentMsg);
	}
}
