<?php
require_once(dirname(__FILE__)."/"."../inc/common.inc.php");	//�����ļ�
@include_once(PHP168_PATH."inc/artic_function.php");			//����һЩ��ȡ�ļ����ݵĺ���

@include_once(PHP168_PATH."php168/ad_cache.php");		//�����������ļ�
@include_once(PHP168_PATH."php168/label_hf.php");		//��ǩͷ����ײ����������ļ�
@include_once(PHP168_PATH."php168/all_fid.php");		//ȫ����Ŀ�����ļ�

if(!$webdb[web_open])
{
	$webdb[close_why] = str_replace("\n","<br>",$webdb[close_why]);
	showerr("��վ��ʱ�ر�:$webdb[close_why]");
}

/**
*������ЩIP����
**/
$IS_BIZ && Limt_IP('AllowVisitIp');


$ch=intval($ch);
$fid=intval($fid);
$aid=intval($aid);
$id=intval($id);
$page=intval($page);
unset($listdb,$rs);

//����JSʱ����ʾ��,����Ի���ͼƬ,'��Ҫ��\
$Load_Msg="<img alt=\"���ݼ�����,���Ժ�...\" src=\"$webdb[www_url]/images/default/ico_loading3.gif\">";

//ͷ����ײ�ר��
function HF_tpl($html,$tpl=''){
	global $STYLE,$webdb;
	if(!$webdb[SystemType]){
		return html($html,$tpl);
	}
	if(file_exists(PHP168_PATH."$webdb[SystemType]/template/$STYLE/$html.htm")){
		return PHP168_PATH."$webdb[SystemType]/template/$STYLE/$html.htm";
	}else{
		return PHP168_PATH."$webdb[SystemType]/template/default/$html.htm";
	}
}

if($webdb[SystemType]&&!function_exists('get_info_url')){
@include(PHP168_PATH."$webdb[SystemType]/global.php");
}
?>