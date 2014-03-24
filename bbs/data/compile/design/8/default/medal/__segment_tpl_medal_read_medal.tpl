<?php if (!function_exists("TPL_MEDAL_READ_MEDAL_DISPLAYMEDALHTMLAFTERCONTENT")) {function TPL_MEDAL_READ_MEDAL_DISPLAYMEDALHTMLAFTERCONTENT($medals){?>

	<div class="medal">
		<ul class="cc">
			<?php  foreach ($medals as $medal) { ?>
			<li><a rel="nofollow" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><img src="<?php echo htmlspecialchars($medal['icon'], ENT_QUOTES, 'UTF-8');?>" title="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" alt="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></a></li>
			<?php  } ?>
		</ul>
	</div>

<?php }}?>