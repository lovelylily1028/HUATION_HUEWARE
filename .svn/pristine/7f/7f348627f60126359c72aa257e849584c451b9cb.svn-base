package com.huation.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.huation.framework.util.FileUtil;
import com.huation.framework.util.StringUtil;

public class fileDownServlet  extends HttpServlet {
    
	/**
	* @brief  브라우저 체크 메서드
	* @author shbyeon 2012-01-10
	* @param  request
	* @return
	*/
	public static String getBrowser(HttpServletRequest request) {
	 
	        String header = request.getHeader("User-Agent");
	        
	        System.out.println("Browser Header:"+header);

	        
	        //IE 11 부터 header 추출 시 MSIE 값을 가져오지 않으므로
	        //Trident/Version으로 비교하는 부분을 추가함.
	        //4.0 = >IE8
	        //5.0 = >IE9
	        //6.0 = >IE10
	        //7.0 = >IE11
	        if ( header.indexOf("MSIE") > -1 || header.indexOf("Trident/7.0") > -1 || header.indexOf("Trident/6.0") > -1 || header.indexOf("Trident/5.0") > -1 || header.indexOf("Trident/4.0") > -1 ) {
	 
	            return "MSIE";
	 
	        } else if ( header.indexOf("Chrome") > -1) {
	 
	            return "Chrome";
	 
	        } else if ( header.indexOf("Opera") > -1) {
	 
	            return "Opera";
	 
	        } else if ( header.indexOf("Safari") > -1) {
	 
	        return "Safari";
	 
	        }
	 
	        return "Firefox";
	 
	}
	//다운로드 Encoding
	public void doGet(HttpServletRequest req,HttpServletResponse resp)
    throws ServletException, IOException {
			
	String rFileName = StringUtil.nvl(req.getParameter("rFileName")); //실제 한글파일명
	String sFileName = StringUtil.nvl(req.getParameter("sFileName")); //실제 파일이름
	String filePath = StringUtil.nvl(req.getParameter("filePath")); //실제 파일경로
	
	//jsp 페이지 에서 받은 rFileName(파일명) 특수문자중 [replaceStr] - > 다시 원 파일명 에 존재하던 & 값으로 치환.
	//Description:[replaceStr] 값이 있을 경우 아래 조건 문 실행 됨.
	
	if(rFileName.indexOf("[replaceStr]") != -1){
		rFileName = rFileName.replace("[replaceStr]", "&")	;
		System.out.println("rFileName 파일명에 [replaceStr] 존재하므로 치환 실행 하였음.");
	}else{
		System.out.println("rFileName 파일명에 & 존재 하지않으므로 실행하지 않음.");
	}
	
	
	
    try
    {
         String browser =getBrowser(req); //브라우저 판별 메소드 (Header값 request받아옴.)
         
         System.out.println("Now Browser:"+browser);
      
      // Explorer
      if(browser.indexOf("MSIE") != -1){	 
        File file		=	new File(FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("##################################Upload File Path:"+FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("실제 한글 파일 명: "+rFileName);

        String encodeFile = URLEncoder.encode(rFileName,"UTF-8");
        System.out.println("인코딩 된 파일 명: "+encodeFile);
         
        
        FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile.replaceAll("\\+", "%20") + "\"" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ rFileName + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }
        
    // Safari    
	}else if(browser.indexOf("Safari") != -1){
		File file		=	new File(FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("##################################Upload File Path:"+FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("실제 한글 파일 명: "+rFileName);

        String encodeFile = rFileName;
        
        encodeFile = new String(rFileName.getBytes("UTF-8"), "ISO-8859-1");        
        System.out.println("인코딩 된 파일명: "+encodeFile);
         
        
        FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile.replaceAll("\\+", "%20") + "\"" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }
        
    // Chrome    
	}else if(browser.indexOf("Chrome") != -1){
		File file		=	new File(FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("##################################Upload File Path:"+FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("실제 한글 파일 명: "+rFileName);

        String encodeFile = rFileName;
        
        encodeFile = new String(rFileName.getBytes("UTF-8"), "ISO-8859-1");       
        String  encodeFile2 = URLEncoder.encode(rFileName, "euc-kr").replaceAll("\\+", "%20");
        String  encodeFile3 = new String(rFileName.getBytes("UTF-8"), "ISO-8859-1");  

        System.out.println("인코딩 된 파일명: "+encodeFile);
        System.out.println("인코딩 된 파일명: "+encodeFile2);
        System.out.println("인코딩 된 파일명: "+encodeFile3);
         
        FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile.replaceAll("\\+", "%20") + "\"" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }
        
    // Opera    
	}else if(browser.indexOf("Opera") != -1){
		File file		=	new File(FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("##################################Upload File Path:"+FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("실제 한글 파일 명: "+rFileName);

        String encodeFile = rFileName;
        
        encodeFile = new String(rFileName.getBytes("UTF-8"), "ISO-8859-1");        
        System.out.println("인코딩 된 파일명: "+encodeFile);
         
        FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile.replaceAll("\\+", "%20") + "\"" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }
        
    // Firefox    
	}else if(browser.indexOf("Firefox") != -1){
		File file		=	new File(FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("##################################Upload File Path:"+FileUtil.UPLOAD_PATH +filePath+"/"+sFileName);
        System.out.println("실제 한글 파일 명: "+rFileName);

        String encodeFile = rFileName;
        
        encodeFile = new String(rFileName.getBytes("UTF-8"), "ISO-8859-1");        
        System.out.println("인코딩 된 파일명: "+encodeFile);
         
        FileInputStream in = null;
        
        try {
            in = new FileInputStream(file);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
         
        resp.setContentType( "application/x-msdownload" );
        //resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile.replaceAll("\\+", "%20") + "\"" );
        resp.setHeader( "Content-Disposition", "attachment; filename=\""+ encodeFile + "\"" );
        resp.setHeader( "Content-Transfer-Coding", "binary" );

        ServletOutputStream binaryOut = resp.getOutputStream();
        byte b[] = new byte[1024];
         
        try {
            int nRead;
            do {
                nRead = in.read( b );
                binaryOut.write( b, 0, nRead );
            } while ( nRead == 1024 );

        } catch ( Exception e ) {

        } finally {
            if ( in != null )
                in.close();
            if(binaryOut != null){
            	binaryOut.close();
            }
        }
	}
      
    }catch(Exception e)
    {
    	e.printStackTrace();
    }

}
}