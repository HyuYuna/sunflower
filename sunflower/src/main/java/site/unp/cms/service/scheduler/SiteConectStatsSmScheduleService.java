package site.unp.cms.service.scheduler;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
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
public class SiteConectStatsSmScheduleService {

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;


	/**
	 * 사이트 접속통계를 기간별로 집계하여 insert 처리 한다.
	 * 1일 1회 실행된다.
	 */

	//@Scheduled(cron = "10 * * * * *")
	@Scheduled(cron = "0 12 * * * *")
	//@Scheduled(cron = "0 0 1 * * *")
	//@CacheEvict(value=SiteConectStatsDAO.SITE_CONECT_STATS_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void siteConectStatsSmPdExec() throws Exception {

		ZValue zvl = new ZValue();
		String smSe = "PD";

		zvl.put("smSe", smSe);
		sqlDAO.save("saveSiteConectStatsSmPd", zvl);
	}


	/**
	 * 사이트 접속통계를 메뉴별로 집계하여 insert 처리 한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "20 * * * * *")
	//@Scheduled(cron = "10 */10 * * * *")
	@Scheduled(cron = "10 12 * * * *")
	//@Scheduled(cron = "0 30 1 * * *")
	public void siteConectStatsSmMenuExec() throws Exception {

		ZValue zvl = new ZValue();
		String smSe = "MENU";

		zvl.put("smSe", smSe);
		sqlDAO.save("saveSiteConectStatsSmMenu", zvl);
	}

	/**
	 * 사이트 접속통계를 운영체제별로 집계하여 insert 처리 한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "30 * * * * *")
	@Scheduled(cron = "20 12 * * * *")
	//@Scheduled(cron = "0 0 2 * * *")
	public void siteConectStatsSmOSExec() throws Exception {

		ZValue zvl = new ZValue();
		String smSe = "OS";

		zvl.put("smSe", smSe);
		sqlDAO.save("saveSiteConectStatsSmOS", zvl);

	}

	/**
	 * 사이트 접속통계를 웹브라우저별로 집계하여 insert 처리 한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "40 * * * * *")
	@Scheduled(cron = "30 12 * * * *")
	//@Scheduled(cron = "0 30 2 * * *")
	public void siteConectStatsSmWbsrExec() throws Exception {

		ZValue zvl = new ZValue();
		String smSe = "BROWSER";

		zvl.put("smSe", smSe);

		sqlDAO.save("saveSiteConectStatsSmWbsr", zvl);
	}

	/**
	 * 사이트 접속통계를 PC/모바일 구분별로 집계하여 insert 처리 한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "50 * * * * *")
	@Scheduled(cron = "40 12 * * * *")
	//@Scheduled(cron = "0 0 3 * * *")
	public void siteConectStatsSmPMExec() throws Exception {

		ZValue zvl = new ZValue();
		String smSe = "PM";

		zvl.put("smSe", smSe);
		sqlDAO.save("saveSiteConectStatsSmPM", zvl);
	}
}
