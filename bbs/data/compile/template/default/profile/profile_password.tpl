<div class="content">
	<div class="profile_nav">
		<ul>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password'; ?>">修改密码</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password&a=question'; ?>">安全问题设置</a></li>
		</ul>
	</div>
	<form id="J_pw_edit" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password&a=edit'; ?>" method="post">
	<div class="profile_ct password_list">
		<dl class="cc">
			<dt>原密码：</dt>
			<dd><span class="must_red">*</span><input id="J_old_pwd" data-checkurl="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password&a=checkOldPwd'; ?>" type="password" name="oldPwd" value="" class="input length_5"><span id="J_tip_oldPwd"></span></dd>
		</dl>
		<dl class="cc">
			<dt>新密码：</dt>
			<dd><input data-tips="<?php echo htmlspecialchars($pwdReg, ENT_QUOTES, 'UTF-8');?>" id="J_newPwd" type="password" name="newPwd" value="" class="input length_5" data-pwdcheck="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password&a=checkpwd'; ?>" data-pwdstrong="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=password&a=checkpwdStrong'; ?>"><span id="J_tip_newPwd"></span></dd>
		</dl>
		<dl class="cc">
			<dt>确认密码：</dt>
			<dd><input type="password" name="rePwd"  class="input length_5"><span id="J_tip_rePwd"></span></dd>
		</dl>
		<dl class="cc">
			<dt>&nbsp;</dt>
			<dd><button type="submit" class="btn btn_submit btn_big">提交</button></dd>
		</dl>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script>
Wind.ready(document, function(){
	Wind.use('jquery', 'global', 'ajaxForm', 'validate', GV.JS_ROOT +'pages/profile/profilePwdQa.js?v=' +GV.JS_VERSION);
});
</script>
