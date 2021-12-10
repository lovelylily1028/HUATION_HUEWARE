package com.huation.hueware.closure.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.framework.struts.StrutsDispatchAction;

/**
 * 휴폐업
 * @author lovelylily
 *
 */
public class ClosureMgAction extends StrutsDispatchAction{

	public ActionForward closureMgList(ActionMapping actionMapping, 
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception{
		
		return actionMapping.findForward("closureMgList");
	}
	
	
	
}
