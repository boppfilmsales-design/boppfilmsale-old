<table width="230" border="0" cellpadding="0" cellspacing="0" id="left_class">
        <tr>
          <td><h6>产品分类</h6></td>
        </tr>
        <tr>
          <td>
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
            <ul><li>
<a href="<%=webfolder%>c_products/?big_id=<%=big_id%>" title="<%=name%>"><strong><% if big_id_now=big_id then%><font color="#FF0000"><%=name%></font><%else%><%=name%><%end if%></strong></a></li>

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
            <ul>
            <li>
<a href="<%=webfolder%>c_products/?big_id=<%=big_id%>&amp;small_id=<%=small_id%>" title="<%=name%>" >└ <% if small_id_now=small_id then%><font color="#FF0000"><%=name%></font><%else%><%=name%><%end if%></a>
			</li></ul>
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
            </ul>
			<%
			rs.movenext
			loop
			end if
			rs.close
			set rs=nothing
			%>
          </td>
        </tr>
      </table>
        