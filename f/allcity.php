<?php
if(!function_exists('html')){
	require_once(dirname(__FILE__)."/global.php");
}
include_once(Mpath."php168/all_area.php");
include_once(Mpath."php168/friendlink.php");

if($webdb[Info_allcityType]==1){
	$query = $db->query("SELECT * FROM {$_pre}city ORDER BY letter ASC,list DESC");
	while($rs = $db->fetch_array($query)){
		$listdb[$rs[letter]][]=$rs;
	}
}

//SEO
$titleDB[title] = $city_DB[metaT][$city_id]?$city_DB[metaT][$city_id]:"{$city_DB[name][$city_id]} $webdb[Info_webname]";
$titleDB[keywords]	= $city_DB[metaK][$city_id]?$city_DB[metaK][$city_id]:$webdb[Info_metakeywords];
$titleDB[description] = $city_DB[metaD][$city_id]?$city_DB[metaD][$city_id]:$webdb[Info_metadescription];


//地区的最新信息

$query = $db->query("SELECT * FROM {$_pre}db ORDER BY id DESC LIMIT 45");
$show="";
while($rs = $db->fetch_array($query)){
	$_erp=$Fid_db[tableid][$rs[fid]];
	$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id=$rs[id] $SQL");
	if(!$rs[title]){
		continue;
	}
	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	$rs[title]=get_word($rs[title]);
	$show.="<dd><a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}



//function get_info_url($id,$fid,$cityid='',$zoneid='',$streetid='',$array=array()){
//echo get_info_url(1440,11,268,0);
//require(Mpath."inc/head.php");
require(getTpl("allcity"));
require(Mpath."inc/foot.php");
?>
