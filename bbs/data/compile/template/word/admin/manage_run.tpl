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
<?php  if($syncStatus){ ?>
	<div class="tips_light">敏感词已更新到<?php echo htmlspecialchars(Pw::time2str($sync['lasttime'], 'Y-m-d'), ENT_QUOTES, 'UTF-8');?>，新增<?php echo htmlspecialchars($sync['syncnum'], ENT_QUOTES, 'UTF-8');?>个词语，<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=sync'; ?>">立即同步</a></div>
<?php  } ?>
	<div class="h_a">提示信息</div>
	<div class="prompt_text">
		<ul>
			<li>敏感词管理可以有效保证您网站的顺利运营。为了提高发帖效率，建议敏感词不超过3500个</li>
			<li>您可以&nbsp;<a target="_blank" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=export'; ?>" class="mr10">导出词库</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=import'; ?>" class="J_dialog" title="导入本地词库">导入本地词库</a></li>
		</ul>
	</div>
	<form id="J_word_tip_form" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=setconfig'; ?>" method="post">
	<div class="h_a">敏感词设置</div>
	<div class="table_full">
	<table width="100%">
		<colgroup>
			<col class="th">
			<col width="400">
		</colgroup>
		<tr>
			<th>前台文字提示</th>
			<td>
				<ul class="switch_list cc">
					<li><label><input name="config[tip]" value="1" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($config[istip] == 1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
					<li><label><input name="config[tip]" value="0" type="radio" <?php echo htmlspecialchars(Pw::ifcheck($config[istip] == 0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
				</ul>
			</td>
			<td><div class="fun_tips">开启后,将会在前台通知用户,发布内容中哪些是敏感词</div></td>
		</tr>
	</table>
	</div>
	<div class="mb10"><button class="btn btn_submit" type="submit">提交</button></div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
	<div class="h_a">搜索</div>
	<form method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=search'; ?>">
	<div class="search_type cc mb10">
		<select name="type" class="select_3 mr10"><option value="-1">所有级别</option>
			<?php  foreach($typeList as $key=>$value){ 
  $selected = $key == $args[type] ? 'selected' : ''; ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($selected, ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
			<?php  } ?>
		</select>
		<input name="keyword" type="text" class="input length_3 mr10" value="<?php echo htmlspecialchars($args[keyword], ENT_QUOTES, 'UTF-8');?>"  placeholder="敏感词关键字">
		<button class="btn" type="submit">搜索</button>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
	<div class="mb10"><a class="btn J_dialog" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=add'; ?>" title="添加敏感词"><span class="add"></span>添加敏感词</a></div>
	
	<div class="tips mb10" id="J_check_tip_part" style="display:none;">
		此页中的全部<span class="J_count"></span>项已选中，<a href="" id="J_check_page">同时选择所有页面的<span class="count"><?php echo htmlspecialchars($total, ENT_QUOTES, 'UTF-8');?></span>项</a>
	</div>
	<?php  $check_all_display = isset($ischeckAll) && $ischeckAll ? '' : 'display:none;'; ?>
	<div class="tips mb10" id="J_check_tip_all" style="<?php echo htmlspecialchars($check_all_display, ENT_QUOTES, 'UTF-8');?>">
		已选中所有页面<span class="J_count"><?php echo htmlspecialchars($total, ENT_QUOTES, 'UTF-8');?></span>项，<a href="" id="J_check_cancl">取消全选</a>
	</div>
	<form id="J_word_form" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=%2A'; ?>" method="post">
		<div class="table_list">
			<table width="100%">
				<colgroup>
					<col width="60">
					<col width="100">
					<col width="200">
					<col width="150">
				</colgroup>
				<thead>
					<tr>
						<?php  $checked = isset($ischeckAll) && $ischeckAll ? 'checked' : ''; ?>
						<td><label><input type="checkbox" class="J_check_all" data-direction="x" data-checklist="J_check_x" <?php echo htmlspecialchars($checked, ENT_QUOTES, 'UTF-8');?>>全选</label></td>
						<td>ID(共<?php echo htmlspecialchars($total, ENT_QUOTES, 'UTF-8');?>个)</td>
						<td>敏感词</td>
						<td><select name="type" id="J_filter_select"><option value="-1">所有级别</option>
			<?php  foreach($typeList as $key=>$value){ 
  $selected = $key == $args[type] ? 'selected' : ''; ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($selected, ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
			<?php  } ?>
		</select></td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody id="J_word_list">
				<?php  foreach ($wordList as $key => $value) {
					$value['word_type'] = in_array($value['word_type'], array_keys($typeList)) ? $typeList[$value['word_type']] : '';
				?>
				<tr>

					<td><input type="checkbox" name="ids[]" value="<?php echo htmlspecialchars($value['word_id'], ENT_QUOTES, 'UTF-8');?>" class="J_check" data-yid="J_check_y" data-xid="J_check_x" <?php echo htmlspecialchars($checked, ENT_QUOTES, 'UTF-8');?>></td>
					<td><?php echo htmlspecialchars($key+1, ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars($value['word'], ENT_QUOTES, 'UTF-8');?></td>
					<td><?php echo htmlspecialchars($value['word_type'], ENT_QUOTES, 'UTF-8');?></td>
					<td><a class="mr5 J_dialog" title="编辑" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($value['word_id']),'&m=word&c=manage&a=edit'; ?>">[编辑]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?id=', rawurlencode($value['word_id']),'&m=word&c=manage&a=delete'; ?>" data-msg="确定删除该敏感词" class="J_ajax_del">[删除]</a></td>
				</tr>
				<?php  } ?>
				</tbody>
			</table>
			<?php  if (!$total && $action == 'search') { ?>
			<div class="tac">啊哦，没有符合条件的内容！</div>
			<?php  } ?>
			<div class="p10" id="J_page_wrap">
				<?php $__tplPageCount=(int)$total;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?page=', rawurlencode($_page_i),'&m=word&c=manage&a=search'; 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
			</div>

		</div>
		<?php  if ($wordList) { ?>
		<div class="btn_wrap">

			<div class="btn_wrap_pd">
				
				<div class="select_pages">
					<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('word/manage/search?perpage=20', $args), ENT_QUOTES, 'UTF-8');?>">20</a><span>|</span>
					<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('word/manage/search?perpage=50', $args), ENT_QUOTES, 'UTF-8');?>">50</a><span>|</span>
					<a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl('word/manage/search?perpage=100', $args), ENT_QUOTES, 'UTF-8');?>">100</a>
				</div>
				
				<label class="mr20"><input type="checkbox" class="J_check_all" data-direction="y" data-checklist="J_check_y">全选</label>
				<input type="hidden" name="checkall" id="J_all_checked" value="0"/>
				<input type="hidden" name="keyword" value="<?php echo htmlspecialchars($args['keyword'], ENT_QUOTES, 'UTF-8');?>"/>
				<button class="btn btn_submit" id="J_edit_btn" type="button">编辑</button>
				<button class="btn J_ajax_delete_btn" type="button">删除</button>
			</div>

		</div>
		<?php  } ?>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>

<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog', 'ajaxForm', function(){
	var word_form = $('#J_word_form');
			word_form.resetForm();
	
	//提示开启关闭
	$('#J_word_tip_form').ajaxForm({
		dataType : 'json',
		beforeSubmit: function(arr, $form, options) {
			$('#J_word_tip_error').remove();
		},
		success : function(data, statusText, xhr, $form) {
			var btn = $form.find('button:submit');
			if(data.state == 'success') {
				$( '<span class="tips_success">' + data.message + '</span>' ).insertAfter(btn).fadeIn('slow').delay( 1000 ).fadeOut(function() {
					$(this).remove();
				});
			}else if(data.state == 'fail') {
				$( '<span class="tips_error" id="J_word_tip_error">' + data.message + '</span>' ).insertAfter(btn).fadeIn( 'fast' );
			}
		}
	});

	//到处词库
	$('#J_word_export').on('click', function(e){
		e.preventDefault();
		$.post($(this).attr('href'),function(data){});
	});


	var URL_DELETE = "<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=batchdelete'; ?>",	//删除
			URL_EDIT = "<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=batchedit'; ?>",	//编辑
			word_list = $('#J_word_list');
	
	//点击删除
	$('button.J_ajax_delete_btn').on('click', function(e){
		e.preventDefault();
		var $this = $(this);
		
		$this.parent().find('span').remove();
		if (getCheckedTr()) {
			
			Wind.dialog({
				type : 'confirm',
				message : '确定删除选中的敏感词？',
				isMask : true,
				follow	: $this,
				onOk : function(){
					word_form.ajaxSubmit({
						url : URL_DELETE,
						dataType : 'json',
						beforeSubmit: function(arr, $form, options) { 
							$this.prop('disabled',true).addClass('disabled');
						},
						success : function(data, statusText, xhr, $form) {
							if( data.state === 'success' ) {
								$( '<span class="tips_success">' + data.message + '</span>' ).insertAfter($this).fadeIn('slow').delay( 1000 ).fadeOut(function() {
									reloadPage(window);
								});
							}else if( data.state === 'fail' ) {
								$( '<span class="tips_error">' + data.message + '</span>' ).insertAfter($this).fadeIn( 'fast' );
								$this.removeProp('disabled').removeClass('disabled');
							}
						}
					});
				},
				onCancel : function(){
					$this.focus();
				}
			});
		} else {
			$( '<span class="tips_error">请至少选择一项</span>' ).appendTo($this.parent()).fadeIn( 'fast' );
		}
		
	});
	
	//批量编辑
	$('#J_edit_btn').on('click', function(e){
		e.preventDefault();
		var $this = $(this);
		
		$this.parent().find('span').remove();
		if (getCheckedTr()) {
			word_form.ajaxSubmit({
				url : URL_EDIT,
				dataType : 'html',
				beforeSubmit: function(arr, $form, options) {
				},
				success : function(data, statusText, xhr, $form) {
					if( data ) {
						Wind.dialog.open( unescape(URL_EDIT +'&'+ word_form.formSerialize()) ,{
							onClose : function() {
								$this.focus();//关闭时让触发弹窗的元素获取焦点
							},
							title : '编辑'
						});
					}
				}
			});
		} else {
			$( '<span class="tips_error">请至少选择一项</span>' ).appendTo($this.parent()).fadeIn( 'fast' );
		}
	});
	
	//选择统计
	function getCheckedTr(){
		if(word_list.find('input.J_check:checked').length >= 1) {
			return true;
		}else{
			return false;
		}
	}

	

	//筛选
	$('#J_filter_select').on('change', function(){
		window.location.href = '<?php echo Wekit::app()->baseUrl,'/','admin.php?m=word&c=manage&a=search'; ?>&type='+ $(this).val();
	});

	//选择统计
	var check_tip_part = $('#J_check_tip_part'),
		check_tip_all = $('#J_check_tip_all'),
		all_checked = $('#J_all_checked'),
		checkbox = word_form.find('input:checkbox'),
		page_a = $('#J_page_wrap a');			//分页链接

	checkbox.on('change', function(){
		var checked = $('input.J_check:checked');

		if(checkbox.filter('input.J_check').length === checked.length) {
			check_tip_part.show().children('.J_count').text(checked.length);
		}else{
			check_tip_part.hide();
		}
		check_tip_all.hide();
		all_checked.val('0');
	});

	//选择所有页面
	$('#J_check_page').on('click', function(e){
		e.preventDefault();
		check_tip_part.hide();
		check_tip_all.show();
		checkbox.attr('checked', 'checked');
		all_checked.val('1');

		page_a.each(function(){
			this.href = changeURLPar(this.href, '_check', '1');
		});

	});

	//取消选择所有
	$('#J_check_cancl').on('click', function(e){
		e.preventDefault();
		var checked = $('input.J_check:checked');

		check_tip_part.hide();
		check_tip_all.hide();

		checkbox.removeAttr('checked');
		all_checked.val('0');

		page_a.each(function(){
			this.href = changeURLPar(this.href, '_check', '0');
		});
	});

	//更换url参数
	function changeURLPar(destiny, par, par_value) {
		var pattern = par+'=([^&]*)';
		var replaceText = par+'='+par_value;

		if (destiny.match(pattern)) {
			var tmp = '/\\'+par+'=[^&]*/';
			tmp = destiny.replace(eval(tmp), replaceText);
			return (tmp);
		}else{
			if (destiny.match('[\?]')){
				return destiny+'&'+ replaceText;
			}else{
				return destiny+'?'+replaceText;
			}
		}

		return destiny+'\n'+par+'\n'+par_value;
	}

});
</script>
</body>
</html>