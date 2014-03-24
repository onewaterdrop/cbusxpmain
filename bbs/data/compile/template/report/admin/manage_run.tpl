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
		<?php  $ifcheck = $args['ifcheck'] ? 'class=current' : '';
			$noifcheck = !$args['ifcheck'] ? 'class=current' : '';
		?>
			<li <?php echo htmlspecialchars($noifcheck, ENT_QUOTES, 'UTF-8');?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=report&c=manage'; ?>">未处理</a></li>
			<li <?php echo htmlspecialchars($ifcheck, ENT_QUOTES, 'UTF-8');?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?ifcheck=1&m=report&c=manage'; ?>">已处理</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=report&c=manage&a=receiverlist'; ?>">举报提醒</a></li>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>帖子内容管理请前往前台帖子页或者后台<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article'; ?>">内容-->帖子管理</a>中处理；消息内容请前往<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=message&c=manage'; ?>">内容-->消息管理</a>中处理。</li>
			<li>标记已处理：标记后系统会发送消息反馈给举报的用户。</li>
			<li>忽略：忽略该条举报，不对举报者和被举报者产生影响。</li>
		</ol>
	</div>
	<div class="mb10">举报列表：
	<select id="J_report_filter" name="type">
		<option value="" href="" data-check="<?php echo htmlspecialchars($args['ifcheck'], ENT_QUOTES, 'UTF-8');?>">全部</option>
		<?php  foreach ($reportTypes as $k => $v) { 
		$selected = ($args['type'] == $k) ? 'selected=selected' : '';
		?>
		<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" data-check="<?php echo htmlspecialchars($args['ifcheck'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($selected, ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></option>
		<?php  } ?>
		</select>
	</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=report&c=manage&a=dealCheck'; ?>" method="post" >
	<?php  if ($reports) { ?>
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<?php  if (!$args['ifcheck']) { ?>
				<col width="65">
				<?php  } ?>
				<col width="55">
				<col width="250">
				<col width="100">
				<col width="120">
				<col width="100">
				<col>
				<col width="130">
			</colgroup>
			<thead>
				<tr>
				<?php  if (!$args['ifcheck']) { ?>
					<td><label><input class="J_check_all" data-direction="y" data-checklist="J_check_y" type="checkbox">全选</label></td>
				<?php  } ?>
					<td>类型</td>
					<td>内容</td>
					<td>作者</td>
					<td>举报时间</td>
					<td>举报者</td>
					<td>举报理由</td>
					<td>操作</td>
				</tr>
			</thead>
			<?php  foreach ($reports as $v) { 
			$v['content'] = Pw::substrs(Pw::stripWindCode($v['content']), 20);
			$created_username = $v['created_username'] ? '<a href="'.WindUrlHelper::createUrl('space/index/run?uid='.$v['created_userid'],array(),'','pw').'" target="_blank">'.$v['created_username'].'</a>' : '游客';
			$v['author_username'] = $v['author_username'] ? $v['author_username'] : '游客';
			?>
			<tr>
				<?php  if (!$args['ifcheck']) { ?>
				<td><input class="J_check" data-yid="J_check_y" data-xid="J_check_x" type="checkbox" name="id[]" value="<?php echo htmlspecialchars($v['id'], ENT_QUOTES, 'UTF-8');?>"></td>
				<?php  } ?>
				<td><?php echo htmlspecialchars($reportTypes[$v['type']], ENT_QUOTES, 'UTF-8');?></td>
				<td>
				<?php  if ($v['content_url']) { ?>
				<a href="<?php echo htmlspecialchars($v['content_url'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($v['content'], ENT_QUOTES, 'UTF-8');?></a>
				<?php  } else { 
 echo htmlspecialchars($v['content'], ENT_QUOTES, 'UTF-8');
  } ?>
				</td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($v['author_userid']); ?>" target="_blank"><?php echo htmlspecialchars($v['author_username'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo htmlspecialchars(Pw::time2str($v['created_time']), ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo $created_username;?></td>
				<td><?php echo htmlspecialchars($v['reason'], ENT_QUOTES, 'UTF-8');?></td>
				<?php  if (!$args['ifcheck']) { ?>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($v['id']),'&m=report&c=manage&a=dealCheck'; ?>" class="mr5 J_ajax_refresh">[标记已处理]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($v['id']),'&m=report&c=manage&a=delete'; ?>" class="J_ajax_refresh">[忽略]</a></td>
				<?php  } else { ?>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($v['operate_userid']); ?>" target="_blank"><?php echo htmlspecialchars($v['operate_username'], ENT_QUOTES, 'UTF-8');?></a> 已处理</td>
				<?php  } ?>
			</tr>
			<?php  } ?>
		</table>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=report&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
		</div>
	</div>
	<?php  if (!$args['ifcheck']) { ?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<label class="mr20"><input class="J_check_all" data-direction="x" data-checklist="J_check_x" type="checkbox">全选</label>
			<button class="btn btn_submit J_ajax_submit_btn" data-subcheck="true" type="submit">标记已处理</button>
			<button class="btn J_ajax_submit_btn" data-subcheck="true" type="submit" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=report&c=manage&a=delete'; ?>">忽略</button>
		</div>
	</div>
	<?php  } 
  } else { ?>
	<div class="tac"> 啊哦，没有符合条件的内容！</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	//筛选
	$('#J_report_filter').on('change', function(){
		var sel_option = $(this).find('option:selected');
		window.location.href = '<?php echo Wekit::app()->baseUrl,'/','admin.php?ifcheck=&m=report&c=manage'; ?>&type=' +sel_option.val() + '&ifcheck=' +sel_option.data('check');
	});
});
</script>
</body>
</html>