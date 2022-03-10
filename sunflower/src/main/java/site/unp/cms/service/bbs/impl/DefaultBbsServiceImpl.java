package site.unp.cms.service.bbs.impl;

import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.bbs.DefaultBbsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.BoardServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.bbs.impl.BbsEstnServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;

@BoardServiceDefinition(
	sqlDaoRef = "bbsEstnDAO",
	delPermanentlyQueryId = "deleteBbsEstnByBbsIdAndNttId",
	restoreQueryId = "restoreBbsEstn",
	replyListQueryId = "findAllBbsEstnReplay",
	updateInqireCoQueryId = "modifyBbsEstnInqireCo",
	prevQueryId = "findOneBbsEstnPrev",
	nextQueryId = "findOneBbsEstnNext",
	pageQueryData = "titlei,contenti,namei,findstr,startDatei,endDatei,bbsId,menuNo,viewType,pageUnit",
	listenerAndMethods = {
		"bbsInitParamsListener=insert,update",
		"checkBbsListener",
		"bbsArticleAccessListener=restore,delPermanently,delete,update,forUpdate"
})
@Service
public class DefaultBbsServiceImpl extends BbsEstnServiceImpl implements DefaultBbsService{
	
	@UnpJsonView
	public void getFileList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> fileList = sqlDao.findAll("findAllBbsFile", param);
		model.addAttribute("fileList", fileList);
	}

	@UnpJsonView
	public void pageUnitChange(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("pageUnit", param.getString("pageUnit"));
	}
	
	@UnpJsonView
	public void pwCheck(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue pwchk = sqlDao.findOneById("boPasswordCheck", param.getString("boidx"));
		
		if(pwchk.getString("bopassword").equals(param.getString("strPassworldCheck"))){
			model.addAttribute("srtIsSuccess", "true");
		} else {
			model.addAttribute("srtIsSuccess", "false");
		}
	}
	
	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(param.getString("bbsId").equals("B0000001")){
			param.put("bid", "bid_7");
		} else if(param.getString("bbsId").equals("B0000003")){
			param.put("bid", "bid_11");
		} else if(param.getString("bbsId").equals("B0000004")){
			param.put("bid", "bid_12");
		} else if(param.getString("bbsId").equals("B0000005")){
			param.put("bid", "bid_8");
		} else if(param.getString("bbsId").equals("B0000022")){
			param.put("bid", "bid_1");
		} else if(param.getString("bbsId").equals("B0000023")){
			param.put("bid", "bid_2");
		} else if(param.getString("bbsId").equals("B0000024")){
			param.put("bid", "bid_3");
		} else if(param.getString("bbsId").equals("B0000025")){
			param.put("bid", "bid_4");
		} else if(param.getString("bbsId").equals("B0000026")){
			param.put("bid", "bid_5");
		} else if(param.getString("bbsId").equals("B0000027")){
			param.put("bid", "bid_6");
		}
		
		super.list(paramCtx);
		
		ZValue category = sqlDao.findOne("bidCategory", param);
		model.addAttribute("category", category);
	}
	
	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(param.getString("bbsId").equals("B0000001")){
			param.put("bid", "bid_7");
		} else if(param.getString("bbsId").equals("B0000003")){
			param.put("bid", "bid_11");
		} else if(param.getString("bbsId").equals("B0000004")){
			param.put("bid", "bid_12");
		} else if(param.getString("bbsId").equals("B0000005")){
			param.put("bid", "bid_8");
		} else if(param.getString("bbsId").equals("B0000022")){
			param.put("bid", "bid_1");
		} else if(param.getString("bbsId").equals("B0000023")){
			param.put("bid", "bid_2");
		} else if(param.getString("bbsId").equals("B0000024")){
			param.put("bid", "bid_3");
		} else if(param.getString("bbsId").equals("B0000025")){
			param.put("bid", "bid_4");
		} else if(param.getString("bbsId").equals("B0000026")){
			param.put("bid", "bid_5");
		} else if(param.getString("bbsId").equals("B0000027")){
			param.put("bid", "bid_6");
		}
		
		super.forInsert(paramCtx);
		
		ZValue category = sqlDao.findOne("bidCategory", param);
		model.addAttribute("category", category);
		
		List<ZValue> code = sqlDao.findAll("bidCode", param);
		model.addAttribute("codeList", code);
	}
	
	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("boid", user.getUserId());
		}
		
		param.put("nttId", param.getString("boidx"));
		param.put("boref", param.getString("boidx"));
		param.put("boreadnumber", "0");
		param.put("bototalfilesize", "0");
		param.put("borestep", "0");
		param.put("borelevel", "0");
		param.put("boisdelete", "0");
		param.put("bofilenumber", "0");
		param.put("booldnumber", "0");
		param.put("booldnumber2", "0");
		param.put("boisbasic", "1");
        
        sqlDao.save("saveBbsEstn", param);
		
        boolean flag = uploadFile(paramCtx);
        if(!flag)
            return;
        
        Object pkValue = param.get("unqKey");
        paramCtx.setPkValue(pkValue);
        MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.insert", null, Locale.getDefault()));
		
		//super.insert(paramCtx);
	}
	
	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(param.getString("bbsId").equals("B0000001")){
			param.put("bid", "bid_7");
		} else if(param.getString("bbsId").equals("B0000003")){
			param.put("bid", "bid_11");
		} else if(param.getString("bbsId").equals("B0000004")){
			param.put("bid", "bid_12");
		} else if(param.getString("bbsId").equals("B0000005")){
			param.put("bid", "bid_8");
		} else if(param.getString("bbsId").equals("B0000022")){
			param.put("bid", "bid_1");
		} else if(param.getString("bbsId").equals("B0000023")){
			param.put("bid", "bid_2");
		} else if(param.getString("bbsId").equals("B0000024")){
			param.put("bid", "bid_3");
		} else if(param.getString("bbsId").equals("B0000025")){
			param.put("bid", "bid_4");
		} else if(param.getString("bbsId").equals("B0000026")){
			param.put("bid", "bid_5");
		} else if(param.getString("bbsId").equals("B0000027")){
			param.put("bid", "bid_6");
		}
		
		super.view(paramCtx);
		
		ZValue category = sqlDao.findOne("bidCategory", param);
		model.addAttribute("category", category);
		
		List<ZValue> files = sqlDao.findAll("findAllFileMngByBfboidx", param);
		model.addAttribute("files", files);
	}
	
	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(param.getString("bbsId").equals("B0000001")){
			param.put("bid", "bid_7");
		} else if(param.getString("bbsId").equals("B0000003")){
			param.put("bid", "bid_11");
		} else if(param.getString("bbsId").equals("B0000004")){
			param.put("bid", "bid_12");
		} else if(param.getString("bbsId").equals("B0000005")){
			param.put("bid", "bid_8");
		} else if(param.getString("bbsId").equals("B0000022")){
			param.put("bid", "bid_1");
		} else if(param.getString("bbsId").equals("B0000023")){
			param.put("bid", "bid_2");
		} else if(param.getString("bbsId").equals("B0000024")){
			param.put("bid", "bid_3");
		} else if(param.getString("bbsId").equals("B0000025")){
			param.put("bid", "bid_4");
		} else if(param.getString("bbsId").equals("B0000026")){
			param.put("bid", "bid_5");
		} else if(param.getString("bbsId").equals("B0000027")){
			param.put("bid", "bid_6");
		}
		
		super.forUpdate(paramCtx);
		
		ZValue category = sqlDao.findOne("bidCategory", param);
		model.addAttribute("category", category);
		
		List<ZValue> code = sqlDao.findAll("bidCode", param);
		model.addAttribute("codeList", code);

		List<ZValue> fileList = sqlDao.findAll("findAllFileMngByBodix", param);
		model.addAttribute("fileList", fileList);
        model.addAttribute("fileListCnt", Integer.valueOf(fileList.size()));
        
        fileMngService.setImgUrl(fileList);
	}
	
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("nttId", param.getString("boidx"));
		
		super.update(paramCtx);
	}
	
	@Override
	public void delPermanently(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("nttId", param.getString("boidx"));
		
		super.delPermanently(paramCtx);
	}
}
