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
	

<!--==============================链接审核================================-->
	<form method="post" class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doCheck'; ?>">
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="70">
				<col width="60">
				<col>
				<col>
				<col width="110">
			</colgroup>
			<thead>
				<tr>
					<td><label><input class="J_check_all" data-direction="y" data-checklist="J_check_y" type="checkbox">全部</label></td>
					<td>顺序</td>
					<td>站点名称</td>
					<td>站点地址</td>
					<td>站点logo</td>
					<td>分类</td>
					<td>操作</td>
				</tr>
			</thead>
			<?php  if ($links) { 
  foreach ($links as $key => $value) { ?>
			<tr>
				<td><input class="J_check" data-xid="J_check_x" data-yid="J_check_y" type="checkbox" name="lid[]" value="<?php echo htmlspecialchars($value['lid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input class="input length_0 J_link_vieworder" type="text" name="data[<?php echo htmlspecialchars($value['lid'], ENT_QUOTES, 'UTF-8');?>][vieworder]" value="<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($value['name'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($value['url'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($value['logo'], ENT_QUOTES, 'UTF-8');?></td>
				<td>
					<div data-id="<?php echo htmlspecialchars($value['lid'], ENT_QUOTES, 'UTF-8');?>" class="cate_link_down J_link_cata"></div>
					<div class="core_menu J_menu_drop" style="display:none;margin-top:18px;">
						<ul class="core_menu_list cc">
							<?php  foreach ($typesList as $k => $v) { ?>
							<li><label><input class="J_cate_check" data-text="<?php echo htmlspecialchars($v['typename'], ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="data[<?php echo htmlspecialchars($value['lid'], ENT_QUOTES, 'UTF-8');?>][typeid][]" value="<?php echo htmlspecialchars($v['typeid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::ifcheck(in_array($v['typeid'], $value['typeids'])), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v['typename'], ENT_QUOTES, 'UTF-8');?></label></li>
							<?php  } ?>
						</ul>
					</div>
					<div class="cate_link J_cate_link">
					<?php  foreach ($value['typeids'] as $typeid) { ?>
					<span><?php echo htmlspecialchars($typesList[$typeid]['typename'], ENT_QUOTES, 'UTF-8');?></span>
					<?php  } ?></div>
				</td>
				<td><a class="J_check_pass mr10" data-lid="<?php echo htmlspecialchars($value['lid'], ENT_QUOTES, 'UTF-8');?>" href="">[通过]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?lid=', rawurlencode($value['lid']),'&m=link&c=link&a=doDelete'; ?>" class="mr10 J_ajax_del" data-msg="确定要拒绝此友情链接申请吗？">[拒绝]</a></td>
			</tr>
			<?php  } 
  } else { ?>
				<tr><td colspan="7" class="tac">啊哦，暂无内容！</td></tr>
			<?php  } ?>
		</table>
	</div>
	<?php  if ($links) { ?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<label class="mr20"><input class="J_check_all" data-direction="x" data-checklist="J_check_x" type="checkbox">全选</label>
			<button class="btn btn_submit J_ajax_submit_btn" type="submit">通过</button><button type="button" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doDelete'; ?>" class="btn J_ajax_submit_btn">拒绝</button>
		</div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script type="text/javascript">
Wind.use('dialog',function() {

	//分类显示&隐藏
	$('div.J_link_cata').on('mouseenter', function(){
		$(this).siblings('.J_menu_drop').show();
	}).on('mouseleave', function(e){
		var $this = $(this);
		if(!$(e.relatedTarget).is($('div.J_menu_drop, div.J_menu_drop *'))) {
			$(this).siblings('.J_menu_drop').hide();
		}
	});
	
	$('div.J_menu_drop').on('mouseleave', function(e){
		$(this).hide();
	});
	
	
	//分类列表选择
	$('input.J_cate_check').on('change', function(e){
		var $this = $(this), cate_list = $this.parents('div.J_menu_drop').siblings('div.J_cate_link');
		if($this.attr('checked')) {
			cate_list.append('<span class="J_cate_item_'+ $this.val() +'">'+ $this.data('text') +'</span>')
		}else{
			cate_list.find('span.J_cate_item_'+ $this.val()).remove();
		}
	});
	
	
	//点击单个通过
	$('a.J_check_pass').on('click', function(e){
		e.preventDefault();
		var $this = $(this),
			tr = $this.parents('tr'),
			order = tr.find('input.J_link_vieworder').val(), //顺序
			cates = tr.find('div.J_menu_drop input.J_cate_check:checked'),
			cates_arr = [],
			lid = $this.data('lid');
			
		//分类数组
		$.each(cates, function(i, o){
			cates_arr.push($(this).val());
		});
		
		$.ajax({
			url			: "<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doCheck'; ?>",
			type		: 'post',
			dataType	: 'json',
			data		: '&signle=1&lid[]='+lid+'&data['+lid+'][vieworder]='+order+'&data['+lid+'][typeid]='+cates_arr+'&csrf_token='+GV.TOKEN,
			success : function(data){
				if(data.state === 'success') {
					var location = window.location;
					location.href = location.pathname + location.search;
				}else{
					Wind.dialog.alert(data.message);
				}
			}
		})

	});
	
	//批量拒绝
	$('#J_link_del_all').on('click', function(e){
		e.preventDefault();
		if(!$('input.J_check:checked').length) {
			Wind.dialog.alert('请至少选定至一条友情链接');
			return;
		}
		Wind.dialog({
			message	: '确定要拒绝选中的友情链接申请吗？', 
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
