<?php
if(is_file('install.php')){
	header("location:install.php");exit;
}elseif(is_file('upgrade.php')){
	header("location:upgrade.php");
	exit;
}

require(dirname(__FILE__)."/global.php");

//��ǩ����
if($jobs=='show'){
	//��Զ���а�,�п���CITYID������.
	if(!$city_id){
		foreach( $city_DB[name] AS $key=>$value){
			$city_id=$key;
			break;
		}
	}
	unset($FirstGoin);
}

//�״η���ʱ,ǿ���û��˹�ѡ�����
if(!$_GET[choose_cityID]&&$webdb[Info_MemberChooseCity]&&$FirstGoin&&count($city_DB[name])>1){
	require(dirname(__FILE__)."/allcity.php");
	header("location:".($webdb[Info_sys]?$webdb[www_url]:$Mdomain)."/allcity.html");
	//exit;
}elseif(!$city_id){
	require(dirname(__FILE__)."/allcity.php");
	//header("location:".($webdb[Info_sys]?$webdb[www_url]:$Mdomain)."/allcity.php");
	exit;
}

choose_domain();	//�����ж�

//����
$Cache_FileName=Mpath."cache/index/$city_id/index.php";
if(!$jobs&&!$MakeIndex&&$webdb[Info_index_cache]&&(time()-filemtime($Cache_FileName))<($webdb[Info_index_cache]*60)){
	echo read_file($Cache_FileName);
	exit;
}

if(count($city_DB[name])>1&&$webdb[Info_htmlType]==2){
	foreach( $city_DB[name] AS $key=>$value){
		if(!$city_DB['dirname'][$key]){
			showerr("�������˸߼�α��̬,����û�а����г�������Ŀ¼,�����̨�����г�������Ŀ¼!<br>Ŀǰ����û�аѳ��С�{$value}�����ɶ���Ŀ¼!");
		}
	}
}

require(Mpath."php168/friendlink.php");

//SEO
$title_text="��##����������Ϣ-##��ҳ���� - ##ͬ����";
$keyword_text="##���ط�����Ϣ��,##��ҳ��,##��Ȩ��������Ϣ��վ,##ͬ����";
$description_text="##ͬ�����Ǳ��ط�����Ϣ�����ṩ��ѷ�����Ϣ��Ѱ��������ȫ�ķ��ݳ��⡢���ַ������ֳ���������Ʒ���ס���ְ��Ƹ��������Ϣ�����Ƿ������������й�����ְ����ҳ�Ⱥ��������������Ϣ";

$titleDB[title] =str_replace("##",$city_DB[name][$city_id],$title_text);//$city_DB[name][$city_id];
//"aaa";$city_DB[metaT][$city_id]?$city_DB[metaT][$city_id]:"{$city_DB[name][$city_id]} $webdb[Info_webname]";
$titleDB[keywords]	=str_replace("##",$city_DB[name][$city_id],$keyword_text); //$city_DB[metaK][$city_id]?$city_DB[metaK][$city_id]:$webdb[Info_metakeywords];
$titleDB[description] =str_replace("##",$city_DB[name][$city_id],$description_text); //$city_DB[metaD][$city_id]?$city_DB[metaD][$city_id]:$webdb[Info_metadescription];

//����ģ��
if($city_DB[tpl][$city_id]){
	list($head_tpl,$foot_tpl,$index_tpl)=explode("|",$city_DB[tpl][$city_id]);
	$head_tpl && $head_tpl=Mpath.$head_tpl;
	$foot_tpl && $foot_tpl=Mpath.$foot_tpl;
	$index_tpl && $index_tpl=Mpath.$index_tpl;
}

//������������Ϣ

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
	$show.="<dd>��<a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}
$show.="</div>";

//������س���
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
*��ǩʹ��
**/
$ch_fid	= $ch_pagetype = 0;
$ch_module = $webdb[module_id]?$webdb[module_id]:99;	//ϵͳ�ض�ID����,ÿ��ϵͳ������ͬ
require(PHP168_PATH."inc/label_module.php");


/**
*�Ƽ�����Ŀ����ҳ��ʾ
**/
$listdb_moresort=Info_ListMoreSort($webdb[InfoIndexCSRow],$webdb[InfoIndexCSLeng],$city_id);

//ÿ����Ŀ����Ϣ��
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