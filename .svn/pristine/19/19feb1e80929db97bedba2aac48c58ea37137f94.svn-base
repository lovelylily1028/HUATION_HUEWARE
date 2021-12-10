<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	//String curPage = (String)model.get("curPage"); 현재 페이징사용안함.
	String searchGbYear = (String)model.get("searchGbYear"); //검색구분(년도)
	String searchGb = (String)model.get("searchGb");		 //검색구분(영업상태)
	String searchGb2 = (String)model.get("searchGb2");		 //검색구분(목록)
	String searchtxt = (String)model.get("searchtxt");		 //검색명


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>영업진행현황 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">

	var  formObj; //form 객체선언
	//초기세팅
	function initcurrent() {
		
		formObj=document.currentPageListForm; //form객체세팅
		
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
		 
		 formObj.searchGbYear.value='<%=searchGbYear%>';
		 formObj.searchGb.value='<%=searchGb%>';
		 formObj.searchGb2.value='<%=searchGb2%>';
		 formObj.searchtxt.value='<%=searchtxt%>';
		
		 searchChk();
		
	}

	//조회옵션 체크	
	function searchChk(){
		
		
		if( formObj.searchGb2[0].selected==true){
			formObj.searchtxt.disabled=true;
			formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}
	
	//검색
	function goSearch() {
		
		var gubun= formObj.searchGb2.value;
		
		if(gubun=='1'){
			if(formObj.searchtxt.value==''){
				alert('영업주관사 명을 입력해주세요.');
				return;
			}
		}else if(gubun=='2'){
			if(formObj.searchtxt.value==''){
				alert('예상 프로젝트 명을 입력해주세요.');
				return;
			}
		}else if(gubun=='3'){
			if(formObj.searchtxt.value==''){
				alert('견적번호를 입력해주세요.');
				return;
			}
		}else if(gubun=='4'){
			if(formObj.searchtxt.value==''){
				alert('모발행번호를 입력해주세요.');
				return;
			}
		}
		openWaiting();
		formObj.submit();
	}


	// 등록 폼으로 이동
	function goRegist(){
		formObj.target ='_self';							
		formObj.action = "<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaRegistForm";
		formObj.submit();
	}
	
	// 상세페이지 이동
	function goDetail(PreSalesCode,PublicNo){
		
		 formObj.target ='_self';
		 formObj.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaView";
		 formObj.PreSalesCode.value=PreSalesCode;
		 formObj.PublicNo.value=PublicNo;
		 formObj.submit();
	}
	
	//Excel Export(엑셀 내려받기)
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaExcel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList";	
	}
	//-->
</script>
</head>
<body onload="initcurrent()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
	
	<!-- title -->
	<div class="content_navi">영업지원 &gt; 영업진행현황</div>
	<h3><span>영</span>업진행현황</h3>
	<!-- title -->
			
	<div class="con currentStaPageList">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
	
			<%
				//1분기 리스트
				ListDTO ld = (ListDTO) model.get("listInfo");
			//	UserDTO userDto = (UserDTO) model.get("totalInfo");
				DataSet ds = (DataSet) ld.getItemList();
				
				int iTotCnt = ld.getTotalItemCount();
				int iCurPage = ld.getCurrentPage();
				int iDispLine = ld.getListScale();
				int startNum = ld.getStartPageNum();
				
			%>
		  
			<form method="post" class="search" name="currentPageListForm" action="<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList">
			<!-- 이슈 코멘트 PK 
			<input type="hidden" name="SeqRep" value=""></input>
			 -->
			<!-- 영업진행현황 PK -->
			<input type="hidden" name="PreSalesCode" value=""></input>
			<!-- 견적서 매핑 PK -->
			<input type="hidden" name="PublicNo" value=""></input>
		   
			<!-- 조회 -->
			<fieldset>
				<legend>검색</legend>
				<ul>
					<li>
					<script>
					document.write("<select name='searchGbYear' id='' title='년도 선택' style='width:70px'>");
					document.write("<option checked value=''>전체</option>");
					var now = new Date();  
					var now_year = now.getFullYear() +5; //+1은 올해년도에서 +1년 한것. 
					for (var i=now_year;i>=2010;i--) 
					{     
					document.write("<option value='"+i+"'>"+i+"</option>"); 
					}  
					document.write(" </select>"); 
					</script>
					</li>
		       
					<!-- 
					<input type="hidden" name="DateProjections" value="2013"></input>
					-->
		      
					<li><select name="searchGb">
						<option checked value="" >전체</option>
						<option value="Y"  >계약</option>
						<option value="N"  >미계약</option>
					</select></li>
		        
					<li><select name="searchGb2" onchange="searchChk()" id="" class="">
						<option checked value="">전체</option>
						<option value="1">영업주관사 명 </option>
						<option value="2">예상 프로젝트명</option>
						<option value="3">견적번호</option>
						<option value="4">모발행번호</option>
					</select></li>
									
					<li><input type="text" name="searchtxt" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" class="text" title="검색어" id="" /></li>
					<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
		
				</ul>
			</fieldset>
			</form>
			<!-- //조회 -->
							
			<!-- Top 버튼영역 -->
			<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
			<!-- //Top 버튼영역 -->
	
		</div>
		<!-- //컨텐츠 상단 영역 -->

	
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="영업진행현황(영업주관사, 상품코드, 고객사, 영업주관사담당자, 예상프로젝트명, 예상수주액(VAT별도), 견적번호, 모발행번호, 견적서파일, 수주가능성, 담당영업, 예상시기, 수주상태, 기술분야배정인력)">
			<colgroup>
				<col width="3%" />
				<col width="3%" />
				<col width="12%" />
				<col width="12%" />
				<col width="*" />
				<col width="12%" />
				<col width="8%" />
				<col width="5%" />
				<col width="7.3%" />
				<col width="7.3%" />
				<col width="5%" />
				<col width="4%" />
				<col width="8.4%" />
			</colgroup>       

			<thead>
			<!-- 
			<tr>
				<th colspan="13" class="title" id="FirstYear"></th>
			</tr>
			 -->
					
			<tr>
				<th rowspan="2">Q</th>
				<th rowspan="2">No.</th>
				<th>영업주관사</th>
				<th>고객사</th>
				<th rowspan="2">예상프로젝트명</th>
				<th rowspan="2">예상수주액(VAT별도)</th>
				<th>견적번호</th>
				<th rowspan="2">견적서파일</th>
				<th colspan="2">수주가능성</th>
				<th rowspan="2">예상시기</th>
				<th rowspan="2">수주상태</th>
				<th rowspan="2">기술분야배정인력</th>
			</tr>
	
			<tr>
				<th>상품코드</th>
				<th>영업주관사담당자</th>
				<th>모발행번호</th>
				<th colspan="2">담당영업</th>
			</tr>
			</thead>
	
			<tbody>
			<!--리스트---------------->
			<!-- :: loop :: -->
			<%
				int rows1 = 2; //분기별 총 갯수로 인해 늘어나는 Rowspan 값.
	        	int totalQ = 0; //분기별로 인해 생성되는 1,2,3,4Sub Total 칼럼
	        	int totalQN = 0;
	        	int totalY = 0; //년도별로 인해 생성되는 마지막 Row 데이터의 4분기(ex:12월일때 생성되는) Annual Total 칼럼
	        	int totalYC = 0; //년도별로 인해 생성되는 마지막 Row 데이터의 4분기(ex:12월일때 생성되는) Annual Total 칼럼
	        	int nn1 = 1; //Q rowspan
	        	int pList=1; //년도별로 생기는 첫번째 칼럼 생성을 위해 쓰는 변수.
	        	
		     	
	                if (ld.getItemCount() > 0) {
	                    int i = 0;
	                    while (ds.next()) {
	                    	
	                    	String Q = ds.getString("Quarter"); 
	                    	int totalCntQN = ds.getInt("totalCountQ"); //년도+분기별총 카운트 Sub Total 칼럼에 사용.
							int qc = ds.getInt("totalCountQ");
	            	        totalQ++;
	            	        totalY++;
	            	        totalYC++;
	            	        totalQN++;
	            	        
	            	 
	            	
	            	        
			%>
	        <%
	        	//수주상태 1,2,3(Y계약,N미계약)
		     	String fColor = "";
		     	String status = ds.getString("OrderStatus");
		     	if(status.equals("Y")){
	        		
	        		status="계약";
	        	}else if(status.equals("N")){
	        		fColor="txtColor_contractNo";
	        		status="미계약";
	        	}
	        %>		
	        
	        <tr class="<%=fColor%>">
			<!-- 분기별 리스트 1Q 시작-->
		
	        <%
	        if(Q.equals("1")){      	
	        %>
	        	<th rowspan="2">1Q</th>
	        <%
	        }if(Q.equals("2")){        	
	        %>
	        	<th rowspan="2">2Q</th> 
	        <%
	        }if(Q.equals("3")){        	
	        %>
				<th rowspan="2">3Q</th>
	        <%
	        }if(Q.equals("4")){        	
	        %>
				<th rowspan="2">4Q</th>
	        <%
	        }
	        %>
       			
		     	<td rowspan="2"><%=nn1++ %></td>     
		     	<td title="<%=ds.getString("EnterpriseNm") %>"><span class="ellipsis"><%=ds.getString("EnterpriseNm") %></span></td>
		     	<td title="<%=ds.getString("OperatingCompany") %>"><span class="ellipsis"><%=ds.getString("OperatingCompany") %></span></td>
		     	<td rowspan="2" title="<%=ds.getString("ProjectName") %>" class="text_l"><span class="ellipsis"><strong><a href="javascript:goDetail('<%=ds.getString("PreSalesCode")%>','<%=ds.getString("PublicNo") %>')"><%=ds.getString("ProjectName") %></a></strong></span></td>
		     	<td rowspan="2" class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SalesProjections"))%>원</td>
		     														
		     	<td><%=ds.getString("PublicNo") %></td> <!-- 견적번호(견적번호 매번 최근 견적번호로 UPDATE된다). -->
		     	
				<td rowspan="2">
		     	<%
		     	//2013_04_26(금)shbyeon.
		     	//견적서 발행에서 엑셀,PDF 파일 첨부 & 수정시 나오게될 LIST
		     	//수정할때마다 새로운 첨부 파일로 UPDATE 된다.
		     		String SalesFile_Xls=ds.getString("SalesFile_Xls");
		     		String SalesFileNm_Xls=ds.getString("SalesFileNm_Xls");
		     		String SalesFile_Pdf = ds.getString("SalesFile_Pdf");
		     		String SalesFileNm_Pdf = ds.getString("SalesFileNm_Pdf");
// 		     		String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
		     		//String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
		     		String serverUrl = "" + request.getContextPath();
	     			int x_index=SalesFile_Xls.lastIndexOf("/"); //엑셀파일
	     			int p_index=SalesFile_Pdf.lastIndexOf("/"); //PDF파일
	     			
	     			String sales_xls_filename=SalesFile_Xls.substring(x_index+1);
	     			System.out.println("xlsName:"+sales_xls_filename);
	     			String sales_pdf_filename=SalesFile_Pdf.substring(p_index+1);
	     			
	     			String sales_xls_path="";
	     			String sales_pdf_path="";
	     			
	     			if(!SalesFile_Xls.equals("")){
	     				sales_xls_path=SalesFile_Xls.substring(0,x_index); //파일경로 읽어오기
	     			if(SalesFileNm_Xls.equals("")){
		     						
					%>
					<!-- 엑셀파일명이 존재하지 않을 경우(기존 견적서발행에서의 파일이름없는 데이터 가져올때) -->
					<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=sales_xls_filename%>&sFileName=<%=sales_xls_filename%>&filePath=<%=sales_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
					<%
						}else if(!SalesFileNm_Xls.equals("")){
						//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
						//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
						String spStrReplace = "";
						if(SalesFileNm_Xls.indexOf("&") != -1){
							spStrReplace=  SalesFileNm_Xls.replace("&", "[replaceStr]");
							System.out.println("spStrReplace:"+spStrReplace);
						}else{
							spStrReplace =  SalesFileNm_Xls;
							System.out.println("spStrReplace:"+spStrReplace) ;
						}
					%>
					<!-- 엑셀파일명이 존재하지 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
					<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=sales_xls_filename%>&filePath=<%=sales_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
					<%
					}
		     		%>
		     		<%
		     		}
		     		%>
		     		<%
		     			if(!SalesFile_Pdf.equals("")){
		     				sales_pdf_path=SalesFile_Pdf.substring(0,p_index); //파일경로 읽어오기
		     		%>
		     		<%
		     			if(SalesFileNm_Pdf.equals("")){
		    	    %>
		    	    <!-- PDF파일명이 존재하지 않을 경우(기존 견적서발행에서의 파일이름없는 데이터 가져올때) -->
		    	    <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=sales_pdf_filename%>&sFileName=<%=sales_pdf_filename%>&filePath=<%=sales_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
		    	    <%
		    	    	}else if(!SalesFileNm_Pdf.equals("")){
		    	    		//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
		    	    		//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
		    	    		String spStrReplace = "";
		    	    		if(SalesFileNm_Pdf.indexOf("&") != -1){
		    	    			spStrReplace=  SalesFileNm_Pdf.replace("&", "[replaceStr]");
		    	    			System.out.println("spStrReplace:"+spStrReplace);
		    	    		}else{
		    	    			spStrReplace =  SalesFileNm_Pdf;
		    	    			System.out.println("spStrReplace:"+spStrReplace) ;
		    	    		}
		    	    %>
		    	    <!-- PDF파일명이 존재하지 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
		    	    <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=sales_pdf_filename%>&filePath=<%=sales_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
		    	    <%
		    	    }
		     		%>
		     		<%
		     		}
		     		%>
				</td>
				<td colspan="2"><strong><%=ds.getString("OrderbleNm") %></strong></td>
				<td rowspan="2"><%=ds.getString("DateProjections") %></td>
				<td rowspan="2"><strong><%=status%></strong></td>
				<td rowspan="2" title="<%=ds.getString("AssignPerson") %>"><span class="ellipsis"><%=ds.getString("AssignPerson") %></span></td>
			</tr>
			
			<tr class="<%=fColor%>">
				<td title="<%=ds.getString("ProductNm") %>"><span class="ellipsis"><%=ds.getString("ProductNm") %></span></td>
				<td title="<%=ds.getString("SalesMan") %>"><span class="ellipsis"><%=ds.getString("SalesMan") %></span></td>
				<td><%=ds.getString("P_PublicNo") %></td>    	
				<td>정 : <%=ds.getString("ChargeNm") %></td>
				<td>부 : <%=ds.getString("ChargeSeNm") %></td>
		     </tr>
		     
		     <%
				 
		         String Year = ds.getString("DatePjYear"); //년
		         String ycount = ds.getString("test"); //동일년도별 카운트.
		         int Mon = ds.getInt("DatePjMon"); //월
		         int Quarter = ds.getInt("Quarter"); //분기
		         int totalCntQ = ds.getInt("totalCountQ"); //년도별+분기별총 카운트 Sub Total 칼럼에 사용.
		         int totalCntY = ds.getInt("totalCountY"); //년도별 총카운트  Annual Total 칼럼에 사용.
		         int totalCntYC = ds.getInt("totalCountY"); //년도별 총카운트  Annual Total 칼럼에 사용.
		              
		         //분기별 Row 데이터 와 총 년도+분기별 카운트 비교 시 같을때 시작.
		         if(totalQ == totalCntQ){
		        	 
		     %>
		     <!-- 분기별 Sub Total(분기 총매출액) 금액 1,2,3,4 칼럼 생성 시작 -->
		     <tr  class="qTotal">
		     	<th colspan="5"><%=Quarter%>Q Sub Total</th>
		     	<td class="text_r"><strong><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceQ"))%>원</strong></td>
		     	<th colspan="7"></th>
		     </tr>
		     <%
		        	 nn1= 1; //No. 넘버 초기화
		        	 totalQ = 0; //년도별+분기별 총카운트
		         }
		     %>
			       
		     <%
				//년도별 Row 데이터 와 총 년도 카운트 비교 시 같을 때 시작.
					if(totalY == totalCntY){	
		     %>
		     <tr class="aTotal">
		     <!--해당년도 1,2,3,4 분기 중 마지막 분기 시 Annual Total(년도 총매출액) 칼럼생성 -->		
		     	<th colspan="5">Annual Total</th>
		     	<td class="text_r"><strong><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceY"))%>원</strong></td>
		     	<th colspan="7" class="aTotalYear"><strong><%=Year %>년도 영업진행현황</strong></th>
		     </tr> 
		     <%
					  totalY = 0; //년도별 총카운트
					}					
		     %>	
		     <!-- Sub Total /  Annual Total 생성 끝. -->  
		     <%
		     	//데이터 ++수와 총 년도 카운트와 같으면서 데이터LIST++수와 총 토탈카운트가 틀리면 하위 칼럼생성.
				if(totalCntYC == totalYC){
					     		
				if(pList != ld.getTotalItemCount()){
					     			
			%>
			</tbdoy>
			<thead>
			<!--
			<tr>
				<td  colspan="13" class="title" id="FirstYear"></td>
			</tr>
			-->
					
			<tr class="borderT">
				<th rowspan="2">Q</th>
				<th rowspan="2">No.</th>
				<th>영업주관사</th>
				<th>고객사</th>
				<th rowspan="2">예상프로젝트명</th>
				<th rowspan="2">예상수주액(VAT별도)</th>
				<th>견적번호</th>
				<th rowspan="2">견적서파일</th>
				<th colspan="2">수주가능성</th>
				<th rowspan="2">예상시기</th>
				<th rowspan="2">수주상태</th>
				<th rowspan="2">기술분야배정인력</th>
			</tr>
			
			<tr>
				<th>상품코드</th>
				<th>영업주관사담당자</th>
				<th>모발행번호</th>
				<th colspan="2">담당영업</th>
			</tr>
			</thead>
			<tbdoy>
			<%totalYC=0;
			    		}
			    	}
			%>
			<!-- :: loop :: -->
			<%
			           i++;
			   		pList++;
			   		 
			               }
			              
			           } else {
			%>
			<tr>
				<td colspan="13">게시물이 없습니다.</td>
			</tr>
        	<%
                }
            %> 
			</tbody>              
		</table>
      
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
		<!-- //Bottom 버튼영역 -->
    
	</div>
    <!-- //con -->
</div>
<!-- //contents -->
</div>
<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"10") %>