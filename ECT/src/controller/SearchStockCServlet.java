package controller;

import dto.*;
import dao.*;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import javax.servlet.http.*;

/**
 * Servlet implementation class SearchStockCServlet
 */
@WebServlet("/SearchStockCServlet")
public class SearchStockCServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchStockCServlet() {
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
		response.setContentType("text/html; charset=utf-8");

		HttpSession session = request.getSession();
		session.removeAttribute("stockdto");
		session.removeAttribute("pricedto");

		Customer customer = (Customer) session.getAttribute("cusdto");

		if (customer == null) {
			response.getWriter().print(
					"<script language='javascript'>alert('セッションタイム切れました、再ログインしてください');window.location.href='Toppage1.html'</script>");
		} else {

			if (validate(request, response)) {

				Stock stockdto = StockDAO.findcode(request.getParameter("stockCode"));
				if (stockdto != null) {
					Price pricedto = PriceDAO.find(stockdto.getStockCode());
					session.setAttribute("pricedto", pricedto);
					session.setAttribute("stockdto", stockdto);
				}

				RequestDispatcher rd = request.getRequestDispatcher("SearchResultD.jsp");
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
		String stockCode = request.getParameter("stockCode").trim();

		if (stockCode.isEmpty() || stockCode.length() != 4 || !isNumeric(stockCode)) {
			JOptionPane.showMessageDialog(null, "銘柄コードを四桁数字を入力してください");
			response.sendRedirect("SearchStockC.html");
			return result;
		} else {
			result = true;
			return result;
		}
	}

	public static boolean isNumeric(String str) {
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

}
