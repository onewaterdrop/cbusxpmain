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
	<div class="h_a">搜索</div>
	<div class="search_type cc mb10">
		<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=tag'; ?>" method="post">
		<input type="hidden" name="page" value="<?php echo htmlspecialchars($page, ENT_QUOTES, 'UTF-8');?>">
		<label>标签名称：</label><input name="name" type="text" class="input length_2 mr10" value="<?php echo htmlspecialchars($args['name'], ENT_QUOTES, 'UTF-8');?>">
		<label>热门标签状态：</label><select name="ifhot" class="mr10">
			<option value="all" <?php echo htmlspecialchars(Pw::isSelected(!in_array($args['ifhot'], array('0', '1'))), ENT_QUOTES, 'UTF-8');?>>所有</option>
			<option value="1" <?php echo htmlspecialchars(Pw::isSelected($args['ifhot'] == '1'), ENT_QUOTES, 'UTF-8');?>>允许</option>
			<option value="0" <?php echo htmlspecialchars(Pw::isSelected($args['ifhot'] == '0'), ENT_QUOTES, 'UTF-8');?>>不允许</option>
		</select>
		<label>使用人数：</label><input name="min_count" type="text" class="input length_1 mr10" value="<?php echo htmlspecialchars($args['min_count'], ENT_QUOTES, 'UTF-8');?>"><span class="mr10">-</span><input name="max_count" type="text" class="input length_1 mr10" value="<?php echo htmlspecialchars($args['max_count'], ENT_QUOTES, 'UTF-8');?>">
		<button type="submit" class="btn">搜索</button>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
	<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=tag&a=delete'; ?>" method="post" class="J_ajaxForm">
	<div class="table_list">
		<table width="100%">
			<thead>
				<tr>
					<td width="60"><input type="checkbox" name="checkAll" class="J_check_all" data-direction="y" data-checklist="J_check_user_y" value="">全选</td>
					<td width="180">标签名称</td>
					<td width="50">使用人数</td>
					<td>热门标签状态</td>
				</tr>
			</thead>
<?php  if ($list) { 
 foreach ($list as $key => $item) {
	$ifhot = $item['ifhot'] ? '允许' : '不允许';
?>
			<tr>
				<td><input class="J_check J_uid" data-yid="J_check_user_y" data-xid="J_check_user_x" type="checkbox" name="ids[]" value="<?php echo htmlspecialchars($item['tag_id'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($item['name'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($item['used_count'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($ifhot, ENT_QUOTES, 'UTF-8');?></td>
			</tr>
<?php }
  } else { ?>
	<tbody>
		<tr><td colspan="7" class="tac">啊哦，没有符合条件的内容！</td></tr>
	</tbody>
<?php  } ?>
		</table>
	</div>
	<?php  if ($list) { ?>
	<div class="p10">
		<?php $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perpage;
$__tplPageTotal=(int)0;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=u&c=tag'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
	</div>
	<div class="btn_wrap">
	 <div class="btn_wrap_pd">
		<label class="mr20"><input type="checkbox" name="checkAll" value="" class="J_check_all" data-direction="x" data-checklist="J_check_user_x">全选</label>
		<button class="btn btn_submit J_ajax_submit_btn" type="submit">删除标签</button>
		<button data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=tag&a=setHot'; ?>" type="submit" class="btn mr10 J_ajax_submit_btn">允许为热门标签</button>
		<button data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=tag&a=cancleHot'; ?>" type="submit" class="btn mr10 J_ajax_submit_btn">不允许为热门标签</button>
		<span id="J_user_tip" style="display:none;" class="tips_error"></span>
	 </div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>