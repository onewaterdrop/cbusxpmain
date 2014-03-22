<?php
require_once("global.php");

$linkdb=array("核心设置"=>"center.php?job=config","焦点信息设置"=>"center.php?job=guide","发布信息权限设置"=>"center.php?job=post","置顶信息设置"=>"center.php?job=top","联系人信息设置"=>"center.php?job=contact");

if($job)
{
	$query=$db->query(" select * from {$_pre}config ");
	while( $rs=$db->fetch_array($query) ){
		$webdb[$rs[c_key]]=$rs[c_value];
	}
}
if($job=="label"){
	foreach( $city_DB[name] AS $key=>$value){
		$cityid=$key;
		break;
	}
	if($webdb[Info_sys]){
		echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$webdb[www_url]/index.php?choose_cityID=$cityid&jobs=show'>";
		exit;
	}else{
		echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=../index.php?choose_cityID=$cityid&jobs=show'>";
		exit;
	}
}
elseif($job=="config")
{
	$GroupPassYz=group_box("webdbs[GroupPassYz]",explode(",",$webdb[GroupPassYz]));
	$webdb[Info_webOpen]?$Info_webOpen1='checked':$Info_webOpen0='checked';
	$select_style=select_style('webdbs[Info_style]',$webdb[Info_style]);
	$Info_forbidOutPost[intval($webdb[Info_forbidOutPost])]=' checked ';
	$Info_DelEndtime[intval($webdb[Info_DelEndtime])]=' checked ';
	$Jump_fromarea[intval($webdb[Jump_fromarea])]=' checked ';
	$Jump_allcity[intval($webdb[Jump_allcity])]=' checked ';
	$Force_Choose_City[intval($webdb[Force_Choose_City])]=' checked ';
	$Info_allowGuesSearch[intval($webdb[Info_allowGuesSearch])]=' checked ';
	$Info_Searchkeyword[intval($webdb[Info_Searchkeyword])]=' checked ';

	$Info_ShowNoYz[intval($webdb[Info_ShowNoYz])]=' checked ';

	$Info_htmlType[intval($webdb[Info_htmlType])]=' checked ';

	$Info_webOpen[intval($webdb[Info_webOpen])]=' checked ';
	
	$Info_UseEndTime[intval($webdb[Info_UseEndTime])]=' checked ';
	$Info_MemberChooseCity[intval($webdb[Info_MemberChooseCity])]=' checked ';
	$Info_allcityType[intval($webdb[Info_allcityType])]=' checked ';

	$Info_index_cache[intval($webdb[Info_index_cache])]=' checked ';

	$Info_sys[intval($webdb[Info_sys])]=' checked ';
	

	$group_UpPhoto=group_box("webdbs[group_UpPhoto]",explode(",",$webdb[group_UpPhoto]),array(2));
	$Post_group_UpPhoto=group_box("webdbs[Post_group_UpPhoto]",explode(",",$webdb[Post_group_UpPhoto]));
	require("head.php");
	require("template/center/config.htm");
	require("foot.php");
}
elseif($job=="html"){
	unset($linkdb);
	$Adminpath=Adminpath.'apache.txt';
	$Info_htmlType[intval($webdb[Info_htmlType])]=' checked ';
	$post_htmlType[intval($webdb[post_htmlType])]=' checked ';

	$linkdb=array(
			  "分类目录批量生成标准目录名"=>"sort.php?job=batch",
			  "城市批量生成目录文件"=>"spsort.php?job=batch"
			);
	if(!function_exists('MODULE_CK')||!in_array("fenlei",$BIZ_MODULEDB)){
		unset($linkdb["城市批量生成目录文件"]);
	}
	require("head.php");
	require("template/center/html.htm");
	require("foot.php");
}

elseif($action=="config")
{
	if(isset($webdbs[Info_MakeIndexHtmlTime])&&!$webdbs[Info_MakeIndexHtmlTime]&&$webdb[Info_MakeIndexHtmlTime]){
		@unlink("../index.htm.bak");
		rename("../index.htm","../index.htm.bak");
	}
	if($GroupPassYz){
		$webdbs[GroupPassYz]=$webdbs[GroupPassYz];
	}
	if($GroupPostInfo){
		$webdbs[GroupPostInfo]=$webdbs[GroupPostInfo];
	}

	if($Info_GroupCommentYzImg){
		$webdbs[Info_GroupCommentYzImg]=$webdbs[Info_GroupCommentYzImg];
	}
	if($Info_GroupPostYzImg){
		$webdbs[Info_GroupPostYzImg]=$webdbs[Info_GroupPostYzImg];
	}

	if( isset($webdbs[Info_webadmin]) ){
		$webdbs[Info_webadmin]=filtrate($webdbs[Info_webadmin]);
		$db->query("UPDATE {$pre}module SET adminmember='$webdbs[Info_webadmin]' WHERE id='$webdb[module_id]'");
	}
	if( isset($webdbs[Info_weburl]) ){
		$webdbs[Info_weburl]=filtrate($webdbs[Info_weburl]);
		$db->query("UPDATE {$pre}module SET domain='$webdbs[Info_weburl]' WHERE id='$webdb[module_id]'");
	}
	if(isset($webdbs[Info_webadmin])||isset($webdbs[Info_weburl])){
		if(function_exists('make_module_cache')){
			make_module_cache();
		}		
	}
	write_config_cache($webdbs);
	refreshto($FROMURL,"修改成功");
}

elseif($job=="settpl")
{
	$Info_NewsMakeHtml[$webdb[Info_NewsMakeHtml]]=' checked ';
	require("head.php");
	require("template/center/settpl.htm");
	require("foot.php");
}
elseif($action=="settable")
{
	write_config_cache($webdbs);
	refreshto($FROMURL,"设置成功");
}
elseif($job=="settable")
{
	
	include_once(Mpath."php168/all_fid.php");
	$layout=array();
	$detail=explode("#",$webdb[sort_layout]);
	foreach($detail AS $key=>$value){
		$detail2=explode(",",$value);
		foreach($detail2 AS $fup){
			if(!$Fid_db['name'][$fup]){
				continue;
			}
			$layout[$key][$fup]['name']=$Fid_db['name'][$fup];
			$layout[$key][$fup]['son']=$Fid_db[$fup];
			$ckfup[$fup]=1;
		}
	}
	foreach($Fid_db[0] AS $fup=>$name){
		if(!$ckfup[$fup]){
			$layout[0][$fup]['name']=$Fid_db['name'][$fup];
			$layout[0][$fup]['son']=$Fid_db[$fup];
		}
	}

	/*
	$query = $db->query("SELECT * FROM {$_pre}sort WHERE fup=0");
	while($rs = $db->fetch_array($query)){
		$query2 = $db->query("SELECT * FROM WHERE fup=$rs[fid]");
		while($rs2 = $db->fetch_array($query2)){
		}
	}*/
	require("head.php");
	require("template/center/settable.htm");
	require("foot.php");
}
elseif($job=="top")
{
	$Info_NewsMakeHtml[$webdb[Info_NewsMakeHtml]]=' checked ';
	require("head.php");
	require("template/center/top.htm");
	require("foot.php");
}

elseif($job=="post")
{
	$GroupPassYz=group_box("webdbs[GroupPassYz]",explode(",",$webdb[GroupPassYz]));
	$webdb[Info_webOpen]?$Info_webOpen1='checked':$Info_webOpen0='checked';
	$select_style=select_style('webdbs[Info_style]',$webdb[Info_style]);
	$Info_forbidOutPost[intval($webdb[Info_forbidOutPost])]=' checked ';

	$Jump_fromarea[intval($webdb[Jump_fromarea])]=' checked ';
	$Jump_allcity[intval($webdb[Jump_allcity])]=' checked ';
	$Force_Choose_City[intval($webdb[Force_Choose_City])]=' checked ';
	$Info_allowGuesSearch[intval($webdb[Info_allowGuesSearch])]=' checked ';
	$Info_Searchkeyword[intval($webdb[Info_Searchkeyword])]=' checked ';
	$Info_ClosePost[intval($webdb[Info_ClosePost])]=' checked ';
	$Info_GuestPostRepeat[intval($webdb[Info_GuestPostRepeat])]=' checked ';
	$Info_MemberPostRepeat[intval($webdb[Info_MemberPostRepeat])]=' checked ';

	$Info_GroupCommentYzImg=group_box("webdbs[Info_GroupCommentYzImg]",explode(",",$webdb[Info_GroupCommentYzImg]));
	$Info_GroupPostYzImg=group_box("webdbs[Info_GroupPostYzImg]",explode(",",$webdb[Info_GroupPostYzImg]));

	$Info_cityPost[intval($webdb[Info_cityPost])]=' checked ';

	$GroupPostInfo=group_box("webdbs[GroupPostInfo]",explode(",",$webdb[GroupPostInfo]));
	require("head.php");
	require("template/center/post.htm");
	require("foot.php");
}

elseif($job=="guide")
{
	require("head.php");
	require("template/center/guide.htm");
	require("foot.php");
}

elseif($job=="contact")
{
	$Info_ImgShopContact[intval($webdb[Info_ImgShopContact])]=' checked ';
	$Info_ForbidGuesViewContact[intval($webdb[Info_ForbidGuesViewContact])]=' checked ';
	$Info_ForbidMemberViewContact[intval($webdb[Info_ForbidMemberViewContact])]=' checked ';
	$Info_ShowSearchContact[intval($webdb[Info_ShowSearchContact])]=' checked ';

	$Info_Musttelephone[intval($webdb[Info_Musttelephone])]=' checked ';
	$Info_Mustmobphone[intval($webdb[Info_Mustmobphone])]=' checked ';
	$Info_MustQQ[intval($webdb[Info_MustQQ])]=' checked ';
	$Info_MustEmail[intval($webdb[Info_MustEmail])]=' checked ';

	require("head.php");
	require("template/center/contact.htm");
	require("foot.php");
}
?>