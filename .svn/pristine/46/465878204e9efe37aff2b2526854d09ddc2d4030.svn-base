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
import com.huation.common.recruit.QnaDTO;

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
public class QnaDAO extends AbstractDAO {
	
	/**
	 * 채용NO MAX카운트 구하기.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getRecruitCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(QNA_NO),0)+1) QNA_CNT FROM T_RECRUIT_QNA ");
		 
		log.debug("[getRecruitCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("QNA_CNT");
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
	 * 채용코드 구하기.
	 * @param recCnt  MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getQnaNo(String recCnt) throws DAOException{
		
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
	 * FAQ 리스트.   
	 * @param curpage   현재 페이지 카운트
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO recruitQnAList(QnaDTO qnadto,int curpage,int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" QNA_NO,QUESTION,ANSWER, SUBJECT, EMAIL, QNA_FILE,REG_ID,REG_DT,MOD_ID,MOD_DT");
			sql.setSelect(" QNA_NO,QUESTION,ANSWER, SUBJECT, EMAIL, QNA_FILE,REG_ID,REG_DT,MOD_ID ,MOD_DT ") ;
			sql.setFrom	(" T_RECRUIT_QNA \n");
			
			where += "  USE_YN='Y' AND QNA_GB=?   \n ";
			
			sql.setString(qnadto.getQna_gb());
			
			if(qnadto.getSearchGb().equals("A")){
				
				where += " AND SUBJECT LIKE ? ";
				sql.setString("%" + qnadto.getSearchtxt() + "%");
				
			}else if(qnadto.getSearchGb().equals("B")){
				
				where += " AND QUESTION LIKE ? ";
				sql.setString("%" + qnadto.getSearchtxt() + "%");
				
			}else if(qnadto.getSearchGb().equals("C")){
				
				where += " AND EMAIL LIKE ? ";
				sql.setString("%" + qnadto.getSearchtxt() + "%");
				
			}
			
			sql.setWhere(where);

			sql.setOrderby(" QNA_NO DESC "); 
			
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
	 * 1:1문의(자주하는 질문) 등록하기. 
	 * @param qnaDto 질문정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int qnaRegist(QnaDTO qnaDto) throws Exception{
		
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
			 sb.append(" 		INSERT INTO T_RECRUIT_QNA                                                       \n");
			 sb.append(" 		(QNA_NO,QNA_GB,QUESTION, ANSWER, SUBJECT, EMAIL,QNA_FILE,REG_ID,REG_DT,USE_YN \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?, ?, ?, ?, ?, ?, ?,?, Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ,'Y'  \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(qnaDto.getQna_no());
			 sql.setString(qnaDto.getQna_gb());
			 sql.setString(qnaDto.getQuestion());
			 sql.setString(qnaDto.getAnswer());
			 sql.setString(qnaDto.getSubject());
			 sql.setString(qnaDto.getEmail());
			 sql.setString(qnaDto.getQna_file());
			 sql.setString(qnaDto.getReg_id());

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
	 * 자주하는 질문 가져오기. 
	 * @param qnaDto 질문정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public QnaDTO getQnaView(String qna_no) throws Exception{
		
		QnaDTO qnaDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT QNA_NO,SUBJECT,QUESTION,ANSWER,EMAIL,QNA_FILE	\n");
		sb.append("				FROM T_RECRUIT_QNA	\n");
		sb.append("				WHERE QNA_NO=?	\n");
		
		log.debug(sb.toString());
		//param
		sql.setSql(sb.toString());
		sql.setString(qna_no);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
			
				qnaDto = new QnaDTO();
	
				qnaDto.setQna_no(StringUtil.nvl(ds.getString("QNA_NO"),""));
				qnaDto.setSubject(StringUtil.nvl(ds.getString("SUBJECT"),""));
				qnaDto.setQuestion(StringUtil.nvl(ds.getString("QUESTION"),""));
				qnaDto.setAnswer(StringUtil.nvl(ds.getString("ANSWER"),""));
				qnaDto.setEmail(StringUtil.nvl(ds.getString("EMAIL"),""));
				qnaDto.setQna_file(StringUtil.nvl(ds.getString("QNA_FILE"),""));
				
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return qnaDto;
		
	}
	/**
	 * 자주하는 질문 수정하기. 
	 * @param 
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editQna(QnaDTO qnaDto) throws DAOException{

		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_RECRUIT_QNA SET					 ");
			 sb.append(" QUESTION=?, ANSWER=?,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')");
	         sb.append(" WHERE QNA_NO = ?					 ");
			
	         sql.setSql(sb.toString());

	         sql.setString(qnaDto.getQuestion());
			 sql.setString(qnaDto.getAnswer());
			 sql.setString(qnaDto.getMod_id());
			 sql.setString(qnaDto.getQna_no());
				
			 log.debug("[editQna]" + sql.toString());
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
	 * 자주하는 질문를 삭제한다.
	 * @param notifyDto 공지사항 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteQnaOne(QnaDTO qnaDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_RECRUIT_QNA SET 	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE QNA_NO = ? \n");
		
		sql.setString(qnaDto.getMod_id());
		sql.setString(qnaDto.getQna_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteQnaOne]" + sql.toString());

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
 }
