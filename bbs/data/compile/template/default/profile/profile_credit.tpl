<div id="J_profile_credit" class="content">
	<div class="profile_nav">
	<ul>
<?php foreach ($_tabs as $key => $_item) {
	if (($key == 'recharge') && !Wekit::C('pay', 'ifopen')) continue;
	if (isset($_item['url']) && $_item['url']) {
?>
		<li class="<?php echo htmlspecialchars($_item['current'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo WindUrlHelper::createUrl($_item['url'], array('_tab' => $key));?>"><?php echo htmlspecialchars($_item['title'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php } else { ?>
		<li class="<?php echo htmlspecialchars($_item['current'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=extends&_left=credit&_tab=', rawurlencode($key); ?>"><?php echo htmlspecialchars($_item['title'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php 
	}
}?>
	</ul>
</div>
	<div class="credit_page">
		<div class="credit_total">
			<h2>当前综合积分<span>( 总积分=<?php echo htmlspecialchars($_upgrade, ENT_QUOTES, 'UTF-8');?> )</span></h2>
			<div class="level">
				<ul class="cc">
					<li style="width:10%;" class="li">&nbsp;</li>
					<li style="width:60%;"><?php echo htmlspecialchars($ltitle[$memberid], ENT_QUOTES, 'UTF-8');?><span>(<?php echo htmlspecialchars($cpoint, ENT_QUOTES, 'UTF-8');?>)</span></li>
					<?php  if ($nextid) { ?>
					<li style="width:30%;"><?php echo htmlspecialchars($ltitle[$nextid], ENT_QUOTES, 'UTF-8');?><span>(<?php echo htmlspecialchars($npoint, ENT_QUOTES, 'UTF-8');?>)</span></li>
					<?php  } ?>
				</ul>
			</div>
			<div class="schedule"><div class="schedule_div" style="width:10%"></div></div>
			<div class="schedule_wrap">
				<div class="schedule_div"style="width:<?php echo htmlspecialchars($rate, ENT_QUOTES, 'UTF-8');?>%"></div>
				<div class="current" style="left:<?php echo htmlspecialchars($rate, ENT_QUOTES, 'UTF-8');?>%;">
					<div class="arrow"><em></em><span></span></div>
					<p><?php echo htmlspecialchars($totalCredit, ENT_QUOTES, 'UTF-8');?></p>
				</div>
			</div>
		</div>
		<div class="credit_has">
			<h2>已有的积分</h2>
			<dl>
				<dt>
					<span class="name">名称</span>
					<span class="num">数量</span>
					<span class="operate">可做操作</span>
				</dt>
				<?php  foreach ($creditBo->cType as $key => $value) { ?>
				<dd>
					<span class="name"><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></span>
					<span class="num"><?php echo htmlspecialchars($loginUser->info['credit' . $key], ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($creditBo->cUnit[$key], ENT_QUOTES, 'UTF-8');?></span>
					<span class="operate"><?php  if (isset($transfer[$key]) && $transfer[$key]['ifopen']) { ?><a href="javascript:;" class="mr5 J_credit_transfer" data-id="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>">[积分转账]</a><?php  } 
  if (isset($exchange[$key])) { ?><a href="#" class="mr5 J_credit_change" data-id="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>">[转换为其他积分]</a><?php  } ?>
					</span>
				</dd>
				<?php  } ?>
			</dl>
		</div>
	</div>
</div>

<!--==============转账弹窗===============-->
<div id="J_credit_transfer_wrap" class="wind_dialog core_pop_wrap" style="display:none;width:340px;">
	<div class="pop_top J_pop_handle"><a href="#" class="pop_close J_close">关闭</a><strong>转账</strong></div>
	<div class="pop_transfer">
		<!-- 转账 -->
		<form class="J_credit_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=credit&a=dotransfer'; ?>" method="post">
			<div class="pop_cont">
				<dl class="cc" style="padding-top:0;">
					<dt>积分：</dt>
					<dd><span class="name" id="J_transfer_name"></span></dd>
				</dl>
				<dl class="cc">
					<dt>转入用户：</dt>
					<dd><input type="text" class="input length_3 mb5" name="touser" /></dd>
				</dl>
				<dl class="cc">
					<dt>转账数量：</dt>
					<dd><input type="text" class="input length_3 mb5 J_input_number" name='num'/><p class="gray" id="J_transfer_min_tip" style="display:none">最低转账数量<span class="red" id="J_transfer_min"></span></p></dd>
				</dl>
				<dl class="cc">
					<dt>总共转出：</dt>
					<dd><span class="name" id="J_transfer_count"></span><p class="gray">转账手续费<span class="red" id="J_transfer_rate"></span></p></dd>
				</dl>
				<dl class="cc">
					<dt>输入密码：</dt>
					<dd><input type="password" class="input length_3 mb5" name="pwd" /><p class="gray">登录密码</p></dd>
				</dl>
			</div>

			<div class="pop_bottom"><input type="hidden" name="credit" value="" id="J_transfer_id" /><button type="submit" class="btn btn_submit">提交</button></div>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
</div>
<!--==============转账弹窗结束===============-->

<!--==============转换弹窗===============-->
<div id="J_credit_change_wrap" class="wind_dialog core_pop_wrap" style="display:none;width:340px;">
	<div class="pop_top J_pop_handle"><a href="#" class="pop_close J_close">关闭</a><strong>转换为其他积分</strong></div>
	<div class="pop_transform">
		<form class="J_credit_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=credit&a=doexchange'; ?>" method="post">
			<div class="pop_cont">
				<dl class="cc" style="padding-top:0;">
					<dt>积分：</dt>
					<dd><span class="name" id="J_orgin_credit"></span></dd>
				</dl>
				<dl class="cc">
					<dt>转换为：</dt>
					<dd><select class="select_3" id="J_exchange_select" name="credit2"></select></dd>
				</dl>
				<dl class="cc">
					<dt>转换比例：</dt>
					<dd><span class="name" id="J_exchange_rate"></span></dd>
				</dl>
				<dl class="cc">
					<dt>转换数量：</dt>
					<dd><input type="text" class="input length_3 mb5 J_input_number" name="num" value="" /><p class="gray" id="J_exchange_parity">必须为<span id="J_exchange_num" class="red"></span>的整数倍</p></dd>
				</dl>
				<dl class="cc">
					<dt>转换后得到：</dt>
					<dd><span class="name"><span class="red" id="J_exchange_count"></span><span id="J_exchange_to"></span></span></dd>
				</dl>
			</div>
			<div class="pop_bottom"><input type="hidden" name="credit1" value="" id="J_exchange_id" /><button type="submit" class="btn btn_submit">提交</button></div>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
</div>
<!--==============转换弹窗结束===============-->
<script>
var EXCHANGE = <?php echo WindJson::encode(Pw::jsonEncode($exchange), 'UTF-8');?>,						//积分转换数据
		TRANSFER = <?php echo WindJson::encode(Pw::jsonEncode($transfer), 'UTF-8');?>,						//积分转账数据
		CREDITNAME = <?php echo WindJson::encode(Pw::jsonEncode($creditBo->cType), 'UTF-8');?>,	//积分名
		CREDITUNIT = <?php echo WindJson::encode(Pw::jsonEncode($creditBo->cUnit), 'UTF-8');?>;	//积分单位
Wind.ready(document, function(){
	Wind.use('jquery', 'global', 'ajaxForm', 'draggable', GV.JS_ROOT +'pages/profile/profileCredit.js?v=' +GV.JS_VERSION);
});
</script>