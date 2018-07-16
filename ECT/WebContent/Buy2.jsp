<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="orderdto" class = "dto.Order" scope="session" />

<html>

<head>
<meta charset="UTF-8">

<title>購入注文確認</title>

<style>
	<%-- Mypageボタン・ログアウトのボタン --%>
	
		
	h1{
	text-align:center;
	}
  
       table{
		align:center;
		font-size:1.2em;
		text-align:center;
		border:1px #606060;
		BORDER-COLLAPSE:COLLAPSE;}
	table Th{
		color:#606060;
		background:#b0c4de;
		font-size:1.2em;
		padding:9px 9px;
		font-weight:lighter;
		border:solid 1px black;}
	table td{
		font-size:1.2em;
		color:#606060;
		background:#FFFFFF;
        padding:8px 6px;
        font-weight:lighter;
        border:solid 1px black;}
	
	img{
	filter:alpha(opacity=40); 
	-moz-opacity:0.4; 
	-khtml-opacity: 0.4;  
	opacity: 0.4;}
	img{
		background-size:contain|cover;
		width:100%;
		height: auto;}
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
	body {
		padding:10px 15px;
		margin:auto;
		background-color:#fcfcfc;}

		
	<%-- 下部のボタン --%>
	
	input.submit{
		font-size:1em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
	
	}

	<%-- テーブルのボタン --%>
	
	
	
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
<span style="position: absolute; top:170px; left:780px;font-size:2.8em; color:#606060;">ー注文確認ー</span>
</div>


<br>
<br>
<br>
<br>
<br>
<br>
<br>


<center>
	
<table border="2">

  <tr>
    <th>銘柄名 </th>
    <td ><jsp:getProperty property="stockName" name="orderdto" /></td>
  </tr> 
  
  <tr> 
    <th >銘柄コード </th>
    <td ><jsp:getProperty property="stockCode" name="orderdto" /></td>
  </tr>   
   
  <tr> 
    <th >執行条件</th>
    
    <td><%if(orderdto.getOrderCondition().equals("N")){%><p>無条件</p>
    <%}else if(orderdto.getOrderCondition().equals("A")){%> <p>寄付</p>
    <%}else if(orderdto.getOrderCondition().equals("B")){%><p>引け</p>
    <%}else{%><p>指成</p><%} %></td>
  </tr> 
  
  <tr> 
    <th >注文価格</th>
    <td><%if(orderdto.getOrderPtype().equals("N")){%><p>成行</p>
    <%}else{%><p>指値</p><%} %></td>
  </tr> 
  
  <tr> 
    <th >注文単価</th>
    <td width="200"  height="50"><jsp:getProperty property="orderPrice" name="orderdto" /></td>
  </tr> 
   
  <tr> 
    <th >注文数量</th>
    <td ><jsp:getProperty property="orderNumber" name="orderdto" /></td>
  </tr> 
  
  <tr> 
    <th >参考総額</th>
  <td><fmt:formatNumber value='${orderdto.orderAmount}' pattern='#.##'></fmt:formatNumber></td>
  </tr> 
   <tr> 
    <th >取引手数料（実行する際に引き落とされます）</th>
    <td ><jsp:getProperty property="orderFee" name="orderdto" /></td>
  </tr> 
    
</table>


<br>
<br>

<form action="Buy1Servlet" method="post" style="display: inline">
		<input type="submit"  value="注文内容の修正" class="submit">
</form>
	
	<form action="Buy3Servlet" method="post" style="display: inline">
			<input type="submit" value="続行" class="submit">
	</form>
	</center>



</body>
</html>

<%-- <% session.inbalidate(); %> --%>
