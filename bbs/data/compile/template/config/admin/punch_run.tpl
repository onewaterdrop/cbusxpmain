<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::app()->charset, ENT_QUOTES, 'UTF-8');?>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','name'), ENT_QUOTES, 'UTF-8');?></title>
<link href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','css'), ENT_QUOTES, 'UTF-8');?>/admin_style.css?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<script>
//全局变量，是Global Variables不是Gay Video喔
var GV = {
	JS_ROOT : "<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/",																									//js目录
	JS_VERSION : "<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>",																										//js版本号
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token ajax全局
	REGION_CONFIG : {},
	SCHOOL_CONFIG : {},
	URL : {
		LOGIN : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','loginUrl'), ENT_QUOTES, 'UTF-8');?>',																													//后台登录地址
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',																										//图片目录
		REGION : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=area'; ?>',					//地区
		SCHOOL : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=school'; ?>'				//学校
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/jquery.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

</head>
<body>
<div class="wrap">

	<div class="h_a">打卡设置</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=config&c=punch&a=dorun'; ?>" method="post">
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>每日打卡</th>
				<td>
					<ul class="switch_list cc">
						<li><label><input type="radio" name="punchOpen" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['punch.open'] == 1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="punchOpen" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['punch.open'] == 0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>奖励积分类型</th>
				<td><select class="select_4" name="punchReward[type]">
				<?php  foreach ($creditBo->cType as $key => $value) { ?>
				<option value="<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($key == $config['punch.reward']['type']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></option>
				<?php  } ?>
				</select></td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>奖励积分数</th>
				<td><input type="number" class="input length_1 mr5" name="punchReward[min]" value="<?php echo htmlspecialchars($config['punch.reward']['min'], ENT_QUOTES, 'UTF-8');?>"><span class="mr5">至</span><input type="number" class="input length_1 mr20"  name="punchReward[max]" value="<?php echo htmlspecialchars($config['punch.reward']['max'], ENT_QUOTES, 'UTF-8');?>"><span class="mr5">递增</span><input type="number" class="input length_1" name="punchReward[step]" value="<?php echo htmlspecialchars($config['punch.reward']['step'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><div class="fun_tips">递增即连续打卡后递增的积分数，递增后的数值不会超过积分范围最大值。</div></td>
			</tr>
			<tr>
				<th>帮Ta打卡</th>
				<td>
					<ul class="switch_list cc">
						<li><label><input type="radio" name="punchFrendOpen" value="1" <?php echo htmlspecialchars(Pw::ifcheck($config['punch.friend.open'] == 1), ENT_QUOTES, 'UTF-8');?>><span>开启</span></label></li>
						<li><label><input type="radio" name="punchFrendOpen" value="0" <?php echo htmlspecialchars(Pw::ifcheck($config['punch.friend.open'] == 0), ENT_QUOTES, 'UTF-8');?>><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">开启后可以帮好友打卡，并获的积分奖励。</div></td>
			</tr>
			<tr>
				<th>帮打卡好友人数上限</th>
				<td>
					<input type="number" class="input length_4" name="punchFrendReward[friendNum]" value="<?php echo htmlspecialchars($config['punch.friend.reward']['friendNum'], ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips">每天最多可帮多少个好友打卡。</div></td>
			</tr>
			<tr>
				<th>被帮者领取积分数</th>
				<td>
					<input type="number" class="input length_4" name="punchFrendReward[rewardMeNum]" value="<?php echo htmlspecialchars($config['punch.friend.reward']['rewardMeNum'], ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips">帮好友领取的积分数，剩余积分需要好友自己打卡领取。</div></td>
			</tr>
			<tr>
				<th>帮打卡奖励积分数</th>
				<td>
					<input type="number" class="input length_4" name="punchFrendReward[rewardNum]" value="<?php echo htmlspecialchars($config['punch.friend.reward']['rewardNum'], ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips">每次帮好友打卡后，自己获得的积分奖励，不得高于打卡奖励积分</div></td>
			</tr>
		</table>
	</div>
	
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
		<button class="btn btn_submit J_ajax_submit_btn" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
</html>