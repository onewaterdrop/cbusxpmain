<?php
require_once("global.php");

preg_match("/(.*)\/(index\.php|)\?main=([^\/]+)/is",$WEBURL,$array);
$MainUrl=$array[3]?$array[3]:"center.php?job=config";

require_once("template/index.htm");
?>