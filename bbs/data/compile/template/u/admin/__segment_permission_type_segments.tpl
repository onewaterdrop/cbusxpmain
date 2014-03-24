<?php if (!function_exists("PERMISSION_TYPE_SEGMENTS_INPUT")) {function PERMISSION_TYPE_SEGMENTS_INPUT($pKey,$pData){?>

	<input type="text" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($pData['default'], ENT_QUOTES, 'UTF-8');?>" class="input length_5 mr5"><?php echo htmlspecialchars($pData['config'][4], ENT_QUOTES, 'UTF-8');?>

<?php }}?>
<?php if (!function_exists("PERMISSION_TYPE_SEGMENTS_RADIO")) {function PERMISSION_TYPE_SEGMENTS_RADIO($pKey,$pData){?>



	<?php  
		$style = ($pData['config'][5] && $pData['config'][5] == 'vertical') ? 'single_list' : 'switch_list';
		$items = $pData['config'][4];
		$items or $items = array(1 => '开启', 0 => '关闭');
	?>
	<ul class="<?php echo htmlspecialchars($style, ENT_QUOTES, 'UTF-8');?> cc">
	<?php  foreach ($items as $k => $v) { ?>
		<li class="<?php echo htmlspecialchars(Pw::isCurrent($pData['default'] == $k), ENT_QUOTES, 'UTF-8');?>"><label><input type="radio" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>]" value="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"<?php echo htmlspecialchars(Pw::ifcheck($pData['default'] == $k), ENT_QUOTES, 'UTF-8');?>><span><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></span></label></li>
	<?php  } ?>
	</ul>

<?php }}?>
<?php if (!function_exists("PERMISSION_TYPE_SEGMENTS_CHECKBOX")) {function PERMISSION_TYPE_SEGMENTS_CHECKBOX($pKey,$pData){?>



	<ul class="three_list cc">
	<?php  
		$items = $pData['config'][4];
		foreach ($items as $k => $v) {
	?>
		<li><label><input type="checkbox" name="gpermission[<?php echo htmlspecialchars($pKey, ENT_QUOTES, 'UTF-8');?>][<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>]" value="1"<?php echo htmlspecialchars(Pw::ifcheck($pData['default'][$k]), ENT_QUOTES, 'UTF-8');?>><span><?php echo htmlspecialchars($v, ENT_QUOTES, 'UTF-8');?></span></label></li>
	<?php  } ?>
	</ul>

<?php }}?>