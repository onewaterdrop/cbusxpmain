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
	<form method="post" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=dothread'; ?>">
	<div class="nav">
		<ul class="cc">
			<!-- <li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs'; ?>">首页</a></li> -->
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=thread'; ?>">列表页</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=setbbs&a=read'; ?>">阅读页</a></li>
		</ul>
	</div>
	<div class="h_a">论坛列表页功能细节设置</div>
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>新帖控制</th>
				<td><input name="new_thread_minutes" type="number" class="input length_5 mr5" value="<?php echo htmlspecialchars($config['thread.new_thread_minutes'], ENT_QUOTES, 'UTF-8');?>">分钟</td>
				<td><div class="fun_tips">超过设定时间后，主题将不在显示为新帖。</div></td>
			</tr>
			<tr>
				<th>每页显示主题数</th>
				<td><input name="perpage" type="number" class="input length_5" value="<?php echo htmlspecialchars($config['thread.perpage'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>最大显示页数</th>
				<td><input name="max_pages" type="number" class="input length_5" value="<?php echo htmlspecialchars($config['thread.max_pages'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips">主题列表中用户可以查看的最大页数，建议设置为1000-2500之间，0表示不限制。</div></td>
			</tr>
			<!-- 
			<tr>
				<th>显示快速发布主题</th>
				<td>
					<ul class="switch_list cc">
						<li><label><input type="radio" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['thread.show_fastpost']==1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['thread.show_fastpost']==0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			 -->
			<!--tr>
				<th>侧栏版块列表宽度</th>
				<td><input name="leftside_width" type="number" class="input length_5 mr5" value="<?php echo htmlspecialchars($config['thread.leftside_width'], ENT_QUOTES, 'UTF-8');?>">像素</td>
				<td><div class="fun_tips">设置左侧版块导航宽度，可根据版块名称长度自动调整。</div></td>
			</tr-->
			<tr>
				<th>热帖回复数量</th>
				<td><input name="hotthread_replies" type="number" class="input length_5" value="<?php echo htmlspecialchars($config['thread.hotthread_replies'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips">回复数超过设定值后，主题将显示热门帖子图标。</div></td>
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