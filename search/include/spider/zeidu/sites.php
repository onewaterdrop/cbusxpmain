<?php
require "global.php";
set_time_limit(0);
?>
<link rel="stylesheet" href="xp.css" type="text/css">
            <table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
              <tr> 
              <td> 
<a href="?action=addform">�����վ</a>&nbsp;&nbsp;&nbsp;
<a href="?action=update_all_qp">��������QP</a>&nbsp;&nbsp;&nbsp;<a href="?action=update_not_qp">���»�ûδ���µ�QP</a>
</td>
</tr>
</table>
<table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
              <tr> 
              <td> 
<?php
$action=$_GET["action"];
switch ($action)
{
    case "saveform":
    saveform();
    break;
    case "addform":
	addform($action);
	break;
	case "modify":
	addform($action);
	break;

	case "options":
	options(intval($_GET["site_id"]));
	break;
	case "dell_links":
	dell_links(HtmlReplace($_GET["url"]));
	break;

	case "del":
	     $site_id=intval($_GET["site_id"]);
		 $db->query("delete from ve123_sites where site_id='".$site_id."'");
	break;
	case "add_in_site_link":
	   echo "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"50%\"><iframe src=\"start.php?action=add_in_site_link&url=".$_GET["url"]."\" height=\"450\" width=\"98%\"></iframe></td><td width=\"50%\"><iframe src=\"start.php?action=update_in_site_link&url=".$_GET["url"]."\" height=\"450\" width=\"98%\"></iframe></td></tr></table><br>";
	break;
	case "update_in_site_all_links":
	$url=$_GET["url"];
	echo "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td width=\"50%\"><iframe src=\"start.php?action=update_in_site_link&url=".$url."\" height=\"450\" width=\"98%\"></iframe></td><td width=\"50%\"></td></tr></table><br>";
	break;
	case "update_qp":
	$url=$_GET["url"];
	echo "<iframe src=\"start.php?action=update_qp&url=".$url."\" height=\"100\" width=\"100%\"></iframe>";
	break;
	case "update_all_qp":
	$url=$_GET["url"];
	echo "<iframe src=\"start.php?action=update_all_qp&url=".$url."\" height=\"100\" width=\"100%\"></iframe>";
	break;
	case "update_not_qp":
	$url=$_GET["url"];
	echo "<iframe src=\"start.php?action=update_not_qp&url=".$url."\" height=\"100\" width=\"100%\"></iframe>";
	break;
}	
?>
</td>
</tr>
</table>
<?php
$url=(trim($_POST["url"]));
?>
<form id="search_form" name="search_form" method="post" action="?action=search">
<table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
  <tr>
    <td width="100">��վ��ַ:</td>
    <td><input type="text" name="url" value="<?php echo $url;?>"/>
      <input type="submit" name="Submit2" value="����" /></td>
  </tr>
</table>
</form>
<table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">

  <tr>
    <th width="100">ID</th>
    <th>��վ��ַ</th>
    <th width="80">�������</th>
    <th width="80">qp</th>
    <th width="200">����</th>
  </tr>
  <?php
  if($action=="search")
  { 
        $where=" where";
		if(!empty($url))
		{
			$where.=" url like '%".$url."%'";
		}
		else
		{
		    $where="";
		}
  }
  $sql="select * from ve123_sites".$where;
  $result=$db->query($sql);
  $total=$db->num_rows($result);//��¼����
  $pagesize=30;//ÿҳ��ʾ��
  $totalpage=ceil($total/$pagesize);
  $page=intval($_GET["page"]);
  if($page<=0){$page=1;}
  $offset=($page-1)*$pagesize;
  $result=$db->query($sql." order by site_id desc limit $offset,$pagesize");
  while ($row=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $row["site_id"]?></td>
    <td><?php echo "<a href=\"".$row["url"]."\" target=\"_blank\">".$row["url"]."</a>";?></td>
    <td><?php echo $row["spider_depth"];?></td>
    <td><font style="float:left;"><?php echo $row["qp"]?></font><font style="float:right;"><a href="?action=update_qp&url=<?php echo $row["url"];?>">����</a></font></td>
    <td>
	
	<a href="?action=options&amp;site_id=<?php echo $row["site_id"]?>">��ϸѡ��</a>
	
	<a href="?action=del&site_id=<?php echo $row["site_id"];?>" onclick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a>	</td>
  </tr>
  <?php
  }
  ?>
</table>
 <table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
 <tr><td>
<?php
echo pageshow($page,$totalpage,$total,"?");
?></td></tr></table>
<?php
function addform($do_action)
{
global $db;
  if ($do_action=="modify")
  {
      $site_id=intval($_GET["site_id"]);
	  $sql="select * from ve123_sites where site_id='$site_id'";
	  $row=$db->get_one($sql);
	  $url=$row["url"];
	  $qp=$row["qp"];
	  $spider_depth=$row["spider_depth"];
	  $include_word=$row["include_word"];
	  $not_include_word=$row["not_include_word"];
	  $btn_txt="ȷ���޸�";
  }
  else
  {
     $spider_depth="0";
     $btn_txt="ȷ���ύ";
  }
?>
 <table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
<form id="form1" name="form1" method="post" action="?action=saveform">
  <tr>
    <td width="100">��վ��ַ:</td>
    <td><input name="url" type="text" value="<?php echo $url?>" size="60" /></td>
  </tr>
  <tr style="display:none">
    <td>qp:</td>
    <td><input name="qp" type="text" value="<?php echo $qp;?>" size="60" />
    (ֵԽ��,����Խ��ǰ)</td>
  </tr>
  <tr>
    <td>�������:</td>
    <td><input name="spider_depth" type="text" value="<?php echo $spider_depth;?>"/>
      (0��ʾֻ����ҳ,1��ʾ����ҳ��������������)</td>
  </tr>
  <tr>
    <td>����ĳ�ֶ�</td>
    <td><textarea name="include_word" cols="60" rows="6"><?php echo $include_word;?></textarea>
      (����ĳ�ֶε����Ӳ�ץȡ,Ϊ�ձ�ʾ������,ÿ�������ԷֺŸ���)</td>
  </tr>
  <tr>
    <td>������ĳ�ֶ�</td>
    <td><textarea name="not_include_word" cols="60" rows="6"><?php echo $not_include_word;?></textarea>
      (Ϊ�ձ�ʾ������,ÿ�������ԷֺŸ���)</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="site_id" value="<?php echo $site_id?>">
	<input type="hidden" name="do_action" value="<?php echo $do_action?>">
	<input type="submit" name="Submit" value="<?php echo $btn_txt?>" />
	<?php
	if($do_action=="modify")
	{
	   echo "<a href=\"?action=options&site_id=".$site_id."\">��ϸѡ��</a>";
	}
	?>	</td>
  </tr>
  </form>
</table>
<?php
}
?>
<?php
function options($site_id)
{
    global $db;
	$row=$db->get_one("select * from ve123_sites where site_id='".$site_id."'");
	
?>
            <table width="98%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolordark="#FFFFFF" bordercolor="888888">
<form id="form1" name="form1" method="post" action="?action=saveform">
  <tr>
    <td width="100">��ַ:</td>
    <td><?php echo "<a target=\"_blank\" href=\"".$row["url"]."\">".$row["url"];?></a></td>
  </tr>
  <!--<tr>
    <td>�ϴθ���ʱ��:</td>
    <td><?php echo date("Y-m-d H:i:s",$row["indexdate"]);?></td>
  </tr>-->
  <tr>
    <td>����¼��ҳ:</td>
    <td><font class="red"><?php echo count_links($row["url"]);?></font>&nbsp;ҳ</td>
  </tr>
  <tr>
    <td>�������:</td>
    <td><font class="red"><?php echo $row["spider_depth"];?></font>&nbsp;(0��ʾֻ����ҳ)</td>
  </tr>
  <tr>
    <td>�������:</td>
    <td>
	<!--<a href="?action=update_qp&site_id=<?php echo $row["site_id"];?>">����qp</a>
	
	-->
	<a href="?action=add_in_site_link&url=<?php echo $row["url"];?>">��¼�µ���ҳ</a>
	<a href="?action=update_in_site_all_links&amp;url=<?php echo $row["url"]?>">����������ҳ</a>
	<a href="links.php?action=search&amp;url=<?php echo $row["url"]?>">�������¼����ҳ</a>
	<a onclick="if(!confirm('ȷ��ɾ����?')) return false;" href="?action=dell_links&amp;url=<?php echo $row["url"]?>">ɾ��������ҳ</a>
	<a href="?action=modify&amp;site_id=<?php echo $row["site_id"]?>">�޸�</a>	</td>
  </tr>
    </form>
</table>
<?php
}
?>
<?php
function saveform()
{
global $db;
   $url=trim($_POST["url"]);
   $qp=trim($_POST["qp"]);
   $spider_depth=intval($_POST["spider_depth"]);
   $include_word=$_POST["include_word"];
   $not_include_word=$_POST["not_include_word"];
   $site_id=$_POST["site_id"];
   $do_action=$_POST["do_action"];
   if ($do_action=="modify")
   {
     $array=array('url'=>$url,'qp'=>$qp,'spider_depth'=>$spider_depth,'include_word'=>$include_word,'not_include_word'=>$not_include_word);
	 $db->update("ve123_sites",$array,"site_id='$site_id'");
	 jsalert("�޸ĳɹ�");
   }
   else
   {
         $row=$db->get_one("select * from ve123_sites where url like '%".$url."%'");
		 if(empty($row))
		 {
		    $array=array('url'=>$url,'qp'=>$qp,'spider_depth'=>$spider_depth,'include_word'=>$include_word,'not_include_word'=>$not_include_word);
	        $db->insert("ve123_sites",$array);
            jsalert("�ύ�ɹ�");
		}
		else
		{
		    jsalert($url."��ַ�Ѵ���");
		}
   }
}
function count_links($url)
{
   global $db;
   $domain=getdomain($url);
   $query=$db->query("select link_id from ve123_links where title<>'' and url like '%".$domain."%' ");
   return $db->num_rows($query);
}
function dell_links($url)
{
   global $db;
   $db->query("delete from ve123_links where url like '%".$url."%'");
   jsalert("ɾ���ɹ�");
}
?>
