<?php
!function_exists('html') && exit('ERR');

if($hack&&ereg("^([a-z_0-9]+)$",$hack))
{
	if(is_file("inc/hack/$hack.php")){
		include(dirname(__FILE__)."/"."inc/hack/$hack.php");
	}elseif(is_file(PHP168_PATH."inc/hack/$hack/admin.php")){
		include(PHP168_PATH."inc/hack/$hack/admin.php");
	}else{
		showmsg("文件不存在");
	}
	
}
elseif($job=='list'&&$Apower[hack_list])
{
	require("menu.php");
	if(!table_field("{$pre}hack",'class1')){
		$db->query("ALTER TABLE `{$pre}hack` ADD `class1` VARCHAR( 30 ) NOT NULL ,ADD `class2` VARCHAR( 30 ) NOT NULL ,ADD `list` VARCHAR( 10 ) NOT NULL");
		$db->query("ALTER TABLE `{$pre}hack` ADD `linkname` TEXT NOT NULL");
	}
	$query = $db->query("SELECT * FROM {$pre}hack ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		$listdb[]=$rs;
	}
	require(dirname(__FILE__)."/"."head.php");
	require(dirname(__FILE__)."/"."template/hack/list.htm");
	require(dirname(__FILE__)."/"."foot.php");
}
elseif($job=='autoadd'&&$Apower[hack_list])
{
	$dir=opendir(PHP168_PATH."cache/");
	while($file=readdir($dir)){
		if(eregi("\.sql$",$file)){
			$sql=read_file(PHP168_PATH."cache/$file");
			$d1=explode("\n",$sql);
			$d2=explode("#####",$d1[0]);
			$listdb[]=array('filename'=>$file,'name'=>$d2[1]);
			if($pre!='p8_'&&strstr($sql,'p8_')){
				$sql=str_replace("p8_",$pre,$sql);
				write_file(PHP168_PATH."cache/$file",$sql);
			}			
		}
	}
	require(dirname(__FILE__)."/"."head.php");
	require(dirname(__FILE__)."/"."template/hack/autoadd.htm");
	require(dirname(__FILE__)."/"."foot.php");
}
elseif($action=='autoadd'&&$Apower[hack_list])
{
	$db->insert_file(PHP168_PATH."cache/$filename");
	if(!unlink(PHP168_PATH."cache/$filename")){
		showmsg("安装成功,你还需要添加后台管理权限,否则无权管理,请手工删除此文件cache/$filename");
	}else{
		jump("安装成功,你还需要添加后台管理权限,否则无权管理","index.php?lfj=group&job=admin_gr&gid=3",10);
	}
}
elseif($job=='add'&&$Apower[hack_list])
{
	require("menu.php");
	require(dirname(__FILE__)."/"."head.php");
	require(dirname(__FILE__)."/"."template/hack/edit.htm");
	require(dirname(__FILE__)."/"."foot.php");
}
elseif($action=='add'&&$Apower[hack_list])
{
	$rs=$db->get_one("SELECT * FROM {$pre}hack WHERE keywords='$postdb[keywords]' ");
	if($rs){
		showmsg("$postdb[keywords],关键字已经存在了.不能重复");
	}elseif(!ereg("([0-9_a-z]+)",$postdb[keywords])){
		showmsg("关键字必须是0-9a-z_这些字符");
	}
	if(!$postdb[adminurl]||!$postdb[class2]){
		$postdb[class1]=$postdb[class2]='';
	}
	$db->query("INSERT INTO `{$pre}hack` ( `keywords` , `name` , `isclose` , `author` , `config` , `htmlcode` , `hackfile` , `hacksqltable` , `about`,`adminurl`,`class1`,`class2`,`list` ) VALUES ('$postdb[keywords]','$postdb[name]','$postdb[isclose]','$postdb[author]','$postdb[config]','$postdb[htmlcode]','$postdb[hackfile]','$postdb[hacksqltable]','$postdb[about]','$postdb[adminurl]','$postdb[class1]','$postdb[class2]','$postdb[list]')");
	write_hackmenu_cache();
	jump("安装成功,你还需要添加后台管理权限,否则无权管理","index.php?lfj=group&job=admin_gr&gid=3",10);
}
elseif($job=='edit'&&$Apower[hack_list])
{
	require("menu.php");
	$rsdb=$db->get_one("SELECT * FROM {$pre}hack WHERE keywords='$keywords' ");
	require(dirname(__FILE__)."/"."head.php");
	require(dirname(__FILE__)."/"."template/hack/edit.htm");
	require(dirname(__FILE__)."/"."foot.php");
}
elseif($action=='edit'&&$Apower[hack_list])
{
	if(!$postdb[adminurl]||!$postdb[class2]){
		$postdb[class1]=$postdb[class2]='';
	}
	$db->query("UPDATE `{$pre}hack` SET name='$postdb[name]',hackfile='$postdb[hackfile]',hacksqltable='$postdb[hacksqltable]',about='$postdb[about]',adminurl='$postdb[adminurl]',class1='$postdb[class1]',class2='$postdb[class2]',list='$postdb[list]' WHERE keywords='$keywords'");
	write_hackmenu_cache();
	jump("修改成功",$FROMURL,1);
}
elseif($action=='delete'&&$Apower[hack_list])
{
	$rsdb=$db->get_one("SELECT * FROM {$pre}hack WHERE keywords='$keywords' ");
	$db->query("DELETE FROM {$pre}hack WHERE keywords='$keywords'");
	$detail=explode("\r\n",$rsdb[hackfile]);
	foreach($detail AS $key=>$value){
		if($value){
			del_file(PHP168_PATH.$value);
		}
	}

	$detail=explode("\r\n",$rsdb[hacksqltable]);
	foreach($detail AS $key=>$value){
		if($value){
			if( $pre!='p8_' ){
				$value=str_replace("p8_",$pre,$value);
			}
			$db->query("DROP TABLE IF EXISTS `$value`");
		}
	}

	write_hackmenu_cache();
	jump("插件删除成功",$FROMURL,600);
}

function write_hackmenu_cache(){
	global $db,$pre;
	$show="<?php\r\n";
	$query = $db->query("SELECT * FROM {$pre}hack ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		if(!$rs[adminurl]||!$rs[class2]||!$rs[class1]){
			continue;
		}
		$rs[adminurl]=addslashes($rs[adminurl]);
		$rs[linkname] && $rs[name]=$rs[linkname];
		$rs[name]=addslashes($rs[name]);
		$show.="\r\n\$menu_partDB['{$rs[class1]}'][]='{$rs[class2]}';";
		$show.="\r\n\$menudb['{$rs[class2]}']['{$rs[name]}']=array('power'=>'{$rs[keywords]}','link'=>'{$rs[adminurl]}');\r\n";
	}
	write_file(PHP168_PATH."php168/hack.php",$show.'?>');
}

?>