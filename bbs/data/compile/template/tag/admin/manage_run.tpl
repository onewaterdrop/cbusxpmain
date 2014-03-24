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
				<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage'; ?>">话题管理</a></li>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=category'; ?>">话题分类</a></li>
			</ul>
		</div>
		<div class="h_a">功能说明</div>
		<div class="prompt_text">
			话题，也叫标签，通过给帖子设置标签，可以将不同版块的帖子汇聚在一起，形成另一种维度的内容聚合。
		</div> 
		<div class="h_a">搜索</div>
		<div class="search_type cc mb10">
			<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage'; ?>" method="post">
			<input type="hidden" name="<?php echo htmlspecialchars($moduleKey, ENT_QUOTES, 'UTF-8');?>" value="tag" />
			<input type="hidden" name="<?php echo htmlspecialchars($controllerKey, ENT_QUOTES, 'UTF-8');?>" value="manage" />
			<div class="ul_wrap">
				<ul class="cc">
					<li>
						<label>话题名称：</label><input type="text" class="input length_3" name="keyword" value="<?php echo htmlspecialchars($keyword, ENT_QUOTES, 'UTF-8');?>">
					</li>
					<li>
						<label>热门话题：</label>
							<select name="ifhot" class="select_3">
								<option value="-1"<?php  if($ifhot=='-1'){ ?> selected<?php  } ?>>不限</option>
								<option value="1"<?php  if($ifhot=='1'){ ?>  selected<?php  } ?>>热门</option>
								<option value="0"<?php  if(is_numeric($ifhot) && $ifhot=='0'){ ?>  selected<?php  } ?>>不热门</option>
							</select>
					</li>
					<li>
						<label>话题分类：</label>
						<select name="categoryId" class="select_3">
							<option value="0">不限</option>
							<?php  foreach($categories as $v){ ?>
							<option value="<?php echo htmlspecialchars($v['category_id'], ENT_QUOTES, 'UTF-8');?>"<?php  if($v['category_id']==$categoryId){ ?> selected<?php  } ?>><?php echo htmlspecialchars($v['category_name'], ENT_QUOTES, 'UTF-8');?></option>
							<?php  } ?>
						</select>
					</li>
					<li>
						<label>关注数：</label><input class="input length_1 mr10" type="number" name="minAttention" value="<?php echo htmlspecialchars($minAttention, ENT_QUOTES, 'UTF-8');?>"><span class="mr10">至</span><input class="input length_1" type="text" name="maxAttention" value="<?php echo htmlspecialchars($maxAttention, ENT_QUOTES, 'UTF-8');?>">
					</li>
					<li>
						<label>内容数：</label><input class="input length_1 mr10" type="number" name="minContent" value="<?php echo htmlspecialchars($minContent, ENT_QUOTES, 'UTF-8');?>"><span class="mr10">至</span><input class="input length_1" type="text" name="maxContent" value="<?php echo htmlspecialchars($maxContent, ENT_QUOTES, 'UTF-8');?>">
					</li>
				</ul>
			</div>
			<div class="btn_side">
			<button class="btn btn_submit" type="submit">搜索</button>
			</div>
			<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		</div>
		<div class="mb10"><a title="添加话题" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=add'; ?>" class="btn J_dialog"><span class="add"></span>添加话题</a></div>
		<?php  if ($tags) { ?>
		<form method="post" action="#" id="J_tag_form" class="J_ajaxForm">
		<div class="table_list">
			<table width="100%">
				<colgroup>
					<col width="65">
					<col width="70">
					<col width="250">
					<col>
					<col>
					<col width="120">
				</colgroup>
				<thead>
					<tr>
						<td><label><input class="J_check_all" data-checklist="J_check_x" data-direction="x" type="checkbox">全选</label></td>
						<td>话题logo</td>
						<td>名称/描述</td>
						<td>内容数/被关注数</td>
						<td>话题分类</td>
						<td>关联话题</td>
						<td>允许热门</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody id="J_tag_list">
				<?php  foreach($tags as $v){
					$relatedTopics = $v['joinTag'];
					$realtedTopicsHtml = array();
					if ($relatedTopics) {
						foreach ($relatedTopics as $v2){
							$realtedTopicsHtml[] = $v2['tag_name'];
						}
					}
				?>
				<tr>
					<td><input class="J_check" name="tag_id[]" value="<?php echo htmlspecialchars($v['tag_id'], ENT_QUOTES, 'UTF-8');?>" data-name="<?php echo htmlspecialchars($v['tag_name'], ENT_QUOTES, 'UTF-8');?>" data-tid="<?php echo htmlspecialchars($v['tag_id'], ENT_QUOTES, 'UTF-8');?>" data-xid="J_check_x" data-yid="J_check_y" type="checkbox"></td>
					<td><img src="<?php echo htmlspecialchars(Pw::getPath($v['tag_logo']), ENT_QUOTES, 'UTF-8');?>" width="50" height="50" class="fl" onerror="this.onerror=null;this.src='<?php echo Wekit::app()->themes; ?>/site/default/images/tags/default.png'" /></td>
					<td>
						<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=tag&a=view&name=', rawurlencode($v['tag_name']); ?>" target="_blank" class="J_tag_name"><?php echo htmlspecialchars($v['tag_name'], ENT_QUOTES, 'UTF-8');?></a>
						<p><?php echo htmlspecialchars(pw::substrs($v['excerpt'],30), ENT_QUOTES, 'UTF-8');?></p>
					</td>
					<td><?php echo htmlspecialchars($v['content_count'], ENT_QUOTES, 'UTF-8');?>/<span><?php echo htmlspecialchars($v['attention_count'], ENT_QUOTES, 'UTF-8');?></span></td>
					<td><?php echo htmlspecialchars($v['categories'], ENT_QUOTES, 'UTF-8');?></td>
					<td><?php  echo implode(',', $realtedTopicsHtml); ?></td>
					<td><?php  if ($v['ifhot']){ ?>是<?php  }else{ ?>否<?php  } ?></td>
					<td><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($v['tag_id']),'&m=tag&c=manage&a=edit'; ?>" title="编辑话题" class="mr5 J_dialog">[编辑]</a><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=tag&a=view&name=', rawurlencode($v['tag_name']); ?>" target="_blank">[内容管理]</a></td>
				</tr>
				<?php  } ?>
				</tbody>
			</table>
			<div class="p10">
				<?php $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perPage;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=tag&c=manage'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
			</div>
		</div>
		
		<div class="btn_wrap">
			<div class="btn_wrap_pd" id="J_sub_wrap">
				<label class="mr10"><input class="J_check_all" data-checklist="J_check_y" data-direction="y" type="checkbox">全选</label>
				<button class="btn J_ajax_submit_btn" data-subcheck="true" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=sethot'; ?>" type="submit">设为热门</button>
				<button class="btn J_ajax_submit_btn" data-subcheck="true" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=deletehot'; ?>" type="submit">取消热门</button>
				<button class="btn" id="J_merger_btn" type="submit" style="width:140px;">合并到关联话题</button>
				<button class="btn" id="J_move_btn" type="submit">移动分类</button>
				<button class="btn J_ajax_submit_btn" data-subcheck="true" data-msg="确定要删除吗？" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=delete'; ?>" type="submit">删除</button>
			</div>
		</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<?php  } else { ?>
	<div class="tac"> 啊哦，没有符合条件的内容！</div>
	<?php  } ?>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog', 'ajaxForm', function(){
	var URL_MERGE = "<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=merge'; ?>",	//合并
		URL_MOVE = "<?php echo Wekit::app()->baseUrl,'/','admin.php?m=tag&c=manage&a=move'; ?>";		//移动
	
	//点击合并
	$('#J_merger_btn').on('click', function(e){
		e.preventDefault();
		tagManPop($(this), 'merger');
		
	});
	
	//点击移动
	$('#J_move_btn').on('click', function(e){
		e.preventDefault();
		tagManPop($(this), 'move');
	});

	function tagManPop(btn, type) {
		var url = (type == 'merger' ? URL_MERGE : URL_MOVE),
			title = (type == 'merger' ? '合并到关联话题' : '移动分类');
		btn.parent().find('span').remove();
		if(getCheckedTr()) {
			Wind.dialog.open( url ,{
				onClose : function() {
					btn.focus();
				},
				title: title
			});

		}else{
			$( '<span class="tips_error">请至少选择一项</span>' ).appendTo(btn.parent()).fadeIn( 'fast' );
		}

	}
	
	//选择统计
	function getCheckedTr(){
		if($('#J_tag_list input.J_check:checked').length >= 1) {
			return true;
		}else{
			return false;
		}
	}

});
</script>
</body>
</html>
