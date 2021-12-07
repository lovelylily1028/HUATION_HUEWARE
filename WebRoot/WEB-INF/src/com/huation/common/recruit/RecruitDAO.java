package com.huation.common.recruit;  

import java.io.BufferedWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.huation.common.BaseDAO;
import com.huation.common.about.NewsDTO;
import com.huation.common.about.NotifyDTO;
import com.huation.common.recruit.RecruitDTO;

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
public class RecruitDAO extends AbstractDAO {
	
	/**
	 * ä��NO MAXī��Ʈ ���ϱ�.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getRecruitCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(RECRUIT_NO),0)+1) REC_CNT FROM T_RECRUIT ");
		 
		log.debug("[getRecruitCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("REC_CNT");
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return compCnt;
	}

	/**
	 * ä���ڵ� ���ϱ�.
	 * @param recCnt  MAX ī��Ʈ
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getRecruitNo(String recCnt) throws DAOException{
		
		String recruitNo = null;
		int recruit_no =0;
		
		recruit_no = NumberUtil.parseInt(recCnt,0);

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
	 * ä������ ����Ʈ.   
	 * @param curpage   ���� ������ ī��Ʈ
	 * @param listScale   list ����
	 * @param pageScale   page ����
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO recruitPageList(RecruitDTO recruitDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql ������
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" RECRUIT_NO,RECRUIT_TYPE,SUBJECT, CONTENTS, CAREER, RECRUIT_START,RECRUIT_END");
			sql.setSelect(" RECRUIT_NO,RECRUIT_TYPE,SUBJECT, CONTENTS, CAREER, RECRUIT_START,RECRUIT_END ") ;
			sql.setFrom	(" T_RECRUIT \n");
			
			where += "  USE_YN='Y'  \n ";

			if(recruitDto.getSearchGb().equals("A")){
				
				where += " AND SUBJECT LIKE ? ";
				sql.setString("%" + recruitDto.getSearchtxt() + "%");
				
			}else if(recruitDto.getSearchGb().equals("B")){
				
				where += " AND RECRUIT_TYPE LIKE ? ";
				sql.setString("%" + recruitDto.getSearchtxt() + "%");
				
			}else if(recruitDto.getSearchGb().equals("C")){
				
				where += " AND CAREER LIKE ? ";
				sql.setString("%" + recruitDto.getSearchtxt() + "%");
				
			}
			
			sql.setWhere(where);

			sql.setOrderby(" RECRUIT_NO DESC "); 
		
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			//---- �������� �� ��ȯ�� ����
			if(listScale != -1 && pageScale != -1){
				retVal = broker.executeListQuery(sql, curpage, listScale, pageScale);
			}else{
				retVal = broker.executeListQuery(sql, curpage);
			}
			
		    if(retVal != null){
			    conn.commit();
			}else{
			    conn.rollback();
			}
			
			
		}catch(SQLException e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}	
		
		return retVal;
	}
	/**
	 * ä�� �⺻���� ��������
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public RecruitDTO recuritDefaultInfo(RecruitDTO recruitDto) throws DAOException{

		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT RECRUIT_FIELD,CAREER FROM T_RECRUIT ");

		sb.append(" WHERE RECRUIT_NO = ? ");
		sql.setString(recruitDto.getRecruit_no());

		sql.setSql(sb.toString());
		log.debug("[recuritDefaultInfo]" + sql.toString());

		DataSet ds = null;

		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 recruitDto.setRecruit_field(ds.getString("RECRUIT_FIELD"));
				 recruitDto.setCareer(ds.getString("CAREER"));
			 }
		 
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return recruitDto;
	}
	/**
	 * ä����� ����ϱ�. 
	 * @param recruitDto ä����� ����
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addRecruit(RecruitDTO recruitDto) throws Exception{
		
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
			 sb.append(" 		INSERT INTO T_RECRUIT                                                      \n");
			 sb.append(" 		(RECRUIT_NO,RECRUIT_TYPE,RECRUIT_FIELD,SUBJECT, CONTENTS, CAREER, RECRUIT_START,RECRUIT_END,REG_ID,REG_DT,USE_YN \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?, ?, ?, ?,?, ?, ?, ?,?, Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ,'Y'               \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(recruitDto.getRecruit_no());
			 sql.setString(recruitDto.getRecruit_type());
			 sql.setString(recruitDto.getRecruit_field());
			 sql.setString(recruitDto.getSubject());
			 sql.setString(recruitDto.getContents());
			 sql.setString(recruitDto.getCareer());
			 sql.setString(recruitDto.getRecruit_start());
			 sql.setString(recruitDto.getRecruit_end());
			 sql.setString(recruitDto.getReg_id());
			 
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
	 * ä����� View ����.
	 * @param recruit_no  ������ Ű
	 * @return ActionForward
	 * @throws DAOException
	 */
	public RecruitDTO getRecruitView( String recruit_no) throws DAOException{
		
		RecruitDTO recruitDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT RECRUIT_NO,RECRUIT_TYPE,RECRUIT_FIELD,SUBJECT, CONTENTS, CAREER, RECRUIT_START,RECRUIT_END,REG_ID	\n");
		sb.append("				FROM T_RECRUIT	\n");
		sb.append("				WHERE RECRUIT_NO=?	\n");
		
		log.debug(sb.toString());
		//param
		sql.setSql(sb.toString());
		sql.setString(recruit_no);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
			
			 recruitDto = new RecruitDTO();

			 recruitDto.setRecruit_no(StringUtil.nvl(ds.getString("RECRUIT_NO"),""));
			 recruitDto.setRecruit_type(StringUtil.nvl(ds.getString("RECRUIT_TYPE"),""));
			 recruitDto.setRecruit_field(StringUtil.nvl(ds.getString("RECRUIT_FIELD"),""));
			 recruitDto.setSubject(StringUtil.nvl(ds.getString("SUBJECT"),""));
			 recruitDto.setContents(StringUtil.nvl(ds.getString("CONTENTS"),""));
			 recruitDto.setCareer(StringUtil.nvl(ds.getString("CAREER"),""));
			 recruitDto.setRecruit_start(StringUtil.nvl(ds.getString("RECRUIT_START"),""));
			 recruitDto.setRecruit_end(StringUtil.nvl(ds.getString("RECRUIT_END"),""));
			 recruitDto.setReg_id(StringUtil.nvl(ds.getString("REG_ID"),""));
			
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return recruitDto;
	}
	/**
	 * ä����� �����ϱ�. 
	 * @param notifyDto �������� ����
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editRecruit(RecruitDTO recruitDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_RECRUIT SET					 ");
			 sb.append(" RECRUIT_TYPE= ?,RECRUIT_FIELD= ?,SUBJECT= ?, CONTENTS= ?, CAREER= ?, RECRUIT_START= ?,RECRUIT_END= ?,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')");
	         sb.append(" WHERE RECRUIT_NO = ?					 ");
			
	         sql.setSql(sb.toString());

	         sql.setString(recruitDto.getRecruit_type());
			 sql.setString(recruitDto.getRecruit_field());
			 sql.setString(recruitDto.getSubject());
			 sql.setString(recruitDto.getContents());
			 sql.setString(recruitDto.getCareer());
			 sql.setString(recruitDto.getRecruit_start());
			 sql.setString(recruitDto.getRecruit_end());
			 sql.setString(recruitDto.getMod_id());
			 sql.setString(recruitDto.getRecruit_no());
				
			 log.debug("[editRecruit]" + sql.toString());
			 conn = broker.getConnection();
			 conn.setAutoCommit(false);		 
			 
			 retVal = broker.executeUpdate(sql, conn);
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
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		 }		 	
	 
	 return retVal; 
	}
	/**
	 * ä�������� �����Ѵ�.
	 * @param recruitDto ä������ Ű
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteRecruitOne(RecruitDTO recruitDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_RECRUIT  SET 	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE RECRUIT_NO = ? \n");
		
		sql.setString(recruitDto.getMod_id());
		sql.setString(recruitDto.getRecruit_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteRecruitOne]" + sql.toString());

		try{
			conn = broker.getConnection();
			conn.setAutoCommit(false);
		    retVal = broker.executeUpdate(sql,conn);
		    
		    if(retVal > 0){
			    conn.commit();
			}else{
			    conn.rollback();
			}
		    
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}		 
		return retVal;
	}	
	/**
	 * ä����� ����Ʈ( ����)  
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ArrayList recruitList(RecruitDTO recruitDto) throws DAOException {
		
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		RecruitDTO resultDto  =null;
		ArrayList<RecruitDTO> arrlist = new ArrayList<RecruitDTO>();
		try{			

			int rowCnt=recruitDto.getRowCnt();
			
			sbSql.append(" SELECT *  FROM ");
			sbSql.append("  (SELECT ROW_NUMBER() over(order by RECRUIT_NO Desc) nn ,RECRUIT_NO,RECRUIT_TYPE,SUBJECT, CONTENTS, CAREER, REG_DT,RECRUIT_START,RECRUIT_END FROM T_RECRUIT WHERE USE_YN='Y' ) as t0 ");
			sbSql.append(" WHERE nn< "+rowCnt);

			sql.setSql(sbSql.toString());
			log.debug("recruitList["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 resultDto = new RecruitDTO();
					 resultDto.setRecruit_no(ds.getString("RECRUIT_NO"));
					 resultDto.setSubject(ds.getString("SUBJECT"));
					 resultDto.setContents(ds.getString("CONTENTS"));
					 resultDto.setReg_dt(ds.getString("REG_DT"));
					 resultDto.setRecruit_start(ds.getString("RECRUIT_START"));
					 resultDto.setRecruit_end(ds.getString("RECRUIT_END"));
					
					 arrlist.add(resultDto);
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
 }
