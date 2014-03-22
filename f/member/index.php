<?php
require_once("global.php");


preg_match("/(.*)\/(index\.php|)\?main=(.*)/is",$WEBURL,$array);
$MainUrl=$array[3]?$array[3]:"";

header("location:$webdb[www_url]/member/index.php?SystemId=$webdb[module_id]&main=$MainUrl");
?>