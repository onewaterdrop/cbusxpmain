<?php
require_once("global.php");

$linkdb=array("广告位管理"=>"?job=listad","添加广告位"=>"?job=addplace","广告用户管理"=>"?job=listuser");

//列出所有广告
if($job=="listad"){
	$query = $db->query("SELECT AD.* FROM `{$_pre}sellad` AD ORDER BY AD.id DESC");
	while($rs = $db->fetch_array($query)){
		$_s1=$db->get_one("SELECT COUNT(*) AS Num FROM `{$_pre}sellad_user` WHERE id='$rs[id]'");
		$rs[AllAdNum]=$_s1[Num];
		$_s2=$db->get_one("SELECT COUNT(*) AS Num FROM `{$_pre}sellad_user` WHERE id='$rs[id]' AND endtime>$timestamp");
		$rs[AdNum]=$_s2[Num];
		$rs[isclose]=$rs[isclose]?'关闭':'开放';
		$listdb[]=$rs;
	}
	require("head.php");
	require("template/sellad/listad.htm");
	require("foot.php");
}

//添加广告
elseif($job=="addplace")
{
	require("head.php");
	require("template/sellad/addplace.htm");
	require("foot.php");
}

//修改广告
elseif($job=="editadplace")
{
	$rsdb=$db->get_one("SELECT * FROM `{$_pre}sellad` WHERE id='$id'");
	$isclose[intval($rsdb[isclose])]=" checked ";
	require("head.php");
	require("template/sellad/addplace.htm");
	require("foot.php");
}

//处理修改广告
elseif($action=="editadplace")
{
	if($postdb[day]<1){
		showerr("有效投放天数不能小于1天");
	}
	if($postdb[price]<1){
		showerr("最低起价不能小于1");
	}
	$db->query("UPDATE `{$_pre}sellad` SET name='$postdb[name]',price='$postdb[price]',day='$postdb[day]',isclose='$isclose',adnum='$postdb[adnum]',wordnum='$postdb[wordnum]' WHERE id='$id' ");
	
	refreshto("$FROMURL","修改成功",1);
}

//处理添加广告
elseif($action=="addplace")
{
	if($postdb[day]<1){
		showerr("有效投放天数不能小于1天");
	}
	if($postdb[price]<1){
		showerr("最低起价不能小于1");
	}
	$db->query("INSERT INTO `{$_pre}sellad` (`name` , `price` , `day`, `adnum`, `wordnum`) VALUES ('$postdb[name]','$postdb[price]','$postdb[day]','$postdb[adnum]','$postdb[wordnum]')");	
				
	refreshto("?job=listad","添加成功",1);
}

//删除广告
elseif($action=='deleteadplace')
{
	$db->query("DELETE FROM `{$_pre}sellad` WHERE id='$id'");
	$db->query("DELETE FROM `{$_pre}sellad_user` WHERE id='$id'");
	refreshto("$FROMURL","删除成功",1);
}

elseif($job=="listuser")
{
	require_once("../php168/all_city.php");
	if($page<1){
		$page=1;
	}
	$rows=20;
	$min=($page-1)*$rows;
	if($id){
		$SQL=" WHERE A.id='$id' ";
	}
	$showpage=getpage("`{$_pre}sellad_user` A","$SQL","?job=$job",$rows);
	$query = $db->query("SELECT A.*,B.* FROM `{$_pre}sellad_user` A LEFT JOIN `{$_pre}sellad` B ON A.id=B.id $SQL ORDER BY A.endtime DESC LIMIT $min,$rows");
	while($rs = $db->fetch_array($query)){
		$rs[begintime]=date("Y-m-d H:i",$rs[begintime]);
		$rs[endtime]=date("Y-m-d H:i",$rs[endtime]);
		$rs[city]=$rs[cityid]?$city_DB[name][$rs[cityid]]:'';
		$listdb[]=$rs;
	}
	require("head.php");
	require("template/sellad/listuser.htm");
	require("foot.php");
}

elseif($action=="deleteusr")
{
	$db->query("DELETE FROM `{$_pre}sellad_user` WHERE ad_id='$ad_id'");
	refreshto("$FROMURL","删除成功",1);
}

?>