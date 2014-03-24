<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_CONTENT_LENGTH_RANGE")) {function PERMISSION_HTML_SEGMENTS_CONTENT_LENGTH_RANGE($pKey,$pData){?>
<!--
自定义模板的权限点配置文件
 name="权限点标识" args="权限点标识,权限点配置信息array('default'=>'默认值','config'=>'配置信息')"
-->

	<input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][min]" value="<?php echo htmlspecialchars($pData['default']['min'], ENT_QUOTES, 'UTF-8');?>" class="input mr5"><span class="mr5">至</span><input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][max]" value="<?php echo htmlspecialchars($pData['default']['max'], ENT_QUOTES, 'UTF-8');?>" class="input mr5"><?php echo htmlspecialchars($pData['config'][4], ENT_QUOTES, 'UTF-8');?>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_SELL_CREDITS")) {function PERMISSION_HTML_SEGMENTS_SELL_CREDITS($pKey,$pData){?>



	<?php  
		Wind::import('SRV:credit.bo.PwCreditBo');
		$creditBo = PwCreditBo::getInstance();
	?>
	<ul class="three_list cc">
	<?php  foreach ($creditBo->cType as $k => $v) { ?>
			<li><label><input<?php echo htmlspecialchars(Pw::ifcheck(in_array($k, $pData['default'])), ENT_QUOTES, 'UTF-8');?> type="checkbox" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></label></li>
	<?php  } ?>
	</ul>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_SELL_CREDIT_RANGE")) {function PERMISSION_HTML_SEGMENTS_SELL_CREDIT_RANGE($pKey,$pData){?>



	<div class="mb5"><input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][maxprice]" value="<?php echo htmlspecialchars($pData['default']['maxprice'], ENT_QUOTES, 'UTF-8');?>" class="input mr5">最高单价限制</div>
	<div><input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][maxincome]" value="<?php echo htmlspecialchars($pData['default']['maxincome'], ENT_QUOTES, 'UTF-8');?>" class="input mr5">最高收入限制</div>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_SIGN_COST")) {function PERMISSION_HTML_SEGMENTS_SIGN_COST($pKey,$pData){?>



	<?php  
		Wind::import('SRV:credit.bo.PwCreditBo');
		$creditBo = PwCreditBo::getInstance();
	?>
	<input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][costs]" value="<?php echo htmlspecialchars($pData['default']['costs'], ENT_QUOTES, 'UTF-8');?>" class="input length3 mr5">
	<select name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][creditid]" class="select_2">
	<?php  foreach ($creditBo->cType as $k => $v) { ?>
	 	<option value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"{Pw::isSelected($k == $pData['default']['creditid'])}><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></option>
	<?php  } ?>
	</select>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_ENHIDE_CREDITS")) {function PERMISSION_HTML_SEGMENTS_ENHIDE_CREDITS($pKey,$pData){?>



	<?php  
		Wind::import('SRV:credit.bo.PwCreditBo');
		$creditBo = PwCreditBo::getInstance();
	 ?>
	<ul class="three_list cc">
	<?php  foreach ($creditBo->cType as $k => $v) { ?>
		<li><label><input<?php echo htmlspecialchars(Pw::ifcheck(in_array($k, $pData['default'])), ENT_QUOTES, 'UTF-8');?> type="checkbox" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"><span><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></span></label></li>
	<?php  } ?>
	</ul>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_OPERATE_THREAD")) {function PERMISSION_HTML_SEGMENTS_OPERATE_THREAD($pKey,$pData){?>



	<ul class="three_list cc">
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][digest]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['digest']), ENT_QUOTES, 'UTF-8');?>>精华</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][highlight]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['highlight']), ENT_QUOTES, 'UTF-8');?>>加亮</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][type]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['type']), ENT_QUOTES, 'UTF-8');?>>分类</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][move]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['move']), ENT_QUOTES, 'UTF-8');?>>移动</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][read]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['read']), ENT_QUOTES, 'UTF-8');?>>已阅</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][edit]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['edit']), ENT_QUOTES, 'UTF-8');?>>编辑</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][copy]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['copy']), ENT_QUOTES, 'UTF-8');?>>复制</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][delete]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['delete']), ENT_QUOTES, 'UTF-8');?>>删除</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][lock]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['lock']), ENT_QUOTES, 'UTF-8');?>>锁定</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][down]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['down']), ENT_QUOTES, 'UTF-8');?>>压帖</label></li>
		<!-- <li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][unite]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['unite']), ENT_QUOTES, 'UTF-8');?>>合并</label></li> -->
		<!-- <li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][split]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['split']), ENT_QUOTES, 'UTF-8');?>>拆分</label></li> -->
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][shield]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['shield']), ENT_QUOTES, 'UTF-8');?>>屏蔽</label></li>
		<!-- <li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][remind]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['remind']), ENT_QUOTES, 'UTF-8');?>>提醒</label></li> -->
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][deleteatt]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['deleteatt']), ENT_QUOTES, 'UTF-8');?>>删除附件</label></li>
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][toppedreply]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['toppedreply']), ENT_QUOTES, 'UTF-8');?>>帖内置顶</label></li>
		<!-- <li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][print]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['print']), ENT_QUOTES, 'UTF-8');?>>帖子印戳</label></li> -->
		<li><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][ban]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['ban']), ENT_QUOTES, 'UTF-8');?>>禁止</label></li>
	</ul>
	<div class="about_list">
		<dl class="cc">
			<dt><label><input type="checkbox" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][up]" value="1" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['up']), ENT_QUOTES, 'UTF-8');?>>提前</label></dt>
			<dd><input type="number" class="input length_2 mr5" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][up_time]" value="<?php echo htmlspecialchars($pData['default']['up_time'], ENT_QUOTES, 'UTF-8');?>">小时</dd>
		</dl>
		<dl class="cc">
			<dt><label><input type="checkbox" value="1" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][topped]" <?php echo htmlspecialchars(Pw::ifcheck($pData['default']['topped']), ENT_QUOTES, 'UTF-8');?>>置顶</label></dt>
			<dd class="fl">
				<p><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][topped_type]" value="1" <?php  if($pData['default']['topped_type'] <= 1){ ?> checked<?php  } ?>>版块置顶</label>当前版块以及下级版块置顶</p>
				<p><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][topped_type]" value="2" <?php  if($pData['default']['topped_type'] == 2){ ?> checked<?php  } ?>>分类置顶</label>当前版块分类以及下级版块置顶</p>
				<p><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][topped_type]" value="3" <?php  if($pData['default']['topped_type'] == 3){ ?> checked<?php  } ?>>全局置顶</label>所有版块置顶</p>
			</dd>
		</dl>
	</div>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_DESIGN_ALLOW_MANAGE")) {function PERMISSION_HTML_SEGMENTS_DESIGN_ALLOW_MANAGE($pKey,$pData){?>



	<ul class="three_list cc">
		<li><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][push]" value="4" <?php echo htmlspecialchars(Pw::ifcheck(4 == $pData['default']['push']), ENT_QUOTES, 'UTF-8');?>><span>门户设计</span></label></li>
	</ul>
	<ul class="three_list cc">
		<li><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][push]" value="3" <?php echo htmlspecialchars(Pw::ifcheck(3 == $pData['default']['push']), ENT_QUOTES, 'UTF-8');?>><span>编辑模块</span></label></li>
	</ul>
	<ul class="three_list cc">
		<li><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][push]" value="2" <?php echo htmlspecialchars(Pw::ifcheck(2 == $pData['default']['push']), ENT_QUOTES, 'UTF-8');?>><span>管理内容</span></label></li>
	</ul>
	<ul class="three_list cc">
		<li><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][push]" value="1" <?php echo htmlspecialchars(Pw::ifcheck(1 == $pData['default']['push']), ENT_QUOTES, 'UTF-8');?>><span>推送内容需审核</span></label></li>
	</ul>
	<ul class="three_list cc">
		<li><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][push]" value="0" <?php echo htmlspecialchars(Pw::ifcheck(!$pData['default']['push']), ENT_QUOTES, 'UTF-8');?>><span>无操作权限</span></label></li>
	</ul>

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_THREAD_EDIT_TIME")) {function PERMISSION_HTML_SEGMENTS_THREAD_EDIT_TIME($pKey,$pData){?>



	<input type="text" class="input length_5 mr5" value="<?php echo htmlspecialchars($pData['default'], ENT_QUOTES, 'UTF-8');?>" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>]"> 分钟

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_POST_PERTIME")) {function PERMISSION_HTML_SEGMENTS_POST_PERTIME($pKey,$pData){?>



	<input type="text" class="input length_5 mr5" value="<?php echo htmlspecialchars($pData['default'], ENT_QUOTES, 'UTF-8');?>" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>]"> 秒

<?php }}?>
<?php if (!function_exists("PERMISSION_HTML_SEGMENTS_POST_MODIFY_TIME")) {function PERMISSION_HTML_SEGMENTS_POST_MODIFY_TIME($pKey,$pData){?>



	<input type="text" class="input length_5 mr5" value="<?php echo htmlspecialchars($pData['default'], ENT_QUOTES, 'UTF-8');?>" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>]"> 分钟

<?php }}?>