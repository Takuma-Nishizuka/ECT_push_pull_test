<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.text.*"%>   
  <%@ page import ="java.util.*"%> 
<jsp:useBean id="stockdto" class="dto.Stock" scope="session" />
<jsp:useBean id="pricedto" class="dto.Price" scope="session" />

<html>
<head>

  <meta charset="UTF-8">
    <title>検索結果詳細画面</title>
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
	    -moz-box-shadow: 2px 2px 3px 1px #666;}
	button.button3{
		font-size:1.3em;
		font-weight:normal;
		padding:10px 0px;
		width:130px;
	}
    table{
		align:center;
		font-size:20px;
		text-align:center;
		border:1px #606060;
		border-collapse:collapse;}
	table th{
		color:#606060;
		background:#B0c4de;
		font-size:1.1em;
		padding:8px 6px;
		font-weight:lighter;
		border:solid 1px black;}
	table td{
		color:#606060;
        padding:8px 6px;
        font-weight:lighter;
        border:solid 1px black;}
    table caption{
    	color:#606060; }
    h1{
    	color:#606060;
    	text-align:center;}
  	h2{
  		color:#606060;}
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
<span style="position: absolute; top:170px; left:800px;font-size:2.8em; color:#606060;">ー銘柄詳細ー</span>
</div>

<br><br><br>
<% SimpleDateFormat df = new java.text.SimpleDateFormat("MM-dd");  
Date d=new Date(); 
String d7=df.format(d);
String d6=df.format(new Date(d.getTime() - (long)1 * 24 * 60 * 60 * 1000));
String d5=df.format(new Date(d.getTime() - (long)2 * 24 * 60 * 60 * 1000));
String d4=df.format(new Date(d.getTime() - (long)3 * 24 * 60 * 60 * 1000));
String d3=df.format(new Date(d.getTime() - (long)4 * 24 * 60 * 60 * 1000));
String d2=df.format(new Date(d.getTime() - (long)5 * 24 * 60 * 60 * 1000));
String d1=df.format(new Date(d.getTime() - (long)6 * 24 * 60 * 60 * 1000));%>  
    <h1>銘柄詳細情報</h1>


<%if(stockdto.getStockCode()==null){%>
<h2>検索結果は０件です。</h2>
<%}else{ %>
 <center>
  <table border="2">
  <tr>
    <th>銘柄コード </th>
    <th>銘柄名 </th>
    <th>市場</th>
    <th>業種</th>
    <th>当時単価</th>
    <th>当時始値</th>
    <th>区分</th>
  </tr>
  <tr>
    <td><jsp:getProperty property="stockCode" name="stockdto" /></td>
    <td><jsp:getProperty property="stockName" name="stockdto" /></td>
    <td><jsp:getProperty property="stockMarket" name="stockdto" /></td>
    <td><jsp:getProperty property="stockCate" name="stockdto" /></td>
    <td><jsp:getProperty property="priceCurrent" name="pricedto" /></td>
    <td><jsp:getProperty property="priceStart" name="pricedto" /></td>
    <td><%if(!stockdto.getStockClass().trim().equals("C")){%><p style="color:red">整理・監理</p><%}else{%> <p>-</p><%}%></td>
    
  </tr>
</table>

  <br>
  <br>
  <br>
  <br>

<table border="2">
  <tr>
    <th>当日高値</th>
    <th>当日安値</th>
    <th>買い気配値</th>
    <th>売り気配値</th>
    <th>年初来高値</th>
    <th>年初来安値</th>
  </tr>
  <tr>
    <td><jsp:getProperty property="priceHighest" name="pricedto" /></td>
    <td><jsp:getProperty property="priceLowest" name="pricedto" /></td>
    <td><jsp:getProperty property="priceBuy" name="pricedto" /></td>
    <td><jsp:getProperty property="priceSell" name="pricedto" /></td>
    <td><jsp:getProperty property="priceYhighest" name="pricedto" /></td>
    <td><jsp:getProperty property="priceLowest" name="pricedto" /></td>
  </tr>
</table>
<br>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>

<canvas id="ChartDemo" width="200" height="30"></canvas>

<script>
var ctx = document.getElementById("ChartDemo").getContext('2d');

ctx.canvas.height = 550;
ctx.canvas.width = 700;

var ChartDemo = new Chart(ctx, {
   type: 'line',
   data: {
      labels: ["<%=d1%>", "<%=d2%>", "<%=d3%>", "<%=d4%>", "<%=d5%>", "<%=d6%>", "<%=d7%>"],
      datasets: [{
    	  label: "株価",
    	 
    	 fill: false,
         borderColor: '#1874CD',
         borderWidth :'5px',
        
		 lineTension:false,
		 pointBorderWidth:5,
		 pointHoverBorderColor: "rgba(220,220,220,1)",
         data: [<jsp:getProperty property="pricePast1" name="pricedto" />,
        	 <jsp:getProperty property="pricePast2" name="pricedto" /> ,
        		 <jsp:getProperty property="pricePast3" name="pricedto" />,
        			 <jsp:getProperty property="pricePast4" name="pricedto" />,
        				 <jsp:getProperty property="pricePast5" name="pricedto" />, 
        					 <jsp:getProperty property="pricePast6" name="pricedto" />,
        						 <jsp:getProperty property="pricePast7" name="pricedto" />],
      },
      ]
   },
   options: {
	  animation :false,
      responsive: false,
      scales: {
          yAxes: [
            {
              ticks: {
            	fontSize: 20, 
                beginAtZero: true,
                min: Math.min(<jsp:getProperty property="pricePast1" name="pricedto" />,
                		<jsp:getProperty property="pricePast2" name="pricedto" />,
                		<jsp:getProperty property="pricePast3" name="pricedto" />,
                		<jsp:getProperty property="pricePast4" name="pricedto" />,
                		<jsp:getProperty property="pricePast5" name="pricedto" />,
                		<jsp:getProperty property="pricePast6" name="pricedto" />,
                		<jsp:getProperty property="pricePast7" name="pricedto" />)-1,	
                max: Math.max(<jsp:getProperty property="pricePast1" name="pricedto" />,
            		<jsp:getProperty property="pricePast2" name="pricedto" />,
            		<jsp:getProperty property="pricePast3" name="pricedto" />,
            		<jsp:getProperty property="pricePast4" name="pricedto" />,
            		<jsp:getProperty property="pricePast5" name="pricedto" />,
            		<jsp:getProperty property="pricePast6" name="pricedto" />,
            		<jsp:getProperty property="pricePast7" name="pricedto" />)+1
              },
              
            scaleLabel: {              //軸ラベル設定
                display: true,          //表示設定
                labelString: '株価 (円)',  //ラベル
                fontSize: 25               //フォントサイズ
             }
            
            
            }
          ],
   		xAxes :[
   		{
   			ticks:{
   				fontSize: 20
   			},
   			scaleLabel: {              //軸ラベル設定
                display: true,          //表示設定
                labelString: '日付(月-日)',  //ラベル
                fontSize:25             //フォントサイズ
             }
   			
   		}	
   			
   		]
   
        },
   title: {                           //タイトル設定
       display: true,                 //表示設定
       fontSize: 25,                  //フォントサイズ
       text: '株価ヒストリカルチャート'                //ラベル
   },
   lavel: {                          //凡例設定
            display: true  ,               //表示設定
            fontSize:1
       },
     legend :{
    	 position: 'top',
     }
   }
});
</script>

<br>

<table border="2">
<caption>過去一週間株価</caption>

  <tr>
  	<th>日付(月/日)</th>
    <th><%=d1%></th>
    <th><%=d2%></th>
    <th><%=d3%></th>
    <th><%=d4%></th>
    <th><%=d5%></th>
    <th><%=d6%></th>
    <th><%=d7%></th>
  </tr>
  <tr>
  	<td>株価(円)</td>
    <td><jsp:getProperty property="pricePast1" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast2" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast3" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast4" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast5" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast6" name="pricedto" /></td>
    <td><jsp:getProperty property="pricePast7" name="pricedto" /></td>
  </tr>
</table>
</center>
<br><br><br>


<center>
<form action="Buy1Servlet" method="post">
  <button class="button3" type="submit">購入</button>
</form>
<form action="SSCServlet" method="post">
  <button class="button3" type="submit">戻る</button>
</form>
</center>
<%} %>



</body>
</html>


