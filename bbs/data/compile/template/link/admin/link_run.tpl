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
	<li class="<?php echo htmlspecialchars($tabs['run'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link'; ?>">链接列表</a></li>
	<li class="<?php echo htmlspecialchars($tabs['editTypes'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=types'; ?>">链接分类</a></li>
	<li class="<?php echo htmlspecialchars($tabs['check'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=check'; ?>">链接审核</a></li>
	</ul>
</div>
	

<!--==============================链接列表================================-->
	<div class="mb10">
		<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=add'; ?>" class="btn J_dialog" title="添加友情链接"><span class="add"></span>添加友情链接</a>
	</div>
	<form class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=dorun'; ?>" method="post">
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="80">
				<col width="60">
				<col width="120">
				<col>
				<col>
				<col width="200">
				<col width="100">
			</colgroup>
			<thead>
				<tr>
					<td><label><input type="checkbox" name="checkAll" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label></td>
					<td>顺序</td>
					<td>站点名称</td>
					<td>站点地址</td>
					<td>站点logo</td>
					<td><select id="J_link_types">
					<option value="">全部分类</option>
					<?php  foreach ($typesList as $v) { ?>
					<option value="<?php echo htmlspecialchars($v['typeid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($typeid == $v['typeid']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v['typename'], ENT_QUOTES, 'UTF-8');?></option>
					<?php  } ?>
					</select></td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="J_link_tr">
			<?php  if ($links) { 
  foreach ($links as $v) { ?>
			<tr>
				<td><input class="J_check" data-xid="J_check_x" data-yid="J_check_y" type="checkbox" name="lid[]" value="<?php echo htmlspecialchars($v['lid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input class="input length_0" type="text" name="vieworder[<?php echo htmlspecialchars($v['lid'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($v['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($v['url'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($v['logo'], ENT_QUOTES, 'UTF-8');?></td>
				<td><div class="cate_link">
					<?php  foreach ($v['typeid'] as $lid) { ?>
					<span class="J_link_<?php echo htmlspecialchars($typesList[$lid]['typeid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($typesList[$lid]['typename'], ENT_QUOTES, 'UTF-8');?></span>
					<?php  } ?>
				</div></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?lid=', rawurlencode($v['lid']),'&m=link&c=link&a=edit'; ?>" title="编辑友情链接" class="mr10 J_dialog">[编辑]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?lid=', rawurlencode($v['lid']),'&m=link&c=link&a=doDelete'; ?>" class="mr10 J_ajax_del">[删除]</a></td>
			</tr>
			<?php  } 
  } else { ?>
				<tr><td colspan="7" class="tac">啊哦，暂无内容！</td></tr>
			<?php  } ?>
			</tbody>
		</table>
	</div>
	<?php  if ($list) { ?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<label class="mr20"><input type="checkbox" name="checkAll" class="J_check_all" data-direction="x" data-checklist="J_check_x">全选</label>
			<button class="btn btn_submit J_ajax_submit_btn" type="submit">提交</button>
			<button type="button" id="J_link_del_all" class="btn">删除</button>
		</div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script type="text/javascript">
Wind.use('dialog',function() {

	//分类筛选

	var link_tr = $('#J_link_tr > tr'),
		link_types = $('#J_link_types');
	link_types.on('change', function(){
		linkFilter(this.value);
	});

	//页面载入筛选
	if(link_types.val()) {
		console.log(link_types.val())
		linkFilter(link_types.val());
	}

	function linkFilter(v){
		link_tr.hide();
		if(v) {
			$('.J_link_'+ v).parents('tr').show();
		}else{
			link_tr.show();
		}
	}
	
	
	//批量删除
	$('#J_link_del_all').on('click', function(e){
		e.preventDefault();
		if(!$('input.J_check:checked').length) {
			Wind.dialog.alert('请至少选定至一条友情链接');
			return;
		}
		Wind.dialog({
			message	: '确定删除选定的友情链接？', 
			type	: 'confirm',
			onOk	: function() {
				$('form.J_ajaxForm').ajaxSubmit({
					dataType : 'json',
					url		 : '<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doDelete'; ?>',
					success	 : function(data, statusText, xhr, $form) {
						if(data.state === 'success') {
							var location = window.location;
							location.href = location.pathname + location.search;
						}else{
							Wind.dialog.alert(data.message);
						}
					}
				});
			}
		});
		
	});
});
</script>
</body>
</html>
