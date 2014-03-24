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
	
		<div class="h_a">版块设置</div>
		<div class="table_full">
			<table width="100%">
				<col class="th" />
				<col width="400" />
				<col />
				<tr>
				<th>允许发布投票的版块</th>
				<td>
					<?php  if ($cateIds) { ?>
					<div class="user_group mb5">
						<?php  foreach($cateList as $cate) {
							if (!in_array($cate['fid'], $cateIds)) continue;
						?>
						<dl>
								<?php  if ($forumList[$cate['fid']]) { ?>
								<dt><label><?php echo htmlspecialchars(Pw::stripWindCode($cate['name'], true), ENT_QUOTES, 'UTF-8');?></label></dt>
								<dd>
								<?php  foreach ($forumList[$cate['fid']] as $forum) {
									$forum['name'] = strip_tags($forum['name']);
								 
  if (in_array($forum['fid'], array_keys($pollOpenForum))) { ?>
									<label><span><?php echo htmlspecialchars($forum['name'], ENT_QUOTES, 'UTF-8');?></span></label>
									<?php  } 
  } ?>
								</dd>
								<?php  } ?>
						</dl>
						<?php  } ?>
					</div>
					<?php  } ?>
					<a class="J_dialog" title="编辑" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=vote&c=manage&a=editforum'; ?>">[编辑]</a>
				</td>
				<td><div class="fun_tips"></div></td>
				</tr>
			</table>
		</div>
		
<form class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=vote&c=manage&a=dogroup'; ?>" method="post">
		<div class="h_a">用户组设置</div>
		<div class="table_full">
			<table width="100%">
				<col class="th" />
				<col width="400" />
				<col />
				<tr>
				<th>发布投票</th>
				<td>
					<div class="user_group">
<?php  foreach($groups as $key=>$value){
$typeName = isset($groupsTypeName[$key]) ? $groupsTypeName[$key] : '';
?>

						<dl>
							<dt><label><input class="J_check_all" data-direction="y" data-checklist="add_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" name="" type="checkbox" value=""><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
							<dd>
<?php  foreach($value as $k=>$val){ 
  $isChecked = in_array($val['gid'], $permission['allow_add_vote']) ? 'checked': ''; ?>
<label><input class="J_check" data-yid="add_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="view[allow_add_vote][]" value="<?php echo htmlspecialchars($val['gid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($isChecked, ENT_QUOTES, 'UTF-8');?>><span><?php echo htmlspecialchars($val['name'], ENT_QUOTES, 'UTF-8');?></span></label>
<?php  } ?>
							</dd>
						</dl>


<?php  } ?>
					</div>
				</td>
				<td><div class="fun_tips"></div></td>
				</tr>
				<tr>
				<th>参与投票</th>
				<td>
					<div class="user_group">
<?php  foreach($groups as $key=>$value){
$typeName = isset($groupsTypeName[$key]) ? $groupsTypeName[$key] : '';
?>

						<dl>
							<dt><label><input class="J_check_all" data-direction="y" data-checklist="participate_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" name="" type="checkbox" value=""><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
							<dd>
<?php  foreach($value as $k=>$val){ 
  $isChecked = in_array($val['gid'], $permission['allow_participate_vote']) ? 'checked': ''; ?>
<label><input class="J_check" data-yid="participate_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="view[allow_participate_vote][]" value="<?php echo htmlspecialchars($val['gid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($isChecked, ENT_QUOTES, 'UTF-8');?>><span><?php echo htmlspecialchars($val['name'], ENT_QUOTES, 'UTF-8');?></span></label>
<?php  } ?>
							</dd>
						</dl>


<?php  } ?>
					</div>

				</td>
				<td><div class="fun_tips"></div></td>
				</tr>
				<tr>
				<th>查看投票人员</th>
				<td>

					<div class="user_group">
<?php  foreach($groups as $key=>$value){
$typeName = isset($groupsTypeName[$key]) ? $groupsTypeName[$key] : '';
?>

						<dl>
							<dt><label><input class="J_check_all" data-direction="y" data-checklist="view_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" name="" type="checkbox" value=""><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
							<dd>
<?php  foreach($value as $k=>$val){ 
  $isChecked = in_array($val['gid'], $permission['allow_view_vote']) ? 'checked': ''; ?>
<label><input class="J_check" data-yid="view_J_check_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="view[allow_view_vote][]" value="<?php echo htmlspecialchars($val['gid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($isChecked, ENT_QUOTES, 'UTF-8');?>><span><?php echo htmlspecialchars($val['name'], ENT_QUOTES, 'UTF-8');?></span></label>
<?php  } ?>
							</dd>
						</dl>


<?php  } ?>
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
