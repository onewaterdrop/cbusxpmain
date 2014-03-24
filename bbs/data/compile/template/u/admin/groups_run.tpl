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
	<ul class="cc">
		<li<?php echo $typeClasses['member'];?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=member&m=u&c=groups'; ?>">会员组</a></li>
		<li<?php echo $typeClasses['special'];?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=special&m=u&c=groups'; ?>">特殊组</a></li>
		<li<?php echo $typeClasses['system'];?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=system&m=u&c=groups'; ?>">管理组</a></li>
		<li<?php echo $typeClasses['default'];?>><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=default&m=u&c=groups'; ?>">默认组</a></li>
	</ul>
</div>

<form class="J_ajaxForm" data-role="list" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=groups&a=dosave'; ?>" method="post">
<input type="hidden" name="grouptype" value="<?php echo htmlspecialchars($groupType, ENT_QUOTES, 'UTF-8');?>" />
<div class="table_list">
	<table width="100%" id="J_group_table">
		<col width="50">
		<col width="210">
		<col width="150">
		<thead>
			<tr>
				<td>编号</td>
				<td>头衔</td>
				<td>用户组图标</td>
				<?php  if ($groupType == 'member') { ?>
				<td width="200">升级点数需求</td>
				<?php  } ?>
				<td>操作</td>
			</tr>
		</thead>
		<tbody id="J_groupList">
		<?php  
			foreach ($groups as $group) {
		?>
		<tr>
			<td><?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?></td>
			<td><input type="text" class="input length_3" name="groupname[<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?>"></td>
			<td class="cp J_set_icon">
				<img src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/level/<?php echo htmlspecialchars($group['image'], ENT_QUOTES, 'UTF-8');?>">
				<input type="hidden" name="groupimage[<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($group['image'], ENT_QUOTES, 'UTF-8');?>" />
			</td>
			<?php  if ($groupType == 'member') { 
				$next = next($points);
			?>
			<td><input type="number" class="input length_2" name="grouppoints[<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($group['points'], ENT_QUOTES, 'UTF-8');?>"> ~ <span><?php echo htmlspecialchars($next, ENT_QUOTES, 'UTF-8');?></span></td>
			<?php  } ?>
			<td>
				<?php  if ($groupType == 'special' || $groupType == 'system') { ?>
				<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?gid=', rawurlencode($group['gid']),'&m=u&c=groups&a=edit'; ?>" class="mr10">[基本权限]</a>
				<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?manage=1&gid=', rawurlencode($group['gid']),'&m=u&c=groups&a=edit'; ?>" class="mr10">[管理权限]</a>
				<?php  } else { ?>
				<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?gid=', rawurlencode($group['gid']),'&m=u&c=groups&a=edit'; ?>" class="mr10">[编辑]</a>
				<?php  } 
  if ($group['gid'] > 7) { ?>
				<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?gid=', rawurlencode($group['gid']),'&m=u&c=groups&a=delete'; ?>" class="mr10 J_ajax_del">[删除]</a>
				<?php  } ?>
			</td>
		</tr>
		<?php  } ?>
		</tbody>
		<?php  if ($groupType != 'default') { ?>
		<tbody id="J_groups_add_temp">
			<tr>
				<td></td>
				<td><input id="J_new_group_name" type="text" class="input length_3" name="newgroupname[]"></td>
				<td class="cp J_set_icon"><img id="J_new_group_icon" data-org="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/level/0.gif" src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/level/0.gif"><input id="J_new_group_icon_input" type="hidden" name="newgroupimage[]" value="0.gif" /></td>
				<?php  if ($groupType == 'member') { ?>
				<td><input id="J_new_group_points" type="number" class="input length_2" name="newgrouppoints[]"></td>
				<?php  } ?>
				<td><a id="J_inset_new_group" href="" class="link_add">添加</a></td>
			</tr>
		</tbody>
		
		<?php  } ?>
	</table>
</div>
<div class="btn_wrap">
	<div class="btn_wrap_pd" id="J_sub_wrap">
   <button type="submit" class="btn btn_submit J_ajax_submit_btn">提交</button>
	</div>
</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

<div class="core_pop_wrap" id="J_icon_pop" style="display:none;">
<div class="core_pop">
	<div style="width:400px;">
	<div class="pop_top J_drag_handle">
		<a href="#" class="pop_close" id="J_icon_pop_close">关闭</a>
		<strong>等级图标</strong>
	</div>
	<div class="pop_cont" style="padding:3px 15px 18px;">
		<ul class="double_list cc">
		<?php  foreach($imageFiles as $v){ ?>
			<li><a href="#" class="J_insert_icon" data-name="<?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?>"><img src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/level/<?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?>" align="absmiddle"></a></li>
		<?php  } ?>
		</ul>
	</div>
	</div>
</div>
</div>


</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('draggable', function(){
	var group_list = $('#J_groupList');
	
	//添加新组
	$('#J_inset_new_group').click(function(e){
		e.preventDefault();
		var new_group_name = $('#J_new_group_name'),
			new_group_icon = $('#J_new_group_icon'),
			new_group_icon_input = $('#J_new_group_icon_input'),
			new_group_points = $('#J_new_group_points');

		if (!(new_group_name.val().replace(/\s/g, ''))) {
			new_group_name.focus();
			return false;
		}
		new_group_html = '<tr class="ct">\
			<td></td>\
			<td><input type="text" value="'+ new_group_name.val() +'" name="newgroupname[]" class="input length_3"></td>\
			<td class="cp J_set_icon"><img src="'+ new_group_icon.attr('src') +'"><input type="hidden" value="'+ new_group_icon_input.val() +'" name="newgroupimage[]"></td>'+ ( new_group_points.length ? '<td><input type="number" value="'+ new_group_points.val() +'" name="newgrouppoints[]" class="input length_2"></td>' : '' ) +'<td>\
				<a class="mr10 J_new_group_del" href="">[删除]</a>\
			</td>\
		</tr>';
		group_list.append(new_group_html);
		new_group_name.val('');
		new_group_icon.attr('src', new_group_icon.data('org'));
		new_group_icon_input.val('0.gif');
		new_group_points.val('');
	});
	
	//删除未提交的组
	Wind.use('dialog',function() {
		group_list.on('click', 'a.J_new_group_del', function(e) {
			e.preventDefault();
			var $this = $(this);
			Wind.dialog.confirm('确定要删除吗？',function() {
				$this.parents('tr.ct').fadeOut('fast', function(){
					$(this).remove();
				});
			})
		});
	});

	//设置等级图标
	var icon_pop = $('#J_icon_pop');
	$('#J_group_table').on('click', '.J_set_icon', function(e){
		e.preventDefault();
		var $this = $(this),
				icon = $this.children('img');
		//common.js
		popPos(icon_pop);

		icon_pop.draggable( { handle : '.J_drag_handle'} );

		$('a.J_insert_icon').off('click').on('click', function(e){
			e.preventDefault();
			icon.attr('src', $(this).children().attr('src'));
			$this.find('input:hidden').val($(this).data('name'));
			icon_pop.hide();
		});
	});

	//关闭
	$('#J_icon_pop_close').on('click', function(e){
		e.preventDefault();
		icon_pop.hide();
	});
})
</script>
</body>
</html>