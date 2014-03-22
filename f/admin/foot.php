<?php
if($webdb['run_time']==1){
	$speed_endtime=explode(' ',microtime());
	$speed_totaltime.="TIME ".number_format((($speed_endtime[0]+$speed_endtime[1]-$speed_headtime)/1),6)." second(s)";
}
require_once("template/foot.htm");
?>