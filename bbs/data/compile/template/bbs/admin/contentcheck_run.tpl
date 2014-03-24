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
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=contentcheck'; ?>">主题审核</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=contentcheck&a=reply'; ?>">回复审核</a></li>
		</ul>
	</div>
	
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>当版块功能设置中开启 "审核主题" 功能时，只有管理员审核通过状态的帖子才会在前台正常显示</li>
		</ol>
	</div>
	<div class="h_a">搜索</div>
	<form method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=contentcheck'; ?>">
	<div class="search_type cc mb10">
		<label>作者：</label><input name="author" value="<?php echo htmlspecialchars($args['author'], ENT_QUOTES, 'UTF-8');?>" type="text" class="input length_2 mr10">
		<label>所属版块：</label><select name="fid" class="select_3 mr10"><option value="0">所有版块</option><?php echo $option_html;?></select>
		<label>发帖时间：</label><input name="created_time_start" type="text" class="input length_2 mr5 J_date"><span class="mr5">至</span><input name="created_time_end" type="text" class="input length_2 J_date mr10">
		<button class="btn">搜索</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=contentcheck&a=doPassThread'; ?>" method="post">
		<?php  if ($threadb) { ?>
		<div class="h_a"><!--label><input type="checkbox" class="J_check_all" data-direction="x" data-checklist="J_check_x">全选</label-->列表</div>
		<div class="table_list">
			<table width="100%">
				<?php  foreach ($threadb as $key => $value) { ?>
				<tr>
					<td width="10"><input type="checkbox" name="tid[]" value="<?php echo htmlspecialchars($value['tid'], ENT_QUOTES, 'UTF-8');?>" class="J_check" data-yid="J_check_y" data-xid="J_check_x"></td>
					<td width="600">
						<div class="mb5">
							<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=thread&fid=', rawurlencode($value['fid']); ?>" class="mr5" target="_blank">[<?php echo $forumlist[$value['fid']]['name'];?>]</a><a href="<?php echo Wekit::app()->baseUrl,'/','read.php?tid=', rawurlencode($value['tid']),'&fid=', rawurlencode($value['fid']); ?>" target="_blank"><?php echo htmlspecialchars($value['subject'], ENT_QUOTES, 'UTF-8');?></a>
						</div>
						<div class="mb5">
							作者：<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($value['created_userid']); ?>" target="_blank" class="mr15"><?php echo htmlspecialchars($value['created_username'], ENT_QUOTES, 'UTF-8');?></a>发帖时间：<?php echo htmlspecialchars(Pw::time2str($value['created_time']), ENT_QUOTES, 'UTF-8');?>
						</div>
						<div class="p10" style="line-height:1.5;border:1px solid #ccc;background:#fff;max-height:140px;_height:60px;overflow-y:auto;"><?php echo htmlspecialchars($value['content'], ENT_QUOTES, 'UTF-8');?>
						</div>
					</td>
					<td>
						<ul class="single_list cc">
							<li><a class="J_ajax_refresh mr5" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?tid=', rawurlencode($value['tid']),'&m=bbs&c=contentcheck&a=doPassThread'; ?>">[通过]</a></li>
							<li><a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?tid=', rawurlencode($value['tid']),'&m=bbs&c=contentcheck&a=doDeleteThread'; ?>">[删除]</a></li>
						</ul>
					</td>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=contentcheck'; 
 echo htmlspecialchars($url ? '&' . http_build_query($url) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
			</div>
		</div>
		<div class="btn_wrap">
			<div class="btn_wrap_pd">
				<label class="mr20"><input type="checkbox" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label>
		<button class="btn btn_submit J_ajax_submit_btn" type="submit">通过</button>
				<button class="btn J_ajax_submit_btn" type="submit" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=contentcheck&a=doDeleteThread'; ?>">删除</button>
			</div>
		</div>
		<?php  } else { ?>
			<div class="tac"> 啊哦，没有符合条件的内容！</div>
		<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>