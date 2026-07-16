<%
sql1="select * from yuzhiguo_e_flash"
set rs=server.CreateObject("Adodb.recordset")
rs.open sql1,conn,1,1
if rs("aimage")<>"" or rs("bimage")<>"" or rs("cimage")<>"" or rs("dimage")<>"" or rs("eimage")<>"" then 
%>
<div class="banner">

<script language="javascript" type="text/javascript">
<!--
var focus_width=<%=rs("image_width")%>
var focus_height=<%=rs("image_height")%>
var text_height=<%=rs("text_height")%>
var swf_height = focus_height+text_height
var pics = '';
var links = '';
var texts = '';
							
function ati(url, img, title)
{
if(pics != '')
{
pics = "|" + pics;
links = "|" + links;
texts = "|" + texts;
}
pics = escape(img) + pics;
links = escape(url) + links;
texts = title + texts;
}

<% if rs("eimage")<>"" then %> 
ati('<%=rs("elink")%>', '<%=webfolder%><%=get_pic(rs("eimage"),1)%>', '<%=rs("etext")%>');
<%end if%>
<% if rs("dimage")<>"" then %>
ati('<%=rs("dlink")%>', '<%=webfolder%><%=get_pic(rs("dimage"),1)%>', '<%=rs("dtext")%>');
<%end if%>
<% if rs("cimage")<>"" then %>
ati('<%=rs("clink")%>', '<%=webfolder%><%=get_pic(rs("cimage"),1)%>', '<%=rs("ctext")%>');
<%end if%>
<% if rs("bimage")<>"" then %>
ati('<%=rs("blink")%>', '<%=webfolder%><%=get_pic(rs("bimage"),1)%>', '<%=rs("btext")%>');
<%end if%>
<% if rs("aimage")<>"" then %>
ati('<%=rs("alink")%>', '<%=webfolder%><%=get_pic(rs("aimage"),1)%>', '<%=rs("atext")%>');
<%end if%>

var yuzhiguo = '<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http:\/\/fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width=\"'+ focus_width +'\" height=\"'+ swf_height +'\">';
yuzhiguo += '<param name="movie" value="<%=webfolder%>\images\/flash_img.swf"><param name="quality" value="high"><param name="bgcolor" value="#ffffff">';
yuzhiguo += '<param name=\"menu\" value=\"false\"><param name=wmode value=\"opaque\">';
yuzhiguo +='<param name=\"FlashVars\" value=\"pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'\">';
yuzhiguo +='<embed src=\"<%=webfolder%>\images\/flash_img.swf\" wmode=\"opaque\" FlashVars=\"pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'\" menu=\"false\" bgcolor=\"#ffffff\" quality=\"high\" width=\"'+ focus_width +'\" height=\"'+ swf_height +'\" allowScriptAccess=\"sameDomain\" type=\"application\/x-shockwave-flash\" pluginspage=\"http:\/\/www.macromedia.com\/go\/getflashplayer\" \/>';
yuzhiguo +='<\/object>';
document.write(yuzhiguo);
//-->
</script>

</div> 
<%
end if
rs.close
set rs=nothing
%>
