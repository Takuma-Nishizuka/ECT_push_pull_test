<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="orderdto" class="dto.Order" scope="session" />

<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注文結果詳細</title>
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
		border-collapse:collapse;
		}
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
h2{
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
<span style="position: absolute; top:170px; left:700px;font-size:2.8em; color:#606060;">ー注文銘柄詳細情報ー</span>
</div>
<br>
<center>
<table border="2">
		<TR>
			<Th>受付番号</Th>
			<th>銘柄名</th>
			<th>銘柄コード</th>
			<th>注文数量</th>
			<th>注文金額</th>
			<th>注文日</th>
			
		</TR>
	<tbody>
		<TR>
			<TD><jsp:getProperty property="orderId" name ="orderdto"/></TD>
			<TD><jsp:getProperty property="stockName" name ="orderdto"/></TD>
			<td><jsp:getProperty property="stockCode" name ="orderdto"/></td>
			<td><jsp:getProperty property="orderNumber" name ="orderdto"/></td>
			<td><jsp:getProperty property="orderAmount" name ="orderdto"/></td>
			<td><jsp:getProperty property="orderDate" name ="orderdto"/></td>
			
			
		</TR>
	</tbody>
</TABLE>
</center>

<br>
<br>
<br>

<center>
<table border="2">
	<thead>
		<TR>
			<th>注文種類</th>
			<th>注文状態</th>
			<Th>執行条件</Th>
			<Th>注文価格</Th>
			<th>注文単価</th>
		</TR>
	</thead>
	<tbody>
		<TR>
			<td><%if(orderdto.getOrderType().trim().equals("B")){%><p>購入</p><%}else{%> <p>売却</p><%}%></td>
			<td><%if(orderdto.getOrderState().trim().equals("A")){%><p>注文中</p>
			<%}else if(orderdto.getOrderState().trim().equals("B")){%> <p>実行完了</p>
			<%}else if(orderdto.getOrderState().trim().equals("C")){%><p>キャンセル</p><%}%></td>	
			<td><%if(orderdto.getOrderCondition().trim().equals("N")){%><p>無条件</p>
			<%}else if(orderdto.getOrderCondition().trim().equals("B")){%> <p>引け</p>
			<%}else if(orderdto.getOrderCondition().trim().equals("A")){%><p>寄付</p>
			<%}else if(orderdto.getOrderCondition().trim().equals("C")){%><p>指成</p><%}%>
			</td>
			<td><%if(orderdto.getOrderPtype().trim().equals("N")){%><p>成行</p><%}else{%> <p>指値</p><%}%>
			</td>
			<td><jsp:getProperty property="orderPrice" name ="orderdto"/></td>
		</TR>
	</tbody>
</table>
</center>

</body>
</html>