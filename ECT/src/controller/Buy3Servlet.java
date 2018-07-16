package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AccountDAO;
import dao.OrderDAO;
import dao.PriceDAO;

import dto.*;

/**
 * Servlet implementation class Buy3Servlet
 */
@WebServlet("/Buy3Servlet")
public class Buy3Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Buy3Servlet() {
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
			Order orderdto = (Order) session.getAttribute("orderdto");
			Price pricedto = (Price) session.getAttribute("pricedto");
			float priceCurrent = PriceDAO.find(orderdto.getStockCode()).getPriceCurrent();
			/* 株価変化確認２ */
			if (priceCurrent != pricedto.getPriceCurrent()) {
				orderdto.setOrderPrice(priceCurrent);
				session.setAttribute("orderdto", orderdto);
				pricedto = PriceDAO.find(orderdto.getStockCode());
				session.setAttribute("pricedto", pricedto);
				response.getWriter()
						.println("<script>alert('当時単価変わりました、注文情報を再入力してください');window.location.href='Buy1.jsp'</script>");
			} else {
				/* 当日上限金額確認2 */
				if (orderdto.getOrderAmount() + AccountDAO.find(customer.getAccId()).getAccDtotalbuy() > 30000000) {
					Order orderdto1 = new Order();
					orderdto1.setCusId(customer.getCusId());
					orderdto1.setStockCode(orderdto.getStockCode());
					orderdto1.setStockName(orderdto.getStockName());
					orderdto1.setStockUnit(orderdto.getStockUnit());
					orderdto1.setOrderType("B");
					orderdto1.setOrderPrice(PriceDAO.find(orderdto1.getStockCode()).getPriceCurrent());
					session.setAttribute("orderdto", orderdto1);
					response.getWriter()
							.println("<script>alert('当日購入累計金額が三千万円超えました');window.location.href='Buy1.jsp'</script>");
					/* 取引用口座残高確認2 */
				} else if (AccountDAO.find(customer.getAccId()).getAccBalance() < orderdto.getOrderAmount()) {
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
					/*注文情報を記録する*/
					orderdto.setOrderState("A");
					if (OrderDAO.insert(orderdto)) {
						session.setAttribute("orderdto", orderdto);
						Account account = AccountDAO.find(customer.getAccId());
						account.setAccBalance(account.getAccBalance() - orderdto.getOrderAmount());
						account.setAccDtotalbuy(account.getAccDtotalbuy() + orderdto.getOrderAmount());
						/*取引用口座を更新する*/
						if (AccountDAO.update(account)) {
							RequestDispatcher rd = request.getRequestDispatcher("Buy3.jsp");
							rd.forward(request, response);
							session.removeAttribute("orderdto");
							session.removeAttribute("stockdto");
							session.removeAttribute("pricedto");
						}
					} else {
						session.removeAttribute("orderdto");
						response.getWriter()
								.println("<script>alert('注文しました');window.location.href='Mypage.html'</script>");
					}
				}
			}
		}
	}

}
