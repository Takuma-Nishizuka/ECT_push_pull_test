<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="holdto" class = "dto.Hold" scope="session" />

<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保有商品一覧</title>
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
table{
		align:center;
		font-size:20px;
		border:1px #606060;
		text-align:center;
		border-collapse:collapse;}
table th{
		color:#606060;
		background:#E6E6FA;
		font-size:1.1em;
		padding:8px 6px;
		font-weight:lighter;
		border:solid 1px black;}
table td{
		color:#606060;
        padding:8px 6px;
        font-weight:lighter;
        border:solid 1px black;}
h2{
		text-align:center;
		font-size:1.8em;
		color:#606060;}
h3{		
		text-align:center;
		font-size:1.8em;
		color:#606060;}
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
body {
		padding:10px 15px;
		margin:auto;
		background-color:#fcfcfc;}	
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
<span style="position: absolute; top:170px; left:700px;font-size:2.8em; color:#606060;">ー保有商品銘柄一覧ー</span>
</div>

<br>
<%List<dto.Hold>holddto=(ArrayList)session.getAttribute("holddto"); %>
<%
if(holddto.isEmpty()){%>
<h3>保有商品はありません</h3>
<%}else{ %>

<table align="center">
	<tr>
		<Th>銘柄名</Th>
		<th>銘柄コード</th>
		<th>商品数量</th>
		<th>累計金額</th>
		<th>評価額</th>
	</tr>
<% List<Float> valuedto=(ArrayList)session.getAttribute("valuedto");int i=0;%>
<c:forEach var="hold" items="${holddto}">
	<tr>
		<td>${hold.stockName}</td>
		<td>${hold.stockCode}</td>
		<td>${hold.holdNumber}</td>
		<td><fmt:formatNumber value='${hold.holdAmount}' pattern='#.##'></fmt:formatNumber></td>
		<td><fmt:formatNumber value='<%=valuedto.get(i)%>' pattern='#.##'></fmt:formatNumber></td>
		<%i++; %>
</tr>
</c:forEach>
</table>
<%} %>
</body>
</html>