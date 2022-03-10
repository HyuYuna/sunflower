package site.unp.cms.service.message.impl;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.file.EkrFileMngService;
import site.unp.cms.service.message.MessageService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		sqlDaoRef="messageDAO",
		countQueryId="countMessage",
		listQueryId="findAllMessage",
		viewQueryId="findOneMessage",
		updateQueryId="updateMessage",
		insertQueryId="saveMessage",
		pageQueryData="searchGroup,searchText,sdate,edate,bbsId,menuNo,viewType,pageUnit"
	)
@CommonServiceLink(desc="메일", linkType=LinkType.BOS)
@Service
public class MessageServiceImpl extends DefaultCrudServiceImpl implements MessageService {
	
	@Resource(name="ekrFileMngService")
	private EkrFileMngService ekrFileMngService;

	@Override
	public void list(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}
		
		if(param.getString("pageUnit").length() == 0){
			param.put("pageUnit", 20);
		}
		
		if(param.getString("menuNo").equals("100240")){
			param.put("dataGroup", "GET");
		} else if(param.getString("menuNo").equals("100241")){
			param.put("dataGroup", "SEND");
		}
		
		super.list(paramCtx);
	}
	
	@Override
	public void view(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("wuser", user.getUserId());
		}
		
		ZValue status = sqlDao.findOne("findOneMessageStatus", param);
		model.addAttribute("status", status);
		
		if(status != null && status.getString("status").equals("N")){
			sqlDao.modify("updateMessageTgtStatus", param);
		}
		
		List<ZValue> rec = sqlDao.findAll("findOneMessageReceiver", param);
		model.addAttribute("rec", rec);
		
		super.view(paramCtx);
	}
	
	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(param.getString("seq").length() != 0){
			ZValue re = sqlDao.findOneById("findOneMessage", param.getString("seq"));
			model.addAttribute("re", re);
		}
		
		param.put("sCode","CM04");
		param.put("codeAt", "Y");
		List<ZValue> codeList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList", codeList);
		
		/*param.put("sCode","CM05");
		if(param.getString("gCode").length() != 0){
			param.put("gCode",param.getString("srcCntrGbn"));
		}
		List<ZValue> codeList2 = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList2", codeList2);*/
		
		super.forInsert(paramCtx);
	}
	
	@Override
	public void insert(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("wuser", user.getUserId());
			param.put("comId", user.getCenterCode());
			param.put("comId2", user.getCenterCode().substring(0,1));
		}
		
		param.put("status", "S");

		//super.insert(paramCtx);
		sqlDao.save("saveMessage", param);
		
		//파일 업로드
		param.put("uflRelNumber", param.getString("seq"));
		
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		//대상 등록
		String[] receiverArr = param.getString("receiverS").split(",");
		
		if(receiverArr.length != 0){
			for (String ra : receiverArr) {
				param.put("seq", param.getString("seq"));
				param.put("receiver", ra);
				param.put("status", "N");
				sqlDao.save("saveMessageTgt", param);
			}
		}
		
		Object pkValue = param.get("unqKey");
        paramCtx.setPkValue(pkValue);
        MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.insert", null, Locale.getDefault()));
	}
	
	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("sCode","CM04");
		param.put("code", "Y");
		List<ZValue> codeList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList", codeList);
		
		/*param.put("sCode","CM05");
		if(param.getString("gCode").length() != 0){
			param.put("gCode",param.getString("srcCntrGbn"));
		}
		List<ZValue> codeList2 = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList2", codeList2);*/
		
		super.forUpdate(paramCtx);
	}
	
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.modify("updateMessage", param);
		param.put("uflRelNumber", param.getString("seq"));
		
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;
		
		MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.update", null, Locale.getDefault()));
	}
	
	@Override
	public void delete(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("uflRelNumber", param.getString("seq"));
		param.put("uflRelCode", param.getString("programId"));
		sqlDao.deleteOne("ekrFileDelete", param);
		
		super.delete(paramCtx);
	}
	
	@UnpJsonView
	public void searchCodeList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		String centerCode = "";
		if (user != null) {
			centerCode = user.getCenterCode();
		}
		
		List<ZValue> titleList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("titleList", titleList);
		model.addAttribute("centerCode", centerCode);
	}
	
	@UnpJsonView
	public void searchCenterNameList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> nameList = sqlDao.findAll("fnMakeSelectboxCenterUserMemo", param);
		model.addAttribute("nameList", nameList);
	}
}
