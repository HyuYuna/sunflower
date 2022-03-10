package site.unp.cms.util;

public class UriUtil {

	public static String getGhvrSumry(String conectUrlad){
		String ghvrSumry ="";
		String methodId = conectUrlad.substring(conectUrlad.lastIndexOf("/"),conectUrlad.length());
		if (methodId.indexOf("list")>-1){
			ghvrSumry = "목록조회";
		} else if (methodId.indexOf("forUpdate")>-1){
			ghvrSumry = "수정화면 조회";
		} else if (methodId.indexOf("forInsert")>-1){
			ghvrSumry = "등록화면 조회";
		} else if (methodId.indexOf("update")>-1){
			ghvrSumry = "수정처리";
		} else if (methodId.indexOf("insert")>-1){
			ghvrSumry = "등록처리";
		} else if (methodId.indexOf("view")>-1){
			ghvrSumry = "상세조회";
		} else if (methodId.indexOf("delete")>-1){
			ghvrSumry = "삭제처리";
		} else if (methodId.indexOf("toLogin")>-1){
			ghvrSumry = "로그인";
		} else if (methodId.indexOf("logout")>-1){
			ghvrSumry = "로그아웃";
		} else if (conectUrlad.indexOf("main/main.do")>-1 || conectUrlad.indexOf("bos/loginProcess.do")>-1){
			ghvrSumry = "메인조회";
		} else {
			ghvrSumry = "조회";
		}

		return ghvrSumry;
	}
}
