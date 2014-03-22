<?php
require_once("global.php");


if($job=="set"){
	require("head.php");
	require("template/makehtml/set.htm");
	require("foot.php");
}elseif($action=="deleteindex"){
	if(unlink("../index.htm")){
		refreshto("?job=set","删除成功");
	}elseif(is_file("../index.htm")){
		showerr("删除失败,请修改文件属性为可写");
	}else{
		showerr("删除失败,文件不存在");
	}
}


?>