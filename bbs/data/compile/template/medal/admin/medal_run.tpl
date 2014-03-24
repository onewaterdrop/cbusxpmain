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
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal'; ?>">勋章管理</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal&a=award'; ?>">勋章颁发</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal&a=approval'; ?>">勋章审核</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal&a=set'; ?>">勋章设置</a></li>
		</ul>
	</div>
	<div class="mb10"><a title="添加勋章" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal&a=add'; ?>" class="btn J_dialog"><span class="add"></span>添加勋章</a></div>
	<form class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=medal&c=medal&a=dorun'; ?>" method="post">
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="45">
				<col width="120">
				<col width="70">
				<col width="265">
				<col width="80">
				<col width="70">
			</colgroup>
			<thead>
				<tr>
					<td>顺序</td>
					<td>勋章名称</td>
					<td>勋章图标</td>
					<td>勋章说明</td>
					<td>发放机制</td>
					<td><label><input class="J_check_all" data-direction="x" data-checklist="J_check_x" type="checkbox">启用</label></td>
					<td>操作</td>
				</tr>
			</thead>
		<?php  foreach ($medalList as $medal):
				$type = ($medal['receive_type']==1) ? '自动颁发' : '手动颁发';?>
			<tr>
				<td><input type="nember" class="input length_0" name="orderid[<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($medal['vieworder'], ENT_QUOTES, 'UTF-8');?>" /></td>
				<td><input type="text" class="input length_2"  name="name[<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></td>
				<td><img src="<?php echo htmlspecialchars($medal['medalImage'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" /></td>
				<td><input type="text" class="input length_4" name="descrip[<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>]"  value="<?php echo htmlspecialchars($medal['descrip'], ENT_QUOTES, 'UTF-8');?>" /></td>
				<td><?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?></td>
				<td>
					<input class="J_check" data-yid="J_check_y" data-xid="J_check_x" type="checkbox" name="isopen[<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>]" <?php echo htmlspecialchars(Pw::ifcheck($medal['isopen']), ENT_QUOTES, 'UTF-8');?> value='1'/>
					<input type="hidden" name="medalid[<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>"/>
				</td>
				<td><a title="编辑勋章" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($medal['medal_id']),'&m=medal&c=medal&a=edit'; ?>" class="mr5 J_dialog">[编辑]</a>
					<?php  if($medal['medal_type'] != 1): ?>
					<a class="J_ajax_del" data-msg="确定要删除此勋章？" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($medal['medal_id']),'&m=medal&c=medal&a=doDel'; ?>">[删除]</a>
					<?php  endif; ?>
				</td>
			</tr>
		<?php  endforeach; ?>
		</table>
		<div class="p10"><?php $__tplPageCount=(int)$count;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=medal&c=medal'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?></div>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<!--label class="mr20"><input class="J_check_all" data-direction="y" data-checklist="J_check_y" type="checkbox" />启用</label-->
			<button class="btn btn_submit J_ajax_submit_btn" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>