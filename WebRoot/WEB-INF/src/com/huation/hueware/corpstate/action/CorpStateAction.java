package com.huation.hueware.corpstate.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.baroservice.ws.BaroService_CORPSTATESoap;
import com.baroservice.ws.BaroService_CORPSTATESoapProxy;
import com.baroservice.ws.CorpState;
import com.huation.common.corpState.CorpStateDAO;
import com.huation.common.corpState.CorpStateDTO;
import com.huation.framework.struts.StrutsDispatchAction;
import com.huation.framework.util.StringUtil;

import net.sf.json.JSONObject;

/**
 * 휴폐업
 * @author lovelylily
 *
 */
public class CorpStateAction extends StrutsDispatchAction{

	/* 바로빌 인증키 */
	public static String Closure_KEY = config.getString("framework.hueware.invocekey_dev");
	/* 휴에이션 사업자 번호 */
	public static String CorpNum = config.getString("framework.hueware.corpNum");
	
	private BaroService_CORPSTATESoap soap = new BaroService_CORPSTATESoapProxy();
	CorpStateDAO dao = new CorpStateDAO();
	
	CorpState result = new CorpState();
	
	/* 휴폐업 조회 페이지 */
	public ActionForward CorpStateSearchPage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception{
		
		return actionMapping.findForward("CorpStateSearchPage");
	}
	
	/* 사업자 번호 검색 */
	public ActionForward CorpStateSearch(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		String checkCorpNum = StringUtil.nvl(request.getParameter("checkCorpNum"));
		
		result = soap.getCorpState(Closure_KEY, CorpNum, checkCorpNum);
		
		CorpStateDTO vdto = new CorpStateDTO();
		
		vdto.setCorpNum(result.getCorpNum());
		vdto.setTaxType(dao.TaxTypeToLongString(result));
		vdto.setState(dao.StateToString(result.getState()));
		vdto.setStateDate(result.getStateDate());
		vdto.setBaseDate(result.getBaseDate());
		
		/* Json객체 생성 */
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result",vdto);
		
		/* 한글 설정 */
		response.setContentType("application/json");
		response.setCharacterEncoding("euc-kr");
		response.getWriter().print(jsonObject);
		
		return null;
	}
	
}
