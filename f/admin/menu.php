<?php
$passport_admin=1;	//������վ��̨����,0������,1����

$menudb["������Ϣ->��������"]["��������"]["link"]="center.php?job=config";
$menudb["������Ϣ->��������"]["��������"]["power"]="1";

$menudb["������Ϣ->��������"]["α��̬����"]["link"]="center.php?job=html";
$menudb["������Ϣ->��������"]["α��̬����"]["power"]="1";

$menudb["������Ϣ->��������"]["ҳ������"]["link"]="center.php?job=settpl";
$menudb["������Ϣ->��������"]["ҳ������"]["power"]="1";

$menudb["������Ϣ->��������"]["��ҳ���಼������"]["link"]="center.php?job=settable";
$menudb["������Ϣ->��������"]["��ҳ���಼������"]["power"]="1";

//$menudb["������Ϣ->��������"]["������ҳ��ǩ"]["link"]="../index.php?jobs=show";
//$menudb["������Ϣ->��������"]["������ҳ��ǩ"]["power"]="1";

//$menudb["������Ϣ->��������"]["���»���"]["link"]="cache.php?job=list";
//$menudb["������Ϣ->��������"]["���»���"]["power"]="1";

//$menudb["������Ϣ->��������"]["ҳ�澲̬��"]["link"]="makehtml.php?job=set";
//$menudb["������Ϣ->��������"]["ҳ�澲̬��"]["power"]="1";

//$menudb["������Ϣ->��������"]["������"]["link"]="ad.php?job=listad";
//$menudb["������Ϣ->��������"]["������"]["power"]="1";

//$menudb["������Ϣ->��������"]["���۹�����"]["link"]="sellad.php?job=listad";
//$menudb["������Ϣ->��������"]["���۹�����"]["power"]="1";

$menudb["������Ϣ->��������"]["��˹�������"]["link"]="autopass.php?job=set";
$menudb["������Ϣ->��������"]["��˹�������"]["power"]="1";

$menudb["������Ϣ->��������"]["������ҳ��ǩ"]["link"]="center.php?job=label";
$menudb["������Ϣ->��������"]["������ҳ��ǩ"]["power"]="1";

$menudb["������Ϣ->���ݹ���"]["���ݹ���"]["link"]="list.php?job=list";
$menudb["������Ϣ->���ݹ���"]["���ݹ���"]["power"]="1";

$menudb["������Ϣ->���ݹ���"]["���۹���"]["link"]="comment.php?job=list";
$menudb["������Ϣ->���ݹ���"]["���۹���"]["power"]="1";

$menudb["������Ϣ->���ݹ���"]["��������"]["link"]="dianping.php?job=list";
$menudb["������Ϣ->���ݹ���"]["��������"]["power"]="1";

$menudb["������Ϣ->���ݹ���"]["��Ŀ����"]["link"]="sort.php?job=listsort&yellow=0";
$menudb["������Ϣ->���ݹ���"]["��Ŀ����"]["power"]="1";

$menudb["������Ϣ->��������"]["ģ�͹���"]["link"]="module.php?job=listsort";
$menudb["������Ϣ->��������"]["ģ�͹���"]["power"]="1";

$menudb["������Ϣ->��������"]["�����ֶι���"]["link"]="fieldsort.php?job=listsort&type=all";
$menudb["������Ϣ->��������"]["�����ֶι���"]["power"]="1";


$menudb["������Ϣ->��������"]["���е�������"]["link"]="spsort.php?job=city";
$menudb["������Ϣ->��������"]["���е�������"]["power"]="1";

$menudb["������Ϣ->��������"]["�ٱ���Ϣ����"]["link"]="report.php?job=list";
$menudb["������Ϣ->��������"]["�ٱ���Ϣ����"]["power"]="1";

//$menudb["������Ϣ->��������"]["�ɼ������б�"]["link"]="gather.php?job=list";
//$menudb["������Ϣ->��������"]["�ɼ������б�"]["power"]="1";

$menudb["������Ϣ->��������"]["�ַ������滻"]["link"]="replace.php?job=list";
$menudb["������Ϣ->��������"]["�ַ������滻"]["power"]="1";


if(!$webdb[Info_sys]&&!$webdb[SystemType]){

$menudb["������Ϣ->���ݿ����"]["��������"]["link"]="mysql.php?lfj=mysql&job=out";
$menudb["������Ϣ->���ݿ����"]["��������"]["power"]="1";

$menudb["������Ϣ->���ݿ����"]["��ԭ����"]["link"]="mysql.php?lfj=mysql&job=into";
$menudb["������Ϣ->���ݿ����"]["��ԭ����"]["power"]="1";

$menudb["������Ϣ->���ݿ����"]["ɾ����������"]["link"]="mysql.php?lfj=mysql&job=del";
$menudb["������Ϣ->���ݿ����"]["ɾ����������"]["power"]="1";
}

$menudb["������Ϣ->��������"]["�������ӹ���"]["link"]="friendlink.php?job=list";
$menudb["������Ϣ->��������"]["�������ӹ���"]["power"]="1";

?>