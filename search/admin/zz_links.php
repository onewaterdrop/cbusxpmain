<?php
require "global.php";
headhtml();
?>
<div class="nav" style="display:;"><a href="?">��ҳ</a><a href="?action=addform&p_cid=<?php echo $p_cid?>">���</a></div>
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
	
	case "del":
	$db->query("delete from ve123_zz_links where link_id='".intval($_GET["link_id"])."'");
	break;
}	
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">

  <tr>
    <th width="50">ID</th>
    <th>�ؼ���</th>
    <th>��ҳ����</th>
    <th>URL ��ַ</th>
    <th>&nbsp;</th>
    <th width="80">����</th>
    <th width="80">����</th>
  </tr>
  <?php
  $result=$db->query("select * from ve123_zz_links");
  while ($rs=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $rs["link_id"]?></td>
    <td><?php echo $rs["keywords"];?></td>
    <td><?php echo $rs["title"];?></td>
    <td><?php echo "<a target=\"_blank\" href=\"".$rs["url"]."\">".$rs["url"]."</a>";?></td>
    <td>&nbsp;</td>
    <td><?php echo $rs["price"];?></td>
    <td><a href="?action=modify&link_id=<?php echo $rs["link_id"];?>">�޸�</a>&nbsp;&nbsp;<a href="?action=del&link_id=<?php echo $rs["link_id"];?>" onClick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a></td>
  </tr>
  <?php
  }
  ?>
</table>

<?php
function addform($do_action)
{
global $db,$p_cid;
  if ($do_action=="modify")
  {
      $link_id=intval($_GET["link_id"]);
	  $sql="select * from ve123_zz_links where link_id='$link_id'";
	  $rs=$db->get_one($sql);
	  $keywords=$rs["keywords"];
	  $title=$rs["title"];
	  $url=$rs["url"];
	  $description=$rs["description"];
	  $jscode=$rs["jscode"];
	  $price=$rs["price"];
	  $pic=$rs["pic"];
	  $sort_id=$rs["sort_id"];
	  $btn_txt="ȷ���޸�";
  }
  else
  {
     $btn_txt="ȷ�����";
  }
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<form id="form1" name="form1" method="post" action="?action=saveform">
  <tr>
    <td width="100">�ؼ���:</td>
    <td>
      <input name="keywords" type="text" value="<?php echo $keywords?>" size="50" /></td>
  </tr>
  <tr>
    <td>��ҳ����:</td>
    <td><input name="title" type="text" value="<?php echo $title?>" size="50" /></td>
  </tr>
  <tr>
    <td>URL ��ַ:</td>
    <td><input name="url" type="text" value="<?php echo $url?>" size="50" /></td>
  </tr>
  <tr>
    <td>��ҳ����:</td>
    <td><textarea name="description" cols="80" rows="8"><?php echo $description?></textarea></td>
  </tr>
  <tr>
    <td>JS����:</td>
    <td><textarea name="jscode" cols="80" rows="8"><?php echo $jscode?></textarea></td>
  </tr>
  <tr>
    <td>ͼƬ:</td>
    <td><input name="pic" type="text" size="80" value="<?php echo $pic;?>"/>
      (ͼƬ,flash,��Ƶ)</td>
  </tr>
  <tr>
    <td>����:</td>
    <td><input name="price" type="text" size="50"  value="<?php echo $price?>"/></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="link_id" value="<?php echo $link_id?>">
	<input type="hidden" name="do_action" value="<?php echo $do_action?>">
	<input type="submit" name="Submit" value="<?php echo $btn_txt?>" />	</td>
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
   $keywords=trim($_POST["keywords"]);
   $title=trim($_POST["title"]);
   $url=trim($_POST["url"]);
   $description=trim($_POST["description"]);
   $jscode=my_addslashes(trim($_POST["jscode"]));
   $price=trim($_POST["price"]);
   $pic=trim($_POST["pic"]);
   $link_id=intval($_POST["link_id"]);
   $do_action=$_POST["do_action"];
   if ($do_action=="modify")
   {
	 $array=array('keywords'=>$keywords,'title'=>$title,'url'=>$url,'description'=>$description,'jscode'=>$jscode,'price'=>$price,'pic'=>$pic);
	 $db->update("ve123_zz_links",$array,"link_id='$link_id'");
	 jsalert("�޸ĳɹ�");
   }
   else
   {     
             $array=array('keywords'=>$keywords,'title'=>$title,'url'=>$url,'description'=>$description,'jscode'=>$jscode,'price'=>$price,'pic'=>$pic);
	         $db->insert("ve123_zz_links",$array);  
			 jsalert("�ύ�ɹ�");
   }
}
?>

