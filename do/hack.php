<?php
require(dirname(__FILE__)."/"."global.php");
if(ereg("^([-_0-9a-zA-Z]+)$",$hack))
{
	if(is_file(PHP168_PATH."inc/hack/$hack.php")){
		include(PHP168_PATH."inc/hack/$hack.php");
	}elseif(is_file(PHP168_PATH."inc/hack/$hack/index.php")){
		include(PHP168_PATH."inc/hack/$hack/index.php");
	}else{
		showerr("�ļ�������",1);
	}
}
?>