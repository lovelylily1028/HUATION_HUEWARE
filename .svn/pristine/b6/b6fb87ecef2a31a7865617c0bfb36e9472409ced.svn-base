package com.huation.common;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.huation.common.projectcodemanage.ProjectCodeManageDTO;
import com.huation.common.util.LogUtil;

import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.QueryStatement;
import com.huation.framework.util.StringUtil;
import com.huation.common.config.MenuDTO;

/**
 * @author 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CommonDAO extends AbstractDAO {

	Logger logger = LogUtil.instance().getLogger("consoleLogger");
	
	/**
	 * 
	 */
	public CommonDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * 현재 Date(YYYYMMDDHHMISS)를 가져온다.
	 * @return
	 * @throws DAOException
	 */
	public String getCurrentDate() throws DAOException{
		 String curDate = "";
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" Select Convert(varchar(10),Getdate(),112) as CURDATE "); 
		 sql.setSql(sb.toString());
		
		 logger.debug("[getCurrentDate]" + sql.toString());
		 
		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql); 
			 if(rs.next()){
				curDate = rs.getString("CURDATE");
			 }
			 rs.close();
		 }catch(Exception e){
		      e.printStackTrace();
			  logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return curDate;   
		}
	
	/**
	 * 코드 리스트를 가져온다.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeList(String smlcode) throws DAOException{
	     ArrayList codeList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select big_cd, cd_nm "); 
		 sb.append(" from t_code ");
		 sb.append(" where sml_cd = ? and use_yn = 'Y' and big_cd <>'*'" );
		 sql.setString(smlcode);
		 
		 sb.append(" order by cd_nm ");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setCode(rs.getString("big_cd"));
				code.setName(rs.getString("cd_nm"));
				codeList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return codeList;   
	}
	
	/**
	 * 코드 리스트를 가져온다.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 * 2013_04_06(금)shbyeon.
	 * 코드북에 있는 상품코드를 가져온다.
	 */
	public ArrayList getCodeListPro(String smlcode) throws DAOException{
	     ArrayList codeList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select big_cd, cd_nm "); 
		 sb.append(" from t_code ");
		 sb.append(" where sml_cd = ? and use_yn = 'Y' and big_cd <>'*'" );
		 sql.setString(smlcode);
		 
		 sb.append(" order by big_cd ");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setCode(rs.getString("big_cd"));
				code.setName(rs.getString("cd_nm"));
				codeList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return codeList;   
	}

	
	/**
	 * 코드 리스트(기나다순)를 가져온다.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListHanSeq(String smlcode) throws DAOException{
	     ArrayList codeList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select big_cd, cd_nm "); 
		 sb.append(" from t_code ");
		 sb.append(" where sml_cd = ? and use_yn = 'Y' and big_cd <>'*'" );
		 sql.setString(smlcode);
		 
		 sb.append(" order by cd_nm");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setCode(rs.getString("big_cd"));
				code.setName(rs.getString("cd_nm"));
				codeList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return codeList;   
	}
	
	/**
	 * 코드 리스트(기나다순)를 가져온다.(코드리스트 code값 코드네임 name값 2개 필요시 사용)
	 * 2013_03_11(월) shbyeon.
	 * 영업지원->영업진행현황용.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListHanSeqq2() throws DAOException{
	     ArrayList userList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select UserID,UserName "); 
		 sb.append(" from ht10User ");
		 sb.append(" where UseYN = 'Y' and DeletedYN='N' and GroupID='G00006' " );
		 sb.append(" order by UserName asc ");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 userList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setUserID(rs.getString("UserID"));
				code.setUserName(rs.getString("UserName"));
				userList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return userList;   
	}
	
	
	/**
	 * 코드 리스트(기나다순)를 가져온다.(코드리스트 code값 코드네임 name값 2개 필요시 사용)
	 * 총무지원->법인통장용.
	 * @param smlcode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeListHanSeqq(String smlcode) throws DAOException{
	     ArrayList codeList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.BankCode, B.CD_NM as BankName, A.AccountNumber"); 
		 sb.append(" from T_BANKMANAGE A left join  T_CODE B on B.BIG_CD = A.BankCode and B.SML_CD ='P01'");
		 sb.append(" where (1=1) and A.sml_cd = ? and A.DeleteYN = 'N'" );
		 sql.setString(smlcode);
		 
		 sb.append(" order by BankName ");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setCode(rs.getString("BankName"));
				code.setCode2(rs.getString("AccountNumber"));
				code.setName(rs.getString("BankName"));
				code.setName2(rs.getString("AccountNumber"));
				codeList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return codeList;   
	}
	/**
	 * 코드 리스트를 가져온다.
	 * @param smlcode
	 * @param limCode
	 * @return
	 * @throws DAOException
	 */
	public ArrayList getCodeList(String smlcode , String limCode) throws DAOException{
	     ArrayList codeList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select big_cd, cd_nm "); 
		 sb.append(" from t_code ");
		 sb.append(" where sml_cd = ? and use_yn = 'Y'");
		 sb.append(" and big_cd > ? ");
		 sql.setString(smlcode);
		 sql.setString(limCode);
		 
		 sb.append(" order by big_cd ");
		 sql.setSql(sb.toString());
	
		 logger.debug("[getCode]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 ComCodeDTO code = null; 
			 codeList = new ArrayList();
			 while(rs.next()){
				code = new ComCodeDTO();
				code.setCode(rs.getString("BIG_CD"));
				code.setName(rs.getString("CD_NM"));
				codeList.add(code);
			 }
			 rs.close();
		 }catch(Exception e){
			  logger.error(e.getMessage()); 
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return codeList;   
	}

	/**
	 * CreateDate:2014-02-03(월) Writer:shbyeon.
	 * 우편번호 조회 리스트(도로명 주소)
	 * @param ptCode
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO searchPost(PostCodeDTO ptCode) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ZipCodeInquiry_Pop ( ?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(ptCode.getvSearchType()); 	// 검색구분
		sql.setString(ptCode.getvSearch()); 		// 검색어

		try {
			retVal = broker.executeListProcedure(sql);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2014-02-03(월) Writer:shbyeon.
	 * 우편번호 조회 리스트(기존 주소)
	 * @param dongname
	 * @return retVal
	 * @throws DAOException
	 */
	public ArrayList  searchPost(String dongname) throws DAOException{
	     ArrayList postList = new ArrayList();
   	     QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append("  SELECT POST_ID, POST_CODE, SIDO+' '+GUGUN+' '+DONG+' '+ISNULL(RI,'') AS ADDR,  \n");
		 sb.append(" SIDO+'  '+GUGUN+'  '+DONG+'  '+ISNULL(RI,'')+' '+ISNULL(BUNJI,'') AS FULLADDR  ");
		 sb.append(" FROM  T_POSTCODE_Ori ");
		 sb.append(" WHERE ( DONG LIKE ? )  ");
		 sb.append(" ORDER BY DONG "); 
		 sql.setSql(sb.toString());
		 sql.setString("%"+dongname+"%");
		 
		 logger.debug("[searchPost]" + sql.toString());

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 PostCodeDTO postCode = null;
			 while(rs.next()){
			     postCode = new PostCodeDTO();
			     postCode.setPostId(rs.getInt("POST_ID"));
			     postCode.setPostCode(rs.getString("POST_CODE"));
			     postCode.setAddr(StringUtil.nvl(rs.getString("ADDR")));
			     postCode.setFullAddr(StringUtil.nvl(rs.getString("FULLADDR")));
			     
			     postList.add(postCode);
			 }
			 rs.close(); 
		 }catch(Exception e){
			  logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return postList;   
	}
	
	/**
	 * 사원명을 가져온다.
	 * @param userid
	 * @return
	 * @throws DAOException
	 */
	public String getUserNm(String userid) throws DAOException{
		 String usernm = "";
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" SELECT UserName FROM ht10User WHERE UserID=? "); 
		 sql.setSql(sb.toString());
		 sql.setString(userid);
		
		 logger.debug("[getUserNm]" + sql.toString());
		 
		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql); 
			 if(rs.next()){
				usernm = rs.getString("UserName");
			 }
			 rs.close();
		 }catch(Exception e){
		      e.printStackTrace();
			  logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return usernm;   
		}
	/**
	 * 업체명을 가져온다.
	 * @param compcode
	 * @return
	 * @throws DAOException
	 */
	public String getCompNm(String compcode) throws DAOException{
		 String compnm = "";
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" SELECT COMP_NM FROM T_COMPANY WHERE COMP_CODE=? "); 
		 sql.setSql(sb.toString());
		 sql.setString(compcode);
		
		 logger.debug("[getUserNm]" + sql.toString());
		 
		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql); 
			 if(rs.next()){
				 compnm = rs.getString("COMP_NM");
			 }
			 rs.close();
		 }catch(Exception e){
		      e.printStackTrace();
			  logger.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return compnm;   
		}
	
	  public String getMenuAuth(ArrayList<MenuDTO> menulist ,String menuid ){
       
          StringBuffer result = new StringBuffer();
          
      	if(menulist.size() > 0){	

			String TmenuID="";
			String menuID="";
		    
			result.append("\n<script language=\"javascript\">\n");
			
			result.append("\n menuSetting('"+menuid+"'); \n");
	       
	        for(int j=0; j < menulist.size(); j++ ){	
				MenuDTO dto = menulist.get(j);
				
				TmenuID="T"+dto.getMenuID();
				menuID=dto.getMenuID();
				
			    result.append("\n tmenuid = document.getElementById(\""+TmenuID+"\");\n");
			    result.append("\n menuid = document.getElementById(\""+menuID+"\");\n");			
				result.append("\n if(tmenuid!=undefined){ tmenuid.style.display='inline'; } \n");
				result.append("\n if(menuid!=undefined){ menuid.style.display='inline'; }\n");

			}
	        
			 result.append("</script>\n");
		}

          return result.toString();
	  }
}
