<?php
if(!function_exists('html')){
die('F');
}
if(!$lfjuid){
	showerr('���ȵ�¼');
}
$_erp=$Fid_db[tableid][$fid];
$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id='$id'");
$fidDB=$db->get_one("SELECT * FROM {$_pre}sort WHERE fid='$rs[fid]'");
if($rs[uid]!=$lfjuid){
	showerr('��ûȨ��');
}
$lfjdb[money]=intval(get_money($lfjuid));

if($type==1){
	$money=$webdb[AdInfoIndexShow];
}elseif($type==2){
	$money=$webdb[AdInfoBigsortShow];
}elseif($type==3){
	$money=$webdb[AdInfoSortShow];
}else{
	$money=0;
}
if($lfjdb[money]<$money){
	showerr("��Ļ��ֲ���:$money,����ѡ�񽹵���ʾ");
}
add_user($lfjuid,-intval($money));
$endtime=$timestamp+$webdb[AdInfoShowTime]*24*3600;
if($type==1){
	$db->query("INSERT INTO `{$_pre}buyad` (`sortid`, `cityid`, `id`, `mid`, `uid`, `begintime`, `endtime`, `money`, `hits`) VALUES ('-1','$rs[city_id]','$id','$rs[mid]','$rs[uid]','$timestamp','$endtime','$money','')");
}elseif($type==2){
	$db->query("INSERT INTO `{$_pre}buyad` (`sortid`, `cityid`, `id`, `mid`, `uid`, `begintime`, `endtime`, `money`, `hits`) VALUES ('$fidDB[fup]','$rs[city_id]','$id','$rs[mid]','$rs[uid]','$timestamp','$endtime','$money','')");
}elseif($type==3){
	$db->query("INSERT INTO `{$_pre}buyad` (`sortid`, `cityid`, `id`, `mid`, `uid`, `begintime`, `endtime`, `money`, `hits`) VALUES ('$rs[fid]','$rs[city_id]','$id','$rs[mid]','$rs[uid]','$timestamp','$endtime','$money','')");
}
refreshto("$FROMURL","������ʾ���óɹ�",1);
?>