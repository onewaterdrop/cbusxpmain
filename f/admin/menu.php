<?php
$passport_admin=1;	//允许整站后台调用,0不允许,1允许

$menudb["分类信息->基本设置"]["核心设置"]["link"]="center.php?job=config";
$menudb["分类信息->基本设置"]["核心设置"]["power"]="1";

$menudb["分类信息->基本设置"]["伪静态设置"]["link"]="center.php?job=html";
$menudb["分类信息->基本设置"]["伪静态设置"]["power"]="1";

$menudb["分类信息->基本设置"]["页面设置"]["link"]="center.php?job=settpl";
$menudb["分类信息->基本设置"]["页面设置"]["power"]="1";

$menudb["分类信息->基本设置"]["首页分类布局设置"]["link"]="center.php?job=settable";
$menudb["分类信息->基本设置"]["首页分类布局设置"]["power"]="1";

//$menudb["分类信息->基本设置"]["更新首页标签"]["link"]="../index.php?jobs=show";
//$menudb["分类信息->基本设置"]["更新首页标签"]["power"]="1";

//$menudb["分类信息->基本设置"]["更新缓存"]["link"]="cache.php?job=list";
//$menudb["分类信息->基本设置"]["更新缓存"]["power"]="1";

//$menudb["分类信息->基本设置"]["页面静态化"]["link"]="makehtml.php?job=set";
//$menudb["分类信息->基本设置"]["页面静态化"]["power"]="1";

//$menudb["分类信息->基本设置"]["广告管理"]["link"]="ad.php?job=listad";
//$menudb["分类信息->基本设置"]["广告管理"]["power"]="1";

//$menudb["分类信息->基本设置"]["竟价广告管理"]["link"]="sellad.php?job=listad";
//$menudb["分类信息->基本设置"]["竟价广告管理"]["power"]="1";

$menudb["分类信息->基本设置"]["审核过滤设置"]["link"]="autopass.php?job=set";
$menudb["分类信息->基本设置"]["审核过滤设置"]["power"]="1";

$menudb["分类信息->基本设置"]["更新首页标签"]["link"]="center.php?job=label";
$menudb["分类信息->基本设置"]["更新首页标签"]["power"]="1";

$menudb["分类信息->内容管理"]["内容管理"]["link"]="list.php?job=list";
$menudb["分类信息->内容管理"]["内容管理"]["power"]="1";

$menudb["分类信息->内容管理"]["评论管理"]["link"]="comment.php?job=list";
$menudb["分类信息->内容管理"]["评论管理"]["power"]="1";

$menudb["分类信息->内容管理"]["点评管理"]["link"]="dianping.php?job=list";
$menudb["分类信息->内容管理"]["点评管理"]["power"]="1";

$menudb["分类信息->内容管理"]["栏目管理"]["link"]="sort.php?job=listsort&yellow=0";
$menudb["分类信息->内容管理"]["栏目管理"]["power"]="1";

$menudb["分类信息->其他管理"]["模型管理"]["link"]="module.php?job=listsort";
$menudb["分类信息->其他管理"]["模型管理"]["power"]="1";

$menudb["分类信息->其他管理"]["联级字段管理"]["link"]="fieldsort.php?job=listsort&type=all";
$menudb["分类信息->其他管理"]["联级字段管理"]["power"]="1";


$menudb["分类信息->其他管理"]["城市地区管理"]["link"]="spsort.php?job=city";
$menudb["分类信息->其他管理"]["城市地区管理"]["power"]="1";

$menudb["分类信息->其他管理"]["举报信息管理"]["link"]="report.php?job=list";
$menudb["分类信息->其他管理"]["举报信息管理"]["power"]="1";

//$menudb["分类信息->其他管理"]["采集参数列表"]["link"]="gather.php?job=list";
//$menudb["分类信息->其他管理"]["采集参数列表"]["power"]="1";

$menudb["分类信息->其他管理"]["字符批量替换"]["link"]="replace.php?job=list";
$menudb["分类信息->其他管理"]["字符批量替换"]["power"]="1";


if(!$webdb[Info_sys]&&!$webdb[SystemType]){

$menudb["分类信息->数据库管理"]["备份数据"]["link"]="mysql.php?lfj=mysql&job=out";
$menudb["分类信息->数据库管理"]["备份数据"]["power"]="1";

$menudb["分类信息->数据库管理"]["还原数据"]["link"]="mysql.php?lfj=mysql&job=into";
$menudb["分类信息->数据库管理"]["还原数据"]["power"]="1";

$menudb["分类信息->数据库管理"]["删除备份数据"]["link"]="mysql.php?lfj=mysql&job=del";
$menudb["分类信息->数据库管理"]["删除备份数据"]["power"]="1";
}

$menudb["分类信息->其他管理"]["友情链接管理"]["link"]="friendlink.php?job=list";
$menudb["分类信息->其他管理"]["友情链接管理"]["power"]="1";

?>