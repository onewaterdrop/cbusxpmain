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
<!--==============================公告管理列表================================-->
	<div class="mb10">
		<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=announce&c=announce&a=add'; ?>" class="btn" title="添加公告"><span class="add"></span>添加公告</a>
	</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=announce&c=announce&a=doRun'; ?>" method="post">
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="80">
				<col width="60">
				<col>
				<col width="60">
				<col width="100">
				<col width="260">
				<col width="160">
			</colgroup>
			<thead>
				<tr>
					<td><label><input type="checkbox" name="checkAll" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label></td>
					<td>顺序</td>
					<td>公告</td>
					<td>状态</td>
					<td>发布者</td>
					<td>有效时间</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="J_link_tr">
			<?php  if ($announceInfos) { 
 
			  $now = Pw::str2time(Pw::time2str(Pw::getTime(), 'Y-m-d'));
			 foreach ($announceInfos as $value) { 
			    $status = null;
			    $subject = $value['subject'] ? Pw::substrs($value['subject'], 30) : null;
			    ?>
			<tr>
				<td><input class="J_check" data-xid="J_check_x" data-yid="J_check_y" type="checkbox" name="aid[]" value="<?php echo htmlspecialchars($value['aid'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input class="input length_0" type="text" name="vieworder[<?php echo htmlspecialchars($value['aid'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($subject, ENT_QUOTES, 'UTF-8');?></td>
				<?php  
				if($now < $value['start_date']) {
				 	$status = '未发布';$statusColor = 'red';
				}
			    if ($now >= $value['start_date'] && (0 == $value['end_date'] || $now <= $value['end_date']))	{
			    	$status = '发布中';$statusColor = 'green';
			    }
			    if ($value['end_date'] && $now > $value['end_date']) {
			  	  	$status = '已过期';$statusColor = 'gray';
			  	} 
			    $start_date = $value['start_date'] ? Pw::time2str($value['start_date'], 'Y-m-d') : null;
			    $end_date = $value['end_date'] ? Pw::time2str($value['end_date'], 'Y-m-d') : null;
			    ?>
				<td><span class="<?php echo htmlspecialchars($statusColor, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($status, ENT_QUOTES, 'UTF-8');?></span></td>
				<td><?php echo htmlspecialchars($value['username'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($start_date, ENT_QUOTES, 'UTF-8');?>至<?php echo htmlspecialchars($end_date, ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?aid=', rawurlencode($value['aid']),'&m=announce&c=announce&a=update'; ?>" title="编辑公告管理" class="mr10">[编辑]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?aid=', rawurlencode($value['aid']),'&m=announce&c=announce&a=doDelete'; ?>" class="mr10 J_ajax_del">[删除]</a></td>
			</tr>
			<?php  } 
  } else { ?>
				<tr><td colspan="7" class="tac">啊哦，暂无内容！</td></tr>
			<?php  } ?>
			</tbody>
		</table>
		<div class="p10"><?php $__tplPageCount=(int)$pageCount;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=announce&c=announce'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?></div>
	</div>
	<?php  if ($announceInfos) { ?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<label class="mr20"><input type="checkbox" name="checkAll" class="J_check_all" data-direction="x" data-checklist="J_check_x">全选</label>
			<button class="btn btn_submit J_ajax_submit_btn" type="submit">提交</button>
			<button type="button" id="J_link_del_all" class="btn">删除</button>
		</div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>

<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script type="text/javascript">
Wind.use('dialog',function() {

	//分类筛选
	var link_tr = $('#J_link_tr > tr');
	$('#J_link_types').on('change', function(){
		link_tr.hide();
		var $this = $(this), v = $this.val();
		if(v) {
			$('.J_link_'+ v).parents('tr').show();
		}else{
			link_tr.show();
		}
	});
	
	//批量删除
	$('#J_link_del_all').on('click', function(e){
		e.preventDefault();
		if(!$('input.J_check:checked').length) {
			Wind.dialog.alert('请至少选定至一条管理公告');
			return;
		}
		Wind.dialog({
			message	: '确定删除选定的管理公告？', 
			type	: 'confirm',
			onOk	: function() {
				$('form.J_ajaxForm').ajaxSubmit({
					dataType : 'json',
					url		 : '<?php echo Wekit::app()->baseUrl,'/','admin.php?m=announce&c=announce&a=doBatchDelete'; ?>',
					success	 : function(data, statusText, xhr, $form) {
						if(data.state === 'success') {
							var location = window.location;
							location.href = location.pathname + location.search;
						}else{
							Wind.dialog.alert(data.message);
						}
					}
				});
			}
		});
		
	});
});
</script>
</body>
</html>
