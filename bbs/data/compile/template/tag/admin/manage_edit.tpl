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
<body style="width:500px" class="body_none">

	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?_json=1&m=tag&c=manage&a=doedit'; ?>" method="post">
	<input type="hidden" value="<?php echo htmlspecialchars($tag['tag_id'], ENT_QUOTES, 'UTF-8');?>" name="tag[tag_id]" />
	<div class="pop_cont">
		<div class="pop_table">
		<table width="100%">
			<tr>
				<th>话题名称</th>
				<td><input type="text" name="tag[name]" value="<?php echo htmlspecialchars($tag['tag_name'], ENT_QUOTES, 'UTF-8');?>" class="input length_5 input_hd"></td>
			</tr>
			<tr>
				<th>话题图片</th>
				<td>
					<div class="single_image_up"><a href="">重新选择</a><input name="icon" type="file" class="J_upload_preview"></div>
					<?php  if ($tag['tag_logo']) { ?>
					<img class="J_previewImg" style="max-width: 300px; " src="<?php echo htmlspecialchars(Pw::getPath($tag['tag_logo']), ENT_QUOTES, 'UTF-8');?>">
					<?php  } ?>
				</td>
			</tr>
			<?php  if ($categories) { ?>
			<tr>
				<th>话题分类</th>
				<td>
					<ul class="three_list cc">
					<?php  foreach($categories as $v){ 
						$checkedHtml = ($tagCategories && isset($tagCategories[$v['category_id']])) ? ' checked' : '';
					?>
						<li><label><input type="checkbox" <?php echo htmlspecialchars($checkedHtml, ENT_QUOTES, 'UTF-8');?> value="<?php echo htmlspecialchars($v['category_id'], ENT_QUOTES, 'UTF-8');?>" name="tag[category][]"><?php echo htmlspecialchars($v['category_name'], ENT_QUOTES, 'UTF-8');?></label></li>
					<?php  } ?>
					</ul>
				</td>
			</tr>
			<?php  } ?>
			<tr>
				<th>关联话题</th>
				<td><input type="text" name="tag[relate_tags]" value="<?php echo htmlspecialchars($relatedTags, ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
			</tr>
			<tr>
				<th>话题描述</th>
				<td><textarea name="tag[excerpt]" class="length_5"><?php echo htmlspecialchars($tag['excerpt'], ENT_QUOTES, 'UTF-8');?></textarea></td>
			</tr>
			<tr>
				<th>title设置</th>
				<td><input type="text" name="tag[seo_title]" value="<?php echo htmlspecialchars($tag['seo_title'], ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
			</tr>
			<tr>
				<th>description设置</th>
				<td><input type="text" name="tag[seo_description]" value="<?php echo htmlspecialchars($tag['seo_description'], ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
			</tr>
			<tr>
				<th>keywords设置</th>
				<td><input type="text" name="tag[seo_keywords]" value="<?php echo htmlspecialchars($tag['seo_keywords'], ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
			</tr>
		</table>
		</div>
	</div>
	<div class="pop_bottom">
		<button class="btn fr" id="J_dialog_close" type="button">取消</button>
		<button type="submit" class="btn btn_submit J_ajax_submit_btn mr10 fr">提交</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>