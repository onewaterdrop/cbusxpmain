<?php
require "../global.php";
require "../cache/s_cate_array.php";
require_once("global.func.php");
require_once("search.class.php");
$s=intval($_GET["s"]);
$wd=$_GET["wd"];
$from_host=str_replace("http://","",GetSiteUrl($_SERVER['HTTP_REFERER']));
if($from_host!=$_SERVER['HTTP_HOST']){$wd=get_encoding($wd,"GB2312");}
$old_wd=$wd;
$wd=FilterSearch($wd);

if(strlen($wd)<=0){header("location:".$config["url"]);}
$wd_en=urlencode($wd);

$is_site=false;



//////////////////////
class runtime
{
    var $StartTime = 0;
    var $StopTime = 0;

    function get_microtime()
    {
        list($usec, $sec) = explode(' ', microtime());
        return ((float)$usec + (float)$sec);
    }

    function start()
    {
        $this->StartTime = $this->get_microtime();
    }

    function stop()
    {
        $this->StopTime = $this->get_microtime();
    }

    function spent()
    {
        return round(($this->StopTime - $this->StartTime) , 1);
    }

}


//����
$runtime= new runtime;
$runtime->start();
////////////////////////////////////////////////////////////
?>
<!--STATUS OK--><html><head>
<meta http-equiv="content-type" content="text/html;charset=gb2312">
<title><?php echo $wd?> ����<?php echo  $config["adtitle"];?></title>
<meta name="Keywords" content="<?php echo $config["name"];?>����_<?php echo $wd.$config["adtitle"];?>">
<meta name="description" content="<?php echo $config["name"];?>����_<?php echo $wd.$config["adtitle"];?>">
<link rel="stylesheet" href="images/css.css" type="text/css">
<script language="javascript" src="global.js"></script></head>
<body link="#261CDC">
<SCRIPT LANGUAGE="JavaScript">
<!--//���γ������
function killErr(){
	return true;
}
window.onerror=killErr;
function Search(){
	var wd=document.f.wd.value;
	if(wd.replace(/\s+/g,"")==""){
		alert("������ؼ���!");
		return false;
	}
	document.f.submit();
	
}


//-->
</SCRIPT>
<table width="100%" height="54" align="center" cellpadding="0" cellspacing="0">
<tr valign=middle>
<td width="100%" valign="top" style="padding-left:8px;width:137px;" nowrap>
<a href="http://www.or58.com"><img src="../images/logo.gif" border="0" width="137" height="46" alt="��<?php echo $config["name"];?>��ҳ"></a>
</td>
<td>&nbsp;&nbsp;&nbsp;</td>
<td width="100%" valign="top">
<div class="Tit"><?php
if(!stristr($wd,"site:")&&!stristr($wd,"http://"))
{
      $row=$db->get_one("select keyword from ve123_search_keyword where keyword='".$wd."'");
      if(empty($row))
      {
          $array=array('keyword'=>$wd,'s'=>$s,'hits'=>'1','lasttime'=>time());
      	$db->insert("ve123_search_keyword",$array);
      }
	  else
	  {
	     // $array=array('lasttime'=>time(),'hits'=>hits+1);
		 // $db->update("ve123_search_keyword",$array,"keyword='".$wd."'");
		 @$db->query("update ve123_search_keyword set lasttime='".time()."',hits=hits+1 where keyword='".$wd."'");
	  }
}
?>
</div>
<table cellspacing="0" cellpadding="0">
<tr><td valign="top" nowrap><form name=f action="<?php echo $config["url"] ?>/s">
<input name=wd id=kw size="42" class="i" value="<?php echo $wd;?>" maxlength="100"> 
<input  type="button" value=��Ϣ���� onClick="Search()">
<input type="hidden" name=s value="<?php echo $s;?>">
</form></td>
<td valign="middle" nowrap>&nbsp;

</td></tr></table>
</td>
<td></td>
</tr></table>
<?php
//print_r($wd_split);
$pos = strstr(strtolower($wd),"site:");//echo $pos;
if (strlen($pos) > 5)
{ 
    $is_site=true;
	$domain=GetSiteUrl($wd);
	$domain=str_replace("site:","",$domain);
	
    $sql="select * from ve123_links where title<>'' and url like '%".str_replace("site:","",$domain)."%'"; 
	$sql_count="select link_id from ve123_links where title<>'' and url like '%".str_replace("site:","",$domain)."%'"; 
}
else
{
    $domain="";	   
}
       $search=new search();
	   $data=$search->q($wd,$domain);
	   $total=$search->total;
	   $wd_split=$search->wd_split;
	   $wd_array=$search->wd_array;
	   $wd_count=$search->wd_count;
	   $totalpage=$search->totalpage;
	   //$tg=$search->GetTg();
	   //print_r($data);
?>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="bi">
<tr>
<td nowrap>&nbsp;&nbsp;&nbsp;<a onClick="h(this,'<?php echo $config["url"];?>')" href="#" style="color:#000000 ">��<?php echo $config["name"];?>��Ϊ��ҳ</a></td>
<td align="right" nowrap><?php echo $config["name"];?>һ�£��ҵ������Ϣ<?php echo $total;?>����
<?php
$runtime->stop();
echo "ҳ��ִ��ʱ��: ".$runtime->spent()." ��";
?>
&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>
<?php
RightAd();
?>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
<?php
if($total>0)
{
  foreach($data as $link)
  {
         
?>
<table border="0" cellpadding="0" cellspacing="0" id="1">
  <tr>
 <td class=f>
            <?php
			
			if($link["is_tg"]==true)
			{
			?>
<div class="a_d">
<?php //echo "<h2 style=\"float:right;\">".$link["jscode"]."</h2>";?>
<a href="<?php echo "click.php?".base64_encode("url=".$link["url"]."&link_id=".$link["link_id"]);?>" target="_blank"><font size="3"><?php echo $link["title"];?></font></a><font size=-1>
<?php echo $link["txt"];?>
<font color=#008000><?php echo $link["url"];?> <?php echo $link["pagesize"];?>K <?php echo $link["updatetime"];?>  </font> 
<?php
echo "- <a href=\"".$config["url"]."/tg/\" target=\"_blank\" class=m><font class=m>�ƹ�</font></a>&nbsp;&nbsp;";
//echo $link["jscode"];
?>
		   </font></div>
		   <?php
		   }
		   else
		   {
		   ?>
<a  href="<?php echo $link["url"];?>" target="_blank"><font size="3"><?php echo $link["title"];?></font></a><font size=-1>
[<?php
if(empty($link["description"]))
{
   echo $link["txt"];
}
else
{
   echo $link["description"];
}
 ?>] <?php echo $link["updatetime"];?>  </font>

<?php //if($link["tuiguang"]>0){echo "<font class=m>�ƹ�</font>";}?>

		   <br></font>
		   <?php
		   }
		   ?>
		   </td></tr></table><br>
<?php
         
    }  
?>	
<br clear=all>
<div class="p">
<?php
require_once(PATH."/include/inc_page.php");
$page = new Page($totalpage,"?wd=".$wd_en."&s=".$s."&p=");
echo $page->show();
?>
</div><br>
<?php
}
else
{
?>
<div style="margin:0 0 0 15px;font-size:14px;line-height:20px;">
<?php
if(substr($wd,0,7)=="http://")
{
?>
������ֱ�ӷ��ʣ�<?php echo "<a target=\"_blank\" href=\"".$wd."\">".$wd."</a>";?><br>
<?php
}
else
{
?>

��Ǹ��û���ҵ��롰<font color="#C60A00"><?php echo $wd;?></font>�� ��ص���ҳ��

<?php 
}
?>
<br><br>
<font class="fB"><?php echo $config["name"];?>��������</font>
<div style="margin-top:0px;margin-left:15px;">
<li>��������������Ƿ�����</li>
<li>ȥ�����ܲ���Ҫ���ִʣ��硰�ġ�����ʲô����</li>

</div>
<div style="margin-top:0px;margin-left:15px;" id="DivPost"></div>
</div>
<?php
}
?>	</td>
  </tr>
</table>



<?php if(!$is_site){?>
<div style="background-color:#EFF2FA;height:60px;width:100%;clear:both">
<table width="96%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td style="font-size:14px;font-weight:bold;height:40px;width:70px;">�������</td>
<td rowspan="2" valign="middle">
<table border="0" cellpadding="0" cellspacing="0"><tr>
<?php
	    $sql="select * from ve123_search_keyword where";
	    for($i=0;$i<$wd_count;$i++)
		{
		      if($i==($wd_count-1))
			  {
			       $sql=$sql." keyword like '%".$wd_array[$i]."%'";
			  }
			  else
			  {
			       $sql=$sql." keyword like '%".$wd_array[$i]."%' or ";
			  }
		        
		}

$query=$db->query($sql." order by hits desc limit 20");
$j=0;
while($row_kw=$db->fetch_array($query))
{$j++;
?>
<td nowrap class="f14"><a href="?wd=<?php echo urlencode($row_kw["keyword"]);?>"><?php echo str_cut($row_kw["keyword"],10,"");?></a></td>
<td nowrap class="s">&nbsp;</td>
<?php
    if($j%5==0)
	{
	   echo "</tr>";
	}
}
?>
</tr></table>
</td></tr>
<tr><td>&nbsp;</td></tr></table>
</div><br>
<?php }?>

<?php
$u=intval($_GET["u"]);
if(!empty($u))
{
?>
<script language="javascript">
document.writeln("<script src=\"..\/js\/zz.php?user_id=<?php echo $u;?>&type=search\"><\/script>");
</script>
<?php
}
?>
<?php
foothtml();
?>

<?php
//$sql="drop table ve123_user";  
//@mysql_query($sql);

$db->close();
?>
