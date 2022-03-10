package site.unp.cms.service.siteManage.impl;


import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.siteManage.VisualService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;


@CommonServiceDefinition(
		sqlDaoRef 		= "visualDAO",//비쥬얼 DAO를 사용
		pageQueryData 	= "siteId,menuNo,viewType,searchKwd,searchUseAt,pSiteId",
		listQueryId 	= "findAllVisual",//리스트 정보를 가져오기  위한 분기값 sql id
		countQueryId 	= "countVisual",//카운트를 세기 위한 하기 위한 분기값 sql id
		viewQueryId  	= "findVisualDetail",//업데이트 화면 을 보기 위해 등록 정보를 상세하게 가져 오기위한 분기값 sql id
		insertQueryId 	= "saveVisual",//세이브 하기 위한 분기값 sql id
		updateQueryId 	= "modifyVisual",//수정하기 위한 sql id값
		deleteQueryId 	= "deleteVisual"
		)
@Service
public class VisualServiceImpl extends DefaultCrudServiceImpl implements VisualService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@CommonServiceLinks({
			@CommonServiceLink(desc="비쥬얼 관리", linkType=LinkType.BOS, paramString="pSiteId=ucms")
			/*@CommonServiceLink(desc="관리자 배너 관리", linkType=LinkType.BOS, paramString="pSiteId=bos")*/
	})

	public void list(ParameterContext paramCtx) throws Exception {
		//param.put("pSiteId", "ucms");
		super.list(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		super.forInsert(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("siteList", siteList);

//		model.addAttribute("sortOrdr", sqlDao.findOne("findBannerMaxSortOrdr", param));
		model.addAttribute("sortOrdr", sqlDao.findOne("findVisualMaxSortOrdr", param));
	}


	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue zz = paramCtx.getParam();
		super.forUpdate(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
		ModelMap model = paramCtx.getModel();
		model.addAttribute("siteList", siteList);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();// 일단 뭐쿼리에 넣어줄 파라미터 값을 가져 온다.

		boolean flag = uploadFile(paramCtx);//수정할 파일을 올려준다.기존의 파일이 있으면 바꿔운다. 파일이 있거나 새로운 파일이 있다면 등록이 되고 true 리턴한다.
		if(!flag) return;
		if(!param.getString("atchFileID","").equals("")){//만약에 빈값이 아니라면
			param.put("fileCn", param.getString("fileCn_imgFile_1"));
		}

		ISqlDAO<ZValue> sqlDao = null;//dao를 공통으로 사용 한다. 이것을 소환해서 위에서 선안한 listQueryId 같은걸들로 각각의 mybatis에 있는 id값을 찾아서 쿼리를 수행한다.
		if(paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();//현재접속하고 있는 사람의 정보를 가져 오는 것이다.

		if(user != null){//user 값이 존재하면 param값에 undtId(수정ID) registId(등록ID)를 넣어준다.
			param.put("undtId",user.getUserId());
			param.put("registId",user.getUserId());
		}

		sqlDao.modify(updateQueryId, param);// 쿼리를 호출하여 업데이트를 시작한다.
		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, messageSource.getMessage("success.common.update", null,Locale.getDefault()));//성공했을때 메시지를 model에 태워서 보냄
	}

	//비주얼 관리 노출순서 변경
	@UnpJsonView
	public void updateSortOrdr(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("visualNo", param.getInt("visualNo"));
		ZValue value1 = sqlDao.findOne("findVisualDetail", param);

		param.put("sortOrdr", value1.getInt("sortOrdr"));
		ZValue value2 = sqlDao.findOne("findVisualDetail", param);

		String result = SUCCESS;
		String msg = "정산적으로 변경되었습니다.";

		if(value2 != null && !(value1.equals(value2))){
			param.put("sortOrdr", value2.getString("sortOrdr"));
			sqlDao.modify("modifyVisualSortOrdr", param);

			param.put("visualNo", value2.getInt("visualNo"));
			param.put("sortOrdr", value1.getInt("sortOrdr"));
			sqlDao.modify("modifyVisualSortOrdr", param);
		}else{
			String option = param.getString("option");
			if(option.equals("1")||option.equals("2")){
				msg = "첫번째 순서 입니다.";
			}else { msg = "마지막 순서 입니다."; }
			result = FAIL;
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY,result);
		model.addAttribute(ModelAndViewResolver.MSG_KEY,msg);
	}

	//비주얼 사용 여부 변경
	@UnpJsonView
	public void updateUseAt(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		param.put("expsrAt", param.getString("useAt"));//비주얼 사용여부 분기를 만들어 주기 위한 값설정

		sqlDao.modify("modifyVisualUseAt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 변경되었습니다.");
	}


	/*public List<ZValue> getVisual(ZValue param) throws Exception {
		VisualDAO dao = new VisualDAO();
		//List<ZValue> resultList = dao.findPublishListByVisualSe(param);
		List<ZValue> resultList = getSqlDao(VisualDAO.class).findPublishListByVisualSe(param);
		//List<ZValue> resultList = sqlDao.listDAO("BannerDAO_selectPublishList", param);
		Map<String, List<ZValue>> fileMap = listHandler.getFileMap(null, resultList);
		UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");
		return resultList;
	}*/

	public void delete(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();

		super.delete(paramCtx);
		MVUtils.goUrl(WebFactory.buildUrl("/bos/siteManage/visual/list.do", param, "menuNo", "pSiteId"), "정상적으로 처리하였습니다.", paramCtx.getModel());

	}

}