<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="orderdto" class="dto.Order" scope="session" />
<jsp:useBean id="pricedto" class="dto.Price" scope="session" />

<html>
<head>

  <meta charset="UTF-8">
    <title>購入注文</title>
   
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
	input.button1{
		font-size:1em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
	
	}
		
	h1{
	text-align:center;
	}
    
    table{
		align:center;
		font-size:1.2em;
		text-align:center;
		border:1px #606060;
		border-collapse:collapse;}
	table Th{
		color:#606060;
		background:#B0C4DE;
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
<span style="position: absolute; top:170px; left:780px;font-size:2.8em; color:#606060;">ー株式購入ー</span>
</div>

<script type="text/javascript">
function changeDisabled() {
    if ( document.script["orderCondition"][0].checked) {
        document .script["id1"] . disabled = true;
        document .script["id2"] . disabled = true;
        document .script["id3"] . disabled = true;
       	document.script["id1"].checked = true;
       	document.script["id2"].checked = false;
       	document.script["id3"].value = "";
       
    } else if((document.script["orderCondition"][1].checked || 
    			document.script["orderCondition"][2].checked || 
    				document.script["orderCondition"][3].checked ) && 
    			document.script["orderPtype"][0].checked) {
    	
        document .script["id1"] . disabled = false;
        document .script["id2"] . disabled = false;
        document .script["id3"] . disabled = true;
        document .script["id3"] . value = "";
        document .script["id1"] . value = "N";
        
    } else{
       	document.script["id1"].disabled = false;
       	document.script["id2"].disabled = false;
       	document.script["id3"].disabled = false;    
    	
    }
}

window.onload = changeDisabled;
</script>


<br>

<center>
<form name="script" action="Buy2Servlet" method="post" >

<table  border="2">
	<tr>
		<Th>銘柄名</Th>
		<td> <jsp:getProperty property="stockName" name ="orderdto"/></Td>
	</tr>
	<tr>
		<Th>銘柄コード</Th>
		<td> <jsp:getProperty property="stockCode" name ="orderdto"/></td>
	</tr>
	<tr>
		<Th>当時価格</Th>
		<td><jsp:getProperty property="priceCurrent" name ="pricedto"/></td>
	</tr>
	
	<tr>
		<Th>執行条件</Th>
		<td><input type="radio" id="id0" name="orderCondition" value="N" onClick="changeDisabled()"checked>無条件
     		<input type="radio" name="orderCondition" value="A" onClick="changeDisabled()" >寄付
    		<input type="radio" name="orderCondition" value="B" onClick="changeDisabled()" >引け
     		<input type="radio" name="orderCondition" value="C" onClick="changeDisabled()" >指成	 <br>
 		 </td>
	</tr>
	<tr>
		<Th>注文価格</Th>
		<td><input type="radio" name="orderPtype" value="N" id="id1" onClick="changeDisabled()">成行
  		<input type="radio" name="orderPtype" value="Y" id="id2" onClick="changeDisabled()">指値<br>
  		</td>
	</tr>
		<th>指定価格</th>
		<td> <p style="display:inline;"><input type="text" name="orderPriceN" value="" id="id3" ><br>
   </td>
	</tr>
	<tr>
		<Th>注文数量</Th>
		<td><input type="text" name="orderNumber" value="" ></td>
	</tr>
	</table>
	
 <br>
 <br>
  <input type="submit" value="次へ" class="button1">
 </form>
 
</center>
 
</body>
</html>
