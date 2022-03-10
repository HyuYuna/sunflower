package site.unp.cms.service.singl;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.ModelMap;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;


public interface MenuService {

	public static final String PREFIX = "menu_";
	public static final String CONTEXT_SCOPE_MENU_PREFIX = "menuAll";
	public static final String CONTEXT_SCOPE_TOPMENU_PREFIX = "menuTop_";

	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;

	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	public void listJson(ParameterContext paramCtx) throws Exception;


	/**
	 * 메뉴명 수정(메뉴관리 오른쪽 마우스 rename기능)
	 * @param paramCtx
	 * @throws Exception
	 */

	public void updateMenuNm(ParameterContext paramCtx) throws Exception;

	/**
	 * 상위메뉴번호 변경(메뉴관리 오른쪽 마우스 마우스 drag기능)
	 * @param paramCtx
	 * @throws Exception
	 */

	public void updateUpperMenuNo(ParameterContext paramCtx) throws Exception;


	/**
	 * 메뉴 최상위/상위/하위/최하위 이동 ~
	 * @param paramCtx
	 * @throws Exception
	 */

	public void updateMoveMenuNo(ParameterContext paramCtx) throws Exception;

	public void menuContentCnt(ParameterContext paramCtx) throws Exception;

	public void menuLoadSite(ParameterContext paramCtx) throws Exception;


    /**
     * 사용자 메뉴정보를 메모리에 올림
     * @param siteId
     * @return
     * @throws Exception
     */
	public void menuLoad(ParameterContext paramCtx) throws Exception;

	public void menuLinkPop(ParameterContext paramCtx) throws Exception;


	/**
	 * 메뉴관리 - 콘텐츠버전 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateContents(ParameterContext paramCtx) throws Exception ;

	/**
	 * 메뉴관리 - 콘텐츠 버젼 비교 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void compareContentsPop(ParameterContext paramCtx) throws Exception;
	/**
	 * 메뉴관리 - 콘텐츠 버젼 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */

	public void compareContents(ParameterContext paramCtx) throws Exception;

	/**
	 * 메뉴관리 - 콘텐츠버전 업데이트 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateContents(ParameterContext paramCtx) throws Exception;

	/**
	 * 메뉴관리 - 컨텐츠 삭제 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteContents(ParameterContext paramCtx) throws Exception;

	public void downloadContents(ParameterContext paramCtx) throws Exception;

	public HashMap<String, List<ZValue>> getMenuCategoryMapBySiteId(ParameterContext paramCtx) throws Exception;

	public HashMap<String, List<ZValue>> getMenuCategories(List<ZValue> list);

	public HashMap<String, List<ZValue>> setMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth, String[] pos) ;

	public HashMap<String, List<ZValue>> setMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth, String[] pos, String gubun) ;

	public HashMap<String, List<ZValue>> setNullLinkMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth) ;

	public void markLeafMenu(HashMap<String, List<ZValue>> menuCategoryMap, String key) ;

	public ZValue getCurrentMenuVO(HashMap<String, List<ZValue>> menuCategoryMap, String menuLc);

	public ZValue getCurrentMenuVO(HashMap<String, List<ZValue>> menuCategoryMap, String menuLc, ZValue savedMenuVO, int menuNo, int depth)	;

	public void modifyRearrangeMenu(HashMap<String, List<ZValue>> menuMap) throws Exception;

	public HashMap<String, List<ZValue>> getTopMenuMap(List<ZValue> menuStructure) throws Exception;

	/**
	 * 화면노출여부 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void scrinExpsrAtPop(ParameterContext paramCtx) throws Exception;

	/**
	 * 화면노출여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateScrinExpsrAt(ParameterContext paramCtx) throws Exception;

}
