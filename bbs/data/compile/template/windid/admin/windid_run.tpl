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

</head>
<body>
<div class="wrap J_check_wrap">	
	<!-- <div class="nav">
		<ul class="cc">
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=windid&c=windid'; ?>">基本设置</a></li>
			
		</ul>
	</div> -->
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>通过WindID,可以实现多个系统间的用户同步登陆，登出，并实现各系统间用户资料，积分，私信等同步。</li>
			<li>独立系统：如查当前没有对接其它系统，请选择此项。</li>
			<li>用户中心服务端：表示当前系统为WindID服务端，设置完成后，请到<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=windid&c=client'; ?>">客户端管理</a>中添加客户端站点信息；并<span class="red">修改src/windid/conf/目录下配置文件</span></li>
			<li>用户中心客户端：表示当前系统作为另一个WindID系统客户端，需要确认客户端通信密钥、服务端数据库配置与服务端保持一致，确保通信成功。设置成功后，客户端用户信息，积分，私信将和服务端保持一致。</li>
		</ol>
	</div>

	<form class="J_ajaxForm"  action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=windid&c=windid&a=dorun'; ?>" method="post">
	<div class="h_a">WindID设置</div>
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400"/>
			<tr>
				<th>将本系统设为</th>
				<td>
					<ul class="single_list J_radio_change" data-rel=".J_windid_item">
						<li><label><input name="windid" data-arr="" value="local" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($config['windid'] == 'local'), ENT_QUOTES, 'UTF-8');?>><span>独立系统</span></label></li>
					
						<li><label><input name="windid" data-arr="" value="server" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($config['windid'] == 'server'), ENT_QUOTES, 'UTF-8');?>><span>WindID服务端</span></label></li>

						<li><label><input name="windid" data-arr="J_client_set" value="client" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($config['windid'] == 'client'), ENT_QUOTES, 'UTF-8');?>><span>WindID客户端</span></label></li>
						
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
		</table>
	</div>
	<!--  # if($config['windid'] == 1){ #  -->
	<!-- <div id="J_client_set" class="J_windid_item">
		<div class="h_a">客户端配置</div>
		<div class="table_full">
			<table width="100%">
				<col class="th" />
				<col width="400"/>
				<tr>
					<th>服务端Url</th>
					<td><input name="serverUrl" type="text" class="input length_5" value="<?php echo htmlspecialchars($client->serverUrl, ENT_QUOTES, 'UTF-8');?>">
						<input name="clientCharser" type="hidden"  value="<?php echo htmlspecialchars($client->clientCharser, ENT_QUOTES, 'UTF-8');?>">
					</td>
					<td></td>
				</tr>
				<tr>
					<th>客户端ID</th>
					<td><input name="clientId" type="text" class="input length_5" value="<?php echo htmlspecialchars($client->clientId, ENT_QUOTES, 'UTF-8');?>"></td>
					<td><div class="fun_tips">在服务端“客户端列表”的ID</div></td>
				</tr>
				<tr>
					<th>通讯密钥</th>
					<td><input name="clientKey" type="text" class="input length_5" value="<?php echo htmlspecialchars($client->clientKey, ENT_QUOTES, 'UTF-8');?>"></td>
					<td><div class="fun_tips">在服务端“客户端列表”的通讯密钥</div></td>
				</tr>
				<tr>
					<th>windid连接方式</th>
					<td>
						<ul class="single_list">
							<li><label><input name="clientDb"  value="mysql" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($client->clientDb == 'mysql'), ENT_QUOTES, 'UTF-8');?>><span>本地连接</span></label></li>
							<li><label><input name="clientDb"  value="http" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($client->clientDb == 'http'), ENT_QUOTES, 'UTF-8');?>><span>HTTP连接</span></label></li>
						</ul>
					</td>
					<td><div class="fun_tips">如果能够直接访问服务端windid数据库，请选择本地连接，请配置windid数据库连接,否则选择http方式，不需要配置数据库</div></td>
				</tr> -->
				<!-- <tr>
					<th>客户端编码</th>
					<td>
						<input name="clientCharser"  value="utf-8" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($client->clientCharser == 'utf-8'), ENT_QUOTES, 'UTF-8');?>><span>UTF-8</span>
						<input name="clientCharser"  value="gbk" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($client->clientCharser == 'gbk'), ENT_QUOTES, 'UTF-8');?>><span>GBK</span>
					</td>
					<td><div class="fun_tips">客户端的网页编码</div></td>
				</tr> -->
			<!-- </table>
		</div>
	</div> -->
	<!--  # } #  -->
	<!-- <div class="h_a">windid数据库配置</div>
		<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col/>
			<tr>
				<th>数据库服务器</th>
				<td><input name="dbhost" type="text" class="input length_5" value="<?php echo htmlspecialchars($mysql['host'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td></td>
			</tr>
			<tr>
				<th>数据库用户名</th>
				<td><input name="dbuser" type="text" class="input length_5" value="<?php echo htmlspecialchars($mysql['user'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td></td>
			</tr>
			<tr>
				<th>数据库密码</th>
				<td><input name="dbpwd" type="password" class="input length_5" value="<?php echo htmlspecialchars($mysql['pwd'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td></td>
			</tr>
			<tr>
				<th>数据库名</th>
				<td><input name="dbname" type="text" class="input length_5" value="<?php echo htmlspecialchars($mysql['dbname'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td></td>
			</tr>
			<tr>
				<th>数据库表前缀</th>
				<td><input name="dbprefix" type="text" class="input length_5" value="<?php echo htmlspecialchars($mysql['tableprefix'], ENT_QUOTES, 'UTF-8');?>">
					<input name="engine" type="hidden"  value="<?php echo htmlspecialchars($mysql['engine'], ENT_QUOTES, 'UTF-8');?>">
					<input name="port" type="hidden"  value="<?php echo htmlspecialchars($mysql['port'], ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td></td>
			</tr>
		</table>
	</div> -->
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" type="submit" >提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

</body>
</html>