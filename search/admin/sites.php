<?php
require "global.php";
headhtml();
set_time_limit(0);
?>
<div class="nav" style="display:;"><a href="?action=addform">���</a></div>
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
	case "update_qp":
	update_qp(intval($_GET["site_id"]));
	break;
	case "update_all_qp":
	update_all_qp();
	break;
	case "links_to_sites":
	links_to_sites();
	break;
	case "options":
	options(intval($_GET["site_id"]));
	break;
	case "dell_links":
	dell_links(HtmlReplace($_GET["url"]));
	break;
	case "update_all_site_id":
	update_all_site_id();
	break;
	case "del":
	     $site_id=intval($_GET["site_id"]);
		 $db->query("delete from ve123_sites where site_id='".$site_id."'");
	break;
	case "dolistform":
	dolistform();
	break;
}	
?>
<?php
$url=HtmlReplace(trim($_POST["url"]));
?>
<form id="search_form" name="search_form" method="post" action="?action=search">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <td width="100">��վ��ַ:</td>
    <td><input type="text" name="url" value="<?php echo $url;?>"/>
      <input type="submit" name="Submit2" value="����" /></td>
  </tr>
</table>
</form>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">

  <tr>
    <th width="100">ID</th>
    <th>��վ��ַ</th>
    <th width="80">�������</th>
    <th width="80">qp</th>
    <th width="200">����</th>
    <th width="50">ѡ��</th>
  </tr><form id="listform" name="listform" method="post" action="?action=dolistform" onsubmit="return checkform();">
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
    <td><?php echo $row["qp"]?></td>
    <td>
	
	<a href="?action=options&amp;site_id=<?php echo $row["site_id"]?>">��ϸѡ��</a>
	
	<a href="?action=del&site_id=<?php echo $row["site_id"];?>" onclick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a>	</td>
    <td><input type="checkbox" name="site_id[]" value="<?php echo $row["site_id"]?>" /></td>
  </tr>

  <?php
  }
  ?>
  <tr>
    <td colspan="6">
<div align="center"> 
                <input name="chkall" type="checkbox" id="chkall" onclick=CheckAll(this.form,'site_id[]') value="checkbox">
                ѡ�б�ҳ��ʾ����Ϣ <strong>������</strong> 
                
				<input name="do_action" type="radio" value="del" checked="checked">
                ɾ��&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type="submit" name="Submit" value=" ִ �� ">
</div>
	</td>
  </tr></form>
</table>
<?php
echo pageshow($page,$totalpage,$total,"?");
?>
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
	  $btn_txt="ȷ���޸�";
  }
  else
  {
     $spider_depth="0";
     $btn_txt="ȷ���ύ";
  }
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<form id="form1" name="form1" method="post" action="?action=saveform">
  <tr>
    <td width="100">��վ��ַ:</td>
    <td><input name="url" type="text" value="<?php echo $url?>" size="80" /></td>
  </tr>
  <tr>
    <td>qp:</td>
    <td><input name="qp" type="text" value="<?php echo $qp;?>" size="80" /></td>
  </tr>
  <tr>
    <td>�������:</td>
    <td><input name="spider_depth" type="text" value="<?php echo $spider_depth;?>"/>
      (0��ʾֻ����ҳ,1��ʾ����ҳ��������������)</td>
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
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
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
	<!--<a href="?action=update_qp&site_id=<?php echo $row["site_id"];?>">����qp</a>-->
	
	<!--<a href="spider.php?action=update_links&amp;site_id=<?php echo $row["site_id"]?>">����������ҳ</a>
	<a href="spider.php?action=add_new_page&amp;site_id=<?php echo $row["site_id"]?>">��¼�µ���ҳ</a>-->
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
   $site_id=$_POST["site_id"];
   $do_action=$_POST["do_action"];
   if ($do_action=="modify")
   {
     $array=array('url'=>$url,'qp'=>$qp,'spider_depth'=>$spider_depth);
	 $db->update("ve123_sites",$array,"site_id='$site_id'");
	 jsalert("�޸ĳɹ�");
   }
   else
   {
     $array=array('url'=>$url,'qp'=>$qp,'spider_depth'=>$spider_depth);
	 $db->insert("ve123_sites",$array);
     jsalert("�ύ�ɹ�");
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
function update_all_qp()
{
    global $db;
	$query=$db->query("select * from ve123_sites");
	while($row=$db->fetch_array($query))
	{
	     update_qp($site_id);
		 sleep(1);
	}
}
function update_qp($site_id)
{
    global $db;
	$row=$db->get_one("select * from ve123_sites where site_id='".$site_id."'");
	$url=get_site_url($row["url"])."/";
    $qp=GetPR($url)+1;
	$array=array('qp'=>$qp);
	$db->update("ve123_sites",$array,"site_id='".$site_id."'");
}
function links_to_sites()
{
     global $db;
	 $query_links=$db->query("select * from ve123_links");
	 while($row_links=$db->fetch_array($query_links))
	 {
	       $url=get_site_url($row_links["url"]);
		   $query=$db->query("select * from ve123_sites where url='$url'");
	       $num=$db->num_rows($query);
		   if($num==0)
		   {
		        $array=array('url'=>$url,'addtime'=>time());
		        $db->insert("ve123_sites",$array);
				
		   }
	 }
}
function update_all_site_id()
{
    global $db;
	$query=$db->query("select * from ve123_sites");
	while($row=$db->fetch_array($query))
	{
	    $array=array('site_id'=>$row["site_id"]);
		$db->update("ve123_links",$array,"url like '%".$row["url"]."%'");
	}
}
function dolistform()
{
   global $db;
   $site_id=$_POST["site_id"];
   $do_action=HtmlReplace($_POST["do_action"]);
   for($i=0;$i<count($site_id);$i++)
   {
       $site_id_str=$site_id_str.$site_id[$i].",";
   }
   $site_id_str=rtrim($site_id_str,",");
   if(empty($site_id_str)){return;}
   if($do_action=="del")
   {
       $sql="delete from ve123_sites where site_id in(".$site_id_str.")";
   }
   $db->query($sql);
   header("location:".$_SERVER['HTTP_REFERER']);
}
?>

