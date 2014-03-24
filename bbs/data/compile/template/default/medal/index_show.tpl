
		<form action="#" method="post" class="J_medal_pop_form">
			<dl class="cc">
				<dt id="J_medal_pop_img"><img src="<?php echo htmlspecialchars($medal['image'], ENT_QUOTES, 'UTF-8');?>" width="96" height="96"></dt>
					<dd>
						<p><span class="name mr5" id="J_medal_pop_name"><?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?></span>
						<?php  if($log['award_status'] < 3): 
  if (!$isAward) :?><span class="tips_icon_error f12">您当前的用户组不支持领取该勋章。</span><?php  endif;
  endif;?>
						</p>
						<p class="type">勋章类型：<?php  if($medal['receive_type'] == 1): ?>自动勋章<?php  else:?>手动勋章<?php  endif;?></p>
						<p style="" id="J_medal_pop_time_row">有效时长： <?php echo htmlspecialchars($medal['expired'], ENT_QUOTES, 'UTF-8');?></p>
						<p class="descrip">勋章描述： <?php echo htmlspecialchars($medal['descrip'], ENT_QUOTES, 'UTF-8');?></p>
						<?php  if($pop == 'wei' && $medal['award_condition'] && $log['award_status'] < 2): 
							$_show = $medal['behavior'] >= $medal['award_condition'] ? $medal['award_condition'] - 1 : $medal['behavior'];
						?>
						<p>当前进度： <?php echo htmlspecialchars($_show, ENT_QUOTES, 'UTF-8');?>/<?php echo htmlspecialchars($medal['award_condition'], ENT_QUOTES, 'UTF-8');?></p>
						<?php  endif;
  if ($groupName) :?>
						<p>可领取勋章用户组： <?php echo htmlspecialchars($groupName, ENT_QUOTES, 'UTF-8');?></p>
						<?php  endif;?>
					</dd>
			</dl>
			<?php  if($log['award_status'] == 3): ?>
			<textarea name="content">我获得了“<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>”勋章。现在有<?php echo htmlspecialchars($count, ENT_QUOTES, 'UTF-8');?>个勋章啦，赶紧去领勋章，比比谁的多！[url=<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>]查看[/url]</textarea>
			
			<div class="operate">
				<button data-action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal&a=doAward'; ?>" class="btn btn_success btn_big" type="submit">领取勋章</button><label>
				<input type="checkbox" value="1" checked="checked" name="isfresh">告诉我的粉丝</label>
			</div>
			<?php  elseif($log['award_status'] < 2 && $medal['receive_type'] == 1):?>
			<div class="tac">
				<button class="btn btn_big J_close" type="button">关闭</button>
			</div>
			<?php  elseif($log['award_status'] == 2):?>
			<div class="tac">
				<button disabled class="btn btn_big disabled" type="button">已申请</button>
			</div>
			<?php  elseif($isAward && $log['award_status'] < 2 && $medal['receive_type'] == 2):?>
			<div class="tac" >
				<button data-action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal&a=doApply'; ?>" class="btn btn_big btn_success" type="submit">申请</button>
			</div>
			<?php  else: ?>
			<div class="tac">
				<button class="btn btn_big J_close" type="button">关闭</button>
			</div>
			<?php  endif;?>
				<input type="hidden" value="<?php echo htmlspecialchars($medal['medal_id'], ENT_QUOTES, 'UTF-8');?>" name="medalid">
				<input type="hidden" value="<?php echo htmlspecialchars($log['log_id'], ENT_QUOTES, 'UTF-8');?>" name="logid">
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
