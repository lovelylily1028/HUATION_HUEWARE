package com.huation.common.recruit;  

import java.io.BufferedWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.huation.common.BaseDAO;
import com.huation.common.recruit.EduDTO;

import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ISqlStatement;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.huation.framework.persist.ResultDTO;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.NumberUtil;
import com.huation.framework.util.StringUtil;


/**
 * @author 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class EduDAO extends AbstractDAO {

	/**
	 * 이력코드 구하기.
	 * @param recCnt  MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getHistoryCode(int recruit_no) throws DAOException{
		
		String recruitNo = null;

		recruitNo = String.valueOf(recruit_no);
        if(recruitNo.length()==1){
        	recruitNo = "00000000"+ recruitNo;	
        }else if(recruitNo.length()==2){
        	recruitNo = "0000000"+ recruitNo;
        }else if(recruitNo.length()==3){
        	recruitNo = "000000"+ recruitNo;
        }else if(recruitNo.length()==4){
        	recruitNo = "00000"+ recruitNo;
        }else if(recruitNo.length()==5){
        	recruitNo = "0000"+ recruitNo;
        }else if(recruitNo.length()==6){
        	recruitNo = "000"+ recruitNo;
        }else if(recruitNo.length()==7){
        	recruitNo = "00"+ recruitNo;
        }else if(recruitNo.length()==8){
        	recruitNo = "0"+ recruitNo;
        }
 
		return recruitNo;
	}	
	/**
	 * 등록여부 및 지원코드 가져오기
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public EduDTO registResult(String applycode) throws DAOException{
		
		String apply_code="";
		String passwd="";
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT APPLY_CODE FROM T_EDU_HISTORY ");
		sb.append(" WHERE APPLY_CODE = ? ");
		sql.setString(applycode);

		sql.setSql(sb.toString());
		log.debug("[registResult]" + sql.toString());

		DataSet ds = null;
		EduDTO resultDto=new EduDTO();
		
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 apply_code = ds.getString("APPLY_CODE");
			 }
			 
			 resultDto.setApply_code(apply_code);
			 
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return resultDto;
	}	
	/**
	 * 교육사항 등록.   
	 * @param commNos 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int[] addHistory(String[] commNos) throws Exception{
		
		int retVal = 0;

		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		Statement stmt = null;
		
		String[] r_data=null;
		int[] resultVal=null;
		String history_code="";

		 
		try{
			conn = broker.getConnection();	
			stmt = conn.createStatement();

			stmt.clearBatch(); 

			for(int i=0; commNos != null && i<commNos.length; i++){ 
				sb.setLength(0);
				r_data = StringUtil.getTokens(commNos[i], "|");
				
				history_code=getHistoryCode(i);
				/*
				log.debug("history_code:"+history_code);
				log.debug("r_data[0]:"+StringUtil.nvl(r_data[0],""));
				log.debug("r_data[1]:"+StringUtil.nvl(r_data[1],""));
				log.debug("r_data[2]:"+StringUtil.nvl(r_data[2],""));
				log.debug("r_data[3]:"+StringUtil.nvl(r_data[3],""));
				log.debug("r_data[4]:"+StringUtil.nvl(r_data[4],""));
				log.debug("r_data[5]:"+StringUtil.nvl(r_data[5],""));
				log.debug("r_data[6]:"+StringUtil.nvl(r_data[6],""));
				*/
				sb.append(" INSERT T_EDU_HISTORY  (APPLY_CODE,HISTORY_CODE,START_YMD,END_YMD,EDU_NM,EDU_ORG,COMPLETE_YN,EDU_DETAIL) 	\n");
				sb.append(" VALUES('"+StringUtil.nvl(r_data[0],"")+"','"+StringUtil.nvl(history_code,"")+"','"+StringUtil.nvl(r_data[1],"")+"','"+StringUtil.nvl(r_data[2],"")+"','"+StringUtil.nvl(r_data[3],"")+"','"+StringUtil.nvl(r_data[4],"")+"','"+StringUtil.nvl(r_data[5],"")+"','"+StringUtil.nvl(r_data[6],"")+"'); \n");
				
				log.debug("[addHistory]" + sb.toString());
				
				stmt.addBatch(sb.toString());
			}
			
			resultVal=stmt.executeBatch();

		 }catch(Exception e){
			 	e.printStackTrace();
				try {
					if(conn != null) conn.rollback(); 
				} catch(SQLException ignore) {
					log.error(ignore.getMessage(), ignore);
				}
				throw new DAOException(e.getMessage());
			 } finally {
			 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
			 }		 	
		 
		 return resultVal; 
	}
	
	
	/**
	 * 교육사항 View 정보.
	 * @param dto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ArrayList historyListView( String apply_code) throws DAOException{
		
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		EduDTO eduDto  =null;
		ArrayList<EduDTO> arrlist = new ArrayList<EduDTO>();
		try{			
			sbSql.append(" SELECT APPLY_CODE,HISTORY_CODE,START_YMD,END_YMD,EDU_NM,EDU_ORG,COMPLETE_YN,EDU_DETAIL ");
			sbSql.append(" FROM T_EDU_HISTORY ");
			sbSql.append(" WHERE APPLY_CODE = ?");
			
			sql.setString(apply_code);
			sql.setSql(sbSql.toString());
			log.debug("historyListView["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 eduDto = new EduDTO();
					 eduDto.setApply_code(ds.getString("APPLY_CODE"));
					 eduDto.setHistory_code(ds.getString("HISTORY_CODE"));
					 eduDto.setStart_ymd(ds.getString("START_YMD"));
					 eduDto.setEnd_ymd(ds.getString("END_YMD"));
					 eduDto.setEdu_nm(ds.getString("EDU_NM"));
					 eduDto.setEdu_org(ds.getString("EDU_ORG"));
					 eduDto.setComplete_yn(ds.getString("COMPLETE_YN"));
					 eduDto.setEdu_detail(ds.getString("EDU_DETAIL"));

					 arrlist.add(eduDto);
				 }
			 }catch(Exception e){
			      e.printStackTrace();
			      log.error(e.getMessage());
				 throw new DAOException(e.getMessage());
			 }finally{
				 if(ds != null) ds.close();
		    }
			 return arrlist;
 
		}catch(Exception e){
			throw new DAOException(e.getMessage());
		}
	}
	/**
	 * 교육사항 삭제. 
	 * @param historyDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int deleteHistory(String apply_code) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" DELETE T_EDU_HISTORY					 ");
			 sb.append(" WHERE APPLY_CODE = ? 					 ");

	         sql.setSql(sb.toString());

			 sql.setString(apply_code);
	         
			 log.debug("[deleteHistory]" + sql.toString());
			 conn = broker.getConnection();
			 conn.setAutoCommit(false);		 
			 
			 retVal = broker.executeUpdate(sql, conn);
			 log.debug("[retVal]" +retVal);
		     if(retVal > 0){
			     conn.commit();
		     }else{
		     	 conn.rollback();
		     }	     
		 }catch(Exception e){
		 	e.printStackTrace();
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			throw new DAOException(e.getMessage());
		 } finally {
		 	 if(rsDto != null) rsDto.close();
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		 }		 	
	 
	 return retVal; 
	 
	}

 }
