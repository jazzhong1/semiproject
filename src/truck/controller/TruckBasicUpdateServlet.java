package truck.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.oreilly.servlet.MultipartRequest;
import com.sun.xml.internal.ws.util.StringUtils;

import common.MyFileRenamePolicy;
import truck.service.TruckService;
import truck.vo.Truck;

/**
 * Servlet implementation class TruckBasicInsertServlet
 */
@WebServlet("/truckBasicUpdate")
public class TruckBasicUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TruckBasicUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		  request.setCharacterEncoding("UTF-8");
		  response.setCharacterEncoding("UTF-8");
		
		  
		  if(!ServletFileUpload.isMultipartContent(request)) {// 파일 불러오기 실패시
		         request.setAttribute("msg", "사진을불러올수없습니다[관리자에 문의하세요]");
		         request.setAttribute("loc", "/");
		         request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);   
		      }
		  
		  
		  String saveDir = getServletContext().getRealPath("/") + "/images" + File.separator +"truck";
	     
		  int maxSize = 1024*1024*10;
	      MultipartRequest mpr =new MultipartRequest(request, saveDir, maxSize,"UTF-8", new MyFileRenamePolicy());
	      int truckPk = Integer.parseInt(mpr.getParameter("truck-pk"));
	      Truck truck = new TruckService().selectOne(truckPk);
	      
	      
	      String CheckDetail = mpr.getParameter("truck-name");
	      System.out.println("CheckDetail : "+CheckDetail);
	   
	      
	      int result = 0;// 업데이트 결과값 수신
	      String view = "/";
	     
	      if (CheckDetail.equals("detail")) { // 디테일단에서 폼 전송했을시
	   
	         
	         truck.setTruckHoliday(mpr.getParameter("truck-holiday"));
	         truck.setTrucklocation(mpr.getParameter("truck-address"));
	         
	         try {
	        	 Date date = (Date) new SimpleDateFormat("HH:mm").parse(mpr.getParameter("truck-open-date")); 
	             Date date2 = (Date) new SimpleDateFormat("HH:mm").parse(mpr.getParameter("truck-close-date"));
	             Date sqldate = new Date( date.getTime());
	          
	             System.out.println(sqldate);
	            truck.setTruckOpenTime(sqldate);
	           Date sqldate2 = new Date( date2.getTime());
	            truck.setTruckCloseTime(sqldate2);
	         } catch (ParseException e) {
	            e.printStackTrace();
	         }
	            
	         truck.setLatitude(Double.parseDouble(mpr.getParameter("truck-latitude")));
	         truck.setLogitude(Double.parseDouble(mpr.getParameter("truck-logitude")));
	         result = new TruckService().updateTruck(truck);
	      } 
	      
	      
	      else { // 베이직 단에서 폼 전송시
	         
	         truck.setTruckName(mpr.getParameter("truck-name"));
	         truck.setTruckOriginalImage(mpr.getOriginalFileName("truck-img"));
	         truck.setTruckRenameImage(mpr.getFilesystemName("truck-img"));
	         truck.setTruckContent(mpr.getParameter("truck-content"));
	         truck.setTruckPrice(Integer.parseInt(mpr.getParameter("min-price")));
	         result = new TruckService().updateTruck(truck);
	      }
	      if(result>0) {
	         view ="/views/truck/truckChoice.jsp";
	         request.setAttribute("truck",truck);
	         request.setAttribute("truckChoice", "truckChoiceMenu");
	      }else {
	            view = "/views/common/msg.jsp";
	            request.setAttribute("msg", "입력 오류입니다. [관리자에게 문의 error : updateTruck]");
	            request.setAttribute("loc", "/");
	         }
	      request.getRequestDispatcher(view).forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}