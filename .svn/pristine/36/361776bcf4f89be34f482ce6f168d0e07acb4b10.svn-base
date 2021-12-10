package com.huation.common.about;  

import java.io.BufferedWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.huation.common.BaseDAO;
import com.huation.common.about.NotifyDTO;
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
public class NotifyDAO extends AbstractDAO {
	
	/**
	 * 공지NO MAX카운트 구하기.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getNotifyCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(NOTI_NO),0)+1) NOTI_CNT FROM T_NOTIFY ");
		 
		log.debug("[getNotifyCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("NOTI_CNT");
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
	 * 공지코드 구하기.
	 * @param recCnt  MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getNofityNo(String notiCnt) throws DAOException{
		
		String notiNo = null;
		int noti_no =0;
		
		noti_no = NumberUtil.parseInt(notiCnt,0);

		notiNo = String.valueOf(noti_no);
        if(notiNo.length()==1){
        	notiNo = "00000000"+ notiNo;	
        }else if(notiNo.length()==2){
        	notiNo = "0000000"+ notiNo;
        }else if(notiNo.length()==3){
        	notiNo = "000000"+ notiNo;
        }else if(notiNo.length()==4){
        	notiNo = "00000"+ notiNo;
        }else if(notiNo.length()==5){
        	notiNo = "0000"+ notiNo;
        }else if(notiNo.length()==6){
        	notiNo = "000"+ notiNo;
        }else if(notiNo.length()==7){
        	notiNo = "00"+ notiNo;
        }else if(notiNo.length()==8){
        	notiNo = "0"+ notiNo;
        }
 
		return notiNo;
	}	
		
	/**
	 * 공지정보 리스트.   
	 * @param curpage   현재 페이지 카운트
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO notifyPageList(NotifyDTO notifyDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" NOTI_NO,SUBJECT, CONTENTS, REG_ID,REG_DT");
			sql.setSelect(" NOTI_NO,SUBJECT, CONTENTS, REG_ID,REG_DT ") ;
			sql.setFrom	(" T_NOTIFY \n");
			
			where += " USE_YN = 'Y'  \n ";
			
			if(notifyDto.getSearchGb().equals("A")){
				
				where += " AND SUBJECT LIKE ? ";
				sql.setString("%" + notifyDto.getSearchtxt() + "%");
				
			}
			
			sql.setWhere(where);
			sql.setOrderby(" NOTI_NO DESC "); 
		
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			//---- 쿼리실행 및 반환값 설정
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
	 * 공지사항 등록하기. 
	 * @param notifyDto 공지사항 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addNotify(NotifyDTO notifyDto) throws Exception{
		
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
			 sb.append(" 		INSERT INTO T_NOTIFY                                                      \n");
			 sb.append(" 		(NOTI_NO,SUBJECT,CONTENTS,REG_ID,REG_DT,USE_YN \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?, ?, ?, ?, Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ,'Y'               \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(notifyDto.getNotify_no());
			 sql.setString(notifyDto.getSubject());
			 sql.setString(notifyDto.getContents());
			 sql.setString(notifyDto.getReg_id());
			 
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
	 * 공지사항 View 정보.
	 * @param pubNo  견적서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public NotifyDTO getNotifyView( String notify_no) throws DAOException{
		
		NotifyDTO notifyDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT NOTI_NO,SUBJECT,CONTENTS,REG_ID	\n");
		sb.append("				FROM T_NOTIFY	\n");
		sb.append("				WHERE NOTI_NO=?	\n");
		
		log.debug(sb.toString());
		//param
		sql.setSql(sb.toString());
		sql.setString(notify_no);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
			
			 notifyDto = new NotifyDTO();

			 notifyDto.setNotify_no(StringUtil.nvl(ds.getString("NOTI_NO"),""));
			 notifyDto.setSubject(StringUtil.nvl(ds.getString("SUBJECT"),""));
			 notifyDto.setContents(StringUtil.nvl(ds.getString("CONTENTS"),""));
			 notifyDto.setReg_id(StringUtil.nvl(ds.getString("REG_ID"),""));
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return notifyDto;
	}
	/**
	 * 공지사항 수정하기. 
	 * @param notifyDto 공지사항 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editNotify(NotifyDTO notifyDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_NOTIFY SET					 ");
			 sb.append(" SUBJECT=?,CONTENTS=?,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')");
	         sb.append(" WHERE NOTI_NO = ?					 ");
			
	         sql.setSql(sb.toString());

			 sql.setString(notifyDto.getSubject());
			 sql.setString(notifyDto.getContents());
			 sql.setString(notifyDto.getMod_id());
			 sql.setString(notifyDto.getNotify_no());
				
			 log.debug("[editNotify]" + sql.toString());
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
	 * 공지사항을 삭제한다.
	 * @param notifyDto 공지사항 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteNotifyOne(NotifyDTO notifyDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_NOTIFY  SET 	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE NOTI_NO = ? \n");
		
		sql.setString(notifyDto.getMod_id());
		sql.setString(notifyDto.getNotify_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteNotifyOne]" + sql.toString());

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
	 * 공지정보 리스트( 메인)  
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ArrayList notifyList(NotifyDTO notifyDto) throws DAOException {
		
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		NotifyDTO resultDto  =null;
		ArrayList<NotifyDTO> arrlist = new ArrayList<NotifyDTO>();
		try{			

			int rowCnt=notifyDto.getRowCnt();
			
			sbSql.append(" SELECT *  FROM ");
			sbSql.append("  (SELECT ROW_NUMBER() over(order by NOTI_NO Desc) nn ,NOTI_NO,SUBJECT, CONTENTS, REG_ID,REG_DT FROM T_NOTIFY WHERE USE_YN='Y' ) as t0 ");
			sbSql.append(" WHERE nn< "+rowCnt);

			sql.setSql(sbSql.toString());
			log.debug("notifyList["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 resultDto = new NotifyDTO();
					 resultDto.setNotify_no(ds.getString("NOTI_NO"));
					 resultDto.setSubject(ds.getString("SUBJECT"));
					 resultDto.setContents(ds.getString("CONTENTS"));
					 resultDto.setReg_id(ds.getString("REG_ID"));
					 resultDto.setReg_dt(ds.getString("REG_DT"));
					
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
