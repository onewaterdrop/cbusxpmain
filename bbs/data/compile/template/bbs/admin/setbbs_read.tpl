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
	<form method="post" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=doread'; ?>">
	<div class="nav">
		<ul class="cc">
			<!-- <li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs'; ?>">首页</a></li> -->
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=thread'; ?>">列表页</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=read'; ?>">阅读页</a></li>
		</ul>
	</div>
	<div class="h_a">论坛阅读页功能细节设置</div>
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>每页帖子楼层数</th>
				<td><input name="perpage" type="number" class="input length_5 mr5" value="<?php echo htmlspecialchars($config['read.perpage'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<!-- 
			<tr>
				<th>匿名的名称</th>
				<td><input name="anonymous_displayname" type="text" class="input length_5" value="<?php echo htmlspecialchars($config['read.anoymous_displayname'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips">发布匿名帖时，匿名用户显示的匿名文字。</div></td>
			</tr>
			<tr>
				<th>屏蔽禁言会员所有帖子</th>
				<td>
					<ul class="switch_list cc mb10">
						<li><label><input type="radio" name="shield_banthreads" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['read.shield_banthreads']==1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="shield_banthreads" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['read.shield_banthreads']==0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">屏蔽禁言会员的帖子内容，普通用户不可查看。</div></td>
			</tr>
			 -->
			<tr>
				<th>帖子楼层单位</th>
				<td><input name="floor_name" type="text" value="<?php echo htmlspecialchars($config['read.floor_name'], ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
				<td><div class="fun_tips">设置帖子显示楼层的单位，如“楼”将显示为1楼。</div></td>
			</tr>
			<tr>
				<th>预设帖子楼层名称</th>
				<td>
					<textarea class="length_5" name="defined_floor_name"><?php echo htmlspecialchars($config['read.defined_floor_name'], ENT_QUOTES, 'UTF-8');?></textarea>
				</td>
				<td><div class="fun_tips">格式 “楼层名称”或“N:楼层名称”，N代表楼层数（主题帖为0楼），如果没有指定楼层N，则第一行代表主题帖子。其中，连续楼层之间可以用‘,’逗号隔开或换行，N后面的楼层为N+1，以此类推，直到再次出现N。<br>例:0:楼主，沙发，板凳<br>3:地板，地下室<br>100:中奖楼层</div></td>
			</tr>
			<tr>
				<th>点击率实时更新</th>
				<td>
					<ul class="switch_list cc mb10">
						<li><label><input type="radio" name="hit_update" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['read.hit_update']==1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="hit_update" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['read.hit_update']==0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">开启后，浏览帖子将实时更新阅读数</div></td>
			</tr>
			<tr>
				<th>图片懒加载</th>
				<td>
					<ul class="switch_list cc mb10">
						<li><label><input type="radio" name="image_lazy" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['read.image_lazy']==1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="image_lazy" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['read.image_lazy']==0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">开启后，浏览帖子实现图片按需加载，可以提升页面显示速度，但可能会影响搜索引擎对图片的收录。</div></td>
			</tr>
		</table>
	</div>
	<div class="h_a">个人信息显示</div>
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>显示个人信息</th>
				<td>
					<ul class="switch_list cc mb10">
						<li><label><input type="radio" name="display_member_info" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['read.display_member_info']==1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="display_member_info" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['read.display_member_info']==0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">开启后，帖子阅读页楼层左侧的用户信息将展开显示。</div></td>
			</tr>
			<tr>
				<th>显示栏目</th>
				<td>
					<div class="cross">
						<ul>
							<li>
								<span class="span_2">顺序</span>
								<span class="span_2">栏目名称</span>
								<span class="span_2">显示</span>
							</li>
							<?php  $i=0; 
  foreach ($order as $key => $value) { 
								if (!$allInfo[$key]) continue;
							?>
							<li>
								<span class="span_2"><input name="display_info_vieworder[<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>]" type="text" class="input length_1" value="<?php echo htmlspecialchars($i++, ENT_QUOTES, 'UTF-8');?>"></span>
								<span class="span_2"><?php echo htmlspecialchars($allInfo[$key], ENT_QUOTES, 'UTF-8');?></span>
								<span class="span_2"><input name="display_info[<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>]" type="checkbox" value="1"<?php echo htmlspecialchars(Pw::ifcheck($config['read.display_info'][$key]), ENT_QUOTES, 'UTF-8');?>></span>
							</li>
							<?php  } ?>
						</ul>
					</div>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
		</table>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>