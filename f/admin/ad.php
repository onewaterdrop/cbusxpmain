<?php
require_once("global.php");

$linkdb=array("���λ����"=>"?job=listad","��ӹ��λ"=>"?job=addplace");

$array_adtype=array(
					"word"=>"���ֹ��",
					"pic"=>"ͼƬ���",
					"swf"=>"FLASH���",
					"code"=>"������"
					);

//�г����й��
if($job=="listad"){
	$query = $db->query("SELECT AD.* FROM {$_pre}ad AD ORDER BY AD.id DESC");
	while($rs = $db->fetch_array($query)){
		$rs[begintime]=$rs[begintime]?date("Y-m-d H:i:s",$rs[begintime]):'';
		$rs[endtime]=$rs[endtime]?date("Y-m-d H:i:s",$rs[endtime]):'';
		$listdb[]=$rs;
	}
	require("head.php");
	 
	require("template/ad/listad.htm");
	require("foot.php");
}

//��ӹ��
elseif($job=="addplace")
{
	$rsdb[type]='word';
	$rsdb[keywords]="AD_".rand(1,9999);
	$_pictarget[blank]=$_wordtarget[blank]=" checked ";
	require("head.php");
	 
	require("template/ad/addplace.htm");
	require("foot.php");
}

//�޸Ĺ��
elseif($job=="editadplace")
{
	$rsdb=$db->get_one("SELECT * FROM `{$_pre}ad` WHERE id='$id'");
	@extract(unserialize($rsdb[adcode]));
	$code=stripslashes($code);
	$rsdb[isclose]=intval($rsdb[isclose]);
	$isclose[$rsdb[isclose]]=" checked ";
	$pictarget||$pictarget='blank';
	$wordtarget||$wordtarget='blank';
	$_pictarget[$pictarget]=" checked ";
	$_wordtarget[$wordtarget]=" checked ";
	require("head.php");
	 
	require("template/ad/addplace.htm");
	require("foot.php");
}

//�����޸Ĺ��
elseif($action=="editadplace")
{
	if($postdb[type]=='word'){
		$cdb[linkurl]=$wordlinkurl;
		$cdb[wordtarget]=$wordtarget;
	}elseif($postdb[type]=='pic'){
		$cdb[width]=$picwidth;
		$cdb[height]=$picheight;
		$cdb[pictarget]=$pictarget;
	}elseif($postdb[type]=='swf'){
		$cdb[width]=$swfwidth;
		$cdb[height]=$swfheight;
	}
	$cdb[code]=stripslashes($cdb[code]);
	$postdb[adcode]=addslashes(serialize($cdb));
	$db->query("UPDATE `{$_pre}ad` SET name='$postdb[name]',keywords='$postdb[keywords]',adcode='$postdb[adcode]',type='$postdb[type]',isclose='$isclose' WHERE id='$id' ");
	make_ad_cache();
	refreshto("$FROMURL","�޸ĳɹ�",1);
}

//������ӹ��
elseif($action=="addplace")
{
	if($postdb[type]=='word'){
		$cdb[linkurl]=$wordlinkurl;
		$cdb[wordtarget]=$wordtarget;
	}elseif($postdb[type]=='pic'){
		$cdb[width]=$picwidth;
		$cdb[height]=$picheight;
		$cdb[pictarget]=$pictarget;
	}elseif($postdb[type]=='swf'){
		$cdb[width]=$swfwidth;
		$cdb[height]=$swfheight;
	}
	$cdb[code]=stripslashes($cdb[code]);
	$postdb[adcode]=addslashes(serialize($cdb));
	$db->query("INSERT INTO `{$_pre}ad` (`name` , `keywords` , `begintime` , `endtime` , `adcode` , `type` ) 
				VALUES (
		'$postdb[name]','$postdb[keywords]','$postdb[begintime]','$postdb[endtime]','$postdb[adcode]','$postdb[type]'
		)");
	make_ad_cache();
	refreshto("?job=listad","��ӳɹ�",1);
}

//ɾ�����
elseif($action=='deleteadplace')
{
	$db->query("DELETE FROM `{$_pre}ad` WHERE id='$id'");
	make_ad_cache();
	refreshto("$FROMURL","ɾ���ɹ�",1);
}

function make_ad_cache(){
	global $db,$_pre;
	$show.="<?php\r\n";
	$query = $db->query("SELECT * FROM `{$_pre}ad` WHERE isclose=0");
	while($rs = $db->fetch_array($query)){
		@extract(unserialize($rs[adcode]));
		if($rs[type]=='word'){
			$url="ad.php?job=refreshto&id=$rs[id]&url=".base64_encode($linkurl);
			$code="<a href='$url' target='$wordtarget'>$word</a>";
		}elseif($rs[type]=='pic'){
			$url="ad.php?job=refreshto&id=$rs[id]&url=".base64_encode($linkurl);
			$picurl=tempdir($picurl);
			$code="<a href='$url' target='$pictarget'><img src='$picurl' border=0></a>";
		}elseif($rs[type]=='swf'){
			$flashurl=tempdir($flashurl);
			$code="<object type='application/x-shockwave-flash' data='$flashurl' width='$width' height='$height' wmode='transparent'><param name='movie' value='$flashurl' /><param name='wmode' value='transparent' /></object>";
		}else{
			$code=$code;
		}
		$show.="\$AD_label['$rs[keywords]']=stripslashes(\"".addslashes($code)."\");\r\n";
	}
	write_file("../php168/ad_cache.php",$show);
}
?>