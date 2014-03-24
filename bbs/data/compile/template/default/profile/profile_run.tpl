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
	<form class="J_profile_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&a=dorun'; ?>" method="post">
	<div class="profile_ct">
		<dl class="cc">
			<dt>真实姓名：</dt>
			<dd>
			<input type="text" class="input length_6" name="realname" value="<?php echo htmlspecialchars($userinfo['realname'], ENT_QUOTES, 'UTF-8');?>"/>
			</dd>
		</dl>
		<dl class="cc">
			<dt>性别：</dt>
			<dd><label class="mr20"><input name="gender" type="radio" value="0" <?php echo htmlspecialchars(Pw::ifcheck($userinfo['gender'] == 0), ENT_QUOTES, 'UTF-8');?> />男</label>
				<label class="mr20"><input name="gender" type="radio" value="1" <?php echo htmlspecialchars(Pw::ifcheck($userinfo['gender'] == 1), ENT_QUOTES, 'UTF-8');?> />女</label>
			</dd>
		</dl>
		<dl class="cc">
			<dt>生日：</dt>
			<dd class="J_date_select">
				<select class="mr15 length_2 J_date_year" name="byear">
				<?php foreach ($years as $_year) {?>
					<option value="<?php echo htmlspecialchars($_year, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($userinfo['byear'] == $_year), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_year, ENT_QUOTES, 'UTF-8');?>年</option>
				<?php }?>
				</select><select class="mr15 length_2 J_date_month" name="bmonth">
				<?php foreach ($months as $_month) {?>
					<option value="<?php echo htmlspecialchars($_month, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($userinfo['bmonth'] == $_month), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_month, ENT_QUOTES, 'UTF-8');?>月</option>
				<?php }?>
				</select><select class="length_2 J_date_day" name="bday">
					<?php foreach ($days as $_day) {?>
					<option value="<?php echo htmlspecialchars($_day, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($userinfo['bday'] == $_day), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($_day, ENT_QUOTES, 'UTF-8');?>日</option>
				<?php }?>
				</select>
			</dd>
		</dl>
		<dl class="cc">
			<dt>现居住地：</dt>
			<dd class="J_region_set">
				<span class="J_region_list">
				<span class="J_province"><?php echo htmlspecialchars($location[0]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_city"><?php echo htmlspecialchars($location[1]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_district"><?php echo htmlspecialchars($location[2]['name'], ENT_QUOTES, 'UTF-8');?></span></span>
				<a data-pid="<?php echo htmlspecialchars($location[0]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($location[1]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-did="<?php echo htmlspecialchars($location[2]['areaid'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=area'; ?>" class="J_region_change">更改</a>
				<input class="J_areaid" type="hidden" name="location" value="<?php echo htmlspecialchars($userinfo['location'], ENT_QUOTES, 'UTF-8');?>" />
			</dd>
		</dl>
		<dl class="cc">
			<dt>家乡：</dt>
			<dd class="J_region_set">
				<span class="J_region_list">
				<span class="J_province"><?php echo htmlspecialchars($hometown[0]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_city"><?php echo htmlspecialchars($hometown[1]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_district"><?php echo htmlspecialchars($hometown[2]['name'], ENT_QUOTES, 'UTF-8');?></span></span>
				<a data-pid="<?php echo htmlspecialchars($hometown[0]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($hometown[1]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-did="<?php echo htmlspecialchars($hometown[2]['areaid'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=area'; ?>" class="J_region_change">更改</a>
				<input class="J_areaid" type="hidden" name="hometown" value="<?php echo htmlspecialchars($userinfo['hometown'], ENT_QUOTES, 'UTF-8');?>" />
			</dd>
		</dl>
		<dl class="cc">
			<dt>个人主页：</dt>
			<dd><input type="text" class="input length_6 mr10" name="homepage" value="<?php echo htmlspecialchars($userinfo['homepage'], ENT_QUOTES, 'UTF-8');?>"/><span id="J_profile_tip_homepage" class="f12 gray"></span></dd>
		</dl>
		<dl class="cc">
			<dt>自我简介：</dt>
			<dd><textarea class="length_6 mr10" name="profile"><?php echo $userinfo['profile'];?></textarea><span id="J_profile_tip_profile" class="f12 gray"></span></dd>
		</dl>
<?php if ($isAllowSign) {?>
		<dl class="cc">
			<dt>帖子签名：</dt>
			<dd><textarea class="length_6 mr10" name="bbs_sign" id="J_bbs_sign"><?php echo htmlspecialchars($userinfo['bbs_sign'], ENT_QUOTES, 'UTF-8');?></textarea><a href="" id="J_ubbdemo" class="tips_icon_help f12 gray" title="ubb使用帮助"></a>
			<span id="J_profile_tip_bbs_sign" class="f12 gray"></span><?php if ($isSignBan) {?><br/><span class="red">签名已被禁止，如有疑问请联系管理员。</span><?php }?>
			</dd>
		</dl>
<?php }?>
		<dl class="cc">
			<dt>&nbsp;</dt>
			<dd><button type="submit" class="btn btn_submit btn_big mr10">提交</button></dd>
		</dl>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<div style="display:none;position:absolute;width:600px;" class="core_pop_wrap" id="J_ubbdemo_pop">
	<div class="pop_top J_pop_handle"><strong>ubb使用帮助</strong></div>
	<div class="pop_cont" style="height: 250px;overflow-x: hidden;overflow-y: auto;position: relative;">
		<table class="pop_design_tablelist">
			<thead>
				<tr>
					<td width="80">说明</td>
					<td width="280">代码</td>
					<td>效果</td>
				</tr>
			</thead>
			<tr>
				<td>文字加粗</td>
				<th>[b]粗体字[/b]</th>
				<td><b>粗体字</b></td>
			</tr>
			<tr>
				<td>斜体</td>
				<th>[i]斜体字[/i]</th>
				<td><i>斜体字</i></td>
			</tr>
			<tr>
				<td>下划线</td>
				<th>[u]下划线[/u]</th>
				<td><u>下划线</u></td>
			</tr>
			<tr>
				<td>链接</td>
				<th>[url]http://www.phpwind.net[/url]</th>
				<td><a target="_blank" href=" http://www.phpwind.net"><font color="#000066"> http://www.phpwind.net</font></a></td>
			</tr>
			<tr>
				<td>链接</td>
				<th>[url=http://www.phpwind.net]PHPwind[/url]</th>
				<td><a target="_blank" href="http://www.phpwind.net"><font color="000066">PHPwind</font></a></td>
			</tr>
			<tr>
				<td>图片</td>
				<th>[img]<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/logo.png[/img]</th>
				<td><img src="<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/logo.png"></td>
			</tr>
			<tr>
				<td>字号</td>
				<th>[size=5]字体大小[/size]</th>
				<td><font size="5">字体大小</font></td>
			</tr>
			<tr>
				<td>字体</td>
				<th>﻿[font=楷体]字体[/font]</th>
				<td><font face="楷体 ">字体</font></td>
			</tr>
			<tr>
				<td>颜色</td>
				<th>﻿[color=red]颜色[/color]</th>
				<td><font face="verdana" color="red">颜色</font></td>
			</tr>
		</table>
	</div>
	<div class="pop_bottom"><button class="btn" type="button" id="J_ubbdemo_close">关闭</button></div>
</div>
<script>
var SING_MAX_LENGTH = '<?php echo htmlspecialchars($signMaxLength, ENT_QUOTES, 'UTF-8');?>';
Wind.ready(document, function(){
	Wind.use('jquery', 'global', GV.JS_ROOT +'pages/profile/profileIndex.js?v=' +GV.JS_VERSION);
});
</script>
<?php
PwHook::display(array($hookSrc, "runDo"), array('displayFootHtml'), "", $__viewer);
?>