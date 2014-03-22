<?php
require_once(dirname(__FILE__)."/"."../inc/common.inc.php");	//核心文件
@include_once(PHP168_PATH."inc/artic_function.php");			//包含一些调取文件内容的函数

@include_once(PHP168_PATH."php168/ad_cache.php");		//广告变量缓存文件
@include_once(PHP168_PATH."php168/label_hf.php");		//标签头部与底部变量缓存文件
@include_once(PHP168_PATH."php168/all_fid.php");		//全部栏目配置文件

if(!$webdb[web_open])
{
	$webdb[close_why] = str_replace("\n","<br>",$webdb[close_why]);
	showerr("网站暂时关闭:$webdb[close_why]");
}

/**
*允许哪些IP访问
**/
$IS_BIZ && Limt_IP('AllowVisitIp');


$ch=intval($ch);
$fid=intval($fid);
$aid=intval($aid);
$id=intval($id);
$page=intval($page);
unset($listdb,$rs);

//加载JS时的提示语,你可以换成图片,'号要加\
$Load_Msg="<img alt=\"内容加载中,请稍候...\" src=\"$webdb[www_url]/images/default/ico_loading3.gif\">";

//头部与底部专用
function HF_tpl($html,$tpl=''){
	global $STYLE,$webdb;
	if(!$webdb[SystemType]){
		return html($html,$tpl);
	}
	if(file_exists(PHP168_PATH."$webdb[SystemType]/template/$STYLE/$html.htm")){
		return PHP168_PATH."$webdb[SystemType]/template/$STYLE/$html.htm";
	}else{
		return PHP168_PATH."$webdb[SystemType]/template/default/$html.htm";
	}
}

if($webdb[SystemType]&&!function_exists('get_info_url')){
@include(PHP168_PATH."$webdb[SystemType]/global.php");
}
?>