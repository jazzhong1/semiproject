﻿package customerFAQ.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import customerFAQ.model.service.CustomerFAQService;
import customerNotice.model.service.CustomerNoticeService;
import member.model.vo.Member;

@WebServlet("/customerFAQDelete.do")
public class CustomerFAQDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CustomerFAQDeleteServlet() {
		super();	
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 관리자가 아닐 경우 페이지 접속을 차단하는 로직
		Member memberLoggedIn = (Member) request.getSession().getAttribute("memberLoggedIn");
		if (memberLoggedIn == null || !"admin".equals(memberLoggedIn.getMemberId())) {
			request.setAttribute("msg", "관리자가 아닙니다 해당 서비스를 이용할 수 없습니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
			return;
		}

		// faq 삭제할 FAQPK가져오기
		request.setCharacterEncoding("UTF-8");
		int FAQPK = Integer.parseInt(request.getParameter("FAQPK"));

		int result = new CustomerFAQService().deleteCustomerFAQ(FAQPK);

		String msg = "";
		String loc = "/customerFAQForm.do";
		String view = "/views/common/msg.jsp";

		if (result > 0) {
			msg = "공지사항 내용 삭제 완료.";
		} else {
			msg = "공지사항 내용 삭제 실패";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(view).forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}