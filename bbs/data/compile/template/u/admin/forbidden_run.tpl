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
<div class="wrap">

<!-- start -->
<div class="nav">
	<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=manage'; ?>">返回上一级</a></div>
	<ul class="cc">
		<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=forbidden'; ?>">手动禁止</a></li>
		<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=forbidden&a=auto'; ?>">自动禁止</a></li>
		<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=forbidden&a=list'; ?>">解除禁止</a></li>
	</ul>
</div>
<form class="J_ajaxForm" data-role="list" method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=forbidden&a=dorun'; ?>">
<div class="h_a">会员禁止</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col width="400" />
		<col />
		<tr>
			<th>禁止对象</th>
			<td>
				<ul class="three_list cc mb5">
					<li><label><input type="radio" name="key" value="2" checked>用户名</label></li>
					<li><label><input type="radio" name="key" value="1">UID</label></li>
				</ul>
				<input type="text" class="input length_5" name="value" value="<?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?>">
			</td>
			<td><div class="fun_tips">多个对象之间用英文半角逗号","分隔。</div></td>
		</tr>
		<tr>
			<th>有效期至</th>
			<td><input type="text" value="" name="end_time" class="input mr5 length_5 J_datetime date"></td>
			<td><div class="fun_tips">输入0表示永久禁止</div></td>
		</tr>
		<tr>
			<th>禁止类型</th>
			<td>
				<ul class="single_list cc">
<?php foreach ($types as $key => $value) {?>
					<li><label><input type="checkbox" name="type[]" value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($value['title'], ENT_QUOTES, 'UTF-8');?></label></li>
<?php }?>
				</ul>
			</td>
			<td><div class="fun_tips">
					<p>禁止发布：将禁止用户在全站发表内容的权限</p>
					<p>禁止头像：将清空用户当前的头像，并默认显示已禁止的头像，超过设定的期限后，显示网站默认头像</p>
					<p>禁止签名：禁止用户签名后，签名栏显示管理员设置的禁止理由，超过设定的期限后，签名栏默认为空</p>
			</div></td>
		</tr>
		<tr>
			<th>禁止多帐号</th>
			<td>
				<ul class="switch_list cc">
				<li><label><input type="radio" name="ban_others" value="1"><span>禁止</span></label></li>
				<li><label><input type="radio" name="ban_others" value="0" checked><span>不禁止</span></label></li>
				</ul>
			</td>
			<td><div class="fun_tips">同时禁止此帐号绑定的所有帐号。</div></td>
		</tr>
		<tr>
			<th>禁止理由</th>
			<td>
				<textarea class="length_5" name="reason"></textarea>
			</td>
			<td><div class="fun_tips">必填</div></td>
		</tr>
	</table>
</div>

<div class="btn_wrap">
	<div class="btn_wrap_pd">
		<button class="btn btn_submit mr10 J_ajax_submit_btn" type="submit">提交</button>
	</div>
</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>