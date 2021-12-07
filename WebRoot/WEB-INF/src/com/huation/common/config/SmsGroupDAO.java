package com.huation.common.config;

import java.sql.SQLException;
import java.util.ArrayList;

import com.huation.common.estimate.EstimateDTO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ISqlStatement;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.huation.framework.util.StringUtil;
import java.util.List;
import java.util.Vector;

public class SmsGroupDAO extends AbstractDAO {
	/**
	 * 문자발송 그룹  리스트 (일반 그룹 트리 리스트)
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList smsGroupTreeList(SmsGroupDTO smsgroupDto) throws DAOException {

		ArrayList<SmsGroupDTO> arrlist = new ArrayList<SmsGroupDTO>();
		
		String procedure = "{ CALL hp10_mgSmsGroupInquiry ( ? ,? ,? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure);
		sql.setString(smsgroupDto.getSmsGroupID());
		sql.setString(smsgroupDto.getJobGb());
		sql.setInteger(smsgroupDto.getSmsGroupStep());

		DataSet ds = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				smsgroupDto = new SmsGroupDTO();
				smsgroupDto.setSmsGroupID(ds.getString("SmsGroupID"));
				smsgroupDto.setSmsUpGroupID(ds.getString("SmsUpGroupID"));
				smsgroupDto.setSmsGroupName(ds.getString("SmsGroupName"));
				smsgroupDto.setSmsGroupStep(ds.getInt("SmsGroupStep"));
				smsgroupDto.setSmsGroupSort(ds.getInt("SmsGroupSort"));

				 arrlist.add(smsgroupDto);
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
	 * 문자발송 유져  리스트 (일반 그룹 트리 리스트)
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList smsUserList(SmsGroupDTO smsgroupDto) throws DAOException {

		ArrayList<SmsGroupDTO> arrlist = new ArrayList<SmsGroupDTO>();
		
		String procedure = "{ CALL hp10_mgSmsUserList ( ? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure);
		sql.setString(smsgroupDto.getSmsGroupID());
		

		DataSet ds = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				smsgroupDto = new SmsGroupDTO();
				smsgroupDto.setSmsGroupID(ds.getString("SmsGroupID"));
				smsgroupDto.setPhoneNumber(ds.getString("PhoneNumber"));
				smsgroupDto.setUserName(ds.getString("UserName"));
				smsgroupDto.setSmsGroupName(ds.getString("SmsGroupName"));
				smsgroupDto.setMemo(ds.getString("Memo"));
				smsgroupDto.setIndex(ds.getInt("seq"));
				
				 arrlist.add(smsgroupDto);
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
	 * 문자발송 유져  리스트 (휴에이션 임직원)
	 * @param  groupDto 그룹정보
	 * @return  arrlist ArrayList
	 * @throws DAOException
	 */
	public ArrayList smsUserList2(SmsGroupDTO smsgroupDto) throws DAOException {

		ArrayList<SmsGroupDTO> arrlist = new ArrayList<SmsGroupDTO>();
		
		String procedure = "{ CALL hp10_mgSmsHueUserList ( ? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure);
		sql.setString(smsgroupDto.getSmsGroupID());
		
		
		DataSet ds = null;
		
		try{
			
			ds = broker.executeProcedure(sql);

			while(ds.next()){
				smsgroupDto = new SmsGroupDTO();
				smsgroupDto.setSmsGroupID(ds.getString("GroupID"));
				smsgroupDto.setPhoneNumber(ds.getString("OfficeTellNo"));
				smsgroupDto.setUserName(ds.getString("UserName"));
				smsgroupDto.setSmsGroupName(ds.getString("GroupName"));
				smsgroupDto.setOfficeTellNo2(ds.getString("OfficeTellNo2"));
				 arrlist.add(smsgroupDto);
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
		 * 문자발송 유져 등록
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public int smsUserRegist(SmsGroupDTO smsgroupDto) throws Exception{
		
		int retVal = -1;
		DataSet ds = null;
		
		String procedure = " { CALL hp10_mgSmsUserRegist ( ? , ? , ? , ? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure); 
		
		sql.setString(smsgroupDto.getGroupID()); 
		sql.setString(smsgroupDto.getPhoneNumber()); 
		sql.setString(smsgroupDto.getUserName()); 
		sql.setString(smsgroupDto.getMemo()); //AgentID
		
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
		 * 문자발송 유져 수정
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public int smsUserModify(SmsGroupDTO smsgroupDto) throws Exception{
		
		int retVal = -1;
		DataSet ds = null;
		
		String procedure = " { CALL hp10_mgSmsUserModify ( ? , ? , ? , ? , ?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure); 
		
		sql.setString(smsgroupDto.getGroupID()); 
		sql.setString(smsgroupDto.getPhoneNumber()); 
		sql.setString(smsgroupDto.getUserName()); 
		sql.setString(smsgroupDto.getMemo()); //AgentID
		sql.setInteger(smsgroupDto.getIndex()); //AgentID
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
		 * 폰번호 중복체크
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public SmsGroupDTO DupCheck(SmsGroupDTO smsgroupDto) throws Exception{
		

			String procedure = "{ CALL  hp10_mgSmsDupCheck (?)} ";
			
			DataSet ds = null;
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(smsgroupDto.getLogID());
			sql.setSql(procedure);
			sql.setString(smsgroupDto.getPhoneNumber());
			
			try{
				
				ds = broker.executeProcedure(sql);
				
				if(ds.next()){ 
					smsgroupDto = new SmsGroupDTO();
					smsgroupDto.setResult(Integer.parseInt(ds.getString("Result")));
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
			
			return smsgroupDto;	
	}
		/**
		 * 그룹 등록 중복체크
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public SmsGroupDTO smsGroupDupCheck(SmsGroupDTO smsgroupDto) throws Exception{
		

			String procedure = "{ CALL  hp10_mgSmsGroupDupCheck ( ? )} ";
			
			DataSet ds = null;
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(smsgroupDto.getLogID());
			sql.setSql(procedure);
			sql.setString(smsgroupDto.getGroupName());
			
			try{
				
				ds = broker.executeProcedure(sql);
				
				if(ds.next()){ 
					smsgroupDto = new SmsGroupDTO();
					smsgroupDto.setResult2(Integer.parseInt(ds.getString("Result2")));
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
			
			return smsgroupDto;	
	}
		/**
		 * 그룹 등록
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public int smsGroupRegist(SmsGroupDTO smsgroupDto) throws Exception{
		
		int retVal = -1;
		DataSet ds = null;
		
		String procedure = " { CALL hp10_mgSmsGroupRegist ( ? , ? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure); 
		
		sql.setString(smsgroupDto.getGroupID()); 
		sql.setString(smsgroupDto.getGroupName()); 
		
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
		 * 그룹 삭제
		 * @param  groupDto 그룹정보
		 * @return  arrlist ArrayList
		 * @throws DAOException
		 */
		public int smsGroupDelete(SmsGroupDTO smsgroupDto) throws Exception{
		
		int retVal = -1;
		DataSet ds = null;
		
		String procedure = " { CALL hp10_mgSmsGroupDelete (  ? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(smsgroupDto.getLogID());
		sql.setSql(procedure); 
		sql.setString(smsgroupDto.getGroupID()); 
		
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
		 * 유저 상세보기
		 * @param userid
		 * @return userDto
		 * @throws DAOException
		 */
		public SmsGroupDTO goModifyForm(SmsGroupDTO smsgroupDto) throws DAOException{

			String procedure = "{ CALL hp10_mgSmsUserSelect ( ? , ? ) }";

			DataSet ds = null;
			
			QueryStatement sql = new QueryStatement();
			
			sql.setKey(smsgroupDto.getLogID()); 
			sql.setSql(procedure);  
			sql.setInteger(smsgroupDto.getIndex()); //Device
			sql.setString("SELECT"); //Device
			try{
				
				 ds = broker.executeProcedure(sql);
				
				 while(ds.next()){ 
					 smsgroupDto = new SmsGroupDTO();
					 smsgroupDto.setPhoneNumber(ds.getString("PhoneNumber"));
					 smsgroupDto.setSmsGroupID(ds.getString("SmsGroupID"));
					 smsgroupDto.setUserName(ds.getString("UserName"));
					 smsgroupDto.setMemo(ds.getString("Memo"));
					 smsgroupDto.setIndex(ds.getInt("seq"));
					
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
			
			return smsgroupDto;
		}
		
		
		/**
		 * SMS 리스트.
		 * 
		 * @param userDto
		 *            사용자 정보
		 * @return ListDTO
		 * @throws DAOException
		 */
		public ListDTO SmsPageList(SmsGroupDTO smsgroupDto) throws DAOException {

			ListDTO retVal = null;
			String procedure = " { CALL hp10_mgSmsList ( ?,?,?,?,?,?,? ) } ";

			QueryStatement sql = new QueryStatement();

			sql.setSql(procedure); // 프로시져 명
			sql.setString(smsgroupDto.getSearchGb()); // 검색구분
			sql.setString(smsgroupDto.getSearchtxt()); // 검색어
			sql.setInteger(smsgroupDto.getnRow()); // 리스트 갯수
			sql.setInteger(smsgroupDto.getnPage()); // 현제 페이지
			sql.setString("PAGE"); // sp 구분
			sql.setString(smsgroupDto.getStartDT()); // 조회시작일
			sql.setString(smsgroupDto.getEndDT()); // 조회종료일
			
			try {
				retVal = broker.executePageProcedure(sql, smsgroupDto.getnPage(),
						smsgroupDto.getnRow());

			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				throw new DAOException(e.getMessage());
			}

			return retVal;

		}
		
	
		/**
		 * Device 유저 삭제(다건)
		 * @param logid 
		 * @param devices ID(check)
		 * @return int
		 * @throws DAOException
		 */	
		public int deviceDeletes(String logid,String[] devices) throws DAOException{
			
			String procedure = " { CALL hp10_mgSmsUserDelete ( ? ) } ";
			
			String[] r_data=null;
			int retVal = 0;	
			int[] resultVal=null;
			
			QueryStatement sql = new QueryStatement();
			sql.setBatchMode(true);
			sql.setSql(procedure);
			
			List batchList=new Vector();
			
			try{
				
				for(int i=0; devices != null && i<devices.length; i++){ 
					
					List batch=new Vector();

					r_data = StringUtil.getTokens(devices[i], "|");
					System.out.println("r_data : "+r_data[0]+" , "+r_data[1]+" , "+r_data[2]);
					if(r_data[2].equals("Y")){
					
					batch.add(StringUtil.nvl(r_data[0],"")); //Device 
					
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
	 * 그룹 수정
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO
	 * @throws DAOException
	 */
	public GroupDTO groupUpdate(GroupDTO groupDto) throws DAOException {
		
		String GroupID=groupDto.getGroupID();
		String GroupName=groupDto.getGroupName();
		int GroupStep=1;
		String faxNo=groupDto.getFaxNo();
		
		String procedure = "{ CALL  hp10_mgGroupModify (? , ? , ? , ? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		sql.setString(GroupName);
		sql.setString("UPDATE");
		sql.setInteger(0);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("R_GroupID"));
				 groupDto.setGroupStep(ds.getInt("R_GroupStep"));

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
		
		return groupDto;	
    }
	/**
	 * 그룹 삭제
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO
	 * @throws DAOException
	 */
	public GroupDTO groupDelete(GroupDTO groupDto) throws DAOException {

		String GroupID=groupDto.getGroupID();
		String GroupName=groupDto.getGroupName();
		int GroupStep=1;
		
		String procedure = "{ CALL  hp10_mgGroupDelete (? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setGroupID(ds.getString("R_GroupID"));
				 groupDto.setGroupStep(ds.getInt("R_GroupStep"));

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
		
		return groupDto;	
    }
	/**
	 * 그룹 순서정렬 (같은 뎁스의 순서를 변경한다)
	 * @param groupDto 그룹정보
	 * @return retVal int
	 * @throws DAOException
	 */
	public int groupOrderUpdate(GroupDTO groupDto) throws DAOException {
		
		int GroupSort=groupDto.getGroupSort();
		String GroupID=groupDto.getGroupID();

		String procedure = "{ CALL  hp10_mgGroupModify (? , ? , ? , ? , ? )} ";
		
		DataSet ds = null;
		int retVal=-1;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString(GroupID);
		sql.setString("");
		sql.setString("SORT");
		sql.setInteger(GroupSort);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 retVal=ds.getInt("ResultCode");

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
		return retVal;	
    }
	/**
	 * 그룹명 중복체크
	 * @param groupDto 그룹정보
	 * @return groupDto GroupDTO 
	 * @throws DAOException
	 */
	public GroupDTO groupNameDupCheck(GroupDTO groupDto) throws DAOException {
		
		String GroupName=groupDto.getGroupName();

		String procedure = "{ CALL  hp10_mgGroupSelect (? , ? , ? , ? )} ";
		
		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(groupDto.getLogid());
		sql.setSql(procedure);
		sql.setString("");
		sql.setString("DUPLICATE");
		sql.setString("1");
		sql.setString(GroupName);
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			if(ds.next()){ 
				 groupDto = new GroupDTO();
				 groupDto.setResult(Integer.parseInt(ds.getString("Result")));

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
		
		return groupDto;	
    }
	
	
	/**
	 * 문자발신 정보 등록하기. 
	 * @param smsgroupDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int SmsSubmitRegist(SmsGroupDTO smsgroupDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		 QueryStatement sql = new QueryStatement();
		 String procedure = " { CALL hp10_mgSmsRegist (?,?,?,?,?,?) } ";
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
		 sql.setString(smsgroupDto.getSendNum());
		 sql.setString(smsgroupDto.getSendKey());
		 sql.setString(smsgroupDto.getMessage());
		 sql.setString(smsgroupDto.getReserveCheck());
		 sql.setString(smsgroupDto.getSendStartTime());
		 sql.setString(smsgroupDto.getRegID());
			
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
	 * 2013_03_14(목) shbyeon.
	 * SMS 수신자 목록 등록 배치
	 * Description : 견적서 최초발행,모발행,영업진행현황 최초발행,즉시발행 공통사용 됨.
	 * @throws DAOException
	 */	
	public int smsReceiveRegist(String SendKey, String phoneno[], String[] username) throws DAOException{
		
		String procedure = " { CALL hp10_mgSmsReceiveRegist ( ?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; phoneno != null && i<phoneno.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(SendKey);
				batch.add(phoneno[i]);
				batch.add(username[i]);
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
	

}
