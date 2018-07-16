<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
	<%@page import="java.util.*"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>検索結果一覧画面</title>

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
	h2 {
		text-align: center;
		color:#606060;}
	body {
		padding:10px 15px;
		margin:auto;
		background-color:#fcfcfc;}
	img{
		background-size:contain|cover;
		width:100%;
		height: auto;}
		
	input.back{
		font-size:1em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
	}

	input.code{
		text-align:center;
		font-size:1.1em;
		
	}
	
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
<span style="position: absolute; top:170px; left:730px;font-size:2.8em; color:#606060;">ー検索結果一覧ー</span>
</div>

<br>

<%List<dto.Stock>stockdto=(ArrayList)session.getAttribute("stockdto"); 
if(stockdto.isEmpty()){%>
<h3>検索結果は０件です。</h3>
<%}else{ %>
		<center>
		<table border="2">

		<tr>
            <th>銘柄コード</th>
			<th>銘柄名</th>
			<th>区分</th>


		</tr>
		<c:forEach var="stock" items="${stockdto}">
			<tr>
				<td><form action="SearchStockCServlet" method="post"><input type="submit" name='stockCode' value='${stock.stockCode}' class="code"></form></td>
				<td><c:out value="${stock.stockName}"/></td>
			    
				<td width="100pt"><c:if test="${stock.stockClass=='A '}"><p style="color:red">整理</p></c:if>
				<c:if test="${stock.stockClass=='B '}"><p style="color:red">監理</p></c:if>
                <c:if test="${stock.stockClass =='C '}"><p>-</p></c:if></td>
				
			</tr>
			</c:forEach>

	</table>
	<p>
<%} %>

		<form action="SSNServlet" method="POST"><input type="submit"value="戻る" class="back"></form>

	</center>
</body>
</html>