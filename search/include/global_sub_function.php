<?php
function index_foothtml()
{
    global $db,$config;
?>
<p style="height:14px">
<?php

$query=$db->query("select * from ve123_about where is_show order by sortid asc");
while($row=$db->fetch_array($query))
{
     if(!empty($row["url"]))
	 {
	    $url=$row["url"];
	 }
	 else
	 {
	    $url=$site["url"]."/a/".$row["filename"].".html";
	 }
?>
<a target="_blank" href="<?php echo $url;?>"><?php echo stripslashes($row["title"]);?></a> | 
<?php
}
?>
</p><p id=b><?php echo $config["copyright"];?> <a href=#>ʹ��<?php echo $site["name"];?>ǰ�ض�</a> <a href=http://www.miibeian.gov.cn target=_blank><?php echo $site["icp"];?></a>
<!--Powered by <a target="_blank" href="http://www.zeidu.com/">ZeiDu</a>-->&nbsp;<a target="_blank" href="http://www.miibeian.gov.cn/"><?php echo $config["icp"];?></a><img src=images/gs.gif>
</p>
<?php
}
?>
<?php
function pageshow($page,$totalpage,$total,$filename)
{   
    $str="<div class=\"pagestyle\">";
    $str=$str."<a href=\"".$filename."page=1\">��һҳ</a>&nbsp;";
    if($page==1)
    {
        $str=$str."��һҳ&nbsp;";
    }
    else
    {
        $str=$str."<a href=\"".$filename."page=".($page-1)."\">��һҳ</a>&nbsp;";
    }

 if ($page>=$totalpage)
 {
   $str=$str."��һҳ&nbsp;";
 }
 else
 {
   $str=$str."<a href=\"".$filename."page=".($page+1)."\">��һҳ</a>&nbsp;";
 }
$str=$str."<a href=\"".$filename."page=$totalpage\">���һҳ</a>&nbsp;";
$str=$str."��ǰ��".$page."ҳ&nbsp;";
$str=$str."��".$totalpage."ҳ&nbsp;";
$str=$str."��".$total."����¼&nbsp;";
$str=$str."</div>";
return $str;
}
?>