package com.scheduler;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.baroservice.ws.CorpState;
import com.huation.common.corpState.CorpStateDAO;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.struts.StrutsDispatchAction;
import com.ibm.icu.text.SimpleDateFormat;

public class CorpStateJob extends StrutsDispatchAction implements Job {

	/* 바로빌 인증키 */
	public static String Closure_KEY = config.getString("framework.hueware.invocekey_dev");
	/* 휴에이션 사업자 번호 */
	public static String CorpNum = config.getString("framework.hueware.corpNum");

	private static final SimpleDateFormat TIMESTAMP_FMT = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSSS");

	CorpStateDAO dao = new CorpStateDAO();

	CorpState result = new CorpState();

	@Override
	public void execute(JobExecutionContext ctx) throws JobExecutionException {
		int retVal = 0;

		try {

			String currentDate = TIMESTAMP_FMT.format(new Date());

			/* 1. Get CheckCorpNum list */
			ListDTO ldto = dao.GetCorpNumList();
			/* 2. Search CorpNum list & Update */
			retVal = dao.getCorpStates(ldto, Closure_KEY, CorpNum);
			
			System.out.println(String.format(" 고객사 휴폐업 조회JOB 완료 : [%s]",currentDate)); 
			

		} catch (Exception e) {

			log.error("[ 고객사 휴폐업 조회 JOB - ERROR ]" + e.getMessage());

		}

	}

}