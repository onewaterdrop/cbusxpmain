<link rel="stylesheet" href="xp.css" type="text/css">
<?php
set_time_limit(0);
//error_reporting(0);
require "global.php";
echo "���ڼ����ַ��...<br>";
print str_repeat(" ", 4096);
ob_flush();
flush();
sleep(1);
$url=$_GET["url"];
if(empty($url)){echo tips("��ַ����Ϊ��!");die();}
insert_links($url);
GetUrl_AllSite(GetSiteUrl($url));
$db->close();
?>