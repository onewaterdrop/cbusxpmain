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
	<div class="nav">
		<ul class="cc">
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=upgrade'; ?>">版本升级</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=fixup'; ?>">安全中心</a></li>
		</ul>
	</div>
	<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=fixup&a=doRun'; ?>" method="post">
		<div class="table_list">
			<table width="100%">
				<?php  if(isset($connect_fail)){ ?>
				<tbody>
					<tr><td class="tac"><?php echo htmlspecialchars($connect_fail, ENT_QUOTES, 'UTF-8');?></td></tr>
				</tbody>
				<?php  }else{ 
  if ($patches) { ?>
				<colgroup>
					<col width="60">
					<col width="300">
				</colgroup>
				<thead>
					<tr>
						<td><label><input type="checkbox" class="J_check_all" data-direction="x" data-checklist="J_check_x">全选</label></td>
						<td>编号</td>
						<td>更新补丁名称</td>
						<td>更新说明</td>
						<td><span>发布时间</span></td>
					</tr>
				</thead>
				<?php  foreach ($patches as $v) {
					$disabled = $v['status'] ? 'disabled="disabled"' : '';
				 ?>
				<tr>
					<td><input <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?> type="checkbox" class="J_check" data-yid="J_check_y" data-xid="J_check_x" name="patches[]" value="<?php echo htmlspecialchars($v['id'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><?php echo htmlspecialchars($v['id'], ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars($v['desc'], ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars(Pw::time2str($v['time']), ENT_QUOTES, 'UTF-8');?></td>
				</tr>
				<?php  } 
  } else { ?>
					<tbody>
						<tr><td class="tac">啊哦，暂时没有更新补丁！</td></tr>
					</tbody>
				<?php  } } ?>
			</table>
		</div>
		<?php  if ($patches) { ?>
		<div class="btn_wrap">
			<div class="btn_wrap_pd">
				<label class="mr20"><input type="checkbox" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label>
				<button class="btn btn_submit J_ajax_submit_btn" type="submit">立即升级</button>
			</div>
		</div>
		<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
<script>

</script>
</html>