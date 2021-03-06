package site.unp.cms.service.stats.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.mysql.fabric.xmlrpc.base.Array;

import site.unp.cms.dao.instance.CaseDAO;
import site.unp.cms.dao.member.MemberDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.stats.StatsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(sqlDaoRef = "statsDAO"
        , pageQueryData = "searchCnd,searchWrd,sdate,edate,menuNo,searchDate,caseSeq,smonth,emonth"
        , listenerAndMethods = {
        		 "accessLogListener=insert,update,delete" }
		)

@CommonServiceLink(desc = "통계관리")
@Service
public class StatsServiceImpl extends DefaultCrudServiceImpl implements StatsService {
	
    @Resource(name="memberDAO")
    private MemberDAO memberDAO;
	

	@Override
    public void casestats(ParameterContext paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		/*model.addAttribute("result", sqlDao.findAll("findAllStats"));*/
        /*super.list(paramCtx);*/
    }
	
	@UnpJsonView
	public void caseAgeSetting(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		
		long ageSettingCnt = sqlDao.count("AgeSettingCnt", param);
		ZValue ageSetting = null;
		if (ageSettingCnt > 0) {
			 ageSetting = sqlDao.findOne("findAgeSetting", param);
		} 
		
		model.addAttribute("ageSetting", ageSetting);
	}
	
	@UnpJsonView
	public void casestatsSearch(ParameterContext paramCtx) throws Exception {

		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		/*System.out.println(param);*/

		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) ){
				param.put("isCenter", "true");
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) || "OA".equals(user.getAuthorCd()) ){
				param.put("isAdmin", "true");
				model.addAttribute("isAdmin", true);
			}
		}
		
		boolean chkNonSelect = false;
		
		String codegWhere =  "0";
		
		if("VICTIM_AGE".equals(param.get("CASE_TYPE")) ) {
			int codeCnt = (int) sqlDao.count("findStatCodeCount", param);
			if(codeCnt > 0) {
				codegWhere = "1";
				param.put("codegWhere", codegWhere);
					
			}
		}
		/*System.out.println(param);*/
		List<ZValue> codeResult = sqlDao.findAll("findStatCode", param);
		String[] code1 = null;
		
		List<String> code = new ArrayList<String>();
		List<String> code2 = new ArrayList<String>();
		List<String> code3 = new ArrayList<String>();
		List<String> code4 = new ArrayList<String>();
		
		String age = param.getString("CASE_TYPE");
		
		for(int i=0; i<codeResult.size(); i++){
			// 아이디 특수기호 방지
			if (age.equals("VICTIM_AGE")) {
				code.add(i, "Agestats"+i);
			} else {
				code.add(i, codeResult.get(i).getString("cd"));
			}
			code3.add(i, codeResult.get(i).getString("cdNm2"));
			code4.add(i, codeResult.get(i).getString("cdNm3"));
		}
		for(int i=0; i<codeResult.size(); i++){
			code2.add(i, String.format("%02d", codeResult.get(i).getInt("cd")) );
		}
		
		String caseTypeValue = param.getString("CHEK_CASE_TYPE_VALUE");
		code1 = caseTypeValue.split(",");
		
		
		param.put("code1", code1);
		
		param.put("code", code);
		param.put("code2", code2);
		param.put("code3", code3);
		param.put("code4", code4);
		
		
		
		
		
		if(param.getString("cond_frdate").equals("")){
			param.put("frdate", "2000-01-01");
			param.put("frdateYear", "2000");
		} else {
			String arr_frdate[]	 = param.getString("cond_frdate").split("-");
			
			param.put("frdateYear", Integer.parseInt(arr_frdate[0]));
			param.put("frdate", param.getString("cond_frdate"));
		}

		if(param.getString("cond_todate").equals("")){
			param.put("todate", "2099-12-31");
			param.put("todateYear", "2099");
		} else {
			String arr_todate[]	 = param.getString("cond_todate").split("-");
			
			param.put("todateYear", Integer.parseInt(arr_todate[0]));
			param.put("todate", param.getString("cond_todate"));
		}
		
		switch (param.getString("CASE_TYPE")) {
		
		case "CS_TYPE_01_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_02_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_03_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_05_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_06_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_11_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		case "CS_TYPE_01":
			if("0104".equals(param.getString("CS_TYPE_01_SUB") ) ) {
				param.put("codegCode", "CSAC");
				param.put("codeGroup", "0104");
				param.put("fieldName", "CASE_TYPE_SUB");
			}else {
				param.put("codegCode", "CSACG");
				param.put("codeGroup", "01");
				param.put("fieldName", "CASE_TYPE_GRP");
			}
			break;
		case "CS_TYPE_02":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "02");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_03":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "03");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_05":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "05");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_06":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "06");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_11":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "11");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CASE_JUPSOO":
			param.put("codegCode", "CS20");
			param.put("fieldName", "CASE_JUPSOO");
			break;
		case "CLIENT_REL_GRP":
			switch (param.getString("CLIENT_REL_GRP")) {
				case "20":
					param.put("fieldName", "CLIENT_REL");
					param.put("codegCode", "CS24");
					param.put("codeGroup", "20");
					break;
				case "30":
					param.put("fieldName", "CLIENT_REL");
					param.put("codegCode", "CS24");
					param.put("codeGroup", "30");
					break;
				default:
					param.put("fieldName", "CLIENT_REL_GRP");
					param.put("codegCode", "CS24G");
					break;
			}
			
			/*param.put("fieldName", "CLIENT_REL");*/
			/*param.put("fieldName", "CLIENT_REL_GRP");*/
			break;
		case "VICTIM_AREA_GRP":
			
			break;
		case "VICTIM_AREA":
			if(param.getString("VICTIM_AREA_GRP").isEmpty() || "".equals(param.getString("VICTIM_AREA_GRP"))) {
				param.put("codegCode", "HM46");
				param.put("fieldName", "VICTIM_AREA");
			}else {
				param.put("codegCode", "HM47");
				param.put("fieldName", "VICTIM_AREA_SUB");
			}
			break;
		case "CASE_ROUTE_GRP":
			switch (param.getString("CASE_ROUTE_GRP")) {
			case "10":
				param.put("fieldName", "CASE_ROUTE");
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "10");
				break;
			case "20":
				param.put("fieldName", "CASE_ROUTE");
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "20");
				break;
			case "30":
				param.put("fieldName", "CASE_ROUTE");
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "30");
				break;
			default:
				param.put("fieldName", "CASE_ROUTE_GRP");
				param.put("codegCode", "CSRTG");
				break;
			}
			
			break;
		case "CASE_ROUTE_GRP_AGE":
    		param.put("fieldName", "VICTIM_AGE");
			param.put("codegCode", "VTAG");
			break;
		case "DMG_STATE_YN":
			param.put("codegCode", "CDYN");
			param.put("fieldName", "DMG_STATE_YN");
			break;
		case "DMG_STATE":
			param.put("codegCode", "CSDG");
			param.put("fieldName", "DMG_STATE");
			param.put("checkType", "check");
			break;
		case "CASE_HELP":
			param.put("codegCode", "CDHP");
			param.put("fieldName", "CASE_HELP");
			param.put("checkType", "check");
			break;
		case "ATTKR_STATE_YN":
			param.put("codegCode", "CDYN");
			param.put("fieldName", "ATTKR_STATE_YN");
			break;
		case "ATTKR_STATE":
			param.put("codegCode", "ATST");
			param.put("fieldName", "ATTKR_STATE");
			param.put("checkType", "check");
			break;
		case "ATTKR_AGE":
			param.put("codegCode", "ATAG");
			param.put("fieldName", "ATTKR_AGE");
			break;
		case "VICTIM_AGE":
			param.put("codegCode", "VTAG");
			param.put("fieldName", "VICTIM_AGE");
			break;
		default:
			param.put("codegCode", "CSAB");
			param.put("fieldName", "CASE_TYPE");
			break;
		}
		
		param.put("searchType4Date", "case");
		
		String[] arr_CNTR_COD = param.getString("arr_CNTR_COD").split(",");
		param.put("arrCntrCod", arr_CNTR_COD);
		
		List<ZValue> caseStats = sqlDao.findAll("findStats", param);
		
		
		
		
		List<ZValue> caseStatd = null;
		if(param.getString("dsaYN").equals("Y")){
			param.put("dsa", param.getString("dsaYN"));
			caseStatd = sqlDao.findAll("findStats", param);
			
			
			/*System.out.println("==========================================");
			System.out.println(caseStatd);*/
		}
		
		/*System.out.println(caseStats);
		System.out.println(caseStatd);*/
		//################# 통계 #################
		
		int[][] sumArray0 = new int[300][4];
		int[][] sumArray1 = new int[300][4];
		int[][] sumArray2 = new int[300][4];
		int[][] sumArray3 = new int[300][4];
		
		int[][] sumDrray0 = new int[300][4];
		int[][] sumDrray1 = new int[300][4];
		int[][] sumDrray2 = new int[300][4];
		int[][] sumDrray3 = new int[300][4];
		
		int codeCount2;
		int codeCount = codeResult.size();
		
		/*if(!chkNonSelect){
			codeCount2 = codeCount + 8 - 1; //필드들 + 전체
		} else {
			codeCount2 = codeCount + 8; //필드들 + 전체 + 미지정
		}*/
		/*System.out.println(param);*/
		
		String[] codename = new String[300];
		
		codename[6] = "All";
		long ageSettingCnt = sqlDao.count("AgeSettingCnt", param);
		
		
		if("CASE_TIME_INTVL".equals(param.getString("CASE_TYPE"))) {
			for (int i = 0; i < 24; i++) {
				codename[i+7]= String.format("%02d", i);
			}
			codename[7 + 24] = "Non";
		}else {
			
			if("VICTIM_AGE".equals(param.getString("CASE_TYPE"))) {
				/*System.out.println(ageSettingCnt);*/
				codeCount = (int)ageSettingCnt;
				
				if(ageSettingCnt > 0) {
					for(int i=0; i<code.size(); i++){
						codename[i+7] =  code.get(i);
					}
				}else {
					for(int i=0; i<code.size(); i++){
						codename[i+7] = code.get(i);
					}
				}
			}else {
				for(int i=0; i<code.size(); i++){
					codename[i+7] = code.get(i);
				}
			}
			codename[7 + code.size()] = "Non";
			
		}
		
		if(!chkNonSelect){
			if("VICTIM_AGE".equals(param.getString("CASE_TYPE"))) {
				/*System.out.println("ageSettingCnt");
				System.out.println(ageSettingCnt);*/
				codeCount2 = (int) (ageSettingCnt + 7);
			}else {
				codeCount2 = codeCount + 8 - 1; //필드들 + 전체
			}
		} else {
			if("VICTIM_AGE".equals(param.getString("CASE_TYPE"))) {
				codeCount2 = (int) (ageSettingCnt + 8);
			}else {
				codeCount2 = codeCount + 8; //필드들 + 전체 + 미지정
			}
		}
		 
		
		if("CASE_TIME_INTVL".equals(param.getString("CASE_TYPE"))) {
			codeCount = 24;
			if(!chkNonSelect){
				codeCount2 = codeCount + 8 - 1; //필드들 + 전체
			} else {
				codeCount2 = codeCount + 8; //필드들 + 전체 + 미지정
			}
		}
		
		if("VICTIM_AGE".equals(param.getString("CASE_TYPE"))) {
			
			for (int j = 0; j < codename.length; j++) {
				if(codename[j] != null ) {
					/*System.out.println(codename[j]);*/
					codename[j] = codename[j].substring(0,1).toUpperCase() + codename[j].substring(1);
					codename[j] = codename[j].replace("_", "");
				}
			}
		}
		
		/*System.out.println("=====");
		System.out.println(codeCount2);*/
		
		//전체 합계
		for(int i=0; i<caseStats.size(); i++){
			for(int t=6; t<=codeCount2; t++){
				
				sumArray0[t][0] = sumArray0[t][0] + caseStats.get(i).getInt("fieldName" + codename[t]);
				
				if(param.getString("dsaYN").equals("Y")){
					if(caseStatd.size() >i ) {
						sumDrray0[t][0] = sumDrray0[t][0] + caseStatd.get(i).getInt("fieldName" + codename[t]);
					}
				}
				
				//남자 전체 합계 산출
				if(caseStats.get(i).getString("victimSex").equals("M")){
					sumArray0[t][1] = sumArray0[t][1] + caseStats.get(i).getInt("fieldName" + codename[t]);
					/*System.out.println(codename[t]);*/
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							sumDrray0[t][1] = sumDrray0[t][1] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
				
				//여자 전체 합계 산출
				if(caseStats.get(i).getString("victimSex").equals("F")){
					sumArray0[t][2] = sumArray0[t][2] + caseStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							
							sumDrray0[t][2] = sumDrray0[t][2] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
				
				//알수없음 전체 합계 산출
				if(caseStats.get(i).getString("victimSex").equals("E")){
					sumArray0[t][3] = sumArray0[t][3] + caseStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							sumDrray0[t][3] = sumDrray0[t][3] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
				
				//1. 위기지원형 소계
				if(caseStats.get(i).getString("cgroupCode").equals("1")){
					sumArray1[t][0] = sumArray1[t][0] + caseStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							sumDrray1[t][0] = sumDrray1[t][0] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//남자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("M")){
						sumArray1[t][1] = sumArray1[t][1] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray1[t][1] = sumDrray1[t][1] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//여자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("F")){
						sumArray1[t][2] = sumArray1[t][2] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray1[t][2] = sumDrray1[t][2] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//알수없음 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("E")){
						sumArray1[t][3] = sumArray1[t][3] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray1[t][3] = sumDrray1[t][3] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
				}
				
				//2. 아동형 소계
				if(caseStats.get(i).getString("cgroupCode").equals("2")){
					sumArray2[t][0] = sumArray2[t][0] + caseStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							sumDrray2[t][0] = sumDrray2[t][0] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//남자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("M")){
						sumArray2[t][1] = sumArray2[t][1] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray2[t][1] = sumDrray2[t][1] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//여자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("F")){
						sumArray2[t][2] = sumArray2[t][2] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray2[t][2] = sumDrray2[t][2] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//알수없음 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("E")){
						sumArray2[t][3] = sumArray2[t][3] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() >i ) {
								sumDrray2[t][3] = sumDrray2[t][3] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
				}
				
				//3. 통합형 소계
				if(caseStats.get(i).getString("cgroupCode").equals("3")){
					sumArray3[t][0] = sumArray3[t][0] + caseStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						if(caseStatd.size() >i ) {
							sumDrray3[t][0] = sumDrray3[t][0] + caseStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//남자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("M")){
						sumArray3[t][1] = sumArray3[t][1] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() > i ) {
								sumDrray3[t][1] = sumDrray3[t][1] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//여자 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("F")){
						sumArray3[t][2] = sumArray3[t][2] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() > i ) {
								sumDrray3[t][2] = sumDrray3[t][2] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
					
					//알수없음 전체 합계 산출
					if(caseStats.get(i).getString("victimSex").equals("E")){
						sumArray3[t][3] = sumArray3[t][3] + caseStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							if(caseStatd.size() > i ) {
								sumDrray3[t][3] = sumDrray3[t][3] + caseStatd.get(i).getInt("fieldName" + codename[t]);
							}
						}
					}
				}
			}
		}
		
		
		
		
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("caseStats", caseStats);
		model.addAttribute("caseStatd", caseStatd);
		model.addAttribute("dsaYN", param.getString("dsaYN"));
		model.addAttribute("sexYN", param.getString("sexYN"));
		model.addAttribute("totYN", param.getString("totYN"));
		model.addAttribute("chkNonSelect", chkNonSelect);
		model.addAttribute("caseType", param.get("CASE_TYPE"));
		
		model.addAttribute("array0", sumArray0);
		model.addAttribute("drray0", sumDrray0);
		model.addAttribute("array1", sumArray1);
		model.addAttribute("drray1", sumDrray1);
		model.addAttribute("array2", sumArray2);
		model.addAttribute("drray2", sumDrray2);
		model.addAttribute("array3", sumArray3);
		model.addAttribute("drray3", sumDrray3);
		model.addAttribute("codeCount2", codeCount2);
		model.addAttribute("codename", codename);
	
		insertHistory(param);
	}
	
	@UnpJsonView
	public void caseAttkrStats(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) ){
				param.put("isCenter", "true");
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) || "OA".equals(user.getAuthorCd()) ){
				param.put("isAdmin", "true");
				model.addAttribute("isAdmin", true);
			}
		}
		
		boolean chkNonSelect = false;
		
		List<ZValue> codeResult = sqlDao.findAll("findStatCode2", param);
		List<String> code = new ArrayList<String>();
		
		for(int i=0; i<codeResult.size(); i++){
			code.add(i, codeResult.get(i).getString("cd"));
		}
		
		String caseTypeValue = param.getString("CHEK_CASE_TYPE_VALUE");
		String[] code1 = caseTypeValue.split(",");
		
		param.put("code", code);
		param.put("code1", code1);
		
		if(param.getString("cond_frdate").equals("")){
			param.put("frdate", "2000-01-01");
			param.put("frdateYear", "2000");
		} else {
			String arr_frdate[]	 = param.getString("cond_frdate").split("-");
			
			param.put("frdateYear", Integer.parseInt(arr_frdate[0]));
			param.put("frdate", param.getString("cond_frdate"));
		}

		if(param.getString("cond_todate").equals("")){
			param.put("todate", "2099-12-31");
			param.put("todateYear", "2099");
		} else {
			String arr_todate[]	 = param.getString("cond_todate").split("-");
			
			param.put("todateYear", Integer.parseInt(arr_todate[0]));
			param.put("todate", param.getString("cond_todate"));
		}
		
		switch (param.getString("CASE_TYPE")) {
		case "CS_TYPE_01":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "01");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_02":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "02");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_03":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "03");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CS_TYPE_11":
			param.put("codegCode", "CSACG");
			param.put("codeGroup", "11");
			param.put("fieldName", "CASE_TYPE_GRP");
			break;
		case "CASE_JUPSOO":
			param.put("codegCode", "CS20");
			param.put("fieldName", "CASE_JUPSOO");
			break;
		case "CLIENT_REL_GRP":
			switch (param.getString("CLIENT_REL_GRP")) {
			case "20":
				param.put("codegCode", "CS24");
				param.put("codeGroup", "20");
				break;
			case "30":
				param.put("codegCode", "CS24");
				param.put("codeGroup", "30");
				break;
			default:
				param.put("codegCode", "CS24G");
				break;
			}
			param.put("fieldName", "CLIENT_REL_GRP");
			break;
		case "VICTIM_AREA":
			param.put("codegCode", "HM46");
			param.put("fieldName", "VICTIM_AREA");
			break;
		case "CASE_ROUTE_GRP":
			switch (param.getString("CASE_ROUTE_GRP")) {
			case "10":
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "10");
				break;
			case "20":
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "20");
				break;
			case "30":
				param.put("codegCode", "CSRT");
				param.put("codeGroup", "30");
				break;
			default:
				param.put("codegCode", "CSRTG");
				break;
			}
			param.put("fieldName", "CASE_ROUTE_GRP");
			break;
		case "DMG_STATE_YN":
			param.put("codegCode", "CDYN");
			param.put("fieldName", "DMG_STATE_YN");
			break;
		case "DMG_STATE":
			param.put("codegCode", "CSDG");
			param.put("fieldName", "DMG_STATE");
			break;
		case "CASE_HELP":
			param.put("codegCode", "CDHP");
			param.put("fieldName", "CASE_HELP");
			param.put("checkType", "check");
			break;
		case "ATTKR_STATE_YN":
			param.put("codegCode", "CDYN");
			param.put("fieldName", "ATTKR_STATE_YN");
			break;
		case "ATTKR_STATE":
			param.put("codegCode", "ATST");
			param.put("fieldName", "ATTKR_STATE");
			param.put("checkType", "check");
			break;
		case "ATTKR_AGE":
			param.put("codegCode", "ATAG");
			param.put("fieldName", "ATTKR_AGE");
			break;
		default:
			param.put("codegCode", "CSAB");
			param.put("fieldName", "CASE_TYPE");
			break;
		}
		
		param.put("searchType4Date", "case");
		
		String[] arr_CNTR_COD = param.getString("arr_CNTR_COD").split(",");
		param.put("arrCntrCod", arr_CNTR_COD);
		
		List<ZValue> attkrStats = sqlDao.findAll("findAttkrStats", param);
		
		List<ZValue> attkrStatd = null;
		if(param.getString("dsaYN").equals("Y")){
			param.put("dsa", param.getString("dsaYN"));
			attkrStatd = sqlDao.findAll("findAttkrStats", param);
		}
		
		//################# 통계 #################
		
		int[][] sumArray0 = new int[100][4];
		int[][] sumArray1 = new int[100][4];
		int[][] sumArray2 = new int[100][4];
		int[][] sumArray3 = new int[100][4];
		
		int[][] sumDrray0 = new int[100][4];
		int[][] sumDrray1 = new int[100][4];
		int[][] sumDrray2 = new int[100][4];
		int[][] sumDrray3 = new int[100][4];
		
		int codeCount2;
		if(!chkNonSelect){
			codeCount2 = codeResult.size() + 8 - 1; //필드들 + 전체
		} else {
			codeCount2 = codeResult.size() + 8; //필드들 + 전체 + 미지정
		}
		
		String[] codename = new String[100];
		
		codename[6] = "All";
		for(int i=0; i<code.size(); i++){
			codename[i+7] = code.get(i);
		}
		codename[7 + code.size()] = "Non";
		
		//전체 합계
		for(int i=0; i<attkrStats.size(); i++){
			for(int t=6; t<=codeCount2; t++){
				sumArray0[t][0] = sumArray0[t][0] + attkrStats.get(i).getInt("fieldName" + codename[t]);
				
				if(param.getString("dsaYN").equals("Y")){
					sumDrray0[t][0] = sumDrray0[t][0] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
				}
				
				//남자 전체 합계 산출
				if(attkrStats.get(i).getString("victimSex").equals("M")){
					sumArray0[t][1] = sumArray0[t][1] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][1] = sumDrray0[t][1] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
				}
				
				//여자 전체 합계 산출
				if(attkrStats.get(i).getString("victimSex").equals("F")){
					sumArray0[t][2] = sumArray0[t][2] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][2] = sumDrray0[t][2] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
				}
				
				//알수없음 전체 합계 산출
				if(attkrStats.get(i).getString("victimSex").equals("E")){
					sumArray0[t][3] = sumArray0[t][3] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][3] = sumDrray0[t][3] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
				}
				
				//1. 위기지원형 소계
				if(attkrStats.get(i).getString("cgroupCode").equals("1")){
					sumArray1[t][0] = sumArray1[t][0] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray1[t][0] = sumDrray1[t][0] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("M")){
						sumArray1[t][1] = sumArray1[t][1] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][1] = sumDrray1[t][1] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("F")){
						sumArray1[t][2] = sumArray1[t][2] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][2] = sumDrray1[t][2] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("E")){
						sumArray1[t][3] = sumArray1[t][3] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][3] = sumDrray1[t][3] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
				
				//2. 아동형 소계
				if(attkrStats.get(i).getString("cgroupCode").equals("2")){
					sumArray2[t][0] = sumArray2[t][0] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray2[t][0] = sumDrray2[t][0] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("M")){
						sumArray2[t][1] = sumArray2[t][1] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][1] = sumDrray2[t][1] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("F")){
						sumArray2[t][2] = sumArray2[t][2] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][2] = sumDrray2[t][2] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("E")){
						sumArray2[t][3] = sumArray2[t][3] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][3] = sumDrray2[t][3] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
				
				//3. 통합형 소계
				if(attkrStats.get(i).getString("cgroupCode").equals("3")){
					sumArray3[t][0] = sumArray3[t][0] + attkrStats.get(i).getInt("fieldName" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray3[t][0] = sumDrray3[t][0] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("M")){
						sumArray3[t][1] = sumArray3[t][1] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][1] = sumDrray3[t][1] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("F")){
						sumArray3[t][2] = sumArray3[t][2] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][2] = sumDrray3[t][2] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(attkrStats.get(i).getString("victimSex").equals("E")){
						sumArray3[t][3] = sumArray3[t][3] + attkrStats.get(i).getInt("fieldName" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][3] = sumDrray3[t][3] + attkrStatd.get(i).getInt("fieldName" + codename[t]);
						}
					}
				}
			}
		}
		
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("attkrStats", attkrStats);
		model.addAttribute("attkrStatd", attkrStatd);
		model.addAttribute("dsaYN", param.getString("dsaYN"));
		model.addAttribute("sexYN", param.getString("sexYN"));
		model.addAttribute("chkNonSelect", chkNonSelect);
		
		model.addAttribute("array0", sumArray0);
		model.addAttribute("drray0", sumDrray0);
		model.addAttribute("array1", sumArray1);
		model.addAttribute("drray1", sumDrray1);
		model.addAttribute("array2", sumArray2);
		model.addAttribute("drray2", sumDrray2);
		model.addAttribute("array3", sumArray3);
		model.addAttribute("drray3", sumDrray3);
		model.addAttribute("codeCount2", codeCount2);
		model.addAttribute("codename", codename);
		
		insertHistory(param);
	}
	
	@Override
	public void casejoin(ParameterContext paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("result", sqlDao.findAll("findAllStats"));
		
		
		
		
		
		
		
		
		
		
		
	}
	
	@Override
	public void spass(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
	}
	
	@UnpJsonView
	public void sPassStats(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if ("".equals(param.getString("centerGubunCodeSub"))) {
				param.put("centerCode", user.getCenterCode());
			}else {
				param.put("centerCode", param.getString("centerGubunCodeSub"));
			}
			
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) ){
				param.put("isCenter", "true");
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) || "OA".equals(user.getAuthorCd()) ){
				param.put("isAdmin", "true");
				model.addAttribute("isAdmin", true);
			}
		}
		
		if(param.getString("CHEK_CASE_TYPE_VALUE").length() != 0){
			String[] caseTypeChk = param.getString("CHEK_CASE_TYPE_VALUE").split(",");
			param.put("caseTypeChk", caseTypeChk);
		}
		
		if(param.getString("cond_frdate").equals("")){
			param.put("frdate", "2000-01-01");
		} else {
			param.put("frdate", param.getString("cond_frdate"));
		}

		if(param.getString("cond_todate").equals("")){
			param.put("todate", "2099-12-31");
		} else {
			param.put("todate", param.getString("cond_todate"));
		}
		
		param.put("searchType4Date", "pass");
		
		String[] arr_CNTR_COD = param.getString("arr_CNTR_COD").split(",");
		param.put("arrCntrCod", arr_CNTR_COD);
		
		if(param.getString("PASS_TYPE").length() == 0){
			param.put("codegCode", "PSA1");
		}
		param.put("fieldName", "PASS_TYPE");
		param.put("passTypeDepth", "A");
		
		if(!param.getString("codegCode").equals("PSA1")){
			param.put("codeGroup", param.getString("PASS_TYPE"));
			if(param.getString("SUB1_DATA").length() == 0){
				param.put("codegCode", "PSA2");
			}
			param.put("fieldName", "SUB1_DATA");
			param.put("passTypeDepth", "B");
			
			if(!param.getString("codegCode").equals("PSA2")){
				param.put("codeGroup", param.getString("SUB1_DATA"));
				param.put("codegCode", "PSA3");
				param.put("fieldName", "SUB2_DATA");
				param.put("passTypeDepth", "C");
			}
		}
		
		List<ZValue> codeResult = sqlDao.findAll("findStatCode2", param);
		List<String> code = new ArrayList<String>();
		
		for(int i=0; i<codeResult.size(); i++){
			code.add(i, codeResult.get(i).getString("cd"));
		}
		
		param.put("code", code);
		
		List<ZValue> sPassStats = sqlDao.findAll("findSPassStats", param);
		
		List<ZValue> sPassStatd = null;
		if(param.getString("dsaYN").equals("Y")){
			param.put("dsa", param.getString("dsaYN"));
			sPassStatd = sqlDao.findAll("findSPassStats", param);
		}
		
		//################# 통계 #################
		
		int[][] sumArray0 = new int[100][4];
		int[][] sumArray1 = new int[100][4];
		int[][] sumArray2 = new int[100][4];
		int[][] sumArray3 = new int[100][4];
		
		int[][] sumDrray0 = new int[100][4];
		int[][] sumDrray1 = new int[100][4];
		int[][] sumDrray2 = new int[100][4];
		int[][] sumDrray3 = new int[100][4];
		
		int codeCount2 = codeResult.size() + 7; //필드들 + 전체 + 미지정
		
		String[] codename = new String[100];
		
		codename[6] = "all";
		for(int i=0; i<code.size(); i++){
			codename[i+7] = code.get(i).toLowerCase();
		}
		
		//전체 합계
		for(int i=0; i<sPassStats.size(); i++){
			
			for(int t=6; t<=codeCount2; t++){
				sumArray0[t][0] = sumArray0[t][0] + sPassStats.get(i).getInt("fieldname" + codename[t]);
				
				if(param.getString("dsaYN").equals("Y")){
					sumDrray0[t][0] = sumDrray0[t][0] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
				}
				
				//남자 전체 합계 산출
				if(sPassStats.get(i).getString("victimSex").equals("M")){
					sumArray0[t][1] = sumArray0[t][1] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][1] = sumDrray0[t][1] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//여자 전체 합계 산출
				if(sPassStats.get(i).getString("victimSex").equals("F")){
					sumArray0[t][2] = sumArray0[t][2] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][2] = sumDrray0[t][2] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//알수없음 전체 합계 산출
				if(sPassStats.get(i).getString("victimSex").equals("E")){
					sumArray0[t][3] = sumArray0[t][3] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][3] = sumDrray0[t][3] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//1. 위기지원형 소계
				if(sPassStats.get(i).getString("cgroupCode").equals("1")){
					sumArray1[t][0] = sumArray1[t][0] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray1[t][0] = sumDrray1[t][0] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("M")){
						sumArray1[t][1] = sumArray1[t][1] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][1] = sumDrray1[t][1] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("F")){
						sumArray1[t][2] = sumArray1[t][2] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][2] = sumDrray1[t][2] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("E")){
						sumArray1[t][3] = sumArray1[t][3] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][3] = sumDrray1[t][3] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//2. 아동형 소계
				if(sPassStats.get(i).getString("cgroupCode").equals("2")){
					sumArray2[t][0] = sumArray2[t][0] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray2[t][0] = sumDrray2[t][0] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("M")){
						sumArray2[t][1] = sumArray2[t][1] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][1] = sumDrray2[t][1] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("F")){
						sumArray2[t][2] = sumArray2[t][2] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][2] = sumDrray2[t][2] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("E")){
						sumArray2[t][3] = sumArray2[t][3] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][3] = sumDrray2[t][3] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//3. 통합형 소계
				if(sPassStats.get(i).getString("cgroupCode").equals("3")){
					sumArray3[t][0] = sumArray3[t][0] + sPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray3[t][0] = sumDrray3[t][0] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("M")){
						sumArray3[t][1] = sumArray3[t][1] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][1] = sumDrray3[t][1] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("F")){
						sumArray3[t][2] = sumArray3[t][2] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][2] = sumDrray3[t][2] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(sPassStats.get(i).getString("victimSex").equals("E")){
						sumArray3[t][3] = sumArray3[t][3] + sPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][3] = sumDrray3[t][3] + sPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
			}
		}
		
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("sPassStats", sPassStats);
		model.addAttribute("sPassStatd", sPassStatd);
		model.addAttribute("dsaYN", param.getString("dsaYN"));
		model.addAttribute("sexYN", param.getString("sexYN"));
		model.addAttribute("totYN", param.getString("totYN"));
		model.addAttribute("termType", param.getString("term_type"));
		
		model.addAttribute("array0", sumArray0);
		model.addAttribute("drray0", sumDrray0);
		model.addAttribute("array1", sumArray1);
		model.addAttribute("drray1", sumDrray1);
		model.addAttribute("array2", sumArray2);
		model.addAttribute("drray2", sumDrray2);
		model.addAttribute("array3", sumArray3);
		model.addAttribute("drray3", sumDrray3);
		model.addAttribute("codeCount2", codeCount2);
		model.addAttribute("codename", codename);
		
		insertHistory(param);
	}
	
	@Override
	public void vpass(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
	}
	
	@UnpJsonView
	public void vPassStats(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) ){
				param.put("isCenter", "true");
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) || "OA".equals(user.getAuthorCd()) ){
				param.put("isAdmin", "true");
				model.addAttribute("isAdmin", true);
			}
		}
		
		if(param.getString("CHEK_CASE_TYPE_VALUE").length() != 0){
			String[] caseTypeChk = param.getString("CHEK_CASE_TYPE_VALUE").split(",");
			param.put("caseTypeChk", caseTypeChk);
		}
		
		if(param.getString("cond_frdate").equals("")){
			param.put("frdate", "2000-01-01");
		} else {
			param.put("frdate", param.getString("cond_frdate"));
		}

		if(param.getString("cond_todate").equals("")){
			param.put("todate", "2099-12-31");
		} else {
			param.put("todate", param.getString("cond_todate"));
		}
		
		param.put("searchType4Date", "pass");
		
		String[] arr_CNTR_COD = param.getString("arr_CNTR_COD").split(",");
		param.put("arrCntrCod", arr_CNTR_COD);
		
		if(param.getString("PASS_TYPE").length() == 0){
			param.put("codegCode", "PSA1");
		}
		
		param.put("passTypeDepth", "A");
		
		if(!param.getString("codegCode").equals("PSA1")){
			param.put("codeGroup", param.getString("PASS_TYPE"));
			if(param.getString("SUB1_DATA").length() == 0){
				param.put("codegCode", "PSA2");
			}
			param.put("fieldName", "SUB1_DATA");
			param.put("passTypeDepth", "B");
			
			if(!param.getString("codegCode").equals("PSA2")){
				param.put("codeGroup", param.getString("SUB1_DATA"));
				param.put("codegCode", "PSA3");
				param.put("fieldName", "SUB2_DATA");
				param.put("passTypeDepth", "C");
			}
		}
		
		List<ZValue> codeResult = sqlDao.findAll("findStatCode2", param);
		List<String> code = new ArrayList<String>();
		
		for(int i=0; i<codeResult.size(); i++){
			code.add(i, codeResult.get(i).getString("cd"));
		}
		
		param.put("code", code);
		
		List<ZValue> vPassStats = sqlDao.findAll("findVPassStats", param);
		
		List<ZValue> vPassStatd = null;
		if(param.getString("dsaYN").equals("Y")){
			param.put("dsa", param.getString("dsaYN"));
			vPassStatd = sqlDao.findAll("findVPassStats", param);
		}
		
		//################# 통계 #################
		
		int[][] sumArray0 = new int[100][4];
		int[][] sumArray1 = new int[100][4];
		int[][] sumArray2 = new int[100][4];
		int[][] sumArray3 = new int[100][4];
		
		int[][] sumDrray0 = new int[100][4];
		int[][] sumDrray1 = new int[100][4];
		int[][] sumDrray2 = new int[100][4];
		int[][] sumDrray3 = new int[100][4];
		
		int codeCount2 = 6; //필드들 + 전체 + 미지정
		
		String[] codename = new String[100];
		
		codename[6] = "all";
		for(int i=0; i<code.size(); i++){
		}
		
		//전체 합계
		for(int i=0; i<vPassStats.size(); i++){
			
			for(int t=6; t<=codeCount2; t++){
				sumArray0[t][0] = sumArray0[t][0] + vPassStats.get(i).getInt("fieldname" + codename[t]);
				
				if(param.getString("dsaYN").equals("Y")){
					sumDrray0[t][0] = sumDrray0[t][0] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
				}
				
				//남자 전체 합계 산출
				if(vPassStats.get(i).getString("victimSex").equals("M")){
					sumArray0[t][1] = sumArray0[t][1] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][1] = sumDrray0[t][1] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//여자 전체 합계 산출
				if(vPassStats.get(i).getString("victimSex").equals("F")){
					sumArray0[t][2] = sumArray0[t][2] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][2] = sumDrray0[t][2] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//알수없음 전체 합계 산출
				if(vPassStats.get(i).getString("victimSex").equals("E")){
					sumArray0[t][3] = sumArray0[t][3] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][3] = sumDrray0[t][3] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//1. 위기지원형 소계
				if(vPassStats.get(i).getString("cgroupCode").equals("1")){
					sumArray1[t][0] = sumArray1[t][0] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray1[t][0] = sumDrray1[t][0] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("M")){
						sumArray1[t][1] = sumArray1[t][1] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][1] = sumDrray1[t][1] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("F")){
						sumArray1[t][2] = sumArray1[t][2] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][2] = sumDrray1[t][2] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("E")){
						sumArray1[t][3] = sumArray1[t][3] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][3] = sumDrray1[t][3] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//2. 아동형 소계
				if(vPassStats.get(i).getString("cgroupCode").equals("2")){
					sumArray2[t][0] = sumArray2[t][0] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray2[t][0] = sumDrray2[t][0] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("M")){
						sumArray2[t][1] = sumArray2[t][1] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][1] = sumDrray2[t][1] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("F")){
						sumArray2[t][2] = sumArray2[t][2] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][2] = sumDrray2[t][2] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("E")){
						sumArray2[t][3] = sumArray2[t][3] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][3] = sumDrray2[t][3] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//3. 통합형 소계
				if(vPassStats.get(i).getString("cgroupCode").equals("3")){
					sumArray3[t][0] = sumArray3[t][0] + vPassStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray3[t][0] = sumDrray3[t][0] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("M")){
						sumArray3[t][1] = sumArray3[t][1] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][1] = sumDrray3[t][1] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("F")){
						sumArray3[t][2] = sumArray3[t][2] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][2] = sumDrray3[t][2] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(vPassStats.get(i).getString("victimSex").equals("E")){
						sumArray3[t][3] = sumArray3[t][3] + vPassStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][3] = sumDrray3[t][3] + vPassStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
			}
		}
		
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("vPassStats", vPassStats);
		model.addAttribute("vPassStatd", vPassStatd);
		model.addAttribute("dsaYN", param.getString("dsaYN"));
		model.addAttribute("sexYN", param.getString("sexYN"));
		model.addAttribute("totYN", param.getString("totYN"));
		model.addAttribute("termType", param.getString("term_type"));
		
		model.addAttribute("array0", sumArray0);
		model.addAttribute("drray0", sumDrray0);
		model.addAttribute("array1", sumArray1);
		model.addAttribute("drray1", sumDrray1);
		model.addAttribute("array2", sumArray2);
		model.addAttribute("drray2", sumDrray2);
		model.addAttribute("array3", sumArray3);
		model.addAttribute("drray3", sumDrray3);
		model.addAttribute("codeCount2", codeCount2);
		model.addAttribute("codename", codename);
		
		insertHistory(param);
	}
	
	@Override
	public void serv(ParameterContext paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
	}
	
	@UnpJsonView
	public void servStats(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			
			if ("".equals(param.getString("centerGubunCodeSub"))) {
				param.put("centerCode", user.getCenterCode());
			}else {
				param.put("centerCode", param.getString("centerGubunCodeSub"));
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) ){
				param.put("isCenter", "true");
			}
			
			if("CA".equals(user.getAuthorCd()) || "CU".equals(user.getAuthorCd()) || "ROLE_SUPER".equals(user.getAuthorCd()) || "OA".equals(user.getAuthorCd()) ){
				param.put("isAdmin", "true");
				model.addAttribute("isAdmin", true);
			}
		}
		
		if(param.getString("CHEK_CASE_TYPE_VALUE").length() != 0){
			String[] caseTypeChk = param.getString("CHEK_CASE_TYPE_VALUE").split(",");
			param.put("caseTypeChk", caseTypeChk);
		}
		
		if(param.getString("cond_frdate").equals("")){
			param.put("frdate", "2000-01-01");
		} else {
			param.put("frdate", param.getString("cond_frdate"));
		}

		if(param.getString("cond_todate").equals("")){
			param.put("todate", "2099-12-31");
		} else {
			param.put("todate", param.getString("cond_todate"));
		}
		
		param.put("searchType4Date", "serv");
		
		String[] arr_CNTR_COD = param.getString("arr_CNTR_COD").split(",");
		param.put("arrCntrCod", arr_CNTR_COD);
		
		switch (param.getString("CASE_SERV")) {
		case "CS_TYPE": //피해 구분별
			param.put("codegCode", "JA00");
			param.put("fieldName", "CS_TYPE");
			break;
		case "CS_TYPE_GROUP": //아동학대범죄 - 가해자 구분
			param.put("codegCode", "JA01");
			param.put("fieldName", "CS_TYPE_GROUP");
			break;
		case "CS_TYPE_ACT": //아동학대범죄 - 학대행위 구분
			param.put("codegCode", "JA02");
			param.put("fieldName", "CS_TYPE_ACT01");
			break;
		case "CS_GROUP": //수사 법률 지원
			param.put("codegCode", "JA11");
			param.put("fieldName", "CS_GROUP");
			break;
		case "CS_GROUP_A10": //신뢰관계인 동석
			param.put("codegCode", "JAA1");
			param.put("fieldName", "CS_GROUP_A10");
			break;
		case "CS_GROUP_B10": //의료비 지원
			param.put("codegCode", "JA16");
			param.put("fieldName", "CS_GROUP_B10");
			break;
		case "CS_GROUP_B20": //의료비 지원 대상
			param.put("codegCode", "JA15");
			param.put("fieldName", "CS_GROUP_B20");
			break;
		case "CS_GROUP_B30": //간병비 지원
			param.put("codegCode", "JA14");
			param.put("fieldName", "CS_GROUP_B30");
			break;
		case "CS_GROUP_B40": //간병비 사유
			param.put("codegCode", "JA13");
			param.put("fieldName", "CS_GROUP_B40");
			break;
		case "CS_GROUP_B50": //응급 키트 지원
			param.put("codegCode", "YES");
			param.put("fieldName", "CS_GROUP_B50");
			break;
		case "CS_GROUP_B61": //인공 임신 중절 - 센터가 임신을 확인한 시점
			param.put("codegCode", "JA17");
			param.put("fieldName", "CS_GROUP_B61");
			break;
		case "CS_GROUP_B62": //인공 임신 중절 지원 - 인공임신중절 수술 시행 병원
			param.put("codegCode", "JA18");
			param.put("fieldName", "CS_GROUP_B62");
			break;
		case "CS_GROUP_C10": //수사법률-신고
			param.put("codegCode", "JA21");
			param.put("fieldName", "CS_GROUP_C10");
			break;
		case "CS_GROUP_C22": //수사법률-1심 재판결과
			param.put("codegCode", "JA23");
			param.put("fieldName", "CS_GROUP_C22");
			break;
		case "CS_GROUP_C23": //수사법률-2심 재판결과
			param.put("codegCode", "JA23");
			param.put("fieldName", "CS_GROUP_C23");
			break;
		case "CS_GROUP_C24": //수사법률-3심 재판결과
			param.put("codegCode", "JA23");
			param.put("fieldName", "CS_GROUP_C24");
			break;
		case "CS_GROUP_C20": //수사법률-수사진행 - 검찰단계 결과
			param.put("codegCode", "JA22");
			param.put("fieldName", "CS_GROUP_C20");
			break;
		case "CS_GROUP_D10": //주사례관리 이관
			param.put("codegCode", "JA31");
			param.put("fieldName", "CS_GROUP_D10");
			break;
		default:
			param.put("codegCode", "JA00");
			param.put("fieldName", "CS_TYPE");
			break;
		}
		
		List<ZValue> codeResult = sqlDao.findAll("findStatCode2", param);
		List<String> code = new ArrayList<String>();
		
		for(int i=0; i<codeResult.size(); i++){
			code.add(i, codeResult.get(i).getString("cd"));
		}
		
		param.put("code", code);
		
		List<ZValue> servStats = sqlDao.findAll("findServStats", param);
		
		List<ZValue> servStatd = null;
		if(param.getString("dsaYN").equals("Y")){
			param.put("dsa", param.getString("dsaYN"));
			servStatd = sqlDao.findAll("findServStats", param);
		}
		
		//################# 통계 #################
		
		int[][] sumArray0 = new int[100][4];
		int[][] sumArray1 = new int[100][4];
		int[][] sumArray2 = new int[100][4];
		int[][] sumArray3 = new int[100][4];
		
		int[][] sumDrray0 = new int[100][4];
		int[][] sumDrray1 = new int[100][4];
		int[][] sumDrray2 = new int[100][4];
		int[][] sumDrray3 = new int[100][4];
		
		int codeCount2 = codeResult.size() + 7; //필드들 + 전체 + 미지정
		
		String[] codename = new String[100];
		
		codename[6] = "all";
		for(int i=0; i<code.size(); i++){
			codename[i+7] = code.get(i).toLowerCase();
		}
		
		//전체 합계
		for(int i=0; i<servStats.size(); i++){
			
			for(int t=6; t<=codeCount2; t++){
				sumArray0[t][0] = sumArray0[t][0] + servStats.get(i).getInt("fieldname" + codename[t]);
				
				if(param.getString("dsaYN").equals("Y")){
					sumDrray0[t][0] = sumDrray0[t][0] + servStatd.get(i).getInt("fieldname" + codename[t]);
				}
				
				//남자 전체 합계 산출
				if(servStats.get(i).getString("victimSex").equals("M")){
					sumArray0[t][1] = sumArray0[t][1] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][1] = sumDrray0[t][1] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//여자 전체 합계 산출
				if(servStats.get(i).getString("victimSex").equals("F")){
					sumArray0[t][2] = sumArray0[t][2] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][2] = sumDrray0[t][2] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//알수없음 전체 합계 산출
				if(servStats.get(i).getString("victimSex").equals("E")){
					sumArray0[t][3] = sumArray0[t][3] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray0[t][3] = sumDrray0[t][3] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
				}
				
				//1. 위기지원형 소계
				if(servStats.get(i).getString("cgroupCode").equals("1")){
					sumArray1[t][0] = sumArray1[t][0] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray1[t][0] = sumDrray1[t][0] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("M")){
						sumArray1[t][1] = sumArray1[t][1] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][1] = sumDrray1[t][1] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("F")){
						sumArray1[t][2] = sumArray1[t][2] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][2] = sumDrray1[t][2] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("E")){
						sumArray1[t][3] = sumArray1[t][3] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray1[t][3] = sumDrray1[t][3] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//2. 아동형 소계
				if(servStats.get(i).getString("cgroupCode").equals("2")){
					sumArray2[t][0] = sumArray2[t][0] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray2[t][0] = sumDrray2[t][0] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("M")){
						sumArray2[t][1] = sumArray2[t][1] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][1] = sumDrray2[t][1] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("F")){
						sumArray2[t][2] = sumArray2[t][2] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][2] = sumDrray2[t][2] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("E")){
						sumArray2[t][3] = sumArray2[t][3] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray2[t][3] = sumDrray2[t][3] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
				
				//3. 통합형 소계
				if(servStats.get(i).getString("cgroupCode").equals("3")){
					sumArray3[t][0] = sumArray3[t][0] + servStats.get(i).getInt("fieldname" + codename[t]);
					
					if(param.getString("dsaYN").equals("Y")){
						sumDrray3[t][0] = sumDrray3[t][0] + servStatd.get(i).getInt("fieldname" + codename[t]);
					}
					
					//남자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("M")){
						sumArray3[t][1] = sumArray3[t][1] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][1] = sumDrray3[t][1] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//여자 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("F")){
						sumArray3[t][2] = sumArray3[t][2] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][2] = sumDrray3[t][2] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
					
					//알수없음 전체 합계 산출
					if(servStats.get(i).getString("victimSex").equals("E")){
						sumArray3[t][3] = sumArray3[t][3] + servStats.get(i).getInt("fieldname" + codename[t]);
						
						if(param.getString("dsaYN").equals("Y")){
							sumDrray3[t][3] = sumDrray3[t][3] + servStatd.get(i).getInt("fieldname" + codename[t]);
						}
					}
				}
			}
		}
		
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("servStats", servStats);
		model.addAttribute("servStatd", servStatd);
		model.addAttribute("dsaYN", param.getString("dsaYN"));
		model.addAttribute("sexYN", param.getString("sexYN"));
		model.addAttribute("totYN", param.getString("totYN"));
		model.addAttribute("termType", param.getString("term_type"));
		
		model.addAttribute("array0", sumArray0);
		model.addAttribute("drray0", sumDrray0);
		model.addAttribute("array1", sumArray1);
		model.addAttribute("drray1", sumDrray1);
		model.addAttribute("array2", sumArray2);
		model.addAttribute("drray2", sumDrray2);
		model.addAttribute("array3", sumArray3);
		model.addAttribute("drray3", sumDrray3);
		model.addAttribute("codeCount2", codeCount2);
		model.addAttribute("codename", codename);
		
		insertHistory(param);
	}
	
	@Override
    public void passView(ParameterContext paramCtx) throws Exception {
		
		super.view(paramCtx);
	}
	
	@UnpJsonView
	public void ageSetting(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}
		param.put("codegCode", "VTAG");
		
		
		ZValue param2 = new ZValue();
		param2.put("userId",user.getUserId());
		
		sqlDao.modify("deleteAgeSetting", param2);
		
		
		String[] ageSettingString =  ((String) param.get("ageSetting")).split(",");
		String[] ageSettingName =  ((String) param.get("ageSettingText")).split(",");
		
		param2.put("codegCode",param.get("codegCode"));
		
	
		for (int i = 0; i <= ageSettingName.length-1; i++) {
			
			String i2= Integer.toString(i);
			
			String codeCode = param.get("userId") + i2;
			
			codeCode = codeCode.toLowerCase().replace("_", "");
			
			param2.put("codeName", ageSettingName[i]);
			param2.put("codeCode", codeCode);
			param2.put("codeGroup", param.get("userId"));
			
			if(i == 0) {
				param2.put("codeName2", 0);
			}else {
				param2.put("codeName2", ageSettingString[i-1]);
			}
			 
			
			
			
			if(i == ageSettingName.length-1) {
				param2.put("codeName3", "121");
			}else {
				param2.put("codeName3", ageSettingString[i]);
			}
			
			/*System.out.println(param2);*/
			
			sqlDao.modify("insertAgeSetting", param2);
		}
		
		
		String codeCode =  param.get("userId") + Integer.toString(ageSettingName.length);
		codeCode = codeCode.toLowerCase().replace("_", "");
		
		param2.put("codeCode", codeCode);
		param2.put("codeName", "알수없음");
		param2.put("codeName2", 121);
		param2.put("codeName3", 999);
		
		sqlDao.modify("insertAgeSetting", param2);
		
		
	}
	
	
	public void insertHistory(ZValue param) throws Exception {
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();

        param.put("chUserId", user.getUserId());
        param.put("chMemo", "[자동입력] 사례통계를 검색했습니다");
        param.put("chUserNm", user.getUserNm());
        param.put("chAction", "S");
        param.put("chGroup", "STATS");
        param.put("caseSeq", "0");
        param.put("chGroupSeq", "0");
        
        sqlDao.save("saveStatsHistory", param);
    }
	
	public void excelDownPopup(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("userId", user.getUserId());
        param.put("userNm", user.getUserNm());
    }
	
	@UnpJsonView
	public void insertDownloadHistory(ParameterContext paramCtx) throws Exception {
	     System.out.println("===다운로드이력 저장");
	     ZValue param = paramCtx.getParam();
	     UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
	     param.put("shUserId", user.getUserId());
	     param.put("shMemo", param.getString("downloadMemo"));
	     param.put("shGroup", "DOWN");
	     param.put("shMenuNm", param.getString("shMenuNm"));
	     param.put("shDataNm", param.getString("shDataNm")); 
	     
	     memberDAO.save("saveDownloadHistory", param);
	 }
	
	/*@Override
    public void view(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);
        List<ZValue> resultPassList = sqlDao.findAll("findCasePassList", param);

        model.addAttribute("resultAttkrList", resultAttkrList);	//가해자정보
        model.addAttribute("resultPassList", resultPassList);	//지원서비스

        model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
        super.view(paramCtx);
    }

	@Override
    public void passView(ParameterContext paramCtx) throws Exception {
		System.out.println("passview:::::::::");
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        List<ZValue> resultPassList = sqlDao.findAll("findCasePassList", param);

        model.addAttribute("resultPassList", resultPassList);	//지원서비스
//        super.view(paramCtx);
    }

    @Override
	@UnpJsonView
    public void findCasePassList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCasePassList", param));
    }

    @Override
    public void caseReg(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

    	//가해자정보 리스트
    	List<ZValue> resultAttkrList = sqlDao.findAll("findCaseAttkrList", param);

    	//사례 상세
    	model.addAttribute("result", sqlDao.findOne("findOneCase", param));
    	model.addAttribute("resultCntr", sqlDao.findOne("findCaseNumber", param));

        model.addAttribute("resultAttkrList", resultAttkrList);
        //메모 상세
        model.addAttribute("resultMemo", sqlDao.findOne("findOneMemo", param));
    }

    @Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);
		ZValue resultCntr = sqlDao.findOne("findCaseNumber", param);
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
		super.insert(paramCtx);
		// 가해자 정보 등록
		sqlDao.save("saveCaseAttkr", param);
		// 지원서비스 등록
//		sqlDao.save("savePass", param);
		// 메모 등록
		sqlDao.save("saveMemo", param);

		// 전산관리번호 넘버 추가 및 업데이트
		if(countCaseNumber > 0) {
			sqlDao.modify("updateCaseNumber", param);
		}else {
			sqlDao.save("saveCaseNumber", param);
		}
	}

    @Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		// 사례 등록
		super.update(paramCtx);
		// 메모 등록
		sqlDao.save("updateMemo", param);
	}

    @Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		// 사례기본정보
		super.delete(paramCtx);
		// 메모
		sqlDao.deleteOne("deleteMemo", param);
		// 가해자정보
		sqlDao.deleteOne("deleteAttkr", param);
		// 지원서비스
		sqlDao.deleteOne("deleteCasePass", param);
		// 첨부
		// 연락처
		// 관리
	}

    @Override
    public void caseAttkrRegPopup(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        ZValue findCaseAttkrOne = sqlDao.findOne("findCaseAttkrOne", param);
        model.addAttribute("result", findCaseAttkrOne);
    }

    @Override
    @UnpJsonView
    public void insertAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ZValue attkrSeq = sqlDao.findOne("findCaseAttkrSeq", param);

		param.put("attkrSeq", attkrSeq.getString("attkrSeq"));
		//가해자 정보 추가
        sqlDao.save("saveCaseAttkr", param);
//        MVUtils.setResultProperty(model, SUCCESS, "등록 정상처리 하였습니다.");
    }

    @Override
    @UnpJsonView
    public void updateAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

    	sqlDao.save("updateCaseAttkr", param);
    }

    @Override
    @UnpJsonView
    public void deleteAttkr(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

    	sqlDao.deleteOne("deleteCaseAttkr", param);
    }

    @Override
    @UnpJsonView
    public void findCdListJson(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCdList", param));
    }


    @Override
    @UnpJsonView
    public void findCdDetailListJson(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	model.addAttribute("resultList", sqlDao.findAll("findCdDetailList", param));
    }*/

}
