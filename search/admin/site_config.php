<?php
require "global.php";
headhtml();
$action=$_GET["action"];
switch ($action)
{
case "saveconfig":
saveconfig();
break;
}

$rs=$db->get_one("select * from ve123_siteconfig");

?>
<form id="configform" name="configform" method="post" action="?action=saveconfig">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <th colspan="2">��վ��������</th>
  </tr>
  <tr>
    <td width="120">��վ����:</td>
    <td><input type="text" name="name" value="<?php echo $rs["name"]?>"/></td>
  </tr>
  <tr>
    <td>֩������:</td>
    <td><input type="text" name="user_agent" value="<?php echo $rs["user_agent"];?>"/></td>
  </tr>
  <tr>
    <td>��վ��ַ:</td>
    <td><input type="text" name="url" value="<?php echo $rs["url"];?>"/></td>
  </tr>
  <tr>
    <td>������:</td>
    <td><input name="adtitle" type="text" value="<?php echo $rs["adtitle"]?>" size="80"/></td>
  </tr>
  <tr>
    <td>IPC����:</td>
    <td><input type="text" name="icp" value="<?php echo $rs["icp"];?>"/></td>
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
    <td>�Ƿ�������¼:</td>
    <td><input name="is_tijiao_shoulu" type="checkbox" value="1" <?php if($rs["is_tijiao_shoulu"]){echo "checked=\"checked\"";}?> />
      (�����ύ��¼��ں��Ƿ�������¼��ҳ)</td>
  </tr>
  <tr>
    <td>֩��Ĭ����¼���:</td>
    <td><input type="text" name="spider_depth" value="<?php echo $rs["spider_depth"];?>"/>
      (0��ʾֻ����ҳ,1��ʾ����ҳ�ϵ���ҳ,2,3,4,�Դ�����)</td>
  </tr>
  <tr>
    <td>Keywords:</td>
    <td><textarea name="Keywords" cols="50" rows="5"><?php echo $rs["Keywords"];?></textarea></td>
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
    <td>�ؼ��ʹ��ˣ�</td>
    <td><textarea name="filter_word" cols="50" rows="5"><?php echo $rs["filter_word"];?></textarea>
      ����ʾ������ʹ�����&quot;,&quot;�Ÿ�����</td>
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
$icp=HtmlReplace($_POST["icp"]);
$url=HtmlReplace($_POST["url"]);
$status_content=HtmlReplace($_POST["status_content"]);
$statcode=$_POST["statcode"];
$Keywords=HtmlReplace($_POST["Keywords"]);
$description=$_POST["description"];
$telephone=$_POST["telephone"];
$qq=$_POST["qq"];
$spider_depth=intval($_POST["spider_depth"]);
$is_tijiao_shoulu=$_POST["is_tijiao_shoulu"];
$filter_word=$_POST["filter_word"];
$array=array('name'=>$name,'user_agent'=>$user_agent,'adtitle'=>$adtitle,'copyright'=>$copyright,'icp'=>$icp,'statcode'=>$statcode,'url'=>$url,'status_content'=>$status_content,'Keywords'=>$Keywords,'description'=>$description,'telephone'=>$telephone,'qq'=>$qq,'is_tijiao_shoulu'=>$is_tijiao_shoulu,'spider_depth'=>$spider_depth,'filter_word'=>$filter_word);
$db->update("ve123_siteconfig",$array,"config_id='1'");
$config=$db->get_one("select * from ve123_siteconfig limit 1");
$str.="<?php".chr(13).chr(10);
$str.="\$config['name']=\"".$name."\";".chr(13).chr(10);
$str.="\$config['user_agent']=\"".$user_agent."\";".chr(13).chr(10);
$str.="\$config['adtitle']=\"".$adtitle."\";".chr(13).chr(10);
$str.="\$config['copyright']=\"".$copyright."\";".chr(13).chr(10);
$str.="\$config['icp']=\"".$icp."\";".chr(13).chr(10);
$str.="\$config['url']=\"".$url."\";".chr(13).chr(10);
$str.="\$config['status_content']=\"".$status_content."\";".chr(13).chr(10);
$str.="\$config['statcode']=\"".addslashes($statcode)."\";".chr(13).chr(10);
$str.="\$config['Keywords']=\"".$Keywords."\";".chr(13).chr(10);
$str.="\$config['description']=\"".$description."\";".chr(13).chr(10);
$str.="\$config['telephone']=\"".$telephone."\";".chr(13).chr(10);
$str.="\$config['qq']=\"".$qq."\";".chr(13).chr(10);
$str.="\$config['is_tijiao_shoulu']=\"".$is_tijiao_shoulu."\";".chr(13).chr(10);
$str.="\$config['spider_depth']=".$spider_depth.";".chr(13).chr(10);
$str.="\$config['author']=\"".$config["author"]."\";".chr(13).chr(10);
$str.="\$config['copyright']=\"".$copyright."\";".chr(13).chr(10);
$str.="\$config['filter_word']=".var_export(explode(",",$filter_word),true).";".chr(13).chr(10);
$str.="?>";
 $fp=@fopen("../cache/site_config.php","w") or die("д��ʽ���ļ�ʧ�ܣ��������Ŀ¼�Ƿ�Ϊ��д");//����conn.php�ļ�
 @fputs($fp,$str) or die("�ļ�д��ʧ��,�������Ŀ¼�Ƿ�Ϊ��д"); 
 @fclose($fp);
jsalert ("�޸ĳɹ�!");
}


?>

