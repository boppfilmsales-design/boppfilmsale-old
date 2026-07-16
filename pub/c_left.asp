 <div class="left">
     <div class="left_title"><h3>产品搜索</h3></div>
   <div class="left_c">
  <div class="left_search">
<form action="/c_products/index.asp" method="post" name="search" id="search">
        产品搜索:
		<input name="key" id="key" value="" size="12">
		<input type="image" height="18" width="48" src="../images/seach.jpg" align="absMiddle" name="submit1">

      </form></div>
	  </div>
   

   <div class="left_title"><h3>产品分类</h3></div>
   <div class="left_c">
   <%
	  		set rs=server.createobject("adodb.recordset") 
      		sql="select * from yuzhiguo_big_class  ORDER BY sort asc "
  			rs.open sql,conn,1,1  
 		 	if rs.eof and rs.bof then 
    	 	response.write "<center>没有数据</center>" 
 		 	else 
     	 	do while not rs.eof
			big_id=rs("big_id")
	  		name=rs("name")
			html_url_cn=rs("html_url_cn")
			if request("big_id")<>"" then
			big_id_now=int(request("big_id"))
			else
			big_id_now=0
			end if
			%>
      <div class="p_list">
        <div class="list"><a href="<%=webfolder%>c_products/?big_id=<%=big_id%>" title="<%=name%>" class="big_class_bg"><strong><% if big_id_now=big_id then%><font color="#FF0000"><%=name%></font><%else%><%=name%><%end if%></strong></a>
        </div></div>
	  
      
       <%
	  		if request("big_id")<>"" then
			
			if request("big_id")<>""  and int(request("big_id"))=rs("big_id") then
			anclassid=request("anclassid")
		    set rss=server.createobject("adodb.recordset") 
            sql="select * from yuzhiguo_small_class where big_id="&rs("big_id")&" order by sort asc"
			rss.open sql,conn,1,3
			if rss.eof then		
			%>
          <%
			else
			do while not rss.eof
			small_id=rss("small_id")
			name=rss("name")
			html_url_cn=rss("html_url_cn")
			if request("big_id")<>"" and request("small_id") <>"" then
			small_id_now=int(request("small_id"))
			else
			small_id_now=0
			end if
			%>
	  
	  <div class="p_list"><div class="list_s"><a href="<%=webfolder%>c_products/?big_id=<%=big_id%>&amp;small_id=<%=small_id%>" title="<%=name%>" >└ <% if small_id_now=small_id then%><font color="#FF0000"><%=name%></font><%else%><%=name%><%end if%></a></div>
	  </div>
	  <%
			rss.movenext
			loop
			end if
			rss.close
			set rss=nothing
			%>
          <%
			else
			end if
			end if
			%>
        
        <%
			rs.movenext
			loop
			end if
			rs.close
			set rs=nothing
			%>
	  

	  <div style="clear:both"></div>
 
  
   </div>
 
   <div class="left_title"><h3>Contact Us </h3></div>
   <div class="left_c">
     <div class="map"><img src="../images/ditu.gif"></div>
	 <div class="left_contact">
<% if yuzhiguo_name<>"" then %>
          <strong>联系人:</strong> <%=yuzhiguo_name%><br /><% end if %>
          <% if tel<>"" then %>
          <strong>电话:</strong> <%=tel%><br /><% end if %>
          <% if fax<>"" then %>
          <strong>传真:</strong> <%=fax%><br /><% end if %>
          <% if mobile<>"" then %>
          <strong>手机:</strong> <%=mobile%><br /><% end if %>
          <% if email<>"" then %>
          <strong>E-mail: </strong><%=email%><br /><% end if %>
          <% if yuzhiguo_add<>"" then %>
          <strong>地址:</strong> <%=yuzhiguo_add%><br /><% end if %>
          <% if msn<>"" then %>
          <strong>MSN:</strong> <%=msn%><br /><% end if %>
          <% if skype<>"" then %>
          <strong>Skype:</strong> <%=skype%><br /><% end if %>
          <% if qq<>"" then %>
          <strong>QQ:</strong> <%=qq%><br /><% end if %>
            
<% if msn<>"" then %>
<a href="msnim:chat?contact=<%=msn%>"><img src="<%=webfolder%>images/msn.png" alt="MSN: <%=msn%>" border="0" /></a> 
<% end if %>

<% if skype<>"" then %>
<a href="skype:<%=skype%>?call"><img src="<%=webfolder%>images/skype.png" alt="SKYPE: <%=skype%>" border="0" /></a> 
<% end if %>

<% if qq<>"" then %>
<a href="http://wpa.qq.com/msgrd?V=1&Uin=<%=qq%>&Site=<%=e_webname%>&Menu=yes" target="_blank"><img src="<%=webfolder%>images/qq.png" alt="QQ: <%=qq%>" border="0" /></a>
          <% end if %>

<a target="_blank" href="mailto:boppfilmsale@hotmail.com"><img border="0" src="<%=webfolder%>images/email.png" alt="点击这里给我发消息"></a>	  </div>
	 <div style="clear:both"></div>
   </div>
   

 </div>