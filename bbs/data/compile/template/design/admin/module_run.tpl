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
<?php  
	$api = $run = '';
	if ($isapi == 'api'){
		$api = 'current';
	}else{
		$run = 'current';
	}
?>
<div class="wrap">
	<div class="nav">
		<ul class="cc">
			<li class="<?php echo htmlspecialchars($run, ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=module'; ?>">模块管理</a></li>
			<li class="<?php echo htmlspecialchars($api, ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=api&m=design&c=module'; ?>">调用管理</a></li>
		</ul>
	</div>
	<div class="h_a">搜索</div>
	<form method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=module'; ?>">
	<div class="search_type cc mb10">
		<div class="mb10">
		<span class="mr20">ID：<input type="text" class="input length_2" name="moduleid" value="<?php echo htmlspecialchars($args['moduleid'], ENT_QUOTES, 'UTF-8');?>"></span>
		<span class="mr20">模块名称：<input type="text" class="input length_2" name="name" value="<?php echo htmlspecialchars($args['name'], ENT_QUOTES, 'UTF-8');?>"></span>
		<!-- <span class="mr20">所属页面：
			<select class="select_2" name="pagename">
				<option value="">不限制</option>
			</select>
		</span> -->
		<span class="mr20">数据分类：
			<select class="select_2" name="model">
				<option  value="">不限制</option>
				<?php  foreach ($models as $k=>$model): ?>
				<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($k == $args['model']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($model['name'], ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
			</select>
		</span>
		<button class="btn">搜索</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="70">
				<col width="200">
				<col width="200">
				<col width="90">
			</colgroup>
			<thead>
				<tr>
					<td>ID</td>
					<td>模块名称</td>
					<td>所属页面</td>
					<td>数据分类</td>
					<td>操作</td>
				</tr>
			</thead>
		<?php  if ($list) { 
  foreach ($list as $v): ?>
			<tr>
				<td><?php echo htmlspecialchars($v['module_id'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($v['module_name'], ENT_QUOTES, 'UTF-8');?></td>
				<td>
					<?php echo htmlspecialchars($v['pageInfo']['page_name'], ENT_QUOTES, 'UTF-8');?>
				</td>
				<td><?php echo htmlspecialchars($models[$v['model_flag']]['name'], ENT_QUOTES, 'UTF-8');?></td>

				<td>
				<?php  if ($v['isdata']): ?>
					<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=data'; ?>" class="mr10">[管理]</a>
				<?php  else: ?>
					<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=property&a=edit'; ?>" class="mr10">[管理]</a>
				<?php  endif; ?>
					<!--a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=data'; ?>" class="mr10">[数据]</a-->
					<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=permissions&a=module'; ?>" class="mr10">[权限管理]</a>
					<!-- <a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=module&a=script'; ?>"  class="mr10">[调用代码]</a> -->
					<!--a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($v['module_id']),'&m=design&c=module&a=delete'; ?>" class="mr10">[删除]</a-->
				</td>
			</tr>
		<?php  endforeach; 
  } else { ?>
			<tr><td colspan="7" class="tac">啊哦，没有符合条件的内容！</td></tr>
		<?php  } ?>
		</table>
	</div>
	<div class="mb20"><?php $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perpage;
$__tplPageTotal=(int)$totalpage;
$__tplPageCurrent=(int)$page;
if($__tplPageCount > 0 && $__tplPagePer > 0){
$__tmp = ceil($__tplPageCount / $__tplPagePer);
($__tplPageTotal !== 0 &&  $__tplPageTotal < $__tmp) || $__tplPageTotal = $__tmp;}
$__tplPageCurrent > $__tplPageTotal && $__tplPageCurrent = $__tplPageTotal;
if ($__tplPageTotal > 1) {
 
$_page_min = max(1, $__tplPageCurrent-3);
$_page_max = min($__tplPageTotal, $__tplPageCurrent+3);
?>
<div class="pages">
<?php  if ($__tplPageCurrent > $_page_min) { 
	$_page_i = $__tplPageCurrent-1;
?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=module'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?></div>
	<form class="J_ajaxForm"  action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=module&a=clear'; ?>" method="post">
	<div class="btn_wrap">
		<div class="btn_wrap_pd"><button class="btn J_ajax_submit_btn" type="submit">清空未使用模块</button></div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>