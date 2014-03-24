<div class="content">
	<div class="profile_nav">
		<ul>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report'; ?>">举报列表</a></li>
		</ul>
	</div>
	<div class="report_page">
		<div class="hd"><strong>筛选：</strong>
		<form action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report'; ?>" method="post">
			<select id="J_report_select" class="select_2" name="type">
				<option value="" href="">全部</option>
				<?php  foreach ($reportTypes as $k => $v) { 
			$selected = ($args['type'] == $k) ? 'selected=selected' : '';
			?>
				<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" data-check="<?php echo htmlspecialchars($args['ifcheck'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($selected, ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></option>
			<?php  } ?>
			</select>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		</div>
		<div class="profile_table">
		<?php  if ($reports) { ?>
		<form class="J_form_ajax" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&a=dealCheck'; ?>" method="post" >
			<table width="100%" class="J_check_wrap">
				<colgroup>
					<col width="60">
					<col width="50">
					<col width="300">
					<col width="115">
					<col width="115">
					<col>
				</colgroup>
				<thead>
					<tr>
						<td><label><input type="checkbox" class="J_check_all">全选</label></td>
						<td>类型</td>
						<td>内容</td>
						<td>作者</td>
						<td>举报人/举报时间</td>
						<td>举报理由</td>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td><label><input type="checkbox" class="J_check_all">全选</label></td>
						<td colspan="3"><button type="submit" class="btn btn_submit J_form_sub_check">标记已处理</button><button type="submit" class="btn J_form_sub_check" data-action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&a=delete'; ?>">忽略</button></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</tfoot>
				<?php  foreach ($reports as $v) { ?>
				<tr>
					<td><input class="J_check" type="checkbox" name="id[]" value="<?php echo htmlspecialchars($v['id'], ENT_QUOTES, 'UTF-8');?>"></td>
					<td><?php echo htmlspecialchars($reportTypes[$v['type']], ENT_QUOTES, 'UTF-8');?></td>
					<td>
					<?php  if ($v['content_url']) { ?>
					<a href="<?php echo htmlspecialchars($v['content_url'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars(Pw::substrs(Pw::stripWindCode($v['content']), 20), ENT_QUOTES, 'UTF-8');?></a>
					<?php  } else { 
 echo htmlspecialchars(Pw::substrs(Pw::stripWindCode($v['content']), 20), ENT_QUOTES, 'UTF-8');
  } ?>
					</td>
					<td><?php if (!empty($v['author_username'])){?><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($v['author_userid']); ?>"><?php echo htmlspecialchars($v['author_username'], ENT_QUOTES, 'UTF-8');?></a><?php }else{?>游客<?php } ?></td>
					<td><?php if (!empty($v['created_username'])){?><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($v['created_userid']); ?>" target="_blank"><?php echo htmlspecialchars($v['created_username'], ENT_QUOTES, 'UTF-8');?></a><?php }else{?>游客<?php } ?><br><?php echo htmlspecialchars(Pw::time2str($v['created_time']), ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars(Pw::substrs($v['reason'], 8), ENT_QUOTES, 'UTF-8');?></td>
				</tr>
				<?php  } ?>
				</table>
				<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=report&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
				</div>
			</div>
	<?php  } else { ?>
		<div class="not_content">啊哦，没有符合条件的内容！</div>
	<?php  } ?>
	</div>
</div>
			