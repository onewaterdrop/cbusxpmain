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
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article'; ?>">帖子管理</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article&a=replylist'; ?>">回复管理</a></li>
		</ul>
	</div>
	
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>删除符合条件的帖子用于清理站点冗余数据，此操作不可恢复，请谨慎使用。</li>
			<li>删除主题功能可删除某个会员发布的所有主题(包括回复)，删除回复功能可删除某个会员发表的所有回复。</li>
			<li>搜索支持通配符“*”，多个用户名之间用英文半角逗号","分割。</li>
		</ol>
	</div>
	<div class="h_a">搜索</div>
	<form method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article&a=searchreply'; ?>">
	<div class="search_type cc mb10">
		<label>关键字：</label><input type="text" name="keyword" value="<?php echo htmlspecialchars($args['keyword'], ENT_QUOTES, 'UTF-8');?>" class="input length_3 mr10" placeholder="支持帖子标题和正文搜索">
		<label>作者：</label><input type="text" name="created_username" value="<?php echo htmlspecialchars($args['created_username'], ENT_QUOTES, 'UTF-8');?>" class="input length_2 mr10">
		<label>所属版块：</label><select name="fid" class="select_3 mr10"><option value="0">所有版块</option><?php echo $option_html;?></select>
		<button class="btn mr20" type="submit">搜索</button><a class="w J_dialog" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article&a=replyadvanced'; ?>" title="高级搜索">高级搜索</a>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=article&a=deletereply'; ?>" method="post">
	<div class="table_list">
		<table width="100%">
			<?php  if ($posts) { ?>
			<colgroup>
				<col width="60">
				<col width="300">
			</colgroup>
			<thead>
				<tr>
					<td><label><input type="checkbox" class="J_check_all" data-direction="x" data-checklist="J_check_x">全选</label></td>
					<td>内容</td>
					<td>作者</td>
					<td>IP</td>
					<td>版块</td>
					<td><span>发帖时间</span></td>
				</tr>
			</thead>
			<?php  foreach ($posts as $v) { 
			$v['created_time'] = Pw::time2str($v['created_time']);
			$v['content'] = Pw::substrs($v['content'], 20);
			$_forumSubject = strip_tags($forumList[$v['fid']]['name']);
			?>
			<tr>
				<td><input type="checkbox" class="J_check" data-yid="J_check_y" data-xid="J_check_x" name="pids[]" value="<?php echo htmlspecialchars($v['pid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','read.php?tid=', rawurlencode($v['tid']),'&fid=', rawurlencode($v['fid']); ?>#<?php echo htmlspecialchars($v['pid'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($v['content'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($v['created_userid']); ?>" target="_blank"><?php echo htmlspecialchars($v['created_username'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo htmlspecialchars($v['created_ip'], ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=thread&fid=', rawurlencode($v['fid']); ?>" target="_blank"><?php echo htmlspecialchars($_forumSubject, ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo htmlspecialchars($v['created_time'], ENT_QUOTES, 'UTF-8');?></td>
			</tr>
			<?php  } 
  } else { ?>
				<tbody>
					<tr><td class="tac">啊哦，没有符合条件的内容！</td></tr>
				</tbody>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=bbs&c=article&a=searchreply'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
		</div>
	</div>
	<?php  if ($posts) { ?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<div class="select_pages">
				<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('bbs/article/searchreply?perpage=20', $args), ENT_QUOTES, 'UTF-8');?>">20</a><span>|</span>
				<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('bbs/article/searchreply?perpage=50', $args), ENT_QUOTES, 'UTF-8');?>">50</a><span>|</span>
				<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('bbs/article/searchreply?perpage=100', $args), ENT_QUOTES, 'UTF-8');?>">100</a>
			</div>
			<label class="mr20"><input type="checkbox" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label>
			<button class="btn J_ajax_submit_btn" type="submit">删除</button>
			<button class="btn btn_submit J_ajax_submit_btn" type="submit" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?isDeductCredit=1&m=bbs&c=article&a=deletereply'; ?>">删除并扣除积分</button>
		</div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>