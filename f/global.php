<?php
define('Mpath',dirname(__FILE__).'/');
define( 'Mdirname' , preg_replace("/(.*)\/([^\/]+)/is","\\2",str_replace("\\","/",dirname(__FILE__))) );

require_once(Mpath."../inc/common.inc.php");
require_once(Mpath."php168/config.php");			//系统全局变量
require_once(Mpath."php168/all_fid.php");			//栏目的名称
require_once(Mpath."php168/module_db.php");			//模块的名称
require_once(Mpath."inc/function.php");
@include_once(Mpath."inc/biz.function.php");
@include_once(PHP168_PATH."php168/ad_cache.php");	//全站广告变量缓存文件
@include_once(PHP168_PATH."php168/label_hf.php");	//标签的头与底的变量值
@include_once(PHP168_PATH."php168/module.php");		//模块系统的参数变量值
require_once(Mpath."inc/module.class.php");


$_pre="{$pre}{$webdb[module_pre]}";					//数据表前缀

$Module_db=new Module_Field();						//自定义模型相关

$Murl=$webdb[www_url].'/'.Mdirname;					//本模块的访问地址
$Mdomain=$ModuleDB[$webdb[module_pre]][domain]?$ModuleDB[$webdb[module_pre]][domain]:$Murl;

@include_once(Mpath."php168/all_city.php");			//必须要放在$Mdomain变量之后,里边要用到$Mdomain变量

//兼容IIS,多城市域名的处理方法
if(!$_GET[choose_cityID]){
	foreach( $city_DB[domain] AS $key=>$value){
		if($value==preg_replace("/http:\/\/([^\/]+)\/(.*)/is","http://\\1",$WEBURL)){
			$_GET[choose_cityID]=$key;
			setcookie('city_id',$key,$timestamp+3600,'/');
			break;
		}
	}
}

/**
*系统默认风格
**/
$STYLE=$webdb[Info_style]?$webdb[Info_style]:"default";

/**
*前台是否开放
**/
if(!$webdb[Info_webOpen])
{
	$webdb[Info_closeWhy]=str_replace("\r\n","<br>",$webdb[Info_closeWhy]);
	showerr("网站暂时关闭:$webdb[Info_closeWhy]");
}

//普通伪静态
if($stringID&&$webdb[Info_htmlType]==1){
	$detail=explode("-",$stringID);
	for($i=0;$i<count($detail) ;$i++ ){
		$$detail[$i]=$_GET[$detail[$i]]=$detail[++$i];
	}
}

if($_GET[city_id]>0&&!$city_DB[name][$_GET[city_id]]){
	showerr("此地区不存在");
}elseif($_GET[choose_cityID]>0&&!$city_DB[name][$_GET[choose_cityID]]){
	showerr("此地区不存在");
}


//用户首次访问的时候,要把他的来源城市写入COOKIE
if( !isset($_COOKIE['From_City_have_ck']) )
{
	$_COOKIE[From_City]=intval(get_area($onlineip));
	$_COOKIE[From_City] && set_cookie("From_City",$_COOKIE[From_City],600);
	set_cookie('From_City_have_ck',1,600);
	$FirstGoin=1;
}

if( $_GET[choose_cityID] )
{
	set_cookie("choose_cityID",$_GET[choose_cityID],1800);
	$city_id=$_GET[choose_cityID];
}

//用户选择城市优先于按来源判断城市
if(!$city_id)
{
	if($_COOKIE[choose_cityID])
	{
		$city_id=$_COOKIE[choose_cityID];
	}
	else
	{
		$city_id=$_COOKIE[From_City];
	}
}

//单城市版,强制城市ID
if(count($city_DB[name])==1){
	foreach( $city_DB[name] AS $key=>$value){
		$city_id=$key;
	}
	$city_DB[domain][$city_id]=$webdb[Info_sys]?$webdb[www_url]:$Mdomain;
}

unset($foot_tpl,$head_tpl,$index_tpl,$list_tpl,$bencandy_tpl);
$ch=intval($ch);
$fid=intval($fid);
$id=intval($id);
$page=intval($page);
$city_id=intval($city_id);
$zone_id=intval($zone_id);
$street_id=intval($street_id);

@include_once(Mpath."php168/zone/$city_id.php");



//为搜索框使用的
$search_fid_select="<select name='fid' onChange=\"if(this.options[this.selectedIndex].value=='-1'){alert('你不能选择大分类');}\"><option value='0' style='color:#aaa;'>所有栏目</option>";
foreach( $Fid_db[0] AS $key=>$value){
	$search_fid_select.="<option value='-1' style='color:red;'>$value</option>";
	foreach( $Fid_db[$key] AS $key2=>$value2){
		$search_fid_select.="<option value='$key2'>&nbsp;&nbsp;|--$value2</option>";
	}
}
$search_fid_select.="</select>";
$search_city_fid=select_where("{$_pre}city","'postdb[city_id]'  onChange=\"choose_where('getzone',this.options[this.selectedIndex].value,'','1','H')\"",$city_id);



//加载JS时的提示语,你可以换成图片,'号要加\
$Load_Msg="<img alt=\"内容加载中,请稍候...\" src=\"$webdb[www_url]/images/default/ico_loading3.gif\">";



//$city_url为了获取城市目录下的文件路径
if($city_DB[domain][$city_id]){
	$city_url=$city_DB[domain][$city_id];
}elseif($city_DB['dirname'][$city_id]){
	if(eregi("^\.\.",$city_DB['dirname'][$city_id])){
		$city_url=$webdb[www_url].str_replace("../","/",$city_DB['dirname'][$city_id]);
	}else{
		$city_url=$Mdomain."/{$city_DB['dirname'][$city_id]}";
	}
}else{
	$city_url=$webdb[Info_sys]?$webdb[www_url]:$Mdomain;
}










/**
*获取模板的函数
**/
function getTpl($html,$tplpath=''){
	global $STYLE;
	if($tplpath&&file_exists($tplpath)){
		return $tplpath;
	}elseif($tplpath&&file_exists(Mpath.$tplpath)){
		return Mpath.$tplpath;
	}elseif(file_exists(Mpath."template/$STYLE/$html.htm")){
		return Mpath."template/$STYLE/$html.htm";
	}else{
		return Mpath."template/default/$html.htm";
	}
}

/**
*获取信息内容
**/
function Get_Info($type,$rows=5,$leng=20,$fid=0,$mid=0,$cityid='city',$zoneid='city',$streetid='city'){
	global $Fid_db,$city_id,$zone_id,$street_id,$webdb,$timestamp;

	if($fid){
		$fidstring=$fid;
		foreach( $Fid_db[$fid] AS $keyfid=>$value){
			$fidstring .=",$keyfid";
			$fid_array[]=$keyfid;
		}
		$fid_array && $fid_array[]=$fid;
		$SQL .=" AND fid IN ($fidstring) ";
	}elseif($mid>0){
		$SQL=" AND mid='$mid' ";
	}

	$cityid=='city'		&&	$cityid=$city_id;
	$zoneid=='city'		&&	$zoneid=$zone_id;
	$streetid=='city'	&&	$streetid=$street_id;

	if($streetid>0){
		$SQL .=" AND street_id='$streetid' ";
	}elseif($zoneid>0){
		$SQL .=" AND zone_id='$zoneid' ";
	}elseif($cityid>0){
		$SQL .=" AND city_id='$cityid' ";
	}

	if(!$webdb[Info_ShowNoYz]){
		$SQL .=" AND yz='1' ";
	}

	if($type=='hot'){
		$SQL=" WHERE 1 $SQL";
		$SQL_ORDER=" ORDER BY hits DESC LIMIT $rows ";
	}elseif($type=='lastview'){
		$SQL=" WHERE 1 $SQL ";
		$SQL_ORDER=" ORDER BY lastview DESC LIMIT $rows ";
	}elseif($type=='new'){
		$SQL=" WHERE 1 $SQL ";
		$SQL_ORDER=" ORDER BY list DESC LIMIT $rows ";
	}elseif($type=='level'){
		$SQL=" WHERE levels=1 $SQL ";
		$SQL_ORDER=" ORDER BY list DESC LIMIT $rows ";
	}elseif($type=='pic'){
		$SQL=" WHERE ispic=1 $SQL ";
		$SQL_ORDER=" ORDER BY list DESC LIMIT $rows ";
	}else{
		return ;
	}
	$_erp=$Fid_db[tableid][$fid];
	$listdb=Info_list_content(" $SQL ",$SQL_ORDER,$leng=40,$fid_array,$_erp);
	return $listdb;
}

/**
*获取焦点信息内容
**/
function Get_AdInfo($sortid=0,$rows=10,$leng=40,$cityid='city'){
	global $db,$_pre,$timestamp,$city_id;

	$cityid=='city' && $cityid=$city_id;
	$cityid>0 && $SQL =" AND cityid = '$cityid' ";

	$query = $db->query("SELECT * FROM {$_pre}buyad WHERE sortid='$sortid' AND endtime>$timestamp $SQL ORDER BY money DESC,aid DESC LIMIT $rows");
	while($rs = $db->fetch_array($query)){
		$iddb[]=$rs[id];
	}
	$listdb=get_id_info(implode(",",$iddb));
	return $listdb;
}

 
function highlight_keyword($content){
	global $db,$pre,$keywordDB,$webdb,$Mdomain;
	return $content;
}

/**
*获取用户的来源城市
**/
function get_area($ip){
	global $city_DB;
	$area=ipfrom($ip);
	foreach( $city_DB[name] AS $key2=>$value2)
	{
		$value2=str_replace(array("市","区"," "),array("","",""),$value2);
		if(strstr($area,$value2)){
			return $key2;
		}
	}
}

/**
*主要提供给城市,区域,地段的选择使用
**/
function select_where($table,$name='fup',$ck='',$fup=''){
	global $db,$city_DB;
	/*
	if($fup){
		$SQL=" WHERE fup='$fup' ";
	}
	$query = $db->query("SELECT * FROM $table $SQL ORDER BY list DESC");
	while($rs = $db->fetch_array($query)){
		$ckk=$ck==$rs[fid]?" selected ":" ";
		$show.="<option value='$rs[fid]' $ckk>$rs[name]</option>";
	}
	*/
	if(!$fup){
		foreach( $city_DB[name] AS $key=>$value){
			$ckk=$ck==$key?" selected ":" ";
			$show.="<option value='$key' $ckk>$value</option>";
		}
	}elseif($fup){
		if(strstr($name,'zone')&&is_file(Mpath."php168/zone/$fup.php")){
			include(Mpath."php168/zone/$fup.php");
			foreach( $zone_DB[name] AS $key=>$value){
				$ckk=$ck==$key?" selected ":" ";
				$show.="<option value='$key' $ckk>$value</option>";
			}
		}else{
			$query = $db->query("SELECT * FROM $table WHERE fup='$fup' ORDER BY list DESC");
			while($rs = $db->fetch_array($query)){
				$ckk=$ck==$rs[fid]?" selected ":" ";
				$show.="<option value='$rs[fid]' $ckk>$rs[name]</option>";
			}
		}
	}
	return "<select id='$table' name=$name><option value=''>请选择</option>$show</select>";
}


/**
*手机号码查询
**/
function get_mob_area($mob){
	$mob=substr($mob,0,7);
	$string=read_file(Mpath."inc/mobilebook.dat");
	$string=strstr($string,$mob);
	$num=strpos($string,"\n");
	$end=substr($string,0,$num);
	list($a,$area)=explode(",",$end);
	return $area;
}

/**
*选择自定义二级域名或二级目录
**/
function choose_domain(){
	global $city_id,$city_DB,$WEBURL,$Mdomain,$jobs;
	if($jobs=='show'){
		return ;	//更新标签的时候,不需要判断域名
	}
	$_dirname=$city_DB['dirname'][$city_id];
	if($_dirname&&is_dir(Mpath."$_dirname"))
	{
		$_domain=$city_DB[domain][$city_id];
		if($_domain){
			if(!strstr($WEBURL,$_domain)){
				if(eregi("index\.php$",$WEBURL)){
					$url=preg_replace("/(.*)\/([^\/]*)/is","$_domain/",$WEBURL);
					echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$url'>";
					exit;
				}
				$url=preg_replace("/(.*)\/([^\/]*)/is","$_domain/\\2",$WEBURL);
				echo "<META HTTP-EQUIV=REFRESH CONTENT='0;URL=$url'>";
				exit;
			}
		}else{/*
			$__dirname=preg_replace("/(.*)\/([^\/]*)\/([^\/]*)/is","\\2",$WEBURL);
			if(!strstr($__dirname,'.')&&$__dirname!=$_dirname){
				$___name=preg_replace("/(.*)\/([^\/]*)\/([^\/]*)/is","\\3",$WEBURL);
				echo "META HTTP-EQUIV=REFRESH CONTENT='0;URL=$Mdomain/$_dirname/$___name'>";
				exit;
			}*/
		}
	}
}


/**
*显示首页推荐栏目的功能函数
**/
function Info_ListMoreSort($rows,$leng,$cityid='city'){
	global $db,$_pre,$fid,$city_id,$zone_id,$street_id,$timestamp,$webdb,$Fid_db;
	$rows>0 || $rows=7;
	$leng>0 || $leng=30;
	$cityid=='city' && $cityid=$city_id;
	if($cityid>0){
		$_SQL .=" AND city_id='$cityid' ";
	}
	if(!$webdb[Info_ShowNoYz]){
		$_SQL .=" AND yz='1' ";
	}
	foreach( $Fid_db[index_show] AS $key=>$value){
		$_erp=$Fid_db[tableid][$key];
		$rs[name]=$value;
		$rs[fid]=$key;
		$rs[article]=Info_list_content(" WHERE fid=$key $_SQL "," ORDER BY list DESC LIMIT $rows ",$leng,'',$_erp);
		$listdb[]=$rs;
	}
	return $listdb;
}

/**
*获取每个栏目有几条信息
**/
function get_infonum($cityid){
	global $db,$_pre;
	if($cityid>0){
		$SQL=" AND city_id = '$cityid' ";
	}
	$query = $db->query("SELECT count(id) AS NUM, `fid` FROM `{$_pre}db` WHERE 1 $SQL GROUP BY `fid`");
	while($rs = $db->fetch_array($query)){
		$InfoNum[$rs[fid]]=$rs[NUM];
	}
	return $InfoNum;
}

//SEO变量
function seo_eval($string){
	global $city_DB,$fidDB;
	$string=str_replace(
		array('{city_name}','{sort_name}'),
		array($city_DB['name'][$city_id],$fidDB['name']),
		$string);
	return $string;
}
//smarty SEO变量
//sitename是否显示网站名字
function seo_geteval($string,$cityname,$sitename=""){
	global $city_DB,$fidDB,$zoneName;
	if($zoneName!=""){//显示区域名称
		$cityname=$zoneName;	
	}
	$newstring=str_replace("{city_name}",$cityname,$string);
	if($sitename!=""){
		$newstring="【".$newstring."】";
		$newstring.=" - ".$cityname."同地网";
	}
	return $newstring;
	
}
if(!function_exists("check_imgnum")){
	function check_imgnum($yzimg){
		if(!get_cookie("yzImgNum")||get_cookie("yzImgNum")!=$yzimg){
			return false;
			//showerr("验证码不符合,发布失败");
		}else{
			set_cookie("yzImgNum","");
			return true;
		}
	}
}

if(!function_exists("check_rand_num")){
	function check_rand_num($rand_num){
		global $webdb,$timestamp,$db,$pre;
		if($webdb['rand_num_mktime']<1){
			return true;
		}
		if($webdb['rand_num'] && $rand_num!=$webdb['rand_num']){
			return false;
			//die('系统随机码失效,请返回,刷新一下页面,再重新输入数据,重新提交!');
		}
		if(($timestamp-$webdb['rand_num'])>$webdb['rand_num_mktime']*3600){
			
			$source = 'qwertyuioplkjhgfdsazxcvbnm';
			for($i=0;$i<rand(1,5);$i++)
			$ck .= $source{mt_rand(0, strlen($source) -1)};
			$webdb['rand_num_inputname']=$ck;
			$webdb['rand_num']=$timestamp;
			$db->query("REPLACE INTO `{$pre}config` (`c_key` ,`c_value` )VALUES ('rand_num', '{$webdb[rand_num]}')");
			$db->query("REPLACE INTO `{$pre}config` (`c_key` ,`c_value` )VALUES ('rand_num_inputname', '{$webdb[rand_num_inputname]}')");
			$writefile="<?php\r\n";
			$query = $db->query("SELECT * FROM {$pre}config");
			while($rs = $db->fetch_array($query)){
				$rs[c_value]=addslashes($rs[c_value]);
				$writefile.="\$webdb['$rs[c_key]']='$rs[c_value]';\r\n";
			}

			write_file(PHP168_PATH."php168/config.php",$writefile);
		}
		return true;
	}
}

?>