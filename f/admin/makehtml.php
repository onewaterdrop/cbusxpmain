<?php
require_once("global.php");


if($job=="set"){
	require("head.php");
	require("template/makehtml/set.htm");
	require("foot.php");
}elseif($action=="deleteindex"){
	if(unlink("../index.htm")){
		refreshto("?job=set","ɾ���ɹ�");
	}elseif(is_file("../index.htm")){
		showerr("ɾ��ʧ��,���޸��ļ�����Ϊ��д");
	}else{
		showerr("ɾ��ʧ��,�ļ�������");
	}
}


?>