package site.unp.cms.service.singl.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.crypto.CryptoARIA;
import site.unp.cms.service.singl.MngrService;
import site.unp.cms.service.sys.PrhibtWrdDicaryService;
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
	sqlDaoRef="mngrDAO",
	listenerAndMethods={
		"sttusCdListener=list,forInsert,forUpdate",
		"userInitParamListener=insert,update,delete,deptInsert,deptUpdate,deptDelete",
		"accessLogListener=insert,update,delete"
	}
)
@CommonServiceLink(desc="홈페이지 관리자 관리", linkType=LinkType.BOS)
@Service
public class MngrServiceImpl extends DefaultCrudServiceImpl implements MngrService {

	@Resource(name="passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;

	@Resource(name="prhibtWrdDicaryService")
	private PrhibtWrdDicaryService prhibtWrdDicaryService;
	
	@Resource(name = "cryptoARIA")
	private CryptoARIA cryptoARIA;

	public static final String USER_SE = "A";

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		model.addAttribute("authorList", sqlDao.findAll("findAllAuthList"));
		super.forInsert(paramCtx);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
		param = userInfoEncode(param);
		param.put("password", passwordEncoder.encodePassword(param.getString("pwdNew"), salt));

		super.insert(paramCtx);
		Object userKey = param.getString("userSn");

		long userSn = Long.parseLong(userKey.toString());

		// TM_USER_SALT 테이블에 SALT값 삭제후 등록
		param.put("userSe", USER_SE);
		param.put("userSn", userSn);
		param.put("userId", param.getString("userId"));
		param.put("userNm", param.getString("userNm"));
		param.put("salt", salt);
		sqlDao.deleteOne("deleteMemberSaltInfo", param);
		sqlDao.save("saveMemberSalfInfo", param);

		List<String> authorCdList = param.getList("authorCd");
		List<String> authorFlagList = param.getList("authorFlag");
		/**
		 * insert 화면으로 save만 수행
		 */
		for (int i=0; i < authorCdList.size(); i++) {
			String authorCd = authorCdList.get(i);
			String authorFlag = authorFlagList.get(i);
			/**
			 * 사용자에 권한 등록
			 */
			param.put("authorCd", authorCd);
			param.put("userTyCd", USER_SE); //'A'
			sqlDao.save("saveMngrAuth", param);


			/**
			 * 개인정보보호 - 권한지정, 변경 이력 기록
			 */
			param.put("registId", user.getUserId());
			param.put("userCpno", param.getString("userCpno1")+"-"+param.getString("userCpno2")+"-"+param.getString("userCpno3"));
			param.put("userEmad", param.getString("userEmad1")+"@"+param.getString("userEmad2"));
			param.put("sttusCd", authorFlag);
			param.put("sttusSumry", authorCd + " 권한 부여");
			param.put("registId", user.getUserId());
			param.put("registIpad", paramCtx.getUserIp());
			sqlDao.save("saveMngrAuthorHist", param);

		}
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> myAuthList = sqlDao.findAll("findAllMngrAuth",param);
		model.addAttribute("myAuthList", myAuthList);
		model.addAttribute("authorList", sqlDao.findAll("findAllAuthList"));
		super.forUpdate(paramCtx);
		
		ZValue encResult =  (ZValue) model.get("result");
		//ZValue result = userInfoDecode(encResult);
		model.addAttribute("result", encResult);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");

		String pwdNew = param.getString("pwdNew");
		if(StringUtils.hasText(pwdNew) && param.getString("pwdChange").equals("1")){
			param.put("password", passwordEncoder.encodePassword(pwdNew, salt));
		}
		param = userInfoEncode(param);
		super.update(paramCtx);

		if(StringUtils.hasText(pwdNew) && param.getString("pwdChange").equals("1")){
			param.put("userSe", USER_SE);
			param.put("userSn", param.getLong("userSn"));
			param.put("userId", param.getString("userId"));
			param.put("userNm", param.getString("userNm"));
			param.put("salt", salt);

			// TM_USER_SALT 테이블에 SALT값 삭제후 등록
			sqlDao.deleteOne("deleteMemberSaltInfo", param);
			sqlDao.save("saveMemberSalfInfo", param);
		}
		List<String> authorCdList = param.getList("authorCd");
		List<String> authorFlagList = param.getList("authorFlag");


		for (int i=0; i < authorCdList.size(); i++) {
			String authorCd = authorCdList.get(i);
			String authorFlag = authorFlagList.get(i);

			if (authorFlag.equals("I")){
				param.put("authorCd", authorCd);
				param.put("userTyCd", "A");
				sqlDao.save("saveMngrAuth", param);
			} else if (authorFlag.equals("D")){
				param.put("authorCd", authorCd);
				param.put("userTyCd", "A");
				sqlDao.save("deleteMngrAuthOne", param);
			}

			/**
			 * 개인정보보호 - 권한지정, 변경 이력 기록
			 */
			if (authorFlag.equals("I") || authorFlag.equals("D")){
				param.put("registId", user.getUserId());
				param.put("userCpno", param.getString("userCpno1")+"-"+param.getString("userCpno2")+"-"+param.getString("userCpno3"));
				param.put("userEmad", param.getString("userEmad1")+"@"+param.getString("userEmad2"));
				param.put("sttusCd", authorFlag);
				param.put("sttusSumry", authorCd + " 권한 " + (authorFlag.equals("I") ? "부여" : "말소"));
				param.put("registId", user.getUserId());
				param.put("registIpad", paramCtx.getUserIp());
				sqlDao.save("saveMngrAuthorHist", param);
			}
		}
	}

	@Override
	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();

		sqlDao.deleteOne("deleteMngrAuth", param);

		List<String> authorCdList = param.getList("authorCd");

		for (int i=0; i < authorCdList.size(); i++) {
			String authorCd = authorCdList.get(i);
			String authorFlag = "D";

			param.put("authorCd", authorCd);
			param.put("registId", user.getUserId());
			param.put("userCpno", param.getString("userCpno1")+"-"+param.getString("userCpno2")+"-"+param.getString("userCpno3"));
			param.put("userEmad", param.getString("userEmad1")+"@"+param.getString("userEmad2"));
			param.put("sttusCd", authorFlag);
			param.put("sttusSumry", authorCd + " 권한 말소 (관리자 삭제)");
			param.put("registId", user.getUserId());
			param.put("registIpad", paramCtx.getUserIp());
			sqlDao.save("saveMngrAuthorHist", param);

		}

		sqlDao.deleteOne("deleteMngr", param);
		param.put("userSe", USER_SE);
		sqlDao.deleteOne("deleteMemberSaltInfo", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 삭제되었습니다.");
	}

	@UnpJsonView
	public void checkId(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		model.addAttribute("cnt", sqlDao.count("countMngr", param));
	}

	@UnpJsonView
	public void checkPrhibtWrd(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("word", param.getString("chkWord"));
		String word = prhibtWrdDicaryService.countWrdNm(paramCtx);
		String chkWord = "N";
		if (word != null) {
			chkWord = "Y";
			model.addAttribute("word", word);
		}
		model.addAttribute("chkWord", chkWord);
	}

	public void listPop(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}
	
	//암호화
	public ZValue userInfoEncode(ZValue param) throws Exception{
		param.put("userCpno", cryptoARIA.encryptData(param.getString("userCpno")));
		param.put("userEmad", cryptoARIA.encryptData(param.getString("userEmad")));

		return param;
	}

	//복호화
	public ZValue userInfoDecode(ZValue result) throws Exception{
		result.put("userCpno", cryptoARIA.decryptData(result.getString("userCpno")));
		result.put("userEmad", cryptoARIA.decryptData(result.getString("userEmad")));
		return result;
	}


}