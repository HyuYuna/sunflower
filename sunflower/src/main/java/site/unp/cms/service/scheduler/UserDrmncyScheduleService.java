package site.unp.cms.service.scheduler;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import site.unp.cms.mail.AttachmentMessageSender;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ZValue;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;

/**
 * 사이트 접속통계를 집계 테이블로 insert 하는 스캐즐
 * cron 순서 대로 다음과 같다.
 * 초(seconds)  0 ~ 59
 * 분(minutes)  0 ~ 59
 * 시(hours)    0 ~ 23
 * 날(day-of-month) 1 ~ 31
 * 달(month) 1 ~ 12 or JAN ~ DEC
 *  요일(day-of-week)  1 ~ 7 or SUN-SAT
 * 년도 빈값, 1970 ~ 2099
 * @author idtong
 */

@Component
public class UserDrmncyScheduleService {
	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;


	@Value("${Globals.ucms.webRootPath}")
	private String webRootPath;

	@Value("${Globals.ucms.domain}")
	private String domain;

	@Resource(name = "siteInfoService")
	private SiteInfoService siteInfoService;

	@Resource(name = "messageSender")
	private AttachmentMessageSender messageSender;

	/**
	 * 1년간 이용하지 않는 사용자는 1개월 전에 휴면계정전환을 이메일 또는 문자로 이를 안내한다.(U-CMS에서는 메일 발송)
	 * 1일 1회 실행된다.
	 */

	@Scheduled(cron = "0 0 20 * * *")
	//@Scheduled(cron = "0 51 * * * *")
	public void drmncyMailProc() throws Exception {
		List<ZValue> resultList = sqlDAO.findAll("findAllDrmncyMail", null);

		drmncyMailSend(resultList);
	}

	/**
	 * 1개월 전 메일 발송에도 로그인 하지 않는 사용자는 휴면계정 처리한다.
	 * (불필요한 개인정보 보관을 최소화하고 유출 위험을 줄이기 위해 장기간 이용하지 않는 이용자의 개인정보를 파기 또는 별도 분리 보관하는 제도이다)
	 * 휴면 계정은 서비스 사용에 제한히 있으며, 메일발송, 홍보 SMS발송, 포이트 등의 사용이 이루어져서는 안된다.
	 * tm_user_drmncy (휴면 테이블로 이동)하며 다른 사람이 이 사용자의 ID를 사용해서는 안된다.
	 * 1일 1회 실행된다.
	 */
	@Scheduled(cron = "0 3 20 * * *")
	//@Scheduled(cron = "0 53 * * * *")
	public void drmncyCnvrsProc() throws Exception {
		List<ZValue> resultList = sqlDAO.findAll("findAllUserDrmncyList", null);
		if (resultList.size()>0){
			for (int i=0; i<resultList.size();i++){
				ZValue result = resultList.get(i);
				/**
				 * 별도의 DB에 저장하는 것을 원칙으로 하여 개인정보 처리시스템DB가 분리된 경우 해당 sqlDao를 변경하여 사용
				 * 현재는 테이블만 분리하여 처리함
				 */
				sqlDAO.save("saveUserDrmncy",result);
				sqlDAO.deleteOne("deleteUserDrmncy", result);
			}
		}
	}

	/**
	 * 휴면 상태로 전환된 후 4년이 지나도록 서비스 사용이 없을 경우 자동탈퇴처리(개인정보 삭제) 되어야 한다.
	 * 1일 1회 실행된다.
	 */
	@Scheduled(cron = "0 6 20 * * *")
	//@Scheduled(cron = "0 55 * * * *")
	public void drmncySecsnProc() throws Exception {
		List<ZValue> resultList = sqlDAO.findAll("findAllUserDrmncyList", null);

		/**
		 * 탈퇴처리와 같은 절차처리
		 */
		if (resultList.size()>0){
			for (int i=0; i<resultList.size();i++){
				ZValue result = resultList.get(i);
				result.put("userSecsnMemo", "휴면계정  자동 탈퇴처리");
				// 휴면계정 삭제 처리
				sqlDAO.deleteOne("deleteUserDrmncySecsn", result);
				// 탈최처리
				sqlDAO.deleteOne("deleteUserPin", result);
				sqlDAO.deleteOne("deleteMemberSaltInfo", result);
				sqlDAO.save("saveUserMemberSecsn", result);
			}
		}
	}
	
	/**
	 * 6개월 동안 사용하지 않는 사용자는 계정 잠김 처리한다.
	 * @throws Exception
	 */
	@Scheduled(cron = "0 3 0 * * *")
	//@Scheduled(cron = "0 55 * * * *")
	public void mngrLockProc() throws Exception {
		sqlDAO.save("saveMngrLock", null);
	}

	/**
	 * 인증메일 발송
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void drmncyMailSend(List<ZValue> resultList) throws Exception {
		ZValue param = new ZValue();
		String emailFormStr = FileParser.getFileToString(webRootPath +"/template/email/userDrmncyMailForm.html"); //메일폼 서식불러오기
		ZValue siteVO = siteInfoService.getSiteBySiteName("ucms");
		String addres = siteVO.getString("adres1") + " " + siteVO.getString("adres2") + siteVO.getString("insttNm") + ", TEL : " + siteVO.getString("telno") + ", FAX : " + siteVO.getString("faxno");
		String cpyrht = siteVO.getString("cpyrhtCn");
		String siteNm = siteVO.getString("siteNm");
		String siteUrlad = siteVO.getString("siteUrlad");

		String subject = siteNm + ") 회원님의 계정이 휴면 계정으로 전환 예정임을 알림니다.";

		if (resultList.size()>0){
			for (int i=0; i<resultList.size();i++){
				ZValue result = resultList.get(i);
				String userEmad = result.getString("userEmad");

				emailFormStr = emailFormStr.replace("@siteNm@", siteNm);
				emailFormStr = emailFormStr.replace("@domain@", domain);
				emailFormStr = emailFormStr.replace("@subject@", subject);
				emailFormStr = emailFormStr.replace("@addres@", addres);
				emailFormStr = emailFormStr.replace("@cpyrht@", cpyrht);
				emailFormStr = emailFormStr.replaceAll("@siteUrl@", siteUrlad);


				param.put("subject", subject);
				param.put("text", emailFormStr);
				param.put("to", userEmad);

				messageSender.sndngEmail(param);
				sqlDAO.save("updateUserInfoDrmncyNtcn", result);
			}
		}

	}
}
