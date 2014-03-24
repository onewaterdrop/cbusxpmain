<div class="content">
	<div class="profile_nav">
		<ul>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=secret&_left=secret'; ?>">空间隐私</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=secret&a=black&_left=secret'; ?>">黑名单</a></li>
		</ul>
	</div>
	<form id="J_secret_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=secret&a=dorun'; ?>" method="post">
	<div class="profile_ct">
		<div class="tips mb15"><span class="tips_icon">设置可以浏览我空间的人，能查看我的哪些资料</span></div>
		<dl class="cc">
			<dt>谁能浏览我的空间：</dt>
			<dd>
				<select class="select_5" name="space">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['space']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
		  </dd>
		</dl>
		<h3>基本资料</h3>
		<dl class="cc">
			<dt>星座：</dt>
			<dd>
				<select class="select_5" name="constellation">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['constellation']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>现居住地：</dt>
			<dd>
				<select class="select_5" name="local">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['local']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>家乡：</dt>
			<dd>
				<select class="select_5" name="nation">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['nation']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<h3>联系方式</h3>
		<dl class="cc">
			<dt>阿里旺旺：</dt>
			<dd>
				<select class="select_5" name="aliwangwang">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['aliwangwang']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>QQ：</dt>
			<dd>
				<select class="select_5" name="qq">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['qq']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>MSN：</dt>
			<dd>
				<select class="select_5" name="msn">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['msn']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>手机：</dt>
			<dd>
				<select class="select_5" name="mobile">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret['mobile']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
	
		<h3>其它</h3>
		<?php  foreach($model AS $k=>$m): ?>	
		<dl class="cc">
			<dt><?php echo htmlspecialchars($m['title'], ENT_QUOTES, 'UTF-8');?>：</dt>
			<dd>
				<select class="select_5" name="<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>">
				<?php  foreach($option AS $key=>$value): ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $secret[$k]), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
				</select>
			</dd>
		</dl>
		<?php  endforeach; ?>
		
		<dl class="cc">
			<dt>&nbsp;</dt>
			<dd><button type="submit" class="btn btn_submit btn_big">提交</button></dd>
		</dl>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script>
Wind.ready(document, function(){
	Wind.use('jquery', 'global', 'ajaxForm', function(){
		//隐私提交
		$('#J_secret_form').ajaxForm({
			dataType : 'json',
			success : function(data){
				if(data.state == 'success') {
					Wind.Util.resultTip({
						msg : '修改成功'
					})
				}else if(data.state == 'fail') {
					Wind.Util.resultTip({
						error : true,
						msg : data.message
					});
				}
			}
		});
	});
});
</script>