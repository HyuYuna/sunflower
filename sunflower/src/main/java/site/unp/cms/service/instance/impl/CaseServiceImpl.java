package site.unp.cms.service.instance.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.file.EkrFileMngService;
import site.unp.cms.service.instance.CaseService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
	sqlDaoRef = "caseDAO", 
	pageQueryData = "searchCnd,searchWrd,menuNo,caseSeq,condFrdate,condTodate,centerCodeSub,scCenterCodeSub,chkCsTypeArr,chkCsJupsooArr,termType,dateType,finishCaseCheck,viewType"
		+ ",visitCaseCheck,srcState,srcCslId,caseManagerState,caseManager,searchCaseType,searchMasterText,victimFrger,victimAgeFrom,victimAgeTo,victimDisable,victimArea"
		+ ",attkrFrger,attkrAge,attkrDisable,attkrRelGrp,casePdate,passUdate,passPdate,caseAlias,searchType,chkPassTypeArr2,chkPassWayArr2,shPassType,shSub1Data,shSub2Data"
		+ ",smonthY,searchHalf,searchQuater,smonthM,scVictimName,pageUnit,searchDateType,pageUnit2,attkrRel", 
	listenerAndMethods = { "accessLogListener=insert,update,delete" }
)
@CommonServiceLink(desc = "사례 관리")
@Service
public class CaseServiceImpl extends DefaultCrudServiceImpl implements CaseService {

	@Resource(name="ekrFileMngService")
	private EkrFileMngService ekrFileMngService;

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("menuNo", param.getString("menuNo"));

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("loginUserId", user.getUserId());

		ZValue user1 = sqlDAO.findOneById("findOneMngrLoginInfo2", user.getUserPin());
		param.put("userLevel", user1.getString("userLevel"));
		if ("".equals(param.getString("centerCodeSub"))) {
			param.put("scCenterCodeSub", user1.getString("centerCode"));
		}

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");

		if ("".equals(param.getString("termType"))) {
			// 수정일 검색
			param.put("searchDateType", "caseDate");

			// defualt 월
//			param.put("condFrdate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH) + 1)));
//			param.put("condTodate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH))));
			
			// 일
			param.put("condFrdate", fmt.format(new java.util.Date(cal.getTime().getTime())));
			param.put("condTodate", fmt.format(new java.util.Date(cal.getTime().getTime())));
		}

		// 날짜 검색 사례접수일 기준일 경우 사례접수일 정렬, 사례등록일 기준일 경우 사례등록일 정렬
		if (param.getString("casePdate").length() == 0) {
			if (param.getString("searchDateType").equals("caseDate")) {
				param.put("casePdate", "DESC");
			} else if (param.getString("searchDateType").equals("caseUdate")) {
				param.put("casePdate", "UDESC");
			}
		}

		String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
		if (chkCsTypeArrList.length > 0) {
			param.put("chkCsType", chkCsTypeArrList);
		}
		String[] chkCsJupsooArrList = param.getString("chkCsJupsooArr").split(", ");
		if (chkCsJupsooArrList.length > 0) {
			param.put("chkCsJupsoo", chkCsJupsooArrList);
		}

		//int countAllpassList = (int) sqlDao.count("countAllCasePassList2", param);


		// 지원서비스리스트 페이징
		/* paginationInfo.setTotalRecordCount(countAllpassList); */

		int pageNo = 1;
		int listScale;
		if (param.getString("pageUnit2").length() == 0) {
			param.put("pageUnit2", 20);
			listScale = 20;
		} else {
			listScale = param.getInt("pageUnit2");
		}
		int pageScale = 10;

		int passTotCnt = 0;

		if (param.get("caseSeq") != null && param.get("caseSeq") != "") {
			passTotCnt = (int) sqlDao.count("countCasePassList2", param);
		} else {
			passTotCnt = (int) sqlDao.count("countAllCasePassList2", param);
		}

		model.addAttribute("totcnt", passTotCnt);
		model.addAttribute("totpage", passTotCnt / listScale);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(pageNo);
		paginationInfo.setRecordCountPerPage(listScale);
		paginationInfo.setPageSize(pageScale);

		int startPage = paginationInfo.getFirstRecordIndex(); // 시작 페이지
		int lastPage = paginationInfo.getRecordCountPerPage(); // 마지막 페이지

		param.put("startPage", startPage);
		param.put("lastPage", lastPage);

//		model.addAttribute("resultPassCnt", sqlDao.count("countCasePass2", param)); //지원서비스 건수
//		model.addAttribute("resultCaseView", sqlDao.findOne("findCaseLimitView", param));

		List<ZValue> passList2 = sqlDao.findAll("findCasePassList3", param);
		model.addAttribute("resultPassList", passList2);

		if (param.getString("pageUnit").length() == 0) {
			param.put("pageUnit", 20);
		}

		super.list(paramCtx);
	}

	public void listCenter(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("loginUserId", user.getUserId());

		ZValue user1 = sqlDAO.findOneById("findOneMngrLoginInfo2", user.getUserPin());
		param.put("userLevel", user1.getString("userLevel"));
		if ("".equals(param.getString("centerCodeSub"))) {
			param.put("scCenterCodeSub", user1.getString("centerCode"));
		}
		//param.put("scCenterCodeSub", user1.getString("centerCode"));

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");

		if ("".equals(param.getString("termType"))) {
			// 수정일 검색
			param.put("searchDateType", "caseDate");

			// defualt 월
//			param.put("condFrdate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH) + 1)));
//			param.put("condTodate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH))));
			
			// 일
			param.put("condFrdate", fmt.format(new java.util.Date(cal.getTime().getTime())));
			param.put("condTodate", fmt.format(new java.util.Date(cal.getTime().getTime())));
		}

		if (param.getString("casePdate").length() == 0) {
			if (param.getString("searchDateType").equals("caseDate")) {
				param.put("casePdate", "DESC");
			} else if (param.getString("searchDateType").equals("caseUdate")) {
				param.put("casePdate", "UDESC");
			}
		}

		String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
		if (chkCsTypeArrList.length > 0) {
			param.put("chkCsType", chkCsTypeArrList);
		}
		String[] chkCsJupsooArrList = param.getString("chkCsJupsooArr").split(", ");
		if (chkCsJupsooArrList.length > 0) {
			param.put("chkCsJupsoo", chkCsJupsooArrList);
		}

		if (param.getString("pageUnit").length() == 0) {
			param.put("pageUnit", 20);
		}

		super.doList(paramCtx, "findAllCaseCneter", "countCaseCneter");
	}

	public void listOther(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("loginUserId", user.getUserId());

		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
		param.put("nCenterCodeSub", resultCntr.getString("cntrCod"));

		super.doList(paramCtx, "findCaselistOther", "countCaselistOther");
	}

    public void listPass(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginUserId", user.getUserId());
        param.put("menuNo", param.getString("menuNo"));

        ZValue user1 = sqlDAO.findOneById("findOneMngrLoginInfo2",user.getUserPin());
        param.put("userLevel", user1.getString("userLevel"));
		if ("".equals(param.getString("centerCodeSub"))) {
			param.put("scCenterCodeSub", user1.getString("centerCode"));
		}

        //DB튜닝 후 반영(xml주석도 )
        //param.put("passPdate", "DESC");
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");

        if ("".equals(param.getString("termType"))) {
        	
        	// defualt 월
//        	param.put("condFrdate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH) + 1)));
//        	param.put("condTodate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH))));
        	// 일
        	param.put("condFrdate", fmt.format(new java.util.Date(cal.getTime().getTime())));
        	param.put("condTodate", fmt.format(new java.util.Date(cal.getTime().getTime())));
        }

//        String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
//        if(chkCsTypeArrList.length > 0) {
//        	param.put("chkCsType", chkCsTypeArrList );
//        }
        
        String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
        if(chkCsTypeArrList.length > 0) {
        	param.put("chkCsType", chkCsTypeArrList );
        }
        String[] chkPassWayArrList = param.getString("chkPassWayArr2").split(", ");
        if(chkPassWayArrList.length > 0) {
        	param.put("chkPassWay", chkPassWayArrList );
        }
        param.put("chkPassWayLength", chkPassWayArrList.length);
        String[] chkPassTypeArrList = param.getString("chkPassTypeArr2").split(", ");
        if(chkPassTypeArrList.length > 0) {
            param.put("chkPassType", chkPassTypeArrList );
        }
        param.put("chkPassTypeLength", chkPassTypeArrList.length);
        super.doList(paramCtx, "findPassList", "countPass");
    }
    public void listCaseTrans(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());
    	param.put("menuNo", param.getString("menuNo"));
    	super.doList(paramCtx, "findCaseTransList", "countCaseTrans");    	
    }
    
    public void caseTransReg(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());
    	param.put("menuNo", param.getString("menuNo"));
    	
    	ZValue user1 = sqlDAO.findOneById("findOneMngrLoginInfo2",user.getUserPin());
    	param.put("userLevel", user1.getString("userLevel"));
    	param.put("scCenterCodeSub", user1.getString("centerCode"));
    	//DB튜닝 후 반영(xml주석도 )
    	//param.put("passPdate", "DESC");
    	Calendar cal = Calendar.getInstance();
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    	
    	if ("".equals(param.getString("termType"))) {
    		
    		// defualt 월
//        	param.put("condFrdate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH) + 1)));
//        	param.put("condTodate", cal.get(Calendar.YEAR) + "-" + DateUtil.zeroFill("00", Integer.toString(cal.get(Calendar.MONTH))));
    		// 일
    		param.put("condFrdate", fmt.format(new java.util.Date(cal.getTime().getTime())));
    		param.put("condTodate", fmt.format(new java.util.Date(cal.getTime().getTime())));
    	}
    	
//        String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
//        if(chkCsTypeArrList.length > 0) {
//        	param.put("chkCsType", chkCsTypeArrList );
//        }
    	
    	String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
    	if(chkCsTypeArrList.length > 0) {
    		param.put("chkCsType", chkCsTypeArrList );
    	}
    	String[] chkPassWayArrList = param.getString("chkPassWayArr2").split(", ");
    	if(chkPassWayArrList.length > 0) {
    		param.put("chkPassWay", chkPassWayArrList );
    	}
    	param.put("chkPassWayLength", chkPassWayArrList.length);
    	String[] chkPassTypeArrList = param.getString("chkPassTypeArr2").split(", ");
    	if(chkPassTypeArrList.length > 0) {
    		param.put("chkPassType", chkPassTypeArrList );
    	}
    	param.put("chkPassTypeLength", chkPassTypeArrList.length);
    	//super.doList(paramCtx, "findPassList", "countPass");
    }
    
 

	@Override
    public void view(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        param.put("currMenu", "사례별 정보");
        
        if(param.getString("goServ").equals("Y")) {
            insertHistory(param, "SERV", "V", "[자동입력] 사례부가정보를 조회했습니다"); 
        }else {
            insertHistory(param, "CASE", "V", "[자동입력] 사례를 조회했습니다");
        }
        
        List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);

        ZValue result = sqlDao.findOne("findOneCase", param);

        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String year = sdf.format(cal.getTime()).substring(0, 4);
        String month = sdf.format(cal.getTime()).substring(4, 6);
        int day = Integer.parseInt(sdf.format(cal.getTime()).substring(6, 8));

        boolean rbool = false;
        String dimMagamDate = "";
        String gDate = result.getString("caseDate");
        String gCaseManager = result.getString("caseManager");
        String loginUser = user1.getUserId();
        String gUserGroup = user.getString("userGroup");
        String gCaseEnd = result.getString("caseEnd");

        if("02".equals(month) || "03".equals(month) || "04".equals(month) || "05".equals(month) || "06".equals(month)){
    		dimMagamDate = year + "-01-01";
    	}else if("01".equals(month)){
    		if(day>=1 && day<=16) {
    			cal.add(Calendar.YEAR, -1);
    			year = sdf.format(cal.getTime()).substring(0, 4);
    			dimMagamDate = year + "-07-01";
    		}else {
    			dimMagamDate = year + "-01-01";
    		}
    	}else if("07".equals(month)){
    		if(day>=1 && day<=16) {
    			dimMagamDate = year + "-01-01";
    		}else {
    			dimMagamDate = year + "-07-01";
    		}
    	}else{
    		dimMagamDate = year + "-07-01";
    	}

    	gDate = gDate.replace("-", "");
    	dimMagamDate = dimMagamDate.replace("-", "");
		int caseDate = Integer.parseInt(gDate);
		int magamDate = Integer.parseInt(dimMagamDate);

    	if(caseDate >= magamDate){
    		rbool = true;
    	}

    	if(caseDate >= magamDate && "OP07".equals(gUserGroup)){
    		rbool = true;
    	}
    	
    	if(gCaseEnd.equals("Y")){ //종결 사례인 경우 수정불가
    		rbool = false;
    	}
    	
    	param.put("rbool", rbool);

        model.addAttribute("resultAttkrList", resultAttkrList);	//가해자정보
        model.addAttribute("resultServ", sqlDao.findOne("findOneCaseServ", param));	//사례부가정보
        model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
        model.addAttribute("rbool", rbool);
        super.view(paramCtx);
    }

    public void caseReg(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());
    	param.put("currMenu", "사례별 정보");
    	//가해자정보 리스트
    	List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);
    	//사례 상세
    	model.addAttribute("result", sqlDao.findOne("findOneCase", param));
    	model.addAttribute("resultCaseManager", sqlDao.findAll("findCaseManager", param));

        model.addAttribute("resultAttkrList", resultAttkrList);
        //메모 상세
        model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
        
        //마감 일자
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String dimMagamDate = "";
		String yearRange = "c:c+10";

		String year = sdf.format(cal.getTime()).substring(0, 4);
        String month = sdf.format(cal.getTime()).substring(4, 6);
        int day = Integer.parseInt(sdf.format(cal.getTime()).substring(6, 8));
        
        if("02".equals(month) || "03".equals(month) || "04".equals(month) || "05".equals(month) || "06".equals(month)){
    		dimMagamDate = year + "-01-01";
    	}else if("01".equals(month)){
    		if(day>=1 && day<=16) {
    			cal.add(Calendar.YEAR, -1);
    			year = sdf.format(cal.getTime()).substring(0, 4);
    			dimMagamDate = year + "-07-01";
    			yearRange = "c-100:c+10";
    		}else {
    			dimMagamDate = year + "-01-01";
    		}
    	}else if("07".equals(month)){
    		if(day>=1 && day<=16) {
    			dimMagamDate = year + "-01-01";
    		}else {
    			dimMagamDate = year + "-07-01";
    		}
    	}else{
    		dimMagamDate = year + "-07-01";
    	}
        
        model.addAttribute("dimMagamDate", dimMagamDate);
        model.addAttribute("yearRange", yearRange);
    }
    
    @UnpJsonView
    public void attkrList(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	
    	//가해자정보 리스트
    	List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);
    	
    	model.addAttribute("attkrList", resultAttkrList);
    }

    @Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());

    	ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
    	param.put("centerCode", resultCntr.getString("cntrCod"));

    	ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
		long countCaseNumber = sqlDao.count("countCaseNumber", param);

		String cntrGbn = resultCntr.getString("cntrGbn");
		String cntrGbnAbc = "";
		String caseNumber = "";

		if("1".equals(cntrGbn)) {
			cntrGbnAbc = "A";
		}else if("2".equals(cntrGbn)){
			cntrGbnAbc = "B";
		}else if("3".equals(cntrGbn)){
			cntrGbnAbc = "C";
		}else {
			cntrGbnAbc = "Z";
		}

		// 전산관리번호 생성
		caseNumber = resultCntr.getString("areaCd") + cntrGbnAbc + resultCntr.getString("cntrCod") + resultCntr.getString("midDate") + "0" + resultCntr.getString("caseNumber");

		param.put("caseNumber", caseNumber);
		param.put("attkrSeq", attkrSeq.getString("attkrSeq"));
		
		//나이 입력 부분이 없고 생일에 의한 나이가 있으면 나이에 값을 넣어줌
		if(param.getString("victimAge").length() == 0 && param.getString("victimAgeBirth").length() != 0){
			param.put("victimAge", param.getString("victimAgeBirth"));
		}
		if(param.getString("victimAge").length() == 0 || param.getString("victimAgeNo").equals("Y")){
			param.put("victimAge", "199");
		}
		
		//거주지 알수없음이면 해당 정보 삭제
		if(param.getString("victimAreaNo").equals("Y")){
			param.put("victimArea", "17");
			param.put("victimAreaSub", "");
			param.put("victimAreaMemo", "");
		}

		// 사례 등록
//		super.insert(paramCtx);
		sqlDao.save("saveCase", param);
		// 가해자 정보 등록
		sqlDao.save("saveCaseAttkr", param);
		// 지원서비스 등록(초기상담 접수상담 자동생성)
		param.put("centerCode", member.getCenterCode());
		param.put("userId", member.getUserId());
		param.put("passDate", param.getString("caseDate"));
		param.put("passTime", param.getString("caseTime"));
		param.put("passTimeE", param.getString("caseTimeE"));
		param.put("passWay", param.getString("caseJupsoo"));
		param.put("passType", "4");
		param.put("sub1Data", "4A");
		param.put("userName", param.getString("client"));
		param.put("userRelGrp", param.getString("clientRelGrp"));
		param.put("userRel", param.getString("clientRel"));
		param.put("passRelType", '1');
		sqlDao.save("savePass", param);
		// 메모 등록
		sqlDao.save("saveMemo", param);

		// 전산관리번호 넘버 추가 및 업데이트
		if(countCaseNumber > 0) {
			sqlDao.modify("updateCaseNumber", param);
		}else {
			sqlDao.save("saveCaseNumber", param);
		}

		param.put("uflRelNumber", param.getString("caseSeq"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

        insertHistory(param, "CASE", "I", "[자동입력] 사례를 입력했습니다");
        insertHistory(param, "SERV", "I", "[자동입력] 사례부가정보를 입력했습니다");
        insertHistory(param, "ATTKR","I", "[자동입력] 가해자정보를 입력했습니다");
        insertHistory(param, "PASS", "I", "[자동입력] 지원서비스를 입력했습니다");
        
		String goUrl = WebFactory.buildUrl("/bos/instance/case/view.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
		
		/*MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.insert", null, Locale.getDefault()));*/
		
	}
    
    /* 임시저장 */
    @UnpJsonView
    public void tmprCase(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	
		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("loginUserId", user.getUserId());

		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
		param.put("centerCode", resultCntr.getString("cntrCod"));
		
		if(param.getString("caseSeq").equals("0")){
			ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
			long countCaseNumber = sqlDao.count("countCaseNumber", param);

			String cntrGbn = resultCntr.getString("cntrGbn");
			String cntrGbnAbc = "";
			String caseNumber = "";

			if ("1".equals(cntrGbn)) {
				cntrGbnAbc = "A";
			} else if ("2".equals(cntrGbn)) {
				cntrGbnAbc = "B";
			} else if ("3".equals(cntrGbn)) {
				cntrGbnAbc = "C";
			} else {
				cntrGbnAbc = "Z";
			}

			// 전산관리번호 생성
			caseNumber = resultCntr.getString("areaCd") + cntrGbnAbc + resultCntr.getString("cntrCod") + resultCntr.getString("midDate") + "0" + resultCntr.getString("caseNumber");

			param.put("caseNumber", caseNumber);
			param.put("attkrSeq", attkrSeq.getString("attkrSeq"));
			
			//나이 입력 부분이 없고 생일에 의한 나이가 있으면 나이에 값을 넣어줌
			if(param.getString("victimAge").length() == 0 && param.getString("victimAgeBirth").length() != 0){
				param.put("victimAge", param.getString("victimAgeBirth"));
			}
			if(param.getString("victimAge").length() == 0 || param.getString("victimAgeNo").equals("Y")){
				param.put("victimAge", "199");
			}
			
			//거주지 알수없음이면 해당 정보 삭제
			if(param.getString("victimAreaNo").equals("Y")){
				param.put("victimArea", "17");
				param.put("victimAreaSub", "");
				param.put("victimAreaMemo", "");
			}

			// 사례 등록
			// super.insert(paramCtx);
			sqlDao.save("saveCase", param);
			// 가해자 정보 등록
			sqlDao.save("saveCaseAttkr", param);
			// 지원서비스 등록(초기상담 접수상담 자동생성)
			param.put("centerCode", member.getCenterCode());
			param.put("userId", member.getUserId());
			param.put("passDate", param.getString("caseDate"));
			param.put("passTime", param.getString("caseTime"));
			param.put("passTimeE", param.getString("caseTimeE"));
			param.put("passWay", param.getString("caseJupsoo"));
			param.put("passType", "4");
			param.put("sub1Data", "4A");
			param.put("userName", param.getString("client"));
			param.put("userRelGrp", param.getString("clientRelGrp"));
			param.put("userRel", param.getString("clientRel"));
			param.put("passRelType", '1');
			sqlDao.save("savePass", param);
			// 메모 등록
			sqlDao.save("saveMemo", param);

			// 전산관리번호 넘버 추가 및 업데이트
			if (countCaseNumber > 0) {
				sqlDao.modify("updateCaseNumber", param);
			} else {
				sqlDao.save("saveCaseNumber", param);
			}

			param.put("uflRelNumber", param.getString("caseSeq"));

			boolean flag = ekrFileMngService.uploadFile(paramCtx);
			if (!flag)
				return;
			
			model.addAttribute("caseSeq", param.getString("caseSeq"));
			model.addAttribute("caseAttkrSeq", attkrSeq.getString("attkrSeq"));
			model.addAttribute("caseNumber", caseNumber);
		} else {
	    	//임시저장 상태에서 저장할 경우 History 저장 안함
	    	if(!param.getString("tmpr").equals("Y")){
	    	    insertHistory(param, "CASE", "U", "[자동입력] 임시저장으로 수정하였습니다.");
	    	}
			
			//나이 입력 부분이 없고 생일에 의한 나이가 있으면 나이에 값을 넣어줌
			if(param.getString("victimAge").length() == 0 && param.getString("victimAgeBirth").length() != 0){
				param.put("victimAge", param.getString("victimAgeBirth"));
			}
			if(param.getString("victimAge").length() == 0 || param.getString("victimAgeNo").equals("Y")){
				param.put("victimAge", "199");
			}
			
			//거주지 알수없음이면 해당 정보 삭제
			if(param.getString("victimAreaNo").equals("Y")){
				param.put("victimArea", "17");
				param.put("victimAreaSub", "");
				param.put("victimAreaMemo", "");
			}
	    	
			// 사례 등록
//			super.update(paramCtx);
			sqlDao.modify("updateCase", param);
			param.put("uflRelNumber", param.getString("cmFileUploadCode"));

			boolean flag = ekrFileMngService.uploadFile(paramCtx);
			if(!flag)
				return;
			
			// 초기지원서비스 수정
			sqlDao.modify("updatePassEryy", param);

			// 메모 등록
			sqlDao.save("updateMemo", param);
		}
		
		model.addAttribute("resultCode", "success");
    }

    public void insertTmpr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());

    	ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
    	param.put("centerCode", resultCntr.getString("cntrCod"));

    	ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
		long countCaseNumber = sqlDao.count("countCaseNumber", param);

		String cntrGbn = resultCntr.getString("cntrGbn");
		String cntrGbnAbc = "";
		String caseNumber = "";

		if("1".equals(cntrGbn)) {
			cntrGbnAbc = "A";
		}else if("2".equals(cntrGbn)){
			cntrGbnAbc = "B";
		}else if("3".equals(cntrGbn)){
			cntrGbnAbc = "C";
		}else {
			cntrGbnAbc = "Z";
		}

		// 전산관리번호 생성
		caseNumber = resultCntr.getString("areaCd") + cntrGbnAbc + resultCntr.getString("cntrCod") + resultCntr.getString("midDate") + "0" + resultCntr.getString("caseNumber");

		param.put("caseNumber", caseNumber);
		param.put("attkrSeq", attkrSeq.getString("attkrSeq"));

		// 사례 등록
//		super.insert(paramCtx);
		sqlDao.save("saveCase", param);
		// 가해자 정보 등록
		sqlDao.save("saveCaseAttkr", param);
		// 메모 등록
		sqlDao.save("saveMemo", param);

		// 전산관리번호 넘버 추가 및 업데이트
		if(countCaseNumber > 0) {
			sqlDao.modify("updateCaseNumber", param);
		}else {
			sqlDao.save("saveCaseNumber", param);
		}

		param.put("uflRelNumber", param.getString("caseSeq"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		String goUrl = WebFactory.buildUrl("/bos/instance/case/caseReg.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "임시저장 되었습니다.", model);
	}
    public void insertCaseTrans(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	String transStdrDate = "";
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("transUserId", user.getUserId());
    	transStdrDate = param.getString("transStdrDate").replace("-", "") + param.getString("transHour") + param.getString("transMin") + param.getString("transSec");
    	param.put("transStdrDate", transStdrDate);
    	
    	
    	
    	// 사례이관 등록
    	sqlDao.save("saveCaseTrans", param);
    	String goUrl = WebFactory.buildUrl("/bos/instance/case/listCaseTrans.do", param, "caseSeq", "menuNo", "pageIndex");
    	MVUtils.goUrl(goUrl, "사례이관 기준일이 정상 처리되었습니다.", model);
    }

    @Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());

		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
    	param.put("centerCode", resultCntr.getString("cntrCod"));

    	//임시저장 상태에서 저장할 경우 History 저장 안함
    	if(!param.getString("tmpr").equals("Y")){
    	    insertHistory(param, "CASE", "U", "");
    	}
		
		//나이 입력 부분이 없고 생일에 의한 나이가 있으면 나이에 값을 넣어줌
		if(param.getString("victimAge").length() == 0 && param.getString("victimAgeBirth").length() != 0){
			param.put("victimAge", param.getString("victimAgeBirth"));
		}
		if(param.getString("victimAge").length() == 0 || param.getString("victimAgeNo").equals("Y")){
			param.put("victimAge", "199");
		}
		
		//거주지 알수없음이면 해당 정보 삭제
		if(param.getString("victimAreaNo").equals("Y")){
			param.put("victimArea", "17");
			param.put("victimAreaSub", "");
			param.put("victimAreaMemo", "");
		}
		
		// 사례 등록
//		super.update(paramCtx);
		sqlDao.modify("updateCase", param);
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		//가해자정보 리스트
    	List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);
    	
    	//가해자 정보가 없을 경우 가해자 새로 등록
    	if(resultAttkrList.size() == 0){
    		ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
    		param.put("attkrSeq", attkrSeq.getString("attkrSeq"));
    		
    		insertHistory(param, "ATTKR", "I", "[자동입력] 가해자정보를 입력했습니다");
    		
    		// 가해자 정보 등록
    		sqlDao.save("saveCaseAttkr", param);
    	}
		
		// 초기지원서비스 수정
		sqlDao.modify("updatePassEryy", param);

		// 메모 등록
		sqlDao.save("updateMemo", param);
		String goUrl = WebFactory.buildUrl("/bos/instance/case/view.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
		/*MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.update", null, Locale.getDefault()));*/
	}

    public void updateTmpr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());

		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
    	param.put("centerCode", resultCntr.getString("cntrCod"));

    	insertHistory(param, "CASE", "U", "");
    	
		// 사례 등록
//		super.update(paramCtx);
		sqlDao.modify("updateCase", param);
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

		// 메모 등록
		sqlDao.save("updateMemo", param);

		String goUrl = WebFactory.buildUrl("/bos/instance/case/caseReg.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "임시저장 되었습니다.", model);
	}

    @Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

        insertHistory(param, "CASE", "D", "[자동입력] 사례를 삭제했습니다");

		// 사례기본정보
		super.delete(paramCtx);
		// 메모
		sqlDao.deleteOne("deleteMemo", param);
		// 가해자정보
		sqlDao.deleteOne("deleteAttkr", param);
		// 지원서비스
		sqlDao.deleteOne("deleteCasePass", param);
		// 부가정보
		sqlDao.deleteOne("deleteCaseServ", param);
		// 첨부
		// 연락처
		sqlDao.deleteOne("deleteCaseContact", param);
		// 관리
		sqlDao.deleteOne("deleteBookmark", param);

		param.put("uflRelNumber", param.getInt("caseSeq"));
		param.put("uflRelCode", "case");
		sqlDao.deleteOne("ekrFileDelete", param);
	}

	public void caseRelPopup(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		
		param.put("userLevel", member.getAuthorCd());
        param.put("scCenterCodeSub", member.getCenterCode());
		
		super.doList(paramCtx, "findAllCase", "countCase");
	}

    public void caseAttkrRegPopup(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        ZValue findCaseAttkrOne = sqlDao.findOne("findCaseAttkrOne", param);
        model.addAttribute("result", findCaseAttkrOne);
    }

    @UnpJsonView
    public void insertAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
    
    	param.put("attkrSeq", attkrSeq.getString("attkrSeq"));
		insertHistory(param, "ATTKR", "I", "[자동입력] 가해자정보를 입력했습니다");
		//가해자 정보 추가
        sqlDao.save("saveCaseAttkr", param);
//        MVUtils.setResultProperty(model, SUCCESS, "등록 정상처리 하였습니다.");
    }

    @UnpJsonView
    public void updateAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        insertHistory(param, "ATTKR", "U", "");
    	sqlDao.save("updateCaseAttkr", param);
    }

    @UnpJsonView
    public void deleteAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

        insertHistory(param, "ATTKR", "D", "[자동입력] 가해자정보를 삭제했습니다");
    	sqlDao.deleteOne("deleteCaseAttkr", param);
    }

	@UnpJsonView
    public void passView(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		//마감 일자
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String dimMagamDate = "";
		String yearRange = "c:c+10";

		String year = sdf.format(cal.getTime()).substring(0, 4);
        String month = sdf.format(cal.getTime()).substring(4, 6);
        int day = Integer.parseInt(sdf.format(cal.getTime()).substring(6, 8));
        
        if("02".equals(month) || "03".equals(month) || "04".equals(month) || "05".equals(month) || "06".equals(month)){
    		dimMagamDate = year + "-01-01";
    	}else if("01".equals(month)){
    		if(day>=1 && day<=16) {
    			cal.add(Calendar.YEAR, -1);
    			year = sdf.format(cal.getTime()).substring(0, 4);
    			dimMagamDate = year + "-07-01";
    			yearRange = "c-100:c+10";
    		}else {
    			dimMagamDate = year + "-01-01";
    		}
    	}else if("07".equals(month)){
    		if(day>=1 && day<=16) {
    			dimMagamDate = year + "-01-01";
    		}else {
    			dimMagamDate = year + "-07-01";
    		}
    	}else{
    		dimMagamDate = year + "-07-01";
    	}
        
        model.addAttribute("dimMagamDate", dimMagamDate);
        model.addAttribute("yearRange", yearRange);

        param.put("currMenu", "사례별 정보");
		model.addAttribute("result", sqlDao.findOne("findOneCase", param));	//사례기본상세
		
		if(param.getString("pageUnit").length() == 0){
			param.put("pageUnit", "20");
		}

		//지원일자순(default)
		if(param.getString("passPdate").length() == 0){
	        param.put("passPdate", "DESC");
		}
		
		//model.addAttribute("resultPassCnt", sqlDao.count("countCasePass", param));	//지원서비스 건수
    	//model.addAttribute("resultPassList", sqlDao.findAll("findCasePassList", param));

		insertHistory(param, "PASS", "V", "[자동입력] 지원서비스를 조회했습니다");
		
        super.doList(paramCtx, "findCasePassList", "countCasePass");
//    	model.addAttribute("resultTypeList", sqlDao.findAll("findPassTypeList", param));	//지원구분 리스트
    }

	@UnpJsonView
    public void findCasePassList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
    	MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		
		String[] chkCsTypeArrList = param.getString("chkCsTypeArr").split(", ");
        if(chkCsTypeArrList.length > 0) {
        	param.put("chkCsType", chkCsTypeArrList );
        }
        String[] chkCsJupsooArrList = param.getString("chkCsJupsooArr").split(", ");
        if(chkCsJupsooArrList.length > 0) {
        	param.put("chkCsJupsoo", chkCsJupsooArrList );
        }
        
        int pageNo = 1;
        int listScale;
        if(param.getString("pageUnit2").length() == 0){
            listScale = 20;
        } else {
        	listScale = param.getInt("pageUnit2");
        }
        int pageScale = 10;
        
        if(param.size() > 0 && param.get("pageNo") != null) {
            pageNo = Integer.parseInt((String)param.get("pageNo"));//현재 페이지 번호
        }
        
        if(param.size() > 0 && param.get("pageSize") != null) {
        	pageScale = Integer.parseInt((String)param.get("pageSize"));//현재 페이지 번호
        }
        
        
        
        
        int passTotCnt = 0;
	    
		if(param.get("caseSeq") != null &&  param.get("caseSeq") != "") {
			passTotCnt = (int) sqlDao.count("countCasePassList2", param);
		}else {
			passTotCnt = (int) sqlDao.count("countAllCasePassList2", param);
		}
		
		model.addAttribute("cnt", passTotCnt);
		
		int totpage = 0;
		if(passTotCnt % listScale == 0) {
			totpage = passTotCnt/listScale;
		}else {
			totpage = passTotCnt/listScale+1;
		}
				
				
		
		model.addAttribute("totcnt", passTotCnt);
		model.addAttribute("totpage", totpage);
		
		
		
        
        param.put("userLevel", member.getAuthorCd());
        param.put("scCenterCodeSub", member.getCenterCode());
        
        
        PaginationInfo paginationInfo = new PaginationInfo();
        
        paginationInfo.setCurrentPageNo(pageNo);
        paginationInfo.setRecordCountPerPage(listScale); 
        paginationInfo.setPageSize(pageScale); 
        
        int startPage = paginationInfo.getFirstRecordIndex(); //시작 페이지
        int lastPage = paginationInfo.getRecordCountPerPage(); //마지막 페이지
        
        param.put("startPage", startPage);
        param.put("lastPage", lastPage);
        
    	model.addAttribute("resultList", sqlDao.findAll("findCasePassList3", param));
    	model.addAttribute("pageNo",pageNo);
    }

	@UnpJsonView
	public void ajaxFindPassTypeList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("resultList", sqlDao.findAll("findPassTypeList", param));
	}

    @UnpJsonView
    public void insertPass(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

    	ZValue tempParam = new ZValue();

    	List<String> passTypeList = param.getList("passType");
    	List<String> sub1DataList = param.getList("sub1Data");
    	List<String> sub2DataList = param.getList("sub2Data");
    	
    	for (int i=0; i<passTypeList.size(); i++) {
			if (passTypeList != null){
				if(passTypeList.get(i) != null && !"".equals(passTypeList.get(i))) {
					tempParam.put("caseSeq", param.getString("caseSeq"));
					tempParam.put("centerCode", member.getCenterCode());
					tempParam.put("userId", param.getString("userId"));
					tempParam.put("userName", param.getString("userName"));
					tempParam.put("userRelGrp", param.getString("userRelGrp"));
					tempParam.put("userRel", param.getString("userRel"));
					tempParam.put("passDate", param.getString("passDate"));
					tempParam.put("passTime", param.getString("passTime"));
					tempParam.put("passTimeE", param.getString("passTimeE"));
					tempParam.put("passWay", param.getString("passWay"));
					tempParam.put("passManager", param.getString("passManager"));

					tempParam.put("passType", passTypeList.get(i));
					tempParam.put("sub1Data", sub1DataList.get(i));
					
					//지원서비스 세부구분2 없을 경우 저장 안함
					if(sub2DataList.size() != 0){
						tempParam.put("sub2Data", sub2DataList.get(i));
					}

					tempParam.put("passRelType", param.getString("passRelType"));
					tempParam.put("passMemo", param.getString("passMemo"));
					tempParam.put("passText", param.getString("passText"));

					//지원서비스
					param.put("historyMemo", "");
			        insertHistory(param, "PASS", "I", "[자동입력] 지원서비스를 입력했습니다");
					sqlDao.save("savePass", tempParam);
				}
			}
		}
    	model.addAttribute("passSeq", tempParam.getString("passSeq"));
    	model.addAttribute("caseSeq", tempParam.getString("caseSeq"));
    	model.addAttribute("passDate", tempParam.getString("passDate"));
    	model.addAttribute("userName", tempParam.getString("userName"));
    	
        String goUrl = WebFactory.buildUrl("/bos/instance/case/passView.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "지원서비스가 등록 되었습니다.", model);
    }

    @UnpJsonView
    public void updatePass(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	insertHistory(param, "PASS", "U", "");
    	
    	ZValue tempParam = new ZValue();

    	List<String> passTypeList = param.getList("passType");
    	List<String> sub1DataList = param.getList("sub1Data");
    	List<String> sub2DataList = param.getList("sub2Data");

    	for (int i=0; i<passTypeList.size(); i++) {
			if (passTypeList != null){
				if(passTypeList.get(i) != null && !"".equals(passTypeList.get(i))) {
					tempParam.put("passSeq", param.getString("passSeq"));
					tempParam.put("caseSeq", param.getString("caseSeq"));
					tempParam.put("centerCode", param.getString("centerCode"));
					tempParam.put("userId", param.getString("userId"));
					tempParam.put("userName", param.getString("userName"));
					tempParam.put("userRelGrp", param.getString("userRelGrp"));
					tempParam.put("userRel", param.getString("userRel"));
					tempParam.put("passDate", param.getString("passDate"));
					tempParam.put("passTime", param.getString("passTime"));
					tempParam.put("passTimeE", param.getString("passTimeE"));
					tempParam.put("passWay", param.getString("passWay"));
					tempParam.put("passManager", param.getString("passManager"));

					tempParam.put("passType", passTypeList.get(i));
					tempParam.put("sub1Data", sub1DataList.get(i));
					
					//지원서비스 세부구분2 없을 경우 저장 안함
					if(sub2DataList.size() != 0){
						tempParam.put("sub2Data", sub2DataList.get(i));
					}

					tempParam.put("passRelType", param.getString("passRelType"));
					tempParam.put("passMemo", param.getString("passMemo"));
					tempParam.put("passText", param.getString("passText"));

					//지원서비스
					sqlDao.save("updatePass", tempParam);
				}
			}
		}


    	String goUrl = WebFactory.buildUrl("/bos/instance/case/passView.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "지원서비스가 수정 되었습니다.", model);
    }

    @UnpJsonView
    public void viewPass(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue result = sqlDao.findOne("findPassView", param);

        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String year = sdf.format(cal.getTime()).substring(0, 4);
        String month = sdf.format(cal.getTime()).substring(4, 6);
        int day = Integer.parseInt(sdf.format(cal.getTime()).substring(6, 8));

        boolean rbool = false;
        String dimMagamDate = "";
        String gDate = result.getString("passDate");

        if("02".equals(month) || "03".equals(month) || "04".equals(month) || "05".equals(month) || "06".equals(month)){
    		dimMagamDate = year + "-01-01";
    	}else if("01".equals(month)){
    		if(day>=1 && day<=16) {
    			cal.add(Calendar.YEAR, -1);
    			year = sdf.format(cal.getTime()).substring(0, 4);
    			dimMagamDate = year + "-07-01";
    		}else {
    			dimMagamDate = year + "-01-01";
    		}
    	}else if("07".equals(month)){
    		if(day>=1 && day<=16) {
    			dimMagamDate = year + "-01-01";
    		}else {
    			dimMagamDate = year + "-07-01";
    		}
    	}else{
    		dimMagamDate = year + "-07-01";
    	}

    	gDate = gDate.replace("-", "");
    	dimMagamDate = dimMagamDate.replace("-", "");
		int caseDate = Integer.parseInt(gDate);
		int magamDate = Integer.parseInt(dimMagamDate);

    	if(caseDate >= magamDate){
    		rbool = true;
    	}
		
    	result.put("rbool", rbool);
    	model.addAttribute("resultList", result);
    }

    @UnpJsonView
    public void deletePass(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

        insertHistory(param, "PASS", "D", "[자동입력] 사례를 삭제했습니다");

    	sqlDao.deleteOne("deletePass", param);
    }

    @UnpJsonView
    public void findCdListJson(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCdList", param));
    }


    @UnpJsonView
    public void findCdDetailListJson(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCdDetailList", param));
    }

	@UnpJsonView
    public void contactView(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

        param.put("currMenu", "사례별 정보");
		model.addAttribute("result", sqlDao.findOne("findOneCase", param));	//사례기본상세
		model.addAttribute("resultContactCnt", sqlDao.count("countCaseContact", param));	//연락처 건수
    	model.addAttribute("resultContactList", sqlDao.findAll("findCaseContactList", param));

    	super.doList(paramCtx, "findCaseSmsList", "countCaseSms");
    }

    @UnpJsonView
    public void insertContact(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		//지원서비스
        sqlDao.save("saveCaseContact", param);
    }

    @UnpJsonView
    public void updateContact(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

    	insertHistory(param, "TEL", "U", "");
        
    	sqlDao.save("updateCaseContact", param);
    }

    @UnpJsonView
    public void deleteContact(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	
    	insertHistory(param, "TEL", "D", "[자동입력] 연락처를 삭제했습니다");

    	sqlDao.deleteOne("deleteContact", param);
    }

	@UnpJsonView
    public void manageView(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("currMenu", "사례별 정보");
		param.put("userId", user.getUserId());

		model.addAttribute("result", sqlDao.findOne("findOneCase", param));	//사례기본상세
		model.addAttribute("resultBookCnt", sqlDao.count("countCaseBook", param));	//북마크 건수
		model.addAttribute("resultManageCnt", sqlDao.count("countCaseManage", param));	//관리 건수
//    	model.addAttribute("resultManageList", sqlDao.findAll("findCaseManageList", param));
    	super.doList(paramCtx, "findCaseManageList", "countCaseManage");
    }

    @UnpJsonView
    public void updateCaseFinish(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

    	insertHistory(param, "CASE", "U", "");

    	sqlDao.save("updateCaseFinish", param);
    }

    @UnpJsonView
    public void updateCaseEnd(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

    	insertHistory(param, "CASE", "U", "");

    	sqlDao.save("updateCaseEnd", param);
    }

    @UnpJsonView
    public void deleteCaseBookmark(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("memberId", user.getUserId());
    	sqlDao.save("deleteCaseBookmark", param);
    }

    @UnpJsonView
    public void insertCaseBookmark(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("memberId", user.getUserId());
    	sqlDao.save("insertCaseBookmark", param);
    }

	@UnpJsonView
    public void findCaseCenterList(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCaseCenterList", param));
    }

	public void servView(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("result", sqlDao.findOne("findOneCase", param));	//사례기본상세
    	model.addAttribute("resultServ", sqlDao.findOne("findOneCaseServ", param));	//사례부가정보
    }

    public void servReg(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
    	//사례 상세
    	model.addAttribute("result", sqlDao.findOne("findOneCase", param));
    	model.addAttribute("resultServ", sqlDao.findOne("findOneCaseServ", param));	//사례부가정보
    }

    public void insertServ(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	insertHistory(param, "SERV", "I", "[자동입력] 사례부가정보를 입력했습니다");
    	
		//부가정보 추가
        sqlDao.save("saveCaseServ", param);

        String goUrl = WebFactory.buildUrl("/bos/instance/case/view.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
    }

    public void updateServ(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	insertHistory(param, "SERV", "U", "");
    	
    	sqlDao.save("updateCaseServ", param);

    	String goUrl = WebFactory.buildUrl("/bos/instance/case/view.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "수정 되었습니다.", model);
    }

    public void deleteServ(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

    	insertHistory(param, "SERV", "D", "[자동입력] 사례부가정보를 삭제했습니다");
    	
    	sqlDao.deleteOne("deleteCaseServ", param);
    }

    public void fileView(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        param.put("currMenu", "사례별 정보");
        
        insertHistory(param, "FILE", "V", "[자동입력] 첨부파일를 조회했습니다");
    	//사례 상세
    	model.addAttribute("result", sqlDao.findOne("findOneCase", param));
    }

    public void insertFile(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}

		param.put("uflRelNumber", param.getString("caseSeq"));
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		insertHistory(param, "FILE", "I", "[자동입력] 첨부파일을 입력했습니다");
		 
		String goUrl = WebFactory.buildUrl("/bos/instance/case/fileView.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
	}

    public void caseFilePopup(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", user.getUserId());
    	param.put("userNm", user.getUserNm());
	}

    @UnpJsonView
    public void printView(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        model.addAttribute("result", sqlDao.findOne("findOneCase", param)); //사례기본상세
        //model.addAttribute("resultPrint", sqlDao.findAll("findPrintHistory", param)); //출력 이력
        model.addAttribute("resultPrintCnt", sqlDao.count("countPrintHistory", param)); //출력 이력 건수
        param.put("currMenu", "사례별 정보");
        super.doList(paramCtx, "findPrintHistory", "countPrintHistory");
    }

    public void casePrint(ParameterContext paramCtx) throws Exception{
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("userId", user.getUserId());
        
        param.put("printYN", "Y");
        param.put("firstIndex", 0);
        param.put("recordCountPerPage", sqlDao.count("countPrintHistory", param));
        
        model.addAttribute("resultAttkrList", sqlDao.findAll("findCaseAttkrList", param)); //가해자정보
        model.addAttribute("resultPassList", sqlDao.findAll("findCasePassList2", param));   //지원서비스
        model.addAttribute("resultOnePassList",  sqlDao.findOne("findPassView", param));   //지원서비스(한개)
        model.addAttribute("resultPassCnt", sqlDao.count("countCasePass", param));  //지원서비스 건수
        model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
        model.addAttribute("result", sqlDao.findOne("findOneCase", param));//사례 상세
        model.addAttribute("resultCenter", sqlDao.findOne("findCenterInfo", param)); //센터 정보
        model.addAttribute("resultPrint", sqlDao.findAll("findPrintHistory", param)); //출력 이력
        model.addAttribute("resultFile", sqlDao.findAll("findOneFile", param)); //첨부 리스트
        model.addAttribute("resultContact", sqlDao.findAll("fineOneContact", param)); //연락처 리스트
        model.addAttribute("resultCaseHistory", sqlDao.findAll("findCaseHistory", param)); //관리 이력
        model.addAttribute("resultBookCnt", sqlDao.count("countCaseBook", param));  //북마크 건수
        model.addAttribute("resultServ", sqlDao.findOne("findOneCaseServ", param)); //사례부가정보

        if(param.getString("thisSeq").equals("print1-2")) {
            param.put("phName", "피해상담사실확인서");
            param.put("phGroup", "1-2");
        }else if(param.getString("thisSeq").equals("print1-3")) {
            param.put("phName", "센터이용확인서");
            param.put("phGroup", "1-3");
        }else if(param.getString("thisSeq").equals("print1-4")) {
            param.put("phName", "성폭력피해법률구조신청서");
            param.put("phGroup", "1-4");
        }else if(param.getString("thisSeq").equals("print1-6")) {
            param.put("phName", "성폭력사건보고");
            param.put("phGroup", "1-6");
        }else if(param.getString("thisSeq").equals("print3-1")) {
            param.put("phName", "사례등록지(사례기본정보)");
            param.put("phGroup", "3-1");
        }else if(param.getString("thisSeq").equals("print3-2")) {
            param.put("phName", "지원서비스 경과 기록지(요약)");
            param.put("phGroup", "3-2");
        }else if(param.getString("thisSeq").equals("print3-3")) {
            param.put("phName", "지원서비스 경과 기록지");
            param.put("phGroup", "3-3");
        }else if(param.getString("thisSeq").equals("print3-4")) {
            param.put("phName", "연계의뢰서");
            param.put("phGroup", "3-4");
        }else if(param.getString("thisSeq").equals("print4-3")) {
            param.put("phName", "사례부가정보 기록지");
            param.put("phGroup", "4-3");
        }else if(param.getString("thisSeq").equals("print4-4")) {
            param.put("phName", "사례정보 - 첨부");
            param.put("phGroup", "4-4");
        }else if(param.getString("thisSeq").equals("print4-5")) {
            param.put("phName", "사례정보 - 출력");
            param.put("phGroup", "4-5");
        }else if(param.getString("thisSeq").equals("print4-6")) {
            param.put("phName", "사례정보 - 연락처");
            param.put("phGroup", "4-6");
        }else if(param.getString("thisSeq").equals("print4-7")) {
            param.put("phName", "사례정보 - 관리");
            param.put("phGroup", "4-7");
        }
        
        //출력 히스토리 저장
        param.put("phSeq", sqlDao.count("getPhSeq", param)+1);
        param.put("userName",user.getUserNm());
        param.put("phGroupSeq", '0');

        insertHistory(param, "CASE", "P", "[자동입력] 사례를 출력했습니다");
        sqlDao.save("savePrintHistory", param);
    }
    
	public void caseDefault(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		model.addAttribute("result", sqlDao.findOne("findOneCase", param));// 사례 상세
		model.addAttribute("resultAttkrList", sqlDao.findAll("findCaseAttkrList", param)); // 가해자정보
	}

	public void caseUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());
		
		model.addAttribute("result", sqlDao.findOne("findOneUpdateCase", param)); // 사례 상세
		model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
    	model.addAttribute("resultCaseManager", sqlDao.findAll("findCaseManager", param)); //사례관리자 목록
	}
	
	public void caseUpdate2(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("loginUserId", user.getUserId());

		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
    	param.put("centerCode", resultCntr.getString("cntrCod"));


        insertHistory(param, "CASE", "U", "");
		
		//사례관리 업데이트2
		sqlDao.modify("updateCase2", param);
		
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

		// 메모 등록
		sqlDao.save("updateMemo", param);
		String goUrl = WebFactory.buildUrl("/bos/instance/case/view.do", param, "caseSeq", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "저장 되었습니다.", model);
		/*MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.update", null, Locale.getDefault()));*/
	}
	
	@UnpJsonView
	public void pageUnitChange(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String pageUnit = param.getString("pageUnit");
		
		if(pageUnit.equals("0")){
			pageUnit = "999999";
		}
		
		//param.put("pageUnit", param.getString("pageUnit"));
		model.addAttribute("pageUnit", pageUnit);
	}
	
	@UnpJsonView
	public void findRelCase(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue caseSeq = sqlDAO.findOne("findCaseRelSeqByCaseNumber", param);
		
		if(caseSeq.getString("caseSeq").length() != 0){
			model.addAttribute("caseSeq", caseSeq.getInt("caseSeq"));
		}
		
	}
	
	public void insertHistory(ZValue param, String chGroup, String chAction, String memo) throws Exception {
	    UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

	    param.put("chUserId", user.getUserId());
        if(param.getString("historyMemo") != null && param.getString("historyMemo") != "") {
            param.put("chMemo", param.getString("historyMemo"));
        }else {
            param.put("chMemo", memo);
        }
        param.put("chUserNm", user.getUserNm());
        param.put("chGroupSeq", param.getString("caseSeq"));
        param.put("chAction", chAction);
        param.put("chGroup", chGroup);
        
        sqlDao.save("saveCaseHistory", param);
	}
	
	@UnpJsonView
	public void countPassList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		int passTotCnt = 0;
	    
		if(param.get("caseSeq") != null &&  param.get("caseSeq") != "") {
		passTotCnt = (int) sqlDao.count("countCasePassList2", param);
		}else {
			passTotCnt = (int) sqlDao.count("countAllCasePassList2", param);
		}
		
		model.addAttribute("totcnt", passTotCnt);
	}
}
