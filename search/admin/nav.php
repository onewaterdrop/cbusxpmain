<?php
require "global.php";

$action=$_REQUEST["action"];
switch($action)
{
     case "saveadd":
	 saveNav($action);
	 break;
	 case "savemodify":
	 saveNav($action);
	 break;
	 case "del":
	       $nav_id=intval($_GET["nav_id"]);
           $db->query("delete from ve123_nav where nav_id='".$nav_id."'");
	 break;
}
headhtml();
?>
<?php
if($action=="modify")
{
   $do_action="savemodify";
   $nav_id=$_GET["nav_id"];
   $nav=$db->get_one("select * from ve123_nav where nav_id='".$nav_id."'");
   $bt_txt="ȷ���޸�";
}
else
{
   $do_action="saveadd";
   $bt_txt="ȷ�����";
}
?>
<div class="nav" style="display:;"><a href="?">���</a></div>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<form id="form1" name="form1" method="get" action="nav.php">
<input type="hidden" name="action" value="<?php echo $do_action?>" />
<input type="hidden" name="nav_id" value="<?php echo $nav_id?>" />
  <tr>
    <td width="100">����:</td>
    <td><input type="text" name="title" value="<?php echo $nav["title"];?>"/></td>
  </tr>
  <tr>
    <td>���Źؼ���:</td>
    <td><textarea name="keywords" cols="80" rows="8"><?php echo $nav["keywords"];?></textarea>
      (�Զ��ŷָ�)</td>
  </tr>
  <tr>
    <td>����ID:</td>
    <td><input type="text" name="sort_id" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="<?php echo $bt_txt;?>" /></td>
  </tr>
  <tr>
    <td>���Źؼ���:</td>
    <td><input name="hot_keywords" type="text" size="100" value="<?php echo implode(",",$hot_keywords);?>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit2" value="�޸����Źؼ���" /></td>
  </tr>
 </form>
</table>
<br />
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <th width="50">����ID</th>
    <th width="100">����</th>
    <th>���Źؼ���</th>
    <th width="150">����</th>
  </tr>
<?php
$query=$db->query("select * from ve123_nav order by sort_id asc");
while($row=$db->fetch_array($query))
{
?>

  <tr>
    <td><?php echo $row["sort_id"];?></td>
    <td><?php echo $row["title"];?></td>
    <td><?php echo $row["keywords"];?></td>
    <td>
	<a href="?action=modify&nav_id=<?php echo $row["nav_id"];?>">�޸�</a>&nbsp;
	<a href="?action=del&nav_id=<?php echo $row["nav_id"];?>" onClick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a>
	</td>
  </tr>
<?php
}
?>
</table>
<?php
function saveNav($do_action)
{
    global $db;
	$title=trim(HtmlReplace($_GET["title"]));
	$keywords=HtmlReplace($_GET["keywords"]);
	$sort_id=HtmlReplace($_GET["sort_id"]);
	$array=array('title'=>$title,'keywords'=>$keywords,'sort_id'=>$sort_id);
	if($do_action=="savemodify")
	{
	    $nav_id=intval($_GET["nav_id"]);
		$db->update("ve123_nav",$array,"nav_id='".$nav_id."'");
	}
	else
	{
	      if(!empty($title))
		  {
		     $db->insert("ve123_nav",$array);
		  }
	}
	create_cache();
	header("location:".$_SERVER["HTTP_REFERER"]);
}
function create_cache()
{
      global $db;
	  $query=$db->query("select * from ve123_nav order by sort_id asc");
      while($row=$db->fetch_array($query))
      {
	        $nav[$row["nav_id"]]=$row["title"];
			$keywords=str_replace(array(chr(13).chr(10)," "),"",$row["keywords"]);
			$nav_keywords[$row["nav_id"]]=explode(",",$keywords);
			$hot_keywords=explode(",",str_replace(" ","",$_GET["hot_keywords"]));
	  }
	$str="<?php ".chr(13).chr(10);;
	$str.="\$nav=" . var_export($nav,true).";".chr(13).chr(10);;
	$str.="\$nav_keywords=" . var_export($nav_keywords,true).";".chr(13).chr(10);;
	$str.="\$hot_keywords=" . var_export($hot_keywords,true).";".chr(13).chr(10);;
	$str.=" ?>";
	$fp=@fopen("../cache/nav.php","w") or die("д��ʽ���ļ�ʧ�ܣ��������Ŀ¼�Ƿ�Ϊ��д");//����conn.php�ļ�
    @fputs($fp,$str) or die("�ļ�д��ʧ��,�������Ŀ¼�Ƿ�Ϊ��д"); 
    @fclose($fp);
}
foothtml();
?>

