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
<body class="body_none" style="width:408px;">

<!--==============================添加链接================================-->
	<form id="J_link_add_form" class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doadd'; ?>" method="post">
	<div class="pop_cont pop_table" style="height:auto;">
		<table width="100%">
			<tr>
				<th>站点名称</th>
				<td><span class="must_red">*</span><input name="name" type="text" class="input length_5"><p class="gray">最多不超过15个字</p></td>
			</tr>
			<tr>
				<th>站点地址</th>
				<td><span class="must_red">*</span><input name="url" type="text" class="input length_5"></td>
			</tr>
			<tr>
				<th>站点LOGO</th>
				<td><input name="logo" type="text" class="input length_5"><p class="gray">请输入LOGO的图片地址，设置后自动为图片链接</p></td>
			</tr>
			<tr>
				<th>显示顺序</th>
				<td><input name="vieworder" type="number" class="input length_5"></td>
			</tr>
			<tr>
				<th>联系方式</th>
				<td><input name="contact" type="text" class="input length_5"></td>
			</tr>
			<tr>
				<th>链接分类</th>
				<td>
					<span class="must_red">*</span>
					<ul class="three_list cc">
					<?php  foreach ($types as $value) { ?>
						<li><label><input type="checkbox" name="typeids[]" value="<?php echo htmlspecialchars($value['typeid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($value['typename'], ENT_QUOTES, 'UTF-8');?></label></li>
					<?php  } ?>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<input name="ifcheck" type="hidden" value="1">
	<!-- <div id="J_submit_tips" class="tips_error" style="display:none;"></div> -->
	<div class="pop_bottom">
		<button class="btn fr" id="J_dialog_close" type="button">取消</button>
		<button type="submit" class="btn btn_submit J_ajax_submit_btn fr mr10">提交</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script type="text/javascript">
/*Wind.use('ajaxForm', function () {
	var submit_tips = $('#J_submit_tips');
	$('#J_link_add_form').ajaxForm({
		dataType	: 'json',
		success     : function(data){
			submit_tips.text(data.message).slideDown('fast');
				if (data.state === 'success') {
					setTimeout(function(){
						window.parent.location.href = window.parent.location.pathname + window.parent.location.search;
						window.parent.Wind.dialog.closeAll();
				}, 1500);
			}
		}
	});
});*/
</script>
</body>
</html>
