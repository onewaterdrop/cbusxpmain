<?php
!function_exists('html') && exit('ERR');
if($job=="list"&&$Apower[attachment_list]){
	!$page&&$page=1;
	$rows=40;
	$min=($page-1)*$rows;
	$down_path || $down_path=$webdb[updir];
	
	$up_path=preg_replace("/(.*)\/([^\/]+)/is","\\1",$down_path);

	$thispath=PHP168_PATH.$down_path;

	$file_db=get_file($down_path);

	$total=count($file_db);
	
	$showpage=getpage("","","index.php?lfj=$lfj&job=$job&down_path=$down_path",$rows,$total);

	for($i=$min;$i<$min+$rows;$i++){
		if(!$file_db[$i]){
			break;
		}
		$rs[type]=$file_db[$i][type];
		$rs[size]=number_format(filesize(PHP168_PATH.$file_db[$i][path])/1024,3);
		$rs[path]=($file_db[$i][path]);
		$rs[name]=basename($file_db[$i][path]);
		$rs[icon]=$file_db[$i][icon];
		$rs[posttime]=date("Y-m-d H:i:s",filemtime(PHP168_PATH.$file_db[$i][path]));
		$rs[url]="$webdb[www_url]/".$file_db[$i][path];
		$rs[id]=$i;
		$listdb[]=$rs;
	}

	//$totalsize=dskspace(PHP168_PATH."$webdb[updir]");
	//$totalsize=abs(number_format($totalsize/(1024),3));
	require(dirname(__FILE__)."/"."head.php");
	require(dirname(__FILE__)."/"."template/attachment/list.htm");
	require(dirname(__FILE__)."/"."foot.php");
}
elseif($action=="delete"&&$Apower[attachment_list])
{
	foreach($iddb AS $key=>$value)
	{
		if(!strstr($value,"..")&&!ereg("^\/",$value)&&$value){
			del_file(PHP168_PATH.$value);
		}
	}
	jump("ɾ���ɹ�","$FROMURL",1);
}
// 

function get_file($dir){
	$dir_hand = opendir(PHP168_PATH.$dir);
	while($file=readdir($dir_hand))
	{
		$rs[path]="$dir/$file";
		if(is_file(PHP168_PATH."$dir/$file"))
		{
			$rs[type]="file";
			$rs[icon]="images/file_icon.gif";
			$array[]=$rs;
		}
		elseif( $file!="." && $file!=".." && is_dir(PHP168_PATH."$dir/$file") )
		{
			$rs[type]="dir";
			$rs[icon]="images/dir_icon.gif";
			$array[]=$rs;
		}
	}
	return $array;
}

function dskspace($dir) 
{ 
   $s = stat($dir); 
   $space = $s["blocks"]*512; 
   if (is_dir($dir)) 
   { 
     $dh = opendir($dir); 
     while (($file = readdir($dh)) !== false) 
       if ($file != "." and $file != "..") 
         $space += dskspace($dir."/".$file); 
     closedir($dh); 
   } 
   return $space; 
}

?>