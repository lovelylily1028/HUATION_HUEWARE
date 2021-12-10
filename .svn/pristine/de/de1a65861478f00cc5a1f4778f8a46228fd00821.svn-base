package com.huation.common.config;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ISqlStatement;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.huation.framework.util.StringUtil;

import com.huation.common.config.MenuDTO;
import com.huation.common.config.AuthDTO;

public class AuthDAO extends AbstractDAO {
	
	/**
	 * 메뉴 리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList authMenuTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp10_mgMenuInquiry  (?) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		sql.setString(authDto.getUserID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setMenuStep(ds.getInt("MenuStep"));
				 menuDto.setMenuSort(ds.getInt("MenuSort"));
				 menuDto.setAuth(ds.getString("AuthID"));
				 
				 arrlist.add(menuDto);
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
	 * 사용자 권한 리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList userAuthMenuTree(AuthDTO authDto) throws DAOException {
		
		MenuDTO menuDto=null;
		ArrayList<MenuDTO> arrlist = new ArrayList<MenuDTO>();
		
		String procedure = "{ CALL hp10_mgAuthUserMenuInquiry  ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(authDto.getLogid());
		sql.setSql(procedure);
		sql.setString(authDto.getUserID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 menuDto = new MenuDTO();
				 menuDto.setMenuID(ds.getString("MenuID"));
				 menuDto.setUpMenuID(ds.getString("UpMenuID"));
				 menuDto.setMenuName(ds.getString("MenuName"));
				 menuDto.setMenuStep(ds.getInt("MenuStep"));
				 menuDto.setMenuSort(ds.getInt("MenuSort"));
				 menuDto.setAuth(ds.getString("AuthID"));
				 
				 arrlist.add(menuDto);
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
	 * 사용자 권한 리스트(메인화면 게시판 보여주기 권한 여부)_2012_10_24(수)bsh
	 * @param 
	 * @return 
	 * @throws DAOException
	 */
	public ArrayList userAuthMenuTreeView(AuthDTO atDto) throws DAOException {
		
		ArrayList<AuthDTO> arrlist = new ArrayList<AuthDTO>();
		String procedure = "{ CALL hp10_mgAuthUserMenuSelect  ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setString(atDto.getUserID());
		System.out.println("ChUSERID"+atDto.getUserID());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 atDto = new AuthDTO();
				 MenuDTO mtDto = new MenuDTO();
				 atDto.setUserID(ds.getString("UserID"));
				 System.out.println("UserID::" +ds.getString("UserID"));
				 atDto.setMenuID(ds.getString("MenuID"));
				 System.out.println("MenuID:메뉴ID리스트:" +ds.getString("MenuID"));
				 mtDto.setUpMenuID(ds.getString("UpMenuID"));
				 System.out.println("UpMenuID::" +ds.getString("UpMenuID"));
				 mtDto.setMenuName(ds.getString("MenuName"));
				 mtDto.setMenuStep(ds.getInt("MenuStep"));
				 mtDto.setMenuSort(ds.getInt("MenuSort"));
				 mtDto.setAuthID(ds.getString("AuthID"));
				 System.out.println("AuthID:메뉴권한:" +ds.getString("AuthID"));
				 
				 arrlist.add(atDto);
				 
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
	
	public int authDeletes(String logid ,String regid ,String[] users ) throws DAOException{
		
		String procedure = "{ CALL hp10_mgAuthUserMenuDelete ( ? , ? ) }";
		
		String[] r_data=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

			for(int i=0; users != null && i<users.length; i++){ 
				
				List batch=new Vector();
				
				r_data = StringUtil.getTokens(users[i], "|");
				
				if(r_data[1].equals("Y")){
					
					userid=StringUtil.nvl(r_data[0],"");

					batch.add(regid);
					batch.add(userid);
					
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
		}
		return retVal;	
    }
	public int authRegists(String logid ,String regid ,String[] users ,String[] menus ) throws DAOException{
		
		String procedure = "{ CALL hp10_mgAuthUserMenuRegist ( ? , ? , ? ) }";
		
		String[] r_users=null;
		String[] r_menus=null;
		int retVal = -1;	
		int[] resultVal=null;
		
		String userid="";
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setKey(logid);
		sql.setSql(procedure);
		
		List batchList=new Vector();

		try{

			for(int i=0; users != null && i<users.length; i++){ 
				
				r_users = StringUtil.getTokens(users[i], "|");

				if(r_users[1].equals("Y") && !r_users[0].equals(" ")){
					
					userid=StringUtil.nvl(r_users[0],"");
					
					for(int j=0; menus != null && j<menus.length; j++){

						r_menus = StringUtil.getTokens(menus[j], "|");
						
						if(r_menus[1].equals("Y")){
							
							List batch=new Vector();
							
							batch.add(regid.trim());
							batch.add(userid.trim());
							batch.add(r_menus[0].trim());

							batchList.add(batch);
						}
					
					}

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
		}
		return retVal;	
    }
}
