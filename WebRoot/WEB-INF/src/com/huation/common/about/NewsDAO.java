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
public class NewsDAO extends AbstractDAO {
	
	/**
	 * 뉴스NO MAX카운트 구하기.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getNewsCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(NEWS_NO),0)+1) NEWS_CNT FROM T_NEWS ");
		 
		log.debug("[getNewsCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("NEWS_CNT");
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
	 * 뉴스코드 구하기.
	 * @param recCnt  MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getNewsNo(String newsCnt) throws DAOException{
		
		String newsNo = null;
		int news_no =0;
		
		news_no = NumberUtil.parseInt(newsCnt,0);

		newsNo = String.valueOf(news_no);
        if(newsNo.length()==1){
        	newsNo = "00000000"+ newsNo;	
        }else if(newsNo.length()==2){
        	newsNo = "0000000"+ newsNo;
        }else if(newsNo.length()==3){
        	newsNo = "000000"+ newsNo;
        }else if(newsNo.length()==4){
        	newsNo = "00000"+ newsNo;
        }else if(newsNo.length()==5){
        	newsNo = "0000"+ newsNo;
        }else if(newsNo.length()==6){
        	newsNo = "000"+ newsNo;
        }else if(newsNo.length()==7){
        	newsNo = "00"+ newsNo;
        }else if(newsNo.length()==8){
        	newsNo = "0"+ newsNo;
        }
 
		return newsNo;
	}	
		
	/**
	 * 뉴스정보 리스트.   
	 * @param curpage   현재 페이지 카운트
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO newsPageList(NewsDTO newsDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" NEWS_NO,SUBJECT, CONTENTS, REG_ID,REG_DT");
			sql.setSelect(" NEWS_NO,SUBJECT, CONTENTS, REG_ID,REG_DT ") ;
			sql.setFrom	(" T_NEWS \n");
			
			where += " USE_YN = 'Y'  \n ";
			
			if(newsDto.getSearchGb().equals("A")){
				
				where += " AND SUBJECT LIKE ? ";
				sql.setString("%" + newsDto.getSearchtxt() + "%");
				
			}
			
			sql.setWhere(where);
			sql.setOrderby(" NEWS_NO DESC "); 
		
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
	public int addNews(NewsDTO newsDto) throws Exception{
		
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
			 sb.append(" 		INSERT INTO T_NEWS                                                      \n");
			 sb.append(" 		(NEWS_NO,SUBJECT,CONTENTS,REG_ID,REG_DT,USE_YN \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?, ?, ?, ?, Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ,'Y'               \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(newsDto.getNews_no());
			 sql.setString(newsDto.getSubject());
			 sql.setString(newsDto.getContents());
			 sql.setString(newsDto.getReg_id());
			 
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
	 * 뉴스 View 정보.
	 * @param pubNo  견적서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public NewsDTO getNewsView( String notify_no) throws DAOException{
		
		NewsDTO newsDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT NEWS_NO,SUBJECT,CONTENTS,REG_ID	\n");
		sb.append("				FROM T_NEWS	\n");
		sb.append("				WHERE NEWS_NO=?	\n");
		
		log.debug(sb.toString());
		//param
		sql.setSql(sb.toString());
		sql.setString(notify_no);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
			
				newsDto = new NewsDTO();
	
				newsDto.setNews_no(StringUtil.nvl(ds.getString("NEWS_NO"),""));
				newsDto.setSubject(StringUtil.nvl(ds.getString("SUBJECT"),""));
				newsDto.setContents(StringUtil.nvl(ds.getString("CONTENTS"),""));
				newsDto.setReg_id(StringUtil.nvl(ds.getString("REG_ID"),""));
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return newsDto;
	}
	/**
	 * 뉴스 수정하기. 
	 * @param notifyDto 공지사항 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editNews(NewsDTO newsDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_NEWS SET					 ");
			 sb.append(" SUBJECT=?,CONTENTS=?,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')");
	         sb.append(" WHERE NEWS_NO = ?					 ");
			
	         sql.setSql(sb.toString());

			 sql.setString(newsDto.getSubject());
			 sql.setString(newsDto.getContents());
			 sql.setString(newsDto.getMod_id());
			 sql.setString(newsDto.getNews_no());
				
			 log.debug("[editNews]" + sql.toString());
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
	 * 뉴스를 삭제한다.
	 * @param notifyDto 공지사항 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteNewsOne(NewsDTO newsDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_NEWS  SET 	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE NEWS_NO = ? \n");
		
		sql.setString(newsDto.getMod_id());
		sql.setString(newsDto.getNews_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteNewsOne]" + sql.toString());

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
	 * 뉴스 리스트( 메인)  
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ArrayList newsList(NewsDTO newsDto) throws DAOException {
		
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		NewsDTO resultDto  =null;
		ArrayList<NewsDTO> arrlist = new ArrayList<NewsDTO>();
		try{			

			int rowCnt=newsDto.getRowCnt();
			
			sbSql.append(" SELECT *  FROM ");
			sbSql.append("  (SELECT ROW_NUMBER() over(order by NEWS_NO Desc) nn ,NEWS_NO,SUBJECT, CONTENTS, REG_ID,REG_DT FROM T_NEWS WHERE USE_YN='Y' ) as t0 ");
			sbSql.append(" WHERE  nn< "+rowCnt);

			sql.setSql(sbSql.toString());
			log.debug("newsList["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 resultDto = new NewsDTO();
					 resultDto.setNews_no(ds.getString("NEWS_NO"));
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
