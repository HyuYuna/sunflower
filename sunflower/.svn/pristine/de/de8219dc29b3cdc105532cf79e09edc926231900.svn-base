package site.unp.cms.service.cmmn.impl;

import javax.annotation.Resource;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.cmmn.CmmnMngrService;
import site.unp.cms.service.singl.MngrService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
	pageQueryData="menuNo,sdate,edate,searchCnd,searchWrd,viewType",
	listQueryId="findAllMngr",
	countQueryId="countMngr",
	viewQueryId="findOneMngr",
	updateQueryId="updateMngr",
	sqlDaoRef="mngrDAO",
	listenerAndMethods={
		"userInitParamListener=updateMy",
	}
)
@Service
public class CmmnMngrServiceImpl extends DefaultCrudServiceImpl implements CmmnMngrService {

	@Resource(name="passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;

	@Resource(name="mngrService")
	private MngrService mngrService;

	public static final String USER_SE = "A";

	/**
	 * 공통 관리자팝업 선택
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listPop(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}

	/**
	 * 괸라자 공통 내정보수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="관리자 내정보수정 관리", linkType=LinkType.BOS)
	public void forUpdateMy(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		super.forUpdate(paramCtx);
	}

	/**
	 * 관리자 공통 내정보수정 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateMy(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		String pwdNew = param.getString("pwdNew");
		if(StringUtils.hasText(pwdNew) && param.getString("pwdChange").equals("1")){
			param.put("password", passwordEncoder.encodePassword(pwdNew, salt));
		}

		sqlDao.modify("updateMngrMy", param);
		// TM_USER_SALT 테이블에 SALT값 삭제후 등록

		if(StringUtils.hasText(pwdNew) && param.getString("pwdChange").equals("1")){
			param.put("userSe", USER_SE);
			param.put("userSn", user.getUserSn());
			param.put("userNm", user.getUserNm());
			param.put("salt", salt);
			sqlDao.deleteOne("deleteMemberSaltInfo", param);
			sqlDao.save("saveMemberSalfInfo", param);
		}

		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "javascript:history.back();");
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 수정되었습니다.");
		model.addAttribute(ModelAndViewResolver.WINDOW_MODE, WIN_CLOSE_WINDOW_MODE);
	}

	/**
	 * 비밀번호 금지단어 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void checkPrhibtWrd(ParameterContext paramCtx) throws Exception {
		mngrService.checkPrhibtWrd(paramCtx);
	}

}