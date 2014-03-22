<?php
defined('PHP168_PATH') or die();

$db->query("CREATE TABLE IF NOT EXISTS `{$pre}yzimg` (
  `sid` varchar(8) NOT NULL default '',
  `imgnum` varchar(6) NOT NULL default '',
  `posttime` int(10) NOT NULL default '0',
  UNIQUE KEY `sid` (`sid`),
  KEY `posttime` (`imgnum`,`posttime`)
) TYPE=HEAP;");

$string_yzimg = yzImgNumRand(4);

$_string_yzimg=$webdb[yzimg_letter_differen]?$string_yzimg:strtolower($string_yzimg);

$db->query("REPLACE INTO `{$pre}yzimg` ( `sid` , `imgnum` , `posttime` ) VALUES ('$usr_sid', '$_string_yzimg', '$timestamp')");

set_cookie("yzImgNum","$string_yzimg",600);

if($webdb[yzimg_simple])
{
	require_once(PHP168_PATH."inc/waterimage.php");	
	yzImg($string_yzimg);
}
else
{
	$im = imagecreate(65,30) or die('Ê§°Ü!');	

	imagecolorallocate($im,mt_rand(12,100),mt_rand(255,255),mt_rand(255,255));
	$icol = imagecolorallocate($im,mt_rand(0,0),mt_rand(0,0),mt_rand(0,0));
	$scol = imagecolorallocate($im,mt_rand(0,0),mt_rand(0,0),mt_rand(0,0));
	for($i=0; $i < 2; $i++) {
	$linecolor = imagecolorallocate($im, 17, 158, 20);
	$lefty = rand(1, 30-1);
	$righty = rand(1, 30-1);
	imageline($im, 0, $lefty, imagesx($im), $righty, $linecolor);
	}
	for($i=0;$i<4;$i++)
		intval($string_yzimg{$i}) ? imagettftext($im,16, mt_rand(-10, 10), $i*16, mt_rand(15, 30),$icol, dirname(__FILE__).'/lsansdi.ttf', $string_yzimg{$i}) : imagettftext($im,16, mt_rand(-10, 10), $i*16, mt_rand(15, 30),$scol, dirname(__FILE__).'/lsansdi.ttf', $string_yzimg{$i}); 
	//imagettftext($im, 16, -5, 12, 22, $scol, 'comic.ttf', $string_yzimg);



	for($i=0;$i<64;$i++) imagesetpixel($im,mt_rand(0,65),mt_rand(0,30),imagecolorallocate($im,mt_rand(0,255),mt_rand(0,255),mt_rand(0,255)));

	header("Content-type: image/jpeg");
	header("Expires: -1");
	header("Cache-Control: no-store, private, post-check=0, pre-check=0, max-age=0");
	header("Pragma: no-cache");
	imagejpeg($im);
	imagedestroy($im);
}


function yzImgNumRand($lenth){
	global $webdb;
	mt_srand((double)microtime() * 1000000);
	for($i=0;$i<$lenth;$i++){
		$string=$webdb[yzimg_letter_num]?trim($webdb[yzimg_letter_num]):"123456789QERTYUADFGHJLBNM";
		$randval.= substr($string,mt_rand(0,strlen($string)-1),1);
	}
	return $randval;
}

?>