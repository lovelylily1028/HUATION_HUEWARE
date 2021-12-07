<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt");
	
	String position = "-";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계정 관리</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">

	//스트라이프 테이블
	$(function(){
		$("tr:nth-child(odd)").addClass("odd");
		$("tr:nth-child(even)").addClass("even");
		
		//마우스오버로 행에 하이라이트효과
		$("tr:not(:first-child)").mouseover(function(){
			$(this).addClass("hover");
		}).mouseout(function(){
			$(this).removeClass("hover");
		});
	});

	var observerkey=false;//처리중여부
	var openWin=0;//팝업객체
	
	var  formObj;//form 객체선언
	
	//초기세팅
	function inits() {
		
		formObj=document.UserForm; //form객체세팅

		searchInit(); //조회옵션 초기화
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //처리중 메세지 비활성화
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	}
	
	//조회옵션 초기값	
	function searchInit(){
	
		 formObj.searchGb.value='<%=searchGb%>';
		 formObj.searchtxt.value='<%=searchtxt%>';
	
		searchChk();
		
	}
	
	//조회옵션 체크	
	function searchChk(){
	
		if( formObj.searchGb[0].selected==true){
			 formObj.searchtxt.disabled=true;
			 formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}
	
	//검색
	function goSearch() {
	
		var gubun= formObj.searchGb.value;
		var invalid = ' ';	//공백 체크
	
		if(gubun=='1'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('사용자 이름을 입력해 주세요');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='2'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('사용자 ID를 입력해 주세요');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='3'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('팩스번호를 입력해 주세요');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='4'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('전화번호를 입력해 주세요');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='5'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('그룹ID를 입력해 주세요');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}
		
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userPageList";
		 if(observerkey==true){return;}
		 openWaiting( );
		 formObj.curPage.value='1';
		 formObj.submit();
	}
	
	//수정 팝업
	function goDetail(ID){
		var url = "<%=request.getContextPath()%>/B_User.do?cmd=userModifyForm";
		var params = "&ID=" + ID;
	
		if(openWin != 0) {
			  openWin.close();
		}
		
		openWin=window.open(url + params, "", "width=806, height=735, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
		
	}
	
	//등록 팝업
	function goRegist() {
		if(openWin != 0) {
			  openWin.close();
		}
		openWin=window.open("<%=request.getContextPath()%>/B_User.do?cmd=userRegistForm","","width=806, height=613, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
	}
	
	//체크박스 전체 선택
	function fnCheckAll(objCheck) {
		  var arrCheck = document.getElementsByName('checkbox');
		  
		  for(var i=0; i<arrCheck.length; i++){
		  	if(objCheck.checked) {
		    	arrCheck[i].checked = true;
		    } else {
		    	arrCheck[i].checked = false;
		    }
		 }
	}
	
	//체크 박스 선택 삭제(다건/단건) 
	function goDelete(){

		var checkYN;
		//var checks=0;
		if( formObj.seqs.length>1){
			for(i=0;i< formObj.seqs.length;i++){
				if( formObj.checkbox[i].checked==true){
					checkYN='Y';
					//checks++;
				}else{
					checkYN='N';
				}
				 formObj.seqs[i].value=fillSpace( formObj.checkbox[i].value)+'|'+fillSpace(checkYN);
			}
		}else{
			if( formObj.checkbox.checked==true){
				checkYN='Y';
				//checks++;
			}else{
				checkYN='N';
			}
			 formObj.seqs.value=fillSpace( formObj.checkbox.value)+'|'+fillSpace(checkYN);
			
		}
		var checks = document.getElementsByName("checkbox");
		var users = new Array();
		
		for(var i = 0; i < checks.length; i++) {	
			if (checks[i].checked ){
				users.push(checks[i].ID);	//users에 push를 이용해 체크된 값을 담는다.
			}
		}
		
		if (users.length == 0){
			alert("삭제할 사용자를 선택해 주세요!")
		} else {
			if(!confirm("정말로 삭제하시겠습니까?"))
				return;
			
			 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userDeletes";
			 formObj.submit();
		}
	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userPageList";	
	}

</script>
</head>
<body onload = "inits();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
//	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  
  <%=ld.getPageScript("UserForm", "curPage", "goPage")%>
  <form method="post" name=UserForm action="<%=request.getContextPath()%>/B_User.do?cmd=userPageList">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="users" value=""/>
    <input type="hidden" name="SearchGroup" value=""/>
    
<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
 <!-- title -->
<div class="content_navi">관리 &gt; 계정관리</div>
<h3><span>계</span>정관리</h3>
<!-- //title -->
<!-- con -->
<div class="con">
<div class="conTop_area">
    <!-- search -->
    <div class="search">  
      <fieldset>
        <legend>검색</legend>
       <ul> 
       <li><select id="select" name="searchGb" title="검색조건선택" onchange="searchChk()">
			<option checked value="">전체</option>
			<option  value="1">사용자명</option>
			<option  value="2">ID</option>
			<option  value="4">전화번호</option>
		</select></li>
        
        <li><input type="text" name="searchtxt" value="<%=searchtxt%>" class="text" maxlength="100" id="textfield_search2" onkeydown="if(event.keyCode == 13)  goSearch()" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
        </ul>
      </fieldset>
      </div>     
    <!--//search -->
    <!-- Top 버튼영역 -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01"><span>등록하기</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>삭제하기</span></a></div>
	<!-- //Top 버튼영역 -->
   </div>

      <table class="tbl_type tbl_type_list" summary="계정관리리스트(선택, 사용자명, ID, 소속, 전화번호, 사용여부, 최초등록일자, 최종수정일자)">
		<colgroup>
			<col width="3%" />
			<col width="5%" />
			<col width="5%" />
			<col width="8%" />
			<col width="13%" />
			
			<col width="6%" />
			<col width="10%" />
			<col width="6%" />
			<col width="9%" />
			<col width="9%" />
			
			<col width="5%" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			
		</colgroup>
        <thead>
        <tr>
        <th><input type="checkbox" id="checkboxAll" class="check md0"  name="checkboxAll" onclick="fnCheckAll(this)"/></th>
			<th>사용자명</th>
			<th>ID</th>
			<th>사번</th>
			<th>주민번호</th>
			<th>나이(만)</th>
			<th>소속</th>
			<th>직급</th>
			<th>휴대폰번호</th>
			<th>사내직통번호</th>
			<th>사용여부</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<th>투입인력프로파일</th>
		</tr>
		</thead>
		<tbody>
        
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String HireDate ="";
                    	
                    	if(ds.getString("HireDateTime").equals("")){
                    		HireDate ="";
                    	}else{
                    		HireDate = ds.getString("HireDateTime").substring(0,10);
                    	}
            %>
        <tr>
          <input type="hidden" name="seqs" >
          <td><input type="checkbox" name="checkbox" value="<%=ds.getString("UserID")%>" /></td>
          <td><a href="#none" onclick="goDetail('<%=ds.getString("UserID")%>');"><%=ds.getString("UserName")%></a></td>
          <td><%=ds.getString("UserID")%></td>
          <td><%=ds.getString("EmployeeNum")%></td>
          <td><%=ds.getString("jumin1").equals("-")?ds.getString("jumin1"):ds.getString("jumin1")+"******"%></td>
          <td><%=ds.getString("jumin2")%></td>
          <td><%=ds.getString("GroupName")%></td>
          <td>
          <%
         		if(ds.getString("Position").equals("A")) {
          			position = "대표이사";
          		} else if(ds.getString("Position").equals("B")) {
          			position = "이사";
          		} else if(ds.getString("Position").equals("C")) {
          			position = "그룹리더";
          		} else if(ds.getString("Position").equals("D")) {
          			position = "팀리더";
          		} else if(ds.getString("Position").equals("E")) {
          			position = "매니저";
          		} else if(ds.getString("Position").equals("F")) {
          			position = "사원";
          		} else if(ds.getString("Position").equals("G")) {
          			position = "인턴";
          		} else if(ds.getString("Position").equals("6")) {
          			position = "기타";
          		}
          %>
          <%=position %>
          </td>
          <td><%=ds.getString("OfficeTellNoFormat")%></td>
          <td><%=ds.getString("OfficeTellNoFormat2")%></td>
          <td><%=ds.getString("UseYN")%></td>
          <td><%=HireDate%></td>
          <td><%=ds.getString("FireDateTime") %></td>
                    <td><%
                   String BoardFile=ds.getString("BoardFile");
          		   String BoardFileNm=ds.getString("BoardFileNm");
          
                    
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
                   String serverUrl = "";// + request.getServerName() + request.getContextPath();
                    int c_index=BoardFile.lastIndexOf("/");
                  	
                    String boardfilename=BoardFile.substring(c_index+1);
              
                    String boardpath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!BoardFile.equals("")){
                    	boardpath=BoardFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(BoardFileNm.indexOf("&") != -1){
                    		spStrReplace=  BoardFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  BoardFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                 %>
           
            <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=boardfilename%>&filePath=<%=boardpath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" title="투입인력프로파일"></a>
            	<%
                     }
               
                %>
       </td>
       
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="11">게시물이 없습니다.</td>
        </tr>
        <%
                }
            %>
            </tbody>
      </table>
<!-- paginate -->
<div class="paging">
<%=ld.getPagging("goPage")%>
</div>
<!-- //paginate -->
<!-- Bottom 버튼영역 -->
<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01"><span>등록하기</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>삭제하기</span></a></div>
    </div>
    <!-- //con -->

  
</div>
<!-- //contents -->
</div>
<!-- //container -->
 </form>

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"60") %>