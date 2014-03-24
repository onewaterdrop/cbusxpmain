<!--====================打卡弹窗=====================-->
<div class="core_pop_wrap" id="J_punch_friend_pop" data-max="<?php echo htmlspecialchars($friendNum, ENT_QUOTES, 'UTF-8');?>">
	<div class="core_pop">
		<div class="pop_help_punch">
		<form id="J_punch_friend_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=dofriend'; ?>" method="post" >
			<div class="pop_top J_drag_handle">
				<a href="#" class="pop_close J_punch_close">关闭</a>
				<strong>帮Ta打卡</strong>
			</div>
			<div class="">
				<div class="info">
					每帮一个好友打卡可获<span class="org"><?php echo htmlspecialchars($reward['cNum'], ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($reward['cUnit'], ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($reward['cType'], ENT_QUOTES, 'UTF-8');?></span>，最多选择<span class="org"><?php echo htmlspecialchars($friendNum, ENT_QUOTES, 'UTF-8');?>个好友</span>
					<div class="arrow"><em></em><span></span></div>
				</div>
				<?php  if ($follows) { ?>
				<div class="select_box">
					<div class="hd">
						<span>选择好友</span>
						<span>已选择</span>
					</div>
					<div class="ct cc">
						<div class="left">
							<dl class="current">
								<dt class="J_friend_dt" id="J_punch_dt_all" name="type" value="0" data-url="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=getfollow'; ?>">全部</dt>
								<?php  foreach ($follows as $k => $v) { ?>
								<dd id="J_firend_dd_<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" class="J_friend_item <?php echo htmlspecialchars($v['disable'], ENT_QUOTES, 'UTF-8');?>" data-name="friend" data-id="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['username'], ENT_QUOTES, 'UTF-8');?></dd>
								<?php  } ?>
								
							</dl>
							<?php  foreach ($typeArr as $k => $v) { ?>
							<dl>
								<dt class="J_friend_dt" data-name="type" data-id="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>" data-url="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=getfollow&type=', rawurlencode($k); ?>"><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></dt>						
							</dl>
							<?php  } ?>
						</div>
						<div class="right">
							<div class="arrow"><em></em><span></span></div>
							<ul class="cc" id="J_friend_selected"></ul>
						</div>
					</div>
				</div>
				<div class="pop_bottom">
					<input type="hidden" name="" id="J_type_id">
					<button type="submit" class="btn btn_submit disabled" id="J_punch_friend_sub" disabled="true">确认</button>
					<a href="#" class="btn J_punch_close">取消</a>
				</div>
			<?php  } else {?>
				<div class="select_box" style="height:238px;">
					<div style="padding:80px 0 0 80px;">
						<div class="not_content_mini">你还没有好友哦!</div>
					</div>
				</div>
			<?php  } ?>
			</div>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		</div>
	</div>
</div>