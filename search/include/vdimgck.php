<?php
//Session����·��
//$sessSavePath = dirname(__FILE__)."/../data/sessions/";
//if(is_writeable($sessSavePath) && is_readable($sessSavePath)){ session_save_path($sessSavePath); }

//��ȡ����ַ�
$rndstring = "";
for($i=0;$i<4;$i++){
	//$rndstring .= chr(mt_rand(65,90));//Ӣ��
	$rndstring.=mt_rand(0,9);
}

//���֧��GD�����ͼ
if(function_exists("imagecreate"))
{
	//PutCookie("dd_ckstr",strtolower($rndstring),1800,"/");
	session_register('dd_ckstr');
	$_SESSION['dd_ckstr'] = strtolower($rndstring);
	$rndcodelen = strlen($rndstring);
  //ͼƬ��С
  $im = imagecreate(50,22);
  //����
  $font_type = dirname(__FILE__)."/data/ant2.ttf";
  //������ɫ
  $bgcolor = ImageColorAllocate($im, 245,245,245);
  //�߿�ɫ
  $iborder = ImageColorAllocate($im, 0x71,0x76,0x67); 
  
  //����ɫ
  //��֧�� imagettftext
  $fontColor = ImageColorAllocate($im, 0x50,0x4d,0x47); 
  
  //֧�� imagettftext
  $fontColor2 = ImageColorAllocate($im, 0x36,0x38,0x32);
  //��Ӱ
  $fontColor1 = ImageColorAllocate($im, 0xbd,0xc0,0xb8); 
  
  //�ӵ㱳����
  //$lineColor1 = ImageColorAllocate($im, 130,220,245);
  //$lineColor2 = ImageColorAllocate($im, 225,245,255);
  
  //������
  //for($j=3;$j<=16;$j=$j+3) imageline($im,2,$j,48,$j,$lineColor1);
  //for($j=2;$j<52;$j=$j+(mt_rand(3,6))) imageline($im,$j,2,$j-6,18,$lineColor2);
  
  //�߿�
  imagerectangle($im, 0, 0, 49, 21, $iborder);
  
  $strposs = array();
  //����
  for($i=0;$i<$rndcodelen;$i++){
	  if(function_exists("imagettftext")){
	  	$strposs[$i][0] = $i*10+6;
	  	$strposs[$i][1] = mt_rand(15,18);
	  	imagettftext($im, 11, 5, $strposs[$i][0]+1, $strposs[$i][1]+1, $fontColor1, $font_type, $rndstring[$i]);
	  }
	  else{
	  	imagestring($im, 5, $i*10+6, mt_rand(2,4), $rndstring[$i], $fontColor);
	  }
  }
  
  
  //����
  for($i=0;$i<$rndcodelen;$i++){
	  if(function_exists("imagettftext")){
	  	imagettftext($im, 11,5, $strposs[$i][0]-1, $strposs[$i][1]-1, $fontColor2, $font_type, $rndstring[$i]);
	  }
  }
  
  
  header("Pragma:no-cache\r\n");
  header("Cache-Control:no-cache\r\n");
  header("Expires:0\r\n");
  //����ض����͵�ͼƬ��ʽ�����ȼ�Ϊ gif -> jpg ->png
  if(function_exists("imagejpeg")){
  	header("content-type:image/jpeg\r\n");
  	imagejpeg($im);
  }else{
    header("content-type:image/png\r\n");
  	imagepng($im);
  }
  ImageDestroy($im);

}else{ //��֧��GD��ֻ�����ĸ ABCD	
	//PutCookie("dd_ckstr","abcd",1800,"/");
	session_register('dd_ckstr');
	$_SESSION['dd_ckstr'] = "abcd";
	header("content-type:image/jpeg\r\n");
	header("Pragma:no-cache\r\n");
  header("Cache-Control:no-cache\r\n");
  header("Expires:0\r\n");
	$fp = fopen("./vdcode.jpg","r");
	echo fread($fp,filesize("./vdcode.jpg"));
	fclose($fp);
}

?>