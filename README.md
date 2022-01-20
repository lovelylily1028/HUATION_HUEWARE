# HUATION_HUEWARE
### 개요
  * 본 HUEWARE 프로젝트는 휴에이션 사내 웹서버 페이지에 **휴페업조회** 메뉴 항목을 추가 및 개선개발 과정을 작성하기 위하여 업로드 되었습니다.
  ***
### 최초 설정 방법
  * MASTER을 COMMIT한 2021-12-17 기준 톰캣 8.5 사용
  * tomcat의 [catalina.properties] 최하단 부분에 아래 코드 추가 - 이 부분은 해당 프로젝트를 압축파일로 받았을 경우, 압축파일이 풀려져 있는 원본의 위치입니다.
```  
   framework_ware.home = C:/Devtools/WORKSPACE/HUATION_HUEWARE/HUEWARE/WebRoot/WEB-INF
```   
  * tomcat의 [contest.xml] 파일에 MSSQL DB사용을 위한 ResourceLink 추가
```
   <ResourceLink name="jdbc/hueware" global="jdbc/hueware" type="javax.sql.DataSource"/>
```    
  * tomcat의 [server.xml] 파일 수정 - 위 코드를 아래코드로 변경
```
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443">
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" secretRequired="false">
```
  * tomcat의 [server.xml] 파일의 **GlobalNamingResoures** 안에 MSSQL DB 사용을 위한 아래 코드 추가
```
     <Resource auth="Container" driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver" 
     maxActive="100" maxIdle="20" maxWait="-1" name="jdbc/hueware" password="huation@2100" 
     type="javax.sql.DataSource" url="jdbc:sqlserver://192.168.2.82:1433;databaseName=HUEWARE"
     username="Hueware" validationQuery="SELECT 1"/>
```
***
 #### 해당부분까지 마치고 난뒤에 예상 오류 
  *  JAVA COMPIILER 버전이 맞지 않는다는 오류는 프로젝트의 Properties - [Java Compiler] - [Compiler compliance level]을 사용하고 있는 자바 버전과 맞춰주시면 됩니다.
 
