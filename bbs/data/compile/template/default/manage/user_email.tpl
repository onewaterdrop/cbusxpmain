<div class="content">
	<div class="profile_nav">
		<ul>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user'; ?>">注册审核</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email'; ?>">邮箱审核</a></li>
		</ul>
	</div>
	<div class="profile_table">
	<?php  if ($list) { ?>
	<form action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=doactive'; ?>" method="post" class="J_form_ajax">
		<table width="100%" class="J_check_wrap">
			<thead>
				<tr>
					<td width="55"><label><input type="checkbox" class="J_check_all">全选</label></td>
					<td width="60">UID</td>
					<td width="120">用户名</td>
					<td width="120">注册时间</td>
					<td>电子邮箱</td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td><label><input type="checkbox" class="J_check_all">全选</label></td>
					<td colspan="4"><button type="submit" class="btn btn_submit J_form_sub_check">通过</button><button type="submit" class="btn J_form_sub_check" data-action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=delete'; ?>">拒绝</button></td>
				</tr>
			</tfoot>
			<?php  foreach ($list as $key => $item) { ?>
			<tr>
				<td><input type="checkbox" class="J_check" name="uid[]" value="<?php echo htmlspecialchars($item['uid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($item['uid'], ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($item['uid']); ?>"><?php echo htmlspecialchars($item['username'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo htmlspecialchars(Pw::time2str($item['regdate'], 'Y-m-d H:i:s'), ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($item['email'], ENT_QUOTES, 'UTF-8');?></td>
			</tr>
			<?php  } ?>
	
		</table>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=manage&c=user&a=email&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<?php  } else { ?>
		<div class="not_content">啊哦，没有符合条件的用户！</div>
	<?php  } ?>
	</div>
</div>