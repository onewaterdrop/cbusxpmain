<?php
/*********************/
/*                   */
/*  Version : 5.1.0  */
/*  Author  : RM     */
/*  Comment : 071223 */
/*                   */
/*********************/

require( "../global.php" );
$link_id = intval( $_SERVER['QUERY_STRING'] );
if ( empty( $link_id ) )
{
	header( "location:.".$zeigou['url'] );
}
$link = $db->get_one( "select * from ve123_links where link_id='".$link_id."'" );
echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\" />\r\n<title>";
echo $link['title'];
echo "</title>\r\n<style>\r\nbody{font-size:13px;line-height:25px;}\r\n.table{background:#D0DBFC;}\r\n.table td{background:#F4F6FC;}\r\n</style>\r\n<script language=\"javascript\" type=\"text/javascript\"> \r\nfunction codeCopy(){ \r\nvar obj=document.getElementById(\"url\"); \r\nobj.select(); \r\njs=obj.createTextRange(); \r\njs.execCommand(\"Copy\") ;\r\nalert(\"���Ƴɹ�!\");\r\nreturn false;\r\n} \r\n</script>\r\n</head>\r\n\r\n<body>\r\n<table width=\"900\" height=\"54\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n<tr valign=middle>\r\n<td width=\"100%\" valign=\"top\" style=\"padding-left:8px;width:137px;\" nowrap>\r\n<a href=\"./\"><img src=\"../images/logo-yy.gif\" border=\"0\" width=\"137\" height=\"46\" alt=\"��";
echo $zeigou['name'];
echo "��ҳ\"></a>\r\n</td>\r\n<td>&nbsp;&nbsp;&nbsp;</td>\r\n<td width=\"100%\" valign=\"top\">\r\n<div class=\"Tit\">\r\n";
foreach ( $nav as $key => $value )
{
	if ( empty( $value['url'] ) )
	{
		echo "<a href=\"../?wd=".urlencode( $value['title'] )."\">".$value['title']."</a>";
	}
	else
	{
		echo "<a href=\"".$value['url']."\" target=\"_blank\">".$value['title']."</a>";
	}
	echo "&nbsp;&nbsp;&nbsp;";
}
echo "</div>\r\n<table cellspacing=\"0\" cellpadding=\"0\">\r\n<tr><td valign=\"top\" nowrap>\r\n<form name=f action=\"../\">\r\n<input name=wd id=kw size=\"42\" class=\"i\" value=\"\" maxlength=\"100\"> \r\n<input type=submit value=";
echo $zeigou['name'];
echo "һ��>&nbsp;&nbsp;&nbsp;\r\n</form>\r\n</td>\r\n<td valign=\"middle\" nowrap>\r\n\r\n</td>\r\n</tr></table>\r\n<div style=\"line-height:25px;\"></div>\r\n</td>\r\n\r\n</tr></table>\r\n<table width=\"900\" border=\"0\" align=\"center\" cellpadding=\"3\" cellspacing=\"1\" class=\"table\">\r\n  <tr>\r\n    <td width=\"100\">��վ����:</td>\r\n    <td>";
echo $link['title'];
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>��վ�ؼ���:</td>\r\n    <td>";
echo $link['keywords'];
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>��վ����:</td>\r\n    <td>";
echo $link['description'];
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>����Ԥ��:</td>\r\n    <td>";
echo $link['fulltxt']."...";
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>��¼ʱ��:</td>\r\n    <td>";
echo date( "Y-m-d H:i:s", $link['addtime'] );
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>����ʱ��:</td>\r\n    <td>";
echo date( "Y-m-d H:i:s", $link['updatetime'] );
echo "</td>\r\n  </tr>\r\n  <tr>\r\n    <td>��վ��ַ:</td>\r\n    <td><a href=\"";
echo "../q?".base64_encode( "url=".$link['url'] );
echo "\" target=\"_blank\">";
echo $link['url'];
echo "</a></td>\r\n  </tr>\r\n  <tr>\r\n    <td>��վ����:</td>\r\n    <td><a href=\"";
echo "../k/?".base64_encode( "url=".$link['url']."&wd=".$wd_split."" );
echo "\" target=\"_blank\">";
echo $zeigou['name'];
echo "����</a></td>\r\n  </tr>\r\n</table>\r\n\r\n<table width=\"900\" border=\"0\" align=\"center\" cellpadding=\"3\" cellspacing=\"1\" class=\"table\" style=\"margin-top:3px;\">\r\n  <tr>\r\n    <td><input name=\"url\" id=\"url\" type=\"text\" size=\"50\" value=\"";
echo $zeigou['url'];
echo "\"/>\r\n    <input type=\"submit\" name=\"Submit\" value=\"����\"  onClick=\"codeCopy()\"/>\r\n    (���ϱ�վ����,ϵͳ�Զ���¼�����վ,�Ժ�ÿ�����µĵ���,�Զ����ڵ�һλ!)</td>\r\n  </tr>\r\n</table>\r\n<div style=\"text-align:center;margin-top:5px;\">";
echo $poweredby;
echo "</div>\r\n</body>\r\n</html>\r\n";
?>
