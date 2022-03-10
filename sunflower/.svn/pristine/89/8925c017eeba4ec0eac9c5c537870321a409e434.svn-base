package site.unp.cms.service.auth.impl;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.dao.member.MemberDAO;
import site.unp.cms.service.auth.AuthorHistService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.domain.UsersVO;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
        pageQueryData="userTyCd,searchCnd,searchWrd,searchKwd,sdate,edate,menuNo,now,searchCnd1,searchCnd2,pageUnit"
)
@Service
public class AuthorHistServiceImpl extends DefaultCrudServiceImpl implements AuthorHistService{
    @Resource(name="memberDAO")
    private MemberDAO memberDAO;
    
	@CommonServiceLinks({
		@CommonServiceLink(desc="권한 변경 이력", linkType=LinkType.BOS, paramString="")
	})
	@SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="권한 변경 이력 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "authorHistory");
    }
	@Override
    @UnpJsonView
    public void print(ParameterContext paramCtx, String type) throws Exception{
        System.out.println("======print.do type : " + type);
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        param.put("noLimit","Y");

        List<ZValue> resultList = null;
        if(type == "authorHistory") {
            resultList = sqlDao.findAll("findAllAuthorHist", param);
        }else {
        }
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("shUserId", user.getUserId());
        param.put("shMemo", param.getString("downloadMemo"));
        param.put("shGroup", "DOWN");
        param.put("shMenuNm", param.getString("shMenuNm"));
        param.put("shDataNm", "권한 이력");
        sqlDao.save("saveDownloadHistory", param);
        
        model.addAttribute("resultList", resultList);
    }
	public void excelDownPopup(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("userId", user.getUserId());
        param.put("userNm", user.getUserNm());
    }
    
	public void list(ParameterContext paramCtx) throws Exception {
		ModelMap map = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		/*
		String sdate, edate ="";

		
		if (param.getString("sdate").equals("") || param.getString("edate").equals("")){
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -7); //1일 더하기
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			sdate = fmt.format(new java.util.Date(cal.getTime().getTime()));
			edate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} else {
			sdate = param.getString("sdate");
			edate = param.getString("edate");
		}
		param.put("sdate", sdate);
		param.put("edate", edate);
		*/
		super.list(paramCtx);
	}

}