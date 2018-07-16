package controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import dao.*;
import dto.*;

/**
 * Servlet implementation class SearchNServlet
 */
@WebServlet("/SearchStockNServlet")
public class SearchStockNServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchStockNServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		/* 入力チェック */
		HttpSession session = request.getSession();
		session.removeAttribute("stockdto");

		Customer customer = (Customer) session.getAttribute("cusdto");

		if (customer == null) {
			response.getWriter().println(
					"<script>alert('セッションタイム切れました、再ログインしてください');window.location.href='Toppage1.html'</script>");
		} else {
			if (validate(request, response)) {
				List<Stock> stockdto = StockDAO.findname(request.getParameter("stockName"));
				session.setAttribute("stockdto", stockdto);
				RequestDispatcher rd = request.getRequestDispatcher("SearchResultN.jsp");
				rd.forward(request, response);
			}
		}
	}

	/**
	 * @throws IOException
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	/* 入力チェックメソット */
	private boolean validate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean result = false;
		String stockName = request.getParameter("stockName");

		if (stockName.isEmpty() || stockName.length() > 50) {
			JOptionPane.showMessageDialog(null, "銘柄名に５０桁以内入力してください");
			response.sendRedirect("SearchStockN.html");
			return result;
		} else {
			result = true;
			return result;
		}
	}

	/*
	 * public static boolean isRight(String str) { for (int i = str.length(); --i >=
	 * 0;) { if ((!Character.isDigit(str.charAt(i))and(!)and(!)) { return false; } }
	 * return true; }
	 */

}
