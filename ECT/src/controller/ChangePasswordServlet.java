package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CustomerDAO;
import dto.Customer;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePasswordServlet() {
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
				String cusId = request.getParameter("cusId");
				String cusPassword = request.getParameter("cusPassword");
				String cusPasswordN = request.getParameter("cusPasswordN");
				/* 顧客情報認証コード */
				Customer cusdto = CustomerDAO.find(cusId);
				if (cusdto == null) {
					response.getWriter().println(
							"<script>alert('顧客IDが存在しません');window.location.href='ChangePassword.html'</script>");

				} else if (!cusPassword.equals(cusdto.getCusPassword())) {

					response.getWriter().println(
							"<script>alert('ログインパスワードが間違いました');window.location.href='ChangePassword.html'</script>");
				} else {
					/* パスワード変更実行する */
					customer.setCusPassword(cusPasswordN);
					if (CustomerDAO.update(customer)) {
						response.getWriter().println(cusPasswordN + request.getAttribute("cusPasswordNS"));
						session.setAttribute("cusdto", customer);
						RequestDispatcher rd = request.getRequestDispatcher("ChangePasswordOK.html");
						rd.forward(request, response);
					} else {
						response.getWriter().println(
								"<script>alert('パスワード変更失敗しました');window.location.href='ChangePassword.html'</script>");
					}
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
		boolean result = false;
		String cusId = request.getParameter("cusId");
		String cusPassword = request.getParameter("cusPassword");
		String cusPasswordN = request.getParameter("cusPasswordN");
		String cusPasswordNS = request.getParameter("cusPasswordNS");

		if (cusId.isEmpty() || cusId.length() != 8 || !isNumeric(cusId)) {

			response.getWriter().println(
					"<script>alert('顧客IDに八桁の半角数字を入力してください');window.location.href='ChangePassword.html'</script>");
			return result;
		} else if (cusPassword.isEmpty() || cusPassword.length() < 8 || cusPassword.length() > 16
				|| !isNumericorLetter(cusPassword)) {

			response.getWriter().println(
					"<script>alert('顧客パスワードに八桁から十六桁までの半角英数字を入力してください');window.location.href='ChangePassword.html'</script>");
			return false;
		} else if (cusPasswordN.isEmpty() || cusPasswordN.length() < 8 || cusPasswordN.length() > 16
				|| !isNumericorLetter(cusPassword)) {

			response.getWriter().println(
					"<script>alert('新しい顧客パスワードに八桁から十六桁までの半角英数字を入力してください');window.location.href='ChangePassword.html'</script>");
			return false;
		} else if (!isNumericandLetter(cusPasswordN)) {

			response.getWriter().println(
					"<script>alert('パスワードを英数混合で設定してください');window.location.href='ChangePassword.html'</script>");
			return false;
		} else if (!cusPasswordN.equals(cusPasswordNS)) {

			response.getWriter()
					.println("<script>alert('再入力のパスワードが一致しません');window.location.href='ChangePassword.html'</script>");
			return false;
		}
		return true;
	}

	public static boolean isNumeric(String str) {
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	public static boolean isNumericorLetter(String str) {
		for (int i = str.length(); --i >= 0;) {
			if ((!Character.isDigit(str.charAt(i))) && (!Character.isLetter(str.charAt(i)))) {
				return false;
			}
		}
		return true;
	}

	public static boolean isNumericandLetter(String str) {
		boolean number = false;
		boolean letter = false;
		for (int i = str.length(); --i >= 0;) {
			if (Character.isDigit(str.charAt(i))) {
				number = true;
			} else if (Character.isLetter(str.charAt(i))) {
				letter = true;
			}
		}
		if (number && letter) {
			return true;
		} else {
			return false;
		}
	}
}
