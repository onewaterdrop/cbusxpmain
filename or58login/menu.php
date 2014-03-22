<?php
$base_menuName=array('base'=>'核心功能','member'=>'会员管理','other'=>'插件中心');

$menu_partDB['member']=array('用户管理','权限管理');
$menu_partDB['base']=array(
'核心设置',
'菜单管理',
'网站常用功能管理',
'数据库工具',
);

$menu_partDB['other']=array(
'广告模块',
'插件功能',
'消息/邮件群发',
'日志管理',
);



$menudb["核心设置"]["网站全局参数设置"]=array("power"=>"center_config","link"=>"index.php?lfj=center&job=config");
$menudb["核心设置"]["插件管理中心"]=array("power"=>"hack_list","link"=>"index.php?lfj=hack&job=list");

$menudb["核心设置"]["整合P8其它系统设置"]=array("power"=>"module_list","link"=>"index.php?lfj=module&job=list");
$menudb["核心设置"]["整合外部论坛系统设置"]=array("power"=>"blend_set","link"=>"index.php?lfj=blend&job=set");

$menudb["菜单管理"]["网站头部导航菜单设置"]=array("power"=>"menu_list","link"=>"index.php?lfj=guidemenu&job=list");
$menudb["菜单管理"]["管理员后台菜单设置"]=array("power"=>"adminmenu_list","link"=>"index.php?lfj=adminguidemenu&job=list");
$menudb["菜单管理"]["会员中心菜单设置"]=array("power"=>"membermenu_list","link"=>"index.php?lfj=memberguidemenu&job=list");

$menudb["网站常用功能管理"]["友情链接管理"]=array("power"=>"friendlink_mod","link"=>"index.php?lfj=friendlink&job=list");
$menudb["网站常用功能管理"]["单篇文章独立页面管理"]=array("power"=>"alonepage_list","link"=>"index.php?lfj=alonepage&job=list");

$menudb["用户管理"]["用户资料管理"]=array("power"=>"member_list","link"=>"index.php?lfj=member&job=list");
$menudb["用户管理"]["企业资料管理"]=array("power"=>"company_list","link"=>"index.php?lfj=company&job=list");
$menudb["用户管理"]["添加新用户"]=array("power"=>"member_addmember","link"=>"index.php?lfj=member&job=addmember");
$menudb["用户管理"]["用户资料字段管理"]=array("power"=>"regfield","link"=>"index.php?lfj=regfield&job=editsort");


$menudb["权限管理"]["前台会员用户组权限管理"]=array("power"=>"group_list","link"=>"index.php?lfj=group&job=list");
$menudb["权限管理"]["后台会员用户组权限管理"]=array("power"=>"group_list_admin","link"=>"index.php?lfj=group&job=list_admin");
$menudb["权限管理"]["添加用户组"]=array("power"=>"group_add","link"=>"index.php?lfj=group&job=add");

$menudb["数据库工具"]["备份数据库"]=array("power"=>"mysql_out","link"=>"index.php?lfj=mysql&job=out");
$menudb["数据库工具"]["数据库还原"]=array("power"=>"mysql_into","link"=>"index.php?lfj=mysql&job=into");
$menudb["数据库工具"]["删除备份数据"]=array("power"=>"mysql_del","link"=>"index.php?lfj=mysql&job=del");
$menudb["数据库工具"]["数据库管理"]=array("power"=>"mysql_sql","link"=>"index.php?lfj=mysql&job=sql");

$menudb["广告模块"]["普通广告位管理"]=array("power"=>"ad_listAdPlace","link"=>"index.php?lfj=ad&job=listad");
$menudb["广告模块"]["普通广告销售管理"]=array("power"=>"ad_listuserad","link"=>"index.php?lfj=ad&job=listuserad");
$menudb["广告模块"]["竞价广告位管理"]=array("power"=>"sellad","link"=>"index.php?lfj=sellad&job=listad");
$menudb["广告模块"]["竞价广告销售管理"]=array("power"=>"sellad_listuser","link"=>"index.php?lfj=sellad&job=listuser");

if($IS_BIZPhp168||$GLOBALS[IS_BIZPhp168]){
$menudb["插件功能"]["点卡充值管理"]=array("power"=>"moneycard_make","link"=>"index.php?lfj=moneycard&job=make");
}
$menudb["插件功能"]["积分介绍管理"]=array("power"=>"jfadmin_mod","link"=>"index.php?lfj=jfadmin&job=listjf");

$menudb["插件功能"]["不良词语过滤"]=array("power"=>"limitword_list","link"=>"index.php?lfj=limitword&job=list");
$menudb["插件功能"]["附件管理"]=array("power"=>"attachment_list","link"=>"index.php?lfj=attachment&job=list");
$menudb["插件功能"]["系统在线升级"]=array("power"=>"upgrade_ol","link"=>"index.php?lfj=upgrade&job=get");

$menudb["日志管理"]["后台登录日志"]=array("power"=>"logs_login_logs","link"=>"index.php?lfj=logs&job=login_logs");
$menudb["日志管理"]["后台操作日志"]=array("power"=>"logs_admin_do_logs","link"=>"index.php?lfj=logs&job=admin_logs");

//$menudb["插件功能"]["PHPWIND营销模块"]=array("power"=>"code_code","link"=>"index.php?lfj=code&job=code");
$menudb["插件功能"]["CNZZ流量统计"]=array("power"=>"cnzz_set","link"=>"index.php?lfj=cnzz&job=ask");



@include(PHP168_PATH."php168/hack.php");

if($ForceEnter||$GLOBALS[ForceEnter]){
	foreach( $menu_partDB AS $key1=>$value1){
		if($key1=='base'){
			continue;
		}
		foreach( $value1 AS $key2=>$value2){
			$menu_partDB['base'][]=$value2;
		}
	}
}
?>