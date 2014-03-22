<?php
require_once("global.php");

$linkdb=array(
			"添加友情链接"=>"?lfj=friendlink&job=add",
			"友情链接管理"=>"?lfj=friendlink&job=list",
			);

if($job=="mod")
{
	$rsdb=$db->get_one("SELECT * FROM {$_pre}friendlink WHERE id='$id' ");
	$rsdb[ifhide]=intval($rsdb[ifhide]);
	$ifhide[$rsdb[ifhide]]=" checked ";
	$yz[$rsdb[yz]]=" checked ";
	$iswordlink[$rsdb[iswordlink]]=" checked ";
	$select_fid=select_fsort("postdb[fid]",$rsdb[fid]);
	$rsdb[endtime]=$rsdb[endtime]?date("Y-m-d H:i:s",$rsdb[endtime]):'';
	require("head.php");
	require("template/friendlink/mod.htm");
	require("foot.php");
}
elseif($action=="mod")
{
	$postdb[endtime]	&&	$postdb[endtime]=preg_replace("/([\d]+)-([\d]+)-([\d]+) ([\d]+):([\d]+):([\d]+)/eis","mk_time('\\4','\\5', '\\6', '\\2', '\\3', '\\1')",$postdb[endtime]);
	$db->query("UPDATE {$_pre}friendlink SET name='$postdb[name]',url='$postdb[url]',logo='$postdb[logo]',descrip='$postdb[descrip]',`ifhide`='$postdb[ifhide]',`yz`='$postdb[yz]',`iswordlink`='$postdb[iswordlink]',`fid`='$postdb[fid]',endtime='$postdb[endtime]' WHERE id='$id'");
	write_friendlink();
	refreshto("$FROMURL","修改成功",1);
}
elseif($job=="add")
{
	$ifhide[0]=" checked ";
	$iswordlink[0]=" checked ";
	$yz[1]=" checked ";
	$select_fid=select_fsort("postdb[fid]","");
	require("head.php");
	require("template/friendlink/mod.htm");
	require("foot.php");
}
elseif($action=="add")
{
	$db->query("INSERT INTO `{$_pre}friendlink` (`name` , `url` ,`fid` , `logo` , `descrip` , `list`,ifhide,yz,iswordlink ) VALUES ('$postdb[name]','$postdb[url]','$postdb[fid]','$postdb[logo]','$postdb[descrip]','0','$postdb[ifhide]','$postdb[yz]','$postdb[iswordlink]')");
	write_friendlink();
	refreshto("?lfj=friendlink&job=list","添加成功");
}
elseif($job=="list")
{
	if(!is_table("{$_pre}friendlink")){
		$db->query("CREATE TABLE `{$_pre}friendlink` (
`id` mediumint( 5 ) NOT NULL AUTO_INCREMENT ,
`fid` int( 7 ) NOT NULL default '0',
`name` varchar( 30 ) NOT NULL default '',
`url` varchar( 150 ) NOT NULL default '',
`logo` varchar( 150 ) NOT NULL default '',
`descrip` varchar( 255 ) NOT NULL default '',
`list` int( 10 ) NOT NULL default '0',
`ifhide` tinyint( 1 ) NOT NULL default '0',
`iswordlink` tinyint( 1 ) default NULL ,
`hits` tinyint( 7 ) NOT NULL default '0',
`posttime` int( 10 ) NOT NULL default '0',
`uid` int( 7 ) NOT NULL default '0',
`username` varchar( 30 ) NOT NULL default '',
`yz` tinyint( 1 ) NOT NULL default '1',
`endtime` int( 10 ) NOT NULL default '0',
PRIMARY KEY ( `id` ) ,
KEY `yz` ( `yz` , `endtime` , `ifhide` ) 
) TYPE = MYISAM ");
		$db->query("INSERT INTO `{$_pre}friendlink` SELECT * FROM `{$_pre}friendlink`");
	}
	$rows=30;
	if(!$page){
		$page=1;
	}
	if($fid){
		$SQL=" WHERE A.fid='$fid' ";
	}else{
		$SQL="";
	}
	$min=($page-1)*$rows;
	$showpage=getpage("`{$_pre}friendlink` A","$SQL","?lfj=$lfj&job=$job&fid=$fid",$rows);
	$query=$db->query("SELECT A.*,B.name AS fname FROM `{$_pre}friendlink` A LEFT JOIN {$_pre}city B ON A.fid=B.fid $SQL ORDER BY A.list DESC,A.yz ASC,A.id DESC LIMIT $min,$rows");
	while($rs=$db->fetch_array($query)){
		$rs[ifshow]=$rs[ifhide]?"<A HREF='?lfj=$lfj&job=up&ifhide=0&id=$rs[id]' style='color:red;'>首页隐藏</A>":"<A HREF='?lfj=$lfj&job=up&ifhide=1&id=$rs[id]' style='color:blue;'>首页显示</A>";
		if(!$rs[yz]){
			$rs[ifshow]="隐藏";
		}
		if(!$rs[endtime]){
			$rs[state]='长久有效';
		}elseif($rs[endtime]<$timestamp){
			$rs[state]='<font color=#FF0000>已过期</font>';
		}else{
			$rs[state]='<font color=#0000FF>'.date("Y-m-d H:i",$rs[endtime]).'</font>截止';
		}
		if($rs[logo]){
			$rs[logo]=tempdir($rs[logo]);
			$rs[logo]="<img src='$rs[logo]' width=88 height=31 border=0>";
		}
		$rs[yz]=$rs[yz]?"<a href='?lfj=$lfj&job=setyz&yz=0&id=$rs[id]' style='color:red;'><img alt='已通过审核,点击取消审核' src='../../member/images/check_yes.gif' border=0></a>":"<a href='?lfj=$lfj&job=setyz&yz=1&id=$rs[id]' style='color:blue;'><img alt='还没通过审核,点击通过审核' src='../../member/images/check_no.gif' border=0></a>";
		$listdb[]=$rs;
	}
	require("head.php");
	require("template/friendlink/friendlink.htm");
	require("foot.php");
}
elseif($action=="list")
{
	foreach( $listdb AS $key=>$value){
		$db->query("UPDATE {$_pre}friendlink SET `list`='$value' WHERE id='$key'");
	}
	write_friendlink();
	refreshto("$FROMURL","修改成功",1);
}
elseif($action=="delete")
{
	$db->query("DELETE FROM `{$_pre}friendlink` WHERE id='$id' ");
	write_friendlink();
	refreshto("?lfj=friendlink&job=list","删除成功");
}
elseif($job=="up")
{
	$db->query("UPDATE {$_pre}friendlink SET `ifhide`='$ifhide' WHERE id='$id'");
	write_friendlink();
	refreshto("$FROMURL","修改成功",0);
}
elseif($job=="setyz")
{
	$db->query("UPDATE {$_pre}friendlink SET `yz`='$yz' WHERE id='$id'");
	write_friendlink();
	refreshto("$FROMURL","修改成功",0);
}



//友情链接缓存
function write_friendlink(){
	global $db,$_pre,$timestamp;
	$query = $db->query("SELECT * FROM {$_pre}friendlink WHERE yz=1 AND (endtime=0 OR endtime>$timestamp) ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		foreach( $rs AS $key=>$value){
			$rs[$key]=AddSlashes($rs[$key]);
		}
		if($rs[logo]&&!$rs[iswordlink]){
			$rs[logo]=tempdir($rs[logo]);
			if($rs[fid]){
				$show.="\$CFLDB[i_$rs[fid]][]=array('name'=>'$rs[name]','url'=>'$rs[url]','logo'=>'$rs[logo]','descrip'=>'$rs[descrip]');\r\n";
			}else{
				$logodb[]="'$rs[id]'=>array('name'=>'$rs[name]','url'=>'$rs[url]','logo'=>'$rs[logo]','descrip'=>'$rs[descrip]')";
			}
		}else{
			if($rs[fid]){
				$show.="\$CFLDB[w_$rs[fid]][]=array('name'=>'$rs[name]','url'=>'$rs[url]','descrip'=>'$rs[descrip]');\r\n";
			}else{
				$worddb[]="'$rs[id]'=>array('name'=>'$rs[name]','url'=>'$rs[url]','descrip'=>'$rs[descrip]')";
			}
		}
	}
	$write="<?php\r\n\$friendlinkDB[1]=array(".implode(",\r\n",$logodb).");\r\n\$friendlinkDB[0]=array(".implode(",\r\n",$worddb).");";
	
	write_file("../php168/friendlink.php",$write."\r\n$show?>");
}

function select_fsort($name,$fid=''){
	global $db,$_pre,$webdb;
	$show.="<select name='$name'><option value=''>$webdb[Info_areaname]</option>";
	$query = $db->query("SELECT * FROM {$_pre}city ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		$ck=$fid==$rs[fid]?'selected':'';
		$show.="<option value='$rs[fid]' $ck>$rs[name]</option>";
	}
	$show.="</select>";
	return $show;
}
?>