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
import com.huation.common.about.NotifyDTO;
import com.huation.common.recruit.DefaultDTO;

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
public class DefaultDAO extends AbstractDAO {
	
	/**
	 * 지원코드 MAX카운트 구하기.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getApplyCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(APPLY_CODE),0)+1) APP_CNT FROM T_DEFAULT_INFO ");
		 
		log.debug("[getApplyCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("APP_CNT");
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
	 * 지원코드 구하기.
	 * @param recCnt  MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getApplyNo(String recCnt) throws DAOException{
		
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
	 * 등록여부 및 지원코드 가져오기
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public DefaultDTO registResult(DefaultDTO defaultDto) throws DAOException{

		String applycode = "";
		String passwd="";
		String apply_state="";
		String result_state="";
		String recruit_no="";
		String email="";
		String user_nm="";
		
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		sb.append(" SELECT APPLY_CODE,PASSWD,APPLY_STATE,RESULT_STATE,RECRUIT_NO,EMAIL,USER_NM FROM T_DEFAULT_INFO ");
		
		if(defaultDto.getType().equals("A")){
			sb.append(" WHERE EMAIL = ? ");
			sql.setString(defaultDto.getEmail());
		}else{
			sb.append(" WHERE APPLY_CODE = ? ");
			sql.setString(defaultDto.getApply_code());
		}

		sql.setSql(sb.toString());
		log.debug("[registResult]" + sql.toString());

		DataSet ds = null;
		DefaultDTO resultDto=new DefaultDTO();
		
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 applycode = ds.getString("APPLY_CODE");
				 passwd = ds.getString("PASSWD");
				 apply_state = ds.getString("APPLY_STATE");
				 result_state = ds.getString("RESULT_STATE");
				 recruit_no= ds.getString("RECRUIT_NO");
				 email= ds.getString("EMAIL");
				 user_nm= ds.getString("USER_NM");
			 }
			 
			 resultDto.setApply_code(applycode);
			 resultDto.setPasswd(passwd);
			 resultDto.setApply_state(apply_state);
			 resultDto.setResult_state(result_state);
			 resultDto.setRecruit_no(recruit_no);
			 resultDto.setEmail(email);
			 resultDto.setUser_nm(user_nm);

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
	 * 기본정보 등록.   
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addDefault(DefaultDTO defaultDto) throws Exception{
		
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
			 sb.append(" 		INSERT INTO T_DEFAULT_INFO                                                       \n");
			 sb.append(" 		(APPLY_CODE,EMAIL,PASSWD, USER_NM, NATIONAL_GB, JUMIN_NO,RECRUIT_NO,CAREER,C_YEAR,WISH_SAL,CURRENT_SAL,POSITION,RECRUIT_FIELD,CREED,H_USER_NM,E_USER_NM ,   \n");
			 sb.append(" 		ENGLISH_NM,NATIONALITY,HAND_PHONE,HOME_PHONE,ETC_PHOME,RRIAGE_YN,BIRTH_DAY,MILITARY,EXEMPTION,PHOTO,J_ADDRESS,J_ADDR_DETAIL,J_POST , \n");
			 sb.append(" 		C_ADDRESS,C_ADDR_DETAIL,C_POST,VETERANS_YN,VETERANS_NO,DISABLED_YN,DISABLED_GRADE,USE_YN,REG_DT,APPLY_STATE,RESULT_STATE \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Y',Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':',''),'S','W'  \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(defaultDto.getApply_code());
			 sql.setString(defaultDto.getEmail());
			 sql.setString(defaultDto.getPasswd());
			 sql.setString(defaultDto.getUser_nm());
			 sql.setString(defaultDto.getNational_gb());
			 sql.setString(defaultDto.getJumin_no());
			 sql.setString(defaultDto.getRecruit_no());
			 sql.setString(defaultDto.getCareer());
			 sql.setString(defaultDto.getC_year());
			 sql.setLong(defaultDto.getWish_sal());
			 sql.setLong(defaultDto.getCurrent_sal());
			 sql.setString(defaultDto.getPosition());
			 sql.setString(defaultDto.getRecruit_field());
			 sql.setString(defaultDto.getCreed());
			 sql.setString(defaultDto.getH_user_nm());
			 sql.setString(defaultDto.getE_user_nm());
			 sql.setString(defaultDto.getEnglish_nm());
			 sql.setString(defaultDto.getNationality());
			 sql.setString(defaultDto.getHand_phone());
			 sql.setString(defaultDto.getHome_phone());
			 sql.setString(defaultDto.getEtc_phone());
			 sql.setString(defaultDto.getRriage_yn());
			 sql.setString(defaultDto.getBirth_day());
			 sql.setString(defaultDto.getMilitary());
			 sql.setString(defaultDto.getExemption());
			 sql.setString(defaultDto.getPhoto());
			 sql.setString(defaultDto.getJ_address());
			 sql.setString(defaultDto.getJ_addr_detail());
			 sql.setString(defaultDto.getJ_post());
			 sql.setString(defaultDto.getC_address());
			 sql.setString(defaultDto.getC_addr_detail());
			 sql.setString(defaultDto.getC_post());
			 sql.setString(defaultDto.getVeterans_yn());
			 sql.setString(defaultDto.getVeterans_no());
			 sql.setString(defaultDto.getDisabled_yn());
			 sql.setString(defaultDto.getDisabled_grade());

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
	 * 기본정보수정하기. 
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editDefault(DefaultDTO defaultDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_DEFAULT_INFO SET					 ");
			 sb.append(" CAREER=?,C_YEAR=?, WISH_SAL=?, CURRENT_SAL=?, POSITION=?,RECRUIT_FIELD=?,CREED=?,H_USER_NM=?,E_USER_NM=?,ENGLISH_NM=?,NATIONALITY=?,HAND_PHONE=?,HOME_PHONE=?, ");
			 sb.append(" ETC_PHOME=?,RRIAGE_YN=?,BIRTH_DAY=?,MILITARY=?,EXEMPTION=?,PHOTO=?,J_ADDRESS=?,J_ADDR_DETAIL=?,J_POST=?,  \n");			 
			 sb.append(" C_ADDRESS=?,C_ADDR_DETAIL=?,C_POST=?,VETERANS_YN=?,VETERANS_NO=?,DISABLED_YN=?,DISABLED_GRADE=?,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')  \n");			 
			 sb.append(" WHERE APPLY_CODE = ? 					 ");

	         sql.setSql(sb.toString());
	         sql.setString(defaultDto.getCareer());
			 sql.setString(defaultDto.getC_year());
			 sql.setLong(defaultDto.getWish_sal());
			 sql.setLong(defaultDto.getCurrent_sal());
			 sql.setString(defaultDto.getPosition());
			 sql.setString(defaultDto.getRecruit_field());
			 sql.setString(defaultDto.getCreed());
			 sql.setString(defaultDto.getH_user_nm());
			 sql.setString(defaultDto.getE_user_nm());
			 sql.setString(defaultDto.getEnglish_nm());
			 sql.setString(defaultDto.getNationality());
			 sql.setString(defaultDto.getHand_phone());
			 sql.setString(defaultDto.getHome_phone());
			 sql.setString(defaultDto.getEtc_phone());
			 sql.setString(defaultDto.getRriage_yn());
			 sql.setString(defaultDto.getBirth_day());
			 sql.setString(defaultDto.getMilitary());
			 sql.setString(defaultDto.getExemption());
			 sql.setString(defaultDto.getPhoto());
			 sql.setString(defaultDto.getJ_address());
			 sql.setString(defaultDto.getJ_addr_detail());
			 sql.setString(defaultDto.getJ_post());
			 sql.setString(defaultDto.getC_address());
			 sql.setString(defaultDto.getC_addr_detail());
			 sql.setString(defaultDto.getC_post());
			 sql.setString(defaultDto.getVeterans_yn());
			 sql.setString(defaultDto.getVeterans_no());
			 sql.setString(defaultDto.getDisabled_yn());
			 sql.setString(defaultDto.getDisabled_grade());
			 sql.setString(defaultDto.getApply_code());
	         
			 log.debug("[editDefault]" + sql.toString());
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
	/**
	 * 기본정보 View 정보.
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public DefaultDTO defaultView( DefaultDTO defaultDto) throws DAOException{
		
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT * FROM T_DEFAULT_INFO   \n");
		sb.append("				WHERE USE_YN='Y' AND APPLY_CODE=?	\n");
		
		log.debug(sb.toString());
		sql.setSql(sb.toString());
		sql.setString(defaultDto.getApply_code());
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
				defaultDto = new DefaultDTO();			
				defaultDto.setApply_code(StringUtil.nvl(ds.getString("APPLY_CODE"),""));
				defaultDto.setEmail(StringUtil.nvl(ds.getString("EMAIL"),""));
				defaultDto.setPasswd(StringUtil.nvl(ds.getString("PASSWD"),""));
				defaultDto.setUser_nm(StringUtil.nvl(ds.getString("USER_NM"),""));
				defaultDto.setNational_gb(StringUtil.nvl(ds.getString("NATIONAL_GB"),""));
				defaultDto.setJumin_no(StringUtil.nvl(ds.getString("JUMIN_NO"),""));
				defaultDto.setRecruit_no(StringUtil.nvl(ds.getString("RECRUIT_NO"),""));
				defaultDto.setCareer(StringUtil.nvl(ds.getString("CAREER"),""));
				defaultDto.setC_year(StringUtil.nvl(ds.getString("C_YEAR"),""));
				defaultDto.setWish_sal(StringUtil.nvl(ds.getString("WISH_SAL"),0));
				defaultDto.setCurrent_sal(StringUtil.nvl(ds.getString("CURRENT_SAL"),0));
				defaultDto.setPosition(StringUtil.nvl(ds.getString("POSITION"),""));
				defaultDto.setRecruit_field(StringUtil.nvl(ds.getString("RECRUIT_FIELD"),""));
				defaultDto.setCreed(StringUtil.nvl(ds.getString("CREED"),""));
				defaultDto.setH_user_nm(StringUtil.nvl(ds.getString("H_USER_NM"),""));
				defaultDto.setE_user_nm(StringUtil.nvl(ds.getString("E_USER_NM"),""));
				defaultDto.setEnglish_nm(StringUtil.nvl(ds.getString("ENGLISH_NM"),""));
				defaultDto.setNationality(StringUtil.nvl(ds.getString("NATIONALITY"),""));
				defaultDto.setHand_phone(StringUtil.nvl(ds.getString("HAND_PHONE"),""));
				defaultDto.setHome_phone(StringUtil.nvl(ds.getString("HOME_PHONE"),""));
				defaultDto.setEtc_phone(StringUtil.nvl(ds.getString("ETC_PHOME"),""));
				defaultDto.setRriage_yn(StringUtil.nvl(ds.getString("RRIAGE_YN"),""));
				defaultDto.setBirth_day(StringUtil.nvl(ds.getString("BIRTH_DAY"),""));
				defaultDto.setMilitary(StringUtil.nvl(ds.getString("MILITARY"),""));
				defaultDto.setExemption(StringUtil.nvl(ds.getString("EXEMPTION"),""));
				defaultDto.setPhoto(StringUtil.nvl(ds.getString("PHOTO"),""));
				defaultDto.setJ_address(StringUtil.nvl(ds.getString("J_ADDRESS"),""));
				defaultDto.setJ_addr_detail(StringUtil.nvl(ds.getString("J_ADDR_DETAIL"),""));
				defaultDto.setJ_post(StringUtil.nvl(ds.getString("J_POST"),""));
				defaultDto.setC_address(StringUtil.nvl(ds.getString("C_ADDRESS"),""));
				defaultDto.setC_addr_detail(StringUtil.nvl(ds.getString("C_ADDR_DETAIL"),""));
				defaultDto.setC_post(StringUtil.nvl(ds.getString("C_POST"),""));
				defaultDto.setVeterans_yn(StringUtil.nvl(ds.getString("VETERANS_YN"),""));
				defaultDto.setVeterans_no(StringUtil.nvl(ds.getString("VETERANS_NO"),""));
				defaultDto.setDisabled_yn(StringUtil.nvl(ds.getString("DISABLED_YN"),""));
				defaultDto.setDisabled_grade(StringUtil.nvl(ds.getString("DISABLED_GRADE"),""));
				
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return defaultDto;
	}
	/**
	 * 지원상태 변경하기. 
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int updateApplyResult(DefaultDTO defaultDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_DEFAULT_INFO SET					 ");
			 sb.append(" APPLY_STATE=?,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')  \n");			 
			 sb.append(" WHERE APPLY_CODE = ? 					 ");

	         sql.setSql(sb.toString());
	         sql.setString(defaultDto.getApply_state());
			 sql.setString(defaultDto.getApply_code());
	         
			 log.debug("[updateApply]" + sql.toString());
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
	/**
	 * 지원상태 변경하기. 
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int updateApply(DefaultDTO defaultDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_DEFAULT_INFO SET					 ");
			 sb.append(" RESULT_STATE=?,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')  \n");			 
			 sb.append(" WHERE APPLY_CODE = ? 					 ");

	         sql.setSql(sb.toString());
	         sql.setString(defaultDto.getResult_state());
	         //sql.setString(defaultDto.getMod_id());
			 sql.setString(defaultDto.getApply_code());
	         
			 log.debug("[updateApply]" + sql.toString());
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
	/**
	 * 초기지원상태 변경하기. 
	 * @param defaultDto 기본정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int defaultUpdate(DefaultDTO defaultDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_DEFAULT_INFO SET					 ");
			 sb.append(" RECRUIT_NO=?,RECRUIT_FIELD=?,APPLY_STATE=?, RESULT_STATE=?,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')  \n");			 
			 sb.append(" WHERE APPLY_CODE = ? 					 ");

	         sql.setSql(sb.toString());
	         sql.setString(defaultDto.getRecruit_no());
	         sql.setString(defaultDto.getRecruit_field());
	         sql.setString(defaultDto.getApply_state());
	         sql.setString(defaultDto.getResult_state());
			 sql.setString(defaultDto.getApply_code());
	         
			 log.debug("[defaultUpdate]" + sql.toString());
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
	/**
	 * 채용지원 리스트.   
	 * @param curpage   현재 페이지 카운트
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO defaultPageList(DefaultDTO defaultDto,int curpage, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" APPLY_CODE,APPLY_STATE,RESULT_STATE,EMAIL, USER_NM, RECRUIT_NO,RECRUIT_NM,CAREER");
			sql.setSelect(" T2.APPLY_CODE,T2.APPLY_STATE,T2.RESULT_STATE,T2.EMAIL, T2.USER_NM,T2.RECRUIT_NO,(SELECT T1.SUBJECT FROM T_RECRUIT T1 WHERE T1.RECRUIT_NO=T2.RECRUIT_NO) AS RECRUIT_NM,T2.CAREER ") ;
			sql.setFrom	(" T_DEFAULT_INFO T2 \n");
			
			where += " T2.USE_YN = 'Y'  \n ";
			
			if(defaultDto.getSearchGb().equals("A")){
				
				where += " AND T2.EMAIL LIKE ? ";
				sql.setString("%" + defaultDto.getSearchtxt() + "%");
				
			}else if(defaultDto.getSearchGb().equals("B")){
				
				where += " AND T2.USER_NM LIKE ? ";
				sql.setString("%" + defaultDto.getSearchtxt() + "%");
				
			}else if(defaultDto.getSearchGb().equals("C")){
				
				where += " AND T2.APPLY_STATE LIKE ? ";
				sql.setString("%" + defaultDto.getSearchtxt() + "%");
				
			}else if(defaultDto.getSearchGb().equals("D")){
				
				where += " AND T2.RESULT_STATE LIKE ? ";
				sql.setString("%" + defaultDto.getSearchtxt() + "%");
				
			}
			
			sql.setWhere(where);
			sql.setOrderby(" APPLY_CODE DESC "); 
		
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
 }
