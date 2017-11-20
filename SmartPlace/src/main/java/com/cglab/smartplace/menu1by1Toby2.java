package com.cglab.smartplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cglab.smartplace.AllData; // Data 객체 입력 부분 추가

/**
 * Servlet implementation class menu1by1Toby2
 */
public class menu1by1Toby2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by1Toby2() {
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
		response.setCharacterEncoding("euc-kr");
		AllData AD = new AllData(); // AllData 객체 생성
		
		PrintWriter out = response.getWriter();
		
		AD.today_issue = request.getParameter("issue"); // issue 값을 입력받아 AllData 객체의 today_issue 변수에 초기화
		//AD.setTodayIssue(request.getParameter("issue")); // issue 값을 입력받아 AllData 객체의 today_issue 변수에 초기화
		//out.println(AD.getTodayIssue());
		//response.sendRedirect("menu1by2.jsp");
		// today_issue에 데이터가 있으면 실행
		
		if(AD.today_issue == null || AD.today_issue.equals("")) {
			out.println("<script>");
			out.println("alert(금일 예정사 사항을 입력하세요.)");
			out.println("history.go(-1)"); //이전 페이지 이동
			out.println("</script>");
			response.sendRedirect("menu1by1.jsp"); //로그인 실패 시 index.jsp 이동
		
		} else {
			response.sendRedirect("menu1by2.jsp");
		}
	}
}
