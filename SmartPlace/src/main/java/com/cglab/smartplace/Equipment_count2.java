package com.cglab.smartplace;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cglab.smartplace.AllData; // AllData Class 추가
/**
 * Servlet implementation class Equipment_count2
 */
public class Equipment_count2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AllData AD = new AllData();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Equipment_count2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		System.out.println("자바스크립트 호출 성공!!");
		AD.equipment_count--; //equipment_count 값을 +1 증가
		response.sendRedirect("test.jsp");
	}

}
