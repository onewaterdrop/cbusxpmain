<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
</head>
<body>
<?php
require "global.php";
include_once("include/splitword.func.php");
$sp=new SplitWord();//创建类对象
$str="海口同地网是分类最全信息网站，提供免费发布信息，寻找最新最全的房屋出租、二手房、二手车、二手物品交易、求职招聘等生活信息，涵盖房产、车辆、招工、兼职、黄页等海量的生活分类信息";
$ary=explode(" ",$sp->SplitRMM($str));//调用类方法
echo addkeyWordURL($ary,$str);
function addkeyWordURL($ary,$str){
	$addurl="s/?wd=";
	for($i=0;$i<count($ary);$i++){
		if(strlen($ary[$i])>=6){
			$str=str_replace($ary[$i],"<a href=\"".$addurl.urlencode(get_encoding($ary[$i],"GB2312"))."\">".$ary[$i]."</a>",$str);	
		}
	}
	return $str;
}
?>
</body>
</html>