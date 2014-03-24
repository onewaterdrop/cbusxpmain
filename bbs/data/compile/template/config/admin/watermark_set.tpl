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
		<ul class="cc">
		<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=config&c=watermark'; ?>">水印设置</a></li>
		<li  class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=config&c=watermark&a=set'; ?>">水印策略</a></li>
		</ul>
	</div>
	
	<form method="post" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=config&c=watermark&a=doset'; ?>" data-role="list">
	<div class="h_a">水印策略</div>
	<div class="table_purview mb10">
		<table class="J_check_wrap" width="100%">
			<col width="160">
			<col width="120">
			<tr class="hd">
				<th>&nbsp;</th>
				<td><label><input class="J_check_all" data-checklist="J_check_watermarkset" data-direction="y" name="" type="checkbox" value="">启用水印</label></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>论坛图片上传</th>
				<td><input class="J_check" data-yid="J_check_watermarkset" name="markset[]" type="checkbox" value="bbs" <?php echo htmlspecialchars(Pw::ifcheck(in_array('bbs',$config['mark.markset'])), ENT_QUOTES, 'UTF-8');?>></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>相册图片上传</th>
				<td><input class="J_check" data-yid="J_check_watermarkset" name="markset[]" type="checkbox" value="album" <?php echo htmlspecialchars(Pw::ifcheck(in_array('album',$config['mark.markset'])), ENT_QUOTES, 'UTF-8');?>></td>
				<td>&nbsp;</td>
			</tr>
			<!-- <tr>
				<th>日志图片上传</th>
				<td><input class="J_check" data-yid="J_check_watermarkset" name="markset[]" type="checkbox" value="diary" <?php echo htmlspecialchars(Pw::ifcheck(in_array('diary',$config['mark.markset'])), ENT_QUOTES, 'UTF-8');?>></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>文章图片上传</th>
				<td><input class="J_check" data-yid="J_check_watermarkset" name="markset[]" type="checkbox" value="cms" <?php echo htmlspecialchars(Pw::ifcheck(in_array('cms',$config['mark.markset'])), ENT_QUOTES, 'UTF-8');?>></td>
				<td>&nbsp;</td>
			</tr> -->
		</table>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit mr10 J_ajax_submit_btn" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
<!--=================结束=================-->
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>