<!--#include file="../pub/conn.asp"-->
<%dim action
action=request("action")
select case action
		case "news_hits"
		call news_hits()
		case "pro_hits"
		call pro_hits()
		case else
		call main()
end select
		sub main()%>
<%
end sub	
'新闻浏览量	
sub news_hits()
dim hits_sql 
dim hits_rs 
set hits_rs=server.createobject("adodb.recordset") 
hits_sql="select * from yuzhiguo_news where id="&request("id") 
hits_rs.open hits_sql,conn,1,3 
conn.execute "update yuzhiguo_news set hits=hits+1 where id="&request("id") 
%> 
document.write(<%'=hits_rs("hits")%>); 
<% 
hits_rs.close 
Set hits_rs = Nothing 
conn.close 
set conn=Nothing 
%> 

<%
end sub
'产品浏览量
sub pro_hits()
dim hits_sql 
dim hits_rs 
set hits_rs=server.createobject("adodb.recordset") 
hits_sql="select * from yuzhiguo_products where id="&request("id") 
hits_rs.open hits_sql,conn,1,3 
conn.execute "update yuzhiguo_products set hits=hits+1 where id="&request("id") 
%> 
document.write(<%'=hits_rs("hits")%>); 
<% 
hits_rs.close 
Set hits_rs = Nothing 
conn.close 
set conn=Nothing 
end sub
%>

