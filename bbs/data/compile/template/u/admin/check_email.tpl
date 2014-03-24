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
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=check'; ?>">注册审核</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=check&a=email'; ?>">邮件审核</a></li>
		</ul>
	</div>
	<div class="h_a">提示信息</div>
	<div class="mb10 prompt_text">
		<ul>
			<li>如果<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=config&c=regist'; ?>">【注册设置】</a>中开启了“新用户邮件激活”，用户由于种种原因无法通过电子邮件激活帐号，管理员可使用此功能激活用户帐号</li>
		</ul>
	</div>
	<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=check&a=doactive'; ?>" method="post" class="J_ajaxForm">
	<div class="table_list">
		<table width="100%">
			<thead>
				<tr>
					<td width="50"><input type="checkbox" name="checkAll" value="" class="J_check_all" data-direction="y" data-checklist="J_check_email_y">全选</td>
					<td width="30">UID</td>
					<td>用户名</td>
					<td>注册时间</td>
					<td>电子邮箱</td>
				</tr>
			</thead>
<?php foreach ($list as $key => $item) {?>
			<tr>
				<td><input class="J_check J_uid" data-yid="J_check_email_y" data-xid="J_check_email_x" type="checkbox" name="uid[]" value="<?php echo htmlspecialchars($item['uid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($item['uid'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($item['username'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars(Pw::time2str($item['regdate'], 'Y-m-d H:i:s'), ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($item['email'], ENT_QUOTES, 'UTF-8');?></td>
			</tr>
<?php }?>
		</table>
	</div>
	<div class="btn_wrap">
	 <div class="btn_wrap_pd">
	 	<div class="select_pages">
	 		<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=20&m=u&c=check&a=email'; ?>">20</a><span>|</span>
	 		<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=50&m=u&c=check&a=email'; ?>">50</a><span>|</span>
	 		<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=100&m=u&c=check&a=email'; ?>">100</a>
	 	</div>
		<label class="mr20"><input type="checkbox" name="checkAll" value="" class="J_check_all" data-direction="x" data-checklist="J_check_email_x">全选</label><button class="btn btn_submit J_ajax_submit_btn" type="submit">通过</button><button type="submit" class="btn mr10 J_ajax_submit_btn" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=check&a=delete'; ?>">忽略</button><span id="J_email_tip" style="display:none;" class="tips_error"></span>
	 </div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?perpage=', rawurlencode($perpage),'&page=', rawurlencode($_page_i),'&m=u&c=check&a=email'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>