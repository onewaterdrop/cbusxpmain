<?php
require "global.php";
headhtml();
?>
<div class="nav" style="display:none;"><a href="?action=addform">���</a></div>
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
	case "dell_all_submit":
	      $db->query("delete from ve123_url_submit");
	break;
	
	case "del":
	     $submit_id=intval($_GET["submit_id"]);
		 $db->query("delete from ve123_url_submit where submit_id='".$submit_id."'");
	break;
}	
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <td><a onclick="if(!confirm('ȷ��ɾ����?')) return false;" href="?action=dell_all_submit">ɾ�����ύ��վ</a></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">

  <tr>
    <th width="100">ID</th>
    <th>��ַ</th>
    <th width="120">�ύʱ��</th>
    <th width="80">IP</th>
    <th width="80">����</th>
  </tr>
  <?php
  $sql="select * from ve123_url_submit";
      $result=$db->query($sql);
      $total=$db->num_rows($result);//��¼����
      $pagesize=30;//ÿҳ��ʾ��
      $totalpage=ceil($total/$pagesize);
      $page=intval($_GET["page"]);
      if($page<=0){$page=1;}
      $offset=($page-1)*$pagesize;
  $result=$db->query($sql." order by submit_id desc limit $offset,$pagesize");
  while ($rs=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $rs["submit_id"]?></td>
    <td><?php echo "<a href=\"".$rs["url"]."\" target=\"_blank\">".$rs["url"]."</a>";?></td>
    <td><?php echo date("Y-m-d H:i:s",$rs["addtime"]);?></td>
    <td><?php echo $rs["ip"];?></td>
    <td>
	<a href="?action=modify&amp;submit_id=<?php echo $rs["submit_id"]?>">�޸�</a>
	<a href="?action=del&submit_id=<?php echo $rs["submit_id"];?>" onclick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a>	</td>
  </tr>
  <?php
  }
  ?>
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
      $submit_id=$_GET["submit_id"];
	  $sql="select * from ve123_url_submit where submit_id='$submit_id'";
	  $rs=$db->get_one($sql);
	  $url=$rs["url"];
	  $ip=$rs["ip"];
	  $btn_txt="ȷ���޸�";
  }
  else
  {
     $btn_txt="ȷ���ύ";
  }
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<form id="form1" name="form1" method="post" action="?action=saveform">
  <tr>
    <td width="100">���ӵ�ַ:</td>
    <td><input name="url" type="text" value="<?php echo $url?>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="submit_id" value="<?php echo $submit_id?>">
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
   $url=trim($_POST["url"]);
   $submit_id=$_POST["submit_id"];
   $do_action=$_POST["do_action"];
   if ($do_action=="modify")
   {
     $array=array('url'=>$url);
	 $db->update("ve123_url_submit",$array,"submit_id='$submit_id'");
	 jsalert("�޸ĳɹ�");
   }
   else
   {
     $array=array('url'=>$url,'ip'=>ip());
	 $db->insert("ve123_url_submit",$array);
     jsalert("�ύ�ɹ�");
   }
}
?>

