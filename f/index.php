<?php
if(is_file('install.php')){
	header("location:install.php");exit;
}elseif(is_file('upgrade.php')){
	header("location:upgrade.php");
	exit;
}

require(dirname(__FILE__)."/global.php");

//标签处理
if($jobs=='show'){
	//针对多城市版,有可能CITYID不存在.
	if(!$city_id){
		foreach( $city_DB[name] AS $key=>$value){
			$city_id=$key;
			break;
		}
	}
	unset($FirstGoin);
}

//首次访问时,强制用户人工选择城市
if(!$_GET[choose_cityID]&&$webdb[Info_MemberChooseCity]&&$FirstGoin&&count($city_DB[name])>1){
	require(dirname(__FILE__)."/allcity.php");
	header("location:".($webdb[Info_sys]?$webdb[www_url]:$Mdomain)."/allcity.html");
	//exit;
}elseif(!$city_id){
	require(dirname(__FILE__)."/allcity.php");
	//header("location:".($webdb[Info_sys]?$webdb[www_url]:$Mdomain)."/allcity.php");
	exit;
}

choose_domain();	//域名判断

//缓存
$Cache_FileName=Mpath."cache/index/$city_id/index.php";
if(!$jobs&&!$MakeIndex&&$webdb[Info_index_cache]&&(time()-filemtime($Cache_FileName))<($webdb[Info_index_cache]*60)){
	echo read_file($Cache_FileName);
	exit;
}

if(count($city_DB[name])>1&&$webdb[Info_htmlType]==2){
	foreach( $city_DB[name] AS $key=>$value){
		if(!$city_DB['dirname'][$key]){
			showerr("你启用了高级伪静态,但是没有把所有城市生成目录,请进后台把所有城市生成目录!<br>目前至少没有把城市“{$value}”生成独立目录!");
		}
	}
}

require(Mpath."php168/friendlink.php");

//SEO
$title_text="【##分类生活信息-##黄页网】 - ##同地网";
$keyword_text="##本地分类信息网,##黄页网,##最权威分类信息网站,##同地网";
$description_text="##同地网是本地分类信息网，提供免费发布信息，寻找最新最全的房屋出租、二手房、二手车、二手物品交易、求职招聘等生活信息，涵盖房产、车辆、招工、兼职、黄页等海量的生活分类信息";

$titleDB[title] =str_replace("##",$city_DB[name][$city_id],$title_text);//$city_DB[name][$city_id];
//"aaa";$city_DB[metaT][$city_id]?$city_DB[metaT][$city_id]:"{$city_DB[name][$city_id]} $webdb[Info_webname]";
$titleDB[keywords]	=str_replace("##",$city_DB[name][$city_id],$keyword_text); //$city_DB[metaK][$city_id]?$city_DB[metaK][$city_id]:$webdb[Info_metakeywords];
$titleDB[description] =str_replace("##",$city_DB[name][$city_id],$description_text); //$city_DB[metaD][$city_id]?$city_DB[metaD][$city_id]:$webdb[Info_metadescription];

//城市模板
if($city_DB[tpl][$city_id]){
	list($head_tpl,$foot_tpl,$index_tpl)=explode("|",$city_DB[tpl][$city_id]);
	$head_tpl && $head_tpl=Mpath.$head_tpl;
	$foot_tpl && $foot_tpl=Mpath.$foot_tpl;
	$index_tpl && $index_tpl=Mpath.$index_tpl;
}

//地区的最新信息

$query = $db->query("SELECT * FROM {$_pre}db WHERE city_id='$city_id' ORDER BY id DESC LIMIT 11");
$show="<div class=\"smarty_news\">";
while($rs = $db->fetch_array($query)){
	$_erp=$Fid_db[tableid][$rs[fid]];
	$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id=$rs[id] $SQL");
	if(!$rs[title]){
		continue;
	}
	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	$rs[title]=get_word($rs[title]);
	$show.="<dd>·<a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}
$show.="</div>";

//附近相关城市
$query=$db->query("select fup from {$_pre}city where fid='$city_id'");
while($rs = $db->fetch_array($query)){
	$fup=$rs["fup"];
}
if($fup<=1){
	$sql="select name,domain from  p8_fenlei_city    group by fup ";	
}
else{
	$sql="select name,domain from  p8_fenlei_city  where fup='$fup'";	
}
$query=$db->query($sql);
while($rs = $db->fetch_array($query)){
	$ocity.="<a href=\"".$rs["domain"]."\">".$rs["name"]."</a>&nbsp;&nbsp;";
}

/**
*标签使用
**/
$ch_fid	= $ch_pagetype = 0;
$ch_module = $webdb[module_id]?$webdb[module_id]:99;	//系统特定ID参数,每个系统不能雷同
require(PHP168_PATH."inc/label_module.php");


/**
*推荐的栏目在首页显示
**/
$listdb_moresort=Info_ListMoreSort($webdb[InfoIndexCSRow],$webdb[InfoIndexCSLeng],$city_id);

//每个栏目的信息数
$InfoNum=get_infonum($city_id);


require(Mpath."inc/head.php");
require(getTpl("index",$index_tpl));
require(Mpath."inc/foot.php");

if(!$jobs&&!$MakeIndex&&$webdb[Info_index_cache]&&(time()-filemtime($Cache_FileName))>($webdb[Info_index_cache]*60)){
	if(!is_dir(dirname($Cache_FileName))){
		makepath(dirname($Cache_FileName));
	}
	write_file($Cache_FileName,$content);
}elseif($jobs=='show'){
	@unlink($Cache_FileName);
}

?>