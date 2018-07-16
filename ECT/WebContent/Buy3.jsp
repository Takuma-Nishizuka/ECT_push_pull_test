<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="orderdto" class = "dto.Order" scope="session" />

<html>
<head>

<meta charset="UTF-8">
<title>購入注文完了画面</title>

<style>
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

		
	h1{
		text-align: center;
		font-size : 35pt;
}
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
<span style="position: absolute; top:170px; left:780px;font-size:2.8em; color:#606060;">ー注文完了ー</span>
</div>

<br>
<br>


<h1> 受付番号 : 
<jsp:getProperty property="orderId" name="orderdto" />
</h1>
<br>
<br>
<h1>ご利用ありがとうございました</h1>


</body>
</html>