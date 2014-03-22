<?php
if(!$city_id){
	$city_DB[name][0]=$webdb[Info_areaname]?$webdb[Info_areaname]:'È«¹ú';
	$city_DB[fup][0]=0;
}
$GuideFid[$fid]=preg_replace("/list\.php\?fid=([0-9]+)/eis","get_info_url('','\\1','$city_id')",$GuideFid[$fid]);
require(getTpl("head",$head_tpl));
?>