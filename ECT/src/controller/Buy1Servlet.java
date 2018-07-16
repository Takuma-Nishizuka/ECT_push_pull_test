package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dto.*;


/**
 * Servlet implementation class Buy1Servlet
 */
@WebServlet("/Buy1Servlet")
public class Buy1Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Buy1Servlet() {
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
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		HttpSession session=request.getSession();
		session.removeAttribute("orderdto");
		Customer customer =(Customer)session.getAttribute("cusdto");
	
		/*セッション時間確認*/             
	    if(customer==null) {
	    	 response.getWriter().println("<script>alert('セッションタイム切れました、再ログインしてください');window.location.href='Toppage1.html'</script>");
	    }else {
	
	    /*購入銘柄情報を取る*/
			    Order orderdto=new Order();
			    Stock stockdto=(Stock)session.getAttribute("stockdto");
			    Price pricedto=(Price)session.getAttribute("pricedto");
			    orderdto.setCusId(customer.getCusId());
			    orderdto.setStockCode(stockdto.getStockCode());
			    orderdto.setStockName(stockdto.getStockName());
			    orderdto.setStockUnit(stockdto.getStockUnit());
			    orderdto.setOrderType("B");
			    orderdto.setOrderPrice(pricedto.getPriceCurrent());
	            session.setAttribute("orderdto",orderdto);
	            session.setAttribute("pricedto", pricedto);
	            RequestDispatcher rd=request.getRequestDispatcher("Buy1.jsp");
			    rd.forward(request,response);
	    }
	}

}
