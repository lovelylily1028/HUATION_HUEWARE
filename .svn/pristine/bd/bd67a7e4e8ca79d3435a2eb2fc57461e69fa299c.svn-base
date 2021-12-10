package com.huation.common.freeboard;

import java.sql.Connection;

import java.sql.SQLException;
import java.sql.ResultSet;

import java.io.Writer;
import java.io.BufferedWriter;
import java.sql.CallableStatement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ExecutionException;

import sun.util.logging.resources.logging;

import com.huation.common.BaseDAO;
import com.huation.common.config.AuthDTO;
import com.huation.common.config.MenuDTO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.common.user.UserDTO;

import com.huation.framework.persist.QueryStatement;
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
import com.mysql.jdbc.SQLError;

public class FreeBoardDAO extends AbstractDAO {

	/*
	 * 게시판 = > 자유게시판 등록
	 */  
	public int addBoardRegist(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_FreeBoardRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(fbDto.getWriteUser());
		//log.debug("유저"+fbDto.getWriteUser());
		sql.setString(fbDto.getBoardFile());
		sql.setString(fbDto.getBoardFileNm());
		//log.debug("파일경로1"+fbDto.getBoardFile());
		//log.debug("파일이름1"+fbDto.getBoardFileNm());
		sql.setString(fbDto.getTitle());
		//log.debug("제목1"+fbDto.getTitle());
		sql.setString(fbDto.getContents());
		//log.debug("내용1"+fbDto.getContents());
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
	/*
	 * 게시판 = > 자유게시판 덧글 등록
	 */
	public int addBoardRegistRep(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_FreeBoardRegistRep (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeqBoard()); //자유게시판 글 SEQ PK값
		log.debug("자유게시판 댓글 seq pk DAO:"+fbDto.getSeqBoard()); //자유게시판 댓글 seq pk
		sql.setString(fbDto.getWriteUserBoard()); //자유게시판 글쓴이
		sql.setString(fbDto.getRepWriteUser()); //자유게시판 덧글 글쓴이
		log.debug("자유게시판 글쓴이DAO:"+fbDto.getWriteUserBoard()); //자유게시판 글제목
		sql.setString(fbDto.getTitleBoard());
		log.debug("자유게시판 글제목DAO:"+fbDto.getTitleBoard()); 
		sql.setString(fbDto.getContentsRep()); //자유게시판 덧글 내용
		log.debug("덧글내용DAO:"+fbDto.getContentsRep());
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
	 * 자유게시판 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO BoardPageList(FreeBoardDTO fbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_FreeBoardInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(fbDto.getChUserID()); // 세션 아이디
		sql.setString(fbDto.getvSearchType()); // 검색구분
		sql.setString(fbDto.getvSearch()); // 검색어
		sql.setInteger(fbDto.getnRow()); // 리스트 갯수
		sql.setInteger(fbDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, fbDto.getnPage(),
					fbDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	/**
	 * 자유게시판 댓글 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO BoardPageListRep(FreeBoardDTO fbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_FreeBoardInquiryRep ( ?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		//sql.setString(fbDto.getRepWriteUser()); // 세션 아이디
		//System.out.println("댓글리스트::세션::체크"+fbDto.getRepWriteUser());
		sql.setInteger(fbDto.getSeqBoard());
		sql.setInteger(fbDto.getnRow()); // 리스트 갯수
		System.out.println("로우DAO:"+fbDto.getnRow());
		sql.setInteger(fbDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, fbDto.getnPage(),
					fbDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	/**
	 * 댓글리스트
	 * @param 
	 * @return 
	 * @throws DAOException
	public ArrayList<FreeBoardDTO> freeBoardTreeView(FreeBoardDTO fbDto) throws DAOException {
		
		ArrayList<FreeBoardDTO> arrlist = new ArrayList<FreeBoardDTO>();
		String procedure = "{ CALL hp10_mgFreeBoardAL  ( ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure);
		sql.setInteger(fbDto.getSeqBoard());
		System.out.println("fbDto.getSeqBoard():::"+fbDto.getSeqBoard());
		
		try{
			
			ds = broker.executeProcedure(sql);
			
			 while(ds.next()){ 
				 fbDto = new FreeBoardDTO();
				 fbDto.setSeqBoard(ds.getInt("SeqBoard"));
				 System.out.println("SeqBoard:"+ds.getInt("SeqBoard"));
				 fbDto.setSeqRep(ds.getInt("SeqRep"));
				 fbDto.setWriteUserBoard(ds.getString("WriteUserBoard"));
				 fbDto.setRepWriteUser(ds.getString("RepWriteUser"));
				 fbDto.setTitleBoard(ds.getString("TitleBoard"));
				 System.out.println("TitleBoard:"+ds.getString("TitleBoard"));
				 fbDto.setContentsRep(ds.getString("ContentsRep"));
				 fbDto.setCreateDateTimeRep(ds.getString("CreateDateTimeRep"));
				 arrlist.add(fbDto);
				 
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
	 */
	/**
	 * 자유게시판 댓글 리스트[더보기].
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	public ListDTO BoardPageListRepp(FreeBoardDTO fbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_FreeBoardInquiryRepTC ( ?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		//sql.setString(fbDto.getRepWriteUser()); // 세션 아이디
		//System.out.println("댓글리스트::세션::체크"+fbDto.getRepWriteUser());
		sql.setInteger(fbDto.getSeqBoard());
		sql.setInteger(fbDto.getNnRow());
		sql.setInteger(fbDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, fbDto.getnPage()
				);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	 */

	/**
	 * 자유게시판(상세) 정보
	 * 
	 */
	public FreeBoardDTO BoardView(FreeBoardDTO fbDto) throws DAOException {

		String procedure = "{ CALL hp_FreeBoardSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeq());
		 
		try {

			ds = broker.executeProcedure(sql);
 
			while (ds.next()) {
				fbDto = new FreeBoardDTO();
				fbDto.setSeq(ds.getInt("Seq"));
				fbDto.setWriteUser(ds.getString("WriteUser"));
				fbDto.setWriteUserName(ds.getString("WriteUserName"));
				fbDto.setBoardFile(ds.getString("BoardFile"));
				fbDto.setBoardFileNm(ds.getString("BoardFileNm"));
				fbDto.setTitle(ds.getString("Title"));
				fbDto.setContents(ds.getString("Contents"));
				//조회수 를 증가시키기 위해 ReadCount를 먼저 셀렉트 해온다.
				fbDto.setReadCount(ds.getInt("ReadCount"));
					System.out.println("ViewREADCOUNT::"+ds.getInt("ReadCount"));
				//댓글 Seq 가져와야 그 게시글Seq의 댓글 목록을 가져올 수 있다.
				fbDto.setSeqBoard(ds.getInt("SeqBoard"));
					System.out.println("SeqBoard::DAO:::" +ds.getInt("SeqBoard"));
				//댓글 UserID를 가져와야 그 게시글 댓글의 세션을 체크 할 수 있다.
				//fbDto.setRepWriteUser(ds.getString("RepWriteUser"));
					//System.out.println("RepWriteUser::DAO:::"+ds.getString("RepWriteUser"));
				fbDto.setSeqRep(ds.getInt("SeqRep"));
				System.out.println("SeqRep::DAO::"+ds.getInt("SeqRep"));
				fbDto.setReplyCount(ds.getInt("ReplyCount"));
				System.out.println("ReplyCount::DAO::"+ds.getInt("ReplyCount"));

				
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			try {
				if (ds != null) {
					ds.close();
					ds = null;
				}
			} catch (Exception ignore) {
				log.error(ignore.getMessage());
			}
		}

		return fbDto;
	}
	/*
	 * 자유게시판 => 조회수증가
	 */
	public int freeBoardCount(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FreeBoardReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeq());
		sql.setInteger(fbDto.getReadCount());
		System.out.println("Readcount::"+fbDto.getReadCount());
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;
	}
	/*
	 * 자유게시판 = > 수정
	 */
	public int BoardUpdate(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FreeBoardModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeq());
		sql.setString(fbDto.getWriteUser());
		sql.setString(fbDto.getBoardFile());
		sql.setString(fbDto.getBoardFileNm());
		sql.setString(fbDto.getTitle());
		sql.setString(fbDto.getContents());
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}
	/*
	 * 자유게시판 = > 덧글수정
	 */
	public int BoardUpdateRep(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FreeBoardModifyRep (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeqRep());
		sql.setInteger(fbDto.getSeqBoard());
		sql.setString(fbDto.getWriteUserBoard());
		sql.setString(fbDto.getRepWriteUser());
		sql.setString(fbDto.getTitleBoard());
		sql.setString(fbDto.getContentsRep());
		System.out.println("DAOContentsRep::"+fbDto.getContentsRep());
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}

	/*
	 * 자유게시판 => 삭제
	 */
	public int deleteBoardOne(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FreeBoardDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeq());

		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;
	}

	/*
	 * 자유게시판 => 덧글삭제
	 */
	public int deleteBoardOneRep(FreeBoardDTO fbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FreeBoardDeleteRep (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(fbDto.getSeqRep());

		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;
	}
	

}