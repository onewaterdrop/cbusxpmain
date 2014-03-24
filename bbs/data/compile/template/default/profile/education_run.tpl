<div class="content">
	<div class="profile_nav">
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=secret&_left=secret'; ?>" class="fr a_privacy">隐私设置</a>
	<ul>
<?php foreach ($_tabs as $key => $_item) {
	if (isset($_item['url']) && $_item['url']) {
?>
		<li class="<?php echo htmlspecialchars($_item['current'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo WindUrlHelper::createUrl($_item['url'], array('_tab' => $key));?>"><?php echo htmlspecialchars($_item['title'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php } else { ?>
		<li class="<?php echo htmlspecialchars($_item['current'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=extends&_left=profile&_tab=', rawurlencode($key); ?>"><?php echo htmlspecialchars($_item['title'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php 
	}
}?>
	</ul>
</div>
	<div class="profile_educat">
		<ul id="J_edu_list">
			<li class="hd">
				<span class="fr"><button type="button" id="J_edu_add" class="btn btn_submit fn f12">+添加教育经历</button></span>
				<span class="edu">学历</span>
				<span class="unit">学校名称</span>
				<span class="time">入学年份</span>
			</li>
<?php  if ($list) { 
 foreach ($list as $id => $item) {?>
			<li>
				<span class="fr"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=education&a=edit&id=', rawurlencode($id); ?>" data-pid="<?php echo htmlspecialchars($item['areaid'][0], ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($item['areaid'][1], ENT_QUOTES, 'UTF-8');?>" data-did="<?php echo htmlspecialchars($item['areaid'][2], ENT_QUOTES, 'UTF-8');?>" data-degreeid="<?php echo htmlspecialchars($item['degreeid'], ENT_QUOTES, 'UTF-8');?>" data-school="<?php echo htmlspecialchars($item['school'], ENT_QUOTES, 'UTF-8');?>" data-schoolid="<?php echo htmlspecialchars($item['schoolid'], ENT_QUOTES, 'UTF-8');?>" data-startyear="<?php echo htmlspecialchars($item['start_time'], ENT_QUOTES, 'UTF-8');?>" class="mr20 J_school_edit">编辑</a><a href="<?php echo WindUrlHelper::createUrl('profile/education/delete?id=' . $id . '&page=' . $page, $args);?>" class="J_edu_del">删除</a></span>
				<span class="edu"><?php echo htmlspecialchars($item['degree'], ENT_QUOTES, 'UTF-8');?></span>
				<span class="unit"><?php echo htmlspecialchars($item['school'], ENT_QUOTES, 'UTF-8');?></span>
				<span class="time"><?php echo htmlspecialchars($item['start_time'], ENT_QUOTES, 'UTF-8');?>年</span>
			</li>
	<?php }
  } else { ?>
			<li class="tac p20" id="J_work_none">你还没添加教育经历，<a href="#" class="s4" id="J_edu_add_trigger">立即添加&gt;&gt;</a></li>
<?php  } ?>
			<li id="J_edu_op_wrap" style="display:none;">
				<form id="J_edu_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=education&a=add'; ?>" method="post">
					<span class="fr"><button type="submit" id="J_edu_save" class="btn btn_submit mr20">保存</button><a href="" id="J_edu_cancl">取消</a></span>
					<span class="edu">
					<select class="select_2" id="J_edu_select" name="degree">
					<?php foreach ($degrees as $key => $value) {?>
					<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key === 5), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
					<?php }?></select></span>
					<span class="unit"><input type="text" class="input length_3 J_plugin_school" data-typeid="3" name="school" readonly="true" />
						<input id="J_edit_id" type="hidden" name="schoolid" value=""/></span>
					<span class="time"><select id="J_startyear" class="select_2" name="startYear">
					<option value="">入学年份</option>
					<?php foreach ($years as $var) {?>
					<option value="<?php echo htmlspecialchars($var, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($var, ENT_QUOTES, 'UTF-8');?></option>
					<?php }?></select></span>
				<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
			</li>
		</ul>
	</div>
</div>
<script>
var URL_EDU_ADD = "<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=education&a=add'; ?>",
	URL_EDU_EDIT = "<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=education&a=edit'; ?>";
Wind.ready(document, function(){
	Wind.use('jquery', 'global', GV.JS_ROOT +'pages/profile/profileEducation.js?v=' +GV.JS_VERSION);
});
</script>
