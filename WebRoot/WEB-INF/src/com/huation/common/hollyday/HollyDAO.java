package com.huation.common.hollyday;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import com.huation.common.company.CompanyDTO;
import com.huation.common.config.SmsGroupDTO;
import com.huation.common.util.*;
import com.huation.framework.data.*;
import com.huation.framework.persist.*;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.StringUtil;

public class HollyDAO extends AbstractDAO {

	/**
	 * 내휴가현황보기
	 * @param userid
	 * @return userDto
	 * @throws DAOException
	 */
	public HollyDTO myHollyDayView(HollyDTO hollyDto) throws DAOException{

		String procedure = "{ CALL hp_myHollyDay ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(hollyDto.getLogID()); 
		sql.setSql(procedure);  
		sql.setString(hollyDto.getUserID());
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 hollyDto = new HollyDTO();
				 hollyDto.setUserID(ds.getString("UserID"));
				 hollyDto.setUserName(ds.getString("UserName"));
				 hollyDto.setCareer(ds.getString("Career"));
				 hollyDto.setUsedHollyDay(ds.getFloat("UsedHollyDay"));	
				 hollyDto.setTotalHollyDay(ds.getFloat("TotalHollyDay"));
				 hollyDto.setHireDateTime(ds.getString("HireDateTime"));
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
		
		return hollyDto;
	}
	
	
	
	
	
	/**
	 * 문자발송 그룹  리스트 (일반 그룹 트리 리스트)
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList HollyUserList(HollyDTO hollyDto) throws DAOException {

		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		
		String procedure = "{ CALL hp_mgHollyUserList ( ? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(hollyDto.getLogID());
		sql.setSql(procedure);
		sql.setString(hollyDto.getUserID());

		DataSet ds = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				hollyDto = new HollyDTO();
				hollyDto.setSignID1(ds.getString("SignID"));
				hollyDto.setSignName1(ds.getString("SignName"));
				hollyDto.setPosition(ds.getString("Position"));

				 arrlist.add(hollyDto);
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

		return arrlist;
 	
	}
	
	/**
	 * 휴가 상세보기
	 * @param userid
	 * @return userDto
	 * @throws DAOException
	 */
	public HollyDTO goModifyForm(HollyDTO hollyDto) throws DAOException{

		String procedure = "{ CALL hp10_mgHollyDaySelect ( ?  ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(hollyDto.getLogID()); 
		sql.setSql(procedure);  
		sql.setInteger(hollyDto.getSeq()); //Device
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 hollyDto = new HollyDTO();
				 hollyDto.setSeq(ds.getInt("seq"));
				 hollyDto.setUserID(ds.getString("UserID"));
				 hollyDto.setHollyFlag(ds.getString("HollyFlag"));
				 hollyDto.setState1(ds.getString("State1"));
				 hollyDto.setState2(ds.getString("State2"));
				 hollyDto.setDay(ds.getFloat("Day"));
				 hollyDto.setStartDate(ds.getString("StartDateTime"));
				 hollyDto.setEndDate(ds.getString("EndDateTime"));
				 hollyDto.setReason(ds.getString("Reason"));
				 hollyDto.setSignID1(ds.getString("SignID1"));
				 hollyDto.setSignID2(ds.getString("SignID2"));
				 hollyDto.setHollyDate(ds.getString("HollyDate"));
				 hollyDto.setReturnReason(ds.getString("ReturnReason"));
				 hollyDto.setMgtKey(ds.getString("MgtKey"));
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
		
		return hollyDto;
	}
	
	/**
	 * 휴가 상세보기
	 * @param userid
	 * @return userDto
	 * @throws DAOException
	 */
	public HollyDTO SignUserSelect(String SignID) throws DAOException{

		String procedure = "{ CALL hp10_mgHollySignUserSelect ( ?  ) }";

		DataSet ds = null;
		HollyDTO hollyDto = new HollyDTO();
		 
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);  
		sql.setString(SignID); //Device
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				
				 hollyDto.setUserID(ds.getString("UserID"));
				 hollyDto.setUserName(ds.getString("UserName"));
				 hollyDto.setPhoneNo(ds.getString("PhoneNo"));
				
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
		
		return hollyDto;
	}
	
	
	/**
	 * 휴가신청
	 * @param smsgroupDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int HollyDayRegist(HollyDTO hollyDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		 QueryStatement sql = new QueryStatement();
		 String procedure = " { CALL hp_hollyDayRequest (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
		 sql.setString(hollyDto.getUserID());
		 sql.setString(hollyDto.getHollyFlag());
		 sql.setString(hollyDto.getStartDate());
		 sql.setString(hollyDto.getEndDate());
		 sql.setFloat(hollyDto.getDay());
		 sql.setString(hollyDto.getSignID1());
		 sql.setString(hollyDto.getSignID2());
		 sql.setString(hollyDto.getReason());
		 sql.setString(hollyDto.getHollyUsed());
		 sql.setString(hollyDto.getState1());
		 sql.setString(hollyDto.getState2());
		 sql.setString(hollyDto.getHollyDate());
		 sql.setString(hollyDto.getMgtKey());
			try {

				retVal = broker.executeProcedureUpdate(sql);

			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				throw new DAOException(e.getMessage());
			} finally {
			}
			return retVal;
		
	}
	/**
	 * 휴가수정
	 * @param smsgroupDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int HollyDayModify(HollyDTO hollyDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		 QueryStatement sql = new QueryStatement();
		 String procedure = " { CALL hp_hollyDayModify (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
		 sql.setString(hollyDto.getUserID());
		 sql.setString(hollyDto.getHollyFlag());
		 sql.setString(hollyDto.getStartDate());
		 sql.setString(hollyDto.getEndDate());
		 sql.setFloat(hollyDto.getDay());
		 sql.setString(hollyDto.getSignID1());
		 sql.setString(hollyDto.getSignID2());
		 sql.setString(hollyDto.getReason());
		 sql.setString(hollyDto.getHollyUsed());
		 sql.setString(hollyDto.getState1());
		 sql.setString(hollyDto.getState2());
		 sql.setInteger(hollyDto.getSeq());
		 sql.setString(hollyDto.getHollyDate());
			try {

				retVal = broker.executeProcedureUpdate(sql);

			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				throw new DAOException(e.getMessage());
			} finally {
			}
			return retVal;
		
	}
	/**
	 * 휴가신청현황 연차 1년 미만. 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ArrayList hollyDayRequestNewbieList(HollyDTO hollyDto) throws DAOException {
		
		DataSet ds = null;
		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		try{
			//---- List Sql 문생성
			QueryStatement sql = new QueryStatement();
			StringBuffer sb = new StringBuffer();
			Connection conn = null;
			
			sb.append("	select Day,Convert(varchar(20),b.RegDateTime,23) as RegDateTime,Convert(varchar(20),b.StartDateTime,23) as StartDateTime ,Convert(varchar(20),b.EndDateTime,23) as EndDateTime,b.Reason   \n");
			sb.append("					from htHollyDayHistory B			                 \n");
			sb.append("					where 1=1			                 \n");
//			sb.append("					and replace(Convert(varchar(20),B.RegDateTime,23),'-','')<= dbo.hf10_HollyEndTime2_new('"+hollyDto.getUserID()+"'	)	                 \n");
			sb.append("					and replace(Convert(varchar(20),B.RegDateTime,23),'-','') between dbo.hf10_HollyStartTime('"+hollyDto.getUserID()+"') and dbo.hf10_HollyEndTime('"+hollyDto.getUserID()+"')			                 \n");			sb.append("					and B.UserID = '"+hollyDto.getUserID()+"'			                 \n");
			sb.append("					and B.UserID = '"+hollyDto.getUserID()+"'			                 \n");
			sb.append("					and B.HollyUsed='Y' and B.State1='Y' and B.State2='Y'	   \n");

			sql.setSql(sb.toString());
			
			log.debug("[hollyDayRequestNewbieList]" + sql.toString());
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			
			ds = broker.executeQuery(sql);
			 while(ds.next()){ 
				 hollyDto = new HollyDTO();
				 hollyDto.setDays(ds.getString("Day"));
				 hollyDto.setRegDateTime(ds.getString("RegDateTime"));
				 hollyDto.setStartDateTime(ds.getString("StartDateTime"));
				 hollyDto.setEndDateTime(ds.getString("EndDateTime"));
				 hollyDto.setReason(ds.getString("Reason"));
				 arrlist.add(hollyDto);
			 }
		 	
		}catch(SQLException e){
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			 if(ds != null) ds.close();
		}	
		
		
		return arrlist;
		
	}
	/**
	 * 휴가신청현황 연차 1년 이상. 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ArrayList hollyDayRequestElderList(HollyDTO hollyDto) throws DAOException {
		
		DataSet ds = null;
		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		try{
			//---- List Sql 문생성
			QueryStatement sql = new QueryStatement();
			StringBuffer sb = new StringBuffer();
			Connection conn = null;
			
			sb.append("	select Day,Convert(varchar(20),b.RegDateTime,23) as RegDateTime,Convert(varchar(20),b.StartDateTime,23) as StartDateTime ,Convert(varchar(20),b.EndDateTime,23) as EndDateTime,b.Reason   \n");
			sb.append("					from htHollyDayHistory B			                 \n");
			sb.append("					where 1=1			                 \n");
//			sb.append("					and replace(Convert(varchar(20),B.RegDateTime,23),'-','')<= dbo.hf10_HollyEndTime2_new('"+hollyDto.getUserID()+"')				                 \n");
			sb.append("					and replace(Convert(varchar(20),B.RegDateTime,23),'-','') between dbo.hf10_HollyStartTime('"+hollyDto.getUserID()+"') and dbo.hf10_HollyEndTime('"+hollyDto.getUserID()+"')			                 \n");			sb.append("					and B.UserID = '"+hollyDto.getUserID()+"'			                 \n");
			sb.append("					and B.UserID = '"+hollyDto.getUserID()+"'			                 \n");
			sb.append("					and B.HollyUsed='Y' and B.State1='Y' and B.State2='Y'	   \n");

			sql.setSql(sb.toString());
			
			log.debug("[hollyDayRequestElderList]" + sql.toString());
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			
			ds = broker.executeQuery(sql);
			 while(ds.next()){ 
				 hollyDto = new HollyDTO();
				 hollyDto.setDays(ds.getString("Day"));
				 hollyDto.setRegDateTime(ds.getString("RegDateTime"));
				 hollyDto.setStartDateTime(ds.getString("StartDateTime"));
				 hollyDto.setEndDateTime(ds.getString("EndDateTime"));
				 hollyDto.setReason(ds.getString("Reason"));
				 arrlist.add(hollyDto);
			 }
		 	
		}catch(SQLException e){
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			 if(ds != null) ds.close();
		}	
		
		
		return arrlist;
		
	}
	/**
	 * 전사원 휴가현황 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ArrayList hollyDayRequestAllList(HollyDTO hollyDto) throws DAOException {

		ListDTO retVal = null;
		HollyDTO hollyDto2 =null;
		DataSet ds = null;
		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		try{
			//---- List Sql 문생성
			QueryStatement sql = new QueryStatement();
			StringBuffer sb = new StringBuffer();
			Connection conn = null;
			
			sb.append("	SELECT A.*			              \n");
			sb.append("	, totalHollyDay2 - usedHollyDay2 AS remainHollyDay			              \n");
			sb.append("	FROM (			              \n");
			sb.append("	select			              \n");
			sb.append("		A.UserID,			              \n");
			sb.append("		A.UserName,			              \n");
			sb.append("		A.EmployeeNum,			              \n");
//			sb.append("	--	A.HireDateTime,			              \n");
			sb.append("		Convert(varchar(20),A.HireDateTime,23) AS HireDateTime,			              \n");
			sb.append("		(select  DATEDIFF( day, A.HireDateTime, getDate()) )/365 as Career,			              \n");
			sb.append("		dbo.hf10_totalHollyDay_new1(A.UserID) AS sumHollyDay,			              \n");
			sb.append("		dbo.hf10_totalHollyDay_new((select  DATEDIFF( day, A.HireDateTime, getDate()) )/365) as basicHollyDay , 			              \n");
			sb.append("		case 			              \n");
			sb.append("			when dbo.hf10_totalHollyDay_new1(A.UserID)  > dbo.hf10_totalHollyDay_new((select  DATEDIFF( day, A.HireDateTime, getDate()) )/365) then dbo.hf10_totalHollyDay_new((select  DATEDIFF( day, A.HireDateTime, getDate()) )/365)			              \n");
			sb.append("			else dbo.hf10_totalHollyDay_new1(A.UserID) 			              \n");
			sb.append("	   end totalHollyDay2  ,			              \n");
			sb.append("			              \n");
			sb.append("	   case 			              \n");
			sb.append("			when (select  DATEDIFF( day, A.HireDateTime, getDate()) )/365  > 0  then 			              \n");
			sb.append("			ISNULL( (select SUM(Day) 			              \n");
			sb.append("				from htHollyDayHistory B			              \n");
			sb.append("				where 1=1			              \n");
			sb.append("				and replace(Convert(varchar(20),B.RegDateTime,23),'-','') between dbo.hf10_HollyStartTime(A.UserID) and dbo.hf10_HollyEndTime(A.UserID)			              \n");
			sb.append("				and B.UserID = A.UserID			              \n");
			sb.append("				and B.HollyUsed='Y' and B.State1='Y' and B.State2='Y'			              \n");
			sb.append("				 ) ,'0')			              \n");
			sb.append("			              \n");
			sb.append("			else ISNULL( (select SUM(Day) 			              \n");
			sb.append("				from htHollyDayHistory B			              \n");
			sb.append("				where 1=1			              \n");
			sb.append("				and replace(Convert(varchar(20),B.RegDateTime,23),'-','')<= dbo.hf10_HollyEndTime2_new(A.UserID)			              \n");
			sb.append("				and B.UserID = A.UserID 			              \n");
			sb.append("				and B.HollyUsed='Y' and B.State1='Y' and B.State2='Y'			              \n");
			sb.append("				) ,'0')			              \n");
			sb.append("	    end usedHollyDay2  			              \n");
			sb.append("			              \n");
			sb.append("		 from 		              \n");
			sb.append("		ht10User A		              \n");
			sb.append("		WHERE A.UseYN = 'Y' AND A.DeletedYN = 'N' 		              \n");
			sb.append("		) A		    ORDER BY UserName ,HireDateTime         \n");
			sql.setSql(sb.toString());
			
			log.debug("[hollyDayRequestAllList]" + sql.toString());
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			
			ds = broker.executeQuery(sql);
			 while(ds.next()){ 
				 hollyDto = new HollyDTO();
				 hollyDto.setUserID(ds.getString("UserID"));
				 hollyDto.setUserName(ds.getString("UserName"));
				 hollyDto.setEmployeeNum(ds.getString("EmployeeNum"));
				 hollyDto.setCareer(ds.getString("Career"));
				 hollyDto.setHireDateTime(ds.getString("HireDateTime"));
				 hollyDto.setTotalHollyDay2(ds.getString("totalHollyDay2"));
				 hollyDto.setUsedHollyDay2(ds.getString("usedHollyDay2"));
				 hollyDto.setRemainHollyDay(ds.getString("remainHollyDay"));
				
				 arrlist.add(hollyDto);
			 }
		 }catch(SQLException e){
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			 if(ds != null) ds.close();
		}	
		
		
		return arrlist;

	}
	/**
	 * 휴가신청현황 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO hollyDayRequestList(HollyDTO hollyDto) throws DAOException {
		
		ListDTO retVal = null;
		
		/*		String vSearchGb2 = null;
		
		if(hollyDto.getSearchGb2() == "D"){
			vSearchGb2 = D
		}
		 */
		String procedure = " { CALL hp_hollyDayRequestList2 ( ?,?,?,?,?,?,?,?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(hollyDto.getSearchGb()); // 검색구분
		sql.setString(hollyDto.getSearchGb2()); // 검색구분
		sql.setString(hollyDto.getSearchGb3()); // 검색구분
		sql.setString(hollyDto.getSearchtxt()); // 검색어
		sql.setInteger(hollyDto.getnRow()); // 리스트 갯수
		sql.setInteger(hollyDto.getnPage()); // 현제 페이지
		sql.setString(hollyDto.getJobGb()); // sp 구분
		sql.setString(hollyDto.getStartDT()); // 조회시작일
		sql.setString(hollyDto.getEndDT()); // 조회종료일
		sql.setString(hollyDto.getUserID()); // 
		System.out.println(hollyDto.getUserID());
		
		try {
			retVal = broker.executePageProcedure(sql, hollyDto.getnPage(),hollyDto.getnRow());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}
		
		return retVal;
		
	}
	/**
	 * 휴일관리 리스트 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO hollyPageList(HollyDTO hollyDto) throws DAOException {

		ListDTO retVal = null;
		
/*		String vSearchGb2 = null;
		
		if(hollyDto.getSearchGb2() == "D"){
			vSearchGb2 = D
		}
		*/
		String procedure = " { CALL hp_hollyPageList ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hollyDto.getSearchGb()); // 검색구분
		sql.setString(hollyDto.getSearchtxt()); // 검색어
		sql.setInteger(hollyDto.getnRow()); // 리스트 갯수
		sql.setInteger(hollyDto.getnPage()); // 현제 페이지
		sql.setString(hollyDto.getJobGb()); // sp 구분
		sql.setString(hollyDto.getStartDT()); // 조회시작일
		sql.setString(hollyDto.getEndDT()); // 조회종료일
		
		try {
			retVal = broker.executePageProcedure(sql, hollyDto.getnPage(),hollyDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	
	/**
	 * 휴가신청현황 Excel 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO hollyDayRequestExcelList(HollyDTO hollyDto) throws DAOException {

		ListDTO retVal = null;
		
/*		String vSearchGb2 = null;
		
		if(hollyDto.getSearchGb2() == "D"){
			vSearchGb2 = D
		}
		*/
		String procedure = " { CALL hp_hollyDayRequestExcelList ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hollyDto.getSearchGb()); // 검색구분
		sql.setString(hollyDto.getSearchGb2()); // 검색구분
		sql.setString(hollyDto.getSearchGb3()); // 검색구분
		sql.setString(hollyDto.getSearchtxt()); // 검색어
/*		sql.setInteger(hollyDto.getnRow()); // 리스트 갯수
		sql.setInteger(hollyDto.getnPage()); // 현제 페이지
		sql.setString(hollyDto.getJobGb()); // sp 구분
*/		sql.setString(hollyDto.getStartDT()); // 조회시작일
		sql.setString(hollyDto.getEndDT()); // 조회종료일
		sql.setString(hollyDto.getUserID()); // 

		
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
	 * 휴가상세 휴가리스트
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO HollyList(String MgtKey) throws DAOException {

		ListDTO retVal = null;
		
/*		String vSearchGb2 = null;
		
		if(hollyDto.getSearchGb2() == "D"){
			vSearchGb2 = D
		}
		*/
		String procedure = " { CALL hp10_mgHollyList ( ? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(MgtKey); // 검색구분

		
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
	 * 휴가결재 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO hollyApproveList(HollyDTO hollyDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_hollyApproveList ( ? , ? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hollyDto.getUserID()); // 
		sql.setString(hollyDto.getJobGb());
		
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
	 * 오늘의 휴가자 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO hollyTodayList(HollyDTO hollyDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_hollyTodayList ( ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
				
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
	 * 휴가관리 휴가등록
	 * @param smsgroupDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int mgHollyDayRegist(HollyDTO hollyDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		 QueryStatement sql = new QueryStatement();
		 String procedure = " { CALL hp_HollyDayRegist (?,?,?,?) } ";
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
		 sql.setString(hollyDto.getUserID());
		 sql.setString(hollyDto.getTitle());
		 sql.setString(hollyDto.getStartDate());
		 sql.setString(hollyDto.getDescription());
			try {

				retVal = broker.executeProcedureUpdate(sql);

			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				throw new DAOException(e.getMessage());
			} finally {
			}
			return retVal;
		
	}
	/**
	 * 결재 승인/반려
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public int updateSign(HollyDTO hollyDto) throws Exception{
	
	int retVal = -1;
	DataSet ds = null;
	
	String procedure = " { CALL hp_hollyApprove ( ? , ? , ? , ? ) } ";
	
	QueryStatement sql = new QueryStatement();
	
	sql.setKey(hollyDto.getLogID());
	sql.setSql(procedure); 
	
	sql.setInteger(hollyDto.getSeq()); 
	sql.setString(hollyDto.getSign()); 
	sql.setString(hollyDto.getJobGb()); 
	sql.setString(hollyDto.getReturnReason()); //AgentID
	
	
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
	 * 결재 승인/반려
	 * @param userid
	 * @return userDto
	 * @throws DAOException
	 */
	public HollyDTO updateSign2(HollyDTO hollyDto) throws DAOException{

		int retVal = -1;
		DataSet ds = null;
		
		String procedure = " { CALL hp_hollyApproveCheck ( ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(hollyDto.getLogID());
		sql.setSql(procedure); 
		
		sql.setInteger(hollyDto.getSeq()); 
		
		
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				
				 hollyDto.setState1(ds.getString("state1"));
				 hollyDto.setState2(ds.getString("state2"));
				 hollyDto.setUserName(ds.getString("UserName"));
				 hollyDto.setStartDate(ds.getString("StartDateTime"));
				 hollyDto.setEndDate(ds.getString("EndDateTime"));
				 hollyDto.setHollyFlag(ds.getString("HollyFlag"));
				 hollyDto.setPhoneNo(ds.getString("Phoneno"));
				 hollyDto.setSignID1(ds.getString("SignID1"));
				 hollyDto.setSignID2(ds.getString("SignID2"));
				 hollyDto.setUserID(ds.getString("UserID"));
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
		
		return hollyDto;
	}	
	
	
	
	
	
	/**
	 * 휴가 이력 등록
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */

	public int HollyDayDuple(String MghKey , String UserID,int[] HollyDate) throws DAOException{
		
		String procedure = " { CALL hp10_HollyDateInsert ( ?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; HollyDate != null && i<HollyDate.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(MghKey);
				batch.add(UserID);
				batch.add(String.valueOf(HollyDate[i]));
				
				batchList.add(batch);
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
	 * 휴가 이력 등록
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public int HollyDayDuple2(String MghKey , String UserID,int HollyDate) throws Exception{
	
	int retVal = -1;
	DataSet ds = null;
	
	String procedure = " { CALL hp10_HollyDateInsert ( ?,?,? ) } ";
	
	QueryStatement sql = new QueryStatement();
	
	sql.setKey(UserID);
	sql.setSql(procedure); 
	
	sql.setString(MghKey); 
	sql.setString(UserID); 
	sql.setString(String.valueOf(HollyDate)); //AgentID
	
	
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
	 * 휴가 이력 등록
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public int HollyDayMapModify2(String MghKey , String UserID,int HollyDate) throws Exception{
	
	int retVal = -1;
	DataSet ds = null;
	
	String procedure = " { CALL hp10_HollyDateUpdate ( ?,?,? ) } ";
	
	QueryStatement sql = new QueryStatement();
	
	sql.setKey(UserID);
	sql.setSql(procedure); 
	
	sql.setString(MghKey); 
	sql.setString(UserID); 
	sql.setString(String.valueOf(HollyDate)); //AgentID
	
	
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
	 * 휴가 이력 등록
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public int HollyMapDelete(String MghKey , String UserID) throws Exception{
	
	int retVal = -1;
	DataSet ds = null;
	
	String procedure = " { CALL hp10_HollyDateDelete ( ?,? ) } ";
	
	QueryStatement sql = new QueryStatement();
	
	sql.setKey(UserID);
	sql.setSql(procedure); 
	
	sql.setString(MghKey); 
	sql.setString(UserID); 
	
	
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
	 *휴가날짜 중복체크
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public HollyDTO DupCheck(String UserID , String HollyDate) throws Exception{
	

		String procedure = "{ CALL  hp10_hollyDateDupCheck (? , ?)} ";
		
		HollyDTO hollyDto = null;
		DataSet ds = null;
		String result ="";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(UserID);
		sql.setSql(procedure);
		sql.setString(UserID);
		sql.setString(HollyDate);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
			    hollyDto = new HollyDTO();
				hollyDto.setResult(Integer.parseInt(ds.getString("Result")));
				hollyDto.setHollyDate(ds.getString("HollyDate"));
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
		
		return hollyDto;	
}
	
	/**
	 *휴가날짜 중복체크
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public HollyDTO HollyDupCheck(String HollyDate) throws Exception{
	

		String procedure = "{ CALL  hp10_hollyDateDupCheck2 (?)} ";
		
		HollyDTO hollyDto = null;
		DataSet ds = null;
		String result ="";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("HollyDupCheck");
		sql.setSql(procedure);
		sql.setString(HollyDate);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
			    hollyDto = new HollyDTO();
				hollyDto.setResult(Integer.parseInt(ds.getString("Result")));
				hollyDto.setHollyDate(ds.getString("HollyDayDate"));
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
		
		return hollyDto;	
}
	
	/**
	 *임직원 핸드폰번호
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList HollyDay() throws DAOException {

		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		
		String procedure = "{ CALL hp10_HollyDay ( ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("test");
		sql.setSql(procedure);
		
		DataSet ds = null;
		
		HollyDTO hollyDto = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				hollyDto = new HollyDTO();
				hollyDto.setTitle(ds.getString("HollyDayTitle"));
				hollyDto.setYear(ds.getString("Year"));
				hollyDto.setDays(ds.getString("Day"));

				 arrlist.add(hollyDto);
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

		return arrlist;
 	
	}
	
	/**
	 *임직원 핸드폰번호
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList TotalUserPhoneNo() throws DAOException {

		ArrayList<HollyDTO> arrlist = new ArrayList<HollyDTO>();
		
		String procedure = "{ CALL hp10_TotalUserPhoneNo ( ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey("test");
		sql.setSql(procedure);
		
		DataSet ds = null;
		
		HollyDTO hollyDto = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				hollyDto = new HollyDTO();
				hollyDto.setPhoneNo(ds.getString("OfficeTellNo"));
				hollyDto.setUserName(ds.getString("UserName"));

				 arrlist.add(hollyDto);
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

		return arrlist;
 	
	}
	
	/**
	 * 계정 정보를 삭제한다.(다건처리)
	 * @param logid 로그아이디
	 * @param users ID(check) 배열
	 * @return int
	 * @throws DAOException
	 */	
	public int HollyDayDeletes(String logid,String[] users, String USERID) throws DAOException{
		
		String procedure = " { CALL hp_mgHollyDayDelete ( ? , ? ) } ";
		
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
				System.out.println(r_data[0]);
				System.out.println(r_data[1]);
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
	
}
