<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
</head>
<body>
<?php
require "global.php";
include_once("include/splitword.func.php");
$sp=new SplitWord();//���������
$str="����ͬ�����Ƿ�����ȫ��Ϣ��վ���ṩ��ѷ�����Ϣ��Ѱ��������ȫ�ķ��ݳ��⡢���ַ������ֳ���������Ʒ���ס���ְ��Ƹ��������Ϣ�����Ƿ������������й�����ְ����ҳ�Ⱥ��������������Ϣ";
$ary=explode(" ",$sp->SplitRMM($str));//�����෽��
echo addkeyWordURL($ary,$str);
function addkeyWordURL($ary,$str){
	$addurl="s/?wd=";
	for($i=0;$i<count($ary);$i++){
		if(strlen($ary[$i])>=6){
			$str=str_replace($ary[$i],"<a href=\"".$addurl.urlencode(get_encoding($ary[$i],"GB2312"))."\">".$ary[$i]."</a>",$str);	
		}
	}
	return $str;
}
?>
</body>
</html>