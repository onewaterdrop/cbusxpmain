<?php
require "global.php";
headhtml();
?>
<?php
$action=$_GET["action"];
switch($action)
{
   case "saveform":
   saveform();
   break;
}

$result=mysql_query("select * from ve123_admin limit 1");
$rs=mysql_fetch_array($result);
?>
<form action="?action=saveform" method="post">
  <table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <td width="100">��¼��:</td>
    <td><input type="text" name="adminname" value="<?php echo $rs["adminname"]?>"/></td>
  </tr>
  <tr>
    <td>����:</td>
    <td><input type="text" name="password" value=""/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="ȷ���޸�" /></td>
  </tr>
</table>
</form>

<?php
if($author<>"qiaso")
{die();}
function saveform()
{
   global $db;
   $adminname=$_POST["adminname"];
   $password=$_POST["password"];
      if($password=="")
	  {
	     jsalert("���벻��Ϊ��,����������!");
		 die();
	  }
	  else
	  {
         $db->query("update ve123_admin set adminname='$adminname',password='$password'");
         jsalert("�������޸�,���ס!");
	  }
}
?>
