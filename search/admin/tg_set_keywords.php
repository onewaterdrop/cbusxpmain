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
	$db->query("delete from ve123_tg_set_keywords where key_id='".intval($_GET["key_id"])."'");
	break;
}	
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">

  <tr>
    <th width="50">ID</th>
    <th>�ؼ���</th>
    <th width="80">��ͼ۸�</th>
    <th width="80">����</th>
  </tr>
  <?php
  $result=$db->query("select * from ve123_tg_set_keywords");
  while ($rs=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $rs["key_id"]?></td>
    <td><?php echo $rs["keywords"];?></td>
    <td><?php echo $rs["price"];?></td>
    <td><a href="?action=modify&key_id=<?php echo $rs["key_id"];?>">�޸�</a>&nbsp;&nbsp;<a href="?action=del&key_id=<?php echo $rs["key_id"];?>" onClick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a></td>
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
      $key_id=intval($_GET["key_id"]);
	  $sql="select * from ve123_tg_set_keywords where key_id='$key_id'";
	  $rs=$db->get_one($sql);
	  $keywords=$rs["keywords"];
	  $price=$rs["price"];
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
    <td>��ͼ۸�:</td>
    <td><input name="price" type="text" size="50"  value="<?php echo $price?>"/></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="key_id" value="<?php echo $key_id?>">
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
   $price=trim($_POST["price"]);
   $key_id=intval($_POST["key_id"]);
   $do_action=$_POST["do_action"];
   if ($do_action=="modify")
   {
	 $array=array('keywords'=>$keywords,'price'=>$price);
	 $db->update("ve123_tg_set_keywords",$array,"key_id='$key_id'");
	 jsalert("�޸ĳɹ�");
   }
   else
   {     
             $array=array('keywords'=>$keywords,'price'=>$price);
	         $db->insert("ve123_tg_set_keywords",$array);  
			 jsalert("�ύ�ɹ�");
   }
}
?>

