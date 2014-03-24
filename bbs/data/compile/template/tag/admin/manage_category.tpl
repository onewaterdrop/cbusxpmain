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
	<div class="nav">
		<ul class="cc">
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage'; ?>">话题管理</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=category'; ?>">话题分类</a></li>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>可以将话题归类，方便用户按分类查看。</li>
			<li>分类别名使用英文字符，设置后分类页面的URL可以显示英文名称。</li>
		</ul>
	</div>
	<form class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=setCategory'; ?>" method="post">
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="65">
			</colgroup>
			<thead>
				<tr>
					<td>顺序</td>
					<td>分类名称</td>
					<td>分类别名</td>
					<td>话题数</td>
					<td>操作</td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="5"><a href="" id="J_cate_add" class="link_add">添加分类</a></td>
				</tr>
			</tfoot>
			<!-- <tr>
				<td><input type="number" class="input length_1" name="data[<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>][vieworder]" value="<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input type="text" class="input length_3" name="data[{$value['category_name'category_name" value="<?php echo htmlspecialchars($value['category_name'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input type="text" class="input length_3" name="data[{$value['alias'alias" value="<?php echo htmlspecialchars($value['alias'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($value['tagcount'], ENT_QUOTES, 'UTF-8');?></td>
				<td></td>
			</tr> -->
			<tbody id="J_cate_list">
			<?php  foreach ($categorys as $value) { 
				$category = $value['alias'] ? $value['alias'] : $value['category_id'];
			?>
				<tr>
					<input type="hidden" name="data[<?php echo htmlspecialchars($value['category_id'], ENT_QUOTES, 'UTF-8');?>][category_id]" value="<?php echo htmlspecialchars($value['category_id'], ENT_QUOTES, 'UTF-8');?>">
					<td><input type="number" class="input length_1 J_cate_order" name="data[<?php echo htmlspecialchars($value['category_id'], ENT_QUOTES, 'UTF-8');?>][vieworder]" value="<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><input type="text" class="input length_3" name="data[<?php echo htmlspecialchars($value['category_id'], ENT_QUOTES, 'UTF-8');?>][category_name]" value="<?php echo htmlspecialchars($value['category_name'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><input type="text" class="input length_3" name="data[<?php echo htmlspecialchars($value['category_id'], ENT_QUOTES, 'UTF-8');?>][alias]" value="<?php echo htmlspecialchars($value['alias'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><?php echo htmlspecialchars($value['tag_count'], ENT_QUOTES, 'UTF-8');?></td>
					<td><!-- a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=tag&categoryid=', rawurlencode($value['category_id']); ?>" class="mr5" target="_blank">[访问]</a--><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($value['category_id']),'&m=tag&c=manage&a=editCategory'; ?>" title="分类编辑" class="mr5 J_dialog">[编辑]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?categoryId=', rawurlencode($value['category_id']),'&m=tag&c=manage'; ?>" class="mr5">[话题管理]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($value['category_id']),'&m=tag&c=manage&a=deleteCategory'; ?>" class="J_ajax_del">[删除]</a></td>
				</tr>
			<?php  } ?>
			</tbody>
			</tbody>
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
	var cate_list = $('#J_cate_list');
	
	//添加分类
	$('#J_cate_add').on('click', function(e){
		e.preventDefault();
		var lastid = $('#J_cate_list > tr').last().find('input.J_cate_order').val();
		if(!lastid) {
			lastid = 0;
		}
		lastid++;

		cate_list.append('<tr class="J_cate_add_tr">\
				<td><input type="number" class="input length_1 J_cate_order" name="newdata['+ lastid +'][vieworder]" value="'+ lastid +'"></td>\
				<td><input type="text" class="input length_3" name="newdata['+ lastid +'][category_name]" value=""></td>\
				<td><input type="text" class="input length_3" name="newdata['+ lastid +'][alias]"></td>\
				<td>0</td>\
				<td><a href="#" class="J_cate_add_del">[删除]</a></td>\
	</tr>');
	});
	
	//删除未保存项
	cate_list.on('click', 'a.J_cate_add_del', function(e){
		e.preventDefault();
		$(this).parents('tr').remove();
	});
	
});
</script>
</body>
</html>

