<?php if (!function_exists("TPL_BBS_POST_POLL_DISPLAYPOSTPOLLHTML")) {function TPL_BBS_POST_POLL_DISPLAYPOSTPOLLHTML($vote){?>

<?php  $disabled = $vote->info['poll']['voter_num'] > 0 ? 'disabled' : ''; ?>
	<input type="hidden" name="poll_id" value="<?php echo htmlspecialchars($vote->info['poll_id'], ENT_QUOTES, 'UTF-8');?>">
	<div class="cc post_type">
		<div class="post_type_ct">
			<div class="post_vote_item">
			    <input type="hidden" id="J_vote_max_size" value="<?php echo htmlspecialchars($vote->post_max_size, ENT_QUOTES, 'UTF-8');?>">
				<input type="hidden" id="J_max_file_uploads" value="<?php echo htmlspecialchars($vote->max_file_uploads, ENT_QUOTES, 'UTF-8');?>">
				<h4>投票选项：</h4>
				<ul id="J_post_vote_list">
 <?php  if($vote->action == 'add') { ?>
 
					<li data-id="0">
						<input name="option[]" type="text" class="input length_5 fl" />
						<div class="icon_image_up fl">
							<a href="javascript:;" tabindex="-1">上传图片</a>
							<input class="J_vote_img" data-preview="#J_preview0" name="optionpic_0" type="file" title="可插入图片" tabindex="-1">
						</div>
						<div class="c"></div>
						<!--图片选择-->
						<div class="vote_preview" style="display:none;">
							<a href="" class="icon_del J_vicon_loc_del">删除</a>
							<img id="J_preview0" class="J_vote_preview_img" style="display:none;" width="120" height="120" />
						</div>
						<!--图片选择ie系列-->
						
						<!--结束-->
						
					</li>
					<li data-id="1">
						<input name="option[]" type="text" class="input length_5 fl" />
						<div class="icon_image_up fl">
							<a href="javascript:;" tabindex="-1">上传图片</a>
							<input class="J_vote_img" data-preview="#J_preview1" name="optionpic_1" type="file" title="可插入图片" tabindex="-1">
						</div>
						<!--图片选择-->
						<div class="c"></div>
						<div class="vote_preview" style="display:none;">
							<a href="" class="icon_del J_vicon_loc_del">删除</a>
							<img id="J_preview1" class="J_vote_preview_img" style="display:none;" width="120" height="120" />
						</div>
						<!--结束-->
						
					</li>
					
<?php  } elseif($vote->action == 'modify') { 
  foreach((array)$vote->info['option'] as $key=>$value) { ?>
					<li data-id="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>">
							<input name="option[<?php echo htmlspecialchars($value['option_id'], ENT_QUOTES, 'UTF-8');?>]" type="text" class="input length_5 fl" value = "<?php echo htmlspecialchars($value['content'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?>/>
							<div class="icon_image_up fl"><a href="javascript:;" tabindex="-1">上传图片</a>
								<input class="J_vote_img" data-preview="#J_preview<?php echo htmlspecialchars($value['option_id'], ENT_QUOTES, 'UTF-8');?>" name="optionpic_<?php echo htmlspecialchars($value['option_id'], ENT_QUOTES, 'UTF-8');?>" type="<?php echo htmlspecialchars($disabled ? 'input' : 'file', ENT_QUOTES, 'UTF-8');?>" title="<?php echo htmlspecialchars($disabled ? '' : '可插入图片', ENT_QUOTES, 'UTF-8');?>" tabindex="-1">
							</div>
							<?php  if (!$disabled) { ?>
								<a class="icon_del J_post_vote_del" data-saved="true" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=vote&a=deloption&pollid=', rawurlencode($vote->info['poll_id']),'&optionid=', rawurlencode($value['option_id']); ?>">删除</a>
 							<?php  } ?>
							<div class="c"></div>
							<?php  $value['image'] = $value['image'] ? Pw::getPath($value['image'], 1) : ''; ?>

							<div class="vote_preview" style="<?php  if (!$value['image']) { ?>display:none;<?php  } ?>">
								<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=vote&a=deloptionimg&pollid=', rawurlencode($vote->info['poll_id']),'&optionid=', rawurlencode($value['option_id']); ?>" class="icon_del J_vicon_saved_del">删除</a>
								<img id="J_preview<?php echo htmlspecialchars($value['option_id'], ENT_QUOTES, 'UTF-8');?>" class="vote_preview_img J_vote_preview_img" src="<?php echo htmlspecialchars($value['image'], ENT_QUOTES, 'UTF-8');?>" width="120" height="120" />
							</div>

					</li>
					<?php  } 
  } 
  if (!$disabled) { ?>

 					<li><a href="#" id="J_post_vote_add" data-role="<?php echo htmlspecialchars($vote->action, ENT_QUOTES, 'UTF-8');?>">+增加选项</a></li>
 <?php  } ?>

				</ul>
			</div>
		</div>
		<div class="post_type_sd">
			<h4 class="mb5 b">&nbsp;</h4>
			<ul class="post_type_operate">
			   
			    <li>
			    <em>是否多选：</em>
			    <label class="mr10"><input class="J_post_vote_radio" name="poll[ismultiple]" value="0" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?> type="radio" <?php echo htmlspecialchars(Pw::ifcheck($vote->info['poll']['ismultiple'] == 0), ENT_QUOTES, 'UTF-8');?>/>单选</label>
			    <label class="mr10"><input class="J_post_vote_radio" data-type="multiple" name="poll[ismultiple]" value="1" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?> type="radio" <?php echo htmlspecialchars(Pw::ifcheck($vote->info['poll']['ismultiple'] == 1), ENT_QUOTES, 'UTF-8');?>/>多选</label>
			    <?php  $display = $vote->info['poll']['ismultiple'] ? '' : 'display:none;' ?>
			    <span style="<?php echo htmlspecialchars($display, ENT_QUOTES, 'UTF-8');?>" id="J_post_vote_mcount"><input name="poll[optionlimit]" type="text" class="input mr5" size="4" value="<?php echo htmlspecialchars($vote->info['poll']['option_limit'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?>/>项</span>
			    </li>
				<li><em>有效天数：</em><input name="poll[expiredday]" type="text" class="input mr5" size="4" value="<?php echo htmlspecialchars($vote->info['poll']['expiredday'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?>/>天</li>
				
				<?php  $regtime_limit = $vote->info['poll']['regtime_limit'] ? @Pw::time2str($vote->info['poll']['regtime_limit'], 'Y-m-d') : '' ?>
				<li><em>注册时间：</em><input name="poll[regtimelimit]" type="text" class="input mr5 J_date" size="10" value="<?php echo htmlspecialchars($regtime_limit, ENT_QUOTES, 'UTF-8');?>" autocomplete="off" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?>/>前注册方可投票</li>
				
				<?php  $checked = ($vote->info['poll']['isafter_view']) ? 'checked' : ''; ?>
				<li><input id="isviewresult" name="poll[isviewresult]" type="checkbox" class="checkbox"  <?php echo htmlspecialchars($checked, ENT_QUOTES, 'UTF-8');?> value="1" <?php echo htmlspecialchars($disabled, ENT_QUOTES, 'UTF-8');?> /><label for="isviewresult">投票后才可见结果</label></li>
			</ul>
		</div>
	</div>

<?php }}?>