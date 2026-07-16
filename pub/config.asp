<%
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from yuzhiguo_setup",conn,1,1

yuzhiguo_webname=trim(rs("yuzhiguo_webname"))
e_webname=trim(rs("e_webname"))
weburl=trim(rs("weburl"))
webfolder=trim(rs("webfolder"))
logo=trim(rs("logo"))

yuzhiguo_title=trim(rs("yuzhiguo_title"))
e_title=trim(rs("e_title"))
yuzhiguo_keywords=trim(rs("yuzhiguo_keywords"))
e_keywords=trim(rs("e_keywords"))
yuzhiguo_description=trim(rs("yuzhiguo_description"))
e_description=trim(rs("e_description"))

webname_show=trim(rs("webname_show"))
e_webname_show=trim(rs("e_webname_show"))
tongji=trim(rs("tongji"))

product_page=Cint(trim(rs("product_page")))
product_hang=Cint(trim(rs("product_hang")))
product_hots=Cint(trim(rs("product_hots")))
news_page=Cint(trim(rs("news_page")))

pic_aspjpeg=trim(rs("pic_aspjpeg"))
pic_width=Cint(trim(rs("pic_width")))
pic_height=Cint(trim(rs("pic_height")))

font_aspjpeg=trim(rs("font_aspjpeg"))
font_size=trim(rs("font_size"))
font_family=trim(rs("font_family"))
font_color=replace(trim(rs("font_color")),"#","")
font_bg_color=replace(trim(rs("font_bg_color")),"#","")
font_text=trim(rs("font_text"))

mail_jmail=trim(rs("mail_jmail"))
mail_smtp=trim(rs("mail_smtp"))
mail_send=trim(rs("mail_send"))
mail_username=trim(rs("mail_username"))
mail_password=trim(rs("mail_password"))
mail_name=trim(rs("mail_name"))

kefu=trim(rs("kefu"))
kefu_x=trim(rs("kefu_x"))
kefu_y=trim(rs("kefu_y"))

feedback_view=trim(rs("feedback_view"))
feedback_verify=trim(rs("feedback_verify"))

yuzhiguo_name=trim(rs("yuzhiguo_name"))
e_name1=trim(rs("e_name"))
tel=trim(rs("tel"))
fax=trim(rs("fax"))
mobile=trim(rs("mobile"))
email=trim(rs("email"))
qq=trim(rs("qq"))
msn=trim(rs("msn"))
skype=trim(rs("skype"))
yahoo=trim(rs("yahoo"))
alibaba=trim(rs("alibaba"))
yuzhiguo_add=trim(rs("yuzhiguo_add"))
e_add=trim(rs("e_add"))

skin_css="deepne_css_bule"'cssÑùÊ½

rs.Close
set rs=nothing
%>
