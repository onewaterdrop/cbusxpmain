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

<div class="nav">
	<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=', rawurlencode($group['type']),'&m=u&c=groups'; ?>">返回上一级</a></div>
	<ul class="cc J_tabs_nav">
		<?php foreach($topLevelCategories as $k=>$v): ?>
		<li<?php echo $topLevelCategoryClasses[$k];?> id="J_nav_<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" data-tab="nav_<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>">
			<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?category=', rawurlencode($k),'&gid=', rawurlencode($gid),'&m=u&c=groups&a=edit'; ?>&manage=<?php echo htmlspecialchars($isManage?1:0, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></a>
		</li>
		<?php endforeach;?>
	</ul>
</div>

<div class="tips_bubble" style="display:none;right:18px;margin-top:50px;" id="J_tips_bubble">
	<div class="core_arrow_bottom"><em></em><span></span></div>
	<p class="mb5">在这里勾选设置项，完成复制设置</p>
	<p class="tar"><a href="" id="J_tips_bubble_close">我知道了</a></p>
</div>

<form id="J_rigths_form" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=groups&a=doedit'; ?>" method="post">
<input type="hidden" name="gid" value="<?php echo htmlspecialchars($gid, ENT_QUOTES, 'UTF-8');?>" />
<input type="hidden" name="category" value="<?php echo htmlspecialchars($category, ENT_QUOTES, 'UTF-8');?>" />
<div class="h_a">用户组设置</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col width="400" />
		<col />
		<tr>
			<th>用户组头衔</th>
			<td><input type="text" name="groupname" value="<?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?>" class="input length_5"></td>
			<td class="td_tips"></td>
		</tr>
	</table>
</div>
<div class="J_tabs_contents">
<?php  foreach($permissionConfigs as $key => $value): ?>
	<div>
		<?php  foreach($value as $k => $v): ?>
		<div class="h_a"><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></div>
		<div class="table_full">
			<table width="100%">
				<col class="th" />
				<col width="400" />
				<col />
				<col width="44" />
				<?php  foreach($v['items'] as $k2 => $v2): 
					$type = $v2['config'][0];
				?>
				<tr><!--  选中后效果 class="tr_checkbox" -->
					<th><?php echo htmlspecialchars($v2['config'][2], ENT_QUOTES, 'UTF-8');?></th>
					<td>
					<?php  if ($type == 'html') { 
 PwHook::segment("permission_html_segments", array($k2,$v2), "$k2", "", $__viewer); 
  } else { 
 PwHook::segment("permission_type_segments", array($k2,$v2), "$type", "", $__viewer); 
  } ?>
					</td>
					<td style="vertical-align:middle"><div class="fun_tips"><?php echo $v2['config'][3];?></div></td>
					<td style="vertical-align:middle"><input type="checkbox" class="J_line_highlight" style="display:none;" name="copy_items[<?php echo htmlspecialchars($k2, ENT_QUOTES, 'UTF-8');?>]" value="1"></td>
				</tr>
				<?php  endforeach; ?>
			</table>
		</div>
		<?php  endforeach; ?>
	</div>
<?php  endforeach; ?>
</div>

<div class="core_pop_wrap pop_expand" style="display:none;" id="J_copy_pop">
	<div class="core_pop">
		<div class="pop_cont">
			<a href="" class="pop_close" id="J_copy_close">关闭</a>
			<div class="mb15 s6">勾选上述设置，并批量复制到其它用户组</div>
			<div class="cc shift">
				<div class="fl">
					<h4>选择用户组</h4>
					<select size="10" name="" id="J_copy_select_all" multiple="true">
						<?php  foreach($groups as $k=>$v){ ?>
						<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></option>
						<?php  } ?>
					</select>
				</div>
				<div class="fl shift_operate">
					<p class="mb10"><a href="" class="btn" id="J_copy_add">添加 &gt;&gt;</a></p>
					<p><a href="" class="btn" id="J_copy_del">&lt;&lt; 移除</a></p>
				</div>
				<div class="fr">
					<h4>已选用户组</h4>
					<select id="J_copy_select_sub" name="copy_groups[]" size="10" multiple="true">
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="core_arrow_bottom"><em></em><span></span></div>
</div>

<div class="btn_wrap">
   <div class="btn_wrap_pd">
      <button type="submit" class="btn btn_submit mr20" id="J_rights_form_btn">提交</button><a href="javascript:;" id="J_copy_rights">复制用户组权限</a>
   </div>
</div>

<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('ajaxForm', function(){
	Wind.js(GV.JS_ROOT+ 'pages/admin/common/rightsCpoy.js?v=' +GV.JS_VERSION);
});
</script>
</body>
</html>