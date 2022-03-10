package site.unp.cms.service.scheduler;


import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;

/**
 * 첨부파일 다운로드 된 내역을 일별로 집계 테이블 insert 하는 스캐즐
 * cron 순서 대로 다음과 같다.
 * 초(seconds)  0 ~ 59
 * 분(minutes)  0 ~ 59
 * 시(hours)    0 ~ 23
 * 날(day-of-month) 1 ~ 31
 * 달(month) 1 ~ 12 or JAN ~ DEC
 *  요일(day-of-week)  1 ~ 7 or SUN-SAT
 * 년도 빈값, 1970 ~ 2099
 * 
 * ****주의사항) 운영 이중화시... spring.profiles.active=real,realScheduler
 * 
 * @author idtong
 */
@Component
public class CmmnFileDwldSmScheduleService{


	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;


	/**
	 * 첨부파일 다운로드 된 내역을 일별로 집계 테이블 insert 한다.
	 * 1일 1회 실행된다.
	 */
	//@Scheduled(cron = "0 */10 * * * *")
	@Scheduled(cron = "0 10 * * * *")
	//@Scheduled(cron = "0 * * * * *")
	public void cmmnFileDwldSmExec() throws Exception {
		sqlDAO.save("saveCmmnFileDwldSm", null);
	}

}