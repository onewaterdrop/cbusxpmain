<?php
require(dirname(__FILE__)."/global.php");
choose_domain();			//域名判断

//伪静态处理
if(!$fid&&$webdb[Info_htmlType]==2){
	$detail=explode("-",$Fid);
	$array=array_flip($Fid_db[dir_name]);
	$fid=$array[$detail[0]];
	if($detail[1]){
		for($i=1;$i<count($detail) ;$i++ ){
			$_GET[$detail[$i]]=$$detail[$i]=str_replace(array('#@#','#!#'),array('-','/'),$detail[++$i]);	
		}
	}
	if($zone_street){
		$detail=explode("-",$zone_street);
		$array=array_flip($zone_DB['dirname']);
		$zone_id=$array[$detail[0]];
		if($detail[1]){
			$array=array_flip($street_DB['dirname']);
			$street_id=$array[$detail[1]];
		}
	}
}

if($page<1){
	$page=1;
}

//缓存
$Cache_FileName=Mpath."cache/list/$city_id-$fid/$page-".md5($WEBURL).".php";
if(!$jobs&&$webdb[Info_list_cache]&&(time()-filemtime($Cache_FileName))<($webdb[Info_list_cache]*60)){
	echo read_file($Cache_FileName);
	exit;
}

//导航条
@include(Mpath."php168/guide_fid.php");

$fidDB=$db->get_one("SELECT A.* FROM {$_pre}sort A WHERE A.fid='$fid'");
if(!$fidDB){
	showerr("栏目不存在");
}elseif($fidDB[jumpurl]){
	header("location:$fidDB[jumpurl]");
	exit;
}

/**
*模型配置文件
**/
$field_db = $module_DB[$fidDB[mid]][field];

//字段筛选
unset($TempSearch_2,$TempSearch_array);
$sort_name="";
$sort_name_content="";
foreach($field_db AS $key=>$value){
	if($value[listfilter]){		
		 $detail=explode("\r\n",$field_db[$key]["form_set"]);
		 foreach($detail as $ $d_key=>$d_value){
				$a_val=explode("|",$d_value);
				if($a_val[0]==$$key && !empty($a_val[0])){					
				   $sort_name.="{city_name}".$a_val[1]."-";//小分类关键字
				   $sort_name_content.="{city_name}".$a_val[1].",";//小分类关键字
				}
		 }
		$TempSearch_2.="$key=>'{$$key}',";		//分页链接使用
		$TempSearch_array[$key]=$$key;			//其它链接使用
		$search_fieldDB[$key][$$key!=''?$$key:0]=" selected class='ck' style='font-weight:bold'";
	}
}


/**
*栏目配置参数及栏目用户自定义的变量
*对栏目用户自定义的变量附件路径做处理
*以下用的比较少,可以删除忽略
**/
$fidDB[config]=unserialize($fidDB[config]);
$CV=$fidDB[config][field_value];
$_array=array_flip($fidDB[config][is_html]);
foreach( $fidDB[config][field_db] AS $key=>$rs){
	if(in_array($key,$_array)){
		$CV[$key]=En_TruePath($CV[$key],0);
	}elseif($rs[form_type]=='upfile'){
		$CV[$key]=tempdir($CV[$key]);
	}
}



//SEO
//echo $city_DB['name'][$city_id];
//echo $fidDB['name'];

if($zone_id>0){//显示区域名称
	$query = $db->query("SELECT * FROM {$_pre}zone WHERE fid='$zone_id'");
	while($rs = $db->fetch_array($query)){
		$zoneName=$rs[name];
	}
}

$titleDB[title]	=$fidDB[metatitle]?seo_geteval($sort_name.$fidDB[metatitle],$city_DB['name'][$city_id],"Y"):seo_geteval($sort_name.strip_tags("{$city_DB[name][$city_id]} $fidDB[name]"),$city_DB['name'][$city_id],"Y");
$titleDB[keywords] = seo_geteval($sort_name_content.$fidDB[metakeywords],$city_DB['name'][$city_id]);
$titleDB[description] = seo_geteval($sort_name_content.$fidDB[metadescription],$city_DB['name'][$city_id]);

//栏目风格
$fidDB[style] && $STYLE=$fidDB[style];

unset($head_tpl,$foot_tpl);
//城市模板
if($city_DB[tpl][$city_id]){
	list($head_tpl,$foot_tpl)=explode("|",$city_DB[tpl][$city_id]);
	$head_tpl && $head_tpl=Mpath.$head_tpl;
	$foot_tpl && $foot_tpl=Mpath.$foot_tpl;
}

/**
*栏目模板优先于城市模板
**/
if($fidDB[template]){
	$FidTpl=unserialize($fidDB[template]);
	$FidTpl['head'] && $head_tpl=Mpath.$FidTpl['head'];
	$FidTpl['foot'] && $foot_tpl=Mpath.$FidTpl['foot'];
	$FidTpl['list'] && $FidTpl['list']=Mpath.$FidTpl['list'];
}

//大分类与小栏目的判断
if($fidDB[type]){
	$sortDB=ListOnlySort();
	$rows=40;
	$show='';
    $rs=$db->get_one("select fid,mid from {$_pre}sort where fup='$fid'");
	$fid=$rs["fid"];
	$mid=$rs["mid"];
	$_erp=$Fid_db[tableid][$fid];
    $fidDB[mid]=$mid;
	$sql_list="A.list";
	$sql_order="DESC";
	$SQL =" AND A.city_id='$city_id' ";
    $query=$db->query("SELECT  B.*,A.* FROM {$_pre}content$_erp A LEFT JOIN {$_pre}content_{$fidDB[mid]} B ON A.id=B.id WHERE A.fid=$fid  $SQL ORDER BY $sql_list $sql_order  LIMIT 0,$rows");
	while( $rs=$db->fetch_array($query) ){
		if(del_EndTimeInfo($rs)){	//自动删除过期信息
			continue;
		}
		$rs[content]=@preg_replace('/<([^>]*)>/is',"",$rs[content]);	//把HTML代码过滤掉
		$rs[content]=get_word($rs[full_content]=$rs[content],100);
		$rs[title]=get_word($rs[full_title]=$rs[title],$leng);
		if($rs['list']>$timestamp){
			$rs[title]=" <font color='$webdb[Info_TopColor]'>$rs[title]</font> <img src='$Murl/images/default/icotop.gif' border=0>";
		}elseif($rs['list']>$rs[posttime]){
			//置顶过期的信息,需要恢复原来发布日期以方便排序,放在后面
			$db->query("UPDATE {$_pre}content$_erp SET list='$rs[posttime]' WHERE id='$rs[id]'");
		}
		$times=$timestamp-$rs[posttime];
		if(!$webdb[Info_list_cache]&&$times<3600){
			$rs[times]=ceil($times/60).'分钟';
		}elseif(!$webdb[Info_list_cache]&&$times<3600*24){
			$rs[times]=ceil($times/3600).'小时';
		}else{
			$rs[times]=date("m-d",$rs[posttime]);
		}
	
		$rs[posttime]=date("Y-m-d",$rs[full_time]=$rs[posttime]);
		if($rs[picurl]){
			$rs[picurl]=tempdir($rs[picurl]);
		}
	
		$Module_db->showfield($field_db,$rs,'list');
	
		$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
		$listdb[]=$rs;
		
	}

	/*
	$query = $db->query("SELECT id,fid FROM {$_pre}db WHERE city_id='$city_id'  ORDER BY id DESC LIMIT $rows");	
	while($rs = $db->fetch_array($query)){
		$_erp=$Fid_db[tableid][$rs[fid]];			
	  	$rs = $db->get_one("SELECT id,fid,city_id, posttime,title,fname FROM `{$_pre}content$_erp`  WHERE id=$rs[id] ");
	  	if(!$rs[title]){
			continue;
		}
		
		//$rs[content]=@preg_replace('/<([^>]*)>/is',"",$rs[content]);	//把HTML代码过滤掉
		//$rs[content]=get_word($rs[full_content]=$rs[content],100);
		
	  	$rs[posttime]=date("Y-m-d H:i",$rs[posttime]);
	  	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	  	$rs[Lurl]=get_info_url('',$rs[fid],$rs[city_id]);

	  	$listshow.="<div style='clear:both;margin-top:4px;'><span style='float:left;'>[<A HREF='$rs[Lurl]' target='_blank'>$rs[fname]</A>]<A HREF='$rs[url]' target='_blank'>$rs[title]</A></span><span style='float:right;padding-right:10px;'>$rs[posttime]</span></div>";
   	}
	*/

	
}else{
	$_erp=$Fid_db[tableid][$fid];
	if($fidDB[maxperpage]){
		$rows=$fidDB[maxperpage];
	}elseif($webdb[Info_ListNum]){
		$rows=$webdb[Info_ListNum];
	}else{
		$rows=50;
	}
	$listdb=ListThisSort($rows,70);

	if($totalNum){
		$showpage=getpage("","","list.php?",$rows,$totalNum);
		$showpage=preg_replace("/list\.php\?&page=([0-9]+)/eis","get_info_url('',$fid,$city_id,$zone_id,$street_id,array($TempSearch_2'page'=>'\\1'))",$showpage);
	}
}

/*
//栏目的最新信息
$query = $db->query("SELECT * FROM {$_pre}db WHERE city_id='$city_id' and fid='$fid' ORDER BY id DESC LIMIT 11");
$show="<div class=\"smarty_news\">";
while($rs = $db->fetch_array($query)){
	$_erp=$Fid_db[tableid][$rs[fid]];
	$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id=$rs[id]");
	if(!$rs[title]){
		continue;
	}
	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	$rs[title]=get_word($rs[title]);
	$show.="<dd>·<a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}
$show.="</div>";

*/





/**
*为获取标签参数
**/
$chdb[main_tpl]=$fidDB[type]?getTpl("bigsort",$FidTpl['list']):getTpl("list_$fidDB[mid]",$FidTpl['list']);

/**
*标签
**/
$ch_fid	= intval($fidDB[config][label_list]);		//是否定义了栏目专用标签
$ch_pagetype = 2;									//2,为list页,3,为bencandy页
$ch_module = $webdb[module_id]?$webdb[module_id]:99;//系统特定ID参数,每个系统不能雷同
$ch = 0;											//不属于任何专题
require(PHP168_PATH."inc/label_module.php");

require(Mpath."inc/head.php");
require($fidDB[type]?getTpl("bigsort",$FidTpl['list']):getTpl("list_$fidDB[mid]",$FidTpl['list']));
require(Mpath."inc/foot.php");


if($jobs=='show'){	//更新标签
	@unlink($Cache_FileName);
}elseif($webdb[Info_list_cache]&&(time()-filemtime($Cache_FileName))>($webdb[Info_list_cache]*60)){

	if($page<10&&!$otherSelect&&!$zone_id&&!$street_id){
		if(!is_dir(dirname($Cache_FileName))){
			makepath(dirname($Cache_FileName));
		}

		//预先清除多余的文件
		$handle=opendir(dirname($Cache_FileName));
		while($file=readdir($handle)){
			if(eregi("^$page-",$file)){
				unlink(dirname($Cache_FileName)."/$file");
			}
		}

		write_file($Cache_FileName,$content);
	}
}


/**
*针对栏目获取内容信息列表
**/
function ListThisSort($rows,$leng){
	global $db,$_pre,$page,$fid,$fidDB,$SQL,$city_id,$zone_id,$street_id,$field_db,$timestamp,$webdb,$timestamp,$Murl,$Fid_db,$_erp,$totalNum,$otherSelect,$Module_db;
	$SQL='';
	if($street_id>0){
		$SQL =" AND A.street_id='$street_id' ";
	}elseif($zone_id>0){
		$SQL =" AND A.zone_id='$zone_id' ";
	}elseif($city_id>0){
		$SQL =" AND A.city_id='$city_id' ";
	}

	//用户自定义筛选字段,过滤数据
	foreach($field_db AS $key=>$value){
		if($value[listfilter]){
			if($_GET[$key]!=''){
				$otherSelect++;
				$SQL .=" AND B.`$key`='$_GET[$key]' ";
			}
		}
	}

	if(!$webdb[Info_ShowNoYz]){
		$SQL .=" AND A.yz='1' ";
	}
	if($page<1){
		$page=1;
	}
	if($fidDB[listorder]==1){
		$sql_list="A.posttime";
		$sql_order="DESC";
	}elseif($fidDB[listorder]==2){
		$sql_list="A.posttime";
		$sql_order="ASC";
	}elseif($fidDB[listorder]==3){
		$sql_list="A.hits";
		$sql_order="DESC";
	}elseif($fidDB[listorder]==4){
		$sql_list="A.hits";
		$sql_order="ASC";
	}elseif($fidDB[listorder]==5){
		$sql_list="A.lastview";
		$sql_order="DESC";
	}else{
		$sql_list="A.list";
		$sql_order="DESC";
	}

	$min=($page-1)*$rows;

	$query=$db->query("SELECT SQL_CALC_FOUND_ROWS B.*,A.* FROM {$_pre}content$_erp A LEFT JOIN {$_pre}content_{$fidDB[mid]} B ON A.id=B.id WHERE A.fid=$fid $SQL ORDER BY $sql_list $sql_order LIMIT $min,$rows");	
	$RS=$db->get_one("SELECT FOUND_ROWS()");
	$totalNum=$RS['FOUND_ROWS()'];
	while( $rs=$db->fetch_array($query) ){
		if(del_EndTimeInfo($rs)){	//自动删除过期信息
			continue;
		}
		$rs[content]=@preg_replace('/<([^>]*)>/is',"",$rs[content]);	//把HTML代码过滤掉
		$rs[content]=get_word($rs[full_content]=$rs[content],100);
		$rs[title]=get_word($rs[full_title]=$rs[title],$leng);
		if($rs['list']>$timestamp){
			$rs[title]=" <font color='$webdb[Info_TopColor]'>$rs[title]</font> <img src='$Murl/images/default/icotop.gif' border=0>";
		}elseif($rs['list']>$rs[posttime]){
			//置顶过期的信息,需要恢复原来发布日期以方便排序,放在后面
			$db->query("UPDATE {$_pre}content$_erp SET list='$rs[posttime]' WHERE id='$rs[id]'");
		}
		$times=$timestamp-$rs[posttime];
		if(!$webdb[Info_list_cache]&&$times<3600){
			$rs[times]=ceil($times/60).'分钟';
		}elseif(!$webdb[Info_list_cache]&&$times<3600*24){
			$rs[times]=ceil($times/3600).'小时';
		}else{
			$rs[times]=date("m-d",$rs[posttime]);
		}
	
		$rs[posttime]=date("Y-m-d",$rs[full_time]=$rs[posttime]);
		if($rs[picurl]){
			$rs[picurl]=tempdir($rs[picurl]);
		}
	
		$Module_db->showfield($field_db,$rs,'list');
	
		$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
		$listdb[]=$rs;
	}
	return $listdb;
}


/**
*大分类
**/
function ListOnlySort(){
	global $Fid_db,$module_DB,$fid,$city_id;
	foreach($Fid_db[$fid] AS $key=>$value){
		unset($rs);
		$rs[name]=$value;
		$rs[fid]=$key;
		$rs[url]=get_info_url('',$rs[fid],$city_id);
		$msconfig=$module_DB[$Fid_db[mid][$key]][field][sortid];
		$detail=explode("\r\n",$msconfig[form_set]);
		foreach( $detail AS $key2=>$value2){
			$detail2=explode("|",$value2);
			$url=get_info_url('',$rs[fid],$city_id,$zoneid,$streetid,array('sortid'=>"$detail2[0]"));

			$rs[sortdb][]="<A HREF='$url'>$detail2[1]</A>";
		}
		$listdb[]=$rs;
	}
	return $listdb;
}

?>