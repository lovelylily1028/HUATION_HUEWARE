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
import com.huation.common.recruit.IntroDTO;

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
public class IntroDAO extends AbstractDAO {

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
	
	public IntroDTO registResult(String applycode) throws DAOException{
		
		String apply_code="";
		String passwd="";
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT APPLY_CODE FROM T_INTRODUCE ");
		sb.append(" WHERE APPLY_CODE = ? ");
		sql.setString(applycode);

		sql.setSql(sb.toString());
		log.debug("[registResult]" + sql.toString());

		DataSet ds = null;
		IntroDTO resultDto=new IntroDTO();
		
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
	 * 자기소개 등록.   
	 * @param commNos 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addHistory(IntroDTO introDto) throws Exception{
		
		int retval = 0;
		HashMap rtnMap = new HashMap();
		BaseDAO dao = null;
		int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		HashMap m = null;
		boolean a = false;
		
		try {
			dao = new BaseDAO(this.getClass());
			dao.startTransaction();

			sql = new QueryStatement(); 

			 sb.append(" INSERT T_INTRODUCE  (APPLY_CODE,HISTORY_CODE,INTRODUCE1,INTRODUCE2,INTRODUCE3) 	\n");
			 sb.append(" VALUES(?,?,?,?,?); \n");
				
			 
			 sql.setSql(sb.toString());

			 sql.setString(introDto.getApply_code());
			 sql.setString(introDto.getHistory_code());
			 sql.setString(introDto.getIntroduce1());
			 sql.setString(introDto.getIntroduce2());
			 sql.setString(introDto.getIntroduce3());
			 
			if( dao.executeQuery(sql) > 0 ){
				retval = 1;
			} else {
				retval = 0;
			}
			
			dao.commitTransaction();	
		 } catch (Exception e) {
			 	log.error(e.getMessage(), e);
			} finally {
				dao.endTransaction();
			}
		 return retval; 
		
	}
	
	
	/**
	 * 자기소개 View 정보.
	 * @param dto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public IntroDTO introView( String apply_code) throws DAOException{
		
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		IntroDTO introDto=null;
		
		sb.append("				SELECT * FROM T_INTRODUCE   \n");
		sb.append("				WHERE APPLY_CODE=?	\n");
		
		log.debug(sb.toString());
		sql.setSql(sb.toString());
		sql.setString(apply_code);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
				introDto = new IntroDTO();
				introDto.setApply_code(StringUtil.nvl(ds.getString("APPLY_CODE"),""));
				introDto.setHistory_code(StringUtil.nvl(ds.getString("HISTORY_CODE"),""));
				introDto.setIntroduce1(StringUtil.nvl(ds.getString("INTRODUCE1"),""));
				introDto.setIntroduce2(StringUtil.nvl(ds.getString("INTRODUCE2"),""));
				introDto.setIntroduce3(StringUtil.nvl(ds.getString("INTRODUCE3"),""));

			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return introDto;
	}
	/**
	 * 자기소개 삭제. 
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
			 sb.append(" DELETE T_INTRODUCE					 ");
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
