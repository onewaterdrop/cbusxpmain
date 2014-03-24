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
	
	
<!--添加模板-->

	<div class="nav">
		<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=', rawurlencode($isapi),'&m=design&c=module'; ?>">返回上一级</a></div>
		<ul class="cc">
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data'; ?>">显示数据</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data&a=push'; ?>">推送审核</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=property&a=edit'; ?>">属性</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=template&a=edit'; ?>">模板</a></li>
		</ul>
	</div>
	<div class="h_a">显示数据</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=data&a=batchEditData'; ?>" method="post">
	<div class="design_ct">
	
	<table class="pop_design_tablelist">
		<colgroup>
			<col width="40">
			<col>
			<col width="60">
			<col width="80">
			<col width="40">
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th>排序</th>
				<td>标题</td>
				<td>来源</td>
				<td>显示时间</td>
				<td>固定</td>
				<td>操作</td>
			</tr>
		</thead>
	<?php  
		$time = Pw::getTime();
		$i=1; foreach ($list as $v):
		//$isfuture = $v['start_time'] > $time ? true : false;
	?>
		<tr>
			
			<th>
			<?php  if ($v['is_reservation']): ?>
			<input type="text" class="input length_0" style="background-color: #dddddd" name="vieworder_reserv[<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($i, ENT_QUOTES, 'UTF-8');?>"  readonly>
			<?php  else: ?>
			<input type="text" class="input length_0" name="vieworder[<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($i, ENT_QUOTES, 'UTF-8');?>" >
			<input type="hidden" name="vieworder_tmp[<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($i, ENT_QUOTES, 'UTF-8');?>" >
			<?php  endif; ?>
			
			</th>
			<td><div class="subject">
			<?php  if ($v['is_reservation']): ?><span style="color:#ff0000">[预订]</span><?php  endif; 
  if ($v['is_edited']): ?><span style="color:#008800">[修改]</span><?php  endif; ?>
			<a href="<?php echo htmlspecialchars($v['url'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($v['title'], ENT_QUOTES, 'UTF-8');?></a></div></td>
			<td><?php  if($v['from_type'] == 1): ?> 推送<?php  elseif($v['from_type'] == 2): ?>手动添加 <?php  else: ?>自动获取<?php  endif; ?></td>
			<td><?php echo htmlspecialchars(Pw::time2str($v['start_time'], 'm-d H:i'), ENT_QUOTES, 'UTF-8');?></td>
			<td><input type="checkbox" name="isfixed[<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>]" value="1" <?php echo htmlspecialchars(Pw::ifcheck($v['data_type'] == 2), ENT_QUOTES, 'UTF-8');?>></td>
			<td>
				<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?dataid=', rawurlencode($v['data_id']),'&moduleid=', rawurlencode($v['module_id']),'&m=design&c=data&a=edit'; ?>" class="mr5 J_data_edit" data-id="<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>">[编辑]</a>
				<?php  if($v['from_type'] == 1): ?>
				<a class="J_design_data_ajax" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?dataid=', rawurlencode($v['data_id']),'&moduleid=', rawurlencode($v['module_id']),'&m=design&c=data&a=doshield'; ?>">[删除]</a>
				<?php  else: ?>
				<a class="J_design_data_ajax" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?dataid=', rawurlencode($v['data_id']),'&moduleid=', rawurlencode($v['module_id']),'&m=design&c=data&a=doshield'; ?>">[屏蔽]</a>
				<?php  endif; ?>
				<input type="hidden" name="dataid[]" value="<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
	<?php  
	if (!$v['is_reservation'])	$i++; 
	endforeach; ?>
	</table>
							
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" type="submit" >提交</button>
			<input type="hidden" name="moduleid" value="<?php echo htmlspecialchars($moduleid, ENT_QUOTES, 'UTF-8');?>">
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog', function(){
	//删除 屏蔽
	$('a.J_design_data_ajax').on('click',function(e) {
		e.preventDefault();
		var $this = $(this), href = $this.prop('href'), msg = ($this.text().indexOf('删除') > 0 ? '确定要删除本条吗？' : '确定要屏蔽本条吗？');
		var params = {
			message	: msg, 
			type	: 'confirm', 
			isMask	: false,
			follow	: $(this),//跟随触发事件的元素显示
			onOk	: function() {
				$.getJSON(href).done(function(data) {
					if(data.state === 'success') {
						if(data.referer) {
							location.href = data.referer;
						}else {
							reloadPage(window);
						}
					}else if( data.state === 'fail' ) {
						Wind.dialog.alert(data.message);
					}
				});
			}
		};
		Wind.dialog(params);
	});
});
</script>
</body>
</html>