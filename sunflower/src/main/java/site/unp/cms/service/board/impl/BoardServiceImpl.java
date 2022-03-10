package site.unp.cms.service.board.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.board.BoardService;
import site.unp.cms.service.file.EkrFileMngService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		sqlDaoRef="boardDAO",
		countQueryId="countBoard",
		listQueryId="findAllBoard",
		viewQueryId="findOneBoard",
		updateQueryId="updateBoard",
		insertQueryId="saveBoard",
		pageQueryData="searchCnd,searchText,menuNo,viewType,pageUnit,srcCntrGbn,srcCntrCod"
	)
@CommonServiceLink(desc="문서수발신", linkType=LinkType.BOS)
@Service
public class BoardServiceImpl extends DefaultCrudServiceImpl implements BoardService {
	
	@Resource(name="ekrFileMngService")
	private EkrFileMngService ekrFileMngService;

	@Override
	public void list(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("bddcCenter", user.getCenterCode());
		}
		
		if(param.getString("pageUnit").length() == 0){
			param.put("pageUnit", 20);
		}
		
		param.put("sCode","CM04");
		List<ZValue> codeList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList", codeList);
		
		param.put("sCode","CM05");
		if(param.getString("srcCntrGbn").length() != 0){
			param.put("gCode",param.getString("srcCntrGbn"));
		}
		List<ZValue> codeList2 = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList2", codeList2);
		
		super.list(paramCtx);
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("bddcCenter", user.getCenterCode());
		}
		
		super.view(paramCtx);

		//발신자와 사용자가 같지 않으면 조회수 업데이트
		ZValue bdd = sqlDao.findOne("findOneBoard", param);
		
		if(!bdd.getString("bddUser").equals(user.getUserId())){
			sqlDao.modify("boardDataHitUpdate", param);
		}
		
		//문서 수신함에서 읽었는데, 문서수신정보 확인후 없으면 데이터 입력
		ZValue cnt = sqlDao.findOne("BoardDataReadSelect", param);
		
		if(cnt.getInt("readCount") > 0 && param.getString("menuNo").equals("100184")){
			sqlDao.modify("BoardDataReadUpdate", param);
		}
		
		//센터에서 첨부 가능한지 확인
		boolean code = false;
		if(bdd.getString("bddTarget").contains(user.getCenterCode())){
			code = true;
		}
		
		param.put("bddCenter", bdd.getString("bddCenter"));
		
		List<ZValue> centerList = sqlDao.findAll("boardUploadCenterList", param);
		List<ZValue> repltyList	= sqlDao.findAll("boardReplyList", param);
		ZValue rcept = sqlDao.findOne("findOneReceiptUser", param);
		model.addAttribute("centerList", centerList);
		model.addAttribute("repltyList", repltyList);
		model.addAttribute("rcept", rcept);
		model.addAttribute("code", code);
	}
	
	@Override
	public void insert(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("bddCenter", user.getCenterCode());
		}
		
		param.put("bddIp", request.getRemoteAddr()); //IP
		param.put("bddState", "C"); //문서 상태 (C : 저장)
		param.put("bddHit", "0"); //조회수
		param.put("bddReplyCount", "0"); //회신수
		param.put("bddIntra", "N"); //내부 사용 여부
		param.put("bddImportance", "0"); //중요여부
		
		//super.insert(paramCtx);
		sqlDao.save("saveBoard", param);
		param.put("uflRelNumber", param.getString("bddSeq"));
		
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

		String[] bddcCenter = param.getString("bddTarget").trim().split(",");
		param.put("bddcCenterList", bddcCenter);
		
		//1. 포함되지 않은 센터 삭제
		sqlDao.deleteOne("deleteBoardDataCenter", param);
		sqlDao.deleteOne("deleteBoardDataCenterRcept", param);
		
		//2. 새롭게 포함된 센터 추가
		if(!param.getString("bddTarget").equals("")){
			//2-1. 기존에 들어가있는 센터 추출
			List<ZValue> bts = sqlDao.findAll("selectBoardDataCenter", param);
			
			//2-2. 추출한 센터(입력되어진 센터) 입력대상에서 제거
			//2-3. 신규로 추가된 업체가 추가
			for(int i=0; i<bddcCenter.length; i++){
				boolean isExist = false;
				
				for(int j=0; j<bts.size(); j++){
					if(bts.get(j).getString("bddcCenter").equals(bddcCenter[i])){
						isExist = true;
					}
				}
				
				if(!isExist){
					param.put("bddTarget", bddcCenter[i]);
					sqlDao.save("insertBoardDataCenter", param);
					sqlDao.save("insertBoardDataCenterRcept", param);
				}
			}
		}
        
        Object pkValue = param.get("unqKey");
        paramCtx.setPkValue(pkValue);
        MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.insert", null, Locale.getDefault()));
	}
	
	@Override
	public void update(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}
		
		//super.update(paramCtx);
		sqlDao.modify("updateBoard", param);
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));
		
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		//문서 상태 변경
		param.put("bddState", "C"); //문서 상태 (C : 저장)
		param.put("bddIp", request.getRemoteAddr()); //IP
		
		sqlDao.modify("changeBoardDataState", param);
		
		String[] bddcCenter = param.getString("bddTarget").trim().split(",");
		param.put("bddcCenterList", bddcCenter);
		
		//1. 포함되지 않은 센터 삭제
		sqlDao.deleteOne("deleteBoardDataCenter", param);
		sqlDao.deleteOne("deleteBoardDataCenterRcept", param);
		
		//2. 새롭게 포함된 센터 추가
		if(!param.getString("bddTarget").equals("")){
			//2-1. 기존에 들어가있는 센터 추출
			List<ZValue> bts = sqlDao.findAll("selectBoardDataCenter", param);
			
			//2-2. 추출한 센터(입력되어진 센터) 입력대상에서 제거
			//2-3. 신규로 추가된 업체가 추가
			for(int i=0; i<bddcCenter.length; i++){
				boolean isExist = false;
				
				for(int j=0; j<bts.size(); j++){
					if(bts.get(j).getString("bddcCenter").equals(bddcCenter[i])){
						isExist = true;
					}
				}
				
				if(!isExist){
					param.put("bddTarget", bddcCenter[i]);
					sqlDao.save("insertBoardDataCenter", param);
					sqlDao.save("insertBoardDataCenterRcept", param);
				}
			}
		}
		
        MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.update", null, Locale.getDefault()));
	}
	
	@Override
	public void delete(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("uflRelNumber", param.getString("bddSeq"));
		param.put("uflRelCode", "demand");
		sqlDao.deleteOne("ekrFileDelete", param);
		
		super.delete(paramCtx);
	}

	@UnpJsonView
	public void searchCodeList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> titleList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("titleList", titleList);
	}
	
	@UnpJsonView
	public void checkboxCodeList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> codeList = sqlDao.findAll("searchCodeCheckbox", param);
		model.addAttribute("codeList", codeList);
	}
	
	@UnpJsonView
	public void autoSave(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("bddCenter", user.getCenterCode());
		}
		
		if(param.getString("bddSeq").equals("")){
			param.put("userIpad", request.getRemoteAddr()); //IP
			param.put("bddHit", "0"); //조회수
			param.put("bddReplyCount", "0"); //회신수
			param.put("bddIntra", "N"); //내부 사용 여부
			param.put("bddImportance", "0"); //중요여부
			param.put("bddState", "A"); //문서 상태 (A : 임시저장)
			
			sqlDao.save("saveBoard", param);
			
			//저장한 임시저장글 찾기
			ZValue src = sqlDao.findOne("searchAutoSave", param);
			model.addAttribute("bsq", src.getString("bddSeq"));
		} else {
			sqlDao.modify("updateBoard", param);
		}
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss에 내용이 자동 저장 되었습니다.");

		String resultMessage = sdf.format(today);
		model.addAttribute("resultCode", "success");
		model.addAttribute("resultMessage",  resultMessage);
	}
	
	@UnpJsonView
	public void documentState(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue src = sqlDao.findOne("searchAutoSave", param);
		String state = "";
		String bddSeq = src.getString("bddSeq");
		
		if(src.getInt("bddSeq") > 0){
			state = "A";
		} else {
			state = "Z";
		}
		
		model.addAttribute("state", state);
		model.addAttribute("bddSeq", bddSeq);
	}
	
	@UnpJsonView
	public void documentDelete(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		sqlDao.deleteById("deleteAutoSave", param);
	}
	
	@UnpJsonView
	public void commentSave(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("uflRelNumber", param.getString("bddSeq"));
		param.put("uflRelNumber2", param.getString("bddcCenter"));
		param.put("filesSeq", "0");
		param.put("filesMemo", param.getString("bdcfMemo"));
		
		sqlDao.save("fileUploadAtBranch", param);
		
		model.addAttribute("resultCode", "success");
	}
	
	@UnpJsonView
	public void fileDelete(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		sqlDao.deleteOne("fileDelete", param);					//파일 삭제
		
		if(param.getString("bddcCenter").length() != 0){
			sqlDao.deleteOne("fileDeleteCenterFile", param);	//제출 센터 자료 삭제
		}
		
		model.addAttribute("resultCode", "true");
		model.addAttribute("resultMessage", "자료를 삭제했습니다.");
	}
	
	@UnpJsonView
	public void fileUpload(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}
		
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));
		
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		param.put("filesMemo", "");
		sqlDao.save("fileUploadAtBranch", param);
		
		model.addAttribute("srtIsSuccess", "true");
	}
	
	@UnpJsonView
	public void centerReceipt(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("bddcCenter", user.getCenterCode());
			
			if(param.getString("status").equals("C")){
				param.put("userId", user.getUserId());
			}
		}

		sqlDao.modify("BoardDataReceiptUpdate", param);
		
		model.addAttribute("resultCode", "success");
	}
}
