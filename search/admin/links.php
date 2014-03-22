<?php
//echo (60*60*24);die();
require "global.php";
set_time_limit(0);
$action=HtmlReplace(trim($_GET["action"]));
$title=HtmlReplace(trim($_GET["title"]));
$url=HtmlReplace(trim($_GET["url"]));
$keywords=HtmlReplace(trim($_GET["keywords"]));
switch($action)
{
	case "saveform":
	saveform();
	break;
	case "update":
	add_update_link($_GET["url"],"","","update");
	break;
	case "update_all_links":
	update_all_links();
	break;
	case "add_all_links":
	add_all_links($_GET["url"]);
	break;
	case "del":
	del();
	break;
	case "dolistform":
	dolistform();
	break;
}
headhtml();
?>
<div class="nav" style="display:none;"><a href="?action=add">���</a></div>
<?php
if($action=="add")
{
   addform($action);
}
elseif($action=="modify")
{
   addform($action);
}
?>
<form id="form1" name="form1" method="get" action="">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <td width="100">��վ����:</td>
    <td><input type="text" name="title" value="<?php echo $title;?>"/></td>
  </tr>
  <tr>
    <td>�ؼ���:</td>
    <td><input type="text" name="keywords" value="<?php echo $keywords;?>"/></td>
  </tr>
  <tr>
    <td>��ַ:</td>
    <td><input type="text" name="url" value="<?php echo $url;?>"/></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="action" value="search" />
	<input type="submit" name="Submit2" value="����" /></td>
  </tr>
</table>
</form>
<?php
  $where=" where title<>''";
  if($action=="search")
  { 
        
		if(!empty($title))
		{
		    $where.=" and title like '%".$title."%'";
		}
		if(!empty($url))
		{
			$where.=" and url like '%".$url."%'";
		}
		if(!empty($keywords))
		{
			$where.=" and CONCAT(title,' ',keywords,' ',fulltxt) like '%".$keywords."%'";
		}
  }
  $sql="select * from ve123_links".$where;//echo $sql;
  $sql_count="select link_id from ve123_links".$where;
  $result=$db->query($sql_count);
  $total=$db->num_rows($result);//��¼����
  $pagesize=30;//ÿҳ��ʾ��
  $totalpage=ceil($total/$pagesize);
  $page=intval($_GET["page"]);
  if($page<=0){$page=1;}
  $offset=($page-1)*$pagesize;
  $result=$db->query($sql." order by link_id desc limit $offset,$pagesize");
echo pageshow($page,$totalpage,$total,"?title=".$title."&keywords=".$keywords."&url=".$url."&action=".$action."&");
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <th width="50">ID</th>
    <th>��վ</th>
    <th>��ַ</th>
    <th>��������</th>
    <th>&nbsp;</th>
    <th>����</th>
    <th width="50">ѡ��</th>
  </tr><form id="listform" name="listform" method="post" action="?action=dolistform" onsubmit="return checkform();">
  <?php

  while($row=$db->fetch_array($result))
  {
  ?>
  <tr>
    <td><?php echo $row["link_id"];?></td>
    <td title="<?php echo $row["title"];?>"><?php echo str_cut($row["title"],40);?></td>
    <td title="<?php echo $row["url"];?>"><a target="_blank" href="<?php echo $row["url"];?>"><?php echo str_cut($row["url"],10);?></a>&nbsp;&nbsp;&nbsp;(<a target="_blank" href="<?php echo $site["url"]."/s/?wd=site:".str_replace("http://","",GetSiteUrl($row["url"]))."";?>">siteһ��</a>)</td>
    <td><?php echo date("Y-m-d H:i:s",$row["updatetime"]);?></td>
    <td><?php echo $row["level"];?></td>
    <td>
	<!--<a href="?action=add_all_links&url=<?php echo GetSiteUrl($row["url"]);?>">��¼ȫվ</a>&nbsp;
	<a href="?action=update&url=<?php echo $row["url"];?>">����</a>&nbsp;-->
	<a href="?action=modify&link_id=<?php echo $row["link_id"]."&url=".$row["url"]."";?>">�޸�</a>&nbsp;
	<a href="?action=del&link_id=<?php echo $row["link_id"];?>" onClick="if(!confirm('ȷ��ɾ����?')) return false;">ɾ��</a></td>
    <td><input type="checkbox" name="link_id[]" value="<?php echo $row["link_id"]?>" /></td>
  </tr>
  <?php
  }
  ?>
  <tr>
    <th colspan="7">
<div align="center"> 
                <input name="chkall" type="checkbox" id="chkall" onclick=CheckAll(this.form,'link_id[]') value="checkbox">
                ѡ�б�ҳ��ʾ����Ϣ <strong>������</strong> 
                
				<input name="do_action" type="radio" value="del" checked="checked">
                ɾ��&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type="submit" name="Submit" value=" ִ �� ">
        </div>	</th>
    </tr></form>
</table>
<?php
echo pageshow($page,$totalpage,$total,"?title=".$title."&url=".$url."&action=".$action."&");
?>
<?php
function addform($do_action)
{
    global $db;
    if($do_action=="modify")
	{
	    $link_id=intval($_GET["link_id"]);
	    $row=$db->get_one("select * from ve123_links where link_id='$link_id'");
		$title=$row["title"];
		$url=$row["url"];
		$tuiguang=$row["tuiguang"];
		$bt_txt="ȷ���޸�";
	}
	else
	{ 
	   $bt_txt="ȷ�����";
	}
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
<tr>
    <th colspan="2">��վ</th>
  </tr>
  <form id="addform" name="addform" method="post" action="?action=saveform">
  <tr>
    <td width="100">��ַ:</td>
    <td><input name="url" type="text" value="<?php echo GetSiteUrl($url);?>" size="50"/></td>
  </tr>
  <tr>
    <td>�ƹ�:</td>
    <td><input type="text" name="tuiguang"  value="<?php echo $tuiguang;?>"/>
      (ֵԽ������Խ��ǰ)</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<input type="hidden" name="link_id" value="<?php echo $link_id;?>" />
	<input type="hidden" name="do_action" value="<?php echo $do_action;?>" />
	<input type="submit" name="Submit" value="<?php echo $bt_txt;?>" />	</td>
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
   $url=HtmlReplace(trim($_POST["url"]));
   $tuiguang=intval(trim($_POST["tuiguang"]));
   $do_action=HtmlReplace($_POST["do_action"]);
   if($do_action=="modify")
   {
       $link_id=intval($_POST["link_id"]);
	   $sql="update ve123_links set url='$url',tuiguang='$tuiguang' where link_id='$link_id'";
	   $db->query($sql);
	   jsalert("�޸ĳɹ�");
   }
   else
   {
         $query=$db->query("select * from ve123_links where url='$url'");
	     $num=$db->num_rows($query);
	     if(!$num)
	    {
            add_update_link($url,"","","add");
	        jsalert("��ӳɹ�");
	    }
         
   }
}
function add_all_links($url)
{
      global $db;
	  $sql="select * from ve123_links where url like '%".$url."%'";
	  $result=$db->query($sql);
      $total=$db->num_rows($result);//��¼����i
	 // echo $sql;
	 // if($total<=0){header("location:links.php");exit;}
      $pagesize=5;//ÿҳ��ʾ��
      $totalpage=ceil($total/$pagesize);
      $page=intval($_GET["page"]);
      if($page<=0){$page=1;}
      $offset=($page-1)*$pagesize;
	 $query=$db->query($sql." limit $offset,$pagesize");
  $str="<html><head><title></title><link rel=\"stylesheet\" href=\"images/maincss.css\">";
  $str.="<meta http-equiv='Content-Type' content='text/html; charset=gb2312'></head><body >";
  $str.="<b>��վ������¼�С������Ժ�!<br>";
	 while($row=$db->fetch_array($query))
	 {
	     add_links($row["url"],false);
	     $str.=$row["url"]."<br>";
	 }
  $str.="<meta http-equiv=\"refresh\" content=3;url='?action=add_all_links&url=".$url."&page=".($page+1)."'>";
  $str.="</body></html>";
  echo $str;
	// add_all_links($url);
}
function add_links($url,$is_index_page=true,$num='')
{
       global $db;
	   $new_links=array();
	   $j=1;
       $url_htmlcode=get_url_content($url);
       $url_htmlcode=get_encoding($url_htmlcode,"GB2312");
       $links=get_links($url_htmlcode, $url, 1, $url);
	   if($is_index_page)
	   {
             foreach($links as $value)
             {
                 $new_links[]=GetSiteUrl($value);
             }
	   }
	   else
	   {
	        $new_links=$links;
	   }
       $new_links = distinct_array($new_links);
       foreach($new_links as $value)
       {
          echo $value."<br>";
		  flush();
          	 $query=$db->query("select * from ve123_links where url='$value'");
	         $num=$db->num_rows($query);
	         if($num==0)
	         {
                 if(!add_update_link($value,"","","add"))
		         {
		            continue;
		         }
				 $j++;
				 if(!empty($num))
				 {
				        if($j>=$num)
						{
						    exit;
						}
				 }
	         }
        }
}
function update_all_links()
{
  global $db;
  $day=intval($_GET["day"]);
  if(!empty($day))
  {
     $sql="select * from ve123_links where updatetime<='".(time()-(86400*$day))."'";
  }
  else
  {
     $sql="select * from ve123_links";
  } //echo $sql;echo date("Y-m-d H:i:s",(time()-(86400*$day)));die();
      $result=$db->query($sql);
      $total=$db->num_rows($result);//��¼����i
	  if($total<=0){header("location:links.php");exit;}
      $pagesize=5;//ÿҳ��ʾ��
      $totalpage=ceil($total/$pagesize);
      $page=intval($_GET["page"]);
      if($page<=0){$page=1;}
      $offset=($page-1)*$pagesize;
  $query=$db->query($sql." limit $offset,$pagesize");
  $str="<html><head><title></title><link rel=\"stylesheet\" href=\"images/maincss.css\">";
  $str.="<meta http-equiv='Content-Type' content='text/html; charset=gb2312'></head><body >";
  $str.="<b>��վ���ڸ����С������Ժ�<font color='red'>�ڴ˹���������ˢ�´�ҳ�棡����</font></b><br>�ܹ���Ҫ���� <font color='red'><b>$total</b></font> ����վ��ÿҳ���� <font color='red'><b>$pagesize</b></font> ����վ������Ҫ�� <font color='red'><b>$totalpage</b></font> ҳ���£���ǰ���ڸ��� <font color='red'><b>$page</b></font> ҳ<br>";
  while($row=$db->fetch_array($query))
  {
       add_update_link($row["url"],"","","update");
	   $str.=$row["url"]."<br>";
  }
  if($page<=$totalpage)
  {
     $str.="<meta http-equiv=\"refresh\" content=3;url='?action=update_all_links&day=".$day."&page=".($page+1)."'>";
     $str.="</body></html>";
     
  }
  else
			{
			     $str.="�������<br>";
				 $str.="<a href=\"links.php\">������һҳ</a>";
				 $str.="</body></html>";
			}
  echo $str;
  exit;
}
function del()
{
  global $db;
  $link_id=intval($_GET["link_id"]);
  $db->query("delete from ve123_links where link_id='$link_id'");
  jsalert("ɾ���ɹ�");
}
function dolistform()
{
   global $db;
   $link_id=$_POST["link_id"];
   $do_action=HtmlReplace($_POST["do_action"]);
   for($i=0;$i<count($link_id);$i++)
   {
       $link_id_str=$link_id_str.$link_id[$i].",";
   }
   $link_id_str=rtrim($link_id_str,",");
   if(empty($link_id_str)){return;}
   if($do_action=="del")
   {
       $sql="delete from ve123_links where link_id in(".$link_id_str.")";
   }
   $db->query($sql);
   header("location:".$_SERVER['HTTP_REFERER']);
}
?>
