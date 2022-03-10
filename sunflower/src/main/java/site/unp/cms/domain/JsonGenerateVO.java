package site.unp.cms.domain;

import java.util.Map;

public class JsonGenerateVO  {
	
	/**
	 * JSON 객체를 생성한다.
	 * @param actionType - 화면처리종류(MOVE,POPUP,C,R,U,D 등)
	 * @param rep - HttpServletResponse
	 * @param req - HttpServletRequest
	 */
	public JsonGenerateVO(String actionType) {
		this.actionType = actionType;
	}
	
	/** 화면처리종류 (MOVE : 화면이동 ,POPUP : 팝업 ,  C : 등록, R : 조회, U : 수정, D : 삭제 ) */
	private String actionType = null;
	
	/** List<EgovMap> 타입의 형식 */
	private Map<Object, Object> egovListMapTypeJsonData = null;
	
	/** 사용자가 임의로 키/값을 정하는 형식 */
	private Map<Object, Object> mapTypeJsonData = null;
	
	/** 이벤트 발생시 필요 파라미터 */
	private Map<Object, Object> eventActionData = null;	
	
	private String charSet = "utf-8";
	
	/**
	 * List<EgovMap> 형의 파라미터
	 * @param parameterMap
	 */
	public void setEgovListMapTypeJsonData(Map<Object, Object> egovListMapTypeJsonData) {
		this.egovListMapTypeJsonData = egovListMapTypeJsonData;
	}

	public Map<Object, Object> getEgovListMapTypeJsonData() {
		return egovListMapTypeJsonData;
	}
	public Map<Object, Object> getMapTypeJsonData() {
		return mapTypeJsonData;
	}

	public void setMapTypeJsonData(Map<Object, Object> mapTypeJsonData) {
		this.mapTypeJsonData = mapTypeJsonData;
	}
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public Map<Object, Object> getEventActionData() {
		return eventActionData;
	}
	public void setEventActionData(Map<Object, Object> eventActionData) {
		this.eventActionData = eventActionData;
	}
	public String getCharSet() {
		return charSet;
	}
	public void setCharSet(String charSet) {
		this.charSet = charSet;
	}

}
