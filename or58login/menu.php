<?php
$base_menuName=array('base'=>'���Ĺ���','member'=>'��Ա����','other'=>'�������');

$menu_partDB['member']=array('�û�����','Ȩ�޹���');
$menu_partDB['base']=array(
'��������',
'�˵�����',
'��վ���ù��ܹ���',
'���ݿ⹤��',
);

$menu_partDB['other']=array(
'���ģ��',
'�������',
'��Ϣ/�ʼ�Ⱥ��',
'��־����',
);



$menudb["��������"]["��վȫ�ֲ�������"]=array("power"=>"center_config","link"=>"index.php?lfj=center&job=config");
$menudb["��������"]["�����������"]=array("power"=>"hack_list","link"=>"index.php?lfj=hack&job=list");

$menudb["��������"]["����P8����ϵͳ����"]=array("power"=>"module_list","link"=>"index.php?lfj=module&job=list");
$menudb["��������"]["�����ⲿ��̳ϵͳ����"]=array("power"=>"blend_set","link"=>"index.php?lfj=blend&job=set");

$menudb["�˵�����"]["��վͷ�������˵�����"]=array("power"=>"menu_list","link"=>"index.php?lfj=guidemenu&job=list");
$menudb["�˵�����"]["����Ա��̨�˵�����"]=array("power"=>"adminmenu_list","link"=>"index.php?lfj=adminguidemenu&job=list");
$menudb["�˵�����"]["��Ա���Ĳ˵�����"]=array("power"=>"membermenu_list","link"=>"index.php?lfj=memberguidemenu&job=list");

$menudb["��վ���ù��ܹ���"]["�������ӹ���"]=array("power"=>"friendlink_mod","link"=>"index.php?lfj=friendlink&job=list");
$menudb["��վ���ù��ܹ���"]["��ƪ���¶���ҳ�����"]=array("power"=>"alonepage_list","link"=>"index.php?lfj=alonepage&job=list");

$menudb["�û�����"]["�û����Ϲ���"]=array("power"=>"member_list","link"=>"index.php?lfj=member&job=list");
$menudb["�û�����"]["��ҵ���Ϲ���"]=array("power"=>"company_list","link"=>"index.php?lfj=company&job=list");
$menudb["�û�����"]["������û�"]=array("power"=>"member_addmember","link"=>"index.php?lfj=member&job=addmember");
$menudb["�û�����"]["�û������ֶι���"]=array("power"=>"regfield","link"=>"index.php?lfj=regfield&job=editsort");


$menudb["Ȩ�޹���"]["ǰ̨��Ա�û���Ȩ�޹���"]=array("power"=>"group_list","link"=>"index.php?lfj=group&job=list");
$menudb["Ȩ�޹���"]["��̨��Ա�û���Ȩ�޹���"]=array("power"=>"group_list_admin","link"=>"index.php?lfj=group&job=list_admin");
$menudb["Ȩ�޹���"]["����û���"]=array("power"=>"group_add","link"=>"index.php?lfj=group&job=add");

$menudb["���ݿ⹤��"]["�������ݿ�"]=array("power"=>"mysql_out","link"=>"index.php?lfj=mysql&job=out");
$menudb["���ݿ⹤��"]["���ݿ⻹ԭ"]=array("power"=>"mysql_into","link"=>"index.php?lfj=mysql&job=into");
$menudb["���ݿ⹤��"]["ɾ����������"]=array("power"=>"mysql_del","link"=>"index.php?lfj=mysql&job=del");
$menudb["���ݿ⹤��"]["���ݿ����"]=array("power"=>"mysql_sql","link"=>"index.php?lfj=mysql&job=sql");

$menudb["���ģ��"]["��ͨ���λ����"]=array("power"=>"ad_listAdPlace","link"=>"index.php?lfj=ad&job=listad");
$menudb["���ģ��"]["��ͨ������۹���"]=array("power"=>"ad_listuserad","link"=>"index.php?lfj=ad&job=listuserad");
$menudb["���ģ��"]["���۹��λ����"]=array("power"=>"sellad","link"=>"index.php?lfj=sellad&job=listad");
$menudb["���ģ��"]["���۹�����۹���"]=array("power"=>"sellad_listuser","link"=>"index.php?lfj=sellad&job=listuser");

if($IS_BIZPhp168||$GLOBALS[IS_BIZPhp168]){
$menudb["�������"]["�㿨��ֵ����"]=array("power"=>"moneycard_make","link"=>"index.php?lfj=moneycard&job=make");
}
$menudb["�������"]["���ֽ��ܹ���"]=array("power"=>"jfadmin_mod","link"=>"index.php?lfj=jfadmin&job=listjf");

$menudb["�������"]["�����������"]=array("power"=>"limitword_list","link"=>"index.php?lfj=limitword&job=list");
$menudb["�������"]["��������"]=array("power"=>"attachment_list","link"=>"index.php?lfj=attachment&job=list");
$menudb["�������"]["ϵͳ��������"]=array("power"=>"upgrade_ol","link"=>"index.php?lfj=upgrade&job=get");

$menudb["��־����"]["��̨��¼��־"]=array("power"=>"logs_login_logs","link"=>"index.php?lfj=logs&job=login_logs");
$menudb["��־����"]["��̨������־"]=array("power"=>"logs_admin_do_logs","link"=>"index.php?lfj=logs&job=admin_logs");

//$menudb["�������"]["PHPWINDӪ��ģ��"]=array("power"=>"code_code","link"=>"index.php?lfj=code&job=code");
$menudb["�������"]["CNZZ����ͳ��"]=array("power"=>"cnzz_set","link"=>"index.php?lfj=cnzz&job=ask");



@include(PHP168_PATH."php168/hack.php");

if($ForceEnter||$GLOBALS[ForceEnter]){
	foreach( $menu_partDB AS $key1=>$value1){
		if($key1=='base'){
			continue;
		}
		foreach( $value1 AS $key2=>$value2){
			$menu_partDB['base'][]=$value2;
		}
	}
}
?>