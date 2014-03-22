<?php
require(dirname(__FILE__)."/global.php");
choose_domain();	//域名判断
include_once(Mpath."php168/guide_fid.php");
include_once(Mpath."php168/keyword.class.php");
//伪静态处理
if(!$id&&$webdb[Info_htmlType]==2){
	$array=array_flip($Fid_db[dir_name]);
	$fid=$array[$Fid];
	preg_match("/([0-9]+)/is",$Id,$array);
	$id=$array[0];
}

$_erp=$Fid_db[tableid][$fid];
/**
*获取栏目与模块配置参数
**/
$fidDB=$db->get_one("SELECT A.* FROM {$_pre}sort A WHERE A.fid='$fid'");

if(!$fidDB){
	showerr("FID有误!");
}

/**
*模型配置文件
**/
$field_db = $module_DB[$fidDB[mid]][field];


/**
*栏目配置参数
*栏目配置文件用户自定义的变量
*栏目当中,用户自定义变量哪些使用了在线编辑器要对他们做附件真实地址作处理
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
*获取信息正文的内容
**/
$rsdb=$db->get_one("SELECT B.*,A.* FROM `{$_pre}content$_erp` A LEFT JOIN `{$_pre}content_$fidDB[mid]` B ON A.id=B.id WHERE A.id='$id'");
//echo "SELECT B.*,A.* FROM `{$_pre}content$_erp` A LEFT JOIN `{$_pre}content_$fidDB[mid]` B ON A.id=B.id WHERE A.id='$id'"

if($rsdb[city_id]!=$city_id){
	showerr("city出错了!");
}

if(!$rsdb){
	showerr("内容不存在");
}
elseif($rsdb[fid]!=$fid){
	showerr("FID有误!!!");
}
elseif($rsdb[yz]!=1&&!$web_admin){
	if($rsdb[yz]==2){
		showerr("回收站的内容,你无法查看");
	}else{
		showerr("还没通过审核");
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
*内容页的风格优先于栏目的风格,栏目的风格优先于系统的风格
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
$rsdb[content]=str_replace("or58","85yp",$rsdb[content]);//网站改版关键字替换
//echo $city_DB['name'][$city_id];
//seo_geteval($fidDB[metakeywords],$city_DB['name'][$city_id]);
/**
*栏目指定了哪些用户组才能看信息内容
**/
//smarty 去掉空
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
			showerr("你所在用户组,无权浏览");
		}
	}
}


/**
*对信息内容字段的处理
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
 *标签关键替换开始 作者:smarty
**/
$rsdb[keywords]=myreplace($rsdb[keywords]);
$KeyArray=addkeyWordURL(explode(" ",$rsdb[keywords]));
$s_key = new KeyReplace($KeyArray,$rsdb[keywords]);
$s_key->KeyOrderBy();
$s_key->Replaces();
$rsdb[keywords]=$s_key->HtmlString; //标签增加关键字
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
*   关键字 替换类  替换(随机位置) 且指定数量的关键词
    先对关键字 md5加密(若关键字之间有重字部分，md5加密，可防止重复替换)，替换标志/&--&/
    /*---*/
/*    替换成/*md5*/
/*    最后用 关键词 替换掉 **形式
*/
class KeyReplace{
    public $KeyArray;  //关键字
    public $HtmlString; //文字内容
    public $ArrayCount; //关键字 的 个数

    /*
        初始化：
        $keyArray 关键字 数组
        $String   检索字域，文字
    */
    function KeyReplace($KeyArray,$String){
       $this->KeyArray=$KeyArray;
       $this->HtmlString=$String;
       $this->ArrayCount=count($KeyArray);
    }

    /*
        关键字 按长度排序
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
       // 中国  呵呵 国  中
    }

    function Replaces(){

        for($i=0;$i<$this->ArrayCount;$i++){

            if((integer)$this->KeyArray[$i]['ReplaceNumber'] != 0 ){
                str_replace($this->KeyArray[$i]["Key"],"/*".md5($this->KeyArray[$i]["Key"])."*/",$this->HtmlString,$num);//$num查询到的数量

                if((integer)$this->KeyArray[$i]['ReplaceNumber']>$num) {//当关键词 需要替换的数量 大于 包含的数量时，替换全部
                    $this->KeyArray[$i]['ReplaceNumber']=$num;
                    $this->HtmlString=str_replace($this->KeyArray[$i]["Key"],"/*".md5($this->KeyArray[$i]["Key"])."*/",$this->HtmlString);
                    continue;
                }
                //当关键词 需要替换的数量 不大于 包含的数量时，使用 KeyStrpos($i);方法替换
                $ListNumber=array();
                $ListNumber=$this->KeyStrpos($i);//$i: 表示第$i个关键词($i从0开始)
                $RegArray=array();

                if(count($ListNumber)<1) continue;//不存在 关键词

                $n=0;
                while($n<(integer)$this->KeyArray[$i]["ReplaceNumber"]){
                    $g=0;
                    $x=rand(0,count($ListNumber)-1);//随机数
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
                {//关键词所在位置 递增排序
                    for($jx=$c+1;$jx<count($RegArray);$jx++){
                        if($RegArray[$c]>$RegArray[$jx]){
                            $TempArray=$RegArray[$c];
                            $RegArray[$c]=$RegArray[$jx];
                            $RegArray[$jx]=$TempArray;
                        }
                    }
                }

                for($c=0;$c<count($RegArray);$c++){
                    $this->StrposKey($this->KeyArray[$i]["Key"],$RegArray[$c],$c);// 逐位(索引位) 替换截取到的关键字
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


    function StrposKey($Key,$StrNumber,$n){//在字符串里 截取关键字 并替换，从$StrNumber这个位置开始(包含$StrNumber这个位置)替换到$n(包含$n这个位置)这个位置
       $this->HtmlString=substr_replace($this->HtmlString, "/*".md5($Key)."*/", $StrNumber, 36);
    }


    /* 递归 查找 关键词 所在的位置 存于数组中 */
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
	$str=str_replace("，"," ",$str);
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

//地区的最新信息
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
	$show.="<dd>·<a href='$rs[url]' target='_blank' title='$rs[title]'>$rs[title]</a></dd>\n";
}
$show.="</div>";

/**
 *标签关键替换结束 作者:smarty
**/

if($webdb[Info_ForbidGuesViewContact]&&$groupdb['gid']==2){
	$rsdb[telephone]=$rsdb[mobphone]=$rsdb[oicq]=$rsdb[msn]=$rsdb[email]="<font color='#cccccc'>**游客无权查看**</font>";
}elseif($webdb[Info_ForbidMemberViewContact]&&$groupdb['gid']==8){
	$rsdb[telephone]=$rsdb[mobphone]=$rsdb[oicq]=$rsdb[msn]=$rsdb[email]="<font color='#cccccc'>**普通会员无权查看**</font>";
}elseif($webdb[Info_ImgShopContact]){
	$rsdb[telephone] && $rsdb[telephone]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[telephone])."'>";
	$mob_area=get_mob_area($rsdb[mobphone]);
	$rsdb[mobphone] && $rsdb[mobphone]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[mobphone])."'> $mob_area <A HREF='$city_url/job.php?job=mob&vid=".base64_encode($rsdb[mobphone])."' target='_blank'>查询更多</A>";
	$rsdb[oicq] && $rsdb[oicq]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[oicq])."'>";
	$rsdb[msn] && $rsdb[msn]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[msn])."'>";
	$rsdb[email] && $rsdb[email]="<img src='$city_url/job.php?job=img&vid=".base64_encode($rsdb[email])."'>";
}else{
	$mob_area=get_mob_area($rsdb[mobphone]);
	$rsdb[mobphone].=" $mob_area <A HREF='$city_url/job.php?job=mob&vid=".base64_encode($rsdb[mobphone])."' target='_blank'>查询更多</A>";
}


$rsdb[posttime]=date("Y-m-d H:i:s",$rsdb[posttime]);

$rsdb[picurl] && $rsdb[picurl]=tempdir($rsdb[picurl]);

unset($head_tpl,$foot_tpl);
//城市模板
if($city_DB[tpl][$city_id]){
	list($head_tpl,$foot_tpl)=explode("|",$city_DB[tpl][$city_id]);
	$head_tpl && $head_tpl=Mpath.$head_tpl;
	$foot_tpl && $foot_tpl=Mpath.$foot_tpl;
}

/**
*栏目模板优先于城市模板
**/
if($fidDB[template]){
	$FidTpl=unserialize($fidDB[template]);
	$FidTpl['head'] && $head_tpl=Mpath.$FidTpl['head'];
	$FidTpl['foot'] && $foot_tpl=Mpath.$FidTpl['foot'];
	$FidTpl['bencandy'] && $main_tpl=Mpath.$FidTpl['bencandy'];
}

/**
*为获取标签参数
**/
$chdb[main_tpl]=getTpl("bencandy_$fidDB[mid]",$main_tpl);

/**
*标签
**/
$ch_fid	= intval($fidDB[config][label_bencandy]);	//是否定义了栏目专用标签
$ch_pagetype = 3;									//2,为list页,3,为bencandy页
$ch_module = $webdb[module_id]?$webdb[module_id]:99;//系统特定ID参数,每个系统不能雷同
$ch = 0;											//不属于任何专题
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
	$userdb[level]="游客";
}

$rsdb[showarea]=get__area($rsdb[city_id],$rsdb[zone_id],$rsdb[street_id]);
$rsdb[ipfrom]=ipfrom($rsdb[ip]);
if($rsdb[endtime]){
	if($rsdb[endtime]<$timestamp){
		$rsdb[showday]="已过期";
	}else{
		$rsdb[showday]=ceil(($rsdb[endtime]-$timestamp)/86400);
		$rsdb[showday]="还剩{$rsdb[showday]}天 ";
	}
}else{
	$rsdb[showday]="不限";
}

$rsdb[username]=(!$rsdb[username])?"*游客*":"$rsdb[username]";

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
	$fendb[fen1][name] || $fendb[fen1][name]="总评";
	$fendb[fen2][name] || $fendb[fen2][name]="环境";
	$fendb[fen3][name] || $fendb[fen3][name]="服务";
	$fendb[fen4][name] || $fendb[fen4][name]="价位";
	$fendb[fen5][name] || $fendb[fen5][name]="喜欢程度";

	$fendb[fen1][set] || $fendb[fen1][set]="1=差\r\n2=一般\r\n3=好\r\n4=很好\r\n5=非常好";
	$fendb[fen2][set] || $fendb[fen2][set]="1=差\r\n2=一般\r\n3=好\r\n4=很好\r\n5=非常好";
	$fendb[fen3][set] || $fendb[fen3][set]="1=差\r\n2=一般\r\n3=好\r\n4=很好\r\n5=非常好";
	$fendb[fen4][set] || $fendb[fen4][set]="1=便宜\r\n2=适中\r\n3=贵\r\n4=很贵";
	$fendb[fen5][set] || $fendb[fen5][set]="1=不喜欢\r\n2=无所谓\r\n3=喜欢\r\n4=很喜欢";

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
*伪静态作处理
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
	//$shows="{$title}:<select name='$name' id='$name'><option value=''>请选择</option>$shows</select>";
	return $shows;
}
?>