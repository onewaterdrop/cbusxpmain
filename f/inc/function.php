<?php
function Info_keyword_ck($keyword){
	if($keyword){
		$keyword=str_replace("　"," ",$keyword);
		$keyword=str_replace(","," ",$keyword);
		$keyword=str_replace("，"," ",$keyword);
		$keyword=str_replace("、"," ",$keyword);
		$detail=explode(" ",$keyword);
		foreach( $detail AS $key=>$value){
			//大于3个字节的,才列为关键字,一个汉字相当于两个字节
			if(strlen($value)>3){
				 $array[$value]=$value;
			}
		}
		$keyword=implode(" ",$array);
		return $keyword;
	}
}

function update_fen($id){
	global $db,$_pre;
	return;
	$query = $db->query("SELECT * FROM {$_pre}comments WHERE id='$id'");
	while($rs = $db->fetch_array($query)){
		for($i=1;$i<6 ;$i++ ){
			if($rs["fen{$i}"]){
				${"fen{$i}_num"}++;
				${"fen{$i}_vale"}+=$rs["fen{$i}"];
			}
		}
	}
	for($i=1;$i<6 ;$i++ ){
		if(${"fen{$i}_num"}){
			//放大10倍易于更准确的作比较
			$value=ceil((${"fen{$i}_vale"}/${"fen{$i}_num"})*10);
			$array[]="`f{$i}`='$value'";
		}		
	}
	if($array){
		$SQL=implode(",",$array);
		$db->query("UPDATE {$_pre}content SET $SQL WHERE id='$id'");
	}
}

function get_post_url($type,$fid,$id='',$cityid='',$zoneid='',$streetid=''){
	global $Mdomain,$webdb,$Fid_db,$zone_DB,$street_DB,$city_DB,$BIZ_MODULEDB;

	$_cityid=$cityid?$cityid:$GLOBALS['city_id'];
	if($city_DB['domain'][$_cityid]){
		$url=$city_DB['domain'][$_cityid].'/';
	}elseif($city_DB['dirname'][$_cityid]){
		$url=$Mdomain.'/'.$city_DB['dirname'][$_cityid].'/';
	}else{
		$url=($webdb['Info_sys']?$webdb['www_url']:$Mdomain).'/';
	}

	if($webdb[post_htmlType]==1){
		if($type=='del'){
			$url.="post-del";
		}elseif($type=='edit'){
			$url.="post-edit";
		}else{
			$url.="post";
		}
		$fid && $url.="-$fid";
		if($type!='del'&&$type!='edit'){	//新发布
			$cityid && $url.="-$cityid";
			$zoneid && $url.="-$zoneid";
			$streetid && $url.="-$streetid";
		}else{
			$url.="-$id";
		}
		$url.=".htm";
	}else{
		if($type=='del'){
			$url.="post.php?action=del&fid=$fid&id=$id";
		}elseif($type=='edit'){
			$url.="post.php?job=edit&fid=$fid&id=$id";
		}else{
			$url.="post.php";
			if($street_id){
				$url.="?fid=$fid&city_id=$cityid&zone_id=$zoneid&street_id=$streetid";
			}elseif($zoneid){
				$url.="?fid=$fid&city_id=$cityid&zone_id=$zoneid";
			}elseif($fid&&$cityid){
				$url.="?fid=$fid&city_id=$cityid";
			}elseif($fid){
				$url.="?fid=$fid";
			}
		}
	}
	return $url;
}

function get_info_url($id,$fid,$cityid='',$zoneid='',$streetid='',$array=array()){
	global $Mdomain,$webdb,$Fid_db,$zone_DB,$street_DB,$city_DB,$BIZ_MODULEDB;
	$webdb[Info_htmlname] || $webdb[Info_htmlname]='html';
	if( count($city_DB[name])>2 ){
		if(!function_exists('MODULE_CK')||!in_array('fenlei',$BIZ_MODULEDB)){
			die("Free!");
		}		
	}
	if($city_DB[domain][$cityid]){
		$url=$city_DB[domain][$cityid].'/';
	}elseif($city_DB['dirname'][$cityid]){
		$url=$Mdomain.'/'.$city_DB['dirname'][$cityid].'/';
	}else{
		$url=($webdb[Info_sys]?$webdb[www_url]:$Mdomain).'/';
	}
	if($webdb[Info_htmlType]==2){
		if($id){
			$url.="{$Fid_db[dir_name][$fid]}/f$id.$webdb[Info_htmlname]";			
		}else{			
			if(!$zoneid&&!$streetid){
				$url.="{$Fid_db[dir_name][$fid]}";
			}elseif($zoneid&&$streetid){
				@include_once(dirname(__FILE__)."/../php168/zone/$cityid.php");
				$url.="{$zone_DB['dirname'][$zoneid]}-{$street_DB['dirname'][$streetid]}/{$Fid_db[dir_name][$fid]}";
			}elseif($zoneid){
				@include_once(dirname(__FILE__)."/../php168/zone/$cityid.php");
				$url.="{$zone_DB['dirname'][$zoneid]}/{$Fid_db[dir_name][$fid]}";
			}
			foreach($array AS $key=>$value){
				if($value!=''){
					if($key=='page'&&$value<2){
						continue;
					}					
					$value=str_replace(array('-','/'),array('#@#','#!#'),$value);
					$value=urlencode($value);
					$url.="-$key-$value";
				}				
			}
			$url.="/";
		}
	}elseif($webdb[Info_htmlType]==1){
		if($id){
			$url.="bencandy-city_id-$cityid-fid-$fid-id-$id.$webdb[Info_htmlname]";
		}else{
			$url.="list-city_id-$cityid-fid-$fid";
			$array[zone_id]=$zoneid;
			$array[street_id]=$streetid;
			foreach($array AS $key=>$value){
				if($value!=''){					
					$value=str_replace(array('-','/'),array('#@#','#!#'),$value);
					$value=urlencode($value);
					$url.="-$key-$value";
				}
			}
			$url.=".$webdb[Info_htmlname]";
		}
	}else{		
		if($id){
			$url.="bencandy.php?city_id=$cityid&fid=$fid&id=$id";
		}else{
			$url.="list.php?fid=$fid&city_id=$cityid";
			if($zoneid){
				$url.="&zone_id=$zoneid";
			}
			if($streetid){
				$url.="&street_id=$streetid";
			}
			foreach($array AS $key=>$value){
				$value=urlencode($value);
				$url.="&$key=$value";
			}
		}
	}
	return $url;
}


function get_id_info($IDstring){
	global $db,$_pre,$Fid_db,$webdb;
	if(!$IDstring){
		return ;
	}
	if(!$webdb[Info_ShowNoYz]){
		$SQL =" AND yz='1' ";
	}
	$query = $db->query("SELECT * FROM {$_pre}db WHERE id IN ($IDstring) ORDER BY id DESC");
	while($rs = $db->fetch_array($query)){
		$_erp=$Fid_db[tableid][$rs[fid]];
		$listdb[$rs[id]]=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id=$rs[id] $SQL");
	}
	//krsort($listdb);
	return $listdb;
}

//自动删除过期信息
function del_EndTimeInfo($rs){
	global $db,$_pre,$Fid_db,$timestamp,$webdb;
	if($webdb[Info_DelEndtime]&&$rs[endtime]&&$rs[endtime]<$timestamp){
		$_erp=$Fid_db[tableid][$rs[fid]];
		del_info($rs[id],$_erp,$rs);
		return 1;
	}
}

//删除信息
function del_info($id,$_erp,$rs){
	global $db,$_pre;
	$db->query("DELETE FROM `{$_pre}db` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}content$_erp` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}content_$rs[mid]` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}buyad` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}report` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}collection` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}comments` WHERE id='$id' ");
	$db->query("DELETE FROM `{$_pre}dianping` WHERE id='$id' ");
	//删除缓存
	$rs[city_id] && del_file(Mpath."cache/index/$rs[city_id]");
	del_file(Mpath."cache/list/$rs[city_id]-$rs[fid]");

	
	$query = $db->query("SELECT * FROM `{$_pre}pic` WHERE id='$id'");
	while($rs = $db->fetch_array($query)){
		delete_attachment($rs[uid],tempdir($rs[imgurl]));
		delete_attachment($rs[uid],tempdir("$rs[imgurl].gif"));
	}
}
/**
*获取信息内容
**/
function Info_list_content($where_sql,$order_sql,$leng=40,$fid_array,$_erp=''){
	global $db,$_pre,$Fid_db;
	if(is_array($fid_array)){
		$SQL_db[""]="(SELECT * FROM {$_pre}content $where_sql)";
		foreach($fid_array AS $key=>$value){
			$_erp=$Fid_db[tableid][$value];
			$SQL_db["$_erp"]="(SELECT * FROM {$_pre}content$_erp $where_sql)";
		}
		$SQL=implode(" UNION ALL ",$SQL_db).$order_sql;
	}else{
		$SQL="SELECT * FROM {$_pre}content$_erp $where_sql $order_sql";
	}
	$query=$db->query($SQL);
	while( $rs=$db->fetch_array($query) ){
		if(del_EndTimeInfo($rs)){	//自动删除过期信息
			continue;
		}
		$leng && $rs[title]=get_word($rs[full_title]=$rs[title],$leng);
		$rs[posttime]=date("Y-m-d",$rs[full_time]=$rs[posttime]);
		if($rs[picurl]){
			$rs[picurl]=tempdir($rs[picurl]);
		}
		$listdb[]=$rs;
	}
	return $listdb;
}
?>