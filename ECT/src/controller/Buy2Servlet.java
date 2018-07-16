package controller;

import java.io.IOException;
import java.text.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.*;
import dto.*;

/**
 * Servlet implementation class Buy2Servlet
 */
@WebServlet("/Buy2Servlet")
public class Buy2Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Buy2Servlet() {
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
		HttpSession session = request.getSession();

		Customer customer = (Customer) session.getAttribute("cusdto");
		/* セッション時間確認 */
		if (customer == null) {
			response.getWriter().println(
					"<script>alert('セッションタイム切れました、再ログインしてください');window.location.href='Toppage1.html'</script>");
		} else {
			/* 入力チェック */
			if (validate(request, response)) {
				Order orderdto = (Order) session.getAttribute("orderdto");
				Price pricedto = (Price) session.getAttribute("pricedto");
				orderdto.setOrderPrice(pricedto.getPriceCurrent());
				int orderNumber = 0;
				float priceCurrent = PriceDAO.find(orderdto.getStockCode()).getPriceCurrent();
				/* 株価変化確認１ */
				if (priceCurrent != pricedto.getPriceCurrent()) {
					orderdto.setOrderPrice(priceCurrent);
					session.setAttribute("orderdto", orderdto);
					pricedto = PriceDAO.find(orderdto.getStockCode());
					session.setAttribute("pricedto", pricedto);
					response.getWriter().println(
							"<script>alert('当時単価変わりました、注文情報を再入力してください');window.location.href='Buy1.jsp'</script>");
				}
				/* 注文数量取得 */
				try {
					orderNumber = Integer.parseInt(request.getParameter("orderNumber"));
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				orderdto.setOrderPtype("N");

				if (!request.getParameter("orderCondition").equals("N")) {

					if (request.getParameter("orderPtype").equals("Y")) {

						try {
							float orderPriceN = Float.parseFloat(request.getParameter("orderPriceN"));
							orderdto.setOrderPrice(orderPriceN);
							orderdto.setOrderPtype("Y");
						} catch (NumberFormatException e) {
							e.printStackTrace();
						}
					}
				}

				Date date = new Date();
				DateFormat format = new SimpleDateFormat("yyyyMMdd");
				String orderDate = format.format(date);
				float orderAmount = orderdto.getOrderPrice() * orderNumber * orderdto.getStockUnit();
				/* 当日上限金額確認 １ */
				if ((orderAmount + AccountDAO.find(customer.getAccId()).getAccDtotalbuy()) > 30000000) {
					Order orderdto1 = new Order();
					orderdto1.setCusId(customer.getCusId());
					orderdto1.setStockCode(orderdto.getStockCode());
					orderdto1.setStockName(orderdto.getStockName());
					orderdto1.setStockUnit(orderdto.getStockUnit());
					orderdto1.setOrderType("B");
					orderdto1.setOrderPrice(PriceDAO.find(orderdto1.getStockCode()).getPriceCurrent());
					session.setAttribute("orderdto", orderdto1);
					response.getWriter()
							.println("<script>alert('当日購入累計金額が三千万円超えます');window.location.href='Buy1.jsp'</script>");

					/* 取引用口座残高確認１ */
				} else if (AccountDAO.find(customer.getAccId()).getAccBalance() < orderAmount) {

					Order orderdto1 = new Order();
					orderdto1.setCusId(customer.getCusId());
					orderdto1.setStockCode(orderdto.getStockCode());
					orderdto1.setStockName(orderdto.getStockName());
					orderdto1.setStockUnit(orderdto.getStockUnit());
					orderdto1.setOrderType("B");
					orderdto1.setOrderPrice(PriceDAO.find(orderdto1.getStockCode()).getPriceCurrent());
					session.setAttribute("orderdto", orderdto1);
					response.getWriter()
							.println("<script>alert('残高不足です,注文情報を再入力してください');window.location.href='Buy1.jsp'</script>");
				} else {
					int orderFee = 0;
					if (orderdto.getOrderPtype().equals("N")) {
						orderFee = 1000;
					} else {
						orderFee = 1500;
					}
					if (orderdto.getOrderAmount() > 1000000) {
						int amount = (int) orderdto.getOrderAmount();
						orderFee = orderFee + ((amount - 1000000) / 100000) * 50;
					}
					/* 注文情報を注文確認画面に送る */
					orderdto.setOrderCondition(request.getParameter("orderCondition"));
					orderdto.setOrderNumber(orderNumber);
					orderdto.setOrderAmount(orderAmount);
					orderdto.setOrderDate(orderDate);
					orderdto.setOrderFee(orderFee);
					session.setAttribute("orderdto", orderdto);
					RequestDispatcher rd = request.getRequestDispatcher("Buy2.jsp");
					rd.forward(request, response);
				}
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
		String orderCondition = request.getParameter("orderCondition");
		String orderNumber = request.getParameter("orderNumber");
		String orderPriceN = request.getParameter("orderPriceN");
		String orderPtype = request.getParameter("orderPtype");

		int orderNumberN = 0;
		float orderPriceNF = 0;

		/* 注文数量チェック */
		if (orderNumber.isEmpty() || !isNumeric(orderNumber)) {
			response.getWriter()
					.println("<script>alert('注文数量に半角整数を入力してください');window.location.href='Buy1.jsp'</script>");
			return false;
		} else {
			try {
				orderNumberN = Integer.parseInt(orderNumber);
			} catch (NumberFormatException e) {
				e.printStackTrace();
				response.getWriter().println(
						"<script>alert('注文数量に30000000以内の整数を入力してください');window.location.href='Buy1.jsp'</script>");
				return false;
			}
			if (orderNumberN > 30000000) {

				response.getWriter().println(
						"<script>alert('注文数量に30000000以内の整数を入力してください');window.location.href='Buy1.jsp'</script>");
				return false;
			}
			/* 無条件以外の場合、注文価格の選択と指定価格チェック */
			if (!orderCondition.equals("N")) {

				if (orderPtype == null) {
					response.getWriter()
							.println("<script>alert('注文価格を選択してください');window.location.href='Buy1.jsp'</script>");
					return false;
				} else if (orderPtype.equals("Y")) {

					if (orderPriceN.isEmpty() || !isFloat(orderPriceN)) {
						response.getWriter().println(
								"<script>alert('指定価格に半角数字を入力してください');window.location.href='Buy1.jsp'</script>");
						return false;
					}

					try {
						orderPriceNF = Float.parseFloat(orderPriceN);
					} catch (NumberFormatException e) {

						e.printStackTrace();
						response.getWriter().println(
								"<script>alert('指定価格に30000000以内の数字を入力してください');window.location.href='Buy1.jsp'</script>");
						return false;
					}
					if (orderPriceNF > 30000000) {

						response.getWriter().println(
								"<script>alert('指定価格に30000000以内の数字を入力してください');window.location.href='Buy1.jsp'</script>");
						return false;
					}
				}
			}
		}
		return true;
	}

	/* 整数チェック */
	public static boolean isNumeric(String str) {
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	/* 数字チェック */
	public static boolean isFloat(String str) {
		boolean x = false;
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				if ((!x) && (str.charAt(i) == '.')) {
					x = true;
				} else {
					return false;
				}
			}

		}
		return true;
	}
}
