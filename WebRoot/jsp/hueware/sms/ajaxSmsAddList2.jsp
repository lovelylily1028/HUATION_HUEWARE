<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Map model = (Map)request.getAttribute("MODEL"); 

ArrayList<SmsGroupDTO> smslist = (ArrayList)model.get("smsList");
String retVal = (String)model.get("retVal");
String retVal2 = (String)model.get("retVal2");
%>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9�� ������ -->
<title>�׷캰 ����Ȳ</title>
<script  type="text/javascript">
</script>
</head>
<body>
							<table  class="tbl_type tbl_type_list">
											
									
											<colgroup>
												<col width="35px" />
												<col width="200px" />
												<col width="160px" />
												<col width="160px" />
												<col width="*" />
											</colgroup>
											<tbody >				
								<%
									if(smslist.size() > 0){
										for(int j=0; j < smslist.size(); j++ ){	
											SmsGroupDTO dto = smslist.get(j);
											%>
											<tr>
												 <input type="hidden" id="seqs"name="seqs" >
												<input type="hidden" value="<%=dto.getUserName() %>" id="names"name="names" > 
												<td><input type="checkbox" name="checkbox" id="checkbox" value="<%=dto.getPhoneNumber()+'|'+dto.getUserName()%>" type="checkbox" class="check md0" title="����" /></td>
												<td><%=dto.getSmsGroupName()%></td>
												<td><%=dto.getUserName()%></td>
												<td><%=dto.getPhoneNumber()%></td>
												<td><%=dto.getOfficeTellNo2()%></td>
												<%-- <td>
												<a href="javascript:goModifyForm('<%=dto.getIndex()%>')" class="btn_type03"><span>����</span>
												</td> --%>
											</tr>
											<%
										}
									}
									%>
							</tbody>					
							</table>
							</body>
</html>