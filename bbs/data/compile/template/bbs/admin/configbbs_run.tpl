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
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=configbbs&a=dorun'; ?>" method="post">
		<div class="h_a">论坛设置</div>
		<div class="table_full">
			<table width="100%">
				<col class="th" />
				<col width="400" />
				<col />
				<tr style="display:none">
					<th>论坛名称</th>
					<td><input name="bbsname" type="text" class="input length_5 input_hd" value="<?php echo htmlspecialchars($config['bbsname'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><div class="fun_tips">设置后显示在面包屑路径以及论坛各个页面title的站点名称中。</div></td>
				</tr>
				<tr>
					<th>帖子标题最大长度</th>
					<td><input name="title_length_max" type="text" class="input length_5 input_hd" value="<?php echo htmlspecialchars($config['title.length.max'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><div class="fun_tips">单位：字，请输入正整数</div></td>
				</tr>
				<tr>
					<th>内容长度控制</th>
					<td><input type="text" name="content_length_min" value="<?php echo htmlspecialchars($config['content.length.min'], ENT_QUOTES, 'UTF-8');?>" class="input mr5"><span class="mr5">至</span><input type="text" name="content_length_max" value="<?php echo htmlspecialchars($config['content.length.max'], ENT_QUOTES, 'UTF-8');?>" class="input"></td>
					<td><div class="fun_tips">单位：字，请输入正整数</div></td>
				</tr>
				<!-- <tr>
					<th>定时发帖</th>
					<td>
						<ul class="switch_list cc mb10">
							<li><label><input class="J_timeing" name="ifopen" data-role="open" type="radio" value="1" <?php echo htmlspecialchars(Pw::ifcheck(1 == $config['post.timing.open']), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
							<li><label><input class="J_timeing" name="ifopen" data-role="close" type="radio" value="0"<?php echo htmlspecialchars(Pw::ifcheck(0 == $config['post.timing.open']), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
						</ul>
						<div class="mb10">开始于&nbsp;<input name="start_hour" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.timing.start_hour'], ENT_QUOTES, 'UTF-8');?>">&nbsp;时&nbsp;<input name="start_min" type="number" class="input length_1 J_timing_input"value="<?php echo htmlspecialchars($config['post.timing.start_min'], ENT_QUOTES, 'UTF-8');?>">&nbsp;分</div>
						<div>结束于&nbsp;<input name="end_hour" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.timing.end_hour'], ENT_QUOTES, 'UTF-8');?>">&nbsp;时&nbsp;<input name="end_min" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.timing.end_min'], ENT_QUOTES, 'UTF-8');?>">&nbsp;分</div>
					</td>
					<td><div class="fun_tips">设置用户发布的帖子需要审核的时间段，支持跨越零点设置。<br>例如：需设置用户在 每天23:00 到 次日8:00 这段时间内发布的帖子需要审核，则设置开始于23:00；结束于8:00。 </div></td>
				</tr>
				<tr>
					<th>允许发帖的用户组</th>
					<td>
						<div class="user_group J_check_wrap">
							<?php  foreach ($groupTypes as $type => $typeName) { ?>
							<dl>
								<dt><label><input type="checkbox" data-direction="y" data-checklist="J_check_timging_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" class="checkbox J_check_all" /><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
								<dd>
								<?php  foreach ($groups as $group) { 
  if ($group['type'] == $type) { ?>
									<label><input class="J_check" data-yid="J_check_timging_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="timing_groups[]" value="<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>"<?php echo htmlspecialchars(Pw::ifcheck(in_array($group['gid'], $config['post.timing.groups'])), ENT_QUOTES, 'UTF-8');?> /><span><?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?></span></label>
									<?php  } 
  } ?>
								</dd>
							</dl>
							<?php  } ?>
						</div>
					</td>
					<td><div class="fun_tips">勾选的用户组不受定时发帖的限制，在限制时间段内也可以正常发帖。</div></td>
				</tr> -->
				<tr>
					<th>定时发帖审核</th>
					<td>
						<ul class="switch_list cc mb10">
							<li><label><input class="J_check" type="radio" data-role='open' name="check" <?php echo htmlspecialchars(Pw::ifcheck(1 == $config['post.check.open']), ENT_QUOTES, 'UTF-8');?> value="1"><span>开启</span></label></li>
							<li><label><input class="J_check" type="radio" data-role='close' name="check" <?php echo htmlspecialchars(Pw::ifcheck(0 == $config['post.check.open']), ENT_QUOTES, 'UTF-8');?> value="0"><span>关闭</span></label></li>
						</ul>
						<div class="mb10">开始于&nbsp;<input name="check_start_hour" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.check.start_hour'], ENT_QUOTES, 'UTF-8');?>">&nbsp;时&nbsp;<input name="check_start_min" type="number" class="input length_1 J_timing_input"value="<?php echo htmlspecialchars($config['post.check.start_min'], ENT_QUOTES, 'UTF-8');?>">&nbsp;分</div>
						<div>结束于&nbsp;<input name="check_end_hour" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.check.end_hour'], ENT_QUOTES, 'UTF-8');?>">&nbsp;时&nbsp;<input name="check_end_min" type="number" class="input length_1 J_timing_input" value="<?php echo htmlspecialchars($config['post.check.end_min'], ENT_QUOTES, 'UTF-8');?>">&nbsp;分</div>
					</td>
					<td><div class="fun_tips">设置用户发布的帖子需要审核的时间段，支持跨越零点设置。 <br>例如：需设置用户在 每天23:00 到 次日8:00 这段时间内发布的帖子需要审核，则设置开始于23:00；结束于8:00。</div></td>
				</tr>
				<tr>
					<th>不需审核的用户组</th>
					<td>
						<div class="user_group J_check_wrap">
							<?php  foreach ($groupTypes as $type => $typeName) { ?>
							<dl>
								<dt><label><input type="checkbox" data-direction="y" data-checklist="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" class="checkbox J_check_all" /><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
								<dd>
								<?php  foreach ($groups as $group) { 
  if ($group['type'] == $type) { ?>
									<label><input class="J_check" data-yid="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="check_groups[]" value="<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>"<?php echo htmlspecialchars(Pw::ifcheck(in_array($group['gid'], $config['post.check.groups'])), ENT_QUOTES, 'UTF-8');?> /><span><?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?></span></label>
									<?php  } 
  } ?>
								</dd>
							</dl>
							<?php  } ?>
						</div>
					</td>
					<td><div class="fun_tips">勾选的用户组不受定时发帖审核的限制，在限制时间段内发帖可以直接显示。</div></td>
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
<script type="text/javascript">
$(function(){
	//定时发帖开启/关闭
	$('input.J_timeing').on('change', function(e){
		var checks = $('div.J_check_time_wrap input:checkbox');
		var input = $('input.J_timing_input');
		if($(this).data('role') === 'open') {
			checks.removeAttr('readonly');
			input.removeAttr('readonly');
		}else{
			checks.attr('readonly', 'true');
			input.attr('readonly', 'true');
		}
	});
});
</script>
</body>
</html>