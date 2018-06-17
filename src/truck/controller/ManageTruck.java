package truck.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.vo.Member;
import truck.service.TruckService;
import truck.vo.Truck;

/**
 * Servlet implementation class ManageTruck
 */
@WebServlet(urlPatterns="/managetruck")
public class ManageTruck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManageTruck() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(); // 유지되어 있는 세션이 있으면 가져오고 없으면 null값을 리턴한다.
		Truck truck = null;
	
		if (session != null) {// 세션이 존재할때 (점주가 접근)
			Member member = (Member)session.getAttribute("memberLoggedIn");
			System.out.println("member :  "+member);
			int memberPk = member.getMemberPk();
			truck = new TruckService().manageTruck(memberPk);
			System.out.println(truck);
		}
		
		String view = "/";
		
	
		String truckChoice="truckMenuUpdate";
		System.out.println(truckChoice);
		
		String temp=request.getParameter("truckChoice");
		if(temp!=null){
			truckChoice=temp;
		}
		
		if (truck == null) {
			view = "/views/common/msg.jsp";
			String msg = "오류가 발생했습니다. 다시 시도해보시고 \n 관리자에게 문의해주세요 [점주접근오류:managetruck]";
			String loc = "/";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
		} 
		
		else {
			view = "views/truck/managetruck.jsp";
			request.setAttribute("truck", truck);
			request.setAttribute("truckChoice", truckChoice);

		}
		request.getRequestDispatcher(view).forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}