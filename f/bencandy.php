<?php
require(dirname(__FILE__)."/global.php");
choose_domain();	//�����ж�
include_once(Mpath."php168/guide_fid.php");
include_once(Mpath."php168/keyword.class.php");
//α��̬����
if(!$id&&$webdb[Info_htmlType]==2){
	$array=array_flip($Fid_db[dir_name]);
	$fid=$array[$Fid];
	preg_match("/([0-9]+)/is",$Id,$array);
	$id=$array[0];
}

$_erp=$Fid_db[tableid][$fid];
/**
*��ȡ��Ŀ��ģ�����ò���
**/
$fidDB=$db->get_one("SELECT A.* FROM {$_pre}sort A WHERE A.fid='$fid'");

if(!$fidDB){
	showerr("FID����!");
}

/**
*ģ�������ļ�
**/
$field_db = $module_DB[$fidDB[mid]][field];


/**
*��Ŀ���ò���
*��Ŀ�����ļ��û��Զ���ı���
*��Ŀ����,�û��Զ��������Щʹ�������߱༭��Ҫ��������������ʵ��ַ������
**/
$fidDB[config]=unserialize($fidDB[config]);
$CV=$fidDB[config][field_value];
$_array=array_flip($fidDB[config][is_html]);
foreach( $fidDB[config][field_db] AS $key=>$rs){
	if(in_array($key,$_array)){
		$CV[$key]=En_TruePath($CV[$key],0);
	}elseif($rs[form_type]=='upfile'){
		$CV[$key]=tempdir($CV[$key]);
	}
}


$db->query("UPDATE {$_pre}content$_erp SET hits=hits+1,lastview='$timestamp' WHERE id='$id'");


/**
*��ȡ��Ϣ���ĵ�����
**/
$rsdb=$db->get_one("SELECT B.*,A.* FROM `{$_pre}content$_erp` A LEFT JOIN `{$_pre}content_$fidDB[mid]` B ON A.id=B.id WHERE A.id='$id'");
//echo "SELECT B.*,A.* FROM `{$_pre}content$_erp` A LEFT JOIN `{$_pre}content_$fidDB[mid]` B ON A.id=B.id WHERE A.id='$id'"

if($rsdb[city_id]!=$city_id){
	showerr("city������!");
}

if(!$rsdb){
	showerr("���ݲ�����");
}
elseif($rsdb[fid]!=$fid){
	showerr("FID����!!!");
}
elseif($rsdb[yz]!=1&&!$web_admin){
	if($rsdb[yz]==2){
		showerr("����վ������,���޷��鿴");
	}else{
		showerr("��ûͨ�����");
	}
}


if($rsdb[idcard_img]&&$rsdb[idcard_yz]){
	$rsdb[idcard_img]=tempdir($rsdb[idcard_img]);
	$rsdb[idcard_show]=" <a href='javascript:' ><img src='$rsdb[idcard_img]' border='0' width='30' height='30'></a> ";
}
if($rsdb[permit_img]&&$rsdb[permit_yz]){
	$rsdb[permit_img]=tempdir($rsdb[permit_img]);
	$rsdb[permit_show]=" <a href='javascript:' ><img src='$rsdb[permit_img]' border='0' width='30' height='30'></a> ";
}
if($rsdb[othercard_img]&&$rsdb[othercard_yz]){
	$rsdb[othercard_img]=tempdir($rsdb[othercard_img]);
	$rsdb[othercard_show]=" <a href='javascript:' ><img src='$rsdb[othercard_img]' border='0' width='30' height='30'></a> ";
}

/**
*����ҳ�ķ����������Ŀ�ķ��,��Ŀ�ķ��������ϵͳ�ķ��
**/
if($rsdb[style]){
	$STYLE=$rsdb[style];
}elseif($fidDB[style]){
	$STYLE=$fidDB[style];
}


//SEO
$titleDB[title]	= filtrate(strip_tags("$rsdb[title] - {$city_DB[name][$city_id]}$fidDB[name] - {$city_DB[name][$city_id]}$webdb[Info_webname]"));
$titleDB[keywords]=filtrate(strip_tags($rsdb[keywords]))!=""?filtrate(strip_tags($rsdb[keywords])): "{$city_DB[name][$city_id]}$fidDB[name],{$city_DB[name][$city_id]}$webdb[Info_webname]"; 


$titleDB[description]	= mydelete(seo_geteval(get_word(strip_tags($rsdb[content]),200).",".filtrate(strip_tags("$fidDB[metadescription] $webdb[Info_metadescription]")),$city_DB['name'][$city_id]));
$rsdb[content]=str_replace("or58","85yp",$rsdb[content]);//��վ�İ�ؼ����滻
//echo $city_DB['name'][$city_id];
//seo_geteval($fidDB[metakeywords],$city_DB['name'][$city_id]);
/**
*��Ŀָ������Щ�û�����ܿ���Ϣ����
**/
//smarty ȥ����
function mydelete($str) {
    $str = trim($str);
    $str = ereg_replace("\t","",$str);
    $str = ereg_replace("\r\n","",$str);
    $str = ereg_replace("\r","",$str);
    $str = ereg_replace("\n","",$str);
    $str = ereg_replace("    ","",$str);
    return trim($str);
}


if($fidDB[allowviewcontent]){
	if( !$web_admin&&!in_array($groupdb[gid],explode(",",$fidDB[allowviewcontent])) ){
		if(!$lfjid||!in_array($lfjid,explode(",",$fidDB[admin]))){	
			showerr("�������û���,��Ȩ���");
		}
	}
}


/**
*����Ϣ�����ֶεĴ���
**/
$Module_db->hidefield=true;
$Module_db->classidShowAll=true;
$Module_db->showfield($field_db,$rsdb,'show');

$rsdb[ipaddress]=base64_encode($rsdb[ip]);

$rsdb[_mobphone]=$rsdb[mobphone];
$rsdb[_telephone]=$rsdb[telephone];
$rsdb[_msn]=$rsdb[msn];
$rsdb[_oicq]=$rsdb[oicq];
$rsdb[_email]=$rsdb[email];

/**
 *��ǩ�ؼ��滻��ʼ ����:smarty
**/
$rsdb[keywords]=myreplace($rsdb[keywords]);
$KeyArray=addkeyWordURL(explode(" ",$rsdb[keywords]));
$s_key = new KeyReplace($KeyArray,$rsdb[keywords]);
$s_key->KeyOrderBy();
$s_key->Replaces();
$rsdb[keywords]=$s_key->HtmlString; //��ǩ���ӹؼ���
function addkeyWordURL($ary){
   $j=0;
   $addurl="http://search.85yp.com/s/?wd=";
	for($i=0;$i<count($ary);$i++){
		if(!empty($ary[$i])){			
			$array[$j]["Key"]=$ary[$i];
			$array[$j]["Href"]="<a href=\"".$addurl.urlencode($ary[$i])."\" target=\"_blank\">".$ary[$i]."</a>";
			$j++;
		 }							
	}
	return $array;
}


/**
*   �ؼ��� �滻��  �滻(���λ��) ��ָ�������Ĺؼ���
    �ȶԹؼ��� md5����(���ؼ���֮�������ֲ��֣�md5���ܣ��ɷ�ֹ�ظ��滻)���滻��־/&--&/
    /*---*/
/*    �滻��/*md5*/
/*    ����� �ؼ��� �滻�� **��ʽ
*/
class KeyReplace{
    public $KeyArray;  //�ؼ���
    public $HtmlString; //��������
    public $ArrayCount; //�ؼ��� �� ����

    /*
        ��ʼ����
        $keyArray �ؼ��� ����
        $String   ������������
    */
    function KeyReplace($KeyArray,$String){
       $this->KeyArray=$KeyArray;
       $this->HtmlString=$String;
       $this->ArrayCount=count($KeyArray);
    }

    /*
        �ؼ��� ����������
    */
    function KeyOrderBy(){
        for($i=0;$i<$this->ArrayCount-1;$i++){
            for($j=$i+1;$j<$this->ArrayCount;$j++){
                $TempArray=array();
                if(strlen($this->KeyArray[$i]["Key"])<strlen($this->KeyArray[$j]["Key"])){
                    $TempArray=$this->KeyArray[$i];
                    $this->KeyArray[$i]=$this->KeyArray[$j];
                    $this->KeyArray[$j]=$TempArray;
                }

            }
       }
       // �й�  �Ǻ� ��  ��
    }

    function Replaces(){

        for($i=0;$i<$this->ArrayCount;$i++){

            if((integer)$this->KeyArray[$i]['ReplaceNumber'] != 0 ){
                str_replace($this->KeyArray[$i]["Key"],"/*".md5($this->KeyArray[$i]["Key"])."*/",$this->HtmlString,$num);//$num��ѯ��������

                if((integer)$this->KeyArray[$i]['ReplaceNumber']>$num) {//���ؼ��� ��Ҫ�滻������ ���� ����������ʱ���滻ȫ��
                    $this->KeyArray[$i]['ReplaceNumber']=$num;
                    $this->HtmlString=str_replace($this->KeyArray[$i]["Key"],"/*".md5($this->KeyArray[$i]["Key"])."*/",$this->HtmlString);
                    continue;
                }
                //���ؼ��� ��Ҫ�滻������ ������ ����������ʱ��ʹ�� KeyStrpos($i);�����滻
                $ListNumber=array();
                $ListNumber=$this->KeyStrpos($i);//$i: ��ʾ��$i���ؼ���($i��0��ʼ)
                $RegArray=array();

                if(count($ListNumber)<1) continue;//������ �ؼ���

                $n=0;
                while($n<(integer)$this->KeyArray[$i]["ReplaceNumber"]){
                    $g=0;
                    $x=rand(0,count($ListNumber)-1);//�����
                    for($xcn=0;$xcn<=$n;$xcn++){
                        if($RegArray[$xcn]==$ListNumber[$x]){
                            $g=1;
                        }
                    }
                    if($g==0){
                        $RegArray[$n]=$ListNumber[$x];
                        $n++;
                    }
                }

                for($c=0;$c<count($RegArray)-1;$c++)
                {//�ؼ�������λ�� ��������
                    for($jx=$c+1;$jx<count($RegArray);$jx++){
                        if($RegArray[$c]>$RegArray[$jx]){
                            $TempArray=$RegArray[$c];
                            $RegArray[$c]=$RegArray[$jx];
                            $RegArray[$jx]=$TempArray;
                        }
                    }
                }

                for($c=0;$c<count($RegArray);$c++){
                    $this->StrposKey($this->KeyArray[$i]["Key"],$RegArray[$c],$c);// ��λ(����λ) �滻��ȡ���Ĺؼ���
                }

               $this->HtmlString=str_replace("/&".md5($this->KeyArray[$i]["Key"])."&/",$this->KeyArray[$i]["Key"],$this->HtmlString);
            }else{
               $this->HtmlString=str_replace($this->KeyArray[$i]["Key"],"/*".md5($this->KeyArray[$i]["Key"])."*/",$this->HtmlString);
            }
       }

       for($i=0;$i<$this->ArrayCount;$i++){
           $this->HtmlString=str_replace("/*".md5($this->KeyArray[$i]["Key"])."*/",$this->KeyArray[$i]["Href"],$this->HtmlString);
       }

    }


    function StrposKey($Key,$StrNumber,$n){//���ַ����� ��ȡ�ؼ��� ���滻����$StrNumber���λ�ÿ�ʼ(����$StrNumber���λ��)�滻��$n(����$n���λ��)���λ��
       $this->HtmlString=substr_replace($this->HtmlString, "/*".md5($Key)."*/", $StrNumber, 36);
    }


    /* �ݹ� ���� �ؼ��� ���ڵ�λ�� ���������� */
    function KeyStrpos($KeyId){
        $StrListArray=array();
        $StrNumberss=strpos($this->HtmlString, $this->KeyArray[$KeyId]["Key"]);
        $xf=0;
        while(!($StrNumberss===false)){
            $StrListArray[$xf]=$StrNumberss;
            $this->HtmlString=substr_replace($this->HtmlString,"/&".md5($this->KeyArray[$KeyId]["Key"])."&/",$StrNumberss, strlen($this->KeyArray[$KeyId]["Key"]));
            $StrNumberss=strpos($this->HtmlString, $this->KeyArray[$KeyId]["Key"]);
            $xf++;
        }
        return $StrListArray;
    }
}

function myreplace($str){
	$str=str_replace(","," ",$str);
	$str=str_replace("��"," ",$str);
	$str=str_replace("\"","",$str);
	$str=str_replace("\'","",$str);
	$str=str_replace("\"","",$str);
	$str=str_replace("'","",$str);
	$str=str_replace("|"," ",$str);	                
	return $str;	
}


function get_encoding($data,$to)
{
   $encode_arr = array('UTF-8','ASCII','GBK','GB2312','BIG5','JIS','eucjp-win','sjis-win','EUC-JP');
   $encoded = mb_detect_encoding($data, $encode_arr);
   $data = mb_convert_encoding($data,$to,$encoded);
   return $data;
}

//������������Ϣ
$query = $db->query("SELECT * FROM {$_pre}db WHERE city_id='$city_id' and  fid='$fid' ORDER BY id DESC LIMIT 10");
$show="<div class=\"smarty_hots\">";
while($rs = $db->fetch_array($query)){
	$_erp=$Fid_db[tableid][$rs[fid]];
	$rs=$db->get_one("SELECT * FROM {$_pre}content$_erp WHERE id=$rs[id] $SQL");
	if(!$rs[title]){
		continue;
	}
	$rs[url]=get_info_url($rs[id],$rs[fid],$rs[city_id]);
	$rs[title]=get_word($rs[title]);
	$show.="<dd>��<a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}
$show.="</div>";

/**
 *��ǩ�ؼ��滻���� ����:smarty
**/

if($webdb[Info_ForbidGuesViewContact]&&$groupdb['gid']==2){
	$rsdb[telephone]=$rsdb[mobphone]=$rsdb[oicq]=$rsdb[msn]=$rsdb[email]="<font color='#cccccc'>**�ο���Ȩ�鿴**</font>";
}elseif($webdb[Info_ForbidMemberViewContact]&&$groupdb['gid']==8){
	$rsdb[telephone]=$rsdb[mobphone]=$rsdb[oicq]=$rsdb[msn]=$rsdb[email]="<font color='#cccccc'>**��ͨ��Ա��Ȩ�鿴**</font>";
}elseif($webdb[Info_ImgShopContact]){
	$rsdb[telephone] && $rsdb[telephone]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[telephone])."'>";
	$mob_area=get_mob_area($rsdb[mobphone]);
	$rsdb[mobphone] && $rsdb[mobphone]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[mobphone])."'> $mob_area <A HREF='$city_url/job.php?job=mob&vid=".base64_encode($rsdb[mobphone])."' target='_blank'>��ѯ����</A>";
	$rsdb[oicq] && $rsdb[oicq]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[oicq])."'>";
	$rsdb[msn] && $rsdb[msn]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[msn])."'>";
	$rsdb[email] && $rsdb[email]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[email])."'>";
}else{
	$mob_area=get_mob_area($rsdb[mobphone]);
	$rsdb[mobphone].=" $mob_area <A HREF='$city_url/job.php?job=mob&vid=".base64_encode($rsdb[mobphone])."' target='_blank'>��ѯ����</A>";
}


$rsdb[posttime]=date("Y-m-d H:i:s",$rsdb[posttime]);

$rsdb[picurl] && $rsdb[picurl]=tempdir($rsdb[picurl]);

unset($head_tpl,$foot_tpl);
//����ģ��
if($city_DB[tpl][$city_id]){
	list($head_tpl,$foot_tpl)=explode("|",$city_DB[tpl][$city_id]);
	$head_tpl && $head_tpl=Mpath.$head_tpl;
	$foot_tpl && $foot_tpl=Mpath.$foot_tpl;
}

/**
*��Ŀģ�������ڳ���ģ��
**/
if($fidDB[template]){
	$FidTpl=unserialize($fidDB[template]);
	$FidTpl['head'] && $head_tpl=Mpath.$FidTpl['head'];
	$FidTpl['foot'] && $foot_tpl=Mpath.$FidTpl['foot'];
	$FidTpl['bencandy'] && $main_tpl=Mpath.$FidTpl['bencandy'];
}

/**
*Ϊ��ȡ��ǩ����
**/
$chdb[main_tpl]=getTpl("bencandy_$fidDB[mid]",$main_tpl);

/**
*��ǩ
**/
$ch_fid	= intval($fidDB[config][label_bencandy]);	//�Ƿ�������Ŀר�ñ�ǩ
$ch_pagetype = 3;									//2,Ϊlistҳ,3,Ϊbencandyҳ
$ch_module = $webdb[module_id]?$webdb[module_id]:99;//ϵͳ�ض�ID����,ÿ��ϵͳ������ͬ
$ch = 0;											//�������κ�ר��
require(PHP168_PATH."inc/label_module.php");


if($rsdb[uid]){
	$userdb=$db->get_one("SELECT * FROM {$pre}memberdata WHERE uid='$rsdb[uid]'");
	$userdb[username]=$rsdb[username];
	$userdb[regdate]=date("y-m-d H:i",$userdb[regdate]);
	$userdb[lastvist]=date("y-m-d H:i",$userdb[lastvist]);
	$userdb[icon]=tempdir($userdb[icon]);
	include_once(PHP168_PATH."php168/level.php");
	$userdb[level]=$ltitle[$userdb[groupid]];
}else{
	$userdb[username]=preg_replace("/([\d]+)\.([\d]+)\.([\d]+)\.([\d]+)/is","\\1.\\2.*.*",$rsdb[ip]);
	$userdb[level]="�ο�";
}

$rsdb[showarea]=get__area($rsdb[city_id],$rsdb[zone_id],$rsdb[street_id]);
$rsdb[ipfrom]=ipfrom($rsdb[ip]);
if($rsdb[endtime]){
	if($rsdb[endtime]<$timestamp){
		$rsdb[showday]="�ѹ���";
	}else{
		$rsdb[showday]=ceil(($rsdb[endtime]-$timestamp)/86400);
		$rsdb[showday]="��ʣ{$rsdb[showday]}�� ";
	}
}else{
	$rsdb[showday]="����";
}

$rsdb[username]=(!$rsdb[username])?"*�ο�*":"$rsdb[username]";

unset($picdb);
if($rsdb[picnum]>1){
	$query = $db->query("SELECT * FROM {$_pre}pic WHERE id='$id'");
	while($rs = $db->fetch_array($query)){
		$rs[imgurl]=tempdir($imgurl=$rs[imgurl]);
		$rs[picurl]=eregi("^http:",$imgurl)?$rs[imgurl]:"$rs[imgurl].gif";
		$picdb[]=$rs;
	}
}

if($module_DB[$fidDB[mid]][config2]){
	$fendb=$module_DB[$fidDB[mid]][config2];
	$fendb[fen1][name] || $fendb[fen1][name]="����";
	$fendb[fen2][name] || $fendb[fen2][name]="����";
	$fendb[fen3][name] || $fendb[fen3][name]="����";
	$fendb[fen4][name] || $fendb[fen4][name]="��λ";
	$fendb[fen5][name] || $fendb[fen5][name]="ϲ���̶�";

	$fendb[fen1][set] || $fendb[fen1][set]="1=��\r\n2=һ��\r\n3=��\r\n4=�ܺ�\r\n5=�ǳ���";
	$fendb[fen2][set] || $fendb[fen2][set]="1=��\r\n2=һ��\r\n3=��\r\n4=�ܺ�\r\n5=�ǳ���";
	$fendb[fen3][set] || $fendb[fen3][set]="1=��\r\n2=һ��\r\n3=��\r\n4=�ܺ�\r\n5=�ǳ���";
	$fendb[fen4][set] || $fendb[fen4][set]="1=����\r\n2=����\r\n3=��\r\n4=�ܹ�";
	$fendb[fen5][set] || $fendb[fen5][set]="1=��ϲ��\r\n2=����ν\r\n3=ϲ��\r\n4=��ϲ��";

	$fen1=setfen("fen1",$fendb[fen1][name],$fendb[fen1][set]);
	$fen2=setfen("fen2",$fendb[fen2][name],$fendb[fen2][set]);
	$fen3=setfen("fen3",$fendb[fen3][name],$fendb[fen3][set]);
	$fen4=setfen("fen4",$fendb[fen4][name],$fendb[fen4][set]);
	$fen5=setfen("fen5",$fendb[fen5][name],$fendb[fen5][set]);
}
//echo $rsdb[linkman]."asdfasdf";
//$rsdb[linkman]=$rsdb[linkman]?$rsdb[linkman]:$rsdb[username];

require(Mpath."inc/head.php");
require(getTpl("bencandy_$fidDB[mid]",$main_tpl));
require(Mpath."inc/foot.php");


/**
*α��̬������
**/
if($webdb[Info_NewsMakeHtml]==2)
{
	$content=ob_get_contents();
	ob_end_clean();

	echo "$content";
}

function get__area($city_id,$zone_id,$street_id){
	global $city_DB,$fid;
	if(!$city_id){
		return ;
	}
	if($zone_id||$street_id){
		include(Mpath."php168/zone/{$city_id}.php");
	}
	$rs[]="<A HREF='".get_info_url('',$fid,$city_id)."'>{$city_DB[name][$city_id]}</A>";
	$zone_id && $rs[]="<A HREF='".get_info_url('',$fid,$city_id,$zone_id)."'>{$zone_DB[name][$zone_id]}</A>";
	$street_id && $rs[]="<A HREF='".get_info_url('',$fid,$city_id,$zone_id,$street_id)."'>{$street_DB[name][$street_id]}</A>";
	$show=implode(" > ",$rs);
	return $show;
}
function setfen($name,$title,$set){
	$detail=explode("\r\n",$set);
	foreach( $detail AS $key=>$value){
		$d=explode("=",$value);
		$shows.="<option value='$d[0]' style='color:blue;'>$d[1]</option>";
	}
	$shows=" <select name='$name' id='$name'><option value=''>-{$title}-</option>$shows</select>";
	//$shows="{$title}:<select name='$name' id='$name'><option value=''>��ѡ��</option>$shows</select>";
	return $shows;
}
?>