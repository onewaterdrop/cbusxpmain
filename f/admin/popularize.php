<?php
require_once("global.php");

if($job=="set"){
	$Info_postCkIp[intval($webdb[Info_postCkIp])]=' checked ';
	$Info_postCkMob[intval($webdb[Info_postCkMob])]=' checked ';
	require("head.php");
	require("template/popularize/set.htm");
	require("foot.php");
}
elseif($action=='set'){
	write_config_cache($webdbs);
	refreshto($FROMURL,"�޸ĳɹ�");
}
?>