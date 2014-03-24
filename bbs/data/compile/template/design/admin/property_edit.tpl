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
<div class="wrap">	
	
	
<!--添加模板-->

	<div class="nav">
		<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=', rawurlencode($isapi),'&m=design&c=module'; ?>">返回上一级</a></div>
		<ul class="cc">
		<?php  if ($isdata): ?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data'; ?>">显示数据</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data&a=push'; ?>">推送审核</a></li>
		<?php  endif; ?>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=property&a=edit'; ?>">属性</a></li>
		<?php  if ($isdata): ?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=template&a=edit'; ?>">模板</a></li>
		<?php  endif; ?>
		</ul>
	</div>
	<div class="h_a">属性</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?_json=1&m=design&c=property&a=doedit'; ?>" method="post">
	<div class="design_ct">
		<dl class="cc">
			<dt>数据模型：</dt>
			<dd>
				<select class="select_2 mr10" name="model_type" id="J_select_model_type">
				<?php  foreach ($types as $k=>$v):?>
					<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($modelInfo['type'] == $k), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
				<select class="select_2 mr10" name="model" id="J_select_model">
				<?php  foreach ($models[$modelInfo['type']] as $v):	?>
						<option value="<?php echo htmlspecialchars($v['model'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($model == $v['model']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
				<?php  if ($isedit): ?>
					<p class="red">切换数据模型可能导致当前模板不可用，请重新设置模板</p>
				<?php  endif; ?>
			</dd>
		</dl>

		
		<dl class="cc">
			<dt>模块名称：</dt>
			<dd><span class="must_red">*</span><input type="text"  class="input length_5" name="module_name" value="<?php echo htmlspecialchars($module['module_name'], ENT_QUOTES, 'UTF-8');?>"></dd>
		</dl>
	<?php  foreach($property AS $k=>$v):
		$v3t = 'array';
		if (!empty($v[3]) && !is_array($v[3])):
			list($v3, $v3t) = explode('|',$v[3]);
			$v[3] = $decorator[$v3];
		 endif;
	
  if($v[0] == 'text'): ?>
		<dl class="cc">
			<dt><?php echo htmlspecialchars($v[1], ENT_QUOTES, 'UTF-8');?>：</dt>
			<?php  
			$cls='length_1';
			if($v[4] == 'long'): 
				$cls='length_5';
			endif;
			
  if($v3t == 'html' && !$vProperty[$k]):?>
			<dd><input type="text" class="input <?php echo htmlspecialchars($cls, ENT_QUOTES, 'UTF-8');?> mr10"  name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($vProperty[$k], ENT_QUOTES, 'UTF-8');?>">
				<?php  if ($cls=='length_5'): ?>
					<p class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></p>
				<?php  else: ?>
					<span class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></span>
				<?php  endif; ?>
			</dd>
			<?php  else: ?>
			<dd><input type="text" class="input <?php echo htmlspecialchars($cls, ENT_QUOTES, 'UTF-8');?> mr10"  name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($vProperty[$k], ENT_QUOTES, 'UTF-8');?>">
				<?php  if ($cls=='length_5'): ?>
					<p class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></p>
				<?php  else: ?>
					<span class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></span>
				<?php  endif; ?>
			</dd>
			<?php  endif; ?>	
		</dl>
	<?php  endif; 
  if($v[0] == 'select'): ?>
		<dl class="cc">
			<dt><?php echo htmlspecialchars($v[1], ENT_QUOTES, 'UTF-8');?>：</dt>
			<dd>
				<?php  if($v[4] == 'multiple'): ?>
				<select class="select_5 mr10" name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>][]" size="8" <?php echo htmlspecialchars($v[4], ENT_QUOTES, 'UTF-8');?>>
				<?php  else: ?>
				<select class="select_5 mr10" name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]">
				<?php  endif; 
  if($v3t == 'html'): 
 echo $v[3];
  else: 
  foreach((array)$v[3] AS $_k=>$_v):?>
					<option value="<?php echo htmlspecialchars($_k, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($vProperty[$k] == $_k), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_v, ENT_QUOTES, 'UTF-8');?></option>
					<?php  endforeach; 
  endif; ?>	
				</select>
				<span class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></span>
			</dd>
		</dl>
	<?php  endif; 
  if($v[0] == 'radio'): ?>
		<dl class="cc">
			<dt><?php echo htmlspecialchars($v[1], ENT_QUOTES, 'UTF-8');?>：</dt>
			<dd>
				<ul class="three_list">
				<?php  if($v3t == 'array'): 
  foreach((array)$v[3] AS $_k=>$_v):?>
					<li><label class="mr20"><input type="radio" value="<?php echo htmlspecialchars($_k, ENT_QUOTES, 'UTF-8');?>" name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]"  <?php echo htmlspecialchars(Pw::ifcheck($vProperty[$k] == $_k), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_v, ENT_QUOTES, 'UTF-8');?></label></li>
					<?php  endforeach; 
  else: 
 echo $v[3];
  endif; ?>	
				</ul>
				<span class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></span>
			</dd>
		</dl>
	<?php  endif; 
  if($v[0] == 'checkbox'): ?>
		<dl class="cc">
			<dt><?php echo htmlspecialchars($v[1], ENT_QUOTES, 'UTF-8');?>：</dt>
			<dd>
				<ul class="three_list">
				<?php  if($v3t == 'array'): 
  foreach((array)$v[3] AS $_k=>$_v):?>
					<li><label class="mr20"><input type="checkbox" value="<?php echo htmlspecialchars($_k, ENT_QUOTES, 'UTF-8');?>" name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>][]" <?php echo htmlspecialchars(Pw::ifcheck(in_array($_k,(array)$vProperty[$k])), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_v, ENT_QUOTES, 'UTF-8');?></label></li>
					<?php  endforeach; 
  else: 
 echo $v[3];
  endif; ?>	
				</ul>
				<span class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></span>
			</dd>
		</dl>
	<?php  endif; 
  if($v[0] == 'textarea'): ?>
		<dl class="cc">
			<dt><?php echo htmlspecialchars($v[1], ENT_QUOTES, 'UTF-8');?>：</dt>
			<dd>
			<?php  if($v3t == 'html' && !$vProperty[$k]): ?>
				<textarea class="length_6 mb5" style="width:450px;height:230px;"  name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]"><?php echo htmlspecialchars($v[3], ENT_QUOTES, 'UTF-8');?></textarea><p class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></p>
			<?php  else: ?>
				<textarea class="length_6 mb5" style="width:450px;height:230px;" name="property[<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]"><?php echo htmlspecialchars($vProperty[$k], ENT_QUOTES, 'UTF-8');?></textarea><p class="gray"><?php echo htmlspecialchars($v[2], ENT_QUOTES, 'UTF-8');?></p>
			<?php  endif; ?>
			</dd>
		</dl>
	<?php  endif; 
  if($v[0] == 'html'): 
		list($tpl,$name) = explode('|', $v[4]);
	
 PwHook::segment("TPL:design.property.$tpl", array($vProperty, $v[3]), "$name", "$tpl", $__viewer); 
  endif; 
  endforeach; 
  if($modelInfo['refresh']): ?>
		<dl class="cc">
			<dt>数据更新周期：</dt>
			<dd><input type="text" class="input length_1 mr5" name="cache[expired]" value="<?php echo htmlspecialchars($cache['expired'], ENT_QUOTES, 'UTF-8');?>"><span class="mr20">分钟</span><span class="gray">0代表不更新</span></dd>
		</dl>
		<dl class="cc">
			<dt>数据更新区间：</dt>
			<dd>
				<div class="mb10">开始于&nbsp;
				<input type="text" class="input length_1 mr5" name="cache[start_hour]" value="<?php echo htmlspecialchars($cache['start_hour'], ENT_QUOTES, 'UTF-8');?>"><span class="mr20">时</span>
				<input type="text" class="input length_1 mr5" name="cache[start_minute]" value="<?php echo htmlspecialchars($cache['start_minute'], ENT_QUOTES, 'UTF-8');?>"><span>分</span></div>
				<div class="mb10">结束于&nbsp;
				<input type="text" class="input length_1 mr5" name="cache[end_hour]" value="<?php echo htmlspecialchars($cache['end_hour'], ENT_QUOTES, 'UTF-8');?>"><span class="mr20">时</span>
				<input type="text" class="input length_1 mr5" name="cache[end_minute]" value="<?php echo htmlspecialchars($cache['end_minute'], ENT_QUOTES, 'UTF-8');?>"><span>分</span></div>
			</dd>
		</dl>
	<?php  endif; ?>

	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" type="submit" >提交</button>
			<input type="hidden"  name="moduleid" value="<?php echo htmlspecialchars($moduleid, ENT_QUOTES, 'UTF-8');?>">
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	var select_model = $('#J_select_model'),
		DESIGN_MODELS = <?php echo WindJson::encode($models, 'UTF-8');?>;

	$('#J_select_model_type').on('change', function(e){
		//模块属性 数据模型
		var data = DESIGN_MODELS[this.value],
			arr = [];
		if(data) {
			for (i = 0, len = data.length; i<len; i++) {
				arr.push('<option value="'+ data[i].model +'">'+ data[i].name +'</option>')
			}
			select_model.html(arr.join('')).show();

			if (select_model.val()) {
				location.href = changeURLPar(location.href, 'model', select_model.val());
			}
 		}else{
			select_model.hide().html('');
		}
	});

	select_model.on('change', function(e){
		//更新数据模块
		if(this.value) {
			location.href = changeURLPar(location.href, 'model', this.value);
		}
		
	});

	//url参数替换
	function changeURLPar(destiny, par, par_value) {
		var pattern = par+'=([^&]*)';
		var replaceText = par+'='+par_value;

		if(destiny.match(pattern)) {
			var tmp = '/\\'+par+'=[^&]*/';
			tmp = destiny.replace(eval(tmp), replaceText);
			return (tmp);
		}else{
			if(destiny.match('[\?]')) {
				return destiny+'&'+ replaceText;
			}else{
				return destiny+'?'+replaceText;
			}
		}

		return destiny+'\n'+par+'\n'+par_value;
	}

	//地区组件
	if($('a.J_region_change').length) {
		Wind.use('region', function(){
			$('a.J_region_change').region({
				regioncancl : true
			});
		});
	}

});
</script>
</body>
</html>