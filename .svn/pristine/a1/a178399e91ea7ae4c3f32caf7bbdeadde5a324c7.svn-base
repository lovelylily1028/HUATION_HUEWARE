package com.huation.common.addBoard;

import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;

import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.QueryStatement;

public class AddBoardDAO extends AbstractDAO{

	/*
	 * 게시판 -> 쓰기 등록
	 */
	public int insertAddBoardRegist(AddBoardDTO abDto, String BoardFile, String BoardFileNm) throws DAOException{
		
		log.debug("dao, filePath : "+BoardFile);
		log.debug("dao, fileName : "+BoardFileNm);
		
		int retVal = -1;
		
		String procedure = " { CALL hp_AddBoardRegist (?,?,?,?,?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);  //프로시저 명
		sql.setString(abDto.getWriteUser());  //작성자
		sql.setString(BoardFile);  //파일경로
		sql.setString(BoardFileNm); //파일명
		sql.setString(abDto.getTitle());  //제목
		sql.setString(abDto.getContents());  //내용
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
		return retVal;
	}//insertAddBoardRegist
	
	
	
	
	/*
	 * 게시판 -> 리스트 불러오기
	 */
	
	public ListDTO selectAddBoardList(AddBoardDTO abDto, String category, String searchWord) throws DAOException{
		
		ListDTO retVal = null;
		String procedure = " { CALL hp_AddBoardInquiry ( ?,?,?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(abDto.getWriteUser());
		sql.setInteger(abDto.getnRow());
		sql.setInteger(abDto.getPageNo());
		sql.setString(category);
		sql.setString(searchWord);
		
		try {
			retVal = broker.executeListProcedure(sql);
		}catch(Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}
		
		return retVal;
		
	}//selectAddBoardList
	
	
	

	/*
	 * 게시판 페이징 => 전체 게시글 갯수 확인 
	 */
	public int selectAddBoardListAllCnt(AddBoardDTO abDto, String category, String searchWord) throws Exception{
		
		//변수선언
		DataSet ds;
		int totalCnt = 0;
		
		String procedure = " { CALL hp_AddBoardListCnt ( ?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(abDto.getPageNo());
		sql.setString(category);
		sql.setString(searchWord);
		
		
		try {
			ds = broker.executeQuery(sql);
			
			while(ds.next()) {
				totalCnt = ds.getInt("totalCnt");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		int pageCnt = 0;
		int pageSize = abDto.getnRow();
		int remain = (int) (totalCnt % pageSize);
		
		if(remain == 0) {
			pageCnt = (int) (totalCnt/pageSize);
		}else {
			pageCnt = (int) (totalCnt/pageSize) +1;
		}
		
		return pageCnt;
	}
	
	
	



	/*
	 * 게시판 -> 상세페이지 
	 */
	public Map<String, Object> selectAddBoardDetail(int addBoardSeq, String USERID) throws DAOException {
		
		
		DataSet ds = null;
		AddBoardDTO abDto = new AddBoardDTO();
		Map<String, Object> map = new HashedMap();
		String boardFile = "";
		String boardFileNm = "";
		
		String procedure = "{ CALL hp_AddBoardDetail ( ?,? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); //프로시저명
		sql.setInteger(addBoardSeq);
		sql.setString(USERID);
		
		try {
			ds = broker.executeProcedure(sql);
			
			while(ds.next()) {
				abDto.setAddBoardSeq(ds.getInt("addBoardSeq"));
				abDto.setWriteUser(ds.getString("writeUser"));
				boardFile = ds.getString("boardFile");
//				System.out.println("boardFile : "+boardFile);
				boardFileNm = ds.getString("boardFileNm");
//				System.out.println("boardFileNm : "+boardFileNm);
				abDto.setTitle(ds.getString("title"));
				abDto.setContents(ds.getString("contents"));
				abDto.setCreateDateTime(ds.getString("createDateTime"));
				abDto.setUpdateDateTime(ds.getString("updateDateTime"));
				abDto.setDeletedYN(ds.getString("deletedYN"));
				abDto.setDeletedUser(ds.getString("deletedUser"));
				abDto.setReadCount(ds.getInt("readCount"));
				abDto.setUserName(ds.getString("userName"));
				
				map.put("abDto", abDto);
				map.put("boardFile", boardFile);
				map.put("boardFileNm", boardFileNm);
				
			}//while
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			try {
				if(ds != null) {
					ds.close();
					ds = null;
				}
			}catch(Exception lgnore) {
				log.error(lgnore.getMessage());
			}
		}
		
		
		
		return map;
	}

	
	
	
	/*
	 * 게시판 -> 조회수 +1 처리
	 */
	public void updateAddBoardReadCnt(int addBoardSeq) throws DAOException{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_AddBoardReadCnt (?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(addBoardSeq);
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retVal : "+retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
	}
	
	
	
	


	/*
	 * 게시판 -> 삭제 
	 */

	public int deleteAddBoardOne(int addBoardSeq) throws DAOException {
		
		int retVal = -1;

		String procedure = " { CALL hp_AddBoardDelete (?) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(addBoardSeq);
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retVal : "+retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			
		}
		
		return retVal;
	}



	
	
	/*
	 * 게시판 -> 수정 
	 */

	public int updateAddBoardModify(AddBoardDTO abDto, String boardFile, String boardFileNm) throws DAOException{
		
		log.debug("dao, filePath : "+boardFile);
		log.debug("dao, fileName : "+boardFileNm);

		int retVal = -1;
		
		String procedure = " { CALL hp_AddBoardModify ( ?,?,?,?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure);  //프로시저 명
		sql.setInteger(abDto.getAddBoardSeq());  //글번호
		sql.setString(abDto.getWriteUser());  //작성자
		sql.setString(boardFile);  //파일경로
		sql.setString(boardFileNm); //파일명
		sql.setString(abDto.getTitle());  //제목
		sql.setString(abDto.getContents());  //내용

		
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			
		}
		
		return retVal;
	}

	
	
	
	
	/*
	 * 
	 * 댓글 -> 쓰기 등록
	 * 
	 * 
	 */
	public int insertAddBoardComRegist(AddBoardDTO abDto) throws DAOException{
		
		
		int retVal = -1;
		
		String procedure = "{ CALL hp_AddBoardComRegist ( ?,?,? ) }";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(abDto.getAddBoardSeq());
		sql.setString(abDto.getComWriteUser());
		sql.setString(abDto.getComContents());
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
		return retVal;
	}




	/*
	 * 
	 * 댓글 -> 리스트
	 * 
	 * 
	 */
	public ListDTO selectAddBoardComDetail(int addBoardSeq, String USERID, int comPageNo, int comPageSize) throws DAOException{
		
		
		//변수선언
		ListDTO ld = null;
		
		String procedure = "{ CALL hp_AddBoardComDetail ( ?,?,?,? ) }";
		
		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure);
		sql.setInteger(addBoardSeq);
		sql.setString(USERID);
		sql.setInteger(comPageNo);
		sql.setInteger(comPageSize);
		
		try {
			ld = broker.executeListProcedure(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
		return ld;
	}




	/*
	 * 
	 * 댓글 -> 수정하기
	 * 
	 * 
	 */
	public int updateAddBoardComModify(AddBoardDTO abDto) throws DAOException{
		
		
		int retVal = -1;
		
		String procedure = " { CALL hp_AddBoardComModify ( ?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(abDto.getComSeq());
		sql.setInteger(abDto.getAddBoardSeq());
		sql.setString(abDto.getComContents());
		
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
		return retVal;
	}




	/*
	 * 
	 * 댓글 개수 확인
	 * 
	 * 
	 */
	public int selectAddBoardComCnt(int addBoardSeq) throws Exception{

		//변수선언
		DataSet ds;
		int comCnt = 0;
		
		String procedure = " { CALL hp_AddBoardComCnt ( ? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(addBoardSeq);
		
		try {
			ds = broker.executeQuery(sql);
			
			while(ds.next()) {
				comCnt = ds.getInt("comCnt");
				
			}//while
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return comCnt;
	}



	/*
	 * 
	 * 댓글 삭제
	 * 
	 * 
	 */
	public int deleteAddBoardComOne(AddBoardDTO abDto) throws DAOException{
		
		int retVal = -1;
		
		String procedure = " { CALL hp_AddBoardComDelete ( ?,?,? ) } ";
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(abDto.getComSeq());
		sql.setInteger(abDto.getAddBoardSeq());
		sql.setString(abDto.getComWriteUser());
		
		try {
			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retVal : "+retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally {
			
		}
		
		return retVal;
	}









	




	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
