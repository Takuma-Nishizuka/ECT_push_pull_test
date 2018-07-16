<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.text.*"%>   
<%@ page import ="java.util.*"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<jsp:useBean id="accountdto" class="dto.Account" scope="session" />
<html>
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
		border:1px #606060;}
	table th{
		color:#606060;
		background:#E6E6FA;
		font-size:1.1em;
		padding:8px 6px;
		font-weight:lighter;}
	table td{
		color:#606060;
        padding:8px 6px;
        font-weight:lighter;}
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>取引用口座</title>
</head>
<body>
<div>
<img src="america-analysis-business-926987.jpg"/>
<ul>
	<li><form action="MypageServlet" method="post"><button class="button1" type="submit"  style="margin-right:15px;">マイページに戻る</button></form></li>
	<li><form action="LogoutServlet" method="post"><button class="button2" type="submit">ログアウト</button></form></li>
</ul>
<span style="position: absolute; top:50px; left:750px;font-size:4em; color:#606060; font-weight:bold;">長谷川証券</span>
<span style="position: absolute; top:170px; left:730px;font-size:2.8em; color:#606060;">ー取引用口座情報ー</span>
</div>
	<h2>口座残高：<fmt:formatNumber value='${accountdto.accBalance}' pattern='###,###.##'></fmt:formatNumber></h2>
	<br>
	<br>
	<h2>当日購入累計金額:<fmt:formatNumber value='${accountdto.accDtotalbuy}' pattern='###,###.##'></fmt:formatNumber></h2>
	<br>
	<h3 align="center" style="color:#A6A6A6 ">当日購入可能金額:<fmt:formatNumber value='${30000000-accountdto.accDtotalbuy}' pattern='###,###.##'></fmt:formatNumber></h3>
	<br>
	<br>
	<h2>当日売却累計金額:<fmt:formatNumber value='${accountdto.accDtotalsell}' pattern='###,###.##'></fmt:formatNumber></h2>
	<br>
	<h3 align="center" style="color:#A6A6A6 ">当日売却可能金額:<fmt:formatNumber value='${30000000-accountdto.accDtotalbuy}' pattern='###,###.##'></fmt:formatNumber></h3>
	
	
</body>
</html>