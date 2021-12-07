<%@ page errorPage="/jsp/hueware/common/error.jsp" %> 
<%@ page import ="java.util.*"%> 
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	boolean bLogin = BaseAction.isSession(request);			
	UserMemDTO dtoUser = new UserMemDTO();					
	if(bLogin == true)
		dtoUser = BaseAction.getSession(request); 

	String BODYEVENT = "oncontextmenu='return false' ";
	
	int port=0;
	
	String SERVER_NM = request.getServerName() ;
	String SERVER_PORT= StringUtil.nvl(""+request.getServerPort(),"");
	String SERVER_SECURE_NM="";
	String SERVER_NORMAL_NM="";

	SERVER_NORMAL_NM="//"+SERVER_NM;

	if(!"".equals(SERVER_PORT)){
		SERVER_NORMAL_NM=SERVER_NORMAL_NM+":"+SERVER_PORT;	
	}

	if(SERVER_NM.equals("www.huation.com")){
		//SERVER_SECURE_NM="http://www.huation.com";//"https://www.huation.com"
		SERVER_SECURE_NM="//www.huation.com";//"https://www.huation.com"
	}else{
		SERVER_SECURE_NM=SERVER_NORMAL_NM;
	}
	//SERVER_SECURE_NM="http://127.0.0.1:8088";
%>