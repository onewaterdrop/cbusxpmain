<?php
require "global.php";
headhtml();
$action=HtmlReplace($_GET["action"]);
switch ($action)
{
case "saveconfig":
saveconfig();
break;
}

$rs=$db->get_one("select * from ve123_dh_siteconfig");

?>
<form id="configform" name="configform" method="post" action="?action=saveconfig">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <th colspan="2">������������</th>
  </tr>
  <tr>
    <td width="100">��������:</td>
    <td><input type="text" name="name" value="<?php echo $rs["name"]?>"/></td>
  </tr>
  <tr>
    <td>������:</td>
    <td><input name="adtitle" type="text" value="<?php echo $rs["adtitle"]?>" size="80"/></td>
  </tr>
  <tr>
    <td>�绰:</td>
    <td><input type="text" name="telephone" value="<?php echo $rs["telephone"];?>"/></td>
  </tr>
  <tr>
    <td>QQ:</td>
    <td><input type="text" name="qq" value="<?php echo $rs["qq"];?>"/></td>
  </tr>
  <tr>
    <td>����:</td>
    <td>
      <textarea name="notice" cols="50" rows="5"><?php echo $rs["notice"];?></textarea></td>
  </tr>
  <tr>
    <td>keywords:</td>
    <td><textarea name="keywords" cols="50" rows="5"><?php echo $rs["keywords"];?></textarea></td>
  </tr>
  <tr>
    <td>description:</td>
    <td><textarea name="description" cols="50" rows="5"><?php echo $rs["description"];?></textarea></td>
  </tr>
  <tr>
    <td>״̬����:</td>
    <td><textarea name="status_content" cols="50" rows="5"><?php echo $rs["status_content"];?></textarea></td>
  </tr>
  <tr>
    <td>��վͳ�ƴ���:</td>
    <td><textarea name="statcode" cols="50" rows="5"><?php echo $rs["statcode"]?></textarea></td>
  </tr>
  <tr>
    <td>��վ��Ȩ:</td>
    <td><textarea name="copyright" cols="50" rows="5"><?php echo $rs["copyright"];?></textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="�ύ" /></td>
  </tr>
</table>
</form>
<?php
function saveconfig()
{
global $db;
$name=HtmlReplace($_POST["name"]);
$user_agent=HtmlReplace($_POST["user_agent"]);
$adtitle=$_POST["adtitle"];
$copyright=$_POST["copyright"];
$url=HtmlReplace($_POST["url"]);
$searchcode=$_POST["searchcode"];

$status_content=HtmlReplace($_POST["status_content"]);
$statcode=$_POST["statcode"];
$description=$_POST["description"];
$notice=HtmlReplace($_POST["notice"]);
$keywords=HtmlReplace($_POST["keywords"]);
$telephone=$_POST["telephone"];
$qq=$_POST["qq"];
$array=array('name'=>$name,'keywords'=>$keywords,'adtitle'=>$adtitle,'copyright'=>$copyright,'icp'=>$icp,'statcode'=>$statcode,'url'=>$url,'searchcode'=>$searchcode,'status_content'=>$status_content,'description'=>$description,'telephone'=>$telephone,'qq'=>$qq,'notice'=>$notice);
$db->update("ve123_dh_siteconfig",$array,"sid='1'");
jsalert ("�޸ĳɹ�!");
}


?>

