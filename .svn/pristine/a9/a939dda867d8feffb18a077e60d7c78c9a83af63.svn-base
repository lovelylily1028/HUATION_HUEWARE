package com.huation.common.user;

import java.util.*;

import com.huation.common.util.*;
import com.huation.framework.data.*;
import com.huation.framework.persist.*;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.StringUtil;

public class UserDAO extends AbstractDAO {

	/**
	 * 계정 리스트.   
	 * @param userDto   사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO userPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp10_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ? ) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(""); //세션 아이디
		sql.setString(userDto.getvSearchType()); //검색구분
		sql.setString(userDto.getvSearch()); //검색어
		sql.setInteger(userDto.getnRow()); //리스트 갯수
		sql.setInteger(userDto.getnPage()); //현제 페이지
		sql.setString("PAGE"); //sp 구분
		sql.setString(""); //사용여부

		try{
			retVal=broker.executePageProcedure(sql,userDto.getnPage(),userDto.getnRow());
	
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}
			
		return retVal;
		
		}
	/**
	 * 사용자계정 등록 
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
//		String procedure = " { CALL hp10_mgUserRegist ( ? , ? , ? , ? , ? , ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";
		//20200608주민번호 2개 추가. 주소추가
		String procedure = " { CALL hp10_mgUserRegist ( ? , ? , ? , ? , ? , ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(userDto.getChUserID()); //세션 아이디
		sql.setString(userDto.getID()); //사용자 아이디
		sql.setString(userDto.getName()); //사용자 명
		sql.setString(userDto.getGroupID()); //그룹아이디
		sql.setString(userDto.getAuthID()); //권한아이디
		sql.setString(userDto.getPassword()); //패스워드
		sql.setString(userDto.getOfficeTellNo()); //핸드폰번호
		sql.setString(userDto.getOfficeTellNo2()); //사내직통번호
		sql.setString(userDto.getEmail()); //이메일
		sql.setString(userDto.getUseYN()); //사용여부
		sql.setString(userDto.getHireDateTime());//입사일
		sql.setString(userDto.getFireDateTime());//퇴사일
		sql.setString(userDto.getPosition());//직급
		sql.setString(userDto.getPhoto());//직급
		sql.setString(userDto.getBoardFileNm());
		sql.setString(userDto.getBoardFile());
		sql.setString(userDto.getEmployeeNum());//사번
		sql.setString(userDto.getJumin1());//주민앞
		sql.setString(userDto.getJumin2());//주민2
		sql.setString(userDto.getZip());//주소

		try{

			retVal=broker.executeProcedureUpdate(sql);
			
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally
		{
			return retVal;
		}	
	}
	/**
	 * 계정 정보
	 * @param userid
	 * @return userDto 사용자 정보
	 * @throws DAOException
	 */
	public UserDTO userView(UserDTO userDto) throws DAOException{

		String procedure = "{ CALL hp10_mgUserSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure);  //프로시져 명
		sql.setString(""); // 세션 아이디
		sql.setString("SELECT"); // sp구분
		sql.setString(userDto.getID()); //사용자 아이디

		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				userDto = new UserDTO();
				userDto.setID(ds.getString("UserID"));
			    userDto.setName(ds.getString("UserName"));
			    userDto.setPassword(ds.getString("Password"));
				userDto.setGroupID(ds.getString("GroupID"));
				userDto.setGroupName(ds.getString("GroupName"));
				userDto.setAuthID(ds.getString("AuthID"));
				userDto.setOfficeTellNo(ds.getString("OfficeTellNo"));
				userDto.setOfficeTellNo2(ds.getString("OfficeTellNo2"));
				userDto.setOfficeTellNoFormat(ds.getString("OfficeTellNoFormat"));
				userDto.setOfficeTellNoFormat2(ds.getString("OfficeTellNoFormat2"));
				userDto.setEmail(ds.getString("Email"));
				userDto.setUseYN(ds.getString("UseYN"));
				userDto.setHireDateTime(ds.getString("HireDateTime"));
				userDto.setFireDateTime(ds.getString("FireDateTime"));
				userDto.setPosition(ds.getString("Position"));
				userDto.setPhoto(ds.getString("Photo"));
				userDto.setBoardFileNm(ds.getString("BoardFileNm"));
				userDto.setBoardFile(ds.getString("BoardFile"));
				userDto.setEmployeeNum(ds.getString("EmployeeNum"));
				userDto.setJumin1(ds.getString("jumin1"));
				userDto.setJumin2(ds.getString("jumin2"));
				userDto.setZip(ds.getString("zip"));
			 }
			 
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		
		return userDto;
	}
	/**
	 * 사용자계정 수정
	 * @param userDto 사용자정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userModify(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
//		String procedure = " { CALL hp10_mgUserModify ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";
		//20200608김진동 주민번호 추가. zip 추가
		String procedure = " { CALL hp10_mgUserModify ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //로그아이디
		sql.setSql(procedure); //프로시져 명
		sql.setString(""); //세션 아이디
		sql.setString(userDto.getID()); //사용자 아이디
		sql.setString(userDto.getName()); //사용자 명
		sql.setString(userDto.getGroupID()); //그룹아이디
		sql.setString(userDto.getAuthID()); //권한아이디
		sql.setString(userDto.getPassword()); //패스워드
		sql.setString(userDto.getOfficeTellNo()); //휴대폰번호
		sql.setString(userDto.getOfficeTellNo2()); //사내직통번호
		sql.setString(userDto.getEmail()); //이메일
		sql.setString(userDto.getUseYN()); //사용여부
		sql.setString(userDto.getHireDateTime());//입사일
		sql.setString(userDto.getFireDateTime());//퇴사일
		sql.setString(userDto.getPosition());//직급
		sql.setString(userDto.getPhoto());//직급
		sql.setString(userDto.getBoardFileNm());
		sql.setString(userDto.getBoardFile());
		sql.setString(userDto.getEmployeeNum()); // 사번
		sql.setString(userDto.getJumin1()); // 주민1
		sql.setString(userDto.getJumin2()); // 주민2
		sql.setString(userDto.getZip()); // 주소

		try{

			retVal=broker.executeProcedureUpdate(sql);
			
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally
		{
			return retVal;
		}	
	}
	
	/**
	 * 계정 정보를 삭제한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int userDeletes(String logid,String[] users, String USERID) throws DAOException{
		
		String procedure = " { CALL hp10_mgUserDelete ( ? , ? ) } ";
		
		String[] r_data=null;
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; users != null && i<users.length; i++){ 
				
				List batch=new Vector();

				r_data = StringUtil.getTokens(users[i], "|");
				if(r_data[1].equals("Y")){
				
				batch.add(USERID);//세션 아이디
				batch.add(StringUtil.nvl(r_data[0],"")); //사용자 아이디
				
				batchList.add(batch);
				}
			}
		
			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally{
			return retVal;
		}

    }
	/**
	 * 사용자 EXCEL 리스트 
	 * @param userDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO userExcelList(UserDTO userDto) throws DAOException{
			
			String procedure = " { CALL hp10_mgUserInquiry (?,?,?,?,?,?) } ";
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setKey(userDto.getLogid()); //로그아이디
			sql.setSql(procedure); //프로시져 명
			sql.setString(userDto.getChUserID()); //세션 아이디
			sql.setString(userDto.getvSearchType()); //검색구분
			sql.setString(userDto.getvSearch()); //검색어
			sql.setInteger(userDto.getnRow()); //리스트 갯수
			sql.setInteger(userDto.getnPage()); //현제 페이지
			sql.setString("LIST"); //sp 구분
			//sql.setString(""); //사용여부

			sql.setSql(procedure);
			
			try{
				retVal=broker.executeListProcedure(sql);
			}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
			}			
			return retVal;
		}

	/**
	 * 사용자 Count 정보를 가져온다
	 * @param userDto 사용자 정보
	 * @return userDto
	 * @throws DAOException
	 */

	public UserDTO userTotCount(UserDTO userDto) throws DAOException {
		
		String procedure = " { CALL hp10_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//로그아이디
		sql.setString(userDto.getChUserID());		//세션아이디
		sql.setString("COUNT");			//SP구분
		sql.setString("");		//사용자 아이디

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				userDto = new UserDTO();
				userDto.setTotCount(ds.getString("TotCount"));
				userDto.setUseYN_NCount(ds.getString("UseYN_NCount"));
				userDto.setUseYN_YCount(ds.getString("UseYN_YCount"));
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return userDto;
	}
	/**
	* 사용자 중복 체크
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String userDupCheck(UserDTO userDto) throws DAOException{

		String procedure = " { CALL hp10_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//로그아이디
		sql.setString(userDto.getChUserID());		//세션아이디
		sql.setString("DUPLICATE");			//SP구분
		sql.setString(userDto.getID());		//사용자 아이디

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				result=ds.getString("Result");
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return result;			
	}
	/**
	 * 패스워드를 인코딩한다.
	 * @param userid
	 * @return
	 * @throws DAOException
	 */
	public String setPasswdEncode(String passwd) throws DAOException{
		 
		 String result = "";		

		 try{
			// Base64Util b64=new Base64Util();
			// result=b64.encode(passwd.getBytes());
			 result=EncryptUtil.encrypt(passwd);
			 
		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }

		 return result;   
	}
	
	/**
	 * 패스워드 변경.
	 * @param userid,passwd
	 * @return
	 * @throws DAOException
	 */
	public int getPasswdModify(String userid,String passwd) throws DAOException{
		
		int reVal=0;
		StringBuffer sb = new StringBuffer();
		 
		sb.append(" UPDATE ht10User set Password=?  ");
		sb.append("  WHERE UserID = ?   ");

		 QueryStatement sql = new QueryStatement();
		 sql.setSql(sb.toString());
		 sql.setString(passwd);
		 sql.setString(userid);

		 log.debug("[getPasswdModify]" + sql.toString());

		 DataSet ds = null;
		 try{

			 reVal = broker.executeUpdate(sql);

		 }catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		 }finally{
			 if(ds != null) ds.close();
	    }			
		
		return reVal;
	}
	
	/*
	 * 사원번호 생성
	 */
	public String EmployeeNumCreate(String position, String HireDate ){
		
		String HireDateDB = null; //DB에 있는 입사일 yyyymm 으로 저장할 String
		String check = null;
		String EmployeeNumber = null;
		String order = null;
		int cnt=0;
		QueryStatement sql = new QueryStatement();
		
		sql.setSql("SELECT (ISNULL(EmployeeNum,'0')) EmployeeNum FROM ht10User"); 
		
		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 while(ds.next()) {
				 if(ds.getString("EmployeeNum").equals("0")){
					 System.out.println("while 빠져나가기");
					 ds.getString("EmployeeNum");
					 continue;
				 }else{
					 /*	 check = ds.getString("EmployeeNum").substring(0,2);
				 	 }
				 
				 if(position.equals(check)){
					 System.out.println(ds.getString("EmployeeNum"));*/
					 HireDateDB = ds.getString("EmployeeNum").substring(2, 8);
					 
					 
					 if(HireDate.equals(HireDateDB))
						 cnt++;
					 
				 }
				 
			 }
			 cnt++;
			 if(cnt<10){
				 order = "0" + cnt;
			 }
			 
			 EmployeeNumber = position+HireDate+order;
		/*	 ds.first();
			 while(ds.next()) {
					 if(ds.getString("EmployeeNum").equals("0")){
						 System.out.println("다음꺼");
						 ds.getString("EmployeeNum");
						 continue;
					 }else{
						 System.out.println("==============================ds.getString(EmployeeNum)=================="+ ds.getString("EmployeeNum"));
						 System.out.println("==============================EmployeeNumber=================="+ EmployeeNumber);
						 if(EmployeeNumber.equals(ds.getString("EmployeeNum"))){
							 String comp=EmployeeNumber.substring(2);
							 int comp_EmployeeNumber = Integer.parseInt(comp);
							 comp_EmployeeNumber++;
							 EmployeeNumber = position + comp_EmployeeNumber;
					 }
				 }
			 }*/
			System.out.println("=========================EmployeeNumber=========================="+EmployeeNumber);
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 //throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return EmployeeNumber;
	}
	
}
