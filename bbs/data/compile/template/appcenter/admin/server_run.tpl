<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::app()->charset, ENT_QUOTES, 'UTF-8');?>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','name'), ENT_QUOTES, 'UTF-8');?></title>
<link href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','css'), ENT_QUOTES, 'UTF-8');?>/admin_style.css?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<script>
//全局变量，是Global Variables不是Gay Video喔
var GV = {
	JS_ROOT : "<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/",																									//js目录
	JS_VERSION : "<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>",																										//js版本号
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token ajax全局
	REGION_CONFIG : {},
	SCHOOL_CONFIG : {},
	URL : {
		LOGIN : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','loginUrl'), ENT_QUOTES, 'UTF-8');?>',																													//后台登录地址
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',																										//图片目录
		REGION : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=area'; ?>',					//地区
		SCHOOL : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=school'; ?>'				//学校
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/jquery.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

<script type="text/javascript">
function display(id){
  var traget=document.getElementById(id);
   if(traget.style.display=="none"){
			traget.style.display="";
   }else{
		   traget.style.display="none";
	}
}

function disabledSubmit(){
	obj = document.getElementById("ac_submit");
	obj.disabled = 'disabled';
	obj.innerHTML = "申请云服务中,请稍后！";
	return true;
 }
</script>
</head>
<body>
<div class="wrap">
<?php if(!$ac_type && $ac_url):?>
<iframe id="acloud" name="acloud" frameborder="0" width="100%" height="1200" scrolling="no" src="<?php echo htmlspecialchars($ac_url, ENT_QUOTES, 'UTF-8');?>"></iframe>
<?php elseif($ac_type == 'apply'):?>
<form action="<?php echo htmlspecialchars($ac_apply_url, ENT_QUOTES, 'UTF-8');?>" method="post" enctype="multipart/form-data" onSubmit="return disabledSubmit();">
<input name="requestkey" value="<?php echo htmlspecialchars($request_key, ENT_QUOTES, 'UTF-8');?>" type="hidden" />
<input name="sitename" value="<?php echo htmlspecialchars($site_name, ENT_QUOTES, 'UTF-8');?>" type="hidden" />
<input name="sitecharset" value="<?php echo htmlspecialchars($site_charset, ENT_QUOTES, 'UTF-8');?>" type="hidden" />
<input name="siteversion" value="<?php echo htmlspecialchars($site_version, ENT_QUOTES, 'UTF-8');?>" type="hidden" />
<div class="h_a">申请云服务</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col width="400" />
		<col />
		<tr>
			<th>论坛网址</th>
			<td><input type="text" name="siteurl" class="input length_4" value="<?php echo htmlspecialchars($site_url, ENT_QUOTES, 'UTF-8');?>"></td>
			<td><div class="fun_tips"></div></td>
		</tr>
	</table>
</div>
<div class="tac p10"><button type="submit" id="ac_submit" class="btn btn_submit btn_big">同意以下协议 并 提交申请</button></div>
<div class="agreements">
			<div><a href="javascript:;" class="s4" title="点击显示本协议"  onclick="display('J_agreements_content2')">《phpwind云平台服务使用协议》</a></div>
			<pre id="J_agreements_content2" style="display:none;">尊敬的用户（以下或称"用户"）：您好<br>
	欢迎您使用phpwind云服务平台，以下条款和条件将构成您与阿里云计算有限公司（以下称"阿里云"）就phpwind云服务平台使用所达成的协议（以下称"协议"）。一旦您下载安装使用了阿里云提供的相关服务，即表示您已经接受了以下所述的条款和条件。             <br>
	任何组织或个人在使用该服务前请务必保证您已经仔细阅读了下列条款。如您不同意本服务条款及/或阿里云随时的修改，您应不使用或主动取消阿里云提供的相关产品，否则，您的任何对阿里云产品中的相关服务的注册、登录、下载、查看等任何行为将被视为您对本服务条款全部的完全接受。             <br>
	阿里云有权随时修改相关条款和条件，并更新到您的安装目录或者阿里云网站上，而无需征得您的事先同意。修改后的条款应于公示即时生效。在阿里云修改协议条款后，您继续使用相关产品应被视作您已接受了修改后的条款。 
除非得到阿里云的书面授权，任何人将不得修改本协议。             <br>
一、定义            <br>    
1、phpwind产品：由阿里云计算有限公司提供的产品，，包括但不限于phpwind建站工具、云搜索，通过该等产品，用户可以轻松搭建自己的网站。           <br>
2、phpwind产品用户：使用phpwind产品搭建网站的自然人或者法人，通常称之为站长、网站运营者或所有权人。           <br>
3、phpwind用户网站：phpwind用户借助阿里云提供的产品所搭建的网站。           <br>
4、用户网站最终用户：访问phpwind产品用户网站的网络用户（以下称"最终用户"），这类用户由用户及阿里云计算有限公司共同为其提供服务。           <br>
5、phpwind云服务：phpwind云服务是由阿里云计算有限公司基于其平台为用户提供的开放云服。           <br>
6、phpwind云服务分配的关键信息：包括但不限于phpwind云服务与杭州德天信息技术有限公司用户网站通讯密钥。           <br>
二、权利与义务           <br>
1、阿里云保留在任何时候自行决定对其产品的相关功能的变更、升级、修改、转移的权利。阿里云进一步保留在其phpwind云服务平台中开发新的功能或其它语种服务的权利。上述所有新的功能、服务的提供，除非阿里云有说明，否则仍适用本协议。          <br>
2、用户向阿里云提交的任何信息均真实、准确且有效的；不含有任何违反国家法律、法规及中华人民共和国承认或加入的国际条约的内容，且您通过阿里云所提供的服务而从事的一切活动都是合法、真实的，不侵害任何第三方的合法权益；如用户提供的任何信息资料发生变化，应在三个工作日内通过phpwind云服务的后台进行修改。          <br>
3、按照政府有关部门的规定取得网站运行和经营的许可，及其他相应的合法资质。          <br>
4、遵守及尊重任何第三方的合法权益，包括但不限于知识产权、财产所有权、隐私权等有形和无形的权益。          <br>
5、用户不得有意或无意的传播任何暴力的、色情的、种族性的、政治相关的、骚扰性的、辱骂性的、恐吓性的、中伤他人的、侵犯版权的或任何其他违反中华人民共和国法律的信息资料；应根据国家法律法规，对网站相关内容及最终用户生产、创造、传播的各类信息承担审核、过滤的义务。          <br>
6、用户不得以任何形式利用phpwind云服务进行任何侵害阿里云计算有限公司或最终用户权益的行为，包括但不限于传播垃圾信息、广告信息、弹出窗口、恶意代码、黑客行为、病毒及木马等。          <br>
7、用户不能以任何形式绕过phpwind云服务的权限验证系统，或使用黑客手段，反向工程或工具盗取原本无法获取的Phpwind云服务最终用户的数据或者phpwind云服务的数据。          <br>
8、用户通过Phpwind云服务合法得到的数据，不得以任何形式提供给任何第三方；用户应妥善保管Phpwind云服务分配的关键信息，不得将其披露、转让或者共享给其他任何第三人；阿里云亦不对此类关键信息的丢失承担任何责任。          <br>
9、用户不得对Phpwind云服务分发子授权，或者以网络服务或其他非开源免费的形式，封装、转让、租借或二次分发任何包含Phpwind云服务的软件、产品或服务给任何第三方，否则阿里云有权立即停止用户使用Phpwind云服务，并追究相关责任人的法律责任，要求相应的损失赔偿。          <br>
10、用户同意如使用阿里云提供的服务为任何第三方提供服务时，对于用户和第三方之间的纠纷，阿里云将不承担任何责任。          <br>
11、用户承诺通过阿里云所提供的服务而进行的活动所引发的一切法律后果，由用户承担全部责任。如因用户使用阿里云服务的行为，导致阿里云或任何第三方为此承担了相关的责任，则用户需全额赔偿阿里云或任何第三方的相关经济损失。          <br>
12、除非取得阿里云事先书面同意，用户不得将本协议项下的权利与义务转让给任何第三方。          <br>
三、阿里云的权利与义务           <br>      
1、阿里云有权在其服务器上复制保存用户的信息，并用之为了用户的利益与用户联络。          <br>
2、阿里云有权通过其所提供的服务采集与网站服务质量相关的所有数据。          <br>
3、阿里云没有义务对用户使用其服务的行为进行监督。          <br>
4、阿里云保留权利在任何时候根据适用法律、法规、法律程序或政府要求的需要而披露任何信息，或由阿里云自主决定全部或部分地编辑、拒绝传送或删除任何信息或资料。          <br>
5、用户了解并确认阿里云提供的服务中可能包含由第三方提供的服务，阿里云只是为了您的便利而提供该功能模块。用户如需使用此等服务，应另行与第三方服务提供方达成服务协议，支付相应费用并承担可能的风险。阿里云对第三方提供的服务不提供任何形式的保证。          <br>
四、免责声明           <br>
1、任何个人或组织，使用phpwind云服务均属自愿行为，阿里云承诺尽其最大努力保证phpwind云服务的稳定，但不保证不发生任何故障，阿里云产品用户须自行承担因使用phpwind云服务所带来的全部风险及损失；不就电讯系统或互联网的中断或无法运作、技术故障、计算机错误或病毒、信息损坏或丢失或其它在阿里云合理控制范围之外的原因而产生的其他任何性质的破坏而向用户或任何第三方承担赔偿责任。          <br>
2、阿里云有权自主决定是否批准用户提出的使用phpwind云服务的申请。出于技术、安全及业务发展规划等各种考虑，阿里云可以在无需用户另行同意的情况下随时独立的调整phpwind云服务的使用策略，包括但不限于：修改服务内容、中止或终止部分或全部服务、限制某个网站使用、用户（在某段时间内）的请求次数、请求的内容。即使用户已经被批准使用phpwind云服务，阿里云仍然有权根据用户投诉和反馈情况，自主决定暂停或终止德天用户网站phpwind云服务。由此带来的风险和损失，阿里云不承担任何责任。  <br>
3、阿里云无法承诺保证阿里云用户网站是完全合法、稳定或者安全的，也无法保证阿里云用户网站最终用户无不当或者违法行为，您应自行解决阿里云产品用户与最终用户产生的任何纠纷或者诉讼，与阿里云无关。<br>
4、对于由于不可抗力因素、阿里云无法控制的因素（包括黑客攻击、停断电等）或其他任何因素等造成服务中止或终止，而给您造成损失的，您同意放弃追究阿里云责任的全部权利。          <br>
5、如果用户和阿里云就phpwind云计算平台所投放的广告相关内容产生分歧，由用户和广告主双方协商解决，阿里云不承担相应责任。           <br>
6、如果用户对阿里云提供的服务的任何部分或本协议条款的任何部分不满意，用户唯一的和全部的解决方案就是停止继续使用相关服务。            <br>
7、双方均完全了解本条款的后果并进一步承认本条款的合理性。          <br>
五、隐私相关条款        <br>
1、阿里云重视对用户、最终用户隐私的保护，保护隐私是阿里云的一项基本政策。您提供的登记资料及阿里云保留的其他有关个人资料将受到中国有关隐私的法律保护。       <br> 
2、阿里云不允许任何人以任何手段收集、编辑、出售或者无偿传播最终用户的个人信息。一经发现用户实施上述行为，阿里云有权立即终止与该用户的服务协议，终止为其提供任何服务。       <br> 
3、如发生下列任一情况，阿里云有权对用户的信息予以披露：        <br>
（1）经相关用户同意披露的；        <br>
（2）根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；       <br> 
（3）如果用户出现违反中国有关法律、法规、规章、政策的，需要向第三方披露；        <br>
（4）其它阿里云为用户和最终用户服务目的而认为合适披露的；       <br>
六、其他       <br>
1、本协议构成用户和阿里云间就使用phpwind云服务的完整协议，并取代双方就有关本协议所载任何事项于先前以口头及书面达成的共识。       <br> 
2、如本协议的任何条款被视作无效或无法执行，则上述条款可被分离，其余部分则仍具有法律效力。       <br> 
3、本协议的标题仅为方便阅读所设，非对条款的定义、限制、解释或描述其范围或界限。        <br>
4、阿里云于用户发生过失或违约行为时放弃本协议规定的权利的，不得视为其对用户的其他或以后同类的过失或违约行为的弃权。         <br>
5、阿里云有权随时根据中华人民共和国有关法律、法规的变化、互联网的发展以及公司经营状况和经营策略的调整等修改本协议。用户要继续使用phpwind云服务就有必要对最新的《phpwind云服务使用协议》进行仔细阅读和确认。当发生有关争议时，以最新的协议为准。如果不同意所改动的内容，用户可以以书面方式通知阿里云终止使用相关服务，并自行删除。如果用户继续使用phpwind云服务，则视为用户接受本协议的变动。<br>
6、本服务协议条款的解释，效力及纠纷的解决，适用于中华人民共和国大陆法律。       <br>
7、若用户和阿里云发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此完全同意将纠纷或争议提交杭州市西湖区人民法院管辖。       <br>
（以下无正文）   </pre>
</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
<?php elseif($ac_type == 'check' ):?>
<div class="h_a">站点概况</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col width="400" />
		<col />
		<tr>
			<th>站点名称</th>
			<td><?php echo htmlspecialchars($ac_sitename, ENT_QUOTES, 'UTF-8');?></td>
			<td><div class="fun_tips"></div></td>
		</tr>
		<tr>
			<th>站点地址</th>
			<td><?php echo htmlspecialchars($ac_siteurl, ENT_QUOTES, 'UTF-8');?></td>
			<td><div class="fun_tips"></div></td>
		</tr>
		<tr>
			<th>站点编码</th>
			<td><?php echo htmlspecialchars($ac_charset, ENT_QUOTES, 'UTF-8');?></td>
			<td><div class="fun_tips"></div></td>
		</tr>
		<tr>
			<th>ACloud版本</th>
			<td><?php echo htmlspecialchars($ac_version, ENT_QUOTES, 'UTF-8');?></td>
			<td><div class="fun_tips"></div></td>
		</tr>
		<tr>
			<th>最近申请地址</th>
			<td><em><?php echo htmlspecialchars($ac_applyinfo[siteurl], ENT_QUOTES, 'UTF-8');?></em></td>
			<td><div class="fun_tips"></div></td>
		</tr>
		<tr>
			<th>最近申请时间</th>
			<td><em><?php echo htmlspecialchars($ac_applyinfo[lasttime], ENT_QUOTES, 'UTF-8');?></em></td>
			<td><div class="fun_tips"></div></td>
		</tr>
	</table>
</div>
<div class="h_a">环境监测</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col width="400" />
		<col />
<?php 
foreach($ac_evninfo as $info):
($info[t]) && $info[v] = $info[v] ? '可用' : '不可用';
?>
		<tr>
			<th><?php echo htmlspecialchars($info[k], ENT_QUOTES, 'UTF-8');?></th>
			<td><?php echo htmlspecialchars($info[v], ENT_QUOTES, 'UTF-8');?></td>
			<td><div class="fun_tips"></div></td>
		</tr>
<?php endforeach;?>
	</table>
	<div class="tac p10">
		<form name="reset" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=server'; ?>" method="post" style="display:inline;">
			<button type="submit" class="btn btn_big btn_submit">继续</button>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		<form name="reset" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?operate=reset&m=appcenter&c=server&a=check'; ?>" method="post" style="display:inline;">
			<button type="submit" onClick="return confirm('确认重置云服务？');" class="btn btn_big">重置云服务</button>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
</div>
<?php elseif($ac_type == 'error' ):?>
<div id="error_tips">
<h2>提示</h2>
<div class="error_cont">
<ul>
<li>出错了：“ <?php echo htmlspecialchars($ac_message, ENT_QUOTES, 'UTF-8');?> ”</li>
<li>请尝试：</li>
<li>1、<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?operate=check&m=appcenter&c=server'; ?>">[环境监测]</a>，查看问题所在。待各指标结果正常后，再重试。</li>
<li>2、若仍无法连接成功，请在<a href="http://www.phpwind.net/thread-htm-fid-131.html" target="_blank">[这里]</a>反馈给官方人员，我们竭诚为您解决。</li>
</ul>
<div class="error_return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=server'; ?>" class="btn">重试</a></div>
</div>
</div>
<?php elseif($ac_type == 'reset' ):?>
<div id="error_tips">
<h2>提示</h2>
<div class="error_cont">
<ul>
	<li><span>重置云服务成功</span></li>
	<li>你可以点击刷新重新申请云服务</li>
</ul>
<div class="error_return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=server'; ?>" class="btn">刷新</a></div>
</div>
<?php endif;?>	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>