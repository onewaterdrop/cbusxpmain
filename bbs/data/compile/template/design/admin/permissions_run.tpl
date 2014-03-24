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
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>此处仅显示在在页面管理或模块管理中有设置过管理权限的用户列表；</li>
			<li>在<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=page'; ?>">门户-页面管理</a>中可为指定页面添加拥有单独管理权限的管理组用户；</li>
			<li>在<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=module'; ?>">门户-模块管理</a>中可为指定模块添加拥有单独管理权限的管理组用户；</li>
			<li>只拥有<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=system&m=u&c=groups'; ?>">用户-用户组权限-管理组管理权限</a>里设置的门户权限的用户，不显示在此列表中。</li>
		</ul>
	</div>
	<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=permissions'; ?>" method="post">
	<div class="h_a">搜索</div>
	<div class="prompt_text">
		<input type="text" placeholder="用户名" class="input length_3 mr5" name="username"><button class="btn" type="submit">搜索</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<div class="h_a">用户列表</div>
	<div class="table_full">
		<table width="100%">
			<colgroup>
				<col class="th">
				<col width="160">
			</colgroup>
		<?php  if ($users) { 
  foreach ($users as $v): ?>
			<tr>
				<th><?php echo htmlspecialchars($v['username'], ENT_QUOTES, 'UTF-8');?></th>
				<td><?php echo htmlspecialchars($groups[$v['gid']]['name'], ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?uid=', rawurlencode($v['uid']),'&m=design&c=permissions&a=view'; ?>">[查看权限]</a></td>
			</tr>
		<?php  endforeach; 
  } else { ?>
			<tr><td colspan="7" class="tac">啊哦，没有符合条件的用户！</td></tr>
		<?php  } ?>
		</table>
	</div>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>