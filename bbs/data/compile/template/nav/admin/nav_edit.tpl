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

<style>
body{width:440px;}
</style>
</head>
<body class="body_none">
<div>
<!-- mod start -->
<form method="post" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=nav&c=nav&a=doedit'; ?>" data-role="edit">
<div class="pop_cont pop_table">
	<table width="100%" style="table-layout:fixed;">
		<col width="80" />
		<col />
		<tr>
			<th>上级导航</th>
			<td>
				<span class="must_red">*</span>
				<select name="parentid" class="select_5">
					<option value=''>顶级导航</option>
					<?php echo $navOption?>
				</select>
			</td>
		</tr>
		<tr>
			<th>栏目名称</th>
			<td>
				<span class="must_red">*</span>
				<input type="text" name="name" class="input input_hd length_5" value="<?php echo htmlspecialchars($navInfo['name'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>链接地址</th>
			<td>
				<div class="mb5"><input type="text" name="link" class="input length_5" value="<?php echo htmlspecialchars($navInfo['link'], ENT_QUOTES, 'UTF-8');?>"></div>
				<div class="gray">以http://开头</div>
			</td>
		</tr>

		<tr>
			<th>名称样式</th>
			<td>
				<?php $__tpl_data = $navInfo; ?>
<!-- 数据格式定义：__tpl_data = array('font' => '' , 'bold' => '' , 'italic' => '' , 'underline' => '' , 'color' => '')  -->
<!-- name:radio名称,默认值为radio；value:radio当前值,默认值为0；items:为radio的选项,默认一个项 -->
<?php  isset($__tpl_data['font']) || $__tpl_data['font'] = '';
isset($__tpl_data['bold']) || $__tpl_data['bold'] = '';
isset($__tpl_data['italic']) || $__tpl_data['italic'] = '';
isset($__tpl_data['underline']) || $__tpl_data['underline'] = '';
isset($__tpl_data['color']) || $__tpl_data['color'] = '';  ?>

<div class="color_pick_dom J_font_config">
	<div class="case" <?php echo htmlspecialchars($__tpl_data['font'], ENT_QUOTES, 'UTF-8');?>><p>字体预览</p><p>ABCD</p></div>
	<ul>
		<li><label><input name="fontBold" class="J_bold" data-class="b" type="checkbox" value="1" <?php echo htmlspecialchars(Pw::ifcheck($__tpl_data['bold']), ENT_QUOTES, 'UTF-8');?>>粗体</label></li>
		<li><label><input name="fontItalic" class="J_italic" data-class="i" type="checkbox" value="1" <?php echo htmlspecialchars(Pw::ifcheck($__tpl_data['italic']), ENT_QUOTES, 'UTF-8');?>>斜体</label></li>
		<li class="none"><label><input name="fontUnderline" data-class="u" type="checkbox" class="J_underline" value="1" <?php echo htmlspecialchars(Pw::ifcheck($__tpl_data['underline']), ENT_QUOTES, 'UTF-8');?>>下划线</label></li>
	</ul>
	<span class="color_pick"><em style="background:<?php echo htmlspecialchars($__tpl_data['color'], ENT_QUOTES, 'UTF-8');?>;" class="J_bg"></em></span>
	<input name="fontColor" type="hidden" class="J_hidden_color" value="<?php echo htmlspecialchars($__tpl_data['color'], ENT_QUOTES, 'UTF-8');?>">
</div>
<?php  ?>
			</td>
		</tr>
		<tr>
			<th>说明</th>
			<td>
				<div class="mb5"><input type="text" name="alt" class="input length_5" value="<?php echo htmlspecialchars($navInfo['alt'], ENT_QUOTES, 'UTF-8');?>"></div>
				<div class="gray">鼠标悬浮于链接文字上时的说明内容</div>
			</td>
		</tr>
		<tr>
			<th>打开方式</th>
			<td>
				<ul class="switch_list cc">
					<li><label><input name="target" type="radio" value="0" <?php echo htmlspecialchars(Pw::ifcheck(!$navInfo['target']), ENT_QUOTES, 'UTF-8');?>><span>本窗口</span></label></li>
					<li><label><input name="target" type="radio" value="1"  <?php echo htmlspecialchars(Pw::ifcheck($navInfo['target']), ENT_QUOTES, 'UTF-8');?>><span>新窗口</span></label></li>
				</ul>
			</td>
		</tr>
		<tr>
			<th>顺序</th>
			<td>
				<input type="text" name="orderid" class="input length_5" value="<?php echo htmlspecialchars($navInfo['orderid'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>

		<tr>
			<th>是否启用</th>
			<td>
				<ul class="three_list cc">
					<li><label><input name="isshow" type="checkbox" value="1"  <?php echo htmlspecialchars(Pw::ifcheck($navInfo['isshow']), ENT_QUOTES, 'UTF-8');?>>启用</label></li>
				</ul>
			</td>
		</tr>
	</table>
</div>
<!-- mod end -->
<div class="pop_bottom">
	<button class="btn fr" id="J_dialog_close" type="button">取消</button>
	<button class="btn btn_submit J_ajax_submit_btn mr10 fr" type="submit">提交</button>
		<input name="type" type="hidden" value="<?php echo htmlspecialchars($navInfo['type'], ENT_QUOTES, 'UTF-8');?>">
		<input name="navid" type="hidden" value="<?php echo htmlspecialchars($navInfo['navid'], ENT_QUOTES, 'UTF-8');?>">
</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
<!-- end -->

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>