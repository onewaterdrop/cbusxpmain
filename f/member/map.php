<?php
require_once(dirname(__FILE__)."/"."global.php");
@include_once(PHP168_PATH."php168/all_area.php");
if(!$lfjid){
	showerr("你还没登录");
}

if($lfjdb[sex]==1){
	$lfjdb[sex]='男';
}elseif($lfjdb[sex]==2){
	$lfjdb[sex]='女';
}else{
	$lfjdb[sex]='保密';
}

$group_db=$db->get_one("SELECT totalspace,grouptitle FROM {$pre}group WHERE gid='$rsdb[groupid]' ");

//使用已使用空间
$rsdb[usespace]=number_format($rsdb[usespace]/(1024*1024),3);

//系统允许使用空间
$space_system=number_format($webdb[totalSpace],3);

//用户组允许使用空间
$space_group=number_format($group_db[totalspace],3);

//用户本身具有的空间
$space_user=number_format($rsdb[totalspace]/(1024*1024),3);

//用户总共拥有的空间
$rsdb[totalspace]=number_format($webdb[totalSpace]+$group_db[totalspace]+$rsdb[totalspace]/(1024*1024),3);;

$lfjdb[lastvist]=date("Y-m-d H:i:s",$lfjdb[lastvist]);
$lfjdb[regdate]=date("Y-m-d H:i:s",$lfjdb[regdate]);
$lfjdb[money]=get_money($lfjdb[uid]);

if($lfjdb[C][endtime]&&$lfjdb[groupid]!=8){
	$lfjdb[C][endtime]=date("Y-m-d",$lfjdb[C][endtime]);
	$lfjdb[C][endtime]="于{$lfjdb[C][endtime]}截止";
}else{
	$lfjdb[C][endtime]='长期有效';
}

if( ereg("^pwbbs",$webdb[passport_type]) ){
	@extract($db->get_one("SELECT COUNT(*) AS pmNUM FROM {$TB_pre}msg WHERE `touid`='$lfjuid' AND type='rebox' AND ifnew=1"));
}elseif( ereg("^dzbbs",$webdb[passport_type]) ){
	if($webdb[passport_type]=='dzbbs7'){
		$pmNUM=uc_pm_checknew($lfjuid);
	}else{
		@extract($db->get_one("SELECT COUNT(*) AS pmNUM FROM {$TB_pre}pms WHERE `msgtoid`='$lfjuid' AND folder='inbox' AND new=1"));
	}			
}else{
	@extract($db->get_one("SELECT COUNT(*) AS pmNUM FROM `{$pre}pm` WHERE `touid`='$lfjuid' AND type='rebox' AND ifnew='1'"));
}



unset($articleDB,$i);
$query = $db->query("SELECT * FROM {$_pre}db WHERE uid='$lfjuid' ORDER BY id DESC LIMIT 15");
while($rs = $db->fetch_array($query)){
	$i++;
	$_erp=$Fid_db[tableid][$rs[fid]];
	$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id='$rs[id]'");
	$rs[cl]=$i%2==0?'t2':'t1';
	$rs[posttime]=date("Y-m-d H:i:s",$rs[posttime]);
	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	$articleDB[]=$rs;
}

require(dirname(__FILE__)."/"."head.php");
require(dirname(__FILE__)."/"."template/map.htm");
require(dirname(__FILE__)."/"."foot.php");

?>