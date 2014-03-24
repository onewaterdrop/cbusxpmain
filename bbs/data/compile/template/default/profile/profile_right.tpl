<div id="J_profile_right" class="content">
	<div class="profile_nav">
		<ul>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=right'; ?>">权限</a></li>
		</ul>
	</div>
	<div class="management_group_list">
		<ul class="cc">
<?php if (count($switchGroups) > 1) {?>
			<li class="current fr" style="margin:0;padding:0;"><a href="" id="J_change_group">切换当前用户组</a></li>
<?php }?>
			<li><a class="J_right_toggle" data-id="J_right_my" href="">我的用户组</a><em class="core_arrow"></em></li>
<?php foreach ($showTypes as $key) {?>
			<li><a class="J_right_toggle"data-id="J_right_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" href=""><?php echo htmlspecialchars($groupTypes[$key]['name'], ENT_QUOTES, 'UTF-8');?></a><em class="core_arrow"></em></li>
<?php }?>
		</ul>
	</div>
	<div class="core_menu J_right_menus" style="margin:-2px 0 0 -15px;display:none" id="J_right_my">
		<div class="core_arrow_top"><em></em><span></span></div>
		<div class="core_menu_list">
			<ul class="cc">
<?php foreach ($myGroups as $_gid) {
	if (!$_gid) continue;
?>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=right&gid=', rawurlencode($_gid); ?>"><?php echo htmlspecialchars($allGroups[$_gid]['name'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php }?>
			</ul>
		</div>
	</div>
<?php foreach ($groupTypes as $_key => $_value) {
	if ($_key == 'default') continue;
?>
	<div class="core_menu J_right_menus" style="margin:-2px 0 0 -27px;display:none" id="J_right_<?php echo htmlspecialchars($_key, ENT_QUOTES, 'UTF-8');?>">
		<div class="core_arrow_top"><em></em><span></span></div>
		<div class="core_menu_list">
			<ul class="cc">
<?php foreach ($_value['sub'] as $_gid => $_gitem) {?>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=right&gid=', rawurlencode($_gid); ?>"><?php echo htmlspecialchars($_gitem['name'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php }?>
			</ul>
		</div>
	</div>
<?php 
}
if ($compare) {
	$class = 'my_group_contrast';
}
?>
	<div class="my_group cc <?php echo htmlspecialchars($class, ENT_QUOTES, 'UTF-8');?>">
		<div class="type">
			<h2>&nbsp;</h2>
			<ul>
				<li></li>
<?php foreach ($categorys as $_cat => $_items) {?>
				<li class="hd"><?php echo htmlspecialchars($_items['name'], ENT_QUOTES, 'UTF-8');?></li>
<?php foreach ($_items['sub'] as $_sub) {?>
				<li><?php echo htmlspecialchars($myGroupPermission[$_sub]['name'], ENT_QUOTES, 'UTF-8');?></li>
<?php }}?>
			</ul>
		</div>
		<div class="current">
			<h2>我当前的用户组 - <?php echo htmlspecialchars($allGroups[$loginUser->gid]['name'], ENT_QUOTES, 'UTF-8');?></h2>
			<ul>
				<li>我的积分<?php echo htmlspecialchars($myCredit, ENT_QUOTES, 'UTF-8');?></li>
<?php foreach ($categorys as $_cat => $_items) {?>
				<li class="hd">&nbsp;</li>
<?php foreach ($_items['sub'] as $_sub) {
	$cont = $myGroupPermission[$_sub]['value'];
	if ('radio' == $myGroupPermission[$_sub]['type']) {
		$cont = ($cont) ? '<span class="correct_span">支持</span>' : '<span class="error_span">不支持</span>';
	} elseif (!$cont) {
		$cont = '不限';
	}
?>
				<li><?php echo $cont;?></li>
<?php }}?>
			</ul>
		</div>
<?php if ($compare) {?>
		<div class="contrast">
			<h2><?php echo htmlspecialchars($groupTypes[$allGroups[$comparegid]['type']]['name'], ENT_QUOTES, 'UTF-8');?> - <?php echo htmlspecialchars($allGroups[$comparegid]['name'], ENT_QUOTES, 'UTF-8');?></h2>
			<ul>
				<li><?php if ('member' == $allGroups[$comparegid]['type']) {?>升级所需积分<?php echo htmlspecialchars($allGroups[$comparegid]['points'], ENT_QUOTES, 'UTF-8');
 }?></li>
<?php foreach ($categorys as $_cat => $_items) {?>
				<li class="hd">&nbsp;</li>
<?php foreach ($_items['sub'] as $_sub) {
	$cont = $compareGroupPermission[$_sub]['value'];
	if ('radio' == $myGroupPermission[$_sub]['type']) {
		$cont = ($cont) ? '<span class="correct_span">支持</span>' : '<span class="error_span">不支持</span>';
	} elseif (!$cont) {
		$cont = '不限';
	}
?>
				<li><?php echo $cont;?></li>
<?php }}?>
			</ul>
		</div>
<?php }?>
	</div>
<?php if (count($switchGroups) > 1) {?>
<!--切换用户组弹窗-->
	<div id="J_change_group_pop" class="core_pop_wrap" style="display:none;">
		<div class="core_pop">
			<div class="pop_group_select">
			    <form id="J_change_group_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=right&a=doset'; ?>" method="post">
				<div class="pop_top">
					<a href="" class="pop_close" id="J_change_group_close">关闭</a>
					<strong>切换当前用户组</strong>
				</div>
				<div class="pop_cont">
					<ul class="cc">
<?php foreach ($switchGroups as $_gid) {?>
						<li><label><input type="radio" value='<?php echo htmlspecialchars($_gid, ENT_QUOTES, 'UTF-8');?>' name='gid' <?php echo htmlspecialchars(Pw::ifcheck($_gid == $loginUser->gid), ENT_QUOTES, 'UTF-8');?>/><span><?php echo htmlspecialchars($allGroups[$_gid]['name'], ENT_QUOTES, 'UTF-8');?></span></label></li>
<?php }?>
					</ul>
				</div>
				<div class="pop_bottom">
					<button type="submit" class="btn btn_submit" id="J_change_group_sub">提交</button>
				</div>
				<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
			</div>
		</div>
	</div>
<?php }?>
</div>
<script>
//core.js
Wind.ready(document, function(){
	//引入js组件
	Wind.use('jquery', 'global', GV.JS_ROOT +'pages/profile/profileRights.js?v=' +GV.JS_VERSION);
});
</script>