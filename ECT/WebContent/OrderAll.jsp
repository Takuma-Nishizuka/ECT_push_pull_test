<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注文銘柄一覧</title>
<head>
<style type="text/css">
img{
	filter:alpha(opacity=40); 
	-moz-opacity:0.4; 
	-khtml-opacity: 0.4;  
	opacity: 0.4;}
ul{
		list-style-type:none;
		margin:0;
		padding:0;
		display:inline-flex;
		position:absolute;
		top:25px;
		right:35px;}
li{
		display:inline;}

button.button1{
		font-size:1em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
		background-color:#D3D3D3;
		border-style: none;
		box-shadow: 2px 2px 3px 1px #666;
	    -moz-box-shadow: 2px 2px 3px 1px #666;
	    -webkit-box-shadow: 2px 2px 3px 1px #666;}
button.button2{
		font-size:1em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
		background-color:#D3D3D3;
		border-style: none;
		box-shadow: 2px 2px 3px 1px #666;
	    -moz-box-shadow: 2px 2px 3px 1px #666;
	    -webkit-box-shadow: 2px 2px 3px 1px #666;}
table{
		align:center;
		font-size:20px;
		text-align:center;
		border:1px #606060;
		border-collapse:collapse;}
table th{
		color:#606060;
		background:#b0c4de;
		font-size:1.1em;
		padding:8px 6px;
		font-weight:lighter;
		border:solid 1px black;}
table td{
		color:#606060;
        padding:8px 6px;
        font-weight:lighter;
        border:solid 1px black;}
h2.h21{
		text-align:center;
		font-size:1.8em;
		color:#606060;}
h2.h22{		
		text-align:center;
		font-size:1.8em;
		color:#606060;}

body {
		padding:10px 15px;
		margin:auto;
		background-color:#fcfcfc;}
input.num{
		text-align:center;
		font-size:1.1em;}
img{
		background-size:contain|cover;
		width:100%;
		height: auto;}

</style>
</head>
<body>
<div>
<img src="america-analysis-business-926987.jpg"/>
<ul>
	<li><form action="MypageServlet" method="post"><button class="button1" type="submit"  style="margin-right:15px;">マイページに戻る</button></form></li>
	<li><form action="LogoutServlet" method="post"><button class="button2" type="submit">ログアウト</button></form></li>
</ul>
<span style="position: absolute; top:50px; left:750px;font-size:4em; color:#606060; font-weight:bold;">長谷川証券</span>
<span style="position: absolute; top:170px; left:750px;font-size:2.8em; color:#606060;">ー注文銘柄一覧ー</span>
</div>
<br>
<br>
<%List<dto.Order>orderdto=(ArrayList)session.getAttribute("orderdto"); %>
<%if(orderdto.isEmpty()){ %>
<h2 class="h22">注文はありません</h2>
<%}else{ %>

<table align="center" border="2">
	<tr>
		<Th>受付番号</Th>
		<Th>銘柄名</Th>
		<th>銘柄コード</th>
		<th>注文数量</th>
		<th>注文金額</th>
		<th>注文日</th>
		<th>注文種類</th>
		<th>注文状態</th>
	</tr>
<c:forEach  var="order" items="${orderdto }">
	<tr>
		<td><form action="ClickOrderIdServlet" method="post"><input type="submit" name="orderId" value="${order.orderId}" class="num"></form></td>
		<td>${order.stockName}</td>
		<td>${order.stockCode}</td>
		<td>${order.orderNumber}</td>
		<td><fmt:formatNumber value='${order.orderAmount}' pattern='#.##'></fmt:formatNumber></td>
		<td>${order.orderDate}</td>
		<td><c:if test="${order.orderType=='B'}">購入</c:if>
		<c:if test="${order.orderType=='S'}">売却</c:if></td>
		<td><c:if test="${order.orderState=='A'}">注文中</c:if>
		<c:if test="${order.orderState=='B'}">実行完了</c:if>
		<c:if test="${order.orderState=='C'}">キャンセル</c:if></td>
		

</tr>
</c:forEach>
</table>
<%} %>
</body>
</html>