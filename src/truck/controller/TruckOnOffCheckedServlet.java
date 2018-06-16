package truck.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import truck.service.TruckService;

/**
 * Servlet implementation class TruckOnOffCheckedServlet
 */
@WebServlet(urlPatterns="/truckOnOff")
public class TruckOnOffCheckedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TruckOnOffCheckedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String truckStatus=request.getParameter("onoffswitch");
		int truckPk=Integer.parseInt(request.getParameter("truckPk"));
		System.out.println("onoffswitch"+truckStatus);
		
		int result=new TruckService().updateTruckStatus(truckStatus,truckPk);
		System.out.println("영업업테이트:"+result);
		String msg="영업종료";
		if(truckStatus.equals("t")){
			msg="영업시작";
		}
		
		JSONObject obj= new JSONObject();
		obj.put("truckStatus", msg);
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().println(obj);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
