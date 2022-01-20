package com.scheduler;

import javax.servlet.http.HttpServlet;

import org.quartz.CronExpression;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

public class SchedulerInit extends HttpServlet{

	/*
	 * 객체 직렬화 중 클레스 UID의 값이 변경되는 것을 방지하기 위해 serialVersionUID값을 명시적으로 선언
	 */
	private static final long serialVersionUID = 1L;
	private SchedulerFactory schedulerFactory;
	private Scheduler scheduler;
	
	/*
	 * 스케쥴러 인스턴스화
	 */
	public SchedulerInit() {
		
		try {
			// 스케쥴러 생성
			schedulerFactory = new StdSchedulerFactory();
			scheduler = schedulerFactory.getScheduler();
			
			scheduler.start(); //스케쥴러 시작
			
			Class<? extends Job> JobClass = CorpStateJob.class;
			
			JobDetail job = JobBuilder.newJob(JobClass).build(); 
			CronScheduleBuilder cronSch = CronScheduleBuilder.cronSchedule(new CronExpression("0 0 1 * * ?"));
			CronTrigger trigger = (CronTrigger) TriggerBuilder.newTrigger()
															.withSchedule(cronSch)
															.forJob(job)
															.build();
			scheduler.scheduleJob(job,trigger);
			
		} catch (Exception e) {
			System.out.println("[ 스케쥴러 인스턴스화 ERROR ] : " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	

}
