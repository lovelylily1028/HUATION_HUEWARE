package com.huation.common.user;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import com.huation.common.util.*;
import com.huation.framework.data.*;
import com.huation.framework.persist.*;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.StringUtil;

//개발
public class UserDAO extends AbstractDAO {

	/**
	 * ���� ����Ʈ.   
	 * @param userDto   ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO userPageList(UserDTO userDto) throws DAOException {
	
		ListDTO retVal = null;
		String procedure = " { CALL hp10_mgUserInquiry ( ? , ? , ? , ? , ? , ?, ? ) } ";
	
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(""); //���� ���̵�
		sql.setString(userDto.getvSearchType()); //�˻�����
		sql.setString(userDto.getvSearch()); //�˻���
		sql.setInteger(userDto.getnRow()); //����Ʈ ����
		sql.setInteger(userDto.getnPage()); //���� ������
		sql.setString("PAGE"); //sp ����
		sql.setString(""); //��뿩��

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
	 * ����ڰ��� ��� 
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userRegist(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
//		String procedure = " { CALL hp10_mgUserRegist ( ? , ? , ? , ? , ? , ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";
		//20200608�ֹι�ȣ 2�� �߰�. �ּ��߰�
		//20200901�̷¼��߰�
		String procedure = " { CALL hp10_mgUserRegist ( ? , ? , ? , ? , ? , ?, ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(userDto.getChUserID()); //���� ���̵�
		sql.setString(userDto.getID()); //����� ���̵�
		sql.setString(userDto.getName()); //����� ��
		sql.setString(userDto.getGroupID()); //�׷���̵�
		sql.setString(userDto.getAuthID()); //���Ѿ��̵�
		sql.setString(userDto.getPassword()); //�н�����
		sql.setString(userDto.getOfficeTellNo()); //�ڵ�����ȣ
		sql.setString(userDto.getOfficeTellNo2()); //�系�����ȣ
		sql.setString(userDto.getEmail()); //�̸���
		sql.setString(userDto.getUseYN()); //��뿩��
		sql.setString(userDto.getHireDateTime());//�Ի���
		sql.setString(userDto.getFireDateTime());//�����
		sql.setString(userDto.getPosition());//����
		sql.setString(userDto.getPhoto());//����
		sql.setString(userDto.getBoardFileNm());
		sql.setString(userDto.getBoardFile());
		sql.setString(userDto.getEmployeeNum());//���
		sql.setString(userDto.getJumin1());//�ֹξ�
		sql.setString(userDto.getJumin2());//�ֹ�2
		sql.setString(userDto.getZip());//�ּ�

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
	 * ���� ����
	 * @param userid
	 * @return userDto ����� ����
	 * @throws DAOException
	 */
	public UserDTO userView(UserDTO userDto) throws DAOException{

		String procedure = "{ CALL hp10_mgUserSelect ( ? ,? ,? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure);  //���ν��� ��
		sql.setString(""); // ���� ���̵�
		sql.setString("SELECT"); // sp����
		sql.setString(userDto.getID()); //����� ���̵�

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
	 * ����ڰ��� ����
	 * @param userDto ���������
	 * @return retVal int
	 * @throws DAOException
	 */
	public int userModify(UserDTO userDto) throws Exception{
		
		int retVal = -1;
		
//		String procedure = " { CALL hp10_mgUserModify ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) } ";
		//20200608������ �ֹι�ȣ �߰�. zip �߰�
		String procedure = " { CALL hp10_mgUserModify ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,? ,? ,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); //�α׾��̵�
		sql.setSql(procedure); //���ν��� ��
		sql.setString(""); //���� ���̵�
		sql.setString(userDto.getID()); //����� ���̵�
		sql.setString(userDto.getName()); //����� ��
		sql.setString(userDto.getGroupID()); //�׷���̵�
		sql.setString(userDto.getAuthID()); //���Ѿ��̵�
		sql.setString(userDto.getPassword()); //�н�����
		sql.setString(userDto.getOfficeTellNo()); //�޴�����ȣ
		sql.setString(userDto.getOfficeTellNo2()); //�系�����ȣ
		sql.setString(userDto.getEmail()); //�̸���
		sql.setString(userDto.getUseYN()); //��뿩��
		sql.setString(userDto.getHireDateTime());//�Ի���
		sql.setString(userDto.getFireDateTime());//�����
		sql.setString(userDto.getPosition());//����
		sql.setString(userDto.getPhoto());//����
		sql.setString(userDto.getBoardFileNm());
		sql.setString(userDto.getBoardFile());
		sql.setString(userDto.getEmployeeNum()); // ���
		sql.setString(userDto.getJumin1()); // �ֹ�1
		sql.setString(userDto.getJumin2()); // �ֹ�2
		sql.setString(userDto.getZip()); // �ּ�

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
	 * ���� ������ �����Ѵ�.(�ٰ�ó��)
	 * @param logid �α׾��̵�
	 * @param users ID(check) �迭
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
				
				batch.add(USERID);//���� ���̵�
				batch.add(StringUtil.nvl(r_data[0],"")); //����� ���̵�
				
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
	 * ����� EXCEL ����Ʈ 
	 * @param userDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO userExcelList(UserDTO userDto) throws DAOException{
			
			String procedure = " { CALL hp10_mgUserInquiry (?,?,?,?,?,?) } ";
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setKey(userDto.getLogid()); //�α׾��̵�
			sql.setSql(procedure); //���ν��� ��
			sql.setString(userDto.getChUserID()); //���� ���̵�
			sql.setString(userDto.getvSearchType()); //�˻�����
			sql.setString(userDto.getvSearch()); //�˻���
			sql.setInteger(userDto.getnRow()); //����Ʈ ����
			sql.setInteger(userDto.getnPage()); //���� ������
			sql.setString("LIST"); //sp ����
			//sql.setString(""); //��뿩��

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
	 * ����� Count ������ �����´�
	 * @param userDto ����� ����
	 * @return userDto
	 * @throws DAOException
	 */

	public UserDTO userTotCount(UserDTO userDto) throws DAOException {
		
		String procedure = " { CALL hp10_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//�α׾��̵�
		sql.setString(userDto.getChUserID());		//���Ǿ��̵�
		sql.setString("COUNT");			//SP����
		sql.setString("");		//����� ���̵�

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
	* ����� �ߺ� üũ
	* @return formCodeDto
	* @return result
	* @throws DAOException
	*/
	public String userDupCheck(UserDTO userDto) throws DAOException{

		String procedure = " { CALL hp10_mgUserSelect ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setKey(userDto.getLogid());				//�α׾��̵�
		sql.setString(userDto.getChUserID());		//���Ǿ��̵�
		sql.setString("DUPLICATE");			//SP����
		sql.setString(userDto.getID());		//����� ���̵�

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
	 * �н����带 ���ڵ��Ѵ�.
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
	 * �н����� ����.
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
	 * �����ȣ ����
	 */
	public String EmployeeNumCreate(String position, String HireDate ){
		
		String HireDateDB = null; //DB�� �ִ� �Ի��� yyyymm ���� ������ String
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
					 System.out.println("while ����������");
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
						 System.out.println("������");
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
