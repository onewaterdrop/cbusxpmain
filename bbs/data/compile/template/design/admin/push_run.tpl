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
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=push'; ?>">显示中数据</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?status=1&m=design&c=push&a=status'; ?>">待审核数据</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?status=2&m=design&c=push&a=status'; ?>">推送数据</a></li>	
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=push&a=shield'; ?>">屏蔽数据</a></li>	
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>此列表展示前台各模块正在显示的，来源为推送的数据。</li>
		</ul>
	</div>
	<div class="h_a">搜索</div>
	<form method="post"  action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=push'; ?>" >
	<div class="search_type cc mb10">
		<span class="mr20">所属页面：
			<select class="select_2" name="pageid" id="J_flag_initiative">
				<option value="">不限制</option>
			<?php  foreach ($pagelist as $v): ?>
				<option value="<?php echo htmlspecialchars($v['page_id'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($v['page_id'] == $pageid), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v['page_name'], ENT_QUOTES, 'UTF-8');?></option>
			<?php  endforeach; ?>
			</select>
		</span>
		<span class="mr20">所属模块：
			<select class="select_2" name="moduleid" id="J_flag_passive">
				<option>不限制</option>
			</select>
		</span>
		<button class="btn">搜索</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<form class="J_ajaxForm" method="post"  action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=push&a=batchshield'; ?>" >
	<div class="table_list">
		<table width="100%">
			<colgroup>
				<col width="70">
				<col width="200">
				<col width="160">
				<col width="90">
				<col width="160">
			</colgroup>
			<thead>
				<tr>
					<td><label><input type="checkbox" data-checklist="J_check_y" data-direction="y" class="J_check_all" name="checkAll">全选</label></td>
					<td>标题</td>
					<td>所属模块</td>
					<td>推荐人</td>
					<td>显示时间</td>
					<td>操作</td>
				</tr>
			</thead>
			<?php  if ($list) { 
  foreach ($list as $v): ?>
			<tr>
				<td><input data-yid="J_check_y" data-xid="J_check_x" class="J_check" type="checkbox" name="dataids[]" value="<?php echo htmlspecialchars($v['data_id'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><a href="<?php echo htmlspecialchars($v['url'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($v['title'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo htmlspecialchars($modules[$v['module_id']]['module_name'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($pushs[$v['from_id']]['created_user'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars(Pw::time2str($v['start_time']), ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?dataid=', rawurlencode($v['data_id']),'&m=design&c=push&a=doshield'; ?>" class="mr10 J_ajax_del" data-msg="确定要删除选中内容?">[删除]</a></td>
			</tr>
			<?php  endforeach; 
  } else { ?>
				<tr><td colspan="7" class="tac">啊哦，没有符合条件的内容！</td></tr>
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=design&c=push'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
	</div>


	<?php  if ($list) { ?>
	<div class="btn_wrap">
	<div class="btn_wrap_pd">
		<label class="mr20"><input type="checkbox" data-checklist="J_check_x" data-direction="x" class="J_check_all" name="checkAll">全选</label><button data-subcheck="true" data-msg="确定要删除选中内容?" class="btn btn_submit J_ajax_submit_btn" type="submit">删除</button>
	</div>
	</div>
	<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	//select联动
	var flag_passive = $('#J_flag_passive'),
		flag_initiative = $('#J_flag_initiative'),
		moduleid = '<?php echo htmlspecialchars($moduleid, ENT_QUOTES, 'UTF-8');?>';		//模块id 后端输出
	flag_initiative.on('change', function(){
		flatSet(this.value);
	});

	//
	if(flag_initiative.val()) {
		flatSet(flag_initiative.val(), moduleid);
	}

	function flatSet(pageid, id){
		if(pageid) {
			$.post('<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=page&a=getModuleOption'; ?>', {pageid : pageid}, function(data){
				if(data.state == 'success') {
					flag_passive.html('<option>不限制</option>'+data.data);

					if(id) {
						flag_passive.children('[value='+ id +']').prop('selected', true);
					}
				}else if(data.state == 'fail'){
					//common.js
					resultTip({
						error : true,
						msg : data.message
					});
				}
			}, 'json');
		}else{
			flag_passive.html('<option>不限制</option>');
		}
	}
});
</script>
</body>
</html>