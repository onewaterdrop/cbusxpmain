<?php if (!function_exists("NOTICE_SEGMENT_DEFAULT_MINILIST")) {function NOTICE_SEGMENT_DEFAULT_MINILIST($v){?>
<!--默认通知页面-->

<!--弹窗列表-->
	<dl class="notice_segment_list cc">
		<dt class="notice_tip_icon">
			<?php  if (!$v['is_read']) { ?>
			<span class="icon_system_new J_unread_icon" title="未读">[未读]</span>
			<?php  } else { ?>
			<span class="icon_system" title="已读">[已读]</span>
			<?php  } ?>
		</dt>
		<dd class="notice_segment_cont">
			<div class="summary">
				<?php echo $v['title'];?>
			</div>
			<div class="time"><?php  echo Pw::time2str($v['modified_time'],'auto');?></div>
		</dd>
	</dl>

<?php }}?>
<?php if (!function_exists("NOTICE_SEGMENT_DEFAULT_DETAIL")) {function NOTICE_SEGMENT_DEFAULT_DETAIL($detailList,$notice,$prevNotice,$nextNotice){?>



<!--弹窗详情-->
	<div class="my_message_top" id="J_hm_top">
	<span class="fr">
		<span>
		<?php  if ($prevNotice) { ?>
		<a class="J_hm_page" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=detail&id=', rawurlencode($prevNotice['id']); ?>">&lt;&nbsp;前一条</a>
		<?php  } else { ?>
		&lt;&nbsp;前一条
		<?php  } ?>
		</span><i>|</i>
		<?php  if ($nextNotice) { ?>
		<a class="J_hm_page" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=detail&id=', rawurlencode($nextNotice['id']); ?>">后一条&nbsp;&gt;</a>
		<?php  } else { ?>
		后一条&nbsp;&gt;
		<?php  } ?>
		</span>
	<a class="J_hm_back" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=minilist'; ?>">&lt;&lt;&nbsp;返回</a>
</div>
	<div class="notice_segment_wrap">
		<dl class="notice_segment_list cc">
			<dt class="notice_tip_icon">
				<span class="icon_system" title="已读">[已读]</span>
			</dt>
			<dd class="notice_segment_cont">
				<div class="summary">
					<?php echo $notice['extend_params']['content'];?>
				</div>
				<div class="time"><?php  echo Pw::time2str($notice['modified_time'],'auto');?></div>
			</dd>
		</dl>
	</div>
	<div class="my_message_bottom">
		<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&type=', rawurlencode($notice['typeid']); ?>">查看全部默认通知&nbsp;&gt;&gt;</a>
	</div>

<?php }}?>
<?php if (!function_exists("NOTICE_SEGMENT_DEFAULT_LIST")) {function NOTICE_SEGMENT_DEFAULT_LIST($v){?>



<!--页列表-->
	<div class="ct cc J_notice_item">
		<div class="check"><input name="ids[]" class="J_check" type="checkbox" value="<?php echo htmlspecialchars($v['id'], ENT_QUOTES, 'UTF-8');?>" style="display:none;"></div>
		<div class="content">
			<?php  
				if ($v['title'] != $v['extend_params']['content'] && Pw::strlen($v['extend_params']['content']) > 49){
			 ?>
			<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=detaillist&id=', rawurlencode($v['id']); ?>" class="open_up J_notice_show" data-role="down">展开&darr;</a>
			<?php 
				} 
			 ?>
			<div class="title J_notice_part">
				<span class="notice_tip_icon">
				<?php  if (!$v['is_read']) { ?>
				<span class="icon_system_new" title="未读"></span>
				<?php  } else { ?>
				<span class="icon_system" title="已读"></span>
				<?php  } ?>
				</span><?php echo $v['title'];?>
			</div>
			<div class="title J_notice_all" style="display:none;"></div>
			<div class="info">
				<span class="time"><?php  echo Pw::time2str($v['modified_time'],'auto');?></span>
				<span class="operating"><span class="line">|</span><a class="J_msg_del" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=delete&id=', rawurlencode($v['id']); ?>">删除</a></span>
			</div>
		</div>
	</div>

<?php }}?>
<?php if (!function_exists("NOTICE_SEGMENT_DEFAULT_DETAILLIST")) {function NOTICE_SEGMENT_DEFAULT_DETAILLIST($detailList,$notice){?>



<!--页详情-->
	<span class="notice_tip_icon">
	<?php  if (!$notice['is_read']) { ?>
	<span class="icon_system_new" title="未读"></span>
	<?php  } else { ?>
	<span class="icon_system" title="已读"></span>
	<?php  } ?>
	</span><?php echo $notice['extend_params']['content'];?>
	<!-- div class="io"><span class="time"><?php  echo Pw::time2str($notice['modified_time'],'auto');?></span></div> -->

<?php }}?>