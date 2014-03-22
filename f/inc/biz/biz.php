<?php
!function_exists('AvoidGather') && exit('F');
unset($BIZ_URLDB);


//绑定的域名,不绑定的话,有日期限制www.28xl.com

if(date("Ymd")>20100310){
	//die("请到官方同步升级!!!");
}

$BIZ_URLDB[]="f.com";

if($BIZID&&$BIZ_URLDB){
	echo '<meta http-equiv="Content-Type" content="text/html; charset=gb2312">';
	echo '你的授权ID是:<br>';
	echo md5("$BIZ_URLDB[0]");
	exit;
}

//购买的商业模块,不设置的话,有日期限制

$BIZ_MODULEDB[]='fenlei';
//$BIZ_MODULEDB[]='mv';
//$BIZ_MODULEDB[]='blog';
//$BIZ_MODULEDB[]='photo';
//$BIZ_MODULEDB[]='flash';
//$BIZ_MODULEDB[]='download';
//$BIZ_MODULEDB[]='article';
//$BIZ_MODULEDB[]='hr';
//$BIZ_MODULEDB[]='shop';
//$BIZ_MODULEDB[]='music';
//$BIZ_MODULEDB[]='shopping';
//$BIZ_MODULEDB[]='news';
//$BIZ_MODULEDB[]='wenxue';
//$BIZ_MODULEDB[]='yp';$BIZ_MODULEDB[]='business';
//$BIZ_MODULEDB[]='article';
//$BIZ_MODULEDB[]='group';
//$BIZ_MODULEDB[]='w8';
//整站+文章商业用户
$IS_BIZPhp168=1;


$IS_BIZ=1;								//商业用户

BIZ_URL_CK($BIZ_URLDB);

function BIZ_URL_CK($BIZ_URLDB){
	global $db,$_SERVER,$HTTP_SERVER_VARS,$PHP_SELF_TEMP;
	if( !is_array($BIZ_URLDB) )
	{
		if(date("Ymd")>20090110){
			die("a为了保证你的系统运行更稳定,功能更强大,请到官方同步升级后,才可以继续使用,谢谢合作,如给你带来不便,敬请原谅!!!");
		}
		return ;
	}


	$BIZ_URLDB[]='127.0.0.1';
	$BIZ_URLDB[]='localhost';
	$PHP_SELF_TEMP=$_SERVER['PHP_SELF'] ? $_SERVER['PHP_SELF'] : $_SERVER['SCRIPT_NAME'];
	$PHP_SELF=$_SERVER['REQUEST_URI']?$_SERVER['REQUEST_URI']:$PHP_SELF_TEMP;
	$HTTP_HOST=$_SERVER['HTTP_HOST']?$_SERVER['HTTP_HOST']:$HTTP_SERVER_VARS['HTTP_HOST'];
	$WEBURL=$HTTP_HOST.$PHP_SELF;

	if(!$WEBURL){
		$allowuse=1;
	}else{
		foreach( $BIZ_URLDB AS $key=>$value){
			if(eregi("^[-a-z0-9_\.]*$value",$WEBURL)){
				$allowuse=1;
			}
		}
	}
	if(!$allowuse){
		die("非授权用户禁止使用,有问题请联系官方站http://www.or58.com");
	}
	return 1;
}

function INFO_CK(){
}


function MODULE_CK($type){
	global $pre,$BIZ_MODULEDB;

	if( !is_array($BIZ_MODULEDB) )
	{
		if(date("Ymd")>20090110){
			die("b为了保证你的系统运行更稳定,功能更强大,请到官方同步升级后,才可以继续使用,谢谢合作,如给你带来不便,敬请原谅!!!");
		}
		return ;
	}
	
	if( !in_array($type,$BIZ_MODULEDB) ){
		die("此模块未经授权,禁止使用。有问题请联系官方站http://www.or58.com");
	}
	return 1;
}
?>