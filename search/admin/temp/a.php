<html><head><meta http-equiv=content-type content="text/html;charset=gb2312">
<title><?php echo Html2Text($title)."--".$config["name"];?></title>
<style>
<!--
body{margin:0px;font-size:12px;font-family:Arial;line-height:180%}
td{font-size:12px;}
img{border:0}
.b{border:1px solid #A1C0DC;margin-bottom:8px;}
.b a{text-decoration:none;}
.b a:hover{text-decoration:underline;}
.b1{padding:4px 0 4px 10px;}
.b2{padding:6px 5px 4px 10px;font-size:14px;line-height:150%}
.b2 img{border:1px solid #D0E3F2;}
-->
</style>

<table width=910 border=0 align="center" cellpadding=0 cellspacing=0>
  <td height=3 bgcolor=005CCD></td>
</table>
<br>
<table width=910 border=0 align="center" cellpadding=0 cellspacing=0>
  <tr>
    <td width=175 rowspan=3><a href="<?php echo $config["url"]?>"><img src="<?php echo $config["url"]."/images/logo.gif";?>"></a></td>
    <td width=735 height=37 align=right valign=bottom style="font-size:14px;font-weight:bold;"><span class="b1"><?php echo $title;?></span></td>
  </tr>
  <tr>
    <td height=1 bgcolor=D0E3F2></td>
  </tr>
  <tr>
    <td height=13></td>
  </tr>
</table>
<br>
<table width=910 align="center" cellpadding=0 cellspacing=1 bgcolor=D0E3F2 style="margin-bottom:8px;">
  <td bgcolor=E6F4FF class=b1><a href="<?php echo $config["url"];?>"><?php echo $config["name"];?>��ҳ</a>&nbsp;&gt;&nbsp;<?php echo $title;?></td>
</table>
<table width=910 align="center" cellpadding=0 cellspacing=0 class=b>
  
  <tr>
    <td valign=top class=b2><?php echo $content;?></td>
  </tr>
</table>


</div>

<div align=center class="center blue" style="padding:18px 0px 18px 0px;">Copyright <?php echo $config["copyright"];?>&nbsp;&nbsp;</div>
</body></html>