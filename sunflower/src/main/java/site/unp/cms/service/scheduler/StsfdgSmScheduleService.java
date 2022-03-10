package site.unp.cms.service.scheduler;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;

/**
 * 만족도를 일별로 집계 테이블로 insert 하는 스캐즐
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
public class StsfdgSmScheduleService{

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	/**
	 * 만족도를 일별로 집계 테이블 insert 한다.
	 * 1일 1회 실행된다.
	 */
	@Scheduled(cron = "50 12 * * * *")
	//@Scheduled(cron = "30 * * * * *")
	public void stsfdgSmExec() throws Exception {
		sqlDAO.save("saveStsfdgSm", null);
	}

}
